[CCode(cheader_filename = "libudev.h")]
namespace UDev {
	/**
	 * Reads the udev config and system environment allows custom logging
	 */
	[CCode(cname = "struct udev", ref_function = "udev_ref", unref_function = "udev_unref", has_type_id = false)]
	public class Context {
		/**
		 * Create udev library context.
		 *
		 * This reads the udev configuration file, and fills in the default values.
		 */
		[CCode(cname = "udev_new")]
		public Context();
		/**
		 * The device directory path.
		 *
		 * The default value is "/dev", the actual value may be overridden in the
		 * udev configuration file.
		 */
		[CCode(cname = "udev_get_dev_path")]
		public string dev_path {
			get;
		}
		public int log_priority {
			[CCode(cname = "udev_get_log_priority")]
			get;
			[CCode(cname = "udev_set_log_priority")]
			set;
		}
		/**
		 * The udev runtime directory path.
		 *
		 * The default is "/run/udev".
		 */
		[CCode(cname = "udev_get_run_path")]
		public string run_path {
			get;
		}
		/**
		 * The sysfs mount point.
		 *
		 * The default is "/sys". For testing purposes, it can be overridden with
		 * udev_sys= in the udev configuration file.
		 */
		[CCode(cname = "udev_get_sys_path")]
		public string sys_path {
			get;
		}
		public void* user_data {
			[CCode(cname = "udev_get_userdata")]
			get;
			[CCode(cname = "udev_set_userdata")]
			set;
		}
		[CCode(cname = "udev_enumerate_new")]
		public Enumerate create_enumerate();
		[CCode(cname = "udev_queue_new")]
		public Queue? create_queue();
		/**
		 * Create new udev monitor and connect to a specified event source. Valid
		 * sources identifiers are "udev" and "kernel".
		 *
		 * Applications should usually not connect directly to the "kernel" events,
		 * because the devices might not be useable at that time, before udev has
		 * configured them, and created device nodes. Accessing devices at the same
		 * time as udev, might result in unpredictable behavior. The "udev" events
		 * are sent out after udev has finished its event processing, all rules
		 * have been processed, and needed device nodes are created.
		 */
		[CCode(cname = "udev_monitor_new_from_netlink")]
		public Monitor? monitor_from_netlink(string name = "udev");
		/**
		 * Create a new udev monitor and connect to a specified socket.
		 *
		 * The path to a socket either points to an existing socket file, or if the
		 * socket path starts with a '@' character, an abstract namespace socket
		 * will be used.
		 *
		 * A socket file will not be created. If it does not already exist, it will
		 * fall-back and connect to an abstract namespace socket with the given
		 * path. The permissions adjustment of a socket file, as well as the later
		 * cleanup, needs to be done by the caller.
		 */
		[Deprecated]
		[CCode(cname = "udev_monitor_new_from_socket")]
		public Monitor? monitor_from_socket(string socket_path);
		/**
		 * Create new udev device, and fill in information from the current process
		 * environment.
		 *
		 * This only works reliable if the process is called from a udev rule. It
		 * is usually used for tools executed from IMPORT= rules.
		 */
		[CCode(cname = "udev_device_new_from_environment")]
		public Device? new_from_environment();
		/**
		 * Create new udev device, and fill in information from the sys device and
		 * the udev database entry by its major/minor number and type.
		 *
		 * Character and block device numbers are not unique across the two types.
		 * @param type 'c' for character devices or 'b' for block devices.
		 */
		[CCode(cname = "udev_device_new_from_devnum")]
		public Device? open_devnum(char type, Posix.dev_t devnum);
		/**
		 * Create new udev device, and fill in information from the sys device
		 * and the udev database entry. The device is looked up by the subsystem
		 * and name string of the device, like "mem" / "zero", or "block" / "sda".
		 */
		[CCode(cname = "udev_device_new_from_subsystem_sysname")]
		public Device? open_subsystem_sysname(string subsystem, string sysname);
		/**
		 * Create new udev device, and fill in information from the sys device and
		 * the udev database entry.
		 *
		 * The syspath is the absolute path to the device, including the sys mount
		 * point.
		 */
		[CCode(cname = "udev_device_new_from_syspath")]
		public Device? open_syspath(string syspath);
		/**
		 * Take a reference of the udev library context.
		 */
		[CCode(cname = "udev_ref")]
		public void ref();
		/**
		 * The error logging function.
		 *
		 * The built-in logging writes to stderr. It can be overridden by a custom
		 * function, to plug log messages into the users' logging functionality.
		 */
		[CCode(cname = "udev_set_log_fn")]
		public void set_logger(Logger logger);

