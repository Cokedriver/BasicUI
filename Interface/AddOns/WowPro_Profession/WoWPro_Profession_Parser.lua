--------------------------------------
--      WoWPro_Profession_Parser      --
--------------------------------------
	
local L = WoWPro_Locale
WoWPro.Profession.actiontypes = {
	A = "Interface\\GossipFrame\\AvailableQuestIcon",
	C = "Interface\\Icons\\Ability_DualWield",
	T = "Interface\\GossipFrame\\ActiveQuestIcon",
	K = "Interface\\Icons\\Ability_Creature_Cursed_02",
	R = "Interface\\Icons\\Ability_Tracking",
	H = "Interface\\Icons\\INV_Misc_Rune_01",
	h = "Interface\\AddOns\\WoWPro\\Textures\\resting.tga",
	F = "Interface\\Icons\\Ability_Druid_FlightForm",
	N = "Interface\\Icons\\INV_Misc_Note_01",
	B = "Interface\\Icons\\INV_Misc_Coin_01",
	b = "Interface\\Icons\\Spell_Frost_SummonWaterElemental",
	U = "Interface\\Icons\\INV_Misc_Bag_08",
	l = "Interface\\Icons\\INV_Misc_Bag_08",
	r = "Interface\\Icons\\Ability_Repair"
}
WoWPro.Profession.actionlabels = {
	A = "Accept",
	C = "Complete",
	T = "Turn in",
	K = "Kill",
	R = "Run to",
	H = "Hearth to",
	h = "Set hearth to",
	F = "Fly to",
	N = "Note:",
	B = "Buy",
	b = "Boat or Zeppelin",
	U = "Use",
	l = "Loot",
	r = "Repair/Restock"
}

-- Determine Next Active Step (Profession Module Specific)--
-- This function is called by the main NextStep function in the core broker --
function WoWPro.Profession:NextStep(k, skip)
	local GID = WoWProDB.char.currentguide

	-- Optional Quests --
	if WoWPro.optional[k] and WoWPro.QID[k] then 
		
		-- Checking Quest Log --
		if WoWPro.QuestLog[WoWPro.QID[k]] then 
			skip = false -- If the optional quest is in the quest log, it's NOT skipped --
		end
	end

	-- Skipping profession quests (moved here from core)  --
	if WoWPro.prof[k] then 
		local prof, proflvl, profmaxlvl, profmaxskill = string.split(";",WoWPro.prof[k])
		proflvl = tonumber(proflvl) or 1
		profmaxlvl = tonumber(profmaxlvl) or 700
		profmaxskill = tonumber(profmaxskill) or 700
		local profs, found = {}, false
		skip = false
		profs[1], profs[2], profs[3], profs[4], profs[5], profs[6] = GetProfessions()
		for p=1,6 do
			if profs[p] then
				local skillName, _, skillRank, maxskill = GetProfessionInfo(profs[p])
				if (skillName == prof) then 
					found = true
					if (skillRank >= proflvl) and (skillRank < profmaxlvl) and (maxskill < profmaxskill) then
						skip = false else skip = true end
					if skip and proflvl > skillRank then skip = false end
					if skip then WoWProCharDB.Guide[GID].skipped[k] = true end
				end
			end
		end
		if found == false and proflvl == 0 then skip = false 
		else if found == false and profmaxlvl == 700 then skip = true end end
	end
	return skip
end

-- Skip a step --
function WoWPro.Profession:SkipStep(index)
	local GID = WoWProDB.char.currentguide
	
	if not WoWPro.QID[index] then return "" end
	if WoWPro.action[index] == "A" 
	or WoWPro.action[index] == "C" 
	or WoWPro.action[index] == "T" then
		WoWProCharDB.skippedQIDs[WoWPro.QID[index]] = true
		WoWProCharDB.Guide[GID].skipped[index] = true
	else 
		WoWProCharDB.Guide[GID].skipped[index] = true
	end
	local steplist = ""
	
	
	skipstep(index)
	
	WoWPro:MapPoint()
	return steplist
end

