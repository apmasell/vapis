void main() {
	var p = new Pipe.Line.command_args ("true");
	assert(Pipe.run((owned)p) == 0);
	p = new Pipe.Line.command_args ("false");
	assert(Pipe.run((owned)p) != 0);

	p = new Pipe.Line.command_args ("echo", "foo");
	p.want_out = -1;
	assert (p[0].num_args == 2);
	p.start();
	var line = p.read_line();
	assert (line == "foo\n");
	assert (p.wait() == 0);

	p = new Pipe.Line.command_args ("echo", "foo", "bar");
	p.want_out = -1;
	assert (p[0].num_args == 3);
	p.start();
	line = p.read_line();
	assert (line == "foo bar\n");
	assert(p.wait() == 0);

	p = new Pipe.Line();
	p.add_args("echo", "foo");
	p.add_args("sed", "-e", "s/foo/bar/");
	p.want_out = -1;
	p.start();
	line = p.read_line();
	assert (line == "bar\n");
	assert (p.wait() == 0);

	p = new Pipe.Line();
	p.add_args("sh", "-c", "exit 2");
	p.add_args("sh", "-c", "exit 3");
	p.add_args("true");
	p.start();
	int[] statuses;
	assert(p.wait_all(out statuses) == 127);
	assert(statuses.length == 3);
	assert(statuses[0] == 2 * 256);
	assert(statuses[1] == 3 * 256);
	assert(statuses[2] == 0);

	p = new Pipe.Line.command_args ("sh", "-c", "exit $TEST1");
	p[0]["TEST1"] = "10";
	assert(Pipe.run((owned)p) == 10);

	p = new Pipe.Line.command_args ("sh", "-c", "echo $TEST2");
	p[0]["TEST2"] = "foo";
	p.want_out = -1;
	p.start();
	line = p.read_line();
	assert(line == "foo\n");
	p.wait();

	p = new Pipe.Line.command_args("sh", "-c", "echo $TEST2");
	p[0].unset("TEST2");
	p.want_out = -1;
	p.start();
	line = p.read_line();
	assert(line == "\n");
	p.wait();

	p = new Pipe.Line();
	var cmd1 = new Pipe.Command.args ("echo", "foo");
	var cmd2 = new Pipe.Command.args ("echo", "bar");
	var cmd3 = new Pipe.Command.args ("echo", "baz");
	var seq = new Pipe.Command.sequence ("echo*3", cmd1, cmd2, cmd3);
	p.add((owned)seq);
	p.add_args("xargs");
	p.want_out = -1;
	p.start();
	line = p.read_line();
	assert(line == "foo bar baz\n");
	p.wait();
}

