package;

import flixel.FlxSprite;
import flixel.group.FlxGroup;

class ScrollSpriteGroup extends FlxGroup
{
	var game:Game;
	var assetName:String;

	var left:FlxSprite;
	var right:FlxSprite;

	public function new(y:Float = 0, assetName:String, game:Game)
	{
		super();
		this.game = game;
		this.assetName = assetName;

		left = new FlxSprite(0, y, assetName);
		right = new FlxSprite(left.width, y, assetName);

		left.velocity.x = game.backgroundVelocityX;
		right.velocity.x = game.backgroundVelocityX;

		add(left);
		add(right);
	}

	public function setImmovable(b:Bool)
	{
		left.immovable = b;
		right.immovable = b;
	}

	override function update(elapsed:Float)
	{
		if (game.isGameOver)
		{
			left.velocity.x = 0;
			right.velocity.x = 0;
		}
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
