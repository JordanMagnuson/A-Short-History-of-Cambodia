package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BloodOverlay extends Entity
	{
		public var canvas:Canvas = new Canvas(FP.width, FP.height);
		public function BloodOverlay() 
		{
			canvas.fill(new Rectangle(0, 0, FP.width, FP.height), Colors.BLOOD_RED, 0.3);
			super(0, 0, canvas);
			layer = -2000;	
		}
		
	}

}