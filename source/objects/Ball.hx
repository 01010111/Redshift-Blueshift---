package objects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import states.PlayState;
import util.ZMath;
/**
 * ...
 * @author x01010111
 */
class Ball extends FlxSprite
{
	var trail1:FlxSprite;
	var trail2:FlxSprite;
	var trailDistance:Int = 7;
	var startSpeed:Float = 60;
	
	var red:Bool = true;
	
	var lastPositions:Array<FlxPoint>;
	
	public function new() 
	{
		super();
		loadGraphic("assets/images/ball.png", true, 9, 9);
		screenCenter();
		var v = ZMath.velocityFromAngle(ZMath.randomRange(225, 315), startSpeed);
		
		lastPositions = new Array();
		for (i in 0...32) lastPositions.push(getMidpoint());
		
		trail1 = new FlxSprite();
		trail1.loadGraphic("assets/images/ball.png", true, 9, 9);
		trail1.setSize(0, 0);
		trail1.offset.set(4.5, 4.5);
		
		trail2 = new FlxSprite();
		trail2.loadGraphic("assets/images/ball.png", true, 9, 9);
		trail2.setSize(0, 0);
		trail2.offset.set(4.5, 4.5);
		
		PlayState.instance.add(trail1);
		PlayState.instance.add(trail2);
		PlayState.instance.add(this);
		
		velocity.set(v.x, v.y);
	}
	
	override public function update(elapsed:Float):Void 
	{
		animate();
		positionTrail();
		bumpOffWalls();
		
		super.update(elapsed);
		
		checkForShipCollision();
	}
	
	function animate():Void
	{
		if (PlayState.instance.red)
		{
			animation.frameIndex = 0;
			trail1.animation.frameIndex = 1;
			trail2.animation.frameIndex = 2;
		}
		else
		{
			animation.frameIndex = 3;
			trail1.animation.frameIndex = 4;
			trail2.animation.frameIndex = 5;
		}
	}
	
	function positionTrail():Void
	{
		lastPositions.insert(0, getMidpoint());
		lastPositions.pop();
		trail1.setPosition(lastPositions[trailDistance].x, lastPositions[trailDistance].y);
		trail2.setPosition(lastPositions[trailDistance + trailDistance].x, lastPositions[trailDistance + trailDistance].y);
	}
	
	function bumpOffWalls():Void
	{
		if (x <= 4 || x >= FlxG.width - 4 - width) 
		{
			velocity.x = -velocity.x * 1.01;
			bounce();
		}
		if (y <= 4) 
		{
			PlayState.instance.red ? PlayState.instance.red = false : PlayState.instance.red = true;
			velocity.y = -velocity.y * 1.01;
			bounce();
		}
	}
	
	var oldVel:Float;
	
	function checkForShipCollision():Void
	{
		if (velocity.y > 0)
		{
			oldVel = ZMath.vectorVelocity(velocity.x, velocity.y);
			if (ZMath.isWithinBounds(PlayState.instance.ship.animation.frameIndex, 9, 14) || ZMath.isWithinBounds(PlayState.instance.ship.animation.frameIndex, 29, 34))
			{
				FlxG.overlap(this, PlayState.instance.ship.paddle, bounceOffShip);
			}
		}
	}
	
	function bounceOffShip(b:Ball, p:FlxObject):Void
	{
		bounce();
		PlayState.instance.score.volleys++;
		var a = ZMath.clamp(270 + (b.getMidpoint().x - p.getMidpoint().x) * 4 + PlayState.instance.ship.velocity.x * 0.4, 180 + 45, 360 - 45);
		var v = ZMath.velocityFromAngle(a, oldVel);
		b.velocity.set(v.x, v.y);
	}
	
	function bounce():Void
	{
		//scale.set(1.5, 1.5);
		//FlxTween.tween(scale, { x:1, y:1 }, 0.3, { ease:FlxEase.backIn } );
	}
	
}