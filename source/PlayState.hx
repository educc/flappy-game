package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.system.FlxSplash;
import flixel.util.FlxAxes;

class PlayState extends FlxState
{
	var wallTop:FlxSprite;
	var wallBottom:FlxSprite;
	var walls:FlxGroup;
	var player:BirdSprite;

	override public function create()
	{
		super.create();

		player = new BirdSprite(50, 0);
		player.screenCenter(FlxAxes.Y);
		add(player);

		// create walls
		wallTop = new WallSprite(0, 0);
		wallBottom = new WallSprite(0, FlxG.height - 4);

		add(wallTop);
		add(wallBottom);

		walls = new FlxGroup();
		walls.add(wallTop);
		walls.add(wallBottom);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.collide(player, walls);
		player.update(elapsed);
	}
}
