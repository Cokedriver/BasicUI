local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config
local cfg = C["minimap"]


--[[

	All Credit for Minimap.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.

]]

if cfg.enable ~= true then return end


-- Minimap tweaks:

-- Hide Zoom In/ Zoom Out buttons:
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Mouse wheel Zom In/ Zoom out:
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
    if delta > 0 then
		Minimap_ZoomIn()
    else
		Minimap_ZoomOut()
    end
end)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("TOPRIGHT", -26, 7)

-- Hide Minimap Clock
if cfg.gameclock == true then
	TimeManagerClockButton:Show()
else
	TimeManagerClockButton:Hide()
end

-- Bigger minimap
if cfg.farm == true then

	MinimapCluster:SetScale(cfg.farmscale)
	MinimapCluster:EnableMouse(false)
else
	MinimapCluster:SetScale(1.1)
	MinimapCluster:EnableMouse(false)
end

-- Modify Minimap Tracker:
MiniMapTracking:UnregisterAllEvents()
MiniMapTracking:Hide()

Minimap:SetScript('OnMouseUp', function(self, button)
    if (button == 'RightButton') then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * 0.7), -3)
    else
        Minimap_OnClick(self)
    end
end)
	