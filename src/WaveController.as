package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class WaveController extends Entity
	{
		public static const FADE_DURATION:Number = 3;
		public static const X_VARIATION:Number = FP.halfWidth;
		public static const Y_VARIATION:Number = 20;
		
		public var currentWave:Wave;
		public var lastWave:Wave;
		
		public function WaveController() 
		{
			var xPos:Number = FP.halfWidth - X_VARIATION + FP.random * (2 * X_VARIATION);
			var yPos:Number = Global.WATER_LINE - Y_VARIATION + FP.random * (2 * Y_VARIATION);		
			currentWave = new Wave(xPos, yPos, 0);
		}
		
		override public function added():void
		{
			FP.world.add(currentWave);
			currentWave.fadeIn(FADE_DURATION);
		}
		
		override public function update():void
		{
			if (currentWave.fadeInComplete) 
			{
				nextWave();
			}
		}
		
		public function nextWave():void
		{
			lastWave = currentWave;
			lastWave.fadeOut(FADE_DURATION);
			
			var xPos:Number = FP.halfWidth - X_VARIATION + FP.random * (2 * X_VARIATION);
			var yPos:Number = Global.WATER_LINE - Y_VARIATION + FP.random * (2 * Y_VARIATION);		
			FP.world.add(currentWave = new Wave(xPos, yPos, 0));
			currentWave.fadeIn(FADE_DURATION);
		}
		
		//override public function render():void
		//{
			// TODO: get rid of this
			//Draw.line(0, Global.WATER_LINE, FP.width, Global.WATER_LINE, Colors.BEACH_YELLOW, 1);
			//super.render();
		//}
		
	}

}