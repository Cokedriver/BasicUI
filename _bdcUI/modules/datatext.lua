local _, bc = ...
local cfg = bc.config

if cfg.datatext.enable ~= true then return end

--[[

	All Create for datatext.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if cfg.datatext.datapanel.enable == true then
	
	local DataBorderPanel = CreateFrame('Frame', 'DataBorderPanel', UIParent)
	if cfg.datatext.top == true then
		DataBorderPanel:SetPoint('TOP', UIParent, 0, 0)
		DataBorderPanel:SetHeight(28)
		DataBorderPanel:SetWidth(GetScreenWidth())
		DataBorderPanel:SetFrameStrata('LOW')
		DataBorderPanel:SetFrameLevel(0)
		DataBorderPanel:SetBackdrop({
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
			edgeFile = "Interface\\AddOns\\_bdcUI\\media\\UI-Tooltip-Border",							
			tile = true, tileSize = 16, edgeSize = 18,
			insets = {left = 3, right = 3, top = 3, bottom = 3},
		})
		local ccolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass("player"))]
		DataBorderPanel:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b, 1)
	elseif cfg.datatext.top == false then
		DataBorderPanel:SetPoint('BOTTOM', UIParent, 0, 0)
		DataBorderPanel:SetHeight(28)
		DataBorderPanel:SetWidth(1200)
		DataBorderPanel:SetFrameStrata('LOW')
		DataBorderPanel:SetFrameLevel(0)
		DataBorderPanel:SetBackdrop({
			bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
			edgeFile = "Interface\\AddOns\\_bdcUI\\media\\UI-DialogBox-Border",							
			tile = true, tileSize = 16, edgeSize = 18,
			insets = {left = 3, right = 3, top = 3, bottom = 3},
		})
	end



	local DataPanelLeft = CreateFrame('Frame', 'DataPanelLeft', UIParent)
	DataPanelLeft:SetPoint('LEFT', DataBorderPanel, 5, 0)
	DataPanelLeft:SetHeight(25)
	if cfg.datatext.top == true then
		DataPanelLeft:SetWidth(GetScreenWidth() / 3)
	elseif cfg.datatext.top == false then
		DataPanelLeft:SetWidth(1200 / 3)
	end
	DataPanelLeft:SetFrameStrata('LOW')
	DataPanelLeft:SetFrameLevel(1)		


	local DataPanelCenter = CreateFrame('Frame', 'DataPanelCenter', UIParent)
	DataPanelCenter:SetPoint('CENTER', DataBorderPanel, 0, 0)
	DataPanelCenter:SetHeight(25)
	if cfg.datatext.top == true then
		DataPanelCenter:SetWidth(GetScreenWidth() / 3)
	elseif cfg.datatext.top == false then
		DataPanelCenter:SetWidth(1200 / 3)
	end
	DataPanelCenter:SetFrameStrata('LOW')
	DataPanelCenter:SetFrameLevel(1)		


	local DataPanelRight = CreateFrame('Frame', 'DataPanelRight', UIParent)
	DataPanelRight:SetPoint('RIGHT', DataBorderPanel, -5, 0)
	DataPanelRight:SetHeight(25)
	if cfg.datatext.top == true then
		DataPanelRight:SetWidth(GetScreenWidth() / 3)
	elseif cfg.datatext.top == false then
		DataPanelRight:SetWidth(1200 / 3)
	end
	DataPanelRight:SetFrameStrata('LOW')
	DataPanelRight:SetFrameLevel(1)		


		 
	local BattleGroundPanel = CreateFrame('Frame', 'BattleGroundPanel', UIParent)
	BattleGroundPanel:SetAllPoints(DataPanelLeft)
	BattleGroundPanel:SetFrameStrata('LOW')
	BattleGroundPanel:SetFrameLevel(1)
	BattleGroundPanel:SetBackdrop({
		bgFile = [[Interface\Buttons\WHITE8x8]],
		insets = {top = 1, left = 4.5, bottom = 1, right = 1},
	})
	BattleGroundPanel:SetBackdropColor(0, 0, 0, 0)

	-- move some frames to make way for the datapanel
	if cfg.datatext.top == true then
		hooksecurefunc("PlayerFrame_ResetPosition", function(self)
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", -19, -20)
		end)	
		
		local bf = BuffFrame
		bf:ClearAllPoints()
		bf:SetPoint('TOP', MinimapCluster, -100, 0)
		
		local mc = MinimapCluster
		mc:ClearAllPoints()
		mc:SetPoint('TOPRIGHT', UIParent, 0, -32)
		
		local tf = TargetFrame
		tf:ClearAllPoints()
		tf:SetPoint("TOPLEFT", 250, -20)
	elseif cfg.datatext.top == false then
		-- Move the Bottom Action Bar Up on Top of the Datapanel
		-- Code help from Nibelheim on Wowinterface Forums
		local Movebar = CreateFrame("Frame")
		local NeedsUpdate = false
		local function RaiseBars(self)
			-- Check if in combat lockdown, and set NeedsUpdate
			if InCombatLockdown() then
				NeedsUpdate = true
				return
			end
						
			--Update bars
			MainMenuBar:ClearAllPoints()
			MainMenuBar:SetPoint('BOTTOM', DataBorderPanel, 0, 25)
			VehicleMenuBar:ClearAllPoints()
			VehicleMenuBar:SetPoint('BOTTOM', DataBorderPanel, 0, 28)

		end
		Movebar:SetScript("OnUpdate", function(MainMenuBar) RaiseBars(); end)
		RaiseBars()

		
		 -- Move the tooltip above the Actionbar
		if cfg.tooltip.enable == true then
			hooksecurefunc('GameTooltip_SetDefaultAnchor', function(self)
				self:SetPoint('BOTTOMRIGHT', UIParent, -95, 175)
			end)
		end

		 -- Move the Bags above the Actionbar
		CONTAINER_WIDTH = 192;
		CONTAINER_SPACING = 5;
		VISIBLE_CONTAINER_SPACING = 3;
		CONTAINER_OFFSET_Y = 70;
		CONTAINER_OFFSET_X = 0;
		CONTAINER_SCALE = 0.75;
		BACKPACK_HEIGHT = 240; 
		 
		function updateContainerFrameAnchors()
			local frame, xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column;
			local screenWidth = GetScreenWidth();
			local containerScale = 1;
			local leftLimit = 0;
			if ( BankFrame:IsShown() ) then
				leftLimit = BankFrame:GetRight() - 25;
			end
			 
			while ( containerScale > CONTAINER_SCALE ) do
				screenHeight = GetScreenHeight() / containerScale;
				-- Adjust the start anchor for bags depending on the multibars
				xOffset = CONTAINER_OFFSET_X / containerScale; 
				yOffset = CONTAINER_OFFSET_Y / containerScale; 
				-- freeScreenHeight determines when to start a new column of bags
				freeScreenHeight = screenHeight - yOffset;
				leftMostPoint = screenWidth - xOffset;
				column = 1;
				local frameHeight;
				for index, frameName in ipairs(ContainerFrame1.bags) do
					frameHeight = _G[frameName]:GetHeight();
					if ( freeScreenHeight < frameHeight ) then
						-- Start a new column
						column = column + 1;
						leftMostPoint = screenWidth - ( column * CONTAINER_WIDTH * containerScale ) - xOffset;
						freeScreenHeight = screenHeight - yOffset;
					end
					freeScreenHeight = freeScreenHeight - frameHeight - VISIBLE_CONTAINER_SPACING;
				end
				if ( leftMostPoint < leftLimit ) then
					containerScale = containerScale - 0.01;
				else
					break;
				end
			end
			 
			if ( containerScale < CONTAINER_SCALE ) then
				containerScale = CONTAINER_SCALE;
			end
			 
			screenHeight = GetScreenHeight() / containerScale;
			-- Adjust the start anchor for bags depending on the multibars
			xOffset = CONTAINER_OFFSET_X / containerScale;
			yOffset = CONTAINER_OFFSET_Y / containerScale;
			-- freeScreenHeight determines when to start a new column of bags
			freeScreenHeight = screenHeight - yOffset;
			column = 0;
			for index, frameName in ipairs(ContainerFrame1.bags) do
				frame = _G[frameName];
				frame:SetScale(containerScale);
				if ( index == 1 ) then
					-- First bag
					frame:SetPoint('BOTTOMRIGHT', frame:GetParent(), 'BOTTOMRIGHT', -xOffset, yOffset+20 );
				elseif ( freeScreenHeight < frame:GetHeight() ) then
					-- Start a new column
					column = column + 1;
					freeScreenHeight = screenHeight - yOffset;
					frame:SetPoint('BOTTOMRIGHT', frame:GetParent(), 'BOTTOMRIGHT', -(column * CONTAINER_WIDTH) - xOffset, yOffset+20 );
				else
					-- Anchor to the previous bag
					frame:SetPoint('BOTTOMRIGHT', ContainerFrame1.bags[index - 1], 'TOPRIGHT', 0, CONTAINER_SPACING);   
				end
				freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING;
			end
		end
	end	
end

