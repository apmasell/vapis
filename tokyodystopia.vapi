[CCode(cheader_filename = "dystopia.h")]
namespace TokyoDystopia {
	[CCode(cname = "uint32_t", cprefix = "IDBX")]
	[Flags]
	public enum ExOptions {
		/**
		 * No text mode
		 */
		NOTXT
	}
	[CCode(cname = "int", cprefix = "IDBO")]
	[Flags]
	public enum Open {
		/**
		 * Connect as a reader
		 */
		READER,
		/**
		 * Connect as a writer
		 */
		WRITER,
		/**
		 * Creates a new database if not exist
		 * @see WRITER
		 */
		CREAT,
		/**
		 * Creates a new database regardless if one exists
		 * @see WRITER
		 */
		TRUNC,
		/**
		 * Opens the database directory without file locking
		 */
		NOLCK,
		/**
		 * Locking is performed without blocking
		 */
		LCKNB
	}

	[CCode(cname = "uint8_t", cprefix = "IDBT")]
	[Flags]
	public enum Options {
		/**
		 * The size of the database can be larger than 2GB by using 64-bit bucket array
		 */
		LARGE,
		/**
		 * Each page is compressed with Deflate encoding
		 */
		DEFLATE,
		/**
		 * Each page is compressed with BZIP2 encoding
		 */
		BZIP,
		/**
		 * Each page is compressed with TCBS encoding
		 */
		TCBS
	}

	[CCode(cname = "int", cprefix = "IDBS")]
	[Flags]
	public enum Search {
		/**
		 * Substring matching
		 */
		SUBSTR,
		/**
		 * Prefix matching
		 */
		PREFIX,
		/**
		 * Suffix matching
		 */
		SUFFIX,
		/**
		 * Full matching
		 */
		FULL,
		/**
		 * Token matching
		 */
		TOKEN,
		/**
		 * Token prefix matching
		 */
		TOKPRE,
		/**
		 * Token suffix matching
		 */
		TOKSUF
	}

	[CCode(cname = "TCIDB", free_function = "tcidbdel")]
	[Compact]
	public class Index {
		[CCode(cname = "tcidbnew")]
		public Index();


