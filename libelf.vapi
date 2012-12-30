[CCode(cheader_filename = "libelf.h")]
namespace Elf {
	/**
	 * Magic number byte 0
	 */
	[CCode(cname = "ELFMAG0")]
	public const uint8 MAG0;
	/**
	 * Magic number byte 1
	 */
	[CCode(cname = "ELFMAG1")]
	public const uint8 MAG1;
	/**
	 * Magic number byte 2
	 */
	[CCode(cname = "ELFMAG2")]
	public const uint8 MAG2;
	/**
	 * Magic number byte 3
	 */
	[CCode(cname = "ELFMAG3")]
	public const uint8 MAG3;
	/**
	 * Get error code of last failing function call.
	 *
	 * This value is kept separately for each thread.
	 */
	[CCode(cname = "elf_errno")]
	public int errno();
	/**
	 * Get error string.
	 *
	 * @param error If zero, return error string for most recent error or null is none occurred. If -1 the behaviour is similar to the last case except that not null but a legal string is returned.
	 */
	[CCode(cname = "elf_errmsg")]
	public unowned string? errmsg(int error);
	/**
	 * Set fill bytes used to fill holes in data structures.
	 */
	[CCode(cname = "elf_fill")]
	public void fill (int fill);
	/**
	 * Compute hash value.
	 */
	[CCode(cname = "elf_hash")]
	public ulong hash(string str);
	/**
	 * Coordinate ELF library and application versions.
	 */
	[CCode(cname = "elf_version")]
	public Version version(Version version = Version.CURRENT);
}
/**
 * Descriptor for the ELF file.
 */
