package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class FloatController extends Entity
	{
		public var t:Number = 0;
		public var A:Number = 50;
		
		public function FloatController() 
		{
		}
		
		override public function update():void
		{
			t += FP.elapsed;
			super.update();
		}
		
		public function u(x:Number):Number
		{
			return Global.WATER_LINE + A * Math.sin(0.01 * x - t);
		}
		
	}

}