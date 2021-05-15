package sprites;

import flixel.FlxG;
import flixel.FlxSprite;

class BackgroundSprite extends FlxSprite
{
	static inline var ASSET = "assets/images/background.png";

	public function new()
	{
		super(0, 0);
		loadGraphic(ASSET);
		setGraphicSize(-1, FlxG.height);
	}
}
