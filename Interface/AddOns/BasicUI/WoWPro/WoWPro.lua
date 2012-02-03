--------------------------
--      WoWPro.lua      --
--------------------------

WoWPro = LibStub("AceAddon-3.0"):NewAddon("WoWPro")
WoWPro.Version = GetAddOnMetadata("WoWPro", "Version") 
WoWPro.DebugMode = false
WoWPro.Guides = {}
WoWPro.InitLockdown = false  -- Set when the addon is loaded
WoWPro.Log = {}

-- Define list of objects to be exported to Guide Addons
WoWPro.mixins = {}
function WoWPro:Embed(target)
  for _,name in pairs(WoWPro.mixins) do
    WoWPro:dbp("Creating WoWPro.%s:%s()",target.name,name)
    target[name] = WoWPro[name]
  end
end

function WoWPro:Export(target)
    table.insert(WoWPro.mixins,target)
end
    
-- WoWPro keybindings name descriptions --
_G["BINDING_NAME_CLICK WoWPro_FauxItemButton:LeftButton"] = "Use quest item"
BINDING_HEADER_BINDING_WOWPRO = "WoWPro Keybindings"
_G["BINDING_NAME_CLICK WoWPro_FauxTargetButton:LeftButton"] = "Target quest mob"

-- Debug print function --
WoWPro.Serial = 0
function WoWPro:dbp(message,...)
	if WoWPro.DebugMode and message ~= nil then
	    local msg = string.format("|cffff7f00%s|r: "..message, self.name or "Wow-Pro",...)
		DEFAULT_CHAT_FRAME:AddMessage( msg )
		WoWPro.Serial = WoWPro.Serial + 1
		if WoWPro.Serial > 999 then
		    WoWPro.Serial = 1
		end
		if WoWProDB and WoWProDB.global and WoWProDB.global.Log then
		    if WoWPro.Log then
		        WoWProDB.global.Log = WoWPro.Log
		        WoWPro.Log = nil
		    end
		    WoWProDB.global.Log[date("%Y%m%d/%H%M.")..string.format("%03d",WoWPro.Serial)] = msg
		else
		    WoWPro.Log[date("%Y%m%d/%H%M.")..string.format("%02d",WoWPro.Serial)] = msg
		end
	end
end
WoWPro:Export("dbp")

-- WoWPro print function --
function WoWPro:Print(message,...)
	if message ~= nil then
	    local msg = string.format("|cffffff00%s|r: "..message, self.name or "Wow-Pro",...)
		DEFAULT_CHAT_FRAME:AddMessage( msg )
		WoWPro.Serial = WoWPro.Serial + 1
		if WoWPro.Serial > 999 then
		    WoWPro.Serial = 1
		end
		if WoWProDB and WoWProDB.global and WoWProDB.global.Log then
		    if WoWPro.Log then
		        WoWProDB.global.Log = WoWPro.Log
		        WoWPro.Log = nil
		    end
		    WoWProDB.global.Log[date("%Y%m%d/%H%M.")..string.format("%03d",WoWPro.Serial)] = msg
		else
		    WoWPro.Log[date("%Y%m%d/%H%M.")..string.format("%02d",WoWPro.Serial)] = msg
		end
	end
end
WoWPro:Export("Print")

-- Default profile options --
local defaults = { profile = {
	drag = true,
	anchorpoint = "AUTO",
	pad = 5,
	space = 5,
	mousenotes = false,
	minimap = { hidden = false, },
	track = true,
	showcoords = false,
	autoload = true,
	guidescroll = false,
	checksound = true,
	checksoundfile = [[Sound\Interface\MapPing.wav]],
	rank = 2,
	resize = false,
	autoresize = true,
	numsteps = 1,
	hminresize = 200,
	vminresize = 100,
	titlebar = true,
	titlecolor = {0.5, 0.5, 0.5, 1},
	bgtexture = [[Interface\Tooltips\UI-Tooltip-Background]],
	bgcolor = {0.2, 0.2, 0.2, 0.7},
	bordertexture = [[Interface\Tooltips\UI-Tooltip-Border]],
	border = true,
	stickytexture = [[Interface\Tooltips\UI-Tooltip-Background]],
	stickycolor = {0.8, 0.8, 0.8, 0.7},
	stepfont = [[Fonts\FRIZQT__.TTF]],
	steptextsize = 13,
	steptextcolor = {1, 1, 1},
	notefont = [[Fonts\FRIZQT__.TTF]],
	notetextsize = 11,
	notetextcolor = {1, 1, 0},
	trackfont = [[Fonts\FRIZQT__.TTF]],
	tracktextsize = 10,
	tracktextcolor = {1, 1, 0},
	titlefont = [[Fonts\FRIZQT__.TTF]],
	titletextsize = 15,
	titletextcolor = {1, 1, 1},
	stickytitlefont = [[Fonts\FRIZQT__.TTF]],
	stickytitletextsize = 13,
	stickytitletextcolor = {1, 1, 1},
} }

