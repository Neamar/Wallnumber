package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import mochi.as3.*;
	
	/**
	 * Wallnumber
	 * @author Neamar
	 * @see https://github.com/Neamar/Wallnumber/
	 */
	public final dynamic class Main extends Sprite 
	{
		[Embed(source = "assets/back.png")] private static var Background:Class;
		
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
		 * La hauteur du HUD
		 */
		public static const HUD_HEIGHT:int = 75;
		
		/**
		 * La hauteur d'une voie
		 */
		public static const LANE_HEIGHT:int = (GAME_HEIGHT - HUD_HEIGHT) / NB_LANES;
		
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
		 * Multiplicateur pour la fermeture d'une voie
		 */
		public static const LANE_FACTOR:int = 5;
		
		/**
		 * La partie "non" utilisable d'une voie.
		 */
		public static const LANE_OFFSETX:int = 80;
		
		/**
		 * Les différentes couleurs de voies
		 * 
		 * La première est la majeure, la seconde couleur la mineure (plus laiteuse, utilisée pour les filtres)
		 */
		public static var laneColors:Array = [
			[0xff0000, 0xc96565],
			[0x3b9114, 0x53d553],
			[0x70419c, 0xb253b8],
			[0x138faa, 0x53a5b7],
			[0xe616df, 0xbd6bba]
		];
		
		/**
		 * Le jeu en cours
		 */
		public static var currentGame:Game = null;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Un joli fond
			addChild(new Background());
			
			// Lancer un jeu !
			setupNewGame();
			
			//Préparer les highscores
			MochiServices.connect("c0066d922623e3a8", this);
		}
		
		protected function setupNewGame():void
		{
			//Nettoyer l'ancienne partie
			if (currentGame != null)
			{
				removeChild(currentGame.view);
				currentGame.removeEventListener(Game.GAMEOVER, registerHighscore);
			}
			
			currentGame = new Game(this.stage);
			currentGame.addEventListener(Game.GAMEOVER, registerHighscore);
			addChild(currentGame.view);
		}
		
		protected function registerHighscore(e:Event):void
		{		
			var o:Object = { n: [3, 12, 15, 14, 13, 6, 14, 10, 3, 12, 13, 5, 13, 8, 13, 9], f: function (i:Number,s:String):String { if (s.length == 16) return s; return this.f(i+1,s + this.n[i].toString(16));}};
			var boardID:String = o.f(0,"");
			MochiScores.showLeaderboard({boardID: boardID, score: currentGame.score, onClose:setupNewGame});
		}
	}
	
}