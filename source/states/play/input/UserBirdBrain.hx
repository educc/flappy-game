package states.play.input;

import flixel.FlxG;

class UserBirdBrain implements BirdBrain
{
	public function new() {}

	public function shouldJump():Bool
	{
		var jumpPressed = false;

		#if mobile
		var touched = FlxG.touches.getFirst();
		jumpPressed = if (touched != null && touched.justPressed) true else false;
		#end
		#if (web || desktop)
		jumpPressed = FlxG.keys.justPressed.SPACE;
		#end
		return jumpPressed;
	}
}
