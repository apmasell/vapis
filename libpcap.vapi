[CCode(cheader_filename = "pcap/pcap.h")]
namespace PCap {
	/**
	 * Representation of an interface address.
	 *
	 * Note that not all the addresses in the list of addresses are necessarily IPv4 or IPv6 addresses - you must check the sa_family member of the struct sockaddr before interpreting the contents of the address.
	 */
	[CCode(cname = "pcap_addr_t", has_type_id = false)]
	[Compact]
	public class Address {
		public Address? next;
		/**
		 * Address
		 */
		public Posix.SockAddr? addr;
		/**
			* Netmask for this address
			*/
		public Posix.SockAddr? netmask;
		/**
		 * Broadcast address for this address
		 *
		 * May be null if the interface doesn't support broadcasts
		 */
		public Posix.SockAddr? broadaddr;
		/**
		 * P2P destination address for this address
		 *
		 * The destination address corresponding to the address; may be null if the interface isn't a point-to-point interface
		 */
		public Posix.SockAddr? dstaddr;
	}

	/**
	 * Interface to capture packets.
	 */
	[CCode(cname = "pcap_t", free_function = "pcap_close", has_type_id = false)]
	[Compact]
	public class Capture {
		/**
		 * Set the buffer size for a not-yet-activated capture handle in units of bytes
		 */
		public int buffer_size {
			[CCode(cname = "pcap_set_buffer_size")]
			set;
		}

		/**
		 * Whether monitor mode can be set for a not-yet-activated capture handle
		 */
		public Result can_set_rfmon {
			[CCode(cname = "pcap_can_set_rfmon")]
			get;
		}

		/**
		 * The link-layer header type
		 */
		public LinkLayer datalink {
			[CCode(cname = "pcap_datalink")]
			get;
		}

		/**
		 * The standard I/O stream for a save file being read
		 *
		 * The standard I/O stream of the save file, if a save file was opened with {@link open_offline_file}, or null, if a network device was opened with {@link create} and {@link activate}, or with {@link open_live}.
		 *
		 * Note that the Packet Capture library is usually built with large file support, so the standard I/O stream of the save file might refer to a file larger than 2 gigabytes; applications should, if possible, use calls that support large files.
		 */
#if POSIX
		public Posix.FILE? file
#else
		public GLib.FileStream? file
#endif
		{
			[CCode(cname = "pcap_file")]
			get;
		}

		/**
		 * The file descriptor for a live capture
		 *
		 * For a network device that was opened for a live capture using a combination of {@link create} and {@link activate}, or using {@link open_live}, the file descriptor from which captured packets are read.

		 * For refers to a save file that was opened using functions such as {@link open_offline_file} or {@link open_offline_stream}, a dead {@link Capture} opened using {@link open_dead}, or a {@link Capture} that was created with {@link create} but that has not yet been activated with {@link activate}, it returns -1.
		 */
		public int fileno {
			[CCode(cname = "pcap_fileno")]
			get;
		}

		/**
		 * Whether a save file has the native byte order
		 *
		 * For a live capture, it is always false.
		 */
		public bool is_swapped {
			[CCode(cname = "pcap_is_swapped")]
			get;
		}

		/**
		 * The major version number of a save file
		 */
		public int major_version {
			[CCode(cname = "pcap_major_version")]
			get;
		}

		/**
		 * The minor version number of a save file
		 */
		public int minor_version {
			[CCode(cname = "pcap_minor_version")]
			get;
		}

		/**
		 * Set promiscuous mode for a not-yet-activated capture handle
		 */
		public bool promisc {
			[CCode(cname = "pcap_set_promisc")]
			set;
		}

		/**
		 * Set monitor mode for a not-yet-activated capture handle
		 */
		public bool rfmon {
			[CCode(cname = "pcap_set_rfmon")]
			set;
		}

		/**
		 * A file descriptor on which a select() can be done for a live capture
		 *
		 * A file descriptor number for a file descriptor on which one can do a select() or poll() to wait for it to be possible to read packets without blocking, if such a descriptor exists, or -1, if no such descriptor exists. Some network devices do not support select() or poll() (for example, regular network devices on FreeBSD 4.3 and 4.4, and Endace DAG devices).
		 *
		 * Note that on most versions of most BSDs (including Mac OS X) select() and poll() do not work correctly on BPF devices; a file descriptor on most of those versions (the exceptions being FreeBSD 4.3 and 4.4), a simple select() or poll() will not return even after the read timeout expires. To work around this, an application that uses select() or poll() to wait for packets to arrive must put the {@link Capture} in non-blocking mode, and must arrange that the select() or poll() have a timeout less than or equal to the read timeout, and must try to read packets after that timeout expires, regardless of whether select() or poll() indicated that the file descriptor is ready to be read or not. (That workaround will not work in FreeBSD 4.3 and later; however, in FreeBSD 4.6 and later, select() and poll() work correctly on BPF devices, so the workaround isn't necessary, although it does no harm.)
		 *
		 * Note also that poll() doesn't work on character special files, including BPF devices, in Mac OS X 10.4 and 10.5, so, while select() can be used on the descriptor, poll() cannot be used on it those versions of Mac OS X. Kqueues also don't work on that descriptor. poll(), but not kqueues, work on that descriptor in Mac OS X releases prior to 10.4; poll() and kqueues work on that descriptor in Mac OS X 10.6 and later.
		 */
		public int selectable_fd {
			[CCode(cname = "pcap_get_selectable_fd")]
			get;
		}

		/**
		 * The snapshot length for a not-yet-activated capture handle
		 */
		public int snaplen {
			[CCode(cname = "pcap_set_snaplen")]
			set;
			[CCode(cname = "pcap_snapshot")]
			get;
		}

		/**
		 * Set the read timeout for a not-yet-activated capture handle in units of milliseconds
		 */
		public int timeout {
			[CCode(cname = "pcap_set_timeout")]
			set;
		}

		/**
		 * Create a live capture handle
		 *
		 * Create a packet capture handle to look at packets on the network. The returned handle must be activated with {@link activate} before packets can be captured with it; options for the capture, such as promiscuous mode, can be set on the handle before activating it.
		 * @param device is a string that specifies the network device to open; on Linux systems with 2.2 or later kernels, a source argument of "any" or null can be used to capture packets from all interfaces.
 @param error_buffer is filled in with an appropriate error message. It is assumed to be able to hold at least {@link ERRBUF_SIZE} chars.
		 */
		[CCode(cname = "pcap_create")]
		public static Capture? create(string? device, [CCode(array_length = false)] char[] error_buffer);

