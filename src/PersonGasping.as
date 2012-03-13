package  
{
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PersonGasping extends Person
	{
		public static const GASP_FLOAT_DISTANCE:Number = 10;	
		
		public static const MIN_FLOAT_X:Number = 0;			
		public static const MAX_FLOAT_X:Number = 0;	// 20	
		public static const MIN_FLOAT_Y:Number = GASP_FLOAT_DISTANCE;		
		public static const MAX_FLOAT_Y:Number = GASP_FLOAT_DISTANCE;
		public static const HANG_TIME:Number = 0; 	// Time at top of wave, before floating back down
		public static const FLOAT_DURATION:Number = 1;	// Used INSTEAD of FLOAT_SPEED, depending on which you want to be constant
		
		public static const MIN_ANGLE_CHANGE:Number = 0;
		public static const MAX_ANGLE_CHANGE:Number = 0;
		
		//public static const BREATH_SCALE_CHANGE:Number = 0.01;
		//public static const BREATH_DURATION_CHANGE:Number = 0.1;
			
		
		public var floatXDirection:Number;
		public var floatX:Number;
		public var floatY:Number;
		public var angleChange:Number;
		public var breathDuration:Number = 0.5;
		public var breathScale:Number = 0.3;
		
		public var mover:LinearMotion;
		public var angleChanger:AngleTween;
		public var scaleChanger:NumTween;
		
		public var firstGasp:Boolean = true;
		public var healthyAgain:Boolean = false;
		
		public var sndSplashUp:Sfx = new Sfx(Assets.SND_SPLASH_UP);
		public var sndGasping:Sfx = new Sfx(Assets.SND_GASPING);
		public var sndGaspingFader:SfxFader;
		
		public function PersonGasping(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, angle, health, maxHealth);
			image.alpha = health / 100;
			sndGaspingFader = new SfxFader(sndGasping, destroy);
		}
		
		override public function added():void
		{
			floatDown();
			breatheIn(0.1);
			sndSplashUp.play(0.5);
			
			// heartbeat
			heartbeatFader = new SfxFader(sndHeartbeat, stopHearbeat);
			addTween(heartbeatFader);
			heartbeatFader.fadeTo(0, 2);
			//FP.alarm(0.1, playGaspingSound);
		}
		
		public function playGaspingSound():void
		{
			sndGasping.loop(0.2);
		}
		
		override public function update():void
		{
			
			// Scare
			if (FP.distance(x, y, Global.mouseController.x, Global.mouseController.y) < Global.scareDistance && !scared)
			{
				scare();
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
			x += FP.choose(shakeAmount, -shakeAmount);
			y += FP.choose(shakeAmount, -shakeAmount);
			
			if (angleChanger) 
			{
				image.angle = angleChanger.angle;
			}
			
			if (scaleChanger)
			{
				image.scale = scaleChanger.value;
			}
			
			if (health < maxHealth)
			{
				health += Global.HEALTH_GAIN_RATE;
			}
			else if (!healthyAgain)
			{
				healthyAgain = true;
				health = maxHealth;
				var floatDelay:Number = getFloaterDelay();
				FP.alarm(floatDelay, changeToFloater);
			}
			
			super.update();
		}		
		
		override public function scaredMoverCallback():void
		{
			if (FP.distance(x, y, Global.mouseController.x, Global.mouseController.y) < Global.scareDistanceAfter)
			{
				scare();
			}
			else
			{
				mover.cancel();
				scared = false;
				terrified = false;
				trace('scared mover callback');
				//mover.x = x;
				if (y > floatLevel)
					floatUp();
				else
					floatDown();
				//scared = false;
			}
		}			
		
		public function getFloaterDelay():Number
		{
			trace('get floater delay');
			var floatingList:Array = [];
			FP.world.getClass(PersonFloating, floatingList);
			if (floatingList.length > 0) 
			{
				for each (var p:PersonFloating in floatingList)
				{
					var percent:Number;
					if (p.mover) percent = p.mover.percent;
					else percent = 0;
					var phaseDelay:Number;
					//p.image.scale = 5;
					trace('percent: ' + percent);
					if (p.x < x)
					{
						trace('p to the left');
						trace('p.floatY: ' + p.floatY);
						if (p.floatY < 0)
							phaseDelay = (x - p.x) / Global.PHASE_DELAY_DIVIDER + (1 - p.mover.percent) * PersonFloating.FLOAT_DURATION + PersonFloating.FLOAT_DURATION;
						else
							phaseDelay = (x - p.x) / Global.PHASE_DELAY_DIVIDER + (1 - p.mover.percent) * PersonFloating.FLOAT_DURATION;
					}
					else
					{
						trace('p to the right');
						trace('p.floatY: ' + p.floatY);					
						if (p.floatY < 0)
							phaseDelay = (1 - p.mover.percent) * PersonFloating.FLOAT_DURATION + PersonFloating.FLOAT_DURATION - (p.x - x) / Global.PHASE_DELAY_DIVIDER;
						else
							phaseDelay = (1 - p.mover.percent) * PersonFloating.FLOAT_DURATION - (p.x - x) / Global.PHASE_DELAY_DIVIDER;
						while (phaseDelay < 0)
						{
							phaseDelay += (PersonFloating.FLOAT_DURATION * 2);
							trace('adding 4 seconds');
						}
					}	
					break;
				}	
				trace('phasedelay: ' + phaseDelay);
				return(phaseDelay + PersonFloating.FLOAT_DURATION * 4);
			}
			return 0;
		}
		
		public function changeToFloater():void
		{
			trace('changetofloater');
			addTween(sndGaspingFader);
			sndGaspingFader.fadeTo(0, 10, Ease.quadIn);
			
			var floater:PersonFloating = FP.world.add(new PersonFloating(x, y)) as PersonFloating;
			floater.breathDuration = this.breathDuration;
			floater.breathScale = this.breathScale;
			floater.image.scale = this.image.scale;
			floater.terrify();
			floater.shakeAmount = this.shakeAmount;
			//if (breathDirection == 1)
			//{
				//trace('breathdirection = 1');
				//floater.breatheIn();
				//floater.scaleChanger.percent = this.scaleChanger.percent;
			//}
			//else 
			//{
				//floater.breatheOut();
				//floater.scaleChanger.percent = this.scaleChanger.percent;				
			//}
			
			//this.type = 'inactive';
			//this.visible = false;
			this.destroy();
		}
		
		public function breatheIn(duration:Number = 0):void
		{
			breathDirection = 1;
			//trace('breathe in');
			if (duration == 0) 
				duration = breathDuration;
			// Scale tween
			scaleChanger = new NumTween(breatheOut);
			addTween(scaleChanger);
			scaleChanger.tween(image.scale, 1 + breathScale, duration, Ease.quadInOut);	
		}
		
		public function breatheOut():void
		{
			breathDirection = -1;
			//trace('breathe out');
			// Scale tween
			scaleChanger = new NumTween(breatheIn);
			addTween(scaleChanger);
			scaleChanger.tween(image.scale, 1 - breathScale, breathDuration, Ease.quadInOut);	
			
			//breathScale -= BREATH_SCALE_CHANGE;
			//breathDuration += BREATH_DURATION_CHANGE;			
		}
		
		public function floatDown():void
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
			mover = new LinearMotion(floatUp);
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
			mover.setMotion(x, y, x + floatX, y + floatY, duration, quadFunc);
			
			//trace('floatX: ' + floatX);
			//trace('duration: ' + duration);			
			
			// Angle tween
			angleChange = MIN_ANGLE_CHANGE + FP.random * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
			angleChange *= -floatXDirection;
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, angleChange, duration, Ease.quadInOut);
		}
		
		public function floatUp():void
		{
			//var duration:Number = floatY / FLOAT_SPEED;
			var duration:Number = FLOAT_DURATION * 1;
			mover = new LinearMotion(floatDown);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y - floatY, duration, Ease.quadInOut);	
			
			// Angle tween
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, -angleChange, duration, Ease.quadInOut);		
		}	
		
		//override public function removed():void
		//{
			//heartbeatFader.cancel();
			//if (sndHeartbeat.playing)
			//{
				//sndHeartbeat.stop();
			//}
			//super.removed();
		//}		
		
	}

}