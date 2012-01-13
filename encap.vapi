/*
 * Vala API for libencap
 *
 * Maintainted by Andre Masella <andre@masella.name>
 * Based on encap.h and encap_list.h which are:
 *  Copyright 1998-2003 University of Illinois Board of Trustees
 *  Copyright 1998-2004 Mark D. Roth <roth@feep.net>
 *  All rights reserved.
 */
[CCode(cheader_filename = "encap.h")]
namespace Encap {

	/**
	 * Result of package operation.
	 */
	[CCode(cname = "int", cprefix = "ENCAP_STATUS_", has_type_id = false)]
	public enum Status {
		/**
		 * Operation failed.
		 */
		FAILED,
		/**
		 * No action was needed.
		 */
		NOOP,
		/**
		 * Operation partially successful.
		 *
		 * Some files were processed successfully, but at least one error was encountered.
		 */
		PARTIAL,
		/**
		 * Operation successful.
		 */
		SUCCESS
	}

	/**
	 * Result of most operations
	 */
	[CCode(cname = "int", has_type_id = false)]
	public enum Result {
		/**
		 * No error occured
		 */
		[CCode(cname = "0")]
		OK,
		/**
		 * An error occured and ''errno'' is set.
		 */
		[CCode(cname = "-1")]
		FAIL
	}

	/**
	 * An Encap package handle
	 */
	[CCode(cname = "ENCAP", free_function = "encap_close", has_type_id = false)]
	[Compact]
	public class Package {
		/**
		 * Name of package
		 */
		[CCode(cname = "e_pkgname")]
		public string name;
		/**
		 * Package information
		 */
		[CCode(cname = "e_pkginfo")]
		public info info;
		/**
		 * Options associated with package
		 */
		[CCode(cname = "e_options")]
		public Options options;
		/**
		 * Encap source directory
		 */
		[CCode(cname = "e_source")]
		public string source;
		/**
		 * Encap target directory
		 */
		[CCode(cname = "e_target")]
		public string target;
		/**
		 * Output function
		 */
		[CCode(cname = "e_print_func")]
		public PrintFunc print_func;

		/**
		 * The creates a handle associated with an Encap package.
		 *
		 * @param print_func used to communicate its actions to the calling application.
		 */
		[CCode(cname = "encap_open")]
		public static Result open(out Package package, string source_directory, string target_directory, string package_name, Options options, PrintFunc print_func);
		/**
		 * Install the package.
		 *
		 * @see DecisionFunction
		 */
		[CCode(cname = "encap_install")]
		public Status install(DecisionFunction func);
		/**
		 * Uninstall the package.
		 *
		 * @see DecisionFunction
		 */
		[CCode(cname = "encap_remove")]
		public Status remove(DecisionFunction func);
		/**
		 * Check the status of the package.
		 *
		 * @see DecisionFunction
		 */
		[CCode(cname = "encap_check")]
		public Status check(DecisionFunction func);
		/**
		 * Describe an Encap source file
		 *
		 * @param subdirectory the subdirectory under the package directory
		 * @param file the filename in the subdirectory.
		 * @return if Result.FAIL, errno is set
		 */
		[CCode(cname = "encap_check_source")]
		public Result check_source(string subdirectory, string file, out source_info info);

		/**
		 * Check prerequisites for an Encap package
		 *
TODO
** returns:
**	0				success
**	1				prereqs not satisfied
**	-1 (and sets errno)		failure
*/
		[CCode(cname = "encap_check_prereqs")]
		public int check_prereqs();

	}

	/**
	 * Communicate data from ''libencap''.
	 *
	 * @param package The package being processed.
	 * @param source The source file being processed.
	 * @param target The source file being processed.
	 * @param type Denotes the disposition
	 * @param format Format argument.
	 * @return The number of characters written.
	 */
	[CCode(cname = "encap_print_func_t", has_target = false, has_type_id = false)]
	[PrintfFormat]
	public delegate int PrintFunc(Package package, source_info? source, target_info? target, Message type, string format, ...);

