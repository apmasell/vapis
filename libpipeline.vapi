[CCode(cheader_filename = "pipeline.h")]
namespace Pipe {
	[CCode(cname = "pipecmd_function_type")]
	public delegate void Function();
	/**
	 * Functions to run pipelines and handle signals.
	 */
	[CCode(cname = "pipeline_post_fork_fn", has_target = false)]
	public delegate void PostFork();

	/**
	 * Install a post-fork handler.
	 *
	 * This will be run in any child process immediately after it is forked.  For
	 * instance, this may be used for cleaning up application-specific signal
	 * handlers.  Pass null to clear any existing post-fork handler.
	 */
	[CCode(cname = "pipeline_install_post_fork")]
	public void install_post_fork(PostFork? handler);

	/**
	 * Start a pipeline and wait for it to complete.
	 */
	[CCode(cname = "pipeline_run")]
	public int run(owned Pipe.Line pipe_line);


	[CCode(cname = "pipecmd", free_function = "pipecmd_free")]
	[Compact]
	public class Command {
		/**
		 * If set, redirect this command's standard error to /dev/null.  Otherwise,
		 * and by default, pass it through.
		 */
		public bool discard_err {
			[CCode(cname = "pipecmd_discard_err")]
			set;
		}

		/**
		 * The nice(3) value for this command.
		 *
		 * Defaults to 0.  Errors while attempting to set the nice value are
		 * ignored, aside from emitting a debug message.
		 */
		public int nice {
			[CCode(cname = "pipecmd_nice")]
			set;
		}

		/**
		 * The number of arguments to this command.
		 *
		 * Note that this includes the command name as the first argument, so the
		 * command 'echo foo bar' is counted as having three arguments.
		 */
		public int num_args {
			[CCode(cname = "pipecmd_get_nargs")]
			get;
		}
		[CCode(cname = "pipecmd_new")]
		public Command(string name);
		[CCode(cname = "pipecmd_new_argv")]
		public Command.argv(string name, va_list argv);
		[CCode(cname = "pipecmd_new_args")]
		public Command.args(string name, ...);

		/**
		 * Split on whitespace to construct a command and arguments.
		 *
		 * Honours shell-style single-quoting, double-quoting, and backslashes, but
		 * not other shell evil like wildcards, semicolons, or backquotes.
		 */
		[Deprecated]
		[CCode(cname = "pipecmd_new_argstr")]
		public Command.arg_str(string arg_str);
		/**
		 * Construct a new command that calls a given function rather than
		 * executing a process.
		 *
		 * Methods that deal with arguments cannot be used with the command
		 * returned by this function.
		 */
		[CCode(cname = "pipecmd_new_function")]
		public Command.function(string name, [CCode(target_pos = -1)] owned Function func);

		/**
		 * Construct a new command that runs a sequence of commands.
		 *
		 * The commands will be executed in forked children; if any exits non-zero
		 * then it will terminate the sequence, as with "&&" in shell.
		 *
		 * Methods that deal with arguments cannot be used with the command
		 * returned by this function.
		 */
		[CCode(cname = "pipecmd_new_sequence", sentinel = "NULL")]
		public Command.sequence(string name, ...);
		[CCode(cname = "pipecmd_new_sequencev")]
		public Command.sequencev(string name, va_list cmdv);

		/**
		 * Return a new command that just passes data from its input to its output.
		 */
		[CCode(cname = "pipecmd_new_passthrough")]
		public Command.passthrough();

		/**
		 * Return a duplicate of a command.
		 */
		[CCode(cname = "pipecmd_dup")]
		public Command dup();

		/**
		 * Add an argument to a command.
		 */
		[CCode(cname = "pipecmd_arg")]
		public void add_arg(string arg);

		/**
		 * Convenience function to add an argument with printf substitutions.
		 */
		[CCode(cname = "pipecmd_argf")]
		[PrintfFormat]
		public void add_argf(string format, ...);

