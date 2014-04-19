PCap.Capture? c;
void main() {
	var err = new char[PCap.ERRBUF_SIZE];
	var cap1 = PCap.Capture.create("wlan0", err);
	var cap = PCap.Capture.open_live("wlan0", 0, true, 60, err);
	if (cap == null) {
		stderr.printf("%s\n", (string)err);
		return;
	}
	c = cap;
	stderr.printf("Success\n");
	cap.loop(-1, (header, data) => {
		stdout.printf("Got packet caplen = %d\n", header.caplen);
	});
	var f = FileStream.open("foo", "r");
	if (f == null) return;
	var st = PCap.Capture.open_offline_stream((owned) f, err);
	c = st;
	c = null;
}
