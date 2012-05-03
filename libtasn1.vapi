[CCode(cheader_filename = "libtasn1.h>\n#define asn1_element_free(x) asn1_delete_structure(&x)\n#include<libtasn1.h")]
namespace Asn1 {
	/**
	 * Return codes
	 */
	[CCode(cname = "asn1_retCode", cprefix = "ASN1_", has_type_id = false)]
	public enum Code {
		SUCCESS,
		FILE_NOT_FOUND,
		ELEMENT_NOT_FOUND,
		IDENTIFIER_NOT_FOUND,
		DER_ERROR,
		VALUE_NOT_FOUND,
		GENERIC_ERROR,
		VALUE_NOT_VALID,
		TAG_ERROR,
		TAG_IMPLICIT,
		ERROR_TYPE_ANY,
		SYNTAX_ERROR,
		MEM_ERROR,
		MEM_ALLOC_ERROR,
		DER_OVERFLOW,
		NAME_TOO_LONG,
		ARRAY_ERROR,
		ELEMENT_NOT_EMPTY;
		[CCode(cname = "asn1_perror")]
		public void perror();
		[CCode(cname = "asn1_strerror")]
		public unowned string to_string();
	}

	[CCode(cname = "int", cprefix = "ASN1_CLASS_", has_type_id = false)]
	public enum Class {
		UNIVERSAL,
		APPLICATION,
		CONTEXT_SPECIFIC,
		PRIVATE,
		STRUCTURED
	}

	[CCode(cname = "int", cprefix = "ASN1_PRINT_", has_type_id = false)]
	public enum PrintMode {
		NAME,
		NAME_TYPE,
		NAME_TYPE_VALUE,
		ALL
	}

	[CCode(cname = "int", cprefix = "ASN1_TAG_", has_type_id = false)]
	public enum Tag {
		BOOLEAN,
		INTEGER,
		SEQUENCE,
		SET,
		OCTET_STRING,
		BIT_STRING,
		UTCTime,
		GENERALIZEDTime,
		OBJECT_ID,
		ENUMERATED,
		NULL,
		GENERALSTRING
	}

	/**
	 * An ASN1 element
	 */
	[CCode(cname = "node_asn", has_type_id = false)]
	[Compact]
	public class Element {
		public string name;
		[CCode(cname = "value", array_length_cname = "value_len")]
    public uint8[] data;
		/**
		 * The son element
		 */
		public Element? down;
		/**
		 * The brother element
		 */
		public Element? right;
		/**
		 * The next list element
		 */
		public Element? left;

		/**
		 * Fill the structure with values of a DER encoding string.
		 *
		 * The structure must just be created with function
		 * {@link create_element}.  If an error occurs during the decoding
		 * procedure, the element will be null.
		 * @return {@link Code.SUCCESS} if DER encoding OK, {@link Code.ELEMENT_NOT_FOUND} if the supplied element is null, and {@link Code.TAG_ERROR} or {@link Code.DER_ERROR} if the der encoding doesn't match the structure name.
		 */
		[CCode(cname = "asn1_der_decoding")]
		public static Code der_decode(ref Element? element, uint8[] ider, [CCode(array_length = false)] char[]? error_description = null);

		/**
		 * Fill the named element with values of a DER encoding
		 * string.
		 *
		 * The structure must just be created with function {@link create_element}. The DER vector must contain the encoding
		 * string of the whole structure. If an error occurs during the
		 * decoding procedure, the structure is set to null.
		 *
		 * @param structure an ASN1 structure
		 * @param element_name name of the element to fill
		 * @param ider the DER encoding of the whole structure.
		 * @param error_description: null-terminated string contains details when
		 * an error occurred.
		 * @return {@link Code.SUCCESS} if DER encoding OK, {@link Code.ELEMENT_NOT_FOUND}
		 * if the structure is null, and {@link Code.TAG_ERROR} or {@link Code.DER_ERROR}
		 * if the der encoding doesn't match the structure.
		 */
		[CCode(cname = "asn1_der_decoding_element")]
		public static Code der_decode_element(ref Element? structure, string element_name, uint8[] ider, [CCode(array_length = false)] char[]? error_description = null);

