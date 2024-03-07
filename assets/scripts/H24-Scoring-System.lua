--THIS SCRIPT WAS MADE BY Gostar64, WITH A BASE NPS SCRIPT BY Meme1079, THE COLORS WERE TAKEN FROM Unholywanderer04's Editable Combo and Ratings Script--
--The Legendary Legend of the Super Soup--

local enabled = true; --enables/disables the script
local continueCalculation = false; --continues the calculation if your script is disabled
local onlyNewText = false; --Only has the combo, rating, and score texts added in if your script is enabled

--Editable Things Below--

--Main Text Stuff--

local font = 'VTKS DURA 3D.ttf' -- H24's font is 'goodbyeDespair.ttf' but 'sonic-1-hud-font.ttf' is pretty cool
local dontChangeScoreFont = false; --disables the font change [default: false]
local changeTimeTextFont = true; --set to true to change the time text font
local textStyle = 'Custom' --Psych/OS/Kade/Yoshi-ish/Gostar64 (Custom) (makes it look like each engine's [or my custom] score)
local MSversion = 'Psych' --Psych/Anything else (Anything else makes it grab the ms from OS's playstate) (Psych one is broken, i no longer have time to do things)
local Ourple = false; --ourples the score

--Timers--

local timer = 1.80; --default is 2.05 --This is how long it takes to deplete
local timeItTakesToSpeedUp = 1.25; --default is 2 --pretty self explanatory
local speedUpMult = 5.00; --default is 2 --multiplier of the speed up

--Size--

local scoresize = 30; --default is 35 (set to 25 if using goodbyeDespair font) --score text size
local size = 30; --default is 50 --size of the special text
local dontChangeScoreSize = true; --disables the size change [default: false]

--Animations--

local AnimationReal = false; --makes bf do the hey thing when the combo is done (and perfect) (default: true)
local playHurtAnim = false; --If you're bad, your animation is the hurt animation (default: false)
local animationNames = {'hey', 'hurt', 'sad', 'cheer'} --the names (1 [default: hey] - perfect combo / 2 [default: hurt] - worst combo / 3 [default: sad] - gf crying when the worst combo / 4 [default: cheer] - perfect combo gf cheer)

--Gf's Animations--

local enableGfAnimCheer = false; -- Yeah
local enableGfAnimSad = false; -- Yeah

--Text Animations--

local SystemZoom = true; -- Makes the text from this script zoom (this specifically makes it zoom even if getPropertyFromGroup('ClientPrefs', 'scoreZoom') == false) default = true
local deactivateSystemZoom = false; --deactivates it even if the scoreZoom setting is on (default = false)

--Custom Texts--
local textSetting = 'custom' --base, custom, or both. changes what text to use. both is randomized each note hit
local customRateText = {'CRITICAL!', 'HIT!', 'LUCKY', 'UNLUCKY'} --Custom Text Here
local allText = {'SICK!', 'NICE!', 'BAD', 'SHIT', 'CRITICAL!', 'HIT!', 'LUCKY', 'UNLUCKY'} --Custom is the last 4
local perfects = {'PERFECT!', 'CRITCAL!'} --OS Engine (1 is normal, 2 is custom)
local customTextChance = 100; --The chance of the custom text appearing when textSetting is both

--Glow--

local glowActive = false; -- Makes the glow exist (default: false [only downscroll currently, and it looks bad])
local baseGlowOpacity = 0.25; -- what it sits at regularly (default: 0.25)
local maxGlowOpacity = 0.5; -- The glow's visible opacity (default: 0.5)
local blendMode = 'normal' --blend thing (default: normal)

-- Extra (some things that weren't in H024) --

local colorsActive = true; --makes the things change colors when you hit notes (direction-based, default: true)
local colors_ = {'c24b99', '68fafc', '12fa05', 'f9393f'} --the colors, yes they are customizable, has to be hex tho (left, down, up, right)
--defaultColors_ = {'c24b99', '68fafc', '12fa05', 'f9393f'}

local fcColorsActive = true; --makes it change colors depending on your FC status when the combo ends (default: true [requires colorsActive to be true])
local fcColors_ = {'68fafc', '48f048', 'fffecb', 'ffffff'} --(pfc/sfc, gfc, fc, sdcb/clear)
--defaultFcColors_ = {'68fafc', '48f048', 'fffecb', 'ffffff'}
local changeScoreColor = false; --direction-based (default: false) [automatically activates if using custom score style]
local fcScoreColor = false; --fc-based (default: false) [automatically activates if using custom score style]

--Sounds--

local playHeySound = false; --self-explainatory (default: false)
local heyVolume = 1; --pretty self-explainatory (default: 1)

--Debug--

local quickDebugThing = false; --set this to false if you're not editing

--skip these--

local coolDudeMult = 1; -- this is here I guess
local NoteHit = false; --just so you know, this is a heavily modified NPS script
local visibleScore = 0; 
local scoreToAdd = 0;
local canDecrease = false;
local daRate = 'SICK!';
local this = 'NICE!';
local recentCombo = 0;
local sick = 0;
local good = 0;
local bad = 0;
local shit = 0;
local perfect = 0; 
local recentMisses = 0;
local goFaster = false;
local canPlayAnimation = false;
local dumbdumbAnim = false;
local fcStatus = 1;
local baseRateText = {'SICK!', 'NICE!', 'BAD', 'SHIT'}
local allMS = 0;
local averageMS = 45;
local Ourpleness_ = "OURPLE"
local ogX = 0.0;
local scoreValue = 350;

--We've been trying to reach you to inform you that you should disable the perfect rating if you are on OS Engine--

function onCreate()
    luaDebugMode = quickDebugThing;

    if botPlay == true then
        enabled = false
    end

    --Better Examples--

    if songName == 'Sugarcrush' or songName == 'Thunderstorm' and getProperty('storyDifficultyText') == 'hard' or songName == 'Revenge-4k' or songName == 'Unknown Suffering' or songName == 'Untold Loneliness' or songName == 'Battered' or songName == 'Transgression' or songName == 'Nyaw' or songName == 'Expurgation' then
        font = 'goodbyeDespair.ttf'
        scoresize = 25;
        if songName == 'Sugarcrush' then
            enableGfAnimCheer = false;
        end
        if songName == 'Nyaw' or songName == 'Expurgation' then
            AnimationReal = false;
            timer = 1.65;
            timeItTakesToSpeedUp = 1;
        end
    end

    if songName == 'Golden' then
        font = 'OURPLE.ttf'

        scoresize = 25;

        enableGfAnimCheer = false;
        enableGfAnimSad = false;

        Ourple = true;
        textStyle = 'Psych'

        changeScoreColor = true
        fcScoreColor = true
    end

    if songName == 'Roses' or songName == 'Guns' or songName == 'Pico' then
        font = 'vcr.ttf';
        dontChangeScoreSize = true;
        enableGfAnimCheer = false;
        enableGfAnimSad = false;
    end

    if songName == 'Tutorial' then
        enabled = false;
        continueCalculation = true;
    end

    if songName == 'Supernovae' then
        onlyNewText = true;
    end

    if songName == 'Splitathon-New' or songName == 'Super-saiyan' or songName == 'Phonophobia' or songName == 'Screwed' or songName == 'Revenge' or songName == 'Thunderstorm' and getProperty('storyDifficultyText') == 'Normal' or songName == 'Awards' or songName == 'Ultra-Instinct' or songName == string.lower('hyperlink') or songName == 'Blammed-Erect' or songName == 'Overwrite' then --just replace/add songs here that you want to not have the score system
        enabled = false;
        textStyle = 'Psych'
    end

    --Add more stuff here--
end

--Don't edit below this unless you know what you're doing--

function onCreatePost()
    if downscroll and enabled then
        makeLuaText('combo score', scoreToAdd, 0, 580, 600)
        setObjectCamera('combo score', 'hud')
        setTextAlignment('combo score', 'center')
        addLuaText('combo score')

        makeLuaText('plusScore', '+'..scoreValue, 0, 550, 525)
        setObjectCamera('plusScore', 'hud')
        setTextAlignment('plusScore', 'center')
        addLuaText('plusScore')
    
        makeLuaText('daRate', daRate, 0, 520, 550)
        setObjectCamera('daRate', 'hud')
        setTextAlignment('daRate', 'center')
        addLuaText('daRate')
        ogX = 520;

        if glowActive then
            makeLuaSprite('glower', 'comboGlow', 500, 500)
            setObjectCamera('glower', 'hud')
            setScrollFactor('glower', 0, 0)
            scaleObject('glower', 1.5, 1.5)
            setBlendMode('glower', blendMode)

            addLuaSprite('glower', false)
        end
    end

    if downscroll and middlescroll and enabled then
        makeLuaText('combo score', scoreToAdd, 0, 580, 200)
        setObjectCamera('combo score', 'hud')
        setTextAlignment('combo score', 'center')
        addLuaText('combo score')

        makeLuaText('plusScore', '+'..scoreValue, 0, 550, 125)
        setObjectCamera('plusScore', 'hud')
        setTextAlignment('plusScore', 'center')
        addLuaText('plusScore')
    
        makeLuaText('daRate', daRate, 0, 520, 150)
        setObjectCamera('daRate', 'hud')
        setTextAlignment('daRate', 'center')
        addLuaText('daRate')

        ogX = 520;
    end

    if not downscroll and enabled then
        makeLuaText('combo score', scoreToAdd, 0, 590, 100)
        setObjectCamera('combo score', 'hud')
        setTextAlignment('combo score', 'center')
        addLuaText('combo score')

        makeLuaText('plusScore', '+'..scoreValue, 0, 575, 25)
        setObjectCamera('plusScore', 'hud')
        setTextAlignment('plusScore', 'center')
        addLuaText('plusScore')
    
        makeLuaText('daRate', daRate, 0, 540, 50)
        setObjectCamera('daRate', 'hud')
        setTextAlignment('daRate', 'center')
        addLuaText('daRate')

        ogX = 540
    end

    if not downscroll and middlescroll and enabled then
        makeLuaText('combo score', scoreToAdd, 0, 580, 500)
        setObjectCamera('combo score', 'hud')
        setTextAlignment('combo score', 'center')
        addLuaText('combo score')

        makeLuaText('plusScore', '+'..scoreValue, 0, 550, 425)
        setObjectCamera('plusScore', 'hud')
        setTextAlignment('plusScore', 'center')
        addLuaText('plusScore')
    
        makeLuaText('daRate', daRate, 0, 520, 450)
        setObjectCamera('daRate', 'hud')
        setTextAlignment('daRate', 'center')
        addLuaText('daRate')

        ogX = 520;
    end

    setTextAlignment('daRate', 'center')
    
    setProperty('combo score.alpha', 0)
    setProperty('plusScore.alpha', 0)
    setProperty('daRate.alpha', 0)
    setProperty('glower.alpha', 0)
end

function onStepHit()
    --sex
end

--[[
function onRecalculateRating()
    rateFullPer = round(getProperty('ratingPercent') * 100, 2)
    return Function_Continue
end
--]]

function onUpdate(elapsed)
    if changeTimeTextFont == true and enabled and not onlyNewText then --yeah, I check directly on custom variables
        setTextFont('timeTxt', font)
    end
    
    setTextString('combo score', scoreToAdd)
    --setTextString('comboCool', 'x'..recentCombo)
    screenCenter('combo score', 'x')
    screenCenter('daRate', 'x')
    screenCenter('plusScore', 'x')
    if scoreToAdd > 0 then
        setProperty('combo score.alpha', 1)
        --setProperty('comboCool.alpha', 1)
        setProperty('plusScore.alpha', 1)
        setProperty('daRate.alpha', 1)
        setProperty('glower.alpha', baseGlowOpacity)

        setTextString('daRate', daRate..' x'..recentCombo)
        setTextString('plusScore', '+'..scoreValue)
        --setProperty('daRate.x', ogX)
    end

    visibleScore = score - scoreToAdd;
    local rateFullPer = round(getProperty('ratingPercent') * 100, 2)

    local BeforeScore = 'SCORE: '..score..' | MISSES: '..misses..' | RATING: '..ratingName
    local FinalScore = 'SCORE: '..visibleScore..' | MISSES: '..misses..' | RATING: '..ratingName..' ('..rateFullPer..'%) - '..ratingFC
    local combo = getProperty('combo')

    local strumTime = getPropertyFromGroup('notes', id, 'strumTime')
    local songPos = getPropertyFromClass('Conductor', 'songPosition')
    local rOffset = getPropertyFromClass('ClientPrefs','ratingOffset')

    if textStyle == 'Psych' then
        BeforeScore = 'Score: '..score..' | Misses: '..misses..' | Rating: '..ratingName
        FinalScore = 'Score: '..visibleScore..' | Misses: '..misses..' | Rating: '..ratingName..' ('..rateFullPer..'%) - '..ratingFC
        if Ourple then
            BeforeScore = 'HOW OURPLE YOU ARE: '..score..' | MISSES: '..misses..' | RATING: '..ratingName
            FinalScore = 'HOW OURPLE YOU ARE: '..visibleScore..' | MISSES: '..misses..' | RATING: '..ratingName..' ('..rateFullPer..'%) - '..ratingFC
        end
    elseif textStyle == 'OS' then
        allMS = strumTime - songPos + rOffset
        BeforeScore = 'Score: '..score..' | Combo Breaks: '..misses..' | Average: ? | Accuracy: ?'
        if Ourple then
            BeforeScore = 'HOW OURPLE YOU ARE: '..score..' | COMBO BREAKS: '..misses..' | AVERAGE: ? | ACCURACY: ?'
        end
        if MSversion == 'Psych' then
            FinalScore = 'Score: '..visibleScore..' | Combo Breaks: '..misses..' | Average: '..string.format("%.3fms",round(averageMS, 0))..'ms | Accuracy: '..rateFullPer..'% | '..ratingName..' ['..ratingFC..']'
            if Ourple then
                FinalScore = 'HOW OURPLE YOU ARE: '..visibleScore..' | COMBO BREAKS: '..misses..' | AVERAGE: '..string.format("%.3fms",round(averageMS, 0))..'ms | ACCURACY: '..rateFullPer..'% | '..ratingName..' ['..ratingFC..']'
            end
        else
            FinalScore = 'Score: '..visibleScore..' | Combo Breaks: '..misses..' | Average: '..round(getProperty('averageMs'), 0)..'ms | Accuracy: '..rateFullPer..'% | '..ratingName..' ['..ratingFC..']'
            if Ourple then
                FinalScore = 'HOW OURPLE YOU ARE: '..visibleScore..' | COMBO BREAKS: '..misses..' | AVERAGE: '..round(getProperty('averageMs'), 0)..'ms | ACCURACY: '..rateFullPer..'% | '..ratingName..' ['..ratingFC..']'
            end
        end 
    elseif textStyle == 'Kade' then
        BeforeScore = 'Score:0 | Combo Breaks:0 | Accuracy:0% | N/A'
        FinalScore = 'Score:'..visibleScore..' | Combo Breaks:'..misses..' | Accuracy:'..rateFullPer..'% | ('..ratingName..') '..ratingFC
        if Ourple then
            BeforeScore = 'OURPLENESS:0 | COMBO BREAKS:0 | ACCURACY:0% | N/A'
            FinalScore = 'OURPLENESS:'..visibleScore..' | Combo Breaks:'..misses..' | Accuracy:'..rateFullPer..'% | ('..ratingName..') '..ratingFC
        end
    elseif textStyle == 'Yoshi-ish' then
        allMS = strumTime - songPos + rOffset
        BeforeScore = 'Score: '..score..' | Combo Breaks: '..misses..' | Accuracy: ? | Average: ? '
        if Ourple then
            BeforeScore = 'HOW OURPLE YOU ARE: '..score..' | COMBO BREAKS: '..misses..' | ACCURACY: ? | AVERAGE: ? '
        end
        if MSversion == 'Psych' then
            FinalScore = 'Score: '..visibleScore..' | Combo Breaks: '..misses..' | Accuracy: '..rateFullPer..'% ('..ratingName..') | ['..ratingFC..'] Average: '..string.format("%.3fms",round(averageMS, 0))..'ms'
            if Ourple then
                FinalScore = 'HOW OURPLE YOU ARE: '..visibleScore..' | COMBO BREAKS: '..misses..' | Accuracy: '..rateFullPer..'% ('..ratingName..') | ['..ratingFC..'] AVERAGE: '..string.format("%.3fms",round(averageMS, 0))..'ms'
            end
        else
            FinalScore = 'Score: '..visibleScore..' | Combo Breaks: '..misses..' |  Accuracy: '..rateFullPer..'% ('..ratingName..') | ['..ratingFC..'] | Average: '..round(getProperty('averageMs'), 0)..'ms'
            if Ourple then
                FinalScore = 'HOW OURPLE YOU ARE: '..visibleScore..' | COMBO BREAKS: '..misses..' |  Accuracy: '..rateFullPer..'% ('..ratingName..') | ['..ratingFC..'] | AVERAGE: '..round(getProperty('averageMs'), 0)..'ms'
            end
        end
    elseif textStyle == 'Custom' or textStyle == 'Gostar64' then
        BeforeScore = 'Score: '..score..' | Misses: '..misses..' | Rating: ? | Accuracy: ? | Combo: real'
        if Ourple then
            BeforeScore = 'HOW OURPLE YOU ARE: '..score..' | MISSES: '..misses..' | RATING: ? | ACCURACY: ? | COMBO: real'
        end
        if ratingFC ~= 'Clear' then 
            FinalScore = 'Score: '..visibleScore..' ('..scoreToAdd..') | Misses: '..misses..' | Rating: '..ratingName..' | Accuracy: '..rateFullPer..'% | Combo: '..combo..' ('..ratingFC..')'
            if Ourple then
                FinalScore = 'HOW OURPLE YOU ARE: '..visibleScore..' ('..Ourpleness_..') | MISSES: '..misses..' | RATING: '..ratingName..' | ACCURACY: '..rateFullPer..'% | COMBO: '..combo..' ('..ratingFC..')'
            end
        else
            FinalScore = 'Score: '..visibleScore..' ('..scoreToAdd..') | Misses: '..misses..' | Rating: '..ratingName..' | Accuracy: '..rateFullPer..'% | Combo: '..combo
            if Ourple then
                FinalScore = 'HOW OURPLE YOU ARE: '..visibleScore..' ('..Ourpleness_..') | MISSES: '..misses..' | RATING: '..ratingName..' | ACCURACY: '..rateFullPer..'% | COMBO: '..combo
            end
        end
    else
        BeforeScore = 'Score: '..score..' | Misses: '..misses..' | Rating: '..ratingName
        FinalScore = 'Score: '..visibleScore..' | Misses: '..misses..' | Rating: '..ratingName..' ('..rateFullPer..'%) - '..ratingFC
    end

    
    if getProperty('ratingFC') == 'SFC' or getProperty('ratingFC') == 'PFC' then
        fcStatus = 1
        Ourpleness_ = 'OURPLE'
    elseif getProperty('ratingFC') == 'GFC' then
        fcStatus = 2
    elseif getProperty('ratingFC') == 'FC' then
        fcStatus = 3
    else
        fcStatus = 4
    end

    if fcStatus ~= 1 then
        if visibleScore < 25000 then
            Ourpleness_ = "PRANGE"
        elseif visibleScore >= 25000 and visibleScore < 35000 then
            Ourpleness_ = "SOMEWHAT"
        elseif visibleScore >= 35000 and visibleScore < 50000 then
            Ourpleness_ = "KINDA"
        elseif visibleScore >= 50000 and visibleScore < 100000 then
            Ourpleness_ = "VERY"
        elseif visibleScore >= 100000 and visibleScore < 150000 then
            Ourpleness_ = "OURPLE"
        elseif visibleScore >= 150000 then
            Ourpleness_ = "WAY PAST OURPLE"
        end
    end


    if ratingName == '?' and enabled then
        setTextString('scoreTxt', BeforeScore)
    elseif ratingName ~= '?' and enabled or ratingName ~= '?' and not enabled and continueCalculation then
        setTextString('scoreTxt', FinalScore)  
    elseif enabled == false and not continueCalculation or enabled and onlyNewText then
        setTextString('scoreTxt', getTextString('scoreTxt'))
    end

    if enabled == true and not onlyNewText then
        if not dontChangeScoreSize then
            setTextSize('scoreTxt', scoresize)
        end
        if not dontChangeScoreFont then
            setTextFont('scoreTxt', font)
        end
    end
    
    setTextSize('combo score', size)
    --setTextSize('comboCool', size)
    setTextSize('daRate', size)
    setTextSize('plusScore', size/2)
    setTextFont('combo score', font)
    --setTextFont('comboCool', font)
    setTextFont('daRate', font)
    setTextFont('plusScore', font)

    if scoreToAdd < 0 and canPlayAnimation and AnimationReal and enabled then
        if canPlayAnimation and not dumbdumbAnim then
            triggerEvent('Play Animation', animationNames[1], 'BF')

            if enableGfAnimCheer then
                triggerEvent('Play Animation', animationNames[4], 'GF')
            end

            if playHeySound == true then
                playSound('Hey', heyVolume)
            end
        elseif canPlayAnimation and dumbdumbAnim and playHurtAnim then
            triggerEvent('Play Animation', animationNames[2], 'BF')

            if enableGfAnimSad then
                triggerEvent('Play Animation', animationNames[3], 'GF')
            end
        end
    end

    if scoreToAdd < 0 then
        scoreToAdd = 0
        canPlayAnimation = false;
        dumbdumbAnim = false;
        runTimer('scoreDoesGone', 1)
        doTweenAlpha('flash', 'combo score', 0.1, 0.2, 'linear')
        canDecrease = false;
        recentCombo = 0;
        --setProperty('comboCool.alpha', 0)
        setProperty('plusScore.alpha', 0)

        setTextString('daRate', this)
        screenCenter('daRate', 'x')
        if fcColorsActive then
            setProperty('daRate.color', getColorFromHex(fcColors_[fcStatus]))
            if textStyle == 'Custom' or textStyle == 'Gostar64' or fcScoreColor then
                setProperty('scoreTxt.color', getColorFromHex(fcColors_[fcStatus]))
                doTweenColor('scoreTxtColorer', 'scoreTxt', 'FFFFFF', 1, 'linear')
            end
        end
        setProperty('daRate.scale.x', 1.075)
	    setProperty('daRate.scale.y', 1.075)
        doTweenX('ratingX', 'daRate.scale', 1, 0.2, 'linear')
	    doTweenY('ratingY', 'daRate.scale', 1, 0.2, 'linear')
        doTweenAlpha('rateLeave', 'daRate', 0, 1, 'linear')
        doTweenAlpha('glowShrink', 'glower', baseGlowOpaceity, 1, 'linear')
        

        recentMisses = 0;

        goFaster = false;
    end

    if recentMisses == 0 then
            this = 'COOL!';
        canPlayAnimation = true;
        dumbdumbAnim = false;
    elseif recentMisses >= 1 and recentMisses <= 5 then
            this = 'SICK!';
        canPlayAnimation = false;
        dumbdumbAnim = false;
    elseif recentMisses >= 6 and recentMisses <= 10 then
            this = 'Nice!';
        canPlayAnimation = false;
        dumbdumbAnim = false;
    else
        this = 'Woops...';   
        canPlayAnimation = true;
        dumbdumbAnim = true;
    end

    if recentCombo == 69 then
        daRate = 'NICE!';
    end
    
    if canDecrease == true then
        scoreToAdd = round(scoreToAdd - 111, 0);
        if goFaster == true then
            scoreToAdd = round(scoreToAdd - 111 * speedUpMult + elapsed/100, 0);
        end
    end
end

function round(num, dp) -- i stole this
    local mult = 10^(dp or 0);
    return math.floor(num * mult + 0.5)/mult;
end
    
function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        recentCombo = recentCombo + 1
        customChance = getRandomBool(customTextChance)

        averageMS = allMS/getProperty('songHits'); --breh

        if scoreZoom and not deactivateSystemZoom or SystemZoom then
            setProperty('daRate.scale.x', 1.075)
	        setProperty('daRate.scale.y', 1.075)
            setProperty('combo score.scale.x', 1.075)
	        setProperty('combo score.scale.y', 1.075)
            setProperty('plusScore.scale.x', 1.075)
            setProperty('plusScore.scale.y', 1.075)
            setProperty('glower.scale.x', 1.575)
            setProperty('glower.scale.y', 1.575)
            setProperty('glower.alpha', maxGlowOpacity)
	        doTweenX('ratingX', 'daRate.scale', 1, 0.2, 'linear')
	        doTweenY('ratingY', 'daRate.scale', 1, 0.2, 'linear')
            doTweenX('+X', 'plusScore.scale', 1, 0.2, 'linear')
	        doTweenY('+Y', 'plusScore.scale', 1, 0.2, 'linear')
            doTweenX('AddScoreX', 'combo score.scale', 1, 0.2, 'linear')
	        doTweenY('AddScoreY', 'combo score.scale', 1, 0.2, 'linear')
        end

        if colorsActive == true then
            setProperty('daRate.color', getColorFromHex(colors_[direction+1]))
            setProperty('combo score.color', getColorFromHex(colors_[direction+1]))
            setProperty('plusScore.color', getColorFromHex(colors_[direction+1]))

            doTweenColor('ratingColor', 'daRate', 'FFFFFF', 0.2, 'linear')
            doTweenColor('addScoreColor', 'combo score', 'FFFFFF', 0.2, 'linear')
            doTweenColor('plusScoreColor', 'plusScore', 'FFFFFF', 0.2, 'linear')

            if textStyle == 'Custom' or textStyle == 'Gostar64' or changeScoreColor then
                setProperty('scoreTxt.color', getColorFromHex(colors_[direction+1]))
                doTweenColor('scoreTxtColorer', 'scoreTxt', 'FFFFFF', 0.2, 'linear')
            end
        end

        if sick < getProperty('sicks') then
            scoreValue = 350
            scoreToAdd = scoreToAdd + 350;
            sick = sick + 1;
            coolDudeMult = coolDudeMult + 0.01
            if averageMS > 45 then
                averageMS = 45
            end
            if textSetting == 'base' then
                daRate = baseRateText[1]
            elseif textSetting == 'custom' then
                daRate = customRateText[1]
            elseif textSetting == 'both' then
                if not customChance then
                    daRate = allText[1]
                end

                if customChance then
                    daRate = allText[5]
                end
            end
        elseif good < getProperty('goods') then
            scoreValue = 200
            scoreToAdd = scoreToAdd + 200;
            good = good + 1;
            coolDudeMult = coolDudeMult + 0.005
            if averageMS > 90 then
                averageMS = 90
            end
            if textSetting == 'base' then
                daRate = baseRateText[2]
            elseif textSetting == 'custom' then
                daRate = customRateText[2]
            elseif textSetting == 'both' then
                if not customChance then
                    daRate = allText[2]
                end

                if customChance then
                    daRate = allText[6]
                end
            end
        elseif bad < getProperty('bads') then
            scoreValue = 100
            scoreToAdd = scoreToAdd + 100;
            bad = bad + 1;
            coolDudeMult = coolDudeMult + 0.0025
            if averageMS > 135 then
                averageMS = 135
            end
            if textSetting == 'base' then
                daRate = baseRateText[3]
            elseif textSetting == 'custom' then
                daRate = customRateText[3]
            elseif textSetting == 'both' then
                if not customChance then
                    daRate = allText[3]
                end

                if customChance then
                    daRate = allText[7]
                end
            end
        elseif shit < getProperty('shits') then
            scoreValue = 50
            scoreToAdd = scoreToAdd + 50;
            shit = shit + 1;
            coolDudeMult = coolDudeMult + 0
            if averageMS > 145 then
                averageMS = 145
            end
            if textSetting == 'base' then
                daRate = baseRateText[4]
            elseif textSetting == 'custom' then
                daRate = customRateText[4]
            elseif textSetting == 'both' then
                if not customChance then
                    daRate = allText[4]
                end

                if customChance then
                    daRate = allText[8]
                end
            end
        elseif perfect < getProperty('perfects') then
            scoreValue = 500
            scoreToAdd = scoreToAdd + 500;
            perfect = perfect + 1;
            coolDudeMult = coolDudeMult + 0.02
            if averageMS > 45 then
                averageMS = 45
            end
            if textSetting == 'base' then
                daRate = perfects[1]
            elseif textSetting == 'custom' then
                daRate = perfects[2]
            elseif textSetting == 'both' then
                if not customChance then
                    daRate = perfects[1]
                end

                if customChance then
                    daRate = perfects[2]
                end
            end
        end
    end
    cancelTimer('scoreLeave')
    canDecrease = false;
    runTimer('scoreLeave', timer)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'scoreLeave' then
        runTimer('goFasterDude', timeItTakesToSpeedUp)
        canDecrease = true;
    end

    if tag == 'goFasterDude' then
        goFaster = true;
    end
    
    if tag == 'scoreDoesGone' then
        cancelTween('flash')
        cancelTween('flash2')
        setProperty('combo score.alpha', 0)
        setProperty('daRate.color', getColorFromHex('FFFFFF'))
    end
end

function onTweenCompleted(tag)
    if tag == 'flash' then
        doTweenAlpha('flash2', 'combo score', 0.1, 1, 'linear')
    elseif tag == 'flash2' then
        doTweenAlpha('flash', 'combo score', 0.1, 0.5, 'linear')
    end

    if tag == 'glowShrink' then
        doTweenAlpha('glowLeave', 'glower', 0, 1, 'elasticInOut')
    end
end

function noteMiss(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        recentMisses = recentMisses + 1
        daRate = 'MISS'
        if scoreToAdd >= 10 then
            scoreToAdd = scoreToAdd - 10;
        end
    end
end