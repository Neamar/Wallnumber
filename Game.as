package 
{
	import com.greensock.TweenLite;
	import design.Game_design;
	import design.Hud_design;
	import design.Lane_design;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * Une partie (un jeu) de Wallnumber
	 * @author Neamar
	 */
	public final class Game extends EventDispatcher
	{
		public static const GAMEOVER:String = "gameOver";
		
		public var view:Game_design = new Game_design();
		
		protected var _score:Number = 0;
		protected var _vitesse:int;
		protected var _stack:Stack;
		protected var _lanes:Vector.<Lane>;
		protected var _currentLane:int = 0;
		protected var _frameNumber:int = 0;
		protected var _hud:Hud_design;
		protected var _stage:Stage;
		
		public function Game(mainStage:Stage)
		{
			//Il faut directement enregistrer le jeu en cours, sinon on risque d'avoir des problèmes à la constructions des sous objets.
			//Cette architecture permet cependant d'éviter de passer des paramètres à outrance.
			Main.currentGame = this;

			_lanes = new Vector.<Lane>(Main.NB_LANES);
			for (var i:int = 0; i < _lanes.length; i++)
			{
				_lanes[i] = new Lane();
				_lanes[i].view.y = (i + .5) * Main.LANE_HEIGHT;
			}
			
			_stack = new Stack();
			
			view.addEventListener(Event.ENTER_FRAME, onFrame);
			view.focusRect = false;
			mainStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this._stage = mainStage;
			
			_hud = new Hud_design();
			view.addChild(_hud);
			_hud.setScore(0);
			vitesse = 1;
		}
		
		/**
		 * Sur chaque Frame distribuée par Flash
		 * @param	e
		 */
		public function onFrame(e:Event = null):void
		{
			_frameNumber = (_frameNumber + 1) % Main.FRAME_RATE;
			
			//Chaque frame, le score augmente de la vitesse actuelle
			_score += vitesse / 10;
			_hud.setScore(_score);
			
			//Déplacer les chariots
			if (_frameNumber % 3)
			{
				_stack.iterate(vitesse);
			}
			
			if (Main.GAME_WIDTH - currentLane.getWidthClosed() - Main.LANE_OFFSETX - Lane_design.STOP_WIDTH < _stack.getX())
			{
				//Perte d'une voie
				currentLane.close('FAIL');
				_stack.moveOneLaneDown();
				
				vitesse *= Main.SPEED_DAMP;
				vitesse = Math.max(vitesse, 1);
				_currentLane++;
				
				if (_currentLane >= _lanes.length)
				{
					//Fin du jeu !
					endGame();
				}
				else
				{
					_hud.changeColor(_currentLane);
				}
			}
		}
		
		/**
		 * As-tu appuyé sur la bonne touche ?
		 * @param	e
		 */
		public function onKeyPress(e:KeyboardEvent):void
		{
			/*
			 * Convertir le keyCode pour récupérer la touche appuyée.
			 */
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
			
			if (estValide)
			{
				this._stage.focus = this.view;
				vitesse++;
			}
			else
			{
				currentLane.closeALittleMore(Main.LANE_FACTOR * vitesse);
			}
		}
		
		/**
		 * C'est la fin de la partie les loulou !
		 */
		protected function endGame():void
		{
			view.removeEventListener(Event.ENTER_FRAME, onFrame);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			dispatchEvent(new Event(Game.GAMEOVER));
		}
		
		/*
		 * GETTERS / SETTERS
		 */
		public function get score():int { return _score; }
		
		public function get currentLane():Lane { return _lanes[_currentLane]; }
		
		public function get vitesse():int { return _vitesse; }
		public function set vitesse(v:int):void
		{
			_vitesse = v;
		}
	}
	
}