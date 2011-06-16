package 
{
	import design.Game_design;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
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
		protected var _stack:Stack;
		protected var _lanes:Vector.<Lane>;
		protected var _currentLane:int = 0;
		protected var _frameNumber:int = 0;
		
		public function Game(mainStage:Stage)
		{
			Main.currentGame = this;
			
			_lanes = new Vector.<Lane>(Main.NB_LANES);
			_stack = new Stack();
			
			view.addEventListener(Event.ENTER_FRAME, onFrame);
			
			mainStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
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
			
			_stack.iterate(_vitesse);
		}
		
		public function onKeyPress(e:KeyboardEvent):void
		{
			var nombrePresse:int = -1;
			
			//Pavé numérique
			if (e.keyCode >= 96 && e.keyCode <= 105)
			{
				nombrePresse = e.keyCode - 96;
			}
			
			//Au dessus d'AZERTY
			if (e.keyCode >= 48 && e.keyCode <= 57)
			{
				nombrePresse = e.keyCode - 48;
			}
			
			//Appui sur une touche non gérée
			if (nombrePresse == -1)
				return;
				
			var estValide:Boolean = _stack.tryNumber(nombrePresse);
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