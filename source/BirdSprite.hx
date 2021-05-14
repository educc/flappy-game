package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class BirdSprite extends FlxSprite
{
	var jumpTimer:Float = 0;
	var jumping:Bool = false;
	var game:Game;
	var jumpSoundName = "assets/sounds/jump.ogg";
	var volume = 0.5;

	private static inline var JUMP_LIMIT = 0.25;

	public function new(x:Float = 0, y:Float = 0, game:Game)
	{
		super(x, y);
		this.game = game;
		loadRotatedGraphic()
		loadGraphic("assets/images/bird-anim.png", true, 43, 32);
		setAnimation();
		this.acceleration.y = 900;
		this.maxVelocity.y = 150;
	}

	override function update(elapsed:Float)
	{
		if (!game.isGameOver)
		{
			updateMovement(elapsed);
		}
		super.update(elapsed);
	}

	private function updateMovement(elapsed:Float)
	{
		var jumpPressed = FlxG.keys.justPressed.SPACE;
		jumpTimer += elapsed;

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
		animation.add("fly", [0, 1], 4);
		animation.play("fly");
	}
}
