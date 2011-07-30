[CCode(cheader_filename = "libtransmission/transmission.h", lower_case_cprefix = "tr_", cprefix="TR_")]
namespace Transmission {

	public const int SHA_DIGEST_LENGTH;
	public const int TR_INET6_ADDRSTRLEN;
	public const string RPC_SESSION_ID_HEADER;

	[SimpleType]
	[CCode (cname = "tr_file_index", has_destroy_function = false, has_copy_function = false)]
	public struct FileIndex { }

	[CCode(cname = "tr_preallocation_mode", cprefix="TR_PREALLOCATE_")]
	public enum PreallocationMode {
		NONE,
		SPARSE,
		FULL
	}

	[CCode(cname = "tr_encryption_mode", cprefix="TR_")]
	public enum EncryptionMode {
		CLEAR_PREFERRED,
		ENCRYPTION_PREFERRED,
		ENCRYPTION_REQUIRED
	}

	/**
	 * Transmission's default configuration file directory.
	 *
	 * The default configuration directory is determined this way:
	 * # If the TRANSMISSION_HOME environment variable is set, its value is used.
	 * # On Darwin, "${HOME}/Library/Application Support/${appname}" is used.
	 * # On Windows, "${CSIDL_APPDATA}/${appname}" is used.
	 * # If XDG_CONFIG_HOME is set, "${XDG_CONFIG_HOME}/${appname}" is used.
	 * # ${HOME}/.config/${appname}" is used as a last resort.
	 */
	public unowned string getDefaultConfigDir(string appname);

	/**
	 * Transmisson's default download directory.
	 *
	 * The default download directory is determined this way:
	 * # If the HOME environment variable is set, "${HOME}/Downloads" is used.
	 * # On Windows, "${CSIDL_MYDOCUMENTS}/Downloads" is used.
	 * # Otherwise, getpwuid(getuid())->pw_dir + "/Downloads" is used.
	 */
	public unowned string getDefaultDownloadDir();

	[CCode(cprefix = "TR_DEFAULT_")]
	namespace Defaults {
		public const string BIND_ADDRESS_IPV4;
		public const string BIND_ADDRESS_IPV6;
		public const string RPC_WHITELIST;
		public const string RPC_PORT_STR;
		public const string RPC_URL_STR;
		public const string PEER_PORT_STR;
		public const string PEER_SOCKET_TOS_STR;
		public const string PEER_LIMIT_GLOBAL_STR;
		public const string PEER_LIMIT_TORRENT_STR;
	}

	[CCode(cprefix = "TR_PREFS_KEY_")]
	namespace Prefs {
		public const string ALT_SPEED_ENABLED;
		public const string ALT_SPEED_UP_KBps;
		public const string ALT_SPEED_DOWN_KBps;
		public const string ALT_SPEED_TIME_BEGIN;
		public const string ALT_SPEED_TIME_ENABLED;
		public const string ALT_SPEED_TIME_END;
		public const string ALT_SPEED_TIME_DAY;
		public const string BIND_ADDRESS_IPV4;
		public const string BIND_ADDRESS_IPV6;
		public const string BLOCKLIST_ENABLED;
		public const string BLOCKLIST_URL;
		public const string MAX_CACHE_SIZE_MB;
		public const string DHT_ENABLED;
		public const string UTP_ENABLED;
		public const string LPD_ENABLED;
		public const string PREFETCH_ENABLED;
		public const string DOWNLOAD_DIR;
		public const string ENCRYPTION;
		public const string IDLE_LIMIT;
		public const string IDLE_LIMIT_ENABLED;
		public const string INCOMPLETE_DIR;
		public const string INCOMPLETE_DIR_ENABLED;
		public const string MSGLEVEL;
		public const string PEER_LIMIT_GLOBAL;
		public const string PEER_LIMIT_TORRENT;
		public const string PEER_PORT;
		public const string PEER_PORT_RANDOM_ON_START;
		public const string PEER_PORT_RANDOM_LOW;
		public const string PEER_PORT_RANDOM_HIGH;
		public const string PEER_SOCKET_TOS;
		public const string PEER_CONGESTION_ALGORITHM;
		public const string PEX_ENABLED;
		public const string PORT_FORWARDING;
		public const string PREALLOCATION;
		public const string RATIO;
		public const string RATIO_ENABLED;
		public const string RENAME_PARTIAL_FILES;
		public const string RPC_AUTH_REQUIRED;
		public const string RPC_BIND_ADDRESS;
		public const string RPC_ENABLED;
		public const string RPC_PASSWORD;
		public const string RPC_PORT;
		public const string RPC_USERNAME;
		public const string RPC_URL;
		public const string RPC_WHITELIST_ENABLED;
		public const string SCRAPE_PAUSED_TORRENTS;
		public const string SCRIPT_TORRENT_DONE_FILENAME;
		public const string SCRIPT_TORRENT_DONE_ENABLED;
		public const string RPC_WHITELIST;
		public const string DSPEED_KBps;
		public const string DSPEED_ENABLED;
		public const string USPEED_KBps;
		public const string USPEED_ENABLED;
		public const string UMASK;
		public const string UPLOAD_SLOTS_PER_TORRENT;
		public const string START;
		public const string TRASH_ORIGINAL;
	}

	/**
	 * Add libtransmission's default settings to the {@link Benc} dictionary.
	 *
	 * @param initme pointer to a tr_benc dictionary
	 */
	[CCode(cname = "tr_sessionGetDefaultSettings")]
	public void GetDefaultSettings(Benc dictionary);

	/**
	 * Load settings from the configuration directory's settings.json file, using libtransmission's default settings as fallbacks for missing keys.
	 *
	 *
	 * @param dictionary pointer to an uninitialized tr_benc
	 * @param configDir the configuration directory to find settings.json
	 * @param appName if configDir is empty, appName is used to find the default dir.
	 * @return success true if the settings were loaded, false otherwise
	 */
	public bool sessionLoadSettings(Benc dictionary, string configDir, string appName);

	[CCode(cheader_filename = "libtransmission/benc.h", cprefix = "TR_FMT_", cname = "tr_fmt_mode")]
	public enum BencFormat {
		BENC,
		JSON,
		JSON_LEAN
	}

	/**
	 * Variant data storage
	 *
	 * An object that acts like a union for integers, strings, lists, dictionaries, booleans, and floating-point numbers. The structure is named Benc due to the historical reason that it was originally tightly coupled with bencoded data. It currently supports being parsed from, and serialized to, both bencoded notation and json notation.
	 *
	 */
	[CCode(cheader_filename = "libtransmission/benc.h", cprefix = "tr_benc", free_function = "tr_bencFree")]
	public class Benc {
		public static int LoadFile(out Benc benc, BencFormat mode, string filename);
		public static int Parse(void* buf, void* buffend, out Benc benc, out unowned uint8[] end);
		public static int Load([CCode(array_lengh_type = "size_t")] uint8[] buf, out Benc benc, out unowned uint8[] end);

		public void InitStr([CCode(array_lengh_type = "int")] char[] raw);
		public void InitRaw([CCode(array_lengh_type = "size_t")] uint8[] raw);
		public void InitInt(int64 num);
		public int InitDict(size_t reserveCount);
		public int InitList(size_t reserveCount);
		public void InitBool(int val);
		public void InitReal(double val);

		public int bencToFile(BencFormat mode, string filename);

		[CCode(array_length_pos = 1.9)]
		public uint8[] ToStr(BencFormat mode);

		public int ListReserve(size_t reserveCount);
		public unowned Benc ListAdd();
		public unowned Benc ListAddBool(bool val);
		public unowned Benc ListAddInt(int64 val);
		public unowned Benc ListAddReal(double val);
		public unowned Benc ListAddStr(string val);
		public unowned Benc ListAddRaw([CCode(array_lengh_type = "size_t")]uint8[] val);
		public unowned Benc ListAddList(size_t reserveCount);
		public unowned Benc ListAddDict(size_t reserveCount);
		public size_t ListSize();
		public unowned Benc ListChild(size_t n);
		public int ListRemove(size_t n);

