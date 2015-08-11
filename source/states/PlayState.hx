package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import fx.Explode;
import fx.Stars;
import objects.Ball;
import objects.Drone;
import objects.MissilePod;
import objects.Ship;
import objects.TinyBill;
import util.Colors;
import util.RState;
import util.ScoreManager;
import util.ScoreText;
import util.Transition;
import util.Weapons;
import util.ZMath;

class PlayState extends RState
{
	var uiBg:FlxSprite;
	
	public var fx:FlxGroup;
	public var explosions:FlxGroup;
	public var shipBullets:FlxGroup;
	public var enemies:FlxGroup;
	public var enemyBullets:FlxGroup;
	public var weaponUI:Weapons;
	public var score:ScoreManager;
	public var red:Bool = true;
	public var ship:Ship;
	public var readyForEnemy:Bool = true;
	public var ball:Ball;
	
	public static var instance:PlayState;
	
	override public function create():Void 
	{
		init();
		addBackground();
		addGroups();
		addUI();
		openSubState(new Transition(true, true));
		new FlxTimer().start(6, spawnEnemies);
	}
	
	function init():Void
	{
		instance = this;
		super.create();
		FlxG.camera.bgColor = Colors.KCMW[0];
		score = new ScoreManager();
	}
	
	function addBackground():Void
	{
		add(new Stars(16));
	}
	
	function addGroups():Void
	{
		fx = new FlxGroup();
		add(fx);
		shipBullets = new FlxGroup();
		add(shipBullets);
		enemies = new FlxGroup();
		add(enemies);
		enemyBullets = new FlxGroup();
		ship = new Ship();
		add(enemyBullets);
		ball = new Ball();
		explosions = new FlxGroup();
		add(explosions);
	}
	
	function addUI():Void
	{
		uiBg = new FlxSprite();
		uiBg.loadGraphic("assets/images/uiBg.png", true, 160, 144);
		add(uiBg);
		
		weaponUI = new Weapons();
		add(weaponUI);
		
		add(new ScoreText());
	}
	
	function spawnEnemies(?t:FlxTimer):Void
	{
		if (readyForEnemy)
		{
			switch(ZMath.randomRangeInt(0, 4))
			{
				case 0: spawnDrone();
				case 1: babyWave1();
				case 2: babyWave2();
				case 3: babyWave3();
				case 4: spawnMissilePod();
			}
		}
		new FlxTimer().start(6, spawnEnemies);
	}
	
	function spawnDrone():Void
	{
		var d:Drone = new Drone();
	}
	
	function babyWave1():Void
	{
		var d:Int;
		var y1 = ZMath.randomRange(16, 32);
		var y2 =  y1 + ZMath.randomRange(16, 32);
		var f = ZMath.randomRange(0.5, 1.5);
		Math.random() > 0.5 ? d = FlxObject.LEFT : d = FlxObject.RIGHT;
		for (i in 0...6)
		{
			new FlxTimer().start(i * 0.4).onComplete = function(t:FlxTimer):Void
			{
				var b:TinyBill = new TinyBill(d, f, y1, y2);
			}
		}
	}
	
	function babyWave2():Void
	{
		for (i in 0...2)
		{
			new FlxTimer().start(i * 0.8).onComplete = function(t:FlxTimer):Void
			{
				var b1:TinyBill = new TinyBill(FlxObject.LEFT, 1, 16, 64);
				new FlxTimer().start(0.4).onComplete = function(t:FlxTimer):Void
				{
					var b2:TinyBill = new TinyBill(FlxObject.RIGHT, 1, 16, 64);
				}
			}
		}
	}
	
	function babyWave3():Void
	{
		var y1 = ZMath.randomRange(16, 32);
		var y2 =  y1 + ZMath.randomRange(16, 32);
		var f = ZMath.randomRange(0.5, 1.5);
		for (i in 0...5)
		{
			new FlxTimer().start(i * 0.4).onComplete = function(t:FlxTimer):Void
			{
				var b:TinyBill = new TinyBill(FlxObject.LEFT, f, y1, y2);
			}
		}
		for (i in 0...5)
		{
			new FlxTimer().start(i * 0.4).onComplete = function(t:FlxTimer):Void
			{
				var b:TinyBill = new TinyBill(FlxObject.RIGHT, f, y1 + 30, y2 + 30);
			}
		}
	}
	
	function spawnMissilePod():Void
	{
		for (i in 0...(Math.floor(score.score/1000)) + 1)
		{
			var m:MissilePod = new MissilePod();
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		red ? uiBg.animation.frameIndex = 0 : uiBg.animation.frameIndex = 1;
		FlxG.overlap(enemyBullets, ship, bulletHitShip);
		FlxG.overlap(shipBullets, enemies, bulletHitEnemy);
		FlxG.overlap(ball, enemies, ballHitEnemy);
		super.update(elapsed);
		if (FlxG.keys.justPressed.R) FlxG.switchState(new PlayState());
	}
	
	function bulletHitShip(b:FlxSprite, s:Ship):Void
	{
		b.kill();
		s.kill();
	}
	
	function bulletHitEnemy(b:FlxSprite, e:FlxSprite):Void
	{
		var ex:Explode = new Explode(b.getMidpoint());
		b.kill();
		e.hurt(1);
	}
	
	function ballHitEnemy(b:Ball, e:FlxSprite):Void
	{
		if (!FlxSpriteUtil.isFlickering(b) && e.alive)
		{
			FlxSpriteUtil.flicker(b, 0.2);
			e.hurt(10);
		}
	}
	
}