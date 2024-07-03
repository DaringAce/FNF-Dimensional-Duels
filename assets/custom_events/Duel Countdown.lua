-- Made by borists and Adapted by ItzJiggzy
-- Edited by Ivaldi

local countdownSounds = {
	[3] = 'Three',
	[2] = 'Two',
	[1] = 'One',
	[0] = 'Fight'
}
local countdownSpr = {'fight', 'one', 'two', 'three'}

function onCreatePost() -- Precache Countdown
	makeLuaSprite('fakeCountdown')
	setObjectCamera('fakeCountdown', 'other')
	screenCenter('fakeCountdown', 'xy')
	setProperty('fakeCountdown.alpha', 0)
	addLuaSprite('fakeCountdown', true)
end

local sound

function onEvent(n,v1,v2)
	if n == 'Duel Countdown' then
		count = tonumber(v1)
		sound = stringSplit(tostring(v2), ", ")
		
		if count <= #countdownSpr then
			loadGraphic('fakeCountdown', countdownSpr[1 + count])
			screenCenter('fakeCountdown', 'xy')
			setProperty('fakeCountdown.alpha', 1)
			doTweenAlpha('fakeCountdown-Hide', 'fakeCountdown', 0, crochet / 1000, 'cubeInOut')
		end
		if count <= #countdownSounds and sound[1] == 'true' then playSound(countdownSounds[count], tonumber(sound[2])) end
	end
end

function onTweenCompleted(tag)
	if tag == 'fakeCountdown-Hide' then
		setProperty('fakeCountdown.alpha', 0)
	end
end