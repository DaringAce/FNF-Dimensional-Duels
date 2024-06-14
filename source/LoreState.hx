//package states;
//If I'm dumb and forgot this, just remove / comment out the line above this comment.

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.text.FlxBitmapText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import sys.io.File;
import haxe.Json;

import flixel.math.FlxRect; //for "cutting" the description text
import flixel.ui.FlxBar;


using StringTools;

typedef LoreData =
{
    char:String, //character in... Characters, and the file path in Backgrounds
    desc:Array<String>
}

class LoreState extends MusicBeatState
{
    var json:Array<LoreData> = Json.parse(File.getContent('assets/images/lorechars/Characters.json'));
    //if this /\ doesn't work anymore, remove "preload/"
    var categories:Array<String> = ["Characters", "Backgrounds"];
    //var catLengths:Array<Int> = [];
    //var catLengths:Map<String, Int> = [];
    var categoryFunction:Void->Void = null;
    
    var curCategory:Int = 0; //starts on characters
    var curSelected:Int = 0;
    var curDescScroll:Int = 0; //how many lines to scoot it down
    var descTotalLines:Int = 0; //total number of lines: Desc Box only displays 11 lines at a time.
    var descStartHeight:Float = 0;
    //var curSelectedDesc:Int = 0;

    var bg:FlxSprite;
    var charSpace:FlxSprite;
    var charName:FlxText;
    var char:FlxSprite;
    var backgroundParts:FlxTypedGroup<FlxSprite>;
    var descSpace:FlxSprite;
    var desc:FlxText;
    var counterSpace:FlxSprite;
    var counter:FlxText;
    var leftArrow:FlxText;
    var rightArrow:FlxText;
    
    var bgTooltip:FlxText;
    var upArrow:FlxText;
    var downArrow:FlxText;
    var leftCatText:FlxText;
    var rightCatText:FlxText;
    var descProgBg:FlxSprite;
    var descProgSlider:FlxSprite;
    var scrollTimer:Float = 0; //.8 seconds, essentially

    var uiSprites:FlxTypedGroup<FlxSprite>;
    

    override function create()
    {
        super.create();

        //catLengths.set("Characters" ,json.length); //in case you ever change the number of characters, this will always be accurate
        categoryFunction = changeCharacter;

        bg = new FlxSprite().loadGraphic(Paths.image('menudd', "preload")); //REMINDER
        bg.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
        bg.updateHitbox();
        bg.screenCenter();
        bg.antialiasing = ClientPrefs.globalAntialiasing; //REPLACE BEFORE GIVING CLIENT; = ClientPrefs.globalAntialiasing
        add(bg);
        
        backgroundParts = new FlxTypedGroup<FlxSprite>();
        add(backgroundParts);
        backgroundParts.visible = false;

        uiSprites = new FlxTypedGroup<FlxSprite>();
        add(uiSprites);

        charSpace = new FlxSprite(FlxG.width * 0.05, FlxG.height * 0.1).makeGraphic(Std.int(FlxG.width * 0.3), Std.int(FlxG.height * 0.6), FlxColor.BLACK);
        charSpace.alpha = 0.7;
        charSpace.antialiasing = false;
        //add(charSpace);
        uiSprites.add(charSpace);

        char = new FlxSprite(charSpace.x + (charSpace.width * 0.05),
            charSpace.y + (charSpace.width * 0.05));
        //add(char);
        uiSprites.add(char);
        
        charName = new FlxText(charSpace.x + (charSpace.width * 0.065), charSpace.y + charSpace.height, charSpace.width * 0.8, "Test");
        charName.setFormat(Paths.font("vcr.ttf"), 40, CENTER);
        charName.antialiasing = false;
        charName.y -= charName.height + 10;
        //add(charName);
        uiSprites.add(charName);
        
        descSpace = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.1).makeGraphic(Std.int(FlxG.width * 0.55), Std.int(charSpace.height), FlxColor.BLACK);
        descSpace.alpha = 0.7;
        descSpace.antialiasing = false;
        //add(descSpace);
        uiSprites.add(descSpace);
        
