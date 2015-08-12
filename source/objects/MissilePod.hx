package objects;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import fx.Explode;
import states.PlayState;
import util.ZMath;

/**
 * ...
 * @author x01010111
 */
class MissilePod extends FlxSprite
{

	public function new() 
	{
		super(32 + Math.random() * FlxG.width - 64, -48);
		loadGraphic("assets/images/missilePod.png", true, 32, 32);
		animation.add("play", [0, 1], ZMath.randomRangeInt(5, 10));
		animation.play("play");
		setSize(8, 8);
		offset.set(12, 12);
		FlxTween.tween(this, { y: ZMath.randomRange(32, 64), x: ZMath.randomRange(32, FlxG.width - 64) }, ZMath.randomRange(2.5, 5), { ease:FlxEase.backOut } ).onComplete = function(t:FlxTween):Void
		{
			if (alive) release();
		}
		health = 10;
		PlayState.instance.enemies.add(this);
	}
	
	override public function kill():Void 
	{
		PlayState.instance.score.points(250);
		var m = getMidpoint();
		var e = new Explode(FlxPoint.get(m.x, m.y));
		var e = new Explode(FlxPoint.get(m.x - 8, m.y - 8));
		var e = new Explode(FlxPoint.get(m.x + 8, m.y - 8));
		var e = new Explode(FlxPoint.get(m.x - 8, m.y + 8));
		var e = new Explode(FlxPoint.get(m.x + 8, m.y + 8));
		super.kill();
	}
	
	function release():Void
	{
		if (alive)
		{
			var m = getMidpoint();
			var e = new Explode(FlxPoint.get(m.x - 8, m.y - 8));
			var e = new Explode(FlxPoint.get(m.x + 8, m.y - 8));
			var e = new Explode(FlxPoint.get(m.x - 8, m.y + 8));
			var e = new Explode(FlxPoint.get(m.x + 8, m.y + 8));
			var e = new Explode(FlxPoint.get(m.x, m.y));
			var m = new Missile(FlxPoint.get(m.x - 8, m.y - 8), FlxPoint.get(-40, -40));
			var m = new Missile(FlxPoint.get(m.x + 8, m.y - 8), FlxPoint.get(40, -40));
			var m = new Missile(FlxPoint.get(m.x - 8, m.y + 8), FlxPoint.get(-40, 40));
			var m = new Missile(FlxPoint.get(m.x + 8, m.y + 8), FlxPoint.get(40, 40));
			super.kill();
		}
	}
	
}