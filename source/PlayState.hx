package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxAxes;

class PlayState extends FlxState
{
	var wallTop:FlxSprite;
	var wallBottom:FlxSprite;
	var walls:FlxGroup;
	var player:BirdSprite;
	var pipes:Array<PipeGroup> = new Array();

	static inline var PIPE_SPACE_X:Float = 200.0;
	static inline var PIPE_START_X:Float = 500.0;

	override public function create()
	{
		super.create();

		player = new BirdSprite(50, 0);
		player.screenCenter(FlxAxes.Y);
		add(player);

		// create walls
		wallTop = new WallSprite(0, 0);
		wallBottom = new WallSprite(0, FlxG.height - 4);

		add(wallTop);
		add(wallBottom);

		walls = new FlxGroup();
		walls.add(wallTop);
		walls.add(wallBottom);

		// create pipes
		createPipes(5);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, walls);
		player.update(elapsed);

		if (pipes[0].xAfterWidth() <= 0)
		{
			createPipes(1);
			var pipeRemoved = pipes.shift();
			remove(pipeRemoved);
		}
	}

	function createPipes(size:Int)
	{
		var x:Float = PIPE_START_X;
		if (pipes.length > 0)
		{
			x = pipes[pipes.length - 1].xAfterWidth() + PIPE_SPACE_X;
		}

		for (i in 0...size)
		{
			var newPipe = new PipeGroup(x);
			pipes.push(newPipe);

			x += PIPE_SPACE_X + newPipe.width();

			add(newPipe);
		}
	}
}
