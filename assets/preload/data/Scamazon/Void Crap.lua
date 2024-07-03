function onSongStart()
	noteTweenX("NoteMove1", 0, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove2", 1, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove3", 2, -1000, 0.5, cubeInOut)
	noteTweenX("NoteMove4", 3, -1000, 0.5, cubeInOut)
	doTweenX('tag', 'timeBar', 764, 0.5, 'cubeInOut')
	doTweenX('tag2', 'timeTxt', 764, 0.5, 'cubeInOut')
end