        desc = new FlxText(descSpace.x + (descSpace.width * 0.05), descSpace.y + (descSpace.height * 0.05)); // Changed to TextArea
        descStartHeight = desc.y;
        desc.setFormat(Paths.font("vcr.ttf"), 30, LEFT);
        desc.fieldWidth = descSpace.width * 0.9;
        desc.antialiasing = false;
        desc.clipRect = new FlxRect(0, 0, descSpace.width, descSpace.height*.9);
        desc.clipRect = desc.clipRect;
        //add(desc);
        uiSprites.add(desc);
        
        counterSpace = new FlxSprite(0, 546).makeGraphic(Std.int(FlxG.width * 0.7), 234, FlxColor.BLACK);
        counterSpace.screenCenter(X);
        counterSpace.alpha = 0.7;
        counterSpace.antialiasing = false;
        //add(counterSpace);
        uiSprites.add(counterSpace);
        
        counter = new FlxText(counterSpace.x + (counterSpace.width * 0.05), 584, counterSpace.width * 0.9);
        counter.setFormat(Paths.font("vcr.ttf"), 60, CENTER, OUTLINE, FlxColor.BLACK);
        counter.borderSize = 2;
        counter.antialiasing = false;
        //add(counter);
        uiSprites.add(counter);
        
        bgTooltip = new FlxText(0, FlxG.height);
        bgTooltip.setFormat(Paths.font("vcr.ttf"), 20, CENTER, OUTLINE, FlxColor.BLACK);
        bgTooltip.borderSize = 2;
        bgTooltip.text = "Press SPACE to toggle UI visibility";
        bgTooltip.updateHitbox();
        bgTooltip.screenCenter(X);
        bgTooltip.y -= bgTooltip.height + 2;
        bgTooltip.antialiasing = bgTooltip.visible = false;
        add(bgTooltip);

        leftArrow = new FlxText(229, "<");
        leftArrow.setFormat(Paths.font("vcr.ttf"), 120, OUTLINE, FlxColor.BLACK);
        leftArrow.borderSize = 4;
        leftArrow.antialiasing = false;
        leftArrow.y = counter.y - 26.5;//counterSpace.y + (counterSpace.height / 2) - (leftArrow.height / 2);
        leftArrow.updateHitbox(); //this is a surprise tool, that will help us later
        //add(leftArrow);
        uiSprites.add(leftArrow);
        

        rightArrow = new FlxText(977, ">");
        rightArrow.setFormat(Paths.font("vcr.ttf"), 120, OUTLINE, FlxColor.BLACK);
        rightArrow.borderSize = 4;
        rightArrow.antialiasing = false;
        rightArrow.y = leftArrow.y;
        //add(rightArrow);
        uiSprites.add(rightArrow);
        

        leftCatText = new FlxText(counterSpace.x + 3, 0); 
        leftCatText.setFormat(Paths.font("vcr.ttf"), 35, OUTLINE, FlxColor.BLACK);
        leftCatText.borderSize = 2;
        leftCatText.antialiasing = false;
        leftCatText.visible = false;
        leftCatText.y = leftArrow.y+leftArrow.height + 2;//the "later" in question: The y-coordinate
        //add(leftCatText);
        uiSprites.add(leftCatText);
        

        rightCatText = new FlxText(counterSpace.x + counterSpace.width-3, leftCatText.y);
        rightCatText.setFormat(Paths.font("vcr.ttf"), 35, RIGHT, OUTLINE, FlxColor.BLACK);
        rightCatText.borderSize = 2;
        rightCatText.antialiasing = false;
        rightCatText.visible = false;
        //add(rightCatText);
        uiSprites.add(rightCatText);
        

        leftCatText.text = "LEFTCAT";
        rightCatText.text = "RIGHTCAT";

        /*descProgBar = new FlxBar(527, 83, TOP_TO_BOTTOM, 10, 410);
        descProgBar.createFilledBar(0xFF3F3F3F, 0xFFBEBEBE);
        add(descProgBar);*/

