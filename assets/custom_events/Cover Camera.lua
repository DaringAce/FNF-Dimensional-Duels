function onCreatePost()
      makeLuaSprite('bgcover','')
      makeGraphic('bgcover',1,1,'000000')
      setProperty('bgcover.color', getColorFromHex('000000'))
      scaleObject('bgcover',screenWidth,screenHeight)
      setObjectCamera('bgcover','hud')
      setProperty('bgcover.alpha',0.000001)
      addLuaSprite('bgcover',true)
      makeAnimatedLuaSprite('cover', 'Fang')
      addAnimationByPrefix('cover', 'Fang', 'Fang', 24, false)
      screenCenter('cover', 'xy')
      -- scaleObject('cover',screenWidth,screenHeight)
      setProperty('cover.alpha',0.0001)
      setObjectCamera('cover','hud')
      addLuaSprite('cover',true)
end

covered = false
function onEvent(n,v1,v2)
        if n == 'Cover Camera' then
            doTweenAlpha('bs','bgcover',covered and 0 or 1,v1,'sineInOut')
            doTweenAlpha('covering','cover',covered and 0 or 1,v1,'sineInOut')
            playAnim('cover', 'Fang')
        end
end

function onTweenCompleted(n)
        if n == 'covering' then
                  covered = not covered
        end
end