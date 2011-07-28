package 
{
	import com.greensock.TweenLite;
	import design.Game_design;
	import design.Hud_design;
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
		protected var _hud:Hud_design;
		protected var _stage:Stage;
		
		public function Game(mainStage:Stage)
		{
			Main.currentGame = this;
			
			_lanes = new Vector.<Lane>(Main.NB_LANES);
			for (var i:int = 0; i < _lanes.length; i++)
			{
				_lanes[i] = new Lane();
				_lanes[i].view.y = i * Main.LANE_HEIGHT;
			}
			
			_stack = new Stack();
			
			view.addEventListener(Event.ENTER_FRAME, onFrame);
			view.focusRect = false;
			mainStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			this._stage = mainStage;
			
			_hud = new Hud_design();
			view.addChild(_hud);
			addToScore(0);
			vitesse = 1;
		}
		
		/**
		 * Sur chaque Frame distribuée par Flash
		 * @param	e
		 */
		public function onFrame(e:Event = null):void
		{
			//Score affiché
			_frameNumber = (_frameNumber + 1) % Main.FRAME_RATE;
			
			//Chaque seconde, le score augmente de la vitesse actuelle
			if (_frameNumber == 0)
			{
				addToScore(vitesse);
			}
			
			if (_frameNumber % 3)
			{
				_stack.iterate(vitesse);
			}
			
			if (Main.GAME_WIDTH - currentLane.getWidthClosed() < _stack.getX())
			{
				//Perte d'une voie
				currentLane.close('FAIL');
				_stack.shift();
				_stack.moveOneLaneDown();
				
				vitesse *= Main.SPEED_DAMP;
				
				_currentLane++;
				
				if (_currentLane >= _lanes.length)
				{
					//Fin du jeu !
					throw new Error('Fin du jeu ! Score : ' + _score);
				}
			}
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
			
			if (estValide)
			{
				this._stage.focus = this.view;
				vitesse++;
			}
			else
			{
				currentLane.closeALittleMore(vitesse);
			}
		}
		
		/**
		 * GETTERS / SETTERS
		 */
		public function get score():int { return _score; }
		
		public function addToScore(v:int):void
		{
			_score += v;
			TweenLite.to(this, 1, { displayedScore:_score } );
		}
		
		public function get currentLane():Lane { return _lanes[_currentLane]; }
		
		public function get displayedScore():Number { return _displayedScore; }
		public function set displayedScore(value:Number):void 
		{
			_displayedScore = value;
			_hud.setScore(_displayedScore);
		}
		
		public function get vitesse():int { return _vitesse; }
		public function set vitesse(v:int):void
		{
			_vitesse = v;
			_hud.setVitesse(v);
		}
	}
	
}