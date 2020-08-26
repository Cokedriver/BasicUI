local MODULE_NAME = "Misc"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		altbuy = true,
		auction = false,
		autogreed = true,
		coords = true,
		chatbubbles = true,
		flashnods = true,
		merchant = true,
		minimap = true,
		spellid = true,
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

local classColor
CUSTOM_FACTION_BAR_COLORS = {
	[1] = {r = 1, g = 0, b = 0},
	[2] = {r = 1, g = 0, b = 0},
	[3] = {r = 1, g = 1, b = 0},
	[4] = {r = 1, g = 1, b = 0},
	[5] = {r = 0, g = 1, b = 0},
	[6] = {r = 0, g = 1, b = 0},
	[7] = {r = 0, g = 1, b = 0},
	[8] = {r = 0, g = 1, b = 0},
}

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

----------------------------------------------------------------------
-- Alt Buy Full Stacks borrowed from NeavUI
----------------------------------------------------------------------
function MODULE:AltBuy()

	if db.altbuy ~= true then return end

	local NEW_ITEM_VENDOR_STACK_BUY = ITEM_VENDOR_STACK_BUY
	ITEM_VENDOR_STACK_BUY = '|cffa9ff00'..NEW_ITEM_VENDOR_STACK_BUY..'|r'

		-- alt-click to buy a stack

	local origMerchantItemButton_OnModifiedClick = _G.MerchantItemButton_OnModifiedClick
	local function MerchantItemButton_OnModifiedClickHook(self, ...)
		origMerchantItemButton_OnModifiedClick(self, ...)

		if (IsAltKeyDown()) then
			local maxStack = select(8, GetItemInfo(GetMerchantItemLink(self:GetID())))

			local numAvailable = select(5, GetMerchantItemInfo(self:GetID()))

			-- -1 means an item has unlimited supply.
			if (numAvailable ~= -1) then
				BuyMerchantItem(self:GetID(), numAvailable)
			else
				BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
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

