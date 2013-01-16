int main(string[] args) {
	int res;
	if (!HidApi.init())
		return -1;

	var dev = HidApi.Info.enumerate(0x0, 0x0);
	for(; dev != null; dev = (owned) dev.next) {
		stdout.printf("Device Found\n  type: %04hx %04hx\n  path: %s\n  serial_number: %s", dev.vendor_id, dev.product_id, dev.path, dev.serial_number_str);
		stdout.printf("\n");
		stdout.printf("  Manufacturer: %s\n", dev.manufacturer);
		stdout.printf("  Product:      %s\n", dev.product);
		stdout.printf("  Release:      %hx\n", dev.release_number);
		stdout.printf("  Interface:    %d\n",  dev.interface_number);
		stdout.printf("\n");
	}

	var handle = HidApi.Device.open(0x0, 0x0, null);
	if (handle == null) {
		stderr.printf("unable to open device\n");
		HidApi.exit();
		return 1;
	}

	stdout.printf("Manufacturer String: %s\n", handle.manufacturer);
	stdout.printf("Product String: %s\n", handle.product);
	stdout.printf("Serial Number String: %s\n", handle.serial_number);
	stdout.printf("Indexed String 1: %s\n", handle[1]);

	handle.set_nonblocking(true);

	uint8 buf[17];
	res = handle.read(buf);

	res = handle.send_feature_report(buf);
	if (res < 0) {
		stderr.printf("Unable to send a feature report: %s\n", handle.error);
	}

	res = handle.get_feature_report(buf);
	if (res < 0) {
		stderr.printf("Unable to get a feature report: %s\n", handle.error);
	} else {
		stdout.printf("Feature Report\n   ");
		for (var i = 0; i < res; i++)
			stdout.printf("%02hhx ", buf[i]);
		stdout.printf("\n");
	}

	res = handle.write(buf);
	if (res < 0) {
		stderr.printf("Unable to write(): %s\n", handle.error);
	}

	res = 0;
	while (res == 0) {
		res = handle.read(buf);
		if (res == 0)
			stderr.printf("Waiting...\n");
		if (res < 0)
			stderr.printf("Unable to read(): %s\n", handle.error);
	}

	stdout.printf("Data read:\n   ");
	for (var i = 0; i < res; i++)
		stdout.printf("%02hhx ", buf[i]);
	stdout.printf("\n");

	handle = null;

	HidApi.exit();
	return 0;
}
