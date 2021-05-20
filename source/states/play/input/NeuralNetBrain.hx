package states.play.input;

import ai.NeuralNet;
import flixel.FlxSprite;
import states.play.groups.ScrollPipesGroup;
import states.play.sprites.BirdSprite;

class NeuralNetBrain implements BirdBrain
{
	var _nn:NeuralNet;
	var _bird:FlxSprite;
	var _pipeGroup:ScrollPipesGroup;

	public function new(bird:BirdSprite, pipe:ScrollPipesGroup)
	{
		_bird = bird;
		_pipeGroup = pipe;
		_nn = new NeuralNet([1, -1], 40);
	}

	public function shouldJump():Bool
	{
		var y = _bird.y;
		var g = _pipeGroup.closest(_bird.x);
		var input = new NeuralNetInput(y, g.lowestPipe);
		var r = _nn.getOutput(input._input);
		return if (r == 1) true else false;
	}
}
