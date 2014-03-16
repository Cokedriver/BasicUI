local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config
local cfg = C["datatext"]
local cfgm = C["media"]

--[[

	All Credit for Coords.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if cfg.enable ~= true then return end

if cfg.coords and cfg.coords > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text = DataPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfgm.fontNormal, cfg.fontsize,'THINOUTLINE')
	B.PP(cfg.coords, Text)

	local function Update(self)
	local px,py=GetPlayerMapPosition("player")
		Text:SetText(format("%i , %i",px*100,py*100))
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end