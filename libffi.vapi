[CCode(cheader_filename = "ffi.h")]
namespace FFI {
	[CCode(cname = "ffi_cif")]
	public struct call_interface {
		[CCode(cname = "ffi_prep_cif")]
		public static Status prepare(out call_interface cif, ABI abi, type returntype, [CCode(array_length_type = "unsigned int", array_length_pos = 2.3)] type[] argtypes);

		[CCode(cname = "ffi_call", simple_generics = true)]
		public void call<T>(void *fn, out T rvalue, void ** avalue);
	}

	[CCode(cname = "ffi_type*", cprefix = "ffi_type_")]
	[SimpleType]
	public struct type {
	}
	[CCode(cname = "&ffi_type_void")]
	public const type @void;
	[CCode(cname = "&ffi_type_uint8")]
	public const type @uint8;
	[CCode(cname = "&ffi_type_sint8")]
	public const type @sint8;
	[CCode(cname = "&ffi_type_uint16")]
	public const type @uint16;
	[CCode(cname = "&ffi_type_sint16")]
	public const type @sint16;
	[CCode(cname = "&ffi_type_uint32")]
	public const type @uint32;
	[CCode(cname = "&ffi_type_sint32")]
	public const type @sint32;
	[CCode(cname = "&ffi_type_uint64")]
	public const type @uint64;
	[CCode(cname = "&ffi_type_sint64")]
	public const type @sint64;
	[CCode(cname = "&ffi_type_float")]
	public const type @float;
	[CCode(cname = "&ffi_type_double")]
	public const type @double;
	[CCode(cname = "&ffi_type_pointer")]
	public const type @pointer;

	[CCode(cname = "ffi_status", cprefix = "FFI_")]
	public enum Status {
		OK,
		BAD_TYPEDEF,
		BAD_ABI
	}

	/**
	 * The ABI convention for the function being called
	 *
	 * This is all possible calling conventions across all platforms. Most will not work, or even be defined, on the current platform.
	 */
	[CCode(cname = "ffi_abi", cprefix = "FFI_")]
	public enum ABI {
		[CCode(cname = "FFI_DEFAULT_ABI")]
		DEFAULT,
		AIX,
		DARWIN,
		EABI,
		GCC_SYSV,
		LINUX,
		LINUX64,
		LINUX_SOFT_FLOAT,
		N32,
		N32_SOFT_FLOAT,
		N64,
		N64_SOFT_FLOAT,
		O32,
		O32_SOFT_FLOAT,
		OSF,
		PA64,
		STDCALL,
		SYSV,
		UNIX,
		UNIX64,
		V8,
		V8PLUS,
		V9,
		VFP,
		WIN64,
	}
}
