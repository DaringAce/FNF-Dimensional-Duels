package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class BackgroundLuna extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas("weeb/Luna",'week2');
		//animation.addByIndices('Symbol', 'Luna', [0], "", 0, false);
		animation.addByIndices('Idle', 'AcesHouseIdle', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], "", 24, false);
		antialiasing = true;
	}

	var danceDir:Bool = false;

	public function dance():Void
	{
			animation.play('Idle', true);
	}
}
