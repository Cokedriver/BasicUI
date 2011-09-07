local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

if C['datatext'].enable ~= true then return end

---------------------------------------------------
-- Color system for DataText Created by Hydra 
---------------------------------------------------
-- convert datatext B.ValColor from rgb decimal to hex
if C["datatext"].colors.classcolor ~= true then
	local color = C["datatext"].colors.color
	hexa = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
	hexb = "|r"
else
	local cc = RAID_CLASS_COLORS[B.myclass]
	hexa = ("|cff%.2x%.2x%.2x"):format(cc.r * 255, cc.g * 255, cc.b * 255)
	--C["datatext"].colors.color = {color.r, color.g, color.b}
	hexb = "|r"
end


