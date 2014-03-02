local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

local L = setmetatable({}, { __index = function(t,k)
    local v = tostring(k)
    rawset(t, k, v)
    return v
end })

--Constants
local m = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")));

B.scale = function(v) return m * floor(v/m+.5) end;
B.dummy = function() return end
B.toc = select(4, GetBuildInfo())
B.myname, _ = UnitName("player")
B.myrealm = GetRealmName()
_, B.myclass = UnitClass("player")
B.version = GetAddOnMetadata("BasicUI", "Version")
B.patch = GetBuildInfo()
B.level = UnitLevel("player")
B.locale = GetLocale()
B.resolution = GetCurrentResolution()
B.getscreenresolution = select(B.resolution, GetScreenResolutions())
B.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
B.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))
B.ccolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
B.regions ={['TOPLEFT'] = L['TOPLEFT'], ['TOP'] = L['TOP'], ['TOPRIGHT'] = L['TOPRIGHT'], ['LEFT'] = L['LEFT'], ['CENTER'] = L['CENTER'], ['RIGHT'] = L['RIGHT'], ['BOTTOMLEFT'] = L['BOTTOMLEFT'], ['BOTTOM'] = L['BOTTOM'], ['BOTTOMRIGHT'] = L['BOTTOMRIGHT']}
B.border = {['Blizzard'] = L['Blizzard'], ['BasicUI'] = L['BasicUI']}
B.textstring = {['XX'] = L['XX'], ['XX/XX'] = L['XX/XX'], ['XX (%)'] = L['XX (%)'], ['XX/XX (%)'] = L['XX/XX (%)']}


-- MoP ClassRole's
	-- PALADIN 		= [1] = "Caster", [2] = "Tank", [3] = "Melee"
	-- PRIEST 		= "Caster"
	-- WARLOCK 		= "Caster"
	-- WARRIOR 		= [1] = "Melee", [2] = "Melee", [3] = "Tank"	
	-- HUNTER 		= "Melee"
	-- SHAMAN 		= [1] = "Caster", [2] = "Melee", [3] = "Caster"	
	-- ROGUE 		= "Melee"
	-- MAGE 		= "Caster"
	-- DEATHKNIGHT 	= [1] = "Tank", [2] = "Melee", [3] = "Melee"	
	-- DRUID 		= [1] = "Caster", [2] = "Melee", [3] = "Tank", [4] = "Caster"
	-- MONK 		= [1] = "Tank", [2] = "Caster", [3] = "Melee"	


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
local function CheckRole()
	local talentTree = GetSpecialization()

	if(type(classRoles[playerClass]) == "string") then
		B.Role = classRoles[playerClass]
	elseif(talentTree) then
		B.Role = classRoles[playerClass][talentTree]
	end
end

local eventHandler = CreateFrame("Frame")
eventHandler:RegisterEvent("PLAYER_ENTERING_WORLD")
eventHandler:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
eventHandler:RegisterEvent("PLAYER_TALENT_UPDATE")
eventHandler:RegisterEvent("CHARACTER_POINTS_CHANGED")
eventHandler:SetScript("OnEvent", CheckRole)

B.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, 'OVERLAY')
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH('LEFT')
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

--RGB to Hex
function B.RGBToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255)
end

--Hex to RGB
function B.HexToRGB(hex)
	local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
	return tonumber(rhex, 16), tonumber(ghex, 16), tonumber(bhex, 16)
end

-- Greeting
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_LOGIN")
EventFrame:SetScript("OnEvent", function(self,event,...) 
	hexa = ("|cff%.2x%.2x%.2x"):format(B.ccolor.r * 255, B.ccolor.g * 255, B.ccolor.b * 255)
	hexb = "|r"
	if type(BasicDBPerCharacter) ~= "number" then
		BasicDBPerCharacter = 1
		ChatFrame1:AddMessage('Welcome to Azeroth '..hexa..UnitName("Player")..hexb..". I do believe this is the first time we've met. Nice to meet you! You're using |cff00B4FFBasic|rUI v"..B.version..'.')
	else
		if BasicDBPerCharacter == 1 then
			ChatFrame1:AddMessage('Welcome to Azeroth '..hexa..UnitName("Player")..hexb..". How nice to see you again. You're using |cff00B4FFBasic|r".."|cffffffffUI|r".." v"..B.version..'.',255,255,0)
		else
			ChatFrame1:AddMessage('Welcome to Azeroth '..hexa..UnitName("Player")..hexb..". How nice to see you again. You're using |cff00B4FFBasic|r".."|cffffffffUI|r".." v"..B.version..'.',255,255,0)
		end
		BasicDBPerCharacter = BasicDBPerCharacter + 1
	end
end)

function B.ShortValue(v)
	if v >= 1e6 then
		return ("%.1fm"):format(v / 1e6):gsub("%.?0+([km])$", "%1")
	elseif v >= 1e3 or v <= -1e3 then
		return ("%.1fk"):format(v / 1e3):gsub("%.?0+([km])$", "%1")
	else
		return v
	end
end

INTERFACE_ACTION_BLOCKED = ''

SlashCmdList['RELOADUI'] = function()
    ReloadUI()
end
SLASH_RELOADUI1 = '/rl'

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


-- Error Message Ignore List
UIErrorsFrame:UnregisterEvent('UI_ERROR_MESSAGE')
UIErrorsFrame:SetTimeVisible(1)
UIErrorsFrame:SetFadeDuration(0.75)

local ignoreList = {
    [ERR_SPELL_COOLDOWN] = true,
    [ERR_ABILITY_COOLDOWN] = true,

    [OUT_OF_ENERGY] = true,

    [SPELL_FAILED_NO_COMBO_POINTS] = true,

    [SPELL_FAILED_MOVING] = true,
    [ERR_NO_ATTACK_TARGET] = true,
    [SPELL_FAILED_SPELL_IN_PROGRESS] = true,

    [ERR_NO_ATTACK_TARGET] = true,
    [ERR_INVALID_ATTACK_TARGET] = true,
    [SPELL_FAILED_BAD_TARGETS] = true,
}

local event = CreateFrame('Frame')
event:SetScript('OnEvent', function(self, event, error)
    if (not ignoreList[error]) then
        UIErrorsFrame:AddMessage(error, 1, .1, .1)
    end
end)

event:RegisterEvent('UI_ERROR_MESSAGE')