[CCode(cname = "Elf", free_function = "elf_end")]
[Compact]
public class Elf.Desc {
	public archive_header? archive_header {
		[CCode(cname = "elf_getarhdr")]
		get;
	}
	/**
	 * Get the base offset for an object file.
	 */
	public Posix.off_t base_offset {
		[CCode(cname = "elf_getbase")]
		get;
	}
	/**
	 * Simple checksum from permanent parts of the ELF file.
	 */
	public long checksum {
		[CCode(cname = "elf32_checksum")]
		get;
	}
	/**
	 * Simple checksum from permanent parts of the ELF file using ELFCLASS64.
	 */
	public long checksum64 {
		[CCode(cname = "elf64_checksum")]
		get;
	}
	public hdr32? header {
		[CCode(cname = "elf32_getehdr")]
		get;
	}
	public hdr64? header64 {
		[CCode(cname = "elf64_getehdr")]
		get;
	}
	public uint8[] ident {
		[CCode(cname = "elf_getident", array_length_type = "size_t")]
		get;
	}
	/**
	 * The kind of file.
	 */
	public Elf.Kind kind {
		[CCode(cname = "elf_kind")]
		get;
	}
	public program_header? program_header {
		[CCode(cname = "elf32_getphdr")]
		get;
	}
	public program_header64? program_header64 {
		[CCode(cname = "elf64_getphdr")]
		get;
	}
	/**
	 * An uninterpreted byte image of the file.
	 *
	 * This should be used only to retrieve a file being read.
	 *
	 * A program may not close or disable the associated file descriptor the initial access, because the data might have to be read from the file if it does not already have the original bytes in memory. Generally, this function is more efficient for unknown file types than for object files. The library implicitly translates object files in memory, while it leaves unknown files unmodified. Thus, asking for the uninterpreted image of an object file may create a duplicate copy in memory.
	 * @see control
	 */
	public uint8[] raw {
		[CCode(cname = "elf_rawfile")]
		get;
	}
	/**
	 * Get descriptor for ELF file to manipulate.
	 * @param filedes the file descriptor of the open file
	 * @param cmd the type of actions that will be performed. This must match the state of the file descriptor.
	 * @param ar_parent if provided, this is an ar(1) archive to browse
	 */
	[CCode(cname = "elf_begin")]
	public static Desc? open(int filedes, Elf.Command cmd, Desc? ar_parent = null);
	/**
	 * Create descriptor for memory region.
	 */
	[CCode(cname = "elf_memory")]
	public static Desc? open_memory([CCode(array_length_type = "size_t")] uint8[] image);
	/**
	 * Create a clone of an existing descriptor.
	 */
	[CCode(cname = "elf_clone")]
 public Desc clone(Elf.Command cmd);
	/**
	 * Control the file descriptor.
	 * @param cmd when {@link Command.FDDONE}, it tells the library not to use the file descriptor. This is usefl when a program has requested all the required information. When {@link Command.FDREAD}, it forces the library to read the contents of the file so that it might close the descriptor.
	 */
	[CCode(cname = "elf_cntl")]
	public bool control(Command cmd);
	/**
	 * Behaves like {@link header}, but creates a header if one does not exist
	 */
	[CCode(cname = "elf32_newehdr")]
	public hdr32? create_header();
	/**
	 * Behaves like {@link header64}, but creates a header if one does not exist
	 */
	[CCode(cname = "elf64_newehdr")]
	public hdr64? create_header64();
	/**
	 * Create a new program header, discarding the previous one of it exists.
	 * @param count the number of entries in the header
	 */
	[CCode(cname = "elf32_newphdr")]
	public program_header? create_program_header(size_t count);
	/**
	 * Create a new program header, discarding the previous one of it exists.
	 * @param count the number of entries in the header
	 */
	[CCode(cname = "elf64_newphdr")]
	public program_header? create_program_header64(size_t count);
	/**
	 * Create a new section and append it.
	 */
	[CCode(cname = "elf_newscn")]
	public Section? create_section();
	/**
	 * Get an elf section.
	 *
	 * Note that {@link Elf.Section.UNDEF} is always present, but uninteresting.
	 */
	[CCode(cname = "elf_getscn")]
	public Section? get(size_t index);
	[CCode(cname = "elf_getarsym")]
	public ar_symbol? get_ar_symbol (out size_t length);
	/**
	 * Get the number of programs.
	 * @return false on success
	 */
	[CCode(cname = "elf_getphdrnum")]
	public bool get_num_programs(out size_t num);
	/**
	 * Get the number of sections.
	 * @return false on success
	 */
	[CCode(cname = "elf_getshdrnum")]
	public bool get_num_sections(out size_t num);
	/**
	 * Converts a string section offset to a string.
	 *
	 * This identifies the file in which the string section resides, and the section table index for the strings.
	 * @return normally a string, but null pointer when the section is invalid or is not a section of type {@link SectionType.STRTAB}, the section data cannot be obtained, offset is invalid, or an error occurs.
	 */
	[CCode(cname = "elf_strptr")]
	public unowned string? get_string(size_t section, size_t offset);
	/**
	 * Get the index of the string table.
	 * @return false on success
	 */
	[CCode(cname = "elf_getshdrstrndx")]
	public bool get_string_section(out size_t index);
	/**
	 * Move a section
	 *
	 * The application is responsible for updating data.
	 * @param scn the section to move
	 * @param after the section to place the moved section after
	 * @return the original index of the removed section. Zero indicates an error.
	 */
	[CCode(cname = "elfx_movscn")]
	public size_t move_section(Section scn, Section after);
	/**
	 * Advance archive descriptor to next element.
	 *
	 * This is only useful when opened from a parent descriptor.
	 */
	[CCode(cname = "elf_next")]
	public Elf.Command next();
	[CCode(cname = "elf_nextscn")]
	public unowned Section? next_section(Section? section = null);
	/**
	 * Allow random archive processing, preparing to access an arbitrary archive member.
	 *
	 * The object must be a descriptor for the archive itself, not a member within the archive.
	 *
	 * A program can mix random and sequential archive processing.
	 * @param offset specifies the byte offset from the beginning of the archive to the archive header of the desired member.
	 * @return on success, it returns offset. Otherwise, it returns 0, because an error occurred, or the file was not an archive (no archive member can have a zero offset).
	 * @see get_ar_symbol
	 */
	[CCode(cname = "elf_rand")]
	public size_t rand(size_t offset);
	/**
	 * Remove a section.
	 * @return the original index of the removed section. Zero indicates an error.
	 */
	[CCode(cname = "elfx_remscn")]
	public size_t remove_section(owned Section scn);
	/**
	 * Set the string table index.
	 * @return false on success
	 * @see get_string_section
	 */
	[CCode(cname = "elfx_update_shstrndx")]
	public bool set_string_section(size_t index);
	/**
	 * Causes the library to examine the information associated with an ELF descriptor, and to recalculate the structural data needed to generate the file's image.
	 *
	 * @param cmd When {@link Command.NULL}, it recalculates various values, updating only the ELF descriptor's memory structures. Any modified structures are flagged with the {@link Flag.DIRTY} bit. A program thus can update the structural information and then reexamine them without changing the file associated with the ELF descriptor. Because this does not change the file, the ELF descriptor may allow reading, writing, or both reading and writing. When {@link Command.WRITE}, it duplicates its {@link Command.NULL} actions and also writes any dirty information associated with the ELF descriptor to the file. That is, when a program has used {@link get} or the various ''update_flags'' facilities to supply new (or update existing) information for an ELF descriptor, those data will be examined, coordinated, translated if necessary, and written to the file. When portions of the file are written, any {@link Flag.DIRTY} bits are reset, indicating those items no longer need to be written to the file. The sections' data are written in the order of their section header entries, and the section header table is written to the end of the file. When the ELF descriptor was created, it must have allowed writing the file.
	 * @return If successful, it returns the total size of the file image (not the memory image), in bytes. Otherwise an error occurred, and the function returns -1.
	 */
	[CCode(cname = "elf_update")]
	public Posix.off_t update(Command cmd = Command.NULL);
	[CCode(cname = "elf_flagelf")]
	public Flag update_elf_flag(Command cmd, Flag flags);
	[CCode(cname = "elf_flagehdr")]
	public Flag update_elf_header_flags(Command cmd, Flag flags);
	[CCode(cname = "elf_flagphdr")]
	public Flag update_phdr_flag(Command cmd, Flag flags);
}
/*
 * Section descriptor
 */
