local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for Colors.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if C['datatext'].enable ~= true then return end

---------------------------------------------------
-- Color system for DataText Created by Hydra 
---------------------------------------------------
if C["datatext"].colors.classcolor ~= true then
	local r, g, b = C["datatext"].colors.color.r, C["datatext"].colors.color.g, C["datatext"].colors.color.b
	hexa = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
	hexb = "|r"
else
	local color = RAID_CLASS_COLORS[B.myclass]
	hexa = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
	C["datatext"].colors.color = {color.r, color.g, color.b}
	hexb = "|r"
end