----------------------------------------------------------------------
-- Auction borrowed from daftAuction by Daftwise - US Destromath
----------------------------------------------------------------------
function MODULE:Auction()
	if db.auction ~= true then return end

	-----------START CONFIG------------

	local UNDERCUT = .97; -- .97 is a 3% undercut
	local PRICE_BY = "QUALITY" -- When no matches are found, set price based on QUALITY or VENDOR

	-- PRICE BY QUALITY, where 1000 = 1 gold
		local POOR_PRICE = 100000
		local COMMON_PRICE = 200000
		local UNCOMMON_PRICE = 2500000
		local RARE_PRICE = 5000000
		local EPIC_PRICE = 10000000

	-- PRICE BY VENDOR, where formula is vendor price * number
		local POOR_MULTIPLIER = 20
		local COMMON_MULTIPLIER = 30
		local UNCOMMMON_MULTIPLIER = 40
		local RARE_MULTIPLIER = 50
		local EPIC_MULTIPLIER = 60

	local STARTING_MULTIPLIER = 0.9

	---------END CONFIG---------

	local cAuction = CreateFrame("Frame", "cAuction", UIParent)

	cAuction:RegisterEvent("AUCTION_HOUSE_SHOW")
	cAuction:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")

	local selectedItem
	local selectedItemVendorPrice
	local selectedItemQuality
	local currentPage = 0
	local myBuyoutPrice, myStartPrice
	local myName = UnitName("player")

	cAuction:SetScript("OnEvent", function(self, event)
		
		if event == "AUCTION_HOUSE_SHOW" then
				
			AuctionsItemButton:HookScript("OnEvent", function(self, event)
				
				if event=="NEW_AUCTION_UPDATE" then -- user placed an item into auction item box
					self:SetScript("OnUpdate", nil)
					myBuyoutPrice = nil
					myStartPrice = nil
					currentPage = 0
					selectedItem = nil
					selectedItem, texture, count, quality, canUse, price, _, stackCount, totalCount, selectedItemID = GetAuctionSellItemInfo();
					local canQuery = CanSendAuctionQuery()
					
					if canQuery and selectedItem then -- query auction house based on item name
						ResetCursor()
						QueryAuctionItems(selectedItem)
					end
				end
			end)

		elseif event == "AUCTION_ITEM_LIST_UPDATE" then -- the auction list was updated or sorted
			
			if (selectedItem ~= nil) then -- an item was placed in the auction item box
				local batch, totalAuctions = GetNumAuctionItems("list")
				
				if totalAuctions == 0 then -- No matches
					_, _, selectedItemQuality, selectedItemLevel, _, _, _, _, _, _, selectedItemVendorPrice = GetItemInfo(selectedItem)
								
					if PRICE_BY == "QUALITY" then
					
						if selectedItemQuality == 0 then myBuyoutPrice = POOR_PRICE end
						if selectedItemQuality == 1 then myBuyoutPrice = COMMON_PRICE end
						if selectedItemQuality == 2 then myBuyoutPrice = UNCOMMON_PRICE end
						if selectedItemQuality == 3 then myBuyoutPrice = RARE_PRICE end
						if selectedItemQuality == 4 then myBuyoutPrice = EPIC_PRICE end
					
					elseif PRICE_BY == "VENDOR" then
					
						if selectedItemQuality == 0 then myBuyoutPrice = selectedItemVendorPrice * POOR_MULTIPLIER end
						if selectedItemQuality == 1 then myBuyoutPrice = selectedItemVendorPrice * COMMON_MULTIPLIER end
						if selectedItemQuality == 2 then myBuyoutPrice = selectedItemVendorPrice * UNCOMMMON_MULTIPLIER end
						if selectedItemQuality == 3 then myBuyoutPrice = selectedItemVendorPrice * RARE_MULTIPLIER end
						if selectedItemQuality == 4 then myBuyoutPrice = selectedItemVendorPrice * EPIC_MULTIPLIER end
					end
					
					myStartPrice = myBuyoutPrice * STARTING_MULTIPLIER
				end
				
				local currentPageCount = floor(totalAuctions/50)
				
				for i=1, batch do -- SCAN CURRENT PAGE
					local postedItem, _, count, _, _, _, _, minBid, _, buyoutPrice, _, _, _, owner = GetAuctionItemInfo("list",i)
					
					if postedItem == selectedItem and owner ~= myName and buyoutPrice ~= nil then -- selected item matches the one found on auction list
						
						if myBuyoutPrice == nil and myStartPrice == nil then
							myBuyoutPrice = (buyoutPrice/count) * UNDERCUT;
							myStartPrice = (minBid/count) * UNDERCUT;
							
						elseif myBuyoutPrice > (buyoutPrice/count) then
							myBuyoutPrice = (buyoutPrice/count) * UNDERCUT;
							myStartPrice = (minBid/count) * UNDERCUT;
						end;
					end;
				end;
				
				if currentPage < currentPageCount then -- GO TO NEXT PAGES
					
					self:SetScript("OnUpdate", function(self, elapsed)
						
						if not self.timeSinceLastUpdate then 
							self.timeSinceLastUpdate = 0 ;
						end;
						self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed;
						
						if self.timeSinceLastUpdate > .1 then -- a cycle has passed, run this
							selectedItem = GetAuctionSellItemInfo();
							local canQuery = CanSendAuctionQuery();
							
							if canQuery then -- check the next page of auctions
								currentPage = currentPage + 1;
								QueryAuctionItems(selectedItem, nil, nil, currentPage);
								self:SetScript("OnUpdate", nil);
							end
							self.timeSinceLastUpdate = 0;
						end;
					end);
				
				else -- ALL PAGES SCANNED
					self:SetScript("OnUpdate", nil)
					local stackSize = AuctionsStackSizeEntry:GetNumber();
						
					if myStartPrice ~= nil then
							
						if stackSize > 1 then -- this is a stack of items
								
							if UIDropDownMenu_GetSelectedValue(PriceDropDown) == PRICE_TYPE_UNIT then -- input price per item
								MoneyInputFrame_SetCopper(StartPrice, myStartPrice);
								MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice);
								
							else -- input price for entire stack
								MoneyInputFrame_SetCopper(StartPrice, myStartPrice*stackSize);
								MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice*stackSize);
							end
							
						else -- this is not a stack
							MoneyInputFrame_SetCopper(StartPrice, myStartPrice);
							MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice);
						end
						
						--[[if UIDropDownMenu_GetSelectedValue(DurationDropDown) ~= 3 then 
							UIDropDownMenu_SetSelectedValue(DurationDropDown, 3); -- set duration to 3 (48h)
							DurationDropDownText:SetText("48 Hours"); -- set duration text since it keeps bugging to "Custom"
						end;]]
					end
						
					myBuyoutPrice = nil;
					myStartPrice = nil;
					currentPage = 0;
					selectedItem = nil;
					stackSize = nil;
				end
			end
		end
	end)