-- Unskip a step --
function WoWPro.Profession:UnSkipStep(index)
	local GID = WoWProDB.char.currentguide
	WoWProCharDB.Guide[GID].completion[index] = nil
	if WoWPro.QID[index] 
	and ( WoWPro.action[index] == "A" 
		or WoWPro.action[index] == "C" 
		or WoWPro.action[index] == "T" ) then
			WoWProCharDB.skippedQIDs[WoWPro.QID[index]] = nil
			WoWProCharDB.Guide[GID].skipped[index] = nil
	else
		WoWProCharDB.Guide[GID].skipped[index] = nil
	end
	
	local function unskipstep(currentstep)
		for j = 1,WoWPro.stepcount do if WoWPro.prereq[j] then
			local numprereqs = select("#", string.split(";", WoWPro.prereq[j]))
			for k=1,numprereqs do
				local kprereq = select(numprereqs-k+1, string.split(";", WoWPro.prereq[j]))
				if tonumber(kprereq) == WoWPro.QID[currentstep] then
					if WoWPro.action[j] == "A" 
					or WoWPro.action[j] == "C" 
					or WoWPro.action[j] == "T" then
						WoWProCharDB.skippedQIDs[WoWPro.QID[j]] = nil
					end
					WoWProCharDB.Guide[GID].skipped = {}
					unskipstep(j)
				end
			end
		end end
	end
	
	unskipstep(index)
	WoWPro:UpdateGuide()
	WoWPro:MapPoint()
end

-- Quest parsing function --
local function ParseQuests(...)
	WoWPro:dbp("Parsing Guide...")
	local i = 1
	local myclassL, myclass = UnitClass("player")
	local myraceL, myrace = UnitRace("player")
	if myrace == "Scourge" then
		myrace = "Undead"
	end
	for j=1,select("#", ...) do
		local text = select(j, ...)
		text = text:trim()
		if text ~= "" and text:sub(1,1) ~= ";" then
			local class, race, gender, faction = text:match("|C|([^|]*)|?"), text:match("|R|([^|]*)|?"), text:match("|GEN|([^|]*)|?"), text:match("|FACTION|([^|]*)|?")
			if class then
				-- deleting whitespaces and capitalizing, to compare with Blizzard's class tokens
				class = strupper(string.gsub(class, " ", ""))
			end
			if race then
				-- deleting whitespaces to compare with Blizzard's race tokens
				race = string.gsub(race, " ", "")
			end
			if gender then
				-- deleting leading/trailing whitespace and then canonicalize the case
				gender=strupper(strtrim(gender))
				-- map the text to the gender code
				if gender == "FEMALE" then
					gender = 3
				elseif gender == "MALE" then
					gender = 2
				else
					gender = 1
				end
			end
			if faction then
				-- deleting leading/trailing whitespace and then canonicalize the case
				faction=strupper(strtrim(faction))
            end			    
			if class == nil or class:find(myclass) then if race == nil or race:find(myrace) then if gender == nil or gender == UnitSex("player") then if faction == nil or faction == strupper(UnitFactionGroup("player")) then
				_, _, WoWPro.action[i], WoWPro.step[i] = text:find("^(%a) ([^|]*)(.*)")
				WoWPro.step[i] = WoWPro.step[i]:trim()
				WoWPro.stepcount = WoWPro.stepcount + 1
				WoWPro.QID[i] = tonumber(text:match("|QID|([^|]*)|?"))
				WoWPro.note[i] = text:match("|N|([^|]*)|?")
				WoWPro.map[i] = text:match("|M|([^|]*)|?")
				if text:find("|S|") then 
					WoWPro.sticky[i] = true; 
					WoWPro.stickycount = WoWPro.stickycount + 1 
				end
				if text:find("|US|") then WoWPro.unsticky[i] = true end
				WoWPro.use[i] = text:match("|U|([^|]*)|?")
				WoWPro.zone[i] = text:match("|Z|([^|]*)|?")
				if WoWPro.zone[i] and not WoWPro:ValidZone(WoWPro.zone[i]) then
					local line =string.format("Vers=%s|Guide=%s|Line=%s",WoWPro.Version,WoWProDB.char.currentguide,text)
                    WoWProDB.global.ZoneErrors = WoWProDB.global.ZoneErrors or {}
	                table.insert(WoWProDB.global.ZoneErrors, line)
				    WoWPro:dbp("Invalid Z tag in:"..text)
				    WoWPro.zone[i] = nil
				end
				_, _, WoWPro.lootitem[i], WoWPro.lootqty[i] = text:find("|L|(%d+)%s?(%d*)|")
				WoWPro.questtext[i] = text:match("|QO|([^|]*)|?")
				if text:find("|O|") then 
					WoWPro.optional[i] = true
					WoWPro.optionalcount = WoWPro.optionalcount + 1 
				end
