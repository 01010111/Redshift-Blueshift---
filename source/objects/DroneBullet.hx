package objects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import fx.Explode;
import states.PlayState;
import util.ZMath;

/**
 * ...
 * @author x01010111
 */
class DroneBullet extends FlxSprite
{

	public function new(P:FlxPoint, V:FlxPoint, A:FlxPoint) 
	{
		super(P.x - 3, P.y - 3);
		loadGraphic("assets/images/enemyBullet.png", true, 7, 7);
		animation.add("play", [0, 1, 2, 3], 15);
		animation.play("play");
		velocity.set(V.x, V.y);
		acceleration.set(A.x, A.y);
		drag.set(400, 400);
		var e = new Explode(P, false);
		PlayState.instance.enemyBullets.add(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (!ZMath.isWithinBounds(x, 0 - 32, FlxG.width + 32) || !ZMath.isWithinBounds(y, 0 - 32, FlxG.height)) kill();
		super.update(elapsed);
	}
	
}