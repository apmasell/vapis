/*
 * Sample showing how to do SSH2 connect.
 *
 * The sample code has default values for host name, user name, password
 * and path to copy, but you can specify them on the command line like:
 *
 * "ssh2 host user password [-p|-i|-k]"
 */
string keyfile1;
string keyfile2;
string username;
string password;


void kbd_callback(uint8[] name, uint8[]instruction,
                         SSH2.keyboard_prompt[] prompts,
                         SSH2.keyboard_response[] responses,
                         ref bool b)
{
    if (prompts.length == 1) {
        responses[0].text = password.data;
    }
}


int main(string[] args)
{
    string home=GLib.Environment.get_home_dir();
    keyfile1=home+"/.ssh/id_rsa.pub";
    keyfile2=home+"/.ssh/id_rsa";
    username="username";
    password="password";

    uint32 hostaddr;
    if (args.length > 1) {
        hostaddr = Posix.inet_addr(args[1]);
    } else {
        hostaddr = Posix.htonl(0x7F000001);
    }

    if(args.length > 2) {
        username = args[2];
    }
    if(args.length > 3) {
        password = args[3];
    }

    var rc = SSH2.init (0);
    if (rc != SSH2.Error.NONE) {
        stdout.printf ("libssh2 initialization failed (%d)\n", rc);
        return 1;
    }

    /* Ultra basic "connect to port 22 on localhost".  Your code is
     * responsible for creating the socket establishing the connection
     */
    var sock = Posix.socket(Posix.AF_INET, Posix.SOCK_STREAM, 0);

    Posix.SockAddrIn sin = Posix.SockAddrIn();
    sin.sin_family = Posix.AF_INET;
    sin.sin_port = Posix.htons(22);
    sin.sin_addr.s_addr = hostaddr;
    if (Posix.connect(sock, &sin,
                sizeof(Posix.SockAddrIn)) != 0) {
        stderr.printf("failed to connect!\n");
        return -1;
    }

    /* Create a session instance and start it up. This will trade welcome
     * banners, exchange keys, and setup crypto, compression, and MAC layers
     */
    var session = SSH2.Session.create<bool>();
    if (session.handshake(sock) != SSH2.Error.NONE) {
        stderr.printf("Failure establishing SSH session\n");
        return -1;
    }

    /* At this point we havn't authenticated. The first thing to do is check
     * the hostkey's fingerprint against our known hosts Your app may have it
     * hard coded, may go to a file, may present it to the user, that's your
     * call
     */
    var fingerprint = session.get_host_key_hash(SSH2.HashType.SHA1);
    stdout.printf("Fingerprint: ");
    for(var i = 0; i < 20; i++) {
        stdout.printf("%02X ", fingerprint[i]);
    }
    stdout.printf("\n");

    /* check what authentication methods are available */
    int auth_pw = 0;
    var userauthlist = session.list_authentication(username.data);
    stdout.printf("Authentication methods: %s\n", userauthlist);
    if ( "password" in userauthlist) {
        auth_pw |= 1;
    }
    if ( "keyboard-interactive" in userauthlist) {
        auth_pw |= 2;
    }
    if ( "publickey" in userauthlist) {
        auth_pw |= 4;
    }

    /* if we got an 4. argument we set this option if supported */
    if(args.length > 4) {
        if ((auth_pw & 1) != 0 && args[4] == "-p") {
            auth_pw = 1;
        }
        if ((auth_pw & 2)  != 0&& args[4] == "-i") {
            auth_pw = 2;
        }
        if ((auth_pw & 4) != 0 && args[4] == "-k") {
            auth_pw = 4;
        }
    }

    if ((auth_pw & 1)!=0) {
        /* We could authenticate via password */
        if (session.auth_password(username, password) != SSH2.Error.NONE) {
            stdout.printf("\tAuthentication by password failed!\n");
            session.disconnect( "Normal Shutdown, Thank you for playing");
            session = null;
            Posix.close(sock);
            return 1;
        } else {
            stdout.printf("\tAuthentication by password succeeded.\n");
        }
    } else if ((auth_pw & 2) != 0) {
        /* Or via keyboard-interactive */
        if (session.auth_keyboard_interactive(username, (SSH2.Session.KeyboardInteractiveHandler<bool>)kbd_callback)  != SSH2.Error.NONE) {
            stdout.printf("\tAuthentication by keyboard-interactive failed!\n");
            session.disconnect( "Normal Shutdown, Thank you for playing");
            session = null;
            Posix.close(sock);
            return 1;
        } else {
            stdout.printf("\tAuthentication by keyboard-interactive succeeded.\n");
        }
    } else if ((auth_pw & 4)!=0) {
        /* Or by public key */
        if (session.auth_publickey_from_file(username, keyfile1, keyfile2, password) != SSH2.Error.NONE) {
            stdout.printf("\tAuthentication by public key failed!\n");
            session.disconnect( "Normal Shutdown, Thank you for playing");
            session = null;
            Posix.close(sock);
            return 1;
        } else {
            stdout.printf("\tAuthentication by public key succeeded.\n");
        }
    } else {
        stdout.printf("No supported authentication methods found!\n");
        session.disconnect( "Normal Shutdown, Thank you for playing");
        session = null;
        Posix.close(sock); return 1;
    }

    /* Request a shell */
    SSH2.Channel? channel = null;
    if (session.authenticated && (channel = session.open_channel()) == null) {
        stderr.printf("Unable to open a session\n");
    } else {

        /* Some environment variables may be set,
         * It's up to the server which ones it'll allow though
         */
        channel.set_env("FOO", "bar");

        /* Request a terminal with 'vanilla' terminal emulation
         * See /etc/termcap for more options
         */
        if (channel.request_pty("vanilla".data) != SSH2.Error.NONE) {
           stderr.printf("Failed requesting pty\n");
           session.disconnect( "Normal Shutdown, Thank you for playing");
           session = null;
           Posix.close(sock);
        }

        /* Open a SHELL on that pty */
        if (channel.start_shell() != SSH2.Error.NONE) {
           stderr.printf("Unable to request shell on allocated pty\n");
           session.disconnect( "Normal Shutdown, Thank you for playing");
           session = null;
           Posix.close(sock);
        }

        /* At this point the shell can be interacted with using
         * libssh2_channel_read()
         * libssh2_channel_read_stderr()
         * libssh2_channel_write()
         * libssh2_channel_write_stderr()
         *
         * Blocking mode may be (en|dis)abled with: libssh2_channel_set_blocking()
         * If the server send EOF, libssh2_channel_eof() will return non-0
         * To send EOF to the server use: libssh2_channel_send_eof()
         * A channel can be closed with: libssh2_channel_close()
         * A channel can be freed with: libssh2_channel_free()
         */

        channel = null;
    }
    /* Other channel types are supported via:
     * libssh2_scp_send()
     * libssh2_scp_recv()
     * libssh2_channel_direct_tcpip()
     */

    session.disconnect( "Normal Shutdown, Thank you for playing");
    session = null;
    Posix.close(sock);
    stdout.printf("all done!\n");

    SSH2.exit();

    return 0;
}
