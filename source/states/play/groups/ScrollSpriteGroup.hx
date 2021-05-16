package states.play.groups;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

class ScrollSpriteGroup extends FlxGroup
{
	var left:FlxSprite;
	var right:FlxSprite;

	public function new(y:Float = 0, assetName:String)
	{
		super();
		left = new FlxSprite(0, y, assetName);
		right = new FlxSprite(left.width, y, assetName);

		left.velocity.x = PlayConstants.BACKGROUND_VELOCITY_X;
		right.velocity.x = PlayConstants.BACKGROUND_VELOCITY_X;

		add(left);
		add(right);
	}

	public function setImmovable(b:Bool)
	{
		left.immovable = b;
		right.immovable = b;
	}

	public function stop()
	{
		left.velocity.x = 0;
		right.velocity.x = 0;
	}

	override function update(elapsed:Float)
	{
		updateMovement(elapsed);
		super.update(elapsed);
	}

	private function updateMovement(elapsed:Float)
	{
		if (xAfterWidth(left) < 0)
		{
			left.x = xAfterWidth(right);
		}
		if (xAfterWidth(right) < 0)
		{
			right.x = xAfterWidth(left);
		}
	}

	private function xAfterWidth(sprite:FlxSprite):Float
	{
		return sprite.x + sprite.width;
	}
}
