package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import fx.Stars;
import objects.Ball;
import objects.Ship;
import util.Colors;
import util.RState;
import util.ScoreManager;
import util.ScoreText;
import util.Transition;
import util.Weapons;

class PlayState extends RState
{
	var uiBg:FlxSprite;
	
	public var weaponUI:Weapons;
	public var score:ScoreManager;
	public var red:Bool = true;
	public var ship:Ship;
	
	public static var instance:PlayState;
	
	override public function create():Void 
	{
		init();
		addBackground();
		addGroups();
		addUI();
		openSubState(new Transition(true, true));
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
		var b:Ball = new Ball();
		ship = new Ship();
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
	
	override public function update(elapsed:Float):Void 
	{
		red ? uiBg.animation.frameIndex = 0 : uiBg.animation.frameIndex = 1;
		super.update(elapsed);
		if (FlxG.keys.justPressed.R) FlxG.switchState(new PlayState());
	}
}