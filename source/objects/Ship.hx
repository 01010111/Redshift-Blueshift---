package objects;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxAxes;
import flixel.util.FlxTimer;
import fx.Explode;
import states.GameOver;
import states.PlayState;
import util.Controls;
import util.ZMath;

/**
 * ...
 * @author x01010111
 */
class Ship extends FlxSprite
{
	public var paddle:FlxObject;
	
	var animationSpeed:Int = 35;
	var minSpeed:Int = 150;
	var maxSpeed:Int = 175;
	var dragAmt:Int = 1200;
	var accelAmt:Int = 1800;
	
	public function new() 
	{
		super(0, FlxG.height * 0.75);
		loadGraphic("assets/images/ship.png", true, 25, 25);
		animation.add("r_guns", [4]);
		animation.add("b_guns", [24]);
		animation.add("r_paddle", [12]);
		animation.add("b_paddle", [32]);
		animation.add("r_guns_to_b_guns", [5, 6, 7, 16, 17, 18, 19, 20, 21, 22, 23, 24], animationSpeed, false);
		animation.add("r_guns_to_b_paddle", [5, 6, 7, 16, 17, 18, 19, 28, 29, 30, 31, 32], animationSpeed, false);
		animation.add("r_guns_to_r_paddle", [5, 6, 7, 8, 9, 10, 11, 12], animationSpeed, false);
		animation.add("r_paddle_to_b_guns", [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24], animationSpeed, false);
		animation.add("r_paddle_to_b_paddle", [13, 14, 15, 16, 17, 18, 19, 20, 29, 30, 31, 32], animationSpeed, false);
		animation.add("r_paddle_to_r_guns", [13, 14, 15, 0, 1, 2, 3, 4], animationSpeed, false);
		animation.add("b_guns_to_r_guns", [25, 26, 27, 35, 36, 37, 38, 39, 0, 2, 2, 3, 4], animationSpeed, false);
		animation.add("b_guns_to_r_paddle", [25, 26, 27, 36, 37, 38, 39, 8, 9, 10, 11, 12], animationSpeed, false);
		animation.add("b_guns_to_b_paddle", [25, 26, 27, 28, 29, 30, 31, 32], animationSpeed, false);
		animation.add("b_paddle_to_r_guns", [33, 34, 35, 36, 37, 38, 39, 0, 1, 2, 3, 4], animationSpeed, false);
		animation.add("b_paddle_to_r_paddle", [33, 34, 35, 36, 37, 38, 39, 8, 9, 10, 11, 12], animationSpeed, false);
		animation.add("b_paddle_to_b_guns", [33, 34, 35, 20, 21, 22, 23, 24], animationSpeed, false);
		animation.frameIndex = 12;
		setSize(3, 2);
		offset.set(11, 11);
		screenCenter(FlxAxes.X);
		drag.set(dragAmt, dragAmt);
		
		paddle = new FlxObject(0, 0, 25, 8);
		paddle.allowCollisions = FlxObject.UP;
		paddle.immovable = true;
		
		PlayState.instance.add(this);
		PlayState.instance.add(paddle);
	}
	
	var shooting:Bool;
	var red:Bool;
	
	override public function update(elapsed:Float):Void 
	{
		if (alive)
		{
			shooting = Reg.c.pressed(Controls.BTN_A);
			red = PlayState.instance.red;
			move();
			bounds();
			animate();
			positionPaddle();
			checkShooting();
		}
		else 
		{
			velocity.set();
			acceleration.set();
			shooting = false;
		}
		super.update(elapsed);
	}
	
	function move():Void
	{
		animation.frameIndex == 4 || animation.frameIndex == 24 ? maxVelocity.set(maxSpeed, maxSpeed * 0.75) : maxVelocity.set(minSpeed, minSpeed * 0.75);
		var p = FlxPoint.get();
		if (Reg.c.pressed(Controls.BTN_LEFT)) p.x--;
		if (Reg.c.pressed(Controls.BTN_RIGHT)) p.x++;
		if (Reg.c.pressed(Controls.BTN_UP)) p.y--;
		if (Reg.c.pressed(Controls.BTN_DOWN)) p.y++;
		acceleration.set(p.x * accelAmt, p.y * accelAmt);
	}
	
	function bounds():Void
	{
		if (x <= 8) velocity.x = maxSpeed;
		if (x >= FlxG.width - 8 - width) velocity.x = -maxSpeed;
		if (y <= 24) velocity.y = maxSpeed;
		if (y >= FlxG.height - 16 - height) velocity.y = -maxSpeed;
	}
	
