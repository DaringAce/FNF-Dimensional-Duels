local ran = false

local function skinChange()
    if not ran then
        ran = true
        opponentTexture = (dadName == 'Ace' or dadName == 'AceFP') and 'NOTE_dimensionalgate' or 'NOTE_assets'
        playerTexture = (boyfriendName == 'bf-Ace' or boyfriendName == 'bf-AceNORMAL') and 'NOTE_dimensionalgate' or 'NOTE_assets'
        unspawnNotesLength = getProperty('unspawnNotes.length')

        for i = 0, 3 do
            setPropertyFromGroup("opponentStrums", i, "texture", opponentTexture)
            setPropertyFromGroup("playerStrums", i, "texture", playerTexture)
        end

        for i = 0, getProperty('unspawnNotes.length') - 1 do
            mustPress = getPropertyFromGroup('unspawnNotes', i, 'mustPress')
            if (boyfriendName == 'bf-Ace' or boyfriendName == 'bf-AceNORMAL') and mustPress then
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_dimensionalgate')
	            setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'SPLASHES_dimensionalgate')
            elseif (dadName == 'Ace' or dadName == 'AceFP') and not mustPress then
                setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_dimensionalgate')
	            setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'SPLASHES_dimensionalgate')
            end
        end
    end
end

--function opponentNoteHit()
--    for i = 0, getProperty('grpNoteSplashes.length')-1 do
--        if (dadName == 'Ace' or dadName == 'AcePOWER') then            
--        end
--    end
--end

function goodNoteHit()
    for i = 0, getProperty('grpNoteSplashes.length')-1 do
        if boyfriendName == 'bf-Ace'or boyfriendName == 'bf-AceNORMAL' then
            setProperty('grpNoteSplashes.members['..i..'].offset.x', 30)
            setProperty('grpNoteSplashes.members['..i..'].offset.y', 28)
        end
    end
end

function onSongStart() skinChange() end
function onCountdownTick() skinChange() end