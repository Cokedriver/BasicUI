local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Quicky = BasicUI:NewModule("Quicky", "AceEvent-3.0")

---------------
-- Quicky --
---------------
function BasicUI_Quicky:OnEnable()
	local db = BasicUI.db.profile

	if db.misc.quicky ~= true then return end

	local f = CreateFrame('Frame')

	f.Head = CreateFrame('Button', nil, CharacterHeadSlot)
	f.Head:SetFrameStrata('HIGH')
	f.Head:SetSize(16, 32)
	f.Head:SetPoint('LEFT', CharacterHeadSlot, 'CENTER', 9, 0)

	f.Head:SetScript('OnClick', function() 
		ShowHelm(not ShowingHelm()) 
	end)

	f.Head:SetScript('OnEnter', function(self) 
		GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 13, -10)
		GameTooltip:AddLine(SHOW_HELM)
		GameTooltip:Show()
	end)

	f.Head:SetScript('OnLeave', function() 
		GameTooltip:Hide()
	end)

	f.Head:SetNormalTexture([[Interface\AddOns\BasicUI\Media\textureNormal]])
	f.Head:SetHighlightTexture([[Interface\AddOns\BasicUI\Media\textureHighlight]])
	f.Head:SetPushedTexture([[Interface\AddOns\BasicUI\Media\texturePushed]])

	CharacterHeadSlotPopoutButton:SetScript('OnShow', function()
		f.Head:ClearAllPoints()
		f.Head:SetPoint('RIGHT', CharacterHeadSlot, 'CENTER', -9, 0)
	end)

	CharacterHeadSlotPopoutButton:SetScript('OnHide', function()
		f.Head:ClearAllPoints()
		f.Head:SetPoint('LEFT', CharacterHeadSlot, 'CENTER', 9, 0)
	end)

	f.Cloak = CreateFrame('Button', nil, CharacterBackSlot)
	f.Cloak:SetFrameStrata('HIGH')
	f.Cloak:SetSize(16, 32)
	f.Cloak:SetPoint('LEFT', CharacterBackSlot, 'CENTER', 9, 0)

	f.Cloak:SetScript('OnClick', function() 
		ShowCloak(not ShowingCloak()) 
	end)

	f.Cloak:SetScript('OnEnter', function(self) 
		GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 13, -10)
		GameTooltip:AddLine(SHOW_CLOAK)
		GameTooltip:Show()
	end)

	f.Cloak:SetScript('OnLeave', function() 
		GameTooltip:Hide()
	end)

	f.Cloak:SetNormalTexture([[Interface\AddOns\BasicUI\Media\textureNormal]])
	f.Cloak:SetHighlightTexture([[Interface\AddOns\BasicUI\Media\textureHighlight]])
	f.Cloak:SetPushedTexture([[Interface\AddOns\BasicUI\Media\texturePushed]])

	CharacterBackSlotPopoutButton:SetScript('OnShow', function()
		f.Cloak:ClearAllPoints()
		f.Cloak:SetPoint('RIGHT', CharacterBackSlot, 'CENTER', -9, 0)
	end)

	CharacterBackSlotPopoutButton:SetScript('OnHide', function()
		f.Cloak:ClearAllPoints()
		f.Cloak:SetPoint('LEFT', CharacterBackSlot, 'CENTER', 9, 0)
	end)
end