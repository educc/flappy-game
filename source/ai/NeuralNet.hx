package ai;

import haxe.Exception;

class NeuralNet
{
	var _weigths:Array<Float>;
	var _bias:Float;

	public function new(weigths:Array<Float>, bias:Float)
	{
		_weigths = weigths;
		_bias = bias;
	}

	public function getOutput(input:Array<Float>)
	{
		if (_weigths.length != input.length)
		{
			throw new Exception("len size must be same");
		}
		var result = 0.0;
		var n = _weigths.length;
		for (i in 0...n)
		{
			var w = _weigths[i];
			var inputItem = input[i];
			result += w * inputItem;
		}

		var inputRound = input.map(it -> Math.round(it));
		var r2 = Math.round(result);
		// trace('r=$r2 \t input=$inputRound');
		return activation(result + _bias);
	}

	// private

	function activation(n:Float)
	{
		return if (n >= 0) 1 else 0;
	}
}
