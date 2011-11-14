/*
 * libgit2 Vala binding
 *
 * Homepage: http://libgit2.github.com/
 * VAPI Homepage: https://github.com/apmasell/vapis/blob/master/libgit2.vapi
 * VAPI Maintainer: Andre Masella <andre@masella.name>
 *
 * This file is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License, version 2,
 * as published by the Free Software Foundation.
 *
 * In addition to the permissions in the GNU General Public License,
 * the authors give you unlimited permission to link the compiled
 * version of this file into combinations with other programs,
 * and to distribute those combinations without any restriction
 * coming from the use of this file.  (The General Public License
 * restrictions do apply in other respects; for example, they cover
 * modification of the file, and distribution when not linked into
 * a combined executable.)
 *
 * This file is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */
[CCode(cheader_filename = "git2.h")]
namespace Git {
	namespace Version {
		[CCode(cname = "LIBGIT2_VERSION")]
		public const string VERSION;
		[CCode(cname = "LIBGIT2_VER_MAJOR")]
		public const int MAJOR;
		[CCode(cname = "LIBGIT2_VER_MINOR")]
		public const int MINOR;
		[CCode(cname = "LIBGIT2_VER_REVISION")]
		public const int REVISION;
		/**
		 * Return the version of the libgit2 library
		 * being currently used.
		 *
		 * @param major Store the major version number
		 * @param minor Store the minor version number
		 * @param rev Store the revision (patch) number
		 */
		[CCode(cname = "git_libgit2_version")]
		public void get_version(out int major, out int minor, out int rev);
	}

	/**
	 * The separator used in path list strings (ie like in the PATH
	 * environment variable). A semi-colon ";" is used on Windows, and
	 * a colon ":" for all other systems.
	 */
	[CCode(cname = "GIT_PATH_LIST_SEPARATOR")]
	public const char PATH_LIST_SEPARATOR;

	/**
	 * The maximum length of a git valid git path.
	 */
	[CCode(cname = "GIT_PATH_MAX")]
	public const int PATH_MAX;

	[CCode(cname = "git_error", cprefix = "GIT_E")]
	public enum Error {
		[CCode(cname = "GIT_SUCCESS")]
		SUCCESS,
		[CCode(cname = "GIT_ERROR")]
		ERROR,
		/**
		 * Input was not a properly formatted Git object id.
		 */
		[CCode(cname = "GIT_ENOTOID")]
		NOTID,
		/**
		 * Input does not exist in the scope searched.
		 */
		NOTFOUND,
		/**
		 * Not enough space available.
		 */
		NOMEM,
		/**
		 * Consult the OS error information.
		 */
		OSERR,
		/**
		 * The specified object is of invalid type
		 */
		OBJTYPE,
		/**
		 * The specified repository is invalid
		 */
		NOTAREPO,
		/**
		 * The object type is invalid or doesn't match
		 */
		INVALIDTYPE,
		/**
		 * The object cannot be written because it's missing internal data
		 */
		MISSINGOBJDATA,
		/**
		 * The packfile for the ODB is corrupted
		 */
		PACKCORRUPTED,
		/**
		 * Failed to acquire or release a file lock
		 */
		FLOCKFAIL,
		/**
		 * The Z library failed to inflate/deflate an object's data
		 */
		ZLIB,
		/**
		 * The queried object is currently busy
		 */
		BUSY,
		/**
		 * The index file is not backed up by an existing repository
		 */
		BAREINDEX,
		/**
		 * The name of the reference is not valid
		 */
		INVALIDREFNAME,
		/**
		 * The specified reference has its data corrupted
		 */
		REFCORRUPTED,
		/**
		 * The specified symbolic reference is too deeply nested
		 */
		TOONESTEDSYMREF,
		/**
		 * The pack-refs file is either corrupted or its format is not currently supported
		 */
		PACKEDREFSCORRUPTED,
		/**
		 * The path is invalid
		 */
		INVALIDPATH,
		/**
		 * The revision walker is empty; there are no more commits left to iterate
		 */
		REVWALKOVER,
		/**
		 * The state of the reference is not valid
		 */
		INVALIDREFSTATE,
		/**
		 * This feature has not been implemented yet
		 */
		NOTIMPLEMENTED,
		/**
		 * A reference with this name already exists
		 */
		EXISTS,
		/**
		 * The given integer literal is too large to be parsed
		 */
		OVERFLOW,
		/**
		 * The given literal is not a valid number
		 */
		NOTNUM,
		/**
		 * Streaming error
		 */
		STREAM,
		/**
		 * invalid arguments to function
		 */
		INVALIDARGS,
		/**
		 * The specified object has its data corrupted
		 */
		OBJCORRUPTED,
		/**
		 * The given short id is ambiguous
		 */
		[CCode(cname = "GIT_EAMBIGUOUSOIDPREFIX")]
		AMBIGUOUSIDPREFIX,
		/**
		 * Skip and passthrough the given ODB backend
		 */
		PASSTHROUGH,
		/**
		 * The path pattern and string did not match
		 */
		NOMATCH,
		/**
		 *  The buffer is too short to satisfy the request
		 */
		SHORTBUFFER;
		/**
		 * Return a detailed error string with the latest error
		 * that occurred in the library.
		 * @return a string explaining the error
		 */
		[CCode(cname = "git_lasterror")]
		public static unowned string get_last();

		/**
		 * Get a string description for a given error code.
		 * @return a string explaining the error code
		 */
		[CCode(cname = "git_strerror")]
		[Deprecated]
		public unowned string to_string();

		/**
		 * Clear the latest library error
		 */
		[CCode(cname = "git_clearerror")]
		public static void clear();
	}

	/**
	 * Basic type (loose or packed) of any Git object.
	 */
	[CCode(cname = "git_otype", cprefix = "GIT_OBJ_")]
	public enum ObjectType {
		/**
		 * Object can be any of the following
		 */
		ANY,
		/**
		 * Object is invalid.
		 */
		BAD,
		/**
		 * Reserved for future use.
		 */
		_EXT1,
		/**
		 * A commit object.
		 */
		COMMIT,
		/**
		 * A tree (directory listing) object.
		 */
		TREE,
		/**
		 * A file revision object.
		 */
		BLOB,
		/**
		 * An annotated tag object.
		 */
		TAG,
		/**
		 * Reserved for future use.
		 */
		_EXT2,
		/**
		 * A delta, base is given by an offset.
		 */
		OFS_DELTA,
		/**
		 * A delta, base is given by object id.
		 */
		REF_DELTA;
		/**
		 * Convert an object type to its string representation.
		 * @return the corresponding string representation.
		 */
		[CCode(cname = "git_object_type2string")]
		public unowned string to_string();

		/**
		 * Convert a string object type representation to its ObjectType.
		 *
		 * @param str the string to convert.
		 * @return the corresponding object type.
		 */
		[CCode(cname = "git_object_string2type")]
		public static ObjectType from_string(string str);

		/**
		 * Determine if the given this type is a valid loose object type.
		 *
		 * @return true if the type represents a valid loose object type,
		 * false otherwise.
		 */
		[CCode(cname = "git_object_typeisloose")]
		public bool is_loose();

		/**
		 * Get the size in bytes for the structure which
		 * acts as an in-memory representation of any given
		 * object type.
		 */
		[CCode(cname = "git_object__size")]
		public size_t get_size();
	}

	/**
	 * An open object database handle.
	 */
	[CCode(cname = "git_odb", free_function = "git_odb_close")]
	[Compact]
	public class Database {
		/**
		 * Create a new object database with no backends.
		 *
		 * Before the ODB can be used for read/writing, a custom database
		 * backend must be manually added using {@link Database.add_backend}.
		 *
		 * @param db location to store the database pointer, if opened.
		 *            Set to null if the open failed.
		 */
		[CCode(cname = "git_odb_new")]
		public static Error create(out Database ? db);

		/**
		 * Create a new object database and automatically add
		 * the two default backends.
		 *
		 * Automatically added are:
		 *	{@link Backend.create_loose}: read and write loose object files
		 *		from disk, assuming `objects_dir` as the Objects folder
		 *
		 *	{@link Backend.create_pack}: read objects from packfiles,
		 *		assuming `objects_dir` as the Objects folder which
		 *		contains a 'pack/' folder with the corresponding data
		 *
		 * @param db location to store the database pointer, if opened.
		 *            Set to null if the open failed.
		 * @param objects_dir path of the backends' "objects" directory.
		 */
		[CCode(cname = "git_odb_open")]
		public static Error open(out Database db, string objects_dir);

		/**
		 * Add a custom backend to an existing Object DB
		 *
		 * The backends are checked in relative ordering, based on the
		 * value of the `priority` parameter.
		 * @param backend the backend instance
		 * @param priority Value for ordering the backends queue
		 */
		[CCode(cname = "git_odb_add_backend")]
		public Error add_backend(owned Backend backend, int priority);

		/**
		 * Add a custom backend to an existing Object DB; this
		 * backend will work as an alternate.
		 *
		 * Alternate backends are always checked for objects ''after''
		 * all the main backends have been exhausted.
		 *
		 * The backends are checked in relative ordering, based on the
		 * value of the `priority` parameter.
		 *
		 * Writing is disabled on alternate backends.
		 *
		 * @param backend the backend instance
		 * @param priority Value for ordering the backends queue
		 */
		[CCode(cname = "git_odb_add_alternate")]
		public Error add_alternate(owned Backend backend, int priority);

		/**
		 * Read an object from the database.
		 *
		 * This method queries all available ODB backends
		 * trying to read the given id.
		 *
		 * @param obj pointer where to store the read object
		 * @param id identity of the object to read.
		 */
		[CCode(cname = "git_odb_read", instance_pos = 1.2)]
		public Error read(out DbObject obj, object_id id);

		/**
		 * Read an object from the database, given a prefix
		 * of its identifier.
		 *
		 * This method queries all available ODB backends
		 * trying to match the 'len' first hexadecimal
		 * characters of the 'short_id'.
		 * The remaining ({@link object_id.HEX_SIZE}-len)*4 bits of
		 * 'short_id' must be 0s.
		 * 'len' must be at least {@link object_id.MIN_PREFIX_LENGTH},
		 * and the prefix must be long enough to identify
		 * a unique object in all the backends; the
		 * method will fail otherwise.
		 *
		 * The returned object is reference counted and
		 * internally cached, so it should be closed
		 * by the user once it's no longer in use.
		 *
		 * @param obj pointer where to store the read object
		 * @param short_id a prefix of the id of the object to read.
		 * @param len the length of the prefix
		 */
		[CCode(cname = "git_odb_read_prefix", instance_pos = 1.2)]
		public Error git_odb_read_prefix(out DbObject obj, object_id short_id, uint len);

		/**
		 * Read the header of an object from the database, without
		 * reading its full contents.
		 *
		 * The header includes the length and the type of an object.
		 *
		 * Note that most backends do not support reading only the header
		 * of an object, so the whole object will be read and then the
		 * header will be returned.
		 *
		 * @param len the length of the object
		 * @param type the type of the object
		 * @param id identity of the object to read.
		 */
		[CCode(cname = "git_odb_read_header", instance_pos = 2.3)]
		public Error read_header(out size_t len, out ObjectType type, object_id id);

