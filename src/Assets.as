package  
{
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Assets 
	{
		// Misc
		[Embed(source = "../assets/background.png")] public static const BACKGROUND:Class;
		[Embed(source = "../assets/bubble.png")] public static const BUBBLE:Class;
		
		// Cursor images
		[Embed(source = "../assets/hand_cursor_open.png")] public static const HAND_CURSOR_OPEN:Class;
		[Embed(source = "../assets/hand_cursor_closed.png")] public static const HAND_CURSOR_CLOSED:Class;
		
		// Wave images
		[Embed(source = "../assets/wave_01.png")] public static const WAVE_01:Class;
		[Embed(source = "../assets/wave_02.png")] public static const WAVE_02:Class;
		[Embed(source = "../assets/wave_03.png")] public static const WAVE_03:Class;
		public static const WAVE_ARRAY:Array = new Array(WAVE_01, WAVE_02, WAVE_03);
		
		// Sounds
		[Embed(source = "../assets/sounds.swf", symbol = "pcaeldries_tide_23454.wav")] public static const SND_WAVES:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "jobro_dramatic_piano_2.wav")] public static const SND_GRAB:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "gabemiller74_breathofdeath.aif")] public static const SND_DEATH:Class;
		[Embed(source="../assets/sounds.swf", symbol="robinhood76__01260_water_swimming_splashing_1_edited_fading.wav")] public static const SND_SPLASH_UP:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "unclesigmund_breath_edited_looping.wav")] public static const SND_GASPING:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "heart_getting_faster_32424.wav")] public static const SND_HEARTBEAT:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "heartbeat_single_32424.wav")] public static const SND_HEARTBEAT_SINGLE:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "water_plunge_17755.wav")] public static const SND_WATER_PLUNGE:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "drowning_45521.wav")] public static const SND_DROWNING:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "splash_down_9508.wav")] public static const SND_SPLASH_DOWN:Class;
		
		// Ambient
		[Embed(source = "../assets/sounds.swf", symbol = "hell_01_33703.wav")] public static const SND_HELL_01:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "hell_02_38965.wav")] public static const SND_HELL_02:Class;
		[Embed(source = "../assets/sounds.swf", symbol = "hell_03_39222.wav")] public static const SND_HELL_03:Class;
		
		// Music
		//[Embed(source = "../assets/low_murderer.mp3")] public static const MUS_MURDERER:Class;
		
		// Game over
		[Embed(source = "../assets/curtain.png")] public static const CURTAIN:Class;
		[Embed(source = "../assets/end_screen.png")] public static const END_SCREEN:Class;
	}

}