function onEvent(name)
    if name == 'Lights on' then
        cameraFlash('camGame', '000000', 0.35);
		showHealth()
		showScoretxt()

        removeSpriteShader('boyfriend');

        setProperty('loBlack.alpha', 0);
        setProperty('gf.visible', true);

        removeSpriteShader('aceBG');
    end
end

function showHealth()
	setProperty('healthBar.alpha', tonumber(1))
    setProperty('iconP1.alpha', tonumber(1))
    setProperty('iconP2.alpha', tonumber(1))
end

function showScoretxt()
	setProperty('scoreTxt.alpha', tonumber(1))
end