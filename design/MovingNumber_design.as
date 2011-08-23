package design
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Le design d'un nombre
	 * 
	 * L'image est centrée de façon à avoir (0,0) au milieu.
	 * @see MovingNumber
	 * @author Neamar
	 */
	public final class MovingNumber_design extends MovieClip 
	{
		[Embed(source = "../assets/car.png")] private static var CarBitmap:Class;
		
		protected var tf:TextField = new TextField();
		
		public function MovingNumber_design()
		{
			var CB:Bitmap = new CarBitmap();
			addChild(CB);
			CB.x = - CB.width / 2;
			CB.y = - CB.height / 2;
			addChild(tf);
			tf.textColor = 0;
			tf.selectable = false;
			tf.scaleX = tf.scaleY = 3;
			tf.textColor = 0xffffff;
			
			tf.y = CB.y;
			tf.x = -20;
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