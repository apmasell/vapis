[CCode(cheader_filename = "gdbm.h")]
namespace GDBM {

	/**
	 * Configuration mode for opening a database.
	 */
	[Flags]
	[CCode(cprefix = "GDBM_", type = "int", has_type_id = false)]
	public enum OpenFlag {
		/**
		 * Open file as reader.
		 */
		READER,
		/**
		 * Open file as writer.
		 */
		WRITER,
		/**
		 * Open as a writer and create the file if it doesn't exist.
		 */
		WRCREAT,
		/**
		 * Open as a writer and overwrite any existing file.
		 */
		NEWDB,
		/**
		 * All database operations should be synchronized to the disk.
		 */
		SYNC,
		/**
		 * Do not perform any locking on the database file.
		 */
		NOLOCK,
		/**
		 * No-sync mode (now the default).
		 */
		[Deprecated]
		FAST
	}

	[SimpleType]
	[CCode(cname = "datum", destroy_function = "", has_type_id = false)]
	private struct rdatum {
		[CCode(cname = "dptr", array_length_cname = "dsize", array_length_type = "int")]
		uint8[] data;
	}

	[SimpleType]
	[CCode(cname = "datum", has_destroy_function = false, has_type_id = false)]
	private struct datum {
		[CCode(array_length = false)]
		unowned uint8[] dptr;
		int dsize;
	}


	/**
	 * The gdbm build release string.
	 */
	[CCode(cname = "gdbm_version")]
	public const string VERSION;

	[CCode(type = "int", cprefix = "GDBM_", has_type_id = false)]
	private enum Option {
		CACHESIZE,
		FASTMODE,
		SYNCMODE,
		CENTFREE,
		COALESCEBLKS
	}

	/**
	 * Delegate for the handler when database opening fails
	 */
	[CCode(has_target = false, has_type_id = false)]
	public delegate void FatalHandler();

	/**
	 * Access handle to a gdbm database.
	 *
	 * GNU dbm is a library of routines that manages data files that contain key/data pairs. The access provided is that of storing, retrieval, and deletion by key and a non-sorted traversal of all keys. A process is allowed to use multiple data files at the same time.
	 * A process that opens a gdbm file is designated as a "reader" or a "writer". Only one writer may open a gdbm file and many readers may open the file. Readers and writers can not open the gdbm file at the same time.
	 */
	[Compact]
	[CCode(cname = "void", cprefix = "gdbm_", free_function = "gdbm_close", has_type_id = false)]
	public class Database {

		private int @delete (datum key);
		private bool exists (datum key);
		private rdatum fetch (datum key);
		private rdatum firstkey ();
		private rdatum nextkey (datum previous);
		private int reorganize ();
		private int setopt (Option option, int* value, int size);
		private int store (datum key, datum content, [CCode(type = "int")] bool replace);

		/**
		 * Open a database.
		 *
		 * @param filename specifies the database file.
		 * @param blocksize is meaningful only when creating a new gdbm database; it is the retrieval block size to be used for the file. If a number less than 256 is given, the system stat page size will be used, but if you are storing large chunks of data in your file, you may want to consider bumping blocksize up.
		 * @param flag specifies the access mode. There may be only one writer at a time, but an arbitrary number of readers. If a file is open for writing, attempts to open it for reading will fail.
		 * @param mode specifies the mode of a newly created database file; it takes the same form as for Unix chmod, so for instance 0666 is read-write access for everybody.
		 * @param handler can be used to assign an error handler; the function should take a single string. If you specify null for this function, gdbm uses a default handler.
		 */
		public static Database open (string filename, int block_size, OpenFlag flag, int mode = 0644, FatalHandler? handler = null);

		/**
		 * Compact the database
		 *
		 * If you have had a lot of deletions and would like to shrink the space used by the gdbm file, this routine will reorganize the database. Gdbm will not shorten the length of a gdbm file except by using this reorganization. (Deleted file space will be reused.) It should be used very infrequently.
		 */
		public bool compact() {
			return this.reorganize() == 0;
		}

		/**
		 * Search the database without retrieving data.
		 *
		 * @param key the data to be searched.
		 * @return Returns true if the key is within the database.
		 */
		public bool contains (uint8[] key) {
			datum k;
			k.dptr = key;
			k.dsize = key.length;
			return exists(k);
		}

		/**
		 * Retrieve the "first" key in the database.
		 */
		public uint8[] first_key() {
			return this.firstkey().data;
		}

		/**
		 * Retrieve data from the database
		 *
		 * Get data from the database.
		 * @param key is the key data.
		 * @return If the return value is null, no data was found. Otherwise the return value is the found data.
		 */
		public uint8[]? @get (uint8[] key) {
			datum k;
			k.dptr = key;
			k.dsize = key.length;
			return (owned) this.fetch(k).data;
		}

		/**
		 * Retrieve the following key in the database.
		 *
		 * This access is not key sequential, but it is guaranteed to visit every key in the database once. Key order can be rearrange if the database is modified!
		 * @param key the preceding key
		 */
		public uint8[]? next_key(uint8[] key) {
			datum k;
			k.dptr = key;
			k.dsize = key.length;
			return this.nextkey(k).data;
		}