end

----------------------------------------------------------------------
-- Autogreed borrowed from NeavUI
----------------------------------------------------------------------
function MODULE:Autogreed()
	if db.autogreed ~= true then return end

	-- Option to only auto-greed at max level.
	local maxLevelOnly = true

	-- A skip list for green stuff you might not wanna auto-greed on
	local skipList = {
		--['Stone Scarab'] = true,
		--['Silver Scarab'] = true,
	}

	local AutoGreedFrame = CreateFrame('Frame')
	AutoGreedFrame:RegisterEvent('START_LOOT_ROLL')
	AutoGreedFrame:SetScript('OnEvent', function(_, _, rollID)
		if (maxLevelOnly and UnitLevel('player') == MAX_PLAYER_LEVEL) then
			local _, name, _, quality, BoP, _, _, canDisenchant = GetLootRollItemInfo(rollID)
			if (quality == 2 and not BoP and not skipList[name]) then
				RollOnLoot(rollID, canDisenchant and 3 or 2)
			end
		end
	end)
end
----------------------------------------------------------------------
-- Coords borrowed from NeavUI
----------------------------------------------------------------------
function MODULE:ChatBubbles()

	if db.chatbubbles == true then

		local select, pairs = select, pairs
		local format = string.format
		local CreateFrame = CreateFrame
		local C_ChatBubbles_GetAllChatBubbles = C_ChatBubbles.GetAllChatBubbles
		local RAID_CLASS_COLORS = RAID_CLASS_COLORS

		local function StyleBubble(frame)
			for i=1, frame:GetNumRegions() do
				local region = select(i, frame:GetRegions())
				if region:GetObjectType() == "Texture" then
					region:SetTexture(nil)
				elseif region:GetObjectType() == "FontString" then
					frame.text = region
				end
			end
			
			frame.text:SetFontObject('SystemFont_Small')
			frame.text:SetJustifyH('LEFT')

			frame:ClearAllPoints()
			frame:SetPoint('TOPLEFT', frame.text, -7, 7)
			frame:SetPoint('BOTTOMRIGHT', frame.text, 7, -7)
			frame:SetBackdrop({
				bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
				edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
				tile = true,
				tileSize = 16,
				edgeSize = 12,
				insets = {left=3, right=3, top=3, bottom=3},
			})
			frame:SetBackdropColor(0, 0, 0, 1)
			
			local r, g, b = frame.text:GetTextColor()
			frame:SetBackdropBorderColor(r, g, b, .8)
					
			frame.isSkinned = true
		end

		local frame = CreateFrame('Frame')
		frame.lastupdate = -2 -- wait 2 seconds before hooking frames
		local numChildren = 0
		frame:SetScript('OnUpdate', function(self, elapsed, guid, name)
			self.lastupdate = self.lastupdate + elapsed
			if (self.lastupdate < .1) then return end
			self.lastupdate = 0	
			
			for _, chatBubble in pairs(C_ChatBubbles_GetAllChatBubbles()) do
				if not chatBubble.isSkinned then				
					StyleBubble(chatBubble)
				end
			end
		end)
	end
