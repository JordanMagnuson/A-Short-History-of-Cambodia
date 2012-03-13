package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameOver extends World
	{
		
		public function GameOver() 
		{
			
		}
		
		override public function begin():void
		{
			add(new Curtain( -FP.width / 2, 0));
			add(new Entity(0, 0, new Image(Assets.END_SCREEN)));
			trace('now in game over');
		}		
		
	}

}