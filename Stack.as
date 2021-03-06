package 
{
	import com.greensock.TweenLite;
	
	/**
	 * La pile des nombres qui s'affichent
	 * @author Neamar
	 */
	public final class Stack
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
				_movingNumbers[i].view.x = Main.LANE_OFFSETX;
				_movingNumbers[i].view.y = (i + .5) * Main.LANE_HEIGHT;
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
				shift();
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
			
			//l'abscisse à atteindre.
			var objectiveX:int;
			//l'abscisse actuelle
			var currentX:int;
			for (var i:int = 0; i < _nbMovingNumbers; i++)
			{
				objectiveX = _x / Math.pow(2, i);
				currentX = _movingNumbers[i].view.x - Main.LANE_OFFSETX;
				if (objectiveX > currentX)
				{
					//Les choses avancent !
					_movingNumbers[i].view.x = Main.LANE_OFFSETX + objectiveX;
				}
				else
				{
					//Il faut faire reculer le chariot, mais pas trop rapidement pour ne pas avoir d'animation saccadée
					_movingNumbers[i].view.x = Main.LANE_OFFSETX + objectiveX + 1.5 * (currentX - objectiveX) / 2
				}
			}
		}
		
		/**
		 * Supprime le nombre actuellement en tête
		 */
		public function shift():void
		{
			//Décaler tous les numéros d'un cran
			for (var i:int = 0; i < _nbMovingNumbers - 1; i++)
			{
				_movingNumbers[i].setValue(_movingNumbers[i + 1].getValue());
			}
			//Et inventer un nouveau numéro pour le petit dernier :
			_movingNumbers[i].setValue(MovingNumber.getRandomValue());
			
			calmDown();
		}
		
		/**
		 * Descend le premier nombre une voie plus bas
		 */
		public function moveOneLaneDown():void
		{
			var movingNumber:MovingNumber = _movingNumbers.shift();
			movingNumber.destroy();
			_nbMovingNumbers--;
			_y += Main.LANE_HEIGHT;
			
			calmDown();
		}
		
		public function getX():int { return _x; }
		
		/**
		 * Ramène à la position correcte après la perte d'une voie, ou quand on a validé correctement un numéro.
		 */
		protected function calmDown():void
		{
			//Ramener à la position correcte :
			_x /= 2;
		}
	}
	
}