		/**
		 * The number of records of an indexed database object.
		 */
		public uint64 count {
			[CCode(cname = "tcidbrnum")]
			get;
		}
		/**
		 * The file descriptor for debugging output.
		 */
		public int debug_fd {
			[CCode(cname = "tcidbsetdbgfd")]
			set;
			[CCode(cname = "tcidbdbgfd")]
			get;
		}
		/**
		 * Get the last happened error code of an indexed database object.
		 */
		public TokyoCabinet.ErrorCode error {
			[CCode(cname = "tcidbecode")]
			get;
		}
		/**
		 * The expert options of an indexed database object.
		 */
		public ExOptions ex_opts {
			[CCode(cname = "tcidbsetexopts")]
			get;
		}
		/**
		 * The inode number of the database directory of an indexed database object.
		 */
		public uint64 inode {
			[CCode(cname = "tcidbinode")]
			get;
		}
		/**
		 * The modification time of the database directory of an indexed database object.
		 */
		public time_t mtime {
			[CCode(cname = "tcidbmtime")]
			get;
		}
		/**
		 * The options of an indexed database object.
		 */
		public Options opts {
			[CCode(cname = "tcidbopts")]
			get;
		}
		/**
		 * The directory path of an indexed database object.
		 *
		 * Null if the object does not connect to any database directory.
		 */
		public string? path {
			[CCode(cname = "tcidbpath")]
			get;
		}
		/**
		 * Get the total size of the database files of an indexed database object.
		 */
		public uint64 size {
			[CCode(cname = "tcidbfsiz")]
			get;
		}
		/**
		 *  Close an indexed database object.
		 *
		 * Update of a database is assured to be written when the database is closed. If a writer opens
		 a database but does not close it appropriately, the database will be broken.
		 */
		[CCode(cname = "tcidbclose")]
		public bool close();
		/**
		 * Copy the database directory of an indexed database object.
		 *
		 * The database directory is assured to be kept synchronized and not modified while the copying or executing operation is in progress.  So, this function is useful to create a backup directory of the database directory.
		 * @param path specifies the path of the destination directory. If it begins with '''@''', the trailing substring is executed as a command line.
		 * @return If successful, the return value is true, else, it is false.  False is returned if the executed command returns non-zero code.
		 */
		[CCode(cname = "tcidbcopy")]
		public bool copy(string path);
		/**
		 * Initialize the iterator of an indexed database object.
		 *
		 * The iterator is used in order to access the ID number of every record stored in a database.
		 * @return If successful, the return value is true, else, it is false.
		 */
		[CCode(cname = "tcidbiterinit")]
		public bool iter_init();
		/**
		 * Get the next ID number of the iterator of an indexed database object.
		 *
		 * It is possible to access every record by iteration of calling this function.  It is allowed to update or remove records whose keys are fetched while the iteration.  However, it is not assured if updating the database is occurred while the iteration.  Besides, the order of this traversal access method is arbitrary, so it is not assured that the order of storing matches the one of the traversal access.
		 * @return If successful, the return value is the ID number of the next record, else, it is 0.  0 is returned when no record is to be get out of the iterator.
		 */
		[CCode(cname = "tcidbiternext")]
		public uint64 iter_next();
		/**
		 * Retrieve a record of an indexed database object.
		 * @param id specifies the ID number of the record.  It should be positive.
		 * @return If successful, the return value is the string of the corresponding record, else, it is null.
		 */
		[CCode(cname = "tcidbget")]
		public string? get(int64 id);
		/**
		 * Synchronize updating contents on memory of an indexed database object.
		 * @param level specifies the synchronization lavel; 0 means cache synchronization, 1 means database synchronization, and 2 means file synchronization.
		 * @return If successful, the return value is true, else, it is false.
		 */
		[CCode(cname = "tcidbmemsync")]
		public bool mem_sync(int level);
		/**
		 * Open an indexed database object.
		 * @param path specifies the path of the database directory.
		 * @return If successful, the return value is true, else, it is false.
		 */
		[CCode(cname = "tcidbopen")]
		public bool open(string path, Open mode);
		/**
		 * Optimize the files of an indexed database object.
		 *
		 * This function is useful to reduce the size of the database files with data fragmentation by successive updating.
		 * @return If successful, the return value is true, else, it is false.
		 */
		[CCode(cname = "tcidboptimize")]
		public bool optimize();
		/**
		 * Remove a record of an indexed database object.
		 * @param id specifies the ID number of the record.  It should be positive.
		 * @return If successful, the return value is true, else, it is false.
		 */
		[CCode(cname = "tcidbout")]
		public bool remove(int64 id);
		/**
		 * Search an indexed database.
		 * @param word specifies the string of the word to be matched to.
		 * @return If successful, the return value is the pointer to an array of ID numbers of the corresponding records.  Null is returned on failure.
		 */
		[CCode(cname = "tcidbsearch")]
		public uint64[]? search(string word, Search smode);
		/**
		 * Search an indexed database with a compound expression.
		 * @param expr specifies the string of the compound expression.
		 * @return If successful, the return value is the pointer to an array of ID numbers of the corresponding records.  Null is returned on failure.
		 */
		[CCode(cname = "tcidbsearch2")]
		public uint64[]? search_expr(string expr);
		/**
		 * Store a record into an indexed database object.
		 * @param id specifies the ID number of the record. It should be positive.
		 * @param text specifies the string of the record, whose encoding should be UTF-8.
		 * @return If successful, true, else, false.
		 */
		[CCode(cname = "tcidbput")]
		bool set(int64 id, string text);
		/**
		 * Set the callback function for sync progression of an indexed database object.
		 */
		[CCode(cname = "tcidbsetsynccb")]
		void set_sync_cb(SyncCallback cb);
		/**
		 * Synchronize updated contents of an indexed database object with the files and the device.
		 *
		 * This function is useful when another process connects the same database directory.
		 * @return If successful, the return value is true, else, it is false.
		 */
		[CCode(cname = "tcidbsync")]
		public bool sync();
		/**
		 * Set the tuning parameters of an indexed database object.
		 *
		 * Note that the tuning parameters should be set before the database is opened.
		 * @param ernum specifies the expected number of records to be stored.  If it is not more than 0, the default value is specified.  The default value is 1000000.
		 * @param etnum specifies the expected number of tokens to be stored.  If it is not more than 0, the default value is specified.  The default value is 1000000.
		 * @param iusiz specifies the unit size of each index file.  If it is not more than 0, the default value is specified.  The default value is 536870912.
		 *
   If successful, the return value is true, else, it is false.
	 */
		[CCode(cname = "tcidbtune")]
		public bool tune(int64 ernum, int64 etnum, int64 iusiz, Options opts);
		/**
		 * Remove all records of an indexed database object.
		 * @return If successful, the return value is true, else, it is false.
		 */
		[CCode(cname = "tcidbvanish")]
		public bool vanish();

	}
	/**
	 * Get the message string corresponding to an error code.
   */
	[CCode(cname = "tcidberrmsg")]
	public unowned string err_msg(TokyoCabinet.ErrorCode ecode);

	/**
	 * Sync progression callback.
	 * @param num_tokens the number of tokens to be synchronized
	 * @param num_processed the number of processed tokens
	 * @param message the message string.
	 * @return Should be true usually, or false if the sync operation should be terminated.
	 */
	public delegate bool SyncCallback(int num_tokens, int num_processed, string message);
}
