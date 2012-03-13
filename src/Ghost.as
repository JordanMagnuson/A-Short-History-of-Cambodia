package  
{
	/**
	 * ...
	 * @author ...
	 */
	public class Ghost extends PersonFloating
	{
		
		public function Ghost(x:Number = 0, y:Number = 0, phaseDelay:Number = 0) 
		{
			super(x, y);
			type = 'ghost';
			this.phaseDelay = phaseDelay;
			
			this.maxY = y + 10;
			this.minY = y - MAX_FLOAT_Y - 10;		
		}
		
	}

}