end
----------------------------------------------------------------------
-- Coords borrowed from NeavUI
----------------------------------------------------------------------
function MODULE:Coords()
if db.coords ~= true then return end
	-- Temp fix until Blizzard removed the ! icon from the global string.
	--local _, MOUSE_LABEL = strsplit("1", MOUSE_LABEL, 2)
	
	local MapRects = {};
	local TempVec2D = CreateVector2D(0,0);
	local function GetPlayerMapPos(mapID)
		local R,P,_ = MapRects[mapID],TempVec2D;
		if not R then
			R = {};
			_, R[1] = C_Map.GetWorldPosFromMapPos(mapID,CreateVector2D(0,0));
			_, R[2] = C_Map.GetWorldPosFromMapPos(mapID,CreateVector2D(1,1));
			R[2]:Subtract(R[1]);
			MapRects[mapID] = R;
		end
		P.x, P.y = UnitPosition("Player");
		P:Subtract(R[1]);
		return (1/R[2].y)*P.y, (1/R[2].x)*P.x;
	end
	
	local CoordsFrame = CreateFrame('Frame', nil, WorldMapFrame)
	CoordsFrame:SetParent(WorldMapFrame.BorderFrame)

	CoordsFrame.Player = CoordsFrame:CreateFontString(nil, 'OVERLAY')
	CoordsFrame.Player:SetFont([[Fonts\FRIZQT__.ttf]], 15, 'THINOUTLINE')
	CoordsFrame.Player:SetJustifyH('LEFT')
	CoordsFrame.Player:SetPoint('BOTTOM', WorldMapFrame.BorderFrame, "BOTTOM", -100, 8)
	CoordsFrame.Player:SetTextColor(1, 0.82, 0)

	CoordsFrame.Mouse = CoordsFrame:CreateFontString(nil, 'OVERLAY')
	CoordsFrame.Mouse:SetFont([[Fonts\FRIZQT__.ttf]], 15, 'THINOUTLINE')
	CoordsFrame.Mouse:SetJustifyH('LEFT')
	CoordsFrame.Mouse:SetPoint('BOTTOMLEFT', CoordsFrame.Player, "BOTTOMLEFT", 120, 0)
	CoordsFrame.Mouse:SetTextColor(1, 0.82, 0)

	CoordsFrame:SetScript('OnUpdate', function(self, elapsed)
		if IsInInstance() then return end

		local mapID = C_Map.GetBestMapForUnit("player")
		local px, py = GetPlayerMapPos(mapID)

		if px then
			if px ~= 0 and py ~= 0 then
				self.Player:SetText(PLAYER..format(': %.0f x %.0f', px * 100, py * 100).." / ")
			else
				self.Player:SetText("")
			end
		end

		if WorldMapFrame.ScrollContainer:IsMouseOver() then
			local mx, my = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()

			if mx then
				if mx >= 0 and my >= 0 and mx <= 1 and my <= 1 then
					self.Mouse:SetText("Mouse"..format(': %.0f x %.0f', mx * 100, my * 100))
				else
					self.Mouse:SetText("")
				end
			end
		else
			self.Mouse:SetText("")
		end
	end)
end

