local MODULE_NAME = "Datapanel"
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
		
		font = [[Fonts\ARIALN.ttf]],
		fontSize = 17,
			
		battleground = false,                            	-- enable 3 stats in battleground only that replace stat1,stat2,stat3.
		bag = false,										-- True = Open Backpack; False = Open All bags			
		recountraiddps 	= false,							-- Enables tracking or Recounts Raid DPS
		enableColor = true,									-- Enable class color for text.
		
		-- Color Datatext	
		customcolor = { r = 1, g = 1, b = 1},				-- Color of Text for Datapanel
		
		-- Stat Locations
		bags			= "P9",		-- show space used in bags on panel.	
		system 			= "P1",		-- show total memory and others systems info (FPS/MS) on panel.	
		guild 			= "P4",		-- show number on guildmate connected on panel.
		dur 			= "P8",		-- show your equipment durability on panel.
		friends 		= "P6",		-- show number of friends connected.
		spec 			= "P5",		-- show your current spec on panel.
		coords 			= "P0",		-- show your current coords on panel.
		pro 			= "P7",		-- shows your professions and tradeskills
		stats 			= "P3",		-- Stat Based on your Role (Avoidance-Tank, AP-Melee, SP/HP-Caster)
		recount 		= "P2",		-- Stat Based on Recount"s DPS	
		calltoarms 		= "P0",		-- Show Current Call to Arms.
		dps				= "P0",		-- Show total dps.	
	}
}

------------------------------------------------------------------------
--	 Local Module Functions
------------------------------------------------------------------------
-- Variables that point to frames or other objects:
local DataP1, DataP2, DataP3, DataBGP
local currentFightDPS
local _, class = UnitClass("player")
local ccolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
local _G = _G
local GetBackpackCurrencyInfo = GetBackpackCurrencyInfo or nil

local function RGBToHex(r, g, b)
	if r > 1 then r = 1 elseif r < 0 then r = 0 end
	if g > 1 then g = 1 elseif g < 0 then g = 0 end
	if b > 1 then b = 1 elseif b < 0 then b = 0 end
	return format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

local function HexToRGB(hex)
	local rhex, ghex, bhex = strsub(hex, 1, 2), strsub(hex, 3, 4), strsub(hex, 5, 6)
	return tonumber(rhex, 16), tonumber(ghex, 16), tonumber(bhex, 16)
end

local function ShortValue(v)
	if v >= 1e6 then
		return format("%.1fm", v / 1e6):gsub("%.?0+([km])$", "%1")
	elseif v >= 1e3 or v <= -1e3 then
		return format("%.1fk", v / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return v
	end
end

--Check Player's Role

local isCaster = {
	-- All Classes are needed as to not cause a error when the table is called.
	-- SpecID - Spec - Role
	DEATHKNIGHT = {
		nil, -- 250 - Blood - (TANK) 
		nil, -- 251 - Frost - (MELEE_DPS)
		nil, -- 252 - Unholy - (MELEE_DPS)
	},
	DEMONHUNTER = {
		nil, -- 577 - Havoc - (TANK)
		nil, -- 581 - Vengeance - (MELEE_DPS)
	},
	DRUID = { 
		true, -- 102 - Balance - (CASTER_DPS)
		nil,  -- 103 - Feral - (MELEE_DPS)
		nil,  -- 104 Guardian - (TANK)
		nil,  -- 105 Restoration - (HEALER)
	},
	HUNTER = {
		nil, -- 253 - Beast Mastery - (RANGED_DPS)
		nil, -- 254 - Marksmanship - (RANGED_DPS)
		nil, -- 255 - Survival - (RANGED_DPS)
	},
	MAGE = { 
		true, -- 62 - Arcane - (CASTER_DPS)
		true, -- 63 - Fire - (CASTER_DPS)
		true, -- 64 - Frost - (CASTER_DPS)
	}, 
	MONK = {
		nil, -- 268 - Brewmaster - (TANK)
		nil, -- 269 - Windwalker - (MELEE_DPS)
		nil, -- 270 - Mistweaver - (HEALER)
	}, 
	PALADIN = {
		nil, -- 65 - Holy - (HEALER)
		nil, -- 66 - Protection - (TANK)
		nil, -- 70 - Retribution - (MELEE_DPS)
	},
	PRIEST = { 
		nil,  -- 256 - Discipline - (HEALER}
		nil,  -- 257 - Holy - (HEALER)
		true, -- 258 - Shadow - (CASTER_DPS)
	},
	ROGUE = {
		nil, -- 259 - Assassination - (MELEE_DPS)
		nil, -- 260 - Combat - (MELEE_DPS)
		nil, -- 261 - Subtlety - (MELEE_DPS)
	}, 
	SHAMAN = { 
		true, -- 262 - Elemental - (CASTER_DPS)
		nil,  -- 263 - Enhancement - (MELEE_DPS)
		nil,  -- 264 - Restoration - (HEALER)
	},
	WARLOCK = { 
		true, -- 265 - Affliction - (CASTER_DPS)
		true, -- 266 - Demonology - (CASTER_DPS)
		true, -- 267 - Destruction - (CASTER_DPS)
	}, 
	WARRIOR = {
		nil, -- 71 - Arms - (MELEE_DPS)
		nil, -- 72 - Furry - (MELEE_DPS)
		nil, -- 73 - Protection - (TANK)
	},
}

function MODULE:UpdatePlayerRole()	
	local spec = GetSpecialization()
	if not spec then
		self.playerRole = nil
		return
	end

	local specRole = GetSpecializationRole(spec)
	if specRole == "DAMAGER" then
		if isCaster[class][spec] then
			self.playerRole = "CASTER"
			return
		end
	end

	self.playerRole = specRole
end


------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

function MODULE:CreatePanels()
	if DataP1 then return end -- already done
	
	-- Create All Panels
	------------------------------------------------------------------------
	DataP1 = CreateFrame("Frame", "DataP1", UIParent)
	DataP2 = CreateFrame("Frame", "DataP2", UIParent)
	DataP3 = CreateFrame("Frame", "DataP3", UIParent)
	DataBGP = CreateFrame("Frame", "DataBGP", UIParent)
	
	
	-- Multi Panel Settings
	------------------------------------------------------------------------
	for _, panelz in pairs({
		DataP1,
		DataP2,
		DataP3,
		DataBGP,
	}) do
		panelz:SetHeight(30)
		panelz:SetFrameStrata("LOW")	
		panelz:SetFrameLevel(1)
	end
	
	
	-- Stat Panel 1 Settings
	------------------------------------------------------------------------
	Mixin(DataP1, BackdropTemplateMixin)
	DataP1:SetPoint("BOTTOM", DataP2, "TOP", 0, 0)
	DataP1:SetWidth(1200 / 3)
	DataP1:SetBackdrop({ 
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]], 
	})
	DataP1:SetBackdropColor(0, 0, 0, 0.60)
	DataP1:RegisterEvent("PLAYER_ENTERING_WORLD")
	DataP1:SetScript("OnEvent", function(self, event, ...)
		if event == 'PLAYER_ENTERING_WORLD' then
			local inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == 'pvp') then			
				self:Hide()
			else
				self:Show()
			end
		end
	end)	
	
	-- Stat Panel 2 Settings
	-----------------------------------------------------------------------
	Mixin(DataP2, BackdropTemplateMixin)
	DataP2:SetPoint("BOTTOM", DataP3, "TOP", 0, 0)
	DataP2:SetWidth(1200 / 3)
	DataP2:SetBackdrop({ 
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]], 
	})
	DataP2:SetBackdropColor(0, 0, 0, 0.60)
	
	-- Stat Panel 3 Settings
	-----------------------------------------------------------------------
	Mixin(DataP3, BackdropTemplateMixin)
	DataP3:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 15, 5)
	DataP3:SetWidth(1200 / 3)
	DataP3:SetBackdrop({ 
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]], 
	})
	DataP3:SetBackdropColor(0, 0, 0, 0.60)
	
	-- Battleground Stat Panel Settings
	-----------------------------------------------------------------------
	Mixin(DataBGP, BackdropTemplateMixin)
	DataBGP:SetAllPoints(DataP1)
	DataBGP:SetBackdrop({ 
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]], 
	})
	DataBGP:SetBackdropColor(0, 0, 0, 0.60)


end

function MODULE:SetBattlegroundPanel()

	--WoW API / Variables
	local GetNumBattlefieldScores = GetNumBattlefieldScores
	local GetBattlefieldScore = GetBattlefieldScore
	local GetCurrentMapAreaID = GetCurrentMapAreaID
	local GetBattlefieldStatInfo = GetBattlefieldStatInfo
	local GetBattlefieldStatData = GetBattlefieldStatData
	
	--Map IDs
	local WSG = 443
	local TP = 626
	local AV = 401
	local SOTA = 512
	local IOC = 540
	local EOTS = 482
	local TBFG = 736
	local AB = 461
	local TOK = 856
	local SSM = 860
	local DG = 935

	DataBGP:SetScript('OnEnter', function(self)
		
		local CurrentMapID = GetCurrentMapAreaID()
		for index=1, GetNumBattlefieldScores() do
			name = GetBattlefieldScore(index)
			if name then
				GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 0, 4)
				GameTooltip:ClearLines()
				GameTooltip:SetPoint('BOTTOM', self, 'TOP', 0, 1)
				GameTooltip:ClearLines()
				GameTooltip:AddLine("Stats for : "..hexa..name..hexb)
				GameTooltip:AddLine(" ")

				--Add extra statistics to watch based on what BG you are in.
				if CurrentMapID == WSG or CurrentMapID == TP then
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1), GetBattlefieldStatData(index, 1),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2), GetBattlefieldStatData(index, 2),1,1,1)
				elseif CurrentMapID == EOTS then
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1), GetBattlefieldStatData(index, 1),1,1,1)
				elseif CurrentMapID == AV then
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1), GetBattlefieldStatData(index, 1),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2), GetBattlefieldStatData(index, 2),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(3), GetBattlefieldStatData(index, 3),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(4), GetBattlefieldStatData(index, 4),1,1,1)
				elseif CurrentMapID == SOTA then
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1), GetBattlefieldStatData(index, 1),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2), GetBattlefieldStatData(index, 2),1,1,1)
				elseif CurrentMapID == IOC or CurrentMapID == TBFG or CurrentMapID == AB then
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1), GetBattlefieldStatData(index, 1),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2), GetBattlefieldStatData(index, 2),1,1,1)
				elseif CurrentMapID == TOK then
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1), GetBattlefieldStatData(index, 1),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2), GetBattlefieldStatData(index, 2),1,1,1)
				elseif CurrentMapID == SSM then
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1), GetBattlefieldStatData(index, 1),1,1,1)
				elseif CurrentMapID == DG then
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(1), GetBattlefieldStatData(index, 1),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(2), GetBattlefieldStatData(index, 2),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(3), GetBattlefieldStatData(index, 3),1,1,1)
					GameTooltip:AddDoubleLine(GetBattlefieldStatInfo(4), GetBattlefieldStatData(index, 4),1,1,1)
				end
				break
			end
		end		
	end) 
	DataBGP:SetScript('OnLeave', function(self) GameTooltip:Hide() end)

	local f = CreateFrame('Frame', nil)
	f:EnableMouse(true)

	local Text1  = DataBGP:CreateFontString(nil, 'OVERLAY')
	Text1:SetFont(db.font, db.fontSize)
	Text1:SetPoint('LEFT', DataBGP, 10, 0)
	Text1:SetHeight(DataP1:GetHeight())

	local Text2  = DataBGP:CreateFontString(nil, 'OVERLAY')
	Text2:SetFont(db.font, db.fontSize)
	Text2:SetPoint('CENTER', DataBGP, 0, 0)
	Text2:SetHeight(DataP1:GetHeight())

	local Text3  = DataBGP:CreateFontString(nil, 'OVERLAY')
	Text3:SetFont(db.font, db.fontSize)
	Text3:SetPoint('RIGHT', DataBGP, -10, 0)
	Text3:SetHeight(DataP1:GetHeight())

	local int = 2
	local function Update(self, t)
		int = int - t
		if int < 0 then
			local dmgtxt
			RequestBattlefieldScoreData()
			local numScores = GetNumBattlefieldScores()
			for i=1, numScores do
				local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
				if healingDone > damageDone then
					dmgtxt = (hexa.."Healing : "..hexb..healingDone)
				else
					dmgtxt = (hexa.."Damage : "..hexb..damageDone)
				end
				if ( name ) then
					if ( name == PLAYER_NAME ) then
						Text2:SetText(hexa.."Honor : "..hexb..format('%d', honorGained))
						Text1:SetText(dmgtxt)
						Text3:SetText(hexa.."Killing Blows : "..hexb..killingBlows)
					end   
				end
			end 
			int  = 0
		end
	end

	--hide text when not in an bg
	local function OnEvent(self, event)
		if event == 'PLAYER_ENTERING_WORLD' then
			local inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == 'pvp') then			
				DataBGP:Show()
			else
				Text1:SetText('')
				Text2:SetText('')
				Text3:SetText('')
				DataBGP:Hide()
			end
		end
	end

	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', OnEvent)
	f:SetScript('OnUpdate', Update)
	Update(f, 10)
