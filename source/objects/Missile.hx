package objects;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import fx.Explode;
import states.PlayState;
import util.ZMath;

/**
 * ...
 * @author x01010111
 */
class Missile extends FlxSprite
{

	public function new(P:FlxPoint, V:FlxPoint) 
	{
		super(P.x, P.y);
		loadGraphic("assets/images/missile.png", true, 16, 16);
		setSize(4, 4);
		offset.set(6, 6);
		velocity.set(V.x, V.y);
		maxVelocity.set(80, 80);
		PlayState.instance.enemyMissiles.add(this);
		PlayState.instance.missileTrails.add(this);
		new FlxTimer().start(8).onComplete = function(t:FlxTimer):Void
		{
			if (alive) reallyKill();
		}
		FlxTween.tween(this, { aO: -45 }, ZMath.randomRange(1, 3), { ease:FlxEase.sineInOut } );
	}
	
	var aO:Float = 45;
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		//animation.frameIndex = Math.floor(ZMath.toRelativeAngle(ZMath.angleFromVelocity(velocity.x, velocity.y) - 22.5) / 45) % 8;
		angle = ZMath.angleFromVelocity(velocity.x, velocity.y);
		var a = ZMath.velocityFromAngle(ZMath.angleBetween(getMidpoint().x, getMidpoint().y, PlayState.instance.ship.getMidpoint().x, PlayState.instance.ship.getMidpoint().y) + aO, 100);
		acceleration.set(a.x, a.y);
	}
	
	function reallyKill():Void
	{
		var e = new Explode(getMidpoint(), true, 10, 2);
		super.kill();
	}
	
	override public function kill():Void 
	{
		reallyKill();
		PlayState.instance.score.points(50);
	}
	
}