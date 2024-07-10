package; //FOR CLIENT, JUST "package;"

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverSubstate extends MusicBeatSubstate
{
	public var boyfriend:Boyfriend; 
	var camFollow:FlxPoint;
	var camFollowPos:FlxObject;
	var updateCamera:Bool = false;
	var playingDeathSound:Bool = false;

	var stageSuffix:String = "";

	public static var characterName:String = 'bf-dead';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';

	public var retryText:FlxSprite;

	public static var instance:GameOverSubstate;

	public static function resetVariables() {
		characterName = 'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
	}

	override function create()
	{
		instance = this;
		PlayState.instance.callOnLuas('onGameOverStart', []);

		super.create();
	}

	public function new(x:Float, y:Float, camX:Float, camY:Float)
	{
		super();

		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		var invalidChar:Bool = false;
		var flipTheX:Bool = false; //idk why, but psych 0.7.3 doesn't work the same...? at least for BF, it don't
		switch(PlayState.SONG.player1)
		{
			case "Ace" | "bf-AceNORMAL":
				characterName = 'bf-AceNORMAL';
				loopSoundName = 'gameoverace';
				deathSoundName = 'AceLose';
				endSoundName = 'Ace_Retry';
			case "DaringBF":
				characterName = 'DaringBF';
			case "bf":
				resetVariables();
				flipTheX = true; //FOR CLIENT, MIGHT NOT BE NEEDED! (if BF is backwards, just remove this line)
			default: //any characters that lack things; the "Just say Retry" screen
				resetVariables();
				invalidChar = true;

		}
		/* // /\ /\ simplified version of \/ \/ 
		if (PlayState.SONG.player1 == 'Ace' || PlayState.SONG.player1 == 'bf-AceNORMAL')
		{
			characterName = 'bf-AceNORMAL';
			loopSoundName = 'gameoverace';
			deathSoundName = 'AceLose';
			endSoundName = 'Ace_Retry';
		}
		if (PlayState.SONG.player1 == 'DaringBF')
		{
			characterName = 'DaringBF';
		}
		*/

		boyfriend = new Character(x, y, characterName);
		if(invalidChar)
		{
			boyfriend.visible = false;

			retryText = new FlxSprite().loadGraphic(Paths.image("gameOver/lose"));
			retryText.frames = Paths.getSparrowAtlas("gameOver/lose");
			retryText.animation.addByPrefix("idle", "lose... instance", 18, false);
			retryText.animation.play("idle", true);

			retryText.scrollFactor.set();
			retryText.scale.set(.9, .9);
			retryText.updateHitbox();
			retryText.screenCenter();
			retryText.y -= 100;
			add(retryText);
		}

		boyfriend.x += boyfriend.positionArray[0];
		boyfriend.y += boyfriend.positionArray[1];
		add(boyfriend);
		camFollow = new FlxPoint(boyfriend.getGraphicMidpoint().x, boyfriend.getGraphicMidpoint().y);

		FlxG.sound.play(Paths.sound(deathSoundName));
		Conductor.changeBPM(100); //FOR CLIENT, ADD BACK!
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		boyfriend.playAnim('firstDeath');
		if(flipTheX)
			boyfriend.flipX = !boyfriend.flipX;

		camFollowPos = new FlxObject(0, 0, 1, 1);
		camFollowPos.setPosition(FlxG.camera.scroll.x + (FlxG.camera.width / 2), FlxG.camera.scroll.y + (FlxG.camera.height / 2));
		add(camFollowPos);
	}

	var isFollowingAlready:Bool = false;
	//public var startedDeath:Bool = false; //FOR CLIENT, REMOVE!
	override function update(elapsed:Float)
	{
		super.update(elapsed);

		PlayState.instance.callOnLuas('onUpdate', [elapsed]);
		if(updateCamera) {
			var lerpVal:Float = FlxMath.bound(elapsed * 0.6, 0, 1);
			camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		}

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			WeekData.loadTheFirstEnabledMod(); //Mods.loadTopMod();
			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		if(retryText != null && retryText.animation.curAnim == null)
		{
			if(!isEnding && retryText.scale.x != .9)
			{
				var lerpedScale:Float = FlxMath.lerp(retryText.scale.x, .9, elapsed*11);
				retryText.scale.set(lerpedScale, lerpedScale);
			}
		}

		if (boyfriend.animation.curAnim != null && boyfriend.animation.curAnim.name == 'firstDeath')
		{

			if(boyfriend.animation.curAnim.curFrame >= 12 && !isFollowingAlready)
			{
				FlxG.camera.follow(camFollowPos, LOCKON, 1);
				updateCamera = true;
				isFollowingAlready = true;
			}

			if(retryText != null && retryText.animation.curAnim != null && retryText.animation.curAnim.finished && retryText.alpha == 1)
			{
				retryText.alpha = .99999; //just slightly change it. NOT enough for the player to notice, hopefully
				new FlxTimer().start(0.4, function(tmr:FlxTimer)
				{
					if(retryText.animation.curAnim != null) //only do it if the game hasn't already changed it to the "Retry" text
					{
						FlxTween.tween(retryText, {y: FlxG.height+400, alpha: 0}, .7, {ease: FlxEase.quartIn});
					}
				});
				
				
			}

			if (boyfriend.animation.curAnim.finished && !playingDeathSound)
			{
				switch(PlayState.SONG.stage)
				{
					case "tank":
						playingDeathSound = true;
						coolStartDeath(0.2);
						
						var exclude:Array<Int> = [];
						//if(!ClientPrefs.cursing) exclude = [1, 3, 8, 13, 17, 21];

						FlxG.sound.play(Paths.sound('jeffGameover/jeffGameover-' + FlxG.random.int(1, 25, exclude)), 1, false, null, true, function() {
							if(!isEnding)
							{
								FlxG.sound.music.fadeIn(0.2, 1, 4);
							}
						});

					case "AcesHouse" | "AcesHouseEvil":
						if(PlayState.SONG.player2 == 'Ace')
						{
							playingDeathSound = true;
							coolStartDeath(0.2);
							
							var exclude:Array<Int> = [];
							FlxG.sound.play(Paths.sound('aceLines/Line' + FlxG.random.int(1, 8)), 1, false, null, true, function() {
								if(!isEnding)
								{
									FlxG.sound.music.fadeIn(0.2, 1, 4);
								}
							});
						}
					default:
						playingDeathSound = true; //does this fix it...?
						coolStartDeath();
				}
				boyfriend.startedDeath = true;
				//startedDeath = true;//FOR CLIENT, REMOVE!
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('onUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();

		if(retryText != null && (curBeat % 2 ==0))
		{
			retryText.scale.set(1, 1);
		}

		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
		boyfriend.playAnim('deathLoop');
		if(retryText != null)
		{
			retryText.animation.destroyAnimations();
			retryText.alpha = 0;
			retryText.loadGraphic(Paths.image("gameOver/restart"));
			retryText.screenCenter(X);
			retryText.y = FlxG.height+100;
			FlxTween.tween(retryText, {y: (FlxG.height/2)-(retryText.height/2), alpha: 1}, 1.1, {ease: FlxEase.elasticOut});
		}
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			boyfriend.playAnim('deathConfirm', true);
			if(retryText != null)
			{
				FlxTween.cancelTweensOf(retryText);
				retryText.animation.destroyAnimations();
				retryText.loadGraphic(Paths.image("gameOver/restart"));
				retryText.screenCenter();
				retryText.scale.set(1.2, 1.2);
				FlxTween.tween(retryText.scale, {x:0, y:0}, 2, {ease: FlxEase.quartIn});
			}
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
