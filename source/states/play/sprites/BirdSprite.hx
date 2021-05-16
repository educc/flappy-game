package states.play.sprites;

import flixel.FlxSprite;
import states.play.input.BirdBrain;
import utils.SoundUtils;

class BirdSprite extends FlxSprite
{
	// public props
	public var brain(default, default):Null<BirdBrain>;

	// props
	var jumpTimer:Float = 0;
	var jumping:Bool = false;
	var game:Game;

	// bird
	static inline var VELOCITY = 400;
	static inline var ACCELERATION = 2000;

	// jumping
	static inline var JUMP_LIMIT = 0.1;
	static inline var JUMP_HEIGHT = 350;
	static inline var ANGLE_TIMER_LIMIT = 0.5;
	static inline var MIN_ANGLE = -25;
	static inline var MAX_ANGLE = 90;

	// assets
	static inline var SOUND_JUMP = "assets/sounds/jump.ogg";
	static inline var ASSET_BIRD = "assets/images/bird-anim.png";

	public function new(x:Float = 0, y:Float = 0, game:Game)
	{
		super(x, y);
		this.game = game;
		loadGraphic(ASSET_BIRD, true, 34, 24);
		setGraphicSize(-1, 32);
		setAnimation();
		this.acceleration.y = ACCELERATION;
		this.maxVelocity.y = VELOCITY;
	}

	override function update(elapsed:Float)
	{
		jumpTimer += elapsed;
		if (!game.isGameOver)
		{
			updateMovement(elapsed);
		}
		else
		{
			animation.stop();
		}
		if (jumpTimer > ANGLE_TIMER_LIMIT)
		{
			this.angle = Math.min(MAX_ANGLE, this.angle + 4);
		}
		super.update(elapsed);
	}

	private function updateMovement(elapsed:Float)
	{
		var jumpPressed = shoudJump();

		if (!jumping && jumpPressed)
		{
			jumping = true;
			jumpTimer = 0;
			SoundUtils.playReusableSound(SOUND_JUMP);
		}

		if (jumping)
		{
			if (jumpTimer < JUMP_LIMIT)
			{
				this.velocity.y = -JUMP_HEIGHT;
				this.angle = MIN_ANGLE;
			}
			else
			{
				jumping = false;
			}
		}
	}

	function setAnimation()
	{
		animation.add("fly", [0, 1, 2], 8);
		animation.play("fly");
	}

	function shoudJump():Bool
	{
		if (this.brain == null)
		{
			return false;
		}
		return this.brain.shouldJump();
	}
}
