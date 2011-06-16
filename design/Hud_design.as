package design 
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * Le panneau de score
	 * @author Neamar
	 */
	public class Hud_design extends MovieClip
	{
		protected var tf:TextField = new TextField();
		protected var _score:int = 0;
		protected var _vitesse:int = 0;
		
		public function Hud_design()
		{
			addChild(tf);
			tf.textColor = 0;
			tf.selectable = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
		}

		protected function update():void
		{
			tf.text = 'Score : ' + _score + ' ; vitesse : ' + _vitesse;
		}
		
		public function setScore(value:int):void 
		{
			_score = value;
			update()
		}
		
		public function setVitesse(value:int):void 
		{
			_vitesse = value;
			update();
		}
		
	}

}