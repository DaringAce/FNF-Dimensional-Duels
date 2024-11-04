charsTable = {}
luaDebugMode = true
function onCreate()
	--example lol
	createChar('extra','Luna Happy',-35,100,false,'dadGroup',1)
end
	
function createChar(tag,name,xpos,ypos,flip,order,prior)
	runHaxeCode([[
		var ]]..tag..[[ = new Character(]].. xpos ..[[,]].. ypos ..[[,"]].. name ..[[");
		game.add(]]..tag..[[);
		setVar(']]..tag..[[',]]..tag..[[);
	]])
	table.insert(charsTable,tag)
	setObjectOrder(tag,getObjectOrder(order)+ prior )
	setProperty(tag..'.flipX',flip)
end

function onCountdownTick(counter)
	for _,v in pairs(charsTable) do
		runHaxeCode([[
				if (]]..counter..[[ % getVar("]]..v..[[").danceEveryNumBeats == 0 && getVar("]]..v..[[").animation.curAnim != null && !StringTools.startsWith(getVar("]]..v..[[").animation.curAnim.name, 'sing') && !getVar("]]..v..[[").stunned)
			{
				getVar("]]..v..[[").dance();
			}
		]]);
	end
end


--function onUpdate(elapsed)
  --   for _,v in pairs(charsTable) do
	--runHaxeCode([[
	--	if (!game.controls.NOTE_LEFT && !game.controls.NOTE_DOWN && !game.controls.NOTE_UP && !game.controls.NOTE_RIGHT && game.startedCountdown && game.generatedMusic)
	--	{
	--		if (!getVar("]]..v..[[").stunned && getVar("]]..v..[[").holdTimer > Conductor.stepCrochet * 0.0011 * getVar("]]..v..[[").singDuration && StringTools.startsWith(getVar("]]..v..[[").animation.curAnim.name, 'sing') && !StringTools.endsWith(getVar("]]..v..[[").animation.curAnim.name, 'miss'))
	--		{
	--			getVar("]]..v..[[").dance();
	--		}
	--	}
--	]]);
--end

function onBeatHit()
	for _,v in pairs(charsTable) do
		runHaxeCode([[
			if (]]..curBeat..[[ % getVar("]]..v..[[").danceEveryNumBeats == 0 && getVar("]]..v..[[").animation.curAnim != null && !StringTools.startsWith(getVar("]]..v..[[").animation.curAnim.name, 'sing') && !getVar("]]..v..[[").stunned)
			{
				getVar("]]..v..[[").dance();
			}
		]]);
	end
end

function onEvent(n,v1,v2)
	if n == "Change Extra Character" then
		charOpts = stringSplit(v2, ",")
		runHaxeCode([[
			if (!game.variables.exists("]]..v1..[[")) {
				return;
			}
			getVar("]]..v1..[[").kill();
			game.variables.remove(getVar("]]..v1..[["));
			variables.remove(getVar("]]..v1..[["));
			getVar("]]..v1..[[").destroy();
		]])
		createChar(v1,charOpts[1],charOpts[2],charOpts[3],charOpts[4],charOpts[5],tonumber(charOpts[6]))
	elseif n == 'Play Animation Secondary Character' then
		runHaxeCode([[
			getVar("]]..v1..[[").playAnim('getVar("]]..v2..[[")',true);
			getVar("]]..v1..[[").specialAnim = true;
		]])
	end
end

function goodNoteHit(i, d, t, s)
    noteHitOrMiss(i, d, t, s, false)
end

function opponentNoteHit(i, d, t, s)
    noteHitOrMiss(i, d, t, s, false)
end

function noteMiss(i, d, t, s)
    noteHitOrMiss(i, d, t, s, true)
end

function noteHitOrMiss(i, d, t, s, m)
	 animName = 'game.singAnimations['.. d ..']'
    if t == 'No Animation' or t == 'altdad' or t == 'Player and Extra Char' then
	if m then
	   animName = anim..'+ "miss"'
	end
        runHaxeCode([[
            getVar("extra").playAnim(]] .. animName .. [[, true);
            getVar("extra").holdTimer = 0;
        ]])
    elseif t == 'Guitar' then
        runHaxeCode([[
            getVar("guitar").playAnim(]] .. animName .. [[ + '-alt', true);
            getVar("guitar").holdTimer = 0;
     r   ]])	
    end
end




