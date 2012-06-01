const int INIT_BUF_SIZE  = 4;

struct memfile_cookie {
	public memfile_cookie() {
		buf = new uint8[1000];
		endpos = 0;
		offset = 0;
	}
	uint8[] buf;
	size_t endpos;
	ssize_t offset;
}

ssize_t memfile_write(memfile_cookie? cookie, [CCode(array_length_type = "size_t")] uint8[]?buf) {
	if (buf == null)
		return 0;

	/* Buffer too small? Keep doubling size until big enough */

	while (buf.length + cookie.offset > cookie.buf.length) {
		cookie.buf.resize(cookie.buf.length * 2);
		if (cookie.buf == null) {
			return -1;
		}
	}

	Memory.copy(&cookie.buf[cookie.offset], buf, buf.length);
	cookie.offset += buf.length;
	if (cookie.offset > cookie.endpos)
		cookie.endpos = cookie.offset;
	return buf.length;
}

ssize_t memfile_read(memfile_cookie? cookie,[CCode(array_length_type = "size_t")] uint8[]?buf) {
	ssize_t xbytes;

	if (buf == null)
		return 0;
	/* Fetch minimum of bytes requested and bytes available */

	xbytes = buf.length;
	if (cookie.offset + buf.length > cookie.endpos)
		xbytes = (ssize_t)cookie.endpos - cookie.offset;
	if (xbytes < 0)     /* offset may be past endpos */
		xbytes = 0;

	Memory.copy(buf, &cookie.buf[cookie.offset], xbytes);

	cookie.offset += xbytes;
	return xbytes;
}

int memfile_seek(memfile_cookie? cookie, ref int64 offset, FileSeek whence) {
	int64 new_offset;

	if (whence == FileSeek.SET)
		new_offset = offset;
	else if (whence == FileSeek.END)
		new_offset = cookie.endpos + offset;
	else if (whence == FileSeek.CUR)
		new_offset = cookie.offset + offset;
	else
		return -1;

	if (new_offset < 0)
		return -1;

	cookie.offset = (ssize_t) new_offset;
	offset = new_offset;
	return 0;
}

int memfile_close(owned memfile_cookie? cookie) {
	return 0;
}

int main(string[] args) {
	Cookie.io_functions<memfile_cookie?> memfile_func = {};
	memfile_func.read  = memfile_read;
	memfile_func.write = memfile_write;
	memfile_func.seek  = memfile_seek;
	memfile_func.close = memfile_close;
	memfile_cookie mycookie = memfile_cookie();
	ssize_t nread;
	uint8 buf[1000];

	var fp = Cookie.open<memfile_cookie?>(mycookie, "w+", memfile_func);
	if (fp == null) {
		return 1;
	}

	/* Write command-line arguments to our file */

	foreach(var arg in args) {
		fp.puts(arg);
	}

	/* Read two bytes out of every five, until EOF */

	for (var p = 0; ; p += 5) {
		if (fp.seek(p, FileSeek.SET) == -1) {
			return 3;
		}
		nread = (ssize_t) fp.read(buf);
		if (nread == -1) {
			return 4;
		}
		if (nread == 0) {
			stdout.printf("Reached end of file\n");
			break;
		}

		stdout.printf("/%.*s/\n", nread, buf);
	}

	return 0;
}

