local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database



--[[

	All Credit for Minimap.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.
	
]]

if C['general'].minimap.mousezoom == true then

	MinimapZoomIn:Hide()
	MinimapZoomIn:UnregisterAllEvents()

	MinimapZoomOut:Hide()
	MinimapZoomOut:UnregisterAllEvents()

	-- Enable mousewheel zooming
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript('OnMouseWheel', function(self, delta)
		if (delta > 0) then
			_G.MinimapZoomIn:Click()
		elseif delta < 0 then
			_G.MinimapZoomOut:Click()
		end
	end)

end

if C['general'].minimap.gameclock == false then
	TimeManagerClockButton:Hide()
end

if C['general'].minimap.square == true then

	function GetMinimapShape() return 'SQUARE' end

	MinimapBorder:Hide()

	Minimap:SetPoint("BOTTOM", MinimapZoneTextButton, 3, -157) 
	Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

	if C['general'].minimap.border == true then
		
		local mm = Minimap
		local mmbg = CreateFrame("Frame", nil, mm)	
		if C['general'].minimap.borderstyle == 'Blizzard' then
			mmbg:SetPoint("TOPLEFT", -9, 9);
			mmbg:SetPoint("BOTTOMRIGHT", 9, -8);	
			mmbg:SetBackdrop({
				edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-DialogBox-Border',
				edgeSize = 24,
			})
			
			GameTimeFrame:ClearAllPoints()
			GameTimeFrame:SetPoint("TOPRIGHT", Minimap, 20, 14)

			MiniMapTracking:ClearAllPoints()
			MiniMapTracking:SetPoint("TOPLEFT", Minimap, -35, 0)

			MiniMapLFGFrame:ClearAllPoints()
			MiniMapLFGFrame:SetPoint("LEFT", Minimap, -35, 0)

			MiniMapBattlefieldFrame:ClearAllPoints()
			MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, -35, 0)

			MiniMapVoiceChatFrame:ClearAllPoints()
			MiniMapVoiceChatFrame:SetPoint("BOTTOMLEFT", Minimap, 5, -35)

			MiniMapMailFrame:ClearAllPoints()
			MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, 0, -35)
			
			TimeManagerClockButton:ClearAllPoints()
			TimeManagerClockButton:SetPoint("BOTTOM", Minimap, 0, -31)		
			
		elseif C['general'].minimap.borderstyle == 'BasicUI' then
			mmbg:SetPoint("TOPLEFT", -5, 5);
			mmbg:SetPoint("BOTTOMRIGHT", 5, -5);	
			mmbg:SetBackdrop({
				edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border',
				edgeSize = 24,
			})
			mmbg:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b);
			
			GameTimeFrame:ClearAllPoints()
			GameTimeFrame:SetPoint("TOPRIGHT", Minimap, 20, 14)

			MiniMapTracking:ClearAllPoints()
			MiniMapTracking:SetPoint("TOPLEFT", Minimap, -30, 0)

			MiniMapLFGFrame:ClearAllPoints()
			MiniMapLFGFrame:SetPoint("LEFT", Minimap, -30, 0)

			MiniMapBattlefieldFrame:ClearAllPoints()
			MiniMapBattlefieldFrame:SetPoint("BOTTOMLEFT", Minimap, -30, 0)

			MiniMapVoiceChatFrame:ClearAllPoints()
			MiniMapVoiceChatFrame:SetPoint("BOTTOMLEFT", Minimap, 5, -32)

			MiniMapMailFrame:ClearAllPoints()
			MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, 0, -32)		

			TimeManagerClockButton:ClearAllPoints()
			TimeManagerClockButton:SetPoint("BOTTOM", Minimap, 0, -28)
			
		end

		-- 3.3 flag to move
		MiniMapInstanceDifficulty:ClearAllPoints()
		MiniMapInstanceDifficulty:SetPoint("BOTTOM", MinimapZoneTextButton, "BOTTOM", 0, -45)
	end
end