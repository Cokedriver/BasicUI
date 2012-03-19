local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for Zone.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if C['datatext'].enable ~= true then return end

if C['datatext'].zone and C['datatext'].zone > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text = DataPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].zone, Text)

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