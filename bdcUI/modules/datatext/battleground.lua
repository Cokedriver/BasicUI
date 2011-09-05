local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

if C['datatext'].enable ~= true then return end

if C['datatext'].battleground == true then 

	--Map IDs
	local WSG = 443
	local TP = 626
	local AV = 401
	local SOTA = 512
	local IOC = 540
	local EOTS = 482
	local TBFG = 736
	local AB = 461

	local bgframe = BattleGroundPanel
	bgframe:SetScript('OnEnter', function(self)
		local numScores = GetNumBattlefieldScores()
		for i=1, numScores do
			local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
			if ( name ) then
				if ( name == UnitName('player') ) then
					GameTooltip:SetOwner(self, 'ANCHOR_TOPLEFT', 0, 4)
					GameTooltip:ClearLines()
					GameTooltip:SetPoint('BOTTOM', self, 'TOP', 0, 1)
					GameTooltip:ClearLines()
					GameTooltip:AddLine(C_ttstatsfor..hexa..name..hexb)
					GameTooltip:AddLine' '
					GameTooltip:AddDoubleLine(L.datatext_ttkillingblows, killingBlows,1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_tthonorkills, honorableKills,1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_ttdeaths, deaths,1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_tthonorgain, format('%d', honorGained),1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_ttdmgdone, damageDone,1,1,1)
					GameTooltip:AddDoubleLine(L.datatext_tthealdone, healingDone,1,1,1)
					--Add extra statistics to watch based on what BG you are in.
					if curmapid == WSG or curmapid == TP then 
						GameTooltip:AddDoubleLine(L.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(L.datatext_flagsreturned,GetBattlefieldStatData(i, 2),1,1,1)
					elseif curmapid == EOTS then
						GameTooltip:AddDoubleLine(L.datatext_flagscaptured,GetBattlefieldStatData(i, 1),1,1,1)
					elseif curmapid == AV then
						GameTooltip:AddDoubleLine(L.datatext_graveyardsassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(L.datatext_graveyardsdefended,GetBattlefieldStatData(i, 2),1,1,1)
						GameTooltip:AddDoubleLine(L.datatext_towersassaulted,GetBattlefieldStatData(i, 3),1,1,1)
						GameTooltip:AddDoubleLine(L.datatext_towersdefended,GetBattlefieldStatData(i, 4),1,1,1)
					elseif curmapid == SOTA then
						GameTooltip:AddDoubleLine(L.datatext_demolishersdestroyed,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(L.datatext_gatesdestroyed,GetBattlefieldStatData(i, 2),1,1,1)
					elseif curmapid == IOC or curmapid == TBFG or curmapid == AB then
						GameTooltip:AddDoubleLine(L.datatext_basesassaulted,GetBattlefieldStatData(i, 1),1,1,1)
						GameTooltip:AddDoubleLine(L.datatext_basesdefended,GetBattlefieldStatData(i, 2),1,1,1)
					end					
					GameTooltip:Show()
				end
			end
		end
	end) 
	bgframe:SetScript('OnLeave', function(self) GameTooltip:Hide() end)

	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)

	local Text1  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
	Text1:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	Text1:SetPoint('LEFT', BattleGroundPanel, 30, 0)
	Text1:SetHeight(DataPanel:GetHeight())

	local Text2  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
	Text2:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	Text2:SetPoint('CENTER', BattleGroundPanel, 0, 0)
	Text2:SetHeight(DataPanel:GetHeight())

	local Text3  = BattleGroundPanel:CreateFontString(nil, 'OVERLAY')
	Text3:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	Text3:SetPoint('RIGHT', BattleGroundPanel, -30, 0)
	Text3:SetHeight(DataPanel:GetHeight())

	local int = 2
	local function Update(self, t)
		int = int - t
		if int < 0 then
			local dmgtxt
			RequestBattlefieldScoreData()
			local numScores = GetNumBattlefieldScores()
			for i=1, numScores do
				local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, healingDone, bgRating, ratingChange = GetBattlefieldScore(i)
				if healingDone > damageDone then
					dmgtxt = (L.datatext_healing..hexa..healingDone..hexb)
				else
					dmgtxt = (L.datatext_damage..hexa..damageDone..hexb)
				end
				if ( name ) then
					if ( name == myname ) then
						Text2:SetText(L.datatext_honor..hexa..format('%d', honorGained)..hexb)
						Text1:SetText(dmgtxt)
						Text3:SetText(L.datatext_killingblows..hexa..killingBlows..hexb)
					end   
				end
			end 
			int  = 0
		end
	end

	--hide text when not in an bg
	local function OnEvent(self, event)
		if event == 'PLAYER_ENTERING_WORLD' then
			local inInstance, instanceType = IsInInstance()
			if inInstance and (instanceType == 'pvp') then			
				bgframe:Show()
				PanelLeft:Hide()
			else
				Text1:SetText('')
				Text2:SetText('')
				Text3:SetText('')
				bgframe:Hide()
				PanelLeft:Show()
			end
		end
	end

	Stat:RegisterEvent('PLAYER_ENTERING_WORLD')
	Stat:SetScript('OnEvent', OnEvent)
	Stat:SetScript('OnUpdate', Update)
	Update(Stat, 10)
end