		/**
		 * Determine if the given object can be found in the object database.
		 *
		 * @param id the object to search for.
		 */
		[CCode(cname = "git_odb_exists")]
		public bool contains(object_id id);

		/**
		 * Write an object directly into the ODB
		 *
		 * This method writes a full object straight into the ODB.
		 * For most cases, it is preferred to write objects through a write
		 * stream, which is both faster and less memory intensive, specially
		 * for big objects.
		 *
		 * This method is provided for compatibility with custom backends
		 * which are not able to support streaming writes
		 *
		 * @param id pointer to store the id result of the write
		 * @param data buffer with the data to store
		 * @param type type of the data to store
		 */
		[CCode(cname = "git_odb_write", instance_pos = 1.2)]
		public Error git_odb_write(object_id id, [CCode(array_length_Type = "size_t")] uint8[] data, ObjectType type);

		/**
		 * Open a stream to write an object into the ODB
		 *
		 * The type and final length of the object must be specified
		 * when opening the stream.
		 *
		 * The returned stream will be of type {@link StreamMode.WRONLY} and
		 * will have the following methods:
		 *
		 *		- stream->write: write `n` bytes into the stream
		 *		- stream->finalize_write: close the stream and store the object in
		 *			the odb
		 *		- stream->free: free the stream
		 *
		 * The streaming write won't be effective until `stream->finalize_write`
		 * is called and returns without an error
		 *
		 * @param stream where to store the stream
		 * @param size final size of the object that will be written
		 * @param type type of the object that will be written
		 */
		[CCode(cname = "git_odb_open_wstream", instance_pos = 1.2)]
		public Error open_wstream(out Stream stream, size_t size, ObjectType type);

		/**
		 * Open a stream to read an object from the ODB
		 *
		 * Note that most backends do ''not'' support streaming reads
		 * because they store their objects as compressed/delta'ed blobs.
		 *
		 * It's recommended to use {@link Database.read} instead, which is
		 * assured to work on all backends.
		 *
		 * The returned stream will be of type {@link StreamMode.RDONLY} and
		 * will have the following methods:
		 *
		 *		- stream->read: read `n` bytes from the stream
		 *		- stream->free: free the stream
		 *
		 * @param stream where to store the stream
		 * @param id id of the object the stream will read from
		 */
		[CCode(cname = "git_odb_open_rstream")]
		public Error open_rstream(out Stream stream, object_id id);
	}

	/**
	 * An object read from the database
	 */
	[CCode(cname = "git_odb_object", free_function = "git_odb_object_close")]
	[Compact]
	public class DbObject {

		/**
		 * The id of an ODB object
		 *
		 * This is the id from which the object was read from
		 */
		public object_id? id {
			[CCode(cname = "git_odb_object_id")]
			get;
		}

		/**
		 * The data of an ODB object
		 *
		 * This is the uncompressed, raw data as read from the ODB,
		 * without the leading header.
		 */
		public uint8[] data {
			[CCode(cname = "git_odb_object_data", array_length_cexpr = "git_odb_object_size")]
			get;
		}

		/**
		 * The type of an ODB object
		 */
		public ObjectType type {
			[CCode(cname = "git_odb_object_type")]
			get;
		}
	}

	/**
	 * A custom backend in an ODB
	 */
	[CCode(cname = "git_odb_backend")]
	[Compact]
	public class Backend {
		public unowned Database odb;

		public ReadHandler read;

		public ReadPrefixHandler read_prefix;

		public ReadHeaderHandler read_header;

		public WriteHandler write;

		public WriteStreamHandler writestream;

		public ReadHandler readstream;

		public ReadStreamHandler exists;

		public FreeHandler free;

		[CCode(cname = "git_odb_backend_pack")]
		public static Error create_pack(out Backend backend, string objects_dir);
		[CCode(cname = "git_odb_backend_loose")]
		public static Error create_loose(out Backend backend, string objects_dir);

		[CCode(has_target = false)]
		public delegate int ReadHandler([CCode(array_length_type = "size_t")] out uint8[] data, out ObjectType type, Backend self, object_id id);

		/**
		 * Find a unique object given a prefix
		 *
		 * The id given must be so that the remaining
		 * ({@link object_id.HEX_SIZE} - len)*4 bits are 0s.
		 */
		[CCode(has_target = false)]
		public delegate int ReadPrefixHandler(out object_id id, [CCode(array_length_type = "size_t")] out uint8[] data, out ObjectType type, Backend self, object_id id_prefix, uint len);

		[CCode(has_target = false)]
		public delegate int ReadHeaderHandler(out size_t size, out ObjectType type, Backend self, object_id id);

		[CCode(has_target = false)]
		public delegate int WriteHandler(out object_id id, Backend self, [CCode(array_length_type = "size_t")] out uint8[] data, ObjectType type);

		[CCode(has_target = false)]
		public delegate int WriteStreamHandler(out Stream stream, Backend self, size_t size, ObjectType type);

		[CCode(has_target = false)]
		public delegate int ReadStreamHandler(out Stream stream, Backend self, object_id id);

		[CCode(has_target = false)]
		public delegate int ExistsHandler(Backend self, object_id id);

		[CCode(has_target = false)]
		public delegate void FreeHandler(owned Backend self);
	}

	/**
	 * Streaming mode
	 */
	[CCode(cname = "git_odb_streammode", cprefix = "GIT_STREAM_")]
	public enum StreamMode {
		RDONLY,
		WRONLY,
		RW
	}

	/**
	 * A stream to read/write from the ODB
	 */
	[CCode(cname = "git_odb_stream")]
	[Compact]
	public class Stream {
		public unowned Backend backend;
		public StreamMode mode;

		public ReadHandler read;

		public WriteHandler write;

		public FinalizeWriteHandler finalize_write;

		public FreeHandler free;

		[CCode(has_target = false)]
		public delegate int ReadHandler(Stream stream, [CCode(array_length_type = "size_t")] uint8[] buffer);

		[CCode(has_target = false)]
		public delegate int WriteHandler(Stream stream, [CCode(array_length_type = "size_t")] uint8[] buffer);

		[CCode(has_target = false)]
		public delegate int FinalizeWriteHandler(out object_id oid, Stream stream);

		[CCode(has_target = false)]
		public delegate void FreeHandler(owned Stream stream);
	}

	/**
	 * Representation of an existing git repository,
	 * including all its object contents
	 */
	[CCode(cname = "git_repository", free_function = "git_repository_free")]
	[Compact]
	public class Repository {

		/**
		 * Open a git repository.
		 *
		 * The path argument must point to an existing git repository
		 * folder. The repository can be normal (having a .git directory)
		 * or bare (having objects, index, and HEAD directly).
		 * The method will automatically detect if path is a normal
		 * or bare repository or fail is path is neither.
		 *
		 * @param repository the repo which will be opened
		 * @param path the path to the repository
		 */
		[CCode(cname = "git_repository_open")]
		public static Error open(out Repository ? repository, string path);

		/**
		 * Open a git repository by manually specifying all its paths
		 *
		 * @param repository the repo which will be opened
		 *
		 * @param git_dir The full path to the repository folder
		 *		e.g. a '.git' folder for live repos, any folder for bare
		 *		Equivalent to $GIT_DIR.
		 *
		 * @param git_object_directory The full path to the ODB folder.
		 *		the folder where all the loose and packed objects are stored
		 *		Equivalent to $GIT_OBJECT_DIRECTORY.
		 *		If null, "$GIT_DIR/objects/" is assumed.
		 *
		 * @param git_index_file The full path to the index (dircache) file
		 *		Equivalent to $GIT_INDEX_FILE.
		 *		If null, "$GIT_DIR/index" is assumed.
		 *
		 * @param git_work_tree The full path to the working tree of the repository,
		 *		if the repository is not bare.
		 *		Equivalent to $GIT_WORK_TREE.
		 *		If null, the repository is assumed to be bare.
		 */
		[CCode(cname = "git_repository_open2")]
		public static Error  open_detailed(out Repository repository, string dir, string ? object_directory, string ? index_file, string ? work_tree);

		/**
		 * Open a git repository by manually specifying its paths and
		 * the object database it will use.
		 *
		 * @param repository pointer to the repo which will be opened
		 *
		 * @param git_dir The full path to the repository folder
		 *		e.g. a '.git' folder for live repos, any folder for bare
		 *		Equivalent to $GIT_DIR.
		 *
		 * @param object_database A pointer to a git_odb created & initialized
		 *		by the user (e.g. with custom backends).
		 *
		 * @param git_index_file The full path to the index (dircache) file
		 *		Equivalent to $GIT_INDEX_FILE.
		 *		If null, "$GIT_DIR/index" is assumed.
		 *
		 * @param git_work_tree The full path to the working tree of the repository,
		 *		if the repository is not bare.
		 *		Equivalent to $GIT_WORK_TREE.
		 *		If null, the repository is assumed to be bare.
		 *
		 * @return 0 on success; error code otherwise
		 */

		[CCode(cname = "git_repository_open3")]
		public static Error open_with_db(out Repository repository, string dir, owned Database object_database, string ? index_file, string ? work_tree);

		/**
		 * Look for a git repository and copy its path in the given buffer. The lookup start
		 * from base_path and walk across parent directories if nothing has been found. The
		 * lookup ends when the first repository is found, or when reaching a directory
		 * referenced in ceiling_dirs or when the filesystem changes (in case across_fs
		 * is true).
		 *
		 * The method will automatically detect if the repository is bare (if there is
		 * a repository).
		 *
		 * @param repository_path The buffer which will contain the found path.
		 *
		 * @param start_path The base path where the lookup starts.
		 *
		 * @param across_fs If true, then the lookup will not stop when a filesystem device change
		 * is detected while exploring parent directories.
		 *
		 * @param ceiling_dirs A {@link PATH_LIST_SEPARATOR} separated list of absolute symbolic link
		 * free paths. The lookup will stop when any of this paths is reached. Note that the
		 * lookup always performs on start_path no matter start_path appears in ceiling_dirs
		 * ceiling_dirs might be null (which is equivalent to an empty string)
		 *
		 * @return 0 on success; error code otherwise
		 */
		public static Error discover([CCode(array_length_type = "size_t")] char[] repository_path, string start_path, bool across_fs = true, string ? ceiling_dirs = null);

		/**
		 * Get the object database behind a Git repository
		 */
		public Database database {
			[CCode(cname = "git_repository_database")]
			get;
		}

		/**
		 * Open the Index file of a Git repository
		 *
		 * This returns a new and unique index object representing the
		 * active index for the repository.
		 *
		 * This method may be called more than once (e.g., on different threads).
		 *
		 * Each returned index object is independent and suffers no race
		 * conditions: synchronization is done at the FS level.
		 *
		 * @param index Pointer where to store the index
		 */
		[CCode(cname = "git_repository_index", instance_pos = -1)]
		public Error get_index(out Index index);