		public int DictReserve(size_t reserveCount);
		public int DictRemove(string key);
		public unowned Benc DictAdd(string key);
		public unowned Benc DictAddReal(string key, double val);
		public unowned Benc DictAddInt(string key, int64 val);
		public unowned Benc DictAddBool(string key, bool val);
		public unowned Benc DictAddStr(string key, string val);
		public unowned Benc DictAddList(string key, size_t reserve);
		public unowned Benc DictAddDict(string key, size_t reserve);
		public unowned Benc DictAddRaw(string key, [CCode(array_lengh_type = "size_t")]uint8[] raw);
		public bool DictChild(size_t i, out string key, out Benc val);
		public unowned Benc DictFind(string key);
		public bool DictFindList(string key, out unowned Benc setme);
		public bool DictFindDict(string key, out unowned Benc setme);
		public bool DictFindInt(string key, out int64 setme);
		public bool DictFindReal(string key, out double setme);
		public bool DictFindBool(string key, out bool setme );
		public bool DictFindStr(string key, out unowned string setme );
		public bool DictFindRaw(string key, [CCode(array_lengh_type = "size_t")]out uint8 raw);

		/**
		 * Get an int64 from a variant object
		 *
		 * @return true if successful, or false if the variant could not be represented as an int64
		 */
		public bool GetInt(int64 val);

		/**
		 * Get an string from a variant object
		 *
		 * @return true if successful, or false if the variant could not be represented as a string
		*/
		public bool GetStr(out string val);

		/**
		 * Get a raw byte array from a variant object
		 *
		 * @return true if successful, or false if the variant could not be represented as a raw byte array
		*/
		public bool GetRaw([CCode(array_lengh_type = "size_t")]out uint8[] raw);

		/**
		 * Get a boolean from a variant object
		 *
		 * @return true if successful, or false if the variant could not be represented as a boolean
		*/
		public bool GetBool(bool val);

		/**
		 * Get a floating-point number from a variant object
		 *
		 * @return true if successful, or false if the variant could not be represented as a floating-point number
		*/
		public bool GetReal(double val);

		public bool IsInt();
		public bool IsDict();
		public bool IsList();
		public bool IsString();
		public bool IsBool();
		public bool IsReal();
	}

	[CCode(cname = "tr_session", cprefix = "tr_session", free_function = "tr_sessionClose")]
	[Compact]
	public class Session {
		/**
		 * Add the session's current configuration settings to the benc dictionary.
		 */
		public void GetSettings(Benc dictionary);

		/**
		* Add the session's configuration settings to the benc dictionary and save it to the configuration directory's settings.json file.
		*/
		public void SaveSettings(string configDir, Benc dictonary);

		/**
		 * Initialize a libtransmission session.
		 *
		 * @param tag "gtk", "macosx", "daemon", etc... this is only for pre-1.30 resume files
		 * @param configDir where Transmission will look for resume files, blocklists, etc.
		 * @param messageQueueingEnabled if false, messages will be dumped to stderr
		 * @param settings libtransmission settings
		 */
		[CCode(cname = "tr_sessionInit")]
		public Session(string tag, string configDir, bool messageQueueingEnabled, Benc settings);

		/**
		 * Update a session's settings from a benc dictionary like to the one used in Init().
		 */
		public void Set(Benc settings);

		/**
		 * Rescan the blocklists directory and reload whatever blocklist files are found there
		 */
		public void ReloadBlocklists();

		/**
		 * Return the session's configuration directory.
		 *
		 * This is where transmission stores its .torrent files, .resume files, blocklists, etc. It's set during initialisation and is immutable during the session.
		 */
		public unowned string GetConfigDir();

		/**
		 * Set the per-session default download folder for new torrents.
		 */
		public void SetDownloadDir(string downloadDir);

		/**
		 * Get the default download folder for new torrents.
		 *
		 * This is set {@link Session.SetDownloadDir}, and can be overridden on a per-torrent basis by {@link TorrentConstructor.SetDownloadDir}.
		 */
		public unowned string GetDownloadDir();

		/**
		 * Get available disk space (in bytes) for the default download folder.
		 * @return zero or positive integer on success, -1 in case of error.
		 */
		public int64 GetDownloadDirFreeSpace();

		/**
		* Set the per-session incomplete download folder.
		*
		* When you add a new torrent and the session's incomplete directory is enabled, the new torrent will start downloading into that directory, and then be moved to downloadDir when the torrent is finished downloading.
		*
		* Torrents aren't moved as a result of changing the session's incomplete dir -- it's applied to new torrents, not existing ones.
		*
		* {@link Torrent.SetLocation} overrules the incomplete dir: when a user specifies a new location, that becomes the torrent's new downloadDir and the torrent is moved there immediately regardless of whether or not it's complete.
		*/
		public void SetIncompleteDir(string dir);

		/**
		 * Get the per-session incomplete download folder
		 */
		public unowned string GetIncompleteDir();

		/**
		 * Enable or disable use of the incomplete download folder
		 */
		public void SetIncompleteDirEnabled(bool useincomplete);

		/**
		 * Get whether or not the incomplete download folder is enabled
		 */
		public bool IsIncompleteDirEnabled();

		/**
		 * When enabled, newly-created files will have ".part" appended to their filename until the file is fully downloaded
		 *
		 * This is not retroactive -- toggling this will not rename existing files. It only applies to new files created by Transmission after this API call.
		 */
		public void SetIncompleteFileNamingEnabled(bool incompletefilenames);

		/**
		 * Return true if files will end in ".part" until they're complete
		 */
		public bool IsIncompleteFileNamingEnabled();

		/**
		 * Set whether or not RPC calls are allowed in this session.
		 *
		 * If true, libtransmission will open a server socket to listen for incoming http RPC requests as described in docs/rpc-spec.txt.
		 */
		public void SetRPCEnabled(bool isEnabled);

		/**
		 * Get whether or not RPC calls are allowed in this session.
		 */
		public bool IsRPCEnabled();

		/**
		 * Specify which port to listen for RPC requests on.
		 */
		public void SetRPCPort(uint32 port);

		/**
		 * Get which port to listen for RPC requests on.
		 */
		public uint32 GetRPCPort();

		/**
		 * Specify which base URL to use.
		 *
		 * The RPC API is accessible under $url/rpc, the web interface under $url/web.
		 */
		public void SetRPCUrl(string url);

		/**
		 * Get the base URL.
		 */
		public unowned string GetRPCUrl();

		/**
		 * Specify a whitelist for remote RPC access
		 *
		 * The whitelist is a comma-separated list of dotted-quad IP addresses to be allowed. Wildmat notation is supported, meaning that '?' is interpreted as a single-character wildcard and '*' is interprted as a multi-character wildcard.
		 */
		public void SetRPCWhitelist(string whitelist);

		/**
		 * Get the Access Control List for allowing/denying RPC requests.
		 * @return a comma-separated string of whitelist domains.
		 */
		public unowned string GetRPCWhitelist();

		public void SetRPCWhitelistEnabled(bool isEnabled);

		public bool GetRPCWhitelistEnabled();

		public void SetRPCPassword(string password);

		public void SetRPCUsername(string username);

		/**
		 * Get the password used to restrict RPC requests.
		 */
		public unowned string GetRPCPassword();

		public unowned string GetRPCUsername();

		public void SetRPCPasswordEnabled(bool isEnabled);

		public bool IsRPCPasswordEnabled();

		public string GetRPCBindAddress();

		/**
		* Register to be notified whenever something is changed via RPC, such as a torrent being added, removed, started, stopped, etc.
		*
		* The function is invoked FROM LIBTRANSMISSION'S THREAD! This means the function must be fast (to avoid blocking peers), shouldn't call libtransmission functions (to avoid deadlock), and shouldn't modify client-level memory without using a mutex!
		*/
		public void SetRPCCallback(Callback func);

		/**
		 * Get bandwidth use statistics for the current session
		 */
		public void GetStats(out Stats stats);

		/**
		 * Get cumulative bandwidth statistics for current and past sessions
		 */
		public void GetCumulativeStats(out Stats stats);

		public void ClearStats();

		/**
		 * Set whether or not torrents are allowed to do peer exchanges.
		 *
		 * PEX is always disabled in private torrents regardless of this. In public torrents, PEX is enabled by default.
		 */
		public void SetPexEnabled(bool isEnabled);
		public bool IsPexEnabled();

		public bool IsDHTEnabled();
		public void SetDHTEnabled(bool isEnabled);

