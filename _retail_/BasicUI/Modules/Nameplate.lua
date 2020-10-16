local MODULE_NAME = "Nameplate"
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
		ColorNameByThreat = false,
		ShowHP = true,
		ShowCurHP = true,
		ShowPercHP = true,
		ShowFullHP = true,
		ShowLevel = true,
		ShowServerName = false,
		AbrrevLongNames = true,
		HideFriendly = false,
		DontClamp = false,
		ShowTotemIcon = false,
		UseOffTankColor = false,
		OffTankColor = { r = 0.60, g = 0.20, b = 1.0},
		ShowPvP = false,		
	}
}

------------------------------------------------------------------------
--	Module Functions
------------------------------------------------------------------------

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end


function MODULE:OnEnable()
	if db.enable ~= true then return end

	-------------------------------------------------
	-- Borrowerd from nPlates by Grimsbain
	-------------------------------------------------
	local BNF = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate") -- BNF = Basic Nameplate Frame

	local len = string.len
	local gsub = string.gsub
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
		return ((val<0 and "-" or "").."%0."..precision.."f%s"):format(val/1000^factor,NumberCaps[factor] or "e"..(factor*3));
	end
	---------------
	-- Functions
	---------------

		-- PvP Icon
	local pvpIcons = {
		Alliance = "\124TInterface/PVPFrame/PVP-Currency-Alliance:16\124t",
		Horde = "\124TInterface/PVPFrame/PVP-Currency-Horde:16\124t",
	}

	BNF.PvPIcon = function(unit)
		if ( db.ShowPvP and UnitIsPlayer(unit) ) then
			local isPVP = UnitIsPVP(unit)
			local faction = UnitFactionGroup(unit)
			local icon = (isPVP and faction) and pvpIcons[faction] or ""

			return icon
		end
		return ""
	end

		-- Check for "Larger Nameplates"

	BNF.IsUsingLargerNamePlateStyle = function()
		local namePlateVerticalScale = tonumber(GetCVar("NamePlateVerticalScale"))
		return namePlateVerticalScale > 1.0
	end

		-- Check if the frame is a nameplate.

	BNF.FrameIsNameplate = function(frame)
		if ( string.match(frame.displayedUnit,"nameplate") ~= "nameplate") then
			return false
		else
			return true
		end
	end

		-- Checks to see if target has tank role.

	BNF.PlayerIsTank = function(target)
		local assignedRole = UnitGroupRolesAssigned(target)

		return assignedRole == "TANK"
	end

		-- Abbreviate Function

	BNF.Abbrev = function(str,length)
		if ( str ~= nil and length ~= nil ) then
			str = (len(str) > length) and gsub(str, "%s?(.[\128-\191]*)%S+%s", "%1. ") or str
			return str
		end
		return ""
	end

		-- RBG to Hex Colors

	BNF.RGBHex = function(r, g, b)
		if ( type(r) == "table" ) then
			if ( r.r ) then
				r, g, b = r.r, r.g, r.b
			else
				r, g, b = unpack(r)
			end
		end

		return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
	end

	-- Off Tank Color Checks

	BNF.UseOffTankColor = function(target)
		if ( db.UseOffTankColor and (UnitPlayerOrPetInRaid(target) or UnitPlayerOrPetInParty(target)) ) then
			if ( not UnitIsUnit("player",target) and BNF.PlayerIsTank(target) and BNF.PlayerIsTank("player") ) then
				return true
			end
		end
		return false
	end

		-- Totem Data and Functions

	local function TotemName(SpellID)
		local name = GetSpellInfo(SpellID)
		return name
	end

	local totemData = {
		[TotemName(192058)] = [[Interface\Icons\spell_nature_brilliance]],          -- Lightning Surge Totem
		[TotemName(98008)]  = [[Interface\Icons\spell_shaman_spiritlink]],          -- Spirit Link Totem
		[TotemName(192077)] = [[Interface\Icons\ability_shaman_windwalktotem]],     -- Wind Rush Totem
		[TotemName(204331)] = [[Interface\Icons\spell_nature_wrathofair_totem]],    -- Counterstrike Totem
		[TotemName(204332)] = [[Interface\Icons\spell_nature_windfury]],            -- Windfury Totem
		[TotemName(204336)] = [[Interface\Icons\spell_nature_groundingtotem]],      -- Grounding Totem
		-- Water
		[TotemName(157153)] = [[Interface\Icons\ability_shaman_condensationtotem]], -- Cloudburst Totem
		[TotemName(5394)]   = [[Interface\Icons\INV_Spear_04]],                     -- Healing Stream Totem
		[TotemName(108280)] = [[Interface\Icons\ability_shaman_healingtide]],       -- Healing Tide Totem
		-- Earth
		[TotemName(207399)] = [[Interface\Icons\spell_nature_reincarnation]],       -- Ancestral Protection Totem
		[TotemName(198838)] = [[Interface\Icons\spell_nature_stoneskintotem]],      -- Earthen Shield Totem
		[TotemName(51485)]  = [[Interface\Icons\spell_nature_stranglevines]],       -- Earthgrab Totem
		[TotemName(61882)]  = [[Interface\Icons\spell_shaman_earthquake]],          -- Earthquake Totem
		[TotemName(196932)] = [[Interface\Icons\spell_totem_wardofdraining]],       -- Voodoo Totem
		-- Fire
		[TotemName(192222)] = [[Interface\Icons\spell_shaman_spewlava]],            -- Liquid Magma Totem
		[TotemName(204330)] = [[Interface\Icons\spell_fire_totemofwrath]],          -- Skyfury Totem
		-- Totem Mastery
		[TotemName(202188)] = [[Interface\Icons\spell_nature_stoneskintotem]],      -- Resonance Totem
		[TotemName(210651)] = [[Interface\Icons\spell_shaman_stormtotem]],          -- Storm Totem
		[TotemName(210657)] = [[Interface\Icons\spell_fire_searingtotem]],          -- Ember Totem
		[TotemName(210660)] = [[Interface\Icons\spell_nature_invisibilitytotem]],   -- Tailwind Totem
	}

	BNF.UpdateTotemIcon = function(frame)
		if ( not BNF.FrameIsNameplate(frame) ) then return end

		local name = UnitName(frame.displayedUnit)

		if name == nil then return end
		if (totemData[name] and db.ShowTotemIcon ) then
			if (not frame.TotemIcon) then
				frame.TotemIcon = CreateFrame("Frame", "$parentTotem", frame, BackdropTemplateMixin and "BackdropTemplate")
				frame.TotemIcon:EnableMouse(false)
				frame.TotemIcon:SetSize(24, 24)
				frame.TotemIcon:SetPoint("BOTTOM", frame.BuffFrame, "TOP", 0, 10)
			end

			if (not frame.TotemIcon.Icon) then
				frame.TotemIcon.Icon = frame.TotemIcon:CreateTexture("$parentIcon","BACKGROUND")
				frame.TotemIcon.Icon:SetSize(24,24)
				frame.TotemIcon.Icon:SetAllPoints(frame.TotemIcon)
				frame.TotemIcon.Icon:SetTexture(totemData[name])
				frame.TotemIcon.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end

			if (not frame.TotemIcon.Icon.Border) then
				frame.TotemIcon.Icon.Border = frame.TotemIcon:CreateTexture("$parentOverlay", "BORDER")
				frame.TotemIcon.Icon.Border:SetTexCoord(0, 1, 0, 1)
				frame.TotemIcon.Icon.Border:ClearAllPoints()
				frame.TotemIcon.Icon.Border:SetPoint("TOPRIGHT", frame.TotemIcon.Icon, 2.5, 2.5)
				frame.TotemIcon.Icon.Border:SetPoint("BOTTOMLEFT", frame.TotemIcon.Icon, -2.5, -2.5)
				frame.TotemIcon.Icon.Border:SetTexture(iconOverlay)
				frame.TotemIcon.Icon.Border:SetVertexColor(unpack(borderColor))
			end

			if ( frame.TotemIcon ) then
				frame.TotemIcon:Show()
			end
		else
			if (frame.TotemIcon) then
				frame.TotemIcon:Hide()
			end
		end
	end

	C_Timer.After(.1, function()

			-- Set Default Options

			-- Set CVars

		if not InCombatLockdown() then
			-- Set min and max scale.
			SetCVar("namePlateMinScale", 1)
			SetCVar("namePlateMaxScale", 1)

			-- Set sticky nameplates.
			if ( not db.DontClamp ) then
				--SetCVar("nameplateOtherTopInset", -1,true)
				--SetCVar("nameplateOtherBottomInset", -1,true)
			else
				for _, v in pairs({"nameplateOtherTopInset", "nameplateOtherBottomInset"}) do SetCVar(v, GetCVarDefault(v),true) end
			end
		end
	end)

	-----------------
	-- Update Name
	-----------------
	hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
		if ( not BNF.FrameIsNameplate(frame) ) then return end

			-- Totem Icon

		if ( db.ShowTotemIcon ) then
			BNF.UpdateTotemIcon(frame)
		end

			-- Hide Friendly Nameplates

		if ( UnitIsFriend(frame.displayedUnit,"player") and not UnitCanAttack(frame.displayedUnit,"player") and db.HideFriendly ) then
			frame.healthBar:Hide()
		else
			frame.healthBar:Show()
		end

		if ( not ShouldShowName(frame) ) then
			frame.name:Hide()
		else

				-- PvP Icon

			local pvpIcon = BNF.PvPIcon(frame.displayedUnit)

				-- Class Color Names

			if ( UnitIsPlayer(frame.displayedUnit) ) then
				local r,g,b = frame.healthBar:GetStatusBarColor()
				frame.name:SetTextColor(r,g,b)
			end

				-- Shorten Long Names

			local newName, realm = UnitName(frame.displayedUnit) or UNKNOWN

			if ( db.ShowServerName ) then
				name = name.." - "..realm
			end
			if ( db.AbrrevLongNames ) then
				newName = BNF.Abbrev(newName,20)
			end

				-- Level

			if ( db.ShowLevel ) then
				local playerLevel = UnitLevel("player")
				local targetLevel = UnitLevel(frame.displayedUnit)
				local difficultyColor = GetRelativeDifficultyColor(playerLevel, targetLevel)
				local levelColor = BNF.RGBHex(difficultyColor.r, difficultyColor.g, difficultyColor.b)

				if ( targetLevel == -1 ) then
					frame.name:SetText(pvpIcon..newName)
				else
					frame.name:SetText(pvpIcon.."|cffffff00|r"..levelColor..targetLevel.."|r "..newName)
				end
			else
				frame.name:SetText(pvpIcon..newName or newName)
			end

				-- Color Name To Threat Status

			if ( db.ColorNameByThreat ) then
				local isTanking, threatStatus = UnitDetailedThreatSituation("player", frame.displayedUnit)
				if ( isTanking and threatStatus ) then
					if ( threatStatus >= 3 ) then
						frame.name:SetTextColor(0,1,0)
					elseif ( threatStatus == 2 ) then
						frame.name:SetTextColor(1,0.6,0.2)
					end
				else
					local target = frame.displayedUnit.."target"
					if ( BNF.UseOffTankColor(target) ) then
						frame.name:SetTextColor(db.OffTankColor.r, db.OffTankColor.g, db.OffTankColor.b)
					end
				end
			end
		end
	end)

		-- Updated Health Text

	hooksecurefunc("CompactUnitFrame_UpdateStatusText", function(frame)
		if ( not BNF.FrameIsNameplate(frame) ) then return end

		local font = select(1,frame.name:GetFont())
		local hexa = ("|cff%.2x%.2x%.2x"):format(255, 255, 51)
		local hexb = "|r"

		if ( db.ShowHP ) then
			if ( not frame.healthBar.healthString ) then
				frame.healthBar.healthString = frame.healthBar:CreateFontString("$parentHeathValue", "OVERLAY")
				frame.healthBar.healthString:Hide()
				frame.healthBar.healthString:SetPoint("CENTER", frame.healthBar, 0, .5)
				frame.healthBar.healthString:SetFont(font, 12)
				frame.healthBar.healthString:SetShadowOffset(.5, -.5)
			end
		else
			if ( frame.healthBar.healthString ) then frame.healthBar.healthString:Hide() end
			return
		end

		local health = UnitHealth(frame.displayedUnit)
		local maxHealth = UnitHealthMax(frame.displayedUnit)
		local perc = (health/maxHealth)*100

		if ( perc >= 100 and health > 5 and db.ShowFullHP ) then
			if ( db.ShowCurHP and perc >= 100 ) then
				frame.healthBar.healthString:SetFormattedText(hexa.."%s"..hexb, AbbreviateNumber(health))
			elseif ( db.ShowCurHP and db.ShowPercHP ) then
				frame.healthBar.healthString:SetFormattedText(hexa.."%s - %s%%"..hexb, AbbreviateNumber(health), AbbreviateNumber(perc))
			elseif ( db.ShowCurHP ) then
				frame.healthBar.healthString:SetFormattedText(hexa.."%s"..hexb, AbbreviateNumber(health))
			elseif ( db.ShowPercHP ) then
				frame.healthBar.healthString:SetFormattedText(hexa.."%s%%"..hexb, AbbreviateNumber(perc))
			else
				frame.healthBar.healthString:SetText("")
			end
		elseif ( perc < 100 and health > 5 ) then
			if ( db.ShowCurHP and db.ShowPercHP ) then
				frame.healthBar.healthString:SetFormattedText(hexa.."%s - %s%%"..hexb, AbbreviateNumber(health), AbbreviateNumber(perc))
			elseif ( db.ShowCurHP ) then
				frame.healthBar.healthString:SetFormattedText(hexa.."%s"..hexb, AbbreviateNumber(health))
			elseif ( db.ShowPercHP ) then
				frame.healthBar.healthString:SetFormattedText(hexa.."%s%%"..hexb, AbbreviateNumber(perc))
			else
				frame.healthBar.healthString:SetText("")
			end
		else
			frame.healthBar.healthString:SetText("")
		end
		frame.healthBar.healthString:Show()
	end)
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
	
	options = {
		type = "group",
		name = L[MODULE_NAME],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
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
				desc = L["Enables the Nameplate Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = false,
			},
			ColorNameByThreat = {
				order = 2,
				name = L["Color Name By Threat"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			AbrrevLongNames = {
				order = 2,
				name = L["Abbreviate Long Names"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			HideFriendly = {
				order = 2,
				name = L["Hide Friendly Nameplates"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			DontClamp = {
				order = 2,
				name = L["Sticky Nameplates"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			UseOffTankColor = {
				order = 2,
				name = L["Use Off Tank Color"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			ShowTotemIcon = {
				order = 2,
				name = L["Show Totem Icon"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},			
			ShowPvP = {
				order = 2,
				name = L["Show PvP Icon"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			ShowHP = {
				order = 2,
				name = L["Show HP Text"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			ShowCurHP = {
				order = 2,
				name = L["Show Current Health Only"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			ShowPercHP = {
				order = 2,
				name = L["Show Percentage of Health Only"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			ShowFullHP = {
				order = 2,
				name = L["Show Both Health - Percent"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			ShowLevel = {
				order = 2,
				name = L["Show Target Level"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			ShowServerName = {
				order = 2,
				name = L["Show Server Name"],
				type = "toggle",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		},
	}
	return options
end