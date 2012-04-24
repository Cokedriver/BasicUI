local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database



--[[

	All Credit for Minimap.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.

]]

if C['minimap'].enable ~= true then return end

    -- Square minimap and create a border

Minimap:ClearAllPoints()	
	
	-- Set Minimap to Square
function GetMinimapShape()
    return 'SQUARE'
end

-- Set Minimap Position
if C['datatext'].top ~= true then
	Minimap:SetPoint('TOPRIGHT', UIParent, -26, -26)
else
	Minimap:SetPoint('TOPRIGHT', UIParent, -26, -35)
end



-- Create Minimap Border
local Minimapbg = CreateFrame("Frame", nil, Minimap)	
Minimapbg:SetPoint("TOPLEFT", -4, 4);
Minimapbg:SetPoint("BOTTOMRIGHT", 4, -4);	
Minimapbg:SetBackdrop({
	edgeFile = C['minimap'].border,
	edgeSize = 20,
})
Minimapbg:SetBackdropBorderColor( B.ccolor.r, B.ccolor.g, B.ccolor.b)
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

    -- A 'new' mail notification

MiniMapMailFrame:SetSize(14, 14)
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint('BOTTOMRIGHT', Minimap, -4, 5)

MiniMapMailBorder:SetTexture(nil)
MiniMapMailIcon:SetTexture(nil)

hooksecurefunc(MiniMapMailFrame, 'Show', function()
    MiniMapMailBorder:SetTexture(nil)
    MiniMapMailIcon:SetTexture(nil)
end)

MiniMapMailFrame.Text = MiniMapMailFrame:CreateFontString(nil, 'OVERLAY')
MiniMapMailFrame.Text:SetFont(C['media'].font, C['media'].fontLarge, 'OUTLINE')
MiniMapMailFrame.Text:SetPoint('BOTTOMRIGHT', MiniMapMailFrame)
MiniMapMailFrame.Text:SetTextColor(1, 0, 1)
MiniMapMailFrame.Text:SetText('Mail')

   -- Modify the lfg frame

MiniMapLFGFrame:ClearAllPoints()
MiniMapLFGFrame:SetPoint('TOPLEFT', Minimap, 4, -4)
MiniMapLFGFrame:SetSize(14, 14)
MiniMapLFGFrame:SetHighlightTexture(nil)

MiniMapLFGFrameBorder:SetTexture()
MiniMapLFGFrame.eye:Hide()

hooksecurefunc('EyeTemplate_StartAnimating', function(self)
    self:SetScript('OnUpdate', nil)
end)

MiniMapLFGFrame.Text = MiniMapLFGFrame:CreateFontString(nil, 'OVERLAY')
MiniMapLFGFrame.Text:SetFont(C['media'].font, C['media'].fontLarge, 'OUTLINE')
MiniMapLFGFrame.Text:SetPoint('TOP', MiniMapLFGFrame)
MiniMapLFGFrame.Text:SetTextColor(1, 0.4, 0)
MiniMapLFGFrame.Text:SetText('LFG')

   -- Modify the battlefield frame

MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint('BOTTOMLEFT', Minimap, 5, 5)
MiniMapBattlefieldFrame:SetSize(14, 14)

hooksecurefunc(MiniMapBattlefieldFrame, 'Show', function()
    MiniMapBattlefieldIcon:SetTexture(nil)
    MiniMapBattlefieldBorder:SetTexture(nil)
    BattlegroundShine:SetTexture(nil)
end)

MiniMapBattlefieldFrame.Text = MiniMapBattlefieldFrame:CreateFontString(nil, 'OVERLAY')
MiniMapBattlefieldFrame.Text:SetFont(C['media'].font, C['media'].fontLarge, 'OUTLINE')
MiniMapBattlefieldFrame.Text:SetPoint('BOTTOMLEFT', MiniMapBattlefieldFrame)
MiniMapBattlefieldFrame.Text:SetTextColor(0, 0.75, 1)
MiniMapBattlefieldFrame.Text:SetText('PvP')

    -- Hide all unwanted things

MinimapZoomIn:Hide()
MinimapZoomIn:UnregisterAllEvents()

MinimapZoomOut:Hide()
MinimapZoomOut:UnregisterAllEvents()

MiniMapWorldMapButton:Hide()
MiniMapWorldMapButton:UnregisterAllEvents()

MinimapNorthTag:SetAlpha(0)

MinimapBorder:Hide()
MinimapBorderTop:Hide()

MinimapZoneText:Hide()

MinimapZoneTextButton:Hide()
MinimapZoneTextButton:UnregisterAllEvents()

    -- Hide the tracking button

MiniMapTracking:UnregisterAllEvents()
MiniMapTracking:Hide()

    -- hide the durability frame (the armored man)

DurabilityFrame:Hide()
DurabilityFrame:UnregisterAllEvents()

    -- Bigger minimap
if C['minimap'].farm == true then

	MinimapCluster:SetScale(C['minimap'].farmscale)
	MinimapCluster:EnableMouse(false)
else
	MinimapCluster:SetScale(1.1)
	MinimapCluster:EnableMouse(false)
