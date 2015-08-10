package util;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

/**
 * ...
 * @author x01010111
 */
class Weapons extends FlxGroup
{
	var rRPD:FlxSprite;
	var rLSR:FlxSprite;
	var rHNG:FlxSprite;
	var bRPD:FlxSprite;
	var bLSR:FlxSprite;
	var bHNG:FlxSprite;
	
	public var rW:Int = -1;
	public var bW:Int = -1;
	
	public var rP:Int = 0;
	public var bP:Int = 0;
	
	public function new() 
	{
		super();
		
		rRPD = new FlxSprite(2, 129);
		rRPD.loadGraphic("assets/images/weaponUI.png", true, 25, 7);
		add(rRPD);
		
		rLSR = new FlxSprite(28, 129);
		rLSR.loadGraphic("assets/images/weaponUI.png", true, 25, 7);
		add(rLSR);
		
		rHNG = new FlxSprite(54, 129);
		rHNG.loadGraphic("assets/images/weaponUI.png", true, 25, 7);
		add(rHNG);
		
		bRPD = new FlxSprite(81, 129);
		bRPD.loadGraphic("assets/images/weaponUI.png", true, 25, 7);
		add(bRPD);
		
		bLSR = new FlxSprite(107, 129);
		bLSR.loadGraphic("assets/images/weaponUI.png", true, 25, 7);
		add(bLSR);
		
		bHNG = new FlxSprite(133, 129);
		bHNG.loadGraphic("assets/images/weaponUI.png", true, 25, 7);
		add(bHNG);
		
		getWeapon(true, 0);
		getWeapon(false, 0);
	}
	
	public function getWeapon(RED:Bool, WEAPON:Int)
	{
		if (RED)
		{
			if (WEAPON == rW)
			{
				if (rP < 2) rP++;
			}
			else 
			{
				rW = WEAPON;
				rP = 0;
			}
			rRPD.animation.frameIndex = 0;
			rLSR.animation.frameIndex = 4;
			rHNG.animation.frameIndex = 8;
			switch(WEAPON)
			{
				case 0: rRPD.animation.frameIndex += rP + 1;
				case 1: rLSR.animation.frameIndex += rP + 1;
				case 2: rHNG.animation.frameIndex += rP + 1;
			}
		}
		else
		{
			if (WEAPON == bW)
			{
				if (bP < 2) bP++;
			}
			else 
			{
				bW = WEAPON;
				bP = 0;
			}
			bRPD.animation.frameIndex = 0;
			bLSR.animation.frameIndex = 4;
			bHNG.animation.frameIndex = 8;
			switch(WEAPON)
			{
				case 0: bRPD.animation.frameIndex += rP + 1;
				case 1: bLSR.animation.frameIndex += rP + 1;
				case 2: bHNG.animation.frameIndex += rP + 1;
			}
		}
	}
	
}