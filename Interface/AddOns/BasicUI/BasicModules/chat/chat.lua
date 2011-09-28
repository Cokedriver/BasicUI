local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['chat'].enable ~= true then return end

--[[

	All Create for autogreed.lua goes to Neal and ballagarba. 
	nChat = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.
	
]]

local _G = _G
local type = type
local select = select
local unpack = unpack
local tostring = tostring
local concat = table.concat
local find = string.find

local gsub = string.gsub
local format = string.format

_G.CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
_G.CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0

_G.CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 0.5
_G.CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0

--_G.CHAT_FRAME_FADE_OUT_TIME = 0
--_G.CHAT_FRAME_FADE_TIME = 0

_G.CHAT_FONT_HEIGHTS = {
    [1] = 8,
    [2] = 9,
    [3] = 10,
    [4] = 11,
    [5] = 12,
    [6] = 13,
    [7] = 14,
    [8] = 15,
    [9] = 16,
    [10] = 17,
    [11] = 18,
    [12] = 19,
    [13] = 20,
}


_G.CHAT_SAY_GET = '%s:\32'
_G.CHAT_YELL_GET = '%s:\32'

_G.CHAT_WHISPER_GET = '[from] %s:\32'
_G.CHAT_WHISPER_INFORM_GET = '[to] %s:\32'

_G.CHAT_BN_WHISPER_GET = '[from] %s:\32'
_G.CHAT_BN_WHISPER_INFORM_GET = '[to] %s:\32'


_G.CHAT_FLAG_AFK = '[AFK] '
_G.CHAT_FLAG_DND = '[DND] '
_G.CHAT_FLAG_GM = '[GM] '

_G.CHAT_GUILD_GET = '[|Hchannel:Guild|hG|h] %s:\32'
_G.CHAT_OFFICER_GET = '[|Hchannel:o|hO|h] %s:\32'

_G.CHAT_PARTY_GET = '[|Hchannel:party|hP|h] %s:\32'
_G.CHAT_PARTY_LEADER_GET = '[|Hchannel:party|hPL|h] %s:\32'
_G.CHAT_PARTY_GUIDE_GET = '[|Hchannel:party|hDG|h] %s:\32'
_G.CHAT_MONSTER_PARTY_GET = '[|Hchannel:raid|hR|h] %s:\32'

_G.CHAT_RAID_GET = '[|Hchannel:raid|hR|h] %s:\32'
_G.CHAT_RAID_WARNING_GET = '[RW!] %s:\32'
_G.CHAT_RAID_LEADER_GET = '[|Hchannel:raid|hL|h] %s:\32'

_G.CHAT_BATTLEGROUND_GET = '[|Hchannel:Battleground|hBG|h] %s:\32'
_G.CHAT_BATTLEGROUND_LEADER_GET = '[|Hchannel:Battleground|hBL|h] %s:\32'


local channelFormat 
do
    local a, b = '.*%[(.*)%].*', '%%[%1%%]'
    channelFormat = {
        [1] = {gsub(CHAT_BATTLEGROUND_GET, a, b), '[BG]'},
        [2] = {gsub(CHAT_BATTLEGROUND_LEADER_GET, a, b), '[BGL]'},

        [3] = {gsub(CHAT_GUILD_GET, a, b), '[G]'},
        [4] = {gsub(CHAT_OFFICER_GET, a, b), '[O]'},
        
        [5] = {gsub(CHAT_PARTY_GET, a, b), '[P]'},
        [6] = {gsub(CHAT_PARTY_LEADER_GET, a, b), '[PL]'},
        [7] = {gsub(CHAT_PARTY_GUIDE_GET, a, b), '[PL]'},

        [8] = {gsub(CHAT_RAID_GET, a, b), '[R]'},
        [9] = {gsub(CHAT_RAID_LEADER_GET, a, b), '[RL]'},
        [10] = {gsub(CHAT_RAID_WARNING_GET, a, b), '[RW]'},

        [11] = {gsub(CHAT_FLAG_AFK, a, b), '[AFK] '},
        [12] = {gsub(CHAT_FLAG_DND, a, b), '[DND] '},
        [13] = {gsub(CHAT_FLAG_GM, a, b), '[GM] '},
    }