PP = function(p, obj)

	local left = DataPanelLeft
	local center = DataPanelCenter
	local right = DataPanelRight
	
		-- Left Panel Data
	if p == 1 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('LEFT', left, 20, 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 2 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 3 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('RIGHT', left, -20, 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
		
		-- Center Panel Data
	elseif p == 4 then
		obj:SetParent(center)
		obj:SetHeight(center:GetHeight())
		obj:SetPoint('LEFT', center, 20, 0)
		obj:SetPoint('TOP', center)
		obj:SetPoint('BOTTOM', center)
	elseif p == 5 then
		obj:SetParent(center)
		obj:SetHeight(center:GetHeight())
		obj:SetPoint('TOP', center)
		obj:SetPoint('BOTTOM', center)
	elseif p == 6 then
		obj:SetParent(center)
		obj:SetHeight(center:GetHeight())
		obj:SetPoint('RIGHT', center, -20, 0)
		obj:SetPoint('TOP', center)
		obj:SetPoint('BOTTOM', center)
		
		-- Right Panel Data
	elseif p == 7 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('LEFT', right, 20, 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	elseif p == 8 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	elseif p == 9 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('RIGHT', right, -20, 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	end

end

SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, 'OVERLAY')
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH('LEFT')
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

DataTextTooltipAnchor = function(self)
	local panel = self:GetParent()
	local anchor = 'GameTooltip'
	local xoff = 1
	local yoff = 3
	
	
	for _, panel in pairs ({
		DataPanelLeft,
		DataPanelCenter,
		DataPanelRight,
	})	do
		if cfg.datatext.top == true then
			anchor = 'ANCHOR_BOTTOM'
		else
			anchor = 'ANCHOR_TOP'
		end
	end	
	return anchor, panel, xoff, yoff
end

myclass = UnitClass("player")
myname = select(1, UnitName("player"))

--Check Player's Role


local RoleUpdater = CreateFrame("Frame")
local function CheckRole(self, event, unit)
	local tree = GetPrimaryTalentTree()
	local resilience
	local resilperc = GetCombatRatingBonus(COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN)
	if resilperc > GetDodgeChance() and resilperc > GetParryChance() then
		resilience = true
	else
		resilience = false
	end
	if ((myclass == "PALADIN" and tree == 2) or 
	(myclass == "WARRIOR" and tree == 3) or 
	(myclass == "DEATHKNIGHT" and tree == 1)) and
	resilience == false or
	(myclass == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
		Role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player");
		local playerap = base + posBuff + negBuff;

		if (((playerap > playerint) or (playeragi > playerint)) and not (myclass == "SHAMAN" and tree ~= 1 and tree ~= 3) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139)))) or myclass == "ROGUE" or myclass == "HUNTER" or (myclass == "SHAMAN" and tree == 2) then
			Role = "Melee"
		else
			Role = "Caster"
		end
	end
end	
RoleUpdater:RegisterEvent("PLAYER_ENTERING_WORLD")
RoleUpdater:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
RoleUpdater:RegisterEvent("PLAYER_TALENT_UPDATE")
RoleUpdater:RegisterEvent("CHARACTER_POINTS_CHANGED")
RoleUpdater:RegisterEvent("UNIT_INVENTORY_CHANGED")
RoleUpdater:RegisterEvent("UPDATE_BONUS_ACTIONBAR")
RoleUpdater:SetScript("OnEvent", CheckRole)
CheckRole()

---------------------------------------------------
-- Color system for DataText Created by Hydra 
---------------------------------------------------

local ccolor = RAID_CLASS_COLORS[select(2, UnitClass('player'))]
hexa, hexb = cfg.datatext.color, '|r'

if cfg.datatext.classcolor then
	hexa = string.format('|c%02x%02x%02x%02x', 255, ccolor.r * 255, ccolor.g * 255, ccolor.b * 255,'THINOUTLINE')
end

---------------
-- Threat Text
---------------

if cfg.datatext.threatbar.enable == true then

	local aggroColors = {
		[1] = {1, 0, 0},
		[2] = {1, 1, 0},
		[3] = {0, 1, 0},
	}

	local nDataThreatBar = CreateFrame("StatusBar", "nDataThreatBar", UIParent)
	nDataThreatBar:SetPoint("TOPLEFT", DataPanelCenter, 2, -2)
	nDataThreatBar:SetPoint("BOTTOMRIGHT", DataPanelCenter, -2, 2)
	nDataThreatBar:SetFrameLevel(1)

	nDataThreatBar.text = SetFontString(nDataThreatBar, cfg.media.font, 18)
	nDataThreatBar.text:SetPoint("CENTER", nDataThreatBar, 0, 0)
		 

	local function OnEvent(self, event, ...)
		local party = GetNumPartyMembers()
		local raid = GetNumRaidMembers()
		local pet = select(1, HasPetUI())
		if event == "PLAYER_ENTERING_WORLD" then
			self:Hide()
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		elseif event == "PLAYER_REGEN_ENABLED" then
			self:Hide()
		elseif event == "PLAYER_REGEN_DISABLED" then
			if party > 0 or raid > 0 or pet == 1 then
				self:Show()
			else
				self:Hide()
			end
		else
			if (InCombatLockdown()) and (party > 0 or raid > 0 or pet == 1) then
				self:Show()
			else
				self:Hide()
			end
		end
	end

	local function OnUpdate(self, event, unit)
		if UnitAffectingCombat(self.unit) then
			local _, _, threatpct, rawthreatpct, _ = UnitDetailedThreatSituation(self.unit, self.tar)
			local threatval = threatpct or 0
			
			self:SetValue(threatval)
			self.text:SetFormattedText("%s ".."%3.1f%%|r", cfg.L.unitframes_ouf_threattext, threatval)
			
			if( threatval < 30 ) then
				self.text:SetTextColor(unpack(self.Colors[3]))
			elseif( threatval >= 30 and threatval < 70 ) then
				self.text:SetTextColor(unpack(self.Colors[2]))
			else
				self.text:SetTextColor(unpack(self.Colors[1]))
			end	
					
			if threatval > 0 then
				self:SetAlpha(1)
				DataPanelCenter:SetAlpha(0)
			else
				self:SetAlpha(0)
				DataPanelCenter:SetAlpha(1)
			end		
		end
	end

	nDataThreatBar:RegisterEvent("PLAYER_ENTERING_WORLD")
	nDataThreatBar:RegisterEvent("PLAYER_REGEN_ENABLED")
	nDataThreatBar:RegisterEvent("PLAYER_REGEN_DISABLED")
	nDataThreatBar:SetScript("OnEvent", OnEvent)
	nDataThreatBar:SetScript("OnUpdate", OnUpdate)
	nDataThreatBar.unit = "player"
	nDataThreatBar.tar = nDataThreatBar.unit.."target"
	nDataThreatBar.Colors = aggroColors
	nDataThreatBar:SetAlpha(0)
end
----------------------------------
-- Datatext for Battleground Data
----------------------------------

if cfg.datatext.battleground == true then 

	--Map IDs
	local WSG = 443
	local TP = 626
	local AV = 401
	local SOTA = 512
	local IOC = 540
	local EOTS = 482
	local TBFG = 736
	local AB = 461

	local bgframe = BattleGroundPanel
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
					GameTooltip:AddLine(cfg_ttstatsfor..hexa..name..hexb)
					GameTooltip:AddLine' '
					GameTooltip:AddDoubleLine(cfg.L.datatext_ttkillingblows, killingBlows,1,1,1)
					GameTooltip:AddDoubleLine(cfg.L.datatext_tthonorkills, honorableKills,1,1,1)
					GameTooltip:AddDoubleLine(cfg.L.datatext_ttdeaths, deaths,1,1,1)
					GameTooltip:AddDoubleLine(cfg.L.datatext_tthonorgain, format('%d', honorGained),1,1,1)
					GameTooltip:AddDoubleLine(cfg.L.datatext_ttdmgdone, damageDone,1,1,1)
					GameTooltip:AddDoubleLine(cfg.L.datatext_tthealdone, healingDone,1,1,1)
					--Add extra statistics to watch based on what BG you are in.
					if curmapid == WSG or curmapid == TP then 
						GameTooltip:AddDoubleLine(cfg.L.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(cfg.L.datatext_flagsreturned,GetBattlefieldStatData(i, 2),1,1,1)
					elseif curmapid == EOTS then
						GameTooltip:AddDoubleLine(cfg.L.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
					elseif curmapid == AV then
						GameTooltip:AddDoubleLine(cfg.L.datatext_graveyardsassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(cfg.L.datatext_graveyardsdefended,GetBattlefieldStatData(i, 2),1,1,1)
						GameTooltip:AddDoubleLine(cfg.L.datatext_towersassaulted,GetBattlefieldStatData(i, 3),1,1,1)
						GameTooltip:AddDoubleLine(cfg.L.datatext_towersdefended,GetBattlefieldStatData(i, 4),1,1,1)
					elseif curmapid == SOTA then
						GameTooltip:AddDoubleLine(cfg.L.datatext_demolishersdestroyed,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(cfg.L.datatext_gatesdestroyed,GetBattlefieldStatData(i, 2),1,1,1)
					elseif curmapid == IOC or curmapid == TBFG or curmapid == AB then
						GameTooltip:AddDoubleLine(cfg.L.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(cfg.L.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
					end					
					GameTooltip:Show()
				end
			end
		end
	end) 
	bgframe:SetScript('OnLeave', function(self) GameTooltip:Hide() end)

	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)

	local Text1  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
	Text1:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	Text1:SetPoint('LEFT', BattleGroundPanel, 30, 0)
	Text1:SetHeight(DataPanelLeft:GetHeight())

	local Text2  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
	Text2:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	Text2:SetPoint('CENTER', BattleGroundPanel, 0, 0)
	Text2:SetHeight(DataPanelLeft:GetHeight())

	local Text3  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
	Text3:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	Text3:SetPoint('RIGHT', BattleGroundPanel, -30, 0)
	Text3:SetHeight(DataPanelLeft:GetHeight())

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
					dmgtxt = (cfg.L.datatext_healing..hexa..healingDone..hexb)
				else
					dmgtxt = (cfg.L.datatext_damage..hexa..damageDone..hexb)
				end
				if ( name ) then
					if ( name == myname ) then
						Text2:SetText(cfg.L.datatext_honor..hexa..format('%d', honorGained)..hexb)
						Text1:SetText(dmgtxt)
						Text3:SetText(cfg.L.datatext_killingblows..hexa..killingBlows..hexb)
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
				DataPanelLeft:Hide()
			else
				Text1:SetText('')
				Text2:SetText('')
				Text3:SetText('')
				bgframe:Hide()
				DataPanelLeft:Show()
			end
		end
	end

	Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
	Stat:SetScript('OnEvent', OnEvent)
	Stat:SetScript('OnUpdate', Update)
	Update(Stat, 10)
end

---------------------
-- Datatext for Bags
---------------------
--[[
if cfg.datatext.bags and cfg.datatext.bags > 0 then
	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.bags, Text)

	local function OnEvent(self, event, ...)
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
			Text:SetText(hexa..cfg.L.datatext_bags..hexb.. freeSlots.. '/' ..totalSlots)
				if freeSlots < 10 then
					Text:SetTextColor(1,0,0)
				elseif freeSlots > 10 then
					Text:SetTextColor(1,1,1)
				end
			self:SetAllPoints(Text)
		end
	end
          
	Stat:RegisterEvent('PLAYER_LOGIN')
	Stat:RegisterEvent('BAG_UPDATE')
	Stat:SetScript('OnMouseDown', 
		function()
			if cfg.datatext.bags.single == true then
				ToggleBag(0)
			elseif cfg.datatext.bags.single == false then
				ToggleAllBags()
			end
		end)
	Stat:SetScript('OnEvent', OnEvent)
end
]]

----------------------------------
-- Datatext for Call To Arms Data
----------------------------------

if cfg.datatext.calltoarms and cfg.datatext.calltoarms > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("MEDIUM")
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.calltoarms, Text)
	
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
		GameTooltip:AddLine(BATTLEGROUND_HOLIDAY)
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
			GameTooltip:AddLine(cfg.L.datatext_cta_allunavailable)
		elseif numCTA == 0 then 
			GameTooltip:AddLine(cfg.L.datatext_cta_nodungeons) 
		end
		GameTooltip:Show()	
	end
    
	Stat:RegisterEvent("LFG_UPDATE_RANDOM_INFO")
	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() ToggleFrame(LFDParentFrame) end)
	Stat:SetScript("OnEnter", OnEnter)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

------------------------------
-- Datatext for Player Coords
------------------------------

if cfg.datatext.coords and cfg.datatext.coords > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.coords, Text)

	local function Update(self)
	local px,py=GetPlayerMapPosition("player")
		Text:SetText(format("%i , %i",px*100,py*100))
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end

-------------------------
-- Datatext for CURRENCY
-------------------------

if cfg.datatext.currency and cfg.datatext.currency > 0 then
	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.currency, Text)
	
	local function update()
		local _text = '---'
		for i = 1, MAX_WATCHED_TOKENS do
			local name, count, _, _, _ = GetBackpackCurrencyInfo(i)
			if name and count then
				if(i ~= 1) then _text = _text .. ' ' else _text = '' end
				words = { strsplit(' ', name) }
				for _, word in ipairs(words) do
					_text = _text .. string.sub(word,1,1)
				end
				_text = _text .. ': ' .. count
			end
		end
		
		Text:SetText(_text)
	end
	
	local function OnEvent(self, event, ...)
		update()
		self:SetAllPoints(Text)
		Stat:UnregisterEvent('PLAYER_LOGIN')	
	end

	Stat:RegisterEvent('PLAYER_LOGIN')	
	hooksecurefunc('BackpackTokenFrame_Update', update)
	Stat:SetScript('OnEvent', OnEvent)
	Stat:SetScript('OnMouseDown', function() ToggleCharacter('TokenFrame') end)
