local allowCountdown = false

-- Thanks to bbpanzu for the original script

function onCreate()
	if (isStoryMode) then --
		runTimer('startDialogue', 0.2);
	end
end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if (not allowCountdown and isStoryMode and not seenCutscene) then --
		setProperty('inCutscene', true);
		allowCountdown = true;
		seenCutscene = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue')
	end
end