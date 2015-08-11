package fx;
import flixel.FlxG;
import flixel.FlxSprite;
import util.Colors;

/**
 * ...
 * @author x01010111
 */
class Star extends FlxSprite
{

	public function new() 
	{
		super(Math.random() * FlxG.width, Math.random() * FlxG.height);
		if (Math.random() > 0.5)
		{
			makeGraphic(1, 1, Colors.KCMW[3]);
			velocity.y = Math.random() * 10 + 50;
		}
		else
		{
			makeGraphic(2, 2, Colors.KCMW[3]);
			velocity.y = Math.random() * 20 + 100;
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (y > FlxG.height) setPosition(Math.random() * FlxG.width);
		super.update(elapsed);
	}
	
}