----------------------------------------------------------------------
-- Flashing Nodes borrowed from Zygor
----------------------------------------------------------------------
function MODULE:FlashGatherNods()

	if db.flashnods ~= true then return end

	
	function AssignButtonTexture(obj,tx,num,total)
		self.ChainCall(obj):SetNormalTexture(CreateTexWithCoordsNum(obj,tx,num,total,1,4))
			:SetPushedTexture(CreateTexWithCoordsNum(obj,tx,num,total,2,4))
			:SetHighlightTexture(CreateTexWithCoordsNum(obj,tx,num,total,3,4))
			:SetDisabledTexture(CreateTexWithCoordsNum(obj,tx,num,total,4,4))
	end

	function self.ChainCall(obj)  local T={}  setmetatable(T,{__index=function(self,fun)  if fun=="__END" then return obj end  return function(self,...) assert(obj[fun],fun.." missing in object") obj[fun](obj,...) return self end end})  return T  end

	local flash_interval = 0.25

	local flash = nil
	local MinimapNodeFlash = function(s)
		flash = not flash
		Minimap:SetBlipTexture("\Interface\\AddOns\\BasicUI\\Media\\objecticons_"..(flash and "on" or "off"))
	end

	local q = 0
	do
		local flashFrame = CreateFrame("FRAME","PointerExtraFrame")
		local ant_last=GetTime()
		local flash_last=GetTime()
		flashFrame:SetScript("OnUpdate",function(self,elapsed)
			local t=GetTime()

			-- Flashing node dots. Prettier than the standard, too. And slightly bigger.
			if db.flashgathernodes then
				if t-flash_last>=flash_interval then
					MinimapNodeFlash()
					flash_last=t-(t-flash_last)%flash_interval
				end
			else
				Minimap:SetBlipTexture("\Interface\\AddOns\\BasicUI\\Media\\objecticons_on")		
			end
		end)

		flashFrame:SetPoint("CENTER",UIParent)
		flashFrame:Show()
		self.ChainCall(flashFrame:CreateTexture("PointerDotOn","OVERLAY")) :SetTexture("\Interface\\AddOns\\BasicUI\\Media\\objecticons_on") :SetSize(50,50) :SetPoint("CENTER") :SetNonBlocking(true) :Show()
		self.ChainCall(flashFrame:CreateTexture("PointerDotOff","OVERLAY")) :SetTexture("\Interface\\AddOns\\BasicUI\\Media\\objecticons_off") :SetSize(50,50) :SetPoint("RIGHT") :SetNonBlocking(true) :Show()
	end

end