[CCode(cname = "Elf_Scn")]
public class Elf.Section {
	public section_header? header {
		[CCode(cname = "elf32_getshdr")]
		get;
	}
	public section_header64? header64 {
		[CCode(cname = "elf64_getshdr")]
		get;
	}
	/**
	 * Section table index
	 */
	public size_t index {
		[CCode(cname = "elf_ndxscn")]
		get;
	}
	/**
	 * Creates a new data descriptor for a section, appending it to any data elements already associated with the section.
	 *
	 * The new data descriptor appears empty, indicating the element holds no data. For convenience, the descriptor's type is set to {@link Type.BYTE}, and the version is set to the working version. The program is responsible for setting (or changing) the descriptor members as needed. This function implicitly sets the {@link Flag.DIRTY} bit for the section's data.
	 */
	[CCode(cname = "elf_newdata")]
	public data? create_data();
	/**
	 * Get a data block assoicated with this section.
	 * @param previous the block preceeding the desired block, or null for the first
	 */
	[CCode(cname = "elf_getdata")]
	public data? get_data(data? previous = null);
	/**
	 * Get a datablock without interpreted bytes, regardless of the section type.
	 *
	 * This function typically should be used only to retrieve a section image from a file being read, and then only when a program must avoid the automatic data translation described below. Moreover, a program may not close or disable (see {@link Desc.control}) the file descriptor associated with elf before the initial raw operation, because this method might read the data from the file to ensure it doesn't interfere with {@link get_data}.
	 *
	 * See {@link Desc.raw} for a related facility that applies to the entire file. When {@link get_data} provides the right translation, its use is recommended.
	 */
	[CCode(cname = "elf_rawdata")]
	public data? get_raw_data (data? previous = null);
	[CCode(cname = "elf_flagshdr")]
	public Flag update_header_flags(Command cmd, Flag flags);
	[CCode(cname = "elf_flagscn")]
	public Flag update_flags(Command cmd, Flag flags);
	/**
	 * Undefined section
	 */
	[CCode(cname = "SHN_UNDEF")]
	public const size_t UNDEF;
	/**
	 * Start of reserved indices
	 */
	[CCode(cname = "SHN_LORESERVE")]
	public const size_t LORESERVE;
	/**
	 * Start of processor-specific
	 */
	[CCode(cname = "SHN_LOPROC")]
	public const size_t LOPROC;
	/**
	 * Order section before all others (Solaris).
	 */
	[CCode(cname = "SHN_BEFORE")]
	public const size_t BEFORE;
	/**
	 * Order section after all others (Solaris).
	 */
	[CCode(cname = "SHN_AFTER")]
	public const size_t AFTER;
	/**
	 * End of processor-specific
	 */
	[CCode(cname = "SHN_HIPROC")]
	public const size_t HIPROC;
	/**
	 * Start of OS-specific
	 */
	[CCode(cname = "SHN_LOOS")]
	public const size_t LOOS;
	/**
	 * End of OS-specific
	 */
	[CCode(cname = "SHN_HIOS")]
	public const size_t HIOS;
	/**
	 * Associated symbol is absolute
	 */
	[CCode(cname = "SHN_ABS")]
	public const size_t ABS;
	/**
	 * Associated symbol is common
	 */
	[CCode(cname = "SHN_COMMON")]
	public const size_t COMMON;
	/**
	 * Index is in extra table.
	 */
	[CCode(cname = "SHN_XINDEX")]
	public const size_t XINDEX;
	/**
	 * End of reserved indices
	 */
	[CCode(cname = "SHN_HIRESERVE")]
	public const size_t HIRESERVE;
}
/**
 * Archive symbol table entry
 */
[CCode(cname = "Elf_Arsym")]
public struct Elf.ar_symbol {
	/**
	 * Symbol name.
	 */
	[CCode(cname = "as_name")]
	string name;
	/**
	 * Offset for this file in the archive.
	 */
	[CCode(cname = "as_off")]
	size_t off;
	/**
	 * Hash value of the name.
	 */
	[CCode(cname = "as_hash")]
	ulong hash;
}
/**
 * Archive member header
 */
[CCode(cname = "Elf_Arhdr")]
public struct Elf.archive_header {
	/**
	 * An archive member name, is a string, with the ar format control characters removed.
	 * @see raw_name
	 */
	[CCode(cname = "ar_name")]
	string name;
	/**
	 * File date.
	 */
	[CCode(cname = "ar_date")]
	time_t date;
	/**
	 * User ID.
	 */
	[CCode(cname = "ar_uid")]
	long uid;
	/**
	 * Group ID.
	 */
	[CCode(cname = "ar_gid")]
	long gid;
	/**
	 * File mode.
	 */
	[CCode(cname = "ar_mode")]
	ulong mode;
	/**
	 * File size.
	 */
	[CCode(cname = "ar_size")]
	Posix.off_t size;
	/**
	 * Holds a string that represents the original name bytes in the file, including the terminating slash and trailing blanks as specified in the archive format.

	 * In addition to regular archive members, the archive format defines some special members. All special member names begin with a slash (/), distinguishing them from regular members (whose names may not contain a slash).
	 *
	 * * A single slash is the archive symbol table. If present, it will be the first archive member. A program may access the archive symbol table through {@link Desc.get_ar_symbol}. The information in the symbol table is useful for random archive processing (see {@link Desc.rand}).
	 * * A double slash member, if present, holds a string table for long archive member names. An archive member's header contains a 16-byte area for the name, which may be exceeded in some file systems.
	 */
	[CCode(cname = "ar_rawname")]
	string raw_name;
}
/**
 * Data converted to/from memory format
 */