        descProgBg = new FlxSprite(527, 83).makeGraphic(10, 410, 0xFF3F3F3F);
        uiSprites.add(descProgBg);
        

        descProgSlider = new FlxSprite(descProgBg.x, 83).makeGraphic(10, 1, 0xFFBEBEBE);
        uiSprites.add(descProgSlider);
        

        //desc arrows
        upArrow = new FlxText();
        upArrow.text = "<";
        upArrow.setFormat(Paths.font("vcr.ttf"), 35, OUTLINE, FlxColor.BLACK);
        upArrow.angle = 90;
        upArrow.borderSize = 3;
        upArrow.antialiasing = false;
        upArrow.x = 519;
        upArrow.y = 68;
        //add(upArrow);
        uiSprites.add(upArrow);
        

        downArrow = new FlxText();
        downArrow.text = ">";
        downArrow.setFormat(Paths.font("vcr.ttf"), 35, OUTLINE, FlxColor.BLACK);
        downArrow.angle = 90;
        downArrow.borderSize = 3;
        downArrow.antialiasing = false;
        downArrow.y = counterSpace.y + (counterSpace.height / 2) - (rightArrow.height / 2);
        downArrow.x = 519;
        downArrow.y = 474;
        //add(downArrow);
        uiSprites.add(downArrow);

