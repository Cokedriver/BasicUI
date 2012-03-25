local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['general'].itemquality ~= true then return end

-- IQB = Item Quality Border

local function UpdateIQB(button, id)
	local quality, texture, _
	if(id) then
		quality, _, _, _, _, _, _, texture = select(3, GetItemInfo(id))
	end

	local IQB = button.IQB
	if(not IQB) then
		IQB = CreateFrame("Frame", nil, button)
	    IQB:SetPoint("TOPLEFT", -3, 3)
		IQB:SetPoint("BOTTOMRIGHT", 3, -3)
		IQB:SetBackdrop({
			edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border',
			edgeSize = 21,
		})
		button.IQB = IQB
	end

	if(texture) then
		local r, g, b = GetItemQualityColor(quality)
		if _G[button:GetName().."IconQuestTexture"] and _G[button:GetName().."IconQuestTexture"]:IsShown() then
			r, g, b = 1, 0, 0
		end	
        IQB:SetBackdropBorderColor(r, g, b)		
		IQB:Show()
	else
		IQB:Hide()
	end	
end

local itemslots = {"Head", "Neck", "Shoulder", "Shirt", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "Finger0", "Finger1", "Trinket0", "Trinket1", "Back", "MainHand","SecondaryHand", "Ranged", "Tabard",}
for i = 1, getn(itemslots) do
	local button = _G["Character"..itemslots[i].."Slot"]
	local itemID = GetInventoryItemLink('player', button:GetID())
	UpdateIQB(button, itemID)
end

hooksecurefunc("BankFrameItemButton_Update", function(self)
	UpdateIQB(self, GetInventoryItemID("player", self:GetInventorySlot()))	
end)

hooksecurefunc("ContainerFrame_Update", function(self)
	for i=1, self.size do
		local button = _G[self:GetName().."Item"..i]
		local itemID = GetContainerItemID(self:GetID(), button:GetID())
		UpdateIQB(button, itemID)
	end		
end)
