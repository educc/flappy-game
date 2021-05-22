package states.intro;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import states.play.PlayState;
import states.play.sprites.BackgroundSprite;
import states.play.sprites.BirdSprite;
import states.play.sprites.GroundSprite;
import states.playai.PlayAIState;

enum UserAction
{
	PlayByHuman;
	PlayByAI;
}

class IntroState extends FlxState
{
	var _bird:BirdSprite;

	override public function create()
	{
		add(new BackgroundSprite());
		add(new GroundSprite());
		addTitle();
		// addSubText();
		addBird();
		addButtons();
	}

	function addBird()
	{
		_bird = new BirdSprite(0, 0);
		_bird.acceleration.y = 0;
		_bird.angleDelta = 0;
		_bird.screenCenter();
		add(_bird);
	}

	function addTitle()
	{
		var y = FlxG.height / 2.0 - 150;
		var text = new FlxText(0, y, FlxG.width, "FlappyGame");
		text.setFormat(null, 32, FlxColor.BLACK);
		text.alignment = FlxTextAlign.CENTER;
		text.setBorderStyle(OUTLINE, FlxColor.WHITE, 2);

		add(text);
	}

	function addSubText()
	{
		var strText = "Click to play";
		#if mobile
		strText = "Tap to play";
		#end
		var y = FlxG.height / 2.0 + 80;
		var text = new FlxText(0, y, FlxG.width, strText);
		text.setFormat(null, 18, FlxColor.BLACK);
		text.alignment = FlxTextAlign.CENTER;
		text.setBorderStyle(OUTLINE, FlxColor.WHITE, 2);

		add(text);
	}

	function addButtons()
	{
		var y = FlxG.height / 2.0 + 80;
		var x = FlxG.width / 2.0;
		var separation = 40;

		var humanBtn = new FlxButton("Human", () -> goToState(UserAction.PlayByHuman));
		humanBtn.setGraphicSize(0, 32);
		humanBtn.y = y;
		humanBtn.x = x - separation - humanBtn.width;

		var iaBtn = new FlxButton("AI", () -> goToState(UserAction.PlayByAI));
		iaBtn.setGraphicSize(0, 32);
		iaBtn.y = y;
		iaBtn.x = x + separation;

		add(humanBtn);
		add(iaBtn);
	}

	function goToState(action:UserAction)
	{
		var state = switch (action)
		{
			case PlayByHuman: new PlayState();
			case PlayByAI: new PlayAIState();
		}
		FlxG.switchState(state);
	}

	// function getUserAction():UserAction
	// {
	// 	var action = UserAction.NoAction;
	// 	#if (web || desktop)
	// 	if (FlxG.mouse.justPressed)
	// 	{
	// 		action = UserAction.PlayByHuman;
	// 	}
	// 	#end
	// 	#if mobile
	// 	var touched = FlxG.touches.getFirst();
	// 	action = if (touched != null && touched.justPressed) UserAction.PlayByHuman;
	// 	#end
	// 	return action;
	// }
}
