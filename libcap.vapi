[CCode(cheader_filename = "sys/capability.h")]
/**
 * Defunct POSIX.1e Standard: 25.2 Capabilities
 */
namespace Posix {
	/**
	 * Capability handle
	 */
	[CCode(cname = "struct _cap_struct", free_function = "cap_free")]
	[Compact]
	public class Capability {
		[CCode(cname = "cap_flag_t", cprefix = "CAP_")]
		public enum Flag {
			EFFECTIVE,
			PERMITTED,
			INHERITABLE;
			/**
			 * Evaluates if the returned status from {@link compare} differs in this flag component.
			 */
			[CCode(cname = "CAP_DIFFERS", instance_pos = -1)]
			public bool differs(int result);
		}
		[CCode(cname = "cap_value_t", cprefix = "CAP_")]
		public enum Value {
			/**
			 * This overrides the restriction of changing file ownership and group ownership.
			 */
			CHOWN,
			/**
			 * Override all DAC access, including ACL execute access. Excluding DAC access covered by {@link LINUX_IMMUTABLE}.
			 */
			DAC_OVERRIDE,
			/**
			 * Overrides all DAC restrictions regarding read and search on files and directories, including ACL restrictions. Excluding DAC access covered by {@link LINUX_IMMUTABLE}.
			 */
			DAC_READ_SEARCH,
			/**
			 * Overrides all restrictions about allowed operations on files, where file owner ID must be equal to the user ID, except where {@link FSETID} is applicable. It doesn't override MAC and DAC restrictions.
			 */
			FOWNER,
			/**
			 * Overrides the following restrictions that the effective user ID shall match the file owner ID when setting the S_ISUID and S_ISGID bits on that file; that the effective group ID (or one of the supplementary group IDs) shall match the file owner ID when setting the S_ISGID bit on that file; that the S_ISUID and S_ISGID bits are cleared on successful return from chown(2) (not implemented).
			 */
			FSETID,
			/**
			 * Overrides the restriction that the real or effective user ID of a process sending a signal must match the real or effective user ID of the process receiving the signal.
			 */
			KILL,
			/**
			 * Allows setgid(2) manipulation, setgroups(2), and forged gids on socket credentials passing.
			 */
			SETGID,
			/**
			 * Allows set*uid(2) manipulation (including fsuid) and forged pids on socket credentials passing.
			 */
			SETUID,
			/**
			 * Without VFS support for capabilities:
			 * Transfer any capability in your permitted set to any pid,
			 * remove any capability in your permitted set from any pid.
			 * With VFS support for capabilities (neither of above, but)
			 * Add any capability from current's capability bounding set
			 * to the current process' inheritable set,
			 * Allow taking bits out of capability bounding set,
			 * Allow modification of the securebits for a process.
			 */
			SETPCAP,
			/**
			 * Allow modification of S_IMMUTABLE and S_APPEND file attributes.
			 */
			LINUX_IMMUTABLE,
			/**
			 * Allows binding to TCP/UDP sockets below 1024 and binding to ATM VCIs below 32.
			 */
			NET_BIND_SERVICE,
			/**
			 * Allow broadcasting, listen to multicast.
			 */
			NET_BROADCAST,
			/**
			 * Allow interface configuration.
			 * Allow administration of IP firewall, masquerading and accounting.
			 * Allow setting debug option on sockets.
			 * Allow modification of routing tables.
			 * Allow setting arbitrary process / process group ownership on sockets.
			 * Allow binding to any address for transparent proxying (also via NET_RAW).
			 * Allow setting TOS (type of service).
			 * Allow setting promiscuous mode.
			 * Allow clearing driver statistics.
			 * Allow multicasting.
			 * Allow read/write of device-specific registers.
			 * Allow activation of ATM control sockets.
			 */
			NET_ADMIN,
			/**
			 * Allow use of RAW sockets.
			 * Allow use of PACKET sockets.
			 * Allow binding to any address for transparent proxying (also via {@link NET_ADMIN}).
			 */
			NET_RAW,
			/**
			 * Allow locking of shared memory segments and mlock and mlockall (which doesn't really have anything to do with IPC).
			 */
			IPC_LOCK,
			/**
			 * Override IPC ownership checks
			 */
			IPC_OWNER,
			/**
			 * Insert and remove kernel modules - modify kernel without limit
			 */
			SYS_MODULE,
			/**
			 * Allow ioperm/iopl access and sending USB messages to any device via /proc/bus/usb
			 */
			SYS_RAWIO,
			/**
			 * Allow use of chroot()
			 */
			SYS_CHROOT,
			/**
			 * Allow ptrace() of any process
			 */
			SYS_PTRACE,
			/**
			 * Allow configuration of process accounting
			 */
			SYS_PACCT,
			/**
			 * Allow configuration of the secure attention key.
			 * Allow administration of the random device.
			 * Allow examination and configuration of disk quotas.
			 * Allow setting the domainname.
			 * Allow setting the hostname.
			 * Allow calling bdflush().
			 * Allow mount() and umount(), setting up new smb connection.
			 * Allow some autofs root ioctls.
			 * Allow nfsservctl.
			 * Allow VM86_REQUEST_IRQ.
			 * Allow to read/write pci config on alpha.
			 * Allow irix_prctl on mips (setstacksize).
			 * Allow flushing all cache on m68k (sys_cacheflush).
			 * Allow removing semaphores.
			 * Used instead of {@link Value.CHOWN} to "chown" IPC message queues, semaphores and shared memory.
			 * Allow locking/unlocking of shared memory segment.
			 * Allow turning swap on/off.
			 * Allow forged pids on socket credentials passing.
			 * Allow setting readahead and flushing buffers on block devices.
			 * Allow setting geometry in floppy driver.
			 * Allow turning DMA on/off in xd driver.
			 * Allow administration of md devices (mostly the above, but some
 extra ioctls).
			 * Allow tuning the ide driver.
			 * Allow access to the nvram device.
			 * Allow administration of apm_bios, serial and bttv (TV) device.
			 * Allow manufacturer commands in isdn CAPI support driver.
			 * Allow reading non-standardized portions of pci configuration space.
			 * Allow DDI debug ioctl on sbpcd driver.
			 * Allow setting up serial ports.
			 * Allow sending raw qic-117 commands.
			 * Allow enabling/disabling tagged queuing on SCSI controllers and sending
 arbitrary SCSI commands.
			 * Allow setting encryption key on loopback filesystem.
			 * Allow setting zone reclaim policy.
			 */
			SYS_ADMIN,
			/**
			 * Allow use of reboot()
			 */
			SYS_BOOT,
			/**
			 * Allow raising priority and setting priority on other (different UID) processes,
			 * the use of FIFO and round-robin (realtime) scheduling on own processes and setting the scheduling algorithm used by another process and setting cpu affinity on other processes.
			 */
			SYS_NICE,

