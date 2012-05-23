[CCode(cheader_filename = "tricks.h")]
namespace Buffer {
	/**
	 * Create a buffer representation of a particular object.
	 */
	[CCode(generic_type_pos = 1.1, cname = "OBJECT_TO_BUFFER")]
	public unowned uint8[] of<T>(ref T @value);
	/**
	 * Create a buffer representation of an array of objects.
	 */
	[CCode(generic_type_pos = 1.9, cname = "OBJECT_ARRAY_TO_BUFFER")]
	public unowned uint8[] of_array<T>(T[] @value);
	/**
	 * Convert an array of one type to another, where the new array length is the
	 * maximum number of items that could be stored in the new array given the
	 * type of the old array.
	 */
	[CCode(generic_type_pos = 1.9, cname = "OBJECT_ARRAY_TO_ARRAY")]
	public unowned U[] change_array<T,U>(T[] @value);
	/**
	 * Convert an array to a array of objects.
	 */
	[CCode(generic_type_pos = 1.9, cname = "OBJECT_ARRAY_FROM_BUFFER")]
	public unowned T[] from_array<T>(uint8[] @value);

	[CCode(cname = "BUFFER_SUB_CHUNK")]
	public unowned uint8[]? index(uint8[] buffer, int index);
}

[CCode(cname = "InitialisationFunction", cheader_filename = "tricks.h", has_type_id = false)]
public delegate size_t InitialisationFunction();

/**
 * Call a function once and cache the result.
 *
 * Calls a function once, which returns a non-zero value and caches the
 * result. The same once block can be enetered many times, with different
 * parameters, and the result will always be the same.
 *
 * This is thread-safe.
 */
[CCode(cname = "ONCE", cheader_filename = "tricks.h")]
public void once(out size_t @value, InitialisationFunction func);