[CCode(cname = "Elf_Data", destroy_function = "")]
public struct Elf.data {
	[CCode(cname = "d_buf", array_length_cname = "d_size")]
	public uint8[] buf;
	[CCode(cname = "d_type")]
	public Type type;
	[CCode(cname = "d_off")]
	public Posix.off_t offset;
	[CCode(cname = "d_align")]
	public size_t align;
	[CCode(cname = "d_version")]
	public Version version;
	[CCode(cname = "elf32_xlatetof", instance_pos = 1.1)]
	public bool from_memory(out data dst, Encoding encode);
	[CCode(cname = "elf32_xlatetom", instance_pos = 1.1)]
	public bool to_memory(out data dst, Encoding encode);
	[CCode(cname = "elf64_xlatetof", instance_pos = 1.1)]
	public bool from_memory64(out data dst, Encoding encode);
	[CCode(cname = "elf64_xlatetom", instance_pos = 1.1)]
	public bool to_memory64(out data dst, Encoding encode);
	[CCode(cname = "elf_flagdata")]
	public Flag update_flags(Command cmd, Flag flags);
}
/* The ELF file header. This appears at the start of every ELF file. */
[CCode(cname = "Elf32_Ehdr")]
public struct Elf.hdr32 {
	/**
	 * Magic number
	 */
	[CCode(cname = "e_ident", array_length_cexpr = "EI_NIDENT")]
	char[] ident;
	[CCode(cname = "e_type")]
	ObjType type;
	[CCode(cname = "e_machine")]
	Machine machine;
	[CCode(cname = "e_version")]
	Version version;
	/**
	 * Entry point virtual address
	 */
	[CCode(cname = "e_entry")]
	uint32 entry;
	/**
	 * Program header table file offset
	 */
	[CCode(cname = "e_phoff")]
	uint32 program_header_offset;
	/**
	 * Section header table file offset
	 */
	[CCode(cname = "e_shoff")]
	uint32 section_header_offset;
	/**
	 * Processor-specific flags
	 */
	[CCode(cname = "e_flags")]
	uint32 flags;
	/**
	 * ELF header size in bytes
	 */
	[CCode(cname = "e_ehsize")]
	uint16 header_size;
	/**
	 * Program header table entry size
	 */
	[CCode(cname = "e_phentsize")]
	uint16 program_entry_size;
	/**
	 * Program header table entry count
	 */
	[CCode(cname = "e_phnum")]
	uint16 program_count;
	/**
	 * Section header table entry size
	 */
	[CCode(cname = "e_shentsize")]
	uint16 section_header_size;
	/**
	 * Section header table entry count
	 */
	[CCode(cname = "e_shnum")]
	uint16 section_count;
	/**
	 * Section header string table index
	 */
	[CCode(cname = "e_shstrndx")]
	uint16 string_index;
}
[CCode(cname = "Elf64_Ehdr")]
public struct Elf.hdr64 {
	/**
	 * Magic number
	 */
	[CCode(cname = "e_ident", array_length_cexpr = "EI_NIDENT")]
 char[] ident;
	[CCode(cname = "e_type")]
	ObjType type;
	[CCode(cname = "e_machine")]
	Machine machine;
	[CCode(cname = "e_version")]
	Version version;
	/**
	 * Entry point virtual address
	 */
	[CCode(cname = "e_entry")]
	uint64 entry;
	/**
	 * Program header table file offset
	 */
	[CCode(cname = "e_phoff")]
	uint64 program_header_offset;
	/**
	 * Section header table file offset
	 */
	[CCode(cname = "e_shoff")]
	uint64 section_header_offset;
	/**
	 * Processor-specific flags
	 */
	[CCode(cname = "e_flags")]
	uint32 flags;
	/**
	 * ELF header size in bytes
	 */
	[CCode(cname = "e_ehsize")]
	uint16 header_size;
	/**
	 * Program header table entry size
	 */
	[CCode(cname = "e_phentsize")]
	uint16 program_entry_size;
	/**
	 * Program header table entry count
	 */
	[CCode(cname = "e_phnum")]
	uint16 program_count;
	/**
	 * Section header table entry size
	 */
	[CCode(cname = "e_shentsize")]
	uint16 section_header_size;
	/**
	 * Section header table entry count
	 */
	[CCode(cname = "e_shnum")]
	uint16 section_count;
	/**
	 * Section header string table index
	 */
	[CCode(cname = "e_shstrndx")]
	uint16 string_index;

