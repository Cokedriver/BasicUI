local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

local L = setmetatable({}, { __index = function(t,k)
    local v = tostring(k)
    rawset(t, k, v)
    return v
end })

--[[

	All Credit for OpenAll.lua goes to Xinhuan.
	Postal = http://www.wowinterface.com/downloads/info11187-Postal.html.
	Edited by Cokedriver.
	
]]

---------------------------
-- Common Mail Functions --
---------------------------


-- Return the type of mail a message subject is
local SubjectPatterns = {
	AHCancelled = gsub(AUCTION_REMOVED_MAIL_SUBJECT, "%%s", ".*"),
	AHExpired = gsub(AUCTION_EXPIRED_MAIL_SUBJECT, "%%s", ".*"),
	AHOutbid = gsub(AUCTION_OUTBID_MAIL_SUBJECT, "%%s", ".*"),
	AHSuccess = gsub(AUCTION_SOLD_MAIL_SUBJECT, "%%s", ".*"),
	AHWon = gsub(AUCTION_WON_MAIL_SUBJECT, "%%s", ".*"),
}
function B.GetMailType(msgSubject)
	if msgSubject then
		for k, v in pairs(SubjectPatterns) do
			if msgSubject:find(v) then return k end
		end
	end
	return "NonAHMail"
end

function B.GetMoneyString(money)
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

function B.GetMoneyStringPlain(money)
	local gold = floor(money / 10000)
	local silver = floor((money - gold * 10000) / 100)
	local copper = mod(money, 100)
	if gold > 0 then
		return gold..GOLD_AMOUNT_SYMBOL.." "..silver..SILVER_AMOUNT_SYMBOL.." "..copper..COPPER_AMOUNT_SYMBOL
	elseif silver > 0 then
		return silver..SILVER_AMOUNT_SYMBOL.." "..copper..COPPER_AMOUNT_SYMBOL
	else
		return copper..COPPER_AMOUNT_SYMBOL
	end
end

function B.CountItemsAndMoney()
	local numAttach = 0
	local numGold = 0
	for i = 1, GetInboxNumItems() do
		local msgMoney, _, _, msgItem = select(5, GetInboxHeaderInfo(i))
		numAttach = numAttach + (msgItem or 0)
		numGold = numGold + msgMoney
	end
	return numAttach, numGold
end

function B.Print(...)
	local text = "|cff00B4FFBasic|r".."|cffffffffUI|r:"
	for i = 1, select("#", ...) do
		text = text.." "..tostring(select(i, ...))
	end

	if not B.IsChatFrameActive(C['general'].OpenAll.ChatOutput) then
		C['general'].OpenAll.ChatOutput = 1
	end
	local chatFrame = _G["ChatFrame"..C['general'].OpenAll.ChatOutput]
	if chatFrame then
		chatFrame:AddMessage(text)
	end
end	

function B.IsChatFrameActive(i)
	local _, _, _, _, _, _, shown = FCF_GetChatWindowInfo(i);
	local chatFrame = _G["ChatFrame"..i]
	if chatFrame then
		if shown or chatFrame.isDocked then
			return true
		end
	end
	return false
end