-- Core Tag Setup --
WoWPro.Tags = { "action", "step", "note", "index", "map", "sticky", 
	"unsticky", "use", "zone", "lootitem", "lootqty", "optional", 
	"level", "target", "prof", "waypcomplete", "rank"  
}

-- Called before all addons have loaded, but after saved variables have loaded. --
function WoWPro:OnInitialize()
	WoWProDB = LibStub("AceDB-3.0"):New("WoWProData", defaults, true) -- Creates DB object to use with Ace
	-- Setting up callbacks for use with profiels --
	WoWProDB.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	WoWProDB.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	WoWProDB.RegisterCallback(self, "OnProfileReset", "SetDefaults")


	-- Creating empty user settings if none exist --
	WoWProCharDB = WoWProCharDB or {}
	WoWProCharDB.Guide = WoWProCharDB.Guide or {} 
	WoWProCharDB.completedQIDs = WoWProCharDB.completedQIDs or {}
	WoWProCharDB.skippedQIDs = WoWProCharDB.skippedQIDs or {}
	if WoWProCharDB.Enabled == nil then
	    WoWProCharDB.Enabled = true
	end
	WoWProDB.global.Deltas = {}
	WoWProDB.global.Log = {}

end

-- Called when the addon is enabled, and on log-in and /reload, after all addons have loaded. --
function WoWPro:OnEnable()
	WoWPro:dbp("|cff33ff33Enabled|r: Core Addon")

	-- Warning if the user is missing TomTom --
	if not TomTom then
		WoWPro:Print("It looks like you don't have |cff33ff33TomTom|r or |cff33ff33Carbonite|r installed. "
			.."WoW-Pro's guides won't have their full functionality without it! "
			.."Download it for free from www.wowinterface.com or www.curse.com .")
	end
	
	-- Loading Frames --
	if not WoWPro.FramesLoaded then --First time the addon has been enabled since UI Load
		WoWPro:CreateFrames()
		WoWPro:CreateConfig()
		WoWPro.EventFrame=CreateFrame("Button", "WoWPro.EventFrame", UIParent)
		WoWPro.FramesLoaded = true
	else -- Addon was previously disabled, so no need to create frames, just turn them back on
		WoWPro:AbleFrames()
	end
	
	-- Module Enabling --
	for name, module in WoWPro:IterateModules() do
		WoWPro:dbp("Enabling "..name.." module...")
		module:Enable()
	end
	
	WoWPro:CustomizeFrames()	-- Applies profile display settings

	-- Keybindings Initial Setup --
	local keys = GetBindingKey("CLICK WoWPro_FauxItemButton:LeftButton")
	if not keys then	
		SetBinding("CTRL-SHIFT-I", "CLICK WoWPro_FauxItemButton:LeftButton")
	end
	local keys = GetBindingKey("CLICK WoWPro_FauxTargetButton:LeftButton")
	if not keys then	
		SetBinding("CTRL-SHIFT-T", "CLICK WoWPro_FauxTargetButton:LeftButton")
	end

	-- Event Setup --
	WoWPro:dbp("Registering Events: Core Addon")
	WoWPro:RegisterEvents( {															-- Setting up core events
		"PLAYER_REGEN_ENABLED", "PARTY_MEMBERS_CHANGED", "QUEST_QUERY_COMPLETE",
		"UPDATE_BINDINGS", "PLAYER_ENTERING_WORLD", "PLAYER_LEAVING_WORLD"
	})
	WoWPro.LockdownTimer = nil
	WoWPro.EventFrame:SetScript("OnUpdate", function(self, elapsed)
	    if WoWPro.LockdownTimer ~= nil then
	        WoWPro.LockdownTimer = WoWPro.LockdownTimer - elapsed
	        if WoWPro.LockdownTimer < 0 then
	            WoWPro:dbp("Lockdown Timer expired.  Return to normal")
	            WoWPro.LockdownTimer = nil
	            WoWPro.InitLockdown = false
                WoWPro:LoadGuide()			-- Loads Current Guide (if nil, loads NilGuide)
	        end
	    end
	end)
	    
	WoWPro.EventFrame:SetScript("OnEvent", function(self, event, ...)		-- Setting up event handler
		if WoWPro.InitLockdown then
		    WoWPro:dbp("LockEvent Fired: "..event)
		else
		    WoWPro:dbp("Event Fired: "..event)
		end
	

		-- Unlocking event processong till after things get settled --
		if event == "PLAYER_ENTERING_WORLD" then
		    WoWPro:dbp("Setting Timer 1")
		    WoWPro.InitLockdown = true
		    WoWPro.LockdownTimer = 2.0
		end
		
		-- Receiving the result of the completed quest query --
		if event == "QUEST_QUERY_COMPLETE" then
			local num = 0
			for i, QID in pairs(WoWProCharDB.completedQIDs) do
				num = num+1
			end
			WoWPro:dbp("Old Completed QIDs: "..num)
			WoWProCharDB.completedQIDs = {}
			GetQuestsCompleted(WoWProCharDB.completedQIDs)
			num = 0
			for i, QID in pairs(WoWProCharDB.completedQIDs) do
				num = num+1
			end
			WoWPro:dbp("New Completed QIDs: "..num)
			collectgarbage("collect")
			if not WoWPro.InitLockdown then
			    WoWPro.UpdateGuide()
			end
		end
		
		-- Locking event processong till after things get settled --
		if event == "PLAYER_LEAVING_WORLD" then
		    WoWPro:dbp("Locking Down 1")
		    WoWPro.InitLockdown = true
		end
		
		if WoWPro.InitLockdown then
		    return
		end
		
		-- Unlocking guide frame when leaving combat --
		if event == "PLAYER_REGEN_ENABLED" or event == "PLAYER_ENTERING_WORLD" then
			WoWPro:UpdateGuide() 
		end
		
		-- Updating party-dependant options --
		if event == "PARTY_MEMBERS_CHANGED" and not InCombatLockdown() then
			WoWPro:UpdateGuide() 
		end

		-- Updating WoWPro keybindings --
		if event == "UPDATE_BINDINGS" and not InCombatLockdown() then
			WoWPro:UpdateGuide() 
		end

		-- Module Event Handlers --
		for name, module in WoWPro:IterateModules() do
			if WoWPro[name].EventHandler 
			and WoWProDB.char.currentguide 
			and WoWPro.Guides[WoWProDB.char.currentguide]
			and WoWPro.Guides[WoWProDB.char.currentguide].guidetype == name 
			then WoWPro[name]:EventHandler(self, event, ...) end
		end
	end)
	