	[CCode(cname = "e_ident[EI_CLASS]")]
	public Class @class;
	[CCode(cname = "e_ident[EI_DATA]")]
	public Encoding encoding;
	[CCode(cname = "e_ident[EI_VERSION]")]
	public Version abi_version;
	[CCode(cname = "e_ident[EI_OSABI]")]
	public OsAbi abi;
}
[CCode(cname = "Elf32_Phdr")]
public struct Elf.program_header {
	[CCode(cname = "p_type")]
	ProgType type;
	/**
	 * Segment file offset
	 */
	[CCode(cname = "p_offset")]
	uint32 offset;
	/**
	 * Segment virtual address
	 */
	[CCode(cname = "p_vaddr")]
	uint32 virtual_addr;
	/**
	 * Segment physical address
	 */
	[CCode(cname = "p_paddr")]
	uint32 physical_addr;
	/**
	 * Segment size in file
	 */
	[CCode(cname = "p_filesz")]
	uint32 file_size;
	/**
	 * Segment size in memory
	 */
	[CCode(cname = "p_memsz")]
	uint32 memory_Size;
	[CCode(cname = "p_flags")]
	SegmentFlag flags;
	/**
	 * Segment alignment
	 */
	[CCode(cname = "p_align")]
	uint32 align;
}
[CCode(cname = "Elf64_Phdr")]
public struct Elf.program_header64 {
	[CCode(cname = "p_type")]
	ProgType type;
	/**
	 * Segment file offset
	 */
	[CCode(cname = "p_offset")]
	uint64 offset;
	/**
	 * Segment virtual address
	 */
	[CCode(cname = "p_vaddr")]
	uint64 virtual_addr;
	/**
	 * Segment physical address
	 */
	[CCode(cname = "p_paddr")]
	uint64 physical_addr;
	/**
	 * Segment size in file
	 */
	[CCode(cname = "p_filesz")]
	uint64 file_size;
	/**
	 * Segment size in memory
	 */
	[CCode(cname = "p_memsz")]
	uint64 memory_Size;
	[CCode(cname = "p_flags")]
	SegmentFlag flags;
	/**
	 * Segment alignment
	 */
	[CCode(cname = "p_align")]
	uint64 align;
}
[CCode(cname = "Elf32_Shdr")]
public struct Elf.section_header {
	/**
	 * Section name (string table index)
	 */
	[CCode(cname = "sh_name")]
	uint32 name;
	[CCode(cname = "sh_type")]
	SectionType type;
	[CCode(cname = "sh_flags")]
	SectionFlag flags;
	/**
	 * Section virtual addr at execution
	 */
	[CCode(cname = "sh_addr")]
	uint32 addr;
	/**
	 * Section file offset
	 */
	[CCode(cname = "sh_offset")]
	uint32 offset;
	/**
	 * Section size in bytes
	 */
	[CCode(cname = "sh_size")]
	uint32 size;
	/**
	 * Link to another section
	 */
	[CCode(cname = "sh_link")]
	uint32 link;
	/**
	 * Additional section information
	 */
	[CCode(cname = "sh_info")]
	uint32 info;
	/**
	 * Section alignment
	 */
	[CCode(cname = "sh_addralign")]
	uint32 addralign;
	/**
	 * Entry size if section holds table
	 */
	[CCode(cname = "sh_entsize")]
	uint32 entsize;
}
[CCode(cname = "Elf64_Shdr")]
public struct Elf.section_header64 {
	/**
	 * Section name (string table index)
	 */
	[CCode(cname = "sh_name")]
	uint32 name;
	[CCode(cname = "sh_type")]
	SectionType type;
	[CCode(cname = "sh_flags")]
	SectionFlag flags;
	/**
	 * Section virtual addr at execution
	 */
	[CCode(cname = "sh_addr")]
	uint64 addr;
	/**
	 * Section file offset
	 */
	[CCode(cname = "sh_offset")]
	uint64 offset;
	/**
	 * Section size in bytes
	 */
	[CCode(cname = "sh_size")]
	uint64 size;
	/**
	 * Link to another section
	 */
	[CCode(cname = "sh_link")]
	uint64 link;
	/**
	 * Additional section information
	 */
	[CCode(cname = "sh_info")]
	uint64 info;
	/**
	 * Section alignment
	 */
	[CCode(cname = "sh_addralign")]
	uint64 addralign;
	/**
	 * Entry size if section holds table
	 */
	[CCode(cname = "sh_entsize")]
	uint64 entsize;
}

[CCode(cname = "int")]
public enum Elf.Class {
	[CCode(cname = "ELFCLASSNONE")]
	NONE,
	[CCode(cname = "ELFCLASS32")]
	THIRTY_TWO,
	[CCode(cname = "ELFCLASS64")]
	SIXTY_FOUR
}
[CCode(cname = "Elf_Cmd", cprefix = "ELF_C_")]
public enum Elf.Command {
	/**
	 * Nothing, terminate, or compute only.
	 */
	NULL,
	/**
	 * Read.
	 */
	READ,
	/**
	 * Read and write.
	 */
	RDWR,
	/**
	 * Write.
	 */
	WRITE,
	/**
	 * Clear flag.
	 */
	CLR,
	/**
	 * Set flag.
	 */
	SET,
	/**
	 * Signal that file descriptor will not be used anymore.
	 */
	FDDONE,
	/**
	 * Read rest of data so that file descriptor is not used anymore.
	 */
	FDREAD,
	/**
	 * Read, but mmap the file if possible.
	 */
	READ_MMAP,
	/**
	 * Read and write, with mmap.
	 */
	RDWR_MMAP,
	/**
	 * Write, with mmap.
	 */
	WRITE_MMAP,
	/**
	 * Read, but memory is writable, results are not written to the file.
	 */
	READ_MMAP_PRIVATE,
	/**
	 * Copy basic file data but not the content.
	 */
	EMPTY
}
[CCode(cname = "int", cprefix = "ELFDATA")]
public enum Elf.Encoding {
	/**
	 * Invalid data encoding
	 */
	NONE,
	/**
	 * 2's complement, little endian
	 */
	[CCode(cname = "ELFDATA2LSB")]
	TWO_LSB,
	/**
	 * 2's complement, big endian
	 */
	[CCode(cname = "ELFDATA2MSB")]
	TWO_MSB
}
[CCode(cname = "int", cprefix ="ELF_F_")]
[Flags]
public enum Elf.Flag {
	DIRTY,
	LAYOUT,
	/**
	 * Allow sections to overlap when {@link LAYOUT} is in effect.
	 *
	 * Note that this flag ist NOT portable, and that it may render the output
	 * file unusable. Use with extreme caution!
	 */
	LAYOUT_OVERLAP
}
/**
 * Identification values for recognized object files.
 */