		/**
		 * Remove some data from the database
		 *
		 * @param key the data to be deleted.
		 * @return true if the data was deleted, false if the database is a reader or the data does not exist.
		 */
		public bool remove (uint8[] key) {
			datum k;
			k.dptr = key;
			k.dsize = key.length;
			return this.delete(k) == 0;
		}

		/**
		 * Store data in the database.
		 *
		 * If you store data for a key that is already in the database, gdbm replaces the old data with the new data if called with replacement. You do not get two data items for the same key and you do not get an error.
		 *
		 * The size in gdbm is not restricted like dbm or ndbm. Your data can be as large as you want.
		 *
		 * @param key is the key data.
		 * @param content is the data to be associated with the key.
		 * @param replace Replace contents if key exists otherwise insert only, generate an error if key exists.
		 */
		public bool save(uint8[] key, uint8[] content, bool replace) {
			datum k;
			k.dptr = key;
			k.dsize = key.length;
			datum c;
			c.dptr = content;
			c.dsize = content.length;
			return this.store(k, c, replace) == 0;
		}

		/**
		 * Update the database overwriting the existing data.
		 */
		public void @set (uint8[] key, uint8[] content) {
			this.save(key, content, true);
		}

		/**
		 * Flush changes to disk.
		 *
		 * This will not return until the disk file state is syncronized with the in-memory state of the database.
		 */
		public void sync ();

		/**
		 * Set the size of the internal bucket cache.
		 *
		 * This option may only be set once on each database descriptor, and is set automatically to 100 upon the first access to the database.
		 */
		public int CacheSize {
			set {
				this.setopt(Option.CACHESIZE, &value, (int) sizeof(int));
			}
		}

		/**
		 * Set central free block pool to either on or off.
		 *
		 * The default is off, which is how previous versions of gdbm handled free blocks. If set, this option causes all subsequent free blocks to be placed in the global pool, allowing (in theory) more file space to be reused more quickly.
		 */
		public bool CentralFreeBlocks {
			set {
				int v = value ? 1 : 0;
				this.setopt(Option.CENTFREE, &v, (int) sizeof(int));
			}
		}

		/**
		 * Set free block merging to either on or off.
		 *
		 * The default is off, which is how previous versions of gdbm handled free blocks. If set, this option causes adjacent free blocks to be merged. This can become a CPU expensive process with time, though, especially if used in conjunction with CentralFreeBlocks.
		 */
		public bool CoalesceBlocks {
			set {
				int v = value ? 1 : 0;
				this.setopt(Option.COALESCEBLKS, &v, (int) sizeof(int));
			}
		}
		/**
		 * Set fast mode to either on or off.
		 *
		 * This allows fast mode to be toggled on an already open and active database. This option is now obsolete.
		*/
		[Deprecated]
		public bool FastMode {
			set {
				int v = value ? 1 : 0;
				this.setopt(Option.FASTMODE, &v, (int) sizeof(int));
			}
		}

		/**
		 * Turn on or off file system synchronization operations.
		 *
		 * This setting defaults to off.
		 */
		public bool SyncMode {
			set {
				int v = value ? 1 : 0;
				this.setopt(Option.SYNCMODE, &v, (int) sizeof(int));
			}
		}

		/**
		 * The file descriptor used by the database.
		 */
		public int descriptor {
			[CCode(cname = "gdbm_fdesc")]
			get;
		}
	}

	/**
	 * Error codes set by database operations.
	 */
	[CCode(type = "gdbm_error", cprefix = "GDBM_", has_type_id = false)]
	public enum Error {
		/**
		 * No error
		 */
		NO_ERROR,
		/**
		 * Malloc error
		 */
		MALLOC_ERROR,
		/**
		 * Block size error
		 */
		BLOCK_SIZE_ERROR,
		/**
		 * File open error
		 */
		FILE_OPEN_ERROR,
		/**
		 * File write error
		 */
		FILE_WRITE_ERROR,
		/**
		 * File seek error
		 */
		FILE_SEEK_ERROR,
		/**
		 * File read error
		 */
		FILE_READ_ERROR,
		/**
		 * Bad magic number
		 */
		BAD_MAGIC_NUMBER,
		/**
		 * Empty database
		 */
		EMPTY_DATABASE,
		/**
		 * Can't be reader
		 */
		CANT_BE_READER,
		/**
		 * Can't be writer
		 */
		CANT_BE_WRITER,
		/**
		 * Reader can't delete
		 */
		READER_CANT_DELETE,
		/**
		 * Reader can't store
		 */
		READER_CANT_STORE,
		/**
		 * Reader can't reorganize
		 */
		READER_CANT_REORGANIZE,
		/**
		 * Unknown update
		 */
		UNKNOWN_UPDATE,
		/**
		 * Item not found
		 */
		ITEM_NOT_FOUND,
		/**
		 * Reorganize failed
		 */
		REORGANIZE_FAILED,
		/**
		 * Cannot replace
		 */
		CANNOT_REPLACE,
		/**
		 * Illegal data
		 */
		ILLEGAL_DATA,
		/**
		 * Option already set
		 */
		OPT_ALREADY_SET,
		/**
		 * Illegal option
		 */
		OPT_ILLEGAL;
		[CCode(cname = "gdbm_strerror")]
		public unowned string to_string();
	}

	/**
	 * Error code of the last database operation.
	 */
	[CCode(cname = "gdbm_errno")]
	public static Error errno;
}
