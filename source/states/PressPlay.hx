package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.math.FlxRect;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author x01010111
 */
class PressPlay extends FlxState
{
	var bg:FlxSprite;
	var brick:FlxSprite;
	var onOff:FlxSprite;
	var cursor:FlxSprite;
	
	override public function create():Void 
	{
		bg = new FlxSprite();
		bg.loadGraphic("assets/images/brickbg.png", true, 160, 144);
		bg.animation.add("unclicked", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 8);
		bg.animation.add("clicked", [12, 13, 14], 8);
		bg.animation.play("unclicked");
		add(bg);
		
		onOff = new FlxSprite(16, 42, "assets/images/brickSwitch.png");
		add(onOff);
		
		brick = new FlxSprite(0, 48);
		brick.loadGraphic("assets/images/brick.png", true, 160, 208);
		add(brick);
		
		cursor = new FlxSprite();
		cursor.loadGraphic("assets/images/brickCursor.png", true, 22, 32);
		cursor.animation.add("play", [0, 1, 2, 1], 8);
		cursor.setSize(2, 2);
		cursor.offset.set(5, 4);
		cursor.animation.play("play");
		add(cursor);
		
		FlxG.mouse.visible = false;
	}
	
	var timer:Int = 2;
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (timer == 0)
		{
			cursor.offset.set(Math.random() * 2 - 1, Math.random() * 2 - 1);
			timer = 2;
		}
		else timer--;
		cursor.setPosition(FlxG.mouse.x, FlxG.mouse.y);
		if (FlxMath.mouseInFlxRect(false, new FlxRect(8, 32, 32, 24)) && FlxG.mouse.justPressed) getGoin();
	}
	
	function getGoin():Void
	{
		FlxTween.tween(cursor.scale, { x:0, y:0 }, 0.5, { ease:FlxEase.backIn } );
		FlxTween.tween(onOff, { x:onOff.x + 32 }, 0.2).onComplete = function(t:FlxTween):Void
		{
			brick.animation.frameIndex = 1;
			FlxTween.tween(brick, { y:brick.y - 104 }, 1, { ease:FlxEase.cubeIn } );
			FlxTween.tween(onOff, { y:onOff.y - 104 }, 1, { ease:FlxEase.cubeIn } ).onComplete = function(t:FlxTween):Void
			{
				FlxG.switchState(new Title());
			}
		}
	}
	
}