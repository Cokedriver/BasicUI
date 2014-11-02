local MODULE_NAME = "Miscellaneous"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Miscellaneous = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		flashgathernodes = true,
		quicky = true,
		vellum = true,
		altbuy = true,
		quest = true,

		autogreed = {
			enable = true,			-- Auto Roll greed for green items.
			disenchant = true,		-- Disenchant Green Item's on Roll
		},
		
		merchant = {
			enable = true,
			autoSellGrey = true,	-- autosell grey items at merchant.
			autoRepair = true,		-- autorepair at merchant.
			guildPay = false,			-- let your guild pay for your repairs if they allow.
		},
		quest = {
			enable = true,			-- enable quest module.
			tekvendor = true,		-- Tek's best quest item by vendor price.			
			autocomplete = false,	-- enable the autoaccept quest and autocomplete quest if no reward.
		},
		skin = {
			enable = true,
			DBM = true,
			Recount = true,
			RecountBackdrop = true,
		},
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

local classColor

function Miscellaneous:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function Miscellaneous:FlashGatherNods()
	if (IsAddOnLoaded('Zygor Guides Viewer 4')) then return end

	
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
		Minimap:SetBlipTexture("Interface\\AddOns\\BasicUI\\Media\\objecticons_"..(flash and "on" or "off"))
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
				Minimap:SetBlipTexture("Interface\\AddOns\\BasicUI\\Media\\objecticons_on")		
			end
		end)

		flashFrame:SetPoint("CENTER",UIParent)
		flashFrame:Show()
		self.ChainCall(flashFrame:CreateTexture("PointerDotOn","OVERLAY")) :SetTexture("Interface\\AddOns\\BasicUI\\Media\\objecticons_on") :SetSize(50,50) :SetPoint("CENTER") :SetNonBlocking(true) :Show()
		self.ChainCall(flashFrame:CreateTexture("PointerDotOff","OVERLAY")) :SetTexture("Interface\\AddOns\\BasicUI\\Media\\objecticons_off") :SetSize(50,50) :SetPoint("RIGHT") :SetNonBlocking(true) :Show()
	end
end

function Miscellaneous:Quicky()

	if db.quicky ~= true then return end

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

function Miscellaneous:Velluminous()
	if db.vellum ~= true then return end 
	
	if not TradeSkillFrame then
		print("What the fuck?  Velluminous cannot initialize.  BAIL!  BAIL!  BAIL!")
		return
	end


	local butt = CreateFrame("Button", nil, TradeSkillCreateButton, "SecureActionButtonTemplate")
	butt:SetAttribute("type", "macro")
	butt:SetAttribute("macrotext", "/click TradeSkillCreateButton\n/use item:38682")

	butt:SetText("Vellum")

	butt:SetPoint("RIGHT", TradeSkillCreateButton, "LEFT")

	butt:SetWidth(80) butt:SetHeight(22)

	-- Fonts --
	butt:SetDisabledFontObject(GameFontDisable)
	butt:SetHighlightFontObject(GameFontHighlight)
	butt:SetNormalFontObject(GameFontNormal)

	-- Textures --
	butt:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up")
	butt:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down")
	butt:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
	butt:SetDisabledTexture("Interface\\Buttons\\UI-Panel-Button-Disabled")
	butt:GetNormalTexture():SetTexCoord(0, 0.625, 0, 0.6875)
	butt:GetPushedTexture():SetTexCoord(0, 0.625, 0, 0.6875)
	butt:GetHighlightTexture():SetTexCoord(0, 0.625, 0, 0.6875)
	butt:GetDisabledTexture():SetTexCoord(0, 0.625, 0, 0.6875)
	butt:GetHighlightTexture():SetBlendMode("ADD")

	local hider = CreateFrame("Frame", nil, TradeSkillCreateAllButton)
	hider:SetScript("OnShow", function() butt:Hide() end)
	hider:SetScript("OnHide", function() butt:Show() end)
end

