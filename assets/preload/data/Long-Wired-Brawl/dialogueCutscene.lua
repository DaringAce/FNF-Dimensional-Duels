local playVideo = true
local playDialogue = true

function onStartCountdown()
if (not allowCountdown and isStoryMode and not seenCutscene) then

    if playVideo then
        startVideo('CutsceneW1')
        playVideo = false
        return Function_Stop
    elseif playDialogue then
        startDialogue('dialogue')
        playDialogue = false
        return Function_Stop
    end
end
end