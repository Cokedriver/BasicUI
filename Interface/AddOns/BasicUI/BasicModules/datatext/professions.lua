local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['datatext'].enable ~= true then return end

if C['datatext'].pro and C['datatext'].pro > 0 then

	local Stat = CreateFrame('Button')
	Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)
	Stat.tooltip = false

	local Text = DataPanel:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].pro, Text)

	local function Update(self)
		for _, v in pairs({GetProfessions()}) do
			if v ~= nil then
				local name, texture, rank, maxRank = GetProfessionInfo(v)
				Text:SetFormattedText(hexa.."Profession's"..hexb)
			end
		end
		self:SetAllPoints(Text)
	end

	Stat:SetScript('OnEnter', function()
		local anchor, panel, xoff, yoff = B.DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(hexa..B.myname.."'s"..hexb.." Professions")
		GameTooltip:AddLine' '		
		for _, v in pairs({GetProfessions()}) do
			if v ~= nil then
				local name, texture, rank, maxRank = GetProfessionInfo(v)
				GameTooltip:AddDoubleLine(name, rank..' / '..maxRank,.75,.9,1,.3,1,.3)
			end
		end
		GameTooltip:AddLine' '
		GameTooltip:AddLine("|cffeda55fLeft Click|r to Open Profession #1")
		GameTooltip:AddLine("|cffeda55fMiddle Click|r to Open Spell Book")
		GameTooltip:AddLine("|cffeda55fRight Click|r to Open Profession #2")
		
		GameTooltip:Show()
	end)


	Stat:SetScript("OnClick",function(self,btn)
		local prof1, prof2 = GetProfessions()
		if btn == "LeftButton" then
			if prof1 then
				if (GetProfessionInfo(prof1) == 'Herbalism')then
						print('|cff00B4FFBasic|rUI: |cffFF0000Herbalism has no options!|r')
				elseif(GetProfessionInfo(prof1) == 'Skinning') then
						print('|cff00B4FFBasic|rUI: |cffFF0000Skinning has no options!|r')
				elseif(GetProfessionInfo(prof1) == 'Mining') then
						CastSpellByName("Smelting")							
				else	
					CastSpellByName((GetProfessionInfo(prof1)))
				end
			else
				print('|cff00B4FFBasic|rUI: |cffFF0000No Profession Found!|r')
			end
		elseif btn == 'MiddleButton' then
			ToggleFrame(SpellBookFrame)		
		elseif btn == "RightButton" then
			if prof2 then
				if (GetProfessionInfo(prof2) == 'Herbalism')then
						print('|cff00B4FFBasic|rUI: |cffFF0000Herbalism has no options!|r')
				elseif(GetProfessionInfo(prof2) == 'Skinning') then
						print('|cff00B4FFBasic|rUI: |cffFF0000Skinning has no options!|r')
				elseif(GetProfessionInfo(prof2) == 'Mining') then
						CastSpellByName("Smelting")						
				else	
					CastSpellByName((GetProfessionInfo(prof2)))
				end
			else
				print('|cff00B4FFBasic|rUI: |cffFF0000No Profession Found!|r')
			end
		end
	end)


	Stat:RegisterForClicks("AnyUp")
	Stat:SetScript('OnUpdate', Update)
	Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)
end