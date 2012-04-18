local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['buff'].enable ~= true then return end

local _G = _G
local unpack = unpack

--[[
_G.DAY_ONELETTER_ABBR = '|cffffffff%dd|r'
_G.HOUR_ONELETTER_ABBR = '|cffffffff%dh|r'
_G.MINUTE_ONELETTER_ABBR = '|cffffffff%dm|r'
_G.SECOND_ONELETTER_ABBR = '|cffffffff%d|r'

_G.DEBUFF_MAX_DISPLAY = 32 -- show more debuffs
_G.BUFF_MIN_ALPHA = 1
--]]

local origSecondsToTimeAbbrev = _G.SecondsToTimeAbbrev
local function SecondsToTimeAbbrevHook(seconds)
    origSecondsToTimeAbbrev(seconds)

    local tempTime
    if (seconds >= 86400) then
        tempTime = ceil(seconds / 86400)
        return '|cffffffff%dd|r', tempTime
    end

    if (seconds >= 3600) then
        tempTime = ceil(seconds / 3600)
        return '|cffffffff%dh|r', tempTime
    end

    if (seconds >= 60) then
        tempTime = ceil(seconds / 60)
        return '|cffffffff%dm|r', tempTime
    end

    return '|cffffffff%d|r', seconds
end
SecondsToTimeAbbrev = SecondsToTimeAbbrevHook

BuffFrame:SetScript('OnUpdate', nil)
hooksecurefunc(BuffFrame, 'Show', function(self)
    self:SetScript('OnUpdate', nil)
end)

-- TemporaryEnchantFrame ...
TempEnchant1:ClearAllPoints()
TempEnchant1:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -15, 0)
-- TempEnchant1.SetPoint = function() end

TempEnchant2:ClearAllPoints()
TempEnchant2:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -C['buff'].paddingX, 0)

ConsolidatedBuffs:SetSize(20, 20)
ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint('BOTTOM', TempEnchant1, 'TOP', 1, 2)
-- ConsolidatedBuffs.SetPoint = function() end

ConsolidatedBuffsIcon:SetAlpha(0)

ConsolidatedBuffsCount:ClearAllPoints()
ConsolidatedBuffsCount:SetPoint('CENTER', ConsolidatedBuffsIcon, 0, 1)
ConsolidatedBuffsCount:SetFont(C['media'].font, C['buff'].buffFontSize+2, 'THINOUTLINE')
ConsolidatedBuffsCount:SetShadowOffset(0, 0)

ConsolidatedBuffsContainer:SetScale(0.57)
ConsolidatedBuffsTooltip:SetScale(1.2)

local function UpdateFirstButton(self)
    if (self and self:IsShown()) then
        self:ClearAllPoints()
        if (UnitHasVehicleUI('player')) then
            self:SetPoint('TOPRIGHT', TempEnchant1)
            return
        else
            if (BuffFrame.numEnchants > 0) then
                self:SetPoint('TOPRIGHT', _G['TempEnchant'..BuffFrame.numEnchants], 'TOPLEFT', -C['buff'].paddingX, 0)
                return
            else
                self:SetPoint('TOPRIGHT', TempEnchant1)
                return
            end
        end
    end
end

local function CheckFirstButton()
    if (BuffButton1) then
        if (not BuffButton1:GetParent() == ConsolidatedBuffsContainer) then
            UpdateFirstButton(BuffButton1)
        end
    end
end

hooksecurefunc('BuffFrame_UpdatePositions', function()
    if (CONSOLIDATED_BUFF_ROW_HEIGHT ~= 26) then
        CONSOLIDATED_BUFF_ROW_HEIGHT = 26
    end
end)

hooksecurefunc('BuffFrame_UpdateAllBuffAnchors', function()  
    local previousBuff, aboveBuff
    local numBuffs = 0
    local numTotal = BuffFrame.numEnchants 

    for i = 1, BUFF_ACTUAL_DISPLAY do
        local buff = _G['BuffButton'..i]

        if (not buff.consolidated) then
            numBuffs = numBuffs + 1
            numTotal = numTotal + 1

            buff:ClearAllPoints()
            if (numBuffs == 1) then
                UpdateFirstButton(buff)
            elseif (numBuffs > 1 and mod(numTotal, C['buff'].buffPerRow) == 1) then
                if (numTotal == C['buff'].buffPerRow + 1) then
                    buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, -C['buff'].paddingY)
                else
                    buff:SetPoint('TOP', aboveBuff, 'BOTTOM', 0, -C['buff'].paddingY)
                end

                aboveBuff = buff
            else
                buff:SetPoint('TOPRIGHT', previousBuff, 'TOPLEFT', -C['buff'].paddingX, 0)
            end

            previousBuff = buff
        end
    end
end)

