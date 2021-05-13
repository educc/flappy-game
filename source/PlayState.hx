package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxAxes;
import haxe.Timer;

class PlayState extends FlxState
{
	var wallTop:FlxSprite;
	var wallBottom:FlxSprite;
	var walls:FlxGroup;
	var player:BirdSprite;
	var pipes:Array<PipeGroup> = new Array();
	var collisionObjects:FlxGroup = new FlxGroup();
	var game:Game;

	static inline var PIPE_SPACE_X:Float = 200.0;
	static inline var PIPE_START_X:Float = 500.0;

	override public function create()
	{
		super.create();

		game = new Game();

		// create walls
		wallTop = new WallSprite(0, 0);
		wallBottom = new WallSprite(0, FlxG.height - 4);

		add(wallTop);
		add(wallBottom);
		// collisionObjects.add(wallBottom);

		// create pipes
		createPipes(3);

		// create bird
		player = new BirdSprite(50, 0, game);
		player.screenCenter(FlxAxes.Y);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, wallTop);
		FlxG.collide(player, wallBottom, gameOver);
		FlxG.overlap(player, collisionObjects, gameOver);
		player.update(elapsed);

		if (anyPipeIsOffsetScreen())
		{
			changePositionOffsetScreenPipe();
		}
	}

	private function gameOver(player:FlxObject, anyWall:FlxObject)
	{
		this.game.isGameOver = true;
		Timer.delay(() ->
		{
			this.switchTo(new PlayState());
			FlxG.resetState();
		}, 2000);
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
			var newPipe = new PipeGroup(x, game);
			pipes.push(newPipe);

			x += PIPE_SPACE_X + newPipe.width();

			collisionObjects.add(newPipe);
		}
		add(collisionObjects);
	}
}
