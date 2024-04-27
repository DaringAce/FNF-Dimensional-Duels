function onEvent(name)
    if name == 'Lights out' then
        cameraFlash('camGame', 'FFFFFF', 0.35);
		hideHealth()
        hideScoretxt()

        if boyfriendName ~= "bf-Xonricd" then
            setSpriteShader('boyfriend', 'BWShader');
            setShaderFloat('boyfriend', 'lowerBound', 0.01);
            setShaderFloat('boyfriend', 'upperBound', 0.12);
            setShaderBool('boyfriend', 'invert', true);
        end

        setSpriteShader('gf', 'BWShader');
        setShaderFloat('gf', 'lowerBound', 0.01);
        setShaderFloat('gf', 'upperBound', 0.12);
        setShaderBool('gf', 'invert', true);
        setProperty('loBlack.alpha', 1);
        
        setSpriteShader('aceBG', 'BWShader');
        setShaderFloat('aceBG', 'lowerBound', 0.01);
        setShaderFloat('aceBG', 'upperBound', 0.12);
    end
end

function hideHealth()
	setProperty('healthBar.alpha', tonumber(0))
    setProperty('iconP1.alpha', tonumber(0))
    setProperty('iconP2.alpha', tonumber(0))
end

function hideScoretxt()
	setProperty('scoreTxt.alpha', tonumber(0))
end