package util;
import flixel.FlxG;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.math.FlxPoint;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText.FlxTextAlign;

/**
 * ...
 * @author x01010111
 */
class RText extends FlxBitmapText
{
	
	public function new(X:Float, Y:Float, TEXT:String = "NO TEXT", COLOR:Int = 0xffffffff, WIDTH:Int = -1, ?ALIGN:FlxTextAlign) 
	{
		var letters:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.!?-#%^&*()+=/: ";
		var letterSize:FlxPoint = new FlxPoint(7, 6);
		var font:FlxBitmapFont = FlxBitmapFont.fromMonospace("assets/images/alphabet.png", letters, letterSize);
		
		super(font);
		autoSize = false;
		WIDTH == -1? set_fieldWidth(FlxG.width): set_fieldWidth(WIDTH);
		ALIGN != null? alignment = ALIGN: alignment = FlxTextAlign.LEFT;
		text = TEXT;
		lineSpacing = 0;
		set_letterSpacing(0);
		
		setPosition(X, Y);
		scrollFactor.set();
		color = COLOR;
	}
	
}