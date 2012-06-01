[CCode(cheader_filename = "stdio.h")]
namespace Cookie {
	[CCode(cname = "fopencookie", simple_generics = true)]
	private
#if POSIX
	Posix.FILE?
#else
	GLib.FileStream?
#endif
	_open<T>([CCode(destroy_notify_pos = -1)] T cookie, string mode, io_functions<T> io_funcs);
	[CCode(cname="", simple_generics = true)]
	private void _make_reference_disappear<T>(owned T cookie);
	/**
	 * Allows the programmer to create a custom implementation for a standard I/O stream.
	 *
	 * This implementation can store the stream's data at a location of its own choosing; for example, it is used to implement {@link open_mem}, which provides a stream interface to data that is stored in a buffer in memory.
	 *
	 * In order to create a custom stream the programmer must:
	 * * Implement four hook functions that are used internally by the standard I/O library when performing I/O on the stream.
	 * * Define a "cookie" data type, a structure that provides bookkeeping information (e.g., where to store data) used by the aforementioned hook functions.
	 * * Call this function to open a new stream and associate the cookie and hook functions with that stream.
	 *
	 * The function opens a new stream and returns a pointer to a {@link GLib.FileStream} object that is used to operate on that stream.
	 */
	[CCode(cname = "_vala_fopencookie")]
	public
#if POSIX
	Posix.FILE?
#else
	GLib.FileStream?
#endif
	open<T>([CCode(destroy_notify_pos = -1)] owned T cookie, string mode, io_functions<T> io_funcs) {
		var result = _open(cookie, mode, io_funcs);
		_make_reference_disappear((owned) cookie);
		return result;
	}
	/**
	 * Open memory as stream
	 *
	 * The function opens a stream that permits the access specified by mode. The stream allows I/O to be performed on the memory buffer.
	 *
	 * When a stream that has been opened for writing is flushed or closed, a null byte is written at the end of the buffer if there is space. The caller should ensure that an extra byte is available in the buffer (and that size counts that byte) to allow for this.
	 *
	 * Attempts to write more than size bytes to the buffer result in an error. (By default, such errors will only be visible when the stdio buffer is flushed.
	 *
	 * In a stream opened for reading, null bytes ('\0') in the buffer do not cause read operations to return an end-of-file indication. A read from the buffer will only indicate end-of-file when the file pointer advances size bytes past the start of the buffer.
	 *
	 * @param mode is the same as for {@link FileStream.open}. If mode specifies an append mode, then the initial file position is set to the location of the first null byte ('\0') in the buffer; otherwise the initial file position is set to the start of the buffer. Since glibc 2.9, the letter 'b' may be specified as the second character in mode. This provides "binary" mode: writes don't implicitly add a terminating null byte, and {@link FileStream.seek} when {@link FileSeek.END} is relative to the end of the buffer (i.e., the value specified by the size argument), rather than the current string length.
	 */
	[CCode(cname = "fmemopen")]
	public
#if POSIX
	Posix.FILE?
#else
	GLib.FileStream?
#endif
	open_buffer([CCode(array_length_type = "size_t")] uint8[] buf, string mode);
	[CCode(cname = "cookie_io_functions_t")]
	[SimpleType]
	public struct io_functions<T> {
		/**
		 * Cleanup any data associated with the cookie. If null, then no special action is performed when the stream is closed.
		 */
		CloseFunction<T>? close;
		/**
		 * The read function for this file. If null, then reads from the custom stream always return end of file.
		 */
		ReadFunction<T>? read;
		/**
		 * The seek function for this file. If null, then it is not possible to perform seek operations on the stream.
		 */
		SeekFunction<T>? seek;
		/**
		 * The write function for this file. If null, then writes are discarded.
		 */
		WriteFunction<T>? write;
	}
	/**
	 * Closes the stream.
	 * @return 0 on success, and EOF on error.
	 */
	[CCode(cname = "cookie_close_function_t", simple_generics = true, has_target = false)]
	public delegate int CloseFunction<T>(owned T cookie);
	/**
	 * Implements read operations for the stream.
	 *
	 * The read function should update the stream offset appropriately.
	 * @param buf a buffer into which input data can be placed.
	 * @return As its function result, the read function should return the number of bytes copied, 0 on end of file, or -1 on error.
	 */
	[CCode(cname = "cookie_read_function_t", simple_generics = true, has_target = false)]
 public delegate ssize_t ReadFunction<T>(T cookie, [CCode(array_length_type = "size_t")] uint8[]? buf);
	/**
	 * Implements seek operations on the stream.
	 *
	 * @param offset argument specifies the new file offset. Before returning, the seek function should update *offset to indicate the new stream offset.
	 * @param whence The point in the stream from where the offset should be counted.
	 * @return 0 on success, and -1 on error.
	 */
	[CCode(cname = "cookie_seek_function_t", simple_generics = true, has_target = false)]
	public delegate int SeekFunction<T>(T cookie, ref int64 offset,
#if POSIX
	int
#else
	GLib.FileSeek
#endif
	whence);
	/**
	 * Implements write operations for the stream.
	 *
	 * The write function should update the stream offset appropriately.
	 * @param buf a buffer of data to be output to the stream
	 * @return the number of bytes copied, or -1 on error
	 */
	[CCode(cname = "cookie_write_function_t", simple_generics = true, has_target = false)]
 public delegate ssize_t WriteFunction<T>(T cookie, [CCode(array_length_type = "size_t")] uint8[]? buf);
}