		/**
		 * Creates a new Git repository in the given folder.
		 *
		 * @param repo the repo which will be created or reinitialized
		 * @param path the path to the repository
		 * @param is_bare if true, a Git repository without a working directory is created
		 *		at the pointed path. If false, provided path will be considered as the working
		 *		directory into which the .git directory will be created.
		 */
		[CCode(cname = "git_repository_init")]
		public Error init(out Repository repo, string path, bool is_bare);

		/**
		 * Check if a repository's HEAD is detached
		 *
		 * A repository's HEAD is detached when it points directly to a commit
		 * instead of a branch.
		 *
		 * @return 1 if HEAD is detached, 0 if i'ts not; error code if there
		 * was an error.
		 */
		[CCode(cname = "git_repository_head_detached")]
		public int is_head_detached();

		/**
		 * Check if the current branch is an orphan
		 *
		 * An orphan branch is one named from HEAD but which doesn't exist in
		 * the refs namespace, because it doesn't have any commit to point to.
		 *
		 * @return 1 if the current branch is an orphan, 0 if it's not; error
		 * code if therewas an error
		 */
		[CCode(cname = "git_repository_head_orphan")]
		public int is_head_orphan();

		/**
		 * Check if a repository is empty
		 *
		 * An empty repository has just been initialized and contains
		 * no commits.
		 *
		 * @return 1 if the repository is empty, 0 if it isn't, error code
		 * if the repository is corrupted
		 */
		[CCode(cname = "git_repository_is_empty")]
		public int is_empty();

		/**
		 * Get one of the paths to the repository
		 *
		 * @param type the path to return
		 * @return absolute path of the requested type
		 */
		[CCode(cname = "git_repository_path")]
		public unowned string get_path(PathType type);

		/**
		 * Check if a repository is bare
		 */
		[CCode(cname = "git_repository_is_bare")]
		public bool is_bare();

		/**
		 * Retrieve the relevant configuration for a repository
		 *
		 * By default he returned `git_config` instance contains a single
		 * configuration file, the `.gitconfig' file that may be found
		 * inside the repository.
		 *
		 * The resulting `git_config` instance will query the files in the following
		 * order:
		 *
		 *	* Repository configuration file
		 *	* User configuration file
		 *	* System configuration file
		 *
		 * The method will fail if any of the passed config files cannot be
		 * found or accessed.
		 *
		 * @param config the repository's configuration
		 * @param user_config_path Path to the user config file
		 * If not null, the given config
		 * file will be also included in the configuration set. On most UNIX
		 * systems, this file may be found on `$HOME/.gitconfig`.
		 * @param system_config_path Path to the system-wide config file
		 * If not null, the given config
		 * file will be also included in the configuration set. On most UNIX
		 * systems, this file may be found on `$PREFIX/etc/gitconfig`.
		 */
		[CCode(cname = "git_repository_config", instance_pos = 1.2)]
		public Error get_config(out Config config, string ? user_config_path = null, string ? system_config_path = null);

		/**
		 * Allocate a new revision walker to iterate through a repo.
		 *
		 * This revision walker uses a custom memory pool and an internal
		 * commit cache, so it is relatively expensive to allocate.
		 *
		 * For maximum performance, this revision walker should be
		 * reused for different walks.
		 *
		 * This revision walker is ''not'' thread safe: it may only be
		 * used to walk a repository on a single thread; however,
		 * it is possible to have several revision walkers in
		 * several different threads walking the same repository.
		 *
		 * @param walker the new revision walker
		 * @return 0 on success; error code otherwise
		 */
		[CCode(cname = "git_revwalk_new", instance_pos = -1)]
		public Error get_walker(out RevisionWalker walker);

		/**
		 * Lookup a reference by its name in a repository.
		 *
		 * @param reference the looked-up reference
		 * @param name the long name for the reference (e.g., HEAD, ref/heads/master, refs/tags/v0.1.0, ...)
		 */
		[CCode(cname = "git_reference_lookup", instance_pos = 1.2)]
		public Error lookup_reference(out unowned Reference reference, string name);

		/**
		 * Perform an operation on each reference in the repository
		 *
		 * The processed references may be filtered by type, or using
		 * a bitwise OR of several types. Use the magic value
		 * {@link ReferenceType.LISTALL} to obtain all references, including
		 * packed ones.
		 *
		 * @param list_flags Filtering flags for the reference
		 *		listing.
		 * @param callback Function which will be called for every listed ref
		 */
		[CCode(cname = "git_reference_foreach")]
		public Error for_each_reference(ReferenceType list_flags, ReferenceCallback function);

		/**
		 * Create a new symbolic reference.
		 *
		 * The reference will be created in the repository and written
		 * to the disk.
		 *
		 * @param ref_out the newly created reference
		 * @param name The name of the reference
		 * @param target The target of the reference
		 * @param force Overwrite existing references
		 */
		[CCode(cname = "git_reference_create_symbolic", instance_pos = 1.2)]
		public Error create_symbolic_reference(out unowned Reference reference, string name, string target, bool force);

		/**
		 * Create a new object id reference.
		 *
		 * The reference will be created in the repository and written
		 * to the disk.
		 *
		 * @param ref the newly created reference
		 * @param name The name of the reference
		 * @param id The object id pointed to by the reference.
		 * @param force Overwrite existing references
		 */
		[CCode(cname = "git_reference_create_oid", instance_pos = 1.2)]
		public Error create_reference(out unowned Reference reference, string name, object_id id, bool force);

		/**
		 * Pack all the loose references in the repository
		 *
		 * This method will load into the cache all the loose
		 * references on the repository and update the
		 * `packed-refs` file with them.
		 *
		 * Once the `packed-refs` file has been written properly,
		 * the loose references will be removed from disk.
		 *
		 * WARNING: calling this method may invalidate any existing
		 * references previously loaded on the cache.
		 */
		[CCode(cname = "git_reference_packall")]
		public Error pack_all_references();

		/**
		 * Fill a list with all the references that can be found
		 * in a repository.
		 *
		 * The listed references may be filtered by type, or using
		 * a bitwise OR of several types. Use the magic value
		 * {@link ReferenceType.LISTALL} to obtain all references, including
		 * packed ones.
		 *
		 * @param array where the reference names will be stored
		 * @param list_flags Filtering flags for the reference
		 *		listing.
		 */
		[CCode(cname = "git_reference_listall", instance_pos = 1.2)]
		public Error list_all(out string_array array, ReferenceType list_flags);

		/**
		 * Lookup a reference to one of the objects in a repostory.
		 *
		 * The 'type' parameter must match the type of the object
		 * in the odb; the method will fail otherwise.
		 * The special value {@link ObjectType.ANY} may be passed to let
		 * the method guess the object's type.
		 *
		 * @param object the looked-up object
		 * @param id the unique identifier for the object
		 * @param type the type of the object
		 * @return a reference to the object
		 */
		[CCode(cname = "git_object_lookup", instance_pos = 1.2)]
		public Error lookup_object(out Object object, object_id id, ObjectType type);

		/**
		 * Lookup a reference to one of the objects in a repostory,
		 * given a prefix of its identifier (short id).
		 *
		 * The object obtained will be so that its identifier
		 * matches the first 'len' hexadecimal characters
		 * (packets of 4 bits) of the given 'id'.
		 * 'len' must be at least {@link object_id.MIN_PREFIX_LENGTH}, and
		 * long enough to identify a unique object matching
		 * the prefix; otherwise the method will fail.
		 *
		 * The 'type' parameter must match the type of the object
		 * in the odb; the method will fail otherwise.
		 * The special value {@link ObjectType.ANY} may be passed to let
		 * the method guess the object's type.
		 *
		 * @param object where to store the looked-up object
		 * @param id a short identifier for the object
		 * @param len the length of the short identifier
		 * @param type the type of the object
		 */
		[CCode(cname = "git_object_lookup_prefix", instance_pos = 1.2)]
		public Error lookup_object_by_prefix(out Object object_out, object_id id, uint len, ObjectType type);

		/**
		 * Lookup a blob object from a repository.
		 *
		 * @param blob the looked up blob
		 * @param id identity of the blob to locate.
		 */
		[CCode(cname = "git_blob_lookup", instance_pos = 1.2)]
		public Error lookup_blob(out Blob blob, object_id id);

		/**
		 * Lookup a blob object from a repository,
		 * given a prefix of its identifier (short id).
		 *
		 * @see lookup_object_by_prefix
		 *
		 * @param blob the looked up blob
		 * @param id identity of the blob to locate.
		 * @param len the length of the short identifier
		 */
		[CCode(cname = "git_blob_lookup_prefix", instance_pos = 1.2)]
		public Error lookup_blob_by_prefix(out Blob blob, object_id id, uint len);

		/**
		 * Read a file from the working folder of a repository
		 * and write it to the object database as a loose blob
		 *
		 * This repository cannot be bare.
		 *
		 * @param id return the id of the written blob
		 * @param path file from which the blob will be created,
		 *	relative to the repository's working dir
		 */
		[CCode(cname = "git_blob_create_fromfile", instance_pos = 1.2)]
		public Error create_blob_from_file(object_id id, string path);

		/**
		 * Write an in-memory buffer to the ODB as a blob
		 *
		 * @param id return the id of the written blob
		 * @param buffer data to be written into the blob
		 */
		[CCode(cname = "git_blob_create_frombuffer", instance_pos = 1.2)]
		public Error create_blob_from_buffer(object_id id, [CCode(array_length_type = "size_t")] uint8[] buffer);

		/**
		 * Lookup a commit object from a repository.
		 *
		 * @param commit the looked up commit
		 * @param id identity of the commit to locate.  If the object is
		 *        an annotated tag it will be peeled back to the commit.
		 */
		[CCode(cname = "git_commit_lookup", instance_pos = 1.2)]
		public Error lookup_commit(out Commit commit, object_id id);

		/**
		 * Lookup a commit object from a repository,
		 * given a prefix of its identifier (short id).
		 *
		 * @see lookup_object_by_prefix
		 *
		 * @param commit the looked up commit
		 * @param id identity of the commit to locate.  If the object is
		 *        an annotated tag it will be peeled back to the commit.
		 * @param len the length of the short identifier
		 */
		[CCode(cname = "git_commit_lookup_prefix", instance_pos = 1.2)]
		public Error lookup_commit_by_prefix(out Commit commit, object_id id, uint len);

		/**
		 * Create a new commit in the repository using {@link Object}
		 * instances as parameters.
		 *
		 * @param id where to store the id of the
		 *	newly created commit
		 *
		 * @param update_ref If not null, name of the reference that
		 *	will be updated to point to this commit. If the reference
		 *	is not direct, it will be resolved to a direct reference.
		 *	Use "HEAD" to update the HEAD of the current branch and
		 *	make it point to this commit
		 *
		 * @param author Signature representing the author and the authory
		 *	time of this commit
		 *
		 * @param committer Signature representing the committer and the
		 *  commit time of this commit
		 *
		 * @param message_encoding The encoding for the message in the
		 * commit, represented with a standard encoding name.
		 * E.g. "UTF-8". If null, no encoding header is written and
		 * UTF-8 is assumed.
		 *
		 * @param message Full message for this commit
		 *
		 * @param tree The tree that will be used as the tree for the commit.
		 * This tree object must also be owned by this repository.
		 *
		 * @param parents The commits that will be used as the parents for this commit.
		 * This array may be empty for the root commit. All the
		 * given commits must be owned by this repository.
		 */
		[CCode(cname = "git_commit_create", instance_pos = 1.2)]
		public Error create_commit(object_id id, string ? update_ref, Signature author, Signature committer, string ? message_encoding, string message, Tree tree, [CCode(array_length_pos = 7.8)] Commit[] parents);

