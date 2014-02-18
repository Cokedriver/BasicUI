local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for Spec.lua goes to Elv.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if C['datatext'].enable ~= true then return end

if C['datatext'].spec and C['datatext'].spec > 0 then

	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(C['media'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].spec, Text)

	local talent = {}
	local active
	local talentString = string.join('', '|cffFFFFFF%s|r ')
	local talentStringTip = string.join('', '|cffFFFFFF%s:|r ')
	local activeString = string.join('', '|cff00FF00' , ACTIVE_PETS, '|r')
	local inactiveString = string.join('', '|cffFF0000', FACTION_INACTIVE, '|r')


	local int = 1
	local function Update(self, t)
		int = int - t
		if int > 0 or not GetSpecialization () then return end

		active = GetActiveSpecGroup(false, false)
		Text:SetFormattedText(talentString, hexa..select(2, GetSpecializationInfo (GetSpecialization (false, false, active)))..hexb)
		int = 1

		-- disable script	
		self:SetScript('OnUpdate', nil)
	end


	Stat:SetScript('OnEnter', function(self)
		if InCombatLockdown() then return end

		local anchor, panel, xoff, yoff = B.DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)

		GameTooltip:ClearLines()
		GameTooltip:AddLine(hexa..B.myname.."'s"..hexb.." Spec")
		GameTooltip:AddLine' '		
		for i = 1, GetNumSpecGroups () do
			if GetSpecialization (false, false, i) then
				GameTooltip:AddLine(string.join(' ', string.format(talentStringTip, select(2, GetSpecializationInfo (GetSpecialization (false, false, i)))), (i == active and activeString or inactiveString)),1,1,1)
			end
		end
		
		GameTooltip:AddLine' '
		GameTooltip:AddLine("|cffeda55fLeft Click|r to Switch Spec's")		
		GameTooltip:AddLine("|cffeda55fRight Click|r to Open Talent Tree")
		GameTooltip:Show()
	end)

	Stat:SetScript('OnLeave', function() GameTooltip:Hide() end)

	local function OnEvent(self, event, ...)
		if event == 'PLAYER_ENTERING_WORLD' then
			self:UnregisterEvent('PLAYER_ENTERING_WORLD')
		end
		

		-- Setup Talents Tooltip
		self:SetAllPoints(Text)

		-- update datatext
		if event ~= 'PLAYER_ENTERING_WORLD' then
			self:SetScript('OnUpdate', Update)
		end
	end



	Stat:RegisterEvent('PLAYER_ENTERING_WORLD');
	Stat:RegisterEvent('CHARACTER_POINTS_CHANGED');
	Stat:RegisterEvent('PLAYER_TALENT_UPDATE');
	Stat:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
	Stat:RegisterEvent("EQUIPMENT_SETS_CHANGED")
	Stat:SetScript('OnEvent', OnEvent)
	Stat:SetScript('OnUpdate', Update)

	Stat:SetScript("OnMouseDown", function(self, button)
		if button == "LeftButton" then
			SetActiveSpecGroup (active == 1 and 2 or 1)
		elseif button == "RightButton" then
			ToggleTalentFrame()
		end
	end)
end