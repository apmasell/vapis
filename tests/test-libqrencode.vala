void main() {
		QR.Code? q = QR.Code.encode_string("hello, world", 0, QR.ECLevel.L, QR.Mode.EIGHT_BIT, true);
		stdout.printf("Is %snull\n", q == null ? "" : "not ");
		stdout.printf("Width: %d\n", q.width);
		for (var x = 0; x < q.width; x++) {
			for (var y = 0; y < q.width; y++) {
				stdout.putc(q[x, y] ? 'X' : ' ');
			}
			stdout.putc('\n');
		}


		QR.List? l = QR.List.encode_string("hello, world", 0, QR.ECLevel.L, QR.Mode.EIGHT_BIT, true);
		stdout.printf("Is %snull\n", l == null ? "" : "not ");
		stdout.printf("Size: %d\n", l.size);
		for (unowned QR.List? c = l; c != null; c = c.next) {
			stdout.printf("%d\n", c.code.width);
		}
}