--				WoWPro.prereq[i] = text:match("|PRE|([^|]*)|?")

				if (WoWPro.action[i] == "R" or WoWPro.action[i] == "r" or WoWPro.action[i] == "N") and WoWPro.map[i] then
					if text:find("|CC|") then WoWPro.waypcomplete[i] = 1
					elseif text:find("|CS|") then WoWPro.waypcomplete[i] = 2
					else WoWPro.waypcomplete[i] = false end
				end

				if text:find("|NC|") then WoWPro.noncombat[i] = true end
				WoWPro.level[i] = text:match("|LVL|([^|]*)|?")
--				WoWPro.leadin[i] = text:match("|LEAD|([^|]*)|?")
				WoWPro.target[i] = text:match("|T|([^|]*)|?")
                                WoWPro.rep[i] = text:match("|REP|([^|]*)|?")
				WoWPro.prof[i] = text:match("|P|([^|]*)|?") or WoWPro.Guides[WoWProDB.char.currentguide].name
				WoWPro.rank[i] = text:match("|RANK|([^|]*)|?")

				for _,tag in pairs(WoWPro.Tags) do 
					if not WoWPro[tag][i] then WoWPro[tag][i] = false end
				end
				
				i = i + 1
			end end end end
		end
	end
end
	
-- Guide Load --
function WoWPro.Profession:LoadGuide()
	local GID = WoWProDB.char.currentguide

	-- Parsing quests --
	local sequence = WoWPro.Guides[GID].sequence
	ParseQuests(string.split("\n", sequence()))
	
	WoWPro:dbp("Guide Parsed. "..WoWPro.stepcount.." steps registered.")
		
	WoWPro:PopulateQuestLog() --Calling this will populate our quest log table for use here
	
	-- Checking to see if any steps are already complete --
	for i=1, WoWPro.stepcount do
		local action = WoWPro.action[i]
		local completion = WoWProCharDB.Guide[GID].completion[i]
		local level = WoWPro.level[i]
		local numQIDs

		if WoWPro.QID[i] then
			numQIDs = select("#", string.split(";", WoWPro.QID[i]))
		else
			numQIDs = 0
		end

		for j=1,numQIDs do
			local QID 
			if WoWPro.QID[i] then
				QID = select(numQIDs-j+1, string.split(";", WoWPro.QID[i]))
				QID = tonumber(QID)
				WoWPro:dbp("Checking for completion: "..QID.." - "..WoWPro.step[i])
			else
				QID = nil
			end

		    -- Turned in quests --
		    if WoWProCharDB.completedQIDs then
			    if WoWProCharDB.completedQIDs[QID] then
				    WoWProCharDB.Guide[GID].completion[i] = true
			    end
		    end
	
		    -- Quest Accepts and Completions --
		    if not completion and WoWPro.QuestLog[QID] then 
			    if action == "A" then WoWProCharDB.Guide[GID].completion[i] = true end
			    if action == "C" and WoWPro.QuestLog[QID].complete then
				    WoWProCharDB.Guide[GID].completion[i] = true
			    end
		    end
		end
	end
	
	-- Checking zone based completion --
	WoWPro:UpdateGuide()
	WoWPro.Profession:AutoCompleteZone()
	
	-- Scrollbar Settings --
	WoWPro.Scrollbar:SetMinMaxValues(1, math.max(1, WoWPro.stepcount - WoWPro.ShownRows))
end

