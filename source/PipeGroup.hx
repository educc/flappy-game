package;

import flixel.FlxG;
import flixel.group.FlxGroup;

class PipeGroup extends FlxGroup
{
	static inline var PIPE_GAP = 130;
	static inline var PIPE_MIN_HEIGHT = 100;

	public function new(x:Float)
	{
		super();

		var heights = makeHeights();
		trace(heights);
		var pipeTop = new PipeSprite(x, 0, heights[0]);
		var pipeBottom = new PipeSprite(x, heights[0] + PIPE_GAP, heights[1]);

		add(pipeTop);
		add(pipeBottom);
	}

	private function makeHeights():Array<Int>
	{
		var topHeight = randomNumber(0, FlxG.height - PIPE_MIN_HEIGHT * 2 - PIPE_GAP) + PIPE_MIN_HEIGHT;
		var bottomHeight = FlxG.height - PIPE_GAP - PIPE_MIN_HEIGHT;
		return [topHeight, bottomHeight];
	}

	private function randomNumber(min:Int, max:Int):Int
	{
		return Std.random(max + 1) + min;
	}
}
