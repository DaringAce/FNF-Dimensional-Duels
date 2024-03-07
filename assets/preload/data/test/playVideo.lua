playVideo = true

function onCreatePost()
	makeGraphic('box', 1280, 720, 'ffffff')
	setObjectCamera('box', 'hud')
	addLuaSprite('box', true)
end

function onStartCountdown()
	if playVideo then
		playVideo = false
		startVideo('Opening Cutscene')
		return Function_Stop
	end
	exitSong()
end