package design
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
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
			
			this.scaleX = this.scaleY = 3;
		}
		
		public function destroy():void
		{
			removeChild(tf);
			parent.removeChild(this);
		}
		
		public function setNumber(v:int):void
		{
			tf.text = v.toString();
		}
	}
	
}