local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config
local cfg = C["datatext"]
local cfgm = C["media"]
local gen = C["general"]
--[[

	All Credit for Colors.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if cfg.enable ~= true then return end

---------------------------------------------------
-- Color system for DataText Created by Hydra 
---------------------------------------------------
if gen.classcolor ~= true then
	local r, g, b = gen.color.r, gen.color.g, gen.color.b
	hexa = ("|cff%.2x%.2x%.2x"):format(r * 255, g * 255, b * 255)
	hexb = "|r"
else
	hexa = ("|cff%.2x%.2x%.2x"):format(B.ccolor.r * 255, B.ccolor.g * 255, B.ccolor.b * 255)
	hexb = "|r"
end


