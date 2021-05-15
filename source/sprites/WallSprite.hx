package sprites;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class WallSprite extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		makeGraphic(FlxG.width, 4, FlxColor.LIME);
		this.immovable = true;
	}
}
