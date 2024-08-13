local shadowdadnote = false;
local oldshadowdadnote = false;
local shadowbfnote = false;
local oldshadowbfnote = false;
local shadowdadanimation = false;
local oldshadowdadanimation = false;
local shadowbfanimation = false;
local oldshadowbfanimation = false;
local shadowgfanimation = false;
local oldshadowgfanimation = false;

function opponentNoteHit(id, direction, noteType, isSustainNote)
		if dadName == "Ace" then
		createShadow()
		end
		if oldshadowdadnote == true and dadName == "Ace" then
		createShadowOldDad()
		end
end

function goodNoteHit(id, direction, noteType, isSustainNote)

end

function onUpdate()
            if shadowdadanimation == true then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
		createShadow()
            end
		if getProperty('dad.animation.curAnim.name') == 'LEFT ALT' then
			createShadow()
			end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'danceLeft' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'danceRight' then
		createShadow()
            end
            if getProperty('dad.animation.curAnim.name') == 'hey' then
		createShadow()
            end
            end
            if oldshadowdadanimation == true then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'danceLeft' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'danceRight' then
		createShadowOldDad()
            end
            if getProperty('dad.animation.curAnim.name') == 'hey' then
		createShadowOldDad()
            end
            end
            if shadowbfanimation == true then
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'danceLeft' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'danceRight' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'hey' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'hurt' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'scared' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'dodge' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'attack' then
		createShadow('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'pre-attack' then
		createShadow('bf')
            end
            end
            if oldshadowbfanimation == true then
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'danceLeft' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'danceRight' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFTmiss' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWNmiss' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUPmiss' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHTmiss' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'hey' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'hurt' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'scared' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'dodge' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'attack' then
		createShadowOldBf('bf')
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'pre-attack' then
		createShadowOldBf('bf')
            end
            end
            if shadowgfanimation == true then
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singUP' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singUP-alt' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'idle-alt' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'idle' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'danceLeft' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'danceRight' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'sad' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'hairBlow' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'hairFall' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'scared' then
		createShadow('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'cheer' then
		createShadow('gf')
            end
            end
            if oldshadowgfanimation == true then
            if getProperty('gf.animation.curAnim.name') == 'singLEFT' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singRIGHT' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singUP' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singDOWN' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singLEFT-alt' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singRIGHT-alt' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singUP-alt' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'singDOWN-alt' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'idle-alt' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'idle' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'danceLeft' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'danceRight' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'sad' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'hairBlow' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'hairFall' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'scared' then
		createShadowOldGf('gf')
            end
            if getProperty('gf.animation.curAnim.name') == 'cheer' then
		createShadowOldGf('gf')
            end
            end
        end

local shadowTag = 'shadow'
local shadowCount = 0
local shadowAlpha = 0.1
function createShadow(char, strong)
	char = getCharacter(char)
	
	if (shadowCount > 999) then shadowCount = 0 end
	local tag = shadowTag .. char .. shadowCount
	
	local props = getProperties(char, {
		image = 'imageFile',
		frame = 'animation.frameName',
		x = 'x',
		y = 'y',
		scaleX = 'scale.x',
		scaleY = 'scale.y',
		offsetX = 'offset.x',
		offsetY = 'offset.y',
		flipX = 'flipX'
	})
	
	--local Ctable = {'000000', 'FFFFFF', '696969', '626362', '9E9E9E'}
	local wackyCtable = {'b3e6b3', 'b3e6b3', 'b3e6b3', 'b3e6b3', 'b3e6b3'}
	
	makeAnimatedLuaSprite(tag, props.image, props.x, props.y)
	addAnimationByPrefix(tag, 'stuff', props.frame, 0, false)
	scaleObject(tag, props.scaleX, props.scaleY, false)
	setProperty(tag .. '.flipX', props.flipX)
	offsetObject(tag, props.offsetX, props.offsetY)
	setProperty(tag .. '.alpha', shadowAlpha)
	setBlendMode(tag, 'add')
	setProperty(tag .. '.color', getColorFromHex(wackyCtable[math.random(1, 5)]))
	
	addLuaSprite(tag, false)
	setObjectOrder(tag, getObjectOrder(char .. 'Group') - 1)
	
	if strong then
		doTweenY('YAx' .. tag, tag, props.y - 500, 1.5, 'quadOut')
		doTweenAlpha('Ang' .. tag, tag, 0, 1, 'quadIn')
		doTweenColor('COL' .. tag, tag, 'FFFFFF', 1.3, 'linear')
	else
		doTweenY('YAx' .. tag, tag, props.y - 300, 0.85, 'quadIn')
		doTweenAlpha('Ang' .. tag, tag, 0, 0.8, 'quadOut')
	end
	
	shadowCount = shadowCount + 1
end

function offsetObject(obj, x, y)
	setProperty(obj .. '.offset.x', x)
	setProperty(obj .. '.offset.y', y)
end

function getProperties(par, props)
	local t = {}
	for i, v in pairs(props) do
		local ind = type(i) == 'string' and i or v
		t[ind] = getProperty(par .. '.' .. v)
	end
	return t
end

function getCharacter(char)
	if (type(char) ~= 'string') then return 'dad' end; char = char:lower()
	if (char:sub(1, 2) == 'bf' or char:sub(1, 3) == 'boy') then return 'boyfriend'
	elseif (char:sub(1, 2) == 'gf' or char:sub(1, 4) == 'girl') then return 'gf' end
	return 'dad'
end

function onTweenCompleted(t)
	if (t:sub(4, 3 + #shadowTag) == shadowTag) then
		local spr = t:sub(4, #t)
		removeLuaSprite(spr, true)
	end
end

local shadows = 0
local alpha = 0.1
function createShadowOldDad()
	image = getProperty('dad.imageFile')
	frame = getProperty('dad.animation.frameName')
	x = getProperty('dad.x')
	y = getProperty('dad.y')
	scaleX = getProperty('dad.scale.x')
	scaleY = getProperty('dad.scale.y')
	offsetX = getProperty('dad.offset.x')
	offsetY = getProperty('dad.offset.y')
	
	shadows = shadows + 1
	makeAnimatedLuaSprite('dad'..shadows, image, x, y)
	setProperty('dad'..shadows..'.offset.x', offsetX)
	setProperty('dad'..shadows..'.offset.y', offsetY)
	setProperty('dad'..shadows..'.scale.x', scaleX)
	setProperty('dad'..shadows..'.scale.y', scaleY)
	setProperty('dad'..shadows..'.alpha', alpha)
	--setProperty('dad'..shadows..'.color', color)
	setBlendMode('dad'..shadows, 'add')
	addAnimationByPrefix('dad'..shadows, 'stuff', frame, 0, false)
	addLuaSprite('dad'..shadows, false)
	setObjectOrder('dad'..shadows, getObjectOrder('dadGroup') - 1)
	doTweenY('dad'..shadows..'y', 'dad'..shadows, getProperty('dad'..shadows..'.y') - 300, 0.85, 'quadIn')
	doTweenAlpha('dad'..shadows, 'dad'..shadows, 0, 0.8, 'quadOut')
end

function createShadowOldBf()
	image = getProperty('boyfriend.imageFile')
	frame = getProperty('boyfriend.animation.frameName')
	x = getProperty('boyfriend.x')
	y = getProperty('boyfriend.y')
	scaleX = getProperty('boyfriend.scale.x')
	scaleY = getProperty('boyfriend.scale.y')
	offsetX = getProperty('boyfriend.offset.x')
	offsetY = getProperty('boyfriend.offset.y')
	
	shadows = shadows + 1
	makeAnimatedLuaSprite('boyfriend'..shadows, image, x, y)
	setProperty('boyfriend'..shadows..'.offset.x', offsetX)
	setProperty('boyfriend'..shadows..'.offset.y', offsetY)
	setProperty('boyfriend'..shadows..'.scale.x', scaleX)
	setProperty('boyfriend'..shadows..'.scale.y', scaleY)
	setProperty('boyfriend'..shadows..'.alpha', alpha)
	--setProperty('boyfriend'..shadows..'.color', color)
	setBlendMode('boyfriend'..shadows, 'add')
	addAnimationByPrefix('boyfriend'..shadows, 'stuff', frame, 0, false)
	addLuaSprite('boyfriend'..shadows, false)
	setObjectOrder('boyfriend'..shadows, getObjectOrder('boyfriendGroup') - 1)
	doTweenY('boyfriend'..shadows..'y', 'boyfriend'..shadows, getProperty('boyfriend'..shadows..'.y') - 300, 0.85, 'quadIn')
	doTweenAlpha('boyfriend'..shadows, 'boyfriend'..shadows, 0, 0.8, 'quadOut')
end

function createShadowOldGf()
	image = getProperty('gf.imageFile')
	frame = getProperty('gf.animation.frameName')
	x = getProperty('gf.x')
	y = getProperty('gf.y')
	scaleX = getProperty('gf.scale.x')
	scaleY = getProperty('gf.scale.y')
	offsetX = getProperty('gf.offset.x')
	offsetY = getProperty('gf.offset.y')
	
	shadows = shadows + 1
	makeAnimatedLuaSprite('gf'..shadows, image, x, y)
	setProperty('gf'..shadows..'.offset.x', offsetX)
	setProperty('gf'..shadows..'.offset.y', offsetY)
	setProperty('gf'..shadows..'.scale.x', scaleX)
	setProperty('gf'..shadows..'.scale.y', scaleY)
	setProperty('gf'..shadows..'.alpha', alpha)
	--setProperty('gf'..shadows..'.color', color)
	setBlendMode('gf'..shadows, 'add')
	addAnimationByPrefix('gf'..shadows, 'stuff', frame, 0, false)
	addLuaSprite('gf'..shadows, false)
	setObjectOrder('gf'..shadows, getObjectOrder('gfGroup') - 1)
	doTweenY('gf'..shadows..'y', 'gf'..shadows, getProperty('gf'..shadows..'.y') - 300, 0.85, 'quadIn')
	doTweenAlpha('gf'..shadows, 'gf'..shadows, 0, 0.8, 'quadOut')
end

function onEvent(name, value1, value2)
	if name == 'shadowevent' and value1 == 'shadowdadnote' then
        shadowdadnote = true
	end
	if name == 'shadowevent' and value2 == 'shadowdadnote' then
        shadowdadnote = false
	end
	if name == 'shadowevent' and value1 == 'oldshadowdadnote' then
        oldshadowdadnote = true
	end
	if name == 'shadowevent' and value2 == 'oldshadowdadnote' then
        oldshadowdadnote = false
	end
	if name == 'shadowevent' and value1 == 'shadowbfnote' then
        shadowbfnote = true
	end
	if name == 'shadowevent' and value2 == 'shadowbfnote' then
        shadowbfnote = false
	end
	if name == 'shadowevent' and value1 == 'oldshadowbfnote' then
        oldshadowbfnote = true
	end
	if name == 'shadowevent' and value2 == 'oldshadowbfnote' then
        oldshadowbfnote = false
	end
	if name == 'shadowevent' and value1 == 'shadowdadanimation' then
        shadowdadanimation = true
	end
	if name == 'shadowevent' and value2 == 'shadowdadanimation' then
        shadowdadanimation = false
	end
	if name == 'shadowevent' and value1 == 'oldshadowdadanimation' then
        oldshadowdadanimation = true
	end
	if name == 'shadowevent' and value2 == 'oldshadowdadanimation' then
        oldshadowdadanimation = false
	end
	if name == 'shadowevent' and value1 == 'shadowbfanimation' then
        shadowbfanimation = true
	end
	if name == 'shadowevent' and value2 == 'shadowbfanimation' then
        shadowbfanimation = false
	end
	if name == 'shadowevent' and value1 == 'oldshadowbfanimation' then
        oldshadowbfanimation = true
	end
	if name == 'shadowevent' and value2 == 'oldshadowbfanimation' then
        oldshadowbfanimation = false
	end
	if name == 'shadowevent' and value1 == 'shadowgfanimation' then
        shadowgfanimation = true
	end
	if name == 'shadowevent' and value2 == 'shadowgfanimation' then
        shadowgfanimation = false
	end
	if name == 'shadowevent' and value1 == 'oldshadowgfanimation' then
        oldshadowgfanimation = true
	end
	if name == 'shadowevent' and value2 == 'oldshadowgfanimation' then
        oldshadowgfanimation = false
	end
end