		/**
		 * Open a fake handle for compiling filters or opening a capture for output
		 *
		 * It is used for creating a handle to use when calling the other functions in libpcap. It is typically used when just using libpcap for compiling BPF code.
		 * @param linktype the link-layer type.
		 * @param snaplen the snapshot length.
		 */
		[CCode(cname = "pcap_open_dead")]
		public static Capture? open_dead(LinkLayer linktype, int snaplen);

		/**
		 * Obtain a packet capture handle to look at packets on the network.
		 *
		 * @param device specifies the network device to open; on Linux systems with 2.2 or later kernels, a device argument of "any" or null can be used to capture packets from all interfaces.
		 * @param snaplen the snapshot length to be set on the handle.
		 * @param promisc if the interface is to be put into promiscuous mode.
		 * @param timeout the read timeout in milliseconds.
		 * @param error_buffer If null is returned, this is filled in with an appropriate error message. It may also be set to warning text when the method succeeds; to detect this case the caller should store a zero-length string and display the warning to the user if it is no longer a zero-length string. It is assumed to be able to hold at least {@link ERRBUF_SIZE} chars.
		 * @return a handle on success and null on failure.
		 */
		 [CCode(cname = "pcap_open_live")]
 public static Capture? open_live(string? device, int snaplen, bool promisc, int timeout, [CCode(array_length = false)] char[] error_buffer);

		/**
		 * Open a saved capture file for reading
		 *
		 * @param file_name the name of the file to open. The file can have the pcap file format as described in pcap-savefile(5), which is the file format used by, among other programs, tcpdump(1) and tcpslice(1), or can have the pcap-ng file format, although not all pcap-ng files can be read. The name "-" in a synonym for stdin.
 stream fp. Note that on Windows, that stream should be opened in binary mode.
			 */
			[CCode(cname = "pcap_open_offline")]
			public static Capture? open_offline_file(string file_name, [CCode(array_length = false)] char[] error_buffer);

		/**
		 * Read dumped data from an existing open file.
		 */
		public static Capture? open_offline_stream(owned
#if POSIX
			Posix.FILE
#else
			GLib.FileStream
#endif
			file, [CCode(array_length = false)] char[] error_buffer) {
			var result = _open_offline_stream(file, error_buffer);
			if (result != null) {
				_sink_file((owned) file);
			}
			return result;
		}

		[CCode(cname = "pcap_fopen_offline")]
		private static Capture? _open_offline_stream(
#if POSIX
			Posix.FILE
#else
			GLib.FileStream
#endif
			file, [CCode(array_length = false)] char[] error_buffer);

		/**
		 * Activate a capture handle to look at packets on the network, with the options that were set on the handle being in effect.
		 */
		[CCode(cname = "pcap_activate")]
		public Result activate();

		/**
		 * Force a {@link dispatch} or {@link loop} to return
		 *
		 * This routine is safe to use inside a signal handler on UNIX or a console control handler on Windows, as it merely sets a flag that is checked within the loop.
		 *
		 * The flag is checked in loops reading packets from the OS - a signal by itself will not necessarily terminate those loops - as well as in loops processing a set of packets returned by the OS. Note that if you are catching signals on UNIX systems that support restarting system calls after a signal, and calling this method in the signal handler, you must specify, when catching those signals, that system calls should NOT be restarted by that signal. Otherwise, if the signal interrupted a call reading packets in a live capture, when your signal handler returns after calling this method, the call will be restarted, and the loop will not terminate until more packets arrive and the call completes.
		 *
		 * Note also that, in a multi-threaded application, if one thread is blocked in {@link dispatch}, {@link loop}, {@link next}, or {@link next_ex}, a call to this method in a different thread will not unblock that thread; you will need to use whatever mechanism the OS provides for breaking a thread out of blocking calls in order to unblock the thread, such as thread cancellation in systems that support POSIX threads.
		 *
		 * Note that {@link next} and {@link next_ex} will, on some platforms, loop reading packets from the OS; that loop will not necessarily be terminated by a signal, so this method should be used to terminate packet processing even if {@link next} or {@link next_ex} is being used.
		 *
		 * This method does not guarantee that no further packets will be processed by {@link dispatch} or {@link loop} after it is called; at most one more packet might be processed.
		 *
		 * If {@link Result.BREAK} is returned from {@link dispatch} or {@link loop}, the flag is cleared, so a subsequent call will resume reading packets. If a positive number is returned, the flag is not cleared, so a subsequent call will return {@link Result.BREAK} and clear the flag.
		 */
		[CCode(cname = "pcap_breakloop")]
		public void	break_loop();

		/**
		 * Compile a filter expression
		 *
		 * @param str the filter program. See pcap-filter(7) for the syntax of that string.
		 * @param program the output program
		 * @param optimize whether optimization on the resulting code is performed.
		 * @param netmask the IPv4 netmask of the network on which packets are being captured; it is used only when checking for IPv4 broadcast addresses in the filter program. If the netmask of the network on which packets are being captured isn't known to the program, or if packets are being captured on the Linux "any" pseudo-interface that can capture on more than one network, a value of {@link NETMASK_UNKNOWN} can be supplied; tests for IPv4 broadcast addresses will fail to compile, but all other tests in the filter program will be OK.
		 */
		[CCode(cname = "pcap_compile")]
		public Result compile(out program program, string str, bool optimize = true, uint32 netmask = NETMASK_UNKNOWN);

		/**
		 * Process packets from a live capture or save file
		 *
		 * Processes packets from a live capture or save file until a specified number of packets are processed, the end of the current bufferful of packets is reached when doing a live capture, the end of the savefile is reached when reading from a savefile, {@link break_loop} is called, or an error occurs.
		 *
		 * @param cnt the number of packets to process. When doing a live capture, this is the maximum number of packets to process before returning, but is not a minimum number; when reading a live capture, only one bufferful of packets is read at a time, so fewer packets may be processed. A value of -1 or 0 causes all the packets received in one buffer to be processed when reading a live capture, and causes all the packets in the file to be processed when reading a savefile.
		 */
		[CCode(cname = "pcap_dispatch")]
		public Result dispatch(int cnt, Handler callback);