end


local AddMessage = ChatFrame1.AddMessage
local function FCF_AddMessage(self, text, ...)
    if (type(text) == 'string') then
        text = gsub(text, '(|HBNplayer.-|h)%[(.-)%]|h', '%1%2|h')
        text = gsub(text, '(|Hplayer.-|h)%[(.-)%]|h', '%1%2|h')
        text = gsub(text, '%[(%d0?)%. (.-)%]', '[%1]') 
        
        
        for i = 1, #channelFormat  do
            text = gsub(text, channelFormat[i][1], channelFormat[i][2])
        end
        
    end

    return AddMessage(self, text, ...)
end

    -- Modify the editbox
    
for k = 6, 11 do
   select(k, ChatFrame1EditBox:GetRegions()):SetTexture(nil)
end

ChatFrame1EditBox:SetAltArrowKeyMode(false)
ChatFrame1EditBox:ClearAllPoints()
ChatFrame1EditBox:SetPoint('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', 2, 33)
ChatFrame1EditBox:SetPoint('BOTTOMRIGHT', ChatFrame1, 'TOPRIGHT', 0, 33)
ChatFrame1EditBox:SetBackdrop({
    bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background',
    edgeFile = 'Interface\\AddOns\\BasicUI\\BasicMedia\\UI-Tooltip-Border',
    tile = true, tileSize = 16, edgeSize = 18,
    insets = {left = 3, right = 3, top = 2, bottom = 3},
})


ChatFrame1EditBox:SetBackdropColor(0, 0, 0, 0.5)

if (C['chat'].enableBorderColoring) then

    hooksecurefunc('ChatEdit_UpdateHeader', function(editBox)
        local type = editBox:GetAttribute('chatType')
        if (not type) then
            return
        end

        local info = ChatTypeInfo[type]
		ChatFrame1EditBox:SetBackdropBorderColor(info.r, info.g, info.b)
    end)
end

    -- Hide the menu and friend button

FriendsMicroButton:SetAlpha(0)
FriendsMicroButton:EnableMouse(false)
FriendsMicroButton:UnregisterAllEvents()

ChatFrameMenuButton:SetAlpha(0)
ChatFrameMenuButton:EnableMouse(false)

    -- Tab text colors for the tabs

hooksecurefunc('FCFTab_UpdateColors', function(self, selected)
    if (selected) then
        self:GetFontString():SetTextColor(0, 0.75, 1)
    else
        self:GetFontString():SetTextColor(1, 1, 1)
    end
end)

    -- Tab text fadeout

local origFCF_FadeOutChatFrame = _G.FCF_FadeOutChatFrame
local function FCF_FadeOutChatFrameHook(chatFrame)
    origFCF_FadeOutChatFrame(chatFrame)

    local frameName = chatFrame:GetName()
    local chatTab = _G[frameName..'Tab']
    local tabGlow = _G[frameName..'TabGlow']

    if (not tabGlow:IsShown()) then
        if (frameName.isDocked) then
            securecall('UIFrameFadeOut', chatTab, CHAT_FRAME_FADE_OUT_TIME, chatTab:GetAlpha(), CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA)
        else
            securecall('UIFrameFadeOut', chatTab, CHAT_FRAME_FADE_OUT_TIME, chatTab:GetAlpha(), CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA)
        end
    end
end
FCF_FadeOutChatFrame = FCF_FadeOutChatFrameHook

    -- Improve mousewheel scrolling

hooksecurefunc('FloatingChatFrame_OnMouseScroll', function(self, direction)
    if (direction > 0) then
        if (IsShiftKeyDown()) then
            self:ScrollToTop()
        else
            self:ScrollUp()
            self:ScrollUp()
        end
    elseif (direction < 0)  then
        if (IsShiftKeyDown()) then
            self:ScrollToBottom()
        else
            self:ScrollDown()
            self:ScrollDown()
        end
    end

    if (C['chat'].enableBottomButton) then
        local buttonBottom = _G[self:GetName() .. 'ButtonFrameBottomButton']
        if (self:AtBottom()) then
            buttonBottom:SetAlpha(0)
            buttonBottom:EnableMouse(false)
        else
            buttonBottom:SetAlpha(0.7)
            buttonBottom:EnableMouse(true)
        end
    end
end)

    -- Reposit toast frame