hooksecurefunc('DebuffButton_UpdateAnchors', function(self, index)
    local numBuffs = BUFF_ACTUAL_DISPLAY + BuffFrame.numEnchants
    if (BuffFrame.numConsolidated > 0) then
        numBuffs = numBuffs - BuffFrame.numConsolidated -- + 1
    end
    
    local rowSpacing
    local debuffSpace = C['buff'].buffSize + C['buff'].paddingY
    local numRows = ceil(numBuffs/C['buff'].buffPerRow)

    if (numRows and numRows > 1) then
        rowSpacing = -numRows * debuffSpace
    else
        rowSpacing = -debuffSpace
    end

    local buff = _G[self..index]
    buff:ClearAllPoints()

    if (index == 1) then
        buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, rowSpacing)
    elseif (index >= 2 and mod(index, C['buff'].buffPerRow) == 1) then
        buff:SetPoint('TOP', _G[self..(index-C['buff'].buffPerRow)], 'BOTTOM', 0, -C['buff'].paddingY)
    else
        buff:SetPoint('TOPRIGHT', _G[self..(index-1)], 'TOPLEFT', -C['buff'].paddingX, 0)
    end
end)

for i = 1, NUM_TEMP_ENCHANT_FRAMES do
    local button = _G['TempEnchant'..i]
	local borderbg = CreateFrame("Frame", nil, button)
	borderbg:SetPoint('TOPRIGHT', button, 4, 4)
	borderbg:SetPoint('BOTTOMLEFT', button, -4, -4)    
	borderbg:SetBackdrop({
		edgeFile = C['buff'].border,
		edgeSize = 20,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	})
	borderbg:SetBackdropBorderColor( 1, 0, 0)		
    button:SetScale(C['buff'].buffScale)
    button:SetSize(C['buff'].buffSize, C['buff'].buffSize)

    button:SetScript('OnShow', function()
        CheckFirstButton()
    end)

    button:SetScript('OnHide', function()
        CheckFirstButton()
    end)

    local icon = _G['TempEnchant'..i..'Icon']

    icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)

    local duration = _G['TempEnchant'..i..'Duration']
    duration:ClearAllPoints()
    duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, -2)
    duration:SetFont(C['media'].font, C['buff'].buffFontSize, 'THINOUTLINE')
    duration:SetShadowOffset(0, 0)
    duration:SetDrawLayer('OVERLAY')

    local border = _G['TempEnchant'..i..'Border']
	border:SetTexture(nil)
	border:ClearAllPoints()	
end

hooksecurefunc('AuraButton_Update', function(self, index)
    local button = _G[self..index]
    
    if (button and not button.Shadow) then
        if (button) then
            if (self:match('Debuff')) then
                button:SetSize(C['buff'].debuffSize, C['buff'].debuffSize)
                button:SetScale(C['buff'].debuffScale)
            else
                button:SetSize(C['buff'].buffSize, C['buff'].buffSize)
                button:SetScale(C['buff'].buffScale)
            end
        end

        local icon = _G[self..index..'Icon']
        if (icon) then
            icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)
        end

        local duration = _G[self..index..'Duration']
        if (duration) then
            duration:ClearAllPoints()
            duration:SetPoint('BOTTOM', button, 'BOTTOM', 0, 2)
            if (self:match('Debuff')) then
                duration:SetFont(C['media'].font, C['buff'].debuffFontSize, 'THINOUTLINE')
            else
                duration:SetFont(C['media'].font, C['buff'].buffFontSize, 'THINOUTLINE')
            end
            duration:SetShadowOffset(0, 0)
            duration:SetDrawLayer('OVERLAY')
        end

        local count = _G[self..index..'Count']
        if (count) then
            count:ClearAllPoints()
            count:SetPoint('TOP', button, 'TOP', 0, -2)
            if (self:match('Debuff')) then
                count:SetFont(C['media'].font, C['buff'].debuffCountSize, 'THINOUTLINE')
            else
                count:SetFont(C['media'].font, C['buff'].buffCountSize, 'THINOUTLINE')
            end
            count:SetShadowOffset(0, 0)
            count:SetDrawLayer('OVERLAY')
        end

        local border = _G[self..index..'Border']
        if (border) then
			border:SetTexture(nil)
			border:ClearAllPoints()
			local borderbg = CreateFrame("Frame", nil, button)
			borderbg:SetPoint('TOPRIGHT', button, 4, 4)
			borderbg:SetPoint('BOTTOMLEFT', button, -4, -4)    
			borderbg:SetBackdrop({
				edgeFile = C['buff'].border,
				edgeSize = 20,
			})
			borderbg:SetBackdropBorderColor( 1, 0, 0)
			borderbg:SetFrameStrata('MEDIUM')
        end

        if (button and not border) then
            if (not button.texture) then
                button.texture = button:CreateTexture('$parentOverlay', 'ARTWORK')
                button.texture:SetParent(button)
                button.texture:SetTexture(nil)
				button.texture:ClearAllPoints()
				local buttonbg = CreateFrame("Frame", nil, button)
				buttonbg:SetPoint('TOPRIGHT', button, 4, 4)
				buttonbg:SetPoint('BOTTOMLEFT', button, -4, -4)    
				buttonbg:SetBackdrop({
					edgeFile = C['buff'].border,
					edgeSize = 20,
				})
				buttonbg:SetBackdropBorderColor( B.ccolor.r, B.ccolor.g, B.ccolor.b)
				buttonbg:SetFrameStrata('MEDIUM')				
            end
        end
    end
end)