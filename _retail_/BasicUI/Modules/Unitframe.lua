local MODULE_NAME = "Unitframe"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

local db

local defaults = {
	profile = {
		enable = true,
		UnitScale = 1.2,
		UnitframeFont = [[Interface\AddOns\BasicUI\Media\Expressway_Rg_BOLD.ttf]],
		
		castbars = {
			playerscale = 1.2,
			targetmove = true,
			targetscale = 1.5,
		},
	},
}

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function MODULE:OnEnable()


	--[[ Unit Font Style ]]--
	----------------------------------------------------------
	local shorts = {
		{ 1e10, 1e9, "%.0fB" }, --  10b+ as  12B
		{  1e9, 1e9, "%.1fB" }, --   1b+ as 8.3B
		{  1e7, 1e6, "%.0fM" }, --  10m+ as  14M
		{  1e6, 1e6, "%.1fM" }, --   1m+ as 7.4M
		{  1e5, 1e3, "%.0fK" }, -- 100k+ as 840K
		{  1e3, 1e3, "%.1fK" }, --   1k+ as 2.5K
		{    0,   1,    "%d" }, -- < 1k  as  974
	}
	for i = 1, #shorts do
		shorts[i][4] = shorts[i][3] .. " (%.0f%%)"
	end

	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(statusBar, textString, value, valueMin, valueMax)
		if value == 0 then
			return textString:SetText("")
		end

		local style = GetCVar("statusTextDisplay")
		if style == "PERCENT" then
			return textString:SetFormattedText("%.0f%%", value / valueMax * 100)
		end
		for i = 1, #shorts do
			local t = shorts[i]
			if value >= t[1] then
				if style == "BOTH" then
					return textString:SetFormattedText(t[4], value / t[2], value / valueMax * 100)
				else
					if value < valueMax then
						for j = 1, #shorts do
							local v = shorts[j]
							if valueMax >= v[1] then
								return textString:SetFormattedText(t[3] .. " / " .. v[3], value / t[2], valueMax / v[2])
							end
						end
					end
					return textString:SetFormattedText(t[3], value / t[2])
				end
			end
		end
	end)
	----------------------------------------------------------

	--[[ Unit Font Color ]]--
	----------------------------------------------------------

	hooksecurefunc("UnitFrame_Update", function(self, isParty)
		if not self.name or not self:IsShown() then return end

		local PET_COLOR = { r = 157/255, g = 197/255, b = 255/255 }
		local unit, color = self.unit
		if UnitPlayerControlled(unit) then
			if UnitIsPlayer(unit) then
				color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
			else
				color = PET_COLOR
			end
		elseif UnitIsDeadOrGhost(unit) then
			color = GRAY_FONT_COLOR
		else
			color = FACTION_BAR_COLORS[UnitIsEnemy(unit, "player") and 1 or UnitReaction(unit, "player") or 5]
		end

		if not color then
			color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)["PRIEST"]
		end

		self.name:SetTextColor(color.r, color.g, color.b)
		if isParty then
			self.name:SetText(GetUnitName(self.overrideName or unit))
		end
	end)
	----------------------------------------------------------


	--[[ Unit Name Background Color ]]--
	----------------------------------------------------------
	for _, region in pairs({
		TargetFrameNameBackground,
		FocusFrameNameBackground,
		Boss1TargetFrameNameBackground, 
		Boss2TargetFrameNameBackground, 
		Boss3TargetFrameNameBackground, 
		Boss4TargetFrameNameBackground,
		Boss5TargetFrameNameBackground, 
		
	}) do
		region:SetColorTexture(0, 0, 0, 0.5)
	end
	----------------------------------------------------------


	--[[ Unit Name Font Size ]]--
	----------------------------------------------------------
	for _, names in pairs({
		PlayerName,
		TargetFrameTextureFrameName,
		FocusFrameTextureFrameName,
	}) do
		names:SetFont(db.UnitframeFont, 16)

	end
	----------------------------------------------------------


	--[[ Unit Level Text Centering ]]--
	----------------------------------------------------------
	-- PlayerFrame
	hooksecurefunc("PlayerFrame_UpdateLevelTextAnchor", function(level)
	  if ( level >= 100 ) then
		PlayerLevelText:SetPoint("CENTER", PlayerFrameTexture, "CENTER", -61, -16);
	  else
		PlayerLevelText:SetPoint("CENTER", PlayerFrameTexture, "CENTER", -62, -16);
	  end
	end)

	-- TargetFrame
	hooksecurefunc("TargetFrame_UpdateLevelTextAnchor",  function(self, targetLevel)
	  if ( targetLevel >= 100 ) then
		self.levelText:SetPoint("CENTER", 62, -16);
	  else
		self.levelText:SetPoint("CENTER", 62, -16);
	  end
	end)



	--[[ Castbar Scaling ]]--
	----------------------------------------------------------
	-- Player Castbar

	CastingBarFrame:SetScale(db.castbars.playerscale)

	-- Target Castbar
	if db.castbars.targetmove == true then	
		hooksecurefunc("Target_Spellbar_AdjustPosition", function(self)
			if self == TargetFrameSpellBar then
				self:ClearAllPoints()
				self:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
			end
		end)
		TargetFrameSpellBar:SetScript("OnShow", Target_Spellbar_AdjustPosition)
		TargetFrameSpellBar:SetScale(db.castbars.targetscale)
	end
	----------------------------------------------------------


	--[[ Main Unit Frames Scaling ]]--
	----------------------------------------------------------
	for _, frames in pairs({
		PlayerFrame,
		TargetFrame,
		FocusFrame,
	}) do
		frames:SetScale(db.UnitScale)
	end
	----------------------------------------------------------


	--[[ Party Member Frame Scaling ]]--
	----------------------------------------------------------
	for i = 1, MAX_PARTY_MEMBERS do
		_G["PartyMemberFrame"..i]:SetScale(db.UnitScale)
	end
	----------------------------------------------------------


	--[[ Arena Frames Scaling ]]--
	----------------------------------------------------------
	--local function ScaleArenaFrames()
		--for i = 1, MAX_ARENA_ENEMIES do
			--_G["ArenaPrepFrame"..i]:SetScale(db.UnitScale)
			--_G["ArenaEnemyFrame"..i]:SetScale(db.UnitScale)
		--end
	--end

	--if IsAddOnLoaded("Blizzard_ArenaUI") then
		--ScaleArenaFrames()
	--else
		--local f = CreateFrame("Frame")
		--f:RegisterEvent("ADDON_LOADED")
		--f:SetScript("OnEvent", function(self, event, addon)
			--if addon == "Blizzard_ArenaUI" then
				--self:UnregisterEvent(event)
				--ScaleArenaFrames()
			--end
		--end)
	--end
	----------------------------------------------------------


	--[[ Boss Frames Scaling ]]--
	----------------------------------------------------------
	for i = 1, MAX_BOSS_FRAMES do
		_G["Boss"..i.."TargetFrame"]:SetScale(db.UnitScale)
	end
	----------------------------------------------------------
