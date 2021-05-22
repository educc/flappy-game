package states.play.sprites;

import common.AssetsConstants;
import flixel.FlxSprite;
import openfl.Assets;
import states.play.input.BirdBrain;
import utils.SoundUtils;

class BirdSprite extends FlxSprite
{
	// public props
	public var brain(default, default):Null<BirdBrain>;
	public var angleDelta(default, default):Float = 4;

	// props
	var jumpTimer:Float = 0;
	var jumping:Bool = false;
	var keepMoving = true;

	// bird
	static inline var VELOCITY = 400;
	static inline var ACCELERATION = 2000;
	static inline var ANIMATION_NAME = "fly";

	// jumping
	static inline var JUMP_LIMIT = 0.1;
	static inline var JUMP_HEIGHT = 350;
	static inline var ANGLE_TIMER_LIMIT = 0.5;
	static inline var MIN_ANGLE = -25;
	static inline var MAX_ANGLE = 90;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic(AssetsConstants.SPRITE_BIRD, true, 34, 24);
		setGraphicSize(-1, 32);
		setAnimation();
		this.acceleration.y = ACCELERATION;
		this.maxVelocity.y = VELOCITY;
	}

	// public

	public function stop()
	{
		keepMoving = false;
	}

	// private

	override function update(elapsed:Float)
	{
		jumpTimer += elapsed;

		if (this.keepMoving)
		{
			updateMovement(elapsed);
		}
		stopAnimationOnFalling();
		rotateBridOnFalling();

		super.update(elapsed);
	}

	function stopAnimationOnFalling()
	{
		if (this.velocity.y >= 0 && this.angleDelta != 0)
		{
			animation.stop();
		}
	}

	function rotateBridOnFalling()
	{
		if (this.velocity.y >= 0 && jumpTimer > ANGLE_TIMER_LIMIT)
		{
			this.angle = Math.min(MAX_ANGLE, this.angle + this.angleDelta);
		}
	}

	function updateMovement(elapsed:Float)
	{
		var jumpPressed = shoudJump();

		if (!jumping && jumpPressed)
		{
			jumping = true;
			jumpTimer = 0;
			SoundUtils.playReusableSound(AssetsConstants.SOUND_JUMP);
			animation.play(ANIMATION_NAME);
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
		animation.add(ANIMATION_NAME, [0, 1, 2], 8);
		animation.play(ANIMATION_NAME);
	}

	function shoudJump():Bool
	{
		return if (this.brain == null) false else this.brain.shouldJump();
	}
}
