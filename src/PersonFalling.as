package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PersonFalling extends Person
	{
		public static const V_MAX:Number = 100;	
		public static const ANGLE_CHANGE_RATE:Number = 1;
		public var a:Number = 0.1;
		public var aWater:Number = 0.15;
		public var v:Number = 0;		
		public var angleDirection:Number = FP.choose(1, -1);
		public var hitWater:Boolean = false;
		
		public var sndSplashUp:Sfx = new Sfx(Assets.SND_SPLASH_UP);
		public var sndSplashDown:Sfx = new Sfx(Assets.SND_SPLASH_DOWN);
		
		public function PersonFalling(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, angle, health, maxHealth);
		}
		
		override public function update():void
		{
			// Change to Swimmer
			if (hitWater && v <= 0)
			{
				changeToSwimmer();
			}

			// Fall
			if (y <= floatLevel)
			{
				if (v < V_MAX)
					v += a;
				else if (v > V_MAX)
					v = V_MAX;
					
				// Image angle
				image.angle += ANGLE_CHANGE_RATE * angleDirection;
			}
			// Hit water
			else 
			{
				if (!hitWater)
				{
					hitWater = true;
					sndSplashUp.play();
					sndSplashDown.play();
				}
				v -= aWater;
			}
				
			y += v;
			
			super.update();
		}
		
		public function changeToSwimmer():void
		{
			FP.world.add(new PersonSwimming(x, y, image.angle, health, maxHealth));
			this.destroy();			
		}
		
		//public function changeToGasper():void
		//{
			//var gasper:PersonGasping;
			//FP.world.add(gasper = new PersonGasping(x, y, image.angle, health, maxHealth));
			//this.destroy();
		//}		
		
	}

}