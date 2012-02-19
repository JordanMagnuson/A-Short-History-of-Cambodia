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
				health -= Global.HEALTH_LOSS_RATE;
				if (health > Global.FADE_HEALTH)
				{
					if (!sndHeartbeat.playing) 
					{
						sndHeartbeat.loop();
					}
				}
				else if (health > Global.MIN_HEALTH && !fading)
				{
					heartbeatFader.fadeTo(0, 3);
					fading = true;
				}
				else if (health <= Global.MIN_HEALTH)
				{
					sndHeartbeat.stop();
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