		/**
		 * Get a list of link-layer header types supported by a capture device
		 */
		public LinkLayer[] get_datalinks() {
			LinkLayer[] dlts;
			var len = _list_datalinks(out dlts);
			dlts.length = len;
			return (owned) dlts;
		}
		[CCode(cname = "pcap_list_datalinks")]
		private int _list_datalinks(out LinkLayer[] dlts);

		/**
		 * Get libpcap error message text
		 *
		 * The error text pertaining to the last pcap library error.
		 */
		[CCode(cname = "pcap_geterr")]
		public unowned string get_error();

		/**
		 * Set the state of non-blocking mode on a capture device
		 * @see set_nonblock
		 */
		[CCode(cname = "pcap_getnonblock")]
		public bool get_nonblock([CCode(array_length = false)] char[] error_buffer);

		/**
		 * Get capture statistics
		 *
		 * This is supported only on live captures, not on save files; no statistics are stored in save files, so no statistics are available when reading from a save file.
		 */
		[CCode(cname = "pcap_stats")]
		public Result get_stats(out stat stats);

		/**
		 * Transmit a raw packet through the network interface
		 *
		 * Note that, even if you successfully open the network interface, you might not have permission to send packets on it, or it might not support sending packets; as {@link open_live} doesn't have a flag to indicate whether to open for capturing, sending, or capturing and sending, you cannot request an open that supports sending and be notified at open time whether sending will be possible. Note also that some devices might not support sending packets.
		 *
		 * Note that, on some platforms, the link-layer header of the packet that's sent might not be the same as the link-layer header of the packet supplied to {@link inject}, as the source link-layer address, if the header contains such an address, might be changed to be the address assigned to the interface on which the packet it sent, if the platform doesn't support sending completely raw and unchanged packets. Even worse, some drivers on some platforms might change the link-layer type field to whatever value libpcap used when attaching to the device, even on platforms that do nominally support sending completely raw and unchanged packets.
		 * @param buf points to the data of the packet, including the link-layer header
		 * @return the number of bytes written
		 * @see send_packet
		 */
		[CCode(cname = "pcap_inject")]
		public int inject(uint8[] buf);

		/**
		 * Process packets from a live capture or save file
		 *
		 * Processes packets from a live capture or save file until a specified number of packets are processed, the end of the save file is reached, {@link break_loop} is called, or an error occurs. It does not return when live read timeouts occur.
		 * @param cnt the number of packets to process. A value of -1 or 0 is equivalent to infinity, so that packets are processed until another ending condition occurs.
		 */
		[CCode(cname = "pcap_loop")]
		public Result loop(int cnt, Handler callback);

		/**
		 * Read the next packet.
		 *
		 * @return the data in that packet or null of an error occurs
		 */
		[CCode(cname = "pcap_next", array_length = false)]
		public uint8[]? next(out packet_header header);

		/**
		 * Read the next packet
		 *
		 * Reads the next packet and returns a success/failure indication.
		 * @param header If the packet was read without problems, the header for the packet
		 * @param header If the packet was read without problems, the data for the packet
		 * @return 1 if the packet was read without problems, {@link Result.SUCCESS} if packets are being read from a live capture, and the timeout expired, {@link Result.ERROR} if an error occurred while reading the packet, and {@link Result.BREAK} if packets are being read from a save file, and there are no more packets to read from the save file.
		 */
		[CCode(cname = "pcap_next_ex")]
		public Result next_ex(out packet_header? header, [CCode(array_length = false)] out uint8[]? data);

		/**
		 * Open a save file for writing.
		 * @param filename the name of the file to open. The file will have the same format as those used by tcpdump(1) and tcpslice(1). The name "-" in a synonym for stdout.
		 */
		[CCode(cname = "pcap_dump_open")]
		public Dumper? open_dump_file(string filename);

		/**
		 * Write data to an existing open stream.
		 *
		 * Note that on Windows, that stream should be opened in binary mode.
		 */
		[CCode(cname = "pcap_dump_fopen")]
#if POSIX
		public Dumper? open_dump_stream(owned Posix.FILE file);
#else
		public Dumper? open_dump_stream(owned GLib.FileStream file);
#endif

		/**
		 * Print libpcap error message text
		 *
		 * Prints the text of the last pcap library error on stderr.
		 * @param prefix A string to print before the error.
		 */
		[CCode(cname = "pcap_perror")]
		public void	perror(string prefix);

		/**
		 * Transmit a raw packet through the network interface
		 * @return false on success, true on failure
		 * @see inject
		 */
		[CCode(cname = "pcap_sendpacket")]
		public bool send_packet(uint8[] buf);

		/**
		 * Set the link-layer header type to be used by a capture device
		 */
		[CCode(cname = "pcap_set_datalink")]
		public Result set_datalink(LinkLayer dlt);

		/**
		 * Set the direction for which packets will be captured
		 *
		 * This method isn't necessarily fully supported on all platforms; some platforms might return an error for all values, and some other platforms might not support {@link Direction.OUT}.
		 *
		 * This operation is not supported if a save file is being read.
		 */
		[CCode(cname = "pcap_setdirection")]
		public Result set_direction(Direction d);

		/**
		 * Set the packet filter
		 */
		[CCode(cname = "pcap_setfilter")]
		public Result set_filter(program program);

		/**
		 * Set the state of non-blocking mode on a capture device
		 *
		 * Puts a capture handle into non-blocking mode, or takes it out of non-blocking mode. It has no effect on save files. In non-blocking mode, an attempt to read from the capture descriptor with {@link dispatch} will, if no packets are currently available to be read, return 0 immediately rather than blocking waiting for packets to arrive. {@link loop} and {@link next} will not work in non-blocking mode.
		 */
		[CCode(cname = "pcap_setnonblock")]
		public Result set_nonblock(bool blocking, [CCode(array_length = false)] char[] error_buffer);
	}

