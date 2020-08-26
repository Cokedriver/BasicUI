local MODULE_NAME = "Selfbuffs"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,			-- enable selbuffs module.
		sound = true,			-- Play Sound
	},
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function MODULE:OnEnable()
	if db.enable ~= true then return end

	--------------------------------
	-- source TukUI - www.tukui.org
	--------------------------------

	--------------------------------------------------------------------------------------------
	-- Spells that should be shown with an icon in the middle of the screen when not buffed.
	--------------------------------------------------------------------------------------------
		 
	remindbuffs = {

		ROGUE = {
			55610, 		-- Unholy Aura (Deathknight)
			113742,		-- Swiftblade's Cunning (Rogue)
			30809,		-- Unleashed Rage (Shaman)
			128432,		-- Cackling Howl (Hunter Pet)
			128433,		-- Serpent's Swiftness (Hunter Pet)
		},
		DRUID = {
			1126,  		-- Mark of the Wild (Druid)
			115921, 	-- Legacy of the Emperor (Monk)
			20217, 		-- Blessing of Kings (Paladin)
			90363, 		-- Embrace of the Shale Spider (Hunter Pet)
			24907,		-- Moonkin Aura (Druid)
			15473,		-- Shadowform (Priest)
			51470,		-- Elemental Oath (Shaman)
			49868,		-- Mind Quickening (Hunter Pet)
			17007,		-- Leader of the Pack (Druid)
			116781, 	-- Legacy of the White Tiger (Monk)
			97229, 		-- Bellowing Roar (Hunter Pet)
			24604,		-- Furious Howl (Hunter Pet)
			90309,		-- Terrifying Roar (Hunter Pet)
			126373,		-- Fearless Roar (Hunter Pet)
			126309, 	-- Still Water (Hunter Pet)
		},
		PRIEST = {
			588, 		-- Inner Fire
			73413, 		-- Inner Will
			21562, 		-- Power Word: Fortitude (Priest)
			103127,		-- Imp: Blood Pact (Warlock Pet)
			469, 		-- Commanding Shout (Warrior)
			90364,		-- Qiraji Fortitude (Hunter Pet)
			24907,		-- Moonkin Aura (Druid)
			15473,		-- Shadowform (Priest)
			51470,		-- Elemental Oath (Shaman)
			49868,		-- Mind Quickening (Hunter Pet)
		},
		PALADIN ={
			20217, 		-- Blessing of Kings (Paladin)
			19740, 		-- Blessing of Might (Paladin)
			116956, 	-- Grace of Air (Shaman)
			93435, 		-- Roar of Courage (Hunter Pet)
			128997, 	-- Spirit Beast Blessing (Hunter Pet)
			90363, 		-- Embrace of the Shale Spider (Hunter Pet)
			1126,  		-- Mark of the Wild (Druid)
			115921, 	-- Legacy of the Emperor (Monk)
		},
		HUNTER = {
			13165, 		-- Aspect of the Hawk
			5118, 		-- Aspect of the Beast
			13159, 		-- Aspect of the Hawk
			61648, 		-- Aspect of the Beast
			82661, 		-- Aspect of the Fox
			109260, 	-- Aspect of the Iron Hawk
			93435, 		-- Roar of Courage (Hunter Pet)
			116956, 	-- Grace of Air (Shaman)
			128997, 	-- Spirit Beast Blessing (Hunter Pet))
			90363, 		-- Embrace of the Shale Spider (Hunter Pet)
			90364,		-- Qiraji Fortitude (Hunter Pet)
			57330, 		-- Horn of Winter (Deathknight)
			19506, 		-- Trueshot Aura (Hunter)
			6673, 		-- Battle Shout (Warrior)
			1459, 		-- Arcane Brilliance (Mage)
			61316,		-- Dalaran Brilliance (Mage)
			77747, 		-- Burning Wrath (Shaman)
			109773, 	-- Dark Intent (Warlock)
			126309, 	-- Still Water (Hunter Pet)
			55610, 		-- Unholy Aura (Deathknight)
			113742,		-- Swiftblade's Cunning (Rogue)
			30809,		-- Unleashed Rage (Shaman)
			128432,		-- Cackling Howl (Hunter Pet)
			128433,		-- Serpent's Swiftness (Hunter Pet)
			24907,		-- Moonkin Aura (Druid)
			15473,		-- Shadowform (Priest)
			51470,		-- Elemental Oath (Shaman)
			49868,		-- Mind Quickening (Hunter Pet)
			17007,		-- Leader of the Pack (Druid)
			116781, 	-- Legacy of the White Tiger (Monk)
			97229, 		-- Bellowing Roar (Hunter Pet)
			24604,		-- Furious Howl (Hunter Pet)
			90309,		-- Terrifying Roar (Hunter Pet)
			126373,		-- Fearless Roar (Hunter Pet)
			19740, 		-- Blessing of Might (Paladin)
			1126,  		-- Mark of the Wild (Druid)
			115921, 	-- Legacy of the Emperor (Monk)
		},
		
		MAGE = {
			7302, 		-- Frost Armor
			6117, 		-- Mage Armor
			30482, 		-- Molten Armor
			1459, 		-- Arcane Brilliance (Mage)
			77747, 		-- Burning Wrath (Shaman)
			109773, 	-- Dark Intent (Warlock)
			126309, 	-- Still Water (Hunter Pet)
			17007,		-- Leader of the Pack (Druid)
			116781, 	-- Legacy of the White Tiger (Monk)
			97229, 		-- Bellowing Roar (Hunter Pet)
			24604,		-- Furious Howl (Hunter Pet)
			90309,		-- Terrifying Roar (Hunter Pet)
			126373,		-- Fearless Roar (Hunter Pet)
			61316,		-- Dalaran Brilliance (Mage)
		},
		
		MONK = {
			115921, 	-- Legacy of the Emperor (Monk)
			116781, 	-- Legacy of the White Tiger (Monk)
			1126,  		-- Mark of the Wild (Druid)
			20217, 		-- Blessing of Kings (Paladin)
			90363, 		-- Embrace of the Shale Spider (Hunter Pet)
			17007,		-- Leader of the Pack (Druid)
			97229, 		-- Bellowing Roar (Hunter Pet)
			24604,		-- Furious Howl (Hunter Pet)
			90309,		-- Terrifying Roar (Hunter Pet)
			126373,		-- Fearless Roar (Hunter Pet)
			126309, 	-- Still Water (Hunter Pet)
		},
		
		WARLOCK = {
			21562, 		-- Power Word: Fortitude (Priest)
			103127, 	-- Imp: Blood Pact (Warlock Pet)
			469, 		-- Commanding Shout (Warrior)
			90364,		-- Qiraji Fortitude (Hunter Pet)
			1459, 		-- Arcane Brilliance (Mage)
			61316,		-- Dalaran Brilliance (Mage)
			77747, 		-- Burning Wrath (Shaman)
			109773, 	-- Dark Intent (Warlock)
			126309, 	-- Still Water (Hunter Pet)
		},
		SHAMAN = {
			52127, 		-- Water Shield
			324, 		-- Lightning Shield
			974, 		-- Earth Shield
			116956, 	-- Grace of Air (Shaman)
			93435, 		-- Roar of Courage (Hunter Pet)
			19740, 		-- Blessing of Might (Paladin)
			128997, 	-- Spirit Beast Blessing (Hunter Pet)
			1459, 		-- Arcane Brilliance (Mage)
			61316,		-- Dalaran Brilliance (Mage)
			77747, 		-- Burning Wrath (Shaman)
			109773, 	-- Dark Intent (Warlock)
			126309, 	-- Still Water (Hunter Pet)
			55610, 		-- Unholy Aura (Deathknight)
			113742,		-- Swiftblade's Cunning (Rogue)
			30809,		-- Unleashed Rage (Shaman)
			128432,		-- Cackling Howl (Hunter Pet)
			128433,		-- Serpent's Swiftness (Hunter Pet)
			24907,		-- Moonkin Aura (Druid)
			15473,		-- Shadowform (Priest)
			51470,		-- Elemental Oath (Shaman)
			49868,		-- Mind Quickening (Hunter Pet)
		},
		WARRIOR = {
			469, 		-- Commanding Shout (Warrior)
			6673, 		-- Battle Shout (Warrior)
			21562, 		-- Power Word: Fortitude (Priest)
			103127, 	-- Imp: Blood Pact (Warlock Pet)
			90364,		-- Qiraji Fortitude (Hunter Pet)
			57330, 		-- Horn of Winter (Deathknight)
			19506, 		-- Trueshot Aura (Hunter)
		},
		DEATHKNIGHT = {
			57330, 		-- Horn of Winter (Deathknight)
			19506, 		-- Trueshot Aura (Hunter)
			6673, 		-- Battle Shout (Warrior)
			31634, 		-- Strength of Earth Totem
			6673, 		-- Battle Shout
			93435, 		-- roar of courage (hunter pet)	
			55610, 		-- Unholy Aura (Deathknight)
			113742,		-- Swiftblade's Cunning (Rogue)
			30809,		-- Unleashed Rage (Shaman)
			128432,		-- Cackling Howl (Hunter Pet)
			128433,		-- Serpent's Swiftness (Hunter Pet)
		},
		
	}

	remindenchants = {
		ROGUE = {
			2842, -- poison
		},
		SHAMAN = {
			8024, -- flametongue
			8232, -- windfury
			51730, -- earthliving
		},
	}

	-- Nasty stuff below. Don't touch.
	local class = select(2, UnitClass('Player'))
	local buffs = remindbuffs[class]
	local enchants = remindenchants[class]
	local sound 


	if (buffs and buffs[1] and UnitLevel("player") > 10) then
		local function OnEvent(self, event)	
			if (event == 'PLAYER_LOGIN' or event == 'LEARNED_SPELL_IN_TAB') then
				for i, buff in pairs(buffs) do
					local name = GetSpellInfo(buff)
					local usable, nomana = IsUsableSpell(name)
					if (usable or nomana) then
						self.icon:SetTexture(select(3, GetSpellInfo(buff)))
						break
					end
				end
				if (not self.icon:GetTexture() and event == 'PLAYER_LOGIN') then
					self:UnregisterAllEvents()
					self:RegisterEvent('LEARNED_SPELL_IN_TAB')
					return
				elseif (self.icon:GetTexture() and event == 'LEARNED_SPELL_IN_TAB') then
					self:UnregisterAllEvents()
					self:RegisterEvent('UNIT_AURA')
					self:RegisterEvent('PLAYER_LOGIN')
					self:RegisterEvent('PLAYER_REGEN_ENABLED')
					self:RegisterEvent('PLAYER_REGEN_DISABLED')
				end
			end
						
			if (UnitAffectingCombat('player') and not UnitInVehicle('player')) then
				for i, buff in pairs(buffs) do
					local name = GetSpellInfo(buff)
					if (name and UnitBuff('player', name)) then
						self:Hide()
						sound = true
						return
					end
				end
				self:Show()
				if db.sound == true and sound == true then
					PlaySoundFile([[Interface\AddOns\BasicUI\Media\Warning.mp3]])
					sound = false
				end
			else
				self:Hide()
				sound = true
			end
		end
		
		local frame = CreateFrame('Frame', nil, UIParent)
		frame:SetPoint('CENTER', UIParent, 0, 150)
		frame:SetSize(50, 50)
		frame:SetBackdrop({
			bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
			edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
			tile = true,
			tileSize = 16,
			edgeSize = 12,
			insets = {left=3, right=3, top=3, bottom=3},
		})
		frame:SetBackdropColor(0, 0, 0, 1)
		frame:Hide()
		
		frame.icon = frame:CreateTexture(nil, 'BACKGROUND')
		frame.icon:SetPoint('CENTER', frame)
		frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.icon:SetSize(45, 45)
		frame.icon:SetParent(frame)
			
		 
		frame:RegisterEvent('UNIT_AURA')
		frame:RegisterEvent('PLAYER_LOGIN')
		frame:RegisterEvent('PLAYER_REGEN_ENABLED')
		frame:RegisterEvent('PLAYER_REGEN_DISABLED')
		
		frame:SetScript('OnEvent', OnEvent)
			

	end

	if (enchants and enchants[1] and UnitLevel("player") > 10) then
		local sound
		local currentlevel = UnitLevel("player")

		local function EnchantsOnEvent(self, event)
			if (event == "PLAYER_LOGIN") or (event == "ACTIVE_TALENT_GROUP_CHANGED") or (event == "PLAYER_LEVEL_UP") then
				if class == "ROGUE" then
					self:UnregisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
					self:UnregisterEvent("PLAYER_LEVEL_UP")
					self.icon:SetTexture(select(3, GetSpellInfo(enchants[1])))
					return
				elseif class == "SHAMAN" then
					local ptt = GetSpecialization ()
					if ptt and ptt == 3 and currentlevel > 53 then
						self.icon:SetTexture(select(3, GetSpellInfo(enchants[3])))
					elseif ptt and ptt == 2 and currentlevel > 31 then
						self.icon:SetTexture(select(3, GetSpellInfo(enchants[2])))
					else
						self.icon:SetTexture(select(3, GetSpellInfo(enchants[1])))
					end
					return
				end
			end

			if (class == "ROGUE" or class =="SHAMAN") and currentlevel < 10 then return end

			if (UnitAffectingCombat("player") and not UnitInVehicle("player")) then
				local mainhand, _, _, offhand, _, _, thrown = GetWeaponEnchantInfo()
				if class == "ROGUE" then
					local itemid = GetInventoryItemID("player", GetInventorySlotInfo("RangedSlot"))
					if itemid and select(7, GetItemInfo(itemid)) == INVTYPE_THROWN and currentlevel > 61 then
						if mainhand and offhand and thrown then
							self:Hide()
							sound = true
							return
						end
					else
						if mainhand and offhand then
							self:Hide()
							sound = true
							return
						end
					end
				elseif class == "SHAMAN" then
					local itemid = GetInventoryItemID("player", GetInventorySlotInfo("SecondaryHandSlot"))
					if itemid and select(6, GetItemInfo(itemid)) == ENCHSLOT_WEAPON then
						if mainhand and offhand then
							self:Hide()
							sound = true
							return
						end
					elseif mainhand then
						self:Hide()
						sound = true
						return
					end
				end
				self:Show()
				if db.sound == true and sound == true then
					PlaySoundFile([[Interface\AddOns\BasicUI\Media\Warning.mp3]])
					sound = false
				end
			else
				self:Hide()
				sound = true
			end
		end

		local frame = CreateFrame('Frame', nil, UIParent)
		frame:SetPoint('CENTER', UIParent, 0, 150)
		frame:SetSize(50, 50)
		frame:SetBackdrop({
			bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
			edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
			tile = true,
			tileSize = 16,
			edgeSize = 12,
			insets = {left=3, right=3, top=3, bottom=3},
		})
		frame:SetBackdropColor(0, 0, 0, 1)
		frame:Hide()
		
		frame.icon = frame:CreateTexture(nil, 'BACKGROUND')
		frame.icon:SetPoint('CENTER', frame)
		frame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		frame.icon:SetSize(45, 45)
		frame.icon:SetParent(frame)
			
		frame:RegisterEvent("PLAYER_LOGIN")
		frame:RegisterEvent("PLAYER_LEVEL_UP")
		frame:RegisterEvent("PLAYER_REGEN_ENABLED")
		frame:RegisterEvent("PLAYER_REGEN_DISABLED")
		frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
		frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")

		frame:SetScript("OnEvent", EnchantsOnEvent)
	end
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
				desc = L["Enables the Selfbuffs Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			sound = {
				type = "toggle",
				order = 1,
				name = L["Sound"],
				desc = L["Toggle playing a sound on or off"],
				width = "full",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		},
	}
	return options
end