		/**
		 * Drop a reference of the udev library context.
		 */
		[CCode(cname = "udev_unref")]
		public void unref();

	}

	/**
	 * Kernel sys devices
   *
	 * Representation of kernel sys devices. Devices are uniquely identified by
	 * their syspath, every device has exactly one path in the kernel sys
	 * filesystem. Devices usually belong to a kernel subsystem, and and have a
	 * unique name inside that subsystem.
	 */
	[CCode(cname = "struct udev_device", ref_function = "udev_device_ref", unref_function = "udev_device_unref", has_type_id = false)]
	public class Device {
		/**
		 * The action if the device was received through a monitor.
		 *
		 * Devices read from sys do not have an action string. Usual actions are: add, remove, change, online, offline.
		 */
		public string? action {
			[CCode(cname = "udev_device_get_action")]
			get;
		}

		/**
		 * An indexable collection of sys attrs
		 */
		public SysAttr attr {
			[CCode(cname = "")]
			get;
		}
		/**
		 * The udev library context with which the device was created.
		 */
		public Context context {
			[CCode(cname = "udev_device_get_udev")]
			get;
		}
		/**
		 * The list of device links pointing to the device file of the udev device.
		 */
		public List? devlinks {
			[CCode(cname = "udev_device_get_devlinks_list_entry")]
			get;
		}
		/**
		 * Retrieve the device node file name belonging to the udev device.
		 *
		 * The path is an absolute path, and starts with the device directory.
		 */
		public string? devnode {
			[CCode(cname = "udev_device_get_devnode")]
			get;
		}
		/**
		 * The the device major/minor number
		 */
		public Posix.dev_t devnum {
			[CCode(cname = "udev_device_get_devnum")]
			get;
		}
		/**
		 * Retrieve the kernel devpath value of the udev device.
		 *
		 * The path does not contain the sys mount point, and starts with a '/'.
		 */
		public string devpath {
			[CCode(cname = "udev_device_get_devpath")]
			get;
		}
		/**
		 * The devtype name of the device, if it can be determined.
		 */
		public string? devtype {
			[CCode(cname = "udev_device_get_devtype")]
			get;
		}
		/**
		 * Get the name of the driver, if one is attached.
		 */
		public string? driver {
			[CCode(cname = "udev_device_get_driver")]
			get;
		}
		/**
		 * Has already handled the device and has set up device node permissions
		 * and context, or has renamed a network device?
		 *
		 * This is only implemented for devices with a device node or network
		 * interfaces. All other devices return true.
		 */
		public bool is_initialized {
			[CCode(cname = "udev_device_get_is_initialized")]
			get;
		}
		/**
		 * Find the next parent device, and fill in information from the sys device
		 * and the udev database entry.
		 *
		 * It is not necessarily just the upper level directory, empty or not
		 * recognized sys directories are ignored.
		 */
		public Device? parent {
			[CCode(cname = "udev_device_get_parent")]
			get;
		}
		/**
		 * The list of key/value device properties of the udev device.
		 */
		public List? properties {
			[CCode(cname = "udev_device_get_properties_list_entry")]
			get;
		}
		/**
		 * The sequence number
		 *
		 * This is only valid if the device was received through a monitor. Devices read from sys do not have a sequence number.
		 */
		public uint64 seqnum {
			[CCode(cname = "udev_device_get_seqnum")]
			get;
		}
		/**
		 * The subsystem string of the device, if it can be determined.
		 *
		 * This string will not contain /.
		 */
		public string? subsystem {
			[CCode(cname = "udev_device_get_subsystem")]
			get;
		}
		/**
		 * The list of available sysattrs, with value being empty.
		 *
		 * This just return all available sysfs attributes for a particular device
		 * without reading their values.
		 */
		public List sysattr {
			[CCode(cname = "udev_device_get_sysattr_list_entry")]
			get;
		}
		/**
		 * The sys name of the device device
		 */
		public string sysname {
			[CCode(cname = "udev_device_get_sysname")]
			get;
		}
		/**
		 * The trailing number of of the device name
		 */
		public string sysnum {
			[CCode(cname = "udev_device_get_sysnum")]
			get;
		}
		/**
		 * Retrieve the absolute sys path of the udev device starting with the sys mount point.
		 */
		public string syspath {
			[CCode(cname = "udev_device_get_syspath")]
			get;
		}
		/**
		 * The list of tags attached to the udev device
		 */
		public List? tags {
			[CCode(cname = "udev_device_get_tags_list_entry")]
			get;
		}
		/**
		 * The number of microseconds passed since udev set up the device for the
		 * first time.
		 *
		 * This is only implemented for devices with need to store properties
		 * in the udev database. All other devices are 0.
		 */
		public uint64 usec_since_initialized {
			[CCode(cname = "udev_device_get_usec_since_initialized")]
			get;
		}
		/**
		 * Get the value of a device property, if one exists.
		 */
		[CCode(cname = "udev_device_get_property_value")]
		public unowned string? get(string key);
		/**
		 * Find the next parent device, with a matching subsystem and devtype
		 * value, and fill in information from the sys device and the udev database
		 * entry.
		 *
		 * @param devtype the type of the device, or null to match any.
		 */
		[CCode(cname = "udev_device_get_parent_with_subsystem_devtype")]
		public unowned Device? get_parent(string subsystem, string? devtype = null);
		[CCode(cname = "udev_device_has_tag")]
		public bool has_tag(string tag);
		/**
		 * Take a reference of a udev device.
		 */
		[CCode(cname = "udev_device_ref")]
		public void ref();
		/**
		 * Drop a reference of a udev device.
		 */
		[CCode(cname = "udev_device_unref")]
		public void unref();

	}

