void main() {
	var ctxt = new UDev.Context();
	var e = ctxt.create_enumerate();
	e.add_match_subsystem("net");
	e.scan_devices();
	for(unowned UDev.List d = e.entries; d != null; d = d.next) {
		var path = d.name;
		var dev = ctxt.open_syspath(path);
		//dev = dev.get_parent("pci", "usb_device");
		if (dev == null) {
			stderr.printf("Could not get parent\n");
			return;
		}
		stdout.printf("VID/PID: %s %s\n", dev.attr["idVendor"], dev.attr["idProduct"]);
		stdout.printf("	%s %s\n", dev.attr["manufacturer"], dev.attr["product"]);
		stdout.printf("	serial: %s\n", dev.attr["serial"]);
	}

	var m = ctxt.monitor_from_netlink();

	m.add_match_subsystem_devtype("hidraw");
	m.enable_receiving();

}