		public bool IsUTPEnabled();
		public void SetUTPEnabled(bool isEnabled);

		public bool IsLPDEnabled();
		public void SetLPDEnabled(bool enabled);

		public void SetCacheLimit_MB(int mb);
		public int GetCacheLimit_MB();

		public EncryptionMode GetEncryption();
		public void SetEncryption(EncryptionMode mode);

		public void SetPortForwardingEnabled(bool enabled);
		public bool IsPortForwardingEnabled();

		public void SetPeerPort(uint32 port);
		public uint32 GetPeerPort();

		public uint32 SetPeerPortRandom();
		public void SetPeerPortRandomOnStart(bool random);
		public bool GetPeerPortRandomOnStart();
		public PortForwarding GetPortForwarding();

		public void SetSpeedLimit_KBps(Direction direction, int kbps);
		public int GetSpeedLimit_KBps(Direction direction);

		public void LimitSpeed(Direction direction, bool limited);
		public bool IsSpeedLimited(Direction direction);

		public void SetAltSpeed_KBps(Direction direction, int bps);
		public int GetAltSpeed_KBps(Direction direction);

		public void UseAltSpeed(bool enabled);
		public bool UsesAltSpeed();

		public void UseAltSpeedTime(bool enabled);
		public bool UsesAltSpeedTime();

		public void SetAltSpeedBegin(int minsSinceMidnight);
		public int GetAltSpeedBegin();

		public void SetAltSpeedEnd(int minsSinceMidnight);
		public int GetAltSpeedEnd();

		public void SetAltSpeedDay(ScheduleDay day );
		public ScheduleDay GetAltSpeedDay ();

		public void ClearAltSpeedFunc ();
		public void SetAltSpeedFunc (AltSpeedFunc func);

		public bool GetActiveSpeedLimit_KBps(Direction dir, out double limit );

		public double GetRawSpeed_KBps(Direction direction);

		public void SetRatioLimited(bool isLimited);
		public bool IsRatioLimited();

		public void SetRatioLimit(double desiredRatio);
		public double GetRatioLimit();

		public void SetIdleLimited(bool isLimited);
		public bool IsIdleLimited();

		public void SetIdleLimit (uint16 idleMinutes);
		public uint16 GetIdleLimit ();

		public void SetPeerLimit(uint16 maxGlobalPeers);
		public uint16 GetPeerLimit();

		public void SetPeerLimitPerTorrent(uint16 maxPeers );
		public uint16 GetPeerLimitPerTorrent();

		public void SetPaused (bool isPaused);
		public bool GetPaused ();

		public void SetDeleteSource(bool deleteSource);
		public bool GetDeleteSource();

		/**
		 * Load all the torrents in the torrent directory.
		 *
		 * This can be used at startup to kickstart all the torrents from the previous session.
		 */
		[CCode(array_length_pos = 1.9)]
		public Torrent[] LoadTorrents(TorrentConstructor ctor);

		public bool IsTorrentDoneScriptEnabled();

		public void SetTorrentDoneScriptEnabled(bool isEnabled);

		public unowned string tr_sessionGetTorrentDoneScript();

		public void SetTorrentDoneScript(string scriptFilename );

		/**
		 * Specify a range of IPs for Transmission to block.
		 *
		 * @param filename The uncompressed ASCII file, or null to clear the blocklist. libtransmission does not keep a handle to `filename' after this call returns, so the caller is free to keep or delete `filename' as it wishes. libtransmission makes its own copy of the file massaged into a binary format easier to search.
		 */
		[CCode(cname = "tr_blocklistSetContent")]
		public int SetContent(string? filename);
		[CCode(cname = "tr_blocklistGetRuleCount")]
		public int GetRuleCount();
		[CCode(cname = "tr_blocklistExists")]
		public bool Exists();
		[CCode(cname = "tr_blocklistIsEnabled")]
		public bool IsEnabled();
		[CCode(cname = "tr_blocklistSetEnabled")]
		public void SetEnabled(bool isEnabled);
		/**
		 * The blocklist that gets updated when an RPC client invokes the "blocklist-update" method
		 */
		[CCode(cname = "tr_blocklistSetURL")]
		public void SetURL(string url);
		[CCode(cname = "tr_blocklistGetURL")]
		public unowned string GetURL();
		[CCode(cname = "tr_torrentFindFromId")]
		public unowned Torrent GetTorrentById (int id);
		[CCode(cname = "tr_torrentFindFromHash")]
		public unowned Torrent GetTorrentByHash ([CCode(array_length = false)] uint8[] hash);
		[CCode(cname = "tr_torrentFindFromMagnetLink")]
		public unowned Torrent GetTorrentByMagnetLink(string link);
	}

	[CCode(cname = "tr_altSpeedFunc")]
	public delegate void AltSpeedFunc (Session session, bool active, bool userDriven);

	[CCode(cname = "tr_sched_day", cprefix = "TR_SCHED_")]
	[Flags]
	public enum ScheduleDay {
		SUN,
		MON,
		TUES,
		WED,
		THURS,
		FRI,
		SAT,
		WEEKDAY,
		WEEKEND,
		ALL
	}

	[CCode(cname = "tr_port_forwarding", cprefix = "TR_PORT_")]
	public enum PortForwarding {
		ERROR,
		UNMAPPED,
		UNMAPPING,
		MAPPING,
		MAPPED
	}

	[CCode(cname = "tr_direction", cprefix = "TR_")]
	public enum Direction {
		CLIENT_TO_PEER, UP,
		PEER_TO_CLIENT, DOWN
	}


	[CCode(cname = "tr_rpc_callback_type", cprefix = "TR_RPC_")]
	public enum CallbackType {
		TORRENT_ADDED,
		TORRENT_STARTED,
		TORRENT_STOPPED,
		TORRENT_REMOVING,
		TORRENT_TRASHING,
		TORRENT_CHANGED,
		TORRENT_MOVED,
		SESSION_CHANGED,
		SESSION_CLOSE
	}

	[CCode(cname = "tr_rpc_callback_status", cprefix = "TR_RPC_")]
	public enum CallbackStatus {
		/**
		 * No special handling is needed by the caller
		 */
		OK,
		/**
		 * Indicates to the caller that the client will take care of removing the torrent itself. For example the client may need to keep the torrent alive long enough to cleanly close some resources in another thread.
		 */
		NOREMOVE
	}

	[CCode(cname = "tr_rpc_func")]
	public delegate CallbackStatus Callback(Session session, CallbackType type, Torrent? torrent);

	[CCode(cname = "tr_session_stats")]
	[Compact]
	public class Stats {
		public float ratio;
		public uint64 uploadedBytes;
		public uint64 downloadedBytes;
		public uint64 filesAdded;
		public uint64 sessionCount;
		public uint64 secondsActive;
	}

	[CCode(cname = "tr_msg_level", cprefix = "TR_MSG_")]
	public enum MessageLevel {
		ERR,
		INF,
		DBG
	}

	public void setMessageLevel(MessageLevel level);

	[CCode(cname = "tr_msg_list", free_function = "freeMessageList")]
	[Compact]
	public class MessageList {
		public MessageList level;
		/**
		 * The line number in the source file where this message originated
		 */
		public int line;
		/**
		 * Time the message was generated
		 */
		public time_t when;
		/**
		 * The torrent associated with this message, or a module name such as "Port Forwarding" for non-torrent messages, or null.
		 */
		public string name;
		/**
		 * The message
		 */
		public string message;
		/**
		 * The source file where this message originated
		 */
		public const string file;
		public MessageList next;
	}

	public void setMessageQueuing(bool isEnabled);
	public bool getMessageQueuing();

	public MessageList getQueuedMessages();

	/**
	 * The file in the $config/blocklists/ directory that's used by {@link Session.SetContent} and "blocklist-update"
	 */
	public const string DEFAULT_BLOCKLIST_FILENAME;


	[CCode(cname = "tr_ctorMode", cprefix = "TR_")]
	public enum ConstructionMode {
		/**
		 * Indicates the constructor value should be used only in case of missing resume settings
		 */
		FALLBACK,
		/**
		 * Indicates the constructor value should be used regardless of what's in the resume settings
		*/
		FORCE
	}

