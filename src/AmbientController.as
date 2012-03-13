package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AmbientController extends Entity
	{
		public static const MIN_DELAY:Number = 10;
		public static const MAX_DELAY:Number = 20;
		public static const FADE_IN_DURATION:Number = 10;
		public static const MIN_PLAY_DURATION:Number = 20;
		public static const MAX_PLAY_DURATION:Number = 30;
		
		public var sndHell01:Sfx = new Sfx(Assets.SND_HELL_01);
		public var sndHell02:Sfx = new Sfx(Assets.SND_HELL_02);
		public var sndHell03:Sfx = new Sfx(Assets.SND_HELL_03);
		
		public var sound01Played:Boolean = false;
		public var sound02Played:Boolean = false;
		public var sound03played:Boolean = false;
		
		public var soundFader:SfxFader;
		
		public function AmbientController() 
		{
			trace('ambient controller online');
		}
		
		override public function update():void
		{
			if (Global.peopleKilled >= 2 && !sound01Played)
			{
				trace('ready sound01');
				FP.alarm(MIN_DELAY + FP.random * (MAX_DELAY - MIN_DELAY), playSound01);
				sound01Played = true;
			}
			else if (Global.peopleKilled >= 5 && !sound02Played && !sndHell01.playing)
			{
				trace('ready sound02');
				FP.alarm(MIN_DELAY + FP.random * (MAX_DELAY - MIN_DELAY), playSound02);
				sound02Played = true;
			}			
		}
		
		public function fadeSound():void
		{
			trace('fade ambient sound');
			soundFader.fadeTo(0, FADE_IN_DURATION);			
		}		
		
		public function playSound01():void
		{
			trace('play sound01');
			soundFader = new SfxFader(sndHell01);
			addTween(soundFader);
			sndHell01.play(0);
			soundFader.fadeTo(1, FADE_IN_DURATION);
			FP.alarm(MIN_PLAY_DURATION + FP.random * (MAX_PLAY_DURATION - MIN_PLAY_DURATION), fadeSound);
		}
		
		public function playSound02():void
		{
			trace('play sound02');
			soundFader = new SfxFader(sndHell02);
			addTween(soundFader);
			sndHell02.play(0);
			soundFader.fadeTo(1, FADE_IN_DURATION);
			FP.alarm(MIN_PLAY_DURATION + FP.random * (MAX_PLAY_DURATION - MIN_PLAY_DURATION), fadeSound);
		}	
		
	}

}