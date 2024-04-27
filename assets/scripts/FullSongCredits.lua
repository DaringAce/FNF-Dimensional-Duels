--[[
CREDITS :yippee:

omotashi: Made the script (https://twitter.com/omotashii)
legole0: Helped me make the base script when I started from scratch (https://twitter.com/legole0)
Piggyfriend1792: The OG Script from the Monday Night Monsterin' Mod that I used for making the thing show up (https://twitter.com/piggyfriend1792)
DEAD SKULLXX: Requested me to add Artist and Charter Credits 
--]]



local songdata = {
--yes i used the pico week bc i didnt wanna interfere with the old version
    ['Pico'] = {
    'Pico', -- Song Name [1]
    'Kawai Sprite', -- Composer [2]
    '5', --  Length for onscreen [3]
    'PhantomArcade', -- Artist [4] (not being used)
    'NinjaMuffin99', -- Charter [5]
    'Pico', -- Custom Song Name [6] (because the names dont accept '-')
    },

    ['Long-Wired Brawl'] = {
        'Long-Wired-Brawl',
        'Daring Ace & Z11Gaming (ft. Greg Chun)',
        '7',
        'JDST & Daring Ace',
        'jordanmodshop',
        'Long-Wired Brawl',
    },
    
    ['Scythe'] = {
        'scythe',
        'Daring Ace & Z11Gaming (ft. Greg Chun)',
        '7',
        'JDST & Daring Ace',
        '(i forgor :skull:)',
        'Scythe',
    },
    
    ['Righteous Waterstream'] = {
        'Righteous-Waterstream',
        'Daring Ace & Z11Gaming (ft. Greg Chun)',
        '7',
        'JDST & Daring Ace',
        'TrueMori',
        'Righteous Waterstream',
    },

    ['Grand Finale'] = {
        'Grand Finale',
        'Daring Ace & Z11Gaming (ft. Greg Chun)',
        '7',
        'JDST & Daring Ace',
        'TrueMori & Ivaldi',
        'Grand Finale',
    },    
    
    ['Uncertainty'] = {
        'Uncertainty',
        'Daring Ace & fadeawayYT (ft. Greg Chun)',
        '7',
        'JDST & Daring Ace',
        'TrueMori',
        'Uncertainty',
    },    
    
    ['Thirst-For-The-Night'] = {
        'Thirst-For-The-Night',
        'Daring Ace',
        '7',
        'JDST & Daring Ace',
        '',
        'Thirst For The Night',
    },    
    
    ['Autophobia'] = {
        'Autophobia',
        'Qiro & Daring Ace (ft. Greg Chun)',
        '7',
        'JDST & Daring Ace',
        'Flain',
        'Autophobia',
    },    
    
-- Replace this data with your songs and the song composer. 
-- The song name in the [] MUST be the same song in the JSON file
-- The Next two are just string values, have fun :3
}

local font = 'PhantomMuff.ttf'
local offsetX = 10
local offsetY = 500
local objWidth = 750
local space = 10

function ifExists(table, valuecheck) -- This stupid function stops your game from throwing up errors when you play a main week song thats not in the Song Data Folder
    if table[valuecheck] then
        return true
    else
        return false
    end
end


function onCreatePost() -- This creates all the placeholder shit B) ((THIS PART OF THE SCRIPT WAS MADE BY PIGGY))
    luaDebugMode = true

    makeLuaSprite('creditBox', 'empty', 0 - objWidth, offsetY)
    makeGraphic('creditBox', objWidth, 150, '000000')
    setObjectCamera('creditBox', 'other')
    setProperty("creditBox.alpha", 0.7)
    addLuaSprite('creditBox', true)

    makeLuaText('creditTitle', 'PlaceholderTitle', objWidth, offsetX - objWidth, offsetY+0 + space)
    setTextSize('creditTitle', 40)
    setTextAlignment('creditTitle', 'left')
    setObjectCamera('creditTitle', 'other')
    setTextFont('creditTitle', font)
    addLuaText("creditTitle",true)

    makeLuaText('creditComposer', 'PlaceholderComposer', objWidth, offsetX - objWidth, offsetY+45 + space)
    setTextSize('creditComposer', 20)
    setTextAlignment('creditComposer', 'left')
    setObjectCamera('creditComposer', 'other')
    setTextFont('creditComposer', font)
    addLuaText("creditComposer",true)

    makeLuaText('creditArtist', 'PlaceholderArtist', objWidth, offsetX - objWidth, offsetY+80 )
    setTextSize('creditArtist', 20)
    setTextAlignment('creditArtist', 'left')
    setObjectCamera('creditArtist', 'other')
 --   addLuaText("creditArtist",true)

    makeLuaText('creditCharter', 'PlaceholderCharter', objWidth, offsetX - objWidth, offsetY+80 + space) -- +115
    setTextSize('creditCharter', 20)
    setTextAlignment('creditCharter', 'left')
    setObjectCamera('creditCharter', 'other')
    setTextFont('creditCharter', font)
    addLuaText("creditCharter",true)

    -- If you dont NOT want the art and charter credits (or a mix of two), the value used in the old version is:
    -- offsetY+25 for creditTitle
    -- offsetY+80 for the other credit (be it Composer, Charting, or Art)
end


function onSongStart()

 songExists = ifExists(songdata, songName) -- Checks to see if song exists

 if songExists == true then
    local curSongTable = songdata[songName]
    setTextString('creditTitle', curSongTable[6]) -- Sets the actual things
    setTextString('creditComposer', "Composing: "..curSongTable[2])
    setTextString('creditArtist', "Art: "..curSongTable[4])
    setTextString('creditCharter', "Charting: "..curSongTable[5])

    --Tweens--
    doTweenX("creditBoxTween", "creditBox", getProperty("creditBox.x") + objWidth, 1, "expoOut")
    doTweenX("creditTitleTween", "creditTitle", getProperty("creditTitle.x") + objWidth, 1, "expoOut")
    doTweenX("creditArtistTween", "creditArtist", getProperty("creditArtist.x") + objWidth, 1, "expoOut")
    doTweenX("creditComposerTween", "creditComposer", getProperty("creditComposer.x") + objWidth, 1, "expoOut")
    doTweenX("creditCharterTween", "creditCharter", getProperty("creditCharter.x") + objWidth, 1, "expoOut")
    runTimer("creditDisplay",curSongTable[3],1)
 else

    

 end
end

function onTimerCompleted(timerName)

    if timerName == "creditDisplay" then
        doTweenX("creditBoxTween", "creditBox", getProperty("creditBox.x") - objWidth, 0.5, "sineIn")
        doTweenX("creditTitleTween", "creditTitle", getProperty("creditTitle.x") - objWidth, 0.5, "sineIn")
        doTweenX("creditComposerTween", "creditComposer", getProperty("creditComposer.x") - objWidth, 0.5, "sineIn")
        doTweenX("creditArtistTween", "creditArtist", getProperty("creditArtist.x") - objWidth, 0.5, "sineIn")
        doTweenX("creditCharterTween", "creditCharter", getProperty("creditCharter.x") - objWidth, 0.5, "sineIn")
    end

end