	/**
	 * Recursion actions returned by decision functions
	 */
	[CCode(cname = "int", cprefix = "R_", has_type_id = false)]
	public enum Decision {
		/**
		 * Fatal error.
		 *
		 * Stop processing the Encap and return immediately.
		 */
		RETURN,
		/**
		 * Non-fatal error.
		 *
		 * Processing continues with the next file in the Encap package.  (Note that if {@link SourceFlags.REQUIRED} is set in {@link source_info.flags}, a fatal error will result.  This case is handled the same as {@link RETURN}.)
		 */
		ERR,
		/**
		 * Continue normally (File should be processed normally).
		 */
		FILEOK,
		/**
		 * Skip to next file
		 *
		 * Do not process this file. No error is recorded, and processing continues with the next file in the Encap package.
		 */
		SKIP
	}

	/**
	 * Evaluate the link and override ''libencap'''s decision about how to handle it.
	 *
	 * This allows the calling application to have more fine-grained control over Encap processing.
	 *
	 * The function is called for each file which is processed.
	 * @param encap The package being processed.
	 * @param source The description of the Encap source file which is returned by {@link Package.check_source}.
	 * @param target The description of the Encap target link which is returned by {@link check_target}.
	 */
	[CCode(cname = "encap_decision_func_t", has_target = false, has_type_id = false)]
	public delegate Decision DecisionFunction(Package package, source_info source, target_info target);

	/**
	 * Callback for {@link find_versions}
	 *
	 * @param name the package name
	 * @param version the version found
	 */
	[CCode(cname = "verfunc_t", instance_pos = 0, has_type_id = false)]
	public delegate Result VersionFunc(string name, string version);

	/**
	 * Scan source directory for all versions of a given package
	 *
	 * The function scans the Encap source directory for all versions of the package.  For each version
which is found, the supplied function is called.  If the function returns {@link Result.FAIL}, the search stops immediately.
	 * @return On success, the number of versions found.  If the callback returns {@link Result.FAIL}, the function returns -2.  On other errors, -1 and sets errno.
	 */
	[CCode(cname = "encap_find_versions")]
	public int find_versions(string source_directory, string name, VersionFunc func);

	/**
	 * Compare version strings
	 * @return less than, equal to, or greater than zero if ''version1'' is less than, equal to, or greater than ''version2'' respectively.
	 */
	[CCode(cname = "encap_vercmp")]
	public int compare_version(string version1, string version2);

	namespace PkgSpec {
		/**
		 * Splits up ''pkgspec'' into its component parts.
		 *
		 * @param name_buffer buffer into which the package name is written
		 * @param version_buffer buffer into which the package version is written
		 * @param platform_buffer buffer into which the package platform is written
		 * @param extension_buffer buffer into which the package extension is written
		 * @return if Result.FAIL, errno is set
		 */
		[CCode(cname = "encap_pkgspec_parse")]
		public Result parse(string pkgspec, [CCode(array_length_type = "size_t")]uint8[]? name_buffer, [CCode(array_length_type = "size_t")]uint8[]? version_buffer, [CCode(array_length_type = "size_t")]uint8[]? platform_buffer, [CCode(array_length_type = "size_t")]uint8[]? extension_buffer);

		/**
		 * Join a package name with a package version to produce a full ''pkgspec''.
		 *
		 * @return if Result.FAIL, errno is set (ENAMETOOLONG if the buffer is too small)
		 */
		[CCode(cname = "encap_pkgspec_join")]
		public Result join([CCode(array_length_type = "size_t")]uint8[] buffer, string name, string version);
	}

