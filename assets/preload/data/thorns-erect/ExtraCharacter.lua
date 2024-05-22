--Options--
p4present = true --Just makes it appear the extra character 
isally = false --very obvious what is does

--Don't touch this plz--
cameranormal = false;

function onCreatePost()
for i = 0, getProperty('unspawnNotes.length')-1 do
if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Extra' then
setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
end
end
if p4present then
--The numbers -300 and 300 are x and y positions of your character and where it is 'pico' write the name of the json of your extra character :3
	runHaxeCode([[
		extra = new Character(-300, 300, 'pico');
		game.add(extra);
		game.variables.set('extra', extra);
	]]);
end
end

function onCountdownTick(counter)
	runHaxeCode([[
		if (]]..counter..[[ % extra.danceEveryNumBeats == 0 && extra.animation.curAnim != null && !StringTools.startsWith(extra.animation.curAnim.name, 'sing') && !extra.stunned)
		{
			extra.dance();
		}
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

function onUpdate(elapsed)
	runHaxeCode([[
		if (!game.controls.NOTE_LEFT && !game.controls.NOTE_DOWN && !game.controls.NOTE_UP && !game.controls.NOTE_RIGHT && game.startedCountdown && game.generatedMusic)
		{
			if (!extra.stunned && extra.holdTimer > Conductor.stepCrochet * 0.0011 * extra.singDuration && StringTools.startsWith(extra.animation.curAnim.name, 'sing') && !StringTools.endsWith(extra.animation.curAnim.name, 'miss'))
			{
				extra.dance();
			}
		}
	]]);
end


function onEvent(n,v1,v2)
a = stringSplit(v2, ",")
newx = a[1]
newy = a[2]
if p4present then
if n == "Change 4th Character" then
setProperty('extra.alpha',0)
runHaxeCode([[
		extra = new Character(-300, 300, "]].. v1 ..[[");
		game.add(extra);
		game.variables.set('extra', extra);
	]]);
extra1 = extra
setProperty('extra.x',newx)
setProperty('extra.y',newy)
--Don't touch this plz is a wip
elseif n == "Change Extra Character Prefix" then
setProperty('extra.idleSuffix',v1)
v1 = altanim
altshit = false
elseif n == "Set Camera to Extra" then
triggerEvent('Camera Follow Pos',getMidpointX('extra')+getProperty('extra.cameraPosition[0]'),getMidpointY('extra')+getProperty('extra.cameraPosition[1]'));
cameranormal = true
end
end
end

function noteMiss(id,dir,nt,sus)
missAnimations = {'singLEFTmiss', 'singDOWNmiss', 'singUPmiss', 'singRIGHTmiss'}
if nt == "Extra" then
setPropertyFromGroup('unspawnNotes', i, 'noMissAnimation', true)
        playAnim("extra", missAnimations[dir + 1], true)
end
end

function goodNoteHit(id, dir, nt, sus)
if isally then
if cameranormal then
if nt ~= 'Extra' then
triggerEvent('Camera Follow Pos',nil,nil);
cameranormal = false
end
end
if nt == "Extra" then
        runHaxeCode([[
            extra.playAnim(game.singAnimations[]]..dir..[[], true);
            extra.holdTimer = 0;
        ]])
end
end
end

function opponentNoteHit(id, dir, nt, sus)
if not isally then
if cameranormal then
if nt ~= 'Extra' then
triggerEvent('Camera Follow Pos',nil,nil);
cameranormal = false
end
end
if nt == "Extra" then
        runHaxeCode([[
            extra.playAnim(game.singAnimations[]]..dir..[[], true);
            extra.holdTimer = 0;
        ]])
end
end
end



