package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.Motion;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PersonFloating extends Person
	{
		public static const MIN_FLOAT_X:Number = 0;			
		public static const MAX_FLOAT_X:Number = 40;	// 20	
		public static const MIN_FLOAT_Y:Number = 10;		
		public static const MAX_FLOAT_Y:Number = 60;
		public static const HANG_TIME:Number = 0; 	// Time at top of wave, before floating back down
		//public const FLOAT_SPEED:Number = 14;
		public static const FLOAT_DURATION:Number = 3;	// Used INSTEAD of FLOAT_SPEED, depending on which you want to be constant
		
		public static const HEALTHY_BREATH_DURATION:Number = 3;
		public static const HEALTHY_BREATH_SCALE:Number = 0.1;
		public static const BREATH_SCALE_CHANGE:Number = 0.01;
		public static const BREATH_DURATION_CHANGE:Number = 0.1;		
		
		public static const MIN_ANGLE_CHANGE:Number = 0;
		public static const MAX_ANGLE_CHANGE:Number = 30;
		
		public var floatXDirection:Number;
		public var floatX:Number;
		public var floatY:Number;
		public var angleChange:Number;
		public var breathDuration:Number = 3;
		public var breathScale:Number = 0.1;		
		
		public var mover:LinearMotion;
		public var angleChanger:AngleTween;
		public var scaleChanger:NumTween;
	
		public var phaseDelay:Number;
		
		public function PersonFloating(x:Number = 0, y:Number = 0, phaseDelay:Number = 0) 
		{
			super(x, y);
			//type = 'person_floating';
			this.phaseDelay = phaseDelay;
		}
		
		override public function added():void
		{
			FP.alarm(FP.random * breathDuration, breatheIn);
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
			// Position
			if (mover) 
			{
				x = mover.x;
				y = mover.y;
			}
			
			// Angle
			if (angleChanger) 
			{
				image.angle = angleChanger.angle;
			}
			
			// Scale
			if (scaleChanger) 
			{
				image.scale = scaleChanger.value;
			}			
			super.update();
		}
		
		public function breatheIn():void
		{
			//trace('breathe in');
			breathDirection = 1;
			scaleChanger = new NumTween(breatheOut);
			addTween(scaleChanger);
			scaleChanger.tween(image.scale, 1 + breathScale, breathDuration, Ease.quadInOut);	
		}
		
		public function breatheOut():void
		{
			//trace('breathe out');
			breathDirection = -1;
			scaleChanger = new NumTween(breatheIn);
			addTween(scaleChanger);
			scaleChanger.tween(image.scale, 1 - breathScale, breathDuration, Ease.quadInOut);	
			
			if (breathScale > HEALTHY_BREATH_SCALE)
				breathScale -= BREATH_SCALE_CHANGE;
			else	
				breathScale = HEALTHY_BREATH_SCALE;
			if (breathDuration < HEALTHY_BREATH_DURATION)
				breathDuration += BREATH_DURATION_CHANGE;	
			else
				breathDuration = HEALTHY_BREATH_DURATION;
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
			floatY = -1 * (MIN_FLOAT_Y + FP.random * (MAX_FLOAT_Y - MIN_FLOAT_Y));
			//var duration:Number = floatY / FLOAT_SPEED;
			var duration:Number = FLOAT_DURATION + floatX / Global.PHASE_DELAY_DIVIDER;
			mover = new LinearMotion(floatUpCallback);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y + floatY, duration, Ease.quadInOut);
			
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
			floatY *= -1;
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