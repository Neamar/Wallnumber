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
		[Embed(source = "../assets/numbers/0.png")] private static var Number0:Class;
		[Embed(source = "../assets/numbers/1.png")] private static var Number1:Class;
		[Embed(source = "../assets/numbers/2.png")] private static var Number2:Class;
		[Embed(source = "../assets/numbers/3.png")] private static var Number3:Class;
		[Embed(source = "../assets/numbers/4.png")] private static var Number4:Class;
		[Embed(source = "../assets/numbers/5.png")] private static var Number5:Class;
		[Embed(source = "../assets/numbers/6.png")] private static var Number6:Class;
		[Embed(source = "../assets/numbers/7.png")] private static var Number7:Class;
		[Embed(source = "../assets/numbers/8.png")] private static var Number8:Class;
		[Embed(source = "../assets/numbers/9.png")] private static var Number9:Class;
		protected static var numbers:Array = [Number0, Number1, Number2, Number3, Number4, Number5, Number6, Number7, Number8, Number9];
		protected static var staticLaneNumber:int = 0;
		
		protected static var colors:Array = [
			[0xff0000, 0xc96565],
			[0x3b9114, 0x53d553],
			[0x70419c, 0xb253b8],
			[0x138faa, 0x53a5b7],
			[0xe616df, 0xbd6bba]
		];
		
		protected var laneNumber:int;
		protected var currentNumber:Bitmap = null;
	
		public function MovingNumber_design()
		{
			var CB:Bitmap = new CarBitmap();
			addChild(CB);
			CB.x = - CB.width / 2;
			CB.y = - CB.height / 2;
			
			laneNumber = staticLaneNumber++;
		}
		
		public function destroy():void
		{
			//removeChild(tf);
			parent.removeChild(this);
		}
		
		public function setNumber(v:int):void
		{
			if (currentNumber != null) {
				removeChild(currentNumber);
			}
			
			var strongColor:int = colors[laneNumber][0];
			var weakColor:int = colors[laneNumber][1];
			
			currentNumber = new numbers[v]();
			var CT:ColorTransform = new ColorTransform(1, 1, 1, 1, (strongColor >> 16) & 0xFF, (strongColor >> 8) & 0xFF, strongColor & 0xFF);
			currentNumber.bitmapData.colorTransform(currentNumber.bitmapData.rect, CT);
			
			currentNumber.filters = [
				new GlowFilter(strongColor, .4, 12, 12, 4),
				new GlowFilter(weakColor, .7, 6, 6, 1, 1, true),
				new DropShadowFilter(2, 90, weakColor, 1, 0, 0, 1, 1, true),
			];
			
			currentNumber.x = - 4 - currentNumber.width / 2;
			currentNumber.y = - currentNumber.height / 2;
			
			addChild(currentNumber);
		}
	}
	
}