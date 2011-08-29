local B, C, L, DB = unpack(select(2, ...)) -- Import:  F - function; C - config; L - locales; DB - Database

if C['datatext'].enable ~= true then return end

if C['datatext'].pro and C['datatext'].pro > 0 then

	local Stat = CreateFrame('Frame')
	Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)
	Stat.tooltip = false

	local Text  = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].pro, Text)

	local function Update(self)
		for _, v in pairs({GetProfessions()}) do
			if v ~= nil then
				local name, texture, rank, maxRank = GetProfessionInfo(v)
				Text:SetFormattedText(hexa..'Profession'..hexb)
			end
		end
		self:SetAllPoints(Text)
	end

	Stat:SetScript('OnEnter', function()
		local anchor, panel, xoff, yoff = B.DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(hexa..B.myname.."'s"..hexb..' Professions', .4,.78,1)
		for _, v in pairs({GetProfessions()}) do
			if v ~= nil then
				local name, texture, rank, maxRank = GetProfessionInfo(v)
				GameTooltip:AddDoubleLine(name, rank..' / '..maxRank,.75,.9,1,.3,1,.3)
			end
		end
		GameTooltip:Show()
	end)


	Stat:SetScript('OnMouseDown', function(self, btn)

		if btn == 'LeftButton' then
			ToggleFrame(SpellBookFrame)
		end

	end)


	Stat:SetScript('OnUpdate', Update)
	Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)
end