	/**
	 * Utility class to instantiate {@link Torrent}s
	 *
	 * Instantiating a {@link Torrent} had gotten more complicated as features were added. At one point there were four functions to check metainfo and five to create a {@link Torrent} object.
	 *
	 * To remedy this, a Torrent Constructor has been introduced:
	 * * Simplifies the API to two functions: {@link TorrentConstructor.Parse} and {@link Torrent.Torrent}
	 * * You can set the fields you want; the system sets defaults for the rest.
	 * * You can specify whether or not your fields should supercede resume's.
	 * * We can add new features to the torrent constructor without breaking {@link Torrent.Torrent}'s API.
	 *
	 * You must call one of the {@link TorrentConstructor.SetMetainfo} functions before creating a torrent with a torrent constructor. The other functions are optional.
	 *
	 * You can reuse a single tr_ctor to create a batch of torrents -- just call one of the SetMetainfo() functions between each {@link Torrent.Torrent} call.
	 */
	[CCode(cname = "tr_ctor", cprefix = "tr_ctor", free_function = "tr_ctorFree")]
	[Compact]
	public class TorrentConstructor {
		/**
		 * Set the torrent's bandwidth priority.
		 */
		public void SetBandwidthPriority(Priority priority);

		/**
		* Get the torrent's bandwidth priority.
		*/
		public Priority GetBandwidthPriority();

		/**
		 * Create a torrent constructor object used to instantiate a {@link Torrent}
		 * @param session This is required if you're going to call {@link Torrent.Torrent}, but you can use null for {@link TorrentConstructor.Parse}.
		 */
		[CCode(cname = "tr_ctorNew")]
		public TorrentConstructor(Session? session);

		/**
		 * Set whether or not to delete the source .torrent file when the torrent is added. (Default: False)
		 */
		public void SetDeleteSource(bool doDelete);

		/**
		 * Set the constructor's metainfo from a magnet link
		 */
		public int SetMetainfoFromMagnetLink(string magnet);

		/**
		 * Set the constructor's metainfo from a raw benc already in memory
		 */
		public int SetMetainfo([CCode(array_length_type = "size_t")] uint8[] metainfo);

		/**
		 * Set the constructor's metainfo from a local .torrent file
		 */
		public int SetMetainfoFromFile(string filename);

		/**
		 * Set the metainfo from an existing file in the torrent directory.
		 *
		 * This is used by the Mac client on startup to pick and choose which
		 * torrents to load
		 */
		public int SetMetainfoFromHash(string hashString);

		/**
		 * Set how many peers this torrent can connect to. (Default: 50)
		 */
		public void SetPeerLimit(ConstructionMode mode, uint16 limit);

		/**
		 * Set the download folder for the torrent being added with this ctor.
		 */
		public void SetDownloadDir(ConstructionMode mode, string directory );

		/**
		 * Set whether or not the torrent begins downloading/seeding when created. (Default: not paused)
		 */
		public void SetPaused(ConstructionMode mode, bool isPaused);

		/**
		 * Set the priorities for files in a torrent
		 */
		public void SetFilePriorities([CCode(array_length_type = "tr_file_index_t")] FileIndex[] files, int8 priority );

		/**
		 * Set the download flag for files in a torrent
		 */
		public void SetFilesWanted([CCode(array_length_type = "tr_file_index_t")] FileIndex[] files, bool wanted);

		/**
		 * Get this peer constructor's peer limit
		 */
		public int GetPeerLimit(ConstructionMode mode, out uint16 count);

		/**
		 * Get the "isPaused" flag from this peer constructor
		 */
		public int GetPaused(ConstructionMode mode, out bool isPaused);

		/**
		 * Get the download path from this peer constructor
		 */
		public int GetDownloadDir(ConstructionMode mode, out unowned string downloadDir);

		/**
		 * Get the incomplete directory from this peer constructor
		 */
		public int GetIncompleteDir(out unowned string incompleteDir);

		/**
		 * Get the metainfo from this peer constructor
		 */
		public int GetMetainfo(out unowned Benc benc);

		/**
		 * Get the "delete .torrent file" flag from this peer constructor
		 */
		public int GetDeleteSource(out bool doDelete);

		/**
		 * Get the underlying session from this peer constructor
		 */
		public unowned Session GetSession();

		/**
		 * Get the .torrent file that this torrent constructors 's metainfo came from, or null if {@link TorrentConstructor.SetMetainfoFromFile} wasn't used
		 */
		public unowned string GetSourceFile();

		/**
		 * Parses the specified metainfo
		 *
		 * This method won't be able to check for duplicates -- and therefore won't return {@link ParseResult.DUPLICATE} -- unless the constructors's "download-dir" and session variable is set.
		 *
		 * The torrent field of the info can't be set unless constructors's session variable is set.
		 *
		 * @param info If parsing is successful and info is non-null, the parsed metainfo is stored there
		 */
		[CCode(cname = "tr_torrentParse")]
		public ParseResult Parse(out Info info);
	}

	[CCode(cname = "tr_parse_result", cprefix = "TR_PARSE_")]
	public enum ParseResult {
		OK,
		ERR,
		DUPLICATE
	}

	[CCode(cname = "tr_fileFunc", has_target = false)]
	public delegate int FileFunc(string filename);

	[CCode(cname = "int", cprefix = "TR_LOC_")]
	public enum LocationStatus {
		MOVING,
		DONE,
		ERROR
	}

	[CCode(cname = "tr_ratiolimit", cprefix = "TR_RATIOLIMIT_")]
	public enum RatioLimit {
		/**
		 * Follow the global settings
		 */
		GLOBAL,
		/**
		 * Orverride the global settings, seeding until a certain ratio
		 */
		SINGLE,
		/**
		 * Override the global settings, seeding regardless of ratio
		 */
		UNLIMITED
	}

	[CCode(cname = "tr_idlelimit", cprefix = "TR_IDLELIMIT_")]
	public enum IdleLimit {
		/**
		 * Follow the global settings
		 */
		GLOBAL,
		/**
		 * Override the global settings, seeding until a certain idle time
		 */
		SINGLE,
		/**
		 * Override the global settings, seeding regardless of activity
		 */
		UNLIMITED
	}

	[CCode(cname = "int", cprefix = "TR_PRI_")]
	public enum Priority {
		LOW,
		NORMAL,
		HIGH
	}

	/**
	 * Represents a single tracker
	 */
	[CCode(cname = "tr_tracker_info", has_destroy_function = false, has_copy_function = false)]
	[Compact]
	public struct TrackerInfo {
		public int tier;
		public unowned string announce;
		public unowned string scrape;
		/**
		 * Unique identifier used to match to a {@link TrackerStat}
		 */
		public uint32 id;
	}

	[CCode(cname = "tr_completeness", cprefix = "TR_")]
	public enum Completeness {
		/**
		 * Doesn't have all the desired pieces
		 */
		LEECH,
		/**
		 * Has the entire torrent
		 */
		SEED,
		/**
		 * Has the desired pieces, but not the entire torrent
		 */
		PARTIAL_SEED
	}

	[CCode(cname = "tr_torrent_completeness_func")]
	public delegate void CompletnessFunc(Torrent torrent, Completeness completeness, bool wasRunning);
	[CCode(cname = "tr_torrent_ratio_limit_hit_func")]
	public delegate void RatioLimitHitFunc(Torrent torrent);
	[CCode(cname = "tr_torrent_idle_limit_hit_func")]
	public delegate void IdleLimitHitFunc(Torrent torrent);
	[CCode(cname = "tr_torrent_metadata_func")]
	public delegate void MetadataFunc(Torrent torrent);

	[CCode(cname = "tr_peer_stat", has_destroy_function = false, has_copy_function = false)]
	public struct PeerStat {
		public bool isUTP;
		public bool isEncrypted;
		public bool isDownloadingFrom;
		public bool isUploadingTo;
		public bool isSeed;
		public bool peerIsChoked;
		public bool peerIsInterested;
		public bool clientIsChoked;
		public bool clientIsInterested;
		public bool isIncoming;
		public uint8 from;
		public uint32 port;
		public unowned char addr[46];
		public unowned char client[80];
		public unowned char flagStr[32];
		public float progress;
		public double rateToPeer_KBps;
		public double rateToClient_KBps;

		/**
		 * How many requests the peer has made that we haven't responded to yet
		 */
		public int pendingReqsToClient;

