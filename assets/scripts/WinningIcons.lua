--Script originally by Flain, but edited a bit by Ivaldi

local dadsExist = false --P2
local bfsExist = false --P1

function onCreatePost()
	if checkFileExists('assets/images/icons/extra/icon-'..getProperty('dad.healthIcon')..'.png', true) then
		dadsExist = true
		print('The opponent HAS winning icons.')
	else
		print('The opponent DOES NOT HAVE winning icons.')
	end

	if checkFileExists('assets/images/icons/extra/icon-'..getProperty('boyfriend.healthIcon')..'.png', true) then
		bfsExist = true
		print('The player HAS winning icons.')
	else
		print('The player DOES NOT HAVE winning icons.')
	end

	winic()
end

function winic()
	if dadsExist then
		makeLuaSprite('newiconP2','icons/extra/icon-'..getProperty('dad.healthIcon'))
		loadGraphic('newiconP2','icons/extra/icon-'..getProperty('dad.healthIcon'),150)
		addAnimation('newiconP2','icons/extra/icon-'..getProperty('dad.healthIcon'),{0,1,2},0,false)
		setObjectCamera('newiconP2','hud')
		setObjectOrder('newiconP2',getObjectOrder('iconP2')+1)
	end

	if bfsExist then
		makeLuaSprite('newiconP1','icons/extra/icon-'..getProperty('boyfriend.healthIcon'))
		loadGraphic('newiconP1','icons/extra/icon-'..getProperty('boyfriend.healthIcon'),150)
		addAnimation('newiconP1','icons/extra/icon-'..getProperty('boyfriend.healthIcon'),{0,1,2},0,false)
		setObjectCamera('newiconP1','hud')
		setObjectOrder('newiconP1',getObjectOrder('iconP1')+1)
		setProperty('newiconP1.flipX',true)
	end
end


function onUpdatePost()
--	for i = 1,2 do
	if dadsExist then
		setProperty('newiconP2.x',getProperty('iconP2.x'))
		setProperty('newiconP2.origin.x',getProperty('iconP2.origin.x'))
		setProperty('newiconP2.origin.y',getProperty('iconP2.origin.y'))
		setProperty('newiconP2.y',getProperty('iconP2.y'))
		scaleObject('newiconP2',getProperty('iconP2.scale.x'),getProperty('iconP2.scale.y'),false)
		setProperty('iconP2.visible',false)
		setProperty('newiconP2.animation.curAnim.curFrame',(getHealth() > 1.6 and 1 or getHealth() < 0.4 and 2 or 0))
	end
	
	if bfsExist then
		setProperty('newiconP1.x',getProperty('iconP1.x'))
		setProperty('newiconP1.origin.x',getProperty('iconP1.origin.x'))
		setProperty('newiconP1.origin.y',getProperty('iconP1.origin.y'))
		setProperty('newiconP1.y',getProperty('iconP1.y'))
		scaleObject('newiconP1',getProperty('iconP1.scale.x'),getProperty('iconP1.scale.y'),false)
		setProperty('iconP1.visible',false)
		setProperty('newiconP1.animation.curAnim.curFrame',(getHealth() > 1.6 and 2 or getHealth() < 0.4 and 1 or 0))
	end
end

function onEvent(n)
			if  n == 'Change Character' and (songName ~= 'Grand Finale' and songName ~= 'Grand-Finale') then
				winic()
			end

			if n == 'Lights out' then
				if bfsExist then
					setProperty('newiconP1.visible', false)
				end

				if dadsExist then
					setProperty('newiconP2.visible', false)
				end
			end

			if n == 'Lights on' then
				if bfsExist then
					setProperty('newiconP1.visible', true)
				end

				if dadsExist then
					setProperty('newiconP2.visible', true)
				end
			end
end

function onBeatHit()
	if bfsExist then
		doTweenAngle('plrTween1', 'newiconP1', -25, crochet/6500)
	end

	if dadsExist then
		doTweenAngle('opTween1', 'newiconP2', 25, crochet/6500)
	end
end

function onTweenCompleted(tag)
    if tag == 'plrTween1' then
        doTweenAngle('plrTween2', 'newiconP1', 0, crochet/4250)
    end

	if tag == 'opTween1' then
		doTweenAngle('opTween2', 'newiconP2', 0, crochet/4250)
	end
end


