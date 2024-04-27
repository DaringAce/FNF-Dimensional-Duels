function onEvent(name, val) --charName = OP/PLR/NONE
    if name == 'Camera Char Snap' then
        if val == 'NONE' then
            disable(defZoom)
        elseif val == 'OP' or val == 'PLR' then
            setProperty('cameraSpeed', 999.99)
            setProperty('defaultCamZoom', 1.75)   
            if val == 'OP' then
                setProperty('camFollowPos.x', 650)
                setProperty('camFollowPos.y', 200)
            end
            if val == 'PLR' then
                setProperty('camFollowPos.x', 1000)
                setProperty('camFollowPos.y', 800)
            end
        end
    end
end

function disable(val)
    setProperty('defaultCamZoom', 1.1)
    setProperty('cameraSpeed', 1.3)
    triggerEvent('Camera Follow Pos', '','')
end