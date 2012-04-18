local N, C, DB = unpack(select(2, ...)) -- Import:  N - function; C - config; DB - database

if C['nameplates'].enable ~= true then return end

    -- Local stuff

local len = string.len
local find = string.find
local gsub = string.gsub

local select = select
local tonumber = tonumber

local UnitName = UnitName
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo

local borderColor = {0.47, 0.47, 0.47}
local noThreatColor = {0, 1, 0}

local nameplateFlashTexture = 'Interface\\TargetingFrame\\UI-TargetingFrame-Flash'

local glowTexture = 'Interface\\AddOns\\BasicUI\\Media\\Textures\\NameplateNewGlow_LessGlow'
local overlayTexture = 'Interface\\AddOns\\BasicUI\\Media\\Textures\\NameplateOverlay'
local whiteOverlay = 'Interface\\AddOns\\BasicUI\\Media\\Textures\\NameplateIconOverlay'

local total = -1
local namePlate, frames

local f = CreateFrame('Frame', nil, UIParent)

f.elapsed = 0  
f.elapsedLong = 0  


f:RegisterEvent('PLAYER_TARGET_CHANGED')

--[[
f:RegisterEvent('UNIT_TARGET')
f:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE')
f:RegisterEvent('UNIT_THREAT_LIST_UPDATE')
f:RegisterEvent('PLAYER_REGEN_ENABLED')
f:RegisterEvent('PLAYER_REGEN_DISABLED')
f:RegisterEvent('PLAYER_CONTROL_LOST')
f:RegisterEvent('PLAYER_CONTROL_GAINED')
--]]

    -- Totem data and functions

local function TotemName(SpellID)
    local name = GetSpellInfo(SpellID)
    return name
end

local function TotemIcon(SpellID)
    local _, _, icon = GetSpellInfo(SpellID)
    return icon
end

local totemData = {
    [TotemName(8177)] = {TotemIcon(8177)}, -- Grounding Totem
    [TotemName(8512)] = {TotemIcon(8512)}, -- Windfury Totem
    [TotemName(3738)] = {TotemIcon(3738)}, -- Wrath of Air Totem

    [TotemName(2062)] = {TotemIcon(2062)}, -- Earth Elemental Totem
    [TotemName(2484)] = {TotemIcon(2484)}, -- Earthbind Totem
    [TotemName(5730)] = {TotemIcon(5730)}, -- Stoneclaw Totem
    [TotemName(8071)] = {TotemIcon(8071)}, -- Stoneskin Totem
    [TotemName(8075)] = {TotemIcon(8075)}, -- Strength of Earth Totem
    [TotemName(8143)] = {TotemIcon(8143)}, -- Tremor Totem

    [TotemName(2894)] = {TotemIcon(2894)}, -- Fire Elemental Totem
    [TotemName(8227)] = {TotemIcon(8227)}, -- Flametongue Totem
    [TotemName(8190)] = {TotemIcon(8190)}, -- Magma Totem
    [TotemName(3599)] = {TotemIcon(3599)}, -- Searing Totem

    [TotemName(8184)] = {TotemIcon(8184)}, -- Elemental Resistance Totem
    [TotemName(5394)] = {TotemIcon(5394)}, -- Healing Stream Totem
    [TotemName(5675)] = {TotemIcon(5675)}, -- Mana Spring Totem
    [TotemName(16190)] = {TotemIcon(16190)}, -- Mana Tide Totem
    [TotemName(87718)] = {TotemIcon(87718)}, -- Totem of Tranquil Mind
}

    -- Some general functions

local function FormatValue(number)
    if (number >= 1e6) then
        return tonumber(format('%.1f', number/1e6))..'m'
    elseif (number >= 1e3) then
        return tonumber(format('%.1f', number/1e3))..'k'
    else
        return number
    end
end

local function RGBHex(r, g, b)
    if (type(r) == 'table') then
        if (r.r) then 
            r, g, b = r.r, r.g, r.b 
        else 
            r, g, b = unpack(r) 
        end
    end

    return ('|cff%02x%02x%02x'):format(r * 255, g * 255, b * 255)
