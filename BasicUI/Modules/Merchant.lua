local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Merchant = BasicUI:NewModule("Merchant", "AceEvent-3.0")

--------------
-- Merchant --
--------------
function BasicUI_Merchant:OnEnable()
	local db = BasicUI.db.profile
	
	if db.merchant.enable ~= true then return end
	
	-- Credit for Merchant goes to Tuks for his Tukui project.
	-- You can find his Addon at http://tukui.org/dl.php
	-- Editied by Cokedriver

	local filter = {
		[6289]  = true, -- Raw Longjaw Mud Snapper
		[6291]  = true, -- Raw Brilliant Smallfish
		[6308]  = true, -- Raw Bristle Whisker Catfish
		[6309]  = true, -- 17 Pound Catfish
		[6310]  = true, -- 19 Pound Catfish
		[41808] = true, -- Bonescale Snapper
		[42336] = true, -- Bloodstone Band
		[42337] = true, -- Sun Rock Ring
		[43244] = true, -- Crystal Citrine Necklace
		[43571] = true, -- Sewer Carp
		[43572] = true, -- Magic Eater		
	}

	local f = CreateFrame("Frame")
	f:SetScript("OnEvent", function()
		if db.merchant.autoSellGrey or db.merchant.sellMisc then
			local c = 0
			for b=0,4 do
				for s=1,GetContainerNumSlots(b) do
					local l,lid = GetContainerItemLink(b, s), GetContainerItemID(b, s)
					if l and lid then
						local p = select(11, GetItemInfo(l))*select(2, GetContainerItemInfo(b, s))
						if db.merchant.autoSellGrey and select(3, GetItemInfo(l))==0 then
							UseContainerItem(b, s)
							PickupMerchantItem()
							c = c+p
						end
						if db.merchant.sellMisc and filter[ lid ] then
							UseContainerItem(b, s)
							PickupMerchantItem()
							c = c+p
						end
					end
				end
			end
			if c>0 then
				local g, s, c = math.floor(c/10000) or 0, math.floor((c%10000)/100) or 0, c%100
				DEFAULT_CHAT_FRAME:AddMessage("Your grey item's have been sold for".." |cffffffff"..g.."|cffffd700g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r"..".",255,255,0)
			end
		end
		if not IsShiftKeyDown() then
			if CanMerchantRepair() and db.merchant.autoRepair then	
				guildRepairFlag = 0
				local cost, possible = GetRepairAllCost()
				-- additional checks for guild repairs
				if (IsInGuild()) and (CanGuildBankRepair()) then
					 if cost <= GetGuildBankWithdrawMoney() then
						guildRepairFlag = 1
					 end
				end
				if cost>0 then
					if (possible or guildRepairFlag) then
						RepairAllItems(guildRepairFlag)
						local c = cost%100
						local s = math.floor((cost%10000)/100)
						local g = math.floor(cost/10000)
						if db.merchant.gpay == "true" and guildRepairFlag == 1 then
							DEFAULT_CHAT_FRAME:AddMessage("Your guild payed".." |cffffffff"..g.."|cffffd700g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r".." to repair your gear.",255,255,0)
						else
							DEFAULT_CHAT_FRAME:AddMessage("You payed".." |cffffffff"..g.."|cffffd700g|r".." |cffffffff"..s.."|cffc7c7cfs|r".." |cffffffff"..c.."|cffeda55fc|r".." to repair your gear.",255,255,0)
						end	
					else
						DEFAULT_CHAT_FRAME:AddMessage("You don't have enough money for repair!",255,0,0)
					end
				end		
			end
		end
	end)
	f:RegisterEvent("MERCHANT_SHOW")
	
	-- Autogreed roll on greens.
	local skipList = {
		--['Stone Scarab'] = true,
		--['Silver Scarab'] = true,
	}

	local ag = CreateFrame('Frame')
	ag:RegisterEvent('START_LOOT_ROLL')
	ag:SetScript('OnEvent', function(_, _, RollID)
		local texture, name, count, quality, bindOnPickUp , canNeed, canGreed, canDisenchant = GetLootRollItemInfo(RollID)
		
		if db.merchant.disenchant ~= true then
			if (quality == 2 and not bindOnPickUp) then
				RollOnLoot(RollID, canGreed and 3 or 2)
			end
		else
			if (quality == 2 and not bindOnPickUp) then
				RollOnLoot(RollID, canDisenchant and 3 or 2)
			end
		end
	end)

	-- Add Alt Buy Full Stacks
    -- just a new color

	local NEW_ITEM_VENDOR_STACK_BUY = ITEM_VENDOR_STACK_BUY
	ITEM_VENDOR_STACK_BUY = '|cffa9ff00'..NEW_ITEM_VENDOR_STACK_BUY..'|r'

	-- alt-click to buy a stack
	local origMerchantItemButton_OnModifiedClick = _G.MerchantItemButton_OnModifiedClick
	local function MerchantItemButton_OnModifiedClickHook(self, ...)
		origMerchantItemButton_OnModifiedClick(self, ...)

		if (IsAltKeyDown()) then
			local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))
			local _, _, _, quantity = GetMerchantItemInfo(self:GetID())

			if (maxStack and maxStack > 1) then
				BuyMerchantItem(self:GetID(), floor(maxStack / quantity))
			end
		end
	end
	MerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClickHook

	-- Google translate ftw...NOT
	local function GetAltClickString()
		if (GetLocale() == 'enUS') then
			return '<Alt-click, to buy an stack>'
		elseif (GetLocale() == 'frFR') then
			return '<Alt-clic, d acheter une pile>'
		elseif (GetLocale() == 'esES') then
			return '<Alt-clic, para comprar una pila>'
		elseif (GetLocale() == 'deDE') then
			return '<Alt-klicken, um einen ganzen Stapel zu kaufen>'
		else
			return '<Alt-click, to buy an stack>'
		end
	end

	-- add a hint to the tooltip
	local function IsMerchantButtonOver()
		return GetMouseFocus():GetName() and GetMouseFocus():GetName():find('MerchantItem%d')
	end

	GameTooltip:HookScript('OnTooltipSetItem', function(self)
		if (MerchantFrame:IsShown() and IsMerchantButtonOver()) then 
			for i = 2, GameTooltip:NumLines() do
				if (_G['GameTooltipTextLeft'..i]:GetText():find('<[sS]hift')) then
					GameTooltip:AddLine('|cff00ffcc'..GetAltClickString()..'|r')
				end
			end
		end
	end)
end