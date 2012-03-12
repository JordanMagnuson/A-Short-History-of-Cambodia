package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * ...
	 * @author ...
	 */
	public class BloodOverlay extends Entity
	{
		public static const TWEEN_DURATION:Number = 2;
		
		public var canvas:Canvas = new Canvas(FP.width, FP.height);
		public var colorTween:ColorTween;
		
		public function BloodOverlay() 
		{
			canvas.fill(new Rectangle(0, 0, FP.width, FP.height), Colors.BLOOD_RED, 1);
			canvas.alpha = 0;
			super(0, 0, canvas);
			layer = -2000;	
			
			colorTween = new ColorTween();
			colorTween.alpha = 0;
		}
		
		override public function added():void
		{
			addTween(colorTween);
		}
		
		override public function update():void
		{
			canvas.alpha = colorTween.alpha;
			super.update();
		}
		
		public function updateAlpha():void
		{
			var newAlpha:Number = Math.pow(Global.peopleKilled, 0.7) / 10;
			colorTween.tween(TWEEN_DURATION, Colors.WHITE, Colors.WHITE, canvas.alpha, newAlpha);
		}
		
	}

}