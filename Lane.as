package 
{
	import design.Lane_design;
	
	/**
	 * Une voie pour le jeu.
	 * Le nombre de voies est défini par Main.NB_LANES
	 * @author Neamar
	 */
	public class Lane
	{
		public var view:Lane_design = new Lane_design();
		
		protected var _widthClosed:int = 0;

		public function Lane()
		{
			Main.currentGame.view.addChild(view);
		}
		
		/**
		  * Ferme un peu plus la voie.
		  * @param	v le delta de fermeture à ajouter
		  */
		public function closeALittleMore(v:int):void
		{
			_widthClosed += v;
			view.closeTo(_widthClosed);
		}
		
		/**
		 * Ferme complètement la voie.
		 * @param	m
		 */
		public function close(m:String):void
		{
			_widthClosed = Main.GAME_WIDTH;
			closeALittleMore(0);
		}
		
		public function getWidthClosed():int { return _widthClosed; }
	}
	
}