end

    -- The plate functions

local function GetUnitReaction(r, g, b)
    if (g + b == 0) then
        return true
    end

    return false
end

local function GetUnitCombatStatus(r, g, b)
    if (r >= 0.98) then
        return true
    end

    return false
end

local function IsTarget(self) 
    local targetExists = UnitExists('target')
    if (not targetExists) then
        return false
    end

    local targetName = UnitName('target')
    if (targetName == self.Name:GetText() and self:GetAlpha() >= 0.99) then
        return true
    else
        return false
    end
end

local function CanHaveThreat(r, g, b)
    if (r < .01 and b < .01 and g > .99) then 
        return false
    elseif (r < .01 and b > .99 and g < .01) then 
        return false
    elseif (r > .99 and b < .01 and g > .99) then 
        return false
    elseif (r > .99 and b < .01 and g < .01) then 
        return true
    else 
        return true
    end
end

local function UpdateTotemIcon(self)
    if (totemData[self.Name:GetText()]) then
        if (not self.Icon) then
            self.Icon = CreateFrame('Frame', nil, self)
            self.Icon:EnableMouse(false)
            self.Icon:SetSize(24, 24)
            self.Icon:SetPoint('BOTTOM', self.NewName, 'TOP', 0, 1)
        end

        local icon = totemData[self.Name:GetText()]
        self.Icon:SetBackdrop({
            bgFile = icon[1], 
            edgeFile = 'Interface\\Buttons\\WHITE8x8', 
            edgeSize = 1.5,
            insets = { top = -0, left = -0, bottom = -0, right = -0 },
        })

        local r, g, b = self.Health:GetStatusBarColor()
        self.Icon:SetBackdropBorderColor(r, g, b, 1)
        self.Icon:Show()
    else
        if (self.Icon) then
            self.Icon:SetBackdrop(nil)
            self.Icon:Hide()
            self.Icon = nil
        end
    end
end

local function UpdateThreatColor(self)
    local r, g, b
    local playerInfight = InCombatLockdown()
    local unitInfight = GetUnitCombatStatus(self.Name:GetTextColor())
    local lowThreat = unitInfight and playerInfight
    local isEnemy = GetUnitReaction(self.Health:GetStatusBarColor())

    if (lowThreat and not self.Glow:IsVisible() and isEnemy and C['nameplates'].enableTankMode) then
        r, g, b = unpack(noThreatColor)
        self.NewGlow:SetVertexColor(r, g, b)
        
        if (not self.NewGlow:IsVisible()) then
            self.NewGlow:Show()
        end

        if (C['nameplates'].colorNameWithThreat) then
            self.NewName:SetTextColor(r * 0.7, g * 0.7, b * 0.7)
        end
    elseif (self.Glow:IsVisible()) then
        r, g, b = self.Glow:GetVertexColor()
        self.NewGlow:SetVertexColor(r, g, b)

        if (not self.NewGlow:IsVisible()) then
            self.NewGlow:Show()
        end

        if (C['nameplates'].colorNameWithThreat) then
            self.NewName:SetTextColor(r, g, b)
        end
    else
        if (self.NewGlow:IsVisible()) then
            self.NewGlow:Hide()

            if (C['nameplates'].colorNameWithThreat) then
                self.NewName:SetTextColor(1, 1, 1)
            end
        end
    end
end

local function UpdateHealthText(self)
    local min, max = self.Health:GetMinMaxValues()
    local currentValue = self.Health:GetValue()
    local perc = (currentValue/max)*100	

    if (perc >= 100 and currentValue > 5 and C['nameplates'].showFullHP) then
        self.Health.Value:SetFormattedText('%s', FormatValue(currentValue))		
    elseif (perc < 100 and currentValue > 5) then
        self.Health.Value:SetFormattedText('%s - %.0f%%', FormatValue(currentValue), perc-0.5)
    else
        self.Health.Value:SetText('')
    end
end

local function UpdateHealthColor(self)
    local r, g, b = self.Health:GetStatusBarColor()
    if (r + g == 0) then
        self.Health:SetStatusBarColor(0, 0.35, 1)
        return
    end
end

