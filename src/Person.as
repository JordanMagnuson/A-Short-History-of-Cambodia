package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Person extends Entity
	{
		public var image:Image = Image.createRect(Global.PERSON_WIDTH, Global.PERSON_HEIGHT, Colors.WHITE);
		public var health:Number;
		public var maxHealth:Number;
		public var floatLevel:Number;
		public var breathDirection:Number = 1;
		
		public var scared:Boolean = false;
		public var terrified:Boolean = false;
		public var shaking:Boolean = false;
		public var shakeAmount:Number = 0;
		
		public var scaredMover:LinearMotion;
		
		public var minY:Number;
		public var maxY:Number;
		
		public var sndHeartbeat:Sfx = new Sfx(Assets.SND_HEARTBEAT);
		public var heartbeatFader:SfxFader;		
		public var sndHeartbeatSingle:Sfx = new Sfx(Assets.SND_HEARTBEAT_SINGLE);
		
		public function Person(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100, scale:Number = 1) 
		{
			super(x, y, image);
			//setHitbox(image.width * 2, image.height * 2, image.width, image.height);
			type = 'person';
			image.color = Colors.BLACK;
			image.angle = angle;
			this.health = health;
			this.maxHealth = maxHealth;
			this.floatLevel = Global.WATER_LINE + FP.random * Global.FLOAT_LEVEL_VARIATION;
			//this.floatLevel = y;
			
			// Hitbox
			image.centerOO();
			setHitbox(image.width, image.height, image.originX, image.originY);	
			
			heartbeatFader = new SfxFader(sndHeartbeat);
		}
		
		override public function added():void
		{
			addTween(heartbeatFader);
			super.added();
		}
		
		override public function update():void
		{
			//if (health <= Global.MIN_HEALTH) image.alpha = health / 100;
			
			if (x < 0) x = 0;
			if (x > FP.width) x = FP.width;			
			
			// Last person commits suicide
			if (Global.peopleKilled >= Global.NUMBER_OF_PEOPLE - 1 && FP.distance(x, y, Global.mouseController.x, Global.mouseController.y) < Global.scareDistance)
			{
				trace('suicide attempt');
				if (this.getClass() != PersonDrowning)
				{
					trace('real suicide');
					FP.world.add(new PersonDrowning(x, y, image.angle, health, maxHealth, image.scale));
					this.destroy();
				}
			}
			
			super.update();
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		public function stopHearbeat():void
		{
			sndHeartbeat.stop();
		}
		
		public function scare():void
		{
			//if (Global.peopleKilled >= 3 && !Global.ambientController.started)
			//{
				//Global.ambientController.start();
			//}
			
			scared = true;
			scaredMover = new LinearMotion(scaredMoverCallback, ONESHOT);
			addTween(scaredMover);
			var xChange:Number = Global.MIN_SCARED_MOVE + FP.random * (Global.MAX_SCARED_MOVE - Global.MIN_SCARED_MOVE)
			if (x < Global.mouseController.x)
			{
				xChange *= -1;
			}
			if (x + xChange < halfWidth || x + xChange > FP.width - halfWidth)
			{
				xChange *= -1;
			}
			scaredMover.setMotionSpeed(x, y, x + xChange, y, Global.SCARE_MOVE_SPEED, Ease.quadInOut);	
		}
		
		public function scaredMoverCallback():void
		{
		}		
		
	}

}