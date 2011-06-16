package 
{
	
	/**
	 * La pile des nombres qui s'affichent
	 * @author Neamar
	 */
	public class Stack
	{
		protected var _movingNumbers:Vector.<MovingNumber> = new Vector.<MovingNumber>(Main.NB_LANES);
		protected var _nbMovingNumbers:int = Main.NB_LANES;
		protected var _x:int = 0;
		protected var _y:int = 0;
		
		public function Stack()
		{
			for (var i:int = 0; i < _nbMovingNumbers; i++)
			{
				_movingNumbers[i] = new MovingNumber();
			}
		}
		
		/**
		 * Descend le premier nombre une voie plus bas
		 */
		public function moveOneLaneDown():void
		{
			_y += Main.LANE_HEIGHT;
		}
	}
	
}