		/**
		 * Create a new commit in the repository using a variable
		 * argument list.
		 *
		 * The parents for the commit are specified as a variable
		 * arguments. Note that this
		 * is a convenience method which may not be safe to export
		 * for certain languages or compilers
		 *
		 * All other parameters remain the same
		 *
		 * @see create_commit
		 */
		[CCode(cname = "git_commit_create_v", instance_pos = 1.2)]
		public Error create_commit_v(object_id id, string update_ref, Signature author, Signature committer, string message_encoding, string message, Tree tree, int parent_count, ...);

		/**
		 * Lookup a tag object from the repository.
		 *
		 * @param tag pointer to the looked up tag
		 * @param id identity of the tag to locate.
		 */
		[CCode(cname = "git_tag_lookup", instance_pos = 1.2)]
		public Error lookup_tag(out Tag tag, object_id id);

		/**
		 * Lookup a tag object from the repository,
		 * given a prefix of its identifier (short id).
		 *
		 * @see lookup_object_by_prefix
		 *
		 * @param tag pointer to the looked up tag
		 * @param id identity of the tag to locate.
		 * @param len the length of the short identifier
		 */
		[CCode(cname = "git_tag_lookup_prefix", instance_pos = 1.2)]
		public Error prefix_lookup_tag(out Tag tag, object_id id, uint len);

		/**
		 * Create a new tag in the repository from an object
		 *
		 * A new reference will also be created pointing to
		 * this tag object. If `force` is true and a reference
		 * already exists with the given name, it'll be replaced.
		 *
		 * @param id where to store the id of the
		 * newly created tag. If the tag already exists, this parameter
		 * will be the id of the existing tag, and the function will
		 * return a {@link Error.EXISTS} error code.
		 *
		 * @param tag_name Name for the tag; this name is validated
		 * for consistency. It should also not conflict with an
		 * already existing tag name
		 *
		 * @param target Object to which this tag points. This object
		 * must belong to this repository.
		 *
		 * @param tagger Signature of the tagger for this tag, and
		 *  of the tagging time
		 *
		 * @param message Full message for this tag
		 *
		 * @param force Overwrite existing references
		 *
		 * @return on success, a tag object is written to the ODB, and a
		 *	proper reference is written in the /refs/tags folder, pointing to it
		 */
		[CCode(cname = "git_tag_create", instance_pos = 1.2)]
		public Error create_tag(object_id id, string tag_name, Object target, Signature tagger, string message, bool force);

		/**
		 * Create a new tag in the repository from a buffer
		 *
		 * @param id Pointer where to store the id of the newly created tag
		 * @param buffer Raw tag data
		 * @param force Overwrite existing tags
		 * @return 0 on sucess; error code otherwise
		 */
		[CCode(cname = "git_tag_create_frombuffer", instance_pos = 1.2)]
		public Error create_tag_frombuffer(object_id id, string buffer, bool force);

		/**
		 * Create a new lightweight tag pointing at a target object
		 *
		 * A new direct reference will be created pointing to
		 * this target object. If `force` is true and a reference
		 * already exists with the given name, it'll be replaced.
		 *
		 * @param id where to store the id of the
		 * newly created tag. If the tag already exists, this parameter
		 * will be the id of the existing tag, and the function will
		 * return a {@link Error.EXISTS} error code.
		 *
		 * @param tag_name Name for the tag; this name is validated
		 * for consistency. It should also not conflict with an
		 * already existing tag name
		 *
		 * @param target Object to which this tag points. This object
		 * must belong to this repository.
		 *
		 * @param force Overwrite existing references
		 *
		 * @return on success, a proper reference is written in the /refs/tags
		 *  folder, pointing to the provided target object
		 */
		[CCode(cname = "git_tag_create_lightweight", instance_pos = 1.2)]
		public Error create_lightweight_tag(object_id id, string tag_name, Object target, bool force);

		/**
		 * Delete an existing tag reference.
		 *
		 * @param tag_name Name of the tag to be deleted;
		 * this name is validated for consistency.
		 */
		[CCode(cname = "git_tag_delete")]
		public Error delete_tag(string tag_name);

		/**
		 * Fill a list with all the tags in the Repository
		 *
		 * @param tag_names where the tag names will be stored
		 */
		[CCode(cname = "git_tag_list", instance_pos = -1)]
		public Error get_tag_list(string_array tag_names);

		/**
		 * Fill a list with all the tags in the Repository
		 * which name match a defined pattern
		 *
		 * If an empty pattern is provided, all the tags
		 * will be returned.
		 *
		 * @param where the tag names will be stored
		 * @param pattern standard shell-like (fnmatch) pattern
		 */
		[CCode(cname = "git_tag_list_match", instance_pos = -1)]
		public Error get_tag_list_match(string_array tag_names, string pattern);

		/**
		 * Lookup a tree object from the repository.
		 *
		 * @param tree the looked up tree
		 * @param id identity of the tree to locate.
		 */
		[CCode(cname = "git_tree_lookup", instance_pos = 1.2)]
		public Error lookup_tree(out Tree tree, object_id id);

		/**
		 * Lookup a tree object from the repository,
		 * given a prefix of its identifier (short id).
		 *
		 * @see lookup_object_by_prefix
		 *
		 * @param tree the looked up tree
		 * @param id identity of the tree to locate.
		 * @param len the length of the short identifier
		 */
		[CCode(cname = "git_tree_lookup_prefix", instance_pos = 1.2)]
		public Error lookup_tree_by_prefix(out Tree tree, object_id id, uint len);

		/**
		 * Write the contents of the tree builder as a tree object
		 *
		 * The tree builder will be written to the repositrory, and
		 * it's identifying SHA1 hash will be stored in the id
		 * pointer.
		 *
		 * @param id Pointer where to store the written id
		 * @param builder Tree builder to write
		 */
		[CCode(cname = "git_treebuilder_write", instance_pos = 1.2)]
		public Error write(object_id id, TreeBuilder builder);

		/**
		 * Convert a tree entry to the object it points too.
		 *
		 * @param object pointer to the converted object
		 * @param entry a tree entry
		 */
		[CCode(cname = "git_tree_entry_2object", instance_pos = 1.2)]
		public Error load(out Object object, TreeEntry entry);

		/**
		 * Gather file statuses and run a callback for each one.
		 *
		 * The callback is passed the path of the file, the status and the data pointer
		 * passed to this function. If the callback returns something other than
		 * {@link Error.SUCCESS}, this function will return that value.
		 *
		 * @param callback the function to call on each file
		 * @return {@link Error.SUCCESS} or the return value of the callback
		 */
		[CCode(cname = "git_status_foreach")]
		public Error for_each_status(StatusCallback callback);

		/**
		 * Get file status for a single file
		 *
		 * @param status the status value
		 * @param path the file to retrieve status for, rooted at the repo's workdir
		 */
		[CCode(cname = "git_status_file", instance_pos = 1.2)]
		public Error get_file_status(out Status status, string path);
	}

	public delegate int ReferenceCallback(string refname);

	/**
	 * Internal path identifiers for a repository
	 */
	[CCode(cname = "git_repository_pathid", cprefix = "GIT_REPO_PATH_")]
	public enum PathType {
		/**
		 * The path to the repository
		 */
		[CCode(cname = "GIT_REPO_PATH")]
		BASE,
		/**
		 * The path to the index
		 */
		INDEX,
		/**
		 * The path to the database
		 */
		ODB,
		/**
		 * The path to the working directory
		 */
		WORKDIR
	}

	/**
	 * Representation of a generic object in a repository
	 */
	[CCode(cname = "git_object", free_function = "git_object_close")]
	[Compact]
	public class Object {
		/**
		 * The id (SHA1) of a repository object
		 */
		public object_id id {
			[CCode(cname = "git_object_id")]
			get;
		}

		/**
		 * The object type of an object
		 */
		public ObjectType type {
			[CCode(cname = "git_object_type")]
			get;
		}

		/**
		 * The repository that owns this object
		 */
		public Repository repository {
			[CCode(cname = "git_object_owner")]
			get;
		}
	}

	[CCode(cname = "int", cprefix = "GIT_SORT_")]
	[Flags]
	public enum Sorting {
		/**
		 * Sort the repository contents in no particular ordering;
		 * this sorting is arbitrary, implementation-specific
		 * and subject to change at any time.
		 * This is the default sorting for new walkers.
		 */
		NONE,
		/**
		 * Sort the repository contents in topological order
		 * (parents before children); this sorting mode
		 * can be combined with time sorting.
		 */
		TOPOLOGICAL,
		/**
		 * Sort the repository contents by commit time;
		 * this sorting mode can be combined with
		 * topological sorting.
		 */
		TIME,
		/**
		 * Iterate through the repository contents in reverse
		 * order; this sorting mode can be combined with
		 * any of the above.
		 */
		REVERSE
	}

	/**
	 * Representation of an in-progress walk through the commits in a repo
	 */
	[CCode(cname = "git_revwalk", free_function = "git_revwalk_free")]
	[Compact]
	public class RevisionWalker {

		/**
		 * Reset the revision walker for reuse.
		 *
		 * This will clear all the pushed and hidden commits, and
		 * leave the walker in a blank state (just like at
		 * creation) ready to receive new commit pushes and
		 * start a new walk.
		 *
		 * The revision walk is automatically reset when a walk
		 * is over.
		 *
		 * @param walker handle to reset.
		 */
		[CCode(cname = "git_revwalk_reset")]
		public void reset();

		/**
		 * Mark a commit to start traversal from.
		 *
		 * The given id must belong to a commit on the walked
		 * repository.
		 *
		 * The given commit will be used as one of the roots
		 * when starting the revision walk. At least one commit
		 * must be pushed the repository before a walk can
		 * be started.
		 *
		 * @param id the id of the commit to start from.
		 */
		[CCode(cname = "git_revwalk_push")]
		public Error push(object_id id);

		/**
		 * Mark a commit (and its ancestors) uninteresting for the output.
		 *
		 * The given id must belong to a commit on the walked
		 * repository.
		 *
		 * The resolved commit and all its parents will be hidden from the
		 * output on the revision walk.
		 *
		 * @param id the id of commit that will be ignored during the traversal
		 */
		[CCode(cname = "git_revwalk_hide")]
		public Error hide(object_id id);

		/**
		 * Get the next commit from the revision walk.
		 *
		 * The initial call to this method is *not* blocking when
		 * iterating through a repo with a time-sorting mode.
		 *
		 * Iterating with Topological or inverted modes makes the initial
		 * call blocking to preprocess the commit list, but this block should be
		 * mostly unnoticeable on most repositories (topological preprocessing
		 * times at 0.3s on the git.git repo).
		 *
		 * The revision walker is reset when the walk is over.
		 *
		 * @param id where to store the id of the next commit
		 */
		[CCode(cname = "git_revwalk_next", instance_pos = -1)]
		public Error next(out object_id id);

