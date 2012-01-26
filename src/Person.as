package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.Motion;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Person extends Entity
	{
		public const MIN_FLOAT_X:Number = 50;			
		public const MAX_FLOAT_X:Number = 100;	// 20	
		public const MIN_FLOAT_Y:Number = 10;		
		public const MAX_FLOAT_Y:Number = 60;
		public const HANG_TIME:Number = 0.01; 	// Time at top of wave, before floating back down
		public const FLOAT_SPEED:Number = 14;
		public const FLOAT_DURATION:Number = 3;	// Used INSTEAD of FLOAT_SPEED, depending on which you want to be constant
		
		public const MIN_ANGLE_CHANGE:Number = 0;
		public const MAX_ANGLE_CHANGE:Number = 20;
		
		public var floatXDirection:Number;
		public var floatX:Number;
		public var floatY:Number;
		public var angleChange:Number;
		
		public var mover:LinearMotion;
		public var angleChanger:AngleTween;
		
		public var image:Image = Image.createRect(10, 10, Colors.BLACK);
		public var phaseDelay:Number;
		
		public function Person(x:Number = 0, y:Number = 0, phaseDelay:Number = 0) 
		{
			image.centerOO();
			super(x, y, image);
			this.phaseDelay = phaseDelay;
		}
		
		override public function added():void
		{
			if (phaseDelay > 0) 
			{
				FP.alarm(phaseDelay, floatUp);
			}
			else 
			{
				floatUp();
			}
		}
		
		override public function update():void
		{
			if (mover) 
			{
				x = mover.x;
				y = mover.y;
			}
			if (angleChanger) 
			{
				image.angle = angleChanger.angle;
			}
			super.update();
		}
		
		public function floatUp():void
		{
			floatXDirection = FP.choose(-1, 1);
			floatX = MIN_FLOAT_X + FP.random * (MAX_FLOAT_X - MIN_FLOAT_X);
			floatX = floatX * floatXDirection;
			if (x + 2 * floatX < 0 || x + 2 * floatX > FP.width)
			{
				floatXDirection *= -1;
				floatX *= -1;
			}
			floatY = MIN_FLOAT_Y + FP.random * (MAX_FLOAT_Y - MIN_FLOAT_Y);
			trace('floatY: ' + floatY);
			var duration:Number = floatY / FLOAT_SPEED;
			mover = new LinearMotion(floatUpCallback);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y - floatY, FLOAT_DURATION, Ease.quadInOut);
			
			// Angle tween
			angleChange = MIN_ANGLE_CHANGE + FP.random * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
			angleChange *= -floatXDirection;
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, angleChange, FLOAT_DURATION, Ease.quadInOut);
		}
		
		public function floatDown():void
		{
			var duration:Number = floatY / FLOAT_SPEED;
			mover = new LinearMotion(floatDownCallback);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y + floatY, FLOAT_DURATION, Ease.quadInOut);	
			
			// Angle tween
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, -angleChange, FLOAT_DURATION, Ease.quadInOut);			
		}
		
		public function floatUpCallback():void
		{
			FP.alarm(HANG_TIME, floatDown);
		}
		
		public function floatDownCallback():void
		{
			FP.alarm(HANG_TIME, floatUp);
		}		
		
	}

}