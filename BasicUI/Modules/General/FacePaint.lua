local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['general'].facepaint.enable ~= true then return end

------------------------------------------------------------
--	FacePaint ~ paints the default interface (w/<3) ~ by Aprikot
------------------------------------------------------------
	
-- Load TimeManager (to color the clock button later)
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
end
	
--	Objects to paint
--------------------
local objects = {
		-- Rune Bar
		RuneButtonIndividual1:GetRegions(),
		RuneButtonIndividual1Border:GetRegions(),	
		RuneButtonIndividual2:GetRegions(),
		RuneButtonIndividual2Border:GetRegions(),
		RuneButtonIndividual3:GetRegions(),
		RuneButtonIndividual3Border:GetRegions(),
		RuneButtonIndividual4:GetRegions(),
		RuneButtonIndividual4Border:GetRegions(),
		RuneButtonIndividual5:GetRegions(),
		RuneButtonIndividual5Border:GetRegions(),
		RuneButtonIndividual6:GetRegions(),
		RuneButtonIndividual6Border:GetRegions(),

		-- Unit frames
		PlayerFrameTexture,
		TargetFrameTextureFrameTexture,
		FocusFrameTextureFrameTexture,
		TargetFrameToTTextureFrameTexture,
		FocusFrameToTTextureFrameTexture,
		PetFrameTexture,
		select(2, PlayerFrameAlternateManaBar:GetRegions()),
		
		-- Party Frame
		PartyMemberFrame1Texture,
		PartyMemberFrame2Texture,
		PartyMemberFrame3Texture,
		PartyMemberFrame4Texture,
		
		-- Party Pet Frames
		PartyMemberFrame1PetFrameTexture,
		PartyMemberFrame2PetFrameTexture,
		PartyMemberFrame3PetFrameTexture,
		PartyMemberFrame4PetFrameTexture,
		
		-- Raid Frame
		CompactRaidFrameContainerBorderFrameBorderBottom,
		CompactRaidFrameContainerBorderFrameBorderBottomLeft,
		CompactRaidFrameContainerBorderFrameBorderBottomRight,
		CompactRaidFrameContainerBorderFrameBorderLeft,
		CompactRaidFrameContainerBorderFrameBorderRight,
		CompactRaidFrameContainerBorderFrameBorderTop,
		CompactRaidFrameContainerBorderFrameBorderTopLeft,
		CompactRaidFrameContainerBorderFrameBorderTopRight,
		
		-- Raid Frame Manager
		CompactRaidFrameManagerToggleButton:GetRegions(),
		CompactRaidFrameManagerBg,
		CompactRaidFrameManagerBorderBottom,
		CompactRaidFrameManagerBorderBottomLeft,
		CompactRaidFrameManagerBorderBottomRight,
		CompactRaidFrameManagerBorderRight,
		CompactRaidFrameManagerBorderTopLeft,
		CompactRaidFrameManagerBorderTopRight,
		CompactRaidFrameManagerBorderTop,
		
		-- Minimap
		MinimapBackdrop,
		MinimapBorder,
		MiniMapMailBorder,
		MiniMapTrackingButtonBorder,
		MinimapBorderTop,
		MinimapZoneTextButton,
		MiniMapWorldMapButton,
		MiniMapWorldMapButton,
		MiniMapWorldIcon,
		MinimapZoomIn:GetRegions(),
		select(3, MinimapZoomIn:GetRegions()),
		MinimapZoomOut:GetRegions(),
		select(3, MinimapZoomOut:GetRegions()),
		TimeManagerClockButton:GetRegions(),
		MiniMapWorldMapButton:GetRegions(),
		select(6, GameTimeFrame:GetRegions()),
		
		-- Action bars
		ReputationWatchBarTexture0,
		ReputationWatchBarTexture1,
		ReputationWatchBarTexture2,
		ReputationWatchBarTexture3,
		ReputationXPBarTexture0,
		ReputationXPBarTexture1,
		ReputationXPBarTexture2,
		ReputationXPBarTexture3,
		MainMenuBarTexture0,
		MainMenuBarTexture1,
		MainMenuBarTexture2,
		MainMenuBarTexture3,
		MainMenuMaxLevelBar0,
		MainMenuMaxLevelBar1,
		MainMenuMaxLevelBar2,
		MainMenuMaxLevelBar3,
		MainMenuXPBarTextureRightCap,
		MainMenuXPBarTextureMid,
		MainMenuXPBarTextureLeftCap,
		ActionBarUpButton:GetRegions(),
		ActionBarDownButton:GetRegions(),
		BonusActionBarFrame:GetRegions(),	
		select(2, BonusActionBarFrame:GetRegions()),
		
		-- Exp bubble dividers
		MainMenuXPBarDiv1,
		MainMenuXPBarDiv2,
		MainMenuXPBarDiv3,
		MainMenuXPBarDiv4,
		MainMenuXPBarDiv5,
		MainMenuXPBarDiv6,
		MainMenuXPBarDiv7,
		MainMenuXPBarDiv8,
		MainMenuXPBarDiv9,
		MainMenuXPBarDiv10,
		MainMenuXPBarDiv11,
		MainMenuXPBarDiv12,
		MainMenuXPBarDiv13,
		MainMenuXPBarDiv14,
		MainMenuXPBarDiv15,
		MainMenuXPBarDiv16,
		MainMenuXPBarDiv17,
		MainMenuXPBarDiv18,
		MainMenuXPBarDiv19,

		
		-- Chat frame buttons
		select(2, FriendsMicroButton:GetRegions()),
		ChatFrameMenuButton:GetRegions(),
		ChatFrame1ButtonFrameUpButton:GetRegions(),
		ChatFrame1ButtonFrameDownButton:GetRegions(),
		select(2, ChatFrame1ButtonFrameBottomButton:GetRegions()),
		ChatFrame2ButtonFrameUpButton:GetRegions(),
		ChatFrame2ButtonFrameDownButton:GetRegions(),
		select(2, ChatFrame2ButtonFrameBottomButton:GetRegions()),
		
		-- Chat edit box
		select(6, ChatFrame1EditBox:GetRegions()),
		select(7, ChatFrame1EditBox:GetRegions()),
		select(8, ChatFrame1EditBox:GetRegions()),
		select(5, ChatFrame1EditBox:GetRegions()),
		
		-- Micro menu buttons
		select(2, SpellbookMicroButton:GetRegions()),
		select(3, CharacterMicroButton:GetRegions()),
		select(2, TalentMicroButton:GetRegions()),
		select(2, AchievementMicroButton:GetRegions()),
		select(2, QuestLogMicroButton:GetRegions()),
		select(2, GuildMicroButton:GetRegions()),
		select(3, PVPMicroButton:GetRegions()),
		select(2, LFDMicroButton:GetRegions()),
		select(4, MainMenuMicroButton:GetRegions()),
		select(2, HelpMicroButton:GetRegions()),
		
		-- Other
		CalendarFrameBorder,
		select(2, CastingBarFrame:GetRegions()),
		select(2, MirrorTimer1:GetRegions()),
		select(3,TargetFrameSpellBar:GetRegions()),
		select(3,FocusFrameSpellBar:GetRegions()),
}



