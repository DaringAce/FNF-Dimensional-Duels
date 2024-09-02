function onCreate()
  makeAnimatedLuaSprite('misty', 'misty', -750, -750)
  addAnimationByPrefix('misty', 'idle', 'neblina instancia 1', 24, true)
  scaleObject('misty', 13, 13)
  setProperty('misty.alpha', 0)
  addLuaSprite('misty', true)
end

onEvent = function(n,v1,v2)
  if n == 'Change Character' and v2 == 'AceFP' then
    for i = 0, getProperty('opponentStrums.length') - 1 do
      setProperty('opponentStrums.members[' .. i .. '].x', -1000)
    end

    doTweenAlpha('fard', 'misty', 0.675, 0.75, 'ease')
    playAnim("misty", "idle", true, false, 0)
  end
  if n == 'Change Character' and v2 == 'Ace' then
    doTweenAlpha('fard', 'misty', 0, 0.75, 'ease')
  end
end

  