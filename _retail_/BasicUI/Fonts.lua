-- saved variables
BASICFONT = BASICFONT or {}

BASICFONT["N"] = [[Interface\AddOns\BasicUI\Media\Expressway_Free_NORMAL.ttf]]	or "WoW Default"
BASICFONT["B"] = [[Interface\AddOns\BasicUI\Media\Expressway_Rg_BOLD.ttf]]	 	or "WoW Default"
BASICFONT["I"] = [[Interface\AddOns\BasicUI\Media\Expressway_Sb_ITALIC.ttf]] 	or "WoW Default"

----- Begin code taken by "http://www.wowinterface.com/downloads/info8786-tekticles.html"
-- by Tekkub: http://www.tekkub.net/addons



--[[local function SetFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b)
	elseif r then obj:SetAlpha(r) end
end]]


--UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 14
--CHAT_FONT_HEIGHTS = {12, 13, 14, 15, 16, 17}

local FONTZ = false -- Set to true only if you have not changed your master fonts.

if FONTZ == true then
	UNIT_NAME_FONT     			= BASICFONT["N"]
	DAMAGE_TEXT_FONT   			= BASICFONT["N"]
	STANDARD_TEXT_FONT			= BASICFONT["N"]
	NAMEPLATE_SPELLCAST_FONT    = BASICFONT["N"]
end


-- Font Normally Used FRIZQT__.TTF
SystemFont_Tiny:SetFont(					BASICFONT["N"], 11);
SystemFont_Small:SetFont(					BASICFONT["N"], 13);
SystemFont_Outline_Small:SetFont(			BASICFONT["N"], 13, "OUTLINE");
SystemFont_Outline:SetFont(					BASICFONT["N"], 15);					-- Pet level on World map
SystemFont_Shadow_Small:SetFont(			BASICFONT["N"], 13);
SystemFont_InverseShadow_Small:SetFont(		BASICFONT["N"], 13);
SystemFont_Med1:SetFont(					BASICFONT["N"], 15);
SystemFont_Shadow_Med1:SetFont(             BASICFONT["N"], 15);
SystemFont_Med2:SetFont(                	BASICFONT["N"], 15, nil, 0.15, 0.09, 0.04);
SystemFont_Shadow_Med2:SetFont(             BASICFONT["N"], 15);
SystemFont_Med3:SetFont(                	BASICFONT["N"], 15);
SystemFont_Shadow_Med3:SetFont(             BASICFONT["N"], 15);
SystemFont_Large:SetFont(                	BASICFONT["B"], 17);
SystemFont_Shadow_Large:SetFont(            BASICFONT["B"], 17);
SystemFont_Huge1:SetFont(                	BASICFONT["B"], 20);
SystemFont_Shadow_Huge1:SetFont(            BASICFONT["B"], 20);
SystemFont_OutlineThick_Huge2:SetFont(      BASICFONT["B"], 22, "THICKOUTLINE");
--SystemFont_Shadow_Outline_Huge2:SetFont(    BASICFONT["B"], 22, "OUTLINE");
SystemFont_Shadow_Huge3:SetFont(            BASICFONT["B"], 25);
SystemFont_OutlineThick_Huge4:SetFont(      BASICFONT["B"], 26, "THICKOUTLINE");
SystemFont_OutlineThick_WTF:SetFont(        BASICFONT["B"], 32, "THICKOUTLINE");	-- World Map
SubZoneTextFont:SetFont(					BASICFONT["B"], 26, "OUTLINE");			-- World Map(SubZone)
GameTooltipHeader:SetFont(                	BASICFONT["B"], 18);
SpellFont_Small:SetFont(                	BASICFONT["N"], 13);
InvoiceFont_Med:SetFont(                	BASICFONT["N"], 15, nil, 0.15, 0.09, 0.04);
InvoiceFont_Small:SetFont(                	BASICFONT["N"], 13, nil, 0.15, 0.09, 0.04);
Tooltip_Med:SetFont(                		BASICFONT["N"], 15);
Tooltip_Small:SetFont(                		BASICFONT["N"], 13);
AchievementFont_Small:SetFont(              BASICFONT["N"], 13);
ReputationDetailFont:SetFont(               BASICFONT["N"], 12, nil, nil, nil, nil, 0, 0, 0, 1, -1);
GameFont_Gigantic:SetFont(                	BASICFONT["B"], 	32, nil, nil, nil, nil, 0, 0, 0, 1, -1);

-- Font Normally Used ARIALN.TTF
NumberFont_Shadow_Small:SetFont(			BASICFONT["B"], 13);
NumberFont_OutlineThick_Mono_Small:SetFont(	BASICFONT["B"], 13, "OUTLINE");
NumberFont_Shadow_Med:SetFont(              BASICFONT["B"], 15);
NumberFont_Outline_Med:SetFont(             BASICFONT["B"], 15, "OUTLINE");
NumberFont_Outline_Large:SetFont(           BASICFONT["B"], 17, "OUTLINE");
NumberFont_GameNormal:SetFont(				BASICFONT["B"], 13);
FriendsFont_UserText:SetFont(               BASICFONT["B"], 15);

-- Font Normally Used skurri.ttf
NumberFont_Outline_Huge:SetFont(            BASICFONT["B"], 30, "THICKOUTLINE");

-- Font Normally Used MORPHEUS.ttf
QuestFont_Large:SetFont(                	BASICFONT["I"], 17)
QuestFont_Shadow_Huge:SetFont(              BASICFONT["I"], 18, nil, nil, nil, nil, 0.54, 0.4, 0.1);
QuestFont_Shadow_Small:SetFont(             BASICFONT["I"], 13)
MailFont_Large:SetFont(                		BASICFONT["I"], 17, nil, 0.15, 0.09, 0.04, 0.54, 0.4, 0.1, 1, -1);

-- Font Normally Used FRIENDS.TTF
FriendsFont_Normal:SetFont(                	BASICFONT["N"], 15, nil, nil, nil, nil, 0, 0, 0, 1, -1);
FriendsFont_Small:SetFont(                	BASICFONT["N"], 13, nil, nil, nil, nil, 0, 0, 0, 1, -1);
FriendsFont_Large:SetFont(                	BASICFONT["B"], 17, nil, nil, nil, nil, 0, 0, 0, 1, -1);


GameFontNormalSmall:SetFont(                BASICFONT["B"], 	13);
GameFontNormal:SetFont(                		BASICFONT["N"], 15);
GameFontNormalLarge:SetFont(                BASICFONT["B"], 	17);
GameFontNormalHuge:SetFont(                	BASICFONT["B"], 	20);
GameFontHighlightSmallLeft:SetFont(			BASICFONT["N"], 15);
GameNormalNumberFont:SetFont(               BASICFONT["B"], 	13);



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

for _,butt in pairs(PaperDollTitlesPane.buttons) do butt.text:SetFontObject(GameFontHighlightSmallLeft) end