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
		protected var _score:int = 0;
		
		public function Hud_design()
		{
			this.y = -Main.HUD_HEIGHT;
			
			addChild(scoreTf);
			
			scoreTf.textColor = 0;
			scoreTf.selectable = false;
			scoreTf.autoSize = TextFieldAutoSize.CENTER;
			
			scoreTf.scaleX = scoreTf.scaleY = 4;
		}
		
		public function setScore(value:int):void 
		{
			_score = value;
			scoreTf.text = _score.toString();
			scoreTf.x = (Main.GAME_WIDTH - scoreTf.width) / 2;
		}		
	}

}