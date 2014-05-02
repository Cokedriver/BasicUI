local MODULE_NAME = "Datatext"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Datatext = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local Adjust = LibStub:GetLibrary("LibBasicAdjust-1.0", true)
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		battleground = true,                            	-- enable 3 stats in battleground only that replace stat1,stat2,stat3.
		bag = false,										-- True = Open Backpack; False = Open All bags			
		
		-- Color Datatext	
		customcolor = { r = 1, g = 1, b = 1},				-- Color of Text for Datapanel
		-- Stat Locations
		armor 			= "P0",                                -- show your armor value against the level mob you are currently targeting.
		avd 			= "P0",                                -- show your current avoidance against the level of the mob your targeting	
		bags			= "P9",                                -- show space used in bags on panel.
		haste 			= "P0",                                -- show your haste rating on panels.	
		system 			= "P0",                                -- show total memory and others systems info (FPS/MS) on panel.	
		guild 			= "P4",                                -- show number on guildmate connected on panel.
		dur 			= "P8",                                -- show your equipment durability on panel.
		friends 		= "P6",                                -- show number of friends connected.
		dps_text 		= "P0",                                -- show a dps meter on panel.
		hps_text 		= "P0",                                -- show a heal meter on panel.
		spec 			= "P5",								-- show your current spec on panel.
		coords 			= "P0",								-- show your current coords on panel.
		pro 			= "P7",								-- shows your professions and tradeskills
		stat1 			= "P1",								-- Stat Based on your Role (Avoidance-Tank, AP-Melee, SP/HP-Caster)
		stat2 			= "P3",								-- Stat Based on your Role (Armor-Tank, Crit-Melee, Crit-Caster)
		recount 		= "P2",								-- Stat Based on Recount"s DPS
		recountraiddps 	= false,							-- Enables tracking or Recounts Raid DPS
		calltoarms 		= "P0",								-- Show Current Call to Arms.		
	}
}

------------------------------------------------------------------------
--	 Local Module Functions
------------------------------------------------------------------------
-- Variables that point to frames or other objects:
local Datapanel, StatPanelLeft, StatPanelCenter, StatPanelRight, BGPanel
local currentFightDPS
local PLAYER_CLASS = UnitClass("player")
local PLAYER_NAME = UnitName("player")
local PLAYER_REALM = GetRealmName()
local SCREEN_WIDTH = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))
local TOC_VERSION = select(4, GetBuildInfo())
local GAME_LOCALE = GetLocale()
local classColor

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

local classRoles = {
	PALADIN = {
		[1] = "Caster",
		[2] = "Tank",
		[3] = "Melee",
	},
	PRIEST = "Caster",
	WARLOCK = "Caster",
	WARRIOR = {
		[1] = "Melee",
		[2] = "Melee",
		[3] = "Tank",	
	},
	HUNTER = "Melee",
	SHAMAN = {
		[1] = "Caster",
		[2] = "Melee",
		[3] = "Caster",	
	},
	ROGUE = "Melee",
	MAGE = "Caster",
	DEATHKNIGHT = {
		[1] = "Tank",
		[2] = "Melee",
		[3] = "Melee",	
	},
	DRUID = {
		[1] = "Caster",
		[2] = "Melee",
		[3] = "Tank",	
		[4] = "Caster"
	},
	MONK = {
		[1] = "Tank",
		[2] = "Caster",
		[3] = "Melee",	
	},
}

local _, playerClass = UnitClass("player")
local Role
local function CheckRole()
	local talentTree = GetSpecialization()

	if(type(classRoles[playerClass]) == "string") then
		Role = classRoles[playerClass]
	elseif(talentTree) then
		Role = classRoles[playerClass][talentTree]
	end
end

local eventHandler = CreateFrame("Frame")
eventHandler:RegisterEvent("PLAYER_ENTERING_WORLD")
eventHandler:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
eventHandler:RegisterEvent("PLAYER_TALENT_UPDATE")
eventHandler:RegisterEvent("CHARACTER_POINTS_CHANGED")
eventHandler:SetScript("OnEvent", CheckRole)


------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

function Datatext:SetDataPanel()

	Datapanel = CreateFrame("Frame", "Datapanel", UIParent)

	Datapanel:SetPoint("BOTTOM", UIParent, 0, 0)
	Datapanel:SetWidth(1200)
	Datapanel:SetFrameLevel(1)
	Datapanel:SetHeight(35)
	Datapanel:SetFrameStrata("LOW")
	Datapanel:SetBackdrop({ bgFile = BasicUI.media.background, edgeFile = BasicUI.media.panelborder, edgeSize = 25, insets = { left = 5, right = 5, top = 5, bottom = 5 } })
	Datapanel:SetBackdropColor(0, 0, 0, 1)

	-- Hide Panels When in a Vehicle or Pet Battle
	Datapanel:RegisterUnitEvent("UNIT_ENTERING_VEHICLE", "player")
	Datapanel:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
	Datapanel:RegisterUnitEvent("PET_BATTLE_OPENING_START")
	Datapanel:RegisterUnitEvent("PET_BATTLE_CLOSE")
	Datapanel:RegisterUnitEvent("PLAYER_ENTERING_WORLD")

	Datapanel:SetScript("OnEvent", function(self, event, ...)
		if event == "UNIT_ENTERING_VEHICLE" or event == "PET_BATTLE_OPENING_START" then
			self:Hide()
		elseif event == "UNIT_EXITED_VEHICLE" or event == "PET_BATTLE_CLOSE" or event == "PLAYER_ENTERING_WORLD" then	
			self:Show()
		end
	end)	
	
	if Adjust then	
		Adjust:RegisterBottom(Datapanel)
	end

end

function Datatext:SetStatPanelLeft()
	StatPanelLeft = CreateFrame("Frame", nil, Datapanel)
	StatPanelLeft:SetPoint("LEFT", Datapanel, 5, 0)
	StatPanelLeft:SetHeight(35)
	StatPanelLeft:SetWidth(1200 / 3)
	StatPanelLeft:SetFrameStrata("MEDIUM")
	StatPanelLeft:SetFrameLevel(1)
end

function Datatext:SetStatPanelCenter()	
	StatPanelCenter = CreateFrame("Frame", nil, Datapanel)
	StatPanelCenter:SetPoint("CENTER", Datapanel, 0, 0)
	StatPanelCenter:SetHeight(35)
	StatPanelCenter:SetWidth(1200 / 3)
	StatPanelCenter:SetFrameStrata("MEDIUM")
	StatPanelCenter:SetFrameLevel(1)
end

function Datatext:SetStatPanelRight()
	StatPanelRight = CreateFrame("Frame", nil, Datapanel)
	StatPanelRight:SetPoint("RIGHT", Datapanel, -5, 0)
	StatPanelRight:SetHeight(35)
	StatPanelRight:SetWidth(1200 / 3)
	StatPanelRight:SetFrameStrata("MEDIUM")
	StatPanelRight:SetFrameLevel(1)
end

function Datatext:PlacePlugin(position, plugin)
	local left = StatPanelLeft
	local center = StatPanelCenter
	local right = StatPanelRight

	-- Left Panel Data
	if position == "P1" then
		plugin:SetParent(left)
		plugin:SetHeight(left:GetHeight())
		plugin:SetPoint('LEFT', left, 30, 0)
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
		plugin:SetPoint('RIGHT', left, -30, 0)
		plugin:SetPoint('TOP', left)
		plugin:SetPoint('BOTTOM', left)

	-- Center Panel Data
	elseif position == "P4" then
		plugin:SetParent(center)
		plugin:SetHeight(center:GetHeight())
		plugin:SetPoint('LEFT', center, 30, 0)
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
		plugin:SetPoint('RIGHT', center, -30, 0)
		plugin:SetPoint('TOP', center)
		plugin:SetPoint('BOTTOM', center)

	-- Right Panel Data
	elseif position == "P7" then
		plugin:SetParent(right)
		plugin:SetHeight(right:GetHeight())
		plugin:SetPoint('LEFT', right, 30, 0)
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
		plugin:SetPoint('RIGHT', right, -30, 0)
		plugin:SetPoint('TOP', right)
		plugin:SetPoint('BOTTOM', right)
	elseif position == "P0" then
		return
	end
end

