local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - database

if C['powerbar'].enable ~= true then return end

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
f:SetPoint(C['powerbar'].position.selfAnchor, C['powerbar'].position.frameParent, C['powerbar'].position.offSetX, C['powerbar'].position.offSetY)
f:EnableMouse(false)

f:RegisterEvent('PLAYER_REGEN_ENABLED')
f:RegisterEvent('PLAYER_REGEN_DISABLED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:RegisterUnitEvent('UNIT_COMBO_POINTS', 'player')
f:RegisterEvent('PLAYER_TARGET_CHANGED')

if (C['powerbar'].rune.showRuneCooldown) then
    f:RegisterEvent('RUNE_TYPE_UPDATE')
end

f:RegisterUnitEvent('UNIT_DISPLAYPOWER', 'player')
f:RegisterUnitEvent('UNIT_POWER_FREQUENT', 'player')
f:RegisterEvent('UPDATE_SHAPESHIFT_FORM')

if (C['powerbar'].showCombatRegen) then
    f:RegisterUnitEvent('UNIT_AURA', 'player')
end

f:RegisterUnitEvent('UNIT_ENTERED_VEHICLE', 'player')
f:RegisterUnitEvent('UNIT_ENTERING_VEHICLE', 'player')
f:RegisterUnitEvent('UNIT_EXITED_VEHICLE', 'player')
f:RegisterUnitEvent('UNIT_EXITING_VEHICLE', 'player')

if (C['powerbar'].energy.showComboPoints) then
    f.ComboPoints = {}

    for i = 1, 5 do
        f.ComboPoints[i] = f:CreateFontString(nil, 'ARTWORK')

        if (C['powerbar'].energy.comboFontOutline) then
            f.ComboPoints[i]:SetFont(C['media'].fontBold, C['powerbar'].energy.comboFontSize, 'THINOUTLINE')
            f.ComboPoints[i]:SetShadowOffset(0, 0)
        else
            f.ComboPoints[i]:SetFont(C['media'].fontBold, C['powerbar'].energy.comboFontSize)
            f.ComboPoints[i]:SetShadowOffset(1, -1)
        end

        f.ComboPoints[i]:SetParent(f)
        f.ComboPoints[i]:SetText(i)
        f.ComboPoints[i]:SetAlpha(0)
    end

    local yOffset = C['powerbar'].energy.comboPointsBelow and -35 or 0
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

        f.Chi[i]:SetFont(C['media'].fontBold, C['powerbar'].energy.comboFontSize, 'THINOUTLINE')
        f.Chi[i]:SetShadowOffset(0, 0)

        f.Chi[i]:SetParent(f)
        f.Chi[i]:SetText(i)
        f.Chi[i]:SetAlpha(0)
    end

    local yOffset = C['powerbar'].energy.comboPointsBelow and -35 or 0
    f.Chi[1]:SetPoint('CENTER', -39, yOffset)
    f.Chi[2]:SetPoint('CENTER', -13, yOffset)
    f.Chi[3]:SetPoint('CENTER', 13, yOffset)
    f.Chi[4]:SetPoint('CENTER', 39, yOffset)
    f.Chi[5]:SetPoint('CENTER', 52, yOffset)
    f.Chi[5]:Hide()
end

if (playerClass == 'WARLOCK' and C['powerbar'].showSoulshards or playerClass == 'PALADIN' and C['powerbar'].showHolypower or playerClass == 'PRIEST' and C['powerbar'].showShadowOrbs) then
    f.extraPoints = f:CreateFontString(nil, 'ARTWORK')

    if (C['powerbar'].extraFontOutline) then
        f.extraPoints:SetFont(C['media'].fontBold, C['powerbar'].extraFontSize, 'THINOUTLINE')
        f.extraPoints:SetShadowOffset(0, 0)
    else
        f.extraPoints:SetFont(C['media'].fontBold, C['powerbar'].extraFontSize)
        f.extraPoints:SetShadowOffset(1, -1)
    end

    f.extraPoints:SetParent(f)
    f.extraPoints:SetPoint('CENTER', 0, 0)
end

if (playerClass == 'DEATHKNIGHT' and C['powerbar'].rune.showRuneCooldown) then
    for i = 1, 6 do
        RuneFrame:UnregisterAllEvents()
        _G['RuneButtonIndividual'..i]:Hide()
    end

    f.Rune = {}

    for i = 1, 6 do
        f.Rune[i] = f:CreateFontString(nil, 'ARTWORK')

        if (C['powerbar'].rune.runeFontOutline) then
            f.Rune[i]:SetFont(C['media'].fontBold, C['powerbar'].rune.runeFontSize, 'THINOUTLINE')
            f.Rune[i]:SetShadowOffset(0, 0)
        else
            f.Rune[i]:SetFont(C['media'].fontBold, C['powerbar'].rune.runeFontSize)
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
f.Power:SetSize(C['powerbar'].sizeWidth, 5)
f.Power:SetPoint('CENTER', f, 0, -23)
f.Power:SetStatusBarTexture(C["powerbar"].statusbar)
f.Power:SetAlpha(0)

f.Power.Value = f.Power:CreateFontString(nil, 'ARTWORK')

if (C['powerbar'].valueFontOutline) then
    f.Power.Value:SetFont(C['media'].fontNormal, C['powerbar'].valueFontSize, 'THINOUTLINE')
    f.Power.Value:SetShadowOffset(0, 0)
else
    f.Power.Value:SetFont(C['media'].fontNormal, C['powerbar'].valueFontSize)
    f.Power.Value:SetShadowOffset(1, -1)
end

f.Power.Value:SetPoint('CENTER', f.Power, 0, C['powerbar'].valueFontAdjustmentX)
f.Power.Value:SetVertexColor(1, 1, 1)

f.Power.Background = f.Power:CreateTexture(nil, 'BACKGROUND')
f.Power.Background:SetAllPoints(f.Power)
f.Power.Background:SetTexture(C["powerbar"].statusbar)
f.Power.Background:SetVertexColor(0.25, 0.25, 0.25, 1)

--[[f.Power.BackgroundShadow = CreateFrame('Frame', nil, f.Power)
f.Power.BackgroundShadow:SetFrameStrata('BACKGROUND')
f.Power.BackgroundShadow:SetPoint('TOPLEFT', -4, 4)
f.Power.BackgroundShadow:SetPoint('BOTTOMRIGHT', 4, -4)
f.Power.BackgroundShadow:SetBackdrop({
    BgFile = C["powerbar"].background,
    edgeFile = 'Interface\\Addons\\BasicUI\\Media\\Textures\\textureGlow', edgeSize = 4,
    insets = {left = 3, right = 3, top = 3, bottom = 3}
})
f.Power.BackgroundShadow:SetBackdropColor(0.15, 0.15, 0.15, 1)
f.Power.BackgroundShadow:SetBackdropBorderColor(0, 0, 0)]]

f.Power.Below = f.Power:CreateTexture(nil, 'BACKGROUND')
f.Power.Below:SetHeight(14)
f.Power.Below:SetWidth(14)
f.Power.Below:SetTexture('Interface\\AddOns\\BasicUI\\Media\\Textures\\textureArrowBelow')

f.Power.Above = f.Power:CreateTexture(nil, 'BACKGROUND')
f.Power.Above:SetHeight(14)
f.Power.Above:SetWidth(14)
f.Power.Above:SetTexture('Interface\\AddOns\\BasicUI\\Media\\Textures\\textureArrowAbove')
f.Power.Above:SetPoint('BOTTOM', f.Power.Below, 'TOP', 0, f.Power:GetHeight())

if (C['powerbar'].showCombatRegen) then
    f.mpreg = f.Power:CreateFontString(nil, 'ARTWORK')
    f.mpreg:SetFont(C['media'].fontNormal, 12, 'THINOUTLINE')
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
    local yOffset = C['powerbar'].energy.comboPointsBelow and -35 or 0

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

    if ((not C['powerbar'].energy.show and powerType == 'ENERGY') or (not C['powerbar'].showFocus and powerType == 'FOCUS') or (not C['powerbar'].showRage and powerType == 'RAGE') or (not C['powerbar'].showMana and powerType == 'MANA') or (not C['powerbar'].rune.show and powerType == 'RUNEPOWER') or UnitIsDeadOrGhost('player') or UnitHasVehicleUI('player')) then
        f.Power:SetAlpha(0)
    elseif (InCombatLockdown()) then
        newAlpha = C['powerbar'].activeAlpha
    elseif (not InCombatLockdown() and UnitPower('player') > 0) then
        newAlpha = C['powerbar'].inactiveAlpha
    else
        newAlpha = C['powerbar'].emptyAlpha
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

    if (C['powerbar'].valueAbbrev) then
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

    if (event == 'RUNE_TYPE_UPDATE' and C['powerbar'].rune.showRuneCooldown) then
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
            securecall('UIFrameFadeOut', f, 0.35, f:GetAlpha(), C['powerbar'].inactiveAlpha)
        end
    end

    if (event == 'PLAYER_REGEN_DISABLED') then
        securecall('UIFrameFadeIn', f, 0.35, f:GetAlpha(), 1)
    end

    if (event == 'PLAYER_REGEN_ENABLED') then
        securecall('UIFrameFadeOut', f, 0.35, f:GetAlpha(), C['powerbar'].inactiveAlpha)
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
