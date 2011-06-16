package design
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	/**
	 * Le design d'un nombre
	 * @see MovingNumber
	 * @author Neamar
	 */
	public class MovingNumber_design extends MovieClip 
	{
		protected var tf:TextField = new TextField();
		
		public function MovingNumber_design()
		{
			addChild(tf);
			tf.textColor = 0;
		}
		
		public function setNumber(v:int):void
		{
			tf.text = v.toString();
		}
	}
	
}