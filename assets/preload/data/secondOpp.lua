
function onCreate()
    --runHaxeCode([[
    --    weewee = new Character(-35, 100,"anti",false);
    --    game.add(weewee);
    --]])
end

function onBeatHit()
    runHaxeCode("weewee.dance();")
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if noteType == "altdad" then
        runHaxeCode([[
            weewee.playAnim(game.singAnimations[]]..noteData..[[], true);
            weewee.holdTimer = 0;
            ]])
    end
end