function Miscellaneous:Merchant()
	
	------------
	-- Merchant
	------------
	-- Credit for Merchant goes to Tuks for his Tukui project.
	-- You can find his Addon at http://tukui.org/dl.php
	-- Editied by Cokedriver
	
	if db.merchant.enable ~= true then return end
	
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
		if db.merchant.autoSellGrey or db.merchant.sellMisc then
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
						
						if (db.merchant.autoSellGrey and select(3, GetItemInfo(Link)) == 0 and Price > 0) then
							UseContainerItem(Bag, Slot)
							PickupMerchantItem()
							Cost = Cost + Price
						end
						
						if db.merchant.sellMisc and MerchantFilter[ID] then
							UseContainerItem(Bag, Slot)
							PickupMerchantItem()
							Cost = Cost + Price
						end
					end
				end
			end
			
			if (Cost > 0) then
				local Gold, Silver, Copper = math.floor(Cost / 10000) or 0, math.floor((Cost % 10000) / 100) or 0, Cost % 100
				
				DEFAULT_CHAT_FRAME:AddMessage("Your grey item's have been sold for".." |cffffffff"..Gold.."|cffffd700g|r".." |cffffffff"..Silver.."|cffc7c7cfs|r".." |cffffffff"..Copper.."|cffeda55fc|r"..".",255,255,0)
			end
		end
		
		if (not IsShiftKeyDown()) then
			if (CanMerchantRepair() and db.merchant.autoRepair) then
				local Cost, Possible = GetRepairAllCost()
				
				if (Cost > 0) then
					if (IsInGuild() and db.merchant.UseGuildRepair) then
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
							DEFAULT_CHAT_FRAME:AddMessage("Your guild payed".." |cffffffff"..Gold.."|cffffd700g|r".." |cffffffff"..Silver.."|cffc7c7cfs|r".." |cffffffff"..Copper.."|cffeda55fc|r".." to repair your gear.",255,255,0)
						else
							DEFAULT_CHAT_FRAME:AddMessage("You payed".." |cffffffff"..Gold.."|cffffd700g|r".." |cffffffff"..Silver.."|cffc7c7cfs|r".." |cffffffff"..Copper.."|cffeda55fc|r".." to repair your gear.",255,255,0)
						end
					else
						DEFAULT_CHAT_FRAME:AddMessage(L.Merchant.NotEnoughMoney, 255, 0, 0)
					end
				end
			end
		end		
	end)
	Merchant_Frame:RegisterEvent("MERCHANT_SHOW")	

end

function Miscellaneous:Autogreed()

	if db.autogreed.enable ~= true then return end

	local skipList = {
		--['Stone Scarab'] = true,
		--['Silver Scarab'] = true,
	}

	local ag = CreateFrame('Frame')
	ag:RegisterEvent('START_LOOT_ROLL')
	ag:SetScript('OnEvent', function(_, _, RollID)
		local texture, name, count, quality, bindOnPickUp , canNeed, canGreed, canDisenchant = GetLootRollItemInfo(RollID)
		
		if db.autogreed.disenchant ~= true then
			if (quality == 2 and not bindOnPickUp) then
				RollOnLoot(RollID, canGreed and 3 or 2)
			end
		else
			if (quality == 2 and not bindOnPickUp) then
				RollOnLoot(RollID, canDisenchant and 3 or 2)
			end
		end
	end)
end

function Miscellaneous:AltBuy()

	if db.altbuy ~= true then return end

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

