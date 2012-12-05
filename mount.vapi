[CCode(cheader_filename = "libmount.h")]
namespace Mount {
	/**
	 * The cache is a very simple API for work with tags (LABEL, UUID, ...) and paths. The cache uses libblkid as a backend for TAGs resolution.
	 *
	 * All returned paths are always canonicalized.
	 *
	 * Stores canonicalized paths and evaluated tags
	 */
	[CCode(cname = "struct libmnt_cache", free_function = "mnt_free_cache", has_type_id = false)]
	[Comapt]
	public class Cache {
		[CCode(cname = "mnt_new_cache")]
		public Cache();
		/**
		 * Retreives a value for a tag.
		 * @param devname device name
		 * @param token tag name ("LABEL" or "UUID")
		 * @return LABEL or UUID for the devname or null in case of error.
		 */
		[CCode(cname = "mnt_cache_find_tag_value")]
		public unowned string? find_tag_value(string devname, string token);
		/**
		 * Get the file system type.
		 * @param devname device name
		 * @param ambi true if probing result is ambivalent (optional argument)
		 * @return filesystem type or null in case of error.
		 */
		[CCode(cname = "mnt_get_fstype", instance_pos = -1)]
		public unowned string? get_fstype(string devname, out bool ambi);
		/**
		 * Look up cache to check it tag+value are associated with devname.
		 * @param devname path to the device
		 * @param token tag name (e.g "LABEL")
		 * @param value tag value
		 */
		[CCode(cname = "mnt_cache_device_has_tag")]
		public int has_tag(string devname, string token, string @value);
		/**
		 * Reads devname LABEL and UUID to the cache.
		 * @param devname path device
		 * @return 0 if at least one tag was added, 1 if no tag was added or negative number in case of error.
		 */
		[CCode(cname = "mnt_cache_read_tags")]
		public int read_tags(string devname);
	}
	[CCode(cname = "struct libmnt_context", free_function = "mnt_free_context", has_type_id = false)]
	[Compact]
	public class Context {
		/**
		 * The mount context's cache.
		 *
		 * The mount context maintains a private cache by default. This function allows to overwrite the private cache with an external instance.
		 *
		 * If the cache is null then the current private cache instance is reseted.
		 */
		public unowned Cache? cache {
			[CCode(cname = "mnt_context_get_cache")]
			get;
			[CCode(cname = "mnt_context_set_cache")]
			set;
		}
		/**
		 * The error callback is used for all tab files (e.g. mtab, fstab) parsed within the context.
		 */
		public TablesError error_handler {
			[CCode(cname = "mnt_context_set_tables_errcb")]
			set;
		}
		/**
		 * Enable/disable fake mounting (see mount(8) man page, option -f).
		 */
		public bool fake {
			[CCode(cname = "mnt_context_enable_fake")]
			set;
			[CCode(cname = "mnt_context_is_fake")]
			get;
		}
		/**
		 * Enable/disable force umounting (see umount(8) man page, option -f).
		 */
		public bool force {
			[CCode(cname = "mnt_context_enable_force")]
			set;
			[CCode(cname = "mnt_context_is_force")]
			get;
		}
		/**
		 * Enable/disable fork(2) call in {@link next_mount} (see mount(8) man page, option -F).
		 */
		public bool fork {
			[CCode(cname = "mnt_context_enable_fork")]
			set;
			[CCode(cname = "mnt_context_is_fork")]
			get;
		}
		/**
		 * The basic description of mountpoint, fs type and so on.
		 *
		 * Note that the FS is modified by certain properties and methods in the context.
		 */
		public FileSystem? fs {
			[CCode(cname = "mnt_context_get_fs")]
			owned get;
			[CCode(cname = "mnt_context_set_fs")]
			set;
		}
		/**
		 * The file system type.
		 *
		 * Note that the fstype has to be the real FS type. For comma-separated list of filesystems or for '''nofs''' notation use {@link set_fstype_pattern}.
		 */
		public string? fstype {
			[CCode(cname = "mnt_context_get_fstype")]
			get;
			[CCode(cname = "mnt_context_set_fstype")]
			set;
		}
		/**
		 * Whether '''mount.type''' helper has been executed.
		 */
		public bool helper_executed {
			[CCode(cname = "mnt_context_helper_executed")]
			get;
		}
		/**
		 * mount.type helper exit status.
		 *
		 * Reliable only if {@link helper_executed} is true.
		 */
		public int helper_status {
			[CCode(cname = "mnt_context_get_helper_status")]
			get;
		}
		public bool is_child {
			[CCode(cname = "mnt_context_is_child")]
			get;
		}
		public bool is_parent {
			[CCode(cname = "mnt_context_is_parent")]
			get;
		}
		/**
		 * False for unrestricted mount (user is root), or true for non-root mounts
		 */
		public bool is_restricted {
			[CCode(cname = "mnt_context_is_restricted")]
			get;
		}
		/**
		 * Enable/disable lazy umount (see umount(8) man page, option -l).
		 */
		public bool lazy {
			[CCode(cname = "mnt_context_enable_lazy")]
			set;
			[CCode(cname = "mnt_context_is_lazy")]
			get;
		}
		/**
		 * Enable/disable loop delete (destroy) after umount (see umount(8), option -d)
		 */
		public bool loop_delete {
			[CCode(cname = "mnt_context_enable_loopdel")]
			set;
		}
		/**
		 * Enable/disable paths canonicalization and tags evaluation.
		 *
		 * The libmount context canonicalies paths when search in fstab and when prepare source and target paths for mount(2) syscall.
		 *
		 * This fuction has effect to the private fstab instance only. If you want to use an external fstab then you need manage your private cache.
		 * @see set_fstab
		 * @see Table.cache
		 */
		public bool no_canonicalize {
			[CCode(cname = "mnt_context_disable_canonicalize")]
			set;
		}
		/**
		 * Enable/disable /sbin/[u]mount.* helpers (see mount(8) man page, option -i).
		 */
		public bool no_helpers {
			[CCode(cname = "mnt_context_disable_helpers")]
			set;
		}
		/**
		 * Disable/enable mtab update (see mount(8) man page, option -n).
		 */
		public bool no_mtab {
			[CCode(cname = "mnt_context_disable_mtab")]
			set;
			[CCode(cname = "mnt_context_is_nomtab")]
			get;
		}
		public OptsMode opts_mode {
			[CCode(cname = "mnt_context_get_optsmode")]
			get;
			[CCode(cname = "mnt_context_set_optsmode")]
			set;
		}
		/**
		 * Enable/disable read-only remount on failed umount(2) (see umount(8) man page, option -r).
		 */
		public bool read_only_umount {
			[CCode(cname = "mnt_context_enable_rdonly_umount")]
			set;
			[CCode(cname = "mnt_context_is_rdonly_umount")]
			get;
		}
		/**
		 * Set/unset sloppy mounting (see mount(8) man page, option -s).
		 */
		public bool sloppy {
			[CCode(cname = "mnt_context_enable_sloppy")]
			set;
			[CCode(cname = "mnt_context_is_sloppy")]
			get;
		}
		/**
		 * Mount source (device, directory, UUID, label, ...)
		 */
		public string? source {
			[CCode(cname = "mnt_context_get_source")]
			get;
			[CCode(cname = "mnt_context_set_source")]
			set;
		}
		/**
		 * If mount.type or mount(2) syscall has been succesfully called.
		 *
		 * The real exit code of the '''mount.type''' helper has to be tested by {@link helper_status}. This only inform that exec() has been sucessful.
		 */
		public int status {
			[CCode(cname = "mnt_context_get_status")]
			get;
		}
		/**
		 * Has the mount(2) syscall has been called?
		 */
		public bool syscall_called {
			[CCode(cname = "mnt_context_syscall_called")]
			get;
		}
		/**
		 * The result from this function is reliable only if {@link syscall_called}.
		 */
		public int syscall_errno {
			[CCode(cname = "mnt_context_get_syscall_errno")]
			get;
		}
		public string target {
			[CCode(cname = "mnt_context_get_target")]
			get;
			[CCode(cname = "mnt_context_set_target")]
			set;
		}
		/**
		 * Enable/disable verbose output
		 */
		public bool verbose {
			[CCode(cname = "mnt_context_enable_verbose")]
			set;
			[CCode(cname = "mnt_context_is_verbose")]
			get;
		}
		/**
		 * Callback to get password
		 */
		[CCode(has_target = false)]
		public delegate string GetHandler(Context context);
		/**
		 * Callback to release (delallocate) password
		 */
		[CCode(has_target = false)]
		public delegate void ReleaseHandler(Context context, owned string password);
		[CCode(cname = "mnt_new_context")]
		public Context();
		/**
		 * Converts mount options string to flags and bitewise-OR the result with already defined flags.
		 * @param opts comma delimited mount options
		 */
		[CCode(cname = "mnt_context_append_options")]
		public int append_options(string opts);
		[CCode(cname = "mnt_context_apply_fstab")]
		public int apply_fstab();
		/**
		 * Call mount(2) or mount.type helper. Unnecessary for {@link mount}.
		 *
		 * Note that this function could be called only once. If you want to mount another source or target than you have to call {@link reset}.
		 *
		 * If you want to call mount(2) for the same source and target with a diffrent mount flags or fstype then you call {@link reset_status} and then try again {@link do_mount}.
		 *
		 * WARNING: non-zero return code does not mean that mount(2) syscall or umount.type helper wasn't sucessfully called.
		 * Check {@link status} after error!
		 */
		[CCode(cname = "mnt_context_do_mount")]
		public int do_mount();
		/**
		 * Umount filesystem by umount(2) or fork()+exec(/sbin/umount.type). Unnecessary for {@link umount}.
		 *
		 * WARNING: non-zero return code does not mean that umount(2) syscall or umount.type helper wasn't sucessfully called. Check {@link status} after error!
		 * @see no_helpers
		 */
		[CCode(cname = "mnt_context_do_umount")]
		public int do_umount();
		/**
		 * Mtab update, etc. Unnecessary for {@link mount}, but should be called after {@link do_mount}.
		 * @see set_syscall_status
		 */
		[CCode(cname = "mnt_context_finalize_mount")]
		public int finalize_mount();
		/**
		 * Mtab update, etc. Unnecessary for {@link umount}, but should be called after {@link do_umount}.
		 * @see set_syscall_status
		 */
		[CCode(cname = "mnt_context_finalize_umount")]
		public int finalize_umount();
		[CCode(cname = "mnt_context_strerror")]
		public int get_error([CCode(array_length_type = "size_t")] uint8[] buf);
		[CCode(cname = "mnt_context_get_mflags")]
		public int get_flags(out Flag flags);
		[CCode(cname = "mnt_context_get_fstab")]
		public int get_fstab(out unowned Table? tb);
		/**
		 * Get a lock on the mtab.
		 *
		 * The libmount applications don't have to care about mtab locking, but with a small exception: the application has to be able to remove the lock file when interrupted by signal or signals have to be ignored when the lock is locked.
		 *
		 * The default behavior is to ignore all signals (except SIGALRM and SIGTRAP for mtab udate) when the lock is locked. If this behavior is unacceptable then use this method and {@link Lock.block_signals} followed by an {@link Lock.unlock_file}.
		 */
		[CCode(cname = "mnt_context_get_lock")]
		public Lock? get_lock();
		[CCode(cname = "mnt_context_get_mtab")]
		public int get_mtab(out unowned Table? tb);
		/**
		 * This method allocates a new table and parses the file.
		 *
		 * The parser error callback and cache for tags and paths is set according to the context setting.
		 *
		 * It's strongly recommended use {@link get_mtab} and {@link get_fstab} for mtab and fstab files. This function does not care about '''LIBMOUNT_*''' environment variables and does not merge userspace options.
		 * @see Table.parse_file
		 */
		[CCode(cname = "mnt_context_get_table")]
		public int get_table(string filename, out unowned Table? tb);
		/**
		 * Converts mount options string to flags and bitewise-OR the result with already defined flags.
		 */
		[CCode(cname = "mnt_context_get_user_mflags")]
		public int get_user_flags(out UserFlag flags);
		/**
		 * This function informs libmount that used from [u]mount.type helper.
		 *
		 * The function also calls disables helpers to avoid recursive mount.type helpers calling. It you really want to call another mount.type helper from your helper than you have to explicitly enable them.
		 */
		[CCode(cname = "mnt_context_init_helper")]
		public int init_helper(Action action, int flags = 0);
		[CCode(cname = "mnt_context_is_fs_mounted")]
		public int is_fs_mounted(FileSystem fs, out bool mounted);
		/**
		 * High-level, mounts filesystem by mount(2) or fork()+exec(/sbin/mount.type).
		 *
		 * This is similar to: {@link prepare_mount}; {@link do_mount}; {@link finalize_mount}
		 *
		 * Note that this function could be called only once. If you want to mount with different setting than you have to call {@link reset}. It's NOT enough to call {@link reset_status} if you want call this function more than once, whole context has to be reseted.
		 *
		 * WARNING: non-zero return code does not mean that mount(2) syscall or mount.type helper wasn't sucessfully called. Check {@link status} after error!
		 * @see no_helpers
		 */
		[CCode(cname = "mnt_context_mount")]
		public int mount();
		/**
		 * This function tries to mount the next filesystem from fstab (as returned by {@link get_fstab}).
		 *
		 * You can filter out filesystems by: {@link set_options_pattern} to simulate mount -a -O pattern {@link set_fstype_pattern} to simulate mount -a -t pattern
		 *
		 * If the filesystem is already mounted or does not match defined criteria, then the {@link next_mount} method returns zero, but the ignored is true. Note that the root filesystem and filesystems with "noauto" option are always ignored.
		 *
		 * If mount(2) syscall or mount.type helper failed, then this method returns zero, but the mntrc is true. Use also {@link status} to check if the filesystem was successfully mounted.
		 * @return 0 on success, <0 in case of error (!= mount(2) errors) 1 at the end of the list.
		 */
		[CCode(cname = "mnt_context_next_mount")]
		public int next_mount(Iter itr, out unowned FileSystem? fs, out bool mntrc, out bool ignored);
		/**
		 * This function tries to umount the next filesystem from mtab (as returned by {@link get_mtab}).
		 *
		 * You can filter out filesystems by: {@link set_options_pattern} to simulate umount -a -O pattern {@link set_fstype_pattern} to simulate umount -a -t pattern
		 *
		 * If the filesystem is not mounted or does not match defined criteria, then this method returns zero, but the ignored is true. Note that the root filesystem is always ignored.
		 *
		 * If umount(2) syscall or umount.type helper failed, then this method returns zero, but the mntrc is true. Use also {@link status} to check if the filesystem was successfully umounted.
		 * @return 0 on success, <0 in case of error (!= umount(2) errors) 1 at the end of the list.
		 */
		[CCode(cname = "mnt_context_next_umount")]
		public int next_umount(Iter itr, out unowned FileSystem? fs, out bool mntrc, out bool ignored);
		/**
		 * Prepare context for mounting, unnecessary for {@link mount}.
		 */
		[CCode(cname = "mnt_context_prepare_mount")]
		public int prepare_mount();
		/**
		 * Prepare context for umounting, unnecessary for {@link umount}.
		 */
		[CCode(cname = "mnt_context_prepare_umount")]
		public int prepare_umount();
		/**
		 * Resets all information in the context that are directly related to the latest mount (spec, source, target, mount options, ....)
		 *
		 * The match patterns, cached fstab, cached canonicalized paths and tags and [e]uid are not reseted.
		 * @see cache
		 * @see set_fstab
		 * @see set_options_pattern
		 */
		[CCode(cname = "mnt_reset_context")]
		public int reset();
		/**
		 * Resets mount(2) and mount.type statuses, so {@link do_mount} or {@link do_umount} could be again called with the same settings.
		 *
		 * BE CAREFUL -- after this soft reset the libmount will NOT parse mount options, evaluate permissions or apply stuff from fstab.
		 */
		[CCode(cname = "mnt_context_reset_status")]
		public int reset_status();
		[CCode(cname = "mnt_context_set_mflags")]
		public int set_flags(Flag flags);
		/**
		 * The mount context reads /etc/fstab to the the private table by default. This function allows to overwrite the private fstab with an external instance.
		 *
		 * The fstab is used read-only and is not modified, it should be possible to share the fstab between more mount contexts.
		 * @param tb is the table; if null, then the current private fstab instance is reseted.
		 */
		[CCode(cname = "mnt_context_set_fstab")]
		public int set_fstab(Table? tb);
		/**
		 * See mount(8), option -t.
		 */
		[CCode(cname = "mnt_context_set_fstype_pattern")]
		public int set_fstype_pattern(string? pattern);
		/**
		 * This function applies [u]mount.type command line option (for example parsed by getopt or getopt_long).
		 *
		 * All unknown options are ignored and an error is returned.
		 */
		[CCode(cname = "mnt_context_helper_setopt")]
		public int set_helper_opt(int c, string arg);
		/**
		 * The mount context generates mountdata from mount options by default. This function allows to overwrite this behavior, and data will be used instead of mount options.
		 */
		[CCode(cname = "mnt_context_set_mountdata")]
		public int set_mount_data(void* data);
		/**
		 * Set user options.
		 * @param optstr comma delimited mount options
		 */
		[CCode(cname = "mnt_context_set_options")]
		public int set_options(string optstr);
		/**
		 * See mount(8), option -O.
		 */
		[CCode(cname = "mnt_context_set_options_pattern")]
		public int set_options_pattern(string? pattern);
		/**
		 * Sets callbacks for encryption password (e.g encrypted loopdev)
		 */
		[CCode(cname = "mnt_context_set_passwd_cb")]
		public int set_passwd_handler(GetHandler gh, ReleaseHandler rh);
		/**
		 * Set the syscall status if [u]mount(2) syscall is NOT called by libmount code.
		 *
		 * The status should be 0 on success, or negative number on error (-errno).
		 */
		[CCode(cname = "mnt_context_set_syscall_status")]
		public int set_syscall_status(int status);
		/**
		 * Sets userspace mount flags.
		 */
		[CCode(cname = "mnt_context_set_user_mflags")]
		public int set_user_flags(UserFlag flags);
		/**
		 * High-level, umounts filesystem by umount(2) or fork()+exec(/sbin/umount.type).
		 *
		 * This is similar to: {@link prepare_umount}; {@link do_umount}; {@link finalize_umount}
		 *
		 * WARNING: non-zero return code does not mean that umount(2) syscall or umount.type helper wasn't sucessfully called. Check {@link status} after error!
		 * @see no_helpers
		 * @return 0 on success; >0 in case of umount(2) error (returns syscall errno), <0 in case of other errors.
		 */
		[CCode(cname = "mnt_context_umount")]
		public int umount();
		[CCode(cname = "mnt_context_wait_for_children")]
		public int wait_for_children(out int children, out int errs);
	}
	/**
	 * Stores mountinfo state
	 */
	[CCode(cname = "struct libmnt_tabdiff", free_function = "mnt_free_tabdiff", has_type_id = false)]
	[Compact]
	public class Diff {
		[CCode(cname = "mnt_new_tabdiff")]
		public Diff();
		/**
		 * Compares two tables, the result is stored.
		 * @return number of changes, negative number in case of error.
		 */
		[CCode(cname = "mnt_diff_tables")]
		public int diff(Table old_tab, Table new_tab);
		[CCode(cname = "mnt_tabdiff_next_change")]
		public int next(Iter itr, out unowned FileSystem? old_fs, out FileSystem? new_fs, out Operation oper);
	}
	[CCode(cname = "struct libmnt_fs", free_function = "mnt_free_fs", has_type_id = false)]
	[Compact]
	public class FileSystem {
		/**
		 * The attributes are mount(2) and mount(8) independent options, these options are not send to kernel and are not interpreted by libmount. The attributes are stored in /run/mount/utab only.
		 *
		 * The attributes are managed by libmount in userspace only. It's possible that information stored in userspace will not be available for libmount after CLONE_FS unshare. Be carefull, and don't use attributes if possible.
		 */
		public string? attributes {
			[CCode(cname = "mnt_fs_get_attributes")]
			get;
			[CCode(cname = "mnt_fs_set_attributes")]
			set;
		}
		/**
		 * Full path that was used for mount(2) on {@link Flag.BIND}
		 */
		public string? bind_src {
			[CCode(cname = "mnt_fs_get_bindsrc")]
			get;
			[CCode(cname = "mnt_fs_set_bindsrc")]
			set;
		}
		public Posix.dev_t dev_no {
			[CCode(cname = "mnt_fs_get_devno")]
			get;
		}
		/**
		 * Dump frequency in days.
		 */
		public int freq {
			[CCode(cname = "mnt_fs_get_freq")]
			get;
			[CCode(cname = "mnt_fs_set_freq")]
			set;
		}
		public string? fs_options {
			[CCode(cname = "mnt_fs_get_fs_options")]
			get;
		}
		public string fstype {
			[CCode(cname = "mnt_fs_get_fstype")]
			get;
			[CCode(cname = "mnt_fs_set_fstype")]
			set;
		}
		/**
		 * Mount ID (unique identifier of the mount) or negative number in case of error.
		 */
		public int id {
			[CCode(cname = "mnt_fs_get_id")]
			get;
		}
		/**
		 * The filesystem description is read from kernel e.g. /proc/mounts.
		 */
		public bool is_kernel {
			[CCode(cname = "mnt_fs_is_kernel")]
			get;
		}
		public bool is_network_fs {
			[CCode(cname = "mnt_fs_is_netfs")]
			get;
		}
		/**
		 * A pseudo fs type (proc, cgroups)
		 */
		public bool is_pseudo_fs {
			[CCode(cname = "mnt_fs_is_pseudofs")]
			get;
		}
		public bool is_swap_area {
			[CCode(cname = "mnt_fs_is_swaparea")]
			get;
		}
		public string? options {
			[CCode(cname = "mnt_fs_get_options")]
			get;
			[CCode(cname = "mnt_fs_set_options")]
			set;
		}
		public int parent_id {
			[CCode(cname = "mnt_fs_get_parent_id")]
			get;
		}
		public int passno {
			[CCode(cname = "mnt_fs_get_passno")]
			get;
			[CCode(cname = "mnt_fs_set_passno")]
			set;
		}
		/**
		 * Root of the mount within the filesystem
		 */
		public string? root {
			[CCode(cname = "mnt_fs_get_root")]
			get;
			[CCode(cname = "mnt_fs_set_root")]
			set;
		}
		/**
		 * Mount source.
		 *
		 * Note that the source could be unparsed TAG (LABEL/UUID).
		 * @see srcpath
		 * @see get_tag
		 */
		public string? source {
			[CCode(cname = "mnt_fs_get_source")]
			get;
			[CCode(cname = "mnt_fs_set_source")]
			set;
		}
		/**
		 * The mount "source path" is: a directory for 'bind' mounts (in fstab or mtab only) or a device name for standard mounts
		 * @see get_tag
		 * @see source
		 */
		public string? srcpath {
			[CCode(cname = "mnt_fs_get_srcpath")]
			get;
		}
		public string? target {
			[CCode(cname = "mnt_fs_get_target")]
			get;
			[CCode(cname = "mnt_fs_set_target")]
			set;
		}
		/**
		 * The "userdata" are library independent data.
		 */
		public void* user_data {
			[CCode(cname = "mnt_fs_get_userdata")]
			get;
			[CCode(cname = "mnt_fs_set_userdata")]
			set;
		}
		public string? user_options {
			[CCode(cname = "mnt_fs_get_user_options")]
			get;
		}
		/**
		 * FS-independent (VFS) mount option string.
		 */
		public string? vfs_options {
			[CCode(cname = "mnt_fs_get_vfs_options")]
			get;
		}
		[CCode(cname = "mnt_new_fs")]
		public FileSystem();
		/**
		 * Appends mount attributes.
		 * @see attributes
		 */
		[CCode(cname = "mnt_fs_append_attributes")]
		public int append_attributes(string optstr);
		/**
		 * Parses (splits) optstr and appends results to VFS, FS and userspace lists of options.
		 */
		[CCode(cname = "mnt_fs_append_options")]
		public int append_options(string optstr);
		/**
		 * Copy a file system.
		 *
		 * This function does not copy userdata. A new copy is not linked with any existing table.
		 */
		[CCode(cname = "mnt_copy_fs", instance_pos = -1)]
		public FileSystem dup(owned FileSystem? dest = null);
		[CCode(cname = "mnt_fs_get_attribute")]
		public int get_attribute(string name, [CCode(array_length_type = "size_t")] out unowned uint8[]? @value);
		[CCode(cname = "mnt_fs_get_option")]
		public int get_option(string name, [CCode(array_length_type = "size_t")] out unowned uint8[]? @value);
		/**
		 * Merges all mount options (VFS, FS and userspace) to the one options string and returns the result.
		 *
		 * This function does not modify fs.
		 */
		[CCode(cname = "mnt_fs_strdup_options")]
		public string? get_options();
		/**
		 * "TAG" is NAME=VALUE (e.g. LABEL=foo)
		 *
		 * The TAG is the first column in the fstab file. The TAG or "srcpath" has to be always set for all entries.
		 * @see source
		 */
		[CCode(cname = "mnt_fs_get_tag")]
		public int get_tag(out unowned string? name, out unowned string? @value);
		/**
		 * Checks if this file system matches an fstype.
		 * @param types filesystem name or comma delimited list of filesystems
		 */
		[CCode(cname = "mnt_fs_match_fstype")]
		public bool match_fstype(string types);
		/**
		 * Checks if this file system matches some options.
		 * @param optiosn comma delimited list of options (and nooptions)
		 */
		[CCode(cname = "mnt_fs_match_options")]
		public bool match_options(string options);
		/**
		 * Possible are four attempts: 1) compare source with fs->source 2) compare realpath(source) with fs->source 3) compare realpath(source) with realpath(fs->source) 4) compare realpath(source) with evaluated tag from fs->source
		 *
		 * The 2nd, 3rd and 4th attempts are not performed when cache is null. The 2nd and 3rd attempts are not performed if fs->source is tag.
		 */
		[CCode(cname = "mnt_fs_match_source")]
		public bool match_source(string source, Cache? cache);
		/**
		 * Prepends mount attributes.
		 * @see attributes
		 */
		[CCode(cname = "mnt_fs_prepend_attributes")]
		public int prepend_attributes(string optstr);
		/**
		 * Possible are three attempts: 1) compare target with fs->target 2) realpath(target) with fs->target 3) realpath(target) with realpath(fs->target) if fs is not from /proc/self/mountinfo.
		 *
		 * The 2nd and 3rd attempts are not performed when cache is null.
		 */
		[CCode(cname = "mnt_fs_match_target")]
		public bool match_target(string target, Cache? cache);
		/**
		 * Parses (splits) optstr and prepands results to VFS, FS and userspace lists of options.
		 */
		[CCode(cname = "mnt_fs_prepend_options")]
		public int prepend_options(string optstr);
		[CCode(cname = "mnt_fs_print_debug")]
		public int print_debug(
#if POSIX
		Posix.FILE
#else
		GLib.FileStream
#endif
		file);
		/**
		 * Resets (zeroize) fs.
		 */
		[CCode(cname = "mnt_reset_fs")]
		public void reset();
	}
	/**
	 * The iterator keeps direction and last position for access to the internal library tables/lists.
	 */
	[CCode(cname = "struct libmnt_iter", free_function = "mnt_free_iter", has_type_id = false)]
	[Compact]
	public class Iter {
		public Direction direction {
			[CCode(cname = "mnt_iter_get_direction")]
			get;
		}
		[CCode(cname = "mnt_new_iter")]
		public Iter(Direction direction);
		[CCode(cname = "mnt_reset_iter")]
		public void reset(Direction direction);
	}
	/**
	 * Stores information about locked file (e.g. /etc/mtab)
	 */
	[CCode(cname = "struct libmnt_lock", free_function = "mnt_free_lock", has_type_id = false)]
	[Compact]
	public class Lock {
		/**
		 * Allocate a new lock.
		 * @param datafile the file that should be covered by the lock
		 * @param id unique linkfile identifier or 0 (default is getpid())
		 */
		[CCode(cname = "mnt_new_lock")]
		public static Lock? create(string datafile, Posix.pid_t id = 0);
		/**
		 * Block/unblock signals when the lock is locked, the signals are not blocked by default.
		 */
		[CCode(cname = "mnt_lock_block_signals")]
		public int block_signals(bool enable);
		/**
		 * Creates lock file (e.g. /etc/mtab~). Note that this function may use alarm().
		 *
		 * Your application has to always call {@link unlock_file} before exit.
		 *
		 * Traditional mtab locking scheme:
		 *
		 * 1. create linkfile (e.g. /etc/mtab~.$PID)
		 * 2. link linkfile --> lockfile (e.g. /etc/mtab~.$PID --> /etc/mtab~)
		 * 3. a) link() success: setups F_SETLK lock (see fcnlt(2)) b) link() failed: wait (max 30s) on F_SETLKW lock, goto 2.
		 */
		[CCode(cname = "mnt_lock_file")]
		public int lock_file();
		/**
		 * Unlocks the file.
		 *
		 * The function could be called independently on the lock status (for example from exit(3)).
		 */
		[CCode(cname = "mnt_unlock_file")]
		public void unlock_file();

	}
	/**
	 * A container for {@link FileSystem} entries that usually represents a fstab, mtab or mountinfo file from your system.
	 */
	[CCode(cname = "struct libmnt_table", free_function = "mnt_free_table", has_type_id = false)]
	[Compact]
	public class Table {
		/**
		 * Setups a cache for canonicalized paths and evaluated tags (LABEL/UUID).
		 *
		 * The cache is recommended for find_ functions.
		 *
		 * The cache could be shared between more tabs. Be careful when you share the same cache between more threads -- currently the cache does not provide any locking method.
		 */
		public Cache? cache {
			[CCode(cname = "mnt_table_get_cache")]
			get;
			[CCode(cname = "mnt_table_set_cache")]
			set;
		}
		public int count {
			[CCode(cname = "mnt_table_get_nents")]
			get;
		}
		/**
		 * The error callback function is called by table parser in case of syntax error.
		 *
		 * The callback function could be used for errors evaluation, libmount will continue/stop parsing according to callback return codes.
		 */
		public TablesError error_handler {
			[CCode(cname = "mnt_table_set_parser_errcb")]
			set;
		}
		/**
		 * Create a table from a directory.
		 * @param dirname directory with *.fstab files
		 */
		[CCode(cname = "mnt_new_table_from_dir")]
		public static Table? from_dir(string dirname);
		/**
		 * Same as {@link Table.Table} + {@link parse_file}.
		 *
		 * Use this function for private files only. This function does not allow to use error callback, so you cannot provide any feedback to end-users about broken records in files (e.g. fstab).
		 * @param filename /etc/{m,fs}tab or /proc/self/mountinfo path
		 */
		[CCode(cname = "mnt_new_table_from_file")]
		public static Table? from_file(string filename);
		public delegate bool Matcher(FileSystem fs);
		[CCode(cname = "mnt_new_table")]
		public Table();
		/**
		 * Adds a new entry to tab.
		 */
		[CCode(cname = "mnt_table_add_fs")]
		public int add(owned FileSystem fs);
		/**
		 * Deallocates all entries (filesystems) from the table
		 */
		[CCode(cname = "mnt_reset_table")]
		public int clear();
		/**
		 * Search the table.
		 */
		[CCode(cname = "mnt_table_find_next_fs")]
		public int find_next(Iter itr, Matcher match, out unowned FileSystem? fs);
		[CCode(cname = "mnt_table_find_pair")]
		public unowned FileSystem? find_pair(string source, string target, Direction direction);
		/**
		 * High-level API for {@link find_srcpath} and {@link find_tag}.
		 *
		 * You needn't to care about source format (device, LABEL, UUID, ...). This function parses source and calls {@link find_tag} or {@link find_srcpath}.
		 */
		[CCode(cname = "mnt_table_find_source")]
		public unowned FileSystem? find_source(string source, Direction direction);
		/**
		 * Try to lookup an entry in given tab, possible are four iterations, first with path, second with realpath(path), third with tags (LABEL, UUID, ..) from path and fourth with realpath(path) against realpath(entry->srcpath).
		 *
		 * The 2nd, 3rd and 4th iterations are not performed when tb cache is not set (see {@link cache}).
		 *
		 * Note that null is a valid source path; it will be replaced with "none". The "none" is used in /proc/{mounts,self/mountinfo} for pseudo filesystems.
		 */
		[CCode(cname = "mnt_table_find_srcpath")]
		public unowned FileSystem? find_srcpath(string? path, Direction direction);
		/**
		 * Try to lookup an entry in given tab.
		 *
		 * First attempt is lookup by tag and val, for the second attempt the tag is evaluated (converted to the device name) and {@link find_srcpath} is preformed. The second attempt is not performed when tb cache is not set (see {@link cache}).
		 * @param tag tag name (e.g "LABEL", "UUID", ...)
		 */
		[CCode(cname = "mnt_table_find_tag")]
		public unowned FileSystem? find_tag(string tag, string val, Direction direction);
		/**
		 * Try to lookup an entry in given tab.
		 *
		 * Possible are three iterations, first with path, second with realpath(path) and third with realpath(path) against realpath(fs->target). The 2nd and 3rd iterations are not performed when tb cache is not set (see {@link cache}).
		 * @param path mountpoint directory
		 */
		[CCode(cname = "mnt_table_find_target")]
		public unowned FileSystem? find_target(string path, Direction direction);
		[CCode(cname = "mnt_table_get_root_fs")]
		public int get_root_fs(out unowned FileSystem? fs);
		[CCode(cname = "mnt_table_is_fs_mounted")]
		public bool is_mounted(FileSystem fs);
		/**
		 * Iterate over items in a list.
		 * @return 0 on success, negative number in case of error or 1 at end of list. Example:
		 */
		[CCode(cname = "mnt_table_next_fs")]
		public int next(Iter itr, out unowned FileSystem? fs);
		/**
		 * Note that filesystems are returned in the order how was mounted (according to IDs in /proc/self/mountinfo).
		 * @return 0 on success, negative number in case of error or 1 at end of list.
		 */
		[CCode(cname = "mnt_table_next_child_fs")]
		public int next_child(Iter itr, FileSystem parent, out unowned FileSystem? chld);
		/**
		 * Parse files from a directory.
		 *
		 * Files are sorted by strverscmp(3). Files that starts with "." are ignored (e.g., ".10foo.fstab") and files without the ".fstab" extension are ignored.
		 */
		[CCode(cname = "mnt_table_parse_dir")]
		public int parse_dir(string dirname);
		/**
		 * Parses whole table (e.g., /etc/mtab) and appends new records to the tab.
		 *
		 * The libmount parser ignores broken (syntax error) lines, these lines are reported to caller by {@link error_handler}.
		 */
		[CCode(cname = "mnt_table_parse_file")]
		public int parse_file(string filename);
		/**
		 * This function parses /etc/fstab and appends new lines to the tab.
		 * @param filename filename to parse. If the filename is a directory then mnt_table_parse_dir() is called. The default is (/etc/fstab or $LIBMOUNT_FSTAB)
		 */
		[CCode(cname = "mnt_table_parse_fstab")]
		public int parse_fstab(string? filename = null);
		/**
		 * This function parses /etc/mtab or /proc/self/mountinfo + /run/mount/utabs or /proc/mounts.
		 * @param filename file to parse; default (/etc/mtab or $LIBMOUNT_MTAB)
		 */
		[CCode(cname = "mnt_table_parse_mtab")]
		public int parse_mtab(string? filename = null);
		/**
		 * Parse from an open file.
		 * @param filename filename used for debug and error messages
		 */
		[CCode(cname = "mnt_table_parse_stream")]
		public int parse_stream(
#if POSIX
		Posix.FILE
#else
		GLib.FileStream
#endif
		f, string filename);
		[CCode(cname = "mnt_table_remove_fs")]
		public int remove(FileSystem fs);
		/**
		 * Sets iter to the position of a filesystem in the file table.
		 */
		[CCode(cname = "mnt_table_set_iter")]
		public int set_iter(Iter itr, FileSystem fs);
	}
	/**
	 * /etc/mtab or utab update description
	 */
	[CCode(cname = "struct libmnt_update", free_function = "mnt_free_update", has_type_id = false)]
	[Compact]
	public class Update {
		/**
		 * This function returns file name (e.g. /etc/mtab) for the up-dated file.
		 */
		public string filename {
			[CCode(cname = "mnt_update_get_filename")]
			get;
		}
		public FileSystem? fs {
			[CCode(cname = "mnt_update_get_fs")]
			get;
		}
		/**
		 * Is entry described by upd is successfully prepared and will be written to mtab/utab file?
		 */
		public bool is_ready {
			[CCode(cname = "mnt_update_is_ready")]
			get;
		}
		public UserFlag user_flags {
			[CCode(cname = "mnt_update_get_mflags")]
			get;
		}
		[CCode(cname = "mnt_new_update")]
		public Update();
		[CCode(cname = "mnt_update_force_rdonly")]
		public int force_read_only(bool read_only);
		/**
		 * Set filesystem.
		 * @param target unmount target, null for mount
		 * @param fs mount file system description, null for umount
		 */
		[CCode(cname = "mnt_update_set_fs")]
		public int set_fs(Flag mountflags, string? target, FileSystem? fs);
		/**
		 * High-level API to update /etc/mtab (or private /run/mount/utab file).
		 *
		 * The lock is optional and will be created if necessary. Note that the automatically created lock blocks all signals.
		 * @see Context.get_lock
		 * @see Lock.block_signals
		 */
		[CCode(cname = "mnt_update_table")]
		public int update_table(Lock? lc = null);
	}
	[CCode(cname = "int", cprefix = "MNT_ACT_", has_type_id = false)]
	public enum Action {
		UMOUNT,
		MOUNT
	}
	[CCode(cname = "int", cprefix = "MNT_ITER_", has_type_id = false)]
	public enum Direction {
		FORWARD,
		BACKWARD,
		[CCode(cname = "-1")]
		UNCHANGED
	}
	[CCode(cname = "unsigned long", cprefix = "MS_", has_type_id = false)]
	[Flags]
	public enum Flag {
		/**
		 * Mount existing tree also elsewhere
		 */
		BIND,
		/**
		 * Directory modifications are synchronous
		 */
		DIRSYNC,
		/**
		 * Update inode I_version field
		 */
		I_VERSION,
		/**
		 * Allow mandatory locks on an FS
		 */
		MANDLOCK,
		/**
		 * Magic flag number mask
		 */
		MGC_MSK,
		/**
		 * Magic flag number to indicate "new" flags
		 */
		MGC_VAL,
		/**
		 * Atomically move tree
		 */
		MOVE,
		/**
		 * Do not update access times.
		 */
		NOATIME,
		/**
		 * Disallow access to device special files
		 */
		NODEV,
		/**
		 * Don't update directory access times
		 */
		NODIRATIME,
		/**
		 * Disallow program execution
		 */
		NOEXEC,
		/**
		 * Ignore suid and sgid bits
		 */
		NOSUID,
		OWNERSECURE,
		PRIVATE,
		PROPAGATION,
		/**
		 * Mount read-only
		 */
		RDONLY,
		/**
		 * Recursive loopback
		 */
		REC,
		/**
		 * Update access times relative
		 */
		RELATIME,
		/**
		 * Alter flags of a mounted FS
		 */
		REMOUNT,
		SECURE,
		SHARED,
		SILENT,
		SLAVE,
		/**
		 * Strict atime semantics
		 */
		STRICTATIME,
		/**
		 * Writes are synced at once
		 */
		SYNCHRONOUS,
		UNBINDABLE
	}
	[CCode(cname = "int", cprefix = "MNT_TABDIFF_", has_type_id = false)]
	public enum Operation {
		MOVE,
		UMOUNT,
		REMOUNT,
		MOUNT
	}
	/**
	 * Controls how to use mount optionsmsource and target paths from fstab/mtab.
	 */
	[Flags]
	[CCode(cname = "int", cprefix = "MNT_OMODE", has_type_id = false)]
	public enum OptsMode {
		/**
		 * Ignore mtab/fstab options
		 */
		IGNORE,
		/**
		 * Append mtab/fstab options to existing options
		 */
		APPEND,
		/**
		 * Prepend mtab/fstab options to existing options
		 */
		PREPEND,
		/**
		 * Replace existing options with options from mtab/fstab
		 */
		REPLACE,
		/**
		 * Always read mtab/fstab (although source and target is defined)
		 */
		FORCE,
		/**
		 * Read from fstab
		 */
		FSTAB,
		/**
		 * Read from mtab if fstab not enabled or failed
		 */
		MTAB,
		/**
		 * Do not read fstab/mtab at all
		 */
		NOTAB,

