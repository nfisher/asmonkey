package ca.function3.functors {
	import ca.function3.Applyable;
	
	import flash.display.DisplayObject;
	
	public class Accordian implements Applyable {
		public static const LEFT:String = "left";
		public static const RIGHT:String = "right";
		
		private var _next_x:Number = Infinity;
		private var _edge:Number;
		private var _side:String;
		
		/** The Constructor for accordian defaults to anchoring on the left side and
		 * using the current x co-ordinate for the edge of the group.
		 *
		 *	@param theAnchorSide	The side that the group has a fixed anchoring to.
		 *												Valid options include LEFT or RIGHT.
		 *	@param theEdge	
		 */
		public function Accordian( theAnchorSide:String = LEFT, theEdge:Number = Infinity ) {
			_edge = theEdge;
			anchor_side = theAnchorSide;
		}


		/** anchor_side: 
		 *
		 */
		public function set anchor_side( theAnchorSide:String ):void {
			if( theAnchorSide != LEFT && theAnchorSide != RIGHT ) throw Error( "Invalid anchoring position" );
			_side = theAnchorSide;
		}
		
		
		/**
		 *
		 */
		public function each( o:Object ):void {
			var dis:DisplayObject = o as DisplayObject;	

			if( _side == LEFT )
			{
				if( _next_x != Infinity ) dis.x = _next_x;
				else if( _edge != Infinity ) dis.x = _edge;
				
				_next_x = dis.x + dis.width;
				return;
			}
			else
			{
				if( _next_x == Infinity ) _next_x = _edge;
				_next_x = _next_x - dis.width;
				dis.x = _next_x;
				return;
			}
		}
	}
}
