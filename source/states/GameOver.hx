package states;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import util.Colors;

/**
 * ...
 * @author x01010111
 */
class GameOver extends FlxSubState
{

	public function new(P:FlxPoint) 
	{
		super();
		
		var vS:FlxSprite = new FlxSprite(P.x, P.y);
		vS.makeGraphic(1, 1, Colors.KCMW[3]);
		vS.scale.set(0, FlxG.height * 2);
		add(vS);
		FlxTween.tween(vS.scale, { x:FlxG.width * 2 }, 0.8, { ease:FlxEase.quintOut } );
		
		var hS:FlxSprite = new FlxSprite(P.x, P.y);
		hS.makeGraphic(1, 1, Colors.KCMW[3]);
		hS.scale.set(FlxG.width * 2, 0);
		add(hS);
		FlxTween.tween(hS.scale, { y:FlxG.height * 2 }, 0.8, { ease:FlxEase.quintOut } );
		
		new FlxTimer().start(1).onComplete = function(t:FlxTimer):Void { FlxG.switchState(new PlayState()); }
	}
	
}