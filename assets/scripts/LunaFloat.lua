t = 0
fly = true
function onCreate()
    ogposx = getProperty('dadGroup.x')
    ogposy = getProperty('dadGroup.y')
end

function onUpdatePost(e)
    if fly and dadName == 'LunaHungry' then
        t = t + e
        doTweenX("flyx", 'dadGroup',getProperty("dadGroup.x") + math.sin(t)*1,0.002)
        doTweenY("flyy", 'dadGroup',getProperty("dadGroup.y") + math.sin(t*2)*2,0.000485)     
    end

    if getProperty('dad.animation.curAnim.name') == 'Bite' then
        stop()
    else
        fly = true
    end
end

function stop()
      fly = not fly
      setProperty('dadGroup.x',ogposx)
      setProperty('dadGroup.y',ogposy)
end