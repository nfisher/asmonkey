package ca.function3.functors {
	import ca.function3.Applyable;
	
	import flash.display.DisplayObject;
	
	public class BulkAssign implements Applyable {
		private var _event:String;
		private var _function:Function;
		
		public function BulkAssign( theEvent:String, theFunction:Function ) {
			_event = theEvent;
			_function = theFunction;
		}
		
		public function each( o:Object ):void {
			if( !(o is DisplayObject) ) return;
			var dis:DisplayObject = o as DisplayObject;
			
			dis.addEventListener( _event, _function );
		}
	}
}
