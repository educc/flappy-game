package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class BirdSprite extends FlxSprite
{
	var jumpTimer:Float = 0;
	var jumping:Bool = false;
	var game:Game;

	private static inline var JUMP_LIMIT = 0.25;

	public function new(x:Float = 0, y:Float = 0, game:Game)
	{
		super(x, y);
		this.game = game;
		makeGraphic(32, 32, FlxColor.BLUE);
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
}
