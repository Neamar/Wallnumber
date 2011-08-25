package design
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.filters.BevelFilter;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
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
		[Embed(source = "../assets/numbers/8.png")] private static var Number8:Class;
		
		protected static var number:int = 0;
		
		protected static var colors:Array = [
			[0xff0000, 0xc96565],
			[0x3b9114, 0x53d553],
			[0x70419c, 0xb253b8],
			[0x138faa, 0x53a5b7],
			[0xe616df, 0xbd6bba]
		];
		
		protected var tf:TextField = new TextField();
	
		public function MovingNumber_design()
		{
			var CB:Bitmap = new CarBitmap();
			addChild(CB);
			CB.x = - CB.width / 2;
			CB.y = - CB.height / 2;
			
			var strongColor:int = colors[number][0];
			var weakColor:int = colors[number][1];
			
			var VB:Bitmap = new Number8();
			var CT:ColorTransform = new ColorTransform(1, 1, 1, 1, (strongColor >> 16) & 0xFF, (strongColor >> 8) & 0xFF, strongColor & 0xFF);
			VB.bitmapData.colorTransform(VB.bitmapData.rect, CT);
			
			VB.filters = [
				new GlowFilter(strongColor, .4, 12, 12, 2),
				//new GlowFilter(strongColor, .7, 6, 6, 1, 1, true)
				new DropShadowFilter(2, 90, weakColor, 1, 0, 0, 1, 1, true),
			];
			addChild(VB);
			VB.x = - 4 - VB.width / 2;
			VB.y = - VB.height / 2;
			
			//addChild(tf);
			tf.textColor = 0;
			tf.selectable = false;
			tf.scaleX = tf.scaleY = 3;
			tf.textColor = 0xffffff;
			
			tf.y = CB.y;
			tf.x = -20;
			
			number++;
		}
		
		public function destroy():void
		{
			//removeChild(tf);
			parent.removeChild(this);
		}
		
		public function setNumber(v:int):void
		{
			tf.text = v.toString();
		}
	}
	
}