		/**
		 * Change the sorting mode when iterating through the
		 * repository's contents.
		 *
		 * Changing the sorting mode resets the walker.
		 *
		 * @param sort combination of sort flags
		 */
		[CCode(cname = "git_revwalk_sorting")]
		public void set_sorting(Sorting sort);

		/**
		 * Return the repository on which this walker
		 * is operating.
		 *
		 * @return the repository being walked
		 */
		public Repository repository {
			[CCode(cname = "git_revwalk_repository")]
			get;
		}
	}

	/**
	 * Parsed representation of a tag object.
	 */
	[CCode(cname = "git_tag", free_function = "git_tag_close")]
	[Compact]
	public class Tag : Object {
		/**
		 * Get the id of a tag.
		 *
		 * @return object identity for the tag.
		 */
		public object_id id {
			[CCode(cname = "git_tag_id")]
			get;
		}

		/**
		 * Get the tagged object of a tag
		 *
		 * This method performs a repository lookup for the
		 * given object and returns it
		 *
		 * @param target pointer where to store the target
		 */
		[CCode(cname = "git_tag_target", instance_pos = -1)]
		public Error get_target(out Object target);

		/**
		 * Get the id of the tagged object of a tag
		 */
		public object_id target_id {
			[CCode(cname = "git_tag_target_oid")]
			get;
		}

		/**
		 * The type of a tag's tagged object
		 */
		public ObjectType type {
			[CCode(cname = "git_tag_type")]
			get;
		}

		/**
		 * The name of a tag
		 */
		public string name {
			[CCode(cname = "git_tag_name")]
			get;
		}

		/**
		 * The tagger (author) of a tag
		 */
		public Signature tagger {
			[CCode(cname = "git_tag_tagger")]
			get;
		}

		/**
		 * The message of a tag
		 */
		public string message {
			[CCode(cname = "git_tag_message")]
			get;
		}

	}

	/**
	 * In-memory representation of a blob object.
	 */
	[CCode(cname = "git_blob", free_function = "git_blob_close")]
	[Compact]
	public class Blob : Object {
		/**
		 * Get a read-only buffer with the raw content of a blob.
		 *
		 * A pointer to the raw content of a blob is returned.
		 * The pointer may be invalidated at a later time.
		 *
		 * @return the data or null if the blob has no contents
		 */
		[CCode(cname = "git_blob_rawcontent", array_length = false)]
		public unowned uint8[] ? get_content();

		/**
		 * Get the size in bytes of the contents of a blob
		 *
		 * @return size in bytes
		 */
		[CCode(cname = "git_blob_rawsize")]
		public int get_size();
	}

	/**
	 * Parsed representation of a commit object.
	 */
	[CCode(cname = "git_commit", free_function = "git_commit_close")]
	[Compact]
	public class Commit : Object {
		/**
		 * The id of a commit.
		 */
		public object_id id {
			[CCode(cname = "git_commit_id")]
			get;
		}

		/**
		 * Get the encoding for the message of a commit,
		 * as a string representing a standard encoding name.
		 *
		 * The encoding may be null if the encoding header
		 * in the commit is missing; in that case UTF-8 is assumed.
		 */
		public string ? message_encoding {
			[CCode(cname = "git_commit_message_encoding")]
			get;
		}

		/**
		 * Get the full message of a commit.
		 */
		public string message {
			[CCode(cname = "git_commit_message")]
			get;
		}

		/**
		 * The message of a commit converted to UTF-8.
		 */
		public string get_message_utf8() throws GLib.ConvertError{
			return this.message_encoding == null ? this.message : GLib.convert(this.message, this.message.length, "utf-8", this.message_encoding);
		}


		/**
		 * Get the commit time (i.e., committer time) of a commit.
		 */
		public int64 time {
			[CCode(cname = "git_commit_time")]
			get;
		}

		/**
		 * Get the commit timezone offset (i.e., committer's preferred timezone) in minutes from UTC of a commit.
		 */
		public int time_offset {
			[CCode(cname = "git_commit_time_offset")]
			get;
		}

		/**
		 * The committer of a commit.
		 */
		public Signature committer {
			[CCode(cname = "git_commit_committer")]
			get;
		}

		/**
		 * The author of a commit.
		 */
		public Signature author {
			[CCode(cname = "git_commit_author")]
			get;
		}

		/**
		 * Get the tree pointed to by a commit.
		 */
		[CCode(cname = "git_commit_tree", instance_pos = -1)]
		public Error get_tree(out Tree tree);

		/**
		 * Get the id of the tree pointed to by a commit.
		 *
		 * This differs from {@link get_tree} in that no attempts
		 * are made to fetch an object from the ODB.
		 */
		public object_id tree_id {
			[CCode(cname = "git_commit_tree_oid")]
			get;
		}

		/**
		 * Get the number of parents of this commit
		 */
		public uint parent_count {
			[CCode(cname = "git_commit_parentcount")]
			get;
		}

		/**
		 * Get the specified parent of the commit.
		 *
		 * @param parent where to store the parent commit
		 * @param n the position of the parent
		 */
		[CCode(cname = "git_commit_parent", instance_pos = 1.2)]
		public Error get_parent(out Commit parent, uint n);

		/**
		 * Get the id of a specified parent for a commit.
		 *
		 * This is different from {@link get_parent}, which will attempt
		 * to load the parent commit from the ODB.
		 *
		 * @param n the position of the parent
		 * @return the id of the parent, null on error.
		 */
		[CCode(cname = "git_commit_parent_oid")]
		public unowned object_id? get_parent_id(uint n);
	}

	/**
	 * Representation of a tree object.
	 */
	[CCode(cname = "git_tree", free_function = "git_tree_close")]
	[Compact]
	public class Tree : Object {
		/**
		 * Get the id of a tree.
		 */
		public object_id id {
			[CCode(cname = "git_tree_id")]
			get;
		}

		/**
		 * Get the number of entries listed in a tree
		 */
		public uint entry_count {
			[CCode(cname = "git_tree_entrycount")]
			get;
		}

		/**
		 * Lookup a tree entry by its filename
		 *
		 * @param filename the filename of the desired entry
		 * @return the tree entry; null if not found
		 */
		[CCode(cname = "git_tree_entry_byname")]
		public unowned TreeEntry ? get_entry_by_name(string filename);

		/**
		 * Lookup a tree entry by its position in the tree
		 *
		 * @param idx the position in the entry list
		 * @return the tree entry; null if not found
		 */
		[CCode(cname = "git_tree_entry_byindex")]
		public unowned TreeEntry ? get(uint idx);
	}

	/**
	 * Representation of each one of the entries in a tree object.
	 */
	[CCode(cname = "git_tree_entry")]
	[Compact]
	public class TreeEntry {
		/**
		 * The UNIX file attributes of a tree entry
		 */
		public uint attributes {
			[CCode(cname = "git_tree_entry_attributes")]
			get;
		}

		/**
		 * The filename of a tree entry
		 */
		public string name {
			[CCode(cname = "git_tree_entry_name")]
			get;
		}

		/**
		 * The id of the object pointed by the entry
		 */
		public unowned object_id id {
			[CCode(cname = "git_tree_entry_id")]
			get;
		}

		/**
		 * The type of the object pointed by the entry
		 */
		public ObjectType type {
			[CCode(cname = "git_tree_entry_type")]
			get;
		}

		/**
		 * Create a new tree builder.
		 *
		 * The tree builder can be used to create or modify
		 * trees in memory and write them as tree objects to the
		 * database.
		 *
		 * The tree builder will be initialized with the entries
		 * of the given tree.
		 *
		 * @param builder where to store the tree builder
		 */
		[CCode(cname = "git_treebuilder_create", instance_pos = -1)]
		public Error create_builder(out TreeBuilder builder);
	}

	/**
	 * Constructor for in-memory trees
	 */
	[CCode(cname = "git_treebuilder", free_function = "git_treebuilder_free")]
	[Compact]
	public class TreeBuilder {
		/**
		 * Create a new tree builder.
		 *
		 * The tree builder can be used to create or modify
		 * trees in memory and write them as tree objects to the
		 * database.
		 *
		 * If the source parameter is not null, the tree builder
		 * will be initialized with the entries of the given tree.
		 *
		 * If the source parameter is null, the tree builder will
		 * have no entries and will have to be filled manually.
		 *
		 * @param builder where to store the tree builder
		 * @param source Source tree to initialize the builder (optional)
		 */
		[CCode(cname = "git_treebuilder_create")]
		public static Error create(out TreeBuilder builder, Tree ? source = null);

		/**
		 * Clear all the entires in the builder
		 */
		[CCode(cname = "git_treebuilder_clear")]
		public void clear();

		/**
		 * Get an entry from the builder from its filename
		 * @param filename Name of the entry
		 * @return the entry; null if not found
		 */
		[CCode(cname = "git_treebuilder_get")]
		public unowned TreeEntry ? get(string filename);

		/**
		 * Add or update an entry to the builder
		 *
		 * Insert a new entry for the given filename in the builder with the
		 * given attributes.
		 *
		 * If an entry named filename already exists, its attributes
		 * will be updated with the given ones.
		 *
		 * @param entry where to store the entry (optional)
		 * @param filename Filename of the entry
		 * @param id SHA1 id of the entry
		 * @param attributes Folder attributes of the entry
		 * @return 0 on success; error code otherwise
		 */
		[CCode(cname = "git_treebuilder_insert", instance_pos = 1.2)]
		public Error insert(out TreeEntry ? entry = null, string filename, object_id id, Attributes attributes);

		/**
		 * Remove an entry from the builder by its filename
		 *
		 * @param filename Filename of the entry to remove
		 */
		[CCode(cname = "git_treebuilder_remove")]
		public Error remove(string filename);

		/**
		 * Filter the entries in the tree
		 *
		 * The filter will be called for each entry
		 * in the tree with an entry. If the callback
		 * returns true, the entry will be filtered (removed from the builder).
		 * @param filter function to filter entries
		 */
		[CCode(cname = "git_treebuilder_filter")]
		public void filter(Filter filter);
	}

	public delegate bool Filter(TreeEntry entry);

	[CCode(cname = "int", cprefix = "GIT_IDXENTRY_")]
	[Flags]
	public enum Attributes {
		EXTENDED,
		VALID,
		UPDATE,
		REMOVE,
		UPTODATE,
		ADDED,
		HASHED,
		UNHASHED,
		WT_REMOVE,
		CONFLICTED,
		UNPACKED,
		NEW_SKIP_WORKTREE,
		INTENT_TO_ADD,
		SKIP_WORKTREE,
		EXTENDED2,
		EXTENDED_FLAGS
	}

	/**
	 * Time used in a index entry
	 */
	[CCode(cname = "git_index_time")]
	public struct index_time {
		public int64 seconds;
		public uint nanoseconds;
	}

	/**
	 * Memory representation of a file entry in the index.
	 */
	[CCode(cname = "git_index_entry")]
	[Compact]
	public class IndexEntry {
		public index_time ctime;
		public index_time mtime;

