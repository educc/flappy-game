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
	var allPipesGroup:FlxGroup = new FlxGroup();

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
		createPipes(3);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, walls);
		// FlxG.collide(player, allPipesGroup);
		player.update(elapsed);

		if (anyPipeIsOffsetScreen())
		{
			changePositionOffsetScreenPipe();
		}
	}

	function anyPipeIsOffsetScreen()
	{
		for (pipe in pipes)
		{
			if (pipe.xAfterWidth() < 0)
			{
				return true;
			}
		}
		return false;
	}

	function changePositionOffsetScreenPipe()
	{
		var x = 0.0;
		for (pipe in pipes)
		{
			if (pipe.xAfterWidth() > x)
			{
				x = pipe.xAfterWidth();
			}
		}

		for (pipe in pipes)
		{
			if (pipe.xAfterWidth() < 0)
			{
				pipe.setX(x + PIPE_SPACE_X);
			}
		}
	}

	function createPipes(size:Int)
	{
		var x:Float = PIPE_START_X;

		for (i in 0...size)
		{
			var newPipe = new PipeGroup(x);
			pipes.push(newPipe);

			x += PIPE_SPACE_X + newPipe.width();

			allPipesGroup.add(newPipe);
		}
		add(allPipesGroup);
	}
}