end

function MODULE:CreateStats()

	local function PlacePlugin(position, plugin)
		local left = DataP1
		local center = DataP2
		local right = DataP3

		-- Left Panel Data
		if position == "P1" then
			plugin:SetParent(left)
			plugin:SetHeight(left:GetHeight())
			plugin:SetPoint('LEFT', left, 10, 0)
			plugin:SetPoint('TOP', left)
			plugin:SetPoint('BOTTOM', left)
		elseif position == "P2" then
			plugin:SetParent(left)
			plugin:SetHeight(left:GetHeight())
			plugin:SetPoint('TOP', left)
			plugin:SetPoint('BOTTOM', left)
		elseif position == "P3" then
			plugin:SetParent(left)
			plugin:SetHeight(left:GetHeight())
			plugin:SetPoint('RIGHT', left, -10, 0)
			plugin:SetPoint('TOP', left)
			plugin:SetPoint('BOTTOM', left)

		-- Center Panel Data
		elseif position == "P4" then
			plugin:SetParent(center)
			plugin:SetHeight(center:GetHeight())
			plugin:SetPoint('LEFT', center, 10, 0)
			plugin:SetPoint('TOP', center)
			plugin:SetPoint('BOTTOM', center)
		elseif position == "P5" then
			plugin:SetParent(center)
			plugin:SetHeight(center:GetHeight())
			plugin:SetPoint('TOP', center)
			plugin:SetPoint('BOTTOM', center)
		elseif position == "P6" then
			plugin:SetParent(center)
			plugin:SetHeight(center:GetHeight())
			plugin:SetPoint('RIGHT', center, -10, 0)
			plugin:SetPoint('TOP', center)
			plugin:SetPoint('BOTTOM', center)

		-- Right Panel Data
		elseif position == "P7" then
			plugin:SetParent(right)
			plugin:SetHeight(right:GetHeight())
			plugin:SetPoint('LEFT', right, 10, 0)
			plugin:SetPoint('TOP', right)
			plugin:SetPoint('BOTTOM', right)
		elseif position == "P8" then
			plugin:SetParent(right)
			plugin:SetHeight(right:GetHeight())
			plugin:SetPoint('TOP', right)
			plugin:SetPoint('BOTTOM', right)
		elseif position == "P9" then
			plugin:SetParent(right)
			plugin:SetHeight(right:GetHeight())
			plugin:SetPoint('RIGHT', right, -10, 0)
			plugin:SetPoint('TOP', right)
			plugin:SetPoint('BOTTOM', right)
		elseif position == "P0" then
			return
		end
	end

	local function DataTextTooltipAnchor(self)
		local panel = self:GetParent()
		local anchor = 'GameTooltip'
		local xoff = 1
		local yoff = 3
		
		
		for _, panel in pairs ({
			DataP1,
			DataP2,
			DataP3,
		})	do
			anchor = 'ANCHOR_TOP'
		end	
		return anchor, panel, xoff, yoff
	end	
	
	if db.enableColor ~= true then
		local r, g, b = db.customcolor.r, db.customcolor.g, db.customcolor.b
		hexa = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
		hexb = "|r"
	else
		hexa = ("|cff%.2x%.2x%.2x"):format(classColor.r * 255, classColor.g * 255, classColor.b * 255)
		hexb = "|r"
	end	

	--------
	-- Bags
	--------

	if db.bags then
		local bagsPlugin = CreateFrame('Frame', nil, Datapanel)
		bagsPlugin:EnableMouse(true)
		bagsPlugin:SetFrameStrata('BACKGROUND')
		bagsPlugin:SetFrameLevel(3)

		local Text = bagsPlugin:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.bags, Text)

		local Profit	= 0
		local Spent		= 0
		local OldMoney	= 0
		local myPlayerName  = UnitName("player");
		local myPlayerRealm = GetRealmName();
		local myPlayerFaction = UnitFactionGroup('player')
		local iconAlliance = CreateTextureMarkup('Interface\\AddOns\\BasicUI\\Media\\Faction_Alliance_64.blp', 32,32, 14,14, 0,1,0,1, -2,-1)
		local iconHorde = CreateTextureMarkup('Interface\\AddOns\\BasicUI\\Media\\Faction_Horde_64.blp', 32,32, 14,14, 0,1,0,1, -2,-1)
		local iconNuetral = CreateTextureMarkup('Interface\\AddOns\\BasicUI\\Media\\Faction_Both_64.blp', 32,32, 14,14, 0,1,0,1, -2,-1)
		
		local function formatMoney(c)
			local str = ""
			if not c or c < 0 then 
				return str 
			end
			
			if c >= 10000 then
				local g = math.floor(c/10000)
				c = c - g*10000
				str = str..BreakUpLargeNumbers(g).."|cFFFFD800g|r "
			end
			if c >= 100 then
				local s = math.floor(c/100)
				c = c - s*100
				str = str..s.."|cFFC7C7C7s|r "
			end
			if c >= 0 then
				str = str..c.."|cFFEEA55Fc|r"
			end
			
			return str
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
						if (subtype == 'Mining Bag') or (subtype == 'Gem Bag') or (subtype == 'Engineering Bag') or (subtype == 'Enchanting Bag') or (subtype == 'Herb Bag') or (subtype == 'Inscription Bag') or (subtype == 'Leatherworking Bag') or (subtype == 'Fishing Bag')then
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
					elseif freeSlots < 10 then
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
		else							-- Gained Money
			Profit = Profit + Change
		end
		
		self:SetAllPoints(Text)

		if not db then db = {} end					
		if not db['Gold'] then db['Gold'] = {} end
		if not db['Gold'][myPlayerRealm] then db['Gold'][myPlayerRealm] = {} end
		if not db['Gold'][myPlayerRealm][myPlayerFaction] then db['Gold'][myPlayerRealm][myPlayerFaction] = {} end
		db['Gold'][myPlayerRealm][myPlayerFaction][myPlayerName] = GetMoney()	
			
		OldMoney = NewMoney	
				
		end

		bagsPlugin:RegisterEvent("PLAYER_MONEY")
		bagsPlugin:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
		bagsPlugin:RegisterEvent("SEND_MAIL_COD_CHANGED")
		bagsPlugin:RegisterEvent("PLAYER_TRADE_MONEY")
		bagsPlugin:RegisterEvent("TRADE_MONEY_CHANGED")
		bagsPlugin:RegisterEvent("PLAYER_ENTERING_WORLD")
		bagsPlugin:RegisterEvent("BAG_UPDATE")
		
		bagsPlugin:SetScript('OnMouseDown', 
			function()
				if db.bag ~= true then
					ToggleAllBags()
				else
					ToggleBag(0)
				end
			end
		)
		bagsPlugin:SetScript('OnEvent', OnEvent)	
		bagsPlugin:SetScript("OnEnter", function(self)
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(hexa..PLAYER_NAME.."'s"..hexb.."|cffffd700 Gold|r", formatMoney(OldMoney), 1, 1, 1, 1, 1, 1)
			GameTooltip:AddLine(" ")			
			GameTooltip:AddLine("This Session: ")				
			GameTooltip:AddDoubleLine("Earned:", formatMoney(Profit), 1, 1, 1, 1, 1, 1)
			GameTooltip:AddDoubleLine("Spent:", formatMoney(Spent), 1, 1, 1, 1, 1, 1)
			if Profit < Spent then
				GameTooltip:AddDoubleLine("Deficit:", formatMoney(Spent - Profit), 1, 0, 0, 1, 1, 1)
			elseif (Profit - Spent) > 0 then
				GameTooltip:AddDoubleLine("Profit:", formatMoney(Profit - Spent), 0, 1, 0, 1, 1, 1)
			end
			GameTooltip:AddLine(" ")
			
			local totalGold = 0
			local totalAllianceGold = 0
			local totalHordeGold = 0
			local totalNeutralGold = 0
			 
			if db['Gold'][myPlayerRealm]['Alliance'] then     --so long as this will never have a value of false, you really only care if a value exists
				GameTooltip:AddLine("Alliance Characters:")     --faction heading
				for k,v in pairs(db['Gold'][myPlayerRealm]['Alliance']) do     --display all characters
					GameTooltip:AddDoubleLine(iconAlliance..k, formatMoney(v), 1, 1, 1, 1, 1, 1)
					totalAllianceGold = totalAllianceGold + v
				end
				GameTooltip:AddDoubleLine("Total Alliance Gold", formatMoney(totalAllianceGold))     --faction total
				GameTooltip:AddLine(" ")     --add a spacer after this faction
			end
			 
			if db['Gold'][myPlayerRealm]['Horde'] then
				GameTooltip:AddLine("Horde Characters:")     --faction heading
				for k,v in pairs(db['Gold'][myPlayerRealm]['Horde']) do     --display all characters
					GameTooltip:AddDoubleLine(iconHorde..k, formatMoney(v), 1, 1, 1, 1, 1, 1)
					totalHordeGold = totalHordeGold + v
				end
				GameTooltip:AddDoubleLine("Total Horde Gold", formatMoney(totalHordeGold))     --faction total
				GameTooltip:AddLine(" ")     --add a spacer after this faction
			end
				
			if db['Gold'][myPlayerRealm]['Neutral'] then
				GameTooltip:AddLine("Neutral Characters:")     --faction heading
				for k,v in pairs(db['Gold'][myPlayerRealm]['Neutral']) do     --display all characters
					GameTooltip:AddDoubleLine(iconNuetral..k, formatMoney(v), 1, 1, 1, 1, 1, 1)
					totalNeutralGold = totalNeutralGold + v
				end
				GameTooltip:AddDoubleLine("Total Neutral Gold", formatMoney(totalNeutralGold))     --faction total
				GameTooltip:AddLine(" ")     --add a spacer after this faction
			end
						
			local totalServerGold = totalAllianceGold + totalHordeGold + totalNeutralGold
			GameTooltip:AddDoubleLine("Total Gold for "..myPlayerRealm, formatMoney(totalServerGold))     --server total			

			--for i = 1, GetNumWatchedTokens() do
				--local GetBackpackCurrencyInfo = C_CurrencyInfo.GetBackpackCurrencyInfo
				--local name, count, extraCurrencyType, icon, itemID = GetBackpackCurrencyInfo(i)
				--if name and i == 1 then
					--GameTooltip:AddLine(" ")
					--GameTooltip:AddLine(CURRENCY..":")
				--end
				--local r, g, b = 1,1,1
				--if itemID then r, g, b = GetItemQualityColor(select(3, GetItemInfo(itemID))) end
				--if name and count then GameTooltip:AddDoubleLine(name, count, r, g, b, 1, 1, 1) end
			--end
			GameTooltip:AddLine' '
			GameTooltip:AddLine("|cffeda55fClick|r to Open Bags")			
			GameTooltip:Show()
		end)
		
		bagsPlugin:SetScript("OnLeave", function() GameTooltip:Hide() end)				

	end

	----------------
	-- Call To Arms
	----------------
	if db.calltoarms then
		local ctaPlugin = CreateFrame('Frame', nil, Datapanel)
		ctaPlugin:EnableMouse(true)
		ctaPlugin:SetFrameStrata("MEDIUM")
		ctaPlugin:SetFrameLevel(3)

		local Text = ctaPlugin:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.calltoarms, Text)
		
		local function MakeIconString(tank, healer, damage)
			local str = ""
			if tank then 
				str = str..'T'
			end
			if healer then
				str = str..', H'
			end
			if damage then
				str = str..', D'
			end	
			
			return str
		end
		
		local function MakeString(tank, healer, damage)
			local str = ""
			if tank then 
				str = str..'Tank'
			end
			if healer then
				str = str..', Healer'
			end
			if damage then
				str = str..', DPS'
			end	
			
			return str
		end

		local function OnEvent(self, event, ...)
			local tankReward = false
			local healerReward = false
			local dpsReward = false
			local unavailable = true		
			for i=1, GetNumRandomDungeons() do
				local id, name = GetLFGRandomDungeonInfo(i)
				for x = 1,LFG_ROLE_NUM_SHORTAGE_TYPES do
					local eligible, forTank, forHealer, forDamage, itemCount = GetLFGRoleShortageRewards(id, x)
					if eligible then unavailable = false end
					if eligible and forTank and itemCount > 0 then tankReward = true end
					if eligible and forHealer and itemCount > 0 then healerReward = true end
					if eligible and forDamage and itemCount > 0 then dpsReward = true end				
				end
			end	
			
			if unavailable then
				Text:SetText(QUEUE_TIME_UNAVAILABLE)
			else
				Text:SetText(hexa..'C to A'..hexb.." : "..MakeIconString(tankReward, healerReward, dpsReward).." ")
			end
			
			self:SetAllPoints(Text)
		end

		local function OnEnter(self)	
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Call to Arms")
			GameTooltip:AddLine(' ')
			
			local allUnavailable = true
			local numCTA = 0
			for i=1, GetNumRandomDungeons() do
				local id, name = GetLFGRandomDungeonInfo(i)
				local tankReward = false
				local healerReward = false
				local dpsReward = false
				local unavailable = true
				for x=1, LFG_ROLE_NUM_SHORTAGE_TYPES do
					local eligible, forTank, forHealer, forDamage, itemCount = GetLFGRoleShortageRewards(id, x)
					if eligible then unavailable = false end
					if eligible and forTank and itemCount > 0 then tankReward = true end
					if eligible and forHealer and itemCount > 0 then healerReward = true end
					if eligible and forDamage and itemCount > 0 then dpsReward = true end
				end
				if not unavailable then
					allUnavailable = false
					local rolesString = MakeString(tankReward, healerReward, dpsReward)
					if rolesString ~= ""  then 
						GameTooltip:AddDoubleLine(name.." : ", rolesString..' ', 1, 1, 1)
					end
					if tankReward or healerReward or dpsReward then numCTA = numCTA + 1 end
				end
			end
			
			if allUnavailable then 
				GameTooltip:AddLine("Could not get Call To Arms information.")
			elseif numCTA == 0 then 
				GameTooltip:AddLine("Could not get Call To Arms information.") 
			end
			GameTooltip:AddLine' '
			GameTooltip:AddLine("|cffeda55fLeft Click|r to Open Dungeon Finder")	
			GameTooltip:AddLine("|cffeda55fRight Click|r to Open PvP Finder")			
			GameTooltip:Show()	
		end
		
		ctaPlugin:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
		ctaPlugin:RegisterEvent("PLAYER_LOGIN")
		ctaPlugin:SetScript("OnEvent", OnEvent)
		ctaPlugin:SetScript("OnMouseDown", function(self, btn)
			if btn == "LeftButton" then
				ToggleLFDParentFrame(1)
			elseif btn == "RightButton" then
				TogglePVPUI(1)
			end
		end)		
		ctaPlugin:SetScript("OnEnter", OnEnter)
		ctaPlugin:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	---------------------
	-- Damage Per Second
	---------------------
	if db.dps then
		local dpsPlugin = CreateFrame('Frame', nil, Datapanel)
		dpsPlugin:EnableMouse(true)
		dpsPlugin:SetFrameStrata('BACKGROUND')
		dpsPlugin:SetFrameLevel(3)

		local Text = dpsPlugin:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.dps, Text)

		local events = {SWING_DAMAGE = true, RANGE_DAMAGE = true, SPELL_DAMAGE = true, SPELL_PERIODIC_DAMAGE = true, DAMAGE_SHIELD = true, DAMAGE_SPLIT = true, SPELL_EXTRA_ATTACKS = true}
		local player_id = UnitGUID('player')
		local dmg_total, last_dmg_amount = 0, 0
		local cmbt_time = 0

		local pet_id = UnitGUID('pet')
		

		dpsPlugin:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
		dpsPlugin:RegisterEvent('PLAYER_LOGIN')

		dpsPlugin:SetScript('OnUpdate', function(self, elap)
			if UnitAffectingCombat('player') then
				cmbt_time = cmbt_time + elap
			end
		   
			Text:SetText(getDPS())
		end)
		 
		function dpsPlugin:PLAYER_LOGIN()
			dpsPlugin:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
			dpsPlugin:RegisterEvent('PLAYER_REGEN_ENABLED')
			dpsPlugin:RegisterEvent('PLAYER_REGEN_DISABLED')
			dpsPlugin:RegisterEvent('UNIT_PET')
			player_id = UnitGUID('player')
			dpsPlugin:UnregisterEvent('PLAYER_LOGIN')
		end
		 
		function dpsPlugin:UNIT_PET(unit)
			if unit == 'player' then
				pet_id = UnitGUID('pet')
			end
		end
		
		-- handler for the combat log. used http://www.wowwiki.com/API_COMBAT_LOG_EVENT for api
		function dpsPlugin:COMBAT_LOG_EVENT_UNFILTERED(...)		   
			-- filter for events we only care about. i.e heals
			if not events[select(2, ...)] then return end

			-- only use events from the player
			local id = select(4, ...)
			   
			if id == player_id or id == pet_id then
				if select(2, ...) == "SWING_DAMAGE" then
					last_dmg_amount = select(12, ...)
				else
					last_dmg_amount = select(15, ...)
				end
				dmg_total = dmg_total + last_dmg_amount
			end       
		end
		 
		function getDPS()
			if (dmg_total == 0) then
				return (hexa.."DPS"..hexb..' 0')
			else
				return string.format(hexa.."DPS: "..hexb..'%.1f ', (dmg_total or 0) / (cmbt_time or 1))
			end
		end

		function dpsPlugin:PLAYER_REGEN_ENABLED()
			Text:SetText(getDPS())
		end
		
		function dpsPlugin:PLAYER_REGEN_DISABLED()
			cmbt_time = 0
			dmg_total = 0
			last_dmg_amount = 0
		end
		 
		dpsPlugin:SetScript("OnEnter", function(self)
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(hexa..PLAYER_NAME.."'s"..hexb.."|cffffd700 DPS|r")
			GameTooltip:AddLine' '
			GameTooltip:AddDoubleLine("Combat Time:", cmbt_time, 1, 0, 0, 1, 1, 1)
			GameTooltip:AddDoubleLine("Total Damage:", dmg_total, 1, 0, 0, 1, 1, 1)
			GameTooltip:AddDoubleLine("Last Damage:", last_dmg_amount, 1, 0, 0, 1, 1, 1)
			GameTooltip:Show()
		end)
	end

	--------------
	-- Durability
	--------------
	if db.dur then

		Slots = {
			[1] = {1, "Head", 1000},
			[2] = {3, "Shoulder", 1000},
			[3] = {5, "Chest", 1000},
			[4] = {6, "Waist", 1000},
			[5] = {9, "Wrist", 1000},
			[6] = {10, "Hands", 1000},
			[7] = {7, "Legs", 1000},
			[8] = {8, "Feet", 1000},
			[9] = {16, "Main Hand", 1000},
			[10] = {17, "Off Hand", 1000},
			[11] = {18, "Ranged", 1000}
		}


		local durPlugin = CreateFrame('Frame', nil, Datapanel)
		durPlugin:EnableMouse(true)
		durPlugin:SetFrameStrata("MEDIUM")
		durPlugin:SetFrameLevel(3)

		local Text  = durPlugin:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.dur, Text)

		local function OnEvent(self)
			local Total = 0
			local current, max
			
			for i = 1, 11 do
				if GetInventoryItemLink("player", Slots[i][1]) ~= nil then
					current, max = GetInventoryItemDurability(Slots[i][1])
					if current then 
						Slots[i][3] = current/max
						Total = Total + 1
					end
				end
			end
			table.sort(Slots, function(a, b) return a[3] < b[3] end)
			
			if Total > 0 then
				Text:SetText(hexa.."Armor: "..hexb..floor(Slots[1][3]*100).."% |r")
			else
				Text:SetText(hexa.."Armor: "..hexb.."100% |r")
			end
			-- Setup Durability Tooltip
			self:SetAllPoints(Text)
			Total = 0
		end

		durPlugin:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
		durPlugin:RegisterEvent("MERCHANT_SHOW")
		durPlugin:RegisterEvent("PLAYER_ENTERING_WORLD")
		durPlugin:SetScript("OnMouseDown",function(self,btn)
			if btn == "LeftButton" then
				ToggleCharacter("PaperDollFrame")
			elseif btn == "RightButton" then
				if not IsShiftKeyDown() then
					CastSpellByName("Traveler's Tundra Mammoth")
				else
					CastSpellByName("Grand Expedition Yak")
				end
			end
		end)
		durPlugin:SetScript("OnEvent", OnEvent)
		durPlugin:SetScript("OnEnter", function(self)
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Durability")
			GameTooltip:AddLine' '
			GameTooltip:AddDoubleLine("Current "..STAT_AVERAGE_ITEM_LEVEL, format("%.1f", GetAverageItemLevel("player")))
			GameTooltip:AddLine' '
			for i = 1, 11 do
				if Slots[i][3] ~= 1000 then
					local green, red
					green = Slots[i][3]*2
					red = 1 - green
					GameTooltip:AddDoubleLine(Slots[i][2], floor(Slots[i][3]*100).."%",1 ,1 , 1, red + 1, green, 0)
				end
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine("|cffeda55fLeft Click|r opens Character Panel.")
			GameTooltip:AddLine("|cffeda55fRight Click|r summon's Traveler's Tundra Mammoth.")
			GameTooltip:AddLine("|cffeda55fHold Shift + Right Click|r summon's Grand Expedition Yak.")
			GameTooltip:Show()
		end)
		durPlugin:SetScript("OnLeave", function() GameTooltip:Hide() end)

	end

	-----------
	-- FRIEND
	-----------

	if db.friends then

	local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r"
	local clientLevelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s (|cffffffff%s|r) |cff%02x%02x%02x%s|r"
	local levelNameClassString = "|cff%02x%02x%02x%d|r %s%s%s"
	local worldOfWarcraftString = "World of Warcraft"
	local battleNetString = "Battle.NET"
	local wowString = "WoW"
	local totalOnlineString = "Online: " .. "%s/%s"
	local tthead, ttsubh, ttoff = {r = 0.4, g = 0.78, b = 1}, {r = 0.75, g = 0.9, b = 1}, {r = .3, g = 1, b = .3}
	local activezone, inactivezone = {r = 0.3, g = 1.0, b = 0.3}, {r = 0.65, g = 0.65, b = 0.65}
	local statusTable = { "|cffff0000[AFK]|r", "|cffff0000[DND]|r", "" }
	local groupedTable = { "|cffaaaaaa*|r", "" }
	local BNTable = {}
	local BNTotalOnline = 0
	local BNGetGameAccountInfo = BNGetGameAccountInfo
	local GetFriendInfo = GetFriendInfo
	local BNGetFriendInfo = BNGetFriendInfo
	local displayString = string.join("", hexa.."%s:|r %d|r"..hexb)
	
	StaticPopupDialogs["SET_BN_BROADCAST"] = {
		preferredIndex = STATICPOPUP_NUMDIALOGS,
		text = BN_BROADCAST_TOOLTIP,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		editBoxWidth = 350,
		maxLetters = 127,
		OnAccept = function(self)
			BNSetCustomMessage(self.editBox:GetText())
		end,
		OnShow = function(self)
			self.editBox:SetText(select(4, BNGetInfo()) )
			self.editBox:SetFocus()
		end,
		OnHide = ChatEdit_FocusActiveWindow,
		EditBoxOnEnterPressed = function(self)
			BNSetCustomMessage(self:GetText())
			self:GetParent():Hide()
		end,
		EditBoxOnEscapePressed = function(self)
			self:GetParent():Hide()
		end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}

	local function GetTableIndex(table, fieldIndex, value)
		for k, v in ipairs(table) do
			if v[fieldIndex] == value then
				return k
			end
		end

		return -1
	end

	local function UpdateBNTable(total)
		BNTotalOnline = 0

		for i = 1, #BNTable do
			local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
			if accountInfo then
				-- get the correct index in our table
				local index = GetTableIndex(BNTable, 1, accountInfo.bnetAccountID)
				local class = accountInfo.gameAccountInfo.className

				-- we cannot find a BN member in our table, so rebuild it
				if index == -1 then
					BuildBNTable(total)
					return
				end

				for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
					if class == v then
						class = k
					end
				end

				-- update on-line status for all members
				BNTable[index][7] = accountInfo.gameAccountInfo.isOnline

				-- update information only for on-line members
				if accountInfo.gameAccountInfo.isOnline then
					BNTable[index][2] = accountInfo.accountName
					BNTable[index][3] = accountInfo.battleTag
					BNTable[index][4] = accountInfo.gameAccountInfo.characterName
					BNTable[index][5] = accountInfo.gameAccountInfo.gameAccountID
					BNTable[index][6] = accountInfo.gameAccountInfo.clientProgram
					BNTable[index][8] = accountInfo.isAFK
					BNTable[index][9] = accountInfo.isDND
					BNTable[index][10] = accountInfo.note
					BNTable[index][11] = accountInfo.gameAccountInfo.realmName
					BNTable[index][12] = accountInfo.gameAccountInfo.factionName
					BNTable[index][13] = accountInfo.gameAccountInfo.raceName
					BNTable[index][14] = class
					BNTable[index][15] = accountInfo.gameAccountInfo.areaName
					BNTable[index][16] = accountInfo.gameAccountInfo.characterLevel
					BNTable[index][17] = accountInfo.isBattleTagFriend

					BNTotalOnline = BNTotalOnline + 1
				end
			end
		end
	end

	local friendsPlugin = CreateFrame('Frame', nil, Datapanel)
	friendsPlugin:EnableMouse(true)
	friendsPlugin:SetFrameStrata("MEDIUM")
	friendsPlugin:SetFrameLevel(3)

	local Text  = friendsPlugin:CreateFontString(nil, "OVERLAY")
	Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
	PlacePlugin(db.friends, Text)

		local menuFrame = CreateFrame("Frame", "FriendDatatextRightClickMenu", UIParent, "UIDropDownMenuTemplate")
		local menuList = {
			{ text = OPTIONS_MENU, isTitle = true, notCheckable = true},
			{ text = INVITE, hasArrow = true, notCheckable = true, },
			{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable = true, },
			{ text = PLAYER_STATUS, hasArrow = true, notCheckable = true,
				menuList = {
					{ text = "|cff2BC226"..AVAILABLE.."|r", notCheckable = true, func = function()
						if IsChatAFK() then
							SendChatMessage("", "AFK")
						elseif IsChatDND() then
							SendChatMessage("", "DND")
						end
					end },

					{ text = "|cffE7E716"..DND.."|r", notCheckable = true, func = function()
						if not IsChatDND() then
							SendChatMessage("", "DND")
						end
					end },

					{ text = "|cffFF0000"..AFK.."|r", notCheckable = true, func = function()
						if not IsChatAFK() then
							SendChatMessage("", "AFK")
						end
					end },
				},
			},
			{ text = BN_BROADCAST_TOOLTIP, notCheckable=true, func = function() StaticPopup_Show("SET_BN_BROADCAST") end },
		}

		local function GetTableIndex(table, fieldIndex, value)
			for k, v in ipairs(table) do
				if v[fieldIndex] == value then
					return k
				end
			end

			return -1
		end

		local function RemoveTagNumber(tag)
			local symbol = string.find(tag, "#")

			if (symbol) then
				return string.sub(tag, 1, symbol - 1)
			else
				return tag
			end
		end

		local function inviteClick(self, arg1, arg2, checked)
			menuFrame:Hide()

			if type(arg1) ~= ("number") then
				InviteUnit(arg1)
			else
				BNInviteFriend(arg1);
			end
		end

		local function whisperClick(self, name, bnet)
			menuFrame:Hide()

			if bnet then
				ChatFrame_SendBNetTell(name)
			else
				SetItemRef("player:"..name, format("|Hplayer:%1$s|h[%1$s]|h",name), "LeftButton")
			end
		end

		local function BuildBNTable(total)
			BNTotalOnline = 0
			wipe(BNTable)

			for i = 1, total do
				local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
				if accountInfo then
					local class = accountInfo.gameAccountInfo.className

					for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
						if class == v then
							class = k
						end
					end

					BNTable[i] = { accountInfo.bnetAccountID, accountInfo.accountName, accountInfo.battleTag, accountInfo.gameAccountInfo.characterName, accountInfo.gameAccountInfo.gameAccountID, accountInfo.gameAccountInfo.clientProgram, accountInfo.gameAccountInfo.isOnline, accountInfo.isAFK, accountInfo.isDND, accountInfo.note, accountInfo.gameAccountInfo.realmName, accountInfo.gameAccountInfo.factionName, accountInfo.gameAccountInfo.raceName, class, accountInfo.gameAccountInfo.areaName, accountInfo.gameAccountInfo.characterLevel }

					if accountInfo.gameAccountInfo.isOnline then
						BNTotalOnline = BNTotalOnline + 1
					end
				end
			end
		end
			

		friendsPlugin:SetScript("OnEvent", function(self, event, ...)

			local BNTotal = BNGetNumFriends()
			local Total = C_FriendList.GetNumFriends()

			if BNTotal == #BNTable then
				UpdateBNTable(BNTotal)
			else
				BuildBNTable(BNTotal)
			end

			Text:SetFormattedText(displayString, "Friends", BNTotalOnline)
			self:SetAllPoints(Text)
		end)

		friendsPlugin:SetScript("OnMouseDown", function(self, btn)
		
			GameTooltip:Hide()
			
			if btn == "RightButton" then

			if not BNConnected() then
				return
			end

			GameTooltip_Hide()

			local menuCountWhispers = 0
			local menuCountInvites = 0
			local classc, levelc

			menuList[2].menuList = {}
			menuList[3].menuList = {}

			if BNTotalOnline > 0 then
				local realID, grouped

				for i = 1, #BNTable do
					if (BNTable[i][7]) then
						realID = BNTable[i][2]
						menuCountWhispers = menuCountWhispers + 1
						menuList[3].menuList[menuCountWhispers] = {text = RemoveTagNumber(BNTable[i][3]), arg1 = realID, arg2 = true, notCheckable=true, func = whisperClick}

						if BNTable[i][6] == wowString and UnitFactionGroup("player") == BNTable[i][12] then
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(BNTable[i][16])

							if classc == nil then
								classc = GetQuestDifficultyColor(BNTable[i][16])
							end

							if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then
								grouped = 1
							else
								grouped = 2
							end

							menuCountInvites = menuCountInvites + 1
							menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,BNTable[i][16],classc.r*255,classc.g*255,classc.b*255,BNTable[i][4]), arg1 = BNTable[i][5],notCheckable=true, func = inviteClick}
						end
					end
				end
			end

				EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
			else
				ToggleFriendsFrame()
			end
		end)


		friendsPlugin:SetScript("OnEnter", function(self)

			if not BNConnected() then
				local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
				GameTooltip:SetOwner(panel, anchor, xoff, yoff)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(BN_CHAT_DISCONNECTED)
				GameTooltip:Show()

				return
			end

			local totalonline = BNTotalOnline
			local zonec, classc, levelc, realmc, grouped

			if (totalonline > 0) then
				local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
				GameTooltip:SetOwner(panel, anchor, xoff, yoff)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(hexa..PLAYER_NAME.."'s"..hexb.."|cffffd700 Friend's|r", format(totalOnlineString, totalonline, #BNTable))
				GameTooltip:AddLine(" ")

				if BNTotalOnline > 0 then
					local status = 0

					for i = 1, #BNTable do
						local BNName = RemoveTagNumber(BNTable[i][3])

						if BNTable[i][7] then
							if BNTable[i][6] == wowString then
								local isBattleTag = BNTable[i][17]

								if (BNTable[i][8] == true) then
									status = 1
								elseif (BNTable[i][9] == true) then
									status = 2
								else
									status = 3
								end

								classc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]]
								levelc = GetQuestDifficultyColor(BNTable[i][16])

								if not classc then
									classc = {r=1, g=1, b=1}
								end

								if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then
									grouped = 1
								else
									grouped = 2
								end

								GameTooltip:AddDoubleLine(format(clientLevelNameString,levelc.r*255,levelc.g*255,levelc.b*255,BNTable[i][16],classc.r*255,classc.g*255,classc.b*255,BNTable[i][4],groupedTable[grouped], BNTable[i][2], 255, 0, 0, statusTable[status]), "World of Warcraft")

								if IsShiftKeyDown() then
									if GetRealZoneText() == BNTable[i][15] then
										zonec = activezone
									else
										zonec = inactivezone
									end

									if GetRealmName() == BNTable[i][11] then
										realmc = activezone
									else
										realmc = inactivezone
									end

									GameTooltip:AddDoubleLine("  ".."Zone - "..BNTable[i][15], "Server - "..BNTable[i][11], zonec.r, zonec.g, zonec.b, realmc.r, realmc.g, realmc.b)
								end
							end

							if BNTable[i][6] == "BSAp"  then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Mobile App")
							end
							
							if BNTable[i][6] == "App" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Desktop App")
							end
							
							if BNTable[i][6] == "S2" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "StarCraft 2")
							end	
							
							if BNTable[i][6] == "D3" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Diablo 3")
							end
							
							if BNTable[i][6] == "WTCG" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Herathstone")
							end
							
							if BNTable[i][6] == "Hero" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Heroes of the Storm")
							end

							if BNTable[i][6] == "Pro" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Overwatch")
							end
							
							if BNTable[i][6] == "CLNT" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Client")
							end	
							
							if BNTable[i][6] == "S1" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "StarCraft: Remastered")
							end
							
							if BNTable[i][6] == "DST2" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Destiny 2")
							end
							
							if BNTable[i][6] == "VIPR" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Call of Duty: Black Ops 4")
							end

							if BNTable[i][6] == "ODIN" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Call of Duty: Modern Warfare")
							end
							
							if BNTable[i][6] == "LAZR" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Call of Duty: Modern Warfare 2")
							end

							if BNTable[i][6] == "W3" then
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][2].."|r", "Warcraft III: Reforged")
							end
						end
					end
				end
				GameTooltip:AddLine' '
				GameTooltip:AddLine("|cffeda55fLeft Click|r to Open Friends List")
				GameTooltip:AddLine("|cffeda55fShift + Mouseover|r to Show Zone and Realm of Friend")
				GameTooltip:AddLine("|cffeda55fRight Click|r to Access Option Menu")
				GameTooltip:Show()
			else
				GameTooltip_Hide()
			end
		end)
		friendsPlugin:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		friendsPlugin:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
		friendsPlugin:RegisterEvent("FRIENDLIST_UPDATE")
		friendsPlugin:RegisterEvent("PLAYER_ENTERING_WORLD")
		friendsPlugin:RegisterEvent("IGNORELIST_UPDATE")
		friendsPlugin:RegisterEvent("MUTELIST_UPDATE")
		friendsPlugin:RegisterEvent("PLAYER_FLAGS_CHANGED")
		friendsPlugin:RegisterEvent("BN_FRIEND_LIST_SIZE_CHANGED")
		friendsPlugin:RegisterEvent("BN_FRIEND_INFO_CHANGED")
		friendsPlugin:RegisterEvent("BN_FRIEND_INVITE_LIST_INITIALIZED")
		friendsPlugin:RegisterEvent("BN_FRIEND_INVITE_ADDED")
		friendsPlugin:RegisterEvent("BN_FRIEND_INVITE_REMOVED")
		friendsPlugin:RegisterEvent("BN_BLOCK_LIST_UPDATED")
		friendsPlugin:RegisterEvent("BN_CONNECTED")
		friendsPlugin:RegisterEvent("BN_DISCONNECTED")
		friendsPlugin:RegisterEvent("BN_INFO_CHANGED")
		friendsPlugin:RegisterEvent("BATTLETAG_INVITE_SHOW")		
		friendsPlugin:SetScript("OnLeave", function() GameTooltip:Hide() end)

	end
	

	---------
	-- Guild
	---------
	if db.guild then

		local guildPlugin = CreateFrame('Frame', nil, Datapanel)
		guildPlugin:EnableMouse(true)
		guildPlugin:SetFrameStrata("MEDIUM")
		guildPlugin:SetFrameLevel(3)

		local Text  = guildPlugin:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.guild, Text)
		
		local join 		= string.join
		local format 	= string.format
		local split 	= string.split	

		local tthead, ttsubh, ttoff = {r=0.4, g=0.78, b=1}, {r=0.75, g=0.9, b=1}, {r=.3,g=1,b=.3}
		local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
		local displayString = join("", hexa, GUILD, ":|r ", "%d")
		local noGuildString = join("", hexa, 'No Guild')
		local guildInfoString = "%s [%d]"
		local guildInfoString2 = join("", "Online", ": %d/%d")
		local guildMotDString = "%s |cffaaaaaa- |cffffffff%s"
		local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s"
		local levelNameStatusString = "|cff%02x%02x%02x%d|r %s %s"
		local nameRankString = "%s |cff999999-|cffffffff %s"
		local guildXpCurrentString = gsub(join("", RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b), GUILD_EXPERIENCE_CURRENT), ": ", ":|r |cffffffff", 1)
		local guildXpDailyString = gsub(join("", RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b), GUILD_EXPERIENCE_DAILY), ": ", ":|r |cffffffff", 1)
		local standingString = join("", RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b), "%s:|r |cFFFFFFFF%s/%s (%s%%)")
		local moreMembersOnlineString = join("", "+ %d ", FRIENDS_LIST_ONLINE, "...")
		local noteString = join("", "|cff999999   ", LABEL_NOTE, ":|r %s")
		local officerNoteString = join("", "|cff999999   ", GUILD_RANK1_DESC, ":|r %s")
		local groupedTable = { "|cffaaaaaa*|r", "" } 
		local MOBILE_BUSY_ICON = "|TInterface\\ChatFrame\\UI-ChatIcon-ArmoryChat-BusyMobile:14:14:0:0:16:16:0:16:0:16|t";
		local MOBILE_AWAY_ICON = "|TInterface\\ChatFrame\\UI-ChatIcon-ArmoryChat-AwayMobile:14:14:0:0:16:16:0:16:0:16|t";
		
		local guildTable, guildXP, guildMotD = {}, {}, ""
		local totalOnline = 0
		
		local function SortGuildTable(shift)
			sort(guildTable, function(a, b)
				if a and b then
					if shift then
						return a[10] < b[10]
					else
						return a[1] < b[1]
					end
				end
			end)
		end	

		local chatframetexture = ChatFrame_GetMobileEmbeddedTexture(73/255, 177/255, 73/255)
		local onlinestatusstring = "|cffFFFFFF[|r|cffFF0000%s|r|cffFFFFFF]|r"
		local onlinestatus = {
			[0] = function () return '' end,
			[1] = function () return format(onlinestatusstring, 'AFK') end,
			[2] = function () return format(onlinestatusstring, 'DND') end,
		}
		local mobilestatus = {
			[0] = function () return chatframetexture end,
			[1] = function () return MOBILE_AWAY_ICON end,
			[2] = function () return MOBILE_BUSY_ICON end,
		}

		local function BuildGuildTable()
			wipe(guildTable)
			local statusInfo
			local _, name, rank, level, zone, note, officernote, connected, memberstatus, class, isMobile
			
			local totalMembers = GetNumGuildMembers()
			for i = 1, totalMembers do
				name, rank, rankIndex, level, _, zone, note, officernote, connected, memberstatus, class, _, _, isMobile = GetGuildRosterInfo(i)

				statusInfo = isMobile and mobilestatus[memberstatus]() or onlinestatus[memberstatus]()
				zone = (isMobile and not connected) and REMOTE_CHAT or zone

				if connected or isMobile then 
					guildTable[#guildTable + 1] = { name, rank, level, zone, note, officernote, connected, statusInfo, class, rankIndex, isMobile }
				end
			end
		end

		local function UpdateGuildMessage()
			guildMotD = GetGuildRosterMOTD()
		end
		
		local FRIEND_ONLINE = select(2, split(" ", ERR_FRIEND_ONLINE_SS, 2))
		local resendRequest = false
		local eventHandlers = {
			['CHAT_MSG_SYSTEM'] = function(self, arg1)
				if(FRIEND_ONLINE ~= nil and arg1 and arg1:find(FRIEND_ONLINE)) then
					resendRequest = true
				end
			end,
			-- when we enter the world and guildframe is not available then
			-- load guild frame, update guild message and guild xp	
			["PLAYER_ENTERING_WORLD"] = function (self, arg1)
			
				if not GuildFrame and IsInGuild() then 
					LoadAddOn("Blizzard_GuildUI")
					GuildRoster() 
				end
			end,
			-- Guild Roster updated, so rebuild the guild table
			["GUILD_ROSTER_UPDATE"] = function (self)
				if(resendRequest) then
					resendRequest = false;
					return GuildRoster()
				else
					BuildGuildTable()
					UpdateGuildMessage()
					if GetMouseFocus() == self then
						self:GetScript("OnEnter")(self, nil, true)
					end
				end
			end,
			-- our guild xp changed, recalculate it	
			["PLAYER_GUILD_UPDATE"] = function (self, arg1)
				GuildRoster()
			end,
			-- our guild message of the day changed
			["GUILD_MOTD"] = function (self, arg1)
				guildMotD = arg1
			end,
			--["ELVUI_FORCE_RUN"] = function() end,
			--["ELVUI_COLOR_UPDATE"] = function() end,
		}	

		local function Update(self, event, ...)
			if IsInGuild() then
				eventHandlers[event](self, select(1, ...))

				Text:SetFormattedText(displayString, #guildTable)
			else
				Text:SetText(noGuildString)
			end
			
			self:SetAllPoints(Text)
		end
			
		local menuFrame = CreateFrame("Frame", "GuildRightClickMenu", UIParent, "UIDropDownMenuTemplate")
		local menuList = {
			{ text = OPTIONS_MENU, isTitle = true,notCheckable=true},
			{ text = INVITE, hasArrow = true,notCheckable=true,},
			{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true,notCheckable=true,}
		}

		local function inviteClick(self, arg1, arg2, checked)
			menuFrame:Hide()
			InviteUnit(arg1)
		end

		local function whisperClick(self,arg1,arg2,checked)
			menuFrame:Hide()
			SetItemRef( "player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton" )
		end

		local function ToggleGuildFrame()
			if IsInGuild() then 
				if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end 
				GuildFrame_Toggle()
				GuildFrame_TabClicked(GuildFrameTab2)
			else 
				if not LookingForGuildFrame then LoadAddOn("Blizzard_LookingForGuildUI") end 
				LookingForGuildFrame_Toggle() 
			end
		end

		guildPlugin:SetScript("OnMouseUp", function(self, btn)
			if btn ~= "RightButton" or not IsInGuild() then return end
			
			GameTooltip:Hide()

			local classc, levelc, grouped
			local menuCountWhispers = 0
			local menuCountInvites = 0

			menuList[2].menuList = {}
			menuList[3].menuList = {}

			for i = 1, #guildTable do
				if (guildTable[i][7] and guildTable[i][1] ~= BasicUImyname) then
					local classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[guildTable[i][9]], GetQuestDifficultyColor(guildTable[i][3])

					if UnitInParty(guildTable[i][1]) or UnitInRaid(guildTable[i][1]) then
						grouped = "|cffaaaaaa*|r"
					else
						grouped = ""
						if not guildTable[i][10] then
							menuCountInvites = menuCountInvites + 1
							menuList[2].menuList[menuCountInvites] = {text = format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, guildTable[i][3], classc.r*255,classc.g*255,classc.b*255, guildTable[i][1], ""), arg1 = guildTable[i][1],notCheckable=true, func = inviteClick}
						end
					end
					menuCountWhispers = menuCountWhispers + 1
					menuList[3].menuList[menuCountWhispers] = {text = format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, guildTable[i][3], classc.r*255,classc.g*255,classc.b*255, guildTable[i][1], grouped), arg1 = guildTable[i][1],notCheckable=true, func = whisperClick}
				end
			end

			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
		end)

		guildPlugin:SetScript("OnEnter", function(self)
			if not IsInGuild() then return end
			
			local total, _, online = GetNumGuildMembers()
			if #guildTable == 0 then BuildGuildTable() end
			
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			local guildName, guildRank = GetGuildInfo('player')
			
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()		
			GameTooltip:AddDoubleLine(hexa..PLAYER_NAME.."'s"..hexb.." Guild", format(guildInfoString2, online, total))
			
			SortGuildTable(IsShiftKeyDown())
			
			if guildMotD ~= "" then 
				GameTooltip:AddLine(' ')
				GameTooltip:AddLine(format(guildMotDString, GUILD_MOTD, guildMotD), ttsubh.r, ttsubh.g, ttsubh.b, 1) 
			end
			
			local col = RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b)
			
			local _, _, standingID, barMin, barMax, barValue = GetGuildFactionInfo()
			if standingID ~= 8 then -- Not Max Rep
				barMax = barMax - barMin
				barValue = barValue - barMin
				barMin = 0
				GameTooltip:AddLine(format(standingString, COMBAT_FACTION_CHANGE, ShortValue(barValue), ShortValue(barMax), ceil((barValue / barMax) * 100)))
			end
			
			local zonec, classc, levelc, info, grouped
			local shown = 0
			
			GameTooltip:AddLine(' ')
			for i = 1, #guildTable do
				-- if more then 30 guild members are online, we don't Show any more, but inform user there are more
				if 30 - shown <= 1 then
					if online - 30 > 1 then GameTooltip:AddLine(format(moreMembersOnlineString, online - 30), ttsubh.r, ttsubh.g, ttsubh.b) end
					break
				end

				info = guildTable[i]
				if GetRealZoneText() == info[4] then zonec = activezone else zonec = inactivezone end
				classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[9]], GetQuestDifficultyColor(info[3])
				
				if (UnitInParty(info[1]) or UnitInRaid(info[1])) then grouped = 1 else grouped = 2 end

				if IsShiftKeyDown() then
					GameTooltip:AddDoubleLine(format(nameRankString, info[1], info[2]), info[4], classc.r, classc.g, classc.b, zonec.r, zonec.g, zonec.b)
					if info[5] ~= "" then GameTooltip:AddLine(format(noteString, info[5]), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
					if info[6] ~= "" then GameTooltip:AddLine(format(officerNoteString, info[6]), ttoff.r, ttoff.g, ttoff.b, 1) end
				else
					GameTooltip:AddDoubleLine(format(levelNameStatusString, levelc.r*255, levelc.g*255, levelc.b*255, info[3], split("-", info[1]), groupedTable[grouped], info[8]), info[4], classc.r,classc.g,classc.b, zonec.r,zonec.g,zonec.b)
				end
				shown = shown + 1
			end	
			
			GameTooltip:Show()
			
			if not noUpdate then
				GuildRoster()
			end		
			GameTooltip:AddLine' '
			GameTooltip:AddLine("|cffeda55fLeft Click|r to Open Guild Roster")
			GameTooltip:AddLine("|cffeda55fHold Shift & Mouseover|r to See Guild and Officer Note's")
			GameTooltip:AddLine("|cffeda55fRight Click|r to open Options Menu")		
			GameTooltip:Show()
		end)

		guildPlugin:SetScript("OnLeave", function() GameTooltip:Hide() end)
		guildPlugin:SetScript("OnMouseDown", function(self, btn)
			if btn ~= "LeftButton" then return end
			ToggleGuildFrame()
		end)

		--guildPlugin:RegisterEvent("GUILD_ROSTER_SHOW")
		guildPlugin:RegisterEvent("PLAYER_ENTERING_WORLD")
		guildPlugin:RegisterEvent("GUILD_ROSTER_UPDATE")
		guildPlugin:RegisterEvent("PLAYER_GUILD_UPDATE")
		guildPlugin:SetScript("OnEvent", Update)
	end

	---------------
	-- Professions
	---------------
	if db.pro then

		local proPlugin = CreateFrame('Button', nil, Datapanel)
		proPlugin:RegisterEvent('PLAYER_ENTERING_WORLD')
		proPlugin:SetFrameStrata('BACKGROUND')
		proPlugin:SetFrameLevel(3)
		proPlugin:EnableMouse(true)
		proPlugin.tooltip = false

		local Text = proPlugin:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.pro, Text)

		local function Update(self)
			Text:SetFormattedText(hexa.."Professions"..hexb)
			self:SetAllPoints(Text)
		end

		proPlugin:SetScript('OnEnter', function()		
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Professions")
			GameTooltip:AddLine' '
			for i = 1, select("#", GetProfessions()) do
				local v = select(i, GetProfessions());
				if v ~= nil then
					local name, texture, rank, maxRank = GetProfessionInfo(v)
					GameTooltip:AddDoubleLine(name, rank..' / '..maxRank,.75,.9,1,.3,1,.3)
				end
			end
			GameTooltip:AddLine' '
			GameTooltip:AddLine("|cffeda55fLeft Click|r to Open Profession #1")
			GameTooltip:AddLine("|cffeda55fMiddle Click|r to Open Spell Book")
			GameTooltip:AddLine("|cffeda55fRight Click|r to Open Profession #2")
			
			GameTooltip:Show()
		end)


		proPlugin:SetScript("OnClick",function(self,btn)
			local prof1, prof2 = GetProfessions()
			if btn == "LeftButton" then
				if prof1 then
					if(GetProfessionInfo(prof1) == ('Skinning')) then
						CastSpellByName("Skinning Skills")
					elseif(GetProfessionInfo(prof1) == ('Mining')) then
						CastSpellByName("Mining Skills")
					elseif(GetProfessionInfo(prof1) == ('Herbalism')) then
						CastSpellByName("Herbalism Skills")					
					else	
						CastSpellByName((GetProfessionInfo(prof1)))
					end
				else
					print('|cff33ff99BasicUI:|r |cffFF0000No Profession Found!|r')
				end
			elseif btn == 'MiddleButton' then
				ToggleSpellBook(BOOKTYPE_PROFESSION)	
			elseif btn == "RightButton" then
				if prof2 then
					if(GetProfessionInfo(prof2) == ('Skinning')) then
						CastSpellByName("Skinning Skills")
					elseif(GetProfessionInfo(prof2) == ('Mining')) then
						CastSpellByName("Mining Skills")
					elseif(GetProfessionInfo(prof2) == ('Herbalism')) then
						CastSpellByName("Herbalism Skills")						
					else
						CastSpellByName((GetProfessionInfo(prof2)))
					end
				else
					print('|cff33ff99BasicUI:|r |cffFF0000No Profession Found!|r')
				end
			end
		end)


		proPlugin:RegisterForClicks("AnyUp")
		proPlugin:SetScript('OnUpdate', Update)
		proPlugin:SetScript('OnLeave', function() GameTooltip:Hide() end)
	end


	-----------
	-- Recount
	-----------
	if db.recount then 

		local math_abs=math.abs;
		local math_floor=math.floor;
		local math_log10=math.log10;
		local math_max=math.max;
		local tostring=tostring;
		 
		local NumberCaps={"K","M","B","T"};
		local function AbbreviateNumber(val)
			local exp=math_max(0,math_floor(math_log10(math_abs(val))));
			if exp<3 then return tostring(math_floor(val)); end
		 
			local factor=math_floor(exp/3);
			local precision=math_max(0,2-exp%3);
			return ((val<0 and "-" or "").."%0."..precision.."f%s"):format(val/1000^factor,NumberCaps[factor] or "e "..(factor*3));
		end

		
		local recountPlugin = CreateFrame('Frame', nil, Datapanel)
		recountPlugin:EnableMouse(true)
		recountPlugin:SetFrameStrata("MEDIUM")
		recountPlugin:SetFrameLevel(3)
		
		
		local Text  = recountPlugin:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.recount, Text)
		recountPlugin:SetAllPoints(Text)
			

		function OnEvent(self, event, ...)
			if event == "PLAYER_LOGIN" then
				if IsAddOnLoaded("Recount") then
					recountPlugin:RegisterEvent("PLAYER_REGEN_ENABLED")
					recountPlugin:RegisterEvent("PLAYER_REGEN_DISABLED")
					PLAYER_NAME = UnitName("player")
					currentFightDPS = 0
				else
					return
				end
				recountPlugin:UnregisterEvent("PLAYER_LOGIN")
				
			elseif event == "PLAYER_ENTERING_WORLD" then
				self.updateDPS()
				recountPlugin:UnregisterEvent("PLAYER_ENTERING_WORLD")
			end
		end

		function recountPlugin:RecountHook_UpdateText()
			self:updateDPS()
		end

		function recountPlugin:updateDPS()
			if IsAddOnLoaded("Recount") then 
				Text:SetText(hexa.."DPS: "..hexb.. AbbreviateNumber(recountPlugin.getDPS()) .. "|r")
			else
				Text:SetText(hexa.."DPS: "..hexb.. "N/A".."|r")
			end
		end

		function recountPlugin:getDPS()
			if not IsAddOnLoaded("Recount") then return "N/A" end
			if db.recountraiddps == true then
				-- show raid dps
				_, dps = recountPlugin:getRaidValuePerSecond(Recount.db.profile.CurDataSet)
				return dps
			else
				return recountPlugin.getValuePerSecond()
			end
		end

		-- quick dps calculation from recount's data
		function recountPlugin:getValuePerSecond()
			local _, dps = Recount:MergedPetDamageDPS(Recount.db2.combatants[PLAYER_NAME], Recount.db.profile.CurDataSet)
			return math.floor(10 * dps + 0.5) / 10
		end

		function recountPlugin:getRaidValuePerSecond(tablename)
			local dps, curdps, data, damage, temp = 0, 0, nil, 0, 0
			for _,data in pairs(Recount.db2.combatants) do
				if data.Fights and data.Fights[tablename] and (data.type=="Self" or data.type=="Grouped" or data.type=="Pet" or data.type=="Ungrouped") then
					temp, curdps = Recount:MergedPetDamageDPS(data,tablename)
					if data.type ~= "Pet" or (not Recount.db.profile.MergePets and data.Owner and (Recount.db2.combatants[data.Owner].type=="Self" or Recount.db2.combatants[data.Owner].type=="Grouped" or Recount.db2.combatants[data.Owner].type=="Ungrouped")) or (not Recount.db.profile.MergePets and data.Name and data.GUID and self:matchUnitGUID(data.Name, data.GUID)) then
						dps = dps + 10 * curdps
						damage = damage + temp
					end
				end
			end
			return math.floor(damage + 0.5) / 10, math.floor(dps + 0.5)/10
		end

		-- tracked events
		recountPlugin:RegisterEvent("PLAYER_LOGIN")
		recountPlugin:RegisterEvent("PLAYER_ENTERING_WORLD")

		-- scripts
		recountPlugin:SetScript("OnEnter", function(self)	
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Damage")
			GameTooltip:AddLine' '		
			if IsAddOnLoaded("Recount") then
				local damage, dps = Recount:MergedPetDamageDPS(Recount.db2.combatants[PLAYER_NAME], Recount.db.profile.CurDataSet)
				local raid_damage, raid_dps = recountPlugin:getRaidValuePerSecond(Recount.db.profile.CurDataSet)
				-- format the number
				dps = math.floor(10 * dps + 0.5) / 10
				GameTooltip:AddLine("Recount")
				GameTooltip:AddDoubleLine("Personal Damage:", AbbreviateNumber(damage), 1, 1, 1, 0.8, 0.8, 0.8)
				GameTooltip:AddDoubleLine("Personal DPS:", AbbreviateNumber(dps), 1, 1, 1, 0.8, 0.8, 0.8)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine("Raid Damage:", AbbreviateNumber(raid_damage), 1, 1, 1, 0.8, 0.8, 0.8)
				GameTooltip:AddDoubleLine("Raid DPS:", AbbreviateNumber(raid_dps), 1, 1, 1, 0.8, 0.8, 0.8)
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine("|cffeda55fLeft Click|r to toggle Recount")
				GameTooltip:AddLine("|cffeda55fRight Click|r to reset data")
				GameTooltip:AddLine("|cffeda55fShift + Right Click|r to open config")
			else
				GameTooltip:AddLine("Recount is not loaded.", 255, 0, 0)
				GameTooltip:AddLine("Enable Recount and reload your UI.")
			end
			GameTooltip:Show()
		end)
		recountPlugin:SetScript("OnMouseUp", function(self, button)
			if button == "RightButton" then
				if not IsShiftKeyDown() then
					Recount:ShowReset()
				else
					Recount:ShowConfig()
				end
			elseif button == "LeftButton" then
				if Recount.MainWindow:IsShown() then
					Recount.MainWindow:Hide()
				else
					Recount.MainWindow:Show()
					Recount:RefreshMainWindow()
				end
			end
		end)
		recountPlugin:SetScript("OnEvent", OnEvent)
		recountPlugin:SetScript("OnLeave", function() GameTooltip:Hide() end)
		recountPlugin:SetScript("OnUpdate", function(self, t)
			local int = -1
			int = int - t
			if int < 0 then
				self.updateDPS()
				int = 1
			end
		end)
	end

	--------------------
	-- Talent Spec Swap
	--------------------
	if db.spec then

		local specPlugin = CreateFrame('Frame', nil, Datapanel)
		specPlugin:EnableMouse(true)
		specPlugin:SetFrameStrata('BACKGROUND')
		specPlugin:SetFrameLevel(3)

		local Text = specPlugin:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.spec, Text)

		local talent = {}
		local active
		local talentString = string.join('', '|cffFFFFFF%s|r ')
		local activeString = string.join('', '|cff00FF00' , ACTIVE_PETS, '|r')
		local inactiveString = string.join('', '|cffFF0000', FACTION_INACTIVE, '|r')



		local function LoadTalentTrees()
			for i = 1, GetNumSpecGroups(false, false) do
				talent[i] = {} -- init talent group table
				for j = 1, GetNumSpecializations(false, false) do
					talent[i][j] = select(5, GetSpecializationInfo(j, false, false, i))
				end
			end
		end

		local int = 5
		local function Update(self, t)
			
			int = int - t
			if int > 0 then return end
			active = GetActiveSpecGroup(false, false)
			if MODULE.playerRole ~= nil then
				Text:SetFormattedText(talentString, hexa..select(2, GetSpecializationInfo(GetSpecialization(false, false, active)))..hexb)
			else
				Text:SetText(hexa.."No Spec"..hexb)
			end
			int = 2

			--disable script	
			self:SetScript('OnUpdate', nil)
			
		end


		specPlugin:SetScript('OnEnter', function(self)
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)

			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Spec")
			GameTooltip:AddLine' '
			if MODULE.playerRole ~= nil then
				for i = 1, GetNumSpecGroups() do
					if GetSpecialization(false, false, i) then
						GameTooltip:AddLine(string.join('- ', string.format(talentString, select(2, GetSpecializationInfo(GetSpecialization(false, false, i)))), (i == active and activeString or inactiveString)),1,1,1)
					end
				end
			else
				GameTooltip:AddLine("You have not chosen a Spec yet.")
			end
			GameTooltip:AddLine' '		
			GameTooltip:AddLine("|cffeda55fClick|r to Open Talent Tree")
			GameTooltip:Show()
		end)

		specPlugin:SetScript('OnLeave', function() GameTooltip:Hide() end)

		local function OnEvent(self, event, ...)
			if event == 'PLAYER_ENTERING_WORLD' then
				self:UnregisterEvent('PLAYER_ENTERING_WORLD')
			end
			
			-- load talent information
			LoadTalentTrees()

			-- Setup Talents Tooltip
			self:SetAllPoints(Text)

			-- update datatext
			if event ~= 'PLAYER_ENTERING_WORLD' then
				self:SetScript('OnUpdate', Update)
			end
		end



		specPlugin:RegisterEvent('PLAYER_ENTERING_WORLD');
		specPlugin:RegisterEvent('CHARACTER_POINTS_CHANGED');
		specPlugin:RegisterEvent('PLAYER_TALENT_UPDATE');
		specPlugin:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
		specPlugin:RegisterEvent("EQUIPMENT_SETS_CHANGED")
		specPlugin:SetScript('OnEvent', OnEvent)
		specPlugin:SetScript('OnUpdate', Update)

		specPlugin:SetScript("OnMouseDown", function() ToggleTalentFrame() end)
	end

	-----------------
	-- Stats
	-----------------
	if db.stats then

		local statsPlugin = CreateFrame('Frame', nil, Datapanel)
		statsPlugin:RegisterEvent("PLAYER_ENTERING_WORLD")
		statsPlugin:SetFrameStrata("BACKGROUND")
		statsPlugin:SetFrameLevel(3)
		statsPlugin:EnableMouse(true)

		local Text = statsPlugin:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.stats, Text)

		local playerClass, englishClass = UnitClass("player");

		local function ShowTooltip(self)	
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Statistics")
			GameTooltip:AddLine' '		
			if MODULE.playerRole == nil then
				GameTooltip:AddLine("Choose a Specialization to see Stats")
			else
				if MODULE.playerRole == "TANK" then
					local Total_Dodge = GetDodgeChance()
					local Total_Parry = GetParryChance()
					local Total_Block = GetBlockChance()
					
					GameTooltip:AddLine(STAT_CATEGORY_DEFENSE)
					GameTooltip:AddDoubleLine(DODGE_CHANCE, format("%.2f%%", Total_Dodge),1,1,1)
					GameTooltip:AddDoubleLine(PARRY_CHANCE, format("%.2f%%", Total_Parry),1,1,1)
					GameTooltip:AddDoubleLine(BLOCK_CHANCE, format("%.2f%%", Total_Block),1,1,1)				
					
				elseif MODULE.playerRole == "HEALER" or MODULE.playerRole == "CASTER" then
					local SC = GetSpellCritChance("2")
					local Total_Spell_Haste = UnitSpellHaste("player")
					local base, casting = GetManaRegen()
					local manaRegenString = "%d / %d"				
					
					GameTooltip:AddLine(STAT_CATEGORY_SPELL)
					GameTooltip:AddDoubleLine(STAT_CRITICAL_STRIKE, format("%.2f%%", SC), 1, 1, 1)
					GameTooltip:AddDoubleLine(STAT_HASTE, format("%.2f%%", Total_Spell_Haste), 1, 1, 1)		
					GameTooltip:AddDoubleLine(MANA_REGEN, format(manaRegenString, base * 5, casting * 5), 1, 1, 1)

				elseif MODULE.playerRole == "DAMAGER" then			
					if englishClass == "HUNTER" then
						local Total_Range_Haste = GetRangedHaste("player")
						--local Range_Armor_Pen = GetArmorPenetration();
						local Range_Crit = GetRangedCritChance("25")
						local speed = UnitRangedDamage("player")
						local Total_Range_Speed = speed
						
						GameTooltip:AddLine(STAT_CATEGORY_RANGED)					
						--GameTooltip:AddDoubleLine("Armor Penetration", format("%.2f%%", Range_Armor_Pen), 1, 1, 1)
						GameTooltip:AddDoubleLine(STAT_CRITICAL_STRIKE, format("%.2f%%", Range_Crit), 1, 1, 1)	
						GameTooltip:AddDoubleLine(STAT_HASTE, format("%.2f%%", Total_Range_Haste), 1, 1, 1)
						GameTooltip:AddDoubleLine(STAT_ATTACK_SPEED, format("%.2f".." (sec)", Total_Range_Speed), 1, 1, 1)					
					else
						local Melee_Crit = GetCritChance("player")
						--local Melee_Armor_Pen = GetArmorPenetration();
						local Total_Melee_Haste = GetMeleeHaste("player")
						local mainSpeed = UnitAttackSpeed("player");
						local MH = mainSpeed
						
						GameTooltip:AddLine(STAT_CATEGORY_MELEE)
						--GameTooltip:AddDoubleLine("Armor Penetration", format("%.2f%%", Melee_Armor_Pen), 1, 1, 1)
						GameTooltip:AddDoubleLine(STAT_CRITICAL_STRIKE, format("%.2f%%", Melee_Crit), 1, 1, 1)		
						GameTooltip:AddDoubleLine(STAT_HASTE, format("%.2f%%", Total_Melee_Haste), 1, 1, 1)
						GameTooltip:AddDoubleLine(STAT_ATTACK_SPEED, format("%.2f".." (sec)", MH), 1, 1, 1)
					end
				end
				if GetCombatRating(CR_MASTERY) ~= 0 and GetSpecialization() then
					local masteryspell = GetSpecializationMasterySpells(GetSpecialization())
					local Mastery = GetMasteryEffect("player")
					local masteryName, _, _, _, _, _, _, _, _ = GetSpellInfo(masteryspell)
					if masteryName then
						GameTooltip:AddDoubleLine(masteryName, format("%.2f%%", Mastery), 1, 1, 1)
					end
				end
					
				GameTooltip:AddLine' '
				GameTooltip:AddLine(STAT_CATEGORY_GENERAL)
				
				local Life_Steal = GetLifesteal();
				--local Versatility = GetVersatility();
				local Versatility_Damage_Bonus = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE);
				local Avoidance = GetAvoidance();
				--local bonusArmor, isNegatedForSpec = UnitBonusArmor("player");
				
				--GameTooltip:AddDoubleLine(STAT_BONUS_ARMOR, format("%s", bonusArmor), 1, 1, 1)
				GameTooltip:AddDoubleLine(STAT_LIFESTEAL, format("%.2f%%", Life_Steal), 1, 1, 1)
				GameTooltip:AddDoubleLine(STAT_VERSATILITY, format("%.2f%%", Versatility_Damage_Bonus), 1, 1, 1)
				--GameTooltip:AddDoubleLine(STAT_VERSATILITY, format("%d", Versatility), 1, 1, 1)
				GameTooltip:AddDoubleLine(STAT_AVOIDANCE, format("%.2f%%", Avoidance), 1, 1, 1)			
			end

			GameTooltip:Show()
		end

		local function UpdateTank(self)
			local armorString = hexa..ARMOR..hexb..": "
			local displayNumberString = string.join("", "%s", "%d|r");
			local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player");
			local Melee_Reduction = effectiveArmor
			
			Text:SetFormattedText(displayNumberString, armorString, effectiveArmor)
			--Setup Tooltip
			self:SetAllPoints(Text)
		end

		local function UpdateCaster(self)
			local spellpwr = GetSpellBonusDamage("2");
			local displayNumberString = string.join("", "%s", "%d|r");
			
			Text:SetFormattedText(displayNumberString, hexa.."SP: "..hexb, spellpwr)
			--Setup Tooltip
			self:SetAllPoints(Text)
		end

		local function UpdateDamager(self)	
			local displayNumberString = string.join("", "%s", "%d|r");
				
			if englishClass == "HUNTER" then
				local base, posBuff, negBuff = UnitRangedAttackPower("player")
				local Range_AP = base + posBuff + negBuff	
				pwr = Range_AP
			else
				local base, posBuff, negBuff = UnitAttackPower("player")
				local Melee_AP = base + posBuff + negBuff		
				pwr = Melee_AP
			end
			
			Text:SetFormattedText(displayNumberString, hexa.."AP: "..hexb, pwr)      
			--Setup Tooltip
			self:SetAllPoints(Text)
		end

		-- initial delay for update (let the ui load)
		local int = 5	
		local function Update(self, t)
			int = int - t
			if int > 0 then return end
			if MODULE.playerRole == nil then
				Text:SetText(hexa.."No Stats"..hexb)
			else
				if MODULE.playerRole == "TANK" then 
					UpdateTank(self)
				elseif MODULE.playerRole == "HEALER" or MODULE.playerRole == "CASTER" then
					UpdateCaster(self)
				elseif MODULE.playerRole == "DAMAGER" then
					UpdateDamager(self)
				end
			end
			int = 2
		end

		statsPlugin:SetScript("OnEnter", function() ShowTooltip(statsPlugin) end)
		statsPlugin:SetScript("OnLeave", function() GameTooltip:Hide() end)
		statsPlugin:SetScript("OnUpdate", Update)
		Update(statsPlugin, 10)
	end

	-------------------
	-- System Settings
	-------------------
	if db.system then

		local systemPlugin = CreateFrame('Frame', nil, Datapanel)
		systemPlugin:RegisterEvent("PLAYER_ENTERING_WORLD")
		systemPlugin:SetFrameStrata("BACKGROUND")
		systemPlugin:SetFrameLevel(3)
		systemPlugin:EnableMouse(true)
		systemPlugin.tooltip = false

		local Text = systemPlugin:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.font, db.fontSize,'THINOUTLINE')
		PlacePlugin(db.system, Text)

		local bandwidthString = "%.2f Mbps"
		local percentageString = "%.2f%%"
		local homeLatencyString = "%d ms"
		local worldLatencyString = "%d ms"
		local kiloByteString = "%d kb"
		local megaByteString = "%.2f mb"

		local function formatMem(memory)
			local mult = 10^1
			if memory > 999 then
				local mem = ((memory/1024) * mult) / mult
				return string.format(megaByteString, mem)
			else
				local mem = (memory * mult) / mult
				return string.format(kiloByteString, mem)
			end
		end

		local memoryTable = {}

		local function RebuildAddonList(self)
			local addOnCount = GetNumAddOns()
			if (addOnCount == #memoryTable) or self.tooltip == true then return end

			-- Number of loaded addons changed, create new memoryTable for all addons
			memoryTable = {}
			for i = 1, addOnCount do
				memoryTable[i] = { i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i) }
			end
			self:SetAllPoints(Text)
		end

		local function UpdateMemory()
			-- Update the memory usages of the addons
			UpdateAddOnMemoryUsage()
			-- Load memory usage in table
			local addOnMem = 0
			local totalMemory = 0
			for i = 1, #memoryTable do
				addOnMem = GetAddOnMemoryUsage(memoryTable[i][1])
				memoryTable[i][3] = addOnMem
				totalMemory = totalMemory + addOnMem
			end
			-- Sort the table to put the largest addon on top
			table.sort(memoryTable, function(a, b)
				if a and b then
					return a[3] > b[3]
				end
			end)
			
			return totalMemory
		end

		-- initial delay for update (let the ui load)
		local int, int2 = 6, 5
		local statusColors = {
			"|cff0CD809",
			"|cffE8DA0F",
			"|cffFF9000",
			"|cffD80909"
		}

		local function Update(self, t)
			int = int - t
			int2 = int2 - t
			
			if int < 0 then
				RebuildAddonList(self)
				int = 10
			end
			if int2 < 0 then
				local framerate = floor(GetFramerate())
				local fpscolor = 4
				local latency = select(4, GetNetStats()) 
				local latencycolor = 4
							
				if latency < 150 then
					latencycolor = 1
				elseif latency >= 150 and latency < 300 then
					latencycolor = 2
				elseif latency >= 300 and latency < 500 then
					latencycolor = 3
				end
				if framerate >= 30 then
					fpscolor = 1
				elseif framerate >= 20 and framerate < 30 then
					fpscolor = 2
				elseif framerate >= 10 and framerate < 20 then
					fpscolor = 3
				end
				local displayFormat = string.join("", hexa.."Framerate: "..hexb, statusColors[fpscolor], "%d|r")
				Text:SetFormattedText(displayFormat, framerate, latency)
				int2 = 1
			end
		end
		systemPlugin:SetScript("OnMouseDown", function () collectgarbage("collect") Update(systemPlugin, 20) end)
		systemPlugin:SetScript("OnEnter", function(self)		
			local bandwidth = GetAvailableBandwidth()
			local _, _, latencyHome, latencyWorld = GetNetStats() 
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Latency")
			GameTooltip:AddLine' '			
			GameTooltip:AddDoubleLine("Home Latency: ", string.format(homeLatencyString, latencyHome), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
			GameTooltip:AddDoubleLine("World Latency: ", string.format(worldLatencyString, latencyWorld), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)

			if bandwidth ~= 0 then
				GameTooltip:AddDoubleLine(L.datatext_bandwidth , string.format(bandwidthString, bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
				GameTooltip:AddDoubleLine("Download: " , string.format(percentageString, GetDownloadedPercentage() *100),0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
				GameTooltip:AddLine(" ")
			end
			local totalMemory = UpdateMemory()
			GameTooltip:AddDoubleLine("Total Memory Usage:", formatMem(totalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
			GameTooltip:AddLine(" ")
			for i = 1, #memoryTable do
				if (memoryTable[i][4]) then
					local red = memoryTable[i][3] / totalMemory
					local green = 1 - red
					GameTooltip:AddDoubleLine(memoryTable[i][2], formatMem(memoryTable[i][3]), 1, 1, 1, red, green + .5, 0)
				end						
			end
			GameTooltip:Show()
		end)
		systemPlugin:SetScript("OnLeave", function() GameTooltip:Hide() end)
		systemPlugin:SetScript("OnUpdate", Update)
		Update(systemPlugin, 10)
	end
end

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end


function MODULE:OnEnable()
	-- This line should not be needed if you're using modules correctly:
	if not db.enable then return end

	if db.enable then -- How is this different than "enable" ? If the panel is not enabled, what's the point of doing anything else?
		self:CreatePanels(); -- factor this giant blob out into its own function to keep things clean
		self:SetBattlegroundPanel();
		self:Refresh()
	end
end

function MODULE:Refresh()
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEnable")
	end
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UpdatePlayerRole()	
	self:CreateStats()
end

function MODULE:SetFontString(parent, file, size, flags)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(file, size, flags)
	return fs
end


------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

local options
function MODULE:GetOptions()
	if options then
		return options
	end

	local function isModuleDisabled()
		return not BasicUI:GetModuleEnabled(MODULE_NAME)
	end

	local statposition = {
		["P0"] = L["Not Shown"],
		["P1"] = L["Position #1"],
		["P2"] = L["Position #2"],
		["P3"] = L["Position #3"],
		["P4"] = L["Position #4"],
		["P5"] = L["Position #5"],
		["P6"] = L["Position #6"],
		["P7"] = L["Position #7"],
		["P8"] = L["Position #8"],
		["P9"] = L["Position #9"],
	}
	
	options = {
		type = "group",
		name = L[MODULE_NAME],
		childGroups = "tree",
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
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
				desc = L["Enables the Datapanel Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = false,
			},
			bag = {
				type = "toggle",
				order = 2,
				name = L["Bag Open"],
				desc = L["Checked opens Backpack only, Unchecked opens all bags."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			battleground = {
				type = "toggle",
				order = 2,
				name = L["Battleground Text"],
				desc = L["Display special datapanels when inside a battleground"],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			enableColor = {
				type = "toggle",					
				order = 2,
				name = L["Enable Class Color"],
				desc = L["Use your classcolor text."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			recountraiddps = {
				type = "toggle",
				order = 2,
				name = L["Recount Raid DPS"],
				desc = L["Display Recount's Raid DPS (RECOUNT MUST BE INSTALLED)"],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			fontSize = {
				type = "range",
				order = 4,						
				name = L["Plugin Font Size"],
				desc = L["Controls the Size of the Plugin Font"],
				min = 0,
				max = 30,
				step = 1,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			DataGroup = {
				type = "group",
				order = 5,
				name = L["Text Positions"],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				args = {
					GroupDesc = {
						type = "description",
						order = 0,
						name = " ",
						desc = L["Chose wich location you would like each stat."],
						width = "full",
					},
					bags = {
						type = "select",
						order = 2,
						name = L["Bags"],
						desc = L["Display amount of bag space"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					calltoarms = {
						type = "select",
						order = 2,
						name = L["Call to Arms"],
						desc = L["Display the active roles that will recieve a reward for completing a random dungeon"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					dps = {
						type = "select",
						order = 2,
						name = L["DPS"],
						desc = L["Display amount of DPS"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					dur = {
						type = "select",
						order = 2,
						name = L["Durability"],
						desc = L["Display your current durability"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					friends = {
						type = "select",
						order = 2,
						name = L["Friends"],
						desc = L["Display current online friends"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					guild = {
						type = "select",
						order = 2,
						name = L["Guild"],
						desc = L["Display current online people in guild"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					pro = {
						type = "select",
						order = 2,
						name = L["Professions"],
						desc = L["Display Professions"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					recount = {
						type = "select",
						order = 2,
						name = L["Recount"],
						desc = L["Display Recount's DPS (RECOUNT MUST BE INSTALLED)"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					spec = {
						type = "select",
						order = 2,
						name = L["Talent Spec"],
						desc = L["Display current spec"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					stats = {
						type = "select",
						order = 2,
						name = L["Stat #1"],
						desc = L["Display stat based on your role (Avoidance-Tank, AP-Melee, SP/HP-Caster)"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					system = {
						type = "select",
						order = 2,
						name = L["System"],
						desc = L["Display FPS and Latency"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
				},
			},
		},
	}
	return options
end