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
		cooldown = true,
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

function Miscellaneous:Cooldown()
	
	if db.cooldown ~= true then return end

	OmniCC = true                               -- hack to work around detection from other addons for OmniCC

	local FONT_COLOR = {1, 1, 1}
	local FONT_FACE, FONT_SIZE = BasicUI.media.fontNormal, 20

	local MIN_DURATION = 2.5                    -- the minimum duration to show cooldown text for
	local DECIMAL_THRESHOLD = 2                 -- threshold in seconds to start showing decimals

	local MIN_SCALE = 0.5                       -- the minimum scale we want to show cooldown counts at, anything below this will be hidden
	local ICON_SIZE = 36

	local DAY, HOUR, MINUTE = 86400, 3600, 60
	local DAYISH, HOURISH, MINUTEISH = 3600 * 23.5, 60 * 59.5, 59.5 
	local HALFDAYISH, HALFHOURISH, HALFMINUTEISH = DAY/2 + 0.5, HOUR/2 + 0.5, MINUTE/2 + 0.5

	local GetTime = GetTime

	local min = math.min
	local floor = math.floor
	local format = string.format

	local round = function(x) 
		return floor(x + 0.5) 
	end

	local function getTimeText(s)
		if (s < DECIMAL_THRESHOLD + 0.5) then
			return format('|cffff0000%.1f|r', s), s - format('%.1f', s)
		elseif (s < MINUTEISH) then
			local seconds = round(s)
			return format('|cffffff00%d|r', seconds), s - (seconds - 0.51)
		elseif (s < HOURISH) then
			local minutes = round(s/MINUTE)
			return format('|cffffffff%dm|r', minutes), minutes > 1 and (s - (minutes*MINUTE - HALFMINUTEISH)) or (s - MINUTEISH)
		elseif (s < DAYISH) then
			local hours = round(s/HOUR)
			return format('|cffccccff%dh|r', hours), hours > 1 and (s - (hours*HOUR - HALFHOURISH)) or (s - HOURISH)
		else
			local days = round(s/DAY)
			return format('|cffcccccc%dd|r', days), days > 1 and (s - (days*DAY - HALFDAYISH)) or (s - DAYISH)
		end
	end

		-- stops the timer

	local function Timer_Stop(self)
		self.enabled = nil
		self:Hide()
	end

		-- forces the given timer to update on the next frame

	local function Timer_ForceUpdate(self)
		self.nextUpdate = 0
		self:Show()
	end

		-- adjust font size whenever the timer's parent size changes, hide if it gets too tiny

	local function Timer_OnSizeChanged(self, width, height)
		local fontScale = round(width) / ICON_SIZE

		if (fontScale == self.fontScale) then
			return
		end

		self.fontScale = fontScale

		if (fontScale < MIN_SCALE) then
			self:Hide()
		else
			self.text:SetFont(FONT_FACE, fontScale * FONT_SIZE, 'OUTLINE')
			self.text:SetShadowColor(0, 0, 0, 0.5)
			self.text:SetShadowOffset(2, -2)

			if (self.enabled) then
				Timer_ForceUpdate(self)
			end
		end
	end

		-- update timer text, if it needs to be, hide the timer if done

	local function Timer_OnUpdate(self, elapsed)
		if (self.nextUpdate > 0) then
			self.nextUpdate = self.nextUpdate - elapsed
		else
			local remain = self.duration - (GetTime() - self.start)
			if (round(remain) > 0) then
				local time, nextUpdate = getTimeText(remain)
				self.text:SetText(time)
				self.nextUpdate = nextUpdate
			else
				Timer_Stop(self)
			end
		end
	end

		-- returns a new timer object

	local function Timer_Create(self)
		local scaler = CreateFrame('Frame', nil, self)
		scaler:SetAllPoints(self)

		local timer = CreateFrame('Frame', nil, scaler)
		timer:Hide()
		timer:SetAllPoints(scaler)
		timer:SetScript('OnUpdate', Timer_OnUpdate)

		local text = timer:CreateFontString(nil, 'BACKGROUND ')
		text:SetPoint('CENTER', 0, 0)
		text:SetJustifyH("CENTER")
		timer.text = text

		Timer_OnSizeChanged(timer, scaler:GetSize())
		scaler:SetScript('OnSizeChanged', function(self, ...) 
			Timer_OnSizeChanged(timer, ...) 
		end)

		self.timer = timer

		return timer
	end

		-- hook the SetCooldown method of all cooldown frames
		-- ActionButton1Cooldown is used here since its likely to always exist 
		-- and I'd rather not create my own cooldown frame to preserve a tiny bit of memory

	hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, 'SetCooldown', function(self, start, duration)
		if (self.noOCC) then 
			return 
		end

		if (start > 0 and duration > MIN_DURATION) then
			local timer = self.timer or Timer_Create(self)
			timer.start = start
			timer.duration = duration
			timer.enabled = true
			timer.nextUpdate = 0

			if (timer.fontScale >= MIN_SCALE) then 
				timer:Show() 
			end
		else
			local timer = self.timer
			
			if (timer) then
				Timer_Stop(timer)
			end
		end
	end)
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

	if db.merchant.enable ~= true then return end
	
	-- Credit for Merchant goes to Tuks for his Tukui project.
	-- You can find his Addon at http://tukui.org/dl.php
	-- Editied by Cokedriver

	local sg = CreateFrame("Frame")
	sg:SetScript("OnEvent", function()
		if db.merchant.autoSellGrey then
			local c = 0
			for b=0,4 do
				for s=1,GetContainerNumSlots(b) do
					local l,lid = GetContainerItemLink(b, s), GetContainerItemID(b, s)
					if l and lid then
					local p = 0
					local mult1, mult2 = select(11, GetItemInfo(l)), select(2, GetContainerItemInfo(b, s))
					if mult1 and mult2 then p = mult1 * mult2 end					
						if db.merchant.autoSellGrey and select(3, GetItemInfo(l)) == 0 and p > 0 then
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
						if db.merchant.guildPay == "true" and guildRepairFlag == 1 then
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
	sg:RegisterEvent("MERCHANT_SHOW")	

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
	self:Cooldown()
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
			cooldown = {
				type = "toggle",
				order = 2,						
				name = L["Cooldown"],
				desc = L["Enables a version of OmniCC."],
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
				name = L["Auto Disenchant"],
				desc = L["If Checked when in a a group any green items will have Disenchant auto selected if a enchanter is in your group"],
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
			quest = {
				type = "group",			
				order = 6,
				name = L["Quest"],
				desc = L["Quest Module for BasicUI."],
				guiInline  = true,
				get = function(info) return db.quest[ info[#info] ] end,
				set = function(info, value) db.quest[ info[#info] ] = value; end,
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
						desc = L["Enables Quest Module"],							
					},					
					autocomplete = {
						type = "toggle",					
						order = 2,
						name = L["Autocomplete"],
						desc = L["Automatically complete your quest."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.quest.enable end,
					},
					tekvendor = {
						type = "toggle",
						order = 2,						
						name = L["Tek's Vendor"],
						desc = L["Enables Tek's best quest item by vendor price."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.quest.enable end,						
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