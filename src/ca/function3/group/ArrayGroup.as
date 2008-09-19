package ca.function3.group {
	import ca.function3.Applyable;
	import ca.function3.Groupable;
	

	/** The ArrayGroup class is used to hold an Array set adding the functionality
	 * to iterate over each of the children and apply a functor.
	 *
	 * @langversion ActionScript 3.0
	 *
	 */
	public class ArrayGroup implements Groupable {
		private var _group:Array;
		

		/** Constructor for the ArrayGroup. 
		 *
		 * @param theArrayGroup	Is the collection of Objects you wish to iterate
		 * 											over.
		 *
		 */
		public function ArrayGroup( theArrayGroup:Array ) {
			_group = theArrayGroup;
		}
		

		/** Applies a specified action to each element in the array from the
		 * beginning to the end.
		 *
		 * @param f	The functor which is applied to each child.
		 *
		 */
		public function apply( f:Applyable ):void {
			var len:int = _group.length;
			for( var i:int = 0; i < len; i++ )
			{
				f.each( _group[i] );
			}
		}
		
		
		/** Applies a specified action to each element in the array from the end to
		 * the beginning.
		 *
		 * @param f	The functor which is applied to each child.
		 *
		 */
		public function reverseApply( f:Applyable ):void {
			var len:int = _group.length - 1;
			for( var i:int = len; i >= 0; i-- )
			{
				f.each( _group[i] );
			}
		}
	}
}
