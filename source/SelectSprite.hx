package;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class SelectSprite extends FlxSprite
{

    public var selected:Bool = true;
	public function new(x:Float, y:Float,boyfriend:String)
	{
		super(x, y);
        var daTex = Paths.getSparrowAtlas('charMenu');

        frames = daTex;

		//frames = FlxAtlasFrames.fromSparrow("assets/preload/images/charMenu.png", "assets/preload/images/charMenu.xml");
        antialiasing = true;
        switch (boyfriend){
        case 'BOYFRIEND':
            anim('idle','BF Idle');
            anim('cheer','BF Hey');
        case 'bf-golden':
            anim('idle','G BF Idle');
            anim('cheer','G BF Hey');
        }
        
	}


    function anim(name,animName){
        //WHY DID I MAKE A FUNCTION FOR LIKE 6 ANIMS HAHAHAHA
        
    animation.addByPrefix(name, animName, 24, true);
    }
	
}