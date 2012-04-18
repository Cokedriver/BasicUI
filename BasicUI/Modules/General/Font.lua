local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database


-- Extra Small Font
for _, font in pairs({
	
	GameFontHighlightExtraSmall,
	
}) do
    font:SetFont(C['media'].font, C['media'].fontxSmall)
end

-- Achievment Frame Text
for _, font in pairs({

    AchievementPointsFont,
    AchievementPointsFontSmall,
    AchievementDescriptionFont,
    AchievementCriteriaFont,
    AchievementDateFont,
	
}) do
    font:SetFont(C['media'].font, C['media'].fontSmall)
	--font:SetShadowOffset(2, -1)
end

-- Game Small Text
for _, font in pairs({

	
	GameFontNormalSmall,
	NumberFontSmall,
    GameFontDisableSmall,
    GameFontHighlightSmall,		
	SystemFont_Shadow_Med1,
	TextStatusBarText,
	
}) do
    font:SetFont(C['media'].font, C['media'].fontSmall, 'THINOUTLINE')
	--font:SetShadowOffset(2, -1)
end

-- Game Medium Text
for _, font in pairs({

	GameFontNormal,
	GameFontDisable,
    GameFontHighlightMedium,
	NumberFontNormal,
	GameTooltipText,
	
	
}) do
    font:SetFont(C['media'].font, C['media'].fontMedium, 'THINOUTLINE')
    --font:SetShadowOffset(2, -1)
end
 
-- Game Large Text
for _, font in pairs({

	GameFontHighlight,
	GameFontNormalLarge,
	GameTooltipHeaderText,
	
}) do
    font:SetFont(C['media'].font, C['media'].fontLarge)
    --font:SetShadowOffset(2, -1)
end 

-- Game Huge Text
for _, font in pairs({

	GameFontNormalHuge,
	
}) do
    font:SetFont(C['media'].font, C['media'].fontHuge)
    --font:SetShadowOffset(2, -1)
end 