BNToastFrame:HookScript('OnShow', function(self)
    BNToastFrame:ClearAllPoints()
    BNToastFrame:SetPoint('BOTTOMLEFT', ChatFrame1EditBox, 'TOPLEFT', 0, 15)
end)

    -- Modify the chat tabs

function SkinTab(self)
    local chat = _G[self]

    local tab = _G[self..'Tab']
    for i = 1, select('#', tab:GetRegions()) do
        local texture = select(i, tab:GetRegions())
        if (texture and texture:GetObjectType() == 'Texture') then
            texture:SetTexture(nil)
        end
    end

    local tabText = _G[self..'TabText']
    tabText:SetJustifyH('CENTER')
    tabText:SetWidth(60)
    if (C['chat'].tab.fontOutline) then
        tabText:SetFont('Fonts\\ARIALN.ttf', C['chat'].tab.fontSize, 'THINOUTLINE')
        tabText:SetShadowOffset(0, 0)
    else
        tabText:SetFont('Fonts\\ARIALN.ttf', C['chat'].tab.fontSize)
        tabText:SetShadowOffset(1, -1)
    end

    local a1, a2, a3, a4, a5 = tabText:GetPoint()
    tabText:SetPoint(a1, a2, a3, a4, 1)

    local s1, s2, s3 = unpack(C['chat'].tab.specialColor)
    local e1, e2, e3 = unpack(C['chat'].tab.selectedColor)
    local n1, n2, n3 = unpack(C['chat'].tab.normalColor)

    local tabGlow = _G[self..'TabGlow']
    hooksecurefunc(tabGlow, 'Show', function()
        tabText:SetTextColor(s1, s2, s3, CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA)
    end)

    hooksecurefunc(tabGlow, 'Hide', function()
        tabText:SetTextColor(n1, n2, n3)
    end)

    tab:SetScript('OnEnter', function()
        tabText:SetTextColor(s1, s2, s3, tabText:GetAlpha())
    end)

    tab:SetScript('OnLeave', function()
        local hasNofication = tabGlow:IsShown()

        local r, g, b
        if (_G[self] == SELECTED_CHAT_FRAME and chat.isDocked) then
            r, g, b = e1, e2, e3
        elseif (hasNofication) then
            r, g, b = s1, s2, s3
        else
            r, g, b = n1, n2, n3
        end

        tabText:SetTextColor(r, g, b)
    end)

    hooksecurefunc(tab, 'Show', function()
        if (not tab.wasShown) then
            local hasNofication = tabGlow:IsShown()
            
            if (chat:IsMouseOver()) then
                tab:SetAlpha(CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA)
            else
                tab:SetAlpha(CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA)
            end

            local r, g, b
            if (_G[self] == SELECTED_CHAT_FRAME and chat.isDocked) then
                r, g, b = e1, e2, e3
            elseif (hasNofication) then
                r, g, b = s1, s2, s3
            else
                r, g, b = n1, n2, n3
            end

            tabText:SetTextColor(r, g, b)

            tab.wasShown = true
        end
    end)
end