	/**
	 * Save file generator
	 */
	[CCode(cname = "pcap_dumper_t", has_type_id = false, destroy_function = "pcap_dump_close")]
	[Compact]
	public class Dumper {
		/**
		 * The file being written to.
		 */
#if POSIX
		public Posix.FILE file
#else
		public GLib.FileStream file
#endif
		{
			[CCode(cname = "pcap_dump_file")]
			get;
		}
		/**
		 * The current position in the file.
		 */
		public long position {
			[CCode(cname = "pcap_dump_ftell")]
			get;
		}
		/**
		 * Write a packet to a capture file
		 */
		[CCode(cname = "pcap_dump")]
		public void dump(packet_header header, [CCode(array_length = false)] uint8[] data);
		/**
		 * Flush to a save file packets dumped
		 *
		 * Flushes the output buffer to the save file, so that any packets written with {@link dump} but not yet written to the save file will be written.
		 */
		[CCode(cname = "pcap_dump_flush")]
		public Result flush();
	}

	/**
	 * An openable interface
	 */
	[CCode(cname = "pcap_if_t", has_type_id = false, free_function = "pcap_freealldevs")]
	public class Interface {
		public Interface? next;
		/**
		 * name to hand to {@link Capture.open_live}
		 */
		public string name;
		/**
		 * Textual description of interface
		 */
		public string? description;
		public Address? addresses;
		public InterfaceFlags flags;
		/**
		 * Get a list of capture devices
		 *
		 * Constructs a list of network devices that can be opened with {@link Capture.create} and {@link Capture.activate} or with {@link Capture.open_live}. (Note that there may be network devices that cannot be opened by the process, because, for example, that process might not have sufficient privileges to open them for capturing; if so, those devices will not appear on the list.)
		 */
		[CCode(cname = "pcap_findalldevs")]
		public static Result find(out Interface first, [CCode(array_length = false)] char[] error_buffer);
	}

	/**
	 * Used to specify a direction that packets will be captured
	 */
	[CCode(cname = "pcap_direction_t", cprefix = "PCAP_D_", has_type_id = false)]
	public enum Direction {
		/**
		 * Capture packets received by or sent by the device. (Default)
		 */
		INOUT,
		/**
		 * Only capture packets received by the device
		 */
		IN,
		/**
		 * Only capture packets sent by the device
		 */
		OUT
	}

	public enum DumpFormat {
		[CCode(cname = "0")]
		OPCODE,
		[CCode(cname = "1")]
		C,
		[CCode(cname = "2")]
		NUMERIC
	}

	/**
	 * Relevant information about an interface's type
	 */
	[CCode(cname = "bpf_u_int32", cprefix = "PCAP_IF_", has_type_id = false)]
	[Flags]
	public enum InterfaceFlags {
		/**
		 * Interface is loopback
		 */
		LOOPBACK
	}

