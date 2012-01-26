package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import flash.ui.Mouse;
	
	public class Main extends Engine
	{
		public function Main() 
		{
			super(1000, 600, 60);
			//FP.screen.color = Colors.BLACK;
			
			// Console for debugging
			FP.console.enable();		
			
			FP.world = new Game;
			
			//Mouse.hide();
		}
	}
}