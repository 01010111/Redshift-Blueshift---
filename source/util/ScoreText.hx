package util;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText.FlxTextAlign;
import states.PlayState;

/**
 * ...
 * @author x01010111
 */
class ScoreText extends FlxGroup
{
	public var volleys:RText;
	public var score:RText;
	public var scoreText:RText;
	
	public function new() 
	{
		super();
		
		volleys = new RText(70, 1, "", Colors.KCMW[3]);
		add(volleys);
		
		score = new RText(0, FlxG.height - 6, "", Colors.KCMW[3], FlxG.width - 1, FlxTextAlign.RIGHT);
		add(score);
		
		scoreText = new RText(2, FlxG.height - 6, "SCORE:", Colors.KCMW[3]);
		add(scoreText);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (PlayState.instance.score.volleys == 0) volleys.text = "000";
		else if (PlayState.instance.score.volleys < 10) volleys.text = "00" + PlayState.instance.score.volleys;
		else if (PlayState.instance.score.volleys < 100) volleys.text = "0" + PlayState.instance.score.volleys;
		else volleys.text = "" + PlayState.instance.score.volleys;
		
		score.text = "" + PlayState.instance.score.score;
		
		super.update(elapsed);
	}
	
}