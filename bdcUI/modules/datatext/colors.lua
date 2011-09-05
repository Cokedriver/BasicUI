local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

if C['datatext'].enable ~= true then return end

---------------------------------------------------
-- Color system for DataText Created by Hydra 
---------------------------------------------------
-- convert datatext B.ValColor from rgb decimal to hex
if C["datatext"].colors.classcolor ~= true then
	local r, g, b = unpack(C["datatext"].colors.color)
	hexa = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
	hexb = "|r"
else
	local color = RAID_CLASS_COLORS[B.myclass]
	hexa = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
	C["datatext"].colors.color = {color.r, color.g, color.b}
	hexb = "|r"
end
--[[
local ccolor = RAID_CLASS_COLORS[B.myclass]
hexa = "|cff"..{unpack(C['datatext'].colors.color)}
hexb = "|r"


if C['datatext'].classcolor then
	hexa = string.format("|c%02x%02x%02x%02x", 255, ccolor.r * 255, ccolor.g * 255, ccolor.b * 255)	
end]]

