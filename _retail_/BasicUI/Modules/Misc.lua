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
		autogreed = true,
		coords = true,
		ilvlchange = true,
		hdt = true,
		massprospect = true,
		merchant = true,
		minimap = true,
		orderhall = true,
		rarealert = true,
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

local classColor

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

	local AutoGreedFrame = CreateFrame('Frame', nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
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
function MODULE:Coords()
if db.coords ~= true then return end
	-- Temp fix until Blizzard removed the ! icon from the global string.
	local _, MOUSE_LABEL = strsplit("1", MOUSE_LABEL, 2)
	
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
	
	local CoordsFrame = CreateFrame('Frame', nil, WorldMapFrame, BackdropTemplateMixin and "BackdropTemplate")
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
					self.Mouse:SetText(" Mouse"..format(': %.0f x %.0f', mx * 100, my * 100))
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
-- Item Level Change by 
----------------------------------------------------------------------
local ilvl = -1

local f = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_AVG_ITEM_LEVEL_UPDATE")
f:SetScript("OnEvent", function()
	local total, equipped = GetAverageItemLevel()
	total = math.floor(total)
	if total == ilvl then
		return
	end
	local color = ChatTypeInfo["SYSTEM"]
	if total > ilvl then
		DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|r Your average item level is now |cff99ff99" .. total .. "|r, up from " .. ilvl, color.r, color.g, color.b)
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|r Your average item level is now |cffff9999" .. total .. "|r, down from " .. ilvl, color.r, color.g, color.b)
	end
	ilvl = total
end)

----------------------------------------------------------------------
-- borrowed from Leatrix.Plus
----------------------------------------------------------------------
function MODULE:HideDamageText()
	if db.hdt ~= true then return end

	-- Hide hit indicators (portrait text)
	hooksecurefunc(PlayerHitIndicator, "Show", PlayerHitIndicator.Hide)
	hooksecurefunc(PetHitIndicator, "Show", PetHitIndicator.Hide)
	
end

----------------------------------------------------------------------
-- Mass Prospect by Kaemin
----------------------------------------------------------------------
function MODULE:MassProspect()
	if db.massprospect ~= true then return end
	SLASH_MassProspect1 = '/mp';

	-- by Kaemin

	function SlashCmdList.MassProspect(msg, editbox)
		if msg == nil or msg == "" or msg == "menu" or msg == "options" or msg == "?" or msg == "help" then
			MassProspect_Define();
		end
		if msg == "reset" then
			DeleteMacro("MassProspect");
			BasicDBPerCharacter = false;
	--		MassProspect_Define();
		end
	end

	function MassProspect_Define()
		local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions();
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(prof1);
		local aname, aicon, askillLevel, amaxSkillLevel, anumAbilities, aspelloffset, askillLine, askillModifier, aspecializationIndex, aspecializationOffset = GetProfessionInfo(prof2);
		if aname=="Jewelcrafting" then name=aname end
		if name == "Jewelcrafting" then
			SPProfCheck = "true";
			MPMacroString = "/run local f,l,n=MPB or CreateFrame(".."\"".."Button".."\""..",".."\"".."MPB".."\""..",nil,".."\"".."SecureActionButtonTemplate".."\""..") f:SetAttribute(".."\"".."type".."\""..",".."\"".."macro".."\""..") l,n=MassProspect_Ore() if l then f:SetAttribute(".."\"".."macrotext".."\""..",".."\"".."/cast Prospecting\\n/use ".."\"".."..l) SetMacroItem(".."\"".."MassProspect".."\""..",n) end\n/click MPB"
			if BasicDBPerCharacter == false then
				local index = CreateMacro("MassProspect", "Inv_misc_gem_bloodgem_01", MPMacroString, 1);
				BasicDBPerCharacter = true;
			else
			local newIndex = EditMacro("MassProspect", "MassProspect", "Inv_misc_gem_bloodgem_01", MPMacroString);
			end
		else
			SPProfCheck = "false";
			DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|r|cffffff00 You are |r|cffff0000NOT|r |cffffff00a jewelcrafter! Please disable Mass Prospect for this character.|r");
		end
	end

	function MassProspect_Ore()
		OreInBags = 0;
		for i=0,4 do 
			for j=1,GetContainerNumSlots(i) do local t={GetItemInfo(GetContainerItemLink(i,j) or 0)}
				if t[7]=="Metal & Stone" and select(2,GetContainerItemInfo(i,j))>=5 then
					OreInBags = OreInBags + 1;
					return i.." "..j,t[1]
				end 
			end 
		end
		if OreInBags == 0 and SPProfCheck == "true" then
			DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|rr|cffffff00 There is |r|cffff0000NOT ENOUGH|r |cffffff00ore in your bags!|r");
		end
	end

	function MassProspect_OnLoad()
		local fframe = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
			fframe:RegisterEvent("ADDON_LOADED");
			fframe:SetScript("OnEvent", function(self, event, arg1)
			if event == "ADDON_LOADED" and arg1 == "_addon" then
				local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions();
				local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(prof1);
				local aname, aicon, askillLevel, amaxSkillLevel, anumAbilities, aspelloffset, askillLine, askillModifier, aspecializationIndex, aspecializationOffset = GetProfessionInfo(prof2);
				if aname == "Jewelcrafting" then name = aname end
				if name == "Jewelcrafting" then
					SPProfCheck = "true";
					MPMacroString = "/run local f,l,n=MPB or CreateFrame(".."\"".."Button".."\""..",".."\"".."MPB".."\""..",nil,".."\"".."SecureActionButtonTemplate".."\""..") f:SetAttribute(".."\"".."type".."\""..",".."\"".."macro".."\""..") l,n=MassProspect_Ore() if l then f:SetAttribute(".."\"".."macrotext".."\""..",".."\"".."/cast Prospecting\\n/use ".."\"".."..l) SetMacroItem(".."\"".."MassProspect".."\""..",n) end\n/click MPB"
					if BasicDBPerCharacter == false then
						local index = CreateMacro("MassProspect", "Inv_misc_gem_bloodgem_01", MPMacroString, 1);
						BasicDBPerCharacter = true;
					else
					local newIndex = EditMacro("MassProspect", "MassProspect", "Inv_misc_gem_bloodgem_01", MPMacroString);
					end
				else
					SPProfCheck = "false";
					DEFAULT_CHAT_FRAME:AddMessage("|cff00B4FFBasic|r|cff33ff99UI:|rr|cffffff00 You are |r|cffff0000NOT|r |cffffff00a jewelcrafter! Please disable Mass Prospect for this character.|r");
				end
			end
		end)
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

	local Merchant_Frame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
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
	GarrisonLandingPageMinimapButton:SetSize(36, 36)

	-- Hide all Unwanted Things	
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()
		 
	MiniMapTracking:UnregisterAllEvents()
	MiniMapTracking:Hide()

	
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
	Minimap:SetScript('OnMouseUp', function(self, button)
		if (button == 'RightButton') then
			ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * 0.7), -3)
		else
			Minimap_OnClick(self)
		end
	end)
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
-- Rare Alert borrowed from
----------------------------------------------------------------------
function MODULE:RareAlert()
	if db.rarealert ~= true then return end
	local RareFrame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
	RareFrame:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
	RareFrame:SetScript("OnEvent", function(self, event, vignetteInstanceID, onMiniMap)
		if vignetteInstanceID and onMiniMap then
			if SVInstanceID == vignetteInstanceID then
			else
				SVInstanceID = vignetteInstanceID;
				RareObjectName = "";
				local SV_Table = C_VignetteInfo.GetVignetteInfo(vignetteInstanceID)
				local name = SV_Table.name	
				if name then
	--				Excluded Items List follows
					if name == "Invasion Site"    
						or name == "Legion Structure"
						or name == "Kukuru's Treasure Cache"
						or name == "Scouting Map"
						or name == "Map of Zandalar"
						then return
					end
					if not svchests then
						if string.find (name, "Treasure") then
							return
						end
						if string.find (name, "Statue") then
							return
						end
						if string.find (name, "Garrison Cache") then
								return
						end
					end
					RareObjectName = name;
				end
				if not name then
					RareObjectName = "Rare";
				end
				PlaySoundFile(569200)
				RaidNotice_AddMessage(RaidWarningFrame, "|cff00ff00"..RareObjectName.." spotted!|r", ChatTypeInfo["RAID_WARNING"])
			end
		end
	end)
	
	-- Riad Warning Font Size
	local font, size = [[Fonts\FRIZQT__.ttf]], 28 --{r,g,b}
	RaidWarningFrameSlot1:SetFont(font,size)
	RaidWarningFrameSlot2:SetFont(font,size)
	RaidWarningFrame.timings.RAID_NOTICE_MIN_HEIGHT = size