	/**
	 * Data-link level type
	 */
	[CCode(cname = "int", cprefix = "DLT_", has_type_id = false)]
	public enum LinkLayer {
		/**
		 * BSD loopback encapsulation
		 */
		NULL,
		/**
		 * Ethernet (10Mb)
		 */
		EN10MB,
		/**
		 * Experimental Ethernet (3Mb)
		 */
		EN3MB,
		/**
		 * Amateur Radio AX.25
		 */
		AX25,
		/**
		 * Proteon ProNET Token Ring
		 */
		PRONET,
		/**
		 * Chaos
		 */
		CHAOS,
		/**
		 * 802.5 Token Ring
		 */
		IEEE802,
		/**
		 * ARCNET, with BSD-style header
		 */
		ARCNET,
		/**
		 * Serial Line IP
		 */
		SLIP,
		/**
		 * Point-to-point Protocol
		 */
		PPP,
		/**
		 * FDDI
		 */
		FDDI,
		/**
		 * LLC-encapsulated ATM
		 */
		ATM_RFC1483,
		/**
		 * raw IP
		 */
		RAW,
		/**
		 * BSD/OS Serial Line IP
		 */
		SLIP_BSDOS,
		/**
		 * BSD/OS Point-to-point Protocol
		 */
		PPP_BSDOS,
		/**
		 * Linux Classical-IP over ATM
		 */
		ATM_CLIP,
		/**
		 * NetBSD PPP over serial with HDLC encapsulation
		 */
		PPP_SERIAL,
		/**
		 * NetBSD PPP over Ethernet
		 */
		PPP_ETHER,
		/**
		 * The Axent Raptor firewall (now the Symantec Enterprise Firewall)
		 */
		SYMANTEC_FIREWALL,
		/**
		 * Cisco HDLC
		 */
		C_HDLC,
		/**
		 * IEEE 802.11 wireless
		 */
		IEEE802_11,
		/**
		 * Frame Relay
		 *
		 * Packets start with the Q.922 Frame Relay header (DLCI, etc.).
		 */
		FRELAY,
		/**
		 * OpenBSD loopback devices
		 *
		 * It's like {@link NULL}, except that the AF_ type in the link-layer header is in network byte order.
		 */
		LOOP,
		/**
		 * Encapsulated packets for IPsec
		 */
		ENC,
		/**
		 * Linux cooked sockets
		 */
		LINUX_SLL,
		/**
		 * Apple LocalTalk hardware
		 */
		LTALK,
		/**
		 * Acorn Econet
		 */
		ECONET,
		/**
		 * OpenBSD ipfilter
		 */
		IPFILTER,
		/**
		 * OpenBSD {@link PFLOG}
		 */
		OLD_PFLOG,
		PFSYNC,
		PFLOG,
		/**
		 * Cisco-internal use.
		 */
		CISCO_IOS,
		/**
		 * 802.11 cards using the Prism II chips
		 *
		 * The link-layer header including Prism monitor mode information plus an 802.11 header.
		 */
		PRISM_HEADER,
		/**
		 * Aironet 802.11 cards
		 */
		AIRONET_HEADER,
		/**
		 * Siemens HiPath HDLC.
		 */
		HHDLC,
		/**
		 * RFC 2625 IP-over-Fibre Channel
		 *
		 * This is not for use with raw Fibre Channel, where the link-layer
		 * header starts with a Fibre Channel frame header; it's for IP-over-FC,
		 * where the link-layer header starts with an RFC 2625 Network_Header
		 * field.
		 */
		IP_OVER_FC,
		/**
		 * Full Frontal ATM on Solaris with SunATM, with a pseudo-header followed by an AALn PDU.
		 *
		 * There may be other forms of Full Frontal ATM on other OSes,
		 * with different pseudo-headers.
		 *
		 * If ATM software returns a pseudo-header with VPI/VCI information
		 * (and, ideally, packet type information, e.g., signalling, ILMI,
		 * LANE, LLC-multiplexed traffic, etc.), it should not use
		 * {@link ATM_RFC1483}, but should get a new value, so tcpdump
		 * and the like don't have to infer the presence or absence of a
		 * pseudo-header and the form of the pseudo-header.
		 */
		SUNATM,
		/**
		 * RapidIO
		 */
		RIO,
		/**
		 * PCI Express
		 */
		PCI_EXP,
		/**
		 * Xilinx Aurora link layer
		 */
		AURORA,
		/**
		 * 802.11 plus radiotap radio header
		 *
		 * Header for 802.11 plus a number of bits of link-layer information
		 * including radio information, used by some recent BSD drivers as
		 * well as the madwifi Atheros driver for Linux.
		 */
		IEEE802_11_RADIO,
		/**
		 * Tazmen Sniffer Protocol
		 *
		 * TZSP is a generic encapsulation for any other link type,
		 * which includes a means to include meta-information
		 * with the packet, e.g. signal strength and channel
		 * for 802.11 packets.
		 */
		TZSP,
		/**
		 * ARCNET
		 */
		ARCNET_LINUX,
		JUNIPER_MLPPP,
		JUNIPER_MLFR,
		JUNIPER_ES,
		JUNIPER_GGSN,
		JUNIPER_MFR,
		JUNIPER_ATM2,
		JUNIPER_SERVICES,
		JUNIPER_ATM1,
		/**
		 * Apple IP-over-IEEE 1394
		 */
		APPLE_IP_OVER_IEEE1394,
		/**
		 * SS7 pseudo-header with various info, followed by MTP2
		 */
		MTP2_WITH_PHDR,
		/**
		 * SS7 MTP2, without pseudo-header
		 */
		MTP2,
		/**
		 * SS7 MTP3, without pseudo-header or MTP2
		 */
		MTP3,
		/**
		 * SS7 SCCP, without pseudo-header or MTP2 or MTP3
		 */
		SCCP,
		/**
		 * DOCSIS MAC frames.
		 */
		DOCSIS,
		/**
		 * Linux-IrDA packets
		 */
		LINUX_IRDA,
		/**
		 * IBM SP switch
		 */
		IBM_SP,
		/**
		 * IBM Next Federation switch
		 */
		IBM_SN,
		/**
		 * Reserved for private use
		 *
		 * If you have some link-layer header type that you want to use within your
		 * organization, with the capture files using that link-layer header type
		 * not ever be sent outside your organization, you can use these values.
		 *
		 * No libpcap release will use these for any purpose, nor will any tcpdump
		 * release use them, either.
		 *
		 * Do ''NOT'' use these in capture files that you expect anybody not using
		 * your private versions of capture-file-reading tools to read; in
		 * particular, do ''NOT'' use them in products, otherwise you may find that
		 * people won't be able to use tcpdump, or snort, or Ethereal, or... to
		 * read capture files from your firewall/intrusion detection/traffic
		 * monitoring/etc. appliance, or whatever product uses that value, and you
		 * may also find that the developers of those applications will not accept
		 * patches to let them read those files.
		 *
		 * Also, do not use them if somebody might send you a capture using them
		 * for ''their'' private type and tools using them for ''your'' private
		 * type would have to read them.
		 *
		 * Instead, ask the [[mailto:tcpdump-workers@lists.tcpdump.org|tcpdump workers]]
		 * for a new value, as per the comment above, and use the type you're
		 * given.
		 */
		USER0,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER1,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER2,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER3,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER4,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER5,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER6,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER7,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER8,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER9,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER10,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER11,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER12,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER13,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER14,
		/**
		 * Reserved for private use
		 * @see USER0
		 */
		USER15,
		/**
		 * 802.11 plus AVS radio header
		 */
		IEEE802_11_RADIO_AVS,
		/**
		 * Juniper-private data link type
		 */
		JUNIPER_MONITOR,
		/**
		 * Reserved for BACnet MS/TP.
		 */
		BACNET_MS_TP,
		/**
		 * Another PPP variant
		 *
		 * This is used in some OSes to allow a kernel socket filter to distinguish
		 * between incoming and outgoing packets, on a socket intended to supply
		 * pppd with outgoing packets so it can do dial-on-demand and
		 * hangup-on-lack-of-demand; incoming packets are filtered out so they
		 * don't cause pppd to hold the connection up (you don't want random input
		 * packets such as port scans, packets from old lost connections, etc. to
		 * force the connection to stay up).
		 *
		 * The first byte of the PPP header (0xff03) is modified to accomodate the
		 * direction - 0x00 = IN, 0x01 = OUT.
		 */
		PPP_PPPD,
		/**
		 * Juniper-private data link type
		 */
		JUNIPER_PPPOE,
		JUNIPER_PPPOE_ATM,
		/**
		 * GPRS LLC
		 */
		GPRS_LLC,
		/**
		 * GPF-T (ITU-T G.7041/Y.1303)
		 */
		GPF_T,
		/**
		 * GPF-F (ITU-T G.7041/Y.1303)
		 */
		GPF_F,
		/**
		 * Gcom's T1/E1 line monitoring equipment.
		 */
		GCOM_T1E1,
		GCOM_SERIAL,
		/**
		 * Juniper-private data link type for internal communication to Physical Interface Cards (PIC)
		 */
		JUNIPER_PIC_PEER,
		/**
		 * Endace Measurement Systems Ethernet
		 */
		ERF_ETH,
		/**
		 * Endace Measurement Systems Packet-over-SONET
		 */
		ERF_POS,
		/**
		 * Raw LAPD for [[http://www.orlandi.com/visdn/|vISDN]]
		 *
		 * Its link-layer header includes additional information before the LAPD
		 * header, so it's not necessarily a generic LAPD header.
		 */
		LINUX_LAPD,
		/**
		 * Juniper-private data link type for prepending meta-information like interface index, interface name before standard Ethernet
		 */
		JUNIPER_ETHER,
		/**
		 * Juniper-private data link type for prepending meta-information like interface index, interface name before standard PPP
		 */
		JUNIPER_PPP,
		/**
		 * Juniper-private data link type for prepending meta-information like interface index, interface name before standard Frelay
		 */
		JUNIPER_FRELAY,
		/**
		 * Juniper-private data link type for prepending meta-information like interface index, interface name before standard C-HDLC Frames
		 */
		JUNIPER_CHDLC,
		/**
		 * Multi Link Frame Relay (FRF.16)
		 */
		MFR,
		/**
		 * Juniper-private data link type for internal communication with a voice Adapter Card (PIC)
		 */
		JUNIPER_VP,
		/**
		 * [[http://www.condoreng.com/support/downloads/tutorials/ARINCTutorial.pdf|Arinc 429]] frames
		 *
		 * Every frame contains a 32bit A429 label.
		 */
		A429,
		/**
		 * Arinc 653 Interpartition Communication messages
		 *
		 * Please refer to the A653-1 standard for more information.
		 */
		A653_ICM,
		/**
		 * USB packets, beginning with a USB setup header
		 */
		USB,
		/**
		 * Bluetooth HCI UART transport layer (part H:4)
		 */
		BLUETOOTH_HCI_H4,
		/**
		 * IEEE 802.16 MAC Common Part Sublayer
		 */
		IEEE802_16_MAC_CPS,
		/**
		 * USB packets, beginning with a Linux USB header
		 */
		USB_LINUX,
		/**
		 * [[http://www.can-cia.org/downloads/?269|Controller Area Network (CAN) v. 2.0B]] packets
		 *
		 * Used to dump CAN packets coming from a CAN Vector board.
		 */
		CAN20B,
		/**
		 * IEEE 802.15.4, with address fields padded, as is done by Linux drivers
		 */
		IEEE802_15_4_LINUX,
		/**
		 * Per Packet Information encapsulated packets
		 */
		PPI,
		/**
		 * Header for 802.16 MAC Common Part Sublayer plus a radiotap radio header
		 */
		IEEE802_16_MAC_CPS_RADIO,
		/**
		 * Juniper-private data link type for internal communication with a
		 * integrated service module (ISM)
		 */
		JUNIPER_ISM,
		/**
		 * IEEE 802.15.4
		 *
		 * Exactly as it appears in the spec (no padding, no nothing).
		 */
		IEEE802_15_4,
		/**
		 * Various link-layer types, with a pseudo-header, for [[http://www.sita.aero/|SITA]]
		 */
		SITA,
		/**
		 * Various link-layer types, with a pseudo-header, for Endace DAG cards
		 */
		ERF,
		/**
		 * Special header prepended to Ethernet packets when capturing from a
		 * u10 Networks board
		 */
		RAIF1,
		/**
		 * IPMB packet for IPMI
		 *
		 * Begins with the I2C slave address, followed by the netFn and LUN, etc..
		 */
		IPMB,
		/**
		 * Juniper-private data link type for capturing data on a secure tunnel interface.
		 */
		JUNIPER_ST,
		/**
		 * Bluetooth HCI UART transport layer (part H:4)
		 *
		 * With pseudo-header that includes direction information
		 */
		BLUETOOTH_HCI_H4_WITH_PHDR,
		/**
		 * AX.25 packet with a 1-byte KISS header
		 *
		 *	http://www.ax25.net/kiss.htm
		 */
		AX25_KISS,
		/**
		 * LAPD packets from an ISDN channel
		 *
		 * Starting with the address field, with no pseudo-header.
		 */
		LAPD,
		/**
		 * PPP with a one-byte direction pseudo-header prepended
		 *
		 * Don't confuse with {@link PPP_PPPD}
		 *
		 * Zero means "received by this host", non-zero (any non-zero value) means
		 * "sent by this host"
		 */
		PPP_WITH_DIR,
		/**
		 * Cisco HDLC with a one-byte direction pseudo-header prepended
		 *
		 * Zero means "received by this host", non-zero (any non-zero value) means
		 * "sent by this host"
		 */
		C_HDLC_WITH_DIR,
		/**
		 * Frame Relay with a one-byte direction pseudo-header prepended
		 *
		 * Zero means "received by this host", non-zero (any non-zero value) means
		 * "sent by this host"
		 */
		FRELAY_WITH_DIR,
		/**
		 * LAPB with a one-byte direction pseudo-header prepended
		 *
		 * Zero means "received by this host", non-zero (any non-zero value) means
		 * "sent by this host"
		 */
		LAPB_WITH_DIR,
		/**
		 * IPMB with a Linux-specific pseudo-header
		 */
		IPMB_LINUX,
		/**
		 * FlexRay automotive bus
		 */
		FLEXRAY,
		/**
		 * Media Oriented Systems Transport (MOST) bus for multimedia transport
		 */
		MOST,
		/**
		 * Local Interconnect Network (LIN) bus for vehicle networks
		 */
		LIN,
		/**
		 * X2E-private data link type used for serial line capture
		 */
		X2E_SERIAL,
		/**
		 * X2E-private data link type used for the Xoraya data logger family
		 */
		X2E_XORAYA,
		/**
		 * IEEE 802.15.4 with PHY-level data
		 *
		 * Exactly as it appears in the spec (no padding, no nothing), but with the
		 * PHY-level data for non-ASK PHYs (4 octets of 0 as preamble, one octet of
		 * SFD, one octet of frame length and reserved bit, and then the MAC-layer
		 * data, starting with the frame control field).
		 */
		IEEE802_15_4_NONASK_PHY,
		/**
		 * Linux kernel /dev/input/eventN devices
		 *
		 * This is used to communicate keystrokes and mouse movements from the
		 * Linux kernel to display systems, such as Xorg.
		 */
		LINUX_EVDEV,
		/**
		 * GSM Um interfaces, preceded by a "gsmtap" header.
		 */
		GSMTAP_UM,
		/**
		 * GSM Abis interfaces, preceded by a "gsmtap" header.
		 */
		GSMTAP_ABIS,
		/**
		 * MPLS, with an MPLS label as the link-layer header.
		 */
		MPLS,
		/**
		 * USB packets, beginning with a Linux USB header, with the USB header
		 * padded to 64 bytes
		 *
		 * Required for memory-mapped access.
		 */
		USB_LINUX_MMAPPED,
		/**
		 * DECT packets, with a pseudo-header
		 */
		DECT,
		/**
		 * AOS Space Data Link Protocol
		 */
		AOS,
		/**
		 * Wireless HART (Highway Addressable Remote Transducer)
		 *
		 * From the HART Communication Foundation IES/PAS 62591
		 */
		WIHART,
		/**
		 * Fibre Channel FC-2 frames, beginning with a frame header
		 */
		FC_2,
		/**
		 * Fibre Channel FC-2 frames, beginning with an encoding of the SOF, and
		 * ending with an encoding of the EOF.
		 *
		 * The encodings represent the frame delimiters as 4-byte sequences
		 * representing the corresponding ordered sets, with K28.5 represented as
		 * 0xBC, and the D symbols as the corresponding byte values; for example,
		 * SOFi2, which is K28.5 - D21.5 - D1.2 - D21.2, is represented as 0xBC
		 * 0xB5 0x55 0x55.
		 */
		FC_2_WITH_FRAME_DELIMS,
		/**
		 * Solaris ipnet pseudo-header
		 *
		 * An IPv4 or IPv6 datagram follows the pseudo-header; dli_family indicates
		 * which of those it is.
		 */
		IPNET,
		/**
		 * CAN (Controller Area Network) frames, with a pseudo-header as supplied
		 * by Linux SocketCAN
		 */
		CAN_SOCKETCAN,
		/**
		 * Raw IPv4
		 *
		 * Different from {@link RAW} in that the value specifies whether it's v4
		 * or v6.
		 */
		IPV4,
		/**
		 * Raw IPv6
		 *
		 * Different from {@link RAW} in that the value specifies whether it's v4
		 * or v6.
		 */
		IPV6;
		[CCode(cname = "pcap_datalink_name_to_val")]
		public static LinkLayer parse(string name);
		/**
		 * DLT and save file link type values are split into a class and a member
		 * of that class. A class value of {@link NULL} indicates a regular value.
		 */
		[CCode(cname = "DLT_CLASS")]
		public LinkLayer get_class();
		[CCode(cname = "DLT_IS_NETBSD_RAWAF")]
		public bool is_netbsd_rawaf();
		[CCode(cname = "pcap_datalink_val_to_description")]
		public unowned string get_description();
		[CCode(cname = "pcap_datalink_val_to_name")]
		public unowned string get_name();
		[CCode(cname = "DLT_NETBSD_RAWAF")]
		public LinkLayer get_netbsd_rawaf();
		[CCode(cname = "DLT_NETBSD_RAWAF_AF")]
		public LinkLayer strip_netbsd_rawaf();
	}