end

----------------------------
-- Datatext for DPS Feed... 
----------------------------

if cfg.datatext.dps_text and cfg.datatext.dps_text > 0 then
	local events = {SWING_DAMAGE = true, RANGE_DAMAGE = true, SPELL_DAMAGE = true, SPELL_PERIODIC_DAMAGE = true, DAMAGE_SHIELD = true, DAMAGE_SPLIT = true, SPELL_EXTRA_ATTACKS = true}
	local DPS_FEED = CreateFrame('Frame')
	local player_id = UnitGUID('player')
	local dmg_total, last_dmg_amount = 0, 0
	local cmbt_time = 0

	local pet_id = UnitGUID('pet')
     
	local dText = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	dText:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	dText:SetText('0 ',cfg.L.datatext_dps)

	PP(cfg.datatext.dps_text, dText)

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
			if select(2, ...) == 'SWING_DAMAGE' then
				last_dmg_amount = select(10, ...)
			else
				last_dmg_amount = select(13, ...)
			end
			dmg_total = dmg_total + last_dmg_amount
		end       
	end
     
	function getDPS()
		if (dmg_total == 0) then
			return ('0 ' .. hexa..cfg.L.datatext_dps..hexb)
		else
			return string.format('%.1f ' ..hexa..cfg.L.datatext_dps..hexb, (dmg_total or 0) / (cmbt_time or 1))
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

---------------------------
-- Datatext for DURABILITY
---------------------------
	
if cfg.datatext.dur and cfg.datatext.dur > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.dur, Text)

	local Total = 0
	local current, max

	local function OnEvent(self)
		for i = 1, 11 do
			if GetInventoryItemLink("player", cfg.L.Slots[i][1]) ~= nil then
				current, max = GetInventoryItemDurability(cfg.L.Slots[i][1])
				if current then 
					cfg.L.Slots[i][3] = current/max
					Total = Total + 1
				end
			end
		end
		table.sort(cfg.L.Slots, function(a, b) return a[3] < b[3] end)
		
		if Total > 0 then
			Text:SetText(floor(cfg.L.Slots[1][3]*100).."% "..hexa..cfg.L.datatext_armor..hexb)
		else
			Text:SetText("100% "..hexa..cfg.L.datatext_armor..hexb)
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
			for i = 1, 11 do
				if cfg.L.Slots[i][3] ~= 1000 then
					green = cfg.L.Slots[i][3]*2
					red = 1 - green
					GameTooltip:AddDoubleLine(cfg.L.Slots[i][2], floor(cfg.L.Slots[i][3]*100).."%",1 ,1 , 1, red + 1, green, 0)
				end
			end
			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

-----------------------------
-- Datatext for Friends List
-----------------------------

