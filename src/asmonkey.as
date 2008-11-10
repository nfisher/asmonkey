package {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import skins.asmonkeySkin;
	
	public class asmonkey extends Sprite {

		public function asmonkey() {
			addChild(new asmonkeySkin.ProjectSprouts() as DisplayObject);
			trace("asmonkey instantiated!");
		}
	}
}