	/**
	 * The instruction encodings.
	 */
	[CCode(cname = "u_short", has_type_id = false, cprefix = "BPF_")]
	public enum OpCode {
		LD,
		LDX,
		ST,
		STX,
		ALU,
		JMP,
		RET,
		MISC,
		W,
		H,
		B,
		IMM,
		ABS,
		IND,
		MEM,
		LEN,
		MSH,
		ADD,
		SUB,
		MUL,
		DIV,
		OR,
		AND,
		LSH,
		RSH,
		NEG,
		JA,
		JEQ,
		JGT,
		JGE,
		JSET,
		K,
		X,
		A,
		TAX,
		TXA;
		[CCode(cname = "BPF_CLASS")]
		public OpCode get_class();
		[CCode(cname = "BPF_MISCOP")]
		public OpCode get_misc_op();
		[CCode(cname = "BPF_MODE")]
		public OpCode get_mode();
		[CCode(cname = "BPF_OP")]
		public OpCode get_op();
		[CCode(cname = "BPF_RVAL")]
		public OpCode get_rval();
		[CCode(cname = "BPF_SIZE")]
		public OpCode get_size();
		[CCode(cname = "BPF_SRC")]
		public OpCode get_src();
	}

	/**
	 * Error and result codes
	 */
	[CCode(cname = "int", has_type_id = false, cprefix = "PCAP_ERROR_")]
	public enum Result {
		/**
		 * The number of packets requested has been read.
		 *
		 * Occurs if no packets were read from a live capture (if, for example, they were discarded because they didn't pass the packet filter, or if, on platforms that support a read timeout that starts before any packets arrive, the timeout expires before any packets arrive, or if the file descriptor for the capture device is in non-blocking mode and no packets were available to be read) or if no more packets are available in a save file.
		 */
		[CCode(cname = "0")]
		SUCCESS,
		/**
		 * A generic error occurred
		 *
		 * @see Capture.perror
		 * @see Capture.get_error
		 */
		[CCode(cname = "PCAP_ERROR")]
		ERROR,
		/**
		 * The user requested the loop stop.
		 * @see Capture.break_loop
		 */
		BREAK,
		/**
		 * The capture needs to be activated
		 */
		NOT_ACTIVATED,
		/**
		 * The operation can't be performed on already activated captures
		 */
		ACTIVATED,
		/**
		 * No such device exists
		 */
		NO_SUCH_DEVICE,
		/**
		 * This device doesn't support rfmon (monitor) mode
		 */
		RFMON_NOTSUP,
		/**
		 * Operation supported only in monitor mode
		 */
		NOT_RFMON,
		/**
		 * No permission to open the device
		 */
		PERM_DENIED,
		/**
		 * Interface isn't up
		 */
		IFACE_NOT_UP,
		/**
		 * Generic warning code
		 */
		[CCode(cname = "PCAP_WARNING")]
		WARNING,
		/**
		 * This device doesn't support promiscuous mode
		 */
		[CCode(cname = "PCAP_WARNING_PROMISC_NOTSUP")]
		WARNING_PROMISC_NOTSUP;
		[CCode(cname = "0 > ")]
		public bool is_error();
		[CCode(cname = "pcap_statustostr")]
		public unowned string to_string();
	}