function Miscellaneous:Quest()
	if db.quest ~= true then return end

	local f = CreateFrame("Frame")

	local function MostValueable()
		local bestp, besti = 0
		for i=1,GetNumQuestChoices() do
			local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
			local price = link and select(11, GetItemInfo(link))
			if not price then
				return
			elseif (price * (qty or 1)) > bestp then
				bestp, besti = (price * (qty or 1)), i
			end
		end
		if besti then		
			local btn = _G["QuestInfoItem"..besti]
			if (btn.type == "choice") then
				btn:GetScript("OnClick")(btn)
			end
		end
	end
	
	f:RegisterEvent("QUEST_ITEM_UPDATE")
	f:RegisterEvent("GET_ITEM_INFO_RECEIVED")	
	f:RegisterEvent("QUEST_ACCEPT_CONFIRM")    
	f:RegisterEvent("QUEST_DETAIL")
	f:RegisterEvent("QUEST_COMPLETE")
	f:SetScript("OnEvent", function(self, event, ...)
		if db.quest.autocomplete ~= false then
			if (event == "QUEST_DETAIL") then
				AcceptQuest()
				CompleteQuest()
			elseif (event == "QUEST_COMPLETE") then
				if (GetNumQuestChoices() and GetNumQuestChoices() < 1) then
					GetQuestReward()
				else
					MostValueable()
				end
			elseif (event == "QUEST_ACCEPT_CONFIRM") then
				ConfirmAcceptQuest()
			end
		else
			if (event == "QUEST_COMPLETE") then
				if (GetNumQuestChoices() and GetNumQuestChoices() < 1) then
					GetQuestReward()
				else
					MostValueable()
				end
			end
		end
	end)
end

