package  
{
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Global 
	{
		public static const WATER_LINE:Number = 100;		
		public static const NUMBER_OF_PEOPLE:Number = 20;
		public static const PHASE_DELAY_DIVIDER:Number = 200;	// for each pixel to the right, a person's wave phase is delayed by 1/200 of a second
		
		public static const PERSON_WIDTH:Number = 10;
		public static const PERSON_HEIGHT:Number = 10;
		public static const BASE_HEALTH:Number = 100;
		public static const HEALTH_VARIATION:Number = 25;
		public static const CHOKE_RATE:Number = 10; 		// Health lost per second while under water.
		
		public static var personGrabbed:Person;
	}

}