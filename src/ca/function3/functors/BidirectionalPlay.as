package ca.function3.functors {
	import ca.function3.Applyable;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	public class BidirectionalPlay implements Applyable {
		private var _end_frame:Number;
		private var _focused_clip:MovieClip;
		
		public function BidirectionalPlay( theEndFrame:Number = Infinity, theFocusedClip:MovieClip = null ) {
			_end_frame = theEndFrame;
			_focused_clip = theFocusedClip;
		}
		
		public function each( o:Object ):void {
			var mc:MovieClip = o as MovieClip;
			var hit:MovieClip = mc;
			var cursorX:Number = mc.stage.mouseX;
			var cursorY:Number = mc.stage.mouseY;
			var is_over:Boolean = hit.hitTestPoint( cursorX, cursorY );

			if( (is_over && (_focused_clip == null)) || (mc === _focused_clip) || ((mc.currentFrame <= _end_frame) && is_over) )
			{
				if( _end_frame == mc.currentFrame ) return;
				mc.nextFrame( );
			}
			else
			{
				mc.prevFrame( );
			}
		}
	}
		
}
