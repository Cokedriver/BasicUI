local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config
local cfg = C["datatext"]
local cfgm = C["media"]

--[[

	All Credit for Zone.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if cfg.enable ~= true then return end

if cfg.zone and cfg.zone > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text = DataPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(cfgm.fontNormal, cfg.fontsize,'THINOUTLINE')
	B.PP(cfg.zone, Text)

	local function Update(self)
		if GetMinimapZoneText() == "Putricide's Laboratory of Alchemical Horrors and Fun" then
			Text:SetText("Putricides's Laboratory")
		else
			Text:SetText(hexa..GetMinimapZoneText()..hexb)
		end
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end