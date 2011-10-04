package design 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Le panneau de score
	 * @author Neamar
	 */
	public final class Hud_design extends MovieClip
	{
		protected var scoreTf:TextField = new TextField();
		protected var vitesseTf:TextField = new TextField();
		protected var _score:int = 0;
		protected var _vitesse:int = 0;
		
		public function Hud_design()
		{
			this.y = -Main.HUD_HEIGHT;
			
			addChild(scoreTf);
			addChild(vitesseTf);
			
			scoreTf.textColor = vitesseTf.textColor = 0;
			scoreTf.selectable = vitesseTf.selectable = false;
			scoreTf.autoSize = TextFieldAutoSize.LEFT;
			vitesseTf.autoSize = TextFieldAutoSize.RIGHT;
			
			scoreTf.scaleX = scoreTf.scaleY = 4;
			vitesseTf.scaleX = vitesseTf.scaleY = 4;
		}
		
		public function setScore(value:int):void 
		{
			_score = value;
			scoreTf.text = _score.toString();
		}
		
		public function setVitesse(value:int):void 
		{
			_vitesse = value;
			vitesseTf.text =  _vitesse.toString();
			vitesseTf.x = Main.GAME_WIDTH - vitesseTf.width;
		}
		
	}

}