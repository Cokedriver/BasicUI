local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

--Constants
B.toc = select(4, GetBuildInfo())
B.myname, _ = UnitName("player")
B.myrealm = GetRealmName()
_, B.myclass = UnitClass("player")
B.version = GetAddOnMetadata("bdcUI", "Version")
B.patch = GetBuildInfo()
B.level = UnitLevel("player")
B.resolution = GetCurrentResolution()
B.getscreenresolution = select(B.resolution, GetScreenResolutions())
B.getscreenheight = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)"))
B.getscreenwidth = tonumber(string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x+%d"))

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
	if ((B.myclass == "PALADIN" and tree == 2) or 
	(B.myclass == "WARRIOR" and tree == 3) or 
	(B.myclass == "DEATHKNIGHT" and tree == 1)) and
	resilience == false or
	(B.myclass == "DRUID" and tree == 2 and GetBonusBarOffset() == 3) then
		B.Role = "Tank"
	else
		local playerint = select(2, UnitStat("player", 4))
		local playeragi	= select(2, UnitStat("player", 2))
		local base, posBuff, negBuff = UnitAttackPower("player");
		local playerap = base + posBuff + negBuff;

		if (((playerap > playerint) or (playeragi > playerint)) and not (B.myclass == "SHAMAN" and tree ~= 1 and tree ~= 3) and not (UnitBuff("player", GetSpellInfo(24858)) or UnitBuff("player", GetSpellInfo(65139)))) or B.myclass == "ROGUE" or B.myclass == "HUNTER" or (B.myclass == "SHAMAN" and tree == 2) then
			B.Role = "Melee"
		else
			B.Role = "Caster"
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

B.SetFontString = function(parent, fontName, fontHeight, fontStyle)
	local fs = parent:CreateFontString(nil, 'OVERLAY')
	fs:SetFont(fontName, fontHeight, fontStyle)
	fs:SetJustifyH('LEFT')
	fs:SetShadowColor(0, 0, 0)
	fs:SetShadowOffset(1.25, -1.25)
	return fs
end

-- Greeting
local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_LOGIN")
EventFrame:SetScript("OnEvent", function(self,event,...) 
	if type(bdcUIPerCharacter) ~= "number" then
		bdcUIPerCharacter = 1
		ChatFrame1:AddMessage('Welcome to Azeroth '.. UnitName("Player")..". I do believe this is the first time we've met. Nice to meet you! Your using |cff00B4FFbdcUI v"..B.version..'|r.')
	else
		if bdcUIPerCharacter == 1 then
			ChatFrame1:AddMessage('Welcome to Azeroth '.. UnitName("Player")..". How nice to see you again. Your using |cff00B4FFbdcUI v"..B.version..'|r.')
		else
			ChatFrame1:AddMessage('Welcome to Azeroth '.. UnitName("Player")..". How nice to see you again. Your using |cff00B4FFbdcUI v"..B.version..'|r.')
		end
		bdcUIPerCharacter = bdcUIPerCharacter + 1
	end
end)

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