		[CCode(cname = "pipecmd_argv")]
		public void add_argv(va_list argv);
		[CCode(cname = "pipecmd_args", sentinel = "NULL")]
		public void add_args(...);

		/**
		 * Split on whitespace to add a list of arguments.
		 *
		 * Honours shell-style single-quoting, double-quoting, and backslashes, but
		 * not other shell evil like wildcards, semicolons, or backquotes.
		 */
		[CCode(cname = "pipecmd_argstr")]
		[Deprecated]
		public void add_arg_str(string arg_str);

		/**
		 * Add a command to a sequence.
		 */
		[CCode(cname = "pipecmd_sequence_command")]
		public void append(owned Command child);
		/**
		 * Clear the environment while running this command.
		 *
		 * Note that environment operations work in sequence; if this is followed
		 * by {@link set}, this causes the command to have just a single
		 * environment variable set.
		 */
		[CCode(cname = "pipecmd_clearenv")]
		public void clear();

		/**
		 * Dump a string representation of a command to stream.
		 */
		[CCode(cname = "pipecmd_dump")]
		public void dump(
#if POSIX
		Posix.FILE?
#else
		GLib.FileStream?
#endif
		stream);

		/**
		 * Execute a single command, replacing the current process.
		 *
		 * Never returns, instead exiting non-zero on failure.
		 */
		[NoReturn]
		[CCode(cname = "pipecmd_exec")]
		public void exec();

		/**
		 * Set an environment variable while running this command.
		 */
		[CCode(cname = "pipecmd_setenv")]
		public void set(string name, string value);

		/**
		 * Return a string representation of a command.
		 */
		[CCode(cname = "pipecmd_tostring")]
		public string to_string();

		/**
		 * Unset an environment variable while running this command.
		 */
		[CCode(cname = "pipecmd_unsetenv")]
		public void unset(string name);
	}

	[CCode(cname = "pipeline", free_function = "pipeline_free")]
	[Compact]
	public class Line {
		/**
		 * Ignore SIGINT and SIGQUIT while the pipeline is running, like system().
		 */
		public bool ignore_signals {
			[CCode(cname = "pipeline_ignore_signals")]
			set;
		}

		/**
		 * Set file name to open and use as the input of the whole pipeline.
		 *
		 * This may be more convenient than supplying file descriptors, and
		 * guarantees that the files are opened with the same privileges under
		 * which the pipeline is run.
		 *
		 * Setting this (even with null, which returns to the default of leaving
		 * input as stdin) supersedes any previous setting of {@link want_in}.
		 *
		 * The given file will be opened when the pipeline is started.
		 */
		public string? in_file {
			[CCode(cname = "pipeline_want_infile")]
			set;
		}

		/**
		 * The stream corresponding to input.
		 *
		 * The pipeline must be started.
		 */
		public
#if POSIX
		Posix.FILE?
#else
		GLib.FileStream?
#endif
		input {
			[CCode(cname = "pipeline_get_infile")]
			get;
		}

		/**
		 * The number of commands in this pipeline.
		 */
		public int length {
			[CCode(cname = "pipeline_get_ncommands")]
			get;
		}

		/**
		 * Set file name to open and use as the output of the whole pipeline.
		 *
		 * This may be more convenient than supplying file descriptors, and
		 * guarantees that the files are opened with the same privileges under
		 * which the pipeline is run.
		 *
		 * Setting this (even with null, which returns to the default of leaving
		 * output as stdout) supersedes any previous setting of {@link want_out}.
		 *
		 * The given file will be opened when the pipeline is started. If an output
		 * file does not already exist, it is created (with mode 0666 modified in
		 * the usual way by umask); if it does exist, then it is truncated.
		 */
		public string? out_file {
			[CCode(cname = "pipeline_want_outfile")]
			set;
		}

