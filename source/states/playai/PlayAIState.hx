package states.playai;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import states.intro.IntroState;
import states.play.PlayState;
import states.play.input.NeuralNetBrain;
import states.play.sprites.BirdSprite;

class PlayAIState extends PlayState
{
	override public function create()
	{
		super.create();
		addSubText();
	}

	public override function createBird()
	{
		player = new BirdSprite(0, 0);
		player.screenCenter();
		player.brain = new NeuralNetBrain(player, pipes);
		add(player);
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (userClicked())
		{
			FlxG.switchState(new IntroState());
		}
	}

	// private

	function addSubText()
	{
		var strText = "AI playing - Click to go back";
		#if mobile
		strText = "AI playing - Tap to go back";
		#end
		var y = FlxG.height - 50;
		var text = new FlxText(0, y, FlxG.width, strText);
		text.setFormat(null, 18, FlxColor.BLACK);
		text.alignment = FlxTextAlign.CENTER;
		text.setBorderStyle(OUTLINE, FlxColor.WHITE, 2);

		add(text);
	}

	function userClicked():Bool
	{
		var action = false;
		#if (web || desktop)
		action = FlxG.mouse.justPressed;
		#end
		#if mobile
		var touched = FlxG.touches.getFirst();
		action = touched != null && touched.justPressed;
		#end
		return action;
	}
}
