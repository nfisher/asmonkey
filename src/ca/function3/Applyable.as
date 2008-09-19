package ca.function3 {
	import flash.display.DisplayObject;
	
	/** The Applyable interface defines the API for concrete functors that are to
	 * be used in conjunction with the Groupable class.
	 *
	 * @langversion ActionScript 3.0
	 *
	 */
	public interface Applyable {


		/** The action to apply to a range of objects in a Groupable instance.
		 *
		 * @param o	The Object that will have the action applied.
		 *
		 */
		function each( o:Object ):void;
	}
}
