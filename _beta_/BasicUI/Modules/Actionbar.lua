local MODULE_NAME = "Actionbar"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
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

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function MODULE:OnEnable()
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEnable")
	end
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")

	local function UpdateRange(self, hasrange, inrange)
		local Icon = self.icon
		local NormalTexture = self.NormalTexture
		local ID = self.action
		
		if not ID then
			return
		end
		
		local IsUsable, NotEnoughMana = IsUsableAction(ID)
		local HasRange = hasrange
		local InRange = inrange

		if IsUsable then
			if (HasRange and InRange == false) then
				Icon:SetVertexColor(0.8, 0.1, 0.1)
				
				NormalTexture:SetVertexColor(0.8, 0.1, 0.1)
			else
				Icon:SetVertexColor(1.0, 1.0, 1.0)
				
				NormalTexture:SetVertexColor(1.0, 1.0, 1.0)
			end
		elseif NotEnoughMana then
			Icon:SetVertexColor(0.1, 0.3, 1.0)
			
			NormalTexture:SetVertexColor(0.1, 0.3, 1.0)
		else
			Icon:SetVertexColor(0.3, 0.3, 0.3)
			
			NormalTexture:SetVertexColor(0.3, 0.3, 0.3)
		end
	end

	do
		hooksecurefunc( "ActionButton_UpdateRangeIndicator", UpdateRange );
	end
	
	self:Refresh()
end

function MODULE:Refresh()

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
function MODULE:GetOptions()

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
		set = function(info, value) db[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
		disabled = isModuleDisabled(),
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
			Text1 = {
				type = "description",
				order = 1,
				name = " ",
				width = "full",
			},			
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				desc = L["Enables the Actionbar Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = false,
			},			
			showHotKeys = {
				type = "toggle",
				order = 2,
				name = L["Show Hot Keys"],
				desc = L["Show key bindings on action buttons."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showMacronames = {
				type = "toggle",
				order = 2,
				name = L["Show Macro Names"],
				desc = L["Show macro names on action buttons."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		}
	}
	return options
end