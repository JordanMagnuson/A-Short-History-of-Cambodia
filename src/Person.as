package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Person extends Entity
	{
		public var image:Image = Image.createRect(Global.PERSON_WIDTH, Global.PERSON_HEIGHT, Colors.BLACK);
		public var health:Number;
		public var maxHealth:Number;
		public var floatLevel:Number;
		
		public function Person(x:Number = 0, y:Number = 0, angle:Number = 0, health:Number = 100, maxHealth:Number = 100) 
		{
			super(x, y, image);
			//setHitbox(image.width * 2, image.height * 2, image.width, image.height);
			type = 'person';
			image.angle = angle;
			this.health = health;
			this.maxHealth = maxHealth;
			this.floatLevel = Global.WATER_LINE + FP.random * Global.FLOAT_LEVEL_VARIATION;
			
			// Hitbox
			image.centerOO();
			setHitbox(image.width, image.height, image.originX, image.originY);			
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}