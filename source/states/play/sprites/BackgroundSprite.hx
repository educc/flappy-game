package states.play.sprites;

import flixel.FlxSprite;

class BackgroundSprite extends FlxSprite
{
	static inline var ASSET = "assets/images/background.png";

	public function new()
	{
		super(0, 0, ASSET);
	}
}
