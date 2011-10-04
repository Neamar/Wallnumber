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
		[Embed(source = "../assets/numbers/0.png")] public static var Number0:Class;
		[Embed(source = "../assets/numbers/1.png")] public static var Number1:Class;
		[Embed(source = "../assets/numbers/2.png")] public static var Number2:Class;
		[Embed(source = "../assets/numbers/3.png")] public static var Number3:Class;
		[Embed(source = "../assets/numbers/4.png")] public static var Number4:Class;
		[Embed(source = "../assets/numbers/5.png")] public static var Number5:Class;
		[Embed(source = "../assets/numbers/6.png")] public static var Number6:Class;
		[Embed(source = "../assets/numbers/7.png")] public static var Number7:Class;
		[Embed(source = "../assets/numbers/8.png")] public static var Number8:Class;
		[Embed(source = "../assets/numbers/9.png")] public static var Number9:Class;
		protected static var numbers:Array = [Number0, Number1, Number2, Number3, Number4, Number5, Number6, Number7, Number8, Number9];
		protected static var staticLaneNumber:int = 0;

		
		protected var laneNumber:int;
		protected var currentNumber:Bitmap = null;
	
		public function MovingNumber_design()
		{
			var CB:Bitmap = new CarBitmap();
			addChild(CB);
			CB.x = - CB.width / 2;
			CB.y = - CB.height / 2;
			
			laneNumber = (staticLaneNumber++) % Main.NB_LANES;
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
			
			var strongColor:int = Main.laneColors[laneNumber][0];
			var weakColor:int = Main.laneColors[laneNumber][1];
			
			currentNumber = new numbers[v]();
			var CT:ColorTransform = new ColorTransform(1, 1, 1, 1, (strongColor >> 16) & 0xFF, (strongColor >> 8) & 0xFF, strongColor & 0xFF);
			currentNumber.bitmapData.colorTransform(currentNumber.bitmapData.rect, CT);
			

			currentNumber.filters = [
				new GlowFilter(weakColor, .5, 12, 12, 4),//Lueur externe
				new GlowFilter(0xffffff, .4, 7, 7, 1, 1, true),//Lueur interne
				new DropShadowFilter(2, 125, 0, .8, 0, 0, 1, 1, true),//Contour
			];
			
			currentNumber.x = - 4 - currentNumber.width / 2;
			currentNumber.y = - currentNumber.height / 2;
			
			addChild(currentNumber);
		}
	}
	
}