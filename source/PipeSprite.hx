package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class PipeSprite extends FlxSprite
{
	static inline var PIPE_WITH = 100;

	public function new(x:Float, y:Float, height:Int)
	{
		super(x, y);
		makeGraphic(PIPE_WITH, height, FlxColor.LIME);
		this.immovable = true;
		this.velocity.x = -100;
	}
}
