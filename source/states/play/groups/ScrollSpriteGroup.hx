package states.play.groups;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

class ScrollSpriteGroup extends FlxGroup
{
	var _sprites:Array<FlxSprite> = new Array();

	public function new(y:Float = 0, repeat = 1, assetName:String)
	{
		super();
		createSprites(y, repeat, assetName);
	}

	public function setImmovable(b:Bool)
	{
		for (sprite in _sprites)
		{
			sprite.immovable = b;
		}
	}

	public function stop()
	{
		for (sprite in _sprites)
		{
			sprite.velocity.x = 0;
		}
	}

	override function update(elapsed:Float)
	{
		updateMovement(elapsed);
		super.update(elapsed);
	}

	// privates

	function createSprites(y:Float, number:Int, assetName:String)
	{
		var x = 0.0;
		for (i in 0...number)
		{
			var sprite = new FlxSprite(x, y, assetName);
			sprite.velocity.x = PlayConstants.BACKGROUND_VELOCITY_X;

			_sprites.push(sprite);
			add(sprite);

			x += sprite.width;
		}
	}

	function updateMovement(elapsed:Float)
	{
		var left = getSpriteLeftOffScreen();

		if (left != null)
		{
			var right = getSpriteRightOffScreen();
			_sprites.remove(left);
			left.x = xAfterWidth(right);
			_sprites.push(left);
		}
	}

	inline function xAfterWidth(sprite:FlxSprite):Float
	{
		return sprite.x + sprite.width;
	}

	function getSpriteLeftOffScreen()
	{
		if (xAfterWidth(_sprites[0]) < 0)
		{
			return _sprites[0];
		}
		return null;
	}

	function getSpriteRightOffScreen()
	{
		return _sprites[_sprites.length - 1];
	}
}
