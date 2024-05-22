function onEndSong()
    if not allowEnd and isStoryMode then
        makeLuaSprite('black', 'black', -150, 0)
        setObjectCamera('black', 'other')
        addLuaSprite('black', true)
        screenCenter('black', 'xy')
        setProperty('black.alpha', 0)

        doTweenAlpha('blackFadeIn', 'black', 1, 2, 'linear')
        
        makeLuaSprite('cutscene', 'EndingBG', -150, 0)
        setObjectCamera('cutscene', 'other')
        addLuaSprite('cutscene', true)
        screenCenter('cutscene', 'xy')
        setProperty('cutscene.alpha', 0)
        return Function_Stop
    end
    return Function_Continue
end

function onTweenCompleted(tag)
    if tag == 'blackFadeIn' then
        doTweenAlpha('cutsceneFadeIn', 'cutscene', 1, 2, 'linear')
    elseif tag == 'cutsceneFadeIn' then
        runTimer('exit', 10)
    end
end

function onTimerCompleted(tag)
    if tag == 'exit' then
        allowEnd = true
        endSong()
    end
end