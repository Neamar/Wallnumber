package design
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	/**
	 * Le design d'une voie
	 * @see Lane.as
	 * @author Neamar
	 */
	public final class Lane_design extends Sprite 
	{
		[Embed(source = "../assets/lane.png")] private static var LaneBitmap:Class;
		
		public function Lane_design()
		{
			var LB:Bitmap = new LaneBitmap();
			addChild(LB);
		}
		
		public function closeTo(v:int):void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x00FF);
			this.graphics.drawRect(Main.GAME_WIDTH - v, 0, v, Main.LANE_HEIGHT);
		}
	}
	
}