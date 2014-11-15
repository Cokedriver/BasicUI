local MODULE_NAME = "Powerbar"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Powerbar = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
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
		
		showCombatRegen = true, 

		activeAlpha = 1,
		inactiveAlpha = 0.5,
		emptyAlpha = 0,
		
		valueAbbrev = true,
			
		valueFontSize = 20,
		valueFontOutline = true,
		valueFontAdjustmentX = 0,

		showSoulshards = true,
		showHolypower = true,
		showMana = true,
		showFocus = true,
		showRage = true,
		
		extraFontSize = 16,                             -- The fontsize for the holypower and soulshard number
		extraFontOutline = true,                        
			
		
		energy = {
			show = true,
			showComboPoints = true,
			comboPointsBelow = false,
			
			comboFontSize = 16,
			comboFontOutline = true,
		},
		
		
		rune = {
			show = true,
			showRuneCooldown = true,
		   
			runeFontSize = 16,
			runeFontOutline = true,
		},
	}
}

------------------------------------------------------------------------
--	Module Functions
------------------------------------------------------------------------

function Powerbar:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end


function Powerbar:OnEnable()
	if db.enable ~= true then return end

	local playerClass = select(2, UnitClass('player'))

	local format = string.format
	local floor = math.floor

	function FormatValue(self)
		if (self >= 10000) then
			return ('%.1fk'):format(self / 1e3)
		else
			return self
		end
	end

	function Round(num, idp)
		local mult = 10^(idp or 0)
		return floor(num * mult + 0.5) / mult
	end

	function Fade(frame, timeToFade, startAlpha, endAlpha)
		if (Round(frame:GetAlpha(), 1) ~= endAlpha) then
			local mode = startAlpha > endAlpha and 'In' or 'Out'
			securecall('UIFrameFade'..mode, frame, timeToFade, startAlpha, endAlpha)
		end
	end

	local ComboColor = {
		[1] = {r = 1.0, g = 1.0, b = 1.0},
		[2] = {r = 1.0, g = 1.0, b = 1.0},
		[3] = {r = 1.0, g = 1.0, b = 1.0},
		[4] = {r = 0.9, g = 0.7, b = 0.0},
		[5] = {r = 1.0, g = 0.0, b = 0.0},
	}
	local RuneColor = {
		[1] = {r = 0.7, g = 0.1, b = 0.1},
		[2] = {r = 0.7, g = 0.1, b = 0.1},
		[3] = {r = 0.4, g = 0.8, b = 0.2},
		[4] = {r = 0.4, g = 0.8, b = 0.2},
		[5] = {r = 0.0, g = 0.6, b = 0.8},
		[6] = {r = 0.0, g = 0.6, b = 0.8},
	}

	local f = CreateFrame('Frame', nil, UIParent)
	f:SetScale(1.4)
	f:SetSize(18, 18)
	f:SetPoint(db.position.selfAnchor, db.position.frameParent, db.position.offSetX, db.position.offSetY)
	f:EnableMouse(false)

	f:RegisterEvent('PLAYER_REGEN_ENABLED')
	f:RegisterEvent('PLAYER_REGEN_DISABLED')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:RegisterUnitEvent('UNIT_COMBO_POINTS', 'player')
	f:RegisterEvent('PLAYER_TARGET_CHANGED')

	if (db.rune.showRuneCooldown) then
		f:RegisterEvent('RUNE_TYPE_UPDATE')
	end

	f:RegisterUnitEvent('UNIT_DISPLAYPOWER', 'player')
	f:RegisterUnitEvent('UNIT_POWER_FREQUENT', 'player')
	f:RegisterEvent('UPDATE_SHAPESHIFT_FORM')

	if (db.showCombatRegen) then
		f:RegisterUnitEvent('UNIT_AURA', 'player')
	end

	f:RegisterUnitEvent('UNIT_ENTERED_VEHICLE', 'player')
	f:RegisterUnitEvent('UNIT_ENTERING_VEHICLE', 'player')
	f:RegisterUnitEvent('UNIT_EXITED_VEHICLE', 'player')
	f:RegisterUnitEvent('UNIT_EXITING_VEHICLE', 'player')

	if (db.energy.showComboPoints) then
		f.ComboPoints = {}

		for i = 1, 5 do
			f.ComboPoints[i] = f:CreateFontString(nil, 'ARTWORK')

			if (db.energy.comboFontOutline) then
				f.ComboPoints[i]:SetFont(BasicUI.media.fontBold, db.energy.comboFontSize, 'THINOUTLINE')
				f.ComboPoints[i]:SetShadowOffset(0, 0)
			else
				f.ComboPoints[i]:SetFont(BasicUI.media.fontBold, db.energy.comboFontSize)
				f.ComboPoints[i]:SetShadowOffset(1, -1)
			end

			f.ComboPoints[i]:SetParent(f)
			f.ComboPoints[i]:SetText(i)
			f.ComboPoints[i]:SetAlpha(0)
		end

		local yOffset = db.energy.comboPointsBelow and -35 or 0
		f.ComboPoints[1]:SetPoint('CENTER', -52, yOffset)
		f.ComboPoints[2]:SetPoint('CENTER', -26, yOffset)
		f.ComboPoints[3]:SetPoint('CENTER', 0, yOffset)
		f.ComboPoints[4]:SetPoint('CENTER', 26, yOffset)
		f.ComboPoints[5]:SetPoint('CENTER', 52, yOffset)
	end

	if (playerClass == 'MONK') then
		f.Chi = {}
		f.Chi.maxChi = 4

		for i = 1, 5 do
			f.Chi[i] = f:CreateFontString(nil, 'ARTWORK')

			f.Chi[i]:SetFont(BasicUI.media.fontBold, db.energy.comboFontSize, 'THINOUTLINE')
			f.Chi[i]:SetShadowOffset(0, 0)

			f.Chi[i]:SetParent(f)
			f.Chi[i]:SetText(i)
			f.Chi[i]:SetAlpha(0)
		end

		local yOffset = db.energy.comboPointsBelow and -35 or 0
		f.Chi[1]:SetPoint('CENTER', -39, yOffset)
		f.Chi[2]:SetPoint('CENTER', -13, yOffset)
		f.Chi[3]:SetPoint('CENTER', 13, yOffset)
		f.Chi[4]:SetPoint('CENTER', 39, yOffset)
		f.Chi[5]:SetPoint('CENTER', 52, yOffset)
		f.Chi[5]:Hide()
	end

	if (playerClass == 'WARLOCK' and db.showSoulshards or playerClass == 'PALADIN' and db.showHolypower or playerClass == 'PRIEST' and db.showShadowOrbs) then
		f.extraPoints = f:CreateFontString(nil, 'ARTWORK')

		if (db.extraFontOutline) then
			f.extraPoints:SetFont(BasicUI.media.fontBold, db.extraFontSize, 'THINOUTLINE')
			f.extraPoints:SetShadowOffset(0, 0)
		else
			f.extraPoints:SetFont(BasicUI.media.fontBold, db.extraFontSize)
			f.extraPoints:SetShadowOffset(1, -1)
		end

		f.extraPoints:SetParent(f)
		f.extraPoints:SetPoint('CENTER', 0, 0)
	end

	if (playerClass == 'DEATHKNIGHT' and db.rune.showRuneCooldown) then
		for i = 1, 6 do
			RuneFrame:UnregisterAllEvents()
			_G['RuneButtonIndividual'..i]:Hide()
		end

		f.Rune = {}

		for i = 1, 6 do
			f.Rune[i] = f:CreateFontString(nil, 'ARTWORK')

			if (db.rune.runeFontOutline) then
				f.Rune[i]:SetFont(BasicUI.media.fontBold, db.rune.runeFontSize, 'THINOUTLINE')
				f.Rune[i]:SetShadowOffset(0, 0)
			else
				f.Rune[i]:SetFont(BasicUI.media.fontBold, db.rune.runeFontSize)
				f.Rune[i]:SetShadowOffset(1, -1)
			end

			f.Rune[i]:SetShadowOffset(0, 0)
			f.Rune[i]:SetParent(f)
		end

		f.Rune[1]:SetPoint('CENTER', -65, 0)
		f.Rune[2]:SetPoint('CENTER', -39, 0)
		f.Rune[3]:SetPoint('CENTER', 39, 0)
		f.Rune[4]:SetPoint('CENTER', 65, 0)
		f.Rune[5]:SetPoint('CENTER', -13, 0)
		f.Rune[6]:SetPoint('CENTER', 13, 0)
	end

	f.Power = CreateFrame('StatusBar', nil, UIParent)
	f.Power:SetScale(UIParent:GetScale())
	f.Power:SetSize(db.sizeWidth, 5)
	f.Power:SetPoint('CENTER', f, 0, -23)
	f.Power:SetStatusBarTexture(BasicUI.media.statusbar)
	f.Power:SetAlpha(0)

	f.Power.Value = f.Power:CreateFontString(nil, 'ARTWORK')

	if (db.valueFontOutline) then
		f.Power.Value:SetFont(BasicUI.media.fontNormal, db.valueFontSize, 'THINOUTLINE')
		f.Power.Value:SetShadowOffset(0, 0)
	else
		f.Power.Value:SetFont(BasicUI.media.fontNormal, db.valueFontSize)
		f.Power.Value:SetShadowOffset(1, -1)
	end

	f.Power.Value:SetPoint('CENTER', f.Power, 0, db.valueFontAdjustmentX)
	f.Power.Value:SetVertexColor(1, 1, 1)

	f.Power.Background = f.Power:CreateTexture(nil, 'BACKGROUND')
	f.Power.Background:SetAllPoints(f.Power)
	f.Power.Background:SetTexture(BasicUI.media.statusbar)
	f.Power.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

	f.Power.Below = f.Power:CreateTexture(nil, 'BACKGROUND')
	f.Power.Below:SetHeight(14)
	f.Power.Below:SetWidth(14)
	f.Power.Below:SetTexture([[Interface\AddOns\BasicUI\Media\textureArrowBelow]])

	f.Power.Above = f.Power:CreateTexture(nil, 'BACKGROUND')
	f.Power.Above:SetHeight(14)
	f.Power.Above:SetWidth(14)
	f.Power.Above:SetTexture([[Interface\AddOns\BasicUI\Media\textureArrowAbove]])
	f.Power.Above:SetPoint('BOTTOM', f.Power.Below, 'TOP', 0, f.Power:GetHeight())

	if (db.showCombatRegen) then
		f.mpreg = f.Power:CreateFontString(nil, 'ARTWORK')
		f.mpreg:SetFont(BasicUI.media.fontNormal, 12, 'THINOUTLINE')
		f.mpreg:SetShadowOffset(0, 0)
		f.mpreg:SetPoint('TOP', f.Power.Below, 'BOTTOM', 0, 4)
		f.mpreg:SetParent(f.Power)
		f.mpreg:Show()
	end

	local function GetWarlockPower()
		local powerType = SPELL_POWER_MANA
		local unitPower = 0

		if (IsPlayerSpell(WARLOCK_SOULBURN)) then
			powerType = SPELL_POWER_SOUL_SHARDS
		elseif (IsPlayerSpell(WARLOCK_BURNING_EMBERS)) then
			powerType = SPELL_POWER_BURNING_EMBERS
		elseif (IsPlayerSpell(WARLOCK_METAMORPHOSIS)) then
			powerType = SPELL_POWER_DEMONIC_FURY
		end

		if (powerType ~= SPELL_POWER_MANA) then
			unitPower = UnitPower('player', powerType)
		end

		return unitPower
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

	local function SetComboColor(i)
		local comboPoints = GetComboPoints('player', 'target') or 0

		if (i > comboPoints or UnitIsDeadOrGhost('target')) then
			return 1, 1, 1
		else
			return ComboColor[i].r, ComboColor[i].g, ComboColor[i].b
		end
	end

	local function SetComboAlpha(i)
		local comboPoints = GetComboPoints('player', 'target') or 0

		if (i == comboPoints) then
			return 1
		else
			return 0
		end
	end

	local function UpdateChi()
		local chi = UnitPower('player', SPELL_POWER_CHI)
		local maxChi = UnitPowerMax('player', SPELL_POWER_CHI)
		local yOffset = db.energy.comboPointsBelow and -35 or 0

		if (f.Chi.maxChi ~= maxChi) then
			if (maxChi == 4) then
				f.Chi[1]:SetPoint('CENTER', -39, yOffset)
				f.Chi[2]:SetPoint('CENTER', -13, yOffset)
				f.Chi[3]:SetPoint('CENTER', 13, yOffset)
				f.Chi[4]:SetPoint('CENTER', 39, yOffset)
				f.Chi[5]:Hide()
				f.Chi.maxChi = 4
			else
				f.Chi[1]:SetPoint('CENTER', -52, yOffset)
				f.Chi[2]:SetPoint('CENTER', -26, yOffset)
				f.Chi[3]:SetPoint('CENTER', 0, yOffset)
				f.Chi[4]:SetPoint('CENTER', 26, yOffset)
				f.Chi[5]:Show()
				f.Chi.maxChi = 5
			end
		end

		for i = 1, maxChi do
			if (UnitHasVehicleUI('player')) then
				if (f.Chi[i]:IsShown()) then
					f.Chi[i]:Hide()
				end
			else
				if (not f.Chi[i]:IsShown()) then
					f.Chi[i]:Show()
				end
			end
			f.Chi[i]:SetAlpha(i == chi and 1 or 0)
		end
	end

	local function CalcRuneCooldown(self)
		local start, duration, runeReady = GetRuneCooldown(self)
		local time = floor(GetTime() - start)
		local cooldown = ceil(duration - time)

		if (runeReady or UnitIsDeadOrGhost('player')) then
			return '#'
		elseif (not UnitIsDeadOrGhost('player') and cooldown) then
			return cooldown
		end
	end

	local function SetRuneColor(i)
		if (f.Rune[i].type == 4) then
			return 1, 0, 1
		else
			return RuneColor[i].r, RuneColor[i].g, RuneColor[i].b
		end
	end

	local function UpdateBarVisibility()
		local _, powerType = UnitPowerType('player')
		local newAlpha = nil

		if ((not db.energy.show and powerType == 'ENERGY') or (not db.showFocus and powerType == 'FOCUS') or (not db.showRage and powerType == 'RAGE') or (not db.showMana and powerType == 'MANA') or (not db.rune.show and powerType == 'RUNEPOWER') or UnitIsDeadOrGhost('player') or UnitHasVehicleUI('player')) then
			f.Power:SetAlpha(0)
		elseif (InCombatLockdown()) then
			newAlpha = db.activeAlpha
		elseif (not InCombatLockdown() and UnitPower('player') > 0) then
			newAlpha = db.inactiveAlpha
		else
			newAlpha = db.emptyAlpha
		end

		if (newAlpha) then
			Fade(f.Power, 0.3, f.Power:GetAlpha(), newAlpha)
		end
	end

	local function UpdateArrow()
		if (UnitPower('player') == 0) then
			f.Power.Below:SetAlpha(0.3)
			f.Power.Above:SetAlpha(0.3)
		else
			f.Power.Below:SetAlpha(1)
			f.Power.Above:SetAlpha(1)
		end

		local newPosition = UnitPower('player') / UnitPowerMax('player') * f.Power:GetWidth()
		f.Power.Below:SetPoint('TOP', f.Power, 'BOTTOMLEFT', newPosition, 0)
	end

	local function UpdateBarValue()
		local min = UnitPower('player')
		f.Power:SetMinMaxValues(0, UnitPowerMax('player', f))
		f.Power:SetValue(min)

		if (db.valueAbbrev) then
			f.Power.Value:SetText(min > 0 and FormatValue(min) or '')
		else
			f.Power.Value:SetText(min > 0 and min or '')
		end
	end

	local function UpdateBarColor()
		local _, powerType, altR, altG, altB = UnitPowerType('player')
		local unitPower = PowerBarColor[powerType]

		if (unitPower) then
			f.Power:SetStatusBarColor(unitPower.r, unitPower.g, unitPower.b)
		else
			f.Power:SetStatusBarColor(altR, altG, altB)
		end
	end

	local function UpdateBar()
		UpdateBarColor()
		UpdateBarValue()
		UpdateArrow()
	end

	f:SetScript('OnEvent', function(self, event, arg1)
		if (f.ComboPoints) then
			if (event == 'UNIT_COMBO_POINTS' or event == 'PLAYER_TARGET_CHANGED') then
				for i = 1, 5 do
					f.ComboPoints[i]:SetTextColor(SetComboColor(i))
					f.ComboPoints[i]:SetAlpha(SetComboAlpha(i))
				end
			end
		end

		if (event == 'RUNE_TYPE_UPDATE' and db.rune.showRuneCooldown) then
			f.Rune[arg1].type = GetRuneType(arg1)
		end

		if (f.extraPoints) then
			if (UnitHasVehicleUI('player')) then
				if (f.extraPoints:IsShown()) then
					f.extraPoints:Hide()
				end
			else
				local nump
				if (playerClass == 'WARLOCK') then
					nump = GetWarlockPower()
				elseif (playerClass == 'PALADIN') then
					nump = UnitPower('player', SPELL_POWER_HOLY_POWER)
				elseif (playerClass == 'PRIEST') then
					nump = UnitPower('player', SPELL_POWER_SHADOW_ORBS)
				end

				f.extraPoints:SetText(nump == 0 and '' or nump)
				
				if (not f.extraPoints:IsShown()) then
					f.extraPoints:Show()
				end			
			end
		end

		if (f.Chi) then
			UpdateChi()
		end

		if (f.mpreg and (event == 'UNIT_AURA' or event == 'PLAYER_ENTERING_WORLD')) then
			f.mpreg:SetText(GetRealMpFive())
		end

		UpdateBar()
		UpdateBarVisibility()

		if (event == 'PLAYER_ENTERING_WORLD') then
			if (InCombatLockdown()) then
				securecall('UIFrameFadeIn', f, 0.35, f:GetAlpha(), 1)
			else
				securecall('UIFrameFadeOut', f, 0.35, f:GetAlpha(), db.inactiveAlpha)
			end
		end

		if (event == 'PLAYER_REGEN_DISABLED') then
			securecall('UIFrameFadeIn', f, 0.35, f:GetAlpha(), 1)
		end

		if (event == 'PLAYER_REGEN_ENABLED') then
			securecall('UIFrameFadeOut', f, 0.35, f:GetAlpha(), db.inactiveAlpha)
		end
	end)

	if (f.Rune) then
		local updateTimer = 0
		f:SetScript('OnUpdate', function(self, elapsed)
			updateTimer = updateTimer + elapsed

			if (updateTimer > 0.1) then
				for i = 1, 6 do
					if (UnitHasVehicleUI('player')) then
						if (f.Rune[i]:IsShown()) then
							f.Rune[i]:Hide()
						end
					else
						if (not f.Rune[i]:IsShown()) then
							f.Rune[i]:Show()
						end
					end

					f.Rune[i]:SetText(CalcRuneCooldown(i))
					f.Rune[i]:SetTextColor(SetRuneColor(i))
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
function Powerbar:GetOptions()
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
		set = function(info, value) db[ info[#info] ] = value;  end,					
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
				order = 1,
				name = L["Enable Powerbar Module"],
				width = "full",
				type = "toggle",							
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
				set = function(info, value) db.position[ info[#info] ] = value;  end,						
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
			energy = {
				type = "group",
				order = 5,
				guiInline = true,
				name = L["Energy"],
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.energy[ info[#info] ] end,
				set = function(info, value) db.energy[ info[#info] ] = value;  end,						
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
						name = L["Show Energy Text"],
						type = "toggle",
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},					
					showComboPoints = {
						order = 2,
						name = L["Show Combo Points"],
						type = "toggle",
						disabled = function() return isModuleDisabled() or not db.enable or not db.energy.show end,
					},
					comboPointsBelow = {
						order = 2,
						name = L["Combo Points Below"],
						type = "toggle",
						disabled = function() return isModuleDisabled() or not db.enable or not db.energy.show end,
					},							
					comboFontOutline = {
						order = 2,
						name = L["Combo Font Outline"],
						type = "toggle",
						disabled = function() return isModuleDisabled() or not db.enable or not db.energy.show end,
					},
					comboFontSize = {
						order = 5,
						name = L["Combo Font Size"],
						type = "range",
						min = 8, max = 25, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.energy.show end,
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
				set = function(info, value) db.rune[ info[#info] ] = value;  end,						
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