local function ModChat(self)
    local chat = _G[self]

    if (not C['chat'].chatOutline) then
        chat:SetShadowOffset(1, -1)
    end

    if (C['chat'].disableFade) then
        chat:SetFading(false)
    end

    SkinTab(self)

    local font, fontsize, fontflags = chat:GetFont()
    chat:SetFont(font, fontsize, C['chat'].chatOutline and 'THINOUTLINE' or fontflags)
    chat:SetClampedToScreen(false)

    chat:SetClampRectInsets(0, 0, 0, 0)
    chat:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
    chat:SetMinResize(150, 25)
    
    if (self ~= 'ChatFrame2') then
        chat.AddMessage = FCF_AddMessage
    end

    local buttonUp = _G[self..'ButtonFrameUpButton']
    buttonUp:SetAlpha(0)
    buttonUp:EnableMouse(false)

    local buttonDown = _G[self..'ButtonFrameDownButton']
    buttonDown:SetAlpha(0)
    buttonDown:EnableMouse(false)

    local buttonBottom = _G[self..'ButtonFrameBottomButton']
	buttonBottom:SetAlpha(0)
    buttonBottom:EnableMouse(false)
	
    if (C['chat'].enableBottomButton) then
        buttonBottom:ClearAllPoints()
        buttonBottom:SetPoint('BOTTOMRIGHT', chat, -1, -3)
        buttonBottom:HookScript('OnClick', function(self)
            self:SetAlpha(0)
            self:EnableMouse(false)
        end)
    end

    for _, texture in pairs({
        'ButtonFrameBackground',
        'ButtonFrameTopLeftTexture',
        'ButtonFrameBottomLeftTexture',
        'ButtonFrameTopRightTexture',
        'ButtonFrameBottomRightTexture',
        'ButtonFrameLeftTexture',
        'ButtonFrameRightTexture',
        'ButtonFrameBottomTexture',
        'ButtonFrameTopTexture',
    }) do
        _G[self..texture]:SetTexture(nil)
    end
end

local function SetChatStyle()
    for _, v in pairs(CHAT_FRAMES) do
        local chat = _G[v]
        if (chat and not chat.hasModification) then
            ModChat(chat:GetName())

            local convButton = _G[chat:GetName()..'ConversationButton']
            if (convButton) then
                convButton:SetAlpha(0)
                convButton:EnableMouse(false)
            end

            local chatMinimize = _G[chat:GetName()..'ButtonFrameMinimizeButton']
            if (chatMinimize) then
                chatMinimize:SetAlpha(0)
                chatMinimize:EnableMouse(0)
            end

            chat.hasModification = true
        end
    end
end
hooksecurefunc('FCF_OpenTemporaryWindow', SetChatStyle)
SetChatStyle()

    -- Chat menu, just a middle click on the chatframe 1 tab

hooksecurefunc('ChatFrameMenu_UpdateAnchorPoint', function()
    if (FCF_GetButtonSide(DEFAULT_CHAT_FRAME) == 'right') then
        ChatMenu:ClearAllPoints()
        ChatMenu:SetPoint('BOTTOMRIGHT', ChatFrame1Tab, 'TOPLEFT')
    else
        ChatMenu:ClearAllPoints()
        ChatMenu:SetPoint('BOTTOMLEFT', ChatFrame1Tab, 'TOPRIGHT')
    end
end)

ChatFrame1Tab:RegisterForClicks('AnyUp')
ChatFrame1Tab:HookScript('OnClick', function(self, button)
    if (button == 'MiddleButton' or button == 'Button4' or button == 'Button5') then
        if (ChatMenu:IsShown()) then
            ChatMenu:Hide()
        else
            ChatMenu:Show()
        end
    else
        ChatMenu:Hide()
    end
end)

    -- Modify the gm chatframe and add a sound notification on incoming whispers

local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')
f:RegisterEvent('CHAT_MSG_WHISPER')
f:RegisterEvent('CHAT_MSG_BN_WHISPER')
f:SetScript('OnEvent', function(_, event)
    if (event == 'ADDON_LOADED' and arg1 == 'Blizzard_GMChatUI') then
        GMChatFrame:EnableMouseWheel(true)
        GMChatFrame:SetScript('OnMouseWheel', ChatFrame1:GetScript('OnMouseWheel'))
        GMChatFrame:SetHeight(200)

        GMChatFrameUpButton:SetAlpha(0)
        GMChatFrameUpButton:EnableMouse(false)

        GMChatFrameDownButton:SetAlpha(0)
        GMChatFrameDownButton:EnableMouse(false)

        GMChatFrameBottomButton:SetAlpha(0)
        GMChatFrameBottomButton:EnableMouse(false)
    end

    if (event == 'CHAT_MSG_WHISPER' or event == 'CHAT_MSG_BN_WHISPER') then
        PlaySoundFile('Sound\\Spells\\Simongame_visual_gametick.wav')
    end
end)

