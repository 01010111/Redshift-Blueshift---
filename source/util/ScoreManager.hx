package util;

/**
 * ...
 * @author x01010111
 */
class ScoreManager
{
	public var score:Int = 0;
	public var volleys:Int = 0;
	
	public function new() 
	{
		
	}
	
	public function points(P:Int):Void
	{
		score += P;
	}
	
	public function volley():Void
	{
		volleys++;
	}
	
}