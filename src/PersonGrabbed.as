package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PersonGrabbed extends Person
	{
		public var fading:Boolean = false;
		public var dead:Boolean = false;
		
		public function PersonGrabbed(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, angle, health, maxHealth);
			visible = false;
		}
		
		override public function update():void
		{
			x = FP.world.mouseX;
			y = FP.world.mouseY;
			
			if (y > floatLevel + Global.FLOAT_LEVEL_VARIATION)
			{
				if (health > Global.MIN_HEALTH)
					health -= Global.HEALTH_LOSS_RATE;
					
				if (health > 52)
				{
					if (!sndHeartbeat.playing) 
					{
						trace('loop heartbeat in');
						var vol:Number = 1 - FP.scaleClamp(health, Global.MIN_HEALTH, Global.BASE_HEALTH, 0, 1);
						sndHeartbeat.loop(vol);
						heartbeatFader.fadeTo(1, 6);
					}
				}
				else if (health > Global.MIN_HEALTH && !fading)
				{
					//heartbeatFader.fadeTo(0, 3);
					trace('stop heartbeat');
					fading = true;
					sndHeartbeat.stop();
					sndHeartbeatSingle.play();					
				}
				else if (health <= Global.MIN_HEALTH && !dead)
				{
					dead = true;
					health = Global.MIN_HEALTH - 1;

					//heartbeatFader.fadeTo(0, 0.5);
				}
			}
			else if (sndHeartbeat.playing)
			{
				heartbeatFader.fadeTo(0, 1);
			}
			
			super.update();
		}
		
		override public function removed():void
		{
			heartbeatFader.cancel();
			if (sndHeartbeat.playing)
			{
				sndHeartbeat.stop();
			}
			super.removed();
		}		
		
		//public function stopHeartbeat():void
		//{
			//sndHeartbeat.stop();
		//}
		//
		//override public function removed():void
		//{
			//sndHeartbeat.stop();
		//}
		
	}

}