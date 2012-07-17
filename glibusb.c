#include <poll.h>
#include <stdlib.h>

#include "glibusb.h"

typedef struct {
	GSource source;
	libusb_context *ctx;
	GSList *pollfds;
} GUSBSource;

static void add_fd(int fd, short events, void *user_data) {
	GPollFD *pollfd = g_slice_new(GPollFD);
	g_message("now monitoring fd %d", fd);
	pollfd->fd = fd;
	pollfd->events = 0;
	pollfd->revents = 0;
	if (events & POLLIN)
		pollfd->events |= G_IO_IN;
	if (events & POLLOUT)
		pollfd->events |= G_IO_OUT;

	((GUSBSource*)user_data)->pollfds = g_slist_prepend(((GUSBSource*)user_data)->pollfds, pollfd);
	g_source_add_poll((GSource *) user_data, pollfd);
}

static void remove_fd(int fd, void *user_data) {
	GSList *elem = ((GUSBSource*)user_data)->pollfds;
	g_message("no longer monitoring fd %d", fd);

	if (!elem) {
		g_warning("cannot remove from list as list is empty?");
		return;
	}

	do {
		GPollFD *pollfd = elem->data;
		if (pollfd->fd != fd)
			continue;

		g_source_remove_poll((GSource *) user_data, pollfd);
		g_slice_free(GPollFD, pollfd);
		((GUSBSource*)user_data)->pollfds = g_slist_delete_link(((GUSBSource*)user_data)->pollfds, elem);
		return;
	} while ((elem = g_slist_next(elem)));

	g_error("couldn't find fd %d in list\n", fd);
}

static gboolean source_prepare(GSource *source, gint *timeout) {
	int r;
	struct timeval tv;

	r = libusb_get_next_timeout(((GUSBSource*)source)->ctx, &tv);
	if (r == 0) {
		*timeout = -1;
		return FALSE;
	}

	if (!timerisset(&tv))
		return TRUE;

	*timeout = (tv.tv_sec * 1000) + (tv.tv_usec / 1000);
	return FALSE;
}

static gboolean source_check(GSource *source) {
	GUSBSource *src = (GUSBSource*) source;
	GSList *elem = src->pollfds;
	struct timeval tv;
	int r;

	if (!elem)
		return FALSE;

	do {
		GPollFD *pollfd = elem->data;
		if (pollfd->revents)
			return TRUE;
	} while ((elem = g_slist_next(elem)));

	r = libusb_get_next_timeout(src->ctx, &tv);
	if (r == 1 && !timerisset(&tv))
		return TRUE;

	return FALSE;
}

static gboolean source_dispatch(GSource *source, GSourceFunc callback, gpointer data)
{
	struct timeval zerotimeout = {
		.tv_sec = 0,
		.tv_usec = 0,
	};

	libusb_handle_events_timeout(((GUSBSource*)source)->ctx, &zerotimeout);

	/* FIXME whats the return value used for? */
	return TRUE;
}

static void source_finalize(GSource *source)
{
	GUSBSource *src = (GUSBSource*) source;
	GSList *elem = src->pollfds;

	if (elem) {
		do {
			GPollFD *pollfd = elem->data;
			g_source_remove_poll(source, pollfd);
			g_slice_free(GPollFD, pollfd);
			src->pollfds = g_slist_delete_link(src->pollfds, elem);
		} while ((elem = g_slist_next(elem)));
	}

	g_slist_free(src->pollfds);
}

static GSourceFuncs sourcefuncs = {
	.prepare = source_prepare,
	.check = source_check,
	.dispatch = source_dispatch,
	.finalize = source_finalize,
};

GSource *glibusb_create_gsource(libusb_context *ctx) {
	int it;
	const struct libusb_pollfd **fds;
	GUSBSource *gsource = (GUSBSource*) g_source_new(&sourcefuncs, sizeof(GUSBSource));

	gsource->ctx = ctx;	
	gsource->pollfds = NULL;
 	fds = libusb_get_pollfds(ctx);
	if (fds != NULL) {
		for(it = 0; fds[it] != NULL; it++) {
			add_fd(fds[it]->fd, fds[it]->events, gsource);
		}
		free(fds);
	}
	libusb_set_pollfd_notifiers(ctx, add_fd, remove_fd, gsource);
	return (GSource*) gsource;
}

static void callback_func(struct libusb_transfer *transfer) {
	g_simple_async_result_complete((GSimpleAsyncResult*)transfer->user_data);
}

static void start_xfer(struct libusb_transfer *xfer) {
	GSimpleAsyncResult *async = (GSimpleAsyncResult*)xfer->user_data;
	g_simple_async_result_set_op_res_gpointer(async, xfer, (GDestroyNotify)libusb_free_transfer);
	if(libusb_submit_transfer(xfer) != 0) {
		g_simple_async_result_complete_in_idle(async);
		g_object_unref((GObject*)async);
		libusb_free_transfer(xfer);
	}
}

#define ASYNC_BLOCK(name) \
	void glibusb_##name##_transfer(libusb_device_handle *dev, ASYNC_PARAMS unsigned int timeout, unsigned char *buffer, int buffer_length, GAsyncReadyCallback callback, gpointer user_data) { \
		struct libusb_transfer *xfer = libusb_alloc_transfer(0); \
		GSimpleAsyncResult *async = g_simple_async_result_new(NULL, callback, user_data, glibusb_control_transfer); \
		libusb_fill_##name##_transfer(xfer, dev, ASYNC_ARGS callback_func, async, timeout); \
		start_xfer(xfer);\
	}\
	enum libusb_transfer_status glibusb_##name##_transfer_finish(GAsyncResult *result, int *actual_length) { \
		struct libusb_transfer *xfer = (struct libusb_transfer*) g_simple_async_result_get_op_res_gpointer(G_SIMPLE_ASYNC_RESULT(result)); \
		if (actual_length) *actual_length = xfer->actual_length; \
		return xfer->status; \
	}

#define ASYNC_ARGS buffer,
#define ASYNC_PARAMS
ASYNC_BLOCK(control)
#undef ASYNC_ARGS
#undef ASYNC_PARAMS
#define ASYNC_ARGS endpoint, buffer, buffer_length,
#define ASYNC_PARAMS unsigned char endpoint,
ASYNC_BLOCK(interrupt)
ASYNC_BLOCK(bulk)