		public uint dev;
		public uint ino;
		public uint mode;
		public uint uid;
		public uint gid;
		public int64 file_size;

		[CCode(cname = "oid")]
		public object_id id;

		public Attributes flags;
		public uint16 flags_extended;

		public string path;

		/**
		 * The stage number from a git index entry
		 */
		public int stage {
			[CCode(cname = "git_index_entry_stage")]
			get;
		}
	}

	/**
	 * Representation of an unmerged file entry in the index.
	 */
	[CCode(cname = "git_index_entry_unmerged")]
	public struct unmerged_index_entry {
		uint mode[3];
		[CCode(cname = "oid")]
		public object_id id[3];
		public string path;
	}

	/**
	 * Memory representation of an index file.
	 */
	[CCode(cname = "git_index", free_function = "git_index_free")]
	[Compact]
	public class Index {
		/**
		 * Write a tree to the ODB from the index file
		 *
		 * This method will scan the index and write a representation
		 * of its current state back to disk; it recursively creates
		 * tree objects for each of the subtrees stored in the index,
		 * but only returns the id of the root tree. This is the id
		 * that can be used (e.g., to create a commit).
		 *
		 * The index instance cannot be bare and needs to be associated
		 * to an existing repository.
		 *
		 * @param id where to store the written tree
		 */
		[CCode(cname = "git_tree_create_fromindex", instance_pos = -1)]
		public Error write_tree(object_id id);

		/**
		 * Create a new bare Git index object as a memory representation
		 * of the Git index file in the index path, without a repository
		 * to back it.
		 *
		 * Since there is no ODB or working directory behind this index,
		 * any index methods which rely on these (e.g., {@link add}) will
		 * fail with the {@link Error.BAREINDEX} error code.
		 *
		 * If you need to access the index of an actual repository,
		 * use {@link Repository.get_index}.
		 *
		 * @param index where to put the new index
		 * @param index_path the path to the index file in disk
		 */
		public static Error open(out Index index, string index_path);

		/**
		 * Clear the contents (all the entries) of an index object.
		 *
		 * This clears the index object in memory; changes must be manually
		 * written to disk for them to take effect.
		 */
		[CCode(cname = "git_index_clear")]
		public void clear();

		/**
		 * Update the contents of an existing index object in memory
		 * by reading from the hard disk.
		 */
		[CCode(cname = "git_index_read")]
		public Error read();

		/**
		 * Write an existing index object from memory back to disk
		 * using an atomic file lock.
		 */
		[CCode(cname = "git_index_write")]
		public Error write();

		/**
		 * Find the first index of any entries which point to given
		 * path in the git index.
		 *
		 * @param path path to search
		 * @return an index >= 0 if found, -1 otherwise
		 */
		[CCode(cname = "git_index_find")]
		public int find(string path);

		/**
		 * Remove all entries with equal path except last added
		 */
		[CCode(cname = "git_index_uniq")]
		public void make_unique();

		/**
		 * Add or update an index entry from a file in disk
		 *
		 * The file path must be relative to the repository's
		 * working folder and must be readable.
		 *
		 * This method will fail in bare index instances.
		 *
		 * @param path filename to add
		 * @param stage stage for the entry
		 */
		public Error add(string path, int stage);

		/**
		 * Add or update an index entry from an in-memory struct
		 *
		 * A full copy (including the path string) of the given
		 * source will be inserted on the index.
		 *
		 * @param source new entry object
		 */
		[CCode(cname = "git_index_add2")]
		public Error add_entry(IndexEntry entry);

		/**
		 * Add (append) an index entry from a file on disk
		 *
		 * A new entry will always be inserted into the index;
		 * if the index already contains an entry for such
		 * path, the old entry will ''not'' be replaced.
		 *
		 * The file path must be relative to the repository's
		 * working folder and must be readable.
		 *
		 * This method will fail in bare index instances.
		 *
		 * @param path filename to add
		 * @param stage stage for the entry
		 */
		[CCode(cname = "git_index_append")]
		public Error append(string path, int stage);

		/**
		 * Add (append) an index entry from an in-memory struct
		 *
		 * A new entry will always be inserted into the index;
		 * if the index already contains an entry for the path
		 * in the entry, the old entry will ''not'' be
		 * replaced.
		 *
		 * A full copy (including the path string) of the given
		 * source will be inserted on the index.
		 *
		 * @param source new entry object
		 */
		[CCode(cname = "git_index_append2")]
		public Error append_entry(IndexEntry source);

		/**
		 * Remove an entry from the index
		 * @param position position of the entry to remove
		 */
		[CCode(cname = "git_index_remove")]
		public Error remove(int position);

		/**
		 * Get a pointer to one of the entries in the index
		 *
		 * This entry can be modified, and the changes will be written
		 * back to disk on the next {@link write} call.
		 *
		 * The entry should not be freed by the caller.
		 *
		 * @param n the position of the entry
		 * @return the entry; null if out of bounds
		 */
		[CCode(cname = "git_index_get")]
		public unowned IndexEntry ? get(uint n);

		/**
		 * The count of entries currently in the index
		 */
		public uint entry_count {
			[CCode(cname = "git_index_entrycount")]
			get;
		}

		/**
		 * The count of unmerged entries currently in the index
		 */
		public uint get_unmerged_count {
			[CCode(cname = "git_index_entrycount_unmerged")]
			get;
		}

		/**
		 * Get an unmerged entry from the index.
		 *
		 * @param path path to search
		 * @return the unmerged entry; null if not found
		 */
		[CCode(cname = "git_index_get_unmerged_bypath")]
		public unowned unmerged_index_entry ? get_unmerged_by_path(string path);

		/**
		 * Get an unmerged entry from the index.
		 *
		 * @param n the position of the entry
		 * @return a pointer to the unmerged entry; null if out of bounds
		 */
		[CCode(cname = "git_index_get_unmerged_byindex")]
		public unowned unmerged_index_entry ? get_unmerged(uint n);
	}

	/**
	 * Memory representation of a set of config files
	 */
	[CCode(cname = "git_config", free_function = "git_config_free")]
	[Compact]
	public class Config {
		/**
		 * Locate the path to the global configuration file
		 *
		 * The user or global configuration file is usually
		 * located in //$HOME/.gitconfig//.
		 *
		 * This method will try to guess the full path to that
		 * file, if the file exists. The returned path
		 * may be used on any call to load the
		 * global configuration file.
		 *
		 * @param global_config_path Buffer of {@link PATH_MAX} length to store the path
		 * @return {@link Error.SUCCESS} if a global configuration file has been
		 *	found. Its path will be stored in `buffer`.
		 */
		[CCode(cname = "git_config_find_global")]
		public static Error find_global([CCode(array_length = false)] char[] global_config_path);

		/**
		 * Open the global configuration file
		 *
		 * Utility wrapper that calls {@link find_global}
		 * and opens the located file, if it exists.
		 *
		 * @param config where to store the config instance
		 */
		public static Error open_global(out Config config);

		/**
		 * Allocate a new configuration object
		 *
		 * This object is empty, so you have to add a file to it before you
		 * can do anything with it.
		 *
		 * @param config the new configuration
		 */
		[CCode(cname = "git_config_new")]
		public static Error create(out Config config);

		/**
		 * Add a generic config file instance to an existing config
		 *
		 * Further queries on this config object will access each
		 * of the config file instances in order (instances with
		 * a higher priority will be accessed first).
		 *
		 * @param file the configuration file (backend) to add
		 * @param priority the priority the backend should have
		 */
		[CCode(cname = "git_config_add_file")]
		public Error add_file(owned ConfigFile file, int priority);

		/**
		 * Add an on-disk config file instance to an existing config
		 *
		 * The on-disk file pointed at by path will be opened and
		 * parsed; it's expected to be a native Git config file following
		 * the default Git config syntax (see man git-config).
		 *
		 * Further queries on this config object will access each
		 * of the config file instances in order (instances with
		 * a higher priority will be accessed first).
		 *
		 * @param path path to the configuration file (backend) to add
		 * @param priority the priority the backend should have
		 */
		[CCode(cname = "git_config_add_file_ondisk")]
		public Error add_filename(string path, int priority);

		/**
		 * Create a new config instance containing a single on-disk file
		 *
		 * This method is a simple utility wrapper for the following sequence
		 * of calls:
		 *	* {@link create}
		 *	* {@link add_filename}
		 *
		 * @param cfg the configuration instance to create
		 * @param path path to the on-disk file to open
		 */
		[CCode(cname = "git_config_open_ondisk")]
		public static Error open(out Config cfg, string path);

		/**
		 * Get the value of an integer config variable.
		 *
		 * @param name the variable's name
		 * @param value where the value should be stored
		 */
		[CCode(cname = "git_config_get_int")]
		public Error get_int(string name, out int value);

		/**
		 * Get the value of a long integer config variable.
		 *
		 * @param name the variable's name
		 * @param value where the value should be stored
		 */
		[CCode(cname = "git_config_get_long")]
		public Error get_long(string name, out long value);

		/**
		 * Get the value of a boolean config variable.
		 *
		 * @param name the variable's name
		 * @param value where the value should be stored
		 */
		[CCode(cname = "git_config_get_bool")]
		public Error get_bool(string name, out bool value);

		/**
		 * Get the value of a string config variable.
		 *
		 * @param name the variable's name
		 * @param value the variable's value
		 */
		public Error get_string(string name, out unowned string value);

		/**
		 * Set the value of an integer config variable.
		 *
		 * @param name the variable's name
		 * @param value integer value for the variable
		 */
		[CCode(cname = "git_config_set_int")]
		public Error set_int(string name, int value);

		/**
		 * Set the value of a long integer config variable.
		 *
		 * @param name the variable's name
		 * @param value Long integer value for the variable
		 */
		[CCode(cname = "git_config_set_long")]
		public Error set_long(string name, long value);

		/**
		 * Set the value of a boolean config variable.
		 *
		 * @param name the variable's name
		 * @param value the value to store
		 */
		[CCode(cname = "git_config_set_bool")]
		public Error set_bool(string name, bool value);

		/**
		 * Set the value of a string config variable.
		 *
		 * A copy of the string is made and the user is free to use it
		 * afterwards.
		 *
		 * @param name the variable's name
		 * @param value the string to store.
		 */
		[CCode(cname = "git_config_set_string")]
		public Error set_string(string name, string value);

		/**
		 * Delete a config variable
		 *
		 * @param name the variable to delete
		 */
		[CCode(cname = "git_config_delete")]
		public Error delete(string name);

		/**
		 * Perform an operation on each config variable.
		 *
		 * The callback receives the normalized name and value of each variable
		 * in the config backend. As soon as one of the callback functions returns
		 * something other than 0, this function returns that value.
		 *
		 * @param callback the function to call on each variable
		 */
		[CCode(cname = "git_config_foreach")]
		public int for_each(ConfigCallback callback);

		/**
		 * Get the information for a particular remote
		 *
		 * @param remote the new remote object
		 * @param name the remote's name
		 */
		[CCode(cname = "git_remote_get", instance_pos = 1.2)]
		public Error get_remote(out Remote remote, string name);
	}

