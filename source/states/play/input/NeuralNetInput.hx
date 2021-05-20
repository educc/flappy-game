package states.play.input;

class NeuralNetInput
{
	public var _input(default, default):Array<Float>;

	public function new(bird:Float, pipe:Float)
	{
		_input = [bird, pipe];
	}
}
