package 
{
	import design.MovingNumber_design;
	
	/**
	 * Un nombre qui s'affiche
	 * @author Neamar
	 */
	public class MovingNumber
	{
		public var view:MovingNumber_design = new MovingNumber_design();
		
		protected var _value:int = Math.round(10 * Math.random());
	}
	
}