	/**
	 * Description of source file
	 */
	[CCode(cname = "encap_source_info_t", destroy_function = "", has_type_id = false)]
	public struct source_info {
		[CCode(cname = "src_flags")]
		SourceFlags flags;
		/**
		 * Absolute path to source file
		 */
		[CCode(cname = "src_path")]
		public string path;
		[CCode(cname = "src_pkgdir_relative")]
		/**
		 * Relative path from pkg dir
		 */
		string pkgdir_relative;
		/**
		 * Absolute path to target file
		 */
		[CCode(cname = "src_target_path")]
		string target_path;
		/**
		 * Relative path from target dir
		 */
		[CCode(cname = "src_target_relative")]
		string target_relative;
		/**
		 * What the link //should// point to
		 */
		[CCode(cname = "src_link_expecting")]
		string link_expecting;
	}

	/**
	 * State of a source file.
	 */
	[CCode(cname = "int", cprefix = "SRC_", has_type_id = false)]
	[Flags]
	public enum SourceFlags {
		/**
		 * File is required
		 */
		REQUIRED,
		/**
		 * file is a linkdir
		 */
		LINKDIR,
		/**
		 * File matches exclude entry
		 */
		EXCLUDED,
		/**
		 * File is a directory
		 */
		ISDIR,
		/**
		 * File is a symlink
		 */
		ISLNK
	}

	/**
	 * Description of a target file
	 */
	[CCode(cname = "encap_target_info_t", destroy_function = "", has_type_id = false)]
	public struct target_info {
		[CCode(cname = "tgt_flags")]
		TargetFlags flags;
		/**
		 * What the link //does// point to
		 */
		[CCode(cname = "tgt_link_existing")]
		string link_existing;
		/**
		 * Package the link points to
		 */
		[CCode(cname = "tgt_link_existing_pkg")]
		string link_existing_pkg;
		[CCode(cname = "tgt_link_existing_pkgdir_relative")]
		string link_existing_pkgdir_relative;
	}

	/**
	 * State of a target file.
	 */
	[CCode(cname = "int", cprefix = "TGT_", has_type_id = false)]
	[Flags]
	public enum TargetFlags {
		/**
		 * Link exists
		 */
		EXISTS,
		/**
		 * It's really a link
		 */
		ISLNK,
		/**
		 * It's a directory
		 */
		ISDIR,
		/**
		 * Link points to an existing target
		 */
		DEST_EXISTS,
		/**
		 * Link points to a directory
		 */
		DEST_ISDIR,
		/**
		 * Link points under source dir
		 */
		DEST_ENCAP_SRC,
		/**
		 * Link points into existing pkgdir
		 */
		DEST_PKGDIR_EXISTS
	}

	/**
	 * Checks the status of the target file
	 *
	 * If {@link TargetFlags.ISLNK} is set in {@link target_info.flags}, the {@link target_info.link_existing} field is set to the path that the link points to.  If {@link TargetFlags.DEST_ENCAP_SRC} is set in {@link target_info.flags}, the {@link target_info.link_existing_pkg} and {@link target_info.link_existing_pkgdir_relative} fields are set to point to the package and the path relative to the package directory which the link points to, respectively.
	 *
	 *
	 * @param source_directory Encap source directory
	 * @param rel_path relative path to file from Encap target directory
	 * @param target structure for the result
	 * @return if Result.FAIL, errno is set
	 */
	[CCode(cname = "encap_check_target")]
	public Result check_target(string source_directory, string rel_path, out target_info target);