		/**
		 * How many requests we've made and are currently awaiting a response for
		 */
		public int pendingReqsToPeer;
	}
	[CCode(cname = "tr_tracker_state", cprefix = "TR_TRACKER_")]
	public enum TrackerState {
		/**
		 * Won't (announce,scrape) this torrent to this tracker because the torrent is stopped, or because of an error, or whatever
		 */
		INACTIVE,
		/**
		 * Will (announce,scrape) this torrent to this tracker, and are waiting for enough time to pass to satisfy the tracker's interval
		 */
		WAITING,
		/**
		 * It's time to (announce,scrape) this torrent, and we're waiting on a a free slot to open up in the announce manager
		 */
		QUEUED,
		/**
		 * We're (announcing,scraping) this torrent right now
		 */
		ACTIVE
	}

	[CCode(cname = "tr_tracker_stat", has_destroy_function = false, has_copy_function = false)]
	public struct TrackerStat {
		/**
		 * How many downloads this tracker knows of (-1 means it does not know)
		 */
		public int downloadCount;

		/**
		 * Whether or not we've ever sent this tracker an announcement
		 */
		public bool hasAnnounced;

		/**
		 * Whether or not we've ever scraped to this tracker
		 */
		public bool hasScraped;

		/**
		 * Human-readable string identifying the tracker
		 */
		public unowned char host[1024];

		/**
		 * The full announce URL
		 */
		public unowned char announce[1024];

		/**
		 * The full scrape URL
		 */
		public unowned char scrape[1024];

		/**
		 * Transmission uses one tracker per tier, and the others are kept as backups
		 */
		public bool isBackup;

		/**
		 * Is the tracker announcing, waiting, queued, etc
		 */
		public TrackerState announceState;

		/**
		 * Is the tracker scraping, waiting, queued, etc
		 */
		public TrackerState scrapeState;

		/**
		 * Number of peers the tracker told us about last time. If {@link TrackerStat.lastAnnounceSucceeded} is false, this field is undefined.
		 */
		public int lastAnnouncePeerCount;

		/**
		 * Human-readable string with the result of the last announce. If {@link TrackerStat.hasAnnounced} is false, this field is undefined.
		 */
		public unowned char lastAnnounceResult[128];

		/**
		 * When the last announce was sent to the tracker. If {@link TrackerStat.hasAnnounced} is false, this field is undefined
		 */
		public time_t lastAnnounceStartTime;

		/**
		 * Whether or not the last announce was a success. If {@link TrackerStat.hasAnnounced} is false, this field is undefined.
		 */
		public bool lastAnnounceSucceeded;

		/**
		 * Whether or not the last announce timed out.
		 */
		public bool lastAnnounceTimedOut;

		/**
		 * When the last announce was completed. If {@link TrackerStat.hasAnnounced} is false, this field is undefined
		 */
		public time_t lastAnnounceTime;

		/**
		 * Human-readable string with the result of the last scrape. If {@link TrackerStat.hasScraped} is false, this field is undefined.
		 */
		public unowned char lastScrapeResult[128];

		/**
		 * When the last scrape was sent to the tracker. If {@link TrackerStat.hasScraped} is false, this field is undefined.
		 */
		public time_t lastScrapeStartTime;

		/**
		 * Whether or not the last scrape was a success. If {@link TrackerStat.hasAnnounced} is false, this field is undefined.
		 */
		public bool lastScrapeSucceeded;

		/**
		 * Whether or not the last scrape timed out.
		 */
		public bool lastScrapeTimedOut;

		/**
		 * When the last scrape was completed. If {@link TrackerStat.hasScraped} is false, this field is undefined.
		 */
		public time_t lastScrapeTime;

		/**
		 * Number of leechers this tracker knows of (-1 means it does not know)
		 */
		public int leecherCount;

		/**
		 * When the next periodic announce message will be sent out. If {@link TrackerStat.announceState} isn't {@link TrackerState.WAITING}, this field is undefined.
		 */
		public time_t nextAnnounceTime;

		/**
		 * when the next periodic scrape message will be sent out. If {@link TrackerStat.scrapeState} isn't {@link TrackerState.WAITING}, this field is undefined.
		 */
		public time_t nextScrapeTime;

		/**
		 * Number of seeders this tracker knows of (-1 means it does not know)
		 */
		public int seederCount;

		/**
		 * Which tier this tracker is in
		 */
		public int tier;
		/**
		 * Used to match to a {@link TrackerInfo}
		 */
		public uint32 id;
	}

	[CCode(cname = "tr_file_stat", has_destroy_function = false, has_copy_function = false)]
	[Compact]
	public struct FileStat {
		public uint64 bytesCompleted;
		public float progress;
	}

	/**
	 * A single file of the torrent's content
	 */
	[CCode(cname = "tr_file", has_destroy_function = false, has_copy_function = false)]
	[Compact]
	public struct File {
		/**
		 * Length of the file, in bytes
		 */
		public uint64 length;
		/**
		 * Path to the file
		 */
		public unowned string name;
		public Priority priority;
		/**
		 * "Do not download" flag
		 */
		public int8 dnd;
		/**
		 * We need pieces [firstPiece...
		 */
		public uint32 firstPiece;
		/**
		 * ...lastPiece] to dl this file
		 */
		public uint32 lastPiece;
		/**
		 * File begins at the torrent's nth byte
		 */
		public uint64 offset;
	}

	/**
	 * A single piece of the torrent's content
	 */
	[CCode(cname = "tr_piece", has_destroy_function = false, has_copy_function = false)]
	public struct Piece {
		/**
		 * The last time we tested this piece
		 */
		public time_t timeChecked;
		/**
		 * Pieces hash
		 */
		public unowned uint8 hash[20];
		public int8 priority;
		/**
		 * "Do not download" flag
		 */
		public int8 dnd;
	}

	/**
	 * Information about a torrent that comes from its metainfo file
	 */
	[CCode(cname = "tr_info", has_destroy_function = false, has_copy_function = false)]
	[Compact]
	public struct Info {
		/**
		 * Total size of the torrent, in bytes
		 */
		public uint64 totalSize;
		/**
		 * The torrent's name
		 */
		public unowned string name;
		/**
		 * Path to torrent Transmission's internal copy of the .torrent file.
		 */
		public unowned string torrent;

		[CCode(array_length_type = "int", array_length_cname = "webseedCount")]
		public unowned string[] webseeds;

		public unowned string comment;
		public unowned string creator;
		[CCode(array_length_type = "tr_file_index_t", array_length_cname = "fileCount")]
		public unowned File[] files;
		[CCode(array_length_type = "tr_piece_index_t", array_length_cname = "pieceCount")]
		public unowned Piece[] pieces;

		/**
		 * These trackers are sorted by tier
		 */
		[CCode(array_length_type = "int", array_length_cname = "trackerCount")]
		public unowned TrackerInfo[] trackers;

		public time_t dateCreated;

		public uint32 pieceSize;

		public uint8 hash[20];
		public unowned string hashString;
		public bool isPrivate;
		public bool isMultifile;
	}

	/**
	 * What the torrent is doing right now.
	 */
	[CCode(cname = "tr_torrent_activity", cprefix = "TR_STATUS_")]
	[Flags]
	public enum Activity {
		/**
		 * Waiting in queue to check files
		 */
		CHECK_WAIT,
		/**
		 * Checking files
		 */
		CHECK,
		/**
		 * Downloading
		 */
		DOWNLOAD,
		/**
		 * Seeding
		 */
		SEED,
		/**
		 * Torrent is stopped
		 */
		STOPPED,
	}

	[CCode(cname = "int", cprefix = "TR_PEER_FROM_")]
	public enum PeerFrom {
		/**
		 * Connections made to the listening port
		 */
		INCOMING,
		/**
		 * Peers found by local announcements
		 */
		LPD,
		/**
		 * Peers found from a tracker
		 */
		TRACKER,
		/**
		 * Peers found from the DHT
		 */
		DHT,
		/**
		 * Peers found from PEX
		 */
		PEX,
		/**
		 * Peers found in the .resume file
		 */
		RESUME,
		/**
		 * Peer address provided in an LTEP handshake
		 */
		LTEP
	}