		/**
		 * Default mode ({@link PREPEND} | {@link FSTAB} | {@link MTAB})
		 */
		AUTO,
		/**
		 * Default for non-root users ({@link REPLACE} | {@link FORCE} | {@link FSTAB})
		 *
		 * This is always used if mount context is in restricted mode.
		 */
		USER
	}
	[CCode(cname = "unsigned long", cprefix = "MNT_MS_", has_type_id = false)]
	[Flags]
	public enum UserFlag {
		COMMENT,
		GROUP,
		HELPER,
		LOOP,
		NETDEV,
		NOAUTO,
		NOFAIL,
		OFFSET,
		OWNER,
		SIZELIMIT,
		ENCRYPTION,
		UHELPER,
		USER,
		USERS,
		XCOMMENT
	}
	[CCode(cname = "LIBMOUNT_VERSION")]
	public const string VERSION;
	[CCode(has_target = false)]
	public delegate int TablesError(Table tb, string filename, int line);
	/**
	 * Path to /etc/fstab or $LIBMOUNT_FSTAB.
	 */
	[CCode(cname = "mnt_get_fstab_path")]
	public unowned string get_fstab_path();
	[CCode(cname = "mnt_get_library_features")]
	private int _get_library_features([CCode(array_length = false)]out unowned string[] features);
	public unowned string[] get_library_features() {
		unowned string[] features;
		features.length = _get_library_features(out features);
		return features;
	}
	[CCode(cname = "mnt_get_library_version")]
	public int get_library_version(out unowned string ver_string);
	/**
	 * This function returns default location of the mtab file.
	 *
	 * The result does not have to be writable.
	 * @see has_regular_mtab
	 */
	[CCode(cname = "mnt_get_mtab_path")]
	public unowned string get_mtab_path();
	/**
	 * If the file does not exist and writable argument is not null then it will try to create the file
	 * @param mtab path to mtab
	 * @param writable true if the file is writable
	 * @return true if /etc/mtab is a regular file
	 */
	[CCode(cname = "mnt_has_regular_mtab")]
	public bool has_regular_mtab(out unowned string mtab, out bool writable);
	[CCode(cname = "mnt_fstype_is_netfs")]
	public bool is_netfs(string type);
	[CCode(cname = "mnt_fstype_is_pseudofs")]
	public bool is_pseudofs(string type);
	/**
	 * Encode str to be compatible with fstab/mtab
	 */
	[CCode(cname = "mnt_mangle")]
	public string? mangle(string str);
	/**
	 * Whether a filesystem matches a list of filesystems, possibly prefixed with '''no'''.
	 *
	 * The pattern list of filesystem can be prefixed with a global "no" prefix to invert matching of the whole list. The "no" could also be used for individual items in the pattern list. So, "nofoo,bar" has the same meaning as "nofoo,nobar".
	 *
	 * "bar" : "nofoo,bar" → false (global "no" prefix)
	 *
	 * "bar" : "foo,bar" → rue
	 *
	 * "bar" : "foo,nobar" → False
	 * @param type filesystem type
	 * @param pattern filesystem name or comma delimited list of names
	 */
	[CCode(cname = "mnt_match_fstype")]
	public bool match_fstype(string type, string pattern);
	/**
	 * Determine if an option string matches a pattern.
	 *
	 * The "no" could used for individual items in the options list. The "no" prefix does not have a global meaning.
	 *
	 * Unlike fs type matching, nonetdev,user and nonetdev,nouser have DIFFERENT meanings; each option is matched explicitly as specified.
	 *
	 * The "no" prefix interpretation could be disable by "+" prefix, for example "+noauto" matches if optstr literally contains "noauto" string.
	 *
	 * "xxx,yyy,zzz" : "nozzz" → False
	 *
	 * "xxx,yyy,zzz" : "xxx,noeee" → true
	 *
	 * "bar,zzz" : "nofoo" → True
	 *
	 * "nofoo,bar" : "+nofoo" → True
	 *
	 * "bar,zzz" : "+nofoo" → False
	 * @param optstr options string
	 * @param pattern comma delimited list of options
	 */
	[CCode(cname = "mnt_match_options")]
	public bool match_options(string optstr, string pattern);
	[CCode(cname = "mnt_parse_version_string")]
	public int parse_version_string();
	/**
	 * Converts path to the absolute path, /dev/dm-N to /dev/mapper/name, /dev/loopN to the loop backing filename, empty path to 'none'
	 */
	[CCode(cname = "mnt_pretty_path")]
	public string? pretty_path(string? path, Cache? cache = null);
	/**
	 * Converts path to the absolute path, /dev/dm-N to /dev/mapper/name.
	 */
	[CCode(cname = "mnt_resolve_path")]
	public string? resolve_path(string path, Cache? cache = null);
	/**
	 * Canonicalize path or tag.
	 * @param spec path or tag
	 */
	[CCode(cname = "mnt_resolve_spec")]
	public string? resolve_spec(string spec, Cache? cache = null);
	/**
	 * Convert a tag into a device name.
	 */
	[CCode(cname = "mnt_resolve_tag")]
	public string? resolve_tag(string token, string @value, Cache? cache = null);
	/**
	 * Decode str from fstab/mtab
	 */
	[CCode(cname = "mnt_unmangle")]
	public string? unmangle(string str);
}