	/**
	 * Error message types
	 */
	[CCode(cname = "uint", cprefix = "EPT_", has_type_id = false)]
	public enum Message {
		/**
		 * Installation of the link or directory corresponding to the file described by {@link source_info} has succeeded.
		 */
		INST_OK,
		/**
		 * Installation of the link or directory corresponding to the file described by {@link source_info} has succeeded, but a pre-existing link was replaced in the process.
		 */
		INST_REPL,
		/**
		 * Installation of the link or directory corresponding to the file described by {@link source_info} has failed due to an Encap conflict.
		 */
		INST_FAIL,
		/**
		 * Installation of the link or directory corresponding to the file described by {@link source_info} has failed due to a system or library call error, and ''errno'' is set to indicate the error.
		 */
		INST_ERROR,
		/**
		 * The link or directory which corresponds to the file described by {@link source_info} is already installed, so no action was necessary.
		 */
		INST_NOOP,
		/**
		 * Removal of the link or directory corresponding to the file described by {@link source_info} has succeeded.
		 */
		REM_OK,
		/**
		 * Removal of the link or directory corresponding to the file described by {@link source_info} has failed due to an Encap conflict.
		 */
		REM_FAIL,
		/**
		 * Removal of the link or directory corresponding to the file described by {@link source_info} has failed due to a system or library call error, and ''errno'' is set to indicate the error.
		 */
		REM_ERROR,
		/**
		 * The link or directory which corresponds to the file described by {@link source_info} is already removed, so no action was necessary.
		 */
		REM_NOOP,
		/**
		 * The link or directory which corresponds to the file described by {@link source_info} is properly installed.
		 */
		CHK_NOOP,
		/**
		 * The link or directory which corresponds to the file described by {@link source_info} is not properly installed.
		 */
		CHK_FAIL,
		/**
		 * Checking of the link or directory corresponding to the file described by {@link source_info} has failed due to a system or library call error, and ''errno'' is set to indicate the error.
		 */
		CHK_ERROR,
		/**
		 * Informational message about the package, such as files that are excluded or prerequisites which are successfully processed.
		 */
		PKG_INFO,
		/**
		 * General package failure, such as a failed prerequisite.
		 */
		PKG_FAIL,
		/**
		 * General package failure due to a system or library call error.  In this case, ''errno'' is set to indicate the error.
		 */
		PKG_ERROR,
		/**
		 * Raw output, such as the output of a package script or the contents of a README file.
		 */
		PKG_RAW,
		/**
		 * The stale Encap link whose path is {@link source_info.target_path} was removed successfully.
		 */
		CLN_OK,
		/**
		 * Informational message during target cleaning, such as files that are excluded.
		 */
		CLN_INFO,
		/**
		 * General target cleaning failure, such as a file directly in target tree or a symlink to somewhere other than the Encap source directory.
		 */
		CLN_FAIL,
		/**
		 * Failed to remove a link or directory while cleaning the target directory due to a system or library call error.  In this case, ''errno'' is set to indicate the error.
		 */
		CLN_ERROR,
		/**
		 * Encountered a valid link while cleaning the Encap target.
		 */
		CLN_NOOP
	}

	/**
	 * Version of ''libencap''
	 */
	[CCode(cname = "libencap_version")]
	public const string VERSION;

	/**
	 * Package information
	 */
	[CCode(cname = "encapinfo_t", destroy_function = "encapinfo_free", has_type_id = false)]
	public struct info {
		/**
		 * Package format
		 */
		[CCode(cname = "ei_pkgfmt")]
		public string format;
		/**
		 * Platform name
		 */
		[CCode(cname = "ei_platform")]
		public string platform;
		/**
		 * One-line description
		 */
		[CCode(cname = "ei_description")]
		public string description;
		/**
		 * Creation date
		 */
		[CCode(cname = "ei_date")]
		public string date;
		/**
		 * Contact address of creator
		 */
		[CCode(cname = "ei_contact")]
		public string contact;
		/**
		 * Exclude list
		 */
		[CCode(cname = "ei_ex_l")]
		public List<string> excludes;
		/**
		 * ''requirelink'' list
		 */
		[CCode(cname = "ei_rl_l")]
		public List<string> required_links;
		/**
		 * ''linkdir'' list
		 */
		[CCode(cname = "ei_ld_l")]
		public List<string> link_dirs;
		/**
		 * ''prereq'' list
		 */
		[CCode(cname = "ei_pr_l")]
		public List<Prerequisite> prereqs;
		/**
		 * ''linkname'' hash
		 */
		[CCode(cname = "ei_ln_h")]
		public Hash<LinkName> link_names;

