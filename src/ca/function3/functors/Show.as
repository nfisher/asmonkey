package ca.function3.functors {
	import ca.function3.Applyable;
	
	import flash.display.DisplayObject;
	
	public class Show implements Applyable {
		public function each( o:Object ):void {
			DisplayObject(o).visible = true;
		}
	}
}
