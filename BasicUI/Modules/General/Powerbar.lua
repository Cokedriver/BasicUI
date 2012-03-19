local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config

if C['powerbar'].enable ~= true then return end

--[[

	All Credit for Powerbar.lua goes to Neal and ballagarba.
	nPower = http://www.wowinterface.com/downloads/info19876-nPower.html.
	Edited by Cokedriver.
	
]]


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
f:SetPoint('CENTER', UIParent, 0, -180)
f:EnableMouse(false)

f:RegisterEvent('PLAYER_REGEN_ENABLED')
f:RegisterEvent('PLAYER_REGEN_DISABLED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:RegisterEvent('UNIT_COMBO_POINTS')
f:RegisterEvent('PLAYER_TARGET_CHANGED')

if (C['powerbar'].showRuneCooldown) then
    f:RegisterEvent('RUNE_TYPE_UPDATE')
end

-- f:RegisterEvent('UNIT_DISPLAYPOWER')
-- f:RegisterEvent('UNIT_POWER')
-- f:RegisterEvent('UPDATE_SHAPESHIFT_FORM')

if (C['powerbar'].showComboPoints) then
    f.ComboPoints = {}

    for i = 1, 5 do
        f.ComboPoints[i] = f:CreateFontString(nil, 'ARTWORK')
        
        if (C['powerbar'].combo.FontOutline) then
            f.ComboPoints[i]:SetFont(C['general'].font, C['powerbar'].combo.FontSize, 'THINOUTLINE')
            f.ComboPoints[i]:SetShadowOffset(0, 0)
        else
            f.ComboPoints[i]:SetFont(C['general'].font, C['powerbar'].combo.FontSize)
            f.ComboPoints[i]:SetShadowOffset(1, -1)
        end
        
        f.ComboPoints[i]:SetParent(f)
        f.ComboPoints[i]:SetText(i)
        f.ComboPoints[i]:SetAlpha(0)
    end

    f.ComboPoints[1]:SetPoint('CENTER', -52, 3)
    f.ComboPoints[2]:SetPoint('CENTER', -26, 3)
    f.ComboPoints[3]:SetPoint('CENTER', 0, 3)
    f.ComboPoints[4]:SetPoint('CENTER', 26, 3)
    f.ComboPoints[5]:SetPoint('CENTER', 52, 3)
end

if (B.myclass == 'WARLOCK' and C['powerbar'].showSoulshardsor or playerClass == 'PALADIN' and C['powerbar'].showHolypower) then
    f.extraPoints = f:CreateFontString(nil, 'ARTWORK')
    
    if (C['powerbar'].extra.FontOutline) then
        f.extraPoints:SetFont(C['general'].font, C['powerbar'].extra.FontSize, 'THINOUTLINE')
        f.extraPoints:SetShadowOffset(0, 0)
    else
        f.extraPoints:SetFont(C['general'].font, C['powerbar'].extra.FontSize)
        f.extraPoints:SetShadowOffset(1, -1)
    end

    f.extraPoints:SetParent(f)
    f.extraPoints:SetPoint('CENTER', 0, 0)
end

if (B.myclass == 'DEATHKNIGHT' and C['powerbar'].showRuneCooldown) then
    for i = 1, 6 do 
        RuneFrame:UnregisterAllEvents()
        _G['RuneButtonIndividual'..i]:Hide()
    end

    f.Rune = {}

    for i = 1, 6 do
        f.Rune[i] = f:CreateFontString(nil, 'ARTWORK')

        if (C['powerbar'].rune.FontOutline) then
            f.Rune[i]:SetFont(C['general'].font, C['powerbar'].rune.FontSize, 'THINOUTLINE')
            f.Rune[i]:SetShadowOffset(0, 0)
        else
            f.Rune[i]:SetFont(C['general'].font, C['powerbar'].rune.FontSize)
            f.Rune[i]:SetShadowOffset(1, -1)
        end

        f.Rune[i]:SetShadowOffset(0, 0)
        f.Rune[i]:SetParent(f)
		f.Rune[i]:Hide()
    end

    f.Rune[1]:SetPoint('CENTER', -65, 3)
    f.Rune[2]:SetPoint('CENTER', -39, 3)
    f.Rune[3]:SetPoint('CENTER', 39, 3)
    f.Rune[4]:SetPoint('CENTER', 65, 3)
    f.Rune[5]:SetPoint('CENTER', -13, 3)
    f.Rune[6]:SetPoint('CENTER', 13, 3)
end

if (B.myclass == "DRUID" and C['powerbar'].showEclipse ) then
	f.unit = "player";
	EclipseBarFrame:SetParent(f);
	EclipseBarFrame:ClearAllPoints();
	EclipseBarFrame:SetPoint('CENTER', 0, 5);
	EclipseBarFrame:Show();
	EclipseBarFrame:SetScale(1);
	
end

f.Power = CreateFrame('StatusBar', nil, UIParent)
f.Power:SetScale(UIParent:GetScale())
f.Power:SetSize(C['powerbar'].sizeWidth, 5)
f.Power:SetPoint('CENTER', f, 0, -23)
f.Power:SetStatusBarTexture('Interface\\TargetingFrame\\UI-StatusBar')
f.Power:SetAlpha(0)

f.Power.Value = f.Power:CreateFontString(nil, 'ARTWORK')

if (C['powerbar'].value.FontOutline) then
    f.Power.Value:SetFont(C['general'].font, C['powerbar'].value.FontSize, 'THINOUTLINE')
    f.Power.Value:SetShadowOffset(0, 0)
else
    f.Power.Value:SetFont(C['general'].font, C['powerbar'].value.FontSize)
    f.Power.Value:SetShadowOffset(1, -1)
end

f.Power.Value:SetPoint('CENTER', f.Power, 0, 0)
f.Power.Value:SetVertexColor(1, 1, 1)

f.Power.Background = f.Power:CreateTexture(nil, 'BACKGROUND')
f.Power.Background:SetAllPoints(f.Power)
f.Power.Background:SetTexture('Interface\\TargetingFrame\\UI-StatusBar')
f.Power.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

f.Power.BackgroundShadow = CreateFrame('Frame', nil, f.Power)
f.Power.BackgroundShadow:SetFrameStrata('BACKGROUND')
f.Power.BackgroundShadow:SetPoint('TOPLEFT', -4, 4)
f.Power.BackgroundShadow:SetPoint('BOTTOMRIGHT', 4, -4)

f.Power.Below = f.Power:CreateTexture(nil, 'BACKGROUND')
f.Power.Below:SetHeight(14)
f.Power.Below:SetWidth(14)
f.Power.Below:SetTexture('Interface\\AddOns\\BasicUI\\Media\\textureArrowBelow')

f.Power.Above = f.Power:CreateTexture(nil, 'BACKGROUND')
f.Power.Above:SetHeight(14)
f.Power.Above:SetWidth(14)
f.Power.Above:SetTexture('Interface\\AddOns\\BasicUI\\Media\\textureArrowAbove')
f.Power.Above:SetPoint('BOTTOM', f.Power.Below, 'TOP', 0, f.Power:GetHeight() - 2)

if (C['powerbar'].showCombatRegen) then
    f.mpreg = f.Power:CreateFontString(nil, 'ARTWORK')
    f.mpreg:SetFont(C['general'].font, 12, 'THINOUTLINE')
    f.mpreg:SetShadowOffset(0, 0)
    f.mpreg:SetPoint('TOP', f.Power.Below, 'BOTTOM', 0, 4)
    f.mpreg:SetParent(f.Power)
    f.mpreg:Show()
end

local function FormatValue(self)
    if (self >= 10000) then
        return ('%.1fk'):format(self / 1e3)
    else
        return self
    end
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

    if ((not C['powerbar'].energybar and powerType == 'ENERGY') or (not C['powerbar'].focusbar and powerType == 'FOCUS') or (not C['powerbar'].ragebar and powerType == 'RAGE') or (not C['powerbar'].manabar and powerType == 'MANA') or (not C['powerbar'].runebar and powerType == 'RUNEPOWER') or UnitIsDeadOrGhost('player') or UnitHasVehicleUI('player')) then
        f.Power:SetAlpha(0)
    elseif (InCombatLockdown()) then
        securecall('UIFrameFadeIn', f.Power, 0.3, f.Power:GetAlpha(), 1)
    elseif (not InCombatLockdown() and UnitPower('player') > 0) then
        securecall('UIFrameFadeOut', f.Power, 0.3, f.Power:GetAlpha(), 0)
    else
        securecall('UIFrameFadeOut', f.Power, 0.3, f.Power:GetAlpha(), 0)
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
    f.Power.Below:SetPoint('TOP', f.Power, 'BOTTOMLEFT', newPosition, 2)
end

local function UpdateBarValue()
    local min = UnitPower('player')
    f.Power:SetMinMaxValues(0, UnitPowerMax('player', f))
    f.Power:SetValue(min)

    if (C['powerbar'].value.Abbrev) then
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

    if (event == 'RUNE_TYPE_UPDATE' and C['powerbar'].showRuneCooldown) then
        f.Rune[arg1].type = GetRuneType(arg1)
    end

    --[[
    UpdateBar()
    UpdateBarVisibility()
    --]]

    if (event == 'PLAYER_ENTERING_WORLD') then
        if (InCombatLockdown()) then
            securecall('UIFrameFadeIn', f, 0.35, f:GetAlpha(), 1)
        else
            securecall('UIFrameFadeOut', f, 0.35, f:GetAlpha(), 0)
        end
    end

    if (event == 'PLAYER_REGEN_DISABLED') then
        securecall('UIFrameFadeIn', f, 0.35, f:GetAlpha(), 1)
    end
    
    if (event == 'PLAYER_REGEN_ENABLED') then
        securecall('UIFrameFadeOut', f, 0.35, f:GetAlpha(), 0)
    end
end)