if cfg.datatext.friends and cfg.datatext.friends > 0 then

	-- create a popup
	StaticPopupDialogs.SET_BN_BROADCAST = {
		text = BN_BROADCAST_TOOLTIP,
		button1 = ACCEPT,
		button2 = CANCEL,
		hasEditBox = 1,
		editBoxWidth = 350,
		maxLetters = 127,
		OnAccept = function(self) BNSetCustomMessage(self.editBox:GetText()) end,
		OnShow = function(self) self.editBox:SetText(select(3, BNGetInfo()) ) self.editBox:SetFocus() end,
		OnHide = ChatEdit_FocusActiveWindow,
		EditBoxOnEnterPressed = function(self) BNSetCustomMessage(self:GetText()) self:GetParent():Hide() end,
		EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
		timeout = 0,
		exclusive = 1,
		whileDead = 1,
		hideOnEscape = 1
	}

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.friends, Text)

	local menuFrame = CreateFrame("Frame", "FriendRightClickMenu", UIParent, "UIDropDownMenuTemplate")
	local menuList = {
		{ text = OPTIONS_MENU, isTitle = true,notCheckable=true},
		{ text = hexa.."Invite"..hexb, hasArrow = true,notCheckable=true,},			
		{ text = hexa.."Whisper"..hexb, hasArrow = true,notCheckable=true, },
		{ text = hexa.."Player Status"..hexb, hasArrow = true, notCheckable=true,
			menuList = {			
				{ text = "|cff2BC226"..AVAILABLE.."|r", notCheckable=true, func = function() if IsChatAFK() then SendChatMessage("", "AFK") elseif IsChatDND() then SendChatMessage("", "DND") end end },
				{ text = "|cffE7E716"..DND.."|r", notCheckable=true, func = function() if not IsChatDND() then SendChatMessage("", "DND") end end },
				{ text = "|cffFF0000"..AFK.."|r", notCheckable=true, func = function() if not IsChatAFK() then SendChatMessage("", "AFK") end end },
			},
		},
		{ text = hexa.."Battle.Net Broadcast"..hexb, notCheckable=true, func = function() StaticPopup_Show("SET_BN_BROADCAST") end }
	,}

	local function GetTableIndex(table, fieldIndex, value)
		for k,v in ipairs(table) do
			if v[fieldIndex] == value then return k end
		end
		return -1
	end

	local function inviteClick(self, arg1, arg2, checked)
		menuFrame:Hide()
		InviteUnit(arg1)
	end

	local function whisperClick(self,arg1,arg2,checked)
		menuFrame:Hide() 
		SetItemRef( "player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton" )		 
	end

	local levelNameString = "|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r"
	local clientLevelNameString = "%s (|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r%s) |cff%02x%02x%02x%s|r"
	local levelNameClassString = "|cff%02x%02x%02x%d|r %s%s%s"
	local worldOfWarcraftString = "World of Warcraft"
	local battleNetString = "Battle.NET"
	local wowString = "WoW"
	local totalOnlineString = cfg.L.datatext_online .. "%s/%s"
	local tthead, ttsubh, ttoff = {r=0.4, g=0.78, b=1}, {r=0.75, g=0.9, b=1}, {r=.3,g=1,b=.3}
	local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
	local displayString = string.join("", hexa.."%s: "..hexb, "|cffffffff", "%d|r")
	local statusTable = { "[AFK]", "[DND]", "" }
	local groupedTable = { "|cffaaaaaa*|r", "" } 
	local friendTable, BNTable = {}, {}
	local totalOnline, BNTotalOnline = 0, 0
	local myrealm = GetRealmName()
	
	local function BuildFriendTable(total)
		totalOnline = 0
		wipe(friendTable)
		local name, level, class, area, connected, status, note
		for i = 1, total do
			name, level, class, area, connected, status, note = GetFriendInfo(i)
			for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			
			friendTable[i] = { name, level, class, area, connected, status, note }
			if connected then totalOnline = totalOnline + 1 end
		end
		table.sort(friendTable, function(a, b)
			if a[1] and b[1] then
				return a[1] < b[1]
			end
		end)
	end

	local function UpdateFriendTable(total)
		totalOnline = 0
		local name, level, class, area, connected, status, note
		for i = 1, #friendTable do
			name, level, class, area, connected, status, note = GetFriendInfo(i)
			for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			
			-- get the correct index in our table		
			index = GetTableIndex(friendTable, 1, name)
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
		local _, presenceID, givenName, surname, toonName, toonID, client, isOnline, isAFK, isDND, noteText, realmName, faction, race, class, zoneName, level
		for i = 1, total do
			presenceID, givenName, surname, toonName, toonID, client, isOnline, _, isAFK, isDND, _, noteText = BNGetFriendInfo(i)
			if cfg.datatext.toc < 40200 then
				_, _, _, realmName, faction, race, class, _, zoneName, level = BNGetToonInfo(presenceID)
			else
				_, _, _, realmName, _, faction, race, class, _, zoneName, level = BNGetToonInfo(presenceID)
			end
			for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			
			BNTable[i] = { presenceID, givenName, surname, toonName, toonID, client, isOnline, isAFK, isDND, noteText, realmName, faction, race, class, zoneName, level }
			if isOnline then BNTotalOnline = BNTotalOnline + 1 end
		end
		table.sort(BNTable, function(a, b)
			if a[2] and b[2] then
				if a[2] == b[2] then return a[3] < b[3] end
				return a[2] < b[2]
			end
		end)
	end

	local function UpdateBNTable(total)
		BNTotalOnline = 0
		local presenceID, givenName, surname, toonName, toonID, client, isOnline, isAFK, isDND, noteText
		local _, realmName, faction, race, class, zoneName, level
		for i = 1, #BNTable do
			-- get guild roster information
			presenceID, givenName, surname, toonName, toonID, client, isOnline, _, isAFK, isDND, _, noteText = BNGetFriendInfo(i)
			if cfg.datatext.toc < 40200 then
				_, _, _, realmName, faction, race, class, _, zoneName, level = BNGetToonInfo(presenceID)
			else
				_, _, _, realmName, _, faction, race, class, _, zoneName, level = BNGetToonInfo(presenceID)
			end
			for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			
			-- get the correct index in our table		
			index = GetTableIndex(BNTable, 1, presenceID)
			-- we cannot find a BN member in our table, so rebuild it
			if index == -1 then
				BuildBNTable(total)
				return
			end
			-- update on-line status for all members
			BNTable[index][7] = isOnline
			-- update information only for on-line members
			if isOnline then
				BNTable[index][2] = givenName
				BNTable[index][3] = surname
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
			local realID, playerFaction, grouped
			for i = 1, #BNTable do
				if (BNTable[i][7]) then
					realID = (BATTLENET_NAME_FORMAT):format(BNTable[i][2], BNTable[i][3])
					menuCountWhispers = menuCountWhispers + 1
					menuList[3].menuList[menuCountWhispers] = {text = realID, arg1 = realID,notCheckable=true, func = whisperClick}

					if select(1, UnitFactionGroup("player")) == "Horde" then playerFaction = 0 else playerFaction = 1 end
					if BNTable[i][6] == wowString and BNTable[i][11] == myrealm and playerFaction == BNTable[i][12] then
						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(BNTable[i][16])
						if classc == nil then classc = GetQuestDifficultyColor(BNTable[i][16]) end

						if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then grouped = 1 else grouped = 2 end
						menuCountInvites = menuCountInvites + 1
						menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,BNTable[i][16],classc.r*255,classc.g*255,classc.b*255,BNTable[i][4]), arg1 = BNTable[i][4],notCheckable=true, func = inviteClick}
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

		Text:SetFormattedText(displayString, cfg.L.datatext_friends, totalOnline + BNTotalOnline)
		self:SetAllPoints(Text)
	end

	Stat:SetScript("OnMouseDown", function(self, btn) if btn == "LeftButton" then ToggleFriendsFrame(1) end end)
	Stat:SetScript("OnEnter", function(self)
		if InCombatLockdown() then return end
			
		local totalonline = totalOnline + BNTotalOnline
		local totalfriends = #friendTable + #BNTable
		local zonec, classc, levelc, realmc, grouped
		if totalonline > 0 then
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddDoubleLine(cfg.L.datatext_friendlist, format(totalOnlineString, totalonline, totalfriends),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
			if totalOnline > 0 then
				GameTooltip:AddLine(' ')
				GameTooltip:AddLine(worldOfWarcraftString)
				for i = 1, #friendTable do
					if friendTable[i][5] then
						if GetRealZoneText() == friendTable[i][4] then zonec = activezone else zonec = inactivezone end
						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[friendTable[i][3]], GetQuestDifficultyColor(friendTable[i][2])
						if classc == nil then classc = GetQuestDifficultyColor(friendTable[i][2]) end
						
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
		
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(BNTable[i][16])
							if classc == nil then classc = GetQuestDifficultyColor(BNTable[i][16]) end
							
							if UnitInParty(BNTable[i][4]) or UnitInRaid(BNTable[i][4]) then grouped = 1 else grouped = 2 end
							GameTooltip:AddDoubleLine(format(clientLevelNameString, BNTable[i][6],levelc.r*255,levelc.g*255,levelc.b*255,BNTable[i][16],classc.r*255,classc.g*255,classc.b*255,BNTable[i][4],groupedTable[grouped], 255, 0, 0, statusTable[status]),BNTable[i][2].." "..BNTable[i][3],238,238,238,238,238,238)
							if IsShiftKeyDown() then
								if GetRealZoneText() == BNTable[i][15] then zonec = activezone else zonec = inactivezone end
								if GetRealmName() == BNTable[i][11] then realmc = activezone else realmc = inactivezone end
								GameTooltip:AddDoubleLine("  "..BNTable[i][15], BNTable[i][11], zonec.r, zonec.g, zonec.b, realmc.r, realmc.g, realmc.b)
							end
						else
							GameTooltip:AddDoubleLine("|cffeeeeee"..BNTable[i][6].." ("..BNTable[i][4]..")|r", "|cffeeeeee"..BNTable[i][2].." "..BNTable[i][3].."|r")
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


--------------------------------------------------------------------
-- Datatext for Player Gold
--------------------------------------------------------------------

if cfg.datatext.gold and cfg.datatext.gold > 0 then
	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.gold, Text)

	local Profit	= 0
	local Spent		= 0
	local OldMoney	= 0
	local myPlayerRealm = GetCVar('realmName');

	local function formatMoney(money)
		local gold = floor(math.abs(money) / 10000)
		local silver = mod(floor(math.abs(money) / 100), 100)
		local copper = mod(floor(math.abs(money)), 100)
		if gold ~= 0 then
			return format('%s'..cfg.L.goldabbrev, gold)
		elseif silver ~= 0 then
			return format('%s'..cfg.L.silverabbrev, silver)
		else
			return format('%s'..cfg.L.copperabbrev, copper)
		end
	end

	local function FormatTooltipMoney(money)
		local gold, silver, copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
		local cash = ''
		cash = format('%.2d'..cfg.L.goldabbrev..' %.2d'..cfg.L.silverabbrev..' %.2d'..cfg.L.copperabbrev, gold, silver, copper)		
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
		
		Text:SetText(hexa..'Cash: '..hexb..formatMoney(NewMoney))
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
			local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(cfg.L.datatext_session)
			GameTooltip:AddDoubleLine(cfg.L.datatext_earned, formatMoney(Profit), 1, 1, 1, 1, 1, 1)
			GameTooltip:AddDoubleLine(cfg.L.datatext_spent, formatMoney(Spent), 1, 1, 1, 1, 1, 1)
			if Profit < Spent then
				GameTooltip:AddDoubleLine(cfg.L.datatext_deficit, formatMoney(Profit-Spent), 1, 0, 0, 1, 1, 1)
			elseif (Profit-Spent)>0 then
				GameTooltip:AddDoubleLine(cfg.L.datatext_profit, formatMoney(Profit-Spent), 0, 1, 0, 1, 1, 1)
			end				
			GameTooltip:AddLine' '								
		
			local totalGold = 0				
			GameTooltip:AddLine(cfg.L.datatext_character)			
			local thisRealmList = bdcUI.gold[myPlayerRealm];
			for k,v in pairs(thisRealmList) do
				GameTooltip:AddDoubleLine(k, FormatTooltipMoney(v), 1, 1, 1, 1, 1, 1)
				totalGold=totalGold+v;
			end 
			GameTooltip:AddLine' '
			GameTooltip:AddLine(cfg.L.datatext_server)
			GameTooltip:AddDoubleLine(cfg.L.datatext_totalgold, FormatTooltipMoney(totalGold), 1, 1, 1, 1, 1, 1)

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

-----------------------------
-- Datatext for Guild Roster
-----------------------------

local USE_EPGP = true

if cfg.datatext.guild and cfg.datatext.guild > 0 then	

	function sortGuildByRank(a,b)

		texta = string.format("%02d",a.rankIndex)..a.name
		textb = string.format("%02d",b.rankIndex)..b.name

		return texta<textb
	end

	function sortGuildByName(a,b)
		texta = a.name
		textb = b.name

		return texta<textb
	end

	function sortGuildByZone(a,b)

		texta = a.zone..a.name
		textb = b.zone..b.name

		return texta<textb
	end

	sortGuildFunc = sortGuildByName

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local tthead = {r=0.4,g=0.78,b=1}
	local ttsubh = {r=0.75,g=0.9,b=1}

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.guild, Text)

	local BASE_GP = 1
	local function ParseGuildInfo(info)
		BASE_GP = 1
		local v
		local lines = {string.split("\n", info)}
		for _,line in pairs(lines) do
			v = string.match(line,"@BASE_GP:(%d+)")
			if(v) then
				BASE_GP = v
				break
			end
		end
	end

	local displayString = string.join("", hexa..GUILD..hexb, ": ", "%d|r")

	local function Update(self, event, ...)	

		if (event=="ADDON_LOADED") then

			if USE_EPGP then
				ParseGuildInfo(GetGuildInfoText())
			end

		else
			if IsInGuild() then
				GuildRoster()
				local numOnline = (GetNumGuildMembers())
				local total = (GetNumGuildMembers())
				local numOnline = 0
				for i = 1, total do
					local _, _, _, _, _, _, _, _, online, _, _ = GetGuildRosterInfo(i)
					if online then
						numOnline = numOnline + 1
					end
				end 			

				Text:SetFormattedText(displayString, numOnline)
				self:SetAllPoints(Text)
			else
				Text:SetText(hexa..cfg.L.datatext_noguild..hexb)
			end
		end
	end

	local guildMenuFrame = nil

	function setGuildSort(self,fun)

		guildMenuFrame:Hide()
		sortGuildFunc = fun
	end	

	local guildMenuList = {
		{ text = "Select an Option", isTitle = true,notCheckable=true},
		{ text = "Invite", hasArrow = true,notCheckable=true,
			menuList = {
				{ text = "Option 3", func = function() print("You've chosen option 3"); end }
			}
		},
		{ text = "Whisper", hasArrow = true,notCheckable=true,
			menuList = {
				{ text = "Option 4", func = function() print("You've chosen option 4"); end }
			}
		},
		{ text = "Sort", hasArrow = true,notCheckable=true,
			menuList = {
				{ notCheckable=true,text = "Name", func = setGuildSort, arg1=sortGuildByName},
				{ notCheckable=true,text = "Zone", func = setGuildSort, arg1=sortGuildByZone},
				{ notCheckable=true,text = "Rank", func = setGuildSort, arg1=sortGuildByRank},
			}
		}
	}

	if USE_EPGP then

		function sortEPGP(a,b)
			if a.PR == b.PR then
				return a.name < b.name
			else
				return a.PR>b.PR
			end
		end

		guildMenuList[4].menuList[4] = { notCheckable=true,text = "EPGP (PR)", func = setGuildSort, arg1=sortEPGP}
	end

	function inviteFriendClick(self, arg1, arg2, checked)
		guildMenuFrame:Hide()
		InviteUnit(arg1)
	end

	function whisperFriendClick(self,arg1,arg2,checked)
		guildMenuFrame:Hide()
		SetItemRef( "player:"..arg1, ("|Hplayer:%1$s|h[%1$s]|h"):format(arg1), "LeftButton" )
	end

	local menuCountWhispers = 0
	local menuCountInvites = 0

	Stat:SetScript("OnMouseUp", function(self, btn)
		if btn == "RightButton" then
			GameTooltip:Hide()

			if(guildMenuFrame==nil) then
				guildMenuFrame = CreateFrame("Frame", "guildMenuFrame", nil, "UIDropDownMenuTemplate")
				guildMenuFrame.relativeTo = self
			else
				guildMenuFrame:Show()
			end			

			EasyMenu(guildMenuList, guildMenuFrame, "cursor", 0, 0, "MENU", 2)
		end
	end)	

	local function EPGPDecodeNote(note)
	  if note then
		if note == "" then
		  return 0, 0
		else
		  local ep, gp = string.match(note, "^(%d+),(%d+)$")
		  if ep then
			return tonumber(ep), tonumber(gp)
		  end
		end
	  end
	end	

	Stat:RegisterEvent("ADDON_LOADED")
	Stat:RegisterEvent("GUILD_ROSTER_UPDATE")
	Stat:RegisterEvent("PLAYER_GUILD_UPDATE")
	Stat:RegisterEvent("GUILD_PERK_UPDATE")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("CHAT_MSG_SYSTEM")
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() or self.altdow then					

			if IsInGuild() then			

				menuCountWhispers = 0
				menuCountInvites = 0

				guildMenuList[2].menuList = {}
				guildMenuList[3].menuList = {}

				colors = {
					note = { .14, .76, .15 },
					officerNote = { 1, .56, .25 }
				}	

				local r,g,b = unpack(colors.officerNote)
				local officerColor = ("\124cff%.2x%.2x%.2x"):format( r*255, g*255, b*255 )
				r,g,b = unpack(colors.note)
				local noteColor = ("\124cff%.2x%.2x%.2x"):format( r*255, g*255, b*255 )

				self.hovered = true
				GuildRoster()
				local name, rank,rankIndex, level, zone, note, officernote, EP,GP,PR, connected, status, class, zone_r, zone_g, zone_b, classc, levelc,grouped
				local online, total, gmotd = 0, GetNumGuildMembers(true), GetGuildRosterMOTD()
				for i = 0, total do if select(9, GetGuildRosterInfo(i)) then online = online + 1 end end
				
				local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
				GameTooltip:SetOwner(panel, anchor, xoff, yoff)
				GameTooltip:ClearAllPoints()
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine(GetGuildInfo'player',format("%s: %d/%d",GUILD,online,total),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
				GameTooltip:AddLine(' ')
				if gmotd ~= "" then GameTooltip:AddLine(format("  %s |cffaaaaaa- |cffffffff%s",GUILD_MOTD,gmotd),ttsubh.r,ttsubh.g,ttsubh.b,1) end
				if online > 1 then
					GameTooltip:AddLine' '
					sortable = {}
					for i = 1, total do
						tabletemp = {}
						tabletemp.index=i
						tabletemp.name, tabletemp.rank, tabletemp.rankIndex , tabletemp.level, _, tabletemp.zone, tabletemp.note, tabletemp.officernote, tabletemp.connected, tabletemp.status, tabletemp.class = GetGuildRosterInfo(i)

						if tabletemp.zone==nil then
							tabletemp.zone = "Unknow Zone"
						end

						if USE_EPGP then
							if tabletemp.officernote then
								tabletemp.EP,tabletemp.GP = EPGPDecodeNote(tabletemp.officernote)
								if(tabletemp.EP) then

									tabletemp.GP = tabletemp.GP + BASE_GP
									tabletemp.PR = tabletemp.EP / tabletemp.GP
									tabletemp.officernote = format("EP: %d GP: %d PR:%.2f",tabletemp.EP,tabletemp.GP,tabletemp.PR)
								else
									tabletemp.EP = 0
									tabletemp.GP = 0
									tabletemp.PR = -1
								end
							end
						end

						if tabletemp.connected~=nil and tabletemp.connected==1 then
							table.insert(sortable,tabletemp)
						end

					end

					table.sort(sortable,sortGuildFunc)

					for i,v in ipairs(sortable) do
						if online <= 1 then
							if online > 1 then GameTooltip:AddLine(format("+ %d More...", online - modules.Guild.maxguild),ttsubh.r,ttsubh.g,ttsubh.b) end
							break
						end						

						name = v.name
						rank = v.rank
						rankIndex = v.rankIndex
						level = v.level
						zone = v.zone
						note = v.note
						officernote = v.officernote
						connected = v.connected
						status = v.status
						class = v.class

						if connected then

							if GetRealZoneText() == zone then zone_r, zone_g, zone_b = 0.3, 1.0, 0.3 else zone_r, zone_g, zone_b = 0.65, 0.65, 0.65 end
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class], GetQuestDifficultyColor(level)

							notes = format(" %s%s",noteColor,note)
							if officernote ~= "" then
								notes = notes .. format(" %s%s",officerColor,officernote)
							end
							rank = noteColor..rank

							if (UnitInParty(name) or UnitInRaid(name)) and (name ~= UnitName'player') then
								grouped = "|cffaaaaaa*|r"
							else
								grouped = ""
								if name ~= UnitName'player' then
									menuCountInvites = menuCountInvites +1
									guildMenuList[2].menuList[menuCountInvites] = {text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r",levelc.r*255,levelc.g*255,levelc.b*255,level,classc.r*255,classc.g*255,classc.b*255,name), arg1 = name,notCheckable=true, func = inviteFriendClick}
								end
							end

							GameTooltip:AddDoubleLine(format("|cff%02x%02x%02x%d|r %s%s%s%s",levelc.r*255,levelc.g*255,levelc.b*255,level,name,grouped,notes,' '..status),zone.." "..rank,classc.r,classc.g,classc.b,zone_r,zone_g,zone_b)

							if name ~= UnitName'player' then
								menuCountWhispers = menuCountWhispers + 1

								guildMenuList[3].menuList[menuCountWhispers] = {text = format("|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r",levelc.r*255,levelc.g*255,levelc.b*255,level,classc.r*255,classc.g*255,classc.b*255,name), arg1 = name,notCheckable=true, func = whisperFriendClick}
							end

						end
					end
				end
				GameTooltip:Show()
			end
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnMouseDown", function(self, btn)
		if btn == "LeftButton" then
			if not GuildFrame and IsInGuild() then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() end
		end)
	Stat:SetScript("OnEvent", Update)
