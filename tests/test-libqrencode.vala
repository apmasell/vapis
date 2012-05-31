void main() {
		QR.Code? x = QR.Code.encode_string("hello, world", 0, QR.ECLevel.L, QR.Mode.EIGHT_BIT, true);
		stdout.printf("Is %snull\n", x == null ? "" : "not ");
		stdout.printf("Width: %d\n", x.width);

		QR.List? l = QR.List.encode_string("hello, world", 0, QR.ECLevel.L, QR.Mode.EIGHT_BIT, true);
		stdout.printf("Is %snull\n", l == null ? "" : "not ");
		stdout.printf("Size: %d\n", l.size);
		for (unowned QR.List? c = l; c != null; c = c.next) {
			stdout.printf("%d\n", c.code.width);
		}
}
