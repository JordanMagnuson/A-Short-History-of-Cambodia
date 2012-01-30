package  
{
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PersonGrabbed extends Person
	{
		
		public function PersonGrabbed(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, angle, health, maxHealth);
		}
		
		override public function update():void
		{
			x = FP.world.mouseX;
			y = FP.world.mouseY;
			super.update();
		}
		
	}

}