local function UpdateCastbarValue(self, curValue)
    local _, maxValue = self:GetMinMaxValues()
    local cast = UnitCastingInfo('target')
    local channel = UnitChannelInfo('target')

    if (self.Shield:IsShown()) then
        self.Overlay:SetVertexColor(1, 0, 1, 1)
        self.Overlay:Show()
    else
        local r, g, b = unpack(borderColor)
        self.Overlay:SetVertexColor(r, g, b, 1 )
    end

    if (channel) then
        self.CastTime:SetFormattedText('%.1fs', curValue)
    else
        self.CastTime:SetFormattedText('%.1fs', maxValue - curValue)
    end

    self.Name:SetText(cast or channel)
end


local function UpdateNameL(self)
    local newName = self.Name:GetText()
    if (C['nameplates'].abbrevLongNames) then
        newName = (len(newName) > 20) and gsub(newName, '%s?(.[\128-\191]*)%S+%s', '%1. ') or newName
    end
    
    self.NewName:SetTextColor(1, 1, 1)
    if (C['nameplates'].showLevel) then
        local levelText = self.Level:GetText()
        local levelColor = RGBHex(self.Level:GetTextColor())
        local eliteTexture = self.EliteIcon:IsVisible()
		local classification = UnitClassification(unit);

        if (self.BossIcon:IsVisible()) then
            self.NewName:SetText('|cffff0000??|r '..newName)
        elseif (eliteTexture) then
            self.NewName:SetText('|cffffff00+|r'..levelColor..levelText..'|r '..newName)
        else
            self.NewName:SetText(levelColor..levelText..'|r '..newName)
        end
    else
        self.NewName:SetText(newName)
    end
end

local function UpdateEliteTexture(self)
    local r, g, b = unpack(borderColor)
    if (self.BossIcon:IsVisible() or self.EliteIcon:IsVisible()) then
        self.Overlay:SetGradientAlpha('HORIZONTAL', r, g, b, 1, 1, 1, 0, 1)
    else
        self.Overlay:SetVertexColor(r, g, b, 1)
    end
end

local function UpdatePlate(self)
    if (self.Level) then
        UpdateNameL(self)
    end

    if (C['nameplates'].showEliteBorder) then
        UpdateEliteTexture(self)
    else
        local r, g, b = unpack(borderColor)
        self.Overlay:SetVertexColor(r, g, b, 1)
    end

    if (C['nameplates'].showTotemIcon) then
        UpdateTotemIcon(self)
    end

    UpdateHealthText(self)
    UpdateHealthColor(self)
    UpdateThreatColor(self)

    self.Highlight:ClearAllPoints()
    self.Highlight:SetAllPoints(self.Health)

    if (self.Castbar:IsVisible()) then     
        self.Castbar:Hide() 
    end

    local r, g, b = self.Health:GetStatusBarColor()
    self.Castbar.IconOverlay:SetVertexColor(r, g, b)
end

