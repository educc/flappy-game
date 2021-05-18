package states.play.input;

import flixel.FlxG;

class UserBirdBrain implements BirdBrain
{
	public function new() {}

	public function shouldJump():Bool
	{
		var jumpPressed = false;
		#if (web || desktop)
		jumpPressed = FlxG.keys.justPressed.SPACE;
		#end
		#if FLX_TOUCH
		var touched = FlxG.touches.getFirst();
		jumpPressed = if (touched != null && touched.justPressed) true else false;
		#end
		return jumpPressed;
	}
}
