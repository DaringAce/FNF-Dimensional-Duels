function cover()
      makeLuaSprite('cover', 'Fang', 0, 0)
      --makeGraphic('cover', 1, 1, color)
      scaleObject('cover',screenWidth,screenHeight)
      setProperty('cover.alpha',0.0001)
      doTweenAlpha('coveringshit','cover',1,0.2)
      setObjectCamera('cover','hud')
	if not covered then
      		addLuaSprite('cover')
      		setProperty('cover.alpha',0.0001)
      		doTweenAlpha('coveringshit','cover',1,0.2)
		covered = true
	else
		setProperty('cover.alpha',0.0001)
      		doTweenAlpha('uncoveringshit','cover',1,0.2)
	end
end

covered = false

function onEvent(n,v1,v2)
        if n == 'Cover Camera' then
			if v1 == 'black' then
				--color = '000000'
				cover()
			end
        end
end

function onTweenCompleted(n)
        if n == 'uncoveringshit' then
              removeLuaSprite('cover',true)
		covered = false
        end
end