--	Paint function
	--------------
local paint = function(object)
	object:SetDesaturated(1)		
		if C['general'].facepaint.custom.gradient then
			object:SetGradientAlpha("VERTICAL", C['general'].facepaint.custom.bottomcolor.r, C['general'].facepaint.custom.bottomcolor.g, C['general'].facepaint.custom.bottomcolor.b, C['general'].facepaint.custom.bottomalpha, C['general'].facepaint.custom.topcolor.r, C['general'].facepaint.custom.topcolor.g, C['general'].facepaint.custom.topcolor.b, C['general'].facepaint.custom.topalpha)
		else
			if C['general'].classcolor then
				object:SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
			else		
				object:SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
			end
		end
end

--[[for i = 0, 5 do
	for _, object in pairs({
	 
		-- Actionbars
		_G['MainMenuMaxLevelBar'..i],
		_G['MainMenuXPBar'..i],
		_G['ReputationWatchBarTexture'..i],
		_G['ReputationXPBarTexture'..i],
		_G['MainMenuBarTexture'..i],
		
		-- Party Pet Frame
		_G['PartyMemberFrame'..i..'PetFrameTexture'],
		_G['PartyMemberFrame'..i..'Texture'],
	}) do
		if C['general'].facepaint.custom.gradient then
			object:SetGradientAlpha("VERTICAL", C['general'].facepaint.custom.bottomcolor.r, C['general'].facepaint.custom.bottomcolor.g, C['general'].facepaint.custom.bottomcolor.b, C['general'].facepaint.custom.bottomalpha, C['general'].facepaint.custom.topcolor.r, C['general'].facepaint.custom.topcolor.g, C['general'].facepaint.custom.topcolor.b, C['general'].facepaint.custom.topalpha)
		else
			if C['general'].classcolor then
				object:SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
			else		
				object:SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
			end
		end
	end
end]]

