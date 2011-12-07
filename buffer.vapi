[CCode(cheader_filename = "vala_buffer.h")]
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
}