end



    -- Enable mousewheel zooming

Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
    if (delta > 0) then
        _G.MinimapZoomIn:Click()
    elseif delta < 0 then
        _G.MinimapZoomOut:Click()
    end
end)

    -- Modify the minimap tracking

Minimap:SetScript('OnMouseUp', function(self, button)
    if (button == 'RightButton') then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self, - (Minimap:GetWidth() * 0.7), -3)
    else
        Minimap_OnClick(self)
    end
end)

    -- Skin the ticket status frame

TicketStatusFrame:ClearAllPoints()
TicketStatusFrame:SetPoint('BOTTOMRIGHT', UIParent, -25, -33)
TicketStatusFrameButton:HookScript('OnShow', function(self)
    self:SetBackdrop({
        bgFile = C['minimap'].background, 
		edgeFile = C['minimap'].border,
        insets = {left = 3, right = 3, top = 3, bottom = 3}
    })
end)

local function GetZoneColor()
    local zoneType = GetZonePVPInfo()
    if (zoneType == 'sanctuary') then
        return 0.4, 0.8, 0.94
    elseif (zoneType == 'arena') then
        return 1, 0.1, 0.1
    elseif (zoneType == 'friendly') then
        return 0.1, 1, 0.1
    elseif (zoneType == 'hostile') then
        return 1, 0.1, 0.1
    elseif (zoneType == 'contested') then
        return 1, 0.8, 0
    else
        return 1, 1, 1
    end
end

    -- Mouseover zone text

if (C['minimap'].zoneText) then
    local MainZone = Minimap:CreateFontString(nil, 'OVERLAY')
    MainZone:SetFont(C['media'].font, C['media'].fontLarge, 'THINOUTLINE')
    MainZone:SetPoint('TOP', Minimap, 0, -22)
    MainZone:SetTextColor(1, 1, 1)
    MainZone:SetAlpha(0)
    MainZone:SetSize(130, 32)
    MainZone:SetJustifyV('BOTTOM')

    local SubZone = Minimap:CreateFontString(nil, 'OVERLAY')
    SubZone:SetFont(C['media'].font, C['media'].fontSmall, 'THINOUTLINE')
    SubZone:SetPoint('TOP', MainZone, 'BOTTOM', 0, -1)
    SubZone:SetTextColor(1, 1, 1)
    SubZone:SetAlpha(0)
    SubZone:SetSize(130, 26)
    SubZone:SetJustifyV('TOP')

    Minimap:HookScript('OnEnter', function()
        if (not IsShiftKeyDown()) then
            SubZone:SetTextColor(GetZoneColor())
            SubZone:SetText(GetSubZoneText())
            securecall('UIFrameFadeIn', SubZone, 0.15, SubZone:GetAlpha(), 1)

            MainZone:SetTextColor(GetZoneColor())
            MainZone:SetText(GetRealZoneText())
            securecall('UIFrameFadeIn', MainZone, 0.15, MainZone:GetAlpha(), 1)
        end
    end)

    Minimap:HookScript('OnLeave', function()
        securecall('UIFrameFadeOut', SubZone, 0.15, SubZone:GetAlpha(), 0)
        securecall('UIFrameFadeOut', MainZone, 0.15, MainZone:GetAlpha(), 0)
    end)
end

-- Mouseover Instance Difficulty

local isGuildGroup = isGuildGroup

local function HideDifficultyFrame()
    GuildInstanceDifficulty:EnableMouse(false)
    GuildInstanceDifficulty:SetAlpha(0)

    MiniMapInstanceDifficulty:EnableMouse(false)
    MiniMapInstanceDifficulty:SetAlpha(0)
end

function GetDifficultyText()
    local inInstance, instancetype = IsInInstance()
    local _, _, difficultyIndex, _, maxPlayers, playerDifficulty, isDynamic = GetInstanceInfo()

    local guildStyle
    local heroStyle = '|cffff00ffH|r'

    if (isGuildGroup or GuildInstanceDifficulty:IsShown()) then
        guildStyle = '|cffffff00G|r'
    else
        guildStyle = ''
    end

    if (inInstance and instancetype == 'raid') then
        if (isDynamic) then
            if (difficultyIndex == 4 or difficultyIndex == 3) then
                if (playerDifficulty == 0) then
                    return maxPlayers..guildStyle..heroStyle
                end
            end

            if (difficultyIndex == 2) then
                return maxPlayers..guildStyle
            end

            if (difficultyIndex == 1) then
                if (playerDifficulty == 0) then
                    return maxPlayers..guildStyle
                end

                if (playerDifficulty == 1) then
                    return maxPlayers..guildStyle..heroStyle
                end
            end
        end

        if (not isDynamic) then
            if (difficultyIndex == 1 or difficultyIndex == 2) then
                return maxPlayers..guildStyle
            end

            if (difficultyIndex == 3 or difficultyIndex == 4) then
                return maxPlayers..guildStyle..heroStyle
            end
        end
    end

    if (inInstance and instancetype == 'party') then
        if (difficultyIndex == 2)then
            return maxPlayers..guildStyle..heroStyle
        elseif (difficultyIndex == 1)then
            return maxPlayers..guildStyle
        end
    end

    if (not inInstance) then
        return '' 
    end
