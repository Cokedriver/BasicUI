local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

--[[

	All Create for fonts.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.
	
]]

--[[
    -- A list of all fonts

    'GameFontNormal',
    'GameFontHighlight',
    'GameFontDisable',
    'GameFontNormalSmall',
    'GameFontHighlightExtraSmall',
    'GameFontHighlightMedium',
    'GameFontNormalLarge',
    'GameFontNormalHuge',

    'BossEmoteNormalHuge',

    'NumberFontNormal',
    'NumberFontNormalSmall',
    'NumberFontNormalLarge',
    'NumberFontNormalHuge',

    'ChatFontNormal',
    'ChatFontSmall',

    'QuestTitleFont',
    'QuestFont',
    'QuestFontNormalSmall',
    'QuestFontHighlight',

    'ItemTextFontNormal',
    'MailTextFontNormal',
    'SubSpellFont',
    'DialogButtonNormalText',
    'ZoneTextFont',
    'SubZoneTextFont',
    'PVPInfoTextFont',
    'ErrorFont',
    'TextStatusBarText',
    'CombatLogFont',

    'GameTooltipText',
    'GameTooltipTextSmall',
    'GameTooltipHeaderText',

    'WorldMapTextFont',

    'InvoiceTextFontNormal',
    'InvoiceTextFontSmall',
    'CombatTextFont',
    'MovieSubtitleFont',

    'AchievementPointsFont',
    'AchievementPointsFontSmall',
    'AchievementDescriptionFont',
    'AchievementCriteriaFont',
    'AchievementDateFont',
    'ReputationDetailFont',
--]]

for _, font in pairs({
    GameFontHighlight,

    GameFontDisable,

    GameFontHighlightExtraSmall,
    GameFontHighlightMedium,

    GameFontNormal,
    GameFontNormalSmall,

    --TextStatusBarText,

    GameFontDisableSmall,
    GameFontHighlightSmall,
	
	GameTooltipText,
}) do
    font:SetFont('Fonts\\ARIALN.ttf', 14)
    font:SetShadowOffset(2, -1)
end
 
TextStatusBarText:SetFont('Fonts\\ARIALN.ttf', 11, 'outline')
GameTooltipHeaderText:SetFont('Fonts\\ARIALN.ttf', 16)

for _, font in pairs({
    AchievementPointsFont,
    AchievementPointsFontSmall,
    AchievementDescriptionFont,
    AchievementCriteriaFont,
    AchievementDateFont,
	
}) do
    font:SetFont('Fonts\\ARIALN.ttf', 12)
end

GameFontNormalHuge:SetFont('Fonts\\ARIALN.ttf', 20, 'OUTLINE')
GameFontNormalHuge:SetShadowOffset(0, 0)