		/**
		 * Find the start and end point of an element in a DER encoding string.
		 *
		 * I mean that if you have a der encoding and you have already used the
		 * function {@link der_decode} to fill a structure, it may happen that
		 * you want to find the piece of string concerning an element of the
		 * structure.
		 *
		 * One example is the sequence "tbsCertificate" inside an X509 certificate.
		 *
		 * @param ider the DER encoding.
		 * @param name_element an element of NAME structure.
		 * @param start the position of the first byte of NAME_ELEMENT decoding
		 * @param end the position of the last byte of NAME_ELEMENT decoding
		 * @return {@link Code.SUCCESS} if DER encoding OK, {@link Code.ELEMENT_NOT_FOUND}
		 * if the element of the NAME is not a valid element, {@link Code.TAG_ERROR}
		 * or {@link Code.DER_ERROR} if the der encoding doesn't match the
		 * structure ELEMENT.
		 **/
		[CCode(cname = "asn1_der_decoding_startEnd")]
		public static Code der_decode_start_end(uint8[] ider, string name_element, out int start, out int end);

		/**
		 * Create a deep copy of a element variable.
		 * @param dst Destination element.
		 * @param dst_name Field name in destination element.
		 * @param src_name Field name in source element.
		 */
		[CCode(cname = "asn1_copy_node", instance = 2.1)]
		public Code copy_element(Element dst, string dst_name, string src_name);

		/**
		 * Deletes the element in the structure by name.
		 */
		[CCode(cname = "asn1_delete_element")]
		public Code delete_element(string element_name);

		/**
		 * Creates a new structure.
		 *
		 * Use this only on a definitions structure.
		 *
		 * The element must be from a definitions structure returned by "parser_asn1" function.
		 * @param source_name: the name of the type of the new structure (must be inside p_structure).
		 */
		[CCode(cname = "asn1_create_element")]
		public Code create_element(string source_name, ref Element? element);

		[CCode(cname = "asn1_der_coding")]
		private Code _der_coding (string name, [CCode(array_length = false)] uint8[] ider, ref int len, [CCode(array_length = false)] char[] error_description);
		/**
		 * Creates the DER encoding for a sub-structure.
		 *
		 * @param name the name of the structure you want to encode
		 * @param ider array that will contain the DER encoding.
		 * @param len number of bytes to allocate for the output
		 * @param error_description return the error description or an empty string if success.
		 */
		public Code der_encode(string name, out uint8[] ider, int len, out string error_description) {
			var temp = new uint8[len];
			var err_buf = new char[MAX_ERROR_DESCRIPTION_SIZE];
			Code c = _der_coding(name, temp, ref len, err_buf);
			error_description = ((string) err_buf).dup();
			temp.length = len;
			ider = temp;
			return c;
		}

		/**
		 * Expands every "ANY DEFINED BY" element of a structure created from a DER
		 * decoding process ({@link der_decode} function).
		 *
		 * Use this only on a definitions structure.
		 *
		 * The element ANY must be defined by an OBJECT IDENTIFIER. The type used
		 * to expand the element ANY is the first one following the definition of
		 * the actual value of the OBJECT IDENTIFIER.
		 *
		 * @return {@link Code.SUCCESS} if Substitution OK, {@link Code.ERROR_TYPE_ANY}
		 * if some "ANY DEFINED BY" element couldn't be expanded due to a problem
		 * in OBJECT_ID → TYPE association, or other error codes depending on DER
		 * decoding.
		 */
		[CCode(cname = "asn1_expand_any_defined_by")]
		public Code expand_any_defined_by(ref Element element);

		/**
		 * Expands an "OCTET STRING" element of a structure created from a DER
		 * decoding process (the {@link der_decode} function).
		 *
		 * Use this only on a definitions structure.
		 *
		 * The type used for expansion is the first one following the definition of
		 * the actual value of the OBJECT IDENTIFIER indicated by OBJECTNAME.
		 *
		 * @return {@link Code.SUCCESS} if substitution OK, {@link Code.ELEMENT_NOT_FOUND}
		 * if the object name or octet name are not correct, {@link Code.VALUE_NOT_VALID}
		 * if it wasn't possible to find the type to use for expansion, or other
		 * errors depending on DER decoding.
		 *
		 * @param octet_name name of the OCTECT STRING field to expand.
		 * @param object_name name of the OBJECT IDENTIFIER field to use to define the type for expansion.
		 */
		[CCode(cname = "asn1_expand_octet_string")]
		public Code expand_octet_string(ref Element? element, string octet_name, string object_name);