--	WoWPro:MapPoint()				-- Maps the active step
	-- If the base addon was disabled by the user, put it to sleep now.
	if not WoWProCharDB.Enabled then
	    WoWPro:Disable()
	    return
	end

end	

-- Called when the addon is disabled --
function WoWPro:OnDisable()
	-- Module Disabling --
	for name, module in WoWPro:IterateModules() do
		WoWPro:dbp("Disabling "..name.." module...")
		module:Disable()
	end

	WoWPro:AbleFrames()								-- Hides all frames
	WoWPro.EventFrame:UnregisterAllEvents()	-- Unregisters all events
	WoWPro:RemoveMapPoint()							-- Removes any active map points
	WoWPro:Print("|cffff3333Disabled|r: Core Addon")
end

-- Tag Registration Function --
function WoWPro:RegisterTags(tagtable)
--[[ Purpose: Can be called by modules to add tags to the WoWPro.Tags table. 
This table is iterated on in several key functions within the addon.
]]--
	if not WoWPro.Tags then return end			-- If the table doesn't exist for some reason (function called too early), end.
	for i=1,#tagtable do
		table.insert(WoWPro.Tags,tagtable[i])	-- Insert each tag from the table supplied into the WoWPro.Tags table.
	end
end

-- Event Registration Function --
function WoWPro:RegisterEvents(eventtable)
--[[Purpose: Iterates through the supplied table of events, and registers each 
event to the guide frame.
]]--
	for _, event in ipairs(eventtable) do
		WoWPro.EventFrame:RegisterEvent(event)
	end
end

-- Event Un-Registration Function --
function WoWPro:UnregisterEvents(eventtable)
--[[Purpose: Iterates through the supplied table of events, and removes each 
event from the guide frame.
]]--
	for _, event in ipairs(eventtable) do
		WoWPro.EventFrame:UnregisterEvent(event)
	end
end

function WoWPro:LoadAllGuides()
    WoWPro:Print("Test Load of All Guides")
    local aCount=0
    local hCount=0
    local nCount=0
    local Count=0
    local nextGID
    local zed
	for guidID,guide in pairs(WoWPro.Guides) do
        WoWPro:Print("Test Loading " .. guidID)
        WoWPro:LoadGuide(guidID)
        nextGID = WoWPro.Guides[guidID].nextGID
        if WoWPro.Guides[guidID].zone then
            zed = strtrim(string.match(WoWPro.Guides[guidID].zone, "([^%(%-]+)" ))
            if not WoWPro:ValidZone(zed) then
		        WoWPro:Print("Invalid guide zone:"..(WoWPro.Guides[guidID].zone))
		    end
		end
        if nextGID and WoWPro.Guides[nextGID] == nil then	    
            WoWPro:Print("Successor to " .. guidID .. " which is " .. tostring(nextGID) .. " is invalid.")
        end
        if WoWPro.Guides[guidID].faction then
            if WoWPro.Guides[guidID].faction == "Alliance" then aCount = aCount + 1 end
            if WoWPro.Guides[guidID].faction == "Neutral"  then nCount = nCount + 1 end
            if WoWPro.Guides[guidID].faction == "Horde"    then hCount = hCount + 1 end
        end
        Count = Count + 1
	end
        WoWPro:Print("%d Done! %d A, %d N, %d H guides present", Count, aCount, nCount, hCount)
end	    

