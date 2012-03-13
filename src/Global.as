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
		public static const NUMBER_OF_PEOPLE:Number = 8;
		public static const PHASE_DELAY_DIVIDER:Number = 200;	// for each pixel to the right, a person's wave phase is delayed by 1/200 of a second
		
		public static const PERSON_WIDTH:Number = 10;
		public static const PERSON_HEIGHT:Number = 10;
		public static const BASE_HEALTH:Number = 100;
		public static const HEALTH_VARIATION:Number = 25;
		public static const MIN_HEALTH:Number = 50;
		public static const FADE_HEALTH:Number = 60; 					// Health at which person starts to fade (lose heartbeat strength, etc.)
		public static const HEALTH_LOSS_RATE:Number = 0.05; 			// Health lost per second while under water. 0.05
		public static const HEALTH_GAIN_RATE:Number = 0.1; 	
		
		public static const BREATH_SCALE_MIN:Number = 0.8;
		public static const BREATH_SCALE_MAX:Number = 1.2;
		
		public static const MIN_SCARED_MOVE:Number = 40;	// 70
		public static const MAX_SCARED_MOVE:Number = 80;	// 150
		public static const SCARE_MOVE_SPEED:Number = 125;
		public static const DEAD_BEFORE_SCARE:Number = 1;	// 1
		public static const DEAD_BEFORE_ALWAYS_SACRED:Number = 5;
		public static var scareDistance:Number = 20;
		public static var scareDistanceAfter:Number = 80; 	// How far blocks will move to (from hand) once scared
		
		// Global variables
		public static var t:Number = 0;							// Time elapsed since start of game
		public static var peopleKilled:Number = 0;
		public static var startedShaking:Boolean = false;
		public static var shakeAmount:Number = 0.3;
		//public static var k:Number = 2 * Math.PI / WAVE_LENGTH;
		
		// Global entities
		public static var mouseController:MouseController;
		public static var floatController:FloatController;
		public static var personGrabbed:Person;
		public static var bloodOverlay:BloodOverlay;
		public static var ambientController:AmbientController;
	}

}