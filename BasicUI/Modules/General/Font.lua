local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

-- Font Setup
local function SetFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b)
	elseif r then obj:SetAlpha(r) end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function()
	local NORMAL     = C['media'].font
	local BOLD       = C['media'].font
	local BOLDITALIC = C['media'].font
	local ITALIC     = C['media'].font
	local NUMBER     = C['media'].font

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 15
	CHAT_FONT_HEIGHTS = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24}

	UNIT_NAME_FONT     = NORMAL
	DAMAGE_TEXT_FONT   = NUMBER
	STANDARD_TEXT_FONT = NORMAL

	-- Base fonts
	SetFont(AchievementFont_Small,                BOLD, C['media'].fontSize)
	SetFont(FriendsFont_Large,                  NORMAL, C['media'].fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Normal,                 NORMAL, C['media'].fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Small,                  NORMAL, C['media'].fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_UserText,               NUMBER, C['media'].fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(GameTooltipHeader,                    BOLD, C['media'].fontSize, "OUTLINE")
	SetFont(GameFont_Gigantic,                    BOLD, 32, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(InvoiceFont_Med,                    ITALIC, C['media'].fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(InvoiceFont_Small,                  ITALIC, C['media'].fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(MailFont_Large,                     ITALIC, C['media'].fontSize, nil, 0.15, 0.09, 0.04, 0.54, 0.4, 0.1, 1, -1)
	SetFont(NumberFont_OutlineThick_Mono_Small, NUMBER, C['media'].fontSize, "OUTLINE")
	SetFont(NumberFont_Outline_Huge,            NUMBER, 30, "THICKOUTLINE", 30)
	SetFont(NumberFont_Outline_Large,           NUMBER, 17, "OUTLINE")
	SetFont(NumberFont_Outline_Med,             NUMBER, C['media'].fontSize, "OUTLINE")
	SetFont(NumberFont_Shadow_Med,              NORMAL, C['media'].fontSize)
	SetFont(NumberFont_Shadow_Small,            NORMAL, C['media'].fontSize)
	SetFont(QuestFont_Shadow_Small,             NORMAL, 16)
	SetFont(QuestFont_Large,                    NORMAL, 16)
	SetFont(QuestFont_Shadow_Huge,                BOLD, 19, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(QuestFont_Super_Huge,                 BOLD, 24)
	SetFont(ReputationDetailFont,                 BOLD, C['media'].fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SpellFont_Small,                      BOLD, C['media'].fontSize)
	SetFont(SystemFont_InverseShadow_Small,       BOLD, C['media'].fontSize)
	SetFont(SystemFont_Large,                   NORMAL, 17)
	SetFont(SystemFont_Med1,                    NORMAL, C['media'].fontSize)
	SetFont(SystemFont_Med2,                    ITALIC, C['media'].fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(SystemFont_Med3,                    NORMAL, C['media'].fontSize)
	SetFont(SystemFont_OutlineThick_Huge2,      NORMAL, 22, "THICKOUTLINE")
	SetFont(SystemFont_OutlineThick_Huge4,  BOLDITALIC, 27, "THICKOUTLINE")
	SetFont(SystemFont_OutlineThick_WTF,    BOLDITALIC, 31, "THICKOUTLINE", nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SystemFont_Outline_Small,           NUMBER, C['media'].fontSize, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge1,              BOLD, 20)
	SetFont(SystemFont_Shadow_Huge3,              BOLD, 25)
	SetFont(SystemFont_Shadow_Large,            NORMAL, 17)
	SetFont(SystemFont_Shadow_Med1,             NORMAL, C['media'].fontSize)
	SetFont(SystemFont_Shadow_Med2,             NORMAL, C['media'].fontSize)
	SetFont(SystemFont_Shadow_Med3,             NORMAL, C['media'].fontSize)
	SetFont(SystemFont_Shadow_Outline_Huge2,    NORMAL, 22, "OUTLINE")
	SetFont(SystemFont_Shadow_Small,              BOLD, C['media'].fontSize)
	SetFont(SystemFont_Small,                   NORMAL, C['media'].fontSize)
	SetFont(SystemFont_Tiny,                    NORMAL, C['media'].fontSize)
	SetFont(Tooltip_Med,                        NORMAL, C['media'].fontSize)
	SetFont(Tooltip_Small,                        BOLD, C['media'].fontSize)
	SetFont(ChatBubbleFont,						NORMAL, C['media'].fontSize)

	-- Derived fonts
	SetFont(BossEmoteNormalHuge,     BOLDITALIC, 27, "THICKOUTLINE")
	SetFont(CombatTextFont,              NORMAL, 26)
	SetFont(ErrorFont,                   ITALIC, 16, nil, 60)
	SetFont(QuestFontNormalSmall,          BOLD, C['media'].fontSize, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(WorldMapTextFont,        BOLDITALIC, 31, "THICKOUTLINE",  40, nil, nil, 0, 0, 0, 1, -1)

	for i=1,7 do
		local f = _G["ChatFrame"..i]
		local font, size = f:GetFont()
		f:SetFont(NORMAL, size)
	end

	-- I have no idea why the channel list is getting fucked up
	-- but re-setting the font obj seems to fix it
	for i=1,MAX_CHANNEL_BUTTONS do
		local f = _G["ChannelButton"..i.."Text"]
		f:SetFontObject(GameFontNormalSmallLeft)
		-- function f:SetFont(...) error("Attempt to set font on ChannelButton"..i) end
	end

	for _,butt in pairs(PaperDollTitlesPane.buttons) do butt.text:SetFontObject(GameFontHighlightSmallLeft) end
end)

--[[	
local NORMAL     = C['media'].font
local COMBAT     = C['media'].font
local NUMBER     = C['media'].font
local _, editBoxFontSize, _, _, _, _, _, _, _, _ = GetChatWindowInfo(1)

UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
CHAT_FONT_HEIGHTS = {12, 13, 14, 15, 16, 17, 18, 19, 20}

UNIT_NAME_FONT     = NORMAL
NAMEPLATE_FONT     = NORMAL
DAMAGE_TEXT_FONT   = COMBAT
STANDARD_TEXT_FONT = NORMAL


-- Base fonts
SetFont(GameTooltipHeader,                  NORMAL, C['media'].fontSize)
SetFont(NumberFont_OutlineThick_Mono_Small, NUMBER, C['media'].fontSize, "OUTLINE")
SetFont(NumberFont_Outline_Huge,            NUMBER, 28, "THICKOUTLINE", 28)
SetFont(NumberFont_Outline_Large,           NUMBER, 15, "OUTLINE")
SetFont(NumberFont_Outline_Med,             NUMBER, C['media'].fontSize*1.1, "OUTLINE")
SetFont(NumberFont_Shadow_Med,              NORMAL, C['media'].fontSize) --chat editbox uses this
SetFont(NumberFont_Shadow_Small,            NORMAL, C['media'].fontSize)
SetFont(QuestFont,                          NORMAL, C['media'].fontSize)
SetFont(QuestFont_Large,                    NORMAL, 14)
SetFont(SystemFont_Large,                   NORMAL, 15)
SetFont(SystemFont_Shadow_Huge1,			NORMAL, 20, "OUTLINE") -- Raid Warning, Boss emote frame too
SetFont(SystemFont_Med1,                    NORMAL, C['media'].fontSize)
SetFont(SystemFont_Med3,                    NORMAL, C['media'].fontSize*1.1)
SetFont(SystemFont_OutlineThick_Huge2,      NORMAL, 20, "THICKOUTLINE")
SetFont(SystemFont_Outline_Small,           NUMBER, C['media'].fontSize, "OUTLINE")
SetFont(SystemFont_Shadow_Large,            NORMAL, 15)
SetFont(SystemFont_Shadow_Med1,             NORMAL, C['media'].fontSize)
SetFont(SystemFont_Shadow_Med3,             NORMAL, C['media'].fontSize*1.1)
SetFont(SystemFont_Shadow_Outline_Huge2,    NORMAL, 20, "OUTLINE")
SetFont(SystemFont_Shadow_Small,            NORMAL, C['media'].fontSize*0.9)
SetFont(SystemFont_Small,                   NORMAL, C['media'].fontSize)
SetFont(SystemFont_Tiny,                    NORMAL, C['media'].fontSize)
SetFont(Tooltip_Med,                        NORMAL, C['media'].fontSize)
SetFont(Tooltip_Small,                      NORMAL, C['media'].fontSize)
SetFont(ZoneTextString,						NORMAL, 32, "OUTLINE")
SetFont(SubZoneTextString,					NORMAL, 25, "OUTLINE")
SetFont(PVPInfoTextString,					NORMAL, 22, "OUTLINE")
SetFont(PVPArenaTextString,					NORMAL, 22, "OUTLINE")
SetFont(CombatTextFont,                     COMBAT, 100, "OUTLINE") -- number here just increase the font quality.
]]