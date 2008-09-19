package ca.function3.functors {
	import ca.function3.Applyable;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public class PlayFirstFrame implements Applyable {
		public function each( o:Object ):void {
			MovieClip(o).gotoAndPlay( 1 );
		}
	}
}