	/**
	 * Search sysfs for specific devices and provide a sorted list
	 */
	[CCode(cname = "struct udev_enumerate", ref_function = "udev_enumerate_ref", unref_function = "udev_enumerate_unref", has_type_id = false)]
	public class Enumerate {
		/**
		 * The udev library context.
		 */
		public Context context {
			[CCode(cname = "udev_enumerate_get_udev")]
			get;
		}
		/**
		 * The sorted list of device paths.
		 */
		public List? entries {
			[CCode(cname = "udev_enumerate_get_list_entry")]
			get;
		}
		/**
		 * Match only devices which udev has set up already.
		 *
		 * This makes sure, that the device node permissions and context are
		 * properly set and that network devices are fully renamed.
		 *
		 * Usually, devices which are found in the kernel but not already handled
		 * by udev, have still pending events. Services should subscribe to monitor
		 * events and wait for these devices to become ready, instead of using
		 * uninitialized devices.
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_match_is_initialized")]
		public bool add_match_is_initialized();
		/**
		 * Return the devices on the subtree of one given device.
		 *
		 * The parent itself is included in the list.
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_match_parent")]
		public bool add_match_parent(Device parent);
		/**
		 * Filter for a property of the device to include in the list
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_match_property")]
		public bool add_match_property(string property, string @value);
		/**
		 * Filter for a subsystem of the device to include in the list
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_match_subsystem")]
		public bool add_match_subsystem(string subsystem);
		/**
		 * Filter for a sys attribute at the device to include in the list
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_match_sysattr")]
		public bool add_match_sysattr(string sysattr, string @value);
		/**
		 * Filter for the name of the device to include in the list
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_match_sysname")]
		public bool add_match_sysname(string sysname);
		/**
		 * Filter for a tag of the device to include in the list
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_match_tag")]
		public bool add_match_tag(string tag);
		/**
		 * Filter for a subsystem of the device to exclude from the list
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_nomatch_subsystem")]
		public bool add_nomatch_subsystem(string subsystem);
		/**
		 * Filter for a sys attribute at the device to exclude from the list
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_nomatch_sysattr")]
		public bool add_nomatch_sysattr(string sysattr, string @value);
		/**
		 * Add a device to the list of devices, to retrieve it back sorted in dependency order.
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_add_syspath")]
		public bool add_syspath(string syspath);
		/**
		 * Take a reference of a enumeration context.
		 */
		[CCode(cname = "udev_enumerate_ref")]
		public void ref();
		/**
		 * Run enumeration with active filters
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_scan_devices")]
		public bool scan_devices();
		/**
		 * Run enumeration with active filters
		 * @return false on success
		 */
		[CCode(cname = "udev_enumerate_scan_subsystems")]
		public bool scan_subsystems();
		/**
		 * Drop a reference of an enumeration context.
		 */
		[CCode(cname = "udev_enumerate_unref")]
		public void unref();
	}

