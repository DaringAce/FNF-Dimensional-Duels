local enabled = true;
local camOffset = {0, 0};
local movement = 27;
local m = {{-movement, 0}, {0, movement}, {0, -movement}, {movement, 0}};

function onUpdate()
    if enabled then
        if not mustHitSection then
            setProperty('camFollow.x', getMidpointX('dad') + getProperty('dad.cameraPosition[0]') + camOffset[1] + 150);
            setProperty('camFollow.y', getMidpointY('dad') + getProperty('dad.cameraPosition[1]') + camOffset[2] - 100);
        else
            setProperty('camFollow.x', getMidpointX('boyfriend') + getProperty('boyfriend.cameraPosition[0]') + camOffset[1] - 100);
            setProperty('camFollow.y', getMidpointY('boyfriend') + getProperty('boyfriend.cameraPosition[1]') + camOffset[2] - 100);
        end
    end
end

function opponentNoteHit(aa, data)
	if (dadName == 'Ace' or dadName == 'AcePOWER') and enabled then
		if not mustHitSection then
			camOffset = m[data+1];
		end
	end
end

function goodNoteHit(aa, data)
	if boyfriendName == 'bf-Ace'or boyfriendName == 'bf-AceNORMAL' and enabled then
		if mustHitSection then
			camOffset = m[data+1];
		end
	end
end

function onEvent(name, val)
    if name == 'Camera Char Snap' then
        if val == 'PLR' or val == 'OP' then
            enabled = false
        elseif val == 'NONE' then
            enabled = true
        end
    end
end