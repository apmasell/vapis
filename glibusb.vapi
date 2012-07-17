[CCode(cheader_filename = "glibusb.h")]
namespace LibUSB {
	/**
	 * Create a source so that a context can be monitored using {@link GLib.MainLoop}.
	 *
	 * Once created, call {@link GLib.Source.attach} to attach it to a context.
	 */
	[CCode(cname = "glibusb_create_gsource")]
	public GLib.Source create_source(owned Context ctx);

	/**
	 * Initiate a USB control transfer on a device.
	 *
	 * @param dev the device to perform the transfer
	 * @param timeout return if no data has been provided after the specified number of milliseconds
	 * @param buffer the data to transfer
	 * @param actual_length the number of bytes transferred
	 */
	[CCode(cname = "glibusb_control_transfer")]
	public async TransferStatus control_transfer(DeviceHandle dev, uint timeout, uint8[] buffer, out int actual_length);

	/**
	 * Initiate a USB interrupt transfer on a device.
	 *
	 * @param dev the device to perform the transfer
	 * @param endpoint the target on the device
	 * @param timeout return if no data has been provided after the specified number of milliseconds
	 * @param buffer the data to transfer
	 * @param actual_length the number of bytes transferred
	 */
	[CCode(cname = "glibusb_interrupt_transfer")]
	public async TransferStatus interrupt_transfer(DeviceHandle dev, uint8 endpoint, uint timeout, uint8[] buffer, out int actual_length);

	/**
	 * Initiate a USB bulk transfer on a device.
	 *
	 * @param dev the device to perform the transfer
	 * @param endpoint the target on the device
	 * @param timeout return if no data has been provided after the specified number of milliseconds
	 * @param buffer the data to transfer
	 * @param actual_length the number of bytes transferred
	 */
	[CCode(cname = "glibusb_bulk_transfer")]
	public async TransferStatus bulk_transfer(DeviceHandle dev, uint8 endpoint, uint timeout, uint8[] buffer, out int actual_length);
}
