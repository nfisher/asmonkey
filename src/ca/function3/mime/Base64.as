/* ex: set tabstop=2 shiftwidth=2 : */
package ca.function3.mime {

	/**
	 * <p>Encode Example:</p>
	 *
	 * <pre><code>
	 * var encoded_string = Base64.encode( "Aladdin:open sesame" );
	 * trace( encoded_string ); // QWxhZGRpbjpvcGVuIHNlc2FtZQ==
	 * </code></pre>
	 *
	 * <p>Decode Example:</p>
	 *
	 * <pre><code>
	 * var decoded_string = Base64.decode( "QWxhZGRpbjpvcGVuIHNlc2FtZQ==" );
	 * trace( decoded_string ); // Aladdin:open sesame
	 * </code></pre>
	 */
	public class Base64 {
		public static const UPPER_OFFSET:int = 0x41;
		public static const LOWER_OFFSET:int = 0x47;
		public static const DIGIT_OFFSET:int = 0x04;

		public static const UPPERCASE_A:uint = 0x41;
		public static const LOWERCASE_A:uint = 0x61;
		public static const UPPERCASE_Z:uint = 0x5A;
		public static const LOWERCASE_Z:uint = 0x7A;

		public static const ZERO:uint = 0x30;
		public static const NINE:uint = 0x39;

		public static const FORWARD_SLASH:uint = 0x2F;
		public static const FORWARD_SLASH_INDEX:uint = 63;
		public static const PLUS:uint = 0x2B;
		public static const PLUS_INDEX:uint = 62;

		public static const PADDING:uint = 0x3D;
		public static const PADDING_INDEX:uint = 64;

		public static const LINE_LENGTH:int = 76;
		public static const LINE_BREAK:String = '\n';

		public static const QUAD_LENGTH:int = 4;
		public static const TRIBBLE_LENGTH:int = 3;

		private static var _instance:Base64;

		public function Base64() {

		}


		public static function get instance( ):Base64 {
			if( Base64._instance == null )
			{
				Base64._instance = new Base64( );
			}

			return Base64._instance;
		}


		public static function decode( theBase64EncodedString:String ):String {
			var output:String = "";
			if( theBase64EncodedString.length > LINE_LENGTH ) theBase64EncodedString = theBase64EncodedString.replace( new RegExp(LINE_BREAK,'g'), '' ); 
			var len:int = Math.ceil(theBase64EncodedString.length / QUAD_LENGTH);

			for( var i:int = 0; i < len; i++ )
			{
				output += instance.decodeQuad( theBase64EncodedString.substr(i*QUAD_LENGTH,QUAD_LENGTH) );
			}

			return output;
		}


		public static function encode( theInputString:String ):String {
			var output:String = "";
			var len:int = Math.ceil(theInputString.length / TRIBBLE_LENGTH);

			for( var i:int = 0; i < len; i++ )
			{
				output += instance.encodeTribble( theInputString.substr(i*TRIBBLE_LENGTH,TRIBBLE_LENGTH) );
			}

			if( output.length > LINE_LENGTH ) output = instance.addLineBreaks(output);

			return output;
		}


		public function decodeIndex( theCharCode:uint ):uint {
			if( theCharCode >= UPPERCASE_A && theCharCode <= UPPERCASE_Z )
			{
				return theCharCode - UPPER_OFFSET;
			}

			if( theCharCode >= LOWERCASE_A && theCharCode <= LOWERCASE_Z )
			{
				return theCharCode - LOWER_OFFSET
			}

			if( theCharCode >= ZERO && theCharCode <= NINE )
			{
				return theCharCode + DIGIT_OFFSET;
			}

			if( theCharCode == PADDING ) return PADDING_INDEX;

			if( theCharCode == PLUS ) return PLUS_INDEX;

			return FORWARD_SLASH_INDEX;
		}


		public function decodeQuad( theQuad:String ):String {
			var pack0:uint = decodeIndex( theQuad.charCodeAt(0) );
			var pack1:uint = decodeIndex( theQuad.charCodeAt(1) );
			var pack2:uint = decodeIndex( theQuad.charCodeAt(2) );
			var pack3:uint = decodeIndex( theQuad.charCodeAt(3) );

			var tribble0:uint = pack0 << 2 | (pack1 & 0x30) >> 4;
			if( pack2 == PADDING_INDEX ) return String.fromCharCode(tribble0);

			var tribble1:uint = (pack1 & 0x0F) << 4 | (pack2 & 0x3C) >> 2;
			if( pack3 == PADDING_INDEX ) return String.fromCharCode(tribble0,tribble1);

			var tribble2:uint =	(pack2 & 0x03) << 6 | pack3;
			return String.fromCharCode(tribble0,tribble1,tribble2);
		}

		
		public function addLineBreaks( theBlock:String ):String {
			var broken_text:String = "";
			var len:int = Math.ceil(theBlock.length / LINE_LENGTH);
			var last_slice:int = len - 1;

			for( var i:int = 0; i < len; i++ )
			{
				var pos:int = i * LINE_LENGTH;
				broken_text += theBlock.slice(pos, pos + LINE_LENGTH);

				if( i < last_slice ) broken_text += LINE_BREAK;
			}

			return broken_text;
		}


		public function encodeIndex( the6Bit:uint ):String {
			if( the6Bit < 26 ) return String.fromCharCode(the6Bit + UPPER_OFFSET);

			if( the6Bit < 52 ) return String.fromCharCode(the6Bit + LOWER_OFFSET);

			if( the6Bit < 62 ) return String.fromCharCode(the6Bit - DIGIT_OFFSET);

			if( the6Bit == 62 ) return '+';

			return '/';
		}


		public function encodeTribble( theTribble:String ):String {
			var four_pack:String;

			var pack0:uint = (theTribble.charCodeAt(0) & 0xFC) >> 2;
			var pack1:uint = ((theTribble.charCodeAt(0) & 0x03) << 4) |
				((theTribble.charCodeAt(1) & 0xF0) >> 4);
			var pack2:uint = ((theTribble.charCodeAt(1) & 0x0F) << 2) |
				((theTribble.charCodeAt(2) & 0xC0) >> 6);
			var pack3:uint = theTribble.charCodeAt(2) & 0x3F


			four_pack = encodeIndex( pack0 );
			four_pack += encodeIndex( pack1 );
			if( theTribble.length == 1 ) return four_pack + "==";

			four_pack += encodeIndex( pack2 );
			if( theTribble.length == 2 ) return four_pack + "=";

			four_pack += encodeIndex( pack3 );
			return four_pack;
		}
	}
}
