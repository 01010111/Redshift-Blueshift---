package util;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxTimer;
import states.PlayState;
import states.Title;

/**
 * ...
 * @author x01010111
 */
class Transition extends FlxSubState
{
	var c:Int;
	
	public function new(IN:Bool, BLACK:Bool = true, TOPLAYSTATE:Bool = true) 
	{
		super();
		IN ? transIn() : transOut(TOPLAYSTATE);
		BLACK ? c = 0: c = 3;
	}
	
	function transIn():Void
	{
		for (i in 0...16)
		{
			for (n in 0...Math.round(FlxG.height / 16))
			{
				var s:FlxSprite = new FlxSprite(0, n * 16 + i);
				s.makeGraphic(FlxG.width, 1, Colors.KCMW[c]);
				add(s);
				new FlxTimer().start(0.01 + i * 0.02).onComplete = function(t:FlxTimer):Void { s.kill(); }
			}
		}
		
		new FlxTimer().start(0.1 + 16 * 0.02).onComplete = function(t:FlxTimer):Void { close(); }
	}
	
	function transOut(TOPLAYSTATE:Bool):Void
	{
		for (i in 0...16)
		{
			for (n in 0...Math.round(FlxG.height / 16))
			{
				var s:FlxSprite = new FlxSprite(0, n * 16 + i);
				s.makeGraphic(FlxG.width, 1, Colors.KCMW[c]);
				new FlxTimer().start(0.01 + i * 0.02).onComplete = function(t:FlxTimer):Void { add(s); }
			}
		}
		
		new FlxTimer().start(0.1 + 16 * 0.02).onComplete = function(t:FlxTimer):Void { 
			TOPLAYSTATE ? FlxG.switchState(new PlayState()) : FlxG.switchState(new Title());
		}
	}
	
}