		/**
		 * Parse an ''encapinfo'' directive.
		 *
		 * @param error_buffer a human-readable error message is written to the buffer.
		 */
		[CCode(cname = "encapinfo_parse_directive", instance_pos = 1.1)]
		public Result parse_directive(string text, uint8[]? error_buffer = null);

		[CCode(cname = "encapinfo_init")]
		public static Result create(out info info);

		/**
		 * Writes the package description data a file.
		 */
		[CCode(cname = "encapinfo_write", instance_pos = -1)]
		public Result write(string file);
	}

	/**
	 * Package action options
	 */
	[CCode(cname = "unsigned long", cprefix = "OPT_", has_type_id = false)]
	[Flags]
	public enum Options {
		/**
		 * Force operations to succeed whenever possible.
		 */
		FORCE,
		/**
		 * Determine what would be done, but do not actually do it.
		 */
		SHOWONLY,
		/**
		 * Use absolute symlinks instead of relative symlinks.
		 */
		ABSLINKS,
		/**
		 * Check prerequisites before installation.
		 */
		PREREQS,
		/**
		 * Run package scripts.
		 */
		RUNSCRIPTS,
		/**
		 * Honor package exclusions.
		 */
		EXCLUDES,
		/**
		 * Run package scripts, but do not attempt to link or remove files.
		 */
		RUNSCRIPTSONLY,
		/**
		 * Remove empty target directories.
		 */
		NUKETARGETDIRS,
		/**
		 * Link files directly from the package directory.
		 */
		PKGDIRLINKS,
		/**
		 * Honor package linkdir directives.
		 */
		LINKDIRS,
		/**
		 * Honor package linkname directives.
		 */
		LINKNAMES,
		/**
		 * Honor ''encap.exclude'' files under the target directory.
		 *
		 * This is used when cleaning the Encap target.
		 * @see target_clean
		 */
		TARGETEXCLUDES,
		DEFAULTS
	}

	/**
	 * Clean stale links out of target tree.
	 *
	 * @param target target directory
	 * @param source source directory
	 * @param message message type
	 * @param print_func ouput function
	 * @param decision function to handle operations
	 * @see DecisionFunction
	 */
	[CCode(cname = "encap_target_clean")]
	public Result target_clean(string target, string source, Message message, PrintFunc print_func, DecisionFunction decision);

	[CCode(cname = "linkname_t", free_function = "", has_type_id = false)]
	[Compact]
	public class LinkName {
		[CCode(cname = "ln_pkgdir_path")]
		public string pkgdir_path;
		[CCode(cname = "ln_newname")]
		public string new_name;
	}

	/**
	 * Package prequisite definition
	 */
	[CCode(cname = "ENCAP_PREREQ", free_function = "", has_type_id = false)]
	public class Prerequisite {
		[CCode(cname = "ep_type")]
		public Type type;
		[CCode(cname = "unsigned short", cprefix = "ENCAP_PREREQ_")]
		[Flags]
		public enum Type {
			NEWER,
			EXACT,
			OLDER,
			ANY,
			RANGEMASK,
			PKGSPEC,
			DIRECTORY,
			REGFILE,
			TYPEMASK
		}
		[CCode(cname = "ep_un.ep_pathname")]
		public string pathname;
		[CCode(cname = "ep_un.ep_pkgspec")]
		public string pkgspec;
	}

	/**
	 * Return the absolute path to what a link points to, based on the absolute path to the link in {@link LinkName}.
	 */
	[CCode(cname = "get_link_dest")]
	public Result get_link_dest(string path, [CCode(array_length_type = "size_t")] uint8[] buffer);

	namespace Platform {
		/**
		 * Check a given package platform for compatibility with the host platform and the specified list of platform suffixes.
		 *
		 * @return 0 if the platform is not compatible, 1 if the platform is compatible, or -1 on failure (and sets ''errno'').
		 */
		[CCode(cname = "encap_platform_compat")]
		public int compat(string pkg_platform, string host_platofrm, List<string>? suffixes = null);

