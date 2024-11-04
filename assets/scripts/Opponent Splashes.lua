function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if not getPropertyFromGroup('notes', membersIndex, 'noteSplashDisabled') and getPropertyFromGroup('notes', membersIndex, 'visible') and getPropertyFromGroup('notes', membersIndex, 'alpha') > 0 and not isSustainNote and getPropertyFromClass('ClientPrefs', 'noteSplashes') then
        local x, y = getPropertyFromGroup('opponentStrums', noteData, 'x'), getPropertyFromGroup('opponentStrums', noteData, 'y')
        local xAce, yAce = -23, -15
        if (dadName == 'Ace' or dadName == 'AcePOWER') then
            runHaxeCode('game.spawnNoteSplash(' .. x + xAce .. ', ' .. y + yAce .. ', game.notes.members[' .. membersIndex .. '].noteData, game.notes.members[' .. membersIndex .. '])')
        else
            runHaxeCode('game.spawnNoteSplash(' .. x .. ', ' .. y .. ', game.notes.members[' .. membersIndex .. '].noteData, game.notes.members[' .. membersIndex .. '])')
        end
    end
end