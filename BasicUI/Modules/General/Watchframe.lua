local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for Watchframe.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.
	
]]

local watchFrame = _G['WatchFrame']
watchFrame:SetHeight(400)
watchFrame:ClearAllPoints()
watchFrame.ClearAllPoints = function() end
watchFrame:SetPoint('TOPRIGHT', UIParent, -100, -250)
watchFrame:SetClampedToScreen(true)
watchFrame:SetMovable(true)
watchFrame:SetUserPlaced(true)
watchFrame.SetPoint = function() end
watchFrame:SetScale(1.01)

local watchHead = _G['WatchFrameHeader']
watchHead:EnableMouse(true)
watchHead:RegisterForDrag('LeftButton')
watchHead:SetHitRectInsets(-15, 0, -5, -5)
watchHead:SetScript('OnDragStart', function(self) 
    if (IsShiftKeyDown()) then
        self:GetParent():StartMoving()
    end
end)

watchHead:SetScript('OnDragStop', function(self) 
    self:GetParent():StopMovingOrSizing()
end)

watchHead:SetScript('OnEnter', function()
	if InCombatLockdown() then return end
	GameTooltip:SetOwner(watchHead, "ANCHOR_TOPLEFT")
	GameTooltip:ClearLines()
	GameTooltip:AddLine("|cffeda55fShift+Left Click|r to Drag")
	GameTooltip:Show()
end)
watchHead:SetScript('OnLeave', function() GameTooltip:Hide() end)

local watchHeadTitle = _G['WatchFrameTitle']
watchHeadTitle:SetFont(C['general'].font, 15)
watchHeadTitle:SetTextColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)