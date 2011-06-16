package design
{
	import flash.display.MovieClip;
	
	/**
	 * Le graphisme du jeu
	 * @see Game.as
	 * @author Neamar
	 */
	public class Game_design extends MovieClip
	{
		public function Game_design()
		{
			this.graphics.beginFill(0xFF0000);
			this.graphics.drawRect(0, 0, Main.GAME_WIDTH, Main.GAME_HEIGHT);
		}
	}
	
}