namespace Posix {
	[CCode (cname = "jmp_buf", cheader_filename = "setjmp.h", has_type_id = false)]
	[SimpleType]
	public struct jump {
		[CCode (cname = "setjmp")]
		public int set ();
		[CCode (cname = "longjmp")]
		[NoReturn]
		public void return int val;
	}

	[CCode (cname = "sigjmp_buf", cheader_filename = "setjmp.h", has_type_id = false)]
	[SimpleType]
	public struct sig_jump {
		[CCode (cname = "sigsetjmp")]
		public int set (bool save_mask);
		[CCode (cname = "siglongjmp")]
		[NoReturn]
		public void return int val;
	}
}
