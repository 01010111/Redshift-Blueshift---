package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import util.Colors;
import util.Controls;
import util.RState;
import util.Transition;

/**
 * A FlxState which can be used for the game's menu.
 */
class Title extends RState
{
	var state:Int = 0;
	
	override public function create():Void 
	{
		super.create();
		
		FlxG.camera.bgColor = Colors.KCMW[3];
		
		FlxG.camera.flash(0xfff4f1c4, 0.3);
		
		var title1:FlxSprite = new FlxSprite(0, -FlxG.height * 0.75);
		title1.loadGraphic("assets/images/title1.png", true, 160, 144);
		title1.animation.add("play", [1, 2, 3, 4, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 30, false);
		add(title1);
		
		var title2:FlxSprite = new FlxSprite(FlxG.width, FlxG.height * 0.5 - 3, "assets/images/title2.png");
		add(title2);
		
		FlxTween.tween(title1, { y:0 }, 3).onComplete = function(t:FlxTween):Void
		{
			new FlxTimer().start(0.5).onComplete = function(t:FlxTimer):Void
			{
				title1.animation.play("play");
				new FlxTimer().start(1).onComplete = function(t:FlxTimer):Void
				{
					FlxTween.tween(title2, { x:(FlxG.width - title2.width) * 0.5 }, 0.5, { ease:FlxEase.cubeOut } );
					new FlxTimer().start(0.5).onComplete = function(t:FlxTimer):Void
					{
						pressStart(); 
					}
				}
			}
		}
	}
	
	var pressStartSpr:FlxSprite;
	
	function pressStart():Void
	{
		state = 1;
		pressStartSpr = new FlxSprite(32, FlxG.height - 24);
		pressStartSpr.loadGraphic("assets/images/pressStart.png", true, 96, 7);
		pressStartSpr.animation.add("play", [0, 0, 1, 2, 2], 12);
		pressStartSpr.animation.play("play");
		add(pressStartSpr);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		switch(state)
		{
			case 1: waitForInput();
		}
	}
	
	function waitForInput():Void
	{
		if (Reg.c.justPressed(Controls.BTN_A) || Reg.c.justPressed(Controls.BTN_START)) goToPlayState();
	}
	
	function goToPlayState():Void
	{
		openSubState(new Transition(false, true, true));
	}
	
}