local combatLog = {
    text = 'CombatLog',
    colorCode = '|cffFFD100',
    isNotRadio = true,

    func = function() 
        if (not LoggingCombat()) then
            LoggingCombat(true) 
            DEFAULT_CHAT_FRAME:AddMessage(COMBATLOGENABLED, 1, 1, 0)
        else
            LoggingCombat(false)
            DEFAULT_CHAT_FRAME:AddMessage(COMBATLOGDISABLED, 1, 1, 0)
        end
    end,

    checked = function()
        if (LoggingCombat()) then
            return true
        else
            return false
        end
    end
}

local chatLog = {
    text = 'ChatLog',
    colorCode = '|cffFFD100',
    isNotRadio = true,

    func = function() 
        if (not LoggingChat()) then
            LoggingChat(true) 
            DEFAULT_CHAT_FRAME:AddMessage(CHATLOGENABLED, 1, 1, 0)
        else
            LoggingChat(false)
            DEFAULT_CHAT_FRAME:AddMessage(CHATLOGDISABLED, 1, 1, 0)
        end
    end,

    checked = function()
        if (LoggingChat()) then
            return true
        else
            return false
        end
    end
}

local origFCF_Tab_OnClick = _G.FCF_Tab_OnClick
local function FCF_Tab_OnClickHook(chatTab, ...)
    origFCF_Tab_OnClick(chatTab, ...)

    combatLog.arg1 = chatTab
    UIDropDownMenu_AddButton(combatLog)

    chatLog.arg1 = chatTab
    UIDropDownMenu_AddButton(chatLog)
end
FCF_Tab_OnClick = FCF_Tab_OnClickHook


    -- Chat Copy

local f = CreateFrame('Frame', nil, UIParent)
f:SetHeight(220)
f:SetBackdropColor(0, 0, 0, 1)
f:SetPoint('BOTTOMLEFT', ChatFrame1EditBox, 'TOPLEFT', 3, 10)
f:SetPoint('BOTTOMRIGHT', ChatFrame1EditBox, 'TOPRIGHT', -3, 10)
f:SetFrameStrata('DIALOG')
f:SetBackdrop({
    bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background',
    edgeFile = 'Interface\\Tooltips\\UI-Tooltip-Border',
    tile = true, tileSize = 16, edgeSize = 18,
    insets = {left = 3, right = 3, top = 3, bottom = 3
}})
f:Hide()

f.t = f:CreateFontString(nil, 'OVERLAY')
f.t:SetFont('Fonts\\ARIALN.ttf', 18)
f.t:SetPoint('TOPLEFT', f, 8, -8)
f.t:SetTextColor(1, 1, 0)
f.t:SetShadowOffset(1, -1)
f.t:SetJustifyH('LEFT')

f.b = CreateFrame('EditBox', nil, f)
f.b:SetMultiLine(true)
f.b:SetMaxLetters(20000)
f.b:SetSize(450, 270)
f.b:SetScript('OnEscapePressed', function()
    f:Hide() 
end)

f.s = CreateFrame('ScrollFrame', '$parentScrollBar', f, 'UIPanelScrollFrameTemplate')
f.s:SetPoint('TOPLEFT', f, 'TOPLEFT', 8, -30)
f.s:SetPoint('BOTTOMRIGHT', f, 'BOTTOMRIGHT', -30, 8)
f.s:SetScrollChild(f.b)

f.c = CreateFrame('Button', nil, f, 'UIPanelCloseButton')
f.c:SetPoint('TOPRIGHT', f, 'TOPRIGHT', 0, -1)

local lines = {}
local function GetChatLines(...)
    local count = 1
    for i = select('#', ...), 1, -1 do
        local region = select(i, ...)
        if (region:GetObjectType() == 'FontString') then
            lines[count] = tostring(region:GetText())
            count = count + 1
        end
    end

    return count - 1
