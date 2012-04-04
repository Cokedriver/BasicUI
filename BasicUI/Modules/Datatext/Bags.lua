local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for Bags.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if C['datatext'].enable ~= true then return end

if C['datatext'].bags and C['datatext'].bags > 0 then
	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].bags, Text)

	local defaultColor = { 1, 1, 1 }
	local Profit	= 0
	local Spent		= 0
	local OldMoney	= 0	
	
	local function formatMoney(c)
		local str = ""
		if not c or c < 0 then 
			return str 
		end
		
		if c >= 10000 then
			local g = math.floor(c/10000)
			c = c - g*10000
			str = str.."|cFFFFD800"..g.."|r|TInterface\\MoneyFrame\\UI-GoldIcon.blp:0:0:0:0|t"
		end
		if c >= 100 then
			local s = math.floor(c/100)
			c = c - s*100
			str = str.."|cFFC7C7C7"..s.."|r|TInterface\\MoneyFrame\\UI-SilverIcon.blp:0:0:0:0|t"
		end
		if c >= 0 then
			str = str.."|cFFEEA55F"..c.."|r|TInterface\\MoneyFrame\\UI-CopperIcon.blp:0:0:0:0|t"
		end
		
		return str
	end
	
	local function FormatTooltipMoney(c)
		if not c then return end
		local str = ""
		if not c or c < 0 then 
			return str 
		end
		
		if c >= 10000 then
			local g = math.floor(c/10000)
			c = c - g*10000
			str = str.."|cFFFFD800"..g.."|r|TInterface\\MoneyFrame\\UI-GoldIcon.blp:0:0:0:0|t"
		end
		if c >= 100 then
			local s = math.floor(c/100)
			c = c - s*100
			str = str.."|cFFC7C7C7"..s.."|r|TInterface\\MoneyFrame\\UI-SilverIcon.blp:0:0:0:0|t"
		end
		if c >= 0 then
			str = str.."|cFFEEA55F"..c.."|r|TInterface\\MoneyFrame\\UI-CopperIcon.blp:0:0:0:0|t"
		end
		
		return str
	end	
	Stat:SetScript("OnEnter", function(self)
		if InCombatLockdown() then return end
		
		local anchor, panel, xoff, yoff = B.DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(hexa..B.myname.."'s"..hexb.." Gold")
		GameTooltip:AddLine' '			
		GameTooltip:AddLine("Session: ")
		GameTooltip:AddDoubleLine("Earned:", formatMoney(Profit), 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine("Spent:", formatMoney(Spent), 1, 1, 1, 1, 1, 1)
		if Profit < Spent then
			GameTooltip:AddDoubleLine("Deficit:", formatMoney(Profit-Spent), 1, 0, 0, 1, 1, 1)
		elseif (Profit-Spent)>0 then
			GameTooltip:AddDoubleLine("Profit:", formatMoney(Profit-Spent), 0, 1, 0, 1, 1, 1)
		end				
		GameTooltip:AddLine' '								
	
		local totalGold = 0				
		GameTooltip:AddLine("Character: ")			
		for k,_ in pairs(BasicDB[B.myrealm]) do
			if BasicDB[B.myrealm][k]["gold"] then 
				GameTooltip:AddDoubleLine(k, FormatTooltipMoney(BasicDB[B.myrealm][k]["gold"]), 1, 1, 1, 1, 1, 1)
				totalGold=totalGold+BasicDB[B.myrealm][k]["gold"]
			end
		end 
		GameTooltip:AddLine' '
		GameTooltip:AddLine("Server: ")
		GameTooltip:AddDoubleLine("Total: ", FormatTooltipMoney(totalGold), 1, 1, 1, 1, 1, 1)

		for i = 1, MAX_WATCHED_TOKENS do
			local name, count, extraCurrencyType, icon, itemID = GetBackpackCurrencyInfo(i)
			if name and i == 1 then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(CURRENCY)
			end
			if name and count then GameTooltip:AddDoubleLine(name, count, 1, 1, 1) end
		end
		GameTooltip:AddLine' '
		GameTooltip:AddLine("|cffeda55fClick|r to Open Bags")			
		GameTooltip:Show()
		
	end)
	
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)		
	
	local function OnEvent(self, event)
		local totalSlots, freeSlots = 0, 0
		local itemLink, subtype, isBag
		for i = 0,NUM_BAG_SLOTS do
			isBag = true
			if i > 0 then
				itemLink = GetInventoryItemLink('player', ContainerIDToInventoryID(i))
				if itemLink then
					subtype = select(7, GetItemInfo(itemLink))
					if (subtype == 'Soul Bag') or (subtype == 'Ammo Pouch') or (subtype == 'Quiver') or (subtype == 'Mining Bag') or (subtype == 'Gem Bag') or (subtype == 'Engineering Bag') or (subtype == 'Enchanting Bag') or (subtype == 'Herb Bag') or (subtype == 'Inscription Bag') or (subtype == 'Leatherworking Bag')then
						isBag = false
					end
				end
			end
			if isBag then
				totalSlots = totalSlots + GetContainerNumSlots(i)
				freeSlots = freeSlots + GetContainerNumFreeSlots(i)
			end
			Text:SetText(hexa.."Bags: "..hexb.. freeSlots.. '/' ..totalSlots)
				if freeSlots < 6 then
					Text:SetTextColor(1,0,0)
					B.Flash(Text, .5)
				elseif freeSlots < 10 then
					Text:SetTextColor(1,0,0)
					B.Flash(Text, 1)
				elseif freeSlots > 10 then
					Text:SetTextColor(1,1,1)
					B.StopFlash(Text)
				end
			self:SetAllPoints(Text)
			
		end	
		if event == "PLAYER_LOGIN" then
			OldMoney = GetMoney()
		end
		
		local NewMoney	= GetMoney()
		local Change = NewMoney-OldMoney -- Positive if we gain money
		
		if OldMoney>NewMoney then		-- Lost Money
			Spent = Spent - Change
		else							-- Gained Moeny
			Profit = Profit + Change
		end
		
		-- Setup Money Tooltip
		self:SetAllPoints(Text)

		if (BasicDB == nil) then BasicDB = {}; end
		if (BasicDB[B.myrealm] == nil) then BasicDB[B.myrealm] = {} end
		if (BasicDB[B.myrealm][B.myname] == nil) then BasicDB[B.myrealm][B.myname] = {} end
		BasicDB[B.myrealm][B.myname]["gold"] = GetMoney()
		BasicDB.gold = nil -- old
			
		OldMoney = NewMoney			
	end
	
	Stat:RegisterEvent("PLAYER_MONEY")
	Stat:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
	Stat:RegisterEvent("SEND_MAIL_COD_CHANGED")
	Stat:RegisterEvent("PLAYER_TRADE_MONEY")
	Stat:RegisterEvent("TRADE_MONEY_CHANGED")         
	Stat:RegisterEvent('PLAYER_LOGIN')
	Stat:RegisterEvent('BAG_UPDATE')
	Stat:SetScript('OnMouseDown', 
		function()
			if C['datatext'].bag == true then
				ToggleBag(0)
			elseif C['datatext'].bag == false then
				ToggleAllBags()
			end
		end
	)	


		-- reset gold data
	local function RESETGOLD()		
		for k,_ in pairs(BasicDB[B.myrealm]) do
			BasicDB[B.myrealm][k].gold = nil
		end 
		if (BasicDB == nil) then BasicDB = {}; end
		if (BasicDB[B.myrealm] == nil) then BasicDB[B.myrealm] = {} end
		if (BasicDB[B.myrealm][B.myname] == nil) then BasicDB[B.myrealm][B.myname] = {} end
		BasicDB[B.myrealm][B.myname]["gold"] = GetMoney()		
	end
	SLASH_RESETGOLD1 = "/resetgold"
	SlashCmdList["RESETGOLD"] = RESETGOLD	
	Stat:SetScript('OnEvent', OnEvent)
end