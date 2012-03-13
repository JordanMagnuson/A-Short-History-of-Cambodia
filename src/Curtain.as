package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Curtain extends Entity
	{
		public static const SPEED:Number = 1;
		
		public var image:Image = new Image(Assets.CURTAIN);
		
		public function Curtain(x:Number = 0, y:Number = 0) 
		{
			super(x, y, image);
			layer = -2000;
		}
		
		override public function update():void
		{
			if (x > FP.width) 
				FP.world.remove(this);
				
			x += 1;
		}
		
	}

}