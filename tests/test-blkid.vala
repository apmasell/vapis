using BlkId;
void main() {
	Cache? c;
	Cache.open(out c);
	c.probe_all();
	foreach (var d in c) {
		stdout.printf("%s\n", d.name);
	}

	var devname = "/dev/sda1";
	var pr = Prober.open(devname);
	if (pr == null)
		error("%s: failed to open device", devname);

	pr.partition_filter.enabled = true;
	pr.do_full_probe();

	unowned uint8[] name;
	pr.lookup_value("PTTYPE", out name);
	stdout.printf("%s partition type detected\n", (string)name);
}
