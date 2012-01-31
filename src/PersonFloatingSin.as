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
	public class PersonFloatingSin extends Person
	{
		public const MIN_FLOAT_X:Number = 0;			
		public const MAX_FLOAT_X:Number = 40;	// 20	
		public const MIN_FLOAT_Y:Number = 10;		
		public const MAX_FLOAT_Y:Number = 60;
		public const HANG_TIME:Number = 0; 	// Time at top of wave, before floating back down
		public const FLOAT_SPEED:Number = 14;
		public const FLOAT_DURATION:Number = 3;	// Used INSTEAD of FLOAT_SPEED, depending on which you want to be constant
		
		public const MIN_ANGLE_CHANGE:Number = 0;
		public const MAX_ANGLE_CHANGE:Number = 30;
		
		public var floatXDirection:Number;
		public var floatX:Number;
		public var floatY:Number;
		public var angleChange:Number;
		
		public var mover:LinearMotion;
		public var angleChanger:AngleTween;
	
		public var yLast:Number;
		public var phaseDelay:Number;
		public var floatLevel:Number;
		public var floatHeight:Number;
		
		public function PersonFloatingSin(x:Number = 0, y:Number = 0, phaseDelay:Number = 0) 
		{
			super(x, y);
			//type = 'person_floating';
			this.phaseDelay = phaseDelay;
			this.floatLevel = Global.WATER_LINE + FP.choose( -1, 1) * Global.FLOAT_LEVEL_VARIATION;
			this.floatHeight = MIN_FLOAT_Y + FP.random * (MAX_FLOAT_Y - MIN_FLOAT_Y);
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
				//x = mover.x;
				//y = mover.y;
			}
			yLast = y;
			//trace('yLast: ' + yLast);	
			y = Global.WATER_LINE - floatHeight * Math.sin(Global.k * x - Global.t);
			//trace('y: ' + y);
						
			if (y <= Global.WATER_LINE && yLast > Global.WATER_LINE)
			{

				//floatHeight = FP.choose(5, 50);
				floatHeight = MIN_FLOAT_Y + FP.random * (MAX_FLOAT_Y - MIN_FLOAT_Y);
			}
			//y = Global.floatController.u(x);
			
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
			//var duration:Number = floatY / FLOAT_SPEED;
			var duration:Number = FLOAT_DURATION + floatX / Global.PHASE_DELAY_DIVIDER;
			mover = new LinearMotion(floatUpCallback);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y - floatY, duration, Ease.quadInOut);
			
			//trace('floatX: ' + floatX);
			//trace('duration: ' + duration);			
			
			// Angle tween
			angleChange = MIN_ANGLE_CHANGE + FP.random * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
			angleChange *= -floatXDirection;
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, angleChange, duration, Ease.quadInOut);
		}
		
		public function floatDown():void
		{
			//var duration:Number = floatY / FLOAT_SPEED;
			var duration:Number = FLOAT_DURATION + floatX / Global.PHASE_DELAY_DIVIDER;
			mover = new LinearMotion(floatDownCallback);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y + floatY, duration, Ease.quadInOut);	
			
			// Angle tween
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, -angleChange, duration, Ease.quadInOut);			
		}
		
		public function floatUpCallback():void
		{
			if (HANG_TIME > 0)
			{
				FP.alarm(HANG_TIME, floatDown);
			}
			else 
			{
				floatDown();
			}
		}
		
		public function floatDownCallback():void
		{
			if (HANG_TIME > 0)
			{
				FP.alarm(HANG_TIME, floatUp);
			}
			else 
			{
				floatUp();
			}			
		}		
		
	}

}