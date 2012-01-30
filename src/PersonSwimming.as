package  
{
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PersonSwimming extends Person
	{
		public var mover:LinearMotion;
		public var angleChanger:AngleTween;		
		
		public function PersonSwimming(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, angle, health, maxHealth);
		}
		
		override public function update():void
		{
			if (mover) 
			{
				x = mover.x;
				y = mover.y;
			}			
			super.update();
		}
		
		override public function added():void
		{
			swimUp();
		}
		
		public function swimUp():void
		{
			var yDist:Number = 80;
			if (yDist > (y - Global.WATER_LINE))
			{
				yDist = y - Global.WATER_LINE
			}
			var xDist:Number = 5;
			var xDir:Number = FP.choose( -1, 1);
			var duration:Number = 1;
			
			mover = new LinearMotion(swimUpCallback);
			addTween(mover);
			mover.setMotion(x, y, x + xDist * xDir, y - yDist, duration, Ease.quadInOut);
			
			//trace('floatX: ' + floatX);
			//trace('duration: ' + duration);			
			
			// Angle tween
			//angleChange = MIN_ANGLE_CHANGE + FP.random * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
			//angleChange *= -floatXDirection;
			//angleChanger = new AngleTween();
			//addTween(angleChanger);
			//angleChanger.tween(image.angle, angleChange, duration, Ease.quadInOut);
		}
		
		public function swimUpCallback():void
		{
			swimUp();
		}
		
	}

}