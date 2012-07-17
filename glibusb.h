#include <glib.h>
#include <glib-object.h>
#include <gio/gio.h>

#include <libusb.h>

GSource *glibusb_create_gsource(libusb_context *ctx);

void glibusb_control_transfer(libusb_device_handle *dev, unsigned int timeout, unsigned char *buffer, int buffer_length, GAsyncReadyCallback callback, gpointer user_data);
enum libusb_transfer_status glibusb_control_transfer_finish(GAsyncResult *result, int *actual_length);

void glibusb_interrupt_transfer(libusb_device_handle *dev, unsigned char endpoint, unsigned int timeout, unsigned char *buffer, int buffer_length, GAsyncReadyCallback callback, gpointer user_data);
enum libusb_transfer_status glibusb_interrupt_transfer_finish(GAsyncResult *result, int *actual_length);

void glibusb_bulk_transfer(libusb_device_handle *dev, unsigned char endpoint, unsigned int timeout, unsigned char *buffer, int buffer_length, GAsyncReadyCallback callback, gpointer user_data);
enum libusb_transfer_status glibusb_bulk_transfer_finish(GAsyncResult *result, int *actual_length);
