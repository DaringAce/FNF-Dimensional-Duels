function onEvent(name)
    if name == 'Hide HUD' then
        setProperty('camHUD.visible', false);
    end
    if name == 'Show HUD' then
        setProperty('camHUD.visible', true);  
    end
end