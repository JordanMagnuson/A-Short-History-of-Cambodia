package  
{
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Global 
	{
		// Constants
		public static const WATER_LINE:Number = 100;		
		public static const FLOAT_LEVEL_VARIATION:Number = 40;
		public static const NUMBER_OF_PEOPLE:Number = 20;
		public static const PHASE_DELAY_DIVIDER:Number = 200;	// for each pixel to the right, a person's wave phase is delayed by 1/200 of a second
		
		public static const PERSON_WIDTH:Number = 10;
		public static const PERSON_HEIGHT:Number = 10;
		public static const BASE_HEALTH:Number = 100;
		public static const HEALTH_VARIATION:Number = 25;
		public static const HEALTH_LOSS_RATE:Number = 10; 			// Health lost per second while under water.
		
		public static const GASP_FLOAT_DISTANCE:Number = 10;
		public static const BREATH_SCALE_MIN:Number = 0.8;
		public static const BREATH_SCALE_MAX:Number = 1.2;
		
		// Global variables
		public static var t:Number = 0;							// Time elapsed since start of game
		//public static var k:Number = 2 * Math.PI / WAVE_LENGTH;
		
		// Global entities
		public static var floatController:FloatController;
		public static var personGrabbed:Person;
	}

}