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
		public static const SWIM_SPEED:Number = 80;
		
		public var hitSurface:Boolean = false;
		public var mover:LinearMotion;
		public var angleChanger:AngleTween;		
		
		public function PersonSwimming(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, angle, health, maxHealth);
		}
		
		override public function update():void
		{
			if (health > Global.MIN_HEALTH)
			{
				health -= Global.HEALTH_LOSS_RATE;
			}
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
			if (yDist > (y - floatLevel - PersonGasping.GASP_FLOAT_DISTANCE))
			{
				yDist = y - floatLevel;
				hitSurface = true;
			}
			var xDist:Number = 5;
			var xDir:Number = FP.choose( -1, 1);
			//var duration:Number;
			//if (yDist == 80)
			//{
				//duration = 1;
			//}
			//else 
			//{
				//duration = 1 * (yDist / 40);
			//}
			
			mover = new LinearMotion(swimUpCallback);
			addTween(mover);
			var quadFunc:Function;
			if (hitSurface)
			{
				quadFunc = Ease.quadIn;
			}
			else 
			{
				quadFunc = Ease.quadInOut;
			}
			mover.setMotionSpeed(x, y, x + xDist * xDir, y - yDist, SWIM_SPEED, quadFunc);
			
			//trace('floatX: ' + floatX);
			//trace('duration: ' + duration);			
			
			// Angle tween
			//angleChange = MIN_ANGLE_CHANGE + FP.random * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
			//angleChange *= -floatXDirection;
			//angleChanger = new AngleTween();
			//addTween(angleChanger);
			//angleChanger.tween(image.angle, angleChange, duration, Ease.quadInOut);
		}
		
		public function changeToGasper():void
		{
			FP.world.add(new PersonGasping(x, y, image.angle, health, maxHealth));
			this.destroy();
		}
		
		public function swimUpCallback():void
		{
			if (hitSurface)
			{
				changeToGasper();
			}
			else 
			{
				swimUp();
			}
		}
		
	}

}