local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Datapanel = BasicUI:NewModule("Datapanel", "AceEvent-3.0")

---------------
-- Datapanel --
---------------
function BasicUI_Datapanel:OnEnable()
	local db = BasicUI.db.profile
	
	if db.datapanel.enable ~= true then return end
	
	local ccolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
	local myclass = UnitClass("player")
	local myname, _ = UnitName("player")
	local myrealm = GetRealmName()
	local getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))
	local toc = select(4, GetBuildInfo())
	local locale = GetLocale()
	local currentFightDPS
	
	PP = function(p, obj)

		local left = PanelLeft
		local center = PanelCenter
		local right = PanelRight
		
			-- Left Panel Data
		if p == 1 then
			obj:SetParent(left)
			obj:SetHeight(left:GetHeight())
			obj:SetPoint('LEFT', left, 30, 0)
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
			obj:SetPoint('RIGHT', left, -30, 0)
			obj:SetPoint('TOP', left)
			obj:SetPoint('BOTTOM', left)
			
			-- Center Panel Data
		elseif p == 4 then
			obj:SetParent(center)
			obj:SetHeight(center:GetHeight())
			obj:SetPoint('LEFT', center, 30, 0)
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
			obj:SetPoint('RIGHT', center, -30, 0)
			obj:SetPoint('TOP', center)
			obj:SetPoint('BOTTOM', center)
			
			-- Right Panel Data
		elseif p == 7 then
			obj:SetParent(right)
			obj:SetHeight(right:GetHeight())
			obj:SetPoint('LEFT', right, 30, 0)
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
			obj:SetPoint('RIGHT', right, -30, 0)
			obj:SetPoint('TOP', right)
			obj:SetPoint('BOTTOM', right)
		end

	end

	DataTextTooltipAnchor = function(self)
		local panel = self:GetParent()
		local anchor = 'GameTooltip'
		local xoff = 1
		local yoff = 3
		
		
		for _, panel in pairs ({
			PanelLeft,
			PanelCenter,
			PanelRight,
		})	do
			if db.datapanel.top == true then
				anchor = 'ANCHOR_BOTTOM'
			else
				anchor = 'ANCHOR_TOP'
			end
		end	
		return anchor, panel, xoff, yoff
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

	SetFontString = function(parent, fontName, fontHeight, fontStyle)
		local fs = parent:CreateFontString(nil, 'OVERLAY')
		fs:SetFont(fontName, fontHeight, fontStyle)
		fs:SetJustifyH('LEFT')
		fs:SetShadowColor(0, 0, 0)
		fs:SetShadowOffset(1.25, -1.25)
		return fs
	end

	function RGBToHex(r, g, b)
		r = r <= 1 and r >= 0 and r or 0
		g = g <= 1 and g >= 0 and g or 0
		b = b <= 1 and b >= 0 and b or 0
		return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
	end

	ShortValue = function(v)
		if v >= 1e6 then
			return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
		elseif v >= 1e3 or v <= -1e3 then
			return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
		else
			return v
		end
	end

	function HexToRGB(hex)
		local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
		return tonumber(rhex, 16), tonumber(ghex, 16), tonumber(bhex, 16)
	end

	--------------
	-- Data Panel
	--------------
	if db.datapanel.enablepanel == true then

		--[[
			All Credit for Datapanel.lua goes to Tuks.
			Tukui = http://www.tukui.org/download.php.
			Edited by Cokedriver.
		]]

		local DataPanel = CreateFrame('Frame', 'DataPanel', UIParent)
		local PanelLeft = CreateFrame('Frame', 'PanelLeft', UIParent)
		local PanelCenter = CreateFrame('Frame', 'PanelCenter', UIParent)
		local PanelRight = CreateFrame('Frame', 'PanelRight', UIParent)
		local BattleGroundPanel = CreateFrame('Frame', 'BattleGroundPanel', UIParent)

		if db.datapanel.panel == "top" then
			DataPanel:SetPoint('TOP', UIParent, 0, 0)
			DataPanel:SetHeight(35)
			DataPanel:SetWidth(getscreenwidth)
			DataPanel:SetFrameStrata('LOW')
			DataPanel:SetFrameLevel(0)
				DataPanel:SetBackdrop({
				bgFile = db.datapanel.background,
				edgeFile = db.datapanel.border,
				edgeSize = 25,
				insets = {left = 5, right = 5, top = 5, bottom = 5}
			})
			DataPanel:SetBackdropColor(0, 0, 0, 1)


			-- Left Panel
			PanelLeft:SetPoint('LEFT', DataPanel, 5, 0)
			PanelLeft:SetHeight(35)
			PanelLeft:SetWidth(getscreenwidth / 3)
			PanelLeft:SetFrameStrata('LOW')
			PanelLeft:SetFrameLevel(1)		

			-- Center Panel
			PanelCenter:SetPoint('CENTER', DataPanel, 0, 0)
			PanelCenter:SetHeight(35)
			PanelCenter:SetWidth(getscreenwidth / 3)
			PanelCenter:SetFrameStrata('LOW')
			PanelCenter:SetFrameLevel(1)		

			-- Right Panel
			PanelRight:SetPoint('RIGHT', DataPanel, -5, 0)
			PanelRight:SetHeight(35)
			PanelRight:SetWidth(getscreenwidth / 3)
			PanelRight:SetFrameStrata('LOW')
			PanelRight:SetFrameLevel(1)		

			-- Battleground Panel
			BattleGroundPanel:SetAllPoints(PanelLeft)
			BattleGroundPanel:SetFrameStrata('LOW')
			BattleGroundPanel:SetFrameLevel(1)
			
		elseif db.datapanel.panel == "bottom" then
			DataPanel:SetPoint('BOTTOM', UIParent, 0, 0)
			DataPanel:SetHeight(35)
			DataPanel:SetWidth(1200)
			DataPanel:SetFrameStrata('LOW')
			DataPanel:SetFrameLevel(0)
			DataPanel:SetBackdrop({
				bgFile = db.datapanel.background,
				edgeFile = db.datapanel.border,
				edgeSize = 25,
				insets = {left = 5, right = 5, top = 5, bottom = 5}
			})
			DataPanel:SetBackdropColor(0, 0, 0, 1)

			
			-- Left Panel
			PanelLeft:SetPoint('LEFT', DataPanel, 5, 0)
			PanelLeft:SetHeight(35)
			PanelLeft:SetWidth(1200 / 3)
			PanelLeft:SetFrameStrata('LOW')
			PanelLeft:SetFrameLevel(1)		

			-- Center Panel
			PanelCenter:SetPoint('CENTER', DataPanel, 0, 0)
			PanelCenter:SetHeight(35)
			PanelCenter:SetWidth(1200 / 3)
			PanelCenter:SetFrameStrata('LOW')
			PanelCenter:SetFrameLevel(1)		

			-- Right panel
			PanelRight:SetPoint('RIGHT', DataPanel, -5, 0)
			PanelRight:SetHeight(35)
			PanelRight:SetWidth(1200 / 3)
			PanelRight:SetFrameStrata('LOW')
			PanelRight:SetFrameLevel(1)		

			-- Battleground Panel
			BattleGroundPanel:SetAllPoints(PanelLeft)
			BattleGroundPanel:SetFrameStrata('LOW')
			BattleGroundPanel:SetFrameLevel(1)
			
		elseif db.datapanel.panel == "shortbar" then	
			DataPanel:SetPoint('BOTTOM', UIParent, 0, 0)
			DataPanel:SetHeight(35)
			DataPanel:SetWidth(725)
			DataPanel:SetFrameStrata('LOW')
			DataPanel:SetFrameLevel(0)
			DataPanel:SetBackdrop({
				bgFile = db.datapanel.background,
				edgeFile = db.datapanel.border,							
				edgeSize = 25,
				insets = {left = 3, right = 3, top = 3, bottom = 3},
			})
			DataPanel:SetBackdropColor(0, 0, 0, 1)
			
			-- Left Panel
			PanelLeft:SetPoint('LEFT', DataPanel, 5, 0)
			PanelLeft:SetHeight(35)
			PanelLeft:SetWidth(725 / 2)
			PanelLeft:SetFrameStrata('LOW')
			PanelLeft:SetFrameLevel(1)				

			-- Right panel
			PanelRight:SetPoint('RIGHT', DataPanel, -5, 0)
			PanelRight:SetHeight(35)
			PanelRight:SetWidth(725 / 2)
			PanelRight:SetFrameStrata('LOW')
			PanelRight:SetFrameLevel(1)		

			-- Battleground Panel
			BattleGroundPanel:SetAllPoints(PanelLeft)
			BattleGroundPanel:SetFrameStrata('LOW')
			BattleGroundPanel:SetFrameLevel(1)	
			
		end




			-- move some frames to make way for the datapanel
		if db.datapanel.panel == "top" then

			local top = function() end
			
			-- Player Frame
			PlayerFrame:ClearAllPoints() 
			PlayerFrame:SetPoint("TOPLEFT", -19, -20) 
			PlayerFrame.ClearAllPoints = top 
			PlayerFrame.SetPoint = top
			
			-- Target Frame
			TargetFrame:ClearAllPoints() 
			TargetFrame:SetPoint("TOPLEFT", 250, -20) 
			TargetFrame.ClearAllPoints = top 
			TargetFrame.SetPoint = top
			
			-- Minimap Frame
			MinimapCluster:ClearAllPoints() 
			MinimapCluster:SetPoint('TOPRIGHT', 0, -32) 
			MinimapCluster.ClearAllPoints = top 
			MinimapCluster.SetPoint = top
			
			-- Buff Frame
			BuffFrame:ClearAllPoints() 
			BuffFrame:SetPoint('TOP', MinimapCluster, -110, -2) 
			BuffFrame.ClearAllPoints = top 
			BuffFrame.SetPoint = top
			
			-- PvP Frame
			WorldStateAlwaysUpFrame:ClearAllPoints() 
			WorldStateAlwaysUpFrame:SetPoint('TOP', 0, -32) 
			WorldStateAlwaysUpFrame.ClearAllpoints = top 
			WorldStateAlwaysUpFrame.Setpoint = top
			

		else

			-- Move some stuff for the panel on bottom.
			
			local bottom = function() end
			
			-- Main Menu Bar
			MainMenuBar:ClearAllPoints() 
			MainMenuBar:SetPoint("BOTTOM", DataPanel, "TOP", 0, -3) 
			MainMenuBar.ClearAllPoints = bottom 
			MainMenuBar.SetPoint = bottom
			
			-- Vehicle Bar
			OverrideActionBar:ClearAllPoints() 
			OverrideActionBar:SetPoint("BOTTOM", DataPanel, "TOP", 0, -3) 
			OverrideActionBar.ClearAllPoints = bottom 
			OverrideActionBar.SetPoint = bottom
			
			-- Pet Battle Bar
			PetBattleFrame.BottomFrame:ClearAllPoints() 
			PetBattleFrame.BottomFrame:SetPoint("BOTTOM", DataPanel, "TOP", 0, -3) 
			PetBattleFrame.BottomFrame.ClearAllPoints = bottom 
			PetBattleFrame.BottomFrame.SetPoint = bottom
			
			-- World Status
			WorldStateAlwaysUpFrame:ClearAllPoints() 
			WorldStateAlwaysUpFrame:SetPoint('TOP', -20, -40) 
			WorldStateAlwaysUpFrame.ClearAllpoints = bottom 
			WorldStateAlwaysUpFrame.Setpoint = bottom
			
			-- Buff Frame
			BuffFrame:ClearAllPoints() 
			BuffFrame:SetPoint('TOP', MinimapCluster, -110, -15) 
			BuffFrame.ClearAllPoints = bottom 
			BuffFrame.SetPoint = bottom	

			
			-- Move the tooltip above the Actionbar
			hooksecurefunc('GameTooltip_SetDefaultAnchor', function(self)
				self:SetPoint('BOTTOMRIGHT', UIParent, -95, 135)
			end)

			
			 -- Move the Bags above the Actionbar
			CONTAINER_WIDTH = 192;
			CONTAINER_SPACING = 5;
			VISIBLE_CONTAINER_SPACING = 3;
			CONTAINER_OFFSET_Y = 70;
			CONTAINER_OFFSET_X = 0;

			 
			function UpdateContainerFrameAnchors()
				local _, xOffset, yOffset, _, _, _, _;
				local containerScale = 1;
				screenHeight = GetScreenHeight() / containerScale;
				-- Adjust the start anchor for bags depending on the multibars
				xOffset = CONTAINER_OFFSET_X / containerScale;
				yOffset = CONTAINER_OFFSET_Y / containerScale + 25;
				-- freeScreenHeight determines when to start a new column of bags
				freeScreenHeight = screenHeight - yOffset;
				column = 0;
				for index, frameName in ipairs(ContainerFrame1.bags) do
					frame = _G[frameName];
					frame:SetScale(containerScale);
					if ( index == 1 ) then
						-- First bag
						frame:SetPoint('BOTTOMRIGHT', frame:GetParent(), 'BOTTOMRIGHT', -xOffset, yOffset );
					elseif ( freeScreenHeight < frame:GetHeight() ) then
						-- Start a new column
						column = column + 1;
						freeScreenHeight = screenHeight - yOffset;
						frame:SetPoint('BOTTOMRIGHT', frame:GetParent(), 'BOTTOMRIGHT', -(column * CONTAINER_WIDTH) - xOffset, yOffset );
					else
						-- Anchor to the previous bag
						frame:SetPoint('BOTTOMRIGHT', ContainerFrame1.bags[index - 1], 'TOPRIGHT', 0, CONTAINER_SPACING);   
					end
					freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING;
				end
			end	 
		end	
	end

	----------------
	-- Color System
	----------------

	--[[

		All Credit for Colors.lua goes to Tuks.
		Tukui = http://www.tukui.org/download.php.
		Edited by Cokedriver.
		
	]]

	if db.misc.classcolor ~= true then
		local r, g, b = db.datapanel.customcolor.r, db.datapanel.customcolor.g, db.datapanel.customcolor.b
		hexa = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
		hexb = "|r"
	else
		hexa = ("|cff%.2x%.2x%.2x"):format(ccolor.r * 255, ccolor.g * 255, ccolor.b * 255)
		hexb = "|r"
	end


	----------------
	-- Player Armor
	----------------
	if db.datapanel.armor and db.datapanel.armor > 0 then
		local effectiveArmor
		
		local Stat = CreateFrame('Frame')
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.armor, Text)

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
	if db.datapanel.avd and db.datapanel.avd > 0 then
		local dodge, parry, block, avoidance, targetlv, playerlv, basemisschance, leveldifference
		local Stat = CreateFrame('Frame')
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.avd, Text)
		
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

	if db.datapanel.bags and db.datapanel.bags > 0 then
		local Stat = CreateFrame('Frame')
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.bags, Text)

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
				str = str..g.."|cFFFFD800g|r "
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
		
		local function FormatTooltipMoney(c)
			if not c then return end
			local str = ""
			if not c or c < 0 then 
				return str 
			end
			
			if c >= 10000 then
				local g = math.floor(c/10000)
				c = c - g*10000
				str = str..g.."|cFFFFD800g|r "
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
			else							-- Gained Moeny
				Profit = Profit + Change
			end
			
			--Text:SetText(formatMoney(NewMoney))
			-- Setup Money Tooltip
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
		Stat:SetScript('OnMouseDown', 
			function()
				if db.datapanel.bag ~= true then
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
				GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Gold")
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
				local thisRealmList = BasicDB.gold[myPlayerRealm];
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
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine(CURRENCY)
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
	if db.datapanel.battleground == true then 

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

		local Stat = CreateFrame('Frame')
		Stat:EnableMouse(true)

		local Text1  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
		Text1:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		Text1:SetPoint('LEFT', BattleGroundPanel, 30, 0)
		Text1:SetHeight(DataPanel:GetHeight())

		local Text2  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
		Text2:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		Text2:SetPoint('CENTER', BattleGroundPanel, 0, 0)
		Text2:SetHeight(DataPanel:GetHeight())

		local Text3  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
		Text3:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		Text3:SetPoint('RIGHT', BattleGroundPanel, -30, 0)
		Text3:SetHeight(DataPanel:GetHeight())

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
						if ( name == myname ) then
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
					PanelLeft:Hide()
				else
					Text1:SetText('')
					Text2:SetText('')
					Text3:SetText('')
					bgframe:Hide()
					PanelLeft:Show()
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
	if db.datapanel.calltoarms and db.datapanel.calltoarms > 0 then
		local Stat = CreateFrame("Frame")
		Stat:EnableMouse(true)
		Stat:SetFrameStrata("MEDIUM")
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.calltoarms, Text)
		
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
			GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Call to Arms")
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
	if db.datapanel.coords and db.datapanel.coords > 0 then
		local Stat = CreateFrame("Frame")
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.coords, Text)

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
	if db.datapanel.dps_text and db.datapanel.dps_text > 0 then
		local events = {SWING_DAMAGE = true, RANGE_DAMAGE = true, SPELL_DAMAGE = true, SPELL_PERIODIC_DAMAGE = true, DAMAGE_SHIELD = true, DAMAGE_SPLIT = true, SPELL_EXTRA_ATTACKS = true}
		local DPS_FEED = CreateFrame('Frame')
		local player_id = UnitGUID('player')
		local dmg_total, last_dmg_amount = 0, 0
		local cmbt_time = 0

		local pet_id = UnitGUID('pet')
		 
		local dText = DataPanel:CreateFontString(nil, 'OVERLAY')
		dText:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		dText:SetText("DPS: ", '0')

		PP(db.datapanel.dps_text, dText)

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
					if toc < 40200 then
						last_dmg_amount = select(10, ...)
					else
						last_dmg_amount = select(12, ...)
					end
				else
					if toc < 40200 then
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
	if db.datapanel.dur and db.datapanel.dur > 0 then

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


		local Stat = CreateFrame("Frame")
		Stat:EnableMouse(true)
		Stat:SetFrameStrata("MEDIUM")
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.dur, Text)

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
				GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Durability")
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

	--------------------------------------------------------------------
	-- FRIEND
	--------------------------------------------------------------------

	if db.datapanel.friends or db.datapanel.friends > 0 then


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

		local Stat = CreateFrame("Frame")
		Stat:EnableMouse(true)
		Stat:SetFrameStrata("MEDIUM")
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.friends, Text)

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
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(BNTable[i][16])
							if classc == nil then classc = GetQuestDifficultyColor(BNTable[i][16]) end

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

			Text:SetFormattedText(displayString, "Friends: ", totalOnline + BNTotalOnline)
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
				GameTooltip:AddDoubleLine(hexa..myname.."'s"..hexb.." Friends", format(totalOnlineString, totalonline, totalfriends))
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
			
								classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[BNTable[i][14]], GetQuestDifficultyColor(BNTable[i][16])
								if classc == nil then classc = GetQuestDifficultyColor(BNTable[i][16]) end
								
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
	if db.datapanel.guild and db.datapanel.guild > 0 then

		local Stat = CreateFrame("Frame")
		Stat:EnableMouse(true)
		Stat:SetFrameStrata("MEDIUM")
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.guild, Text)

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
			GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Guild")		
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
				--UpdateGuildXP()
				
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
	if db.datapanel.haste and db.datapanel.haste > 0 then
		local Stat = CreateFrame('Frame')
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.haste, Text)

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

	--------------------
	-- Heals Per Second
	--------------------
	if db.datapanel.hps_text and db.datapanel.hps_text > 0 then
		local events = {SPELL_HEAL = true, SPELL_PERIODIC_HEAL = true}
		local HPS_FEED = CreateFrame('Frame')
		local player_id = UnitGUID('player')
		local actual_heals_total, cmbt_time = 0
	 
		local hText = DataPanel:CreateFontString(nil, 'OVERLAY')
		hText:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		hText:SetText("HPS: ", '0')
	 
		PP(db.datapanel.hps_text, hText)
	 
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
				if toc < 40200 then
					amount_healed = select(13, ...)
					amount_over_healed = select(14, ...)
				else
					amount_healed = select(15, ...)
					amount_over_healed = select(16, ...)
				end
				-- add to the total the healed amount subtracting the overhealed amount
				actual_heals_total = actual_heals_total + math.max(0, amount_healed - amount_over_healed)
			end
		end
		
		function get_hps()
			if (actual_heals_total == 0) then
				return (hexa.."HPS: "..hexb..'0' )
			else
				return string.format('%.1f '..hexa.."HPS"..hexb, (actual_heals_total or 0) / (cmbt_time or 1))
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

	---------------
	-- Professions
	---------------
	if db.datapanel.pro and db.datapanel.pro > 0 then

		local Stat = CreateFrame('Button')
		Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)
		Stat:EnableMouse(true)
		Stat.tooltip = false

		local Text = DataPanel:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.pro, Text)

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
			GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Professions")
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
	if db.datapanel.recount and db.datapanel.recount > 0 then 

		local RecountDPS = CreateFrame("Frame")
		RecountDPS:EnableMouse(true)
		RecountDPS:SetFrameStrata("MEDIUM")
		RecountDPS:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.recount, Text)
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
			if db.datapanel.recountraiddps == true then
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
			GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Damage")
			GameTooltip:AddLine' '		
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

	--------------------
	-- Talent Spec Swap
	--------------------
	if db.datapanel.spec and db.datapanel.spec > 0 then

		local Stat = CreateFrame('Frame')
		Stat:EnableMouse(true)
		Stat:SetFrameStrata('BACKGROUND')
		Stat:SetFrameLevel(3)

		local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.spec, Text)

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
			GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Spec")
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
	if db.datapanel.stat1 and db.datapanel.stat1 > 0 then

		local Stat = CreateFrame("Frame")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetFrameStrata("BACKGROUND")
		Stat:SetFrameLevel(3)
		Stat:EnableMouse(true)

		local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.stat1, Text)

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
			GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Statistics")
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
				local hit =  myclass == "HUNTER" and GetCombatRating(CR_HIT_RANGED) or GetCombatRating(CR_HIT_MELEE)
				local hitBonus =  myclass == "HUNTER" and GetCombatRatingBonus(CR_HIT_RANGED) or GetCombatRatingBonus(CR_HIT_MELEE)
			
				GameTooltip:AddDoubleLine(STAT_HIT_CHANCE, format(modifierString, hit, hitBonus), 1, 1, 1)
				
				local haste = myclass == "HUNTER" and GetCombatRating(CR_HASTE_RANGED) or GetCombatRating(CR_HASTE_MELEE)
				local hasteBonus = myclass == "HUNTER" and GetCombatRatingBonus(CR_HASTE_RANGED) or GetCombatRatingBonus(CR_HASTE_MELEE)
				
				GameTooltip:AddDoubleLine(STAT_HASTE, format(modifierString, haste, hasteBonus), 1, 1, 1)
			end
			
			local masteryspell
			if GetCombatRating(CR_MASTERY) ~= 0 and GetSpecialization() then
				if myclass == "DRUID" then
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
			
			if myclass == "DRUID" then
				parry = 0
				block = 0
			elseif myclass == "DEATHKNIGHT" then
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
				
			if myclass == "HUNTER" then
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
	if db.datapanel.stat2 and db.datapanel.stat2 > 0 then

		local Stat = CreateFrame("Frame")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetFrameStrata("BACKGROUND")
		Stat:SetFrameLevel(3)
		Stat:EnableMouse(true)

		local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.stat2, Text)

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
			GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Statistics")
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

			Text:SetFormattedText(displayFloatString, hexa.."Crit: "..hexb, spellcrit)
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
	if db.datapanel.system and db.datapanel.system > 0 then

		local Stat = CreateFrame("Frame")
		Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
		Stat:SetFrameStrata("BACKGROUND")
		Stat:SetFrameLevel(3)
		Stat:EnableMouse(true)
		Stat.tooltip = false

		local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
		Text:SetFont(db.media.fontNormal, db.media.fontSize,'THINOUTLINE')
		PP(db.datapanel.system, Text)

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
			GameTooltip:AddLine(hexa..myname.."'s"..hexb.." Latency")
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