void main() {
	int a = 1;
	int b = 2;

	stdout.printf("%d %d\n", a, b);
	swap(ref a, ref b);
	stdout.printf("%d %d\n", a, b);
	double x = 1.1;
	double y = 2.1;

	stdout.printf("%f %f\n", x, y);
	swap(ref x, ref y);
	stdout.printf("%f %f\n", x, y);
}
