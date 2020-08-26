-- saved variables
BASICFONT = BASICFONT or {}

BASICFONT["N"] = [[Interface\AddOns\BasicUI\Media\Expressway_Free_NORMAL.ttf]]	or "WoW Default"
BASICFONT["B"] = [[Interface\AddOns\BasicUI\Media\Expressway_Rg_BOLD.ttf]]	 	or "WoW Default"
BASICFONT["I"] = [[Interface\AddOns\BasicUI\Media\Expressway_Sb_ITALIC.ttf]] 	or "WoW Default"

----- Begin code taken by "http://www.wowinterface.com/downloads/info8786-tekticles.html"
-- by Tekkub: http://www.tekkub.net/addons

local function SetFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b)
	elseif r then obj:SetAlpha(r) end
end


UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 14
CHAT_FONT_HEIGHTS = {12, 13, 14, 15, 16, 17}

local FONTZ = false -- Set to true only if you have not changed your master fonts.

if FONTZ == true then
	UNIT_NAME_FONT     			= BASICFONT["N"]
	DAMAGE_TEXT_FONT   			= BASICFONT["N"]
	STANDARD_TEXT_FONT			= BASICFONT["N"]
	NAMEPLATE_SPELLCAST_FONT    = BASICFONT["N"]
end


-- Font Normally Used FRIZQT__.TTF
SetFont(SystemFont_Tiny,                	BASICFONT["N"], 11);
SetFont(SystemFont_Small,                	BASICFONT["N"], 13);
SetFont(SystemFont_Outline_Small,           BASICFONT["N"], 13, "OUTLINE");
SetFont(SystemFont_Outline,                	BASICFONT["N"], 15);					-- Pet level on World map
SetFont(SystemFont_Shadow_Small,            BASICFONT["N"], 13);
SetFont(SystemFont_InverseShadow_Small,		BASICFONT["N"], 13);
SetFont(SystemFont_Med1,                	BASICFONT["N"], 15);
SetFont(SystemFont_Shadow_Med1,             BASICFONT["N"], 15);
SetFont(SystemFont_Med2,                	BASICFONT["N"], 15, nil, 0.15, 0.09, 0.04);
SetFont(SystemFont_Shadow_Med2,             BASICFONT["N"], 15);
SetFont(SystemFont_Med3,                	BASICFONT["N"], 15);
SetFont(SystemFont_Shadow_Med3,             BASICFONT["N"], 15);
SetFont(SystemFont_Large,                	BASICFONT["B"], 	17);
SetFont(SystemFont_Shadow_Large,            BASICFONT["B"], 	17);
SetFont(SystemFont_Huge1,                	BASICFONT["B"], 	20);
SetFont(SystemFont_Shadow_Huge1,            BASICFONT["B"], 	20);
SetFont(SystemFont_OutlineThick_Huge2,      BASICFONT["B"], 	22, "THICKOUTLINE");
SetFont(SystemFont_Shadow_Outline_Huge2,    BASICFONT["B"], 	22, "OUTLINE");
SetFont(SystemFont_Shadow_Huge3,            BASICFONT["B"], 	25);
SetFont(SystemFont_OutlineThick_Huge4,      BASICFONT["B"], 	26, "THICKOUTLINE");
SetFont(SystemFont_OutlineThick_WTF,        BASICFONT["B"], 	32, "THICKOUTLINE");	-- World Map
SetFont(SubZoneTextFont,					BASICFONT["B"], 	26, "OUTLINE");			-- World Map(SubZone)
SetFont(GameTooltipHeader,                	BASICFONT["B"], 	18);
SetFont(SpellFont_Small,                	BASICFONT["N"], 13);
SetFont(InvoiceFont_Med,                	BASICFONT["N"], 15, nil, 0.15, 0.09, 0.04);
SetFont(InvoiceFont_Small,                	BASICFONT["N"], 13, nil, 0.15, 0.09, 0.04);
SetFont(Tooltip_Med,                		BASICFONT["N"], 15);
SetFont(Tooltip_Small,                		BASICFONT["N"], 13);
SetFont(AchievementFont_Small,              BASICFONT["N"], 13);
SetFont(ReputationDetailFont,               BASICFONT["N"], 12, nil, nil, nil, nil, 0, 0, 0, 1, -1);
SetFont(GameFont_Gigantic,                	BASICFONT["B"], 	32, nil, nil, nil, nil, 0, 0, 0, 1, -1);

-- Font Normally Used ARIALN.TTF
SetFont(NumberFont_Shadow_Small,			BASICFONT["B"], 13);
SetFont(NumberFont_OutlineThick_Mono_Small,	BASICFONT["B"], 13, "OUTLINE");
SetFont(NumberFont_Shadow_Med,              BASICFONT["B"], 15);
SetFont(NumberFont_Outline_Med,             BASICFONT["B"], 15, "OUTLINE");
SetFont(NumberFont_Outline_Large,           BASICFONT["B"], 17, "OUTLINE");
SetFont(NumberFont_GameNormal,				BASICFONT["B"], 13);
SetFont(FriendsFont_UserText,               BASICFONT["B"], 15);

-- Font Normally Used skurri.ttf
SetFont(NumberFont_Outline_Huge,            BASICFONT["B"], 30, "THICKOUTLINE");

-- Font Normally Used MORPHEUS.ttf
SetFont(QuestFont_Large,                	BASICFONT["I"], 17)
SetFont(QuestFont_Shadow_Huge,              BASICFONT["I"], 18, nil, nil, nil, nil, 0.54, 0.4, 0.1);
SetFont(QuestFont_Shadow_Small,             BASICFONT["I"], 13)
SetFont(MailFont_Large,                		BASICFONT["I"], 17, nil, 0.15, 0.09, 0.04, 0.54, 0.4, 0.1, 1, -1);

-- Font Normally Used FRIENDS.TTF
SetFont(FriendsFont_Normal,                	BASICFONT["N"], 15, nil, nil, nil, nil, 0, 0, 0, 1, -1);
SetFont(FriendsFont_Small,                	BASICFONT["N"], 13, nil, nil, nil, nil, 0, 0, 0, 1, -1);
SetFont(FriendsFont_Large,                	BASICFONT["B"], 	17, nil, nil, nil, nil, 0, 0, 0, 1, -1);


SetFont(GameFontNormalSmall,                BASICFONT["B"], 	13);
SetFont(GameFontNormal,                		BASICFONT["N"], 15);
SetFont(GameFontNormalLarge,                BASICFONT["B"], 	17);
SetFont(GameFontNormalHuge,                	BASICFONT["B"], 	20);
SetFont(GameFontHighlightSmallLeft,			BASICFONT["N"], 15);
SetFont(GameNormalNumberFont,               BASICFONT["B"], 	13);



for i=1,7 do
	local f = _G["ChatFrame"..i]
	local font, size = f:GetFont()
	f:SetFont(BASICFONT["N"], size)
end

--[[ I have no idea why the channel list is getting fucked up
-- but re-setting the font obj seems to fix it
for i=1,20 do
	local f = _G["ChannelButton"..i.."Text"]
	f:SetFontObject(GameFontNormalSmallLeft)
	-- function f:SetFont(...) error("Attempt to set font on ChannelButton"..i) end
end]]

--for _,butt in pairs(PaperDollTitlesPane.buttons) do butt.text:SetFontObject(GameFontHighlightSmallLeft) end