if C['general'].OpenAll.enable == true then

	local BasicUIConfig = LibStub("AceAddon-3.0"):GetAddon("BasicUIConfig")
	local Mail_OpenAll = BasicUIConfig:NewModule("OpenAll", "AceEvent-3.0", "AceHook-3.0")
	Mail_OpenAll.description = L["A button that collects all attachments and coins from mail."]
	Mail_OpenAll.description2 = L[ [[|cFFFFCC00*|r Simple filters are available for various mail types.
	|cFFFFCC00*|r Shift-Click the Open All button to override the filters and take ALL mail.
	|cFFFFCC00*|r OpenAll will never delete any mail (mail without text is auto-deleted by the game when all attached items and gold are taken).
	|cFFFFCC00*|r OpenAll will skip CoD mails and mails from Blizzard.
	|cFFFFCC00*|r Disable the Verbose option to stop the chat spam while opening mail.]] ]

	-- Disable Inbox Clicks
	local function noop() end
	function Mail_OpenAll:DisableInbox(disable)
		if disable then
			if not self:IsHooked("InboxFrame_OnClick") then
				self:RawHook("InboxFrame_OnClick", noop, true)
				for i = 1, 7 do
					_G["MailItem" .. i .. "ButtonIcon"]:SetDesaturated(1)
				end
			end
		else
			if self:IsHooked("InboxFrame_OnClick") then
				self:Unhook("InboxFrame_OnClick")
				for i = 1, 7 do
					_G["MailItem" .. i .. "ButtonIcon"]:SetDesaturated(nil)
				end
			end
		end
	end	
	
	-- Hides the minimap unread mail button if there are no unread mail on closing the mailbox.
	-- Does not scan past the first 50 items since only the first 50 are viewable.
	function Mail_OpenAll:MAIL_CLOSED()
		for i = 1, GetInboxNumItems() do
			if not select(9, GetInboxHeaderInfo(i)) then return end
		end
		MiniMapMailFrame:Hide()
	end	
	
	-- Use a common frame and setup some common functions for the Mail dropdown menus
	local BasicUIConfig_DropDownMenu = CreateFrame("Frame", "BasicUIConfig_DropDownMenu")
	BasicUIConfig_DropDownMenu.displayMode = "MENU"
	BasicUIConfig_DropDownMenu.info = {}
	BasicUIConfig_DropDownMenu.levelAdjust = 0
	BasicUIConfig_DropDownMenu.UncheckHack = function(dropdownbutton)
		_G[dropdownbutton:GetName().."Check"]:Hide()
		if B.toc >= 40000 then
			_G[dropdownbutton:GetName().."UnCheck"]:Hide()
		end
	end
	BasicUIConfig_DropDownMenu.HideMenu = function()
		if UIDROPDOWNMENU_OPEN_MENU == BasicUIConfig_DropDownMenu then
			CloseDropDownMenus()
		end
	end

	BasicUIConfig.keepFreeOptions = {0, 1, 2, 3, 5, 10, 15, 20, 25, 30}	
	
	local MAX_MAIL_SHOWN = 50
	local mailIndex, attachIndex
	local numUnshownItems
	local lastItem, lastNumAttach, lastNumGold
	local wait
	local button
	local BasicUIConfig_OpenAllMenuButton
	local skipFlag
	local invFull, invAlmostFull
	local openAllOverride
	local firstMailDaysLeft

	-- Frame to process opening mail
	local updateFrame = CreateFrame("Frame")
	updateFrame:Hide()
	updateFrame:SetScript("OnShow", function(self)
		self.time = C['general'].OpenAll.OpenSpeed
		if invAlmostFull and self.time < 1.0 and not self.lootingMoney then
			-- Delay opening to 1 second to account for a nearly full
			-- inventory to respect the KeepFreeSpace setting
			self.time = 1.0
		end
		self.lootingMoney = nil
	end)
	updateFrame:SetScript("OnUpdate", function(self, elapsed)
		self.time = self.time - elapsed
		if self.time <= 0 then
			self:Hide()
			Mail_OpenAll:ProcessNext()
		end
	end)

	-- Frame to refresh the Inbox
	-- I'm cheap so instead of trying to track 60 or so seconds since the
	-- last CheckInbox(), I just call CheckInbox() every 10 seconds
	local refreshFrame = CreateFrame("Frame", nil, MailFrame)
	refreshFrame:Hide()
	refreshFrame:SetScript("OnShow", function(self)
		self.time = 10
		self.mode = nil
	end)
	refreshFrame:SetScript("OnUpdate", function(self, elapsed)
		self.time = self.time - elapsed
		if self.time <= 0 then
			if self.mode == nil then
				self.time = 10
				B.Print(L["Refreshing mailbox..."])
				self:RegisterEvent("MAIL_INBOX_UPDATE")
				CheckInbox()
				refreshFrame:OnEvent()
			else
				self:Hide()
				Mail_OpenAll:OpenAll(true)
			end
		end
	end)
	function refreshFrame:OnEvent(event)
		local current, total = GetInboxNumItems()
		if current == MAX_MAIL_SHOWN or current == total then
			-- If we're here, then mailbox contains a full fresh batch or
			-- we're showing all the mail we have. Continue OpenAll in
			-- 3 seconds to allow for other addons to do stuff.
			self.time = 3
			self.mode = 1
			self:UnregisterEvent("MAIL_INBOX_UPDATE")
		end
	end
	refreshFrame:SetScript("OnEvent", refreshFrame.OnEvent)

	function Mail_OpenAll:OnEnable()
		if not button then
			button = CreateFrame("Button", "MailOpenAllButton", InboxFrame, "UIPanelButtonTemplate")
			button:SetWidth(120)
			button:SetHeight(25)
			if GetLocale() == "frFR" then
				button:SetPoint("CENTER", InboxFrame, "TOP", -46, -399)
			else
				button:SetPoint("CENTER", InboxFrame, "TOP", -36, -399)
			end
			button:SetText(L["Open All"])
			button:SetScript("OnClick", function() Mail_OpenAll:OpenAll() end)
			button:SetFrameLevel(button:GetFrameLevel() + 1)
		end
		if not BasicUIConfig_OpenAllMenuButton then
			-- Create the Menu Button
			BasicUIConfig_OpenAllMenuButton = CreateFrame("Button", "BasicUIConfig_OpenAllMenuButton", InboxFrame);
			BasicUIConfig_OpenAllMenuButton:SetWidth(30);
			BasicUIConfig_OpenAllMenuButton:SetHeight(30);
			BasicUIConfig_OpenAllMenuButton:SetPoint("LEFT", button, "RIGHT", -2, 0);
			BasicUIConfig_OpenAllMenuButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up");
			BasicUIConfig_OpenAllMenuButton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Round");
			BasicUIConfig_OpenAllMenuButton:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled");
			BasicUIConfig_OpenAllMenuButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down");
			BasicUIConfig_OpenAllMenuButton:SetScript("OnClick", function(self, button, down)
				if BasicUIConfig_DropDownMenu.initialize ~= Mail_OpenAll.ModuleMenu then
					CloseDropDownMenus()
					BasicUIConfig_DropDownMenu.initialize = Mail_OpenAll.ModuleMenu
				end
				ToggleDropDownMenu(1, nil, BasicUIConfig_DropDownMenu, self:GetName(), 0, 0)
			end)
			BasicUIConfig_OpenAllMenuButton:SetFrameLevel(BasicUIConfig_OpenAllMenuButton:GetFrameLevel() + 1)
		end

		self:RegisterEvent("MAIL_SHOW")
		-- For enabling after a disable
		button:Show()
		BasicUIConfig_OpenAllMenuButton:SetScript("OnHide", BasicUIConfig_DropDownMenu.HideMenu)
		BasicUIConfig_OpenAllMenuButton:Show()
	end

	function Mail_OpenAll:OnDisable()
		self:Reset()
		button:Hide()
		BasicUIConfig_OpenAllMenuButton:SetScript("OnHide", nil)
		BasicUIConfig_OpenAllMenuButton:Hide()
		self:MAIL_CLOSED()
	end

	function Mail_OpenAll:MAIL_SHOW()
		self:RegisterEvent("MAIL_CLOSED", "Reset")
		self:RegisterEvent("PLAYER_LEAVING_WORLD", "Reset")
	end

	function Mail_OpenAll:OpenAll(isRecursive)
		refreshFrame:Hide()
		mailIndex, numUnshownItems = GetInboxNumItems()
		numUnshownItems = numUnshownItems - mailIndex
		attachIndex = ATTACHMENTS_MAX_RECEIVE
		invFull = nil
		invAlmostFull = nil
		skipFlag = false
		lastItem = false
		lastNumAttach = nil
		lastNumGold = nil
		wait = false
		if not isRecursive then openAllOverride = IsShiftKeyDown() end
		if mailIndex == 0 then
			return
		end
		firstMailDaysLeft = select(7, GetInboxHeaderInfo(1))

		Mail_OpenAll:DisableInbox(1)
		button:SetText(L["In Progress"])

		self:RegisterEvent("UI_ERROR_MESSAGE")
		self:ProcessNext()
	end

	function Mail_OpenAll:ProcessNext()
		-- We need this because MAIL_INBOX_UPDATEs can now potentially
		-- include mailbox refreshes since patch 4.0.3 (that is mail can
		-- get inserted both at the back (old mail) and at the front
		-- (new mail received in the last 60 seconds))
		local currentFirstMailDaysLeft = select(7, GetInboxHeaderInfo(1))
		if currentFirstMailDaysLeft ~= 0 and currentFirstMailDaysLeft ~= firstMailDaysLeft then
			-- First mail's daysLeft changed, indicating we have a 
			-- fresh MAIL_INBOX_UPDATE that has new data from CheckInbox()
			-- so we reopen from the last mail
			return self:OpenAll(true) -- tail call
		end

		if mailIndex > 0 then
			-- Check if we need to wait for the mailbox to change
			if wait then
				local attachCount, goldCount = B.CountItemsAndMoney()
				if lastNumGold ~= goldCount then
					-- Process next mail, gold has been taken
					wait = false
					mailIndex = mailIndex - 1
					attachIndex = ATTACHMENTS_MAX_RECEIVE
					return self:ProcessNext() -- tail call
				elseif lastNumAttach ~= attachCount then
					-- Process next item, an attachment has been taken
					wait = false
					attachIndex = attachIndex - 1
					if lastItem then
						-- The item taken was the last item, process next mail
						lastItem = false
						mailIndex = mailIndex - 1
						attachIndex = ATTACHMENTS_MAX_RECEIVE
						return self:ProcessNext() -- tail call
					end
				else
					-- Wait longer until something in the mailbox changes
					updateFrame:Show()
					return
				end
			end

			local sender, msgSubject, msgMoney, msgCOD, _, msgItem, _, _, msgText, _, isGM = select(3, GetInboxHeaderInfo(mailIndex))

			-- Skip mail if it contains a CoD or if its from a GM
			if (msgCOD and msgCOD > 0) or (isGM) then
				skipFlag = true
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				return self:ProcessNext() -- tail call
			end

			-- Filter by mail type
			local mailType = B.GetMailType(msgSubject)
			if mailType == "NonAHMail" then
				-- Skip player sent mail with attachments according to user options
				if not (openAllOverride or C['general'].OpenAll.Attachments) and msgItem then
					mailIndex = mailIndex - 1
					attachIndex = ATTACHMENTS_MAX_RECEIVE
					return self:ProcessNext() -- tail call
				end
			else
				-- AH mail, check if its from faction or neutral AH
				local factionEnglish, factionLocale = UnitFactionGroup("player")
				if not strfind(sender, factionLocale) then
					mailType = "Neutral"..mailType
				end
				-- Skip AH mail types according to user options
				if not (openAllOverride or C['general'].OpenAll[mailType]) then
					mailIndex = mailIndex - 1
					attachIndex = ATTACHMENTS_MAX_RECEIVE
					return self:ProcessNext() -- tail call
				end
			end

			-- Print message on next mail
			if C['general'].OpenAll.SpamChat and attachIndex == ATTACHMENTS_MAX_RECEIVE then
				if not invFull or msgMoney > 0 then
					local moneyString = msgMoney > 0 and " ["..B.GetMoneyString(msgMoney).."]" or ""
					local playerName
					if (mailType == "AHSuccess" or mailType == "AHWon") then
						playerName = select(3,GetInboxInvoiceInfo(mailIndex))
						playerName = playerName and (" ("..playerName..")")
					end
					B.Print(format("%s %d: %s%s%s", L["Processing Message"], mailIndex, msgSubject or "", moneyString, (playerName or "")))
				end
			end

			-- Find next attachment index backwards
			while not GetInboxItemLink(mailIndex, attachIndex) and attachIndex > 0 do
				attachIndex = attachIndex - 1
			end

			-- Check for free bag space
			if attachIndex > 0 and not invFull and C['general'].OpenAll.KeepFreeSpace>0 then
				local free=0
				for bag=0,NUM_BAG_SLOTS do
					local bagFree,bagFam = GetContainerNumFreeSlots(bag)
					if bagFam==0 then
						free = free + bagFree
					end
				end
				if free <= C['general'].OpenAll.KeepFreeSpace then
					invFull = true
					invAlmostFull = nil
					B.Print(format(L["Not taking more items as there are now only %d regular bagslots free."], free))
				elseif free <= C['general'].OpenAll.KeepFreeSpace + 1 then
					invAlmostFull = true
				end
			end

			-- If inventory is full, check if the item to be looted can stack with an existing stack
			local lootFlag = false
			if attachIndex > 0 and invFull then
				local name, itemTexture, count, quality, canUse = GetInboxItem(mailIndex, attachIndex)
				local link = GetInboxItemLink(mailIndex, attachIndex)
				local itemID = strmatch(link, "item:(%d+)")
				local stackSize = select(8, GetItemInfo(link))
				if itemID and stackSize and GetItemCount(itemID) > 0 then
					for bag = 0, NUM_BAG_SLOTS do
						for slot = 1, GetContainerNumSlots(bag) do
							local texture2, count2, locked2, quality2, readable2, lootable2, link2 = GetContainerItemInfo(bag, slot)
							if link2 then
								local itemID2 = strmatch(link2, "item:(%d+)")
								if itemID == itemID2 and count + count2 <= stackSize then
									lootFlag = true
									break
								end
							end
						end
						if lootFlag then break end
					end
				end
			end

			if attachIndex > 0 and (lootFlag or not invFull) then
				-- If there's attachments, take the item
				--B.Print("Getting Item from Message "..mailIndex..", "..attachIndex)
				lastNumAttach, lastNumGold = B.CountItemsAndMoney()
				TakeInboxItem(mailIndex, attachIndex)

				wait = true
				-- Find next attachment index backwards
				local attachIndex2 = attachIndex - 1
				while not GetInboxItemLink(mailIndex, attachIndex2) and attachIndex2 > 0 do
					attachIndex2 = attachIndex2 - 1
				end
				if attachIndex2 == 0 and msgMoney == 0 then lastItem = true end

				updateFrame:Show()
			elseif msgMoney > 0 then
				-- No attachments, but there is money
				--B.Print("Getting Gold from Message "..mailIndex)
				lastNumAttach, lastNumGold = B.CountItemsAndMoney()
				TakeInboxMoney(mailIndex)

				wait = true

				updateFrame.lootingMoney = true
				updateFrame:Show()
			else
				-- Mail has no item or money, go to next mail
				mailIndex = mailIndex - 1
				attachIndex = ATTACHMENTS_MAX_RECEIVE
				return self:ProcessNext() -- tail call
			end

		else
			-- Reached the end of opening all selected mail

			local numItems, totalItems = GetInboxNumItems()
			if numUnshownItems ~= totalItems - numItems then
				-- We will Open All again if the number of unshown items is different
				return self:OpenAll(true) -- tail call
			elseif totalItems > numItems and numItems < MAX_MAIL_SHOWN then
				-- We only want to refresh if there's more items to show
				B.Print(L["Not all messages are shown, refreshing mailbox soon to continue Open All..."])
				refreshFrame:Show()
				return
			end
			if skipFlag then B.Print(L["Some Messages May Have Been Skipped."]) end
			self:Reset()
		end
	end

	function Mail_OpenAll:Reset(event)
		refreshFrame:Hide()
		updateFrame:Hide()
		self:UnregisterEvent("UI_ERROR_MESSAGE")
		button:SetText(L["Open All"])
		Mail_OpenAll:DisableInbox()
		InboxFrame_Update()
		if event == "MAIL_CLOSED" or event == "PLAYER_LEAVING_WORLD" then
			self:UnregisterEvent("MAIL_CLOSED")
			self:UnregisterEvent("PLAYER_LEAVING_WORLD")
		end
	end

	function Mail_OpenAll:UI_ERROR_MESSAGE(event, error_message)
		if error_message == ERR_INV_FULL then
			invFull = true
			wait = false
		elseif error_message == ERR_ITEM_MAX_COUNT then
			attachIndex = attachIndex - 1
			wait = false
		end
	end

	function Mail_OpenAll.SetKeepFreeSpace(dropdownbutton, arg1)
		C['general'].OpenAll.KeepFreeSpace = arg1
	end

	function Mail_OpenAll.ModuleMenu(self, level)
		if not level then return end
		local info = self.info
		wipe(info)
		info.isNotRadio = 1
		local db = C['general'].OpenAll
		
		if level == 1 + self.levelAdjust then
			info.hasArrow = 1
			info.keepShownOnClick = 1
			info.func = self.UncheckHack
			info.notCheckable = 1

			info.text = FACTION.." "..L["AH-related mail"]
			info.value = "AHMail"
			UIDropDownMenu_AddButton(info, level)

			info.text = FACTION_STANDING_LABEL4.." "..L["AH-related mail"]
			info.value = "NeutralAHMail"
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Non-AH related mail"]
			info.value = "NonAHMail"
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Other options"]
			info.value = "OtherOptions"
			UIDropDownMenu_AddButton(info, level)

		elseif level == 2 + self.levelAdjust then

			info.keepShownOnClick = 1
			--info.func = Basic_Mail.SaveOption
			info.arg1 = "OpenAll"

			if UIDROPDOWNMENU_MENU_VALUE == "AHMail" then
				info.text = L["Open all Auction cancelled mail"]
				info.arg2 = "AHCancelled"
				info.checked = db.AHCancelled
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Open all Auction expired mail"]
				info.arg2 = "AHExpired"
				info.checked = db.AHExpired
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Open all Outbid on mail"]
				info.arg2 = "AHOutbid"
				info.checked = db.AHOutbid
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Open all Auction successful mail"]
				info.arg2 = "AHSuccess"
				info.checked = db.AHSuccess
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Open all Auction won mail"]
				info.arg2 = "AHWon"
				info.checked = db.AHWon
				UIDropDownMenu_AddButton(info, level)

			elseif UIDROPDOWNMENU_MENU_VALUE == "NeutralAHMail" then
				info.text = L["Open all Auction cancelled mail"]
				info.arg2 = "NeutralAHCancelled"
				info.checked = db.NeutralAHCancelled
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Open all Auction expired mail"]
				info.arg2 = "NeutralAHExpired"
				info.checked = db.NeutralAHExpired
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Open all Outbid on mail"]
				info.arg2 = "NeutralAHOutbid"
				info.checked = db.NeutralAHOutbid
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Open all Auction successful mail"]
				info.arg2 = "NeutralAHSuccess"
				info.checked = db.NeutralAHSuccess
				UIDropDownMenu_AddButton(info, level)

				info.text = L["Open all Auction won mail"]
				info.arg2 = "NeutralAHWon"
				info.checked = db.NeutralAHWon
				UIDropDownMenu_AddButton(info, level)

			elseif UIDROPDOWNMENU_MENU_VALUE == "NonAHMail" then
				info.text = L["Open all mail with attachments"]
				info.arg2 = "Attachments"
				info.checked = db.Attachments
				UIDropDownMenu_AddButton(info, level)

			elseif UIDROPDOWNMENU_MENU_VALUE == "OtherOptions" then
				info.text = L["Keep free space"]
				info.hasArrow = 1
				info.value = "KeepFreeSpace"
				info.func = self.UncheckHack
				UIDropDownMenu_AddButton(info, level)
				local listFrame = _G["DropDownList"..level]
				self.UncheckHack(_G[listFrame:GetName().."Button"..listFrame.numButtons])

				info.text = L["Verbose mode"]
				info.hasArrow = nil
				info.value = nil
				--info.func = Basic_Mail.SaveOption
				info.arg2 = "SpamChat"
				info.checked = db.SpamChat
				UIDropDownMenu_AddButton(info, level)
				
		elseif level == 3 + self.levelAdjust then
			if UIDROPDOWNMENU_MENU_VALUE == "KeepFreeSpace" then
				local keepFree = db.KeepFreeSpace
				info.func = Mail_OpenAll.SetKeepFreeSpace
				info.isNotRadio = nil
				for _, v in ipairs(BasicUIConfig.keepFreeOptions) do
					info.text = v
					info.checked = v == keepFree
					info.arg1 = v
					UIDropDownMenu_AddButton(info, level)
				end
			end
		end
	end
	end
