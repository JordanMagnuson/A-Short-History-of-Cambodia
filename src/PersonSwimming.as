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
		public var canBeScared:Boolean = false;
		
		public function PersonSwimming(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, angle, health, maxHealth);
		}
		
		override public function update():void
		{
			// Scare
			if (canBeScared && FP.distance(x, y, Global.mouseController.x, Global.mouseController.y) < Global.scareDistance && !scared)
			{
				scare();
			}			
			
			if (!sndHeartbeat.playing)
			{
				sndHeartbeat.loop();
			}			
			
			if (health > Global.MIN_HEALTH)
			{
				health -= Global.HEALTH_LOSS_RATE;
			}
			else
			{
				FP.world.add(new PersonDrowning(x, y, image.angle, health, maxHealth, image.scale));
				sndHeartbeat.stop();
				this.destroy();
			}
			
			if (mover && scaredMover && scared)
			{
				x = scaredMover.x;
				y = mover.y;
			}					
			else if (mover) 
			{
				x = mover.x;
				y = mover.y;
			}			
			super.update();
		}
		
		override public function added():void
		{
			FP.alarm(1, allowScare);
			swimUp();
			super.added();
		}
		
		public function allowScare():void
		{
			canBeScared = true;
		}
		
		override public function scaredMoverCallback():void
		{
			mover.cancel();
			scared = false;
			terrified = false;
			trace('scared mover callback');
			//mover.x = x;
			swimUp();
			//scared = false;
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
			var gasper:PersonGasping;
			FP.world.add(gasper = new PersonGasping(x, y, image.angle, health, maxHealth));
			gasper.sndHeartbeat = this.sndHeartbeat;
			this.destroy();
		}
		
		//public function changeToFloater():void
		//{
			//var floater:PersonFloating;
			//FP.world.add(floater = new PersonFloating(x, y, image.angle, health, maxHealth, ));
			//gasper.sndHeartbeat = this.sndHeartbeat;
			//this.destroy();			
		//}
		
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
		
		// TODO: this makes it so gasper doesn't pick up on heartbeat... need to pass sndHeartbeat on to gasper
		// but if we don't do this, there's a problem if you grab a swimmer who's already swimming.
		override public function removed():void
		{
			heartbeatFader.cancel();
			if (sndHeartbeat.playing)
			{
				sndHeartbeat.stop();
			}
			super.removed();
		}				
		
	}

}