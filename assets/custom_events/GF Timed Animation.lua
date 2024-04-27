function onEvent(name, v1, v2) --v1 is animation name, v2 is seconds
    if name == "GF Timed Animation" then
        playAnim('gf', v1, true)
        setProperty('gf.specialAnim', true)
        setProperty('char.holdTimer',v2)
        runTimer('timerTag', v2)
        setProperty('gf.skipDance', true)

    end
end

function onTimerCompleted(tag)
  if t == 'timerTag' then
    setProperty('char.skipDance', false)
  end
end