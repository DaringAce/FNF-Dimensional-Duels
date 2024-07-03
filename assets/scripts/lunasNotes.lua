local ran = false

local function skinChange()
    if dadName == 'Luna Happy' or dadName == 'Luna' or dadName == 'LunaHungry' then
        if not ran then
            ran = true
            opponentTexture = (dadName == 'Luna Happy' or dadName == 'Luna' or dadName == 'LunaHungry') and 'CrossNotes' or 'NOTE_assets'
            unspawnNotesLength = getProperty('unspawnNotes.length')

            for i = 0, 3 do
                setPropertyFromGroup("opponentStrums", i, "texture", opponentTexture)
            end

            for i = 0, getProperty('unspawnNotes.length') - 1 do
                mustPress = getPropertyFromGroup('unspawnNotes', i, 'mustPress')
                if (dadName == 'Luna Happy' or dadName == 'Luna' or dadName == 'LunaHungry') and not mustPress then
                    setPropertyFromGroup('unspawnNotes', i, 'texture', 'CrossNotes')
                    setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'LunaSplash')
                end
            end
        end
    end
end

function opponentNoteHit()
    if dadName == 'Luna Happy' or dadName == 'Luna' or dadName == 'LunaHungry' then
        for i = 0, getProperty('grpNoteSplashes.length')-1 do
            if (dadName == 'Luna Happy' or dadName == 'Luna' or dadName == 'LunaHungry') then            
                setProperty('grpNoteSplashes.members['..i..'].alpha', 0.8)
            end
        end
    end
end

function onSongStart() 
    if dadName == 'Luna Happy' or dadName == 'Luna' or dadName == 'LunaHungry' then
        skinChange() 
    end
end

function onCountdownTick() 
    if dadName == 'Luna Happy' or dadName == 'Luna' or dadName == 'LunaHungry' then
        skinChange() 
    end
end