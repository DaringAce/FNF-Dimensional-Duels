function opponentNoteHit(id,nd,nt,issus)
	playAnim("gf", getProperty('singAnimations')[nd + 1], true)
	setProperty('gf.holdTimer', 0)
end
