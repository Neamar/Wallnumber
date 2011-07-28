package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	/**
	 * Wallnumber
	 * @author Neamar
	 * @see https://github.com/Neamar/Wallnumber/
	 */
	public class Main extends Sprite 
	{
		/**
		 * Largeur du jeu (px)
		 */
		public static const GAME_WIDTH:int = 800;
		
		/**
		 * Hauteur du jeu (px)
		 */
		public static const GAME_HEIGHT:int = 600;
		
		/**
		 * Le nombre de voies sur le jeu (grosso modo, un équivalent du nombre de vies)
		 */
		public static const NB_LANES:int = 5;
		
		/**
		 * La hauteur d'une voie
		 */
		public static const LANE_HEIGHT:int = GAME_HEIGHT / NB_LANES;
		
		/**
		 * La vitesse maximale que l'on puisse atteindre, au delà de laquelle on est bridé
		 */
		public static const SPEED_MAX:int = 50;
		
		/**
		 * Le facteur de perte de vitesse lorsque l'on perd une voie (< 1 pour ralentir le jeu)
		 */
		public static const SPEED_DAMP:Number = .75;
		
		/**
		 * Nombre de frames par secondes
		 */
		public static const FRAME_RATE:int = 30;
		
		/**
		 * Le jeu en cours
		 */
		public static var currentGame:Game;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// Lancer un jeu !
			
			new Game(stage);
			addChild(currentGame.view);
		}
		
	}
	
}