	public delegate int ConfigCallback(string var_name, string val);

	/**
	 * Generic backend that implements the interface to
	 * access a configuration file
	 */
	[CCode(cname = "git_config_file")]
	[Compact]
	public class ConfigFile {
		public unowned Config cfg;
		/**
		 * Create a configuration file backend for on-disk files
		 *
		 * These are the normal //.gitconfig// files that Core Git
		 * processes. Note that you first have to add this file to a
		 * configuration object before you can query it for configuration
		 * variables.
		 *
		 * @param out the new backend
		 * @param path where the config file is located
		 */
		[CCode(cname = "git_config_file__ondisk")]
		public static Error open(out ConfigFile file, string path);
	}

	/**
	 * Representation of a reference log
	 */
	[CCode(cname = "git_reflog", free_function = "git_reflog_free")]
	[Compact]
	public class ReferenceLog {
		/**
		 * Get the number of log entries in a reflog
		 * @return the number of log entries
		 */
		[CCode(cname = "git_reflog_entrycount")]
		public uint length();

		/**
		 * Lookup an entry by its index
		 *
		 * @param idx the position to lookup
		 * @return the entry; null if not found
		 */
		[CCode(cname = "git_reflog_entry_byindex")]
		public unowned ReferenceLogEntry ? get(uint idx);
	}

	/**
	 * Representation of a reference log entry
	 */
	[CCode(cname = "git_reflog_entry")]
	[Compact]
	public class ReferenceLogEntry {
		/**
		 * The old id
		 */
		public object_id old_id {
			[CCode(cname = "git_reflog_entry_oidold")]
			get;
		}

		/**
		 * The new id at this time
		 */
		public object_id new_id {
			[CCode(cname = "git_reflog_entry_oidnew")]
			get;
		}

		/**
		 * The committer of this entry
		 */
		public Signature commiter {
			[CCode(cname = "git_reflog_entry_committer")]
			get;
		}

		/**
		 * The log message
		 */
		public string message {
			[CCode(cname = "git_reflog_entry_msg")]
			get;
		}
	}

	/**
	 * Time in a signature
	 */
	[CCode(cname = "git_time")]
	public struct time {
		/**
		 * time in seconds from epoch
		 */
		int64 time;
		/**
		 * timezone offset, in minutes
		 */
		int offset;
	}

	/**
	 * Basic type of any Git reference.
	 */
	[CCode(cname = "git_rtype", cprefix = "GIT_REF_")]
	[Flags]
	public enum ReferenceType {
		/**
		 * Invalid reference
		 */
		INVALID,
		/**
		 * A reference which points at an object id
		 */
		[CCode(cname = "GIT_REF_OID")]
		ID,
		/**
		 * A reference which points at another reference
		 */
		SYMBOLIC,
		PACKED,
		HAS_PEEL,
		LISTALL
	}

	[CCode(cname = "git_refspec")]
	[Compact]
	public class RefSpec {
		/**
		 * The source specifier
		 */
		public string source {
			[CCode(cname = "git_refspec_src")]
			get;
		}

		/**
		 * The destination specifier
		 */
		public string destination {
			[CCode(cname = "git_refspec_dst")]
			get;
		}

		/**
		 * Match a refspec's source descriptor with a reference name
		 *
		 * @param refname the name of the reference to check
		 * @return {@link Error.SUCCESS} on successful match; {@link Error.NOMATCH}
		 * on match failure or an error code on other failure
		 */
		[CCode(cname = "git_refspec_src_match")]
		public Error matches(string refname);

		/**
		 * Transform a reference to its target following the refspec's rules
		 *
		 * @param buffer where to store the target name
		 * @param name the name of the reference to transform
		 * @return {@link Error.SUCCESS}, {@link Error.SHORTBUFFER} or another error
		 */
		[CCode(cname = "git_refspec_transform", instance_pos = 1.3)]
		public Error transform([CCode(array_length_type = "size_t")] char[] buffer, string name);
	}

	/**
	 * In-memory representation of a reference.
	 */
	[CCode(cname = "git_reference")]
	[Compact]
	public class Reference {
		/**
		 * The id pointed to by a reference.
		 *
		 * Only available if the reference is direct (i.e. not symbolic)
		 */
		public object_id? id {
			[CCode(cname = "git_reference_oid")]
			get;
		}

		/**
		 * The full name to the reference pointed by this reference
		 *
		 * Only available if the reference is symbolic
		 */
		public string ? target {
			[CCode(cname = "git_reference_target")]
			get;
		}

		/**
		 * The type of a reference
		 *
		 * Either direct, {@link ReferenceType.ID}, or symbolic, {@link ReferenceType.SYMBOLIC}
		 *
		 */
		public ReferenceType type {
			[CCode(cname = "git_reference_type")]
			get;
		}

		/**
		 * The full name of a reference
		 */
		public string name {
			[CCode(cname = "git_reference_name")]
			get;
		}

		/**
		 * Resolve a symbolic reference
		 *
		 * Thie method iteratively peels a symbolic reference
		 * until it resolves to a direct reference to an id.
		 *
		 * If a direct reference is passed as an argument,
		 * that reference is returned immediately
		 *
		 * @param resolved the peeled reference
		 */
		[CCode(cname = "git_reference_resolve", instance_pos = -1)]
		public Error resolve(out Reference resolved_ref);

		/**
		 * The repository where a reference resides
		 */
		public Repository repository {
			[CCode(cname = "git_reference_owner")]
			get;
		}

		/**
		 * Set the symbolic target of a reference.
		 *
		 * The reference must be a symbolic reference, otherwise
		 * this method will fail.
		 *
		 * The reference will be automatically updated in
		 * memory and on disk.
		 *
		 * @param target The new target for the reference
		 */
		[CCode(cname = "git_reference_set_target")]
		public Error set_target(string target);

		/**
		 * Set the id target of a reference.
		 *
		 * The reference must be a direct reference, otherwise
		 * this method will fail.
		 *
		 * The reference will be automatically updated in
		 * memory and on disk.
		 *
		 * @param id the new target id for the reference
		 */
		[CCode(cname = "git_reference_set_oid")]
		public Error set_id(object_id id);

		/**
		 * Rename an existing reference
		 *
		 * This method works for both direct and symbolic references.
		 * The new name will be checked for validity and may be
		 * modified into a normalized form.
		 *
		 * The refernece will be immediately renamed in-memory
		 * and on disk.
		 */
		[CCode(cname = "git_reference_rename")]
		public Error rename(string new_name, bool force);

		/**
		 * Delete an existing reference
		 *
		 * This method works for both direct and symbolic references.
		 *
		 * The reference will be immediately removed on disk and from
		 * memory. The given reference pointer will no longer be valid.
		 *
		 */
		[DestroysInstance]
		[CCode(cname = "git_reference_delete")]
		public Error @delete();

		/**
		 * Read the reflog for the given reference
		 *
		 * @param reflog where to put the reflog
		 */
		[CCode(cname = "git_reflog_read", instance_pos = -1)]
		public Error get_reflog(out ReferenceLog reflog);

		/**
		 * Write a new reflog for the given reference
		 *
		 * If there is no reflog file for the given
		 * reference yet, it will be created.
		 *
		 * `msg` is optional and can be NULL.
		 *
		 * @param id_old the id the reference was pointing to
		 * @param committer the signature of the committer
		 * @param msg the reflog message
		 */
		[CCode(cname = "git_reflog_write")]
		public Error write_reflog(object_id ? id_old, Signature committer, string ? msg = null);
	}

	/**
	 * Reference to a remote repository
	 */
	[CCode(cname = "git_remote", free_function = "git_remote_free")]
	[Compact]
	public class Remote {
		/**
		 * Get the remote's name
		 */
		public string name {
			[CCode(cname = "git_remote_name")]
			get;
		}

		/**
		 * Get the remote's url
		 */
		public string url {
			[CCode(cname = "git_remote_url")]
			get;
		}

		/**
		 * The fetch refspec, if it exists
		 */
		public RefSpec ? fetch_spec {
			[CCode(cname = "git_remote_fetchspec")]
			get;
		}

		/**
		 * Get the push refspe, if it existsc
		 */

		public RefSpec ? push_spec {
			[CCode(cname = "git_remote_pushspec")]
			get;
		}

		/**
		 * Open a connection to a remote
		 *
		 * The transport is selected based on the URL. The direction argument
		 * is due to a limitation of the git protocol (over TCP or SSH) which
		 * starts up a specific binary which can only do the one or the other.
		 *
		 * @param direction whether you want to receive or send data
		 */
		[CCode(cname = "git_remote_connect")]
		public Error connect(Direction dir);

		/**
		 * Get a list of refs at the remote
		 *
		 * The remote (or more exactly its transport) must be connected.
		 *
		 * @param refs where to store the refs
		 */
		[CCode(cname = "git_remote_ls", instance_pos = -1)]
		public Error list(head_array refs);

		/**
		 * Negotiate what data needs to be exchanged to synchroize the remote
		 * and local references
		 */
		[CCode(cname = "git_remote_negotiate")]
		public Error negotiate();

		/**
		 * Download the packfile
		 *
		 * The packfile is downloaded with a temporary filename, as it's final
		 * name is not known yet. If there was no packfile needed (all the
		 * objects were available locally), filename will be null and the
		 * function will return success.
		 *
		 * @param filename where to store the temproray filename
		 */
		[CCode(cname = "git_remote_download", instance_pos = -1)]
		public Error download(out string ? filename);

		/**
		 * Update the tips to the new state
		 *
		 * Make sure that you only call this once you've successfully indexed
		 * or expanded the packfile.
		 */
		[CCode(cname = "git_remote_update_tips")]
		public Error update_tips();
	}

	/**
	 * A transport to use
	 */
	[CCode(cname = "git_transport", free_function = "git_transport_free")]
	[Compact]
	public class Transport {
		/**
		 * Get the appropriate transport for an URL.
		 * @param tranport the transport for the url
		 * @param url the url of the repo
		 */
		[CCode(cname = "git_transport_new")]
		public static Error create(out Transport ? transport, string url);

		[CCode(cname = "git_transport_connect")]
		public Error connect(Direction direction);

		[CCode(cname = "git_transport_ls")]
		public Error list(head_array array);

		[CCode(cname = "git_transport_close")]
		public Error close();

		[CCode(cname = "git_transport_add")]
		public Error add(string prefix);
	}

	/**
	 * Unique identity of any object (commit, tree, blob, tag).
	 */
	[CCode(cname = "git_oid")]
	public struct object_id {
		/**
		 * Raw binary formatted id
		 */
		uint8 id[20];

		/**
		 * Size (in bytes) of a raw/binary id
		 */
		[CCode(cname = "GIT_OID_RAWSZ")]
		public const int RAW_SIZE;

		/**
		 * Size (in bytes) of a hex formatted id
		 */
		[CCode(cname = "GIT_OID_HEXSZ")]
		public const int HEX_SIZE;

		/**
		 * Minimum length (in number of hex characters,
		 * (i.e., packets of 4 bits) of an id prefix
		 */
		[CCode(cname = "GIT_OID_MINPREFIXLEN")]
		public const int MIN_PREFIX_LENGTH;

