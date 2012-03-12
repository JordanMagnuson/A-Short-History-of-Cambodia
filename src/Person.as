package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	
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
			image.alpha = health / 100;
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
		
	}

}