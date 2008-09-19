package ca.function3.group {
	import ca.function3.Applyable;
	import ca.function3.Groupable;
	
	import flash.display.DisplayObjectContainer
	

	/** The Container class is used as a decorator for a DisplayObjectContainer
	 * adding the functionality to iterate over each of the children and apply a
	 * functor.
	 *
	 * @langversion ActionScript 3.0
	 *
	 */
	public class Container implements Groupable {
		private var _container:DisplayObjectContainer;

		
		/** Constructor which throws an ArgumentError if a null container is
		 * specified.
		 *
		 * @param theContainer	The DisplayObjectContainer which has a collection of
		 * 											children you wish to iterate over.
		 *
		 */
		public function Container( theContainer:DisplayObjectContainer ) {
			if( theContainer == null ) throw ArgumentError( "Expected DisplayObjectContainer, received Null." );
			_container = theContainer;
		}
		
		
		/** Applies a specified action to each child in the container from the bottom
		 * up.
		 *
		 * @param f	The functor which is applied to each child.
		 *
		 */
		public function apply( f:Applyable ):void {
			var len:int = _container.numChildren;
			for( var i:int = 0; i < len; i++ )
			{
				f.each( _container.getChildAt(i) );
			}
		}
		
		
		/** Applies a specified action to each child in the container from the top
		 * down.
		 *
		 * @param f	The functor which is applied to each child.
		 *
		 */
		public function reverseApply( f:Applyable ):void {
			var len:int = _container.numChildren - 1;
			for( var i:int = len; i >= 0; i-- )
			{
				f.each( _container.getChildAt(i) );
			}
		}
	}
}
