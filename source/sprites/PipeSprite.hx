package sprites;

import flixel.FlxSprite;

class PipeSprite extends FlxSprite
{
	static inline var PIPE_WITH = 80;
	static inline var IMAGE = "assets/images/pipe-green.png";

	var game:Game;

	public function new(x:Float, y:Float, rotate:Bool, game:Game)
	{
		super(x, y);
		this.game = game;

		loadGraphic(IMAGE, false, 52, 320);
		// makeGraphic(PIPE_WITH, height, FlxColor.LIME);
		setOrientation(rotate);
		this.immovable = true;
		this.velocity.x = game.backgroundVelocityX;
	}

	override function update(elapsed:Float)
	{
		if (game.isGameOver)
		{
			this.velocity.x = 0;
		}
		super.update(elapsed);
	}

	function setOrientation(rotate)
	{
		setGraphicSize(PIPE_WITH, -1);
		updateHitbox();

		if (rotate)
		{
			// this.angle = 180;
		}
		else
		{
			this.flipY = true;
			this.y = this.y - this.height;
		}
	}
}