----------------------------------------------------------------------
-- Merchant borrowed from Tukui and NeavUI
----------------------------------------------------------------------
function MODULE:Merchant()

	if db.merchant ~= true then return end
	
	local merchantUseGuildRepair = false	-- let your guild pay for your repairs if they allow.

	local MerchantFilter = {
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

	local Merchant_Frame = CreateFrame("Frame")
	Merchant_Frame:SetScript("OnEvent", function()
		local Cost = 0
		
		for Bag = 0, 4 do
			for Slot = 1, GetContainerNumSlots(Bag) do
				local Link, ID = GetContainerItemLink(Bag, Slot), GetContainerItemID(Bag, Slot)
				
				if (Link and ID) then
					local Price = 0
					local Mult1, Mult2 = select(11, GetItemInfo(Link)), select(2, GetContainerItemInfo(Bag, Slot))
					
					if (Mult1 and Mult2) then
						Price = Mult1 * Mult2
					end
					
					if (select(3, GetItemInfo(Link)) == 0 and Price > 0) then
						UseContainerItem(Bag, Slot)
						PickupMerchantItem()
						Cost = Cost + Price
					end
					
					if MerchantFilter[ID] then
						UseContainerItem(Bag, Slot)
						PickupMerchantItem()
						Cost = Cost + Price
					end
				end
			end
		end
		
		if (Cost > 0) then
			local Gold, Silver, Copper = math.floor(Cost / 10000) or 0, math.floor((Cost % 10000) / 100) or 0, Cost % 100
			
			DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|r Your grey item's have been sold for".." |cffffffff"..Gold.."|cffffd700g|r".." |cffffffff"..Silver.."|cffc7c7cfs|r".." |cffffffff"..Copper.."|cffeda55fc|r"..".",255,255,0)
		end
		
		if (not IsShiftKeyDown()) then
			if CanMerchantRepair() then
				local Cost, Possible = GetRepairAllCost()
				
				if (Cost > 0) then
					if (IsInGuild() and merchantUseGuildRepair) then
						local CanGuildRepair = (CanGuildBankRepair() and (Cost <= GetGuildBankWithdrawMoney()))
						
						if CanGuildRepair then
							RepairAllItems(1)
							
							return
						end
					end
					
					if Possible then
						RepairAllItems()
						
						local Copper = Cost % 100
						local Silver = math.floor((Cost % 10000) / 100)
						local Gold = math.floor(Cost / 10000)
						if guildRepairFlag == 1 then
							DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|r Your guild payed".." |cffffffff"..Gold.."|cffffd700g|r".." |cffffffff"..Silver.."|cffc7c7cfs|r".." |cffffffff"..Copper.."|cffeda55fc|r".." to repair your gear.",255,255,0)
						else
							DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|r You payed".." |cffffffff"..Gold.."|cffffd700g|r".." |cffffffff"..Silver.."|cffc7c7cfs|r".." |cffffffff"..Copper.."|cffeda55fc|r".." to repair your gear.",255,255,0)
						end
					else
						DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|r You don't have enough money for repair!", 255, 0, 0)
					end
				end
			end
		end		
	end)

	Merchant_Frame:RegisterEvent("MERCHANT_SHOW")

end

----------------------------------------------------------------------
-- Minimap Modifacations
----------------------------------------------------------------------
function MODULE:Minimap()
	if db.minimap ~= true then return end

	-- Bigger Minimap
	MinimapCluster:SetScale(1.2) 
	MinimapCluster:EnableMouse(false)
	
	-- Garrison Button
	--GarrisonLandingPageMinimapButton:SetSize(36, 36)

	-- Hide all Unwanted Things	
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()
		 
	--MiniMapTracking:UnregisterAllEvents()
	--MiniMapTracking:Hide()

	
	-- Enable Mousewheel Zooming
	Minimap:EnableMouseWheel(true)
	Minimap:SetScript('OnMouseWheel', function(self, delta)
		if (delta > 0) then
			_G.MinimapZoomIn:Click()
		elseif delta < 0 then
			_G.MinimapZoomOut:Click()
		end
	end)

	-- Modify the Minimap Tracking		
	--Minimap:SetScript('OnMouseUp', function(self, button)
		--if (button == 'RightButton') then
			--ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * 0.7), -3)
		--else
			--Minimap_OnClick(self)
		--end
	--end)
	Minimap:SetScript('OnEnter', function()
		if InCombatLockdown() then return end
		GameTooltip:SetOwner(Minimap, "ANCHOR_BOTTOM")
		GameTooltip:ClearLines()
		GameTooltip:AddLine("Minimap Options")
		GameTooltip:AddLine("|cffeda55fRight Click|r for Menu")
		GameTooltip:AddLine("|cffeda55fScroll|r for Zoom")
		GameTooltip:Show()
	end)
	Minimap:SetScript('OnLeave', function() GameTooltip:Hide() end)
end