-- Row Content Update --
function WoWPro.Profession:RowUpdate(offset)
	local GID = WoWProDB.char.currentguide
	if InCombatLockdown() 
		or not GID 
		or not WoWPro.Guides[GID]
		then return 
	end
	WoWPro:dbp("Running: WoWPro.Profession:RowUpdate()")
	WoWPro.ActiveStickyCount = 0
	local reload = false
	local lootcheck = true
	local k = offset or WoWPro.ActiveStep
	local itemkb = false
	local targetkb = false
	ClearOverrideBindings(WoWPro.MainFrame)
	WoWPro.Profession.RowDropdownMenu = {}
	
	for i=1,15 do
		
		-- Skipping any skipped steps, unsticky steps, and optional steps unless it's time for them to display --
		if not WoWProDB.profile.guidescroll then
			k = WoWPro:NextStep(k, i)
		end
		
		--Loading Variables --
		local row = WoWPro.rows[i]
		row.index = k
		row.num = i
		local step = WoWPro.step[k]
		local action = WoWPro.action[k] 
		local note = WoWPro.note[k]
		local QID = WoWPro.QID[k] 
		local coord = WoWPro.map[k] 
		local sticky = WoWPro.sticky[k] 
		local unsticky = WoWPro.unsticky[k] 
		local use = WoWPro.use[k] 
		local zone = WoWPro.zone[k] 
		local lootitem = WoWPro.lootitem[k] 
		local lootqty = WoWPro.lootqty[k] 
		local questtext = WoWPro.questtext[k] 
		local optional = WoWPro.optional[k] 
		local target = WoWPro.target[k] 
		local completion = WoWProCharDB.Guide[GID].completion
		
		-- Unstickying stickies --
		if unsticky and i == WoWPro.ActiveStickyCount+1 then
			for n,row in ipairs(WoWPro.rows) do 
				if step == row.step:GetText() and WoWPro.sticky[row.index] and not completion[row.index] then 
					completion[row.index] = true
					return true --reloading
				end
			end
		end
		
		-- Counting stickies that are currently active (at the top) --
		if sticky and i == WoWPro.ActiveStickyCount+1 and not completion[k] then
			WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount+1
		end
		
		-- Getting the image and text for the step --
		row.step:SetText(step)
		if step then row.check:Show() else row.check:Hide() end
		if completion[k] or WoWProCharDB.Guide[GID].skipped[k] or WoWProCharDB.skippedQIDs[WoWPro.QID[k]] then
			row.check:SetChecked(true)
			if WoWProCharDB.Guide[GID].skipped[k] or WoWProCharDB.skippedQIDs[WoWPro.QID[k]] then
				row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
			else
				row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
			end
		else
			row.check:SetChecked(false)
			row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		end
		if note then note = strtrim(note) note = string.gsub(note,"\\n","\n") end
		if WoWProDB.profile.showcoords and coord and note then note = note.." ("..coord..")" end
		if WoWProDB.profile.showcoords and coord and not note then note = "("..coord..")" end
		if not ( WoWProDB.profile.showcoords and coord ) and not note then note = "" end
		row.note:SetText(note)
		row.action:SetTexture(WoWPro.Profession.actiontypes[action])
		if WoWPro.noncombat[k] and WoWPro.action[k] == "C" then
			row.action:SetTexture("Interface\\AddOns\\WoWPro\\Textures\\Config.tga")
		end
		
		-- Checkbox Function --
		function WoWPro.Profession:CheckFunction(row, button, down)
			row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
			if button == "LeftButton" and row.check:GetChecked() then
				local steplist = WoWPro.Profession:SkipStep(row.index)
				row.check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
				if steplist ~= "" then 
					WoWPro:SkipStepDialogCall(row.index, steplist)
				end
			elseif button == "RightButton" and row.check:GetChecked() then
				completion[row.index] = true
				WoWPro:MapPoint()
				if WoWProDB.profile.checksound then	
					PlaySoundFile(WoWProDB.profile.checksoundfile)
				end
			elseif not row.check:GetChecked() then
				WoWPro.Profession:UnSkipStep(row.index)
			end
			WoWPro:UpdateGuide()
		end
		row.check:SetScript("OnClick", function(self, button, down)
			WoWPro.Profession:CheckFunction(row, button, down)
		end)
		
		-- Right-Click Drop-Down --
		local dropdown = {
		}
		if step then
			table.insert(dropdown, 
				{text = step.." Options", isTitle = true}
			)
			QuestMapUpdateAllQuests()
			QuestPOIUpdateIcons()
			local _, x, y, obj
			if QID then _, x, y, obj = QuestPOIGetIconInfo(QID) end
			if coord or x then
				table.insert(dropdown, 
					{text = "Map Coordinates", func = function()
						WoWPro:MapPoint(row.num)
					end} 
				)
			end
			if WoWPro.QuestLog[QID] and WoWPro.QuestLog[QID].index and GetNumPartyMembers() > 0 then
				table.insert(dropdown, 
					{text = "Share Quest", func = function()
						QuestLogPushQuest(WoWPro.QuestLog[QID].index)
					end} 
				)
			end
			if sticky then
				table.insert(dropdown, 
					{text = "Un-Sticky", func = function() 
						WoWPro.sticky[row.index] = false
						WoWPro.UpdateGuide()
						WoWPro.UpdateGuide()
						WoWPro.MapPoint()
					end} 
				)
			else
				table.insert(dropdown, 
					{text = "Make Sticky", func = function() 
						WoWPro.sticky[row.index] = true
						WoWPro.unsticky[row.index] = false
						WoWPro.UpdateGuide()
						WoWPro.UpdateGuide()
						WoWPro.MapPoint()
					end} 
				)
			end
		end
		WoWPro.Profession.RowDropdownMenu[i] = dropdown
		
		-- Item Button --
		if action == "H" then use = 6948 end
		if ( not use ) and action == "C" and WoWPro.QuestLog[QID] then
			local link, icon, charges = GetQuestLogSpecialItemInfo(WoWPro.QuestLog[QID].index)
			if link then
				local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(link, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
				use = Id
				WoWPro.use[k] = use
			end
		end
		
		if use and GetItemInfo(use) then
			row.itembutton:Show() 
			row.itemicon:SetTexture(GetItemIcon(use))
			row.itembutton:SetAttribute("type1", "item")
			row.itembutton:SetAttribute("item1", "item:"..use)
			row.cooldown:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
			row.cooldown:SetScript("OnEvent", function() 
					local start, duration, enabled = GetItemCooldown(use)
					if enabled then
						row.cooldown:Show()
						row.cooldown:SetCooldown(start, duration)
					else row.cooldown:Hide() end
				end)
			local start, duration, enabled = GetItemCooldown(use)
			if enabled then
				row.cooldown:Show()
				row.cooldown:SetCooldown(start, duration)
			else row.cooldown:Hide() end
			if not itemkb and row.itembutton:IsVisible() then
				local key1, key2 = GetBindingKey("CLICK WoWPro_FauxItemButton:LeftButton")
				if key1 then
					SetOverrideBinding(WoWPro.MainFrame, false, key1, "CLICK WoWPro_itembutton"..i..":LeftButton")
				end
				if key2 then
					SetOverrideBinding(WoWPro.MainFrame, false, key2, "CLICK WoWPro_itembutton"..i..":LeftButton")
				end
				itemkb = true
			end
		else row.itembutton:Hide() end
		
		-- Target Button --
		if target then
			local target, spell, amt = string.split(";",target)
			spell = tonumber(spell) or 0
			amt = tonumber(amt) or 1

			row.targetbutton:Show() 
			if spell == 1 then
				local prof, proflvl, profmaxlvl, profmaxskill = string.split(";",WoWPro.prof[k])
				row.targetbutton:SetAttribute("macrotext", "/run CloseTradeSkill()\n/Cast "..prof.."\n/run for i=1,GetNumTradeSkills() do local na,_,n,_,_,p=GetTradeSkillInfo(i)if na=='"..target.."' then DoTradeSkill(i,'"..amt.."') end end ")
			else
				row.targetbutton:SetAttribute("macrotext", "/cleartarget\n/targetexact "..target
				.."\n/run if not GetRaidTargetIndex('target') == 8 and not UnitIsDead('target') then SetRaidTarget('target', 8) end")
			end
			if use then
				row.targetbutton:SetPoint("TOPRIGHT", row.itembutton, "TOPLEFT", -5, 0)
			else
				row.targetbutton:SetPoint("TOPRIGHT", row, "TOPLEFT", -10, -7)
			end 
			if not targetkb and row.targetbutton:IsVisible() then
				local key1, key2 = GetBindingKey("CLICK WoWPro_FauxTargetButton:LeftButton")
				if key1 then
					SetOverrideBinding(WoWPro.MainFrame, false, key1, "CLICK WoWPro_targetbutton"..i..":LeftButton")
				end
				if key2 then
					SetOverrideBinding(WoWPro.MainFrame, false, key2, "CLICK WoWPro_targetbutton"..i..":LeftButton")
				end
				targetkb = true
			end
		else
			row.targetbutton:Hide() 
		end

		
		-- Setting the zone for the coordinates of the step --
		zone = zone or strsplit("-(",WoWPro.Guides[GID].zone)
		row.zone = strtrim(zone)

		-- Checking for loot items in bags --
		local lootqtyi
		if lootcheck and ( lootitem or action == "B" ) then
			if not WoWPro.sticky[index] then lootcheck = false end
			if not lootitem then
				if GetItemCount(step) > 0 and not completion[k] then WoWPro.CompleteStep(k) end
			end
			if tonumber(lootqty) ~= nil then lootqtyi = tonumber(lootqty) else lootqtyi = 1 end
			if GetItemCount(lootitem) >= lootqtyi and not completion[k] then WoWPro.CompleteStep(k) end
		end

		WoWPro.rows[i] = row
		k = k + 1
	end
	
	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	WoWPro.CurrentIndex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	WoWPro.Profession:UpdateQuestTracker()

	return reload
end

-- Left-Click Row Function --
function WoWPro.Profession:RowLeftClick(i)
	if WoWPro.QID[WoWPro.rows[i].index] and WoWPro.QuestLog[WoWPro.QID[WoWPro.rows[i].index]] then
		QuestLog_OpenToQuest(WoWPro.QuestLog[WoWPro.QID[WoWPro.rows[i].index]].index)
	end
	WoWPro.rows[i]:SetChecked(nil)
end

-- Event Response Logic --
function WoWPro.Profession:EventHandler(self, event, ...)
	WoWPro:dbp("Running: Profession Event Handler")
		
	-- Noticing if we have entered a Dungeon!
	if event == "ZONE_CHANGED_NEW_AREA" and WoWProCharDB.AutoHideProfessionInsideInstances == true then
		if IsInInstance() then
			WoWPro:Print("|cff33ff33Instance Auto Hide|r: Profession Module")
			WoWPro.MainFrame:Hide()
			WoWPro.Titlebar:Hide()
			WoWPro.Hidden = true
			return
		elseif WoWPro.Hidden == true then
			WoWPro:Print("|cff33ff33Instance Exit Auto Show|r: Profession Module")
			WoWPro.MainFrame:Show()
			WoWPro.Titlebar:Show()
			WoWPro.Hidden = nil
		end
	end	

	-- Noting that a quest is being completed for quest log update events --
	if event == "QUEST_COMPLETE" then
		WoWPro.Profession.CompletingQuest = true
		WoWPro.Profession:AutoCompleteQuestUpdate(GetQuestID())
	end
	
	-- Auto-Completion --
	if event == "CHAT_MSG_SYSTEM" then
		WoWPro.Profession:AutoCompleteSetHearth(...)
	end	
	if event == "CHAT_MSG_LOOT" then
		WoWPro.Profession:AutoCompleteLoot(...)
	end
	if event == "ZONE_CHANGED" or event == "ZONE_CHANGED_INDOORS" or event == "MINIMAP_ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
		WoWPro.Profession:AutoCompleteZone(...)
	end
	if event == "QUEST_LOG_UPDATE" then
		WoWPro:PopulateQuestLog(...)
		WoWPro.Profession:AutoCompleteQuestUpdate(...)
		WoWPro.Profession:UpdateQuestTracker()
	end	
	if event == "UI_INFO_MESSAGE" then
		WoWPro.Profession:AutoCompleteGetFP(...)
	end
	if event == "PLAYER_LEVEL_UP" then
		WoWPro.Profession:AutoCompleteLevel(...)
		WoWPro.Profession.CheckAvailableSpells(...)
--		WoWPro.Profession.CheckAvailableTalents()
	end
	if event == "TRAINER_UPDATE" then
		WoWPro.UpdateGuide()
--		WoWPro.Profession.CheckAvailableSpells()
	end
	
	if event == "CHAT_MSG_SKILL" then
		WoWPro.UpdateGuide()
	end

end

-- Auto-Complete: Get flight point --
function WoWPro.Profession:AutoCompleteGetFP(...)
	for i = 1,15 do
		local index = WoWPro.rows[i].index
		if ... == ERR_NEWTAXIPATH and WoWPro.action[index] == "f" 
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
			WoWPro.CompleteStep(index)
		end
	end
end

-- Auto-Complete: Quest Update --
function WoWPro.Profession:AutoCompleteQuestUpdate(questComplete)
	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end

	if WoWProCharDB.Guide then
		for i=1,#WoWPro.action do
		
			local action = WoWPro.action[i]
			local completion = WoWProCharDB.Guide[GID].completion[i]
		
			if WoWPro.QID[i] then
				local numQIDs = select("#", string.split(";", WoWPro.QID[i]))
				for j=1,numQIDs do
					local QID = select(numQIDs-j+1, string.split(";", WoWPro.QID[i]))
					QID = tonumber(QID)

			        -- Quest Turn-Ins --
			        if WoWPro.Profession.CompletingQuest and action == "T" and not completion and WoWPro.missingQuest == QID then
				        WoWPro.CompleteStep(i)
				        WoWProCharDB.completedQIDs[QID] = true
				        WoWPro.Profession.CompletingQuest = false
			        end
			
			        -- Abandoned Quests --
			        if not WoWPro.Profession.CompletingQuest and ( action == "A" or action == "C" ) 
			        and completion and WoWPro.missingQuest == QID then
				        WoWProCharDB.Guide[GID].completion[i] = nil
				        WoWPro:UpdateGuide()
				        WoWPro:MapPoint()
			        end
			
                    -- Quest AutoComplete --
                    if questComplete and (action == "A" or action == "C" or action == "T" or action == "N") and QID == questComplete then
                        WoWPro.CompleteStep(i)
                    end
			        -- Quest Accepts --
			        if WoWPro.newQuest == QID and action == "A" and not completion then
				        WoWPro.CompleteStep(i)
			        end
			
			        -- Quest Completion --
			        if WoWPro.QuestLog[QID] and action == "C" and not completion and WoWPro.QuestLog[QID].complete then
				        WoWPro.CompleteStep(i)
			        end
			
			        -- Partial Completion --
			        if WoWPro.QuestLog[QID] and WoWPro.QuestLog[QID].leaderBoard and WoWPro.questtext[i] 
			        and not WoWProCharDB.Guide[GID].completion[i] then 
				        local numquesttext = select("#", string.split(";", WoWPro.questtext[i]))
				        local complete = true
				        for l=1,numquesttext do
					        local lquesttext = select(numquesttext-l+1, string.split(";", WoWPro.questtext[i]))
					        local lcomplete = false
					        for _, objective in pairs(WoWPro.QuestLog[QID].leaderBoard) do --Checks each of the quest log objectives
						        if lquesttext == objective then --if the objective matches the step's criteria, mark true
							        lcomplete = true
						        end
					        end
					        if not lcomplete then complete = false end --if one of the listed objectives isn't complete, then the step is not complete.
				        end
				        if complete then WoWPro.CompleteStep(i) end --if the step has not been found to be incomplete, run the completion function
			        end
			    end
			end		
		end
	
	end
	
	-- First Map Point --
	if WoWPro.Profession.FirstMapCall then
		WoWPro:MapPoint()
		WoWPro.Profession.FirstMapCall = false
	end
	
end

-- Update Item Tracking --
local function GetLootTrackingInfo(lootitem,lootqty,count)
--[[Purpose: Creates a string containing:
	- tracked item's name
	- how many the user has
	- how many the user needs
	- a complete symbol if the ammount the user has is equal to the ammount they need 
]]
	if not GetItemInfo(lootitem) then return "" end
	local track = "" 												--If the function did have a track string, adds a newline
	track = track.." - "..GetItemInfo(lootitem)..": " 	--Adds the item's name to the string
	numinbag = GetItemCount(lootitem)+(count or 0)		--Finds the number in the bag, and adds a count if supplied
	track = track..numinbag										--Adds the number in bag to the string
	track = track.."/"..lootqty								--Adds the total number needed to the string
	if lootqty == numinbag then
		track = track.." (C)"									--If the user has the requisite number of items, adds a complete marker
	end
	return track													--Returns the track string to the calling function
end

-- Auto-Complete: Loot based --
function WoWPro.Profession:AutoCompleteLoot(msg)
	local lootqtyi
	local _, _, itemid, name = msg:find(L["^You .*Hitem:(%d+).*(%[.+%])"])
	local _, _, _, _, count = msg:find(L["^You .*Hitem:(%d+).*(%[.+%]).*x(%d+)."])
	if count == nil then count = 1 end
	for i = 1,1+WoWPro.ActiveStickyCount do
		local index = WoWPro.rows[i].index
		if tonumber(WoWPro.lootqty[index]) ~= nil then lootqtyi = tonumber(WoWPro.lootqty[index]) else lootqtyi = 1 end
		if WoWProDB.profile.track and WoWPro.lootitem[index] then
			local track = GetLootTrackingInfo(WoWPro.lootitem[index],lootqtyi,count)
			WoWPro.rows[i].track:SetText(strtrim(track))
		end
		if WoWPro.lootitem[index] and WoWPro.lootitem[index] == itemid and GetItemCount(WoWPro.lootitem[index]) + count >= lootqtyi 
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
			WoWPro.CompleteStep(index)
		end
	end
	for i = 1,15 do
	end
end
			
-- Auto-Complete: Set hearth --
function WoWPro.Profession:AutoCompleteSetHearth(...)
	local msg = ...
	local _, _, loc = msg:find(L["(.*) is now your home."])
	if loc then
		WoWProCharDB.Guide.hearth = loc
		for i = 1,15 do
			local index = WoWPro.rows[i].index
			if WoWPro.action[index] == "h" and WoWPro.step[index] == loc 
			and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[index] then
				WoWPro.CompleteStep(index)
			end
		end
	end	
end

-- Auto-Complete: Zone based --
function WoWPro.Profession:AutoCompleteZone()
	WoWPro.ActiveStickyCount = WoWPro.ActiveStickyCount or 0
	local currentindex = WoWPro.rows[1+WoWPro.ActiveStickyCount].index
	local action = WoWPro.action[currentindex]
	local step = WoWPro.step[currentindex]
	local coord = WoWPro.map[currentindex]
	local waypcomplete = WoWPro.waypcomplete[currentindex]
	local zonetext, subzonetext = GetZoneText(), string.trim(GetSubZoneText())
	if action == "F" or action == "H" or action == "b" or (action == "R" and not waypcomplete) then
		if step == zonetext or step == subzonetext 
		and not WoWProCharDB.Guide[WoWProDB.char.currentguide].completion[currentindex] then
			WoWPro.CompleteStep(currentindex)
		end
	end
end

-- Update Quest Tracker --
function WoWPro.Profession:UpdateQuestTracker()
	if not WoWPro.GuideFrame:IsVisible() then return end
	local GID = WoWProDB.char.currentguide
	if not GID or not WoWPro.Guides[GID] then return end
	
	for i,row in ipairs(WoWPro.rows) do
		local index = row.index
		local questtext = WoWPro.questtext[index] 
		local action = WoWPro.action[index] 
		local lootitem = WoWPro.lootitem[index] 
		local lootqty = WoWPro.lootqty[index] 
					if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
		local QID = WoWPro.QID[index]
		-- Setting up quest tracker --
		row.trackcheck = false
		local track = ""
		if WoWProDB.profile.track and ( action == "C" or questtext or lootitem) then
			if WoWPro.QuestLog[QID] and WoWPro.QuestLog[QID].leaderBoard then
				local j = WoWPro.QuestLog[QID].index
				row.trackcheck = true
				if not questtext and action == "C" then
					if WoWPro.QuestLog[QID].leaderBoard[1] then
						track = "- "..WoWPro.QuestLog[QID].leaderBoard[1]
						if select(3,GetQuestLogLeaderBoard(1, j)) then
							track =  track.." (C)"
						end
					end
					for l=1,#WoWPro.QuestLog[QID].leaderBoard do 
						if l > 1 then
							if WoWPro.QuestLog[QID].leaderBoard[l] then
								track = track.."\n- "..WoWPro.QuestLog[QID].leaderBoard[l]
								if select(3,GetQuestLogLeaderBoard(l, j)) then
									track =  track.." (C)"
								end
							end
						end
					end
				elseif questtext then --Partial completion steps only track pertinent objective.
					local numquesttext = select("#", string.split(";", questtext))
					for l=1,numquesttext do
						local lquesttext = select(numquesttext-l+1, string.split(";", questtext))
						for m=1,GetNumQuestLeaderBoards(j) do 
							if GetQuestLogLeaderBoard(m, j) then
								local _, _, itemName, _, _ = string.find(GetQuestLogLeaderBoard(m, j), "(.*):%s*([%d]+)%s*/%s*([%d]+)");
								if itemName and string.find(lquesttext,itemName) then
									track = "- "..GetQuestLogLeaderBoard(m, j)
									if select(3,GetQuestLogLeaderBoard(m, j)) then
										track =  track.." (C)"
									end
								end
							end
						end
					end
				end
			end
			if lootitem then
				row.trackcheck = true
				if tonumber(lootqty) ~= nil then lootqty = tonumber(lootqty) else lootqty = 1 end
				track = GetLootTrackingInfo(lootitem,lootqty)
			end
		end
		row.track:SetText(track)
	end
	if not InCombatLockdown() then WoWPro:RowSizeSet(); WoWPro:PaddingSet() end
end