end
	
function MODULE:OnEnable()
	self:AltBuy()
	self:Autogreed()
	self:Coords()
	self:HideDamageText()
	self:MassProspect()
	self:Merchant()
	self:Minimap()
	self:RareAlert()
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
			autogreed = {
				type = "toggle",
				order = 2,						
				name = L["Autogreed"],
				desc = L["Auto Roll Greed when in an Instance group."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			coords = {
				type = "toggle",
				order = 2,						
				name = L["Coords"],
				desc = L["Adds coordinates of player and arrow to main Map."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			ilvlchange = {
				type = "toggle",
				order = 2,						
				name = L["Item LvL Change"],
				desc = L["Notifies you when your Item Level Changes."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			hdt = {
				type = "toggle",
				order = 2,						
				name = L["Hide Damage Text"],
				desc = L["Hide the damage text on player frame."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			massprospect = {
				type = "toggle",
				order = 2,						
				name = L["Mass Prospect"],
				desc = L["If Checked creates a macro to massprospect all ore in your bags."],
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
			orderhall = {
				type = "toggle",
				order = 2,						
				name = L["Orderhall"],
				desc = L["Shows Orehall Resources in icons tooltip."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			rarealert = {
				type = "toggle",
				order = 2,						
				name = L["Rare Alert"],
				desc = L["Alerts you if a Rare is Spotted in your area."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		},
	}
	return options
end