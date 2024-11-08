package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('BGYellow'));
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}

		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color

			//	<-------------------DIMENSIONAL DUELS------------------->

			['Main Dev Team'],
			['Daring Ace',		'150a',				'Director\nThe lore himself\nComposer\nAnd more',								'https://www.youtube.com/channel/UC2bhBg8pgJCXoLtPXTKh5bA',		'9edf62'], //Ace's green color
			['Ivaldi',		'Ivaldi',				'Co-Director\nCoder\nCompiler\nArtist\nAnd more',								'https://www.roblox.com/users/147080606/profile',		'000000'], //Ivaldi's black color
			['Z11Gaming',			'150z',				'Psych Port Helper and Composer',								'https://www.youtube.com/@Z11Music/videos',				'8556b1'], //Z's purple color
			['BigNinjaKai',			'150k',				'Charter and Supporter',									'https://twitter.com/bigninjakai',					'ab5cd2'], //Kai's purple color
			['R0cketta',			'150r',				'Chromatic Scale Creator',									'https://www.youtube.com/channel/UC8l4zLUs5Kf5RdLYsbm5Ykg',		'99008d'], //R0cketta's purple color
			['TrueMori',			'TrueMori',				'Charter',									'https://www.youtube.com/channel/UCgudcI4nYEQ--Jnm0aOoNpA',		'2a6c58'], //TrueMori's green color
			[''],

			['Contributors'],
			['JDST',			'150j',				'Artist and Animator',										'https://twitter.com/JDSTtwt',						'1de599'], 	//JDST's green color
			['fadeaway_yt',			'paid',				'Commissioned Musician',									'https://www.youtube.com/@FaDeAWAYut',					'adf3d9'], 	//paid icon green color
			['Biscuit.',			'Biscuit',			'Commissioned Artist',										'',									'442c2c'], 	//Biscuit's  brown color	
			['monedic',			'monedic',			'Commissioned Animator',									'https://twitter.com/OfficialKidemon',					'f52342'],	//monedic's red color				
			['spikey',			'spike',			'Commissioned Artist and Animator',								'https://twitter.com/FunkinTraveller',					'33f899'],	//spikey's green color				
			['Deadwin151',			'Deadwin151',			'Commissioned Thumbnail Artist',								'https://twitter.com/@DeadwinO',					'8c8c8c'],	//Deadwins's grey color		
			['Its_joaquin',			'jo',				'Commissioned Artist and Animator',								'https://twitter.com/Its_Joaquinxd',					'30364f'],	//Jo's blue color				
			['Lap^z',			'Laps',				'Commissioned Composer',								'https://www.youtube.com/@lap_z',					'eae386'],	//Lapz's yellow color				
			['Ranfring',			'Ranfring',				'Commissioned Artist and Animator',								'https://twitter.com/Ranfringg',					'd39765'],	//Ranfring's tan color				
			['TetraHunter',			'TetraHunter',				'Commissioned Charter',								'https://twitter.com/TetraHunter503D',					'883cc2'],		//Tetra's purple color
			['GelePanda',			'GelePanda',				'Commissioned Composer',								'https://www.youtube.com/@GelePanda',					'500286'],		//Gele's purple color
			['Drawpant',			'unknown',				'Commissioned Composer',								'',					'C6C6C6'],		//unknown icon grey color
			['Fende',			'unknown',				'Commissioned Artist and Animator',								'',					'C6C6C6'],		//unknown icon grey color
			[''],

			['Used Assets'],
			['spectradev',			'unknown',				'Healthbar Script Creator',										'',						'C6C6C6'], 	//unknown icon grey color
			['omotashi and others',	'unknown',				'Song Credits Script Creators',										'',						'C6C6C6'], 	//unknown icon grey color
			['Gostar64 and others',	'unknown',				'Scoring System Script Creators',										'',						'C6C6C6'], 	//unknown icon grey color
			['CJRed#6258 and Kaite#1102',	'unknown',				'Trail Script Creators',										'',						'C6C6C6'], 	//unknown icon grey color
			['Held',	'unknown',				'Duet Cam Event Creator',										'',						'C6C6C6'], 	//unknown icon grey color
			['borists and ItzJiggzy',	'unknown',				'Countdown Event Creators',										'',						'C6C6C6'], 	//unknown icon grey color
			['FNF WEEKLY',	'weekly',				'FPS Counter Creator',										'https://gamebanana.com/mods/522709',						'de5e54'], 	//FNF WEEKLY red icon grey color
			['chibisprinklez and RixFX',	'unknown',				'GF Reskin V2',										'https://gamebanana.com/mods/490808',						'C6C6C6'], 	//unknown icon grey color
			[''],

			['Special Thanks'],
			['Greg Chun',			'Greg_Chun',			'Original Voice Actor For The Clips of Ace',							'https://twitter.com/gregchunva?lang=en',	'42d6a9'], 	//Greg Chun's green color
			['sgt jellyfish',			'sgtjellyfish',			'Content Creator Showcases',							'https://www.youtube.com/channel/UCnNN7wzaoeF0posLKBnf4qA',	'f10d04'], 	//sgt jellyfish's red color
			['Death X-Gaming',			'gamer',			'Content Creator Showcases',							'https://www.youtube.com/c/deathxgaming',	'000000'], 	//Death's black color
			['Hank Sensei',			'Rowan',			'Stole my dryer bro :moyai:',							'https://www.youtube.com/channel/UCDCC2SWYC7zorsT5WC0q2lA',		'fe2529'], 	//Hank's red color		

			[''],


			//	<-------------------PSYCH ENGINE------------------->

			['Psych Engine Team'],
			['Shadow Mario',		'shadowmario',			'Main Programmer of Psych Engine\nAnd Lua Scripter',								'https://twitter.com/Shadow_Mario_',					'444444'],
			['RiverOaken',			'river',			'Main Artist/Animator of Psych Engine',								'https://twitter.com/RiverOaken',					'B42F71'],
			['shubs',			'shubs',			'Additional Programmer of Psych Engine',							'https://twitter.com/yoshubs',						'5E99DF'],
			[''],
			
			['Former Engine Members'],
			['bb-panzu',			'bb',				'Ex-Programmer of Psych Engine',								'https://twitter.com/bbsub3',						'3E813A'],
			[''],
			
			['Engine Contributors'],
			['iFlicky',			'flicky',			'Composer of Psync and Tea Time\nMade the Dialogue Sounds',					'https://twitter.com/flicky_i',						'9E29CF'],
			['SqirraRNG',			'sqirra',			'Crash Handler and Base code for\nChart Editor\'s Waveform',					'https://twitter.com/gedehari',						'E1843A'],
			['EliteMasterEric',		'mastereric',			'Runtime Shaders support',									'https://twitter.com/EliteMasterEric',					'FFBD40'],
			['PolybiusProxy',		'proxy',			'.MP4 Video Loader Library (hxCodec)',								'https://twitter.com/polybiusproxy',					'DCD294'],
			['KadeDev',			'kade',				'Fixed some cool stuff on Chart Editor\nand other PRs',						'https://twitter.com/kade0912',						'64A250'],
			['Keoiki',			'keoiki',			'Note Splash Animations',									'https://twitter.com/Keoiki_',						'D2D2D2'],
			['Nebula the Zorua',		'nebula',			'LUA JIT Fork and some Lua reworks',								'https://twitter.com/Nebula_Zorua',					'7D40B2'],
			['Smokey',			'smokey',			'Sprite Atlas Support',										'https://twitter.com/Smokey_5_',					'483D92'],
			[''],
			
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',		"Programmer of Friday Night Funkin'",								'https://twitter.com/ninja_muffin99',					'CF2D2D'],
			['PhantomArcade',		'phantomarcade',		"Animator of Friday Night Funkin'",								'https://twitter.com/PhantomArcade3K',					'FADC45'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",								'https://twitter.com/evilsk8r',						'5ABD4B'],
			['kawaisprite',			'kawaisprite',			"Composer of Friday Night Funkin'",								'https://twitter.com/kawaisprite',					'378FC7']
		];
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{

			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(FlxG.width / 2, 300, creditsStuff[i][0], !isSelectable);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.changeX = false;
			optionText.snapToPosition();
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
			else optionText.alignment = CENTERED;
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("OBELIX PRO BROKEN.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(controls.ACCEPT && (creditsStuff[curSelected][3] == null || creditsStuff[curSelected][3].length > 4)) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.bold)
			{
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 12, 0, 1);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(lastX, item.x - 70, lerpVal);
				}
				else
				{
					item.x = FlxMath.lerp(item.x, 200 + -40 * Math.abs(item.targetY), lerpVal);
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
