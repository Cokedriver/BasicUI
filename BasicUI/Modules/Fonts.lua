local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Fonts = BasicUI:NewModule("Fonts", "AceEvent-3.0")

----------
-- Font --
----------
function BasicUI_Fonts:OnEnable()
	local db = BasicUI.db.profile
	
	-- Credit Game Font goes to Elv for his ElvUI project.
	-- You can find his Addon at http://tukui.org/dl.php
	-- Editied by Cokedriver

	
	local function SetFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
		obj:SetFont(font, size, style)
		if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
		if sox and soy then obj:SetShadowOffset(sox, soy) end
		if r and g and b then obj:SetTextColor(r, g, b)
		elseif r then obj:SetAlpha(r) end
	end	

	local NORMAL     = db.media.fontNormal
	local BOLD       = db.media.fontBold
	local BOLDITALIC = db.media.fontBoldItalic
	local ITALIC     = db.media.fontItalic
	local NUMBER     = db.media.fontNormal

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 15
	CHAT_FONT_HEIGHTS = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24}

	UNIT_NAME_FONT     = NORMAL
	DAMAGE_TEXT_FONT   = NUMBER
	STANDARD_TEXT_FONT = NORMAL

	-- Base fonts
	SetFont(AchievementFont_Small,                BOLD, db.media.fontSize)
	SetFont(FriendsFont_Large,                  NORMAL, db.media.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Normal,                 NORMAL, db.media.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Small,                  NORMAL, db.media.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_UserText,               NUMBER, db.media.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(GameTooltipHeader,                    BOLD, db.media.fontSize, "OUTLINE")
	SetFont(GameFont_Gigantic,                    BOLD, 32, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(InvoiceFont_Med,                    ITALIC, db.media.fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(InvoiceFont_Small,                  ITALIC, db.media.fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(MailFont_Large,                     ITALIC, db.media.fontSize, nil, 0.15, 0.09, 0.04, 0.54, 0.4, 0.1, 1, -1)
	SetFont(NumberFont_OutlineThick_Mono_Small, NUMBER, db.media.fontSize, "OUTLINE")
	SetFont(NumberFont_Outline_Huge,            NUMBER, 30, "THICKOUTLINE", 30)
	SetFont(NumberFont_Outline_Large,           NUMBER, 17, "OUTLINE")
	SetFont(NumberFont_Outline_Med,             NUMBER, db.media.fontSize, "OUTLINE")
	SetFont(NumberFont_Shadow_Med,              NORMAL, db.media.fontSize)
	SetFont(NumberFont_Shadow_Small,            NORMAL, db.media.fontSize)
	SetFont(QuestFont_Shadow_Small,             NORMAL, 16)
	SetFont(QuestFont_Large,                    NORMAL, 16)
	SetFont(QuestFont_Shadow_Huge,                BOLD, 19, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(QuestFont_Super_Huge,                 BOLD, 24)
	SetFont(ReputationDetailFont,                 BOLD, db.media.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SpellFont_Small,                      BOLD, db.media.fontSize)
	SetFont(SystemFont_InverseShadow_Small,       BOLD, db.media.fontSize)
	SetFont(SystemFont_Large,                   NORMAL, 17)
	SetFont(SystemFont_Med1,                    NORMAL, db.media.fontSize)
	SetFont(SystemFont_Med2,                    ITALIC, db.media.fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(SystemFont_Med3,                    NORMAL, db.media.fontSize)
	SetFont(SystemFont_OutlineThick_Huge2,      NORMAL, 22, "THICKOUTLINE")
	SetFont(SystemFont_OutlineThick_Huge4,  BOLDITALIC, 27, "THICKOUTLINE")
	SetFont(SystemFont_OutlineThick_WTF,    BOLDITALIC, 31, "THICKOUTLINE", nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SystemFont_Outline_Small,           NUMBER, db.media.fontSize, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge1,              BOLD, 20)
	SetFont(SystemFont_Shadow_Huge3,              BOLD, 25)
	SetFont(SystemFont_Shadow_Large,            NORMAL, 17)
	SetFont(SystemFont_Shadow_Med1,             NORMAL, db.media.fontSize)
	SetFont(SystemFont_Shadow_Med2,             NORMAL, db.media.fontSize)
	SetFont(SystemFont_Shadow_Med3,             NORMAL, db.media.fontSize)
	SetFont(SystemFont_Shadow_Outline_Huge2,    NORMAL, 22, "OUTLINE")
	SetFont(SystemFont_Shadow_Small,              BOLD, db.media.fontSize)
	SetFont(SystemFont_Small,                   NORMAL, db.media.fontSize)
	SetFont(SystemFont_Tiny,                    NORMAL, db.media.fontSize)
	SetFont(ChatBubbleFont,						NORMAL, db.media.fontSize)
	

	-- Derived fonts
	SetFont(BossEmoteNormalHuge,     BOLDITALIC, 27, "THICKOUTLINE")
	SetFont(CombatTextFont,              NORMAL, 26)
	SetFont(ErrorFont,                   ITALIC, 16, nil, 60)
	SetFont(QuestFontNormalSmall,          BOLD, db.media.fontSize, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(WorldMapTextFont,        BOLDITALIC, 31, "THICKOUTLINE",  40, nil, nil, 0, 0, 0, 1, -1)
	
end