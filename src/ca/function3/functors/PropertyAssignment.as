package ca.function3.functors {
	import ca.function3.Applyable;
	
	import flash.display.DisplayObject;
	
	public class PropertyAssignment implements Applyable {
		private var _properties:Object;
		
		public function PropertyAssignment( theProperties:Object ) {
			_properties = theProperties;
		}
		
		public function each( o:Object ):void {
			for( var p:String in _properties )
			{
				o[p] = _properties[p];
			}
		}
	}
}
