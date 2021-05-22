package states.intro;

import flixel.FlxG;
import flixel.FlxState;
import states.play.PlayState;
import states.play.sprites.BackgroundSprite;
import states.play.sprites.BirdSprite;

enum UserAction
{
	NoAction;
	PlayByHuman;
	PlayByAI;
}

class IntroState extends FlxState
{
	override public function create()
	{
		add(new BackgroundSprite());
		addBird();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		goToState(getUserAction());
	}

	// private

	function addBird()
	{
		var bird = new BirdSprite(0, 0);
		bird.acceleration.y = 0;
		bird.angleDelta = 0;
		bird.screenCenter();
		add(bird);
	}

	function goToState(action:UserAction)
	{
		var state = switch (action)
		{
			case NoAction: null;
			case PlayByHuman: new PlayState();
			case PlayByAI: new PlayState();
		}
		if (state != null)
		{
			FlxG.switchState(state);
		}
	}

	function getUserAction():UserAction
	{
		var action = UserAction.NoAction;
		#if (web || desktop)
		if (FlxG.mouse.justPressed)
		{
			action = UserAction.PlayByHuman;
		}
		#end
		return action;
	}
}
