package ca.function3 {
	import ca.function3.Applyable;

	/** The Groupable interface defines the API for concrete containers that are to
	 * be used in conjunction with the Applyable class.
	 *
	 * @langversion ActionScript 3.0
	 *
	 */
	public interface Groupable {


		/** Forward iteration over each of the elements in the group applying the
		 * functor to each element.
		 *
		 * @param f	The functor that applies the action to an element.
		 *
		 */
		function apply( f:Applyable ):void;


		/** Reverse iteration over each of the elements in the group applying the
		 * functor to each element.
		 *
		 * @param f	The functor that applies the action to an element.
		 *
		 */
		function reverseApply( f:Applyable ):void;
	}
}