	[CCode(cname = "struct udev_list_entry", free_function = "")]
	[Compact]
	public class List {
		[CCode(cname = "udev_list_entry_get_by_name")]
		public List? get(string name);
		public string name {
			[CCode(cname = "udev_list_entry_get_name")]
			get;
		}
		public List? next {
			[CCode(cname = "udev_list_entry_get_next")]
			get;
		}
		public string @value {
			[CCode(cname = "udev_list_entry_get_value")]
			get;
		}
	}

	/**
	 * Connection to a device event source.
	 */
	[CCode(cname = "struct udev_monitor", ref_function = "udev_monitor_ref", unref_function = "udev_monitor_unref", has_type_id = false)]
	public class Monitor {
		/**
		 * The udev library context with which the monitor was created.
		 */
		public Context context {
			[CCode(cname = "udev_monitor_get_udev")]
			get;
		}

		/**
		 * The socket file descriptor associated with the monitor.
		 */
		public int fd {
			[CCode(cname = "udev_monitor_get_fd")]
			get;
		}

		/**
		 * This filter is efficiently executed inside the kernel, and libudev
		 * subscribers will usually not be woken up for devices which do not match.
		 *
		 * The filter must be installed before the monitor is switched to listening mode.
		 * @return false on success
		 */
		[CCode(cname = "udev_monitor_filter_add_match_subsystem_devtype")]
		public bool add_match_subsystem_devtype(string subsystem, string? devtype = null);
		/**
		 * This filter is efficiently executed inside the kernel, and libudev
		 * subscribers will usually not be woken up for devices which do not match.
		 *
		 * The filter must be installed before the monitor is switched to listening mode.
		 * @return false on success
		 */
		[CCode(cname = "udev_monitor_filter_add_match_tag")]
		public bool add_match_tag(string tag);
		/**
		 * Binds the monitor socket to the event source.
		 * @return false on success
		 */
		[CCode(cname = "udev_monitor_enable_receiving")]
		public bool enable_receiving();
		/**
		 * Receive data from the udev monitor socket, allocate a new udev device,
		 * fill in the received data, and return the device.
		 *
		 * Only socket connections with uid=0 are accepted.
		 * @return a new udev device, or null, in case of an error
		 */
		[CCode(cname = "udev_monitor_receive_device")]
		public Device? receive_device();
		/**
		 * Take a reference of a udev monitor.
		 */
		[CCode(cname = "udev_monitor_ref")]
		public void ref();
		/**
		 * Remove all filters from monitor.
		 * @return false on success
		 */
		[CCode(cname = "udev_monitor_filter_remove")]
		public bool remove_filter();
		/**
		 * Set the size of the kernel socket buffer.
		 *
		 * This call needs the appropriate privileges to succeed.
		 * @return false on success
		 */
		[CCode(cname = "udev_monitor_set_receive_buffer_size")]
		public bool set_receive_buffer_size(int size);
		/**
		 * Drop a reference of a udev monitor.
		 */
		[CCode(cname = "udev_monitor_unref")]
		public void unref();
		/**
		 * Update the installed socket filter.
		 *
		 * This is only needed, if the filter was removed or changed.
		 * @return false on success
		 */
		[CCode(cname = "udev_monitor_filter_update")]
		public bool update_filter();
	}
	/**
	 * Access to currently active events
	 *
	 * The udev daemon processes events asynchronously. All events which do not
	 * have interdependencies run in parallel. This exports the current state of
	 * the event processing queue, and the current event sequence numbers from
	 * the kernel and the udev daemon.
	 */
	[CCode(cname = "struct udev_queue", ref_function = "udev_queue_ref", unref_function = "udev_queue_unref", has_type_id = false)]
	public class Queue {
		/**
		 * The udev library context with which the queue context was created.
		 */
		public Context context {
			[CCode(cname = "udev_queue_get_udev")]
			get;
		}
		/**
		 * The list of queued events.
		 */
		public List? events {
			[CCode(cname = "udev_queue_get_queued_list_entry")]
			get;
		}
		public bool is_active {
			[CCode(cname = "udev_queue_get_udev_is_active")]
			get;
		}
		public bool is_empty {
			[CCode(cname = "udev_queue_get_queue_is_empty")]
			get;
		}
		/**
		 * The current kernel event sequence number.
		 */
		public uint64 kernel_seqnum {
			[CCode(cname = "udev_queue_get_kernel_seqnum")]
			get;
		}
		/**
		 * The last known udev event sequence number.
		 */
		public uint64 udev_seqnum {
			[CCode(cname = "udev_queue_get_udev_seqnum")]
			get;
		}
		/**
		 * Indicates whether the given sequence number is currently active.
		 */
		[CCode(cname = "udev_queue_get_seqnum_is_finished")]
		public bool is_finished(uint64 seqnum);
		/**
		 * Indicates if any of the sequence numbers in the given range is currently active.
		 */
		[CCode(cname = "udev_queue_get_seqnum_sequence_is_finished")]
		public bool is_sequence_finished(uint64 start, uint64 end);
		/**
		 * Take a reference of a udev queue context.
		 */
		[CCode(cname = "udev_queue_ref")]
		public void ref();
		/**
		 * Drop a reference of a udev queue context.
		 */
		[CCode(cname = "udev_queue_unref")]
		public void unref();
	}
	/**
	 * Internal class to make sysattrs easy to access
	 */
	[CCode(cname = "struct udev_device", ref_function = "udev_device_ref", unref_function = "udev_device_unref", has_type_id = false)]
	public class SysAttr {
		/**
		 * The content of a sys attribute file, null if there is a sys attribute value.
		 *
		 * The retrieved value is cached in the device. Repeated calls will return the same
		 * value and not open the attribute again.
		 */
		[CCode(cname = "udev_device_get_sysattr_value")]
		public unowned string? get(string sysattr);
}

	public delegate void Logger(Context udev, int priority, string file, int line, string fn, string format, va_list args);

	/**
	 * Encode all potentially unsafe characters of a string to the corresponding 2 char hex value prefixed by '\x'.
	 * @param buffer the output buffer to store the string which might be four times the length of the input.
	 * @return true on error
	 */
	[CCode(cname = "udev_util_encode_string")]
	public bool encode_string(string str, char[] buffer);
}
