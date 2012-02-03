
-------------------------------
--      WoWPro_WorldEvents      --
-------------------------------

WoWPro.WorldEvents = WoWPro:NewModule("WorldEvents")
local myUFG = UnitFactionGroup("player")
WoWPro:Embed(WoWPro.WorldEvents)

-- Called before all addons have loaded, but after saved variables have loaded. --
function WoWPro.WorldEvents:OnInitialize()
	if WoWProCharDB.AutoHideWorldEventsInsideInstances == nil then
	    WoWProCharDB.AutoHideWorldEventsInsideInstances = true
	end
end

-- Called when the module is enabled, and on log-in and /reload, after all addons have loaded. --
function WoWPro.WorldEvents:OnEnable()
	WoWPro:dbp("|cff33ff33Enabled|r: WorldEvents Module")
	
	-- WorldEvents Tag Setup --
	WoWPro:RegisterTags({"QID", "questtext", "rep", "noncombat", "ach", "prereq"})
	
	-- Event Registration --
	WoWPro.WorldEvents.Events = {"QUEST_LOG_UPDATE", "QUEST_COMPLETE", "CRITERIA_UPDATE",
		"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "MINIMAP_ZONE_CHANGED", "ZONE_CHANGED_NEW_AREA", 
		"UI_INFO_MESSAGE", "CHAT_MSG_SYSTEM", "CHAT_MSG_LOOT"
	}
	WoWPro:RegisterEvents(WoWPro.WorldEvents.Events)
	
	--Loading Frames--
	if not WoWPro.WorldEvents.FramesLoaded then --First time the addon has been enabled since UI Load
		WoWPro.WorldEvents:CreateConfig()
		WoWPro.WorldEvents.CreateGuideList()
		WoWPro.WorldEvents.FramesLoaded = true
	end
	
	WoWPro.WorldEvents.FirstMapCall = true
	
	-- Server query for completed quests --
	QueryQuestsCompleted()
end

-- Called when the module is disabled --
function WoWPro.WorldEvents:OnDisable()
	-- Unregistering WorldEvents Module Events --
	WoWPro:UnregisterEvents(WoWPro.WorldEvents.Events)
	
	--[[ If the current guide is a WorldEvents guide, removes the map point, stores the guide's ID to be resumed later, 
	sets the current guide to nil, and loads the nil guide. ]]
	if WoWPro.Guides[WoWProDB.char.currentguide] and WoWPro.Guides[WoWProDB.char.currentguide].guidetype == "WorldEvents" then
		WoWPro:RemoveMapPoint()
		WoWProDB.char.lastWorldEventsguide = WoWProDB.char.currentguide
		WoWProDB.char.currentguide = nil
		WoWPro:LoadGuide()
	end
end

-- Guide Registration Function --
function WoWPro.WorldEvents:RegisterGuide(GIDvalue, zonename, guidename, categoryname, authorname, factionname, sequencevalue)
	
--[[ Purpose: 
		Called by guides to register them to the WoWPro.Guide table. All members
		of this table must have a quidetype parameter to let the addon know what 
		module should handle that guide.]]
		
	if factionname and factionname ~= myUFG and factionname ~= "Neutral" then return end 
		-- If the guide is not of the correct faction, don't register it
		
	WoWPro:dbp("Guide Registered: "..GIDvalue)

	WoWPro.Guides[GIDvalue] = {
		guidetype = "WorldEvents",
		zone = zonename,
		name = guidename,
		category = categoryname,
		author = authorname,
		sequence = sequencevalue,
		faction = factionname
	}
end

function WoWPro.WorldEvents:LoadAllGuides()
    WoWPro:Print("Test Load of All Guides")
    local aCount=0
    local hCount=0
    local nCount=0
    local nextGID
    local zed
	for guidID,guide in pairs(WoWPro.Guides) do
	    if WoWPro.Guides[guidID].guidetype == "WorldEvents" then
            WoWPro:Print("Test Loading " .. guidID)
	        WoWPro:LoadGuide(guidID)
	        nextGID = WoWPro.Guides[guidID].nextGID
	        zed = strtrim(string.match(WoWPro.Guides[guidID].zone, "([^%(%-]+)" ))
	        if not WoWPro:ValidZone(zed) then
			    WoWPro:Print("Invalid guide zone:"..(WoWPro.Guides[guidID].zone))
			end
	        if nextGID == nil or WoWPro.Guides[nextGID] == nil then	    
	            WoWPro:Print("Successor to " .. guidID .. " which is " .. tostring(nextGID) .. " is invalid.")
	        end
	        if WoWPro.Guides[guidID].faction == "Alliance" then aCount = aCount + 1 end
	        if WoWPro.Guides[guidID].faction == "Neutral"  then nCount = nCount + 1 end
	        if WoWPro.Guides[guidID].faction == "Horde"    then hCount = hCount + 1 end
	    end
	end
        WoWPro:Print(string.format("Done! %d A, %d N, %d H guides present", aCount, nCount, hCount))
end	    

