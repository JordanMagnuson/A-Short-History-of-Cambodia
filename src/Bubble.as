package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Bubble extends Entity
	{
		public static const SPEED:Number = 0.1;
		
		public var spritemap:Spritemap = new Spritemap(Assets.BUBBLE, 11, 11);					
		
		public function Bubble(x:Number = 0, y:Number = 0) 
		{
			super(x, y, spritemap);
			spritemap.add("go", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 3, false);
			spritemap.centerOO();
			spritemap.color = Colors.BLACK;
			spritemap.alpha = 0.5;
		}
		
		override public function update():void
		{
			if (spritemap.complete)
				FP.world.remove(this);
				
			y -= SPEED;
		}
		
		override public function added():void
		{
			spritemap.play('go');
		}
		
	}

}