		/**
		 * The stream corresponding to input.
		 *
		 * The pipeline must be started.
		 */
		public
#if POSIX
		Posix.FILE?
#else
		GLib.FileStream?
#endif
		output {
			[CCode(cname = "pipeline_get_outfile")]
			get;
		}

		/**
		 * The number of bytes of data that can be read using {@link read} or
		 * {@link peek} solely from the peek cache, without having to read from the
		 * pipeline itself (and thus potentially block).
		 */
		public size_t peek_size {
			[CCode(cname = "pipeline_peek_size")]
			get;
		}

		/**
		 * Set file descriptors to use as the input of the whole pipeline.
		 *
		 * If non-negative, used directly as a file descriptor. If negative,
		 * {@link start} will create pipes and store the input writing.  The
		 * default is to leave input and output as stdin unless
		 * {@link in_file} has been set.
		 */
		public int want_in {
			[CCode(cname = "pipeline_want_in")]
			set;
		}
		/**
		 * Set file descriptors to use as the output of the whole pipeline.
		 *
		 * If non-negative, used directly as a file descriptor. If negative,
		 * {@link start} will create pipes and store the output reading.  The
		 * default is to leave output as stdout unless {@link out_file} has been
		 * set.
		 */
		public int want_out {
			[CCode(cname = "pipeline_want_out")]
			set;
		}

		[CCode(cname = "pipeline_new")]
		public Line();

		[CCode(cname = "pipeline_new_commandv")]
		public Line.commandv(owned Command cmd, va_list cmdv);
		[CCode(cname = "pipeline_new_commands", sentinel = "NULL")]
		public Line.commands(owned Command cmd1, ...);

		[CCode(cname = "pipeline_new_command_argv")]
		public Line.command_argv(string name, va_list argv);
		[CCode(cname = "pipeline_new_command_args", sentinel = "NULL")]
		public Line.command_args(string name, ...);

		/**
		 * Joins two pipelines, neither of which are allowed to be started.
		 *
		 * Discards output from this instance, and input from the parameter.
		 */
		[CCode(cname = "pipeline_join")]
		public Line join(Line other);

		/**
		 * Add a command to a pipeline.
		 */
		[CCode(cname = "pipeline_command")]
		public void add(owned Command cmd);

		/**
		 * Construct a new command and add it to a pipeline in one go.
		 */
		[CCode(cname = "pipeline_command_argv")]
		public void add_argv(string name, va_list argv);
		[CCode(cname = "pipeline_command_args", sentinel = "NULL")]
		public void add_args(string name, ...);

		/**
		 * Construct a new command from a shell-quoted string and add it to a
		 * pipeline in one go.
		 * @see Command.Command.arg_str
		 */
		[CCode(cname = "pipeline_command_argstr")]
		[Deprecated]
		public void add_arg_str(string arg_str);

		/**
		 * Convenience functions wrapping pipeline_command().
		 */
		[CCode(cname = "pipeline_commandv")]
		public void add_commandv(va_list cmdv);
		[CCode(cname = "pipeline_commands", sentinel = "NULL")]
		public void add_commands(...);

		/**
		 * Connect the input of one or more sink pipelines to the output of a source
		 * pipeline.
		 *
		 * The source pipeline may be started, but in that case {@link want_out}
		 * must be negative; otherwise, discards {@link want_out} from source. In
		 * any event, discards {@link want_in} from all sinks, none of which are
		 * allowed to be started.
		 *
		 * This is an application-level connection; data may be intercepted between
		 * the pipelines by the program before calling {@link pump}, which sets
		 * data flowing from the source to the sinks. It is primarily useful when
		 * more than one sink pipeline is involved, in which case the pipelines
		 * cannot simply be concatenated into one.
		 */
		[CCode(cname = "pipeline_connect", sentinel = "NULL")]
		public void connect(owned Line sink, ...);