		/**
		 * Searches for an element with a given name.
		 *
		 * The name is composed by differents identifiers separated by dots. When
		 * the element has a name, the first identifier must be the name of
		 * the element, otherwise it must be the name of one child of the node.
		 */
		[CCode(cname = "asn1_find_node")]
		public unowned Element find_node(string name);

		/**
		 * Search the structure that is defined just after an OID definition.
		 *
		 * Use this only on a definitions structure.
		 *
		 * @param oid the OID to search (e.g. "1.2.3.4").
		 * @return null when the OID is not found, otherwise the a string that contains the element name defined just after the OID.
		 **/
		[CCode(cname = "asn1_find_structure_from_oid")]
		public unowned string? find_structure_from_oid(string oid);

		/**
		 * Counts the number of elements of a sub-structure.
		 * @param name name of substructure with names equal to "?1","?2", ...
		 */
		[CCode(cname = "asn1_number_of_elements")]
		public Code get_element_count(string name, out int num);

		/**
		 * Prints on the file descriptor the structure's tree.
		 */
		[CCode(cname = "asn1_print_structure", instance_pos = 1.1)]
		public void print_structure(
#if POSIX
		Posix.FILE
#else
		GLib.FileStream
#endif
		file, string name, PrintMode mode);

		[CCode(cname = "asn1_read_value")]
		private Code _read_value(string name, [CCode(array_length = false)] uint8[] buffer, ref int len);
		/**
		 * Reads the value of one element inside a structure.
		 */
		public Code read_value(string name, out uint8[] buffer, int len) {
			var temp = new uint8[len];
			Code c = _read_value(name, temp, ref len);
			temp.length = len;
			buffer = temp;
			return c;
		}

		[CCode(cname = "asn1_read_tag")]
		public Code read_tag(string name, out Tag tag_value, out Class class_value);

		/**
		 * Set the value of one element inside a structure.
		 *
		 * If an element is OPTIONAL and you want to delete it, you must use
		 * a null value.  Using "pkix.asn":
		 *
		 * result=asn1_write_value(cert, "tbsCertificate.issuerUniqueID",
		 * NULL, 0);
		 *
		 * Description for each type:
		 *
		 * INTEGER: VALUE must contain a two's complement form integer.
		 *
		 *            value[0]=0xFF ,               len=1 -> integer=-1.
		 *            value[0]=0xFF value[1]=0xFF , len=2 -> integer=-1.
		 *            value[0]=0x01 ,               len=1 -> integer= 1.
		 *            value[0]=0x00 value[1]=0x01 , len=2 -> integer= 1.
		 *            value="123"                 , len=0 -> integer= 123.
		 *
		 * ENUMERATED: As INTEGER (but only with not negative numbers).
		 *
		 * BOOLEAN: VALUE must be the null terminated string "TRUE" or "FALSE" and
		 * LEN != 0.
		 *
		 *            value="TRUE" , len=1 -> boolean=TRUE.
		 *            value="FALSE" , len=1 -> boolean=FALSE.
		 *
		 * OBJECT IDENTIFIER: VALUE must be a null terminated string with each
		 * number separated by a dot (e.g. "1.2.3.543.1").  LEN != 0.
		 *
		 *            value="1 2 840 10040 4 3" , len=1 -> OID=dsa-with-sha.
		 *
		 * UTCTime: VALUE must be a null terminated string in one of these formats:
		 * "YYMMDDhhmmssZ", "YYMMDDhhmmssZ", "YYMMDDhhmmss+hh'mm'",
		 * "YYMMDDhhmmss-hh'mm'", "YYMMDDhhmm+hh'mm'", or "YYMMDDhhmm-hh'mm'".  LEN
		 * != 0.
		 *
		 *            value="9801011200Z" , len=1 -> time=Jannuary 1st, 1998
		 *            at 12h 00m Greenwich Mean Time
		 *
		 * GeneralizedTime: VALUE must be in one of this format:
		 * "YYYYMMDDhhmmss.sZ", "YYYYMMDDhhmmss.sZ", "YYYYMMDDhhmmss.s+hh'mm'",
		 * "YYYYMMDDhhmmss.s-hh'mm'", "YYYYMMDDhhmm+hh'mm'", or
		 * "YYYYMMDDhhmm-hh'mm'" where ss.s indicates the seconds with any
		 * precision like "10.1" or "01.02".  LEN != 0
		 *
		 *            value="2001010112001.12-0700" , len=1 -> time=Jannuary
		 *            1st, 2001 at 12h 00m 01.12s Pacific Daylight Time
		 *
		 * OCTET STRING: VALUE contains the octet string and LEN is the number of
		 * octets.
		 *
		 *            value="$\backslash$x01$\backslash$x02$\backslash$x03" ,
		 *            len=3 -> three bytes octet string
		 *
		 * GeneralString: VALUE contains the generalstring and LEN is the number of
		 * octets.
		 *
		 *            value="$\backslash$x01$\backslash$x02$\backslash$x03" ,
		 *            len=3 -> three bytes generalstring
		 *
		 * BIT STRING: VALUE contains the bit string organized by bytes and LEN is
		 * the number of bits.
		 *
		 *   value="$\backslash$xCF" , len=6 -> bit string="110011" (six
		 *   bits)
		 *
		 * CHOICE: if NAME indicates a choice type, VALUE must specify one of the
		 * alternatives with a null terminated string. LEN != 0. Using "pkix.asn":
		 *
		 *           result=asn1_write_value(cert,
		 *           "certificate1.tbsCertificate.subject", "rdnSequence",
		 *           1);
		 *
		 * ANY: VALUE indicates the der encoding of a structure.  LEN != 0.
		 *
		 * SEQUENCE OF: VALUE must be the null terminated string "NEW" and LEN !=
		 * 0. With this instruction another element is appended in the sequence.
		 * The name of this element will be "?1" if it's the first one, "?2" for
		 * the second and so on.
		 *
		 *   Using "pkix.asn"\:
		 *
		 *   result=asn1_write_value(cert,
		 *   "certificate1.tbsCertificate.subject.rdnSequence", "NEW", 1);
		 *
		 * SET OF: the same as SEQUENCE OF.  Using "pkix.asn":
		 *
		 *           result=asn1_write_value(cert,
		 *           "tbsCertificate.subject.rdnSequence.?LAST", "NEW", 1);
		 *
		 * @param name: the name of the element inside the structure that you want to set.
		 * @param ivalue: vector used to specify the value to set.
		 */
		[CCode(cname = "asn1_write_value")]
		public Code write_value(string name, uint8[]? ivalue);

