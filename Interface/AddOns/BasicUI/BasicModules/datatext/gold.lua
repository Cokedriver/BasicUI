local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['datatext'].enable ~= true then return end

if C['datatext'].gold and C['datatext'].gold > 0 then

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("MEDIUM")
	Stat:SetFrameLevel(3)

	local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].gold, Text)

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
		if not InCombatLockdown() then
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
			GameTooltip:Show()
		end
	end)

	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)

	local function OnEvent(self, event)
		if event == "PLAYER_ENTERING_WORLD" then
			OldMoney = GetMoney()
		end
		
		local NewMoney	= GetMoney()
		local Change = NewMoney-OldMoney -- Positive if we gain money
		
		if OldMoney>NewMoney then		-- Lost Money
			Spent = Spent - Change
		else							-- Gained Moeny
			Profit = Profit + Change
		end
		
		Text:SetText(formatMoney(NewMoney))
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
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnMouseDown", function() ToggleCharacter('TokenFrame') end)
	Stat:SetScript("OnEvent", OnEvent)

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

end