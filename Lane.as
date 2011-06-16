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

		/**
		  * Ferme un peu plus la voie.
		  * @param	v le delta de fermeture à ajouter
		  */
		public function closeALittleMore(v:int):void
		{
			_widthClosed += v;
		}
	}
	
}