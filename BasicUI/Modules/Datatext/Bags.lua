local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config
local cfg = C["datatext"]
local cfgm = C["media"]

--[[

	All Credit for Bags.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if cfg.enable ~= true then return end

if cfg.bags and cfg.bags > 0 then
	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(cfgm.fontNormal, cfg.fontsize,'THINOUTLINE')
	B.PP(cfg.bags, Text)

	local Profit	= 0
	local Spent		= 0
	local OldMoney	= 0
	local myPlayerRealm = GetRealmName();
	

	local function formatMoney(money)
		local gold, silver, copper  = floor(math.abs(money) / 10000), mod(floor(math.abs(money) / 100), 100), mod(floor(math.abs(money)), 100)
		local gc, sc, cc = "|cFFFFD800", "|cFFC7C7C7", "|cFFEEA55F"		
		if gold ~= 0 then
			return format("%s"..gc.."g |r".."%s"..sc.."s |r".."%s"..cc.."c|r", gold, silver, copper)
		elseif silver ~= 0 then
			return format("%s"..sc.."s |r".."%s"..cc.."c|r", silver, copper)
		else
			return format("%s"..cc.."c", copper)
		end
	end
	
	
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
				if freeSlots < 10 then
					Text:SetTextColor(1,0,0)
				elseif freeSlots > 10 then
					Text:SetTextColor(1,1,1)
				end
			self:SetAllPoints(Text)
			
		end	
		if event == "PLAYER_ENTERING_WORLD" then
			OldMoney = GetMoney()
		end
		
		local NewMoney	= GetMoney()
		local Change = NewMoney - OldMoney -- Positive if we gain money
		
		if OldMoney>NewMoney then		-- Lost Money
			Spent = Spent - Change
		else							-- Gained Moeny
			Profit = Profit + Change
		end
		
		-- Setup Money Tooltip
		self:SetAllPoints(Text)
		
		local myPlayerName  = UnitName("player");				
		if (BasicDB == nil) then BasicDB = {}; end
		if (BasicDB.gold == nil) then BasicDB.gold = {}; end
		if (BasicDB.gold[myPlayerRealm]==nil) then BasicDB.gold[myPlayerRealm]={}; end
		BasicDB.gold[myPlayerRealm][myPlayerName] = GetMoney();		
			
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
			if C["datatext"].bag ~= true then
				ToggleAllBags()
			else
				ToggleBag(0)
			end
		end
	)
	Stat:SetScript('OnEvent', OnEvent)	
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			local anchor, panel, xoff, yoff = B.DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..B.myname.."'s"..hexb.." Funds")
			GameTooltip:AddLine' '			
			GameTooltip:AddLine("Session: ")
			GameTooltip:AddDoubleLine("Earned:", formatMoney(Profit), 1, 1, 1, 1, 1, 1)
			GameTooltip:AddDoubleLine("Spent:", formatMoney(Spent), 1, 1, 1, 1, 1, 1)
			if Profit < Spent then
				GameTooltip:AddDoubleLine("Deficit:", formatMoney(Profit - Spent), 1, 0, 0, 1, 1, 1)
			elseif (Profit-Spent)>0 then
				GameTooltip:AddDoubleLine("Profit:", formatMoney(Profit - Spent), 0, 1, 0, 1, 1, 1)
			end				
			GameTooltip:AddLine' '								
		
			local totalGold = 0				
			GameTooltip:AddLine("Character: ")			
			local thisRealmList = BasicDB.gold[myPlayerRealm];
			for k,v in pairs(thisRealmList) do
				GameTooltip:AddDoubleLine(k, formatMoney(v), 1, 1, 1, 1, 1, 1)
				totalGold=totalGold+v;
			end 
			GameTooltip:AddLine' '
			GameTooltip:AddLine("Server: ")
			GameTooltip:AddDoubleLine("Total: ", formatMoney(totalGold), 1, 1, 1, 1, 1, 1)

			for i = 1, GetNumWatchedTokens() do
				local name, count, extraCurrencyType, icon, itemID = GetBackpackCurrencyInfo(i)
				if name and i == 1 then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(CURRENCY)
				end
				local r, g, b = 1,1,1
				if itemID then r, g, b = GetItemQualityColor(select(3, GetItemInfo(itemID))) end
				if name and count then GameTooltip:AddDoubleLine(name, count, r, g, b, 1, 1, 1) end
			end
			GameTooltip:AddLine' '
			GameTooltip:AddLine("|cffeda55fClick|r to Open Bags")			
			GameTooltip:Show()
		end
	end)
	
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)			

	-- reset gold data
	local function RESETGOLD()
		local myPlayerRealm = GetCVar("realmName");
		local myPlayerName  = UnitName("player");
		
		BasicDB.gold = {}
		BasicDB.gold[myPlayerRealm]={}
		BasicDB.gold[myPlayerRealm][myPlayerName] = GetMoney();
	end
	SLASH_RESETGOLD1 = "/resetgold"
	SlashCmdList["RESETGOLD"] = RESETGOLD	
	
end