static void PrintEnv(FastCGI.Stream @out, string label, FastCGI.parameters envp)
{
    @out.printf( "%s:<br>\n<pre>\n", label);
    foreach(var s in envp.get_all()) {
        @out.printf("%s\n", s);
    }
    @out.printf( "</pre><p>\n");
}

int main ()
{
    FastCGI.Stream @in;
		FastCGI.Stream @out;
		FastCGI.Stream @err;
    unowned FastCGI.parameters envp;
    int count = 0;

    while (FastCGI.accept(out @in, out @out, out @err, out @envp) >= 0) {
        string contentLength = envp["CONTENT_LENGTH"];

        @out.printf(
           "Content-type: text/html\r\n\r\n<title>FastCGI echo (fcgiapp version)</title><h1>FastCGI echo (fcgiapp version)</h1>\nRequest number %d,  Process ID: %d<p>\n", ++count, 3);

        if (contentLength != null)
           @out.printf("No data from standard input.<p>\n");

        PrintEnv(@out, "Request environment", envp);
    } /* while */

    return 0;
}