	[CCode(cname = "tr_stat_errtype", cprefix = "TR_STAT_")]
	public enum StatError {
		/**
		 * Everything's fine
		 */
		OK,
		/**
		 * When we anounced to the tracker, we got a warning in the response
		 */
		TRACKER_WARNING,
		/**
		 * When we anounced to the tracker, we got an error in the response
		 */
		TRACKER_ERROR,
		/**
		 * Local trouble, such as disk full or permissions error
		 */
		LOCAL_ERROR
	}

	[CCode(cname = "TR_RATIO_NA")]
	public const double RATIO_NA;
	[CCode(cname = "TR_RATIO_INF")]
	public const double RATIO_INF;

	[CCode(cname = "TR_ETA_NOT_AVAIL ")]
	public int ETA_NOT_AVAIL;
	[CCode(cname = "TR_ETA_UNKNOWN ")]
	public int ETA_UNKNOWN;

	/**
	 * A torrent's state and statistics
	 */
	[CCode(cname = "tr_stat")]
	[Compact]
	public class Stat {
		/**
		 * The torrent's unique Id.
		 * @see Torrent.Id
		 */
		public int id;
		/**
		 * What is this torrent doing right now?
		 */
		public Activity activity;
		/**
		 * Defines what kind of text is in errorString.
		 */
		public StatError error;
		/**
		 * A warning or error message regarding the torrent.
		 */
		public char errorString[512];
		/**
		 * When {@link Stat.activity} is {@link Activity.CHECK} or {@link Activity.CHECK_WAIT}, this is the percentage of how much of the files has been verified. When it gets to 1, the verify process is done.
		 */
		public float recheckProgress;
		/**
		 * How much has been downloaded of the entire torrent.
		 */
		public float percentComplete;
		/**
		 * How much of the metadata the torrent has. For torrents added from a .torrent this will always be 1. For magnet links, this number will from from 0 to 1 as the metadata is downloaded.
		 */
		public float metadataPercentComplete;
		/**
		 * How much has been downloaded of the files the user wants. This differs from {@link Stat.percentComplete} if the user wants only some of the torrent's files.
		 */
		public float percentDone;
		/**
		 * How much has been uploaded to satisfy the seed ratio. This is 1 if the ratio is reached or the torrent is set to seed forever.
		 */
		public float seedRatioPercentDone;
		/**
		 * Speed all data being sent for this torrent. This includes piece data, protocol messages, and TCP overhead
		 */
		public float rawUploadSpeed_KBps;
		/**
		 *  Speed all data being received for this torrent. This includes piece data, protocol messages, and TCP overhead
		 */
		public float rawDownloadSpeed_KBps;
		/**
		 * Speed all piece being sent for this torrent. This ONLY counts piece data.
		 */
		public float pieceUploadSpeed_KBps;
		/**
		 * Speed all piece being received for this torrent. This ONLY counts piece data.i
		 */
		public float pieceDownloadSpeed_KBps;
		/**
		 * If downloading, estimated number of seconds left until the torrent is done. If seeding, estimated number of seconds left until seed ratio is reached.
		 */
		public int eta;
		/**
		 * If seeding, number of seconds left until the idle time limit is reached.
		 */
		public int etaIdle;
		/**
		 * Number of peers that we're connected to
		 */
		public int peersConnected;
		/**
		 * How many peers we found out about from the tracker, or from PEX, or from incoming connections, or from our resume file.
		 */
		public int peersFrom[8];
		/**
		 * Number of peers that are sending data to us.
		 */
		public int peersSendingToUs;
		/**
		 * Number of peers that we're sending data to
		 */
		public int peersGettingFromUs;
		/**
		 * Number of webseeds that are sending data to us.
		 */
		public int webseedsSendingToUs;
		/**
		 * Byte count of all the piece data we'll have downloaded when we're done, whether or not we have it yet. This may be less than {@link Info.totalSize} if only some of the torrent's files are wanted.
		 */
		public uint64 sizeWhenDone;
		/**
		 * Byte count of how much data is left to be downloaded until we've got all the pieces that we want.
		 */
		public uint64 leftUntilDone;
		/**
		 * Byte count of all the piece data we want and don't have yet, but that a connected peer does have.
		 */
		public uint64 desiredAvailable;
		/**
		 * Byte count of all the corrupt data you've ever downloaded for this torrent. If you're on a poisoned torrent, this number can grow very large.
		 */
		public uint64 corruptEver;
		/**
		 * Byte count of all data you've ever uploaded for this torrent.
		 */
		public uint64 uploadedEver;
		/**
		 * Byte count of all the non-corrupt data you've ever downloaded for this torrent. If you deleted the files and downloaded a second time, this will be 2*totalSize.
		 */
		public uint64 downloadedEver;
		/**
		 * Byte count of all the checksum-verified data we have for this torrent.
		 */
		public uint64 haveValid;
		/**
		 * Byte count of all the partial piece data we have for this torrent. As pieces become complete, this value may decrease as portions of it are moved to `corrupt' or `haveValid'.
		 */
		public uint64 haveUnchecked;
		/**
		 * Time when one or more of the torrent's trackers will allow you to manually ask for more peers, or 0 if you can't
		 */
		public time_t manualAnnounceTime;
		/**
		 * {@link RATIO_INF}, {@link RATIO_NA}, or a regular ratio
		 */
		public float ratio;
		/**
		 * When the torrent was first added.
		 */
		public time_t addedDate;
		/**
		 * When the torrent finished downloading.
		 */
		public time_t doneDate;
		/**
		 * When the torrent was last started.
		 */
		public time_t startDate;
		/**
		 * The last time we uploaded or downloaded piece data on this torrent.
		 */
		public time_t activityDate;
		/**
		 * Number of seconds since the last activity (or since started). -1 if activity is not seeding or downloading.
		 */
		public int idleSecs;
		/**
		 * Cumulative seconds the torrent's ever spent downloading
		 */
		public int secondsDownloading;
		/**
		 * Cumulative seconds the torrent's ever spent seeding
		 */
		public int secondsSeeding;
		/**
		 *  A torrent is considered finished if it has met its seed ratio. As a result, only paused torrents can be finished.
		 */
		public bool finished;
	}


	[CCode(cname = "tr_torrent", cprefix = "tr_torrent", free_function = "tr_torrentFree")]
	[Compact]
	public class Torrent {
		/**
		 * Instantiate a single torrent.
		 */
		[CCode(cname = "tr_torrentNew")]
		public Torrent(TorrentConstructor ctor, out ParseResult error);

		/**
		 * Removes our .torrent and .resume files for this torrent and frees it.
		 */
		[DestroysInstance]
		public void Remove(bool removeLocalData, FileFunc removeFunc);

		/**
		 * Start a torrent
		 */
		public void Start();

		/**
		 * Stop (pause) a torrent
		 */
		public void Stop();

		/**
		 * Tell transmsision where to find this torrent's local data.
		 *
		 * @param move_from_previous_location If `true', the torrent's incompleteDir will be clobberred such that additional files being added will be saved to the torrent's downloadDir.
		 */
		public void SetLocation(string location, bool move_from_previous_location, out double progress, out LocationStatus state);

		public uint64 GetBytesLeftToAllocate();

		/**
		 * Returns this torrent's unique ID.
		 *
		 * IDs are good as simple lookup keys, but are not persistent between sessions. If you need that, use {@link Info.hash} or {@link Info.hashString}.
		 */
		int Id();

		public static unowned Torrent FindFromId(Session session, int id );
		public static unowned Torrent FindFromHash(Session session, [CCode(array_length = false)] uint8[] hash);
		public static unowned Torrent FindFromMagnetLink(Session session, string link);

		/**
		 * This torrent's name.
		 */
		public unowned string Name();

		/**
		 * Find the location of a torrent's file by looking with and without the ".part" suffix, looking in downloadDir and incompleteDir, etc.
		 * @param fileNum The index into {@link Info.files}
		 * @return The location of this file on disk, or null if no file exists yet.
		 */
		public string? FindFile(int fileNo);

		public void SetSpeedLimit_KBps(Direction direction, int kBps);
		public int GetSpeedLimit_KBps(Direction direction);

		public void UseSpeedLimit(Direction direction, bool use);
		public bool UsesSpeedLimit(Direction direction);

		public void UseSessionLimits(bool use);
		public bool UsesSessionLimits();

