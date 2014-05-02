local MODULE_NAME = "Minimap"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MyMinimap = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		gameclock = true,
		farm = false,
		farmscale = 1.15,
		coords = true,		
	}
}

------------------------------------------------------------------------
--	Module Functions
------------------------------------------------------------------------

function MyMinimap:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end


function MyMinimap:OnEnable()
	--[[

		All Credit for Minimap.lua goes to Neal and ballagarba.
		Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
		Edited by Cokedriver.

	]]

	if db.enable ~= true then return end


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
	
	-- Modify Minimap Tracker:	
	MiniMapTracking:UnregisterAllEvents()
	MiniMapTracking:Hide()

	Minimap:SetScript('OnMouseDown', function(self, button)
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
	if db.coords then
		local coordsFrame = CreateFrame('Frame', nil, WorldMapFrame)
		coordsFrame:SetParent(WorldMapButton)

		coordsFrame.Player = coordsFrame:CreateFontString(nil, 'OVERLAY')
		coordsFrame.Player:SetFont(BasicUI.media.fontNormal, 26)
		coordsFrame.Player:SetShadowOffset(1, -1)
		coordsFrame.Player:SetJustifyH('LEFT')
		coordsFrame.Player:SetPoint('BOTTOMLEFT', WorldMapButton, 7, 4)
		coordsFrame.Player:SetTextColor(1, 0.82, 0)

		coordsFrame.Cursor = coordsFrame:CreateFontString(nil, 'OVERLAY')
		coordsFrame.Cursor:SetFont(BasicUI.media.fontNormal, 26)
		coordsFrame.Cursor:SetShadowOffset(1, -1)
		coordsFrame.Cursor:SetJustifyH('LEFT')
		coordsFrame.Cursor:SetPoint('BOTTOMLEFT', coordsFrame.Player, 'TOPLEFT')
		coordsFrame.Cursor:SetTextColor(1, 0.82, 0)

		coordsFrame:SetScript('OnUpdate', function(self, elapsed)
			local width = WorldMapDetailFrame:GetWidth() 
			local height = WorldMapDetailFrame:GetHeight()
			local mx, my = WorldMapDetailFrame:GetCenter()
			local px, py = GetPlayerMapPosition('player')
			local cx, cy = GetCursorPosition()

			mx = ((cx / WorldMapDetailFrame:GetEffectiveScale()) - (mx - width / 2)) / width
			my = ((my + height / 2) - (cy / WorldMapDetailFrame:GetEffectiveScale())) / height

			if (mx >= 0 and my >= 0 and mx <= 1 and my <= 1) then
				coordsFrame.Cursor:SetText(MOUSE_LABEL..format(': %.0f x %.0f', mx * 100, my * 100))
			else
				coordsFrame.Cursor:SetText('')
			end

			if (px ~= 0 and py ~= 0) then
				coordsFrame.Player:SetText(PLAYER..format(': %.0f x %.0f', px * 100, py * 100))
			else
				coordsFrame.Player:SetText('')
			end
		end)
	end
	
	self:Refresh()
end

function MyMinimap:Refresh()
	-- Hide Minimap Clock
	if db.gameclock == true then
		TimeManagerClockButton:Show()
	else
		TimeManagerClockButton:Hide()
	end

	-- Bigger minimap
	if db.farm == true then
		MinimapCluster:SetScale(db.farmscale)
		MinimapCluster:EnableMouse(false)
	else
		MinimapCluster:SetScale(1.1)
		MinimapCluster:EnableMouse(false)
	end
end

------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

local options
function MyMinimap:GetOptions()
	if options then
		return options
	end

	local function isModuleDisabled()
		return not BasicUI:GetModuleEnabled(MODULE_NAME)
	end
	
	options = {
		type = "group",
		name = L[MODULE_NAME],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value;   self:Refresh() end,
		args = {
			---------------------------
			--Option Type Seperators
			sep1 = {
				type = "description",
				order = 2,
				name = " ",
			},
			sep2 = {
				type = "description",
				order = 3,
				name = " ",
			},
			sep3 = {
				type = "description",
				order = 4,
				name = " ",
			},
			sep4 = {
				type = "description",
				order = 5,
				name = " ",
			},
			---------------------------
			reloadUI = {
				type = "execute",
				name = "Reload UI",
				desc = " ",
				order = 0,
				func = 	function()
					ReloadUI()
				end,
			},
			Text = {
				type = "description",
				order = 0,
				name = "When changes are made a reload of the UI is needed.",
				width = "full",
			},
			Text1 = {
				type = "description",
				order = 1,
				name = " ",
				width = "full",
			},
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable Minimap Module"],
				width = "full"
			},
			farm = {
				type = "toggle",
				order = 2,
				name = L["Farming"],
				desc = L["Enlarges the Minimap when Farming."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			farmscale = {
				type = "range",
				order = 5,
				name = L["Farming Map Scale"],
				desc = L["Controls the Size of the Farming Map"],
				disabled = function() return isModuleDisabled() or not db.enable end,
				min = 1, max = 5, step = 0.1,
			},
			gameclock = {
				type = "toggle",
				order = 2,
				name = L["Game Clock"],
				desc = L["Enable the Clock Frame on Minimap."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		},
	}
	return options
end