local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['datatext'].enable ~= true then return end

if C['datatext'].micromenu and C['datatext'].micromenu > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].micromenu, Text)

	local function OnEvent(self, event, ...)
		Text:SetText(hexa..MAINMENU_BUTTON..hexb)
		self:SetAllPoints(Text)
	end

	local function OpenMenu()
		local menuFrame = CreateFrame("Frame", "DataTextMicroMenu", UIParent, "UIDropDownMenuTemplate")
		local menuList = {
			{text = CHARACTER_BUTTON,
			func = function() ToggleCharacter("PaperDollFrame") end},
			{text = SPELLBOOK_ABILITIES_BUTTON,
			func = function() ToggleFrame(SpellBookFrame) end},
			{text = TALENTS_BUTTON,
			func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end if not GlyphFrame then LoadAddOn("Blizzard_GlyphUI") end PlayerTalentFrame_Toggle() end},
			{text = ACHIEVEMENT_BUTTON,
			func = function() ToggleAchievementFrame() end},
			{text = QUESTLOG_BUTTON,
			func = function() ToggleFrame(QuestLogFrame) end},
			{text = SOCIAL_BUTTON,
			func = function() ToggleFriendsFrame(1) end},
			{text = PLAYER_V_PLAYER,
			func = function() ToggleFrame(PVPFrame) end},
			{text = ACHIEVEMENTS_GUILD_TAB,
			func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() end end},
			{text = LFG_TITLE,
			func = function() ToggleFrame(LFDParentFrame) end},
			{text = L_LFRAID,
			func = function() ToggleFrame(LFRParentFrame) end},
			{text = HELP_BUTTON,
			func = function() ToggleHelpFrame() end},
			{text = L_CALENDAR,
			func = function()
			if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
				Calendar_Toggle()
			end},
		}

		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	end

	Stat:RegisterEvent("PLAYER_LOGIN")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", function() OpenMenu() end)
end