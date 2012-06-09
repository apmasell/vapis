void main() {
	var f = Posix.open("/bin/ls", Posix.O_RDONLY);
	var d = Elf.Desc.open(f, Elf.Command.READ);
}
