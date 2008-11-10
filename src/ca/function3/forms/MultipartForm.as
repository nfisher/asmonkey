package ca.function3.forms {
	
	import flash.utils.ByteArray;

	// TODO: Ensure part boundaries are unique.
	// TODO: Provide more than 1 file upload.

	public dynamic class MultipartForm {
		
		public static const CONTENT_DISPOSITION_FORM_DATA:String = 'Content-Disposition: form-data; name="';
		public static const CONTENT_DISPOSITION_FILE:String = 'Content-Disposition: file; name="userfile"; filename="';
		public static const CONTENT_TYPE:String = 'Content-Type: ';
		public static const CRLF:String = '\r\n';
		public static const BOUNDARY_ASSIGNMENT:String = '; boundary=';
		public static const BOUNDARY_IDENTIFIER:String = '--';
		public static const FORM_DATA:String = 'formdata';
		public static const OCTET_STREAM:String = 'application/octet-stream';
		public static const PLAIN_TEXT:String = 'text/plain';
		public static const MULTIPART_FORM:String = 'multipart/form-data';
		
		public function contentType( theTermination:String ):String {
			return MULTIPART_FORM + BOUNDARY_ASSIGNMENT + theTermination + CRLF;
		}
			
		public function formData( theKey:String, theValue:String, theTermination:String ):String {
			var output:String = CONTENT_DISPOSITION_FORM_DATA + theKey + '"' + CRLF;
			output += CRLF;
			output += theValue + CRLF;
			output += boundary( theTermination ) + CRLF;

			return output;
		}

		public function textData( theKey:String, theValue:String, theTermination:String ):String {
			var output:String = CONTENT_DISPOSITION_FILE + theKey + '"' + CRLF;
			output += CONTENT_TYPE + mimeType(theKey) + CRLF;
			output += CRLF;
			output += theValue + CRLF;
			output += boundary( theTermination ) + CRLF;

			return output;
		}

		public function fileData( theKey:String, theValue:ByteArray, theTermination:String ):String {
			var output_string:String = CONTENT_DISPOSITION_FILE + theKey + '"' + CRLF;

			return output_string;
		}

		public function imageData( theKey:String, theImageData:ByteArray, theTermination:String ):ByteArray {
			theImageData.position = 0;
			var preamble:String = CONTENT_DISPOSITION_FILE + theKey + '"' + CRLF +
									CONTENT_TYPE + mimeType(theKey) + CRLF +
									CRLF;
			var closure:String = CRLF + boundary( theTermination ) + CRLF;

			var output:ByteArray = new ByteArray();
			output.writeUTFBytes( preamble );
			output.writeBytes( theImageData );
			output.writeUTFBytes( closure );
			output.position = 0;

			return output;
		}

		public function mimeType( theFilename:String ):String {
			var file_ext:String = theFilename.replace( /.*\.([a-z]*)$/i, "$1" ).toLowerCase();
			var mime_type:String = '';

			if( file_ext == theFilename.toLowerCase() ) return FORM_DATA;

			switch( file_ext ) {
				case 'jpeg':
					file_ext = 'jpg';
				case 'png':
				case 'jpg':
					mime_type = 'image/' + file_ext;
					break;

				case 'txt':
					mime_type = PLAIN_TEXT;
					break;

				default:
					mime_type = OCTET_STREAM;
			}

			return mime_type;
		}

		public function boundary( theTermination:String ):String {
			return BOUNDARY_IDENTIFIER + theTermination;
		}

		public function eof( theTermination:String ):String {
			return boundary(theTermination) + BOUNDARY_IDENTIFIER;
		}

		public function process( theTermination:String ):ByteArray {
			var payload:ByteArray = new ByteArray();
			var preamble:String = boundary( theTermination ) + CRLF;
			payload.writeUTFBytes( preamble );

			for( var p:String in this ) {
				var mime:String = mimeType(p);
				var current:ByteArray;

				switch( mimeType(p) ) {
					case FORM_DATA:
						current = new ByteArray();
						current.writeUTFBytes( formData(p, this[p] as String, theTermination) );
						break;

					case 'image/png':
					case 'image/jpg':
						current = imageData( p, this[p] as ByteArray, theTermination );
						break;

					default:
						// TODO: Replace by binaryData.
						// current = formData( p, this[p] as String, theTermination );
				}

				payload.writeBytes( current );
			}

			payload.writeUTFBytes( eof(theTermination) + CRLF );
			payload.position = 0;

			return payload;
		}
	}
}
