/*
 * Copyright (c) 2014 Yubico AB
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided
 * with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
[CCode (cheader_filename = "u2f-server/u2f-server.h")]
namespace U2F.Server {
	namespace Version {
		[CCode (cname = "U2FS_VERSION_STRING")]
		public const string STRING;
		[CCode (cname = "U2FS_VERSION_NUMBER")]
		public const int NUMBER;
		[CCode (cname = "U2FS_VERSION_MAJOR")]
		public const int MAJOR;
		[CCode (cname = "U2FS_VERSION_MINOR")]
		public const int MINOR;
		[CCode (cname = "U2FS_VERSION_PATCH")]
		public const int PATCH;

		[CCode (cname = "u2fs_check_version")]
		unowned string? check (string req_version = STRING);
	}
	[CCode (cname = "U2FS_CHALLENGE_RAW_LEN")]
	public const int CHALLENGE_RAW_LEN;
	[CCode (cname = "U2FS_CHALLENGE_B64U_LEN")]
	public const int CHALLENGE_B64U_LEN;
	[CCode (cname = "U2FS_PUBLIC_KEY_LEN")]
	public const int PUBLIC_KEY_LEN;
	[CCode (cname = "U2FS_COUNTER_LEN")]
	public const int COUNTER_LEN;

	[CCode (cname = "u2fs_rc", cprefix = "U2FS_")]
	public enum Error {
		OK,
		MEMORY_ERROR,
		JSON_ERROR,
		BASE64_ERROR,
		CRYPTO_ERROR,
		ORIGIN_ERROR,
		CHALLENGE_ERROR,
		SIGNATURE_ERROR,
		FORMAT_ERROR;
		[CCode (cname = "u2fs_strerror_name")]
		public unowned string get_name ();
		[CCode (cname = "u2fs_strerror")]
		public unowned string get_message ();
	}

	[CCode (cname = "u2fs_initflags")]
	[Flags]
	public enum Init {
		U2FS_DEBUG = 1
	}

	[CCode (cname = "u2fs_global_init")]
	public Error init (Init flags);
	[CCode (cname = "u2fs_global_done")]
	public void done ();

	[CCode (cname = "u2fs_ctx_t", free_function = "u2fs_done")]
	[Compact]
	public class Context {

		[CCode (cname = "u2fs_init")]
		public static Error init (out Context? ctx);
		[CCode (cname = "u2fs_set_origin")]
		public Error set_origin (string origin);
		[CCode (cname = "u2fs_set_appid")]
		public Error set_appid (string appid);
		[CCode (cname = "u2fs_set_challenge")]
		public Error set_challenge (string challenge);
		[CCode (cname = "u2fs_set_keyHandle")]
		public Error set_key_handle (string keyHandle);
		[CCode (cname = "u2fs_set_publicKey")]
		public Error set_publicKey (uint8 publicKey[16]);

		[CCode (cname = "u2fs_registration_challenge")]
		public Error registration_challenge (out string? output);
		[CCode (cname = "u2fs_registration_verify")]
		public Error registration_verify (string response, out RegisterResult? output);
		[CCode (cname = "u2fs_authentication_challenge")]
		public Error authentication_challenge (out string? output);

		[CCode (cname = "u2fs_authentication_verify")]
		public Error u2fs_authentication_verify (string response, out AuthResult? output);
	}
	[CCode (cname = "u2fs_reg_res_t", free_function = "u2fs_free_reg_res")]
	[Compact]
	public class RegisterResult {
		public string? key_handle {
			[CCode (cname = "u2fs_get_registration_keyHandle")]
			get;
		}
		public string? public_key {
			[CCode (cname = "u2fs_get_registration_publicKey")]
			get;
		}
	}
	[CCode (cname = "u2fs_auth_res_t", free_function = "u2fs_free_auth_res")]
	public class AuthResult {
		[CCode (cname = "u2fs_get_authentication_result")]
		public Error u2fs_get_authentication_result (out Error verified, out uint32 counter, out uint8 user_presence);
	}
}
