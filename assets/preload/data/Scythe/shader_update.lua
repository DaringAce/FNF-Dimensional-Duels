local shadname = "dropShadow"
 local LastDadname=''
local LastBFname=''
function onCreatePost()

    initLuaShader(shadname)

    setSpriteShader('boyfriend', shadname)
    setSpriteShader('dad', shadname)
    setSpriteShader('gf', shadname)
    LastBFname=boyfriendName
    LastDadname=dadName
    makeLuaSprite("temporaryShader")
    makeGraphic("temporaryShader", screenWidth, screenHeight)

    setSpriteShader("temporaryShader", shadname)

    runHaxeCode([[
        game.boyfriendMap.set(game.boyfriend.curCharacter, game.boyfriend);
        game.dadMap.set(game.dad.curCharacter, game.dad);
        //game.addTextToDebug("ShaderFilter",]]..getColorFromHex('FF0000')..[[);
        //game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        //game.camOther.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
    ]]) 
    setShaderFloat("temporaryShader", "_alpha", 0.5)
    setShaderFloat("temporaryShader", "_disx", 14)
    setShaderFloat("temporaryShader", "_disy",12)
    setShaderBool("temporaryShader", "inner", true) 
    setShaderBool("temporaryShader", "inverted", true)
    setShaderBool("temporaryShader", "knockout", true)
end
function onEvent(eventName, value1, value2)
    if eventName=='Change Character' then
        local Character=stringTrim(string.lower(value1))
        local LastCharName=LastBFname
        if Character== 'dad' or Character== 'opponent' then
            Character='dad'
            LastCharName=LastDadname
        else
            Character='boyfriend'
        end
        runHaxeCode([[
            var Char=game.]]..Character..[[Map.get(']]..LastCharName..[[');
            Char.shader = null;
        ]])
        if Character=='dad' then LastDadname=value2
        else LastBFname=value2 end
        setSpriteShader(Character,shadname)
    end 
end