	/**
	 * A filter program instruction
	 */
	[CCode(cname = "struct bpf_insn", has_type_id = false, destroy_function = "")]
	public struct instruction {
		OpCode code;
		uint8 jt;
		uint8 jf;
		uint32 k;
		[CCode(cname = "BPF_STMT")]
		public instruction.stmt(OpCode code, uint32 k);
		[CCode(cname = "BPF_JUMP")]
		public instruction.jmp(OpCode code, uint32 k, uint8 jt, uint8 jf);

		/**
		 * Execute the filter program.
		 * @param packet_data the packet contents
		 * @param wirelen the length of the original packet
		 */
		[CCode(cname = "bpf_filter")]
		public uint	filter([CCode(array_length = false)] instruction[] instructions, [CCode(array_length_pos = -1)] uint8[] packet_data, uint wirelen);
		[CCode(cname = "bpf_image")]
		public unowned string to_string(int index);
	}

	/**
	 * A packet filtering program.
	 */
	[CCode(cname = "struct bpf_program", has_type_id = false, destroy_function = "pcap_freecode")]
	public struct program {
		[CCode(cname = "bf_insns", array_length_name = "bf_len")]
		instruction[] instructions;

		/**
		 * Dump program to standard output.
		 */
		[CCode(cname = "bpf_dump")]
		public void	dump(DumpFormat format);
		/**
		 * Compile a program
		 */
		[CCode(cname = "pcap_compile_nopcap")]
		public static Result compile(int snaplen, LinkLayer linktype, out program program, string buf, bool optimize = true, uint32 mask = NETMASK_UNKNOWN);
		/**
		 * Given a header and data for a packet, check whether the packet passes
		 * the filter. Returns the return value of the filter program, which will
		 * be zero if the packet doesn't pass and non-zero if the packet does pass.
		 */
		[CCode(cname = "pcap_offline_filter")]
		public int filter(packet_header header, [CCode(array_length = false)] uint8[] data);
	}

