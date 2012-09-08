void main() {
	var fstab = new Mount.Table();
	fstab.parse_fstab();
	var it = new Mount.Iter(Mount.Direction.FORWARD);
	unowned Mount.FileSystem? fs;
	while(fstab.next(it, out fs) == 0) {
		stdout.printf("%s → %s : %s\n", fs.source, fs.target, fs.fstype);
	}
}