[CCode(cname = "Elf_Kind")]
public enum Elf.Kind {
	/**
	 * Unknown.
	 */
	NONE,
	/**
	 * Archive.
	 */
	AR,
	/**
	 * Stupid old COFF.
	 */
	COFF,
	/**
	 * ELF file.
	 */
	ELF,
}
[CCode(cname = "int", cprefix = "EM_")]
public enum Elf.Machine {
	/**
	 * No machine
	 */
	NONE,
	/**
	 * AT&T WE 32100
	 */
	M32,
	/**
	 * SUN SPARC
	 */
	SPARC,
	/**
	 * Intel 80386
	 */
	[CCode(cname = "EM_386")]
	I386,
	/**
	 * Motorola m68k family
	 */
	[CCode(cname = "EM_68K")]
	M68K,
	/**
	 * Motorola m88k family
	 */
	[CCode(cname = "EM_88K")]
	M88K,
	/**
	 * Intel 80860
	 */
	[CCode(cname = "EM_860")]
	M860,
	/**
	 * MIPS R3000 big-endian
	 */
	MIPS,
	/**
	 * IBM System/370
	 */
	S370,
	/**
	 * MIPS R3000 little-endian
	 */
	MIPS_RS3_LE,
	/**
	 * HPPA
	 */
	PARISC,
	/**
	 * Fujitsu VPP500
	 */
	VPP500,
	/**
	 * Sun's "v8plus"
	 */
	SPARC32PLUS,
	/**
	 * Intel 80960
	 */
	[CCode(cname = "EM_960")]
	I960,
	/**
	 * PowerPC
	 */
	PPC,
	/**
	 * PowerPC 64-bit
	 */
	PPC64,
	/**
	 * IBM S390
	 */
	S390,
	/**
	 * NEC V800 series
	 */
	V800,
	/**
	 * Fujitsu FR20
	 */
	FR20,
	/**
	 * TRW RH-32
	 */
	RH32,
	/**
	 * Motorola RCE
	 */
	RCE,
	/**
	 * ARM
	 */
	ARM,
	/**
	 * Digital Alpha
	 */
	FAKE_ALPHA,
	ALPHA,
	/**
	 * Hitachi SH
	 */
	SH,
	/**
	 * SPARC v9 64-bit
	 */
	SPARCV9,
	/**
	 * Siemens Tricore
	 */
	TRICORE,
	/**
	 * Argonaut RISC Core
	 */
	ARC,
	/**
	 * Hitachi H8/300
	 */
	H8_300,
	/**
	 * Hitachi H8/300H
	 */
	H8_300H,
	/**
	 * Hitachi H8S
	 */
	H8S,
	/**
	 * Hitachi H8/500
	 */
	H8_500,
	/**
	 * Intel Merced
	 */
	IA_64,
	/**
	 * Stanford MIPS-X
	 */
	MIPS_X,
	/**
	 * Motorola Coldfire
	 */
	COLDFIRE,
	/**
	 * Motorola M68HC12
	 */
	68HC12,
	/**
	 * Fujitsu MMA Multimedia Accelerator
	 */
	MMA,
	/**
	 * Siemens PCP
	 */
	PCP,
	/**
	 * Sony nCPU embeeded RISC
	 */
	NCPU,
	/**
	 * Denso NDR1 microprocessor
	 */
	NDR1,
	/**
	 * Motorola Start*Core processor
	 */
	STARCORE,
	/**
	 * Toyota ME16 processor
	 */
	ME16,
	/**
	 * STMicroelectronic ST100 processor
	 */
	ST100,
	/**
	 * Advanced Logic Corp. Tinyj emb.fam
	 */
	TINYJ,
	/**
	 * AMD x86-64 architecture
	 */
	X86_64,
	/**
	 * Sony DSP Processor
	 */
	PDSP,
	/**
	 * Siemens FX66 microcontroller
	 */
	FX66,
	/**
	 * STMicroelectronics ST9+ 8/16 mc
	 */
	ST9PLUS,
	/**
	 * STmicroelectronics ST7 8 bit mc
	 */
	ST7,
	/**
	 * Motorola MC68HC16 microcontroller
	 */
	68HC16,
	/**
	 * Motorola MC68HC11 microcontroller
	 */
	68HC11,
	/**
	 * Motorola MC68HC08 microcontroller
	 */
	68HC08,
	/**
	 * Motorola MC68HC05 microcontroller
	 */
	68HC05,
	/**
	 * Silicon Graphics SVx
	 */
	SVX,
	/**
	 * STMicroelectronics ST19 8 bit mc
	 */
	ST19,
	/**
	 * Digital VAX
	 */
	VAX,
	/**
	 * Axis Communications 32-bit embedded processor
	 */
	CRIS,
	/**
	 * Infineon Technologies 32-bit embedded processor
	 */
	JAVELIN,
	/**
	 * Element 14 64-bit DSP Processor
	 */
	FIREPATH,
	/**
	 * LSI Logic 16-bit DSP Processor
	 */
	ZSP,
	/**
	 * Donald Knuth's educational 64-bit processor
	 */
	MMIX,
	/**
	 * Harvard University machine-independent object files
	 */
	HUANY,
	/**
	 * SiTera Prism
	 */
	PRISM,
	/**
	 * Atmel AVR 8-bit microcontroller
	 */
	AVR,
	/**
	 * Fujitsu FR30
	 */
	FR30,
	/**
	 * Mitsubishi D10V
	 */
	D10V,
	/**
	 * Mitsubishi D30V
	 */
	D30V,
	/**
	 * NEC v850
	 */
	V850,
	/**
	 * Mitsubishi M32R
	 */
	M32R,
	/**
	 * Matsushita MN10300
	 */
	MN10300,
	/**
	 * Matsushita MN10200
	 */
	MN10200,
	/**
	 * picoJava
	 */
	PJ,
	/**
	 * OpenRISC 32-bit embedded processor
	 */
	OPENRISC,
	/**
	 * ARC Cores Tangent-A5
	 */
	ARC_A5,
	/**
	 * Tensilica Xtensa Architecture
	 */
	XTENSA
}
[CCode(cname = "int", cprefix = "ET_NONE")]
public enum Elf.ObjType {
	/**
	 * No file type
	 */
	NONE,
	/**
	 * Relocatable file
	 */
	REL,
	/**
	 * Executable file
	 */
	EXEC,
	/**
	 * Shared object file
	 */
	DYN,
	/**
	 * Core file
	 */
	CORE
}
[CCode(cname = "int", cprefix = "ELFOSABI_")]
public enum Elf.OsAbi {
	/**
	 * UNIX System V ABI
	 */
	NONE,
	SYSV,
	/**
	 * HP-UX
	 */
	HPUX,
	/**
	 * NetBSD.
	 */
	NETBSD,
	/**
	 * Object uses GNU ELF extensions.
	 */
	GNU,
	LINUX,
	/**
	 * Sun Solaris.
	 */
	SOLARIS,
	/**
	 * IBM AIX.
	 */
	AIX,
	/**
	 * SGI Irix.
	 */
	IRIX,
	/**
	 * FreeBSD.
	 */
	FREEBSD,
	/**
	 * Compaq TRU64 UNIX.
	 */
	TRU64,
	/**
	 * Novell Modesto.
	 */
	MODESTO,
	/**
	 * OpenBSD.
	 */
	OPENBSD,
	/**
	 * ARM EABI
	 */
	ARM_AEABI,
	/**
	 * ARM
	 */
	ARM,
	/**
	 * Standalone (embedded) application
	 */
	STANDALONE
}
[CCode(cname = "int", cprefix = "PT_")]
public enum Elf.ProgType {
	/**
	 * Program header table entry unused
	 */
	NULL,
	/**
	 * Loadable program segment
	 */
	LOAD,
	/**
	 * Dynamic linking information
	 */
	DYNAMIC,
	/**
	 * Program interpreter
	 */
	INTERP,
	/**
	 * Auxiliary information
	 */
	NOTE,
	/**
	 * Reserved
	 */
	SHLIB,
	/**
	 * Entry for header table itself
	 */
	PHDR,
	/**
	 * Thread-local storage segment
	 */
	TLS,
	/**
	 * Start of OS-specific
	 */
	LOOS,
	/**
	 * GCC .eh_frame_hdr segment
	 */
	GNU_EH_FRAME,
	/**
	 * Indicates stack executability
	 */
	GNU_STACK,
	/**
	 * Read-only after relocation
	 */
	GNU_RELRO,
	LOSUNW,
	/**
	 * Sun Specific segment
	 */
	SUNWBSS,
	/**
	 * Stack segment
	 */
	SUNWSTACK,
	HISUNW,
	/**
	 * End of OS-specific
	 */
	HIOS,
	/**
	 * Start of processor-specific
	 */
	LOPROC,
	/**
	 * End of processor-specific
	 */
	HIPROC,
}
[CCode(cname = "long", cprefix = "SHF_")]
[Flags]
public enum Elf.SectionFlag {
	/**
	 * Writable
	 */
	WRITE,
	/**
	 * Occupies memory during execution
	 */
	ALLOC,
	/**
	 * Executable
	 */
	EXECINSTR,
	/**
	 * Might be merged
	 */
	MERGE,
	/**
	 * Contains nul-terminated strings
	 */
	STRINGS,
	/**
	 * `sh_info' contains SHT index
	 */
	INFO_LINK,
	/**
	 * Preserve order after combining
	 */
	LINK_ORDER,
	/**
	 * Non-standard OS specific handling required
	 */
	OS_NONCONFORMING,
	/**
	 * Section is member of a group.
	 */
	GROUP,
	/**
	 * Section hold thread-local data.
	 */
	TLS,
	/**
	 * OS-specific.
	 */
	MASKOS,
	/**
	 * Processor-specific
	 */
	MASKPROC,
	/**
	 * Special ordering requirement (Solaris).
	 */
	ORDERED,
	/**
	 * Section is excluded unless referenced or allocated (Solaris).
	 */
	EXCLUDE
}
[CCode(cname = "long")]
public enum Elf.SectionType {
	/**
	 * Section header table entry unused
	 */
	NULL,
	/**
	 * Program data
	 */
	PROGBITS,
	/**
	 * Symbol table
	 */
	SYMTAB,
	/**
	 * String table
	 */
	STRTAB,
	/**
	 * Relocation entries with addends
	 */
	RELA,
	/**
	 * Symbol hash table
	 */
	HASH,
	/**
	 * Dynamic linking information
	 */
	DYNAMIC,
	/**
	 * Notes
	 */
	NOTE,
	/**
	 * Program space with no data (bss)
	 */
	NOBITS,
	/**
	 * Relocation entries, no addends
	 */
	REL,
	/**
	 * Reserved
	 */
	SHLIB,
	/**
	 * Dynamic linker symbol table
	 */
	DYNSYM,
	/**
	 * Array of constructors
	 */
	INIT_ARRAY,
	/**
	 * Array of destructors
	 */
	FINI_ARRAY,
	/**
	 * Array of pre-constructors
	 */
	PREINIT_ARRAY,
	/**
	 * Section group
	 */
	GROUP,
	/**
	 * Extended section indeces
	 */
	SYMTAB_SHNDX,
	/**
	 * Start OS-specific.
	 */
	LOOS,
	/**
	 * Object attributes.
	 */
	GNU_ATTRIBUTES,
	/**
	 * GNU-style hash table.
	 */
	GNU_HASH,
	/**
	 * Prelink library list
	 */
	GNU_LIBLIST,
	/**
	 * Checksum for DSO content.
	 */
	CHECKSUM,
	/**
	 * Sun-specific low bound.
	 */
	LOSUNW,
	SUNW_move,
	SUNW_COMDAT,
	SUNW_syminfo,
	/**
	 * Version definition section.
	 */
	GNU_verdef,
	/**
	 * Version needs section.
	 */
	GNU_verneed,
	/**
	 * Version symbol table.
	 */
	GNU_versym,
	/**
	 * Sun-specific high bound.
	 */
	HISUNW,
	/**
	 * End OS-specific type
	 */
	HIOS,
	/**
	 * Start of processor-specific
	 */
	LOPROC,
	/**
	 * End of processor-specific
	 */
	HIPROC,
	/**
	 * Start of application-specific
	 */
	LOUSER,
	/**
	 * End of application-specific
	 */
	HIUSER
}
public enum Elf.SegmentFlag {
	/**
	 * Executable
	 */
	X,
	/**
	 * Writable
	 */
	W,
	/**
	 * Readable
	 */
	R,
	/**
	 * OS-specific
	 */
	MASKOS,
	/**
	 * Processor-specific
	 */
	MASKPROC
}
/**
 * Known translation types.
 */