end

----------------------------
-- Datatext for HPS Feed... 
----------------------------

if cfg.datatext.hps_text and cfg.datatext.hps_text > 0 then
	local events = {SPELL_HEAL = true, SPELL_PERIODIC_HEAL = true}
	local HPS_FEED = CreateFrame('Frame')
	local player_id = UnitGUID('player')
	local actual_heals_total, cmbt_time = 0
 
	local hText = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	hText:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	hText:SetText('0 ',cfg.L.datatext_hps)
 
	PP(cfg.datatext.hps_text, hText)
 
	HPS_FEED:EnableMouse(true)
	HPS_FEED:SetFrameStrata('BACKGROUND')
	HPS_FEED:SetFrameLevel(3)
	HPS_FEED:SetHeight(20)
	HPS_FEED:SetWidth(100)
	HPS_FEED:SetAllPoints(hText)
 
	HPS_FEED:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)
	HPS_FEED:RegisterEvent('PLAYER_LOGIN')
 
	HPS_FEED:SetScript('OnUpdate', function(self, elap)
		if UnitAffectingCombat('player') then
			HPS_FEED:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
			cmbt_time = cmbt_time + elap
		else
			HPS_FEED:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
		end
		hText:SetText(get_hps())
	end)
 
	function HPS_FEED:PLAYER_LOGIN()
		HPS_FEED:RegisterEvent('PLAYER_REGEN_ENABLED')
		HPS_FEED:RegisterEvent('PLAYER_REGEN_DISABLED')
		player_id = UnitGUID('player')
		HPS_FEED:UnregisterEvent('PLAYER_LOGIN')
	end
 
	-- handler for the combat log. used http://www.wowwiki.com/API_COMBAT_LOG_EVENT for api
	function HPS_FEED:COMBAT_LOG_EVENT_UNFILTERED(...)         
		-- filter for events we only care about. i.e heals
		if not events[select(2, ...)] then return end
		if event == 'PLAYER_REGEN_DISABLED' then return end

		-- only use events from the player
		local id = select(4, ...)
		if id == player_id then
			amount_healed = select(13, ...)
			amount_over_healed = select(14, ...)
			-- add to the total the healed amount subtracting the overhealed amount
			actual_heals_total = actual_heals_total + math.max(0, amount_healed - amount_over_healed)
		end
	end
	
 	function get_hps()
		if (actual_heals_total == 0) then
			return ('0 '..hexa..cfg.L.datatext_hps..hexb)
		else
			return string.format('%.1f '..hexa..cfg.L.datatext_hps..hexb, (actual_heals_total or 0) / (cmbt_time or 1))
		end
	end
 
	function HPS_FEED:PLAYER_REGEN_ENABLED()
		hText:SetText(get_hps)
	end
   
	function HPS_FEED:PLAYER_REGEN_DISABLED()
		cmbt_time = 0
		actual_heals_total = 0
	end
     
	HPS_FEED:SetScript('OnMouseDown', function (self, button, down)
		cmbt_time = 0
		actual_heals_total = 0
	end)
 


