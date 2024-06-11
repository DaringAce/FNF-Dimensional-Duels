import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.text.FlxBitmapText;
import flixel.FlxSprite;
import sys.io.File;
import haxe.Json;


using StringTools;

typedef LoreData =
{
    char:String,
    desc:String
}

class LoreState extends MusicBeatState
{
    var json:Array<LoreData> = Json.parse(File.getContent('assets/images/lorechars/data.json'));
    var curSelected:Int = 0;
    var curSelectedDesc:Int = 0;

    var bg:FlxSprite;
    var charSpace:FlxSprite;
    var charName:FlxText;
    var char:FlxSprite;
    var descSpace:FlxSprite;
    var desc:FlxText;
    var counterSpace:FlxSprite;
    var counter:FlxText;
    var leftArrow:FlxText;
    var rightArrow:FlxText;

    override function create()
    {
        super.create();

        bg = new FlxSprite().loadGraphic(Paths.image('menudd'));
        bg.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        add(bg);

        charSpace = new FlxSprite(FlxG.width * 0.05, FlxG.height * 0.1).makeGraphic(Std.int(FlxG.width * 0.3), Std.int(FlxG.height * 0.5), FlxColor.BLACK);
        charSpace.alpha = 0.5;
        charSpace.antialiasing = ClientPrefs.globalAntialiasing;
        add(charSpace);

        charName = new FlxText(charSpace.x + (charSpace.width * 0.05), charSpace.y + charSpace.height, charSpace.width * 0.9, "Test");
        charName.setFormat(Paths.font("vcr.ttf"), 40, CENTER);
        charName.antialiasing = ClientPrefs.globalAntialiasing;
        charName.y -= charName.height + 10;
        add(charName);

        char = new FlxSprite(charSpace.x + (charSpace.width * 0.05),
            charSpace.y + (charSpace.width * 0.05)).makeGraphic(Std.int(charSpace.width * 0.9), Std.int(charSpace.height * 0.75));
        add(char);

        descSpace = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.1).makeGraphic(Std.int(FlxG.width * 0.55), Std.int(FlxG.height * 0.5), FlxColor.BLACK);
        descSpace.alpha = 0.5;
        descSpace.antialiasing = ClientPrefs.globalAntialiasing;
        add(descSpace);

        desc = new FlxText(); // Changed to TextArea
        desc.width = descSpace.width * 0.9;
        desc.x = descSpace.x + (descSpace.width * 0.05);
        desc.y = descSpace.y + (descSpace.width * 0.05);
        desc.height = descSpace.height * 0.9;
        add(desc);

        counterSpace = new FlxSprite(0, FlxG.height).makeGraphic(Std.int(FlxG.width * 0.7), Std.int(FlxG.height * 0.2), FlxColor.BLACK);
        counterSpace.screenCenter(X);
        counterSpace.y -= counterSpace.height + (FlxG.height * 0.05);
        counterSpace.alpha = 0.5;
        counterSpace.antialiasing = ClientPrefs.globalAntialiasing;
        add(counterSpace);

        counter = new FlxText(counterSpace.x + (counterSpace.width * 0.05), counterSpace.y + (counterSpace.width * 0.05), counterSpace.width * 0.9);
        counter.setFormat(Paths.font("vcr.ttf"), 80, CENTER, OUTLINE, FlxColor.BLACK);
        counter.borderSize = 2;
        counter.antialiasing = ClientPrefs.globalAntialiasing;
        counter.y = counterSpace.y + (counterSpace.height / 2) - (counter.height / 2);
        add(counter);

        leftArrow = new FlxText(FlxG.width * 0.1, "<");
        leftArrow.setFormat(Paths.font("vcr.ttf"), 120, OUTLINE, FlxColor.BLACK);
        leftArrow.borderSize = 4;
        leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
        leftArrow.y = counterSpace.y + (counterSpace.height / 2) - (leftArrow.height / 2);

        add(leftArrow);

        rightArrow = new FlxText(FlxG.width * 0.9, ">");
        rightArrow.setFormat(Paths.font("vcr.ttf"), 120, OUTLINE, FlxColor.BLACK);
        rightArrow.borderSize = 4;
        rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
        rightArrow.y = counterSpace.y + (counterSpace.height / 2) - (rightArrow.height / 2);

        rightArrow.x -= rightArrow.width;
        add(rightArrow);

        changeItem();
        changeDesc();
    }

    function changeItem(huh:Int = 0)
    {
        curSelected += huh;
        curSelectedDesc = 0;


        if (curSelected >= json.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = json.length - 1;

        if (json.length == 0)
            return;

        charName.text = json[curSelected].char;
        desc.text = json[curSelected].desc;
        desc.y = descSpace.y + (descSpace.height * 0.05);
        desc.height = descSpace.height * 0.9;

        var oldChar = char.graphic;
        char.loadGraphic(Paths.image('lorechars/${charName.text}'));
        if (char.graphic == oldChar)
            return;

        do
        {
            char.scale.add(-0.05, -0.05);
            char.updateHitbox();
        }
        while (char.width > charName.width || char.height > charSpace.height * 0.8);
        char.x = charSpace.x + (charSpace.width / 2) - (char.width / 2);
        char.y = charSpace.y + (charSpace.height / 2) - (char.height / 2);

        charName.text = charName.text.replace("_", " ");
        charName.text = charName.text.charAt(0).toUpperCase() + charName.text.substr(1);

        if (huh != 0)
        {
            if (huh < 0)
            {
                leftArrow.x = FlxG.width * 0.05;
                FlxTween.cancelTweensOf(leftArrow, ["x"]);
                FlxTween.tween(leftArrow, {x: FlxG.width * 0.1}, 0.5, {ease: FlxEase.quadOut});
            }
            else
            {
                rightArrow.x = (FlxG.width * 0.95) - rightArrow.width;
                FlxTween.cancelTweensOf(rightArrow, ["x"]);
                FlxTween.tween(rightArrow, {x: (FlxG.width * 0.9) - rightArrow.width}, 0.5, {ease: FlxEase.quadOut});
            }
        }
    }


    function changeDesc(huh:Int = 0)
    {
        curSelectedDesc +=huh;


        if (curSelectedDesc >= json.length)
            curSelectedDesc = 0;
        if (curSelectedDesc < 0)
            curSelectedDesc = json.length - 1;

        if (json.length == 0)
            return;

        
        desc.text = json[curSelectedDesc].desc;
        desc.y = descSpace.y + (descSpace.height * 0.05);
        desc.height = descSpace.height * 0.9;

    }




    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.UI_LEFT_P)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeItem(-1);
        }

        if (controls.UI_RIGHT_P)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeItem(1);
        }


        // changeDesc basically moves the description provided so for each char it would have different descriptions

        if (controls.UI_UP_P)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeDesc(1);
        }

        if (controls.UI_DOWN_P)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeDesc(-1);
        }





        if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
        }
    }
}