local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for Coords.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if C['datatext'].enable ~= true then return end

if C['datatext'].coords and C['datatext'].coords > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text = DataPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C['media'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].coords, Text)

	local function Update(self)
	local px,py=GetPlayerMapPosition("player")
		Text:SetText(format("%i , %i",px*100,py*100))
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end