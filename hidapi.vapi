/**
 * Multi-Platform library for communication with HID devices.
 */
[CCode (cheader_filename = "hidapi.h")]
namespace HidApi {
	[CCode (cname = "hid_device", free_function = "hid_close")]
	[Compact]
	public class Device {

		/**
		 * Open a HID device using a Vendor ID (VID), Product ID (PID) and optionally a serial number.
		 *
		 * @param vendor_id The Vendor ID (VID) of the device to open.
		 * @param product_id The Product ID (PID) of the device to open.
		 * @param serial_number The Serial Number of the device to open.  If null,
		 * the first device with the specified VID and PID is opened.
		 */
		[CCode (cname = "hid_open")]
		public static Device? open (ushort vendor_id, ushort product_id, void* serial_number = null);

		/**
		 * Open a HID device by its path name.
		 *
		 * The path name be determined by calling {@link Info.enumerate}, or a platform-specific path name can be used (e.g., '''/dev/hidraw0''' on Linux).
		 */
		[CCode (cname = "hid_open_path")]
		public static Device? open_path (string path);

		/**
		 * Get a feature report from a HID device.
		 *
		 * Make sure to set the first byte of the data to the Report ID of the
		 * report to be read. Make sure to allow space for this extra byte.
		 *
		 * @param data A buffer to put the read data into, including the Report ID.
		 * Set the first byte of the data[] to the Report ID of the report to be
		 * read. The buffer can be longer than the actual report.
		 *
		 * @return This function returns the number of bytes read and -1 on error.
		 */
		[CCode (cname = "hid_get_feature_report")]
		public int get_feature_report ([CCode (array_length_type = "size_t")] uint8[] data);

		/**
		 * Read an Input report from a HID device.
		 *
		 * Input reports are returned to the host through the INTERRUPT IN
		 * endpoint. The first byte will contain the Report number if the device
		 * uses numbered reports.
		 *
		 * @param data A buffer to put the read data into. For devices with
		 * multiple reports, make sure to read an extra byte for the report
		 * number.
		 *
		 * @return This function returns the actual number of bytes read and -1
		 * on error.
		 */
		[CCode (cname = "hid_read")]
		public int read ([CCode (array_length_type = "size_t")] uint8[] data);

		/**
		 * Read an Input report from a HID device with timeout.
		 *
		 * Input reports are returned to the host through the INTERRUPT IN
		 * endpoint. The first byte will contain the Report number if the device
		 * uses numbered reports.
		 *
		 * @param data A buffer to put the read data into. For devices with
		 * multiple reports, make sure to read an extra byte for the report
		 * number.
		 *
		 * @param milliseconds timeout in milliseconds or -1 for blocking wait.
		 *
		 * @return This function returns the actual number of bytes read and -1
		 * on error.
		 */
		[CCode (cname = "hid_read_timeout")]
		public int read_timeout ([CCode (array_length_type = "size_t")] uint8[] data, int milliseconds);

		/**
		 * Send a Feature report to the device.
		 *
		 * Feature reports are sent over the Control endpoint as a Set_Report
		 * transfer.  The first byte of the data must contain the Report ID. For
		 * devices which only support a single report, this must be set to 0x0. The
		 * remaining bytes contain the report data. Since the Report ID is
		 * mandatory, calls will always contain one more byte than the report
		 * contains. For example, if a HID report is 16 bytes long, 17 bytes must
		 * be passed: the Report ID (or 0x0, for devices which do not use numbered
		 * reports), followed by the report data (16 bytes). In this example, the
		 * length passed in would be 17.
		 *
		 * @param data The data to send, including the report number as the first byte.
		 *
		 * @return This function returns the actual number of bytes written and -1 on error.
		 */
		[CCode (cname = "hid_send_feature_report")]
		public int send_feature_report ([CCode (array_length_type = "size_t")] uint8[] data);