        descTotalLines = Std.int(Math.max(Std.int(desc.height/30)-13, 0)); //30 is the font size, which I have to assume is also *line* height.
        changeItem();
        changeDesc(0);
    }

    function changeCharacter()
    {
        var oldChar = char.graphic;

        /*char.animation.stop();
        char.animation.destroy();*/

        //char.loadGraphic(Paths.image('lorechars/${charName.text}', "preload")); //include [], "preload"] for client
        
        char.frames = Paths.getSparrowAtlas('lorechars/${charName.text}', "preload"); //REMINDER
        char.animation.addByPrefix("anim", "Hey0", 24, false); 
        char.animation.play("anim");

        //Flare- was here when I got here, but I altered slightly to function properly
        if (char.graphic == oldChar)
            return;
        else
        {
            char.scale.set(1, 1); //change eventually
            char.updateHitbox();
        }

        do
        {
            char.scale.add(-0.05, -0.05);
            char.updateHitbox();
        }
        while (char.width >= charName.width || char.height >= charSpace.height * 0.8);

        char.scale.add(.05, .05);
        char.updateHitbox();

        char.x = charSpace.getMidpoint().x - (char.width / 2) + 30;
        char.y = charSpace.getMidpoint().y - (char.height / 2);
    }

    function changeBackground()
    {
        backgroundParts.forEach(function(spr:FlxSprite){
            spr.kill();
            backgroundParts.remove(spr);
            spr.destroy();
        });

        //var bgName:String = 
        switch(Std.string(json[curSelected].char)) //USE THIS TO SET YOUR STAGES UP!
        {                                           //Replace these examples, and also add a new case for every new stage after
            case "Ace's House":
                var bg:FlxSprite = new FlxSprite(150, 90).loadGraphic(Paths.image("AcesHouse", "Duel1"));
                bg.frames = Paths.getSparrowAtlas("AcesHouse", "Duel1");
                bg.scale.set(1.55, 1.5); 
                bg.animation.addByPrefix("idle", "HouseNORMAL");
                bg.animation.play("idle", true);
                bg.antialiasing = ClientPrefs.globalAntialiasing;
                backgroundParts.add(bg);

            case "City Cliff":
                var bg:FlxSprite = new FlxSprite(-350, -200).loadGraphic(Paths.image("CliffBG", "shared"));
                bg.frames = Paths.getSparrowAtlas("CliffBG", "shared");
                bg.scale.set(0.7, 0.7); 
                bg.animation.addByPrefix("idle", "Background");
                bg.animation.play("idle", true);
                bg.antialiasing = ClientPrefs.globalAntialiasing;
                backgroundParts.add(bg);
        }
    }

    //if you add more categories, add their functions here. like "changeMusic()"
    function changeCategorySETUP(left:Bool)
    {
        switch(categories[curCategory]) //handle "removing" the current category
        {
            case "Characters":
                char.visible = char.active = false; //sets both at once

            case "Backgrounds":
            backgroundParts.forEach(function(spr:FlxSprite){
                spr.kill();
                backgroundParts.remove(spr);
                spr.destroy();
            });
            backgroundParts.visible = false;
        }

        if(left) //END of previous category
        {
            curCategory = categories.indexOf(leftCatText.text);
            json = Json.parse(File.getContent('assets/images/lorechars/${categories[curCategory]}.json'));
            curSelected = json.length-1;
        }
        else //START of next category
        {
            curCategory = categories.indexOf(rightCatText.text);
            json = Json.parse(File.getContent('assets/images/lorechars/${categories[curCategory]}.json'));
            curSelected = 0;
        }
    }

    function changeCategoryPOST()
    {
        switch(categories[curCategory]) //update category elements
        {
            case "Characters":
                uiSprites.visible = true;
                bgTooltip.visible = false;
                categoryFunction = changeCharacter;
                char.visible = char.active = true;
                charSpace.setPosition(FlxG.width * 0.05, FlxG.height * 0.1);
                charName.setPosition(charSpace.x + (charSpace.width * 0.065), charSpace.y + charSpace.height);

                descSpace.x = FlxG.width * 0.4;

            case "Backgrounds":
                bgTooltip.visible = backgroundParts.visible = true;
                categoryFunction = changeBackground;

                charSpace.screenCenter(X);
                charSpace.y = -360;
                charName.x = charSpace.getMidpoint().x - (charName.width/2);
                descSpace.screenCenter(X);
        }

        desc.x = descSpace.x + 35.2;
        
        descProgBg.setPosition(descSpace.x+15, descSpace.y+11);
        descProgSlider.setPosition(descProgBg.x, descProgBg.y);
        upArrow.setPosition(descSpace.x+7, descSpace.y-4);
        downArrow.setPosition(upArrow.x, descSpace.y+402);
    }

    function changeItem(huh:Int = 0)
    {
        var changeCat:Bool = false;
        curSelected += huh;
        curDescScroll = 0;

        //move down, when categories are added
        if (curSelected >= json.length) //curSelected = 0;
        {
            changeCategorySETUP(false); //go right
            changeCat = true;
        }   
            
        if (curSelected < 0) //curSelected = json.length - 1;
        {
            changeCategorySETUP(true); //go right
            changeCat = true;
        } 

        if (json.length == 0)
            return;

        //desc.height = descSpace.height * 0.9;
        var descArray:Array<String> = json[curSelected].desc;
        desc.text = ""; //reset the text
        if(descArray != null && descArray.length > 0) //always null for some reason?
        {
            for(section in descArray)
            {
                desc.text += section + "\n\n"; //skip 2 lines, to "segment" the description.
            }
            
        }
        desc.updateHitbox();
        desc.y = descSpace.y + (descSpace.height * 0.05);

        descTotalLines = Std.int(Math.max(Std.int(desc.height/30)-13, 0)); //30 is the font size, which I have to assume is also *line* height.

        if(changeCat)
            changeCategoryPOST();

        charName.text = json[curSelected].char;
        /*charName.text = charName.text.replace("_", " ");
        charName.text = charName.text.charAt(0).toUpperCase() + charName.text.substr(1);*/
        charName.updateHitbox();
        charName.y = (charSpace.y + charSpace.height - charName.height);

        counter.text = '${categories[curCategory]}: ${curSelected+1}/${json.length}';
        counter.updateHitbox();

        leftCatText.visible = (curSelected==0); //if you're on the very left option, show the LEFT category
        rightCatText.visible = (curSelected == json.length-1);

        if(leftCatText.visible)
        {
            if(curCategory == 0)
                leftCatText.text = categories[categories.length-1];
            else
                leftCatText.text = categories[curCategory-1];
        }
        if(rightCatText.visible)
        {
            rightCatText.text = categories[(curCategory+1)%categories.length];
            rightCatText.updateHitbox();
            rightCatText.x = (counterSpace.x + counterSpace.width-3 - rightCatText.width);
            //rightCatText.x = ;
        }

        descProgSlider.scale.set(1, (descProgBg.height/descTotalLines));
        descProgSlider.updateHitbox();
        categoryFunction(); //changeCharacter, changeBackground, ect.

        if (huh != 0)
        {
            if (huh < 0)
            {
                leftArrow.x = 192;
                FlxTween.cancelTweensOf(leftArrow, ["x"]);
                FlxTween.tween(leftArrow, {x: 229}, 0.5, {ease: FlxEase.quadOut});
            }
            else
            {
                rightArrow.x = 1014;
                FlxTween.cancelTweensOf(rightArrow, ["x"]);
                FlxTween.tween(rightArrow, {x: 977}, 0.5, {ease: FlxEase.quadOut});
            }
        }
        changeDesc(0, false);
    }


    function changeDesc(huh:Int = 0, ?sound:Bool = true) //issue is here
    {
        curDescScroll = Std.int(FlxMath.bound(curDescScroll+huh, 0, descTotalLines));

        if(sound)
            FlxG.sound.play(Paths.sound('scrollMenu')); 
        desc.y = descStartHeight - (desc.size * curDescScroll);
        desc.clipRect.y = (desc.size * curDescScroll);
        desc.clipRect = desc.clipRect;

        if(descTotalLines != 0)
        {
            descProgBg.visible = descProgSlider.visible = true;
            upArrow.visible = (curDescScroll != 0);
            downArrow.visible = (curDescScroll != descTotalLines);
        }
        else
        {
            descProgBg.visible = descProgSlider.visible = upArrow.visible = downArrow.visible = false;
        }

        //descProgBar.percent = (curDescScroll/descTotalLines)*100s;
        if(descTotalLines != 0) 
            descProgSlider.y = (descProgBg.y + curDescScroll*(descProgBg.height/(descTotalLines+1))); //+1 because otherwise, the "bottom" would actually cause the bar to scroll out of the box.

        trace('DescScroll = ${curDescScroll}/${descTotalLines}');
    }




    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if((categories[curCategory] != "Characters") && FlxG.keys.justPressed.SPACE)
        {
            //swap ALL of them at once, by using the oppposite of one of them only
            uiSprites.visible = !uiSprites.visible; 
            bgTooltip.alpha = (uiSprites.visible ? 1 : .15); //if the UI is visible, tooltip is fully opaque. otherwise, barely visible (Just so the player can't forget)
        }

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

        // changeDesc basically moves the description provided so for each char it would have different descriptions (NOT Flare)

        if(controls.UI_UP || controls.UI_DOWN)
        {
            if(scrollTimer <= 0)
            {
                trace('($curDescScroll/${descTotalLines})--- ${controls.UI_UP}, ${curDescScroll!=0} || ${controls.UI_DOWN}, ${curDescScroll!=(descTotalLines)}');
                if(controls.UI_UP && (curDescScroll!=0)) 
                    changeDesc(-1);
                else if(controls.UI_DOWN && (curDescScroll!=(descTotalLines))) //UI_DOWN 
                    changeDesc(1);

                //FlxG.sound.play(Paths.sound('scrollMenu'));
                if(controls.UI_UP_P || controls.UI_DOWN_P)
                    scrollTimer = .3;
                else
                    scrollTimer = .12; // 1/4th of a second, between each scroll, if you hold the key down
                
            }
            else
                scrollTimer -= elapsed; //subtract time passed since last update
        }
        else 
        {
            scrollTimer = 0;
        }

        /*
        if (controls.UI_UP_P && curDescScroll != 0)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeDesc(-1);
        }

        if (controls.UI_DOWN_P && curDescScroll != descTotalLines)
        {
            FlxG.sound.play(Paths.sound('scrollMenu'));
            changeDesc(1);
        }
        */




        if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
        }
    }
}