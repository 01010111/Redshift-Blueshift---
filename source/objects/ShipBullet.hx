package objects;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import fx.Explode;
import states.PlayState;
import util.ZMath;

/**
 * ...
 * @author x01010111
 */
class ShipBullet extends FlxSprite
{

	public function new(P:FlxPoint, V:FlxPoint) 
	{
		super(P.x - 1, P.y);
		loadGraphic("assets/images/playerBullet.png", true, 5, 9 );
		animation.add("play", [0, 1], 20);
		animation.play("play");
		setSize(3, 3);
		offset.set(1, 3);
		velocity.set(V.x, V.y);
		
		PlayState.instance.shipBullets.add(this);
		var e = new Explode(P, false);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (y < -8) kill();
		super.update(elapsed);
	}
	
}