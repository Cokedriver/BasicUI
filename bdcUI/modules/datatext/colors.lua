local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

if C['datatext'].enable ~= true then return end

---------------------------------------------------
-- Color system for DataText Created by Hydra 
---------------------------------------------------

local ccolor = RAID_CLASS_COLORS[B.myclass]
hexa = "|cff"..C['datatext'].color
hexb = "|r"

if C['datatext'].classcolor then
	hexa = string.format("|c%02x%02x%02x%02x", 255, ccolor.r * 255, ccolor.g * 255, ccolor.b * 255)
end