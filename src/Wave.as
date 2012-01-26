package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Wave extends Entity
	{
		public var image:Image;
	
		public var fadeInComplete:Boolean = false;		
		public var fadeTween:ColorTween;
		
		public function Wave(x:Number = 0, y:Number = 0, alpha:Number = 0) 
		{
			FP.shuffle(Assets.WAVE_ARRAY);
			image = new Image(Assets.WAVE_ARRAY[0]);
			//image.flipped = FP.choose(true, false);
			image.centerOO();
			super(x, y, image);
			
			image.alpha = alpha;		
		}
		
		override public function added():void
		{
		}
		
		override public function update():void
		{
			if (image && fadeTween) image.alpha = fadeTween.alpha;
			super.update();
		}			
		
		public function fadeInCallback():void
		{
			fadeInComplete = true;
		}			
		
		public function fadeIn(duration:Number):void
		{
			if (duration > 0) 
			{
				fadeTween = new ColorTween(fadeInCallback);
				addTween(fadeTween);		
				fadeTween.tween(duration, Colors.WHITE, Colors.WHITE, 0, 1, Ease.quadInOut);
			}
			else 
			{
				image.alpha = 1;
			}
		}	
		
		public function fadeOut(duration:Number):void
		{
			if (duration > 0)
			{
				fadeTween = new ColorTween(destroy);
				addTween(fadeTween);		
				fadeTween.tween(duration, Colors.WHITE, Colors.WHITE, image.alpha, 0, Ease.quadInOut);		
			}
			else
			{
				destroy();
			}			
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}				
		
	}

}