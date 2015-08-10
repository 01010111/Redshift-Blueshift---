package util;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.input.keyboard.FlxKey;

/**
 * ...
 * @author x01010111
 */
class Controls extends FlxObject
{
	public static var BTN_A:Int = 0;
	public static var BTN_B:Int = 1;
	public static var BTN_START:Int = 2;
	public static var BTN_SELECT:Int = 3;
	public static var BTN_LEFT:Int = 4;
	public static var BTN_RIGHT:Int = 5;
	public static var BTN_UP:Int = 6;
	public static var BTN_DOWN:Int = 7;
	
	public function new() 
	{
		super();
	}
	
	public function justPressed(BUTTON:Int):Bool
	{
		var b = false;
		
		switch(BUTTON)
		{
			case 0: b = FlxG.keys.anyJustPressed([FlxKey.X, FlxKey.SPACE]);
			case 1: b = FlxG.keys.anyJustPressed([FlxKey.C, FlxKey.SHIFT]);
			case 2: b = FlxG.keys.anyJustPressed([FlxKey.ENTER, FlxKey.ESCAPE]);
			case 3: b = false;
			case 4: b = FlxG.keys.anyJustPressed([FlxKey.LEFT, FlxKey.A]);
			case 5: b = FlxG.keys.anyJustPressed([FlxKey.RIGHT, FlxKey.D]);
			case 6: b = FlxG.keys.anyJustPressed([FlxKey.UP, FlxKey.W]);
			case 7: b = FlxG.keys.anyJustPressed([FlxKey.DOWN, FlxKey.S]);
		}
		
		return b;
	}
	
	public function pressed(BUTTON:Int):Bool
	{
		var b = false;
		
		switch(BUTTON)
		{
			case 0: b = FlxG.keys.anyPressed([FlxKey.X, FlxKey.SPACE]);
			case 1: b = FlxG.keys.anyPressed([FlxKey.C, FlxKey.SHIFT]);
			case 2: b = FlxG.keys.anyPressed([FlxKey.ENTER, FlxKey.ESCAPE]);
			case 3: b = false;
			case 4: b = FlxG.keys.anyPressed([FlxKey.LEFT, FlxKey.A]);
			case 5: b = FlxG.keys.anyPressed([FlxKey.RIGHT, FlxKey.D]);
			case 6: b = FlxG.keys.anyPressed([FlxKey.UP, FlxKey.W]);
			case 7: b = FlxG.keys.anyPressed([FlxKey.DOWN, FlxKey.S]);
		}
		
		return b;
	}
	
}