		/**
		 * Set the device handle to be non-blocking.
		 *
		 * In non-blocking mode calls to {@link read} will return immediately with
		 * a value of 0 if there is no data to be read. In blocking mode,
		 * {@link read} will wait (block) until there is data to read before
		 * returning.
		 *
		 * Nonblocking can be turned on and off at any time.
		 */
		[CCode (cname = "!hid_set_nonblocking")]
		public bool set_nonblocking (bool nonblock);

		/**
		 * Write an Output report to a HID device.
		 *
		 * The first byte of data must contain the Report ID. For devices which
		 * only support a single report, this must be set to 0x0. The remaining
		 * bytes contain the report data. Since the Report ID is mandatory, calls
		 * will always contain one more byte than the report contains. For
		 * example, if a HID report is 16 bytes long, 17 bytes must be passed,
		 * the Report ID (or 0x0, for devices with a single report), followed by
		 * the report data (16 bytes). In this example, the length passed in
		 * would be 17.
		 *
		 * The data will be sent on the first OUT endpoint, if one exists. If it
		 * does not, it will send the data through the Control Endpoint (Endpoint
		 * 0).
		 *
		 * @return This function returns the actual number of bytes written and
		 * -1 on error.
		 */
		[CCode (cname = "hid_write")]
		public int write ([CCode (array_length_type = "size_t")] uint8[] data);

		/**
		 * A string describing the last error which occurred.
		 */
		public string? error {
			owned get {
				unowned wchar_t[]? str = get_error ();
				if (str == null) {
					return null;
				}
				uint8[] unistr = new uint8[wcstombs (null, str, 0) + 1];
				wcstombs (unistr, str, unistr.length);
				return ((string) unistr).dup ();
			}
		}
		[CCode (cname = "hid_error", array_length = false)]
		private unowned wchar_t[]? get_error ();

		public string? manufacturer {
			owned get {
				wchar_t str[127];
				if (get_manufacturer_string (str)) {
					uint8[] unistr = new uint8[wcstombs (null, str, 0) + 1];
					wcstombs (unistr, str, unistr.length);
					return ((string) unistr).dup ();
				}
				return null;
			}
		}
		[CCode (cname = "!hid_get_manufacturer_string")]
		private bool get_manufacturer_string ([CCode (array_length_type = "size_t")] wchar_t[] str);

		public string? product {
			owned get {
				wchar_t str[127];
				if (get_product_string (str)) {
					uint8[] unistr = new uint8[wcstombs (null, str, 0) + 1];
					wcstombs (unistr, str, unistr.length);
					return ((string) unistr).dup ();
				}
				return null;
			}
		}
		[CCode (cname = "!hid_get_product_string")]
		private bool get_product_string ([CCode (array_length_type = "size_t")] wchar_t[] str);

		public string? serial_number {
			owned get {
				wchar_t str[127];
				if (get_serial_number_string (str)) {
					uint8[] unistr = new uint8[wcstombs (null, str, 0) + 1];
					wcstombs (unistr, str, unistr.length);
					return ((string) unistr).dup ();
				}
				return null;
			}
		}
		[CCode (cname = "!hid_get_serial_number_string")]
		private bool get_serial_number_string ([CCode (array_length_type = "size_t")] wchar_t[] str);

		/**
		 * Get a string from a HID device, based on its string index.
		 */
		public string? get (int index) {
			wchar_t str[127];
			if (get_indexed_string (index, str)) {
				uint8[] unistr = new uint8[wcstombs (null, str, 0) + 1];
				wcstombs (unistr, str, unistr.length);
				return ((string) unistr).dup ();
			}
			return null;
		}
		[CCode (cname = "!hid_get_indexed_string")]
		private bool get_indexed_string (int index, [CCode (array_length_type = "size_t")] wchar_t[] str);
	}

