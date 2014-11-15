local MODULE_NAME = "Actionbar"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Actionbars = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable 			= true,		
		showHotKeys 	= false,	 -- Set the Alpha
		showMacronames 	= false,	 -- Set the Alpha
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

local classColor

function Actionbars:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function Actionbars:OnEnable()
	
	local hotkeyAlpha = db.showHotKeys and 1 or 0
	for i = 1, 12 do
		_G["ActionButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- main bar
		_G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- bottom right bar
		_G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- bottom left bar
		_G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- right bar
		_G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- left bar
	end

	local macroAlpha = db.showMacronames and 1 or 0
	for i = 1, 12 do
		_G["ActionButton"..i.."Name"]:SetAlpha(macroAlpha) -- main bar
		_G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(macroAlpha) -- bottom right bar
		_G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(macroAlpha) -- bottom left bar
		_G["MultiBarRightButton"..i.."Name"]:SetAlpha(macroAlpha) -- right bar
		_G["MultiBarLeftButton"..i.."Name"]:SetAlpha(macroAlpha) -- left bar
	end
end



------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

local options
function Actionbars:GetOptions()

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
		set = function(info, value) db[ info[#info] ] = value end,
		disabled = isModuleDisabled(),
		args = {
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
				name = L["Enable Actionbar Module"],
				width = "full",
				disabled = false,
			},
			Text2 = {
				type = "description",
				name = " ",
				width = "full",
			},
			showHotKeys = {
				type = "toggle",
				name = L["Show Hot Keys"],
				desc = L["Show key bindings on action buttons."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showMacronames = {
				type = "toggle",
				name = L["Show Macro Names"],
				desc = L["Show macro names on action buttons."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		},
	},
	return options
end