		/**
		 * Dump a string representation to stream.
		 */
		[CCode(cname = "pipeline_dump")]
		public void dump(
#if POSIX
		Posix.FILE?
#else
		GLib.FileStream?
#endif
		stream);

		/**
		 * Get a command from this pipeline, counting from zero
		 * @return null if n is out of range.
		 */
		[CCode(cname = "pipeline_get_command")]
		public unowned Command? get(int n);

		/**
		 * Return the process ID of a command from this pipeline, counting from
		 * zero.
		 *
		 * The pipeline must be started.  Return -1 if n is out of range or if the
		 * command has already exited and been reaped.
		 */
		[CCode(cname = "pipeline_get_pid")]
		public Posix.pid_t get_pid(int n);

		/**
		 * Look ahead in the pipeline's output, returning the data block.
		 * @param len is the number of bytes to read and is updated to the number of bytes read.
		 */
		[CCode(cname = "pipeline_peek", array_length = false)]
		public unowned uint8[] peek(ref size_t len);

		/**
		 * Look ahead in the pipeline's output for a line of data, returning it.
		 *
		 * The starting position of the next read or peek is not affected by this
		 * call.
		 */
		[CCode(cname = "pipeline_peekline")]
		public unowned string? peek_line();

		/**
		 * Pump data among one or more pipelines connected using {@link connect}
		 * until all source pipelines have reached end-of-file and all data has been
		 * written to all sinks (or failed).
		 *
		 * All relevant pipelines must be supplied: that is, no pipeline that has
		 * been connected to a source pipeline may be supplied unless that source
		 * pipeline is also supplied.  Automatically starts all pipelines if they are
		 * not already started, but does not wait for them.
		 */
		[CCode(cname = "pipeline_pump", sentinel = "NULL")]
		public void pump(...);

		/**
		 * Read bytes of data from the pipeline, returning the data block.
		 * @param len is the number of bytes to read and is updated to the number of bytes read.
		 */
		[CCode(cname = "pipeline_read", array_length = false)]
		public unowned uint8[] read(ref size_t len);

		/**
		 * Read a line of data from the pipeline, returning it.
		 */
		[CCode(cname = "pipeline_readline")]
		public unowned string? read_line();

		/**
		 * Set a command in this pipeline, counting from zero.
		 * @return the previous command in that position.
		 */
		[CCode(cname = "pipeline_set_command")]
		public Command? set(int n, owned Command cmd);

		/**
		 * Skip over and discard bytes of data from the peek cache.
		 *
		 * Asserts that enough data is available to skip, so you may want to check
		 * using {@link peek_size} first.
		 */
		[CCode(cname = "pipeline_peek_skip")]
		public void skip(size_t len);

		/**
		 * Start the processes in a pipeline.
		 *
		 * Installs this library's SIGCHLD handler if not already installed. Calls
		 * error(FATAL) on error.
		 */
		[CCode(cname = "pipeline_start")]
		public void start();

		/**
		 * Return a string representation.
		 */
		[CCode(cname = "pipeline_tostring")]
		public string to_string();

		/**
		 * Wait for a pipeline to complete.
		 *
		 * @param statuses The return values similar to the exit status that a shell
		 * would return, with some modifications.
		 * @return If the last command exits with a signal (other than SIGPIPE, which
		 * is considered equivalent to exiting zero), then the return value is 128
		 * plus the signal number; if the last command exits normally but non-zero,
		 * then the return value is its exit status; if any other command exits
		 * non-zero, then the return value is 127; otherwise, the return value is 0.
		 * This means that the return value is only 0 if all commands in the pipeline
		 * exit successfully.
		 */
		[CCode(cname = "pipeline_wait_all")]
		public int wait_all(out int[] statuses);

		/**
		 * Wait for a pipeline to complete and return its combined exit status.
		 * @see wait_all
		 */
		[CCode(cname = "pipeline_wait")]
		public int wait();
	}
}
