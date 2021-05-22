package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.intro.IntroState;
import states.play.PlayState;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(360, 640, IntroState, 3));
	}
}