--	Execute!
------------
local exec = function()
	for i,v in pairs(objects) do
		if v:GetObjectType() == "Texture" then
			paint(v)
		end
	end
end
exec()

--	Miscellaneous
-------------
-- Calendar button text
--select(5, GameTimeFrame:GetRegions()):SetVertexColor(1, 1, 1)

-- Desaturation fix for elite target texture (thanks SDPhantom!)
hooksecurefunc("TargetFrame_CheckClassification", function(self)
	self.borderTexture:SetDesaturated(1);
end);
	
-- Opposing horizontal gradients for the gryphons <3
if C['general'].facepaint.custom.gradient then
	MainMenuBarLeftEndCap:SetGradientAlpha("HORIZONTAL", C['general'].facepaint.custom.bottomcolor.r, C['general'].facepaint.custom.bottomcolor.g, C['general'].facepaint.custom.bottomcolor.b, bottomalpha, C['general'].facepaint.custom.topcolor.r, C['general'].facepaint.custom.topcolor.g, C['general'].facepaint.custom.topcolor.b, topalpha)
	MainMenuBarRightEndCap:SetGradientAlpha("HORIZONTAL", C['general'].facepaint.custom.topcolor.r, C['general'].facepaint.custom.topcolor.g, C['general'].facepaint.custom.topcolor.b, topalpha, C['general'].facepaint.custom.bottomcolor.r, C['general'].facepaint.custom.bottomcolor.g, C['general'].facepaint.custom.bottomcolor.b, bottomalpha)
else
	if C['general'].classcolor then
		MainMenuBarLeftEndCap:SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
		MainMenuBarRightEndCap:SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
	else
		MainMenuBarLeftEndCap:SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
		MainMenuBarRightEndCap:SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
	end
end
	
-- Game tooltip
--TOOLTIP_DEFAULT_COLOR = { r = C['general'].facepaint.custom.topcolor.r * 0.5, g = C['general'].facepaint.custom.topcolor.g * 0.5, b = C['general'].facepaint.custom.topcolor.b * 0.5 };
--TOOLTIP_DEFAULT_BACKGROUND_COLOR = { r = C['general'].facepaint.custom.bottomcolor.r * 0.2, g = C['general'].facepaint.custom.bottomcolor.g * 0.2, b = C['general'].facepaint.custom.bottomcolor.b * 0.2};

-- ShardBar via SetVertexColor per SetGradientAlpha fail
if C['general'].classcolor then
	select(5,ShardBarFrameShard1:GetRegions()):SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
	select(5,ShardBarFrameShard2:GetRegions()):SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
	select(5,ShardBarFrameShard3:GetRegions()):SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
else
	select(5,ShardBarFrameShard1:GetRegions()):SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
	select(5,ShardBarFrameShard2:GetRegions()):SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
	select(5,ShardBarFrameShard3:GetRegions()):SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
end