end

local function copyChat(self)
    local chat = _G[self:GetName()]
    local _, fontSize = chat:GetFont()

    FCF_SetChatWindowFontSize(self, chat, 0.1)
    local lineCount = GetChatLines(chat:GetRegions())
    FCF_SetChatWindowFontSize(self, chat, fontSize)

    if (lineCount > 0) then
        ToggleFrame(f)
        f.t:SetText(chat:GetName())

        local f1, f2, f3 = ChatFrame1:GetFont()
        f.b:SetFont(f1, f2, f3)

        local text = concat(lines, '\n', 1, lineCount)
        f.b:SetText(text)
    end
end

local function CreateCopyButton(self)
    self.Copy = CreateFrame('Button', nil, _G[self:GetName()])
    self.Copy:SetSize(20, 20)
    self.Copy:SetPoint('TOPRIGHT', self, -5, -5)

    self.Copy:SetNormalTexture('Interface\\AddOns\\BasicUI\\BasicMedia\\textureCopyNormal')
    self.Copy:GetNormalTexture():SetSize(20, 20)

    self.Copy:SetHighlightTexture('Interface\\AddOns\\BasicUI\\BasicMedia\\textureCopyHighlight')
    self.Copy:GetHighlightTexture():SetAllPoints(self.Copy:GetNormalTexture())

    local tab = _G[self:GetName()..'Tab']
    hooksecurefunc(tab, 'SetAlpha', function()
        self.Copy:SetAlpha(tab:GetAlpha()*0.55)
    end)
    
    self.Copy:SetScript('OnMouseDown', function(self)
        self:GetNormalTexture():ClearAllPoints()
        self:GetNormalTexture():SetPoint('CENTER', 1, -1)
    end)

    self.Copy:SetScript('OnMouseUp', function()
        self.Copy:GetNormalTexture():ClearAllPoints()
        self.Copy:GetNormalTexture():SetPoint('CENTER')
        
        if (self.Copy:IsMouseOver()) then
            copyChat(self)
        end
    end)
end

local function EnableCopyButton()
    for _, v in pairs(CHAT_FRAMES) do
        local chat = _G[v]
        if (chat and not chat.Copy) then
            CreateCopyButton(chat)
        end
    end
end
hooksecurefunc('FCF_OpenTemporaryWindow', EnableCopyButton)
EnableCopyButton()

 -- Copy URL
 
local urlStyle = '|cffff00ff|Hurl:%1|h%1|h|r'
local urlPatterns = {
    '(http://%S+)',                 -- http://xxx.com
    '(www%.%S+)',                   -- www.xxx.com/site/index.php
    '(%d+%.%d+%.%d+%.%d+:?%d*)',    -- 192.168.1.1 / 192.168.1.1:1110
}

local messageTypes = {
    'CHAT_MSG_CHANNEL',
    'CHAT_MSG_GUILD',
    'CHAT_MSG_PARTY',
    'CHAT_MSG_RAID',
    'CHAT_MSG_SAY',
    'CHAT_MSG_WHISPER',
}

local function urlFilter(self, event, text, ...)
    for _, pattern in ipairs(urlPatterns) do
        local result, matches = gsub(text, pattern, urlStyle)

        if (matches > 0) then
            return false, result, ...
        end
    end
end

for _, event in ipairs(messageTypes) do
    ChatFrame_AddMessageEventFilter(event, urlFilter)
end

local origSetItemRef = _G.SetItemRef
local currentLink
local SetItemRefHook = function(link, text, button)
    if (link:sub(0, 3) == 'url') then
        currentLink = link:sub(5)
        StaticPopup_Show('UrlCopyDialog')
        return
    end

    return origSetItemRef(link, text, button)
end

SetItemRef = SetItemRefHook