end

if C["general"].OpenAll.collected == true then
	local BasicUIConfig = LibStub("AceAddon-3.0"):GetAddon("BasicUIConfig")
	local OpenAll_Collected = BasicUIConfig:NewModule("OpenAll_Collected", "AceEvent-3.0")
	OpenAll_Collected.description = L["Prints the amount of money collected during a mail session."]

	local money
	local flag = false

	function OpenAll_Collected:OnEnable()
		self:RegisterEvent("MAIL_SHOW")
	end

	-- Disabling modules unregisters all events/hook automatically
	--function OpenAll_Collected:OnDisable()
	--end

	function OpenAll_Collected:MAIL_SHOW()
		if not flag then
			money = GetMoney()
			self:RegisterEvent("MAIL_CLOSED")
			flag = true
		end
	end

	function OpenAll_Collected:MAIL_CLOSED()
		flag = false
		self:UnregisterEvent("MAIL_CLOSED")
		money = GetMoney() - money
		if money > 0 then
			B.Print(L["Total money from mailbox:"].." ["..B.GetMoneyString(money).."].")
		end
		-- Hides the minimap unread mail button if there are no unread mail on closing the mailbox.
		-- Does not scan past the first 50 items since only the first 50 are viewable.
		for i = 1, GetInboxNumItems() do
			if not select(9, GetInboxHeaderInfo(i)) then return end
		end
		MiniMapMailFrame:Hide()
	end
end