		public void SetRatioMode(RatioLimit mode);
		public RatioLimit GetRatioMode();

		public void SetRatioLimit(double ratio);
		public double GetRatioLimit();

		public bool GetSeedRatio(out double ratio);

		public void SetIdleMode(IdleLimit mode);
		public IdleLimit GetIdleMode();

		public void SetIdleLimit(uint16 idleMinutes);
		public uint16 GetIdleLimit();
		public bool GetSeedIdle(out uint16 minutes);

		public void SetPeerLimit(uint16 peerLimit);
		public uint16 GetPeerLimit();

		/**
		* Set a batch of files to a particular priority.
		*/
		public void SetFilePriorities([CCode(array_length_type = "tr_file_index_t")] FileIndex[] files, Priority priority);

		/**
		 * Get this torrent's file priorities.
		 */
		public Priority[] GetFilePriorities();

		/**
		 * Set a batch of files to be downloaded or not.
		 */
		public void SetFileDLs([CCode(array_length_type = "tr_file_index_t")] FileIndex[] files, bool download);

		public unowned Info* Info();

		/**
		 * Raw function to change the torrent's downloadDir field.
		 *
		 * This should only be used by libtransmission or to bootstrap a newly-instantiated object.
		 */
		public void SetDownloadDir(string path);

		public unowned string GetDownloadDir();

		/**
		 * Returns the root directory of where the torrent is.
		 *
		 * This will usually be the downloadDir. However if the torrent has an incompleteDir enabled and hasn't finished downloading yet, that will be returned instead.
		 */
		public unowned string GetCurrentDir();

		/**
		 * Returns a string with a magnet link of the torrent.
		 */
		public string GetMagnetLink();

		/**
		 * Modify a torrent's tracker list.
		 *
		 * This updates both the torrent object's tracker list and the metainfo file in configuration directory's torrent subdirectory.
		 *
		 *
		 * NOTE: only the `tier' and `announce' fields are used. libtransmission derives `scrape' from `announce' and reassigns 'id'.
		 * @param trackers An array of trackers, sorted by tier from first to last.
		 */
		public bool SetAnnounceList([CCode(array_length_type = "int")] TrackerInfo[] trackers);

		/**
		 * Register to be notified whenever a torrent's "completeness" changes.
		 *
		 * This will be called, for example, when a torrent finishes downloading and changes from {@link Completeness.LEECH} to
		 * either {@link Completeness.SEED} or {@link Completeness.PARTIAL_SEED}.
		 *
		 * The function is invoked FROM LIBTRANSMISSION'S THREAD! This means the function must be fast (to avoid blocking peers), shouldn't call libtransmission functions (to avoid deadlock), and shouldn't modify client-level memory without using a mutex!
		 */
		public void SetCompletenessCallback(CompletnessFunc func);

		public void ClearCompletenessCallback();

		/**
		 * Register to be notified whenever a torrent changes from having incomplete metadata to having complete metadata.
		 *
		 * This happens when a magnet link finishes downloading metadata from its peers.
		 */
		public void SetMetadataCallback(MetadataFunc func);

		/**
		 * Register to be notified whenever a torrent's ratio limit has been hit.
		 *
		 * This will be called when the torrent's upload/download ratio has met or exceeded the designated ratio limit.
		 *
		 * Has the same restrictions as {@link Torrent.SetCompletenessCallback}
		 */
		public void SetRatioLimitHitCallback( RatioLimitHitFunc func);

		public void ClearRatioLimitHitCallback();

		/**
		 * Register to be notified whenever a torrent's idle limit has been hit.
		 *
		 * This will be called when the seeding torrent's idle time has met or exceeded the designated idle limit.
		 *
		 * Has the same restrictions as {@link Torrent.SetCompletenessCallback}
		 */
		public void SetIdleLimitHitCallback(IdleLimitHitFunc func);

		public void ClearIdleLimitHitCallback();

		/**
		 * Perform a manual announce
		 *
		 * Trackers usually set an announce interval of 15 or 30 minutes. Users can send one-time announce requests that override this interval by calling this method.
		 *
		 * The wait interval for manual announce is much smaller. You can test whether or not a manual update is possible (for example, to desensitize the button) by calling {@link Torrent.CanManualUpdate}.
		 */
		public void ManualUpdate();
		public bool CanManualUpdate();

		public Priority GetPriority();
		public void SetPriority(Priority priority);

		[CCode(array_length_pos = 0.9)]
		public PeerStat[] Peers();

		[CCode(array_length_pos = 0.9)]
		public TrackerStat[] Trackers();

		/**
		* Get the download speeds for each of this torrent's webseed sources.
		*
		* To differentiate "idle" and "stalled" status, idle webseeds will return -1 instead of 0 KiB/s.
		* @return an array floats giving download speeds. Each speed in the array corresponds to the webseed at the same array index in {@link Info.webseeds}.
		*/
		public double[] WebSpeeds_KBps();

		[CCode(array_length_pos = 0.9)]
		public FileStat[] Files();

		/**
		 * Use this to draw an advanced progress bar.
		 *
		 * Fills 'tab' which you must have allocated: each byte is set to either -1 if we have the piece, otherwise it is set to the number of connected peers who have the piece.
		 */
		public void Availability([CCode(array_length_type = "int")] int8[] tab);
		public void AmountFinished([CCode(array_length_type = "int")] float[] tab);
		public void Verify();

		public bool HasMetadata();

		/**
		 * Get updated information on the torrent.
		 *
		 * This is typically called by the GUI clients every second or so to get a new snapshot of the torrent's status.
		*/
		public unowned Stat Stat();

		/**
		 * Get updated information on the torrent.
		 *
		 * Like {@link Torrent.Stat}, but only recalculates the statistics if it's been longer than a second since they were last calculated. This can reduce the CPU load if you're calling it frequently.
		 */
		public unowned Stat StatCached();
	}

	[CCode(cheader_filename = "libtorrent/makemeta.h", cname = "tr_metainfo_builder_file", has_destroy_function = false, has_copy_function = false)]
	public struct BuilderFile {
		public unowned string filename;
		public uint64 size;
	}

	[CCode(cheader_filename = "libtorrent/makemeta.h", cname = "tr_metainfo_builder_err", cprefix = "TR_MAKEMETA_")]
	public enum BuilderError {
		OK,
		URL,
		CANCELLED,
		IO_READ,
		IO_WRITE
	}

	[CCode(cheader_filename = "libtorrent/makemeta.h", cname = "tr_metainfo_builder", cprefix = "tr_metaInfoBuilder", free_function = "tr_metaInfoBuilderFree")]
	[Compact]
	public class Builder {
		[CCode(cname = "tr_metaInfoBuilderCreate")]
		public Builder(string topFile);

		public string top;
		[CCode(array_length_cname = "fileCount", array_length_type = "uint32")]
		public BuilderFile[] files;
		public uint64 totalSize;
		public uint32 pieceSize;
		public uint32 pieceCount;
		public int isSingleFile;

		[CCode(array_length_cname = "trackerCount", array_length_type = "int")]
		public TrackerInfo[] trackers;
		public string comment;
		public string outputFile;
		public int isPrivate;

		public uint32 pieceIndex;
		public int abortFlag;
		public int isDone;
		public BuilderError result;

		/**
		 * File in use when result was set to {@link BuilderError.IO_READ} or {@link BuilderError.IO_WRITE}, or the URL in use when the result was set to {@link BuilderError.URL}.
		*/
		public char errfile[2048];

		/**
		 * errno encountered when result was set to {@link BuilderError.IO_READ} or {@link BuilderError.IO_WRITE}
		 */
		public int my_errno;

		/**
		 * Create a new .torrent file
		 *
		 * This is actually done in a worker thread, not the main thread!
		 * Otherwise the client's interface would lock up while this runs.
		 *
		 * It is the caller's responsibility to poll {@link Builder.isDone} from time to time! When the worker thread sets that flag, the caller must destroy the builder.
		 *
		 * @param outputFile If null, {@link Builder.top} + ".torrent" will be used.
		 * @param trackers An array of trackers, sorted by tier from first to last.
		 */
		[CCode(cname = "tr_makeMetaInfo")]
		public void MakeInfo(string outputFile, TrackerInfo[] trackers, string comment, int isPrivate);
	}

