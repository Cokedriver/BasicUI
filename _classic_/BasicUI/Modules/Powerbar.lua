local MODULE_NAME = "Powerbar"
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
		position = {
			selfAnchor = "CENTER",
			frameParent = "UIParent",
			offSetX = 0,
			offSetY = -100
		},
		sizeWidth = 200,
		scale = 1.0,

		showCombatRegen = true,

		activeAlpha = 1,
		inactiveAlpha = 0.3,
		emptyAlpha = 0,

		valueAbbrev = true,

		valueFont = [[Fonts\FRIZQT__.ttf]],
		valueFontSize = 20,
		valueFontOutline = true,
		valueFontAdjustmentX = 0,

		showSoulshards = true,
		showHolypower = true,
		showComboPoints = true,
		showChi = true,
		showRunes = true,
		showArcaneCharges = true,
		showInsanity = true,
		showMaelstrom = true,
		showFury = true,
		showPain = true,
		showMana = true,
		showEnergy = true,
		showFocus = true,
		showRage = true,
		showLunarPower = true,
		
		-- Resource text shown above the bar.
		extraFont = [[Fonts\FRIZQT__.ttf]],
		extraFontSize = 22,
		extraFontOutline = true,

		hp = {
			show = false,
			hpFont = [[Fonts\FRIZQT__.ttf]],
			hpFontOutline = true,
			hpFontSize = 25,
			hpFontColor = {0.0, 1.0, 0.0},
			hpFontHeightAdjustment = 10,
		},
		rune = {
			show = true,
			runeFont = [[Fonts\FRIZQT__.ttf]],
			runeFontSize = 22,
			runeFontOutline = true,
		},
	}
}

------------------------------------------------------------------------
--	Module Functions
------------------------------------------------------------------------

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end


