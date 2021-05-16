package states.play.sprites;

import flixel.FlxG;
import flixel.text.FlxText;

class ScoreText extends FlxText
{
	var currentText = "0";
	var score = 0;

	static inline var POS_Y = 50;
	static inline var FONT_SIZE = 28;

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
		this.currentText = Std.string(this.score);
	}
}
