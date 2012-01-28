package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import flash.ui.Mouse;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MouseController extends Entity
	{
		public var handOpen:Image = new Image(Assets.HAND_CURSOR_OPEN);
		public var handClosed:Image = new Image(Assets.HAND_CURSOR_CLOSED);
		public var handOpenMask:Pixelmask = new Pixelmask(Assets.HAND_CURSOR_OPEN);
		
		public function MouseController() 
		{
			handOpen.centerOO();
			handClosed.centerOO();
			handOpenMask.x = -handOpen.width / 2;
			handOpenMask.y = -handOpen.height / 2;
			type = 'mouse_controller';
			layer = -1000;	
		}
		
		override public function added():void
		{
			Mouse.hide();
		}					
		
		override public function update():void
		{
			x = FP.world.mouseX;
			y = FP.world.mouseY;

			var overlapPerson:Person = collide('person', x, y) as Person;
			
			if (overlapPerson && Input.mousePressed)
			{
				Global.personGrabbed = true;
			}	
			else if (Input.mouseReleased)
			{
				Global.personGrabbed = false;
			}
			else if (Global.personGrabbed)
			{
				graphic = handClosed;
			}				
			else if (overlapPerson)
			{
				graphic = handOpen;
				mask = handOpenMask;
				handOpen.alpha = 1;
			}
			else
			{
				graphic = handOpen;
				mask = handOpenMask;
				handOpen.alpha = 0.5;
			}
			
			super.update();
		}				
		
	}

}