end


---------------------------
-- Datatext for Micro Menu
---------------------------

if cfg.datatext.micromenu and cfg.datatext.micromenu > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.micromenu, Text)

	local function OnEvent(self, event, ...)
		Text:SetText(hexa..MAINMENU_BUTTON..hexb)
		self:SetAllPoints(Text)
	end

	local function OpenMenu()
		local menuFrame = CreateFrame("Frame", "DataTextMicroMenu", UIParent, "UIDropDownMenuTemplate")
		local menuList = {
			{text = CHARACTER_BUTTON,
			func = function() ToggleCharacter("PaperDollFrame") end},
			{text = SPELLBOOK_ABILITIES_BUTTON,
			func = function() ToggleFrame(SpellBookFrame) end},
			{text = TALENTS_BUTTON,
			func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end if not GlyphFrame then LoadAddOn("Blizzard_GlyphUI") end PlayerTalentFrame_Toggle() end},
			{text = ACHIEVEMENT_BUTTON,
			func = function() ToggleAchievementFrame() end},
			{text = QUESTLOG_BUTTON,
			func = function() ToggleFrame(QuestLogFrame) end},
			{text = SOCIAL_BUTTON,
			func = function() ToggleFriendsFrame(1) end},
			{text = PLAYER_V_PLAYER,
			func = function() ToggleFrame(PVPFrame) end},
			{text = ACHIEVEMENTS_GUILD_TAB,
			func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() end end},
			{text = LFG_TITLE,
			func = function() ToggleFrame(LFDParentFrame) end},
			{text = L_LFRAID,
			func = function() ToggleFrame(LFRParentFrame) end},
			{text = HELP_BUTTON,
			func = function() ToggleHelpFrame() end},
			{text = L_CALENDAR,
			func = function()
			if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
				Calendar_Toggle()
			end},
		}

		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	end

	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() OpenMenu() end)
end

---------------------------
--Datatext for Professions
---------------------------
if cfg.datatext.pro and cfg.datatext.pro > 0 then

	local Stat = CreateFrame('Frame')
	Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)
	Stat.tooltip = false

	local Text  = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.pro, Text)

	local function Update(self)
		for _, v in pairs({GetProfessions()}) do
			if v ~= nil then
				local name, texture, rank, maxRank = GetProfessionInfo(v)
				Text:SetFormattedText(hexa..'Profession'..hexb)
			end
		end
		self:SetAllPoints(Text)
	end

	Stat:SetScript('OnEnter', function()
		local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(hexa..myname.."'s"..hexb..' Professions', .4,.78,1)
		for _, v in pairs({GetProfessions()}) do
			if v ~= nil then
				local name, texture, rank, maxRank = GetProfessionInfo(v)
				GameTooltip:AddDoubleLine(name, rank..' / '..maxRank,.75,.9,1,.3,1,.3)
			end
		end
		GameTooltip:Show()
	end)


	Stat:SetScript('OnMouseDown', function(self, btn)

		if btn == 'LeftButton' then
			ToggleFrame(SpellBookFrame)
		end

	end)


	Stat:SetScript('OnUpdate', Update)
	Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)
end

------------------------
-- Datatext for Recount 
------------------------
local currentFightDPS

