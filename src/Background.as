package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	
	public class Background extends Entity
	{
		
		public function Background() 
		{
			super(0, 0, new Backdrop(Assets.BACKGROUND));
		}
		
	}

}