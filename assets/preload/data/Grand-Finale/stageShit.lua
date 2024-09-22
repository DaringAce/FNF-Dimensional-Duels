local showing = false

function onCreate()
  makeLuaSprite('stage', 'v2', -900, -300) 
  addLuaSprite('stage')
  setProperty('stage.visible', false)
  setObjectOrder('stage', getObjectOrder('dadGroup') - 1.5) 
end

function onEvent(n, v1,v2)
  if n == 'lunaShit' then
    if showing == false then
      setProperty('stage.visible', true)
      showing = true
    else
      setProperty('stage.visible', false)
    end
  end
end