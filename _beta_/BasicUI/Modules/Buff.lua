local MODULE_NAME = "Buff"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		scale = 1.193,
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function MODULE:OnEnable()
	-- set up stuff here
	db = self.db.profile
	
	BuffFrame:SetScale(db.scale)

	local origSecondsToTimeAbbrev = _G.SecondsToTimeAbbrev
	local function SecondsToTimeAbbrevHook(seconds)

		if (seconds >= 86400) then
			return '%dd', ceil(seconds / 86400)
		end

		if (seconds >= 3600) then
			return '%dh', ceil(seconds / 3600)
		end

		if (seconds >= 60) then
			return '%dm', ceil(seconds / 60)
		end

		return '%d', seconds
	end
	SecondsToTimeAbbrev = SecondsToTimeAbbrevHook


	hooksecurefunc('AuraButton_Update', function(buttonName, index)
		local font = 'Fonts\\ARIALN.ttf'
		local button = _G[buttonName..index]
		local duration = _G[buttonName..index..'Duration']
		if (duration) then
			duration:ClearAllPoints()
			duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -2)
			if button.symbol then
				duration:SetFont(font, 12, 'THINOUTLINE')
			else
				duration:SetFont(font, 12, 'THINOUTLINE')
			end
			duration:SetShadowOffset(0, 0)
			duration:SetDrawLayer('OVERLAY')
		end

		local count = _G[buttonName..index..'Count']
		if (count) then
			count:ClearAllPoints()
			count:SetPoint('TOPRIGHT', button)
			if button.symbol then
				count:SetFont(font, 12, 'THINOUTLINE')
			else
				count:SetFont(font, 12, 'THINOUTLINE')
			end
			count:SetShadowOffset(0, 0)
			count:SetDrawLayer('OVERLAY')	
		end
	end)
end

-- Leave this out if the module doesn't have any settings:
function MODULE:Refresh()
	db = self.db.profile -- update the upvalue

	-- change stuff here
	BuffFrame:SetScale(db.scale)
end

------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

-- Leave this out if the module doesn't have any options:
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
		desc = L["Buff Module for BasicUI."],
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
				desc = L["Enables the Buff Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = false,
			},
			scale = {
				type = "range",
				order = 2,
				name = L["Buff Scale"],
				desc = L["Controls the scaling of the Buff Frames"],
				min = 0.05, max = 5, step = 0.05,
				set = function(info, value) 
					db[ info[#info] ] = value
					MODULE:Refresh()
				end,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		}
	}
	return options
end