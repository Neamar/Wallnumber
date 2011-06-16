package 
{
	import com.greensock.TweenLite;
	
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
				_movingNumbers[i].view.x = 0;
				_movingNumbers[i].view.y = i * Main.LANE_HEIGHT;
			}
		}
		
		/**
		 * Essaie le nombre passé en paramètre et renvoie true s'il correspond au premier MovingNumber
		 * @param	v
		 * @return true si le nombre passé est correct
		 */
		public function tryNumber(v:int):Boolean
		{
			if (v == _movingNumbers[0].getValue())
			{
				var movingNumber:MovingNumber = _movingNumbers.shift();
				movingNumber.destroy();
				_movingNumbers.push(new MovingNumber());
				
				for (var i:int = 0; i < _nbMovingNumbers; i++)
				{
					TweenLite.to(_movingNumbers[i].view, .2, {y:i * Main.LANE_HEIGHT});
				}
				
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * Décale tous les numéros de quelques pixels
		 * @param	vitesse
		 */
		public function iterate(vitesse:int):void
		{
			_x += vitesse;
			for (var i:int = 0; i < _nbMovingNumbers; i++)
			{
				_movingNumbers[i].view.x = _x / Math.pow(2,i);
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