StaticPopupDialogs['UrlCopyDialog'] = {
    text = 'URL',
    button2 = CLOSE,
    hasEditBox = 1,
    editBoxWidth = 250,

    OnShow = function(frame)
        local editBox = _G[frame:GetName()..'EditBox']
        if (editBox) then
            editBox:SetText(currentLink)
            editBox:SetFocus()
            editBox:HighlightText(0)
        end

        local button = _G[frame:GetName()..'Button2']
        if (button) then
            button:ClearAllPoints()
            button:SetWidth(100)
            button:SetPoint('CENTER', editBox, 'CENTER', 0, -30)
        end
    end,

    EditBoxOnEscapePressed = function(frame) 
        frame:GetParent():Hide() 
    end,

    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    maxLetters = 1024,
}

if C['chat'].enableHyperlinkTooltip ~= true then return end

--[[

	All Create for hyperlink.lua goes to Neal, ballagarba, and Tuks.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

local _G = getfenv(0)
local orig1, orig2 = {}, {}
local GameTooltip = GameTooltip

local linktypes = {
    item = true, 
    enchant = true, 
    spell = true, 
    quest = true, 
    unit = true, 
    talent = true, 
    achievement = true, 
    glyph = true
}

local function OnHyperlinkEnter(frame, link, ...)
    local linktype = link:match('^([^:]+)')
    if (linktype and linktypes[linktype]) then
        GameTooltip:SetOwner(ChatFrame1, 'ANCHOR_CURSOR', 0, 20)
        GameTooltip:SetHyperlink(link)
        GameTooltip:Show()
    else
        GameTooltip:Hide()
    end

    if (orig1[frame]) then 
        return orig1[frame](frame, link, ...) 
    end
end

local function OnHyperlinkLeave(frame, ...)
    GameTooltip:Hide()

    if (orig2[frame]) then 
        return orig2[frame](frame, ...) 
    end
end

local function EnableItemLinkTooltip()
    for _, v in pairs(CHAT_FRAMES) do
        local chat = _G[v]
        if (chat and not chat.URLCopy) then
            orig1[chat] = chat:GetScript('OnHyperlinkEnter')
            chat:SetScript('OnHyperlinkEnter', OnHyperlinkEnter)

            orig2[chat] = chat:GetScript('OnHyperlinkLeave')
            chat:SetScript('OnHyperlinkLeave', OnHyperlinkLeave)
            chat.URLCopy = true
        end
    end
end
hooksecurefunc('FCF_OpenTemporaryWindow', EnableItemLinkTooltip)
EnableItemLinkTooltip()

for i = 3, NUM_CHAT_WINDOWS do
	local cf1 = _G['ChatFrame1']
	local cf2 = _G['ChatFrame2']
	local cf3 = _G['ChatFrame'..i]
	local bg1 = CreateFrame("Frame", nil, cf1);
	local bg2 = CreateFrame("Frame", nil, cf2);
	local bg3 = CreateFrame("Frame", nil, cf3);
	
	if cf1 then
		bg1:SetFrameStrata("BACKGROUND");
		bg1:SetPoint("TOPLEFT", -8, 8);
		bg1:SetPoint("BOTTOMRIGHT", 8, -8);
		bg1:SetBackdrop({
			edgeFile = 'Interface\\AddOns\\BasicUI\\BasicMedia\\UI-Tooltip-Border',
			edgeSize = 18,
		})
	end	
	
	if cf2 then
		bg2:SetFrameStrata("BACKGROUND");
		bg2:SetPoint("TOPLEFT", -8, 32);
		bg2:SetPoint("BOTTOMRIGHT", 8, -8);
		bg2:SetBackdrop({
			edgeFile = 'Interface\\AddOns\\BasicUI\\BasicMedia\\UI-Tooltip-Border',
			edgeSize = 18,
		})
	end
	
	if cf3 then
		bg3:SetFrameStrata("BACKGROUND");
		bg3:SetPoint("TOPLEFT", -8, 8);
		bg3:SetPoint("BOTTOMRIGHT", 8, -8);
		bg3:SetBackdrop({
			edgeFile = 'Interface\\AddOns\\BasicUI\\BasicMedia\\UI-Tooltip-Border',
			edgeSize = 18,
		})
	end		
end