		/**
		 * Set the value of one element inside a structure.
		 * @see write_value
		 */
		[CCode(cname = "asn1_write_value")]
		public Code write_value_str(string name, string ivalue, int length = 0);
  }

  /**
	 * For the on-disk format of ASN.1 trees
	 */
	[CCode(cname = "ASN1_ARRAY_TYPE", has_type_id = false, destroy_function = "")]
  public struct decl {
		public string name;
    uint type;
		[CCode(array_length = false)]
    uint8[] @value;
  }

  /**
	 * Maximum number of characters of a name inside a file with ASN1 definitons
	 */
	[CCode(cname = "ASN1_MAX_NAME_SIZE")]
	public const int MAX_NAME_SIZE;

  /**
	 * Maximum number of characters of a description message
	 *
   * Null character included.
	 */
	[CCode(cname = "ASN1_MAX_ERROR_DESCRIPTION_SIZE")]
	public const int MAX_ERROR_DESCRIPTION_SIZE;

	[CCode(cname = "ASN1_VERSION")]
	public const string VERSION;

	/**
	 * Creates the structures needed to manage the ASN.1 definitions.
	 *
	 * @return {@link Code.SUCCESS} if structure was created correctly,
	 * {@link Code.IDENTIFIER_NOT_FOUND} if in the file there is an identifier
	 * that is not defined (see //error_description// for more information),
	 * {@link Code.ARRAY_ERROR} if the array is wrong.
	 */
	[CCode(cname = "asn1_array2tree")]
	public Code array2tree([CCode(array_length = false)] decl[] array, out Element definitions, [CCode(array_length = false)] char[]? error_description = null);

	/**
	 * Check that the version of the library is at minimum the requested one and
	 * return the version string
	 *
	 * @param req_version If null, no check is done, but the version string is simply returned.
	 * @return Version string of run-time library, null if the condition is not satisfied.
	 */
	[CCode(cname = "asn1_check_version")]
	public unowned string? check_version (string? req_version);

