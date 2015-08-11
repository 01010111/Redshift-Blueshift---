package fx;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import states.PlayState;

/**
 * ...
 * @author x01010111
 */
class Explode extends FlxSprite
{

	public function new(P:FlxPoint, E:Bool = true, VY:Int = 10) 
	{
		super(P.x, P.y);
		loadGraphic("assets/images/explode.png", true, 15, 15);
		offset.set(7.5, 7.5);
		animation.add("explode", [0, 0, 1, 1, 2, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8], 48, false);
		animation.add("puff", [2, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 8], 48, false);
		E ? animation.play("explode") : animation.play("puff");
		PlayState.instance.explosions.add(this);
		velocity.y = VY;
		//angle = Math.random() * 360;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (animation.finished) kill();
		super.update(elapsed);
	}
	
}