----------------------------------------------------------------------
-- Minimap Modifacations
----------------------------------------------------------------------
function MODULE:SpellID()
    local select = select
    local find = string.find
    local sub = string.sub

    hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
        if not db.spellid then return end
        local id = select(10, UnitBuff(...))
        if id then
            self:AddLine("SpellID: "..id, 1, 1, 1)
            self:Show()
        end
    end)

    hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
        if not db.spellid then return end
        local id = select(10, UnitDebuff(...))
        if id then
            self:AddLine("SpellID: "..id, 1, 1, 1)
            self:Show()
        end
    end)

    hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
        if not db.spellid then return end
        local id = select(10, UnitAura(...))
        if id then
            self:AddLine("SpellID: "..id, 1, 1, 1)
            self:Show()
        end
    end)

    hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
        if not db.spellid then return end
        if find(link,"^spell:") then
            local id = sub(link, 7)
            ItemRefTooltip:AddLine("SpellID: "..id, 1, 1, 1)
            ItemRefTooltip:Show()
        end
    end)

    GameTooltip:HookScript("OnTooltipSetSpell", function(self)
        if not db.spellid then return end
        local id = select(2, self:GetSpell())
        if id then
            -- Workaround for weird issue when this gets triggered twice on the Talents frame
            -- https://github.com/renstrom/NeavUI/issues/76
            for i = 1, self:NumLines() do
                if _G["GameTooltipTextLeft"..i]:GetText() == "SpellID: "..id then
                    return
                end
            end

            self:AddLine("SpellID: "..id, 1, 1, 1)
            self:Show()
        end
    end)
end
	
function MODULE:OnEnable()
	self:AltBuy()
	self:Auction()
	self:Autogreed()
	self:Coords()
	self:ChatBubbles()
	self:FlashGatherNods()
	self:Merchant()
	self:Minimap()
	self:SpellID()
end


------------------------------------------------------------------------
--	 Module options
------------------------------------------------------------------------

local options
function MODULE:GetOptions()
	if options then
		return options
	end

	local function isModuleDisabled()
		return not BasicUI:GetModuleEnabled(MODULE_NAME)
	end

	options = {
		type = "group",
		name = L[MODULE_NAME],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
		disabled = isModuleDisabled(),
		args = {
			---------------------------
			--Option Type Seperators
			-- Sep1 is for Reload UI Spacing
			sep1 = {
				type = "description",
				order = 2,						
				name = " ",
			},
			-- Sep2 is for all toggle functions
			sep2 = {
				type = "description",
				order = 3,						
				name = " ",
			},
			-- sep3 is for 
			sep3 = {
				type = "description",
				order = 4,						
				name = " ",
			},
			sep4 = {
				type = "description",
				order = 5,						
				name = " ",
			},	
			---------------------------	
			Text1 = {
				type = "description",
				order = 1,
				name = " ",
				width = "full",
			},
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				desc = L["Enables the Misc Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = false,
			},
			Text2 = {
				type = "description",
				name = " ",
				width = "full",
			},
			altbuy = {
				type = "toggle",
				order = 2,
				name = L["Alt Buy"],
				desc = L["If Checked when you press and hold alt then click an item at a merchant it will buy max quantity"],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},			
			auction = {
				type = "toggle",
				order = 2,						
				name = L["Auction"],
				desc = L["Enables and auto lookup for prices at the auction house when and item is put into the main window."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			autogreed = {
				type = "toggle",
				order = 2,						
				name = L["Autogreed"],
				desc = L["Auto Roll Greed when in an Instance group."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			chatbubbles = {
				type = "toggle",
				order = 2,						
				name = L["Chat Bubbles"],
				desc = L["Enables skinning of the chat bubbles.."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},		
			coords = {
				type = "toggle",
				order = 2,						
				name = L["Coords"],
				desc = L["Adds coordinates of player and arrow to main Map."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			flashnods = {
				type = "toggle",
				order = 2,						
				name = L["Flashing Nods"],
				desc = L["Makes it so the nodes on the Minimap flash.."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},			
			merchant = {
				type = "toggle",
				order = 2,						
				name = L["Merchant"],
				desc = L["Enables Auto Selling or Grey Items and Auto Repair when a merchant window is opened. [If Shift is held down you can use Guild Funds for Repair]"],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			minimap = {
				type = "toggle",
				order = 2,						
				name = L["Minimap"],
				desc = L["Changes scale of Minimap Cluster."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			spellid = {
				type = "toggle",
				order = 2,						
				name = L["SpellID"],
				desc = L["All the Spell ID to tooltip."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		},
	}
	return options
end