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
		
		protected var _value:int = Math.floor(10 * Math.random());
		public static var c:int = 0;
		
		public function MovingNumber()
		{
			_value = c;
			c++;
			Main.currentGame.view.addChild(view);
			view.setNumber(_value);
		}
	}
	
}