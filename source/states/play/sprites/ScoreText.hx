package states.play.sprites;

import flixel.FlxG;
import flixel.text.FlxText;
import utils.SoundUtils;

/**
 * Handle Score starting from 0
 * if the score increase then play a sound
 */
class ScoreText extends FlxText
{
	var currentText = "0";
	var score = 0;

	static inline var POS_Y = 50;
	static inline var FONT_SIZE = 28;
	static inline var SOUND_COIN = "assets/sounds/coin.ogg";

	public function new()
	{
		super(0, POS_Y, FlxG.width, currentText, FONT_SIZE);
		this.alignment = FlxTextAlign.CENTER;
	}

	override public function update(elapsed:Float)
	{
		this.text = currentText;
		super.update(elapsed);
	}

	public function increaseScore(increase = 1)
	{
		this.score += increase;
		if (increase > 0)
		{
			SoundUtils.playReusableSound(SOUND_COIN);
		}
		this.currentText = Std.string(this.score);
	}
}
