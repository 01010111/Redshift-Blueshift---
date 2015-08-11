package objects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import fx.Explode;
import states.PlayState;
import util.ZMath;

/**
 * ...
 * @author x01010111
 */
class TinyBill extends FlxSprite
{
	var direction:Int;
	var fired:Bool = false;
	
	public function new(DIR:Int, FREQ:Float, Y1:Float, Y2:Float) 
	{
		super(0, Y1, "assets/images/babyBill.png");
		setFacingFlip(FlxObject.RIGHT, true, false);
		setFacingFlip(FlxObject.LEFT, false, false);
		direction = facing = DIR;
		if (facing == FlxObject.LEFT)
		{
			x = FlxG.width;
			velocity.x = -80;
		}
		else
		{
			x = 0 - width;
			velocity.x = 80;
		}
		FlxTween.tween(this, { y:Y2 }, FREQ, { ease:FlxEase.sineInOut, type:FlxTween.PINGPONG } );
		health = 1;
		PlayState.instance.enemies.add(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (facing == FlxObject.LEFT)
		{
			if (!fired)
			{
				if (x < FlxG.width * 0.5) fire();
			}
			if (x < 0 - width)
			{
				super.kill();
			}
		}
		else
		{
			if (!fired)
			{
				if (x > FlxG.width * 0.5) fire();
			}
			if (x > FlxG.width)
			{
				super.kill();
			}
		}
		super.update(elapsed);
	}
	
	function fire():Void
	{
		fired = true;
		var a = ZMath.angleBetween(getMidpoint().x, getMidpoint().y, PlayState.instance.ship.getMidpoint().x, PlayState.instance.ship.getMidpoint().y);
		var b:DroneBullet = new DroneBullet(getMidpoint(), ZMath.velocityFromAngle(a, 20), ZMath.velocityFromAngle(a, 100));
	}
	
	override public function kill():Void 
	{
		PlayState.instance.score.points(25);
		var e:Explode = new Explode(getMidpoint());
		super.kill();
	}
	
}