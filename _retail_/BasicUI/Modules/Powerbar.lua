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

	local BPF = CreateFrame('Frame', nil, UIParent, BackdropTemplateMixin and "BackdropTemplate") -- BPF = Basic Powerbar Frame

	BPF:SetScale(db.scale)
	BPF:SetSize(18, 18)
	BPF:SetPoint(db.position.selfAnchor, db.position.frameParent, db.position.offSetX, db.position.offSetY)
	BPF:EnableMouse(false)

	BPF:RegisterEvent('PLAYER_REGEN_ENABLED')
	BPF:RegisterEvent('PLAYER_REGEN_DISABLED')
	BPF:RegisterEvent('PLAYER_ENTERING_WORLD')
	BPF:RegisterEvent('PLAYER_TARGET_CHANGED')
	BPF:RegisterUnitEvent('UNIT_DISPLAYPOWER', 'player')
	BPF:RegisterUnitEvent('UNIT_POWER_UPDATE', 'player')
	BPF:RegisterUnitEvent('UNIT_POWER_FREQUENT', 'player')
	BPF:RegisterEvent('UPDATE_SHAPESHIFT_FORM')

	if (db.showCombatRegen) then
		BPF:RegisterUnitEvent('UNIT_AURA', 'player')
	end

	if (db.hp.show) then
		BPF:RegisterUnitEvent('UNIT_HEALTH', 'player')
		BPF:RegisterUnitEvent('UNIT_MAX_HEALTH', 'player')
	end

	BPF:RegisterUnitEvent('UNIT_ENTERED_VEHICLE', 'player')
	BPF:RegisterUnitEvent('UNIT_ENTERING_VEHICLE', 'player')
	BPF:RegisterUnitEvent('UNIT_EXITED_VEHICLE', 'player')
	BPF:RegisterUnitEvent('UNIT_EXITING_VEHICLE', 'player')

	if (playerClass == 'WARLOCK' and db.showSoulshards
		or playerClass == 'PALADIN' and db.showHolypower
		or playerClass == 'ROGUE' and db.showComboPoints
		or playerClass == 'DRUID' and db.showComboPoints
		or playerClass == 'MONK' and db.showChi
		or playerClass == 'MAGE' and db.showArcaneCharges) then

		BPF.extraPoints = BPF:CreateFontString(nil, 'ARTWORK')

		if (db.extraFontOutline) then
			BPF.extraPoints:SetFont(db.extraFont, db.extraFontSize, 'THINOUTLINE')
			BPF.extraPoints:SetShadowOffset(0, 0)
		else
			BPF.extraPoints:SetFont(db.extraFont, db.extraFontSize)
			BPF.extraPoints:SetShadowOffset(1, -1)
		end

		BPF.extraPoints:SetParent(BPF)
		BPF.extraPoints:SetPoint('CENTER', 0, 0)
	end

	if (playerClass == 'DEATHKNIGHT' and db.showRunes) then

		-- Hide the Runes on the Player Frame
		RuneFrame.Rune1:Hide()
		RuneFrame.Rune2:Hide()
		RuneFrame.Rune3:Hide()
		RuneFrame.Rune4:Hide()
		RuneFrame.Rune5:Hide()
		RuneFrame.Rune6:Hide()
		
		BPF.Rune = {}

		for i = 1, 6 do
			BPF.Rune[i] = BPF:CreateFontString(nil, 'ARTWORK')

			if (db.rune.runeFontOutline) then
				BPF.Rune[i]:SetFont(db.rune.runeFont, db.rune.runeFontSize, 'THINOUTLINE')
				BPF.Rune[i]:SetShadowOffset(0, 0)
			else
				BPF.Rune[i]:SetFont(db.rune.runeFont, db.rune.runeFontSize)
				BPF.Rune[i]:SetShadowOffset(1, -1)
			end

			BPF.Rune[i]:SetShadowOffset(0, 0)
			BPF.Rune[i]:SetParent(BPF)
		end

		BPF.Rune[1]:SetPoint('CENTER', -65, 0) 
		BPF.Rune[2]:SetPoint('CENTER', -39, 0) 
		BPF.Rune[3]:SetPoint('CENTER', 39, 0) 
		BPF.Rune[4]:SetPoint('CENTER', 65, 0) 
		BPF.Rune[5]:SetPoint('CENTER', -13, 0) 
		BPF.Rune[6]:SetPoint('CENTER', 13, 0) 
	end

	if (db.hp.show) then
		BPF.HPText = BPF:CreateFontString(nil, 'ARTWORK')
		if (db.hp.hpFontOutline) then
			BPF.HPText:SetFont(db.hp.hpFont, db.hp.hpFontSize, 'THINOUTLINE')
			BPF.HPText:SetShadowOffset(0, 0)
		else
			BPF.HPText:SetFont(db.hp.hpFont, db.hp.hpFontSize)
			BPF.HPText:SetShadowOffset(1, -1)
		end
		BPF.HPText:SetParent(BPF)
		if (BPF.extraPoints) then
			BPF.HPText:SetPoint('CENTER', 0, db.extraFontSize + db.hp.hpFontHeightAdjustment)
		else
			BPF.HPText:SetPoint('CENTER', 0, 0)
		end

	end

	BPF.Power = CreateFrame('StatusBar', nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
	BPF.Power:SetScale(BPF:GetScale())
	BPF.Power:SetSize(db.sizeWidth, 8)
	BPF.Power:SetPoint('CENTER', BPF, 0, -28)
	BPF.Power:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
	BPF.Power:SetAlpha(0)

	BPF.Power.Value = BPF.Power:CreateFontString(nil, 'ARTWORK')

	if (db.valueFontOutline) then
		BPF.Power.Value:SetFont(db.valueFont, db.valueFontSize, 'THINOUTLINE')
		BPF.Power.Value:SetShadowOffset(0, 0)
	else
		BPF.Power.Value:SetFont(db.valueFont, db.valueFontSize)
		BPF.Power.Value:SetShadowOffset(1, -1)
	end

	BPF.Power.Value:SetPoint('CENTER', BPF.Power, 0, db.valueFontAdjustmentX)
	BPF.Power.Value:SetVertexColor(1, 1, 1)

	BPF.Power.Background = BPF.Power:CreateTexture(nil, 'BACKGROUND')
	BPF.Power.Background:SetAllPoints(BPF.Power)
	BPF.Power.Background:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background]])
	BPF.Power.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

	BPF.Power.Below = BPF.Power:CreateTexture(nil, 'BACKGROUND')
	BPF.Power.Below:SetHeight(14)
	BPF.Power.Below:SetWidth(14)
	BPF.Power.Below:SetTexture([[Interface\AddOns\BasicUI\Media\textureArrowBelow]])

	BPF.Power.Above = BPF.Power:CreateTexture(nil, 'BACKGROUND')
	BPF.Power.Above:SetHeight(14)
	BPF.Power.Above:SetWidth(14)
	BPF.Power.Above:SetTexture([[Interface\AddOns\BasicUI\Media\textureArrowAbove]])
	BPF.Power.Above:SetPoint('BOTTOM', BPF.Power.Below, 'TOP', 0, BPF.Power:GetHeight())

	if (db.showCombatRegen) then
		BPF.mpreg = BPF.Power:CreateFontString(nil, 'ARTWORK')
		BPF.mpreg:SetFont(db.valueFont, 12, 'THINOUTLINE')
		BPF.mpreg:SetShadowOffset(0, 0)
		BPF.mpreg:SetPoint('TOP', BPF.Power.Below, 'BOTTOM', 0, 4)
		BPF.mpreg:SetParent(BPF.Power)
		BPF.mpreg:Show()
	end

	local function GetRealMpFive()
		local _, activeRegen = GetPowerRegen()
		local realRegen = activeRegen * 5
		local _, powerType = UnitPowerType('player')

		if (powerType == 'MANA' or UnitHasVehicleUI('player')) then
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

	local function CalcRuneCooldown(num)
		local start, duration, runeReady = GetRuneCooldown(num)

		-- Sometimes GetRuneCooldown returns nil for some reason.
		if not start then
			return
		end

		local time = floor(GetTime() - start)
		local cooldown = ceil(duration - time)

		if runeReady or UnitIsDeadOrGhost("player") then
			return "#"
		elseif not UnitIsDeadOrGhost("player") and cooldown then
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
			or UnitIsDeadOrGhost('player') or UnitHasVehicleUI('player')) then
			BPF.Power:SetAlpha(0)
		elseif (InCombatLockdown()) then
			newAlpha = db.activeAlpha
		elseif (not InCombatLockdown() and UnitPower('player') > 0) then
			newAlpha = db.inactiveAlpha
		else
			newAlpha = db.emptyAlpha
		end

		if (newAlpha) then
			PowerFade(BPF.Power, 0.3, BPF.Power:GetAlpha(), newAlpha)
		end
	end

	local function UpdateArrow()
		if (UnitPower('player') == 0) then
			BPF.Power.Below:SetAlpha(0.3)
			BPF.Power.Above:SetAlpha(0.3)
		else
			BPF.Power.Below:SetAlpha(1)
			BPF.Power.Above:SetAlpha(1)
		end

		local newPosition = UnitPower('player') / UnitPowerMax('player') * BPF.Power:GetWidth()
		BPF.Power.Below:SetPoint('TOP', BPF.Power, 'BOTTOMLEFT', newPosition, 0)
	end

	local function UpdateBarValue()
		local min = UnitPower('player')
		BPF.Power:SetMinMaxValues(0, UnitPowerMax('player'))
		BPF.Power:SetValue(min)

		if (db.valueAbbrev) then
			BPF.Power.Value:SetText(min > 0 and FormatValue(min) or '')
		else
			BPF.Power.Value:SetText(min > 0 and min or '')
		end
	end

	local function UpdateBarColor()
		local powerType, powerToken, altR, altG, altB = UnitPowerType('player')
		local unitPower = PowerBarColor[powerToken]

		if (unitPower) then
			if ( powerType == 0 ) then
				BPF.Power:SetStatusBarColor(0,0.55,1)
			else
				BPF.Power:SetStatusBarColor(unitPower.r, unitPower.g, unitPower.b)
			end
		else
			BPF.Power:SetStatusBarColor(altR, altG, altB)
		end
	end

	local function UpdateBar()
		UpdateBarColor()
		UpdateBarValue()
		UpdateArrow()
	end

	BPF:SetScript('OnEvent', function(self, event, arg1)
		if (BPF.extraPoints) then
			if (UnitHasVehicleUI('player')) then
				if (BPF.extraPoints:IsShown()) then
					BPF.extraPoints:Hide()
				end
			else
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

				BPF.extraPoints:SetTextColor(SetPowerColor())
				BPF.extraPoints:SetText(nump == 0 and '' or nump)

				if (not BPF.extraPoints:IsShown()) then
					BPF.extraPoints:Show()
				end

				-- move the hp text if no points
				if (BPF.HPText) then
					if (nump == 0) then
						BPF.HPText:SetPoint('CENTER', 0, 0)
					else
						BPF.HPText:SetPoint('CENTER', 0, db.extraFontSize + db.hp.hpFontHeightAdjustment)
					end
				end
			end
		end

		if (BPF.mpreg and (event == 'UNIT_AURA' or event == 'PLAYER_ENTERING_WORLD')) then
			BPF.mpreg:SetText(GetRealMpFive())
		end

		if (BPF.HPText) then
			if (UnitHasVehicleUI('player')) then
				if (BPF.HPText:IsShown()) then
					BPF.HPText:Hide()
				end
			else
				BPF.HPText:SetTextColor(unpack(db.hp.hpFontColor))
				BPF.HPText:SetText(GetHPPercentage())

				if (not BPF.HPText:IsShown()) then
					BPF.HPText:Show()
				end
			end
		end

		UpdateBar()
		UpdateBarVisibility()

		if (event == 'PLAYER_ENTERING_WORLD') then
			if (InCombatLockdown()) then
				securecall('UIFrameFadeIn', f, 0.35, BPF:GetAlpha(), 1)
			else
				securecall('UIFrameFadeOut', f, 0.35, BPF:GetAlpha(), db.inactiveAlpha)
			end
		end

		if (event == 'PLAYER_REGEN_DISABLED') then
			securecall('UIFrameFadeIn', f, 0.35, BPF:GetAlpha(), 1)
		end

		if (event == 'PLAYER_REGEN_ENABLED') then
			securecall('UIFrameFadeOut', f, 0.35, BPF:GetAlpha(), db.inactiveAlpha)
		end
	end)

	if (BPF.Rune) then
		local updateTimer = 0
		BPF:SetScript('OnUpdate', function(self, elapsed)
			updateTimer = updateTimer + elapsed

			if (updateTimer > 0.1) then
				for i = 1, 6 do
					if (UnitHasVehicleUI('player')) then
						if (BPF.Rune[i]:IsShown()) then
							BPF.Rune[i]:Hide()
						end
					else
						if (not BPF.Rune[i]:IsShown()) then
							BPF.Rune[i]:Show()
						end
					end

					BPF.Rune[i]:SetText(CalcRuneCooldown(i))
					BPF.Rune[i]:SetTextColor(0.0, 0.6, 0.8)
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