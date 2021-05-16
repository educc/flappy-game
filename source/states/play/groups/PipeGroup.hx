package states.play.groups;

import flixel.group.FlxGroup;
import states.play.sprites.PipeSprite;

class PipeGroup extends FlxGroup
{
	static inline var PIPE_GAP = 130;
	static inline var PIPE_MIN_HEIGHT = 50;

	var pipeTop:PipeSprite;
	var pipeBottom:PipeSprite;
	var maxY:Int;
	var game:Game;
	var point = 1;

	public function new(x:Float, maxY:Int, game:Game)
	{
		super();
		this.game = game;
		this.maxY = maxY;

		var pos = makeYpositions();

		pipeTop = new PipeSprite(x, pos[0], false, game);
		pipeBottom = new PipeSprite(x, pos[1], true, game);

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

	public function getPoints():Int
	{
		var result = point;
		point = Std.int(Math.max(0, point - 1));
		return result;
	}

	// helpers

	private function makeYpositions():Array<Int>
	{
		var max = this.maxY - PIPE_GAP - PIPE_MIN_HEIGHT * 2;
		var mid = randomNumber(0, max);
		var topHeight = PIPE_MIN_HEIGHT + mid;
		var bottomHeight = topHeight + PIPE_GAP;
		return [topHeight, bottomHeight];
	}

	private function randomNumber(min:Int, max:Int):Int
	{
		return Std.random(max + 1) + min;
	}
}
