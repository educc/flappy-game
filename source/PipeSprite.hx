package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class PipeSprite extends FlxSprite
{
	static inline var PIPE_WITH = 100;

	var game:Game;

	public function new(x:Float, y:Float, height:Int, game:Game)
	{
		super(x, y);
		this.game = game;
		makeGraphic(PIPE_WITH, height, FlxColor.LIME);
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
}
