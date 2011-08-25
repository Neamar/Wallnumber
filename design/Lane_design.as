package design
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.Bitmap;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	/**
	 * Le design d'une voie
	 * 
	 * L'image est centrée verticalement de façon à avoir (x,0) au milieu.
	 * 
	 * @see Lane.as
	 * @author Neamar
	 */
	public final class Lane_design extends Sprite 
	{
		[Embed(source = "../assets/lane.png")] private static var LaneBitmap:Class;
		[Embed(source = "../assets/stop.png")] private static var StopBitmap:Class;
		public static const STOP_WIDTH:int = 45;
		
		protected static var staticLaneNumber:int = 0;
		
		protected var laneNumber:int;
		
		public var stops:Sprite = new Sprite();
		
		public function Lane_design()
		{
			laneNumber = (staticLaneNumber++) % Main.NB_LANES;
			
			var LB:Bitmap = new LaneBitmap();
			LB.y = - LB.height / 2;
			addChild(LB);
			
			stops.x = Main.GAME_WIDTH;
			stops.y = - STOP_WIDTH / 2;
			addChild(stops);
			
			
		}
		
		public function closeTo(v:int):void
		{
			v = Math.min(v, Main.GAME_WIDTH - Main.LANE_OFFSETX);
			
			while (stops.numChildren <= Math.ceil(v / STOP_WIDTH))
			{
				var newStop:Sprite = new Sprite();
				
				//Le flux
				var newStopShape:Shape = new Shape();
				var gradientBoxMatrix:Matrix = new Matrix();
				gradientBoxMatrix.createGradientBox(8, 15, 0, 0, 0);  
				
				newStopShape.graphics.lineStyle(5);
				newStopShape.graphics.lineGradientStyle(GradientType.LINEAR, [Main.laneColors[laneNumber][1],
				0], [1, 1], [0, 255], gradientBoxMatrix);
				newStopShape.graphics.drawCircle(0, 0, 13);
				newStopShape.rotation = Math.random() * 360;
				TweenMax.to(newStopShape, 3, { rotation:360 + newStopShape.rotation, repeat:-1 } );
				newStop.addChild(newStopShape);
				
				//Le bloc
				var newStopBitmap:Bitmap = new StopBitmap();
				newStopBitmap.x = - STOP_WIDTH / 2;
				newStopBitmap.y = - STOP_WIDTH / 2;
				newStop.addChild(newStopBitmap);
				
				newStop.x = stops.numChildren * STOP_WIDTH;
				newStop.y = STOP_WIDTH / 2;
				stops.addChild(newStop);
			}
			
			if (v == Main.GAME_WIDTH - Main.LANE_OFFSETX)
			{
				//Optimiser les tweens en conservant le premier "4fun"
				for (var i:int = 1; i < stops.numChildren; i++)
				{
					TweenMax.killTweensOf((stops.getChildAt(i) as Sprite).getChildAt(0));
				}
				
				TweenLite.to(stops, .2, { x: Main.LANE_OFFSETX} );
			}
			else
			{
				TweenLite.to(stops, .5, { x: Main.GAME_WIDTH - v } );
			}
		}
	}
	
}