local function SkinPlate(self)
    self.Health, self.Castbar = self:GetChildren()
    _, self.Castbar.Overlay, self.Castbar.Shield, self.Castbar.Icon = self.Castbar:GetRegions()
    self.Glow, self.Overlay, self.Highlight, self.Name, self.Level, self.BossIcon, self.RaidIcon, self.EliteIcon = self:GetRegions()

        -- Hide some nameplate objects

    self.Glow:SetTexCoord(0, 0, 0, 0)
    self.BossIcon:SetTexCoord(0, 0, 0, 0)
    self.EliteIcon:SetTexCoord(0, 0, 0, 0)
    self.Castbar.Shield:SetTexCoord(0, 0, 0, 0)

    self.Name:SetWidth(0.001)
    self.Level:SetWidth(0.0001)

        -- Modify the overlay

    self.Overlay:SetTexCoord(0, 1, 1, 0)
    self.Overlay:ClearAllPoints()
    --self.Overlay:SetPoint('TOPRIGHT', self.Health, 35.66666667, 5.66666667)
    --self.Overlay:SetPoint('BOTTOMLEFT', self.Health, -36.66666667, -5.66666667)
    self.Overlay:SetPoint('TOPRIGHT', self.Health, 29.66666667, 4.66666667)
    self.Overlay:SetPoint('BOTTOMLEFT', self.Health, -31.66666667, -4.66666667)	
    self.Overlay:SetDrawLayer('BORDER')
    self.Overlay:SetTexture(overlayTexture)


        -- Healtbar and background

    self.Health:SetBackdrop({
        bgFile = 'Interface\\Buttons\\WHITE8x8',
        insets = { left = -1, right = -1, top = -1, bottom = -1 }
    })
    self.Health:SetBackdropColor(0, 0, 0, 0.55)

    self.Health:SetScript('OnValueChanged', function()
        UpdateHealthText(self)
        UpdateHealthColor(self)
    end)

        -- Create health value font string

    if (not self.Health.Value) then    
        self.Health.Value = self.Health:CreateFontString(nil, 'OVERLAY')
        self.Health.Value:SetPoint('CENTER', self.Health, 0, 0)
        self.Health.Value:SetFont(C['media'].font, 12)
        self.Health.Value:SetShadowOffset(1, -1)
    end

    if (not self.NewName) then
        self.NewName = self:CreateFontString(nil, 'ARTWORK')
        self.NewName:SetFont(C['media'].font, 11, 'THINOUTLINE')
        self.NewName:SetShadowOffset(0, 0)
        self.NewName:SetPoint('BOTTOM', self.Health, 'TOP', 0, 2)
        self.NewName:SetSize(110, 13)
    end

    if (not self.NewGlow) then
        self.NewGlow = self.Health:CreateTexture(nil, 'BACKGROUND')
        self.NewGlow:SetTexture(glowTexture)
        self.NewGlow:SetAllPoints(self.Overlay)
        self.NewGlow:Hide()
    end

        -- Castbar

    self.Castbar:SetBackdrop({
        bgFile = 'Interface\\Buttons\\WHITE8x8',
        insets = { left = -1, right = -1, top = -1, bottom = -1 }
    })
    self.Castbar:SetBackdropColor(0.2, 0.2, 0.2, 0.5)

    self.Castbar:ClearAllPoints()
    self.Castbar:SetPoint('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, -9)
    self.Castbar:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMLEFT', 0, -20)

    self.Castbar:HookScript('OnValueChanged', UpdateCastbarValue)

    self.Castbar.Overlay:SetTexCoord(0, 1, 0, 1)
    self.Castbar.Overlay:SetDrawLayer('BORDER')
    self.Castbar.Overlay:SetTexture(overlayTexture)
    self.Castbar.Overlay:ClearAllPoints()
    self.Castbar.Overlay:SetPoint('TOPRIGHT', self.Castbar, 35.66666667, 5.66666667)
    self.Castbar.Overlay:SetPoint('BOTTOMLEFT', self.Castbar, -36.66666667, -5.66666667)
    
        -- Castbar casttime font string

    if (not self.Castbar.CastTime) then   
        self.Castbar.CastTime = self.Castbar:CreateFontString(nil, 'OVERLAY')
        self.Castbar.CastTime:SetPoint('RIGHT', self.Castbar, 1.6666667, 0)
        self.Castbar.CastTime:SetFont(C['media'].font, 16)   -- , 'THINOUTLINE')
        self.Castbar.CastTime:SetTextColor(1, 1, 1)
        self.Castbar.CastTime:SetShadowOffset(1, -1)
    end

        -- Castbar castname font string

    if (not self.Castbar.Name) then
        self.Castbar.Name = self.Castbar:CreateFontString(nil, 'OVERLAY')
        self.Castbar.Name:SetPoint('LEFT', self.Castbar, 1.5, 0)
        self.Castbar.Name:SetPoint('RIGHT', self.Castbar.CastTime, 'LEFT', -6, 0)
        self.Castbar.Name:SetFont(C['media'].font, 10)
        self.Castbar.Name:SetTextColor(1, 1, 1)
        self.Castbar.Name:SetShadowOffset(1, -1)
        self.Castbar.Name:SetJustifyH('LEFT')
    end

        -- Castbar spellicon and overlay

    self.Castbar.Icon:SetParent(self.Castbar)
    self.Castbar.Icon:ClearAllPoints()
    self.Castbar.Icon:SetPoint('BOTTOMLEFT', self.Castbar, 'BOTTOMRIGHT', 7, 3)
    self.Castbar.Icon:SetSize(24, 24)
    self.Castbar.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    self.Castbar.Icon:SetDrawLayer('BACKGROUND')

    if (not self.Castbar.IconOverlay) then
        self.Castbar.IconOverlay = self.Castbar:CreateTexture(nil, 'OVERLAY')
        self.Castbar.IconOverlay:SetPoint('TOPLEFT', self.Castbar.Icon, -1, 1)
        self.Castbar.IconOverlay:SetPoint('BOTTOMRIGHT', self.Castbar.Icon, 1, -1)
        self.Castbar.IconOverlay:SetTexture(whiteOverlay)
    end

        -- Mouseover highlight

    self.Highlight:SetTexture(1, 1, 1, 0.2)

        -- Raidicons

    self.RaidIcon:ClearAllPoints()
    self.RaidIcon:SetDrawLayer('OVERLAY')
    self.RaidIcon:SetPoint('CENTER', self.Health, 'TOP', 0, 12)
    self.RaidIcon:SetSize(16, 16)

        -- Nameplates like cookies

    UpdatePlate(self)

    self:SetScript('OnUpdate', nil)
    self:SetScript('OnShow', UpdatePlate)

    self:SetScript('OnHide', function(self)
        self.Highlight:Hide()
    end)
    
    f:HookScript('OnUpdate', function(_, elapsed)
        if (not self:IsVisible()) then
            return
        end

        f.elapsed = f.elapsed + elapsed
        if (f.elapsed >= 0.1) then
            if ((CanHaveThreat(self.Health:GetStatusBarColor()) and InCombatLockdown()) or self.NewGlow:IsShown()) then
                UpdateThreatColor(self)
            end

            if (C['nameplates'].showTargetBorder) then
                if (IsTarget(self)) then
                    if (not self.TargetHighlight) then
                        self.TargetHighlight = self:CreateTexture(nil, 'ARTWORK')
                        self.TargetHighlight:SetAllPoints(self.Overlay)
                        self.TargetHighlight:SetTexture(overlayTexture)
                        self.TargetHighlight:Hide()
                    end

                    if (not self.TargetHighlight:IsVisible()) then
                        self.TargetHighlight:Show()
                    end
                else
                    if (self.TargetHighlight and self.TargetHighlight:IsVisible()) then
                        self.TargetHighlight:Hide()
                    end
                end
            end

            -- UpdateTargetBorder(self)
            f.elapsed = 0
        end

        f.elapsedLong = f.elapsedLong + elapsed
        if (f.elapsedLong >= 0.49) then
            UpdateHealthColor(self)

            f.elapsedLong = 0
        end
    end)

    --[[
    f:HookScript('OnEvent', function(_, event)
        if (CanHaveThreat(self.Health:GetStatusBarColor())) then
            if (event == 'UNIT_THREAT_LIST_UPDATE' or event == 'UNIT_THREAT_SITUATION_UPDATE' or event == 'PLAYER_REGEN_ENABLED' or event == 'PLAYER_REGEN_DISABLED') then
                UpdateThreatColor(self)
            end
        else
            if (self.NewGlow:IsVisible()) then
                self.NewGlow:Hide()
            end
        end
    end)
    --]]
end

    -- Scan the worldframe for nameplates

local function IsNameplate(self)
    -- local region = self:GetRegions()
    -- return region region:GetObjectType() == 'Texture' and region:GetTexture() == nameplateFlashTexture
    return self:GetName() and self:GetName():find('NamePlate(%d)')
end

f:SetScript('OnUpdate', function()
    frames = select('#', WorldFrame:GetChildren())
    if (frames ~= total) then
        for i = 1, frames do
            namePlate = select(i, WorldFrame:GetChildren())
            if (IsNameplate(namePlate) and not namePlate.NewName) then
                SkinPlate(namePlate)
            end

            total = frames
        end
    end
end)