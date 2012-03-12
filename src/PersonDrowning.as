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
		public static const MIN_BUBBLES:Number = 2;
		public static const MAX_BUBBLES:Number = 4;
		
		public var drowning:Boolean = false;
		public var angleDirection:Number;
		public var a:Number = 0.001;
		public var v:Number = 0;
		
		public var bubblesToRelease:Number;
		public var bubblesReleased:Number = 0;
		
		public var sndDeath:Sfx = new Sfx(Assets.SND_DEATH);
		
		public function PersonDrowning(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100, scale:Number = 1) 
		{
			super(x, y, angle, health, maxHealth);
			image.alpha = health / 100;		
			type = 'person_drowning';
			angleDirection = FP.choose( -1, 1);
			bubblesToRelease = MIN_BUBBLES + FP.rand(MAX_BUBBLES - MIN_BUBBLES + 1);
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
			FP.alarm(1.5, releaseBubble);
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
				image.angle += 0.1 * angleDirection;
			}
			
			super.update();
		}
		
		public function releaseBubble():void
		{
			if (bubblesReleased < bubblesToRelease)
			{
				var xLoc:Number = x + FP.random * image.width / 2 * FP.choose(1, -1);
				var yLoc:Number = y - FP.random * image.width;
				FP.world.add(new Bubble(xLoc, yLoc));		
				FP.alarm(2, releaseBubble);
				bubblesReleased += 1;
			}
		}
		
	}

}