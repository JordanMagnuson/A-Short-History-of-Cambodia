package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameEndController extends Entity
	{
		public const MUSIC_IN_DELAY:Number = 20;
		public const MUSIC_FADE_IN_DURATION:Number = 30;
		
		public var music:Sfx;
		public var musicFader:SfxFader;
		public var waveFader:SfxFader;
		
		public function GameEndController() 
		{
			//music = new Sfx(Assets.MUS_MURDERER, fadeOut);
		}
		
		override public function added():void
		{	
			trace('gameEndController added');
			if (Global.ambientController.started) Global.ambientController.fadeOut(40);
			//FP.alarm(MUSIC_IN_DELAY, startMusic);
			
			// Fade out waves
			//waveFader = new SfxFader(Game.sndWaves, null, ONESHOT);
			//addTween(waveFader);
			//waveFader.fadeTo(0, 40);		

			super.added();
		}
		
		public function startMusic():void
		{
			musicFader = new SfxFader(music, null, ONESHOT);
			addTween(musicFader);
			music.play(0);
			musicFader.fadeTo(1, MUSIC_FADE_IN_DURATION);			
		}
		
		public function fadeOut():void
		{
			FP.world.add(new FadeOut(GameOver, Colors.BLACK, 10, 0));
		}
		
		public function placeGhosts():void
		{
			
		}
		
	}

}