if cfg.datatext.recount and cfg.datatext.recount > 0 then 

	local RecountDPS = CreateFrame("Frame")
	RecountDPS:EnableMouse(true)
	RecountDPS:SetFrameStrata("MEDIUM")
	RecountDPS:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.recount, Text)
	RecountDPS:SetAllPoints(Text)

	function OnEvent(self, event, ...)
		if event == "PLAYER_LOGIN" then
			if IsAddOnLoaded("Recount") then
				RecountDPS:RegisterEvent("PLAYER_REGEN_ENABLED")
				RecountDPS:RegisterEvent("PLAYER_REGEN_DISABLED")
				myname = UnitName("player")
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
		if cfg.datatext.recountraiddps == true then
			-- show raid dps
			_, dps = RecountDPS:getRaidValuePerSecond(Recount.db.profile.CurDataSet)
			return dps
		else
			return RecountDPS.getValuePerSecond()
		end
	end

	-- quick dps calculation from recount's data
	function RecountDPS:getValuePerSecond()
		local _, dps = Recount:MergedPetDamageDPS(Recount.db2.combatants[myname], Recount.db.profile.CurDataSet)
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
		if IsAddOnLoaded("Recount") then
			local damage, dps = Recount:MergedPetDamageDPS(Recount.db2.combatants[myname], Recount.db.profile.CurDataSet)
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

--------------------------
-- Datatext for Spec Swap
--------------------------

if cfg.datatext.spec and cfg.datatext.spec > 0 then

	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.spec, Text)

	local talent = {}
	local active
	local talentString = string.join('', '|cffFFFFFF%s|r ')
	local talentStringTip = string.join('', '|cffFFFFFF%s:|r ', '%d|r/',  '%d|r/',  '%d|r')
	local activeString = string.join('', '|cff00FF00' , ACTIVE_PETS, '|r')
	local inactiveString = string.join('', '|cffFF0000', FACTION_INACTIVE, '|r')



	local function LoadTalentTrees()
		for i = 1, GetNumTalentGroups(false, false) do
			talent[i] = {} -- init talent group table
			for j = 1, GetNumTalentTabs(false, false) do
				talent[i][j] = select(5, GetTalentTabInfo(j, false, false, i))
			end
		end
	end

	local int = 1
	local function Update(self, t)
		int = int - t
		if int > 0 or not GetPrimaryTalentTree() then return end

		active = GetActiveTalentGroup(false, false)
		Text:SetFormattedText(talentString, hexa..select(2, GetTalentTabInfo(GetPrimaryTalentTree(false, false, active)))..hexb)
		int = 1

		-- disable script	
		self:SetScript('OnUpdate', nil)
	end


	Stat:SetScript('OnEnter', function(self)
		if InCombatLockdown() then return end

		local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)

		GameTooltip:ClearLines()
		for i = 1, GetNumTalentGroups() do
			if GetPrimaryTalentTree(false, false, i) then
				GameTooltip:AddLine(string.join(' ', string.format(talentStringTip, select(2, GetTalentTabInfo(GetPrimaryTalentTree(false, false, i))), talent[i][1], talent[i][2], talent[i][3]), (i == active and activeString or inactiveString)),1,1,1)
			end
		end
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
			SetActiveTalentGroup(active == 1 and 2 or 1)
		elseif button == "RightButton" then
			ToggleTalentFrame()
		end
	end)
end


-----------------------
-- Datatext for Stat 1 
-----------------------

if cfg.datatext.stat1 and cfg.datatext.stat1 > 0 then

	local Stat = CreateFrame("Frame")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.stat1, Text)

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
		local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		
		if Role == "Tank" then
			if targetlv > 1 then
				GameTooltip:AddDoubleLine(cfg.L.datatext_avoidancebreakdown, string.join("", " (", cfg.L.datatext_lvl, " ", targetlv, ")"))
			elseif targetlv == -1 then
				GameTooltip:AddDoubleLine(cfg.L.datatext_avoidancebreakdown, string.join("", " (", cfg.L.datatext_boss, ")"))
			else
				GameTooltip:AddDoubleLine(cfg.L.datatext_avoidancebreakdown, string.join("", " (", cfg.L.datatext_lvl, " ", playerlv, ")"))
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
			local hit =  myclass == "HUNTER" and GetCombatRating(CR_HIT_RANGED) or GetCombatRating(CR_HIT_MELEE)
			local hitBonus =  myclass == "HUNTER" and GetCombatRatingBonus(CR_HIT_RANGED) or GetCombatRatingBonus(CR_HIT_MELEE)
		
			GameTooltip:AddDoubleLine(STAT_HIT_CHANCE, format(modifierString, hit, hitBonus), 1, 1, 1)
			
			--Hunters don't use expertise
			if myclass ~= "HUNTER" then
				local expertisePercent, offhandExpertisePercent = GetExpertisePercent()
				expertisePercent = format("%.2f", expertisePercent)
				offhandExpertisePercent = format("%.2f", offhandExpertisePercent)
				
				local expertisePercentDisplay
				if IsDualWielding() then
					expertisePercentDisplay = expertisePercent.."% / "..offhandExpertisePercent.."%"
				else
					expertisePercentDisplay = expertisePercent.."%"
				end
				GameTooltip:AddDoubleLine(COMBAT_RATING_NAME24, format('%d (+%s)', GetCombatRating(CR_EXPERTISE), expertisePercentDisplay), 1, 1, 1)
			end
			
			local haste = myclass == "HUNTER" and GetCombatRating(CR_HASTE_RANGED) or GetCombatRating(CR_HASTE_MELEE)
			local hasteBonus = myclass == "HUNTER" and GetCombatRatingBonus(CR_HASTE_RANGED) or GetCombatRatingBonus(CR_HASTE_MELEE)
			
			GameTooltip:AddDoubleLine(STAT_HASTE, format(modifierString, haste, hasteBonus), 1, 1, 1)
		end
		
		local masteryspell
		if GetCombatRating(CR_MASTERY) ~= 0 and GetPrimaryTalentTree() then
			if myclass == "DRUID" then
				if Role == "Melee" then
					masteryspell = select(2, GetTalentTreeMasterySpells(GetPrimaryTalentTree()))
				elseif Role == "Tank" then
					masteryspell = select(1, GetTalentTreeMasterySpells(GetPrimaryTalentTree()))
				else
					masteryspell = GetTalentTreeMasterySpells(GetPrimaryTalentTree())
				end
			else
				masteryspell = GetTalentTreeMasterySpells(GetPrimaryTalentTree())
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
		
		if myclass == "DRUID" then
			parry = 0
			block = 0
		elseif myclass == "DEATHKNIGHT" then
			block = 0
		end
		avoidance = (dodge+parry+block+basemisschance)
		
		Text:SetFormattedText(displayFloatString, hexa..cfg.L.datatext_playeravd..hexb, avoidance)
		--Setup Tooltip
		self:SetAllPoints(Text)
	end

	local function UpdateCaster(self)
		if GetSpellBonusHealing() > GetSpellBonusDamage(7) then
			spellpwr = GetSpellBonusHealing()
		else
			spellpwr = GetSpellBonusDamage(7)
		end
		
		Text:SetFormattedText(displayNumberString, hexa..cfg.L.datatext_playersp..hexb, spellpwr)
		--Setup Tooltip
		self:SetAllPoints(Text)
	end

	local function UpdateMelee(self)
		local base, posBuff, negBuff = UnitAttackPower("player");
		local effective = base + posBuff + negBuff;
		local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player");
		local Reffective = Rbase + RposBuff + RnegBuff;
			
		if myclass == "HUNTER" then
			pwr = Reffective
		else
			pwr = effective
		end
		
		Text:SetFormattedText(displayNumberString, hexa..cfg.L.datatext_playerap..hexb, pwr)      
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

-----------------------
-- Datatext for Stat 2
-----------------------

if cfg.datatext.stat2 and cfg.datatext.stat2 > 0 then

	local Stat = CreateFrame("Frame")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.stat2, Text)

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
		local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		
		if Role == "Tank" then
			AddTooltipHeader(cfg.L.datatext_mitigation)
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
			
			local baseResistance, effectiveResistance, posResitance, negResistance
			for i = 2, 6 do
				baseResistance, effectiveResistance, posResitance, negResistance = UnitResistance("player", i)
				GameTooltip:AddDoubleLine(_G["DAMAGE_SCHOOL"..(i+1)], format(chanceString, (effectiveResistance / (effectiveResistance + (500 + level + 2.5))) * 100),1,1,1)
			end
			
			local spellpen = GetSpellPenetration()
			if (myclass == "SHAMAN" or Role == "Caster") and spellpen > 0 then
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

		Text:SetFormattedText(displayFloatString, hexa..cfg.L.datatext_playercrit..hexb, spellcrit)
		--Setup Tooltip
		self:SetAllPoints(Text)
	end

	local function UpdateMelee(self)
		local meleecrit = GetCritChance()
		local rangedcrit = GetRangedCritChance()
		local critChance
			
		if myclass == "HUNTER" then    
			critChance = rangedcrit
		else
			critChance = meleecrit
		end
		
		Text:SetFormattedText(displayFloatString, hexa..cfg.L.datatext_playercrit..hexb, critChance)
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

---------------------------------------------------
-- Datatext for System Stats
---------------------------------------------------

