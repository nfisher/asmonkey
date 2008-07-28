package {
	import flash.display.Sprite;
	import skins.asmonkeySkin;
	
	public class asmonkey extends Sprite {

		public function asmonkey() {
			addChild(new asmonkeySkin.ProjectSprouts());
			trace("asmonkey instantiated!");
		}
	}
}
