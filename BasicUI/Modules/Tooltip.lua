local MODULE_NAME = "Tooltip"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Tooltip = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		fontSize = 15,
		fontOutline = true,
		disableFade = false,                     		-- Can cause errors or a buggy tooltip!
		abbrevRealmNames = true, 	

		hideInCombat = false,                       -- Hide unit frame tooltips during combat	
		hideRealmText = true,                      -- Hide the coalesced/interactive realm text	
		reactionBorderColor = true,
		itemqualityBorderColor = true,
		
		showPlayerTitles = true,
		showPVPIcons = false,                        	-- Show pvp icons instead of just a prefix
		showMouseoverTarget = true,
		showOnMouseover = false,
		showUnitRole = true,
		showItemLevel = true,
		showSpecializationIcon = false,
		
		healthbar = {
			showHealthValue = true,
			showOutline = true,
			healthFormat = '$cur / $max',           -- Possible: $cur, $max, $deficit, $perc, $smartperc, $smartcolorperc, $colorperc
			healthFullFormat = '$cur',              -- if the tooltip unit has 100% hp 		
			textPos = "CENTER",                     -- Possible "TOP" "BOTTOM" "CENTER"	
			reactionColoring = false,
			custom = {
				apply = false,
				color =	{ r = 1, g = 1, b = 0},
			},		
			fontSize = 15,
		},		
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

local classColor

function Tooltip:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end


