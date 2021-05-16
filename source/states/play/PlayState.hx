package states.play;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.scaleModes.RatioScaleMode;
import haxe.Timer;
import states.play.groups.PipeGroup;
import states.play.groups.ScrollSpriteGroup;
import states.play.input.UserBirdBrain;
import states.play.sprites.BackgroundSprite;
import states.play.sprites.BirdSprite;
import states.play.sprites.ScoreText;
import states.play.sprites.WallSprite;
import utils.SoundUtils;

class PlayState extends FlxState
{
	var wallTop:FlxSprite;
	var ground:ScrollSpriteGroup;
	var player:BirdSprite;
	var pipes:Array<PipeGroup> = new Array();
	var collisionObjects:FlxGroup = new FlxGroup();
	var game:Game;
	var scoreText:ScoreText;
	var groundY:Int = 0;

	static inline var SOUND_COLLIDE = "assets/sounds/impact.ogg";
	static inline var PIPE_SPACE_X:Float = 200.0;
	static inline var PIPE_START_X:Float = 500.0;

	override public function create()
	{
		// super.create();
		FlxG.mouse.visible = false;
		FlxG.scaleMode = new RatioScaleMode();
		groundY = FlxG.height - 90;

		game = new Game();
		// game.backgroundVelocityX = -300;

		add(new BackgroundSprite());

		// create pipes
		createPipes(2);

		// score
		scoreText = new ScoreText();
		add(scoreText);

		// create walls
		wallTop = new WallSprite(0, 0);
		wallTop.alpha = 0;
		ground = new ScrollSpriteGroup(groundY, "assets/images/ground.png", game);
		ground.setImmovable(true);

		add(wallTop);
		add(ground);

		// create bird
		createBird();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, wallTop);
		FlxG.collide(player, ground, gameOver);
		FlxG.overlap(player, collisionObjects, gameOver);
		if (anyPipeIsOffsetScreen())
		{
			changePositionOffsetScreenPipe();
		}
		updateScore();
	}

	private function gameOver(player:FlxObject, anyWall:FlxObject)
	{
		if (this.game.isGameOver)
		{
			return;
		}
		this.game.isGameOver = true;
		SoundUtils.playReusableSound(SOUND_COLLIDE);
		Timer.delay(() ->
		{
			this.switchTo(new PlayState());
			FlxG.resetState();
		}, 2000);
	}

	function anyPipeIsOffsetScreen()
	{
		return pipes[0].xAfterWidth() < 0;
	}

	function changePositionOffsetScreenPipe()
	{
		var x = pipes[pipes.length - 1].xAfterWidth();

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
			var newPipe = mkPipe(x);
			pipes.push(newPipe);

			x += PIPE_SPACE_X + newPipe.width();

			collisionObjects.add(newPipe);
		}
		add(collisionObjects);
	}

	function mkPipe(x:Float)
	{
		return new PipeGroup(x, groundY, this.game);
	}

	function updateScore()
	{
		if (player.x + player.width >= pipes[0].xAfterWidth())
		{
			var point = pipes[0].getPoints();
			this.scoreText.increaseScore(point);
		}
	}

	function createBird()
	{
		player = new BirdSprite(0, 0, game);
		player.screenCenter();
		player.brain = new UserBirdBrain();
		add(player);
	}
}
