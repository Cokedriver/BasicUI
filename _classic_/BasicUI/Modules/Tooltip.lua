local MODULE_NAME = "Tooltip"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local BASIC_BORDER = [[Interface\Tooltips\UI-Tooltip-Border]]
local BASIC_BACKGROUND = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]]
local BASIC_STATUSBAR = [[Interface\TargetingFrame\UI-StatusBar]]

local db
local defaults = {
	profile = {
		enable = true,
		fontSize = 15,
		fontOutline = false,

		showOnMouseover = false,
		hideInCombat = false,                       -- Hide unit frame tooltips during combat

		reactionBorderColor = false,
		itemqualityBorderColor = true,

		abbrevRealmNames = false,
		showPlayerTitles = true,
		showPVPIcons = false,                       -- Show pvp icons instead of just a prefix
		showMouseoverTarget = true,
		showSpecializationIcon = true,

		healthbar = {
			showHealthValue = true,

			healthFormat = "$cur / $max",           -- Possible: $cur, $max, $deficit, $perc, $smartperc, $smartcolorperc, $colorperc
			healthFullFormat = "$cur",              -- if the tooltip unit has 100% hp

			fontSize = 13,
			font = STANDARD_TEXT_FONT,
			showOutline = true,
			textPos = "CENTER",                     -- Possible "TOP" "BOTTOM" "CENTER"

			reactionColoring = false,               -- Overrides customColor
			customColor = {
				apply = false,
				color = {
					r = 0,
					g = 1,
					b = 1,
				}
			},
		},		
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


function MODULE:OnEnable()
	
	if db.enable ~= true then return end

	--[[

		All Credit for Tooltip.lua goes to Neal and ballagarba.
		Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
		Edited by Cokedriver.
		
	]]
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
	function GameTooltip_UnitColor(unit)

		local r, g, b

		if (UnitIsDead(unit) or UnitIsGhost(unit) or UnitIsTapDenied(unit)) then
			r = 0.5
			g = 0.5
			b = 0.5
		elseif (UnitIsPlayer(unit)) then
			if (UnitIsFriend(unit, 'player')) then
				local _, class = UnitClass(unit)
				if ( class ) then
					r = RAID_CLASS_COLORS[class].r
					g = RAID_CLASS_COLORS[class].g
					b = RAID_CLASS_COLORS[class].b
				else
					r = 0.60
					g = 0.60
					b = 0.60
				end
			elseif (not UnitIsFriend(unit, 'player')) then
				r = 1
				g = 0
				b = 0
			end
		elseif (UnitPlayerControlled(unit)) then
			if (UnitCanAttack(unit, 'player')) then
				if (not UnitCanAttack('player', unit)) then
					r = 157/255
					g = 197/255
					b = 255/255
				else
					r = 1
					g = 0
					b = 0
				end
			elseif (UnitCanAttack('player', unit)) then
				r = 1
				g = 1
				b = 0
			elseif (UnitIsPVP(unit)) then
				r = 0
				g = 1
				b = 0
			else
				r = 157/255
				g = 197/255
				b = 255/255
			end
		else
			local reaction = UnitReaction(unit, 'player')

			if (reaction) then
				r = FACTION_BAR_COLORS[reaction].r
				g = FACTION_BAR_COLORS[reaction].g
				b = FACTION_BAR_COLORS[reaction].b
			else
				r = 157/255
				g = 197/255
				b = 255/255
			end
		end

		return r, g, b
	end

	hooksecurefunc("TargetFrame_CheckFaction", function(self)
		if ( UnitPlayerControlled(self.unit) ) then
			self.nameBackground:SetVertexColor(GameTooltip_UnitColor(self.unit));
		end
	end)

	local select = select
	local tonumber = tonumber
	
	local format = string.format
	local match = string.match
	local upper = string.upper
	local floor = floor
	local sub = sub
	local gsub = gsub
	local find = find
	local modf = math.modf

	local UnitName = UnitName
	local UnitLevel = UnitLevel
	local UnitExists = UnitExists
	local UnitIsDead = UnitIsDead
	local UnitIsGhost = UnitIsGhost
	local UnitFactionGroup = UnitFactionGroup
	local UnitCreatureType = UnitCreatureType
	local GetQuestDifficultyColor = GetQuestDifficultyColor

	local tankIcon = "|T\Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:0:19:22:41|t"
	local healIcon = "|T\Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:20:39:1:20|t"
	local damagerIcon = "|T\Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:20:39:22:41|t"

		-- Some tooltip changes

	if db.fontOutline then
		GameTooltipText:SetFont(STANDARD_TEXT_FONT, (db.fontSize), "OUTLINE")
		GameTooltipText:SetShadowOffset(0, 0)

		GameTooltipTextSmall:SetFont(STANDARD_TEXT_FONT, (db.fontSize), "OUTLINE")
		GameTooltipTextSmall:SetShadowOffset(0, 0)
	else
		GameTooltipText:SetFont(STANDARD_TEXT_FONT, (db.fontSize))
		GameTooltipTextSmall:SetFont(STANDARD_TEXT_FONT, (db.fontSize))
	end

	GameTooltipStatusBar:SetHeight(7)
	GameTooltipStatusBar:SetBackdrop({bgFile = [[Interface\Buttons\WHITE8x8]]})
	GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)

	local function ApplyTooltipStyle(self)
		if not self then
			return
		end

		local name = self:GetName()
		if name then
			if match(name, "TooltipTooltip") then
				return
			end
		end

		local bgOffset, borderSize = 3, 12

		if self == FloatingBattlePetTooltip or self == BattlePetTooltip then
			bgOffset = 4
			borderSize = 16
		end

		if not self.Background then
			self.Background = self:CreateTexture(nil, "BACKGROUND", nil, 1)
			self.Background:SetTexture([[Interface\Buttons\WHITE8x8]])
			self.Background:SetPoint("TOPLEFT", self, bgOffset, -bgOffset)
			self.Background:SetPoint("BOTTOMRIGHT", self, -bgOffset, bgOffset)
			self.Background:SetVertexColor(0.0, 0.0, 0.0, 0.60)
		end
	end

	for _, tooltip in pairs({
		GameTooltip,
		BattlePetTooltip,
		EmbeddedItemTooltip,
		ItemRefTooltip,
		ItemRefShoppingTooltip1,
		ItemRefShoppingTooltip2,
		ShoppingTooltip1,
		ShoppingTooltip2,
		DropDownList1MenuBackdrop,
		DropDownList2MenuBackdrop,
		ConsolidatedBuffsTooltip,
		AutoCompleteBox,
		ChatMenu,
		EmoteMenu,
		LanguageMenu,
		VoiceMacroMenu,
		FriendsTooltip,
		FloatingGarrisonFollowerTooltip,
		FloatingBattlePetTooltip,
		FloatingPetBattleAbilityTooltip,
		ReputationParagonTooltip,
		LibDBIconTooltip,
		SmallTextTooltip,
		LibItemUpdateInfoTooltip,
		NamePlateTooltip,
	}) do
		ApplyTooltipStyle(tooltip)
	end

	hooksecurefunc("GameTooltip_SetBackdropStyle", ApplyTooltipStyle)

		-- Itemquaility border, we use our beautycase functions

	if db.itemqualityBorderColor then
		for _, tooltip in pairs({
			GameTooltip,
			ItemRefTooltip,

			ShoppingTooltip1,
			ShoppingTooltip2,
			ShoppingTooltip3,
		}) do
			tooltip:HookScript('OnTooltipSetItem', function(self)
				local name, item = self:GetItem()
				if (item) then
					local quality = select(3, GetItemInfo(item))
					if (quality) then
						local r, g, b = GetItemQualityColor(quality)
						self:SetBackdropBorderColor(r, g, b)
					end
				end
			end)
			
			tooltip:HookScript('OnTooltipCleared', function(self)
				self:SetBackdropBorderColor(1, 1, 1)
			end)
		end
	end

	local function GetFormattedUnitType(unit)
		local creaturetype = UnitCreatureType(unit)
		if creaturetype then
			return creaturetype
		else
			return ""
		end
	end

	local function GetFormattedUnitClassification(unit)
		local class = UnitClassification(unit)
		if class == "worldboss" then
			return "|cffFF0000"..BOSS.."|r "
		elseif class == "rareelite" then
			return "|cffFF66CCRare|r |cffFFFF00"..ELITE.."|r "
		elseif class == "rare" then
			return "|cffFF66CCRare|r "
		elseif class == "elite" then
			return "|cffFFFF00"..ELITE.."|r "
		else
			return ""
		end
	end

	local function GetFormattedUnitLevel(unit)
		local diff = GetQuestDifficultyColor(UnitLevel(unit))
		if UnitLevel(unit) == -1 then
			return "|cffff0000??|r "
		elseif UnitLevel(unit) == 0 then
			return "? "
		else
			return format("|cff%02x%02x%02x%s|r ", diff.r*255, diff.g*255, diff.b*255, UnitLevel(unit))
		end
	end

	local function GetFormattedUnitClass(unit)
		local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
		if color then
			return format(" |cff%02x%02x%02x%s|r", color.r*255, color.g*255, color.b*255, UnitClass(unit))
		end
	end

	local function GetFormattedUnitString(unit, specIcon)
		if UnitIsPlayer(unit) then
			if not UnitRace(unit) then
				return nil
			end
			return GetFormattedUnitLevel(unit)..UnitRace(unit)..GetFormattedUnitClass(unit)..(db.showSpecializationIcon and specIcon or "")
		else
			return GetFormattedUnitLevel(unit)..GetFormattedUnitClassification(unit)..GetFormattedUnitType(unit)
		end
	end
	
	local function GetUnitRoleString(unit)
		local role = UnitGroupRolesAssigned(unit)
		local roleList = nil

		if role == "TANK" then
			roleList = "   "..tankIcon.." "..TANK
		elseif role == "HEALER" then
			roleList = "   "..healIcon.." "..HEALER
		elseif role == "DAMAGER" then
			roleList = "   "..damagerIcon.." "..DAMAGER
		end

		return roleList
	end


		-- Healthbar coloring funtion

	local function SetHealthBarColor(unit)
		local r, g, b
		if db.healthbar.customColor.apply and not db.healthbar.reactionColoring then
			r, g, b = db.healthbar.customColor.color.r, db.healthbar.customColor.color.g, db.healthbar.customColor.color.b
		elseif db.healthbar.reactionColoring and unit then
			if unit == "player" then
				local _, class = UnitClass("player")
				local ccolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
				r, g, b = ccolor.r, ccolor.g, ccolor.b
			else
				r, g, b = UnitSelectionColor(unit)
			end
		else
			r, g, b = 0, 1, 0
		end

		GameTooltipStatusBar:SetStatusBarColor(r, g, b)
		GameTooltipStatusBar:SetBackdropColor(r, g, b, 0.3)
	end

	local function GetUnitRaidIcon(unit)
		local index = GetRaidTargetIndex(unit)
		local icon = ICON_LIST[index] or ""

		if index then
			if UnitIsPVP(unit) and db.showPVPIcons then
				return icon.."11|t"
			else
				return icon.."11|t "
			end
		else
			return ""
		end
	end

	local function GetUnitPVPIcon(unit)
		local factionGroup = UnitFactionGroup(unit)

		if UnitIsPVPFreeForAll(unit) then
			if db.showPVPIcons then
				return CreateTextureMarkup([[Interface\AddOns\BasicUI\Media\UI-PVP-FFA]], 32,32, 16,16, 0,1,0,1, -2,-1)
			else
				return "|cffFF0000# |r"
			end
		elseif factionGroup and UnitIsPVP(unit) then
			if db.showPVPIcons then
				return CreateTextureMarkup([[Interface\AddOns\BasicUI\Media\UI-PVP-]]..factionGroup, 32,32, 14,14, 0,1,0,1, -2,-1)
			else
				return "|cff00FF00# |r"
			end
		else
			return ""
		end
	end

	local function AddMouseoverTarget(self, unit)
		local unitTargetName = UnitName(unit.."target")
		local unitTargetClassColor = RAID_CLASS_COLORS[select(2, UnitClass(unit.."target"))] or { r = 1, g = 0, b = 1 }
		local unitTargetReactionColor = {
			r = select(1, GameTooltip_UnitColor(unit.."target")),
			g = select(2, GameTooltip_UnitColor(unit.."target")),
			b = select(3, GameTooltip_UnitColor(unit.."target"))
		}

		if UnitExists(unit.."target") then
			if UnitName('player') == unitTargetName then
				self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cffff00ff%s|r', string.upper("** YOU **")), 1, 1, 1)
			else
				if UnitIsPlayer(unit..'target') then
					self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cff%02x%02x%02x%s|r', unitTargetClassColor.r*255, unitTargetClassColor.g*255, unitTargetClassColor.b*255, unitTargetName:sub(1, 40)), 1, 1, 1)
				else
					self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cff%02x%02x%02x%s|r', unitTargetReactionColor.r*255, unitTargetReactionColor.g*255, unitTargetReactionColor.b*255, unitTargetName:sub(1, 40)), 1, 1, 1)
				end
			end
		end
	end

	GameTooltip.inspectCache = {}

	GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
		local _, unit = self:GetUnit()

		if db.hideInCombat and InCombatLockdown() then
			self:Hide()
			return
		end

		if UnitExists(unit) and UnitName(unit) ~= UNKNOWN then
			local specIcon = ""

			local name, realm = UnitName(unit)

				-- Player Titles

			if db.showPlayerTitles then
				if UnitPVPName(unit) then
					name = UnitPVPName(unit)
				end
			end

			GameTooltipTextLeft1:SetText(name)

				-- Color guildnames
			

			local unitGuild, unitRank = GetGuildInfo(unit)
			if unitGuild and unitRank then
				if UnitIsInMyGuild(unit) then
					self:AddLine("|cffFF66CC<" .. unitGuild .. "> - " .. unitRank .. "|r")
				else
					self:AddLine("|cffFF66CC<" .. unitGuild .. ">|r")
				end
			end
			 
				-- Level

			for i = 2, GameTooltip:NumLines() do
				if _G["GameTooltipTextLeft"..i]:GetText():find("^"..TOOLTIP_UNIT_LEVEL:gsub("%%s", ".+")) then
					_G["GameTooltipTextLeft"..i]:SetText(GetFormattedUnitString(unit, specIcon))
				end
			end
			
				-- Role

			if db.showUnitRole then
				self:AddLine(GetUnitRoleString(unit), 1, 1, 1)
			end
			
				-- Mouseover Target

			if db.showMouseoverTarget then
				AddMouseoverTarget(self, unit)
			end

				-- PvP Flag Prefix

			for i = 3, GameTooltip:NumLines() do
				if _G["GameTooltipTextLeft"..i]:GetText():find(PVP_ENABLED) then
					_G["GameTooltipTextLeft"..i]:SetText(nil)
					GameTooltipTextLeft1:SetText(GetUnitPVPIcon(unit)..GameTooltipTextLeft1:GetText())
				end
			end

				-- Raid icon, want to see the raidicon on the left

			GameTooltipTextLeft1:SetText(GetUnitRaidIcon(unit)..GameTooltipTextLeft1:GetText())

				-- Away and DND

			if UnitIsAFK(unit) then
				self:AppendText("|cff00ff00 <"..CHAT_MSG_AFK..">|r")
			elseif UnitIsDND(unit) then
				self:AppendText("|cff00ff00 <"..DEFAULT_DND_MESSAGE..">|r")
			end

				-- Player realm names

			if realm and realm ~= "" then
				if db.abbrevRealmNames then
					self:AppendText(" (*)")
				else
					self:AppendText(" - "..realm)
				end
			end

				-- Move the healthbar inside the tooltip

			if GameTooltipStatusBar:IsShown() then
				self:AddLine(" ")
				GameTooltipStatusBar:ClearAllPoints()
				GameTooltipStatusBar:SetPoint("LEFT", self:GetName().."TextLeft"..self:NumLines(), 1, -3)
				GameTooltipStatusBar:SetPoint("RIGHT", self, -10, 0)
			end

				-- Border coloring

			if db.reactionBorderColor then
				if unit == "player" then
					local _, class = UnitClass("player")
					local ccolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
					self:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
				else
					local r, g, b = UnitSelectionColor(unit)
					self:SetBackdropBorderColor(r, g, b)
				end
			end

				-- Dead or ghost recoloring

			if UnitIsDead(unit) or UnitIsGhost(unit) then
				GameTooltipStatusBar:SetBackdropColor(0.5, 0.5, 0.5, 0.3)
			else
				if not db.healthbar.customColor.apply and not db.healthbar.reactionColoring then
					GameTooltipStatusBar:SetBackdropColor(27/255, 243/255, 27/255, 0.3)
				else
					SetHealthBarColor(unit)
				end
			end
		end
	end)

	GameTooltip:HookScript("OnTooltipCleared", function(self)
		GameTooltipStatusBar:ClearAllPoints()
		GameTooltipStatusBar:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0.5, 3)
		GameTooltipStatusBar:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -1, 3)
		GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)

		if (db.reactionBorderColor) then
			self:SetBackdropBorderColor(1, 1, 1)
		end
	end)

		-- Custom healthbar coloring

	if db.healthbar.reactionColoring or db.healthbar.customColor.apply then
		GameTooltipStatusBar:HookScript("OnValueChanged", function(self)
			local _, unit = self:GetParent():GetUnit()
			SetHealthBarColor(unit)
		end)
	end

	local function CreateAnchor()
		local anchorFrame = CreateFrame("Frame", "addon_Anchor", UIParent)
		anchorFrame:SetSize(50, 50)
		anchorFrame:SetScale(1.2)
		anchorFrame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -75, 75)
		anchorFrame:SetFrameStrata("HIGH")
		anchorFrame:SetMovable(true)
		anchorFrame:SetClampedToScreen(true)
		anchorFrame:SetUserPlaced(true)
		anchorFrame:SetBackdrop({bgFile = [[Interface\MINIMAP\TooltipBackdrop-Background]],})
		anchorFrame:EnableMouse(true)
		anchorFrame:RegisterForDrag("LeftButton")
		anchorFrame:Hide()

		anchorFrame.text = anchorFrame:CreateFontString(nil, "OVERLAY")
		anchorFrame.text:SetAllPoints(anchorFrame)
		anchorFrame.text:SetFont(STANDARD_TEXT_FONT, 12)
		anchorFrame.text:SetText("addon")

		anchorFrame:SetScript("OnDragStart", function(self)
			self:StartMoving()
		end)

		anchorFrame:SetScript("OnDragStop", function(self)
			self:StopMovingOrSizing()
		end)

		return anchorFrame
	end

	local addonAnchor = CreateAnchor()

	hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
		if db.showOnMouseover then
			self:SetOwner(parent, "ANCHOR_CURSOR")
		else
			self:SetOwner(parent, "ANCHOR_NONE")
			self:ClearAllPoints()
			self:SetPoint("BOTTOMRIGHT", addonAnchor)
		end
	end)

	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, event)
		if IsAddOnLoaded("Blizzard_InspectUI") then
			hooksecurefunc("InspectFrame_Show", function(unit)
				GameTooltip.blockInspectRequests = true
			end)

			InspectFrame:HookScript("OnHide", function()
				GameTooltip.blockInspectRequests = false
			end)

			self:UnregisterEvent("ADDON_LOADED")
		end
	end)

	if db.healthbar.showHealthValue then

		local HP_Bar = GameTooltipStatusBar
		HP_Bar.Text = HP_Bar:CreateFontString(nil, "OVERLAY")
		HP_Bar.Text:SetPoint("CENTER", HP_Bar, db.healthbar.textPos, 0, 1)

		if db.healthbar.showOutline then
			HP_Bar.Text:SetFont(db.healthbar.font, db.healthbar.fontSize, "THINOUTLINE")
			HP_Bar.Text:SetShadowOffset(0, 0)
		else
			HP_Bar.Text:SetFont(db.healthbar.font, db.healthbar.fontSize)
			HP_Bar.Text:SetShadowOffset(1, -1)
		end

		local function ColorGradient(perc, ...)
			if perc >= 1 then
				local r, g, b = select(select("#", ...) - 2, ...)
				return r, g, b
			elseif perc <= 0 then
				local r, g, b = ...
				return r, g, b
			end

			local num = select("#", ...) / 3

			local segment, relperc = modf(perc*(num-1))
			local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

			return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
		end

		local function FormatValue(value)
			if value >= 1e6 then
				return tonumber(format("%.1f", value/1e6)).."m"
			elseif value >= 1e3 then
				return tonumber(format("%.1f", value/1e3)).."k"
			else
				return value
			end
		end

		local function DeficitValue(value)
			if value == 0 then
				return ""
			else
				return "-"..FormatValue(value)
			end
		end

		local function GetHealthTag(text, cur, max)
			local perc = format("%d", (cur/max)*100)

			if max == 1 then
				return perc
			end

			local r, g, b = ColorGradient(cur/max, 1, 0, 0, 1, 1, 0, 0, 1, 0)
			text = gsub(text, "$cur", format("%s", FormatValue(cur)))
			text = gsub(text, "$max", format("%s", FormatValue(max)))
			text = gsub(text, "$deficit", format("%s", DeficitValue(max-cur)))
			text = gsub(text, "$perc", format("%d", perc).."%%")
			text = gsub(text, "$smartperc", format("%d", perc))
			text = gsub(text, "$smartcolorperc", format("|cff%02x%02x%02x%d|r", r*255, g*255, b*255, perc))
			text = gsub(text, "$colorperc", format("|cff%02x%02x%02x%d", r*255, g*255, b*255, perc).."%%|r")

			return text
		end

		GameTooltipStatusBar:HookScript("OnValueChanged", function(self, value)
			if self.Text then
				self.Text:SetText("")
			end

			if not value then
				return
			end

			local min, max = self:GetMinMaxValues()

			if (value < min) or (value > max) or (value == 0) or (value == 1) then
				return
			end

			if not self.Text then
				CreateHealthString(self)
			end

			local fullString = GetHealthTag(db.healthbar.healthFullFormat, value, max)
			local normalString = GetHealthTag(db.healthbar.healthFormat, value, max)

			local perc = (value/max)*100
			if perc >= 100 and currentValue ~= 1 then
				self.Text:SetText(fullString)
			elseif perc < 100 and currentValue ~= 1 then
				self.Text:SetText(normalString)
			else
				self.Text:SetText("")
			end
		end)

	end
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

	local regions = {
		['BOTTOM'] = L['Bottom'],
		['BOTTOMLEFT'] = L['Bottom Left'],
		['BOTTOMRIGHT'] = L['Bottom Right'],
		['CENTER'] = L['Center'],
		['LEFT'] = L['Left'],
		['RIGHT'] = L['Right'],
		['TOP'] = L['Top'],
		['TOPLEFT'] = L['Top Left'],
		['TOPRIGHT'] = L['Top Right'],
	}	
	
	options = {
		type = "group",
		name = L[MODULE_NAME],
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
				desc = L["Enables the Tooltip Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = false,
			},
			reactionBorderColor = {
				type = "toggle",
				order = 2,
				name = L["Reaction Border Color"],
				desc = L["Colors the borders match targets classcolors."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			itemqualityBorderColor = {
				type = "toggle",
				order = 2,
				name = L["Item Quality Border Color"],
				desc = L["Colors the border of the tooltip to match the items quality."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showPlayerTitles = {
				type = "toggle",
				order = 2,
				name = L["Player Titles"],
				desc = L["Shows players title in tooltip."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showPVPIcons = {
				type = "toggle",
				order = 2,
				name = L["PVP Icons"],
				desc = L["Shows PvP Icons in tooltip."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showUnitRole = {
				type = "toggle",
				order = 2,
				name = L["Show Units Role"],
				desc = L["Shows Units Role in tooltip."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			abbrevRealmNames = {
				type = "toggle",
				order = 2,
				name = L["Abberviate Realm Names"],
				desc = L["Abberviates Players Realm Name."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showMouseoverTarget = {
				type = "toggle",
				order = 2,
				name = L["Mouseover Target"],
				desc = L["Shows mouseover target."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showSpecializationIcon = {
				type = "toggle",
				order = 2,
				name = L["Specialization"],
				desc = L["Shows Specialization In Tooltip."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			hideInCombat = {
				type = "toggle",
				order = 2,
				name = L["Hide in Combat"],
				desc = L["Hides unit frame tooltips during combat."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			hideRealmText = {
				type = "toggle",
				order = 2,
				name = L["Hide Realm Text"],
				desc = L["Hide the coalesced/interactive realm text."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			healthbar = {
				type = "group",
				order = 3,
				name = L["Healthbar"],
				desc = L["Players Healthbar Options."],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.healthbar[ info[#info] ] end,
				set = function(info, value) db.healthbar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
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
					showHealthValue = {
						type = "toggle",
						order = 2,
						name = L["Health Value"],
						desc = L["Shows health value over healthbar."],
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					showOutline = {
						type = "toggle",
						order = 2,
						name = L["Font Outline"],
						desc = L["Adds a font outline to health value."],
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					reactionColoring = {
						type = "toggle",
						order = 2,
						name = L["Reaction Coloring"],
						desc = L["Change healthbar color to targets classcolor. (Overides Custom Color)"],
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					textPos = {
						type = "select",
						order = 3,
						name = L["Text Position"],
						desc = L["Health Value Position."],
						disabled = function() return isModuleDisabled() or not db.enable end,
						values = regions,
					},
					fontSize= {
						type = "range",
						order = 5,
						name = L["Font Size"],
						desc = L["Controls the healthbar value font size."],
						min = 8, max = 25, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
				},
			},
		},
	}
	return options
end