		/**
		 * Split platform name into base and optional tag
		 *
		 * Splits a package's platform name into the base platform name and the platform suffix.
		 */
		[CCode(cname = "encap_platform_split")]
		public Result split(string name, [CCode(array_length_type = "size_t")] uint8[] base_buffer, [CCode(array_length_type = "size_t")] uint8[] other_buffer);

		/**
		 * Returns the "official" platform name.
		 *
		 * Writes the name of the host platform into the buffer provided.
		 */
		[CCode(cname = "encap_platform_name")]
		public unowned string platform_name([CCode(array_length_type = "size_t")] uint8[] buffer);
	}

	/**
	 * Comparison function used to determine order of elements in a list
	 *
	 * @return less than, equal to, or greater than 0 if ''a'' is less than, equal to, or greater than ''b''
	 */
	[CCode(cname = "encap_cmpfunc_t", simple_generics = true, has_target = false, has_type_id = false)]
	public delegate int CompareFunc<T>(T a, T b);

	/**
	 * Free function (for freeing allocated memory in each element)
	 */
	[CCode(cname = "encap_freefunc_t", simple_generics = true, has_target = false, has_type_id = false)]
	public delegate void FreeFunc<T>(owned T data);

	[CCode(cname = "encap_iterate_func_t", simple_generics = true, has_type_id = false)]
	public delegate Result IterateFunc<T>(T data);

	/**
	 * Matching function (used to find elements in a list)
	 */
	[CCode(cname = "encap_matchfunc_t", simple_generics = true, has_target = false, has_type_id = false)]
	public delegate bool MatchFunc<T>(T a, T b);

	/**
	 * Reference to an item in a {@link List}
	 */
	[CCode(cname = "encap_listptr_t", simple_generics = true, destroy_function = "", has_type_id = false)]
	public struct list_item<T> {
		[CCode(cname = "encap_listptr_reset")]
		public list_item();
		/**
		 *  Retrieve the data being pointed to
		 */
		public T data {
			[CCode(cname = "encap_listptr_data", simple_generics = true)]
			get;
		}
	}

	/**
	 * A list of items
	 */
	[CCode(cname = "encap_list_t", simple_generics = true, has_type_id = false)]
	[Compact]
	public class List<T> {
		[CCode(cname = "int", cprefix = "LIST_", has_type_id = false)]
		public enum Format {
		/**
		 * The user-supplied function which determines the ordering of the list.
		 */
		USERFUNC,
		/**
		 * Use the list as a stack.
		 *
		 * New elements are added to the front of the list.
		 */
		STACK,
		/**
		 * Use the list as a queue.
		 *
		 * New elements are added to the end of the list.
		 */
		QUEUE
		}

		/**
		 * Creates a new, empty list
		 */
		[CCode(cname = "encap_list_new")]
		public List(Format format, CompareFunc? func);

		/**
		 * Call a function for every element in a list
		 */
		[CCode(cname = "encap_list_iterate", simple_generics = true)]
		public Result foreach(IterateFunc<T> func);

		/**
		 * Empty the list
		 */
		[CCode(cname = "encap_list_empty", simple_generics = true)]
		public void empty(FreeFunc<T> func);

		/**
		 * Remove and free the entire list
		 */
		[CCode(cname = "encap_list_free", simple_generics = true)]
		[DestorysInstance]
		public void free(FreeFunc<T> func);

		/**
		 * Add an element to the list.
		 *
		 * The position of the new element will be determined by the {@link Format} when list was created.
		 */
		[CCode(cname = "encap_list_add", simple_generics = true)]
		public Result add(owned T item);

		[CCode(cname = "encap_list_del", simple_generics = true)]
		public void remove(ref list_item<T> item);

		[CCode(cname = "encap_list_next", simple_generics = true)]
		public bool next(ref list_item<T> item);

