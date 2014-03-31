local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Minimap = BasicUI:NewModule("Minimap", "AceEvent-3.0")

function BasicUI_Minimap:OnEnable()
	local db = BasicUI.db.profile
	
	if db.minimap.enable ~= true then return end
	
	--[[

		All Credit for Minimap.lua goes to Neal and ballagarba.
		Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
		Edited by Cokedriver.

	]]

	if db.minimap.enable ~= true then return end


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
	if db.minimap.gameclock == true then
		TimeManagerClockButton:Show()
	else
		TimeManagerClockButton:Hide()
	end

	-- Bigger minimap
	if db.minimap.farm == true then

		MinimapCluster:SetScale(db.minimap.farmscale)
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

	Minimap:SetScript('OnEnter', function()
		if InCombatLockdown() then return end
		GameTooltip:SetOwner(Minimap, "ANCHOR_BOTTOM")
		GameTooltip:ClearLines()
		GameTooltip:AddLine("Minimap Options")
		GameTooltip:AddLine("|cffeda55fRight Click|r for Menu")
		GameTooltip:AddLine("|cffeda55fScroll|r for Zoom")
		GameTooltip:Show()
	end)
	Minimap:SetScript('OnLeave', function() GameTooltip:Hide() end)
	
	-- Coords on World Map
	if db.minimap.coords then
		local f = CreateFrame('Frame', nil, WorldMapFrame)
		f:SetParent(WorldMapButton)

		f.Player = f:CreateFontString(nil, 'OVERLAY')
		f.Player:SetFont(db.fontNormal, 26)
		f.Player:SetShadowOffset(1, -1)
		f.Player:SetJustifyH('LEFT')
		f.Player:SetPoint('BOTTOMLEFT', WorldMapButton, 7, 4)
		f.Player:SetTextColor(1, 0.82, 0)

		f.Cursor = f:CreateFontString(nil, 'OVERLAY')
		f.Cursor:SetFont(db.fontNormal, 26)
		f.Cursor:SetShadowOffset(1, -1)
		f.Cursor:SetJustifyH('LEFT')
		f.Cursor:SetPoint('BOTTOMLEFT', f.Player, 'TOPLEFT')
		f.Cursor:SetTextColor(1, 0.82, 0)

		f:SetScript('OnUpdate', function(self, elapsed)
			local width = WorldMapDetailFrame:GetWidth() 
			local height = WorldMapDetailFrame:GetHeight()
			local mx, my = WorldMapDetailFrame:GetCenter()
			local px, py = GetPlayerMapPosition('player')
			local cx, cy = GetCursorPosition()

			mx = ((cx / WorldMapDetailFrame:GetEffectiveScale()) - (mx - width / 2)) / width
			my = ((my + height / 2) - (cy / WorldMapDetailFrame:GetEffectiveScale())) / height

			if (mx >= 0 and my >= 0 and mx <= 1 and my <= 1) then
				f.Cursor:SetText(MOUSE_LABEL..format(': %.0f x %.0f', mx * 100, my * 100))
			else
				f.Cursor:SetText('')
			end

			if (px ~= 0 and py ~= 0) then
				f.Player:SetText(PLAYER..format(': %.0f x %.0f', px * 100, py * 100))
			else
				f.Player:SetText('')
			end
		end)
	end
end