	[CCode (cname = "struct hid_device_info", free_function = "hid_free_enumeration")]
	[Compact]
	public class Info {
		/**
		 * Platform-specific device path
		 */
		public string? path;
		/**
		 * Device vendor ID
		 */
		public ushort vendor_id;
		/**
		 * Device product ID
		 */
		public ushort product_id;
		/**
		 * Serial number
		 */
		public void* serial_number;
		public string? serial_number_str {
			owned get {
				if (serial_number == null) {
					return null;
				}
				uint8[] unistr = new uint8[wcstombs (null, (wchar_t[])serial_number, 0) + 1];
				wcstombs (unistr, (wchar_t[])serial_number, unistr.length);
				return ((string) unistr).dup ();
			}
		}               /**
		                 * Device release number in binary-coded decimal
		                 *
		                 * Also known as device version number.
		                 */
		public ushort release_number;
		/**
		 * Manufacturer name
		 */
		public string? manufacturer {
			owned get {
				if (manufacturer_string == null) {
					return null;
				}
				uint8[] unistr = new uint8[wcstombs (null, manufacturer_string, 0) + 1];
				wcstombs (unistr, manufacturer_string, unistr.length);
				return ((string) unistr).dup ();
			}
		}
		[CCode (array_length = false)]
		private wchar_t[]? manufacturer_string;
		/**
		 * Product name
		 */
		public string? product {
			owned get {
				if (product_string == null) {
					return null;
				}
				uint8[] unistr = new uint8[wcstombs (null, product_string, 0) + 1];
				wcstombs (unistr, product_string, unistr.length);
				return ((string) unistr).dup ();
			}
		}
		[CCode (array_length = false)]
		private wchar_t[] product_string;
		/**
		 * Usage page for this device/interface (Windows/Mac only).
		 */
		public ushort usage_page;
		/**
		 * Usage for this device/interface (Windows/Mac only).
		 */
		public ushort usage;
		/**
		 * The USB interface which this logical device represents.
		 *
		 * Valid on both Linux implementations in all cases, and valid on the
		 * Windows implementation only if the device contains more than one
		 * interface.
		 */
		public int interface_number;

		public Info? next;
		/**
		 * Enumerate the HID Devices.
		 *
		 * This function returns a linked list of all the HID devices attached to the system which match the provided vendor and product IDs.
		 *
		 * @param vendor_id the vendor ID, or 0 to match any vendor.
		 * @param product_id the product ID, or 0 to match any product.
		 */
		[CCode (cname = "hid_enumerate")]
		public static Info? enumerate (ushort vendor_id = 0, ushort product_id = 0);

		/**
		 * Open the corresponding HID device.
		 */
		public Device? open () {
			return Device.open (this.vendor_id, this.product_id, this.serial_number);
		}
	}

	/**
	 * Initialize the HIDAPI library.
	 *
	 * This function initializes the HIDAPI library. Calling it is not strictly
	 * necessary, as it will be called automatically by {@link Info.enumerate}
	 * and either {@link Device.open} or {@link Device.open_path} functions if it
	 * is needed.  This function should be called at the beginning of execution
	 * however, if there is a chance of HIDAPI handles being opened by different
	 * threads simultaneously.
	 *
	 * @return This function returns true on success and false on error.
	 */
	[CCode (cname = "!hid_init")]
	public bool init ();

	/**
	 * Finalize the HIDAPI library.
	 *
	 * This function frees all of the static data associated with HIDAPI. It
	 * should be called at the end of execution to avoid memory leaks.
	 *
	 * @return This function returns true on success and false on error.
	 */
	[CCode (cname = "!hid_exit")]
	public bool exit ();

	[CCode (cname = "wcstombs", cheader_filename = "stdlib.h")]
	private size_t wcstombs ([CCode (array_length = false)] uint8[]? dest, [CCode (array_length = false)] wchar_t[] src, size_t n);

	[CCode (cname = "wchar_t")]
	[SimpleType]
	private struct wchar_t {}
}
