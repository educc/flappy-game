package;

import flixel.group.FlxGroup;

class PipeGroup extends FlxGroup
{
	static inline var PIPE_GAP = 130;
	static inline var PIPE_MIN_HEIGHT = 50;

	var pipeTop:PipeSprite;
	var pipeBottom:PipeSprite;
	var maxY:Int;
	var game:Game;

	public function new(x:Float, maxY:Int, game:Game)
	{
		super();
		this.game = game;
		this.maxY = maxY;

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
		var max = this.maxY - PIPE_GAP - PIPE_MIN_HEIGHT * 2;
		var mid = randomNumber(0, max);
		var topHeight = PIPE_MIN_HEIGHT + mid;
		var bottomHeight = PIPE_MIN_HEIGHT + (max - mid);
		return [topHeight, bottomHeight];
	}

	private function randomNumber(min:Int, max:Int):Int
	{
		return Std.random(max + 1) + min;
	}
}
