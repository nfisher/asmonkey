package {
	/**
	 * This file has been automatically created using
	 * #!/usr/bin/ruby script/generate suite
	 * If you modify it and run this script, your
	 * modifications will be lost!
	 */

	import asunit.framework.TestSuite;
	import ca.function3.functors.HideTest;
	import ca.function3.mime.Base64Test;

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new ca.function3.functors.HideTest());
			addTest(new ca.function3.mime.Base64Test());
		}
	}
}
