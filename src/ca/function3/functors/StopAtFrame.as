package ca.function3.functors {
	import ca.function3.Applyable;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public class StopAtFrame implements Applyable {
		private var _end_frame:Number;
		public static const LAST_FRAME:Number = Infinity;
		
		public function StopAtFrame( theEndFrame:Number = LAST_FRAME ) {
			_end_frame = theEndFrame;
		}
		
		public function each( o:Object ):void {
				var mc:MovieClip = MovieClip(o);
				var dest:Number = (_end_frame == Infinity) ? mc.totalFrames : _end_frame;
				
				mc.gotoAndStop( dest );
		}
	}
}