		/**
		 * Parse a hex formatted object id
		 *
		 * @param out id structure the result is written into.
		 * @param str input hex string; must be pointing at the start of
		 *        the hex sequence and have at least the number of bytes
		 *        needed for an id encoded in hex (40 bytes).
		 * @return {@link Error.SUCCESS} if valid; {@link Error.NOTID} on failure.
		 */
		[CCode(cname = "git_oid_fromstr")]
		public static Error from_string(out object_id id, string str);

		/**
		 * Parse N characters of a hex formatted object id
		 *
		 * If N is odd, N-1 characters will be parsed instead.
		 * The remaining space in the git_oid will be set to zero.
		 *
		 * @param id id structure the result is written into.
		 * @param data input hex string
		 * @return {@link Error.SUCCESS} if valid; {@link Error.NOTID} on failure.
		 */
		[CCode(cname = "git_oid_fromstrn")]
		public static Error from_array(out object_id id, [CCode(array_length_type = "size_t")] uint8[] data);

		/**
		 * Copy an already raw id
		 */
		[CCode(cname = "git_oid_fromraw")]
		public static void from_raw(out object_id id, [CCode(array_length = false)] uint8[] raw);

		/**
		 * Format an id into a hex string.
		 *
		 * @param str output hex string; must be pointing at the start of
		 *        the hex sequence and have at least the number of bytes
		 *        needed for an id encoded in hex (40 bytes).  Only the
		 *        id digits are written; a '\\0' terminator must be added
		 *        by the caller if it is required.
		 */
		[CCode(cname = "git_oid_fmt", instance_pos = -1)]
		public void to_buffer([CCode(array_length = false)] char[] str);

		/**
		 * Format an id into a loose-object path string.
		 *
		 * The resulting string is "aa/...", where "aa" is the first two
		 * hex digitis of the id and "..." is the remaining 38 digits.
		 *
		 * @param str output hex string; must be pointing at the start of
		 *        the hex sequence and have at least the number of bytes
		 *        needed for an oid encoded in hex (41 bytes).  Only the
		 *        id digits are written; a '\\0' terminator must be added
		 *        by the caller if it is required.
		 */
		[CCode(cname = "git_oid_pathfmt", instance_pos = -1)]
		public void to_path([CCode(array_length = false)] char[] str);

		/**
		 * Format an id into a string.
		 *
		 * @return the string; null if memory is exhausted.
		 */
		[CCode(cname = "git_oid_allocfmt")]
		public string ? to_string();

		/**
		 * Format an id into a buffer as a hex format string.
		 *
		 * If the buffer is smaller than {@link HEX_SIZE}+1, then the resulting
		 * id string will be truncated to data.length-1 characters. If there are
		 * any input parameter errors, then a pointer to an empty string is returned,
		 * so that the return value can always be printed.
		 *
		 * @param buffer the buffer into which the id string is output.
		 * @return the out buffer pointer, assuming no input parameter
		 *         errors, otherwise a pointer to an empty string.
		 */
		[CCode(cname = "git_oid_to_string", instance_pos = -1)]
		public unowned string to_string_buffer([CCode(array_length_type = "size_t")] char[] buffer);

		/**
		 * Copy an id from one structure to another.
		 *
		 * @param dest id structure the result is written into.
		 * @param src id structure to copy from.
		 */
		[CCode(cname = "git_oid_cpy")]
		public static void copy(out object_id dest, object_id src);

		/**
		 * Copy an id from one structure to another.
		 *
		 * @param dest id structure the result is written into.
		 * @param src id structure to copy from.
		 */
		[CCode(cname = "git_oid_cpy", instance_pos = -1)]
		public void copy_to(out object_id dest);

		/**
		 * Compare two id structures.
		 *
		 * @param a first id structure.
		 * @param b second id structure.
		 * @return <0, 0, >0 if a < b, a == b, a > b.
		 */
		[CCode(cname = "git_oid_cmp")]
		public static int compare(object_id a, object_id b);

		/**
		 * Compare two id structures.
		 *
		 * @param b second id structure.
		 * @return <0, 0, >0 if a < b, a == b, a > b.
		 */
		[CCode(cname = "git_oid_cmp")]
		public int compare_to(object_id b);

		/**
		 * Compare the first 'len' hexadecimal characters (packets of 4 bits)
		 * of two id structures.
		 *
		 * @param a first id structure.
		 * @param b second id structure.
		 * @param len the number of hex chars to compare
		 * @return 0 in case of a match
		 */
		[CCode(cname = "git_oid_ncmp")]
		public static int compare_n(object_id a, object_id b, uint len);

		/**
		 * Compare the first 'len' hexadecimal characters (packets of 4 bits)
		 * of two id structures.
		 *
		 * @param a first id structure.
		 * @param b second id structure.
		 * @param len the number of hex chars to compare
		 * @return 0 in case of a match
		 */
		[CCode(cname = "git_oid_ncmp")]
		public int compare_n_to(object_id b, uint len);

		/**
		 * Determine the id of a buffer containing an object
		 *
		 * The resulting id will the itentifier for the data
		 * buffer as if the data buffer it were to written to the ODB.
		 *
		 * @param id the resulting id.
		 * @param data data to hash
		 * @param type of the data to hash
		 */
		[CCode(cname = "git_odb_hash")]
		public static Error from_data(out object_id id, [CCode(array_length_type = "size_t")] uint8[] data, ObjectType type);

		/**
		 * Read a file from disk and determine the id
		 *
		 * Read the file and compute the id have if it were
		 * written to the database as an object of the given type.
		 * Similar functionality to git's //git hash-object// without
		 * the //-w// flag.
		 *
		 * @param out id structure the result is written into.
		 * @param path file to read and determine object id for
		 * @param type the type of the object that will be hashed
		 */
		[CCode(cname = "git_odb_hashfile")]
		public static Error hashfile(out object_id id, string path, ObjectType type);
	}

	/**
	 * Object ID Shortener object
	 */
	[CCode(cname = "git_oid_shorten", free_function = "git_oid_shorten_free")]
	[Compact]
	public class IdShortener {
		/**
		 * Create a new id shortener.
		 *
		 * The id shortener is used to process a list of ids
		 * in text form and return the shortest length that would
		 * uniquely identify all of them.
		 *
		 * (e.g., look at the result of //git log --abbrev//)
		 *
		 * @param min_length The minimal length for all identifiers,
		 *		which will be used even if shorter ids would still
		 *		be unique.
		 */
		[CCode(cname = "git_oid_shorten_new")]
		public IdShortener(size_t min_length);

		/**
		 * Add a new id to set of shortened ids and calculate
		 * the minimal length to uniquely identify all the ids in
		 * the set.
		 *
		 * The id is expected to be a 40-char hexadecimal string.
		 *
		 * For performance reasons, there is a hard-limit of how many
		 * ids can be added to a single set (around ~22000, assuming
		 * a mostly randomized distribution), which should be enough
		 * for any kind of program, and keeps the algorithm fast and
		 * memory-efficient.
		 *
		 * Attempting to add more than those ids will result in a
		 * {@link Error.NOMEM} error
		 *
		 * @param text_id an id in text form
		 * @return the minimal length to uniquely identify all ids
		 *		added so far to the set; or an error code (<0) if an
		 *		error occurs.
		 */
		[CCode(cname = "git_oid_shorten_add")]
		public int add(string text_id);
	}

	/**
	 * An action signature (e.g. for committers, taggers, etc)
	 */
	[CCode(cname = "git_signature", free_function = "git_signature_free", copy_function = "git_signature_dup")]
	[Compact]
	public class Signature {
		/**
		 * Full name of the author
		 */
		public string name;
		/**
		 * Email of the author
		 */
		public string email;
		/**
		 * Time when the action happened
		 */
		public time when;

		/**
		 * Create a new action signature.
		 *
		 * @param sig new signature, null in case of error
		 * @param name name of the person
		 * @param email email of the person
		 * @param time time when the action happened
		 * @param offset timezone offset in minutes for the time
		 */
		[CCode(cname = "git_signature_new")]
		public static int create(out Signature ? sig, string name, string email, int64 time, int offset);

		/**
		 * Create a new action signature with a timestamp of now.
		 *
		 * @param sig new signature, null in case of error
		 * @param name name of the person
		 * @param email email of the person
		 */
		[CCode(cname = "git_signature_now")]
		public static int create_now(out Signature ? sig, string name, string email);
	}

	[CCode(cname = "int", cprefix = "GIT_STATUS_")]
	public enum Status {
		CURRENT,
		INDEX_NEW,
		INDEX_MODIFIED,
		INDEX_DELETED,
		WT_NEW,
		WT_MODIFIED,
		WT_DELETED,
		IGNORED
	}
	public delegate Error StatusCallback(string file, Status status);

	/**
	 * This is passed as the first argument to the callback to allow the
	 * user to see the progress.
	 */
	[CCode(cname = "git_indexer_stats")]
	public struct indexer_stats {
		uint total;
		uint processed;
	}

	[CCode(cname = "git_indexer", free_function = "git_indexer_free")]
	public class Indexer {
		/**
		 * Create a new indexer instance
		 *
		 * @param indexer where to store the indexer instance
		 * @param packname the absolute filename of the packfile to index
		 */
		[CCode(cname = "git_indexer_new")]
		public Error create(out Indexer indexer, string packname);

		/**
		 * Iterate over the objects in the packfile and extract the information
		 *
		 * Indexing a packfile can be very expensive so this function is
		 * expected to be run in a worker thread and the stats used to provide
		 * feedback the user.
		 *
		 * @param stats storage for the running state
		 */
		[CCode(cname = "git_indexer_run")]
		public Error runt(indexer_stats stats);

		/**
		 * Write the index file to disk.
		 *
		 * The file will be stored as pack-//hash//.idx in the same directory as
		 * the packfile.
		 */
		[CCode(cname = "git_indexer_write")]
		public Error write();

		/**
		 * Get the packfile's hash
		 *
		 * A packfile's name is derived from the sorted hashing of all object
		 * names. This is only correct after the index has been written to disk.
		 */
		[CCode(cname = "git_indexer_hash")]
		public unowned object_id? get_hash();
	}

	[CCode(cname = "GIT_DEFAULT_PORT")]
	public const string DEFAULT_PORT;

	[CCode(cname = "int", cprefix = "GIT_DIR_")]
	public enum Direction {
		FETCH, PUSH
	}

	/**
	 * Remote head description, given out on `ls` calls.
	 */
	[CCode(cname = "struct git_remote_head")]
	public struct remote_head {
		public bool local;
		[CCode(cname = "oid")]
		public object_id id;
		[CCode(cname = "loid")]
		public object_id l_id;
		public unowned string name;
	}

	/**
	 * Array of remote heads
	 */
	[CCode(cname = "git_headarray")]
	public struct head_array {
		[CCode(array_lenth_cname = "len", array_length_type = "unsigned int")]
		remote_head[] heads;
	}

	[CCode(cname = "git_strarray", destroy_function = "git_strarray_free")]
	public struct string_array {
		[CCode(array_length_cname = "count", array_length_type = "size_t")]
		string[] strings;
	}
}
