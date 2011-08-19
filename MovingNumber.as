package 
{
	import design.MovingNumber_design;
	
	/**
	 * Un nombre qui s'affiche
	 * @author Neamar
	 */
	public final class MovingNumber
	{
		public static function getRandomValue():int { return Math.floor(10 * Math.random()); }

		public var view:MovingNumber_design = new MovingNumber_design();
		
		protected var _value:int;
		
		public function MovingNumber()
		{
			Main.currentGame.view.addChild(view);
			setValue(getRandomValue());
		}
		
		public function destroy():void
		{
			view.destroy();
		}
		
		public function getValue():int { return _value; }
		
		public function setValue(value:int):void { _value = value; view.setNumber(_value);}
	}
	
}