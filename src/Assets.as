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
		[Embed(source="../assets/sounds.swf", symbol="unclesigmund_breath_edited_looping.wav")] public static const SND_GASPING:Class;
		
	}

}