if cfg.datatext.system and cfg.datatext.system > 0 then

	local Stat = CreateFrame("Frame")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)
	Stat.tooltip = false

	local Text  = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.system, Text)

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
			local displayFormat = string.join("", hexa..cfg.L.datatext_fps..hexb, statusColors[fpscolor], "%d|r", hexa..cfg.L.datatext_ms..hexb, statusColors[latencycolor], "%d|r")
			Text:SetFormattedText(displayFormat, framerate, latency)
			int2 = 1
		end
	end
	Stat:SetScript("OnMouseDown", function () collectgarbage("collect") Update(Stat, 20) end)
	Stat:SetScript("OnEnter", function(self)
		local bandwidth = GetAvailableBandwidth()
		local _, _, latencyHome, latencyWorld = GetNetStats() 
		local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		if cfg.datatext.fps.enable == true then 
			if cfg.datatext.fps.home == true then
				GameTooltip:AddDoubleLine(cfg.L.datatext_homelatency, string.format(homeLatencyString, latencyHome), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
			elseif cfg.datatext.fps.world == true then
				GameTooltip:AddDoubleLine(cfg.L.datatext_worldlatency, string.format(worldLatencyString, latencyWorld), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
			elseif cfg.datatext.fps.both == true then
				GameTooltip:AddDoubleLine(cfg.L.datatext_homelatency, string.format(homeLatencyString, latencyHome), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
				GameTooltip:AddDoubleLine(cfg.L.datatext_worldlatency, string.format(worldLatencyString, latencyWorld), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
			end
		end
		if bandwidth ~= 0 then
			GameTooltip:AddDoubleLine(cfg.L.datatext_bandwidth , string.format(bandwidthString, bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
			GameTooltip:AddDoubleLine(cfg.L.datatext_download , string.format(percentageString, GetDownloadedPercentage() *100),0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
			GameTooltip:AddLine(" ")
		end
		local totalMemory = UpdateMemory()
		GameTooltip:AddDoubleLine(cfg.L.datatext_totalmemusage, formatMem(totalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
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

---------------------
-- Datatext for TIME
---------------------

if cfg.datatext.wowtime and cfg.datatext.wowtime > 0 then

	local europeDisplayFormat = string.join("", "%02d", ":|r%02d")
	local ukDisplayFormat = string.join("", "", "%d", ":|r%02d", " %s|r")
	local timerLongFormat = "%d:%02d:%02d"
	local timerShortFormat = "%d:%02d"
	local lockoutInfoFormat = "%s |cffaaaaaa(%s%s, %s/%s)"
	local formatBattleGroundInfo = "%s: "
	local lockoutColorExtended, lockoutColorNormal = { r=0.3,g=1,b=0.3 }, { r=1,g=1,b=1 }
	local difficultyInfo = { "N", "N", "H", "H" }
	local curHr, curMin, curAmPm

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("MEDIUM")
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.wowtime, Text)

	local APM = { TIMEMANAGER_PM, TIMEMANAGER_AM }

	local function CalculateTimeValues(tt)
		if tt == nil then tt = false end
		local Hr, Min, AmPm
		if tt == true then
			if cfg.datatext.localtime == true then
				Hr, Min = GetGameTime()
				if cfg.datatext.time24 == true then
					return Hr, Min, -1
				else
					if Hr>=12 then
						if Hr>12 then Hr = Hr - 12 end
						AmPm = 1
					else
						if Hr == 0 then Hr = 12 end
						AmPm = 2
					end
					return Hr, Min, AmPm
				end			
			else
				local Hr24 = tonumber(date("%H"))
				Hr = tonumber(date("%I"))
				Min = tonumber(date("%M"))
				if cfg.datatext.time24 == true then
					return Hr24, Min, -1
				else
					if Hr24>=12 then AmPm = 1 else AmPm = 2 end
					return Hr, Min, AmPm
				end
			end
		else
			if cfg.datatext.localtime == true then
				local Hr24 = tonumber(date("%H"))
				Hr = tonumber(date("%I"))
				Min = tonumber(date("%M"))
				if cfg.datatext.time24 == true then
					return Hr24, Min, -1
				else
					if Hr24>=12 then AmPm = 1 else AmPm = 2 end
					return Hr, Min, AmPm
				end
			else
				Hr, Min = GetGameTime()
				if cfg.datatext.time24 == true then
					return Hr, Min, -1
				else
					if Hr>=12 then
						if Hr>12 then Hr = Hr - 12 end
						AmPm = 1
					else
						if Hr == 0 then Hr = 12 end
						AmPm = 2
					end
					return Hr, Min, AmPm
				end
			end	
		end
	end

	local function CalculateTimeLeft(time)
			local hour = floor(time / 3600)
			local min = floor(time / 60 - (hour*60))
			local sec = time - (hour * 3600) - (min * 60)
			
			return hour, min, sec
	end

	local function formatResetTime(sec,table)
		local table = table or {}
		local d,h,m,s = ChatFrame_TimeBreakDown(floor(sec))
		local string = gsub(gsub(format(" %dd %dh %dm "..((d==0 and h==0) and "%ds" or ""),d,h,m,s)," 0[dhms]"," "),"%s+"," ")
		local string = strtrim(gsub(string, "([dhms])", {d=table.days or "d",h=table.hours or "h",m=table.minutes or "m",s=table.seconds or "s"})," ")
		return strmatch(string,"^%s*$") and "0"..(table.seconds or L"s") or string
	end

	local int = 1
	local function Update(self, t)
		int = int - t
		if int > 0 then return end
		
		local Hr, Min, AmPm = CalculateTimeValues()
		
		if CalendarGetNumPendingInvites() > 0 then
			Text:SetTextColor(1, 0, 0)
		else
			Text:SetTextColor(1, 1, 1)
		end
		
		-- no update quick exit
		if (Hr == curHr and Min == curMin and AmPm == curAmPm) then
			int = 2
			return
		end
		
		curHr = Hr
		curMin = Min
		curAmPm = AmPm
			
		if AmPm == -1 then
			Text:SetFormattedText(europeDisplayFormat, Hr, Min)
		else
			Text:SetFormattedText(ukDisplayFormat, Hr, Min, hexa..APM[AmPm]..hexb)
		end

		self:SetAllPoints(Text)
		int = 2
	end

	Stat:SetScript("OnEnter", function(self)
		OnLoad = function(self) RequestRaidInfo() end
		local anchor, panel, xoff, yoff = DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()

		local localizedName, isActive, canQueue, startTime, canEnter
		for i = 1, GetNumWorldPVPAreas() do
			_, localizedName, isActive, canQueue, startTime, canEnter = GetWorldPVPAreaInfo(i)
			if canEnter then
				if isActive then
					startTime = WINTERGRASP_IN_PROGRESS
				elseif startTime == nil then
					startTime = QUEUE_TIME_UNAVAILABLE
				else
					local hour, min, sec = CalculateTimeLeft(startTime)
					if hour > 0 then 
						startTime = string.format(timerLongFormat, hour, min, sec) 
					else 
						startTime = string.format(timerShortFormat, min, sec)
					end
				end
				GameTooltip:AddDoubleLine(format(formatBattleGroundInfo, localizedName), startTime)	
			end
		end	

		local timeText
		local Hr, Min, AmPm = CalculateTimeValues(true)

		if cfg.datatext.localtime == true then
			timeText = cfg.L.datatext_servertime
		else
			timeText = cfg.L.datatext_localtime
		end
		
		if AmPm == -1 then
			GameTooltip:AddDoubleLine(timeText, string.format(europeDisplayFormat, Hr, Min))
		else
			GameTooltip:AddDoubleLine(timeText, string.format(ukDisplayFormat, Hr, Min, APM[AmPm]))
		end
		
		local oneraid, lockoutColor
		for i = 1, GetNumSavedInstances() do
			local name, _, reset, difficulty, locked, extended, _, isRaid, maxPlayers, _, numEncounters, encounterProgress  = GetSavedInstanceInfo(i)
			if isRaid and (locked or extended) then
				local tr,tg,tb,diff
				if not oneraid then
					GameTooltip:AddLine(" ")
					GameTooltip:AddLine(cfg.L.datatext_savedraid)
					oneraid = true
				end
				if extended then lockoutColor = lockoutColorExtended else lockoutColor = lockoutColorNormal end
				GameTooltip:AddDoubleLine(format(lockoutInfoFormat, name, maxPlayers, difficultyInfo[difficulty],encounterProgress,numEncounters), formatResetTime(reset), 1,1,1, lockoutColor.r,lockoutColor.g,lockoutColor.b)
			end
		end
		GameTooltip:Show()
	end)

	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:RegisterEvent("CALENDAR_UPDATE_PENDING_INVITES")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnUpdate", Update)
	Stat:RegisterEvent("UPDATE_INSTANCE_INFO")
	Stat:SetScript("OnMouseDown", function(self, btn)
		if btn == 'RightButton'  then
			ToggleTimeManager()
		else
			GameTimeFrame:Click()
		end
	end)
	Update(Stat, 10)
end

---------------------------------------------------
-- Datatext for Zone Text
---------------------------------------------------
if cfg.datatext.zone and cfg.datatext.zone > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text = DataPanelLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfg.media.font, cfg.datatext.fontsize,'THINOUTLINE')
	PP(cfg.datatext.zone, Text)

	local function Update(self)
		if GetMinimapZoneText() == "Putricide's Laboratory of Alchemical Horrors and Fun" then
			Text:SetText("Putricides's Laboratory")
		else
			Text:SetText(hexa..GetMinimapZoneText()..hexb)
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end