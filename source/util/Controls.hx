package util;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.id.XBox360ID;
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
	
	var joypad:FlxGamepad;
	
	public function new() 
	{
		super();
		joypad = FlxG.gamepads.firstActive;
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
		
		if (joypad != null && !b)
		{
			switch(BUTTON)
			{
				case 0: b = joypad.justPressed.A;
				case 1: b = joypad.justPressed.B;
				case 2: b = joypad.justPressed.START;
				case 3: b = joypad.justPressed.BACK;
				case 4: b = joypad.justPressed.DPAD_LEFT;
				case 5: b = joypad.justPressed.DPAD_RIGHT;
				case 6: b = joypad.justPressed.DPAD_UP;
				case 7: b = joypad.justPressed.DPAD_DOWN;
			}
		}
		
		return b;
	}
	
	var deadzone:Float = 0.3;
	
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
		
		if (joypad != null && !b)
		{
			switch(BUTTON)
			{
				case 0: b = joypad.pressed.A || joypad.pressed.RIGHT_TRIGGER || joypad.pressed.RIGHT_SHOULDER;
				case 1: b = joypad.pressed.B;
				case 2: b = joypad.pressed.START;
				case 3: b = joypad.pressed.BACK;
				case 4: b = joypad.pressed.DPAD_LEFT || joypad.getXAxis(FlxGamepadInputID.LEFT_ANALOG_STICK) < -deadzone;
				case 5: b = joypad.pressed.DPAD_RIGHT || joypad.getXAxis(FlxGamepadInputID.LEFT_ANALOG_STICK) > deadzone;
				case 6: b = joypad.pressed.DPAD_UP || joypad.getYAxis(FlxGamepadInputID.LEFT_ANALOG_STICK) < -deadzone;
				case 7: b = joypad.pressed.DPAD_DOWN || joypad.getYAxis(FlxGamepadInputID.LEFT_ANALOG_STICK) > deadzone;
			}
		}
		
		return b;
	}
	
}