package ca.function3.functors {
	import ca.function3.Applyable;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	public class StopIfLastFrame implements Applyable {
		public function each( o:Object ):void {
			if( !(o is MovieClip) ) return;
			
			var mc:MovieClip = o as MovieClip;
			if( mc.currentFrame == mc.totalFrames )
			{
				mc.stop( );
			}
		}
	}
}
