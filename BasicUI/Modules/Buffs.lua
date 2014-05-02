local MODULE_NAME = "Buffs"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Buffs = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		scale = 1.19,
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

function Buffs:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function Buffs:OnEnable()
	-- set up stuff here
	db = self.db.profile
	
	BuffFrame:ClearAllPoints()
	BuffFrame:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -25, 0)		
	BuffFrame:SetScale(db.scale)
	
	DAY_ONELETTER_ABBR = gsub(DAY_ONELETTER_ABBR, "%s", "")
	HOUR_ONELETTER_ABBR = gsub(HOUR_ONELETTER_ABBR, "%s", "")
	MINUTE_ONELETTER_ABBR = gsub(MINUTE_ONELETTER_ABBR, "%s", "")
	SECOND_ONELETTER_ABBR = gsub(SECOND_ONELETTER_ABBR, "%s", "")	
end

-- Leave this out if the module doesn't have any settings:
function Buffs:Refresh()
	db = self.db.profile -- update the upvalue

	-- change stuff here
	BuffFrame:SetScale(db.scale)
end

------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

-- Leave this out if the module doesn't have any options:
local options
function Buffs:GetOptions()

	if options then
		return options
	end

	local function isModuleDisabled()
		return not BasicUI:GetModuleEnabled(MODULE_NAME)
	end

	options = {
		type = "group",
		name = L[MODULE_NAME],
		desc = L["Buff Module for BasicUI."],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value end,
		disabled = isModuleDisabled(),		
		args = {
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				desc = L["Enables Buff Module."],
				width = "full",
				disabled = false,
			},
			scale = {
				type = "range",
				order = -1,
				name = L["Buff Scale"],
				--desc = L["Controls the scaling of the Buff Frames"],
				min = 0.05, max = 5, step = 0.05,
				disabled = function() return isModuleDisabled() or not db.enable end,
				set = function(info, value) 
					db[ info[#info] ] = value
					Buffs:Refresh()
				end,
			},
		}
	}
	return options
end