local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config

-- Square Minimap
function GetMinimapShape()
    return 'SQUARE'
end

Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

local mm = Minimap
local mmbg = CreateFrame("Frame", nil, mm)
mmbg:SetPoint("TOPLEFT", -5, 7);
mmbg:SetPoint("BOTTOMRIGHT", 5, -7);
mmbg:SetBackdrop({
	edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-DialogBox-Border',
	edgeSize = 24,
})

-- Move Stuff

Minimap:SetPoint("BOTTOM", MinimapZoneTextButton, 3, -157) 
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

TimeManagerClockButton:ClearAllPoints()
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, 0, -29)

GameTimeFrame:ClearAllPoints()
GameTimeFrame:SetPoint("TOPRIGHT", Minimap, 18, 12)

MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("TOPLEFT", Minimap, -27, 0)

MiniMapLFGFrame:ClearAllPoints()
MiniMapLFGFrame:SetPoint("LEFT", Minimap, -27, 0)

MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, -27, 0)

MiniMapVoiceChatFrame:ClearAllPoints()
MiniMapVoiceChatFrame:SetPoint("BOTTOMLEFT", Minimap, 0, -29)

MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, 0, -29)

-- Hide all unwanted things
MinimapZoomIn:Hide()
MinimapZoomIn:UnregisterAllEvents()

MinimapZoomOut:Hide()
MinimapZoomOut:UnregisterAllEvents()

MinimapBorder:Hide()

-- 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("BOTTOM", MinimapZoneTextButton, "BOTTOM", 0, -45)


-- Enable mousewheel zooming
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
    if (delta > 0) then
        _G.MinimapZoomIn:Click()
    elseif delta < 0 then
        _G.MinimapZoomOut:Click()
    end
end)