end

local f = Minimap
f.InstanceText = f:CreateFontString(nil, 'OVERLAY')
f.InstanceText:SetFont(C['media'].font, C['media'].fontLarge, 'OUTLINE')
f.InstanceText:SetPoint('TOP', Minimap, 0, -3.5)
f.InstanceText:SetTextColor(1, 1, 1)
f.InstanceText:Show()

--[[
MiniMapInstanceDifficulty:UnregisterAllEvents()
MiniMapInstanceDifficulty:Hide()
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 1, 5)
MiniMapInstanceDifficulty:SetScale(0.9)

GuildInstanceDifficulty:UnregisterAllEvents()
GuildInstanceDifficulty:Hide()
GuildInstanceDifficulty:Show()
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 1, 5)
GuildInstanceDifficulty:SetScale(0.9)   
--]]

hooksecurefunc(GuildInstanceDifficulty, 'Show', function()
    isGuildGroup = true
    HideDifficultyFrame()
end)

hooksecurefunc(GuildInstanceDifficulty, 'Hide', function()
    isGuildGroup = false
end)

hooksecurefunc(MiniMapInstanceDifficulty, 'Show', function()
    HideDifficultyFrame()
end)

GuildInstanceDifficulty:HookScript('OnEvent', function(self)
    if (self:IsShown()) then
        isGuildGroup = true
    else
        isGuildGroup = false
    end

    Minimap.InstanceText:SetText(GetDifficultyText())
end)

MiniMapInstanceDifficulty:HookScript('OnEvent', function(self)
    Minimap.InstanceText:SetText(GetDifficultyText())
end)

if (C['minimap'].instanceDifficulty) then
    Minimap.InstanceText:SetAlpha(0)

    Minimap:HookScript('OnEnter', function(self)
        securecall('UIFrameFadeIn', self.InstanceText, 0.235, 0, 1)
    end)

    Minimap:HookScript('OnLeave', function(self)
        securecall('UIFrameFadeOut', self.InstanceText, 0.235, 1, 0)
    end)
end

-- Calender
if (not IsAddOnLoaded('Blizzard_TimeManager')) then
    LoadAddOn('Blizzard_TimeManager')
end

for i = 1, select('#', GameTimeFrame:GetRegions()) do
    local texture = select(i, GameTimeFrame:GetRegions())
    if (texture and texture:GetObjectType() == 'Texture') then
        texture:SetTexture(nil)
    end
end

GameTimeFrame:SetSize(14, 14)
GameTimeFrame:SetHitRectInsets(0, 0, 0, 0)
GameTimeFrame:ClearAllPoints()
GameTimeFrame:SetPoint('TOPRIGHT', Minimap, -3.5, -3.5)

GameTimeFrame:GetFontString():SetFont(C['media'].font, C['media'].fontLarge, 'OUTLINE')
GameTimeFrame:GetFontString():SetShadowOffset(0, 0)
GameTimeFrame:GetFontString():SetPoint('TOPRIGHT', GameTimeFrame)

for _, texture in pairs({
    GameTimeCalendarEventAlarmTexture,
    GameTimeCalendarInvitesTexture,
    GameTimeCalendarInvitesGlow,
    TimeManagerAlarmFiredTexture,
}) do
    texture:SetTexture(nil)


    if (texture:IsShown()) then
        GameTimeFrame:GetFontString():SetTextColor(1, 0, 1)
    else
        GameTimeFrame:GetFontString():SetTextColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
    end

    hooksecurefunc(texture, 'Show', function()
        GameTimeFrame:GetFontString():SetTextColor(1, 0, 1)
    end)

    hooksecurefunc(texture, 'Hide', function()
        GameTimeFrame:GetFontString():SetTextColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
    end)
end

-- Minimap Clock
TimeManagerClockTicker:SetFont(C['media'].font, C['media'].fontLarge, 'OUTLINE')
TimeManagerClockTicker:SetShadowOffset(0, 0)
TimeManagerClockTicker:SetTextColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
TimeManagerClockTicker:SetPoint('TOPRIGHT', TimeManagerClockButton, 0, 0)

TimeManagerClockButton:GetRegions():Hide()
TimeManagerClockButton:ClearAllPoints()
TimeManagerClockButton:SetWidth(40)
TimeManagerClockButton:SetHeight(18)
TimeManagerClockButton:SetPoint('BOTTOM', Minimap, 0, 2)

TimeManagerAlarmFiredTexture:SetTexture(nil)

hooksecurefunc(TimeManagerAlarmFiredTexture, 'Show', function()
	TimeManagerClockTicker:SetTextColor(1, 0, 1)
end)

hooksecurefunc(TimeManagerAlarmFiredTexture, 'Hide', function()
	TimeManagerClockTicker:SetTextColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
end)

if C['minimap'].gameclock == true then
	TimeManagerClockButton:Show()
else
	TimeManagerClockButton:Hide()
end
	