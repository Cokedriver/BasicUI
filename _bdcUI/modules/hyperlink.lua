local DB, L = unpack(select(2, ...)) -- Import: DB - config; L - locales

if DB.chat.enableHyperlinkTooltip ~= true then return end

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
