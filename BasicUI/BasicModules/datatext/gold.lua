local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['datatext'].enable ~= true then return end

if C['datatext'].gold and C['datatext'].gold > 0 then
	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].gold, Text)

	local Profit	= 0
	local Spent		= 0
	local OldMoney	= 0
	local myPlayerRealm = GetCVar('realmName');

	local function formatMoney(money)
		local gold = floor(math.abs(money) / 10000)
		local silver = mod(floor(math.abs(money) / 100), 100)
		local copper = mod(floor(math.abs(money)), 100)
		if gold ~= 0 then
			return format('%s'.."|cffffd700g|r", gold)
		elseif silver ~= 0 then
			return format('%s'.."|cffc7c7cfs|r", silver)
		else
			return format('%s'.."|cffeda55fc|r", copper)
		end
	end

	local function FormatTooltipMoney(money)
		local gold, silver, copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
		local cash = ''
		cash = format('%.2d'.."|cffffd700g|r"..' %.2d'.."|cffc7c7cfs|r"..' %.2d'.."|cffeda55fc|r", gold, silver, copper)		
		return cash
	end	

	local function OnEvent(self, event)
		if event == 'PLAYER_ENTERING_WORLD' then
			OldMoney = GetMoney()
		end
		
		local NewMoney	= GetMoney()
		local Change = NewMoney-OldMoney -- Positive if we gain money
		
		if OldMoney>NewMoney then		-- Lost Money
			Spent = Spent - Change
		else							-- Gained Moeny
			Profit = Profit + Change
		end
		
		Text:SetText(hexa..'Gold: '..hexb..formatMoney(NewMoney))
		-- Setup Money Tooltip
		self:SetAllPoints(Text)

		local myname  = UnitName('player');				
		if (bdcUI == nil) then bdcUI = {}; end
		if (bdcUI.gold == nil) then bdcUI.gold = {}; end
		if (bdcUI.gold[myPlayerRealm]==nil) then bdcUI.gold[myPlayerRealm]={}; end
		bdcUI.gold[myPlayerRealm][myname] = GetMoney();
				
		OldMoney = NewMoney
	end

	Stat:RegisterEvent('PLAYER_MONEY')
	Stat:RegisterEvent('SEND_MAIL_MONEY_CHANGED')
	Stat:RegisterEvent('SEND_MAIL_COD_CHANGED')
	Stat:RegisterEvent('PLAYER_TRADE_MONEY')
	Stat:RegisterEvent('TRADE_MONEY_CHANGED')
	Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
	Stat:SetScript('OnMouseDown', function() ToggleCharacter('TokenFrame') end)
	Stat:SetScript('OnEvent', OnEvent)
	Stat:SetScript('OnEnter', function(self)
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
			local thisRealmList = bdcUI.gold[myPlayerRealm];
			for k,v in pairs(thisRealmList) do
				GameTooltip:AddDoubleLine(k, FormatTooltipMoney(v), 1, 1, 1, 1, 1, 1)
				totalGold=totalGold+v;
			end 
			GameTooltip:AddLine' '
			GameTooltip:AddLine("Server: ")
			GameTooltip:AddDoubleLine("Total: ", FormatTooltipMoney(totalGold), 1, 1, 1, 1, 1, 1)

			for i = 1, GetNumWatchedTokens() do
				local name, count, extraCurrencyType, icon, itemID = GetBackpackCurrencyInfo(i)
				if name and i == 1 then
					GameTooltip:AddLine(' ')
					GameTooltip:AddLine(CURRENCY)
				end
				local r, g, b = 1,1,1
				if itemID then r, g, b = GetItemQualityColor(select(3, GetItemInfo(itemID))) end
				if name and count then GameTooltip:AddDoubleLine(name, count, r, g, b, 1, 1, 1) end
			end
			GameTooltip:Show()
		end
	end)
	Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)	
	-- reset gold data
	local function RESETGOLD()
		local myPlayerRealm = GetCVar('realmName');
		local myname  = UnitName('player');
		
		bdcUI.gold = {}
		bdcUI.gold[myPlayerRealm]={}
		bdcUI.gold[myPlayerRealm][myname] = GetMoney();
	end
	SLASH_RESETGOLD1 = '/resetgold'
	SlashCmdList['RESETGOLD'] = RESETGOLD
end