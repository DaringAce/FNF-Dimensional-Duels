package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class Emeraldspr extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas("PumpkinNoteEFFECT");
		//animation.addByIndices('Symbol', 'Luna', [0], "", 0, false);
		animation.addByIndices('Emerald', 'Fire', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29], "", 24, true);
		animation.play('Emerald', true);
		antialiasing = true;
	}

	//var danceDir:Bool = false;

	/*public function dance():Void
	{
		//danceDir = !danceDir;

		//if (danceDir)
		animation.play('Emerald', true);
		//else
			//animation.play('danceLeft', true);
	}
	*/
}