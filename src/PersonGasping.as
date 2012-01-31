package  
{
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PersonGasping extends Person
	{
		public const MIN_FLOAT_X:Number = 0;			
		public const MAX_FLOAT_X:Number = 0;	// 20	
		public const MIN_FLOAT_Y:Number = Global.GASP_FLOAT_DISTANCE;		
		public const MAX_FLOAT_Y:Number = Global.GASP_FLOAT_DISTANCE;
		public const HANG_TIME:Number = 0; 	// Time at top of wave, before floating back down
		public const FLOAT_DURATION:Number = 1;	// Used INSTEAD of FLOAT_SPEED, depending on which you want to be constant
		
		public const MIN_ANGLE_CHANGE:Number = 0;
		public const MAX_ANGLE_CHANGE:Number = 0;
		
		public var floatXDirection:Number;
		public var floatX:Number;
		public var floatY:Number;
		public var angleChange:Number;
		
		public var mover:LinearMotion;
		public var angleChanger:AngleTween;
		public var scaleChanger:NumTween;
		
		public var firstGasp:Boolean = true;
		
		public function PersonGasping(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, angle, health, maxHealth);
		}
		
		override public function added():void
		{
			floatUp();
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
			
			if (scaleChanger)
			{
				image.scale = scaleChanger.value;
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
			mover = new LinearMotion(floatDown);
			addTween(mover);
			var quadFunc:Function;
			if (firstGasp)
			{
				quadFunc = Ease.quadOut;
			}
			else 
			{
				firstGasp = false;
				quadFunc = Ease.quadInOut;
			}			
			mover.setMotion(x, y, x + floatX, y - floatY, duration, quadFunc);
			
			//trace('floatX: ' + floatX);
			//trace('duration: ' + duration);			
			
			// Angle tween
			angleChange = MIN_ANGLE_CHANGE + FP.random * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
			angleChange *= -floatXDirection;
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, angleChange, duration, Ease.quadInOut);
			
			// Scale tween
			scaleChanger = new NumTween();
			addTween(scaleChanger);
			scaleChanger.tween(image.scale, Global.BREATH_SCALE_MAX, duration, Ease.quadInOut);
		}
		
		public function floatDown():void
		{
			//var duration:Number = floatY / FLOAT_SPEED;
			var duration:Number = FLOAT_DURATION * 1;
			mover = new LinearMotion(floatUp);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y + floatY, duration, Ease.quadInOut);	
			
			// Angle tween
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, -angleChange, duration, Ease.quadInOut);	
			
			// Scale tween
			scaleChanger = new NumTween();
			addTween(scaleChanger);
			scaleChanger.tween(image.scale, Global.BREATH_SCALE_MIN, duration, Ease.quadInOut);			
		}	
		
	}

}