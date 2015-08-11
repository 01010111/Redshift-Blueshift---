package objects;
import flixel.FlxG;
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
class Drone extends FlxSprite
{
	
	var bTimer:FlxTimer;
	var mTimer:FlxTimer;
	
	public function new() 
	{
		super();
		loadGraphic("assets/images/drone.png", true, 21, 21);
		setPosition(ZMath.randomRange(0, FlxG.width - 21), -21);
		animation.add("hurt", [0, 8, 1, 9, 2, 10, 3, 11, 4, 12, 5, 13, 6, 14, 7, 15], 20, false);
		mTimer = new FlxTimer().start(6, move, 0);
		bTimer = new FlxTimer().start(4, fire, 0);
		move();
		PlayState.instance.enemies.add(this);
		PlayState.instance.readyForEnemy = false;
		health = 150;
	}
	
	function move(?t:FlxTimer):Void
	{
		FlxTween.tween(this, { x:ZMath.randomRange(0 + 32, FlxG.width - 21 - 32), y:ZMath.randomRange(16, 32) }, 2, { ease:FlxEase.backOut } );
	}
	
	function fire(t:FlxTimer):Void
	{
		switch(ZMath.randomRangeInt(0, 2))
		{
			case 0: circleShoot();
			case 1: followers();
			case 2: crissCross();
		}
	}
	
	function circleShoot():Void
	{
		for (i in 0...24)
		{
			new FlxTimer().start(i * 0.05).onComplete = function(t:FlxTimer):Void
			{
				if (alive)
				{
					var v = ZMath.velocityFromAngle(i * 30, 30);
					var b:DroneBullet = new DroneBullet(getMidpoint(), v, v); 
				}
			}
		}
	}
	
	function followers():Void
	{
		var m = PlayState.instance.ship.getMidpoint();
		for (i in 0...7)
		{
			new FlxTimer().start(i * 0.1).onComplete = function(t:FlxTimer):Void
			{
				if (alive)
				{
					var a = ZMath.angleBetween(getMidpoint().x, getMidpoint().y, m.x, m.y);
					var v = ZMath.velocityFromAngle(a + 180 - 3 * 20 + i * 20, 150);
					var b:DroneBullet = new DroneBullet(getMidpoint(), v, FlxPoint.get());
					new FlxTimer().start(0.5).onComplete = function(t:FlxTimer):Void { 
						var subA = ZMath.angleBetween(b.getMidpoint().x, b.getMidpoint().y, m.x, m.y);
						var subV = ZMath.velocityFromAngle(subA, 400);
						b.acceleration.set(subV.x, subV.y); 
					}
				}
			}
		}
	}
	
	function crissCross():Void
	{
		var m = PlayState.instance.ship.getMidpoint();
		var a = 0.0;
		for (i in 0...4)
		{
			new FlxTimer().start(0.1 * i).onComplete = function(t:FlxTimer):Void
			{
				var b1 = new DroneBullet(getMidpoint(), ZMath.velocityFromAngle(a, 150), FlxPoint.get());
				var b2 = new DroneBullet(getMidpoint(), ZMath.velocityFromAngle(a + 180, 150), FlxPoint.get());
				new FlxTimer().start(1).onComplete = function(t:FlxTimer):Void
				{
					var a1 = ZMath.velocityFromAngle(ZMath.angleBetween(b1.getMidpoint().x, b1.getMidpoint().y, m.x, m.y), 300);
					b1.acceleration.set(a1.x, a1.y);
					var a2 = ZMath.velocityFromAngle(ZMath.angleBetween(b2.getMidpoint().x, b2.getMidpoint().y, m.x, m.y), 300);
					b2.acceleration.set(a2.x, a2.y);
				}
				a += 45;
			}
			
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (animation.finished) 
		{
			if (health > 0)
			{
				var a = ZMath.snapToGrid(ZMath.angleBetween(getMidpoint().x, getMidpoint().y, PlayState.instance.ship.getMidpoint().x, PlayState.instance.ship.getMidpoint().y), Math.round(360 / 8));
				animation.frameIndex = Math.floor(a / (360 / 8));
			}
			else
			{
				PlayState.instance.score.points(500);
				super.kill();
			}
		}
	}
	
	override public function hurt(Damage:Float):Void 
	{
		animation.play("hurt");
		super.hurt(Damage);
	}
	
	override public function kill():Void 
	{
		PlayState.instance.readyForEnemy = true;
		mTimer.cancel();
		bTimer.cancel();
		var m = getMidpoint();
		for (i in 0...10)
		{
			new FlxTimer().start(0.1 * i).onComplete = function(t:FlxTimer):Void
			{
				var e:Explode = new Explode(FlxPoint.get(m.x + ZMath.randomRange( -12, 12), m.y + ZMath.randomRange( -12, 12)));
			}
		}
	}
	
}