[CCode(cname = "Elf_Type", cprefix = "ELF_T_")]
public enum Elf.Type {
	/**
	 * unsigned char
	 */
	BYTE,
	/**
	 * Elf32_Addr, Elf64_Addr, ...
	 */
	ADDR,
	/**
	 * Dynamic section record.
	 */
	DYN,
	/**
	 * ELF header.
	 */
	EHDR,
	/**
	 * Elf32_Half, Elf64_Half, ...
	 */
	HALF,
	/**
	 * Elf32_Off, Elf64_Off, ...
	 */
	OFF,
	/**
	 * Program header.
	 */
	PHDR,
	/**
	 * Relocation entry with addend.
	 */
	RELA,
	/**
	 * Relocation entry.
	 */
	REL,
	/**
	 * Section header.
	 */
	SHDR,
	/**
	 * Elf32_Sword, Elf64_Sword, ...
	 */
	SWORD,
	/**
	 * Symbol record.
	 */
	SYM,
	/**
	 * Elf32_Word, Elf64_Word, ...
	 */
	WORD,
	/**
	 * Elf32_Xword, Elf64_Xword, ...
	 */
	XWORD,
	/**
	 * Elf32_Sxword, Elf64_Sxword, ...
	 */
	SXWORD,
	/**
	 * Elf32_Verdef, Elf64_Verdef, ...
	 */
	VDEF,
	/**
	 * Elf32_Verdaux, Elf64_Verdaux, ...
	 */
	VDAUX,
	/**
	 * Elf32_Verneed, Elf64_Verneed, ...
	 */
	VNEED,
	/**
	 * Elf32_Vernaux, Elf64_Vernaux, ...
	 */
	VNAUX,
	/**
	 * Elf32_Nhdr, Elf64_Nhdr, ...
	 */
	NHDR,
	/**
	 * Elf32_Syminfo, Elf64_Syminfo, ...
	 */
	SYMINFO,
	/**
	 * Elf32_Move, Elf64_Move, ...
	 */
	MOVE,
	/**
	 * Elf32_Lib, Elf64_Lib, ...
	 */
	LIB,
	/**
	 * GNU-style hash section.
	 */
	GNUHASH,
	/**
	 * Elf32_auxv_t, Elf64_auxv_t, ...
	 */
	AUXV;
	/**
	 * Return size of array of the type in the external representation.
	 *
	 * The binary class is taken from ELF. The result is based on the version of the ELF standard.
	 */
	[CCode(cname = "elf32_fsize")]
	public size_t size(size_t count = 1, Version version = Version.CURRENT);
	/**
	 * Return size of array of the type in the external representation in ELFCLASS64.
	 */
	[CCode(cname = "elf64_fsize")]
	public size_t size64(size_t count = 1, Version version = Version.CURRENT);
}
[CCode(cname = "unsigned int", cprefix = "EV_")]
public enum Elf.Version {
	/**
	 * Invalid ELF version
	 */
	NONE,
	/**
	 * Current version
	 */
	CURRENT
}
