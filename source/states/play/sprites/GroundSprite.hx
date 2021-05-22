package states.play.sprites;

import common.AssetsConstants;
import states.play.groups.ScrollSpriteGroup;

class GroundSprite extends ScrollSpriteGroup
{
	public function new()
	{
		super(PlayConstants.GROUND_Y_START, 3, AssetsConstants.IMAGE_PLAY_GROUND);
		this.setImmovable(true);
	}
}
