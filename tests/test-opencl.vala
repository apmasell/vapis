using OpenCL;
public void foo(CommandQueue queue) {
	uint8[] buffer;
	queue.get_info_auto(CommandQueue.Info.CONTEXT, out buffer);
}

void main() {
}
