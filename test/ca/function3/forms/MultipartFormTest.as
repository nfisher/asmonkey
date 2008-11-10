package ca.function3.forms {

	import asunit.framework.TestCase;
	import com.adobe.images.PNGEncoder;
	import skins.asmonkeySkin;
	import flash.display.Bitmap;
	import flash.utils.ByteArray;

	public class MultipartFormTest extends TestCase {
		private var instance:MultipartForm;

		public function MultipartFormTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			instance = new MultipartForm();
		}

		override protected function tearDown():void {
			super.tearDown();
			instance = null;
		}

		public function testInstantiated():void {
			assertTrue("instance is MultipartForm", instance is MultipartForm);
		}

		public function testFormData():void {
			var expected:String = 'Content-Disposition: form-data; name="stuff"\r\n' +
														'\r\n' +
														'value\r\n' +
														'--TEST\r\n';
			assertEquals( expected, instance.formData('stuff', 'value', 'TEST') );
		}

		public function testTextData():void {
			var expected:String = 'Content-Disposition: file; name="userfile"; filename="stuff.txt"\r\n' +
														'Content-Type: text/plain\r\n' +
														'\r\n' +
														'value\r\n' +
														'--TEST\r\n';
			assertEquals( expected, instance.textData('stuff.txt', 'value', 'TEST') );
		}

		public function testImageData():void {
			var key:String = 'sprouts.png';
			var png_array:ByteArray = new ByteArray();
			png_array.writeUTFBytes( 'PNG 1b' );
			var expected:String = 'Content-Disposition: file; name="userfile"; filename="sprouts.png"\r\n' +
														'Content-Type: image/png\r\n' +
														'\r\n' +
														'PNG 1b\r\n' +
														'--TEST\r\n';

			var received_bytes:ByteArray = instance.imageData( key, png_array, 'TEST' );
			assertEquals( expected, received_bytes.readUTFBytes(received_bytes.length) );
			assertEquals( expected.length, received_bytes.length );
		}

		public function testSimpleProcessing():void {
			instance['abc'] = 'Hello world';
			// sample from w3.org
			var received_bytes:ByteArray = instance.process( 'Aab03x' );
			var expected:String = '--Aab03x\r\n' +
														'Content-Disposition: form-data; name="abc"\r\n' +
														'\r\n' +
														'Hello world\r\n' +
														'--Aab03x\r\n' +
														'--Aab03x--\r\n';

			assertEquals( expected, received_bytes.readUTFBytes(received_bytes.length) );
			assertEquals( expected.length, received_bytes.length );
		}

		public function testMultipartProcessing():void {
			instance['sprouts.png'] = new ByteArray();
			instance['sprouts.png'].writeUTFBytes( 'PNG 1b' );
			var received_bytes:ByteArray = instance.process( 'Aab03x' );
			var expected:String = '--Aab03x\r\n' +
														'Content-Disposition: file; name="userfile"; filename="sprouts.png"\r\n' +
														'Content-Type: image/png\r\n' +
														'\r\n' +
														'PNG 1b\r\n' +
														'--Aab03x\r\n' +
														'--Aab03x--\r\n';

			assertEquals( expected, received_bytes.readUTFBytes(received_bytes.length) );
			assertEquals( expected.length, received_bytes.length );
		}

		public function testLowerCaseImageMimeType():void {
			var filename:String = 'simple.png';
			var expected:String = 'image/png'
			assertEquals( expected, instance.mimeType(filename) );
		}

		public function testUpperCaseImageMimeType():void {
			var filename:String = 'simple.PNG';
			var expected:String = 'image/png'
			assertEquals( expected, instance.mimeType(filename) );
		}

		public function testFormDataMimeType():void {
			var filename:String = 'nuffin';
			var expected:String = 'formdata';

			assertEquals( expected, instance.mimeType(filename) );
		}
	}
}