	/**
	 * Generic per-packet information, as supplied by libpcap.
	 */
	[CCode(cname = "struct pcap_pkthdr", has_type_id = false, destroy_function = "")]
	public struct packet_header {
		/**
		 * Time stamp
		 */
		Posix.timeval ts;
		/**
		 * Length of portion present
		 */
		int32 caplen;
		/**
		 * Length this packet (off wire)
		 */
		int32 len;
	}

	/**
	 * Packet capture statistics
	 *
	 * The statistics do not behave the same way on all platforms.
	 */
	[CCode(cname = "pcap_stat")]
	public struct stat {
		/**
		 * Number of packets received
		 *
		 * This might count packets whether they passed any filter set with {@link Capture.set_filter} or not, or it might count only packets that pass the filter. It also might, or might not, count packets dropped because there was no room in the operating system's buffer when they arrived. This might, or might not, count packets not yet read from the operating system and thus not yet seen by the application.
		 */
		[CCode(cname = "ps_recv")]
		uint recv;
		/**
		 * Number of packets dropped
		 *
		 * This is not available on all platforms; it is zero on platforms where it's not available. If packet filtering is done in libpcap, rather than in the operating system, it would count packets that don't pass the filter. This might, or might not, count packets not yet read from the operating system and thus not yet seen by the application.
		 */
		[CCode(cname = "ps_drop")]
		uint drop;
		/**
		 * Drops by interface
		 *
		 * This might, or might not, be implemented; if it's zero, that might mean that no packets were dropped by the interface, or it might mean that the statistic is unavailable, so it should not be treated as an indication that the interface did not drop any packets.
		 */
		[CCode(cname = "ps_ifdrop")]
		uint ifdrop;
	}

	[CCode(cname = "BPF_MAXBUFSIZE")]
	public const int BPF_MAXBUFSIZE;
	[CCode(cname = "BPF_MINBUFSIZE")]
	public const int BPF_MINBUFSIZE;

	/**
	 * The size to allocate for error messages.
	 */
	[CCode(cname = "PCAP_ERRBUF_SIZE")]
	public const int ERRBUF_SIZE;

	/**
	 * Number of scratch memory words (for {@link OpCode.LD}|{@link OpCode.MEM} and {@link OpCode.ST}).
	 */
	[CCode(cname = "BPF_MEMWORDS")]
	public const int MEMWORDS;

	/**
	 * Value to pass to {@link Capture.compile} as the netmask if you don't know what * the netmask is.
	 */
	[CCode(cname = "PCAP_NETMASK_UNKNOWN")]
	public const uint32 NETMASK_UNKNOWN;

	/**
	 * Get the version information for libpcap
	 *
	 * Returns a pointer to a string giving information about the version of the libpcap library being used; note that it contains more information than just a version number.
	 */
	[CCode(cname = "pcap_lib_version")]
	public unowned string get_version();

	/**
	 * Find the default device on which to capture
	 */
	[CCode(cname = "pcap_lookupdev")]
	public string? lookup_dev([CCode(array_length = false)] char[] error_buffer);

	/**
	 * Find the IPv4 network number and netmask for a device
	 */
	[CCode(cname = "pcap_lookupnet")]
	public Result lookup_net(string? device, out uint32 net, out uint32 mask, [CCode(array_length = false)] char[] error_buffer);

	/**
	 * Validate a program
	 */
	[CCode(cname = "bpf_validate")]
	public bool validate(instruction[] instructions);

	/**
	 * A routine to be called to process a packet
	 *
	 * @param header the packet time stamp and lengths
	 * @param packet_data the first {@link packet_header.caplen} bytes of data from the packet.
	 */
	[CCode(cname = "pcap_handler", has_type_id = false, instance_pos = 0)]
	public delegate void Handler(packet_header header, [CCode(array_length = false)] uint8[] packet_data);

	/**
	 * Version number of the current version of the pcap file format.
	 *
	 * This is ''not'' the version number of the libpcap library.
	 * @see get_version
	 */
	namespace FileFormat {
		/**
		 * Major version number of the current version of the pcap file format.
		 * @see Capture.major_version
		 */
		[CCode(cname = "PCAP_VERSION_MAJOR")]
		public const int VERSION_MAJOR;
		/**
		 * Minor version number of the current version of the pcap file format.
		 * @see Capture.minor_version
		 */
		[CCode(cname = "PCAP_VERSION_MINOR")]
		public const int VERSION_MINOR;
	}
	[CCode(cname = "")]
	private void _sink_file(owned
#if POSIX
		Posix.FILE
#else
		GLib.FileStream
#endif
		file);
}
