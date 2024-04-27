package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; // This is also used for Discord RPC
	public static var daringDuelsVersion:String = '1.0'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var selectedSomethin:Bool = true;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	var optionShit:Array<String> = [
		'Story Mode',
		'Freeplay',
//		#if MODS_ALLOWED 'mods', #end
//		// #if ACHIEVEMENTS_ALLOWED 'awards', #end
		'Lore',
		'Credits',
		#if !switch 'Donate', #end
		'Options'
	];

	var magenta:FlxSprite;
	var portal:FlxSprite;
	var leftArrow:FlxText;
	var rightArrow:FlxText;
	var optionText:FlxText;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menudd'));
		bg.scrollFactor.set();
		bg.setGraphicSize(Std.int(FlxG.width), Std.int(FlxG.height));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.color = FlxColor.GRAY;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set();
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		// add(magenta);

		portal = new FlxSprite();
		portal.frames = Paths.getSparrowAtlas('portal');
		portal.animation.addByPrefix("looping", "Final");
		portal.animation.play("looping");
		portal.setGraphicSize(0, Std.int(FlxG.height * 0.8));
		portal.updateHitbox();
		portal.screenCenter();
		portal.scrollFactor.set();
		portal.antialiasing = ClientPrefs.globalAntialiasing;
		portal.alpha = 0;
		add(portal);
		FlxTween.tween(portal, {alpha: 0.75}, {
			onComplete: function(twn)
			{
				selectedSomethin = false;
				changeItem();
			}
		});

		leftArrow = new FlxText(FlxG.width * 0.1, "<");
		leftArrow.setFormat(Paths.font("vcr.ttf"), 120, FlxColor.PURPLE.getLightened(0.4), OUTLINE, FlxColor.BLACK);
		leftArrow.borderSize = 4;
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		leftArrow.screenCenter(Y);
		leftArrow.scrollFactor.set();
		add(leftArrow);

		rightArrow = new FlxText(FlxG.width * 0.9, ">");
		rightArrow.setFormat(Paths.font("vcr.ttf"), 120, FlxColor.PURPLE.getLightened(0.4), OUTLINE, FlxColor.BLACK);
		rightArrow.borderSize = 4;
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		rightArrow.screenCenter(Y);
		rightArrow.scrollFactor.set();
		rightArrow.x -= rightArrow.width;
		add(rightArrow);

		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		optionText = new FlxText(0, FlxG.height * 0.75);
		optionText.setFormat(Paths.font("VTKS DURA 3D.ttf"), 100, FlxColor.PURPLE.getLightened(0.4), OUTLINE, FlxColor.BLACK);
		optionText.scrollFactor.set();
		optionText.borderSize = 4;
		add(optionText);

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite();
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_icons');
			menuItem.animation.addByPrefix('selected', optionShit[i], 24);
			menuItem.animation.play('selected');
			menuItem.ID = i;
			menuItem.scale.set(1.5, 1.5);
			menuItem.updateHitbox();
			menuItem.centerOffsets();
			menuItem.screenCenter();
			menuItem.scrollFactor.set();
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.alpha = 0;
			menuItems.add(menuItem);
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Dimensional Duels v" + daringDuelsVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		/*
			var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
			versionShit.scrollFactor.set();
			versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			add(versionShit);
		 */
		// NG.core.calls.event.logEvent('swag').send();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
		{
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if (!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
			{ // It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement()
	{
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		portal.angle++;

		if (!selectedSomethin)
		{
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

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'Donate')
				{
					CoolUtil.browserLoad('https://www.patreon.com/DaringAce');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					FlxTween.tween(portal, {alpha: 0}, {startDelay: 0.5});
					leftArrow.visible = rightArrow.visible = false;

					if (ClientPrefs.flashing)
						FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'Story Mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'Freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'Mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'Lore':
//										MusicBeatState.switchState(new LoreState());
									case 'Awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'Credits':
										MusicBeatState.switchState(new CreditsState());
									case 'Options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		optionText.text = optionShit[curSelected].replace("_", " ");
		optionText.text = optionText.text.charAt(0).toUpperCase() + optionText.text.substr(1);
		optionText.screenCenter(X);

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

		menuItems.forEach(function(spr:FlxSprite)
		{
			FlxTween.cancelTweensOf(spr, ["angle", "alpha"]);

			if (huh < 0)
			{
				FlxTween.angle(spr, spr.ID == curSelected ? 180 : 0, spr.ID == curSelected ? -360 : -180, 0.5, {ease: FlxEase.quartOut});
			}
			else
			{
				FlxTween.angle(spr, spr.ID == curSelected ? 180 : 0, spr.ID == curSelected ? 360 : 180, 0.5, {ease: FlxEase.quartOut});

			}

			FlxTween.tween(spr, {alpha: spr.ID == curSelected ? 1 : 0}, 0.5, {ease: FlxEase.quartOut});
		});
	}
}