function MODULE:OnEnable()
	if db.enable ~= true then return end

	local format = string.format
	local floor = math.floor

	local function FormatValue(self)
		if (self >= 10000) then
			return ('%.1fk'):format(self / 1e3)
		else
			return self
		end
	end

	local function PowerRound(num, idp)
		local mult = 10^(idp or 0)
		return floor(num * mult + 0.5) / mult
	end

	local function PowerFade(frame, timeToFade, startAlpha, endAlpha)
		if (PowerRound(frame:GetAlpha(), 1) ~= endAlpha) then
			local mode = startAlpha > endAlpha and 'In' or 'Out'
			securecall('UIFrameFade'..mode, frame, timeToFade, startAlpha, endAlpha)
		end
	end

	local playerClass = select(2, UnitClass('player'))

	local PBFrame = CreateFrame('Frame', nil, UIParent)

	PBFrame:SetScale(db.scale)
	PBFrame:SetSize(18, 18)
	PBFrame:SetPoint(db.position.selfAnchor, db.position.frameParent, db.position.offSetX, db.position.offSetY)
	PBFrame:EnableMouse(false)

	PBFrame:RegisterEvent('PLAYER_REGEN_ENABLED')
	PBFrame:RegisterEvent('PLAYER_REGEN_DISABLED')
	PBFrame:RegisterEvent('PLAYER_ENTERING_WORLD')
	PBFrame:RegisterEvent('PLAYER_TARGET_CHANGED')
	PBFrame:RegisterUnitEvent('UNIT_DISPLAYPOWER', 'player')
	PBFrame:RegisterUnitEvent('UNIT_POWER_UPDATE', 'player')
	PBFrame:RegisterUnitEvent('UNIT_POWER_FREQUENT', 'player')
	PBFrame:RegisterEvent('UPDATE_SHAPESHIFT_FORM')

	if (db.showCombatRegen) then
		PBFrame:RegisterUnitEvent('UNIT_AURA', 'player')
	end

	if (db.hp.show) then
		PBFrame:RegisterUnitEvent('UNIT_HEALTH', 'player')
		PBFrame:RegisterUnitEvent('UNIT_MAX_HEALTH', 'player')
		PBFrame:RegisterUnitEvent('UNIT_HEALTH_FREQUENT', 'player')
	end

	--PBFrame:RegisterUnitEvent('UNIT_ENTERED_VEHICLE', 'player')
	--PBFrame:RegisterUnitEvent('UNIT_ENTERING_VEHICLE', 'player')
	--PBFrame:RegisterUnitEvent('UNIT_EXITED_VEHICLE', 'player')
	--PBFrame:RegisterUnitEvent('UNIT_EXITING_VEHICLE', 'player')

	if (playerClass == 'WARLOCK' and db.showSoulshards
		or playerClass == 'PALADIN' and db.showHolypower
		or playerClass == 'ROGUE' and db.showComboPoints
		or playerClass == 'DRUID' and db.showComboPoints
		or playerClass == 'MONK' and db.showChi
		or playerClass == 'MAGE' and db.showArcaneCharges) then

		PBFrame.extraPoints = PBFrame:CreateFontString(nil, 'ARTWORK')

		if (db.extraFontOutline) then
			PBFrame.extraPoints:SetFont(db.extraFont, db.extraFontSize, 'THINOUTLINE')
			PBFrame.extraPoints:SetShadowOffset(0, 0)
		else
			PBFrame.extraPoints:SetFont(db.extraFont, db.extraFontSize)
			PBFrame.extraPoints:SetShadowOffset(1, -1)
		end

		PBFrame.extraPoints:SetParent(PBFrame)
		PBFrame.extraPoints:SetPoint('CENTER', 0, 0)
	end

	if (playerClass == 'DEATHKNIGHT' and db.showRunes) then

		-- Hide the Runes on the Player Frame
		RuneFrame.Rune1:Hide()
		RuneFrame.Rune2:Hide()
		RuneFrame.Rune3:Hide()
		RuneFrame.Rune4:Hide()
		RuneFrame.Rune5:Hide()
		RuneFrame.Rune6:Hide()
		
		PBFrame.Rune = {}

		for i = 1, 6 do
			PBFrame.Rune[i] = PBFrame:CreateFontString(nil, 'ARTWORK')

			if (db.rune.runeFontOutline) then
				PBFrame.Rune[i]:SetFont(db.rune.runeFont, db.rune.runeFontSize, 'THINOUTLINE')
				PBFrame.Rune[i]:SetShadowOffset(0, 0)
			else
				PBFrame.Rune[i]:SetFont(db.rune.runeFont, db.rune.runeFontSize)
				PBFrame.Rune[i]:SetShadowOffset(1, -1)
			end

			PBFrame.Rune[i]:SetShadowOffset(0, 0)
			PBFrame.Rune[i]:SetParent(PBFrame)
		end

		PBFrame.Rune[1]:SetPoint('CENTER', -65, 0) 
		PBFrame.Rune[2]:SetPoint('CENTER', -39, 0) 
		PBFrame.Rune[3]:SetPoint('CENTER', 39, 0) 
		PBFrame.Rune[4]:SetPoint('CENTER', 65, 0) 
		PBFrame.Rune[5]:SetPoint('CENTER', -13, 0) 
		PBFrame.Rune[6]:SetPoint('CENTER', 13, 0) 
	end

	if (db.hp.show) then
		PBFrame.HPText = PBFrame:CreateFontString(nil, 'ARTWORK')
		if (db.hp.hpFontOutline) then
			PBFrame.HPText:SetFont(db.hp.hpFont, db.hp.hpFontSize, 'THINOUTLINE')
			PBFrame.HPText:SetShadowOffset(0, 0)
		else
			PBFrame.HPText:SetFont(db.hp.hpFont, db.hp.hpFontSize)
			PBFrame.HPText:SetShadowOffset(1, -1)
		end
		PBFrame.HPText:SetParent(PBFrame)
		if (PBFrame.extraPoints) then
			PBFrame.HPText:SetPoint('CENTER', 0, db.extraFontSize + db.hp.hpFontHeightAdjustment)
		else
			PBFrame.HPText:SetPoint('CENTER', 0, 0)
		end

	end

	PBFrame.Power = CreateFrame('StatusBar', nil, UIParent)
	PBFrame.Power:SetScale(PBFrame:GetScale())
	PBFrame.Power:SetSize(db.sizeWidth, 8)
	PBFrame.Power:SetPoint('CENTER', PBFrame, 0, -28)
	PBFrame.Power:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
	PBFrame.Power:SetAlpha(0)

	PBFrame.Power.Value = PBFrame.Power:CreateFontString(nil, 'ARTWORK')

	if (db.valueFontOutline) then
		PBFrame.Power.Value:SetFont(db.valueFont, db.valueFontSize, 'THINOUTLINE')
		PBFrame.Power.Value:SetShadowOffset(0, 0)
	else
		PBFrame.Power.Value:SetFont(db.valueFont, db.valueFontSize)
		PBFrame.Power.Value:SetShadowOffset(1, -1)
	end

	PBFrame.Power.Value:SetPoint('CENTER', PBFrame.Power, 0, db.valueFontAdjustmentX)
	PBFrame.Power.Value:SetVertexColor(1, 1, 1)

	PBFrame.Power.Background = PBFrame.Power:CreateTexture(nil, 'BACKGROUND')
	PBFrame.Power.Background:SetAllPoints(PBFrame.Power)
	PBFrame.Power.Background:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background]])
	PBFrame.Power.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

	PBFrame.Power.Below = PBFrame.Power:CreateTexture(nil, 'BACKGROUND')
	PBFrame.Power.Below:SetHeight(14)
	PBFrame.Power.Below:SetWidth(14)
	PBFrame.Power.Below:SetTexture([[Interface\AddOns\BasicUI\Media\textureArrowBelow]])

	PBFrame.Power.Above = PBFrame.Power:CreateTexture(nil, 'BACKGROUND')
	PBFrame.Power.Above:SetHeight(14)
	PBFrame.Power.Above:SetWidth(14)
	PBFrame.Power.Above:SetTexture([[Interface\AddOns\BasicUI\Media\textureArrowAbove]])
	PBFrame.Power.Above:SetPoint('BOTTOM', PBFrame.Power.Below, 'TOP', 0, PBFrame.Power:GetHeight())

	if (db.showCombatRegen) then
		PBFrame.mpreg = PBFrame.Power:CreateFontString(nil, 'ARTWORK')
		PBFrame.mpreg:SetFont(db.valueFont, 12, 'THINOUTLINE')
		PBFrame.mpreg:SetShadowOffset(0, 0)
		PBFrame.mpreg:SetPoint('TOP', PBFrame.Power.Below, 'BOTTOM', 0, 4)
		PBFrame.mpreg:SetParent(PBFrame.Power)
		PBFrame.mpreg:Show()
	end

	local function GetRealMpFive()
		local _, activeRegen = GetPowerRegen()
		local realRegen = activeRegen * 5
		local _, powerType = UnitPowerType('player')

		if (powerType == 'MANA') then
			return math.floor(realRegen)
		else
			return ''
		end
	end

	local function SetPowerColor()
		local powerType
		if ( playerClass == 'ROGUE' or playerClass == 'DRUID' ) then
			powerType = Enum.PowerType.ComboPoints
		elseif ( playerClass == 'MONK' ) then
			powerType = Enum.PowerType.Chi
		elseif ( playerClass == 'MAGE' ) then
			powerType = Enum.PowerType.ArcaneCharges
		elseif ( playerClass == 'PALADIN' ) then
			powerType = Enum.PowerType.HolyPower
		elseif ( playerClass == 'WARLOCK' ) then
			powerType = Enum.PowerType.SoulShards
		end

		local currentPower = UnitPower("player", powerType)
		local maxPower = UnitPowerMax("player", powerType)

		if ( UnitIsDeadOrGhost('target') ) then
			return 1, 1, 1
		elseif ( currentPower == maxPower-1 ) then
			return 0.9, 0.7, 0.0
		elseif ( currentPower == maxPower ) then
			return 1, 0, 0
		else
			return 1, 1, 1
		end
	end

	local function GetHPPercentage()
		local currentHP = UnitHealth('player')
		local maxHP = UnitHealthMax('player')
		return math.floor(100*currentHP/maxHP)
	end


	local function CalcRuneCooldown(self)
		local cooldown
		local start, duration, runeReady = GetRuneCooldown(self)
		if start then
			local time = floor(GetTime() - start)
			cooldown = ceil(duration - time)
		end     
		if (runeReady or UnitIsDeadOrGhost("player")) then
			return "#"
		elseif (not UnitIsDeadOrGhost("player") and cooldown) then
			return cooldown
		end
	end

	local function UpdateBarVisibility()
		local _, powerType = UnitPowerType('player')
		local newAlpha = nil

		if ((not db.showEnergy and powerType == 'ENERGY')
			or (not db.showFocus and powerType == 'FOCUS')
			or (not db.showRage and powerType == 'RAGE')
			or (not db.showMana and powerType == 'MANA')
			or (not db.rune.show and powerType == 'RUNEPOWER')
			or (not db.showFury and powerType == 'FURY')
			or (not db.showPain and powerType == 'PAIN')
			or (not db.showLunarPower and powerType == 'LUNAR_POWER')
			or (not db.showInsanity and powerType == 'INSANITY')
			or (not db.showMaelstrom and powerType == 'MAELSTROM')
			or UnitIsDeadOrGhost('player')) then
			PBFrame.Power:SetAlpha(0)
		elseif (InCombatLockdown()) then
			newAlpha = db.activeAlpha
		elseif (not InCombatLockdown() and UnitPower('player') > 0) then
			newAlpha = db.inactiveAlpha
		else
			newAlpha = db.emptyAlpha
		end

		if (newAlpha) then
			PowerFade(PBFrame.Power, 0.3, PBFrame.Power:GetAlpha(), newAlpha)
		end
	end

	local function UpdateArrow()
		if (UnitPower('player') == 0) then
			PBFrame.Power.Below:SetAlpha(0.3)
			PBFrame.Power.Above:SetAlpha(0.3)
		else
			PBFrame.Power.Below:SetAlpha(1)
			PBFrame.Power.Above:SetAlpha(1)
		end

		local newPosition = UnitPower('player') / UnitPowerMax('player') * PBFrame.Power:GetWidth()
		PBFrame.Power.Below:SetPoint('TOP', PBFrame.Power, 'BOTTOMLEFT', newPosition, 0)
	end

	local function UpdateBarValue()
		local min = UnitPower('player')
		PBFrame.Power:SetMinMaxValues(0, UnitPowerMax('player'))
		PBFrame.Power:SetValue(min)

		if (db.valueAbbrev) then
			PBFrame.Power.Value:SetText(min > 0 and FormatValue(min) or '')
		else
			PBFrame.Power.Value:SetText(min > 0 and min or '')
		end
	end

	local function UpdateBarColor()
		local powerType, powerToken, altR, altG, altB = UnitPowerType('player')
		local unitPower = PowerBarColor[powerToken]

		if (unitPower) then
			if ( powerType == 0 ) then
				PBFrame.Power:SetStatusBarColor(0,0.55,1)
			else
				PBFrame.Power:SetStatusBarColor(unitPower.r, unitPower.g, unitPower.b)
			end
		else
			PBFrame.Power:SetStatusBarColor(altR, altG, altB)
		end
	end

	local function UpdateBar()
		UpdateBarColor()
		UpdateBarValue()
		UpdateArrow()
	end

	PBFrame:SetScript('OnEvent', function(self, event, arg1)
		if (PBFrame.extraPoints) then
			local nump
			if (playerClass == 'WARLOCK') then
				nump = UnitPower('player', Enum.PowerType.SoulShards)-- WarlockUnitPower('player')
			elseif (playerClass == 'PALADIN') then
				nump = UnitPower('player', Enum.PowerType.HolyPower)
			elseif (playerClass == 'ROGUE' or playerClass == 'DRUID' ) then
				nump = UnitPower('player', Enum.PowerType.ComboPoints)
			elseif (playerClass == 'MONK' ) then
				nump = UnitPower('player', Enum.PowerType.Chi)
			elseif (playerClass == 'MAGE' ) then
				nump = UnitPower('player', Enum.PowerType.ArcaneCharges)
			end

			PBFrame.extraPoints:SetTextColor(SetPowerColor())
			PBFrame.extraPoints:SetText(nump == 0 and '' or nump)

			if (not PBFrame.extraPoints:IsShown()) then
				PBFrame.extraPoints:Show()
			end

			-- move the hp text if no points
			if (PBFrame.HPText) then
				if (nump == 0) then
					PBFrame.HPText:SetPoint('CENTER', 0, 0)
				else
					PBFrame.HPText:SetPoint('CENTER', 0, db.extraFontSize + db.hp.hpFontHeightAdjustment)
				end
			end
		end

		if (PBFrame.mpreg and (event == 'UNIT_AURA' or event == 'PLAYER_ENTERING_WORLD')) then
			PBFrame.mpreg:SetText(GetRealMpFive())
		end

		if (PBFrame.HPText) then
			if (UnitInVehicle('player')) then
				if (PBFrame.HPText:IsShown()) then
					PBFrame.HPText:Hide()
				end
			else
				PBFrame.HPText:SetTextColor(unpack(db.hp.hpFontColor))
				PBFrame.HPText:SetText(GetHPPercentage())

				if (not PBFrame.HPText:IsShown()) then
					PBFrame.HPText:Show()
				end
			end
		end

		UpdateBar()
		UpdateBarVisibility()

		if (event == 'PLAYER_ENTERING_WORLD') then
			if (InCombatLockdown()) then
				securecall('UIFrameFadeIn', f, 0.35, PBFrame:GetAlpha(), 1)
			else
				securecall('UIFrameFadeOut', f, 0.35, PBFrame:GetAlpha(), db.inactiveAlpha)
			end
		end

		if (event == 'PLAYER_REGEN_DISABLED') then
			securecall('UIFrameFadeIn', f, 0.35, PBFrame:GetAlpha(), 1)
		end

		if (event == 'PLAYER_REGEN_ENABLED') then
			securecall('UIFrameFadeOut', f, 0.35, PBFrame:GetAlpha(), db.inactiveAlpha)
		end
	end)

	if (PBFrame.Rune) then
		local updateTimer = 0
		PBFrame:SetScript('OnUpdate', function(self, elapsed)
			updateTimer = updateTimer + elapsed

			if (updateTimer > 0.1) then
				for i = 1, 6 do
					if (UnitInVehicle('player')) then
						if (PBFrame.Rune[i]:IsShown()) then
							PBFrame.Rune[i]:Hide()
						end
					else
						if (not PBFrame.Rune[i]:IsShown()) then
							PBFrame.Rune[i]:Show()
						end
					end

					PBFrame.Rune[i]:SetText(CalcRuneCooldown(i))
					PBFrame.Rune[i]:SetTextColor(0.0, 0.6, 0.8)
				end

				updateTimer = 0
			end
		end)
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

	local regions = {
		['BOTTOM'] = L['Bottom'],
		['BOTTOMLEFT'] = L['Bottom Left'],
		['BOTTOMRIGHT'] = L['Bottom Right'],
		['CENTER'] = L['Center'],
		['LEFT'] = L['Left'],
		['RIGHT'] = L['Right'],
		['TOP'] = L['Top'],
		['TOPLEFT'] = L['Top Left'],
		['TOPRIGHT'] = L['Top Right'],
	}
	
	options = {
		type = "group",
		name = L[MODULE_NAME],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
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
				desc = L["Enables the Powerbar Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = false,
			},					
			showCombatRegen = {
				order = 2,
				name = L["Show Combat Regen"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},				
			showSoulshards = {
				order = 2,
				name = L["Show Soulshards Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showHolypower = {
				order = 2,
				name = L["Show Holypower Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showMana = {
				order = 2,
				name = L["Show Mana Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showFocus = {
				order = 2,
				name = L["Show Focus Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showRage = {
				order = 2,
				name = L["Show Rage Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showEnergy = {
				order = 2,
				name = L["Show Energy Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showLunarPower = {
				order = 2,
				name = L["Show Lunar Power Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showInsanity = {
				order = 2,
				name = L["Show Insanity Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showMaelstrom = {
				order = 2,
				name = L["Show Maelstorm Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showFury = {
				order = 2,
				name = L["Show Fury Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showPain = {
				order = 2,
				name = L["Show Pain Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showChi = {
				order = 2,
				name = L["Show Chi Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showRunes = {
				order = 2,
				name = L["Show Rune Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showArcaneCharges = {
				order = 2,
				name = L["Show Arcane Charges Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			valueAbbrev = {
				order = 2,
				name = L["Value Abbrev"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			valueFontOutline = {
				order = 2,
				name = L["Value Font Outline"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},					
			sizeWidth= {
				order = 5,
				name = L["Size Width"],
				type = "range",
				min = 50, max = 350, step = 25,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},					
			activeAlpha = {
				order = 5,
				name = L["Active Alpha"],
				type = "range",
				min = 0, max = 1, step = 0.1,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			inactiveAlpha = {
				order = 5,
				name = L["In Active Alpha"],
				type = "range",
				min = 0, max = 1, step = 0.1,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			emptyAlpha = {
				order = 5,
				name = L["Empty Alpha"],
				type = "range",
				min = 0, max = 1, step = 0.1,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},										
			valueFontSize = {
				order = 5,
				name = L["Value Font Size"],
				type = "range",
				min = 8, max = 30, step = 1,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},	
			valueFontAdjustmentX = {
				order = 5,
				name = L["Value Font Adjustment X"],
				type = "range",
				min = -200, max = 200, step = 1,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			position = {
				type = "group",
				order = 6,
				guiInline = true,
				name = L["Position the Powerbar"],
				guiInline = true,
				disabled = function() return isModuleDisabled() or not db.enable end,						
				get = function(info) return db.position[ info[#info] ] end,
				set = function(info, value) db.position[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
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
					---------------------------							
					selfAnchor = {
						order = 1,
						name = L["Self Anchor"],
						disabled = function() return isModuleDisabled() or not db.enable end,
						type = "select",
						values = regions;
					},
					offSetX = {
						type = "range",							
						order = 2,
						name = L["X Offset"],
						desc = L["Controls the X offset. (Left - Right)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					offSetY = {
						type = "range",							
						order = 2,
						name = L["Y Offset"],
						desc = L["Controls the Y offset. (Up - Down)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
				},
			},					
			rune = {
				type = "group",
				order = 5,
				guiInline = true,
				name = L["Rune"],	
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.rune[ info[#info] ] end,
				set = function(info, value) db.rune[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
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
					show = {
						order = 1,
						name = L["Show Rune Text"],
						type = "toggle",
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},					
					showRuneCooldown = {
						order = 2,
						name = L["Show Rune Cooldown"],
						type = "toggle",
						disabled = function() return isModuleDisabled() or not db.enable or not db.rune.show end,
					},							
					runeFontOutline = {
						order = 2,
						name = L["Rune Font Outline"],
						type = "toggle",
						disabled = function() return isModuleDisabled() or not db.enable or not db.rune.show end,
					},
					runeFontSize= {
						order = 5,
						name = L["Rune Font Size"],
						type = "range",
						min = 8, max = 25, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.rune.show end,
					},						
				},
			},					
		},
	}
	return options
end