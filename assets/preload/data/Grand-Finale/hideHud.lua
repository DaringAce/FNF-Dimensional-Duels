function onBeatHit()
	if curBeat == 24 then
		setProperty('camHUD.visible', false)	
	end
	
	if curBeat == 32 then
        setProperty('camHUD.visible', true)		
	end
end