	/**
	 * Function that generates a C structure from an ASN1 file.
	 *
	 * Creates a file containing a C vector to use to manage the definitions
	 * @param output_file_name If null, the file created is "/aa/bb/xx_asn1_tab.c" given the input file was "/aa/bb/xx.yy".
	 * @param vector_name If null the vector name * will be "xx_asn1_tab" given the input file was "/aa/bb/xx.yy".
	 *
	 * @param input_file_name the path and the name of file that contains ASN.1 declarations.
	 * @param output_file_name the path and the name of file that will   contain the C vector definition.
	 * @param vector_name the name of the C vector.
	 * @param error_description error description or an empty string if success.
	 *
	 * @return {@link Code.SUCCESS} if the file has a correct syntax and every
	 * identifier is known, {@link Code.FILE_NOT_FOUND} if an error occured while
	 * opening the input file, {@link Code.SYNTAX_ERROR} if the syntax is not
	 * correct, {@link Code.IDENTIFIER_NOT_FOUND} if in the file there is an
	 * identifier that is not defined, {@link Code.NAME_TOO_LONG} if in the file
	 * there is an identifier whith more than {@link MAX_NAME_SIZE} characters.
	 */
	[CCode(cname = "asn1_parser2array")]
	public Code parser2array(string input_file_name, string? output_file_name, string? vector_name, [CCode(array_length = false)] char[]? error_description = null);

	/**
	 * Creates the structures needed to manage the definitions included in a file.
	 *
	 * @param file_name specify the path and the name of file that contains ASN.1 declarations.
	 * @param definitions the structure created from "file_name" ASN.1 declarations.
	 * @param error_description return the error description or an empty string if success.
	 * @return {@link Code.SUCCESS} if the file has a correct syntax and every
	 * identifier is known, {@link Code.FILE_NOT_FOUND} if an error occured while
	 * opening the file, {@link Code.SYNTAX_ERROR} if the syntax is not correct,
	 * {@link Code.IDENTIFIER_NOT_FOUND} if in the file there is an identifier
	 * that is not defined, {@link Code.NAME_TOO_LONG} if in the file there is an
	 * identifier whith more than {@link MAX_NAME_SIZE} characters.
	 */
	[CCode(cname = "asn1_parser2tree")]
	public Code parser2tree(string file_name, out Element? definitions, [CCode(array_length = false)] char[]? error_description = null);

  /**
	 * DER utility functions
	 */
	namespace DER {
		/**
		 * Creates the DER coding for a BIT STRING type (length and pad included).
		 */
		[CCode(cname = "asn1_bit_der")]
		public void bit_der(uint8[] str, [CCode(array_length = false)] uint8[] der, out int der_len);

		/**
		 * Extract a BIT SEQUENCE from DER data.
		 */
		[CCode(cname = "asn1_get_bit_der")]
		public Code get_bit_der(uint8[] der, out int ret_len, uint8[] str, out int bit_len);

		/**
		 * Extract a length field from BER data.
		 *
		 * The difference to {@link get_length_der} is that this function will
		 * return a length even if the value has indefinite encoding.
		 *
		 * @return the decoded length value, or negative value when the value was
		 * too big.
		 */
		[CCode(cname = "asn1_get_length_ber")]
		public long get_length_ber(uint8[] ber, out int len);

		/**
		 * Extract a length field from DER data.
		 *
		 * @return the decoded length value, or -1 on indefinite length, or -2
		 * when the value was too big to fit in a int, or -4 when the decoded
		 * length value plus //len// would exceed the input length.
		 */
		[CCode(cname = "asn1_get_length_der")]
		public long get_length_der (uint8[] der, out int len);

		/**
		 * Extract an OCTET SEQUENCE from DER data.
		 */
		[CCode(cname = "asn1_get_octet_der")]
		public Code get_octet_der(uint8[] der, out int ret_len, uint8[] str, out int str_len);

		/**
		 * Decode the class and TAG from DER code.
		 */
		[CCode(cname = "asn1_get_tag_der")]
		public int get_tag_der (uint8[] der, out uint8 cls, out int len, out ulong tag);

		/**
		 * Creates the DER coding for the LEN parameter (only the length).
		 *
		 * @param ans buffer is pre-allocated and must have room for the output.
		 */
		[CCode(cname = "asn1_length_der")]
		public void length_der(ulong len, [CCode(array_length = false)] uint8[] ans, out int ans_len);

		/**
		 * Creates the DER coding for an OCTET type (length included).
		 */
		[CCode(cname = "asn1_octet_der")]
		public void octet_der(uint8[] str, [CCode(array_length = false)] uint8[] der, out int der_len);
	}
}
