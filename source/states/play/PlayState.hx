package states.play;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.scaleModes.RatioScaleMode;
import haxe.Timer;
import states.play.event.EventSource;
import states.play.event.PlayEvent;
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
	// props
	var pipes:Array<PipeGroup> = new Array();
	var groundY:Int = 0;
	var isGameOver = false;
	var events = new EventSource();

	// sprites
	var wallTop:FlxSprite;
	var ground:ScrollSpriteGroup;
	var player:BirdSprite;
	var collisionObjects:FlxGroup = new FlxGroup();
	var scoreText:ScoreText;

	// constans
	static inline var SOUND_COLLIDE = "assets/sounds/impact.ogg";
	static inline var PIPE_SPACE_X:Float = 200.0;
	static inline var PIPE_START_X:Float = 500.0;

	override public function create()
	{
		// super.create();
		FlxG.mouse.visible = false;
		FlxG.scaleMode = new RatioScaleMode();
		groundY = FlxG.height - 90;

		add(new BackgroundSprite());

		// create pipes
		createPipes(2);

		// score
		scoreText = new ScoreText();
		add(scoreText);

		// create walls
		wallTop = new WallSprite(0, 0);
		wallTop.alpha = 0;
		ground = new ScrollSpriteGroup(groundY, "assets/images/ground.png");
		ground.setImmovable(true);

		add(wallTop);
		add(ground);

		// create bird
		createBird();

		// events
		events.subscribe(PlayEvent.GameOver, onGameOver);
		events.subscribe(PlayEvent.Point, onPoint);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, wallTop);
		FlxG.collide(player, ground, onBirdCollide);
		FlxG.overlap(player, collisionObjects, onBirdCollide);
		if (anyPipeIsOffsetScreen())
		{
			changePositionOffsetScreenPipe();
		}
		calculateScore();
	}

	function onBirdCollide(player:FlxObject, anyWall:FlxObject)
	{
		if (isGameOver)
		{
			return;
		}
		SoundUtils.playReusableSound(SOUND_COLLIDE);
		events.emit(PlayEvent.GameOver);
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
		return new PipeGroup(x, groundY, this.events);
	}

	function calculateScore()
	{
		if (player.x + player.width >= pipes[0].xAfterWidth())
		{
			var point = pipes[0].getPoints();
			if (point > 0)
			{
				events.emit(PlayEvent.Point);
			}
		}
	}

	function createBird()
	{
		player = new BirdSprite(0, 0, this.events);
		player.screenCenter();
		player.brain = new UserBirdBrain();
		add(player);
	}

	// EVENTS

	function onGameOver()
	{
		trace("onGameOver");
		this.isGameOver = true;
		this.ground.stop();

		Timer.delay(() ->
		{
			this.switchTo(new PlayState());
			FlxG.resetState();
		}, 2000);
	}

	function onPoint()
	{
		this.scoreText.increaseScore(1);
	}
}