function Miscellaneous:SkinAddons()
	--[[

		All Credit for Skinning.lua goes to Neal and ballagarba.
		Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
		Edited by Cokedriver.
		
	]]
	
	local ccolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]

	if db.skin.enable ~= true then return end

	local f = CreateFrame('Frame')
	f:RegisterEvent('VARIABLES_LOADED')
	f:RegisterEvent('ADDON_LOADED')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')


	f:SetScript('OnEvent', function(self, ...)
		---------------
		-- DBM Skinning
		---------------
		
		if (db.skin.DBM == true and IsAddOnLoaded('DBM-Core')) then	
			-- Normal Bars (Credit for DBM codeing goes to Elv from ElvUI)
			hooksecurefunc(DBT, 'CreateBar', function(self)
				for bar in self:GetBarIterator() do
					if not bar.injected then
							bar.ApplyStyle=function()
							local frame = bar.frame
							local tbar = _G[frame:GetName().."Bar"]
							local spark = _G[frame:GetName().."BarSpark"]
							local texture = _G[frame:GetName().."BarTexture"]
							local icon1 = _G[frame:GetName().."BarIcon1"]
							local icon2 = _G[frame:GetName().."BarIcon2"]
							local name = _G[frame:GetName().."BarName"]
							local timer = _G[frame:GetName().."BarTimer"]
							
							if not (icon1.overlay) then
								icon1.overlay = CreateFrame("Frame", "$parentIcon1Overlay", tbar)
								icon1.overlay:SetSize(26, 26)
								icon1.overlay:SetFrameStrata("MEDIUM");
								icon1.overlay:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", -22/4, -4);
								icon1.overlay:SetBackdrop({
									edgeFile = db.skin.border,
									tile = true, tileSize = 16, edgeSize = 18,
								})

								if BasicUI.db.profile.general.classcolor then
									icon1.overlay:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
								end

								icon1.overlay.styled=true
							end

							if not (icon2.overlay) then
								icon2.overlay = CreateFrame("Frame", "$parentIcon2Overlay", tbar)
								icon2.overlay:SetSize(26, 26)
								icon2.overlay:SetFrameStrata("MEDIUM");
								icon2.overlay:SetPoint("BOTTOMLEFT", tbar, "BOTTOMRIGHT", 22/4, -4);
								icon2.overlay:SetBackdrop({
									edgeFile = db.skin.border,
									tile = true, tileSize = 16, edgeSize = 18,
								})

								if BasicUI.db.profile.general.classcolor then
									icon2.overlay:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
								end

								icon2.overlay.styled=true				
							end

							if bar.color then
								tbar:SetStatusBarColor(ccolor.r, ccolor.g, ccolor.b)
							else
								tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
							end
							
							if bar.enlarged then frame:SetWidth(bar.owner.options.HugeWidth) else frame:SetWidth(bar.owner.options.Width) end
							if bar.enlarged then tbar:SetWidth(bar.owner.options.HugeWidth) else tbar:SetWidth(bar.owner.options.Width) end

							if not frame.styled then
								frame:SetScale(1)
								frame.SetScale=B.dummy
								frame:SetHeight(22)
								local border = CreateFrame("Frame", nil, frame);
								border:SetFrameStrata("MEDIUM");
								border:SetPoint("TOPLEFT", -2, 2);
								border:SetPoint("BOTTOMRIGHT", 2, -2);
								border:SetBackdrop({
									edgeFile = db.skin.border,
									tile = true, tileSize = 16, edgeSize = 18,
								})

								if BasicUI.db.profile.general.classcolor then
									border:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
								end

								frame.styled=true
							end

							if not spark.killed then
								spark:SetAlpha(0)
								spark:SetTexture(nil)
								spark.killed=true
							end
				
							if not icon1.styled then
								icon1:SetTexCoord(0.08, 0.92, 0.08, 0.92)
								icon1:ClearAllPoints()
								icon1:SetPoint("TOPLEFT", icon1.overlay, 2, -2)
								icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, -2, 2)
								icon1.styled=true
							end
							
							if not icon2.styled then
								icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92)
								icon2:ClearAllPoints()
								icon2:SetPoint("TOPLEFT", icon2.overlay, 2, -2)
								icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, -2, 2)
								icon2.styled=true
							end

							if not texture.styled then
								texture:SetTexture(db.skin.statusbar)
								texture.styled=true
							end
							
							tbar:SetStatusBarTexture(db.skin.statusbar)
							if not tbar.styled then
								tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
								tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
								
								tbar.styled=true
							end

							if not name.styled then
								name:ClearAllPoints()
								name:SetPoint("LEFT", frame, "LEFT", 4, 0)
								name:SetWidth(165)
								name:SetHeight(8)
								name:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize)
								name:SetJustifyH("LEFT")
								name:SetShadowColor(0, 0, 0, 0)
								name.SetFont = B.dummy
								name.styled=true
							end
							
							if not timer.styled then	
								timer:ClearAllPoints()
								timer:SetPoint("RIGHT", frame, "RIGHT", -4, 0)
								timer:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize)
								timer:SetJustifyH("RIGHT")
								timer:SetShadowColor(0, 0, 0, 0)
								timer.SetFont = B.dummy
								timer.styled=true
							end

							if bar.owner.options.IconLeft then icon1:Show() icon1.overlay:Show() else icon1:Hide() icon1.overlay:Hide() end
							if bar.owner.options.IconRight then icon2:Show() icon2.overlay:Show() else icon2:Hide() icon2.overlay:Hide() end
							tbar:SetAlpha(1)
							frame:SetAlpha(1)
							texture:SetAlpha(1)
							frame:Show()
							bar:Update(0)
							bar.injected=true
						end
						bar:ApplyStyle()
					end

				end
			end)
			
			-- DBM Boss Healthbars
			hooksecurefunc(DBM.BossHealth,"Show",function()
				local anchor=DBMBossHealthDropdown:GetParent()
				if not anchor.styled then
					local header={anchor:GetRegions()}
						if header[1]:IsObjectType("FontString") then
							header[1]:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize)
							header[1]:SetTextColor(1,1,1,1)
							header[1]:SetShadowColor(0, 0, 0, 0)
							anchor.styled=true	
						end
					header=nil
				end
				anchor=nil
			end)
			
			hooksecurefunc(DBM.BossHealth, "AddBoss", function()
				local count = 1
				while (_G[format("DBM_BossHealth_Bar_%d", count)]) do
					local bar = _G[format("DBM_BossHealth_Bar_%d", count)]
					local background = _G[bar:GetName().."BarBorder"]
					local progress = _G[bar:GetName().."Bar"]
					local name = _G[bar:GetName().."BarName"]
					local timer = _G[bar:GetName().."BarTimer"]
					local prev = _G[format("DBM_BossHealth_Bar_%d", count-1)]	

					if (count == 1) then
						local	_, anch, _ ,_, _ = bar:GetPoint()
						bar:ClearAllPoints()
						if DBM_SavedOptions.HealthFrameGrowUp then
							bar:SetPoint("BOTTOM", anch, "TOP" , 0 , 12)
						else
							bar:SetPoint("TOP", anch, "BOTTOM" , 0, -22)
						end
					else
						bar:ClearAllPoints()
						if DBM_SavedOptions.HealthFrameGrowUp then
							bar:SetPoint("TOPLEFT", prev, "TOPLEFT", 0, 26)
						else
							bar:SetPoint("TOPLEFT", prev, "TOPLEFT", 0, -26)
						end
					end

					if not bar.styled then
						bar:SetHeight(22)
						background:SetNormalTexture(nil)
						local barb = CreateFrame("Frame", nil, bar);
						barb:SetFrameStrata("MEDIUM");
						barb:SetPoint("TOPLEFT", -2, 2);
						barb:SetPoint("BOTTOMRIGHT", 2, -2);
						barb:SetBackdrop({
							edgeFile = db.skin.border,
							tile = true, tileSize = 16, edgeSize = 18,
						})

						if BasicUI.db.profile.general.classcolor then
							barb:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
						end

						bar.styled=true
					end	
					
					if not progress.styled then
						progress:SetStatusBarTexture(db.skin.statusbar)
						progress:SetStatusBarColor(ccolor.r, ccolor.g, ccolor.b)
						progress.styled=true
					end				
					progress:ClearAllPoints()
					progress:SetPoint("TOPLEFT", bar, "TOPLEFT", 2, -2)
					progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -2, 2)

					if not name.styled then
						name:ClearAllPoints()
						name:SetPoint("LEFT", bar, "LEFT", 4, 0)
						name:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize)
						name:SetJustifyH("LEFT")
						name:SetShadowColor(0, 0, 0, 0)
						name.styled=true
					end
					
					if not timer.styled then
						timer:ClearAllPoints()
						timer:SetPoint("RIGHT", bar, "RIGHT", -4, 0)
						timer:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize)
						timer:SetJustifyH("RIGHT")
						timer:SetShadowColor(0, 0, 0, 0)
						timer.styled=true
					end
					count = count + 1
				end
			end)
		end
		
		-------------------
		-- Recount Skinning
		-------------------
		
		if (db.skin.Recount == true and IsAddOnLoaded('Recount')) then
			local rm = Recount.MainWindow
			if db.skin.RecountBackdrop == false then 
				rm:SetBackdrop(nil)
			end
			local bgs = CreateFrame("Frame", nil, rm);
			bgs:SetFrameStrata("MEDIUM");
			bgs:SetPoint("TOPLEFT", -3, -8);
			bgs:SetPoint("BOTTOMRIGHT", 1, 0);
			bgs:SetBackdrop({
				edgeFile = db.skin.border,
				tile = true, tileSize = 16, edgeSize = 18,
			})

			if BasicUI.db.profile.general.classcolor then
				bgs:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
			end
			
		end
	end)
