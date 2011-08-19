package design
{
	import flash.display.MovieClip;
	
	/**
	 * Le design d'une voie
	 * @see Lane.as
	 * @author Neamar
	 */
	public final class Lane_design extends MovieClip 
	{
		public function closeTo(v:int):void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x00FF);
			this.graphics.drawRect(Main.GAME_WIDTH - v, 0, v, Main.LANE_HEIGHT);
		}
	}
	
}