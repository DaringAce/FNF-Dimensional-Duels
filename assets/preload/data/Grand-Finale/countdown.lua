onEvent = function(n,v1,v2)
 if n == 'Duel Countdown' then
  playSound('Three')
  local c = crochet/1000
  runTimer('two', c)
  runTimer('one', c*2)
  runTimer('go', c*3)
 end
end
onTimerCompleted=function(t)
 if t == 'two' then
  makeLuaSprite('ready', 'two')
  setObjectCamera('ready', 'hud')
  screenCenter('ready')
  addLuaSprite('ready', true)
  playSound('Two')
  doTweenAlpha('ready','ready',0,(crochet/1000)*0.75,'cubeIn')
 elseif t == 'one' then
  makeLuaSprite('set', 'one')
  setObjectCamera('set', 'hud')
  screenCenter('set')
  addLuaSprite('set', true)
  playSound('One')
  doTweenAlpha('set','set',0,(crochet/1000)*0.75,'cubeIn')
 elseif t == 'go' then
  makeLuaSprite('go', 'fight')
  setObjectCamera('go', 'hud')
  screenCenter('go')
  addLuaSprite('go', true)
  playSound('Fight')
  doTweenAlpha('go','go',0,(crochet/1000)*0.75,'cubeIn')
 end
end
onTweenCompleted=function(t)
  if t == 'go' then
    removeLuaSprite('ready')
    removeLuaSprite('set')
    removeLuaSprite('go')
  end
end