end

function Miscellaneous:OnEnable()	
	self:FlashGatherNods()
	self:Velluminous()
	self:Quicky()
	self:Autogreed()
	self:Quest()
	self:AltBuy()
	self:Merchant()
	self:SkinAddons()
end


------------------------------------------------------------------------
--	 Module options
------------------------------------------------------------------------

local options
function Miscellaneous:GetOptions()
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
		set = function(info, value) db[ info[#info] ] = value;   end,
		disabled = isModuleDisabled(),
		args = {
			---------------------------
			--Option Type Seperators
			sep1 = {
				type = "description",
				order = 2,						
				name = " ",
			},
			sep2 = {
				type = "description",
				order = 3,						
				name = " ",
			},
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
			reloadUI = {
				type = "execute",
				name = "Reload UI",
				desc = " ",
				order = 0,
				func = 	function()
					ReloadUI()
				end,
			},
			Text = {
				type = "description",
				order = 0,
				name = "When changes are made a reload of the UI is needed.",
				width = "full",
			},
			Text1 = {
				type = "description",
				order = 1,
				name = " ",
				width = "full",
			},
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable Miscellaneous Module"],
				width = "full",
				disabled = false,
			},
			Text2 = {
				type = "description",
				name = " ",
				width = "full",
			},			
			vellum = {
				type = "toggle",
				order = 2,						
				name = L["Vellum"],
				desc = L["Enables a vellum button for Enchanters to click."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			quicky = {
				type = "toggle",
				order = 2,						
				name = L["Quicky"],
				desc = L["Enables a quick hide show for your helm and cloak on your character page."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			altbuy = {
				type = "toggle",
				order = 2,
				name = L["Alt Buy"],
				desc = L["If Checked when at a merchant Alt + Left Click will buy a full stack."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			flashgathernodes = {
				type = "toggle",
				order = 3,						
				name = L["Flash Gathering Nodes"],
				desc = L["Enables flashing map nodes for tracking herbs and ore."],
				width = "full",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},			
			autogreed = {
				type = "group",
				order = 4,
				name = L["Auto Greed Roll"],
				guiInline  = true,
				get = function(info) return db.autogreed[ info[#info] ] end,
				set = function(info, value) db.autogreed[ info[#info] ] = value;   end,
				disabled = function() return isModuleDisabled() or not db.enable end,
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables Auto Rolling Greed on Green item's when in a Instance or Raid"],
						width = "full",
					},
					disenchant = {
						type = "toggle",
						order = 2,
						name = L["Auto Disenchant"],
						desc = L["If Checked when in a a group any green items will have Disenchant auto selected if a enchanter is in your group"],
						disabled = function() return isModuleDisabled() or not db.enable or not db.autogreed.enable end,
					},
				},
			},		
			merchant = {
				type = "group",
				order = 5,
				name = L["Merchant"],
				guiInline  = true,
				get = function(info) return db.merchant[ info[#info] ] end,
				set = function(info, value) db.merchant[ info[#info] ] = value;   end,
				disabled = function() return isModuleDisabled() or not db.enable end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
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
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enable Merchant Settings"],
						width = "full",
					},
					autoRepair = {
						type = "toggle",
						order = 2,
						name = L["Auto Repair"],
						desc = L["Automatically repair when visiting a vendor"],
						disabled = function() return isModuleDisabled() or not db.enable or not db.merchant.enable end,
					},
					guildPay = {
						type = "toggle",
						order = 2,
						name = L["Guild Repair"],
						desc = L["If Checked your guild will pay for your repairs"],
						disabled = function() return isModuleDisabled() or not db.enable or not db.merchant.enable end,
					},
					autoSellGrey = {
						type = "toggle",
						order = 2,
						name = L["Sell Grays"],
						desc = L["Automatically sell gray items when visiting a vendor"],
						disabled = function() return isModuleDisabled() or not db.enable or not db.merchant.enable end,
					},
				},
			},
			skin = {
				type = "group",
				order = 7,
				name = L["Skin Addons"],
				guiInline  = true,				
				get = function(info) return db.skin[ info[#info] ] end,
				set = function(info, value) db.skin[ info[#info] ] = value;  end,
				disabled = function() return isModuleDisabled() or not db.enable end,				
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,										
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,										
						name = " ",
					},
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
					enable = {
						type = "toggle",					
						order = 1,
						name = L["Enable Skinning Addon's to match BasicUI"],
						width = "full",						
					},						
					DBM = {
						type = "toggle",					
						order = 2,
						name = L["DBM"],
						desc = L["Skins Deadly Boss Mods to match BasicUI."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.skin.enable end,
					},
					Recount = {
						type = "toggle",					
						order = 2,
						name = L["Recount"],
						desc = L["Skins Recount to match BasicUI."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.skin.enable end,
					},
					RecountBackdrop = {
						type = "toggle",					
						order = 2,
						name = L["Recount Backdrop"],
						desc = L["Keep the backdrop in the Recount Window."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.skin.enable end,
					},
				},
			},
		},
	}
	return options
end