function Tooltip:OnEnable()
	
	if db.enable ~= true then return end

	--[[

		All Credit for Tooltip.lua goes to Neal and ballagarba.
		Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
		Edited by Cokedriver.
		
	]]

	local _G = _G
	local select = select
	local format = string.format

	local UnitName = UnitName
	local UnitLevel = UnitLevel
	local UnitExists = UnitExists
	local UnitIsDead = UnitIsDead
	local UnitIsGhost = UnitIsGhost
	local UnitFactionGroup = UnitFactionGroup
	local UnitCreatureType = UnitCreatureType
	local GetQuestDifficultyColor = GetQuestDifficultyColor

	local tankIcon = '|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:0:19:22:41|t'
	local healIcon = '|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:20:39:1:20|t'
	local damagerIcon = '|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:13:13:0:0:64:64:20:39:22:41|t'

	local symbiosis = {
		gain = {
			['DEATHKNIGHT'] = { ['DK_BLOOD']            = 113072, ['DK_FROST']          = 113516, ['DK_UNHOLY']         = 113516, },
			['HUNTER']      = { ['HUNTER_BM']           = 113073, ['HUNTER_MM']         = 113073, ['HUNTER_SV']         = 113073, },
			['MAGE']        = { ['MAGE_ARCANE']         = 113074, ['MAGE_FIRE']         = 113074, ['MAGE_FROST']        = 113074, },
			['MONK']        = { ['MONK_BREW']           = 113306, ['MONK_MIST']         = 127361, ['MONK_WIND']         = 113275, },
			['PALADIN']     = { ['PALADIN_HOLY']        = 113269, ['PALADIN_PROT']      = 122287, ['PALADIN_RET']       = 113075, },
			['PRIEST']      = { ['PRIEST_DISC']         = 113506, ['PRIEST_HOLY']       = 113506, ['PRIEST_SHADOW']     = 113277, },
			['ROGUE']       = { ['ROGUE_ASS']           = 113613, ['ROGUE_COMBAT']      = 113613, ['ROGUE_SUB']         = 113613, },
			['SHAMAN']      = { ['SHAMAN_ELE']          = 113286, ['SHAMAN_ENHANCE']    = 113286, ['SHAMAN_RESTO']      = 113289, },
			['WARLOCK']     = { ['WARLOCK_AFFLICTION']  = 113295, ['WARLOCK_DEMO']      = 113295, ['WARLOCK_DESTRO']    = 113295, },
			['WARRIOR']     = { ['WARRIOR_ARMS']        = 122294, ['WARRIOR_FURY']      = 122294, ['WARRIOR_PROT']      = 122286, },
		},
		grant = {
			['DEATHKNIGHT'] =   { ['DRUID_BALANCE'] = 110570, ['DRUID_FERAL'] = 122282, ['DRUID_GUARDIAN'] = 122285, ['DRUID_RESTO'] = 110575, },
			['HUNTER'] =        { ['DRUID_BALANCE'] = 110588, ['DRUID_FERAL'] = 110597, ['DRUID_GUARDIAN'] = 110600, ['DRUID_RESTO'] = 19263, },
			['MAGE'] =          { ['DRUID_BALANCE'] = 110621, ['DRUID_FERAL'] = 110693, ['DRUID_GUARDIAN'] = 110694, ['DRUID_RESTO'] = 110696, },
			['MONK'] =          { ['DRUID_BALANCE'] = 126458, ['DRUID_FERAL'] = 128844, ['DRUID_GUARDIAN'] = 126453, ['DRUID_RESTO'] = 126456, },
			['PALADIN'] =       { ['DRUID_BALANCE'] = 110698, ['DRUID_FERAL'] = 110700, ['DRUID_GUARDIAN'] = 110701, ['DRUID_RESTO'] = 122288, },
			['PRIEST'] =        { ['DRUID_BALANCE'] = 110707, ['DRUID_FERAL'] = 110715, ['DRUID_GUARDIAN'] = 110717, ['DRUID_RESTO'] = 110718, },
			['ROGUE'] =         { ['DRUID_BALANCE'] = 110788, ['DRUID_FERAL'] = 110730, ['DRUID_GUARDIAN'] = 122289, ['DRUID_RESTO'] = 110791, },
			['SHAMAN'] =        { ['DRUID_BALANCE'] = 110802, ['DRUID_FERAL'] = 110807, ['DRUID_GUARDIAN'] = 110803, ['DRUID_RESTO'] = 110806, },
			['WARLOCK'] =       { ['DRUID_BALANCE'] = 122291, ['DRUID_FERAL'] = 110810, ['DRUID_GUARDIAN'] = 122290, ['DRUID_RESTO'] = 112970, },
			['WARRIOR'] =       { ['DRUID_BALANCE'] = 122292, ['DRUID_FERAL'] = 112997, ['DRUID_GUARDIAN'] = 113002, ['DRUID_RESTO'] = 113004, },
		}
	}

	-- _G.TOOLTIP_DEFAULT_BACKGROUND_COLOR = {r = 0, g = 0, b = 0}

		-- Some tooltip changes

	if (db.fontOutline) then
		GameTooltipHeaderText:SetFont(BasicUI.media.fontBold, (db.fontSize + 2), 'THINOUTLINE')
		GameTooltipHeaderText:SetShadowOffset(0, 0)

		GameTooltipText:SetFont(BasicUI.media.fontNormal, (db.fontSize), 'THINOUTLINE')
		GameTooltipText:SetShadowOffset(0, 0)

		GameTooltipTextSmall:SetFont(BasicUI.media.fontNormal, (db.fontSize), 'THINOUTLINE')
		GameTooltipTextSmall:SetShadowOffset(0, 0)
	else
		GameTooltipHeaderText:SetFont(BasicUI.media.fontBold, (db.fontSize + 2))
		GameTooltipText:SetFont(BasicUI.media.fontNormal, (db.fontSize))
		GameTooltipTextSmall:SetFont(BasicUI.media.fontNormal, (db.fontSize))
	end

	GameTooltipStatusBar:SetHeight(7)
	GameTooltipStatusBar:SetBackdrop({bgFile = 'Interface\\Buttons\\WHITE8x8'})
	GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)

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

		if (UnitIsDead(unit) or UnitIsGhost(unit) or UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
			r = 0.5
			g = 0.5
			b = 0.5 
		elseif (UnitIsPlayer(unit)) then
			if (UnitIsFriend(unit, 'player')) then
				local _, class = UnitClass(unit)
				r = RAID_CLASS_COLORS[class].r
				g = RAID_CLASS_COLORS[class].g
				b = RAID_CLASS_COLORS[class].b
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
				r = CUSTOM_FACTION_BAR_COLORS[reaction].r
				g = CUSTOM_FACTION_BAR_COLORS[reaction].g
				b = CUSTOM_FACTION_BAR_COLORS[reaction].b
			else
				r = 157/255
				g = 197/255
				b = 255/255
			end
		end

		return r, g, b
	end
	  
	UnitSelectionColor = GameTooltip_UnitColor

	local function ApplyTooltipStyle(self)
		local bgsize, bsize
		if (self == ConsolidatedBuffsTooltip) then
			bgsize = 1
			bsize = 8
		elseif (self == FriendsTooltip) then
			FriendsTooltip:SetScale(1.1)

			bgsize = 1
			bsize = 9
		else
			bgsize = 3
			bsize = 12
		end

		self:SetBackdrop({
			bgFile = BasicUI.media.background,    -- 'Interface\\Tooltips\\UI-Tooltip-Background',
			edgeFile = BasicUI.media.border,
			tile = true, tileSize = 16, edgeSize = 18,

			insets = {
				left = bgsize, right = bgsize, top = bgsize, bottom = bgsize
			}
		})
	end

	for _, tooltip in pairs({
		GameTooltip,
		ItemRefTooltip,

		ShoppingTooltip1,
		ShoppingTooltip2,
		ShoppingTooltip3,

		WorldMapTooltip,

		DropDownList1MenuBackdrop,
		DropDownList2MenuBackdrop,

		ConsolidatedBuffsTooltip,

		ChatMenu,
		EmoteMenu,
		LanguageMenu,
		VoiceMacroMenu,

		FriendsTooltip,
	}) do
		ApplyTooltipStyle(tooltip)
	end

		-- Itemquaility border

	if (db.itemqualityBorderColor) then
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

		-- Itemlvl (by Gsuz) - http://www.tukui.org/forums/topic.php?id=10151

	local function GetItemLevel(unit)
		local total, item = 0, 0
		for i, v in pairs({
			'Head',
			'Neck',
			'Shoulder',
			'Back',
			'Chest',
			'Wrist',
			'Hands',
			'Waist',
			'Legs',
			'Feet',
			'Finger0',
			'Finger1',
			'Trinket0',
			'Trinket1',
			'MainHand',
			'SecondaryHand',
		}) do
			local slot = GetInventoryItemLink(unit, GetInventorySlotInfo(v..'Slot'))
			if (slot ~= nil) then
				item = item + 1
				total = total + select(4, GetItemInfo(slot))
			end
		end

		if (item > 0) then
			return floor(total / item + 0.5)
		end

		return 0
	end

		-- Make sure we get a correct unit

	local function GetRealUnit(self)
		if (GetMouseFocus() and not GetMouseFocus():GetAttribute('unit') and GetMouseFocus() ~= WorldFrame) then
			return select(2, self:GetUnit())
		elseif (GetMouseFocus() and GetMouseFocus():GetAttribute('unit')) then
			return GetMouseFocus():GetAttribute('unit')
		elseif (select(2, self:GetUnit())) then
			return select(2, self:GetUnit())
		else
			return 'mouseover'
		end
	end

	local function GetFormattedUnitType(unit)
		local creaturetype = UnitCreatureType(unit)
		if (creaturetype) then
			return creaturetype
		else
			return ''
		end
	end

	local function GetFormattedUnitClassification(unit)
		local class = UnitClassification(unit)
		if (class == 'worldboss') then
			return '|cffFF0000'..BOSS..'|r '
		elseif (class == 'rareelite') then
			return '|cffFF66CCRare|r |cffFFFF00'..ELITE..'|r '
		elseif (class == 'rare') then
			return '|cffFF66CCRare|r '
		elseif (class == 'elite') then
			return '|cffFFFF00'..ELITE..'|r '
		else
			return ''
		end
	end

	local function GetFormattedUnitLevel(unit)
		local diff = GetQuestDifficultyColor(UnitLevel(unit))
		if (UnitLevel(unit) == -1) then
			return '|cffff0000??|r '
		elseif (UnitLevel(unit) == 0) then
			return '? '
		else
			return format('|cff%02x%02x%02x%s|r ', diff.r*255, diff.g*255, diff.b*255, UnitLevel(unit))
		end
	end

	local function GetFormattedUnitClass(unit)
		local color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
		if (color) then
			return format(' |cff%02x%02x%02x%s|r', color.r*255, color.g*255, color.b*255, UnitClass(unit))
		end
	end

	local function GetFormattedUnitString(unit, specIcon)
		if (UnitIsPlayer(unit)) then
			if (not UnitRace(unit)) then
				return nil
			end
			return GetFormattedUnitLevel(unit)..UnitRace(unit)..GetFormattedUnitClass(unit)..(db.showSpecializationIcon and specIcon or '')
		else
			return GetFormattedUnitLevel(unit)..GetFormattedUnitClassification(unit)..GetFormattedUnitType(unit)
		end
	end

	local function GetUnitRoleString(unit)
		local role = UnitGroupRolesAssigned(unit)
		local roleList = nil

		if (role == 'TANK') then
			roleList = '   '..tankIcon..' '..TANK
		elseif (role == 'HEALER') then
			roleList = '   '..healIcon..' '..HEALER
		elseif (role == 'DAMAGER') then
			roleList = '   '..damagerIcon..' '..DAMAGER
		end

		return roleList
	end

		-- Healthbar coloring funtion

	local function SetHealthBarColor(unit)
		local r, g, b
		if (db.healthbar.custom.apply and not db.healthbar.reactionColoring) then
			r, g, b = db.healthbar.custom.color.r, db.healthbar.custom.color.g, db.healthbar.custom.color.b
		elseif (db.healthbar.reactionColoring and unit) then
			r, g, b = UnitSelectionColor(unit)
		else
			r, g, b = 0, 1, 0
		end

		GameTooltipStatusBar:SetStatusBarColor(r, g, b)
		GameTooltipStatusBar:SetBackdropColor(r, g, b, 0.3)
	end

	local function GetUnitRaidIcon(unit)
		local index = GetRaidTargetIndex(unit)

		if (index) then
			if (UnitIsPVP(unit) and db.showPVPIcons) then
				return ICON_LIST[index]..'11|t'
			else
				return ICON_LIST[index]..'11|t '
			end
		else
			return ''
		end
	end

	local function GetUnitPVPIcon(unit)
		local factionGroup = UnitFactionGroup(unit)

		if (UnitIsPVPFreeForAll(unit)) then
			if (db.showPVPIcons) then
				return '|TInterface\\AddOns\\MyCore\\Media\\UI-PVP-FFA:12|t'
			else
				return '|cffFF0000# |r'
			end
		elseif (factionGroup and UnitIsPVP(unit)) then
			if (db.showPVPIcons) then
				return '|TInterface\\AddOns\\MyCore\\Media\\UI-PVP-'..factionGroup..':12|t'
			else
				return '|cff00FF00# |r'
			end
		else
			return ''
		end
	end

	local function AddMouseoverTarget(self, unit)
		local unitTargetName = UnitName(unit..'target')
		local unitTargetClassColor = RAID_CLASS_COLORS[select(2, UnitClass(unit..'target'))] or { r = 1, g = 0, b = 1 }
		local unitTargetReactionColor = {
			r = select(1, UnitSelectionColor(unit..'target')),
			g = select(2, UnitSelectionColor(unit..'target')),
			b = select(3, UnitSelectionColor(unit..'target'))
		}

		if (UnitExists(unit..'target')) then
			if (UnitName('player') == unitTargetName) then
				self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cffff00ff%s|r', string.upper("** YOU **")), 1, 1, 1)
			else
				if (UnitIsPlayer(unit..'target')) then
					self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cff%02x%02x%02x%s|r', unitTargetClassColor.r*255, unitTargetClassColor.g*255, unitTargetClassColor.b*255, unitTargetName:sub(1, 40)), 1, 1, 1)
				else
					self:AddLine(format('|cffFFFF00Target|r: '..GetUnitRaidIcon(unit..'target')..'|cff%02x%02x%02x%s|r', unitTargetReactionColor.r*255, unitTargetReactionColor.g*255, unitTargetReactionColor.b*255, unitTargetName:sub(1, 40)), 1, 1, 1)
				end
			end
		end
	end

	GameTooltip.inspectCache = {}

	GameTooltip:HookScript('OnTooltipSetUnit', function(self, ...)
		local unit = GetRealUnit(self)

		if (db.hideInCombat and InCombatLockdown()) then
			self:Hide()
			return
		end

		if (UnitExists(unit) and UnitName(unit) ~= UNKNOWN) then

			local ilvl = 0
			local specIcon = ''
			local lastUpdate = 30
			for index, _ in pairs(self.inspectCache) do
				local inspectCache = self.inspectCache[index]
				if (inspectCache.GUID == UnitGUID(unit)) then
					ilvl = inspectCache.itemLevel or 0
					specIcon = inspectCache.specIcon or ''
					lastUpdate = inspectCache.lastUpdate and math.abs(inspectCache.lastUpdate - math.floor(GetTime())) or 30
				end
			end

				-- Fetch inspect information (ilvl and spec)

			if (unit and CanInspect(unit)) then
				if (not self.inspectRefresh and lastUpdate >= 30 and not self.blockInspectRequests) then
					if (not self.blockInspectRequests) then
						self.inspectRequestSent = true
						NotifyInspect(unit)
					end
				end
			end

			self.inspectRefresh = false

			local name, realm = UnitName(unit)

				-- Hide player titles

			if (db.showPlayerTitles) then
				if (UnitPVPName(unit)) then
					name = UnitPVPName(unit)
				end
			end

			GameTooltipTextLeft1:SetText(name)

				-- Color guildnames

			if (GetGuildInfo(unit)) then
				if (GetGuildInfo(unit) == GetGuildInfo('player') and IsInGuild('player')) then
				   GameTooltipTextLeft2:SetText('|cffFF66CC'..GameTooltipTextLeft2:GetText()..'|r')
				end
			end

				-- Tooltip level text

			for i = 2, GameTooltip:NumLines() do
				if (_G['GameTooltipTextLeft'..i]:GetText():find('^'..TOOLTIP_UNIT_LEVEL:gsub('%%s', '.+'))) then
					_G['GameTooltipTextLeft'..i]:SetText(GetFormattedUnitString(unit, specIcon))
				end
			end

				-- Role text

			if (db.showUnitRole) then
				self:AddLine(GetUnitRoleString(unit), 1, 1, 1)
			end

				-- Mouse over target with raidicon support

			if (db.showMouseoverTarget) then
				AddMouseoverTarget(self, unit)
			end

				-- Pvp flag prefix

			for i = 3, GameTooltip:NumLines() do
				if (_G['GameTooltipTextLeft'..i]:GetText():find(PVP_ENABLED)) then
					_G['GameTooltipTextLeft'..i]:SetText(nil)
					GameTooltipTextLeft1:SetText(GetUnitPVPIcon(unit)..GameTooltipTextLeft1:GetText())
				end
			end

				-- Raid icon, want to see the raidicon on the left

			GameTooltipTextLeft1:SetText(GetUnitRaidIcon(unit)..GameTooltipTextLeft1:GetText())

				-- Afk and dnd prefix

			if (UnitIsAFK(unit)) then
				self:AppendText('|cff00ff00 <AFK>|r')
			elseif (UnitIsDND(unit)) then
				self:AppendText('|cff00ff00 <DND>|r')
			end

				-- Player realm names

			if (realm and realm ~= '') then
				if (db.abbrevRealmNames)   then
					self:AppendText(' (*)')
				else
					self:AppendText(' - '..realm)
				end
			end

				-- Move the healthbar inside the tooltip

			self:AddLine(' ')
			GameTooltipStatusBar:ClearAllPoints()
			GameTooltipStatusBar:SetPoint('LEFT', self:GetName()..'TextLeft'..self:NumLines(), 1, -3)
			GameTooltipStatusBar:SetPoint('RIGHT', self, -10, 0)

				-- Border coloring

			if (db.reactionBorderColor) then
				local r, g, b = UnitSelectionColor(unit)
					self:SetBackdropBorderColor(r, g, b)
			end

				-- Dead or ghost recoloring

			if (UnitIsDead(unit) or UnitIsGhost(unit)) then
				GameTooltipStatusBar:SetBackdropColor(0.5, 0.5, 0.5, 0.3)
			else
				if (not db.healthbar.custom.apply and not db.healthbar.reactionColoring) then
					GameTooltipStatusBar:SetBackdropColor(27/255, 243/255, 27/255, 0.3)
				else
					SetHealthBarColor(unit)
				end
			end

				-- Custom healthbar coloring

			if (db.healthbar.reactionColoring or db.healthbar.custom.apply) then
				GameTooltipStatusBar:HookScript('OnValueChanged', function()
					SetHealthBarColor(unit)
				end)
			end

				-- Show player item lvl

			if (db.showItemLevel and ilvl > 1) then
				GameTooltip:AddLine(STAT_AVERAGE_ITEM_LEVEL .. ': ' .. '|cffFFFFFF'..ilvl..'|r')
			end

				-- Symbiosis

			if (UnitIsPlayer(unit) and not UnitIsEnemy(unit, 'player')) then
				local hasSymbiosisBuff = false
				for i = 1, 40 do
					if select(11, UnitAura(unit, i, 'HELPFUL')) == 110309 then
						hasSymbiosisBuff = true
						break
					end
				end

				local _, playerClass = UnitClass('player')
				local _, unitClass = UnitClass(unit)
				local spec = SPEC_CORE_ABILITY_TEXT[GetSpecializationInfo(GetSpecialization() or 1)]
				local spellID = (playerClass == 'DRUID' and unitClass ~= 'DRUID') and symbiosis.grant[unitClass][spec] or (playerClass ~= 'DRUID' and unitClass == 'DRUID') and symbiosis.grant[playerClass][spec]
				local name, _, icon = GetSpellInfo(spellID)

				if (hasSymbiosisBuff) then
					GameTooltip:AddLine(' ')
					GameTooltip:AddLine('|cff3eea23'..GetSpellInfo(110309)..' already buffed|r')
				end

				if (icon) then
					GameTooltip:AddLine(' ')
					GameTooltip:AddDoubleLine('|T'..icon..':16:16:0:0:64:64:4:60:4:60|t '..name, '|cff3eea23'..GetSpellInfo(110309)..'|r')
				end
			end
		end
	end)

	GameTooltip:HookScript('OnTooltipCleared', function(self)
		GameTooltipStatusBar:ClearAllPoints()
		GameTooltipStatusBar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0.5, 3)
		GameTooltipStatusBar:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -1, 3)
		GameTooltipStatusBar:SetBackdropColor(0, 1, 0, 0.3)

		if (db.reactionBorderColor) then
			self:SetBackdropColor(1, 1, 1)
		end
	end)


		-- Hide coalesced/interactive realm information

	if (db.hideRealmText) then
		local COALESCED_REALM_TOOLTIP1 = string.split(FOREIGN_SERVER_LABEL, COALESCED_REALM_TOOLTIP)
		local INTERACTIVE_REALM_TOOLTIP1 = string.split(INTERACTIVE_SERVER_LABEL, INTERACTIVE_REALM_TOOLTIP)
		-- Dirty checking of the coalesced realm text because it's added
		-- after the initial OnShow
		GameTooltip:HookScript('OnUpdate', function(self)
			for i = 3, self:NumLines() do
				local row = _G['GameTooltipTextLeft'..i]
				local rowText = row:GetText()

				if (rowText) then
					if (rowText:find(COALESCED_REALM_TOOLTIP1) or rowText:find(INTERACTIVE_REALM_TOOLTIP1)) then
						row:SetText(nil)
						row:Hide()

						local previousRow = _G['GameTooltipTextLeft'..(i - 1)]
						previousRow:SetText(nil)
						previousRow:Hide()

						self:Show()
					end
				end
			end
		end)
	end

	hooksecurefunc('GameTooltip_SetDefaultAnchor', function(self, parent)
		if (db.showOnMouseover) then
			self:SetOwner(parent, 'ANCHOR_CURSOR')
		end
	end)


	GameTooltip:RegisterEvent('INSPECT_READY')
	GameTooltip:SetScript('OnEvent', function(self, event, GUID)
		if (not self:IsShown()) then
			return
		end

		local _, unit = self:GetUnit()

		if (not unit) then
			return
		end

		if (self.blockInspectRequests) then
			self.inspectRequestSent = false
		end

		if (UnitGUID(unit) ~= GUID or not self.inspectRequestSent) then
			if (not self.blockInspectRequests) then
				ClearInspectPlayer()
			end
			return
		end

		local _, _, _, icon = GetSpecializationInfoByID(GetInspectSpecialization(unit))
		local ilvl = GetItemLevel(unit)
		local now = GetTime()

		local matchFound
		for index, _ in pairs(self.inspectCache) do
			local inspectCache = self.inspectCache[index]
			if (inspectCache.GUID == GUID) then
				inspectCache.itemLevel = ilvl
				inspectCache.specIcon = icon and ' |T'..icon..':0|t' or ''
				inspectCache.lastUpdate = math.floor(now)
				matchFound = true
			end
		end

		if not matchFound then
			local GUIDInfo = {
				['GUID'] = GUID,
				['itemLevel'] = ilvl,
				['specIcon'] = icon and ' |T'..icon..':0|t' or '',
				['lastUpdate'] = math.floor(now)
			}
			table.insert(self.inspectCache, GUIDInfo)
		end

		if (#self.inspectCache > 30) then
			table.remove(self.inspectCache, 1)
		end

		self.inspectRefresh = true
		GameTooltip:SetUnit('mouseover')

		if (not self.blockInspectRequests) then
			ClearInspectPlayer()
		end
		self.inspectRequestSent = false
	end)

	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript('OnEvent', function(self, event)
		if IsAddOnLoaded('Blizzard_InspectUI') then
			hooksecurefunc('InspectFrame_Show', function(unit)
				GameTooltip.blockInspectRequests = true
			end)

			InspectFrame:HookScript('OnHide', function()
				GameTooltip.blockInspectRequests = false
			end)

			self:UnregisterEvent('ADDON_LOADED')
		end
	end)

	local select = select
	local tonumber = tonumber

	local modf = math.modf
	local gsub = string.gsub
	local format = string.format

	local bar = GameTooltipStatusBar
	bar.Text = bar:CreateFontString(nil, 'OVERLAY')
	bar.Text:SetPoint('CENTER', bar, db.healthbar.textPos, 0, 1)

	if (db.healthbar.showOutline) then
		bar.Text:SetFont(BasicUI.media.fontNormal, db.healthbar.fontSize, 'THINOUTLINE')
		bar.Text:SetShadowOffset(0, 0)
	else
		bar.Text:SetFont(BasicUI.media.fontNormal, db.healthbar.fontSize)
		bar.Text:SetShadowOffset(1, -1)
	end

	local function ColorGradient(perc, ...)
		if (perc >= 1) then
			local r, g, b = select(select('#', ...) - 2, ...)
			return r, g, b
		elseif (perc <= 0) then
			local r, g, b = ...
			return r, g, b
		end

		local num = select('#', ...) / 3

		local segment, relperc = modf(perc*(num-1))
		local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

		return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
	end

	local function FormatValue(value)
		if (value >= 1e6) then
			return tonumber(format('%.1f', value/1e6))..'m'
		elseif (value >= 1e3) then
			return tonumber(format('%.1f', value/1e3))..'k'
		else
			return value
		end
	end

	local function DeficitValue(value)
		if (value == 0) then
			return ''
		else
			return '-'..FormatValue(value)
		end
	end

	local function GetHealthTag(text, cur, max)
		local perc = format('%d', (cur/max)*100)

		if (max == 1) then
			return perc
		end

		local r, g, b = ColorGradient(cur/max, 1, 0, 0, 1, 1, 0, 0, 1, 0)
		text = gsub(text, '$cur', format('%s', FormatValue(cur)))
		text = gsub(text, '$max', format('%s', FormatValue(max)))
		text = gsub(text, '$deficit', format('%s', DeficitValue(max-cur)))
		text = gsub(text, '$perc', format('%d', perc)..'%%')
		text = gsub(text, '$smartperc', format('%d', perc))
		text = gsub(text, '$smartcolorperc', format('|cff%02x%02x%02x%d|r', r*255, g*255, b*255, perc))
		text = gsub(text, '$colorperc', format('|cff%02x%02x%02x%d', r*255, g*255, b*255, perc)..'%%|r')

		return text
	end

	GameTooltipStatusBar:HookScript('OnValueChanged', function(self, value)
		if (self.Text) then
			self.Text:SetText('')
		end

		if (not value) then
			return
		end

		local min, max = self:GetMinMaxValues()

		if ((value < min) or (value > max) or (value == 0) or (value == 1)) then
			return
		end

		if (not self.Text) then
			CreateHealthString(self)
		end

		local fullString = GetHealthTag(db.healthbar.healthFullFormat, value, max)
		local normalString = GetHealthTag(db.healthbar.healthFormat, value, max)

		local perc = (value/max)*100 
		if (perc >= 100 and currentValue ~= 1) then
			self.Text:SetText(fullString)
		elseif (perc < 100 and currentValue ~= 1) then
			self.Text:SetText(normalString)
		else
			self.Text:SetText('')
		end
	end)	
end


------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

local options
function Tooltip:GetOptions()
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
				name = L["Enable Tooltip Module"],
				width = "full",
			},
			disableFade = {
				type = "toggle",
				order = 2,
				name = L["Disable Fade"],
				desc = L["Disables Tooltip Fade."],
				disabled = function() return isModuleDisabled() or not db.enable end,
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
			showItemLevel = {
				type = "toggle",
				order = 2,
				name = L["Item Level"],
				desc = L["Shows targets average item level."],
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
				order = 6,
				name = L["Healthbar"],
				desc = L["Players Healthbar Options."],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.healthbar[ info[#info] ] end,
				set = function(info, value) db.healthbar[ info[#info] ] = value;   end,
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
					custom = {
						type = "group",
						order = 6,
						name = L["Custom"],
						desc = L["Custom Coloring"],
						childGroups = "tree",
						disabled = function() return isModuleDisabled() or not db.enable end,
						get = function(info) return db.healthbar.custom[ info[#info] ] end,
						set = function(info, value) db.healthbar.custom[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								name = " ",
								order = 2,
							},
							sep2 = {
								type = "description",
								name = " ",
								order = 3,
							},
							sep3 = {
								type = "description",
								name = " ",
								order = 4,
							},
							sep4 = {
								type = "description",
								name = " ",
								order = 5,
							},
							---------------------------
							apply = {
								type = "toggle",
								order = 2,
								name = L["Apply Custom Color"],
								desc = L["Use the Custom Color you have chosen."],
								disabled = function() return isModuleDisabled() or not db.enable end,
							},
							color = {
								type = "color",
								order = 4,
								name = L["Custom Color"],
								desc = L["Picks a Custom Color for the tooltip border."],
								hasAlpha = false,
								disabled = function() return isModuleDisabled() or not db.healthbar.custom.apply or not db.enable end,
								get = function(info)
									local hb = db.healthbar.custom[ info[#info] ]
									return hb.r, hb.g, hb.b
								end,
								set = function(info, r, g, b)
									db.healthbar.custom[ info[#info] ] = {}
									local hb = db.healthbar.custom[ info[#info] ]
									hb.r, hb.g, hb.b = r, g, b
								end,
							},
						},
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