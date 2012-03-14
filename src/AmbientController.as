package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author ...
	 */
	public class AmbientController extends Entity
	{
		//public static const MIN_DELAY:Number = 10;
		//public static const MAX_DELAY:Number = 20;
		public static const FADE_IN_DURATION:Number = 10;
		//public static const MIN_PLAY_DURATION:Number = 20;
		//public static const MAX_PLAY_DURATION:Number = 30;
		
		public var sndHell01:Sfx = new Sfx(Assets.SND_HELL_01);
		public var sndHell02:Sfx = new Sfx(Assets.SND_HELL_02);
		public var sndHell03:Sfx = new Sfx(Assets.SND_HELL_03);
		
		public var lastSound:Sfx;
		public var currentSound:Sfx;
		public var fadeOutPosition:Number;
		
		public var started:Boolean = false;
		public var startedFade:Boolean = false;
		
		//public var sound01Played:Boolean = false;
		//public var sound02Played:Boolean = false;
		//public var sound03played:Boolean = false;
		
		public var soundFader:SfxFader;
		
		public var specificSoundFadeAlarm:Alarm;
		
		public function AmbientController() 
		{
			trace('ambient controller online');
		}
		
		override public function update():void
		{
			//if (started && currentSound.complete)
			//{
				//playSound();
			//}
			if (started && currentSound.position >= fadeOutPosition && !startedFade)
			{
				fadeSound();
			}
			
			super.update();
		}
		
		public function start():void
		{
			started = true;
			playSound();
		}
		
		public function fadeOut(duration:Number = 10):void
		{
			if (soundFader) soundFader.cancel();
			soundFader = new SfxFader(currentSound, destroy, ONESHOT);
			addTween(soundFader);
			soundFader.fadeTo(0, duration); 				
		}
		
		public function playSpecificSound(sound:Sfx):void
		{
			if (specificSoundFadeAlarm) specificSoundFadeAlarm.cancel();
			if (currentSound && currentSound.playing) currentSound.stop();
			trace('play specific sound');
			currentSound = sound;
			fadeOutPosition = currentSound.length - FADE_IN_DURATION;
			currentSound.play(0);
			soundFader = new SfxFader(currentSound, null, ONESHOT);
			addTween(soundFader);
			soundFader.fadeTo(1, FADE_IN_DURATION); 	
			
			// Set fade out
			var fadeTime:Number = currentSound.length - FADE_IN_DURATION;
			specificSoundFadeAlarm = new Alarm(fadeTime, fadeSpecificSound, ONESHOT);
			addTween(specificSoundFadeAlarm, true);
		}
		
		public function fadeSpecificSound():void
		{		
			trace('fade specific sound');
			lastSound = currentSound;
			startedFade = true;
			soundFader = new SfxFader(currentSound, null, ONESHOT);
			addTween(soundFader);
			soundFader.fadeTo(0, FADE_IN_DURATION); 			
		}
		
		public function playSound():void
		{
			if (Global.peopleKilled >= Global.NUMBER_OF_PEOPLE)
				return;
				
			if (specificSoundFadeAlarm) specificSoundFadeAlarm.cancel();
			if (currentSound && currentSound.playing) currentSound.stop();			
			trace('play sound');
			startedFade = false;
			do 
			{
				currentSound = FP.choose(sndHell01, sndHell02, sndHell03);
			} while (currentSound == lastSound);
			fadeOutPosition = currentSound.length - FADE_IN_DURATION;
			currentSound.play(0);
			soundFader = new SfxFader(currentSound, null, ONESHOT);
			addTween(soundFader);
			soundFader.fadeTo(1, FADE_IN_DURATION); 
		}
		
		public function fadeSound():void
		{
			trace('fade sound');
			lastSound = currentSound;
			startedFade = true;
			soundFader = new SfxFader(currentSound, playSound, ONESHOT);
			addTween(soundFader);
			soundFader.fadeTo(0, FADE_IN_DURATION); 		
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}