	function animate():Void
	{
		if (animation.finished)
		{
			if (red)
			{
				if (shooting && animation.frameIndex != 4)
				{
					switch(animation.frameIndex)
					{
						case 4:  animation.play("r_guns_to_r_guns");
						case 12: animation.play("r_paddle_to_r_guns");
						case 24: animation.play("b_guns_to_r_guns");
						case 32: animation.play("b_paddle_to_r_guns");
					}
				}
				if (!shooting && animation.frameIndex != 12)
				{
					switch(animation.frameIndex)
					{
						case 4:  animation.play("r_guns_to_r_paddle");
						case 12: animation.play("r_paddle_to_r_paddle");
						case 24: animation.play("b_guns_to_r_paddle");
						case 32: animation.play("b_paddle_to_r_paddle");
					}
				}
			}
			else
			{
				if (shooting && animation.frameIndex != 24)
				{
					switch(animation.frameIndex)
					{
						case 4:  animation.play("r_guns_to_b_guns");
						case 12: animation.play("r_paddle_to_b_guns");
						case 24: animation.play("b_guns_to_b_guns");
						case 32: animation.play("b_paddle_to_b_guns");
					}
				}
				if (!shooting && animation.frameIndex != 32)
				{
					switch(animation.frameIndex)
					{
						case 4:  animation.play("r_guns_to_b_paddle");
						case 12: animation.play("r_paddle_to_b_paddle");
						case 24: animation.play("b_guns_to_b_paddle");
						case 32: animation.play("b_paddle_to_b_paddle");
					}
				}
			}
		}
	}
	
	function positionPaddle():Void
	{
		paddle.setPosition(x - 11, y - 6);
	}
	
	var timer:Int = 0;
	
	function checkShooting():Void
	{
		if (animation.frameIndex == 4)
		{
			switch(PlayState.instance.weaponUI.rW)
			{
				case 0: rapidFire(true);
				case 1: rapidFire(true);
				case 2: rapidFire(true);
			}
		}
		if (animation.frameIndex == 24)
		{
			switch(PlayState.instance.weaponUI.bW)
			{
				case 0: rapidFire(false);
				case 1: rapidFire(false);
				case 2: rapidFire(false);
			}
		}
	}
	
	function rapidFire(RED:Bool):Void
	{
		if (RED)
		{
			switch(PlayState.instance.weaponUI.rP)
			{
				case 0:
					if (timer == 0)
					{
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x, y - 2), FlxPoint.get(ZMath.randomRange( -10, 10), -400));
						timer = 8;
					}
					else timer--;
				case 1:
					if (timer == 0)
					{
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x - 4, y - 2), FlxPoint.get(0, -400));
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x + 4, y - 2), FlxPoint.get(0, -400));
						timer = 6;
					}
					else timer--;
				case 2:
					if (timer == 0)
					{
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x, y - 2), 	 FlxPoint.get(0, -400));
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x + 7, y + 2), FlxPoint.get(0, -400));
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x - 7, y + 2), FlxPoint.get(0, -400));
						timer = 6;
					}
					else timer--;
			}
		}
		else
		{
			switch(PlayState.instance.weaponUI.bP)
			{
				case 0:
					if (timer == 0)
					{
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x, y - 2), FlxPoint.get(ZMath.randomRange( -10, 10), -400));
						timer = 8;
					}
					else timer--;
				case 1:
					if (timer == 0)
					{
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x - 4, y - 2), FlxPoint.get(0, -400));
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x + 4, y - 2), FlxPoint.get(0, -400));
						timer = 6;
					}
					else timer--;
				case 2:
					if (timer == 0)
					{
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x, y - 2), 	 FlxPoint.get(0, -400));
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x + 7, y + 2), FlxPoint.get(0, -400));
						var b = new ShipBullet(FlxPoint.get(getMidpoint().x - 7, y + 2), FlxPoint.get(0, -400));
						timer = 6;
					}
					else timer--;
			}
		}
	}
	
	function laserFire(RED:Bool):Void
	{
		
	}
	
	function misssileFire(RED:Bool):Void
	{
		
	}
	
	override public function kill():Void 
	{
		if (alive)
		{
			alive = false;
			PlayState.instance.ball.kill();
			for (i in 0...15)
			{
				new FlxTimer().start(0.1 * i).onComplete = function(t:FlxTimer):Void
				{
					var m = getMidpoint();
					var e:Explode = new Explode(FlxPoint.get(m.x + ZMath.randomRange( -12, 12), m.y + ZMath.randomRange( -12, 12)), true);
				}
			}
			new FlxTimer().start(1.5).onComplete = function(t:FlxTimer):Void 
			{
				PlayState.instance.openSubState(new GameOver(getMidpoint()));
			}
		}
	}
	
}