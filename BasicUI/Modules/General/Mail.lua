local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for Mail.lua goes to Xruptor.
	xanAutoMail = http://www.wowinterface.com/downloads/info18868-xanAutoMail.html.
	Edited by Cokedriver.
	
]]

local L = setmetatable({}, { __index = function(t,k)
    local v = tostring(k)
    rawset(t, k, v)
    return v
end })

if C['general'].mail.enable ~= true then return end

if C['general'].mail.openall == true then

	local DB_PLAYER
	local DB_RECENT
	local currentPlayer
	local currentRealm
	local inboxAllButton
	local old_InboxFrame_OnClick
	local triggerStop = false
	local numInboxItems = 0
	local timeChk, timeDelay = 0, 1
	local stopLoop = 10
	local loopChk = 0
	local skipCount = 0
	local moneyCount = 0

	local origHook = {}

	local Mail = CreateFrame("frame","MailFrame",UIParent)
	Mail:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

	--------------------------
		-- CORE
	--------------------------

	function Mail:PLAYER_LOGIN()
		
		currentPlayer = UnitName('player')
		currentRealm = GetRealmName()
		
		--do the db initialization
		self:StartupDB()
		
		--increase the mailbox history lines to 15
		SendMailNameEditBox:SetHistoryLines(15)
		
		--make the open all button
		inboxAllButton = CreateFrame("Button", "Mail_OpenAllBTN", InboxFrame, "UIPanelButtonTemplate")
		inboxAllButton:SetWidth(100)
		inboxAllButton:SetHeight(20)
		inboxAllButton:SetPoint("CENTER", InboxFrame, "TOP", 0, -55)
		inboxAllButton:SetText("Open All")
		inboxAllButton:SetScript("OnClick", function() Mail.GetMail() end)

		self:UnregisterEvent("PLAYER_LOGIN")
		self.PLAYER_LOGIN = nil
	end

	function Mail:StartupDB()
		BasicDB = BasicDB or {}
		BasicDB[currentRealm] = BasicDB[currentRealm] or {}

		--player list
		BasicDB[currentRealm]["player"] = BasicDB[currentRealm]["player"] or {}
		DB_PLAYER = BasicDB[currentRealm]["player"]
		
		--recent list
		BasicDB[currentRealm]["recent"] = BasicDB[currentRealm]["recent"] or {}
		DB_RECENT = BasicDB[currentRealm]["recent"]
		
		--check for current user
		if DB_PLAYER[currentPlayer] == nil then DB_PLAYER[currentPlayer] = true end
	end



	--------------------------
		-- OPEN ALL MAIL
	--------------------------

	Mail:RegisterEvent("MAIL_INBOX_UPDATE")
	Mail:RegisterEvent("MAIL_SHOW")

	local function colorMoneyText(value)
		if not value then return "" end
		local gold = abs(value / 10000)
		local silver = abs(mod(value / 100, 100))
		local copper = abs(mod(value, 100))
		
		local GOLD_ABRV = "g"
		local SILVER_ABRV = "s"
		local COPPER_ABRV = "c"
		
		local WHITE = "ffffff"
		local COLOR_COPPER = "eda55f"
		local COLOR_SILVER = "c7c7cf"
		local COLOR_GOLD = "ffd700"

		if value >= 10000 or value <= -10000 then
			return format("|cff%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r", WHITE, gold, COLOR_GOLD, GOLD_ABRV, WHITE, silver, COLOR_SILVER, SILVER_ABRV, WHITE, copper, COLOR_COPPER, COPPER_ABRV)
		elseif value >= 100 or value <= -100 then
			return format("|cff%s%d|r|cff%s%s|r |cff%s%d|r|cff%s%s|r", WHITE, silver, COLOR_SILVER, SILVER_ABRV, WHITE, copper, COLOR_COPPER, COPPER_ABRV)
		else
			return format("|cff%s%d|r|cff%s%s|r", WHITE, copper, COLOR_COPPER, COPPER_ABRV)
		end
	end

	local function bagCheck()
		local totalFree = 0
		for i=0, NUM_BAG_SLOTS do
			local numberOfFreeSlots = GetContainerNumFreeSlots(i)
			totalFree = totalFree + numberOfFreeSlots
		end
		return totalFree
	end

	local function mailLoop(this, arg1)
		timeChk = timeChk + arg1
		if triggerStop then return end
		
		if (timeChk > timeDelay) then
			timeChk = 0
			
			--check for last or no messages
			if numInboxItems <= 0 then
				--double check that there aren't anymore mail items
				--we use a loop check just in case to prevent infinite loops
				if GetInboxNumItems() > 0 and skipCount ~= GetInboxNumItems() and loopChk < stopLoop then
					loopChk = loopChk + 1
					numInboxItems = GetInboxNumItems()
				else
					triggerStop = true
					Mail:StopMail()
					return
				end
			end

			--lets get the mail
			local _, _, _, _, money, COD, _, numItems, wasRead, _, _, _, isGM = GetInboxHeaderInfo(numInboxItems)
			
			if money > 0 or (numItems and numItems > 0) and COD <= 0 and not isGM then
				--stop the loop if the mail was already read
				if wasRead and loopChk > 0 then
					triggerStop = true
					Mail:StopMail()
					return
				elseif bagCheck() < 1 then
					triggerStop = true
					Mail:StopMail()
					DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|rUI: Your bags are full")
				else
					if money > 0 then moneyCount = moneyCount + money end
					AutoLootMailItem(numInboxItems)
				end
			else
				skipCount = skipCount + 1
			end
			
			--decrease count
			numInboxItems = numInboxItems - 1
		end
	end

	function Mail:GetMail()
		if GetInboxNumItems() == 0 then return end
		
		Mail_OpenAllBTN:Disable() --disable the button to prevent further clicks
		triggerStop = false
		timeChk, timeDelay = 0, 0.5
		loopChk = 0
		skipCount = 0
		moneyCount = 0
		numInboxItems = GetInboxNumItems()
		
		old_InboxFrame_OnClick = InboxFrame_OnClick
		InboxFrame_OnClick = function() end
		
		--register for inventory full error
		Mail:RegisterEvent("UI_ERROR_MESSAGE")
		
		--initiate the loop
		Mail:SetScript("OnUpdate", mailLoop)
	end

	function Mail:StopMail()
		Mail_OpenAllBTN:Enable() --enable the button again
		if old_InboxFrame_OnClick then
			InboxFrame_OnClick = old_InboxFrame_OnClick
			old_InboxFrame_OnClick = nil
		end
		Mail:UnregisterEvent("UI_ERROR_MESSAGE")
		Mail:SetScript("OnUpdate", nil)
		--check for money output
		if moneyCount > 0 then
			DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|rUI: Total money from mailbox ["..colorMoneyText(moneyCount).."]")
		end
	end

	--this is to stop the loop if our bags are filled
	function Mail:UI_ERROR_MESSAGE(event, arg1)
		if arg1 == ERR_INV_FULL then
			triggerStop = true
			Mail:StopMail()
			DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|rUI: Your bags are full")
		end
	end

	--sometimes the mailbox is full, if this happens we have to make changes to the button position
	local function inboxFullCheck()
		local nItem, nTotal = GetInboxNumItems()
		if nItem and nTotal then
			if ( nTotal > nItem) or InboxTooMuchMail:IsVisible() and not inboxAllButton.movedBottom then
				inboxAllButton:ClearAllPoints()
				inboxAllButton:SetPoint("CENTER", InboxFrame, "BOTTOM", -10, 100)
				inboxAllButton.movedBottom = true
			elseif (( nTotal < nItem) or not InboxTooMuchMail:IsVisible()) and inboxAllButton.movedBottom then
				inboxAllButton.movedBottom = nil
				inboxAllButton:ClearAllPoints()
				inboxAllButton:SetPoint("CENTER", InboxFrame, "TOP", 0, -55)
			end 
		end
	end

	function Mail:MAIL_INBOX_UPDATE()
		inboxFullCheck()
	end

	function Mail:MAIL_SHOW()
		inboxFullCheck()
	end

	if IsLoggedIn() then Mail:PLAYER_LOGIN() else Mail:RegisterEvent("PLAYER_LOGIN") end
end
