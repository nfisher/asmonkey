package ca.function3.functors {

	import asunit.framework.TestCase;

	public class HideTest extends TestCase {
		private var hide:Hide;

		public function HideTest(methodName:String=null) {
			super(methodName)
		}

		override protected function setUp():void {
			super.setUp();
			hide = new Hide();
		}

		override protected function tearDown():void {
			super.tearDown();
			hide = null;
		}

		public function testInstantiated():void {
			assertTrue("hide is Hide", hide is Hide);
		}
	}
}
