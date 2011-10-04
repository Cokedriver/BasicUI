local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['general'].buttons.enable ~= true then return end

 -- Hide Keybindings
if C['general'].buttons.showHotKeys ~= true then
	function ActionButton_UpdateHotkeys(self, actionButtonType) end
end

 -- Hide Macro Names
hooksecurefunc('ActionButton_Update', function(self)
    local macroname = _G[self:GetName()..'Name']
    if (not C['general'].buttons.showMacronames) then
        macroname:SetAlpha(0)
    end
end)

--hooksecurefunc('ActionButton_UpdateHotkeys', function(self, actionButtonType) end)

hooksecurefunc('ActionButton_UpdateUsable', function(self)
    if (IsAddOnLoaded('RedRange') or IsAddOnLoaded('GreenRange') or IsAddOnLoaded('tullaRange') or IsAddOnLoaded('RangeColors')) then
        return
    end    
	
    local isUsable, notEnoughMana = IsUsableAction(self.action)
    if (isUsable) then
        _G[self:GetName()..'Icon']:SetVertexColor(1, 1, 1)
    elseif (notEnoughMana) then
        _G[self:GetName()..'Icon']:SetVertexColor(C['general'].buttons.color.OutOfMana.r,C['general'].buttons.color.OutOfMana.g,C['general'].buttons.color.OutOfMana.b)
    else
        _G[self:GetName()..'Icon']:SetVertexColor(C['general'].buttons.color.NotUsable.r, C['general'].buttons.color.NotUsable.g, C['general'].buttons.color.NotUsable.b)
    end
end)

function ActionButton_OnUpdate(self, elapsed)
    if (IsAddOnLoaded('RedRange') or IsAddOnLoaded('GreenRange') or IsAddOnLoaded('tullaRange') or IsAddOnLoaded('RangeColors')) then
        return
    end     

    if (ActionButton_IsFlashing(self)) then
        local flashtime = self.flashtime
        flashtime = flashtime - elapsed

        if (flashtime <= 0) then
            local overtime = - flashtime
            if (overtime >= ATTACK_BUTTON_FLASH_TIME) then
                overtime = 0
            end

            flashtime = ATTACK_BUTTON_FLASH_TIME - overtime

            local flashTexture = _G[self:GetName()..'Flash']
            if (flashTexture:IsShown()) then
                flashTexture:Hide()
            else
                flashTexture:Show()
            end
        end

        self.flashtime = flashtime
    end

    local rangeTimer = self.rangeTimer
    if (rangeTimer) then
        rangeTimer = rangeTimer - elapsed
        if (rangeTimer <= 0.1) then
            local isInRange = false
            if (ActionHasRange(self.action) and IsActionInRange(self.action) == 0) then
                _G[self:GetName()..'Icon']:SetVertexColor(C['general'].buttons.color.OutOfRange.r, C['general'].buttons.color.OutOfRange.g, C['general'].buttons.color.OutOfRange.b)
                isInRange = true
            end

            if (self.isInRange ~= isInRange) then
                self.isInRange = isInRange
                ActionButton_UpdateUsable(self)
            end

            rangeTimer = TOOLTIP_UPDATE_TIME
        end

        self.rangeTimer = rangeTimer
    end
end