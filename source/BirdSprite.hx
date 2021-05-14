package;

import flixel.FlxG;
import flixel.FlxSprite;

class BirdSprite extends FlxSprite
{
	var jumpTimer:Float = 0;
	var jumping:Bool = false;
	var game:Game;
	var jumpSoundName = "assets/sounds/jump.ogg";
	var volume = 0.5;
	var angleStep = ANGLE_STEP_DELTA;

	private static inline var JUMP_LIMIT = 0.25;
	private static inline var ANGLE_TIMER_LIMIT = 1.1;
	private static inline var MIN_ANGLE = -25;
	private static inline var MAX_ANGLE = 90;
	private static inline var ANGLE_STEP_DELTA = 0.001;

	public function new(x:Float = 0, y:Float = 0, game:Game)
	{
		super(x, y);
		this.game = game;
		// loadRotatedGraphic()
		loadGraphic("assets/images/bird-anim.png", true, 34, 24);
		setGraphicSize(-1, 32);
		setAnimation();
		this.acceleration.y = 900;
		this.maxVelocity.y = 150;
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
		var jumpPressed = FlxG.keys.justPressed.SPACE;

		if (!jumping && jumpPressed)
		{
			jumping = true;
			jumpTimer = 0;
			FlxG.sound.playMusic(jumpSoundName, volume, false);
		}

		if (jumping)
		{
			if (jumpTimer < JUMP_LIMIT)
			{
				this.velocity.y = -300;
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
		// var animationFrames = [1, 2, 3, 4, 5, 6].concat([for (i in 0...45) 0]);
		animation.add("fly", [0, 1, 2], 4);
		animation.play("fly");
	}
}
