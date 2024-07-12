function onStepHit()
    if curStep == 0 or curStep == 0 then
        setProperty('dad.flipX',not getProperty('dad.flipX'))
        setProperty('dad.flipY',not getProperty('dad.flipY'))
    end
end

function onSongStart()
    playAnim('dad', 'singUP-alt', true)
end