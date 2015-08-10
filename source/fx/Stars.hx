package fx;
import flixel.group.FlxGroup;

/**
 * ...
 * @author x01010111
 */
class Stars extends FlxGroup
{

	public function new(AMOUNT_OF_STARS:Int = 16) 
	{
		super();
		for (i in 0...AMOUNT_OF_STARS)
		{
			add(new Star());
		}
	}
	
}