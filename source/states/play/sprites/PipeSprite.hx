package states.play.sprites;

import common.AssetsConstants;
import flixel.FlxSprite;

class PipeSprite extends FlxSprite
{
	static inline var PIPE_WITH = 80;

	public function new(x:Float, y:Float, rotate:Bool)
	{
		super(x, y, AssetsConstants.IMAGE_PLAY_PIPE);
		setOrientation(rotate);
		this.immovable = true;
		this.velocity.x = PlayConstants.BACKGROUND_VELOCITY_X;
	}

	public function stop()
	{
		this.velocity.x = 0;
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
