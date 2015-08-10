package util;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxSort;
import util.ZState;

class RState extends ZState
{
	public static var instance:RState;
	
	override public function create():Void 
	{
		instance = this;
		colors = Colors.colors[Reg.scheme];
		FlxG.camera.bgColor = 0xffffffff;
		FlxG.mouse.visible = false;
		if (Reg.c == null) Reg.c = new Controls();
		add(Reg.c);
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
	function changeColors(COLORS:Array<Int>):Void
	{
		colors = COLORS;
		initColorPalette();
	}
	
}