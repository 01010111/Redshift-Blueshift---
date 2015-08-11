package fx;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import states.PlayState;
import util.ZMath;

/**
 * ...
 * @author x01010111
 */
class Spark extends FlxSprite
{

	public function new(P:FlxPoint) 
	{
		super(P.x, P.y);
		loadGraphic("assets/images/spark.png", true, 15, 15);
		animation.add("play", [0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 40, false);
		offset.set(7.5, 7.5);
		animation.play("play");
		PlayState.instance.fx.add(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (animation.finished) kill();
		super.update(elapsed);
	}
	
}