package states.play.sprites;

import flixel.FlxG;
import flixel.FlxSprite;

class BackgroundSprite extends FlxSprite
{
	static inline var ASSET = "assets/images/background.png";

	public function new()
	{
		super(0, 0);
		loadGraphic(ASSET, false, 360, 640);
		setGraphicSize(-1, FlxG.height);
		this.y = 0;
		this.x = 0;
	}
}
