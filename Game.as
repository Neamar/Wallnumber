package 
{
	import design.Game_design;
	
	/**
	 * Une partie (un jeu) de Wallnumber
	 * @author Neamar
	 */
	public class Game
	{
		public var view:Game_design = new Game_design();
		
		protected var _score:int = 0;
		private var _displayedScore:int = 0;
		protected var _vitesse:int = 0;
		protected var _stack:Stack = new Stack();
		protected var _lanes:Vector.<Lane> = new Vector.<Lane>(Main.NB_LANES);
		protected var _currentLane:int = 0;
		
		/**
		 * GETTERS / SETTERS
		 */
		public function get score():int { return _score; }
		
		public function set score(value:int):void 
		{
			_score = value;
		}
		
		public function getCurrentLane():Lane { return _lanes[_currentLane]; }
	}
	
}