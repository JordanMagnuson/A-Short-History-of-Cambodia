package  
{
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PersonDrowning extends Person
	{
		public static const V_MAX:Number = 0.5;
		
		public var drowning:Boolean = false;
		public var a:Number = 0.001;
		public var v:Number = 0;	
		
		public var sndDeath:Sfx = new Sfx(Assets.SND_DEATH);
		
		public function PersonDrowning(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100, scale:Number = 1) 
		{
			super(x, y, angle, health, maxHealth);
			image.alpha = health / 100;		
			type = 'person_drowning';
		}
		
		override public function added():void
		{
			FP.alarm(0.5, playSound);
			FP.alarm(1, startDrowning);
		}
		
		public function playSound():void
		{
			sndDeath.play();
		}
		
		public function startDrowning():void
		{
			drowning = true;
		}
		
		override public function update():void
		{
			if (drowning)
			{
				if (y > FP.height + image.height)
					destroy();
					
				if (v < V_MAX)
					v += a;
				else if (v > V_MAX)
					v = V_MAX;
					
				y += v;
				health -= v / 10;
			}
			
			super.update();
		}
		
	}

}