	[CCode(cheader_filename = "libtransmission/utils.h", cprefix = "tr_", lower_case_cprefix = "tr_")]
	namespace Utils {
		[CCode(cname = "TR_MAX_MSG_LOG")]
		public const int MAX_MSG_LOG;

		public MessageLevel getMessageLevel();
		public bool msgLoggingIsActive(MessageLevel level);

		[PrintfFormat]
		public void msg(string file, int line, MessageLevel level, string torrent, string fmt, ... );

		[PrintfFormat]
		public void nerr(string name, string fmt, ...);
		[PrintfFormat]
		public void ninf(string name, string fmt, ...);
		[PrintfFormat]
		public void ndbg(string name, string fmt, ...);

		[PrintfFormat]
		public void torerr(Torrent torrent, string fmt, ...);
		[PrintfFormat]
		public void torinf(Torrent torrent, string fmt, ...);
		[PrintfFormat]
		public void tordbg(Torrent torrent, string fmt, ...);

		[PrintfFormat]
		public void err(string fmt, ...);
		[PrintfFormat]
		public void inf(string fmt, ...);
		[PrintfFormat]
		public void dbg(string fmt, ...);

		/**
		 * Return true if deep logging has been enabled by the user; false otherwise
		 */
		public bool deepLoggingIsActive();

		[PrintfFormat]
		public void deepLog(string file, int line, string name, string fmt,... );

		/**
		 * Set the buffer with the current time formatted for deep logging.
		 */
		public unowned string getLogTimeStr([CCode(array_length_type = "size_t")] char[] buf);


		/**
		 * Rich Salz's classic implementation of shell-style pattern matching for ?, \, [], and * characters.
		 * @return 1 if the pattern matches, 0 if it doesn't, or -1 if an error occurred
		 */
		public int wildmat(string text, string pattern);

		/**
		 * Portability wrapper for basename() that uses the system implementation if available
		 */
		public string basename(string path);

		/**
		 * Portability wrapper for dirname() that uses the system implementation if available
		 */
		public string dirname(string path);

		/**
		 * Portability wrapper for mkdir()
		 *
		 * A portability wrapper around mkdir().
		 * On WIN32, the `permissions' argument is unused.
		 *
		 * @return zero on success, or -1 if an error occurred (in which case errno is set appropriately).
		 */
		public int mkdir(string path, int permissions);

		/**
		 * Like mkdir, but makes parent directories as needed.
		 *
		 * @return zero on success, or -1 if an error occurred (in which case errno is set appropriately).
		 */
		public int mkdirp(string path, int permissions);


		/**
		 * Loads a file and returns its contents.
		 * @return The file's contents. On failure, null is returned and errno is set.
		 */
		[CCode(array_length_type = "size_t", array_length_pos = 1.9)]
		uint8[]? loadFile(string filename);


		/**
		 * Build a filename from a series of elements using the platform's correct directory separator.
		 */
		[CCode(sentinel = "NULL")]
		string buildPath(string first_element, ...);

		[CCode(cname = "struct event", cprefix = "tr_")]
		[Compact]
		class Event {
			/**
			 * Convenience wrapper around timer_add() to have a timer wake up in a number of seconds and microseconds
			 * @param timer
			 * @param seconds
			 * @param microseconds
			 */
			public void timerAdd(int seconds, int microseconds);

			/**
			 * Convenience wrapper around timer_add() to have a timer wake up in a number of milliseconds
			 * @param timer
			 * @param milliseconds
			 */
			public void timerAddMsec(int milliseconds);
		}

		/**
		 * Return the current date in milliseconds
		 */
		public uint64 time_msec();

		/**
		 * Sleep the specified number of milliseconds
		 */
		public void wait_msec(long delay_milliseconds);

		/**
		 * Make a copy of 'str' whose non-utf8 content has been corrected or stripped
		 * @return a new string
		 * @param str the string to make a clean copy of
		 * @param len the length of the string to copy. If -1, the entire string is used.
		 */
		public string utf8clean(string str, int len = -1);

		public void sha1_to_hex([CCode(array_null_terminated = true)] char[] result, uint8[] sha1);

		public void hex_to_sha1([CCode(array_length = false)] uint8[] result, string hex);

		/**
		 * Convenience function to determine if an address is an IP address (IPv4 or IPv6)
		 */
		public bool addressIsIP(string address);

		/**
		 * Return true if the URL is a http or https URL that Transmission understands
		 */
		public bool urlIsValidTracker(string url);

		/**
		 * Return true if the URL is a [ http, https, ftp, ftps ] URL that Transmission understands
		 */
		public bool urlIsValid(string url, int url_len );

		/**
		 * Parse a URL into its component parts
		 * @return zero on success or an error number if an error occurred
		 */
		public int urlParse(string url, int url_len, out string scheme, out string host, out int port, out string path );

		/**
		 * Compute a ratio given a numerator and denominator.
		 * @return {@link RATIO_NA}, {@link RATIO_INF}, or a number in [0..1]
		 */
		public double getRatio(uint64 numerator, uint64 denominator);

		/**
		 * Given a string like "1-4" or "1-4,6,9,14-51", this returns an array of all the integers in the set.
		 *
		 * For example, "5-8" will return [ 5, 6, 7, 8 ].
		 * @return an array of integers or null if a fragment of the string can't be parsed.
		 */
		[CCode(array_length_type = "int", array_length_pos = 2.9)]
		public int[]? parseNumberRange(string str, int str_len);


		/**
		 * Truncate a double value at a given number of decimal places.
		 *
		 * This can be used to prevent a printf() call from rounding up:
		 * call with the decimal_places argument equal to the number of
		 * decimal places in the printf()'s precision:
		 *
		 * * printf("%.2f%%", 99.999 ) ==> "100.00%"
		 * * printf("%.2f%%", tr_truncd(99.999, 2)) ==> "99.99%"
		 * These should match
		 */
		public double truncd(double x, int decimal_places);

		/**
		 * Return a percent formatted string of either x.xx, xx.x or xxx
		 */
		public unowned string strpercent([CCode(array_length_type = "size_t", array_length_pos = 2.9)] char[] buf, double x);

		/**
		 * Convert ratio to a string
		 * @param buf the buffer to write the string to
		 * @param ratio the ratio to convert to a string
		 * @param the string representation of "infinity"
		 */
		public unowned string strratio([CCode(array_length_type = "size_t")] char[] buf, double ratio, string infinity);

		/**
		 * Move a file
		 * @return 0 on success; otherwise, return -1 and set errno
		 */
		public int moveFile(string oldpath, string newpath, out bool renamed);

		/**
		 * Test to see if the two filenames point to the same file.
		 */
		public bool is_same_file(string filename1, string filename2);

		/**
		 * Very inexpensive form of time(NULL)
		 *
		 * This function returns a second counter that is updated once per second. If something blocks the libtransmission thread for more than a second, that counter may be thrown off, so this function is not guaranteed to always be accurate. However, it is *much* faster when 100% accuracy isn't needed.
		 * @return the current epoch time in seconds
		 */
		public time_t time();

		public uint speed_K;
		public uint mem_K;
		public uint size_K;

		[CCode(cprefix = "tr_formatter_")]
		namespace Formatter {
			public void size_init(uint kilo, string kb, string mb, string gb, string tb);
			public void speed_init(uint kilo, string kb, string mb, string gb, string tb);
			public void mem_init(uint kilo, string kb, string mb, string gb, string tb);

			/**
			 * Format a speed from KBps into a user-readable string.
			 */
			public unowned string speed_KBps([CCode(array_length_type = "size_t", array_length_pos = 2.9)] char[] buf, double KBps);

			/**
			 * Format a memory size from bytes into a user-readable string.
			 */
			public unowned string mem_B([CCode(array_length_type = "size_t", array_length_pos = 2.9)] char[] buf, int64 bytes);

			/**
			 * Format a memory size from MB into a user-readable string.
			 */
			public unowned string mem_MB([CCode(array_length_type = "size_t", array_length_pos = 2.9)] char[] buf, double MBps);

			/**
			 * Format a file size from bytes into a user-readable string.
			 */
			public unowned string size_B([CCode(array_length_type = "size_t", array_length_pos = 2.9)] char[] buf, int64 bytes);

			public void get_units(Benc dict);
		}
	}
}
