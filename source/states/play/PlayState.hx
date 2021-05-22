package states.play;

import common.AssetsConstants;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import haxe.Timer;
import states.play.event.EventSource;
import states.play.event.PlayEvent;
import states.play.groups.ScrollPipesGroup;
import states.play.groups.ScrollSpriteGroup;
import states.play.input.NeuralNetBrain;
import states.play.input.UserBirdBrain;
import states.play.sprites.BackgroundSprite;
import states.play.sprites.BirdSprite;
import states.play.sprites.ScoreText;
import states.play.sprites.WallSprite;
import utils.SoundUtils;

class PlayState extends FlxState
{
	// props
	var isGameOver = false;
	var events = new EventSource();

	// sprites
	var wallTop:FlxSprite;
	var pipes:ScrollPipesGroup;
	var ground:ScrollSpriteGroup;
	var player:BirdSprite;
	var scoreText:ScoreText;

	override public function create()
	{
		// super.create();
		// FlxG.mouse.visible = false;
		// FlxG.scaleMode = new RatioScaleMode();

		add(new BackgroundSprite());

		// create pipes
		pipes = new ScrollPipesGroup(PlayConstants.GROUND_Y_START);
		add(pipes);

		// score
		scoreText = new ScoreText();
		add(scoreText);

		// create walls
		wallTop = new WallSprite(0, 0);
		wallTop.alpha = 0;
		ground = new ScrollSpriteGroup(PlayConstants.GROUND_Y_START, AssetsConstants.IMAGE_PLAY_GROUND);
		ground.setImmovable(true);

		add(wallTop);
		add(ground);

		// create bird
		createBird();
		// createIABird();

		// events
		events.subscribe(PlayEvent.GameOver, onGameOver);
		events.subscribe(PlayEvent.Point, onPoint);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, wallTop);
		FlxG.collide(player, ground, onBirdCollide);
		FlxG.overlap(player, pipes, onBirdCollide);
		calculateScore();
	}

	function onBirdCollide(player:FlxObject, anyWall:FlxObject)
	{
		if (isGameOver)
		{
			return;
		}
		SoundUtils.playReusableSound(AssetsConstants.SOUND_COLLIDE);
		events.emit(PlayEvent.GameOver);
	}

	function calculateScore()
	{
		if (player.x + player.width >= pipes.get(0).xAfterWidth())
		{
			var point = pipes.get(0).getPoints();
			if (point > 0)
			{
				events.emit(PlayEvent.Point);
			}
		}
	}

	function createBird()
	{
		player = new BirdSprite(0, 0);
		player.screenCenter();
		player.brain = new UserBirdBrain();
		add(player);
	}

	function createIABird()
	{
		player = new BirdSprite(0, 0);
		player.screenCenter();
		player.brain = new NeuralNetBrain(player, pipes);
		add(player);
	}

	// EVENTS

	function onGameOver()
	{
		trace("onGameOver");
		this.isGameOver = true;
		this.player.stop();
		this.ground.stop();
		this.pipes.stop();

		Timer.delay(() ->
		{
			FlxG.resetState();
		}, 2000);
	}

	function onPoint()
	{
		this.scoreText.increaseScore(1);
	}
}
