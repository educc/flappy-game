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
	var ground:ScrollSpriteGroup;
	var walls:FlxGroup;
	var player:BirdSprite;
	var pipes:Array<PipeGroup> = new Array();
	var collisionObjects:FlxGroup = new FlxGroup();
	var game:Game;

	var collideSoundName = "assets/sounds/impact.ogg";
	var volume = 0.5;

	static inline var PIPE_SPACE_X:Float = 200.0;
	static inline var PIPE_START_X:Float = 500.0;
	static inline var GROUND_Y:Int = 550;

	override public function create()
	{
		super.create();

		game = new Game();
		// game.backgroundVelocityX = -300;

		setBackground();

		// create pipes
		createPipes(2);

		// create walls
		wallTop = new WallSprite(0, 0);
		wallTop.alpha = 0;
		ground = new ScrollSpriteGroup(GROUND_Y, "assets/images/ground.png", game);
		ground.setImmovable(true);

		add(wallTop);
		add(ground);

		// create bird
		player = new BirdSprite(50, 0, game);
		player.screenCenter(FlxAxes.Y);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, wallTop);
		FlxG.collide(player, ground, gameOver);
		FlxG.overlap(player, collisionObjects, gameOver);
		player.update(elapsed);

		if (anyPipeIsOffsetScreen())
		{
			changePositionOffsetScreenPipe();
		}
	}

	private function gameOver(player:FlxObject, anyWall:FlxObject)
	{
		if (this.game.isGameOver)
		{
			return;
		}
		this.game.isGameOver = true;
		FlxG.sound.playMusic(collideSoundName, volume, false);
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

		var pipesToRemove = pipes.filter(it -> it.xAfterWidth() < 0);
		for (pipe in pipesToRemove)
		{
			var newX = x + PIPE_SPACE_X;
			var newPipe = mkPipe(newX);

			pipes.remove(pipe);
			pipes.push(newPipe);

			collisionObjects.remove(pipe);
			collisionObjects.add(newPipe);
		}
	}

	function createPipes(size:Int)
	{
		var x:Float = PIPE_START_X;

		for (i in 0...size)
		{
			var newPipe = new PipeGroup(x, GROUND_Y, game);
			pipes.push(newPipe);

			x += PIPE_SPACE_X + newPipe.width();

			collisionObjects.add(newPipe);
		}
		add(collisionObjects);
	}

	function mkPipe(x:Float)
	{
		return new PipeGroup(x, GROUND_Y, this.game);
	}

	function setBackground()
	{
		// var bg = new ScrollSpriteGroup(0, "assets/images/background.png", game);
		var bg = new FlxSprite(0, 0, "assets/images/background.png");
		add(bg);
	}
}
