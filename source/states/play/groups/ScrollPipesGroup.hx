package states.play.groups;

import flixel.FlxG;
import flixel.group.FlxGroup;

class ScrollPipesGroup extends FlxGroup
{
	var _pipes:Array<PipeGroup> = new Array();
	var _spaceBetweenPipes:Float;
	var _positionY:Int;

	public function new(positionY:Int)
	{
		super();
		_spaceBetweenPipes = FlxG.width / 2.0;
		_positionY = positionY;
		createPipes(2);
	}

	override public function update(elapsed:Float)
	{
		if (anyPipeIsOffsetScreen())
		{
			changePositionOffsetScreenPipe();
		}
		super.update(elapsed);
	}

	// public

	public function stop()
	{
		for (p in _pipes)
		{
			p.stop();
		}
	}

	public function get(idx:Int):PipeGroup
	{
		return _pipes[idx];
	}

	// private

	function anyPipeIsOffsetScreen()
	{
		return _pipes[0].xAfterWidth() < 0;
	}

	function changePositionOffsetScreenPipe()
	{
		var x = _pipes[_pipes.length - 1].xAfterWidth();

		var pipesToRemove = _pipes.filter(it -> it.xAfterWidth() < 0);
		for (pipe in pipesToRemove)
		{
			var newX = x + _spaceBetweenPipes;
			var newPipe = mkPipe(newX);

			_pipes.remove(pipe);
			_pipes.push(newPipe);

			this.remove(pipe);
			this.add(newPipe);
		}
	}

	function createPipes(size:Int)
	{
		var x:Float = FlxG.width * 1.5;

		for (i in 0...size)
		{
			var newPipe = mkPipe(x);
			_pipes.push(newPipe);

			x += _spaceBetweenPipes + newPipe.width();

			this.add(newPipe);
		}
	}

	function mkPipe(x:Float)
	{
		return new PipeGroup(x, _positionY);
	}
}
