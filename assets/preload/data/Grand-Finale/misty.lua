function onCreate()
  makeAnimatedLuaSprite('misty', 'misty', -500, -400)
  addAnimationByPrefix('misty', 'idle', 'neblina instancia 1', 24, true)
  scaleObject('misty', 11, 11)
  setProperty('misty.alpha', 0)
  addLuaSprite('misty', true)
end

onEvent = function(n,v1,v2)
  if n == 'Lights out' then
    doTweenAlpha('fard', 'misty', 0.75, 0.75, 'ease')
    playAnim("misty", "idle", true, false, 0)
  end
  if n == 'Lights on' then
    doTweenAlpha('fard', 'misty', 0, 0.75, 'ease')
  end
end

  