			/**
			 * Override resource limits. Set resource limits.
			 *
			 * Override quota limits.
			 * Override reserved space on ext2 filesystem.
			 * Modify data journaling mode on ext3 filesystem (uses journaling resources).
			 * NOTE: ext2 honors fsuid when checking for resource overrides, so you can override using fsuid too.
			 * Override size restrictions on IPC message queues.
			 * Allow more than 64hz interrupts from the real-time clock.
			 * Override max number of consoles on console allocation.
			 * Override max number of keymaps.
			 */
			SYS_RESOURCE,
			/**
			 * Allow manipulation of system clock, irix_stime on mips, and the real-time clock
			 */
			SYS_TIME,
			/**
			 * Allow configuration of tty devices and vhangup() of tty
			 */
			SYS_TTY_CONFIG,
			/**
			 * Allow the privileged aspects of mknod()
			 */
			MKNOD,

			/**
			 * Allow taking of leases on files
			 */
			LEASE,
			AUDIT_WRITE,
			AUDIT_CONTROL,
			SETFCAP,
			/**
			 * Override MAC access.
			 *
			 * The base kernel enforces no MAC policy. An LSM may enforce a MAC policy, and if it does and it chooses to implement capability based overrides of that policy, this is the capability it should use to do so.
			 */
			MAC_OVERRIDE,
			/**
			 * Allow MAC configuration or state changes.
			 *
			 * The base kernel requires no MAC configuration. An LSM may enforce a MAC policy, and if it does and it chooses to implement capability based checks on modifications to that policy or the data required to maintain it, this is the capability it should use to do so.
			 */
			MAC_ADMIN,
			/**
			 * Allow configuring the kernel's syslog (printk behaviour)
			 */
			SYSLOG,
			/**
			 * Allow triggering something that will wake the system
			 */
			WAKE_ALARM;
			/**
			 * Converts a text representation of a capability, such as "cap_chown".
			 * @return whether or not the specified capability can be represented by the library.
			 */
			[CCode(cname = "0 == cap_from_name")]
			public static bool from_name(string name, out Value @value);
			/**
			 * Can be used to lower the specified bounding set capability.
			 *
			 * To complete successfully, the prevailing effective capability set must have a raised {@link Value.SETPCAP}.
			 */
			[CCode(cname = "0 == cap_drop_bound")]
			public bool drop_bound();
			/**
			 * Gets the current value of this bounding set capability flag in effect for the current process.
			 *
			 * This operation is unprivileged.
			 * @return -1 if the requested capability is unknown, otherwise the return value reflects the current state of that capability in the prevailing bounding set.
			 * @see is_supported
			 */
			[CCode(cname = "cap_get_bound")]
			public int get_bound();
			[CCode(cname = "CAP_IS_SUPPORTED")]
			public bool is_supported();
			[CCode(cname = "cap_to_name")]
			public string to_string();
		}
		/**
		 * The total length (in bytes) that the capability state in working storage would require when converted by {@link copy}.
		 *
		 * This is used primarily to determine the amount of buffer space that must be provided to the {@link copy} function in order to hold the capability data record created.
		 */
		public ssize_t size {
			[CCode(cname = "cap_size")]
			get;
		}
		/**
		 * Copies a capability state from a capability data record in user-managed space to a new capability state in working storage, allocating any memory necessary, and returning a pointer to the newly created capability state.
		 *
		 * The function initializes the capability state and then copies the capability state from the record passed into the capability state, converting, if necessary, the data from a contiguous, persistent format to an undefined, internal format. Once copied into internal format, the object can be manipulated by the capability state manipulation functions. Note that the record must have been obtained from a previous, successful call to {@link copy} for this function to work successfully.
		 */
		[CCode(cname = "cap_copy_int")]
		public static Capability? create([CCode(array_length = false)] uint8[] buffer);
		/**
		 * Allocates and initializes a capability state in working storage. It then sets the contents of this newly created capability state to the state represented by a human-readable character string. It returns a pointer to the newly created capability state.
		 *
		 * @return an null if it cannot parse the contents of the string or does not recognize any '''capability_name''' or flag character as valid. Also returns null if any flag is both set and cleared within a single clause.
		 */
		[CCode(cname = "cap_from_text")]
		public static Capability? from_text(string text);
		/**
		 * Allocate a capability state in working storage and set it to represent the capability state of the path.
		 *
		 * The effects of reading the capability state from any file other than a regular file is undefined.
		 */
		[CCode(cname = "cap_get_fd")]
		public static Capability? get_fd(int fd);
		/**
		 * Allocate a capability state in working storage and set it to represent the capability state of the file open on descriptor.
		 *
		 * The effects of reading the capability state from any file other than a regular file is undefined.
		 */
		[CCode(cname = "cap_get_file")]
		public static Capability? get_file(string filename);
		/**
		 * Returns cap_d with the process capabilities of the process indicated by pid.
		 */
		[CCode(cname = "cap_get_pid")]
		public static Capability? get_pid(Posix.pid_t pid);
		/**
		 * Allocates a capability state in working storage, sets its state to that of the calling process.
		 */
		[CCode(cname = "cap_get_proc")]
		public static Capability? get_proc();
		/**
		 * Reset the values for all capability flags for all capabilities for the open file descriptor.
		 *
		 * @see set_file
		 */
		[CCode(cname = "0 == cap_set_fd")]
		public static bool reset_fd(int fd, Capability? cap = null);
		/**
		 * Reset the values for all capability flags for all capabilities for a file.
		 *
		 * @see set_file
		 */
		[CCode(cname = "0 == cap_set_file")]
		public static bool reset_file(string filename, Capability? cap = null);
		[CCode(cname = "cap_init")]
		public Capability();
		/**
		 * Initializes the capability state so that all capability flags are cleared.
		 */
		[CCode(cname = "0 == cap_clear")]
		public bool clear();
		/**
		 * Clears all of the capabilities of the specified capability flag.
		 */
		[CCode(cname = "cap_clear_flag")]
		public bool clear_flag(Flag flag);
		/**
		 * Compares two full capability sets and, in the spirit of memcmp(), returns zero if the two capability sets are identical.
		 *
		 * A positive return value, status, indicates there is a difference between them. The returned value carries further information about which of three sets differ.
		 * @see Flag.differs
		 */
		[CCode(cname = "cap_compare")]
		public int compare(Capability other);
		/**
		 * Copies a capability state in working storage from system managed space to user-managed space.
		 *
		 * The function will do any conversions necessary to convert the capability state from the undefined internal format to an exportable, contiguous, persistent data record. It is the responsibility of the user to allocate a buffer large enough to hold the copied data.
		 * @return the length of the resulting data record.
		 * @see size
		 */
		[CCode(cname = "cap_copy_ext", instance_pos = 1.1)]
		public ssize_t copy([CCode(array_length_pos = 1.2)] uint8[] buffer);
		[CCode(cname = "cap_dup")]
		public Capability dup();
		/**
		 * Obtains the current value of the capability flag.
		 */
		[CCode(cname = "0 == cap_get_flag")]
		public bool get_flag(Value val, Flag flag, out bool result);
		/**
		 * Set the values for all capability flags for all capabilities for the open file descriptor.
		 *
		 * @see set_file
		 */
		[CCode(cname = "0 == cap_set_fd", instance_pos = -1)]
		public bool set_fd(int fd);
		/**
		 * Set the values for all capability flags for all capabilities for a file.
		 *
		 * The new capability state of the file is completely determined by the contents of this object.
		 * For these functions to succeed, the calling process must have the effective capability, {@link Value.SETFCAP}, enabled and either the effective user ID of the process must match the file owner or the calling process must have the {@link Value.FOWNER} flag in its effective capability set. The effects of writing the capability state to any file type other than a regular file are undefined.
		 */
		[CCode(cname = "0 == cap_set_file", instance_pos = -1)]
		public bool set_file(string filename);
		/**
		 * Sets the flag of each capability in the array caps in the capability state.
		 */
		[CCode(cname = "0 == cap_set_flag")]
		public bool set_flag(Flag flag, [CCode(array_length_pos = 2.1)] Value[] values, bool val);
		/**
		 * Sets the values for all capability flags for all capabilities to this capability state.
		 *
		 * The new capability state of the process will be completely determined by the contents of this object upon successful return from this function. If any flag is set for any capability not currently permitted for the calling process, the function will fail, and the capability state of the process will remain unchanged.
		 */
		[CCode(cname = "0 == cap_set_proc")]
		public bool set_proc();
		[CCode(cname = "cap_to_text", array_length_type = "ssize_t")]
		public uint8[] to_text();
	}
}
