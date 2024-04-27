function onEvent(name, v1, v2) --v1 is animation name, v2 is seconds
    if name == "OP Timed Animation" then
        playAnim('dad', v1, true)
        setProperty('dad.specialAnim', true)
        setProperty('char.holdTimer',v2)
        runTimer('timerTag', v2)
        setProperty('dad.skipDance', true)

    end
end

function onTimerCompleted(tag)
  if t == 'timerTag' then
    setProperty('char.skipDance', false)
  end
end