		[CCode(cname = "encap_list_prev", simple_generics = true)]
		public bool prev(ref list_item<T> item);

		/**
		 * Searches for an element
		 *
		 * @param start_item the first item to seach. If null, the beginning of the list is assumed.
		 * @param data the item to search for
		 * @param func the function which determines if two items are equal. If null, a matching function for strings is used.
		 */
		[CCode(cname = "encap_list_search", simple_generics = true)]
		public bool search(ref list_item<T> start_item, T data, MatchFunc<T>? func);

		public uint size {
			[CCode(cname = "encap_list_nents")]
			get;
		}

		/**
		 * Tokenize a string and add the resulting tokens to the list.
		 *
		 * @param str the string to be tokenized.
		 * @param delimiters the characters to be used as delimiters
		 */
		[CCode(cname = "encap_list_add_str")]
		public static Result add_string(List<string> list, string str, string delimiters);
	}

	/**
	 * A string matching function
	 */
	[CCode(cname = "encap_str_match")]
	public int str_match(string a, string b);

	/**
	 * Hashing function (determines which bucket the given key hashes into)
	 *
	 * @param data the key to hash
	 * @param the total number of buckets
	 * @return the bucket number
	 */
	[CCode(cname = "encap_hashfunc_t", simple_generics = true, has_target = false, has_type_id = false)]
	public delegate uint HashFunc<T>(T data, uint buckets);

	/**
	 * Reference to an item in a {@link Hash}
	 */
	[CCode(cname = "encap_hashptr_t", simple_generics = true, destroy_function = "", has_type_id = false)]
	public struct hash_item<T> {
		[CCode(cname = "encap_hashptr_reset")]
		public hash_item();
		public T data {
			[CCode(cname = "encap_hashptr_data", simple_generics = true)]
			get;
		}
		int bucket;
		list_item<T> node;
	}

	/**
	 * Default hash function, optimized for 7-bit strings
	 */
	[CCode(cname = "encap_str_hashfunc")]
	public uint str_hash(string data, uint buckets);

	/**
	 * A hashtable
	 */
	[CCode(cname = "encap_hash_t", has_type_id = false)]
	[Compact]
	public class Hash<T> {
		/**
		 * Creates a new hash
		 *
		 * @param size the number of buckets
		 * @param func the hashing function to use. If null, a default hash function designed for 7-bit ASCII strings is used.
		 */
		[CCode(cname = "encap_hash_new")]
		public Hash(int size, HashFunc? func);

		public uint size {
			[CCode(cname = "encap_hash_nents")]
			get;
		}

		/**
		 * Empty the hash
		 */
		[CCode(cname = "encap_hash_empty")]
		public void empty(FreeFunc func);

		/**
		 * Delete all the encap_nodes of the hash and clean up
		 */
		[CCode(cname = "encap_hash_free")]
		[DestorysInstance]
		public void free(FreeFunc func);

		/**
		 * Allow iteration though the hash.
		 */
		[CCode(cname = "encap_hash_next")]
		public bool next(ref hash_item<T> item);

		/**
		 * Searches iteratively through the hash until it finds a node whose contents match.
		 *
		 * @param start_item searching begins at this bucket.
		 */
		[CCode(cname = "encap_hash_search", simple_generics = true)]
		public bool search(ref hash_item<T> start_item, T data, MatchFunc func);

		/**
		 * Using the hash function, determine which bucket the data should be in, and searches
only that bucket for a matching node.
		 */
		[CCode(cname = "encap_hash_getkey", simple_generics = true)]
		public bool get_key(ref hash_item<T> start_item, T data, MatchFunc func);

		/**
		 * Insert data
		 */
		[CCode(cname = "encap_hash_add", simple_generics = true)]
		public Result add(owned T data);

		/**
		 * Delete an entry
		 */
		[CCode(cname = "encap_hash_del")]
		public bool remove(ref hash_item<T> item);
	}
}

