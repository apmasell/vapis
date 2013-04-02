/**
 * Interface for libblkid, a library to identify block devices
 */
[CCode(cheader_filename = "blkid.h")]
namespace BlkId {
	[CCode(cname = "int", cprefix = "BLKID_FLTR_", has_type_id = false)]
	public enum Filter {
		NOTIN,
		ONLYIN
	}
	[CCode(cname = "int", has_type_id = false, cprefix = "BLKID_DEV_")]
	[Flags]
	public enum Get {
		/**
		 * Create an empty device structure if not found in the cache.
		 */
		FIND,
		/**
		 * Make sure the device structure corresponds with reality.
		 */
		CREATE,
		/**
		 * Just look up a device entry, and return null if it is not found.
		 */
		VERIFY,
		/**
		 * Get a valid device structure, either from the cache or by probing the
		 * device.
		 */
		NORMAL
	}
	[CCode(cname = "unsigned long long", cprefix = "BLKID_PARTS_", has_type_id = false)]
	[Flags]
	public enum PartInfo {
		FORCE_GPT,
		ENTRY_DETAILS
	}
	[CCode(cname = "int", cprefix = "BLKID_SUBLKS_", has_type_id = false)]
	[Flags]
	public enum SuperBlock {
		/**
		 * Read LABEL from superblock
		 */
		LABEL,
		/**
		 * Read and define LABEL_RAW result value
		 */
		LABELRAW,
		/**
		 * Read UUID from superblock
		 */
		UUID,
		/**
		 * Read and define UUID_RAW result value
		 */
		UUIDRAW,
		/**
		 * Define TYPE result value
		 */
		TYPE,
		/**
		 * Define compatible fs type (second type)
		 */
		SECTYPE,
		/**
		 * Define USAGE result value
		 */
		USAGE,
		/**
		 * Read FS type from superblock
		 */
		VERSION,
		/**
		 * Define SBMAGIC and SBMAGIC_OFFSET
		 */
		MAGIC,
		DEFAULT
	}
	[CCode(cname = "int", cprefix = "BLKID_USAGE_", has_type_id = false)]
	[Flags]
	public enum Usage {
		FILESYSTEM,
		RAID,
		CRYPTO,
		OTHER
	}
	/**
	 * Information about all system devices
	 *
	 * Block device information is normally kept in a cache file blkid.tab and is verified to still be valid before being returned to the user (if the user has read permission on the raw block device, otherwise not). The cache file also allows unprivileged users (normally anyone other than root, or those not in the "disk" group) to locate devices by label/id. The standard location of the cache file can be overridden by the environment variable BLKID_FILE.
	 *
	 * In situations where one is getting information about a single known device, it does not impact performance whether the cache is used or not (unless you are not able to read the block device directly). If you are dealing with multiple devices, use of the cache is highly recommended (even if empty) as devices will be scanned at most one time and the on-disk cache will be updated if possible. There is rarely a reason not to use the cache.
	 *
	 * In some cases (modular kernels), block devices are not even visible until after they are accessed the first time, so it is critical that there is some way to locate these devices without enumerating only visible devices, so the use of the cache file is required in this situation.
	 */
	[CCode(cname = "struct blkid_struct_cache", free_function = "blkid_put_cache", has_type_id = false)]
	[Compact]
	public class Cache {
		/**
		 * Allocates and initialize librray cache handler.
		 * @param filename path to the cache file or null for the default path
		 * @return 0 on success or number less than zero in case of error.
		 */
		[CCode(cname = "blkid_get_cache")]
		public static int open(out Cache? cache, string? filename = null);
		/**
		 * Removes garbage (non-existing devices) from the cache.
		 */
		[CCode(cname = "blkid_gc_cache")]
		public void collect_garbage();
		[CCode(cname = "blkid_find_dev_with_tag")]
		public Device? find_dev_with_tag(string type, string @value);
		/**
		 * Find a device in the cache by device name, if available.
		 *
		 * If there is no entry with the specified device name, and the create flag
		 * is set, then create an empty device entry.
		 */
		[CCode(cname = "blkid_get_dev")]
		public unowned Device? get(string devname, Get flags);
		/**
		 * Locate a device name from a token (NAME=value string), or (name, value)
		 * pair.
		 *
		 * In the case of a token, value is ignored.  If the "token" is not of the
		 * form "NAME=value" and there is no value given, then it is assumed to be
		 * the actual devname and a copy is returned.
		 */
		[CCode(cname = "blkid_get_devname")]
		public string? get_name(string token, string @value);
		/**
		 * Find a tagname (e.g. LABEL or UUID) on a specific device.
		 */
		[CCode(cname = "blkid_get_tag_value")]
		public string? get_tag_value(string tagname, string devname);
		[CCode(cname = "blkid_dev_iterate_begin")]
		public DevIterate iterator();
		/**
		 * Probes all block devices.
		 */
		[CCode(cname = "blkid_probe_all")]
		public int probe_all();
		/**
		 * Probes all new block devices.
		 */
		[CCode(cname = "blkid_probe_all_new")]
		public int probe_all_new();
		/**
		 * The libblkid probing is based on devices from /proc/partitions by default. This file usually does not contain removable devices (e.g. CDROMs) and this kind of devices are invisible for libblkid.
		 *
		 * This function adds removable block devices to cache (probing is based on information from the /sys directory). Don't forget that removable devices (floppies, CDROMs, ...) could be pretty slow. It's very bad idea to call this function by default.
		 *
		 * Note that devices which were detected by this function won't be written to blkid.tab cache file.
		 */
		[CCode(cname = "blkid_probe_all_removable")]
		public int probe_all_removable();
		/**
		 * Verify that the data in dev is consistent with what is on the actual
		 * block device (using the devname field only).  Normally this will be
		 * called when finding items in the cache, but for long running processes
		 * is also desirable to revalidate an item before use.
		 *
		 * If we are unable to revalidate the data, we return the old data and do
		 * not set the {@link Get.VERIFY} flag on it.
		 */
		[CCode(cname = "blkid_verify")]
		public Device? verify(owned Device dev);
	}
	/**
	 * The device object keeps information about one device
	 */
	[CCode(cname = "struct blkid_struct_dev", has_type_id = false)]
	[Compact]
	public class Device {
		[CCode(cname = "blkid_dev_has_tag")]
		public bool has_tag(string type, string @value);
		public string? name {
			[CCode(cname = "blkid_dev_devname")]
			get;
		}
		[CCode(cname = "blkid_tag_iterate_begin")]
		public TagIterate iterator();
	}
	/**
	 * Devices iterator for high-level API
	 */
	[CCode(cname = "struct blkid_struct_dev_iterate", free_function = "blkid_dev_iterate_end", has_type_id = false)]
	[Compact]
	public class DevIterate {
		[CCode(cname = "blkid_dev_next")]
		public int next(out unowned Device? dev);
		public unowned Device? next_value() {
			unowned Device? dev;
			next(out dev);
			return dev;
		}
		[CCode(cname = "blkid_dev_set_search")]
		public int set_search(string search_type, string search_value);
	}
	/**
	 * List of all detected partitions and partitions tables
	 */
	[CCode(cname = "struct blkid_struct_partlist", has_type_id = false)]
	[Compact]
	public class PartList {
		public PartTable table {
			[CCode(cname = "blkid_partlist_get_table")]
			get;
		}
		public int size {
			[CCode(cname = "blkid_partlist_numof_partitions")]
			get;
		}
		[CCode(cname = "blkid_partlist_get_partition")]
		public unowned Partition? get(int n);
		[CCode(cname = "blkid_partlist_devno_to_partition")]
		public unowned Partition? get_by_dev_no(Posix.dev_t devno);
	}
	/**
	 * Information about a partition table
	 */
	[CCode(cname = "struct blkid_struct_parttable", has_type_id = false)]
	[Compact]
	public class PartTable {
		public int64 offset {
			[CCode(cname = "blkid_parttable_get_offset")]
			get;
		}
		public Partition? parent {
			[CCode(cname = "blkid_parttable_get_parent")]
			get;
		}
		public string? type {
			[CCode(cname = "blkid_parttable_get_type")]
			get;
		}
	}
	/**
	 * Information about a partition
	 */
	[CCode(cname = "struct blkid_struct_partition", has_type_id = false)]
	[Compact]
	public class Partition {
		public PartInfo flags {
			[CCode(cname = "blkid_partition_get_flags")]
			get;
		}
		public bool is_extended {
			[CCode(cname = "blkid_partition_is_extended")]
			get;
		}
		public bool is_logical {
			[CCode(cname = "blkid_partition_is_logical")]
			get;
		}
		public bool is_primary {
			[CCode(cname = "blkid_partition_is_primary")]
			get;
		}
		public string? name {
			[CCode(cname = "blkid_partition_get_name")]
			get;
		}
		public int number {
			[CCode(cname = "blkid_partition_get_partno")]
			get;
		}
		public int64 size {
			[CCode(cname = "blkid_partition_get_size")]
			get;
		}
		public int64 start {
			[CCode(cname = "blkid_partition_get_start")]
			get;
		}
		public PartTable table {
			[CCode(cname = "blkid_partition_get_table")]
			get;
		}
		public int type {
			[CCode(cname = "blkid_partition_get_type")]
			get;
		}
		public string? type_name {
			[CCode(cname = "blkid_partition_get_type_string")]
			get;
		}
		public string? uuid {
			[CCode(cname = "blkid_partition_get_uuid")]
			get;
		}
	}
	[CCode(cname = "struct blkid_struct_probe", free_function = "", has_type_id = false)]
	[Compact]
	public class PartitionFilter {
		public bool enabled {
			[CCode(cname = "blkid_probe_enable_partitions")]
			set;
		}
		public PartInfo flags {
			[CCode(cname = "blkid_probe_set_partitions_flags")]
			set;
		}
		[CCode(cname = "blkid_probe_invert_partitions_filter")]
		public int invert();
		[CCode(cname = "blkid_probe_reset_partitions_filter")]
		public int reset();
		[CCode(cname = "blkid_probe_filter_partitions_type")]
		public int set(Filter flag, [CCode(array_null_terminated = true)] string[] names);
	}
	/**
	 * low-level probing setting
	 */
	[CCode(cname = "struct blkid_struct_probe", free_function = "blkid_free_probe", has_type_id = false)]
	[Compact]
	public class Prober {
		public Posix.dev_t devno {
			[CCode(cname = "blkid_probe_get_devno")]
			get;
		}
		public bool enable_topology {
			[CCode(cname = "blkid_probe_enable_topology")]
			set;
		}
		public int fd {
			[CCode(cname = "blkid_probe_get_fd")]
			get;
		}
		public bool is_whole_disk {
			[CCode(cname = "blkid_probe_is_wholedisk")]
			get;
		}
		public int64 offset {
			[CCode(cname = "blkid_probe_get_offset")]
			get;
		}
		public PartitionFilter partition_filter {
			[CCode(cname = "")]
			get;
		}
		public PartList partitions {
			[CCode(cname = "blkid_probe_get_partitions")]
			get;
		}
		public uint sector_size {
			[CCode(cname = "blkid_probe_get_sectorsize")]
			get;
		}
		public int64 sectors {
			[CCode(cname = "blkid_probe_get_sectors")]
			get;
		}
		public int64 size {
			[CCode(cname = "blkid_probe_get_size")]
			get;
		}
		public SuperblockFilter superblock_filter {
			[CCode(cname = "")]
			get;
		}
		/**
		 * The topology chain provides details about Linux block devices
		 */
		public Topology? topology {
			[CCode(cname = "blkid_probe_get_topology")]
			get;
		}
		public int value_count {
			[CCode(cname = "blkid_probe_numof_values")]
			get;
		}
		public Posix.dev_t whole_disk_devno {
			[CCode(cname = "blkid_probe_get_wholedisk_devno")]
			get;
		}
		[CCode(cname = "blkid_new_probe")]
		public Prober();
		[CCode(cname = "blkid_new_probe_from_filename")]
		public static Prober? open(string filename);
		[CCode(cname = "blkid_probe_has_value")]
		public bool contains(string name);
		/**
		 * This function gathers probing results from all enabled chains.
		 *
		 * Same as {@link do_safe_probe} but does not check for collision between probing result.
		 *
		 * This is string-based NAME=value interface only.
		 */
		[CCode(cname = "blkid_do_fullprobe")]
		public int do_full_probe();
		/**
		 * Calls probing functions in all enabled chains.
		 *
		 * The superblocks chain is enabled by default. The probe stores result from only one probing function. It's necessary to call this routine in a loop to get results from all probing functions in all chains. The probing is reset by {@link reset} or by filter functions.
		 *
		 * This is string-based NAME=value interface only.
		 */
		[CCode(cname = "blkid_do_probe")]
		public int do_probe();
		/**
		 * This function gathers probing results from all enabled chains and checks for ambivalent results (e.g. more filesystems on the device).
		 *
		 * This is string-based NAME=value interface only.
		 *
		 * Note about suberblocks chain -- the function does not check for filesystems when a RAID signature is detected. The function also does not check for collision between RAIDs. The first detected RAID is returned. The function checks for collision between partition table and RAID signature -- it's recommended to enable partitions chain together with superblocks chain.
		 */
		[CCode(cname = "blkid_do_safeprobe")]
		public int do_safe_probe();
		[CCode(cname = "blkid_probe_get_value")]
		public int get_value(int num, out unowned string name, [CCode(array_length_type = "size_t")] out unowned uint8[]? data);
		[CCode(cname = "blkid_probe_lookup_value")]
		public int lookup_value(string name, [CCode(array_length_type = "size_t")] out unowned uint8[]? data);
		/**
		 * Zeroize probing results and resets the current probing.
		 *
		 * This has impact to {@link do_probe} only). This function does not touch probing filters and keeps assigned device.
		 */
		[CCode(cname = "blkid_reset_probe")]
		public void reset();
		/**
		 * Assigns the device to probe control struct, resets internal buffers and resets the current probing.
		 * @param fd device file descriptor
		 * @param off begin of probing area
		 * @param size size of probing area (zero means whole device/file)
		 */
		[CCode(cname = "blkid_probe_set_device")]
		public int set_device(int fd, int64 off, int64 size);

	}
	[CCode(cname = "struct blkid_struct_probe", free_function = "", has_type_id = false)]
	[Compact]
	public class SuperblockFilter {
		public bool enabled {
			[CCode(cname = "blkid_probe_enable_superblocks")]
			set;
		}
		public SuperBlock flags {
			[CCode(cname = "blkid_probe_set_superblocks_flags")]
			set;
		}
		[CCode(cname = "blkid_probe_invert_superblocks_filter")]
		public int invert();
		[CCode(cname = "blkid_probe_reset_superblocks_filter")]
		public int reset();
		[CCode(cname = "blkid_probe_filter_superblocks_type")]
		public int set_type(Filter flag, [CCode(array_null_terminated = true)] string[] names);
		[CCode(cname = "blkid_probe_filter_superblocks_usage")]
		public int set_usage(Filter flag, Usage usage);
	}
	/**
	 * Tags iterator for high-level API
	 */
	[CCode(cname = "struct blkid_struct_tag_iterate", free_function = "blkid_tag_iterate_end", has_type_id = false)]
	[Compact]
	public class TagIterate {
		[CCode(cname = "blkid_tag_next")]
		public int next_tag(out unowned string? type, out unowned string? @value);
		public string[]? next_value() {
			unowned string? type;
			unowned string? @value;
			return next_tag(out type, out @value) == 0 ? new string[] { type, @value} : null;
		}
	}
	/**
	 * Device topology information
	 */
	[CCode(cname = "struct blkid_struct_topology", has_type_id = false)]
	[Compact]
	public class Topology {
		/**
		 * How many bytes the beginning of the device is offset from the disk's natural alignment.
		 */
		public ulong alignment_offset {
			[CCode(cname = "blkid_topology_get_alignment_offset")]
			get;
		}
		/**
		 * The smallest unit the storage device can address. It is typically 512 bytes.
		 */
		public ulong logical_sector_size {
			[CCode(cname = "blkid_topology_get_logical_sector_size")]
			get;
		}
		/**
		 * Minimum size which is the device's preferred unit of I/O. For RAID arrays it is often the stripe chunk size.
		 */
		public ulong minimum_io_size {
			[CCode(cname = "blkid_topology_get_minimum_io_size")]
			get;
		}
		/**
		 * Usually the stripe width for RAID or zero. For RAID arrays it is usually the stripe width or the internal track size.
		 */
		public ulong optimal_io_size {
			[CCode(cname = "blkid_topology_get_optimal_io_size")]
			get;
		}
		/**
		 * The smallest unit a physical storage device can write atomically. It is usually the same as the logical sector size but may be bigger.
		 */
		public ulong physical_sector_size {
			[CCode(cname = "blkid_topology_get_physical_sector_size")]
			get;
		}
	}
	[CCode(cname = "BLKID_DATE")]
	public const string DATE;
	[CCode(cname = "BLKID_VERSION")]
	public const string VERSION;
	/**
	 * This function finds the pathname to a block device with a given device number.
	 */
	[CCode(cname = "blkid_devno_to_devname")]
	public string? devno_to_name(Posix.dev_t devno);
	/**
	 * This function uses sysfs to convert the devno device number to the '''name''' of the whole disk.
	 *
	 * The function DOES NOT return full device name. The dev argument could be partition or whole disk -- both are converted.
	 * @see devno_to_name
	 */
	[CCode(cname = "blkid_devno_to_wholedisk")]
	public int devno_to_wholedisk(Posix.dev_t dev, [CCode(array_length_type = "size_t")] uint8[]? buffer, out Posix.dev_t diskdevno);
	/**
	 * Encode all potentially unsafe characters of a string to the corresponding hex value prefixed by '\x'.
	 */
	[CCode(cname = "blkid_encode_string")]
	public int encode_string(string str, [CCode(array_length_type = "size_t")] uint8[] buffer);
	/**
	 * All returned paths are canonicalized, device-mapper paths are converted to the /dev/mapper/name format.
	 * @param token an unparsed tag (e.g., LABEL=foo) or path
	 * @return the device name
	 */
	[CCode(cname = "blkid_evaluate_spec")]
	public string? evaluate_spec(string token, Cache? cache = null);
	/**
	 * Evaluate a tag.
	 * @param token the token name (e.g., LABEL or UUID) or the unparsed tag (e.g., LABEL=foo)
	 * @param value the token data
	 * @return the device name
	 */
	[CCode(cname = "blkid_evaluate_tag")]
	public string? evaluate_tag(string token, string @value, Cache? cache = null);
	[CCode(cname = "blkid_get_dev_size")]
	public int64 get_dev_size(int fd);
	[CCode(cname = "blkid_superblocks_get_name")]
	public int get_superblock_name(size_t idx, out unowned string? name, out Usage usage);
	/**
	 * Get the library version.
	 * @param ver_string the release version (not the SONAME)
	 * @return release version code
	 */
	[CCode(cname = "blkid_get_library_version")]
	public int get_version(out unowned string ver_string, out unowned string date_string);
	[CCode(cname = "blkid_known_fstype")]
	public bool is_known_fs_type(string fstype);
	[CCode(cname = "blkid_known_pttype")]
	public bool is_known_part_type(string pttype);
	/**
	 * Parse a "NAME=value" string.
	 */
	[CCode(cname = "blkid_parse_tag_string")]
	public int parse_tag_string(string token, out string? type, out string? val);
	[CCode(cname = "blkid_parse_version_string")]
	public int parse_version(string ver_string);
	/**
	 * Allows plain ASCII, hex-escaping and valid utf8. Replaces all whitespaces with '_'.
	 */
	[CCode(cname = "blkid_safe_string")]
	public int safe_string([CCode(array_length_type = "size_t")] uint8[] buffer);
	/**
	 * Sends a uevent
	 * @param devname absolute path to the device
	 * @param action event string
	 */
	[CCode(cname = "blkid_send_uevent")]
	public int send_uevent(string devname, string action);
}

