local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

-- Font Setup
local function SetFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b)
	elseif r then obj:SetAlpha(r) end
end

	
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
SetFont(GameTooltipHeader,                  NORMAL, C['media'].fontsize)
SetFont(NumberFont_OutlineThick_Mono_Small, NUMBER, C['media'].fontsize, "OUTLINE")
SetFont(NumberFont_Outline_Huge,            NUMBER, 28, "THICKOUTLINE", 28)
SetFont(NumberFont_Outline_Large,           NUMBER, 15, "OUTLINE")
SetFont(NumberFont_Outline_Med,             NUMBER, C['media'].fontsize*1.1, "OUTLINE")
SetFont(NumberFont_Shadow_Med,              NORMAL, C['media'].fontsize) --chat editbox uses this
SetFont(NumberFont_Shadow_Small,            NORMAL, C['media'].fontsize)
SetFont(QuestFont,                          NORMAL, C['media'].fontsize)
SetFont(QuestFont_Large,                    NORMAL, 14)
SetFont(SystemFont_Large,                   NORMAL, 15)
SetFont(SystemFont_Shadow_Huge1,			NORMAL, 20, "OUTLINE") -- Raid Warning, Boss emote frame too
SetFont(SystemFont_Med1,                    NORMAL, C['media'].fontsize)
SetFont(SystemFont_Med3,                    NORMAL, C['media'].fontsize*1.1)
SetFont(SystemFont_OutlineThick_Huge2,      NORMAL, 20, "THICKOUTLINE")
SetFont(SystemFont_Outline_Small,           NUMBER, C['media'].fontsize, "OUTLINE")
SetFont(SystemFont_Shadow_Large,            NORMAL, 15)
SetFont(SystemFont_Shadow_Med1,             NORMAL, C['media'].fontsize)
SetFont(SystemFont_Shadow_Med3,             NORMAL, C['media'].fontsize*1.1)
SetFont(SystemFont_Shadow_Outline_Huge2,    NORMAL, 20, "OUTLINE")
SetFont(SystemFont_Shadow_Small,            NORMAL, C['media'].fontsize*0.9)
SetFont(SystemFont_Small,                   NORMAL, C['media'].fontsize)
SetFont(SystemFont_Tiny,                    NORMAL, C['media'].fontsize)
SetFont(Tooltip_Med,                        NORMAL, C['media'].fontsize)
SetFont(Tooltip_Small,                      NORMAL, C['media'].fontsize)
SetFont(ZoneTextString,						NORMAL, 32, "OUTLINE")
SetFont(SubZoneTextString,					NORMAL, 25, "OUTLINE")
SetFont(PVPInfoTextString,					NORMAL, 22, "OUTLINE")
SetFont(PVPArenaTextString,					NORMAL, 22, "OUTLINE")
SetFont(CombatTextFont,                     COMBAT, 100, "OUTLINE") -- number here just increase the font quality.