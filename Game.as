package 
{
	import design.Game_design;
	import flash.events.Event;
	
	/**
	 * Une partie (un jeu) de Wallnumber
	 * @author Neamar
	 */
	public class Game
	{
		public var view:Game_design = new Game_design();
		
		protected var _score:int = 0;
		private var _displayedScore:Number = 0;
		protected var _vitesse:int = 1;
		protected var _stack:Stack = new Stack();
		protected var _lanes:Vector.<Lane> = new Vector.<Lane>(Main.NB_LANES);
		protected var _currentLane:int = 0;
		protected var _frameNumber:int = 0;
		
		public function Game()
		{
			view.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		/**
		 * Sur chaque Frame distribuée par Flash
		 * @param	e
		 */
		public function onFrame(e:Event = null):void
		{
			//Score affiché
			setDisplayedScore(_displayedScore + (_score - _displayedScore) / 10);
			_frameNumber = (_frameNumber + 1) % Main.FRAME_RATE;
			//Chaque seconde, le score augmente de la vitesse actuelle
			if (_frameNumber == 0)
			{
				addToScore(_vitesse);
			}
		}
		/**
		 * GETTERS / SETTERS
		 */
		public function get score():int { return _score; }
		
		public function addToScore(v:int):void
		{
			_score += v;
		}
		
		public function get currentLane():Lane { return _lanes[_currentLane]; }
		
		public function setDisplayedScore(value:Number):void 
		{
			_displayedScore = value;
		}
	}
	
}