local showing = false

function onCreate()
  runHaxeCode([[
		extra = new Character(100, 100, 'LunaFP');
		game.variables.set('extra', extra);
    game.addBehindDad(extra);
    extra.alpha = 0;
	]]);
end

function onBeatHit()
	runHaxeCode([[
		if (]]..curBeat..[[ % extra.danceEveryNumBeats == 0 && extra.animation.curAnim != null && !StringTools.startsWith(extra.animation.curAnim.name, 'sing') && !extra.stunned)
		{
			extra.dance();
		}
	]]);
end

function onEvent(n, v1,v2)
  if n == 'lunaShit' then
    if showing == false then
      setProperty('gf.visible', false)
      runHaxeCode([[
        extra.alpha = 1;
      ]]);
      showing = true
    else
      setProperty('gf.visible', true)
      runHaxeCode([[
        extra.alpha = 0;
      ]]);
    end
  end
end