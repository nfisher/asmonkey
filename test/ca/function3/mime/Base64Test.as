package ca.function3.mime {

	import asunit.framework.TestCase;

	public class Base64Test extends TestCase {
		private var base64:Base64;

		public function Base64Test(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			base64 = new Base64();
		}

		override protected function tearDown():void {
			super.tearDown();
			base64 = null;
		}

		public function testInstantiated():void {
			assertTrue("base64 is Base64", base64 is Base64);
		}

		public function testDecodingWithLessThan76CharacterInput():void {
			var expected:String = "Aladdin:open sesame";
			var input_text:String = "QWxhZGRpbjpvcGVuIHNlc2FtZQ==";

			assertEquals( expected, Base64.decode(input_text) );
		}

		public function testDecodingWithMoreThan76CharacterInput():void {
			var expected:String = "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.";
			var input_text:String =
				"TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlz\n" +
				"IHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2Yg\n" +
				"dGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGlu\n" +
				"dWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRo\n" +
				"ZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=";

			assertEquals( expected, Base64.decode(input_text) );
		}

		public function testDecodeIndex():void {
			assertEquals( 0, base64.decodeIndex('A'.charCodeAt(0)) );
			assertEquals( 25, base64.decodeIndex('Z'.charCodeAt(0)) );
			assertEquals( 26, base64.decodeIndex('a'.charCodeAt(0)) );
			assertEquals( 51, base64.decodeIndex('z'.charCodeAt(0)) );
			assertEquals( 52, base64.decodeIndex('0'.charCodeAt(0)) );
			assertEquals( 61, base64.decodeIndex('9'.charCodeAt(0)) );
			assertEquals( 62, base64.decodeIndex('+'.charCodeAt(0)) );
			assertEquals( 63, base64.decodeIndex('/'.charCodeAt(0)) );
		}

		public function testDecodeQuad3Bytes():void {
			assertEquals( "Man", base64.decodeQuad('TWFu') );
		}

		public function testDecodeQuad2Bytes():void {
			assertEquals( 'e.', base64.decodeQuad("ZS4=") );
		}

		public function testDecodeQuad1Byte():void {
			assertEquals( '.', base64.decodeQuad("Lg==") );
		}

		public function testEncodeIndex(): void {
			assertEquals( 'A', base64.encodeIndex(0) );
			assertEquals( 'Z', base64.encodeIndex(25) );
			assertEquals( 'a', base64.encodeIndex(26) );
			assertEquals( 'z', base64.encodeIndex(51) );
			assertEquals( '0', base64.encodeIndex(52) );
			assertEquals( '9', base64.encodeIndex(61) );
			assertEquals( '+', base64.encodeIndex(62) );
			assertEquals( '/', base64.encodeIndex(63) );
		}

		public function testEncodeTribble():void {
			assertEquals( "TWFu", base64.encodeTribble('Man') );
			assertEquals( "Lg==", base64.encodeTribble('.') );
			assertEquals( "ZS4=", base64.encodeTribble('e.') );
		}

		public function testEncodingWithLessThan76CharactersInOutput():void {
			var input_text:String = "Aladdin:open sesame";
			var expected:String = "QWxhZGRpbjpvcGVuIHNlc2FtZQ==";

			assertEquals( expected, Base64.encode(input_text) );
		}

		public function testAddingSingleLineBreak():void {
			var input_text:String = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
			var expected:String = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nAA";

			assertEquals( expected, base64.addLineBreaks(input_text) );
		}

		public function testEncodingWithMoreThan76CharactersInOutput():void {
			var input_text:String = "Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.";
			var expected:String =
				"TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlz\n" +
				"IHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2Yg\n" +
				"dGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGlu\n" +
				"dWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRo\n" +
				"ZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=";

			assertEquals( expected, Base64.encode(input_text) );
		}
	}
}