function Datatext:CreateStats()

	local function DataTextTooltipAnchor(self)
		local panel = self:GetParent()
		local anchor = 'GameTooltip'
		local xoff = 1
		local yoff = 3
		
		
		for _, panel in pairs ({
			StatPanelLeft,
			StatPanelCenter,
			StatPanelRight,
		})	do
			anchor = 'ANCHOR_TOP'
		end	
		return anchor, panel, xoff, yoff
	end	
	
	if BasicUI.db.profile.general.classcolor ~= true then
		local r, g, b = db.customcolor.r, db.customcolor.g, db.customcolor.b
		hexa = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
		hexb = "|r"
	else
		hexa = ("|cff%.2x%.2x%.2x"):format(classColor.r * 255, classColor.g * 255, classColor.b * 255)
		hexb = "|r"
	end	
	
	----------------
	-- Player Armor
	----------------
	if db.armor then
		local effectiveArmor
		
		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = Stat:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.armor, Text)

		local function Update(self)
			effectiveArmor = select(2, UnitArmor("player"))
			Text:SetText(hexa.."Armor: "..hexb..(effectiveArmor))
			--Setup Armor Tooltip
			self:SetAllPoints(Text)
		end

		Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
		Stat:RegisterEvent("UNIT_AURA")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
		Stat:SetScript("OnEvent", Update)
		Stat:SetScript("OnEnter", function(self)
			if not InCombatLockdown() then
				local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)	
				GameTooltip:SetOwner(panel, anchor, xoff, yoff)
				GameTooltip:ClearLines()
				GameTooltip:AddLine("Mitigation By Level: ")
				local lv = 83
				local mitigation = (effectiveArmor/(effectiveArmor+(467.5*lv-22167.5)))
				for i = 1, 4 do
					local format = string.format
					if mitigation > .75 then
						mitigation = .75
					end
					GameTooltip:AddDoubleLine(lv,format("%.2f", mitigation*100) .. "%",1,1,1)
					lv = lv - 1
				end
				if UnitLevel("target") > 0 and UnitLevel("target") < UnitLevel("player") then
					if mitigation > .75 then
						mitigation = .75
					end
					GameTooltip:AddDoubleLine(UnitLevel("target"),format("%.2f", mitigation*100) .. "%",1,1,1)
				end
				GameTooltip:Show()
			end
		end)
		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	--------------------
	-- Player Avoidance
	--------------------
	if db.avd then
		local dodge, parry, block, avoidance, targetlv, playerlv, basemisschance, leveldifference
		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = Stat:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.avd, Text)
		
		local targetlv, playerlv

		local function Update(self)
			local format = string.format
			targetlv, playerlv = UnitLevel("target"), UnitLevel("player")
			local basemisschance, leveldifference, avoidance
			
			if targetlv == -1 then
				basemisschance = (5 - (3*.2))  --Boss Value
				leveldifference = 3
			elseif targetlv > playerlv then
				basemisschance = (5 - ((targetlv - playerlv)*.2)) --Mobs above player level
				leveldifference = (targetlv - playerlv)
			elseif targetlv < playerlv and targetlv > 0 then
				basemisschance = (5 + ((playerlv - targetlv)*.2)) --Mobs below player level
				leveldifference = (targetlv - playerlv)
			else
				basemisschance = 5 --Sets miss chance of attacker level if no target exists, lv80=5, 81=4.2, 82=3.4, 83=2.6
				leveldifference = 0
			end
			
			if myrace == "NightElf" then
				basemisschance = basemisschance + 2
			end

			if leveldifference >= 0 then
				dodge = (GetDodgeChance()-leveldifference*.2)
				parry = (GetParryChance()-leveldifference*.2)
				block = (GetBlockChance()-leveldifference*.2)
				avoidance = (dodge+parry+block)
				Text:SetText(hexa.."Avd: "..hexb..format("%.2f", avoidance).."|r")
			else
				dodge = (GetDodgeChance()+abs(leveldifference*.2))
				parry = (GetParryChance()+abs(leveldifference*.2))
				block = (GetBlockChance()+abs(leveldifference*.2))
				avoidance = (dodge+parry+block)
				Text:SetText(hexa.."Avd: "..hexb..format("%.2f", avoidance).."|r")
			end

			--Setup Avoidance Tooltip
			self:SetAllPoints(Text)
		end


		Stat:RegisterEvent("UNIT_AURA")
		Stat:RegisterEvent("UNIT_INVENTORY_CHANGED")
		Stat:RegisterEvent("PLAYER_TARGET_CHANGED")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetScript("OnEvent", Update)
		Stat:SetScript("OnEnter", function(self)
			if not InCombatLockdown() then
				local anchor, yoff = DataTextTooltipAnchor(Text)
				GameTooltip:SetOwner(self, anchor, 0, yoff)
				GameTooltip:ClearAllPoints()
				GameTooltip:ClearLines()
				if targetlv > 1 then
					GameTooltip:AddDoubleLine("Avoidance Breakdown".." (".."lvl".." "..targetlv..")")
				elseif targetlv == -1 then
					GameTooltip:AddDoubleLine("Avoidance Breakdown".." (".."Boss"..")")
				else
					GameTooltip:AddDoubleLine("Avoidance Breakdown".." (".."lvl".." "..targetlv..")")
				end
				GameTooltip:AddDoubleLine("Dodge",format("%.2f",dodge) .. "%",1,1,1,  1,1,1)
				GameTooltip:AddDoubleLine("Parry",format("%.2f",parry) .. "%",1,1,1,  1,1,1)
				GameTooltip:AddDoubleLine("Block",format("%.2f",block) .. "%",1,1,1,  1,1,1)
				GameTooltip:Show()
			end
		end)
		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	--------
	-- Bags
	--------

	if db.bags then
		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text = Stat:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.bags, Text)

		local Profit	= 0
		local Spent		= 0
		local OldMoney	= 0
		local myPlayerRealm = GetRealmName();
		
		
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
			local Change = NewMoney-OldMoney -- Positive if we gain money
			
			if OldMoney>NewMoney then		-- Lost Money
				Spent = Spent - Change
			else							-- Gained Money
				Profit = Profit + Change
			end
			
			self:SetAllPoints(Text)

			local myPlayerName  = UnitName("player")				
			if not BasicDB then BasicDB = {} end
			if not BasicDB.gold then BasicDB.gold = {} end
			if not BasicDB.gold[myPlayerRealm] then BasicDB.gold[myPlayerRealm]={} end
			BasicDB.gold[myPlayerRealm][myPlayerName] = GetMoney()	
				
			OldMoney = NewMoney	
				
		end

		Stat:RegisterEvent("PLAYER_MONEY")
		Stat:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
		Stat:RegisterEvent("SEND_MAIL_COD_CHANGED")
		Stat:RegisterEvent("PLAYER_TRADE_MONEY")
		Stat:RegisterEvent("TRADE_MONEY_CHANGED")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:RegisterEvent("BAG_UPDATE")
		
		Stat:SetScript('OnMouseDown', 
			function()
				if db.bag ~= true then
					ToggleAllBags()
				else
					ToggleBag(0)
				end
			end
		)
		Stat:SetScript('OnEvent', OnEvent)	
		Stat:SetScript("OnEnter", function(self)
			if not InCombatLockdown() then
				local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
				GameTooltip:SetOwner(panel, anchor, xoff, yoff)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Gold")
				GameTooltip:AddLine' '			
				GameTooltip:AddLine("This Session: ")				
				GameTooltip:AddDoubleLine("Earned:", formatMoney(Profit), 1, 1, 1, 1, 1, 1)
				GameTooltip:AddDoubleLine("Spent:", formatMoney(Spent), 1, 1, 1, 1, 1, 1)
				if Profit < Spent then
					GameTooltip:AddDoubleLine("Deficit:", formatMoney(Profit-Spent), 1, 0, 0, 1, 1, 1)
				elseif (Profit-Spent)>0 then
					GameTooltip:AddDoubleLine("Profit:", formatMoney(Profit-Spent), 0, 1, 0, 1, 1, 1)
				end				
				GameTooltip:AddDoubleLine("Total:", formatMoney(OldMoney), 1, 1, 1, 1, 1, 1)
				GameTooltip:AddLine' '
				
				local totalGold = 0				
				GameTooltip:AddLine("Character's: ")			
				local thisRealmList = BasicDB.gold[myPlayerRealm];
				for k,v in pairs(thisRealmList) do
					GameTooltip:AddDoubleLine(k, formatMoney(v), 1, 1, 1, 1, 1, 1)
					totalGold=totalGold+v;
				end  
				GameTooltip:AddLine' '
				GameTooltip:AddLine("Server:")
				GameTooltip:AddDoubleLine("Total: ", formatMoney(totalGold), 1, 1, 1, 1, 1, 1)

				for i = 1, GetNumWatchedTokens() do
					local name, count, extraCurrencyType, icon, itemID = GetBackpackCurrencyInfo(i)
					if name and i == 1 then
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine(CURRENCY..":")
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
			local myPlayerRealm = GetRealmName();
			local myPlayerName  = UnitName("player");
			
			BasicDB.gold = {}
			BasicDB.gold[myPlayerRealm]={}
			BasicDB.gold[myPlayerRealm][myPlayerName] = GetMoney();
		end
		SLASH_RESETGOLD1 = "/resetgold"
		SlashCmdList["RESETGOLD"] = RESETGOLD	

	end

	----------------
	-- Battleground
	----------------
	if db.battleground == true then 

		--Map IDs
		local WSG = 443
		local TP = 626
		local AV = 401
		local SOTA = 512
		local IOC = 540
		local EOTS = 482
		local TBFG = 736
		local AB = 461

		local bgframe = BGPanel
		bgframe:SetScript('OnEnter', function(self)
			local numScores = GetNumBattlefieldScores()
			for i=1, numScores do
				local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
				if ( name ) then
					if ( name == UnitName('player') ) then
						GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 0, 4)
						GameTooltip:ClearLines()
						GameTooltip:SetPoint('BOTTOM', self, 'TOP', 0, 1)
						GameTooltip:ClearLines()
						GameTooltip:AddLine("Stats for : "..hexa..name..hexb)
						GameTooltip:AddLine' '
						GameTooltip:AddDoubleLine("Killing Blows:", killingBlows,1,1,1)
						GameTooltip:AddDoubleLine("Honorable Kills:", honorableKills,1,1,1)
						GameTooltip:AddDoubleLine("Deaths:", deaths,1,1,1)
						GameTooltip:AddDoubleLine("Honor Gained:", format('%d', honorGained),1,1,1)
						GameTooltip:AddDoubleLine("Damage Done:", damageDone,1,1,1)
						GameTooltip:AddDoubleLine("Healing Done:", healingDone,1,1,1)
						--Add extra statistics to watch based on what BG you are in.
						if curmapid == WSG or curmapid == TP then 
							GameTooltip:AddDoubleLine("Flags Captured:",GetBattlefieldStatData(i, 1),1,1,1)
							GameTooltip:AddDoubleLine("Flags Returned:",GetBattlefieldStatData(i, 2),1,1,1)
						elseif curmapid == EOTS then
							GameTooltip:AddDoubleLine("Flags Captured:",GetBattlefieldStatData(i, 1),1,1,1)
						elseif curmapid == AV then
							GameTooltip:AddDoubleLine("Graveyards Assaulted:",GetBattlefieldStatData(i, 1),1,1,1)
							GameTooltip:AddDoubleLine("Graveyards Defended:",GetBattlefieldStatData(i, 2),1,1,1)
							GameTooltip:AddDoubleLine("Towers Assaulted:",GetBattlefieldStatData(i, 3),1,1,1)
							GameTooltip:AddDoubleLine("Towers Defended:",GetBattlefieldStatData(i, 4),1,1,1)
						elseif curmapid == SOTA then
							GameTooltip:AddDoubleLine("Demolishers Destroyed:",GetBattlefieldStatData(i, 1),1,1,1)
							GameTooltip:AddDoubleLine("Gates Destroyed:",GetBattlefieldStatData(i, 2),1,1,1)
						elseif curmapid == IOC or curmapid == TBFG or curmapid == AB then
							GameTooltip:AddDoubleLine("Bases Assaulted:",GetBattlefieldStatData(i, 1),1,1,1)
							GameTooltip:AddDoubleLine("Bases Defended:",GetBattlefieldStatData(i, 2),1,1,1)
						end					
						GameTooltip:Show()
					end
				end
			end
		end) 
		bgframe:SetScript('OnLeave', function(self) GameTooltip:Hide() end)

		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)

		local Text1  = BGPanel:CreateFontString(nil, 'OVERLAY')
		Text1:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		Text1:SetPoint('LEFT', BGPanel, 30, 0)
		Text1:SetHeight(Datapanel:GetHeight())

		local Text2  = BGPanel:CreateFontString(nil, 'OVERLAY')
		Text2:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		Text2:SetPoint('CENTER', BGPanel, 0, 0)
		Text2:SetHeight(Datapanel:GetHeight())

		local Text3  = BGPanel:CreateFontString(nil, 'OVERLAY')
		Text3:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		Text3:SetPoint('RIGHT', BGPanel, -30, 0)
		Text3:SetHeight(Datapanel:GetHeight())

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
						dmgtxt = ("Healing : "..hexa..healingDone..hexb)
					else
						dmgtxt = ("Damage : "..hexa..damageDone..hexb)
					end
					if ( name ) then
						if ( name == PLAYER_NAME ) then
							Text2:SetText("Honor : "..hexa..format('%d', honorGained)..hexb)
							Text1:SetText(dmgtxt)
							Text3:SetText("Killing Blows : "..hexa..killingBlows..hexb)
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
					bgframe:Show()
					StatPanelLeft:Hide()
				else
					Text1:SetText('')
					Text2:SetText('')
					Text3:SetText('')
					bgframe:Hide()
					StatPanelLeft:Show()
				end
			end
		end

		Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
		Stat:SetScript('OnEvent', OnEvent)
		Stat:SetScript('OnUpdate', Update)
		Update(Stat, 10)
	end

	----------------
	-- Call To Arms
	----------------
	if db.calltoarms then
		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata("MEDIUM")
		Stat:SetFrameLevel(3)

		local Text  = Stat:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.calltoarms, Text)
		
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
			if InCombatLockdown() then return end
		
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
		
		Stat:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
		Stat:RegisterEvent("PLAYER_LOGIN")
		Stat:SetScript("OnEvent", OnEvent)
		Stat:SetScript("OnMouseDown", function(self, btn)
			if btn == "LeftButton" then
				ToggleLFDParentFrame(1)
			elseif btn == "RightButton" then
				TogglePVPUI(1)
			end
		end)		
		Stat:SetScript("OnEnter", OnEnter)
		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end

	---------------
	-- Coordinates
	---------------
	if db.coords then
		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text = Stat:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.coords, Text)

		local function Update(self)
		local px,py=GetPlayerMapPosition("player")
			Text:SetText(format(hexa.."Loc: "..hexb.."%i , %i",px*100,py*100))
		end

		Stat:SetScript("OnUpdate", Update)
		Update(Stat, 10)
	end

	---------------------
	-- Damage Per Second
	---------------------
	if db.dps_text then
		local events = {SWING_DAMAGE = true, RANGE_DAMAGE = true, SPELL_DAMAGE = true, SPELL_PERIODIC_DAMAGE = true, DAMAGE_SHIELD = true, DAMAGE_SPLIT = true, SPELL_EXTRA_ATTACKS = true}
		local DPS_FEED = CreateFrame('Frame', nil, Datapanel)
		local player_id = UnitGUID('player')
		local dmg_total, last_dmg_amount = 0, 0
		local cmbt_time = 0

		local pet_id = UnitGUID('pet')
		 
		local dText = DPS_FEED:CreateFontString(nil, 'OVERLAY')
		dText:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		dText:SetText("DPS: ", '0')

		self:PlacePlugin(db.dps_text, dText)

		DPS_FEED:EnableMouse(true)
		DPS_FEED:SetFrameStrata('BACKGROUND')
		DPS_FEED:SetFrameLevel(3)
		DPS_FEED:SetHeight(20)
		DPS_FEED:SetWidth(100)
		DPS_FEED:SetAllPoints(dText)

		DPS_FEED:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
		DPS_FEED:RegisterEvent('PLAYER_LOGIN')

		DPS_FEED:SetScript('OnUpdate', function(self, elap)
			if UnitAffectingCombat('player') then
				cmbt_time = cmbt_time + elap
			end
		   
			dText:SetText(getDPS())
		end)
		 
		function DPS_FEED:PLAYER_LOGIN()
			DPS_FEED:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
			DPS_FEED:RegisterEvent('PLAYER_REGEN_ENABLED')
			DPS_FEED:RegisterEvent('PLAYER_REGEN_DISABLED')
			DPS_FEED:RegisterEvent('UNIT_PET')
			player_id = UnitGUID('player')
			DPS_FEED:UnregisterEvent('PLAYER_LOGIN')
		end
		 
		function DPS_FEED:UNIT_PET(unit)
			if unit == 'player' then
				pet_id = UnitGUID('pet')
			end
		end
		
		-- handler for the combat log. used http://www.wowwiki.com/API_COMBAT_LOG_EVENT for api
		function DPS_FEED:COMBAT_LOG_EVENT_UNFILTERED(...)		   
			-- filter for events we only care about. i.e heals
			if not events[select(2, ...)] then return end

			-- only use events from the player
			local id = select(4, ...)
			   
			if id == player_id or id == pet_id then
				if select(2, ...) == "SWING_DAMAGE" then
					if TOC_VERSION < 40200 then
						last_dmg_amount = select(10, ...)
					else
						last_dmg_amount = select(12, ...)
					end
				else
					if TOC_VERSION < 40200 then
						last_dmg_amount = select(13, ...)
					else
						last_dmg_amount = select(15, ...)
					end
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

		function DPS_FEED:PLAYER_REGEN_ENABLED()
			dText:SetText(getDPS())
		end
		
		function DPS_FEED:PLAYER_REGEN_DISABLED()
			cmbt_time = 0
			dmg_total = 0
			last_dmg_amount = 0
		end
		 
		DPS_FEED:SetScript('OnMouseDown', function (self, button, down)
			cmbt_time = 0
			dmg_total = 0
			last_dmg_amount = 0
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


		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata("MEDIUM")
		Stat:SetFrameLevel(3)

		local Text  = Stat:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.dur, Text)

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

		Stat:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
		Stat:RegisterEvent("MERCHANT_SHOW")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
		Stat:SetScript("OnEvent", OnEvent)
		Stat:SetScript("OnEnter", function(self)
			if not InCombatLockdown() then
				local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
				GameTooltip:SetOwner(panel, anchor, xoff, yoff)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Durability")
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
			GameTooltip:AddLine("|cffeda55fClick|r to Show Character Panel")
			GameTooltip:Show()
			end
		end)
		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)

	end

	-----------
	-- FRIEND
	-----------

	if db.friends then


		local _, _, _, broadcastText = BNGetInfo();
		
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
				self.editBox:SetText(broadcastText)
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

		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata("MEDIUM")
		Stat:SetFrameLevel(3)

		local Text  = Stat:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.friends, Text)

		local menuFrame = CreateFrame("Frame", "FriendRightClickMenu", UIParent, "UIDropDownMenuTemplate")
		local menuList = {
			{ text = OPTIONS_MENU, isTitle = true,notCheckable=true},
			{ text = INVITE, hasArrow = true,notCheckable=true, },
			{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true,notCheckable=true, },			
			{ text = PLAYER_STATUS, hasArrow = true, notCheckable=true,
				menuList = {
					{ text = "|cff2BC226"..AVAILABLE.."|r", notCheckable=true, func = function() if IsChatAFK() then SendChatMessage("", "AFK") elseif IsChatDND() then SendChatMessage("", "DND") end end },
					{ text = "|cffE7E716"..DND.."|r", notCheckable=true, func = function() if not IsChatDND() then SendChatMessage("", "DND") end end },
					{ text = "|cffFF0000"..AFK.."|r", notCheckable=true, func = function() if not IsChatAFK() then SendChatMessage("", "AFK") end end },
				},
			},
			{ text = BN_BROADCAST_TOOLTIP, notCheckable=true, func = function() StaticPopup_Show("SET_BN_BROADCAST") end },
		}

		local function GetTableIndex(table, fieldIndex, value)
			for k,v in ipairs(table) do
				if v[fieldIndex] == value then return k end
			end
			return -1
		end

		local function inviteClick(self, arg1, arg2, checked)
			menuFrame:Hide()
			if type(arg1) ~= 'number' then
				InviteUnit(arg1)
			else
				BNInviteFriend(arg1);
			end
		end

		local function whisperClick(self,name,bnet)
			menuFrame:Hide()
			if bnet then
				ChatFrame_SendSmartTell(name)
			else
				SetItemRef( "player:"..name, ("|Hplayer:%1$s|h[%1$s]|h"):format(name), "LeftButton" )
			end
		end

		
		local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r"
		local clientLevelNameString = "%s (|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s) |cff%02x%02x%02x%s|r"
		local levelNameClassString = "|cff%02x%02x%02x%d|r %s%s%s"
		local worldOfWarcraftString = "World of Warcraft"
		local battleNetString = "Battle.NET"
		local wowString = "WoW"
		local totalOnlineString = "Online: " .. "%s/%s"
		local tthead, ttsubh, ttoff = {r=0.4, g=0.78, b=1}, {r=0.75, g=0.9, b=1}, {r=.3,g=1,b=.3}
		local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
		local displayString = string.join("", hexa.."%s "..hexb, "|cffffffff", "%d|r")
		local statusTable = { "|cffff0000[AFK]|r", "|cffff0000[DND]|r", "" }
		local groupedTable = { "|cffaaaaaa*|r", "" } 
		local friendTable, BNTable = {}, {}
		local totalOnline, BNTotalOnline = 0, 0		

		local function BuildFriendTable(total)
			totalOnline = 0
			wipe(friendTable)
			local name, level, class, area, connected, status, note
			for i = 1, total do
				name, level, class, area, connected, status, note = GetFriendInfo(i)
				for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
				
				if status == "<"..AFK..">" then
					status = "|cffff0000[AFK]|r"
				elseif status == "<"..DND..">" then
					status = "|cffff0000[DND]|r"
				end
				
				friendTable[i] = { name, level, class, area, connected, status, note }
				if connected then totalOnline = totalOnline + 1 end
			end
		end

		local function UpdateFriendTable(total)
			totalOnline = 0
			local name, level, class, area, connected, status, note
			for i = 1, #friendTable do
				name, level, class, area, connected, status, note = GetFriendInfo(i)
				for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
				
				-- get the correct index in our table		
				local index = GetTableIndex(friendTable, 1, name)
				-- we cannot find a friend in our table, so rebuild it
				if index == -1 then
					BuildFriendTable(total)
					break
				end
				-- update on-line status for all members
				friendTable[index][5] = connected
				-- update information only for on-line members
				if connected then
					friendTable[index][2] = level
					friendTable[index][3] = class
					friendTable[index][4] = area
					friendTable[index][6] = status
					friendTable[index][7] = note
					totalOnline = totalOnline + 1
				end
			end
		end

		local function BuildBNTable(total)
			BNTotalOnline = 0
			wipe(BNTable)
			
			for i = 1, total do
				local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(i)
				local hasFocus, _, _, realmName, realmID, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(presenceID)

				for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
				
				BNTable[i] = { presenceID, presenceName, battleTag, toonName, toonID, client, isOnline, isAFK, isDND, noteText, realmName, faction, race, class, zoneName, level }
				if isOnline then BNTotalOnline = BNTotalOnline + 1 end
			end
		end

		local function UpdateBNTable(total)
			BNTotalOnline = 0
			for i = 1, #BNTable do
				-- get guild roster information
				local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(i)
				local hasFocus, _, _, realmName, realmID, faction, race, class, guild, zoneName, level, gameText = BNGetToonInfo(presenceID)
				
				for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
				
				-- get the correct index in our table		
				local index = GetTableIndex(BNTable, 1, presenceID)
				-- we cannot find a BN member in our table, so rebuild it
				if index == -1 then
					BuildBNTable(total)
					return
				end
				-- update on-line status for all members
				BNTable[index][7] = isOnline
				-- update information only for on-line members
				if isOnline then
					BNTable[index][2] = presenceName
					BNTable[index][3] = battleTag
					BNTable[index][4] = toonName
					BNTable[index][5] = toonID
					BNTable[index][6] = client
					BNTable[index][8] = isAFK
					BNTable[index][9] = isDND
					BNTable[index][10] = noteText
					BNTable[index][11] = realmName
					BNTable[index][12] = faction
					BNTable[index][13] = race
					BNTable[index][14] = class
					BNTable[index][15] = zoneName
					BNTable[index][16] = level
					
					BNTotalOnline = BNTotalOnline + 1
				end
			end
		end

		Stat:SetScript("OnMouseUp", function(self, btn)
			if btn ~= "RightButton" then return end
			
			GameTooltip:Hide()
			
			local menuCountWhispers = 0
			local menuCountInvites = 0
			local classc, levelc
			
			menuList[2].menuList = {}
			menuList[3].menuList = {}
			
			if totalOnline > 0 then
				for i = 1, #friendTable do
					if (friendTable[i][5]) then
						menuCountInvites = menuCountInvites + 1
						menuCountWhispers = menuCountWhispers + 1

						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[friendTable[i][3]], GetQuestDifficultyColor(friendTable[i][2])
						if classc == nil then classc = GetQuestDifficultyColor(friendTable[i][2]) end

						menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,friendTable[i][2],classc.r*255,classc.g*255,classc.b*255,friendTable[i][1]), arg1 = friendTable[i][1],notCheckable=true, func = inviteClick}
						menuList[3].menuList[menuCountWhispers] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,friendTable[i][2],classc.r*255,classc.g*255,classc.b*255,friendTable[i][1]), arg1 = friendTable[i][1],notCheckable=true, func = whisperClick}
					end
				end
			end
			
			if BNTotalOnline > 0 then
				local realID, grouped
				for i = 1, #BNTable do
					if (BNTable[i][7]) then
						realID = BNTable[i][2]
						menuCountWhispers = menuCountWhispers + 1
						menuList[3].menuList[menuCountWhispers] = {text = realID, arg1 = realID, arg2 = true, notCheckable=true, func = whisperClick}

						if BNTable[i][6] == wowString and UnitFactionGroup("player") == BNTable[i][12] then
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(90)
							if classc == nil then classc = GetQuestDifficultyColor(90) end

							if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then grouped = 1 else grouped = 2 end
							menuCountInvites = menuCountInvites + 1
							menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,BNTable[i][16],classc.r*255,classc.g*255,classc.b*255,BNTable[i][4]), arg1 = BNTable[i][5],notCheckable=true, func = inviteClick}
						end
					end
				end
			end

			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
		end)

		local function Update(self, event)
			if event == "BN_FRIEND_INFO_CHANGED" or "BN_FRIEND_ACCOUNT_ONLINE" or "BN_FRIEND_ACCOUNT_OFFLINE" or "BN_TOON_NAME_UPDATED"
					or "BN_FRIEND_TOON_ONLINE" or "BN_FRIEND_TOON_OFFLINE" or "PLAYER_ENTERING_WORLD" then
				local BNTotal = BNGetNumFriends()
				if BNTotal == #BNTable then
					UpdateBNTable(BNTotal)
				else
					BuildBNTable(BNTotal)
				end
			end
			
			if event == "FRIENDLIST_UPDATE" or "PLAYER_ENTERING_WORLD" then
				local total = GetNumFriends()
				if total == #friendTable then
					UpdateFriendTable(total)
				else
					BuildFriendTable(total)
				end
			end

			Text:SetFormattedText(displayString, "Friends:", totalOnline + BNTotalOnline)
			self:SetAllPoints(Text)
		end

		Stat:SetScript("OnMouseDown", function(self, btn) if btn == "LeftButton" then ToggleFriendsFrame() end end)
		Stat:SetScript("OnEnter", function(self)
			if InCombatLockdown() then return end
				
			local totalonline = totalOnline + BNTotalOnline
			local totalfriends = #friendTable + #BNTable
			local zonec, classc, levelc, realmc, grouped
			if totalonline > 0 then
				local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
				GameTooltip:SetOwner(panel, anchor, xoff, yoff)
				GameTooltip:ClearLines()	
				GameTooltip:AddDoubleLine(hexa..PLAYER_NAME.."'s"..hexb.." Friends", format(totalOnlineString, totalonline, totalfriends))
				if totalOnline > 0 then
					GameTooltip:AddLine(' ')
					GameTooltip:AddLine(worldOfWarcraftString)
					for i = 1, #friendTable do
						if friendTable[i][5] then
							if GetRealZoneText() == friendTable[i][4] then zonec = activezone else zonec = inactivezone end
							classc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[friendTable[i][3]]
							if classc == nil then classc = GetQuestDifficultyColor(friendTable[i][2]) end
							
							if friendTable[i][2] ~= '' then
								levelc = GetQuestDifficultyColor(friendTable[i][2])
							else
								levelc = RAID_CLASS_COLORS["PRIEST"]
								classc = RAID_CLASS_COLORS["PRIEST"]
							end
							
							if UnitInParty(friendTable[i][1]) or UnitInRaid(friendTable[i][1]) then grouped = 1 else grouped = 2 end
							GameTooltip:AddDoubleLine(format(levelNameClassString,levelc.r*255,levelc.g*255,levelc.b*255,friendTable[i][2],friendTable[i][1],groupedTable[grouped]," "..friendTable[i][6]),friendTable[i][4],classc.r,classc.g,classc.b,zonec.r,zonec.g,zonec.b)
						end
					end
				end
				if BNTotalOnline > 0 then
					GameTooltip:AddLine(' ')
					GameTooltip:AddLine(battleNetString)

					local status = 0
					for i = 1, #BNTable do
						if BNTable[i][7] then
							if BNTable[i][6] == wowString then
								if (BNTable[i][8] == true) then status = 1 elseif (BNTable[i][9] == true) then status = 2 else status = 3 end
			
								classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(90)
								if classc == nil then classc = GetQuestDifficultyColor(90) end
								
								if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then grouped = 1 else grouped = 2 end
								GameTooltip:AddDoubleLine(format(clientLevelNameString, BNTable[i][6],levelc.r*255,levelc.g*255,levelc.b*255,BNTable[i][16],classc.r*255,classc.g*255,classc.b*255,BNTable[i][4],groupedTable[grouped], 255, 0, 0, statusTable[status]),BNTable[i][2],238,238,238,238,238,238)
								if IsShiftKeyDown() then
									if GetRealZoneText() == BNTable[i][15] then zonec = activezone else zonec = inactivezone end
									if GetRealmName() == BNTable[i][11] then realmc = activezone else realmc = inactivezone end
									GameTooltip:AddDoubleLine("  "..BNTable[i][15], BNTable[i][11], zonec.r, zonec.g, zonec.b, realmc.r, realmc.g, realmc.b)
								end
							else
								GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][6].." ("..BNTable[i][4]..")|r", "|cffeeeeee"..BNTable[i][2].."|r")
							end
						end
					end
				end
				GameTooltip:Show()
			else 
				GameTooltip:Hide() 
			end
		end)

		Stat:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE")
		Stat:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE")
		Stat:RegisterEvent("BN_FRIEND_INFO_CHANGED")
		Stat:RegisterEvent("BN_FRIEND_TOON_ONLINE")
		Stat:RegisterEvent("BN_FRIEND_TOON_OFFLINE")
		Stat:RegisterEvent("BN_TOON_NAME_UPDATED")
		Stat:RegisterEvent("FRIENDLIST_UPDATE")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")

		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
		Stat:SetScript("OnEvent", Update)	
	end
	

	---------
	-- Guild
	---------
	if db.guild then

		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata("MEDIUM")
		Stat:SetFrameLevel(3)

		local Text  = Stat:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.guild, Text)

		local tthead, ttsubh, ttoff = {r=0.4, g=0.78, b=1}, {r=0.75, g=0.9, b=1}, {r=.3,g=1,b=.3}
		local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
		local displayString = string.join("", hexa.."%s: "..hexb, "|cffffffff", "%d|r")
		local guildInfoString0 = "%s"
		local guildInfoString1 = "%s [%d]"
		local guildInfoString2 = "%s: %d/%d"
		local guildMotDString = "%s |cffaaaaaa- |cffffffff%s"
		local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r %s"
		local levelNameStatusString = "|cff%02x%02x%02x%d|r %s %s"
		local nameRankString = "%s |cff999999-|cffffffff %s"
		local noteString = "  '%s'"
		local officerNoteString = "  o: '%s'"

		local guildTable, guildXP, guildMotD = {}, {}, ""
		local totalOnline = 0


		local function BuildGuildTable()
			totalOnline = 0
			wipe(guildTable)
			local _, name, rank, level, zone, note, officernote, connected, status, class, isMobile
			for i = 1, GetNumGuildMembers() do
				name, rank, _, level, _, zone, note, officernote, connected, status, class, _, _, isMobile = GetGuildRosterInfo(i)
				
				if status == 1 then
					status = "|cffff0000["..AFK.."]|r"
				elseif status == 2 then
					status = "|cffff0000["..DND.."]|r" 
				else
					status = ""
				end
				
				guildTable[i] = { name, rank, level, zone, note, officernote, connected, status, class, isMobile }
				if connected then totalOnline = totalOnline + 1 end
			end
			table.sort(guildTable, function(a, b)
				if a and b then
					return a[1] < b[1]
				end
			end)
		end

		local function UpdateGuildXP()
			local currentXP, remainingXP = UnitGetGuildXP("player")
			local nextLevelXP = currentXP + remainingXP
			
			-- prevent 4.3 division / 0
			if nextLevelXP == 0 or maxDailyXP == 0 then return end
			
			local percentTotal = tostring(math.ceil((currentXP / nextLevelXP) * 100))
			
			guildXP[0] = { currentXP, nextLevelXP, percentTotal }
		end

		local function UpdateGuildMessage()
			guildMotD = GetGuildRosterMOTD()
		end

		local function Update(self, event, ...)
			if event == "PLAYER_ENTERING_WORLD" then
				self:UnregisterEvent("PLAYER_ENTERING_WORLD")
				if IsInGuild() and not GuildFrame then LoadAddOn("Blizzard_GuildUI") end
			end
			
			if IsInGuild() then
				totalOnline = 0
				local name, rank, level, zone, note, officernote, connected, status, class
				for i = 1, GetNumGuildMembers() do
					local connected = select(9, GetGuildRosterInfo(i))
					if connected then totalOnline = totalOnline + 1 end
				end	
				Text:SetFormattedText(displayString, "Guild", totalOnline)
			else
				Text:SetText("No Guild")
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

		Stat:SetScript("OnMouseUp", function(self, btn)
			if btn ~= "RightButton" or not IsInGuild() then return end
			
			GameTooltip:Hide()

			local classc, levelc, grouped
			local menuCountWhispers = 0
			local menuCountInvites = 0

			menuList[2].menuList = {}
			menuList[3].menuList = {}

			for i = 1, #guildTable do
				if (guildTable[i][7] and guildTable[i][1] ~= nDatamyname) then
					local classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[guildTable[i][9]], GetQuestDifficultyColor(guildTable[i][3])

					if UnitInParty(guildTable[i][1]) or UnitInRaid(guildTable[i][1]) then
						grouped = "|cffaaaaaa*|r"
					else
						grouped = ""
						if not guildTable[i][10] then
							menuCountInvites = menuCountInvites + 1
							menuList[2].menuList[menuCountInvites] = {text = string.format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, guildTable[i][3], classc.r*255,classc.g*255,classc.b*255, guildTable[i][1], ""), arg1 = guildTable[i][1],notCheckable=true, func = inviteClick}
						end
					end
					menuCountWhispers = menuCountWhispers + 1
					menuList[3].menuList[menuCountWhispers] = {text = string.format(levelNameString, levelc.r*255,levelc.g*255,levelc.b*255, guildTable[i][3], classc.r*255,classc.g*255,classc.b*255, guildTable[i][1], grouped), arg1 = guildTable[i][1],notCheckable=true, func = whisperClick}
				end
			end

			EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
		end)

		Stat:SetScript("OnEnter", function(self)
			if InCombatLockdown() or not IsInGuild() then return end
			
			GuildRoster()
			UpdateGuildMessage()
			BuildGuildTable()
				
			local name, rank, level, zone, note, officernote, connected, status, class, isMobile
			local zonec, classc, levelc
			local online = totalOnline
			local guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
			local GuildInfo = GetGuildInfo('player')
			local GuildLevel = GetGuildLevel()
				
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Guild")		
			if GuildInfo then
				GameTooltip:AddDoubleLine(string.format(guildInfoString0, GuildInfo), string.format(guildInfoString1, "Guild Level:", GuildLevel),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)		
			end
			GameTooltip:AddLine' '
			if GuildLevel then
				GameTooltip:AddLine( string.format(guildInfoString2, "Member's Online", online, #guildTable),tthead.r,tthead.g,tthead.b)		
			end
			
			if guildMotD ~= "" then GameTooltip:AddLine(' ') 
				GameTooltip:AddLine(string.format(guildMotDString, GUILD_MOTD, guildMotD), ttsubh.r, ttsubh.g, ttsubh.b, 1) 
			end
			
			local col = RGBToHex(ttsubh.r, ttsubh.g, ttsubh.b)
			GameTooltip:AddLine' '
			if GuildLevel and GuildLevel ~= 25 then

				if guildXP[0] then
					local currentXP, nextLevelXP, percentTotal = unpack(guildXP[0])
					
					GameTooltip:AddLine(string.format(col..GUILD_EXPERIENCE_CURRENT, "|r |cFFFFFFFF"..ShortValue(currentXP), ShortValue(nextLevelXP), percentTotal))
				end
			end
			
			local _, _, standingID, barMin, barMax, barValue = GetGuildFactionInfo()
			if standingID ~= 8 then -- Not Max Rep
				barMax = barMax - barMin
				barValue = barValue - barMin
				barMin = 0
				GameTooltip:AddLine(string.format("%s:|r |cFFFFFFFF%s/%s (%s%%)",col..COMBAT_FACTION_CHANGE, ShortValue(barValue), ShortValue(barMax), math.ceil((barValue / barMax) * 100)))
			end
			
			if online > 1 then
				GameTooltip:AddLine(' ')
				for i = 1, #guildTable do
					if online <= 1 then
						if online > 1 then GameTooltip:AddLine(format("+ %d More...", online - modules.Guild.maxguild),ttsubh.r,ttsubh.g,ttsubh.b) end
						break
					end

					name, rank, level, zone, note, officernote, connected, status, class, isMobile = unpack(guildTable[i])
					if connected and name ~= nDatamyname then
						if GetRealZoneText() == zone then zonec = activezone else zonec = inactivezone end
						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)
						
						if isMobile then zone = "" end
						
						if IsShiftKeyDown() then
							GameTooltip:AddDoubleLine(string.format(nameRankString, name, rank), zone, classc.r, classc.g, classc.b, zonec.r, zonec.g, zonec.b)
							if note ~= "" then GameTooltip:AddLine(string.format(noteString, note), ttsubh.r, ttsubh.g, ttsubh.b, 1) end
							if officernote ~= "" then GameTooltip:AddLine(string.format(officerNoteString, officernote), ttoff.r, ttoff.g, ttoff.b ,1) end
						else
							GameTooltip:AddDoubleLine(string.format(levelNameStatusString, levelc.r*255, levelc.g*255, levelc.b*255, level, name, status), zone, classc.r,classc.g,classc.b, zonec.r,zonec.g,zonec.b)
						end
					end
				end
			end
			GameTooltip:AddLine' '
			GameTooltip:AddLine("|cffeda55fLeft Click|r to Open Guild Roster")
			GameTooltip:AddLine("|cffeda55fHold Shift & Mouseover|r to See Guild and Officer Note's")
			GameTooltip:AddLine("|cffeda55fRight Click|r to open Options Menu")		
			GameTooltip:Show()
		end)

		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
		Stat:SetScript("OnMouseDown", function(self, btn)
			if btn ~= "LeftButton" then return end
			ToggleGuildFrame()
		end)

		Stat:RegisterEvent("GUILD_ROSTER_SHOW")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:RegisterEvent("GUILD_ROSTER_UPDATE")
		Stat:RegisterEvent("PLAYER_GUILD_UPDATE")
		Stat:SetScript("OnEvent", Update)
	end

	----------------
	-- Player Haste
	----------------
	if db.haste then
		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = Stat:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.haste, Text)

		local int = 1

		local function Update(self, t)
			local spellhaste = GetCombatRating(CR_HASTE_SPELL)
			local rangedhaste = GetCombatRating(CR_HASTE_RANGED)
			local attackhaste = GetCombatRating(CR_HASTE_MELEE)
			
			if attackhaste > spellhaste and select(2, UnitClass("Player")) ~= "HUNTER" then
				haste = attackhaste
			elseif select(2, UnitClass("Player")) == "HUNTER" then
				haste = rangedhaste
			else
				haste = spellhaste
			end
			
			int = int - t
			if int < 0 then
				Text:SetText(hexa.."Haste: "..hexb..haste)
				int = 1
			end     
		end

		Stat:SetScript("OnUpdate", Update)
		Update(Stat, 10)
	end

	---------------
	-- Professions
	---------------
	if db.pro then

		local Stat = CreateFrame('Button', nil, Datapanel)
		Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)
		Stat:EnableMouse(true)
		Stat.tooltip = false

		local Text = Stat:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.pro, Text)

		local function Update(self)
			for i = 1, select("#", GetProfessions()) do
				local v = select(i, GetProfessions());
				if v ~= nil then
					local name, texture, rank, maxRank = GetProfessionInfo(v)
					Text:SetFormattedText(hexa.."Professions"..hexb)
				end
			end
			self:SetAllPoints(Text)
		end

		Stat:SetScript('OnEnter', function()
			if InCombatLockdown() then return end
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


		Stat:SetScript("OnClick",function(self,btn)
			local prof1, prof2 = GetProfessions()
			if btn == "LeftButton" then
				if prof1 then
					if (GetProfessionInfo(prof1) == ('Herbalism')) then
						print('|cff00B4FFBasic|rUI: |cffFF0000Herbalism has no options!|r')
					elseif(GetProfessionInfo(prof1) == ('Skinning')) then
						print('|cff00B4FFBasic|rUI: |cffFF0000Skinning has no options!|r')
					elseif(GetProfessionInfo(prof1) == ('Mining')) then
						CastSpellByName("Smelting")
					else	
						CastSpellByName((GetProfessionInfo(prof1)))
					end
				else
					print('|cff00B4FFBasic|rUI: |cffFF0000No Profession Found!|r')
				end
			elseif btn == 'MiddleButton' then
				ToggleSpellBook(BOOKTYPE_PROFESSION);	
			elseif btn == "RightButton" then
				if prof2 then
					if (GetProfessionInfo(prof2) == ('Herbalism')) then
						print('|cff00B4FFBasic|rUI: |cffFF0000Herbalism has no options!|r')
					elseif(GetProfessionInfo(prof2) == ('Skinning')) then
						print('|cff00B4FFBasic|rUI: |cffFF0000Skinning has no options!|r')
					elseif(GetProfessionInfo(prof2) == ('Mining')) then
						CastSpellByName("Smelting")
					else
						CastSpellByName((GetProfessionInfo(prof2)))
					end
				else
					print('|cff00B4FFBasic|rUI: |cffFF0000No Profession Found!|r')
				end
			end
		end)


		Stat:RegisterForClicks("AnyUp")
		Stat:SetScript('OnUpdate', Update)
		Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)
	end


	-----------
	-- Recount
	-----------
	if db.recount then 

		local RecountDPS = CreateFrame('Frame', nil, Datapanel)
		RecountDPS:EnableMouse(true)
		RecountDPS:SetFrameStrata("MEDIUM")
		RecountDPS:SetFrameLevel(3)

		local Text  = RecountDPS:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.recount, Text)
		RecountDPS:SetAllPoints(Text)

		function OnEvent(self, event, ...)
			if event == "PLAYER_LOGIN" then
				if IsAddOnLoaded("Recount") then
					RecountDPS:RegisterEvent("PLAYER_REGEN_ENABLED")
					RecountDPS:RegisterEvent("PLAYER_REGEN_DISABLED")
					PLAYER_NAME = UnitName("player")
					currentFightDPS = 0
				else
					return
				end
				RecountDPS:UnregisterEvent("PLAYER_LOGIN")
			elseif event == "PLAYER_ENTERING_WORLD" then
				self.updateDPS()
				RecountDPS:UnregisterEvent("PLAYER_ENTERING_WORLD")
			end
		end

		function RecountDPS:RecountHook_UpdateText()
			self:updateDPS()
		end

		function RecountDPS:updateDPS()
			Text:SetText(hexa.."DPS: "..hexb.. RecountDPS.getDPS() .. "|r")
		end

		function RecountDPS:getDPS()
			if not IsAddOnLoaded("Recount") then return "N/A" end
			if db.recountraiddps == true then
				-- show raid dps
				_, dps = RecountDPS:getRaidValuePerSecond(Recount.db.profile.CurDataSet)
				return dps
			else
				return RecountDPS.getValuePerSecond()
			end
		end

		-- quick dps calculation from recount's data
		function RecountDPS:getValuePerSecond()
			local _, dps = Recount:MergedPetDamageDPS(Recount.db2.combatants[PLAYER_NAME], Recount.db.profile.CurDataSet)
			return math.floor(10 * dps + 0.5) / 10
		end

		function RecountDPS:getRaidValuePerSecond(tablename)
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
		RecountDPS:RegisterEvent("PLAYER_LOGIN")
		RecountDPS:RegisterEvent("PLAYER_ENTERING_WORLD")

		-- scripts
		RecountDPS:SetScript("OnEnter", function(self)
			if InCombatLockdown() then return end

			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Damage")
			GameTooltip:AddLine' '		
			if IsAddOnLoaded("Recount") then
				local damage, dps = Recount:MergedPetDamageDPS(Recount.db2.combatants[PLAYER_NAME], Recount.db.profile.CurDataSet)
				local raid_damage, raid_dps = RecountDPS:getRaidValuePerSecond(Recount.db.profile.CurDataSet)
				-- format the number
				dps = math.floor(10 * dps + 0.5) / 10
				GameTooltip:AddLine("Recount")
				GameTooltip:AddDoubleLine("Personal Damage:", damage, 1, 1, 1, 0.8, 0.8, 0.8)
				GameTooltip:AddDoubleLine("Personal DPS:", dps, 1, 1, 1, 0.8, 0.8, 0.8)
				GameTooltip:AddLine(" ")
				GameTooltip:AddDoubleLine("Raid Damage:", raid_damage, 1, 1, 1, 0.8, 0.8, 0.8)
				GameTooltip:AddDoubleLine("Raid DPS:", raid_dps, 1, 1, 1, 0.8, 0.8, 0.8)
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
		RecountDPS:SetScript("OnMouseUp", function(self, button)
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
		RecountDPS:SetScript("OnEvent", OnEvent)
		RecountDPS:SetScript("OnLeave", function() GameTooltip:Hide() end)
		RecountDPS:SetScript("OnUpdate", function(self, t)
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

		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = Stat:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.spec, Text)

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

		local int = 1
		local function Update(self, t)
			int = int - t
			if int > 0 or not GetSpecialization() then return end

			active = GetActiveSpecGroup(false, false)
			Text:SetFormattedText(talentString, hexa..select(2, GetSpecializationInfo(GetSpecialization(false, false, active)))..hexb)
			int = 1

			-- disable script	
			self:SetScript('OnUpdate', nil)
		end


		Stat:SetScript('OnEnter', function(self)
			if InCombatLockdown() then return end

			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)

			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Spec")
			GameTooltip:AddLine' '		
			for i = 1, GetNumSpecGroups() do
				if GetSpecialization(false, false, i) then
					GameTooltip:AddLine(string.join('- ', string.format(talentString, select(2, GetSpecializationInfo(GetSpecialization(false, false, i)))), (i == active and activeString or inactiveString)),1,1,1)
				end
			end
			
			GameTooltip:AddLine' '
			GameTooltip:AddLine("|cffeda55fLeft Click|r to Switch Spec's")		
			GameTooltip:AddLine("|cffeda55fRight Click|r to Open Talent Tree")
			GameTooltip:Show()
		end)

		Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)

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



		Stat:RegisterEvent('PLAYER_ENTERING_WORLD');
		Stat:RegisterEvent('CHARACTER_POINTS_CHANGED');
		Stat:RegisterEvent('PLAYER_TALENT_UPDATE');
		Stat:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
		Stat:RegisterEvent("EQUIPMENT_SETS_CHANGED")
		Stat:SetScript('OnEvent', OnEvent)
		Stat:SetScript('OnUpdate', Update)

		Stat:SetScript("OnMouseDown", function(self, button)
			if button == "LeftButton" then
				SetActiveSpecGroup (active == 1 and 2 or 1)
			elseif button == "RightButton" then
				ToggleTalentFrame()
			end
		end)
	end

	-----------------
	-- Statistics #1
	-----------------
	if db.stat1 then

		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetFrameStrata("BACKGROUND")
		Stat:SetFrameLevel(3)
		Stat:EnableMouse(true)

		local Text  = Stat:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.stat1, Text)

		local format = string.format
		local targetlv, playerlv = UnitLevel("target"), UnitLevel("player")
		local basemisschance, leveldifference, dodge, parry, block
		local chanceString = "%.2f%%"
		local modifierString = string.join("", "%d (+", chanceString, ")")
		local manaRegenString = "%d / %d"
		local displayNumberString = string.join("", "%s", "%d|r")
		local displayFloatString = string.join("", "%s", "%.2f%%|r")
		local spellpwr, avoidance, pwr
		local haste, hasteBonus
		local level = UnitLevel("player")

		local function ShowTooltip(self)
			if InCombatLockdown() then return end
		
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Statistics")
			GameTooltip:AddLine' '		
			
			if Role == "Tank" then
				if targetlv > 1 then
					GameTooltip:AddDoubleLine("Avoidance Breakdown", string.join("", " (", "lvl", " ", targetlv, ")"))
				elseif targetlv == -1 then
					GameTooltip:AddDoubleLine("Avoidance Breakdown", string.join("", " (", "Boss", ")"))
				else
					GameTooltip:AddDoubleLine("Avoidance Breakdown", string.join("", " (", "lvl", " ", playerlv, ")"))
				end
				GameTooltip:AddLine' '
				GameTooltip:AddDoubleLine(DODGE_CHANCE, format(chanceString, dodge),1,1,1)
				GameTooltip:AddDoubleLine(PARRY_CHANCE, format(chanceString, parry),1,1,1)
				GameTooltip:AddDoubleLine(BLOCK_CHANCE, format(chanceString, block),1,1,1)
				GameTooltip:AddDoubleLine(MISS_CHANCE, format(chanceString, basemisschance),1,1,1)
			elseif Role == "Caster" then
				GameTooltip:AddDoubleLine(STAT_HIT_CHANCE, format(modifierString, GetCombatRating(CR_HIT_SPELL), GetCombatRatingBonus(CR_HIT_SPELL)), 1, 1, 1)
				GameTooltip:AddDoubleLine(STAT_HASTE, format(modifierString, GetCombatRating(CR_HASTE_SPELL), GetCombatRatingBonus(CR_HASTE_SPELL)), 1, 1, 1)
				local base, combat = GetManaRegen()
				GameTooltip:AddDoubleLine(MANA_REGEN, format(manaRegenString, base * 5, combat * 5), 1, 1, 1)
			elseif Role == "Melee" then
				local hit =  UNIT_CLASS == "HUNTER" and GetCombatRating(CR_HIT_RANGED) or GetCombatRating(CR_HIT_MELEE)
				local hitBonus =  UNIT_CLASS == "HUNTER" and GetCombatRatingBonus(CR_HIT_RANGED) or GetCombatRatingBonus(CR_HIT_MELEE)
			
				GameTooltip:AddDoubleLine(STAT_HIT_CHANCE, format(modifierString, hit, hitBonus), 1, 1, 1)
				
				local haste = UNIT_CLASS == "HUNTER" and GetCombatRating(CR_HASTE_RANGED) or GetCombatRating(CR_HASTE_MELEE)
				local hasteBonus = UNIT_CLASS == "HUNTER" and GetCombatRatingBonus(CR_HASTE_RANGED) or GetCombatRatingBonus(CR_HASTE_MELEE)
				
				GameTooltip:AddDoubleLine(STAT_HASTE, format(modifierString, haste, hasteBonus), 1, 1, 1)
			end
			
			local masteryspell
			if GetCombatRating(CR_MASTERY) ~= 0 and GetSpecialization() then
				if UNIT_CLASS == "DRUID" then
					if Role == "Melee" then
						masteryspell = select(2, GetSpecializationMasterySpells(GetSpecialization()))
					elseif Role == "Tank" then
						masteryspell = select(1, GetSpecializationMasterySpells(GetSpecialization()))
					else
						masteryspell = GetSpecializationMasterySpells(GetSpecialization())
					end
				else
					masteryspell = GetSpecializationMasterySpells(GetSpecialization())
				end
				


				local masteryName, _, _, _, _, _, _, _, _ = GetSpellInfo(masteryspell)
				if masteryName then
					GameTooltip:AddLine' '
					GameTooltip:AddDoubleLine(masteryName, format(modifierString, GetCombatRating(CR_MASTERY), GetCombatRatingBonus(CR_MASTERY)), 1, 1, 1)
				end
			end
			
			GameTooltip:Show()
		end

		local function UpdateTank(self)
					
			-- the 5 is for base miss chance
			if targetlv == -1 then
				basemisschance = (5 - (3*.2))
				leveldifference = 3
			elseif targetlv > playerlv then
				basemisschance = (5 - ((targetlv - playerlv)*.2))
				leveldifference = (targetlv - playerlv)
			elseif targetlv < playerlv and targetlv > 0 then
				basemisschance = (5 + ((playerlv - targetlv)*.2))
				leveldifference = (targetlv - playerlv)
			else
				basemisschance = 5
				leveldifference = 0
			end
			
			if select(2, UnitRace("player")) == "NightElf" then basemisschance = basemisschance + 2 end
			
			if leveldifference >= 0 then
				dodge = (GetDodgeChance()-leveldifference*.2)
				parry = (GetParryChance()-leveldifference*.2)
				block = (GetBlockChance()-leveldifference*.2)
			else
				dodge = (GetDodgeChance()+abs(leveldifference*.2))
				parry = (GetParryChance()+abs(leveldifference*.2))
				block = (GetBlockChance()+abs(leveldifference*.2))
			end
			
			if dodge <= 0 then dodge = 0 end
			if parry <= 0 then parry = 0 end
			if block <= 0 then block = 0 end
			
			if UNIT_CLASS == "DRUID" then
				parry = 0
				block = 0
			elseif UNIT_CLASS == "DEATHKNIGHT" then
				block = 0
			end
			avoidance = (dodge+parry+block+basemisschance)
			
			Text:SetFormattedText(displayFloatString, hexa.."AVD: "..hexb, avoidance)
			--Setup Tooltip
			self:SetAllPoints(Text)
		end

		local function UpdateCaster(self)
			if GetSpellBonusHealing() > GetSpellBonusDamage(7) then
				spellpwr = GetSpellBonusHealing()
			else
				spellpwr = GetSpellBonusDamage(7)
			end
			
			Text:SetFormattedText(displayNumberString, hexa.."SP: "..hexb, spellpwr)
			--Setup Tooltip
			self:SetAllPoints(Text)
		end

		local function UpdateMelee(self)
			local base, posBuff, negBuff = UnitAttackPower("player");
			local effective = base + posBuff + negBuff;
			local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player");
			local Reffective = Rbase + RposBuff + RnegBuff;
				
			if UNIT_CLASS == "HUNTER" then
				pwr = Reffective
			else
				pwr = effective
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
			if Role == "Tank" then 
				UpdateTank(self)
			elseif Role == "Caster" then
				UpdateCaster(self)
			elseif Role == "Melee" then
				UpdateMelee(self)
			end
			int = 2
		end

		Stat:SetScript("OnEnter", function() ShowTooltip(Stat) end)
		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
		Stat:SetScript("OnUpdate", Update)
		Update(Stat, 10)
	end

	-----------------
	-- Statistics #2
	-----------------
	if db.stat2 then

		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetFrameStrata("BACKGROUND")
		Stat:SetFrameLevel(3)
		Stat:EnableMouse(true)

		local Text  = Stat:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.stat2, Text)

		local _G = getfenv(0)
		local format = string.format
		local chanceString = "%.2f%%"
		local armorString = hexa..ARMOR..hexb..": "
		local modifierString = string.join("", "%d (+", chanceString, ")")
		local baseArmor, effectiveArmor, armor, posBuff, negBuff
		local displayNumberString = string.join("", "%s", "%d|r")
		local displayFloatString = string.join("", "%s", "%.2f%%|r")
		local level = UnitLevel("player")


		local function CalculateMitigation(level, effective)
			local mitigation
			
			if not effective then
				_, effective, _, _, _ = UnitArmor("player")
			end
			
			if level < 60 then
				mitigation = (effective/(effective + 400 + (85 * level)));
			else
				mitigation = (effective/(effective + (467.5 * level - 22167.5)));
			end
			if mitigation > .75 then
				mitigation = .75
			end
			return mitigation
		end

		local function AddTooltipHeader(description)
			GameTooltip:AddLine(description)
			GameTooltip:AddLine(' ')
		end

		local function ShowTooltip(self)
			if InCombatLockdown() then return end
		
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..PLAYER_NAME.."'s"..hexb.." Statistics")
			GameTooltip:AddLine' '	
			
			if Role == "Tank" then
				AddTooltipHeader("Mitigation By Level: ")
				local lv = level +3
				for i = 1, 4 do
					GameTooltip:AddDoubleLine(lv,format(chanceString, CalculateMitigation(lv, effectiveArmor) * 100),1,1,1)
					lv = lv - 1
				end
				lv = UnitLevel("target")
				if lv and lv > 0 and (lv > level + 3 or lv < level) then
					GameTooltip:AddDoubleLine(lv, format(chanceString, CalculateMitigation(lv, effectiveArmor) * 100),1,1,1)
				end	
			elseif Role == "Caster" or Role == "Melee" then
				AddTooltipHeader(MAGIC_RESISTANCES_COLON)
				
				local base, total, bonus, minus
				for i = 2, 6 do
					base, total, bonus, minus = UnitResistance("player", i)
					GameTooltip:AddDoubleLine(_G["DAMAGE_SCHOOL"..(i+1)], format(chanceString, (total / (total + (500 + level + 2.5))) * 100),1,1,1)
				end
				
				local spellpen = GetSpellPenetration()
				if (UNIT_CLASS == "SHAMAN" or Role == "Caster") and spellpen > 0 then
					GameTooltip:AddLine' '
					GameTooltip:AddDoubleLine(ITEM_MOD_SPELL_PENETRATION_SHORT, spellpen,1,1,1)
				end
			end
			GameTooltip:Show()
		end

		local function UpdateTank(self)
			baseArmor, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player");
			
			Text:SetFormattedText(displayNumberString, armorString, effectiveArmor)
			--Setup Tooltip
			self:SetAllPoints(Text)
		end

		local function UpdateCaster(self)
			local spellcrit = GetSpellCritChance(1)

			Text:SetFormattedText(displayFloatString, hexa.."Crit: "..hexb, spellcrit)
			--Setup Tooltip
			self:SetAllPoints(Text)
		end

		local function UpdateMelee(self)
			local meleecrit = GetCritChance()
			local rangedcrit = GetRangedCritChance()
			local critChance
				
			if UNIT_CLASS == "HUNTER" then    
				critChance = rangedcrit
			else
				critChance = meleecrit
			end
			
			Text:SetFormattedText(displayFloatString, hexa.."Crit: "..hexb, critChance)
			--Setup Tooltip
			self:SetAllPoints(Text)
		end

		-- initial delay for update (let the ui load)
		local int = 5	
		local function Update(self, t)
			int = int - t
			if int > 0 then return end
			
			if Role == "Tank" then
				UpdateTank(self)
			elseif Role == "Caster" then
				UpdateCaster(self)
			elseif Role == "Melee" then
				UpdateMelee(self)		
			end
			int = 2
		end

		Stat:SetScript("OnEnter", function() ShowTooltip(Stat) end)
		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
		Stat:SetScript("OnUpdate", Update)
		Update(Stat, 10)
	end

	-------------------
	-- System Settings
	-------------------
	if db.system then

		local Stat = CreateFrame('Frame', nil, Datapanel)
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetFrameStrata("BACKGROUND")
		Stat:SetFrameLevel(3)
		Stat:EnableMouse(true)
		Stat.tooltip = false

		local Text  = Stat:CreateFontString(nil, "OVERLAY")
		Text:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize,'THINOUTLINE')
		self:PlacePlugin(db.system, Text)

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
				local displayFormat = string.join("", hexa.."FPS: "..hexb, statusColors[fpscolor], "%d|r", hexa.." MS: "..hexb, statusColors[latencycolor], "%d|r")
				Text:SetFormattedText(displayFormat, framerate, latency)
				int2 = 1
			end
		end
		Stat:SetScript("OnMouseDown", function () collectgarbage("collect") Update(Stat, 20) end)
		Stat:SetScript("OnEnter", function(self)
			if InCombatLockdown() then return end
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
		Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
		Stat:SetScript("OnUpdate", Update)
		Update(Stat, 10)
	end
end

function Datatext:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end


function Datatext:OnEnable()
	-- This line should not be needed if you're using modules correctly:
	if not db.enable then return end

	if db.enable then -- How is this different than "enable" ? If the panel is not enabled, what's the point of doing anything else?
		self:CreatePanel() -- factor this giant blob out into its own function to keep things clean
		self:Refresh()
	end
end

function Datatext:Refresh()
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEnable")
	end
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	
	self:CreateStats()
end

function Datatext:SetFontString(parent, file, size, flags)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(file, size, flags)
	fs:SetJustifyH("LEFT")
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

function Datatext:CreatePanel()

	if Datapanel then return end -- already done
	
	-- Setup the Panels
	self:SetDataPanel()
	self:SetStatPanelLeft()
	self:SetStatPanelCenter()
	self:SetStatPanelRight()
	
	-- No Need for function it always sets it self on the PanelLeft
	BGPanel = CreateFrame("Frame", nil, Datapanel)
	BGPanel:SetAllPoints(StatPanelLeft)
	BGPanel:SetFrameStrata("LOW")
	BGPanel:SetFrameLevel(1)


end


------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

local options
function Datatext:GetOptions()
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
				name = L["Enable Datapanel Module"],
				width = "full"
			},
			time24 = {
				type = "toggle",
				order = 2,
				name = L["24-Hour Time"],
				desc = L["Display time datapanel on a 24 hour time scale"],
				disabled = function() return isModuleDisabled() or not db.enable end,
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
			recountraiddps = {
				type = "toggle",
				order = 2,
				name = L["Recount Raid DPS"],
				desc = L["Display Recount's Raid DPS (RECOUNT MUST BE INSTALLED)"],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			DataGroup = {
				type = "group",
				order = 6,
				name = L["Text Positions"],
				guiInline  = true,
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
					bags = {
						type = "select",
						order = 5,
						name = L["Bags"],
						desc = L["Display amount of bag space"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					calltoarms = {
						type = "select",
						order = 5,
						name = L["Call to Arms"],
						desc = L["Display the active roles that will recieve a reward for completing a random dungeon"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					coords = {
						type = "select",
						order = 5,
						name = L["Coordinates"],
						desc = L["Display Player's Coordinates"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					dps_text = {
						type = "select",
						order = 5,
						name = L["DPS"],
						desc = L["Display amount of DPS"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					dur = {
						type = "select",
						order = 5,
						name = L["Durability"],
						desc = L["Display your current durability"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					friends = {
						type = "select",
						order = 5,
						name = L["Friends"],
						desc = L["Display current online friends"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					guild = {
						type = "select",
						order = 5,
						name = L["Guild"],
						desc = L["Display current online people in guild"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					hps_text = {
						type = "select",
						order = 5,
						name = L["HPS"],
						desc = L["Display amount of HPS"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					pro = {
						type = "select",
						order = 5,
						name = L["Professions"],
						desc = L["Display Professions"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					recount = {
						type = "select",
						order = 5,
						name = L["Recount"],
						desc = L["Display Recount's DPS (RECOUNT MUST BE INSTALLED)"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					spec = {
						type = "select",
						order = 5,
						name = L["Talent Spec"],
						desc = L["Display current spec"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					stat1 = {
						type = "select",
						order = 5,
						name = L["Stat #1"],
						desc = L["Display stat based on your role (Avoidance-Tank, AP-Melee, SP/HP-Caster)"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					stat2 = {
						type = "select",
						order = 5,
						name = L["Stat #2"],
						desc = L["Display stat based on your role (Armor-Tank, Crit-Melee, Crit-Caster)"],
						values = statposition;
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					system = {
						type = "select",
						order = 5,
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