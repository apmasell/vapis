/*
   Copyright (C) 2013-2015 Yubico AB

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU Lesser General Public License as published by
   the Free Software Foundation; either version 2.1, or (at your option) any
   later version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser
   General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with this program; if not, see <http://www.gnu.org/licenses/>.
 */
[CCode (cheader_filename = "u2f-host/u2f-host.h")]
namespace U2F.Host {

	namespace Version {

		[CCode (cname = "U2FH_VERSION_STRING")]
		public const string STRING;

		[CCode (cname = "U2FH_VERSION_NUMBER")]
		public const int NUMBER;

		[CCode (cname = "U2FH_VERSION_MAJOR")]
		public const int MAJOR;

		[CCode (cname = "U2FH_VERSION_MINOR")]
		public const int MINOR;

		[CCode (cname = "U2FH_VERSION_PATCH")]
		public const int PATCH;

		[CCode (cname = "u2fh_check_version")]
		public unowned string? check_version (string version = STRING);
	}

	[CCode (cname = "u2fh_cmdflags", cprefix = "U2FH_")]
	[Flags]
	public enum Commands
	{
		REQUEST_USER_PRESENCE
	}

	[CCode (cname = "u2fh_rc", cprefix = "U2FH_")]
	public enum Error
	{
		OK,
		MEMORY_ERROR,
		TRANSPORT_ERROR,
		JSON_ERROR,
		BASE64_ERROR,
		NO_U2F_DEVICE,
		AUTHENTICATOR_ERROR;
		[CCode (cname = "u2fh_strerror")]
		public unowned string get_message ();
		[CCode (cname = "u2fh_strerror_name")]
		public unowned string get_name ();
	}
	[CCode (cname = "u2fh_initflags", cprefix = "U2FH_")]
	[Flags]
	public enum Init
	{
		DEBUG
	}

	[CCode (cname = "u2fh_global_init")]
	public Error init (Init flags);
	[CCode (cname = "u2fh_global_done")]
	public void done ();

	[CCode (cname = "u2fh_devs", free_function = "u2fh_devs_done")]
	[Compact]
	public class Devices {

		[CCode (cname = "u2fh_devs_init")]
		public Error init (out Devices? devs);

		[CCode (cname = "u2fh_authenticate")]
		public Error authenticate (string challenge, string origin, out string? response, Commands flags);

		[CCode (cname = "u2fh_devs_discover")]
		public Error discover (out uint max_index);

		public Error get_description (
			uint index, out uint8[] buffer,
			size_t max_len) {
			var len = max_len;
			buffer = new uint8[max_len];
			Error err = _get_description (index, buffer, ref len);
			buffer.length = (int) len;
			return err;
		}

		[CCode (cname = "u2fh_is_alive")]
		public bool is_alive (uint index);

		[CCode (cname = "u2fh_register")]
		public Error register (string challenge, string origin, char** response, Commands flags);

		[CCode (cname = "u2fh_sendrecv")]
		public Error sendrecv (uint index, uint8 cmd, [CCode (array_length_type = "uint16_t")]
				       uint8[] send, [CCode (array_length_type = "uint16_t")]
				       uint8[] recv);

		[CCode (cname = "u2fh_get_device_description")]
		private Error _get_description (uint index, [CCode (array_length = false)] uint8[] buffer, ref size_t len);
	}
}
