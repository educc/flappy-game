package;

import flixel.FlxG;
import flixel.group.FlxGroup;

class PipeGroup extends FlxGroup
{
	static inline var PIPE_GAP = 130;
	static inline var PIPE_MIN_HEIGHT = 80;

	var pipeTop:PipeSprite;
	var pipeBottom:PipeSprite;
	var game:Game;

	public function new(x:Float, game:Game)
	{
		super();

		this.game = game;
		var heights = makeHeights();
		pipeTop = new PipeSprite(x, 0, heights[0], game);
		pipeBottom = new PipeSprite(x, heights[0] + PIPE_GAP, heights[1], game);

		add(pipeTop);
		add(pipeBottom);
	}

	public function width()
	{
		return pipeTop.width;
	}

	public function x():Float
	{
		return pipeTop.x;
	}

	public function setX(x:Float)
	{
		pipeBottom.x = x;
		pipeTop.x = x;
	}

	public function xAfterWidth():Float
	{
		return pipeTop.x + pipeTop.width;
	}

	// helpers

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