local updateTimer = 0
f:SetScript('OnUpdate', function(self, elapsed)
    updateTimer = updateTimer + elapsed

    if (updateTimer > 0.1) then
        if (f.mpreg) then
            f.mpreg:SetText(GetRealMpFive())
        end

        if (f.Rune) then
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
        end	
		
        if (f.extraPoints) then
            if (UnitHasVehicleUI('player')) then
                if (f.extraPoints:IsShown()) then
                    f.extraPoints:Hide()
                end
            else
                local nump
                if (B.myclass == 'WARLOCK') then
                    nump = UnitPower('player', SPELL_POWER_SOUL_SHARDS)
                elseif (playerClass == 'PALADIN') then
                    nump = UnitPower('player', SPELL_POWER_HOLY_POWER)					
                end
                
                f.extraPoints:SetText(nump == 0 and '' or nump)
            end
        end

        UpdateBar()
        UpdateBarVisibility()

        updateTimer = 0
    end
end)


--[[ 
	Original Code from nibEclipse
	Edited by Cokderiver for BasicUI
]]

if (B.level > 10 and C['powerbar'].showEclipseBar == true) then 

	EclipseBarFrame:UnregisterAllEvents()
	EclipseBarFrame:Hide()
	function EclipseBarFrame:Show() return nil end;

	local BasicEclipse = CreateFrame("Frame")
	BasicEclipse.direction = "none"
	BasicEclipse.lastupdate = 0

	local EventsRegistered

	local Textures = {
		Arrow = "Interface\\PlayerFrame\\UI-DruidEclipse",
	}

	local IconShow = {
		moon = { 0.55859375, 0.72656250, 0.00781250, 0.35937500 },
		sun = { 0.73437500, 0.90234375, 0.00781250, 0.35937500 },
	}

	local ArrowDirection = {
		sun	= { 0.914, 1.0, 0.641, 0.82 },
		moon = { 1.0, 0.914, 0.641, 0.82 },
	}



	local retval = {}
	local function HasEclipseBuffs()
		local spellIDs = {ECLIPSE_BAR_SOLAR_BUFF_ID, ECLIPSE_BAR_LUNAR_BUFF_ID}
		
		for i = 1, #spellIDs do
			retval[i] = false
		end

		local i = 1
		local name, _, texture, applications, _, _, _, _, _, _, auraID = UnitAura("player", i)
		while name do
			for i=1, #spellIDs do
				if spellIDs[i] == auraID then
					retval[i] = applications == 0 and true or applications
					break
				end
			end

			i = i + 1
			name, _, texture, applications, _, _, _, _, _, _, auraID = UnitAura("player", i)
		end

		return retval
	end

	---- Events
	local function Eclipse_UpdateDirection()
		BasicEclipse.direction = GetEclipseDirection()
		
		if BasicEclipse.direction == "sun" then
			
			BasicEclipse.Frames.Icon:Show()
			BasicEclipse.Frames.Icon:ClearAllPoints()
			BasicEclipse.Frames.Icon:SetPoint("LEFT", BasicEclipse.Frames.Main, "LEFT", -45, 0)
			BasicEclipse.Frames.Icon.bg:SetTexCoord(unpack(IconShow.sun))
			B.Flash(BasicEclipse.Frames.Icon, 1)
			
			BasicEclipse.Frames.Status:Show()
			BasicEclipse.Frames.Status:ClearAllPoints()
			BasicEclipse.Frames.Status:SetPoint("BOTTOMLEFT", BasicEclipse.Frames.Main, "BOTTOMLEFT", 1, 1)
			BasicEclipse.Frames.Status:SetWidth(1)
			BasicEclipse.Frames.Status.bg:SetTexture(0.13, 0.13, 0.5, 0.5)
			BasicEclipse.Frames.Status.bg:SetAllPoints(BasicEclipse.Frames.Status)
			
			BasicEclipse.Frames.Below:SetPoint('TOP', BasicEclipse.Frames.Status, 'BOTTOMRIGHT', 0, 0)			
			
		elseif BasicEclipse.direction == "moon" then
			
			BasicEclipse.Frames.Icon:Show()
			BasicEclipse.Frames.Icon:ClearAllPoints()
			BasicEclipse.Frames.Icon:SetPoint("RIGHT", BasicEclipse.Frames.Main, "RIGHT", 47, 1)
			BasicEclipse.Frames.Icon.bg:SetTexCoord(unpack(IconShow.moon))
			B.Flash(BasicEclipse.Frames.Icon, 1)
			
			BasicEclipse.Frames.Status:Show()
			BasicEclipse.Frames.Status:ClearAllPoints()
			BasicEclipse.Frames.Status:SetPoint("BOTTOMRIGHT", BasicEclipse.Frames.Main, "BOTTOMRIGHT", -1, 1)
			BasicEclipse.Frames.Status:SetWidth(1)
			BasicEclipse.Frames.Status.bg:SetTexture(0.6, 0.35, 0, 0.5)
			BasicEclipse.Frames.Status.bg:SetAllPoints(BasicEclipse.Frames.Status)
			
			BasicEclipse.Frames.Below:SetPoint('TOP', BasicEclipse.Frames.Status, 'BOTTOMLEFT', 0, 0)			
			
		elseif BasicEclipse.direction == nil then
		
			BasicEclipse.Frames.Arrow:Hide()
			BasicEclipse.Frames.Status:Hide()
			B.StopFlash(BasicEclipse.Frames.Icon)
		end


	end

	local function Eclipse_UpdateAuras(...)
		if ... ~= "player" then return end
		
		local buffStatus = HasEclipseBuffs()
		local hasSolar = buffStatus[1]
		local hasLunar = buffStatus[2]

	end

	local function Eclipse_UpdateShown()
		local form = GetShapeshiftFormID()
		if form == MOONKIN_FORM or not form then
			if (InCombatLockdown()) then
				securecall('UIFrameFadeIn', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 1)
			else
				securecall('UIFrameFadeOut', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 0)
			end
		else
			securecall('UIFrameFadeOut', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 0)
		end
		
	end

	function BasicEclipse.OnUpdate()
		local CurTime = GetTime()
		
		if CurTime >= BasicEclipse.lastupdate + 0.05 then
			local power = UnitPower("player", SPELL_POWER_ECLIPSE)
			local maxPower = UnitPowerMax("player", SPELL_POWER_ECLIPSE)
			
			if maxPower <= 0 or power > maxPower then
				return
			end
			
			local powerper = 0
			if BasicEclipse.direction == "sun" then
				powerper = (power + 100) / (maxPower + 100)
			elseif BasicEclipse.direction == "moon" then
				powerper = 1 - ((power + 100) / (maxPower + 100))
			else
				powerper = 0
			end
			powerper = max(powerper, 0)
			powerper = min(powerper, 1)
			
			if (UnitPower('player') == 0) then
				BasicEclipse.Frames.Below:SetAlpha(0.3)
				BasicEclipse.Frames.Above:SetAlpha(0.3)
			else
				BasicEclipse.Frames.Below:SetAlpha(1)
				BasicEclipse.Frames.Above:SetAlpha(1)
			end
			
			BasicEclipse.Frames.Status:SetWidth(powerper * (150 - 2) + 1)
			BasicEclipse.Frames.Text.str:SetText(tostring(abs(power)))
			
			BasicEclipse.lastupdate = CurTime
		end
	end

	local function Eclipse_PlayerEnteringWorld()
		Eclipse_UpdateShown()
		Eclipse_UpdateAuras("player")
		Eclipse_UpdateDirection()	
	end

	local function EclipseEvents(self, event, ...)
		if event == "PLAYER_ENTERING_WORLD" then
			Eclipse_PlayerEnteringWorld()
		elseif event == "UPDATE_SHAPESHIFT_FORM" or event == "PLAYER_TALENT_UPDATE" or event == "MASTERY_UPDATE" or event == "PLAYER_UNGHOST" or event == "PLAYER_ALIVE" or event == "PLAYER_DEAD" then
			Eclipse_UpdateShown()
		elseif event == "UNIT_AURA" then
			Eclipse_UpdateAuras(...)
		elseif event == "ECLIPSE_DIRECTION_CHANGE" then
			Eclipse_UpdateDirection()
		elseif event == 'PLAYER_REGEN_DISABLED' then
			securecall('UIFrameFadeIn', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 1)
		elseif event == 'PLAYER_REGEN_ENABLED' then
			securecall('UIFrameFadeOut', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 0)
		end
	end

	function BasicEclipse.SetupEvents()
		if EventsRegistered then return end
		
		BasicEclipse.Frames.Main:RegisterEvent("PLAYER_ENTERING_WORLD")
		BasicEclipse.Frames.Main:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
		BasicEclipse.Frames.Main:RegisterEvent("PLAYER_TALENT_UPDATE")
		BasicEclipse.Frames.Main:RegisterEvent("MASTERY_UPDATE")
		BasicEclipse.Frames.Main:RegisterEvent("PLAYER_TARGET_CHANGED")
		BasicEclipse.Frames.Main:RegisterEvent("PLAYER_UNGHOST")
		BasicEclipse.Frames.Main:RegisterEvent("PLAYER_REGEN_DISABLED")
		BasicEclipse.Frames.Main:RegisterEvent("PLAYER_REGEN_ENABLED")
		BasicEclipse.Frames.Main:RegisterEvent("PLAYER_ALIVE")
		BasicEclipse.Frames.Main:RegisterEvent("PLAYER_DEAD")
		BasicEclipse.Frames.Main:RegisterEvent("UNIT_AURA")
		BasicEclipse.Frames.Main:RegisterEvent("ECLIPSE_DIRECTION_CHANGE")
		BasicEclipse.Frames.Main:SetScript("OnEvent", EclipseEvents)
		
		-- Enable OnUpdate handler
		BasicEclipse.LastTime = 0
		BasicEclipse.Frames.Main:SetScript("OnUpdate", BasicEclipse.OnUpdate)
		
		EventsRegistered = true
	end

	-- Settings Update
	function BasicEclipse.UpdateSettings()
		local PF = UIParent
		BasicEclipse.Frames.Main:SetParent(PF)
		BasicEclipse.Frames.Main:SetPoint("CENTER", PF, "CENTER", 0, -230)
		BasicEclipse.Frames.Main:SetFrameStrata(PF:GetFrameStrata())
		BasicEclipse.Frames.Main:SetFrameLevel(PF:GetFrameLevel() + 4)
		BasicEclipse.Frames.Main:SetWidth(150)
		BasicEclipse.Frames.Main:SetHeight(14)
		local EclipseBorder = CreateFrame("Frame", nil, BasicEclipse.Frames.Main);
		EclipseBorder:SetFrameStrata("MEDIUM");
		EclipseBorder:SetPoint("TOPLEFT", -3, 3);
		EclipseBorder:SetPoint("BOTTOMRIGHT", 3, -3);
		EclipseBorder:SetBackdrop({
			edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border',
			edgeSize = 15,
		})
		EclipseBorder:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
		

		-- Lunar BG
		BasicEclipse.Frames.LunarBG:SetWidth((150 / 2) - 1)
		BasicEclipse.Frames.LunarBG:SetHeight(14 - 2)
		BasicEclipse.Frames.LunarBG:SetTexture("Interface\\AddOns\\BasicUI\\Media\\Eclipse_Lunar.tga")
		
		-- Solar BG
		BasicEclipse.Frames.SolarBG:SetWidth((150 / 2) - 1)
		BasicEclipse.Frames.SolarBG:SetHeight(14 - 2)
		BasicEclipse.Frames.SolarBG:SetTexture("Interface\\AddOns\\BasicUI\\Media\\Eclipse_Solar.tga")
		
		
		BasicEclipse.Frames.Below = BasicEclipse.Frames.Main:CreateTexture(nil, 'BACKGROUND')
		BasicEclipse.Frames.Below:SetHeight(14)
		BasicEclipse.Frames.Below:SetWidth(14)
		BasicEclipse.Frames.Below:SetTexture('Interface\\AddOns\\BasicUI\\Media\\textureArrowBelow')

		BasicEclipse.Frames.Above = BasicEclipse.Frames.Main:CreateTexture(nil, 'BACKGROUND')
		BasicEclipse.Frames.Above:SetHeight(14)
		BasicEclipse.Frames.Above:SetWidth(14)
		BasicEclipse.Frames.Above:SetTexture('Interface\\AddOns\\BasicUI\\Media\\textureArrowAbove')
		BasicEclipse.Frames.Above:SetPoint('BOTTOM', BasicEclipse.Frames.Below, 'TOP', 0, BasicEclipse.Frames.Main:GetHeight() - 2)
		
		-- Icons (Solar - Lunar)
		BasicEclipse.Frames.Icon:SetPoint("CENTER", BasicEclipse.Frames.Main, "CENTER", 0, 1)
		BasicEclipse.Frames.Icon:SetFrameLevel(BasicEclipse.Frames.Main:GetFrameLevel() + 2)
		BasicEclipse.Frames.Icon:SetWidth(24 * 2)
		BasicEclipse.Frames.Icon:SetHeight(24 * 2)	
		
		BasicEclipse.Frames.Icon.bg:SetTexture(Textures.Arrow)
		BasicEclipse.Frames.Icon.bg:SetAllPoints(BasicEclipse.Frames.Icon)
		
		-- Status Bar
		BasicEclipse.Frames.Status:SetPoint("BOTTOM", BasicEclipse.Frames.Main, "BOTTOM", 0, 1)
		BasicEclipse.Frames.Status:SetFrameLevel(BasicEclipse.Frames.Main:GetFrameLevel() + 1)
		BasicEclipse.Frames.Status:SetWidth(1)
		BasicEclipse.Frames.Status:SetHeight(14 - 2)

		
		-- Text
		BasicEclipse.Frames.Text:SetPoint("CENTER", BasicEclipse.Frames.Main, "CENTER", 0, 0)
		BasicEclipse.Frames.Text:SetFrameLevel(BasicEclipse.Frames.Main:GetFrameLevel() + 2)
		BasicEclipse.Frames.Text:SetWidth(24)
		BasicEclipse.Frames.Text:SetHeight(24)
		BasicEclipse.Frames.Text.str:SetFont(C['general'].font, C['general'].fontsize, 'THINOUTLINE')
		BasicEclipse.Frames.Text.str:SetText("0")
	end

	-- Frame Creation
	function BasicEclipse.CreateFrames()
		if BasicEclipse.Frames then return end
		
		BasicEclipse.Frames = {}
		
		-- Create main frame
		BasicEclipse.Frames.Main = CreateFrame("Frame", "EclipseBar", UIParent)
		
		-- Lunar BG
		BasicEclipse.Frames.LunarBG = BasicEclipse.Frames.Main:CreateTexture("BACKGROUND")
		BasicEclipse.Frames.LunarBG:SetPoint("LEFT", BasicEclipse.Frames.Main, "LEFT", 1, 0)
		
		-- Solar BG
		BasicEclipse.Frames.SolarBG = BasicEclipse.Frames.Main:CreateTexture("BACKGROUND")
		BasicEclipse.Frames.SolarBG:SetPoint("RIGHT", BasicEclipse.Frames.Main, "RIGHT", -1, 0)
		
		-- Arrow
		BasicEclipse.Frames.Arrow = CreateFrame("Frame", nil, BasicEclipse.Frames.Main)
		BasicEclipse.Frames.Arrow.bg = BasicEclipse.Frames.Arrow:CreateTexture()
		BasicEclipse.Frames.Arrow.bg:SetBlendMode("ADD")

		--  Icon
		BasicEclipse.Frames.Icon = CreateFrame("Frame", nil, BasicEclipse.Frames.Main)
		BasicEclipse.Frames.Icon.bg = BasicEclipse.Frames.Icon:CreateTexture()
			
		-- Status Bar
		BasicEclipse.Frames.Status = CreateFrame("Frame", nil, BasicEclipse.Frames.Main)
		BasicEclipse.Frames.Status.bg = BasicEclipse.Frames.Status:CreateTexture()
		
		-- Text
		BasicEclipse.Frames.Text = CreateFrame("Frame", nil, BasicEclipse.Frames.Main)
		BasicEclipse.Frames.Text.str = BasicEclipse.Frames.Text:CreateFontString()
		BasicEclipse.Frames.Text.str:SetPoint("CENTER", BasicEclipse.Frames.Text, "CENTER")
	end

	----
	function BasicEclipse.PLAYER_LOGIN()
		if not (select(2, UnitClass("player")) == "DRUID") then return end
		
		BasicEclipse.CreateFrames()
		BasicEclipse.UpdateSettings()
		BasicEclipse.SetupEvents()
	end

	local function EventHandler(self, event, ...)
		if event == "PLAYER_LOGIN" then
			BasicEclipse.PLAYER_LOGIN()
		end
	end
	BasicEclipse:RegisterEvent("PLAYER_LOGIN")
	BasicEclipse:SetScript("OnEvent", EventHandler)
end