package design 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Le panneau de score
	 * @author Neamar
	 */
	public final class Hud_design extends MovieClip
	{
		protected var scoreTf:TextField = new TextField();
		protected var scoreTfFormat:TextFormat = new TextFormat();
		protected var _score:int = -1;
		
		[Embed(source = "../assets/digital-7.ttf", fontFamily = "Digital-7", mimeType="application/x-font-truetype")]
		private static var EmbedFont:String;
		
		public function Hud_design()
		{
			this.y = -Main.HUD_HEIGHT;
			
			scoreTfFormat.font = "Digital-7";
			scoreTfFormat.size = 14;
			//Text_Format.bold = true;
			scoreTfFormat.color = 0xFFFFFF;
			
			scoreTf.embedFonts = true;
			scoreTf.defaultTextFormat = scoreTfFormat;
			scoreTf.textColor = 0;
			scoreTf.selectable = false;
			scoreTf.autoSize = TextFieldAutoSize.RIGHT;
			
			scoreTf.scaleX = scoreTf.scaleY = 4;
			addChild(scoreTf);
			
			setScore(0);
			
			changeColor();
		}
		
		public function setScore(value:int):void 
		{
			if (Math.floor(Math.log(value) / Math.LN10) != Math.floor(Math.log(_score) / Math.LN10))
			{
				trace(value);
				_score = value;
				scoreTf.text = _score.toString();
				scoreTf.x = Main.GAME_WIDTH - scoreTf.width;
			}
			else
			{
				_score = value;
				scoreTf.text = _score.toString();
			}
		}
		
		public function changeColor(colorIndex:int = 0):void
		{
			this.filters = [new GlowFilter(Main.laneColors[colorIndex][1])];
		}
	}

}