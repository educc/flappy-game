package;

import flixel.FlxG;

class SoundUtils
{
	static inline var VOLUME = 0.5;

	public static function playReusableSound(soundName:String)
	{
		FlxG.sound.play(soundName, VOLUME, false, null, false);
	}
}