end

-- Leave this out if the module doesn't have any settings:
function MODULE:Refresh()
	db = self.db.profile -- update the upvalue

	-- change stuff here
end

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
				desc = L["Enables the Unitframe Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = false,				
			},
			UnitScale = {
				type = "range",
				order = 2,
				name = L["Player, Target, and Focus Frames Scale"],
				desc = L["Controls the scaling of Player, Target, and Focus Frames."],
				min = 0.5, max = 2, step = 0.05,
				disabled = function() return isModuleDisabled() or not db.enable end,																
			},
			castbars = {
				type = "group",
				order = 3,
				name = L["Castbar Frame"],
				desc = L["Castbar Frame Options."],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.castbars[ info[#info] ] end,
				set = function(info, value) db.castbars[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
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
					playerscale = {
						type = "range",
						order = 1,
						name = L["Scale the Player's Castbar"],
						desc = L["Controls the scaling of the Player's Castbar"],
						min = 0.5, max = 2, step = 0.05,
						disabled = function() return isModuleDisabled() or not db.enable end,																
					},
					targetmove = {
						type = "toggle",
						order = 2,
						name = L["Move Target Castbar"],
						desc = L["Moves the Target's Castbar to the middle of the screen."],
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					targetscale = {
						type = "range",
						order = 3,
						name = L["Scale the Target's Castbar"],
						desc = L["Controls the scaling of the target's Castbar"],
						min = 0.5, max = 2, step = 0.05,
						disabled = function() return isModuleDisabled() or not db.enable or not db.castbars.targetmove end,																
					},					
				},
			},
		},
	}
	return options
end