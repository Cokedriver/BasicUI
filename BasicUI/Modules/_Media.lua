local MODULE_NAME = "Media"
local ADDON_NAME = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = ADDON_NAME:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = setmetatable({}, { __index = function(t,k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		fontNormal = 		[[Interface\Addons\BasicUI\Media\NORMAL.ttf]],
		fontBold = 			[[Interface\Addons\BasicUI\Media\BOLD.ttf]],
		fontItalic = 		[[Interface\Addons\BasicUI\Media\ITALIC.ttf]],
		fontBoldItalic = 	[[Interface\Addons\BasicUI\Media\BOLDITALIC.ttf]],
		fontNumber = 		[[Interface\Addons\BasicUI\Media\NUMBER.ttf]],
		fontSize = 15,
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

local classColor

local function SetFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
	obj:SetFont(font, size, style)
	if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
	if sox and soy then obj:SetShadowOffset(sox, soy) end
	if r and g and b then obj:SetTextColor(r, g, b)
	elseif r then obj:SetAlpha(r) end
end	

function MODULE:OnInitialize()
	
	self.db = ADDON_NAME.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(ADDON_NAME:GetModuleEnabled(MODULE_NAME))
end

function MODULE:OnEnable()

	local db = self.db.profile

	if db.enable ~= true then return end
	
	local NORMAL     = db.fontNormal
	local BOLD       = db.fontBold
	local BOLDITALIC = db.fontBoldItalic
	local ITALIC     = db.fontItalic
	local NUMBER     = db.fontNormal

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 15
	CHAT_FONT_HEIGHTS = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24}

	UNIT_NAME_FONT     = NORMAL
	DAMAGE_TEXT_FONT   = NUMBER
	STANDARD_TEXT_FONT = NORMAL

	-- Base fonts
	SetFont(AchievementFont_Small,                BOLD, db.fontSize)
	SetFont(FriendsFont_Large,                  NORMAL, db.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Normal,                 NORMAL, db.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Small,                  NORMAL, db.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_UserText,               NUMBER, db.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(GameTooltipHeader,                    BOLD, db.fontSize, "OUTLINE")
	SetFont(GameFont_Gigantic,                    BOLD, 32, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(InvoiceFont_Med,                    ITALIC, db.fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(InvoiceFont_Small,                  ITALIC, db.fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(MailFont_Large,                     ITALIC, db.fontSize, nil, 0.15, 0.09, 0.04, 0.54, 0.4, 0.1, 1, -1)
	SetFont(NumberFont_OutlineThick_Mono_Small, NUMBER, db.fontSize, "OUTLINE")
	SetFont(NumberFont_Outline_Huge,            NUMBER, 30, "THICKOUTLINE", 30)
	SetFont(NumberFont_Outline_Large,           NUMBER, 17, "OUTLINE")
	SetFont(NumberFont_Outline_Med,             NUMBER, db.fontSize, "OUTLINE")
	SetFont(NumberFont_Shadow_Med,              NORMAL, db.fontSize)
	SetFont(NumberFont_Shadow_Small,            NORMAL, db.fontSize)
	SetFont(QuestFont_Shadow_Small,             NORMAL, 16)
	SetFont(QuestFont_Large,                    NORMAL, 16)
	SetFont(QuestFont_Shadow_Huge,                BOLD, 19, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(QuestFont_Super_Huge,                 BOLD, 24)
	SetFont(ReputationDetailFont,                 BOLD, db.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SpellFont_Small,                      BOLD, db.fontSize)
	SetFont(SystemFont_InverseShadow_Small,       BOLD, db.fontSize)
	SetFont(SystemFont_Large,                   NORMAL, 17)
	SetFont(SystemFont_Med1,                    NORMAL, db.fontSize)
	SetFont(SystemFont_Med2,                    ITALIC, db.fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(SystemFont_Med3,                    NORMAL, db.fontSize)
	SetFont(SystemFont_OutlineThick_Huge2,      NORMAL, 22, "THICKOUTLINE")
	SetFont(SystemFont_OutlineThick_Huge4,  BOLDITALIC, 27, "THICKOUTLINE")
	SetFont(SystemFont_OutlineThick_WTF,    BOLDITALIC, 31, "THICKOUTLINE", nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SystemFont_Outline_Small,           NUMBER, db.fontSize, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge1,              BOLD, 20)
	SetFont(SystemFont_Shadow_Huge3,              BOLD, 25)
	SetFont(SystemFont_Shadow_Large,            NORMAL, 17)
	SetFont(SystemFont_Shadow_Med1,             NORMAL, db.fontSize)
	SetFont(SystemFont_Shadow_Med2,             NORMAL, db.fontSize)
	SetFont(SystemFont_Shadow_Med3,             NORMAL, db.fontSize)
	SetFont(SystemFont_Shadow_Outline_Huge2,    NORMAL, 22, "OUTLINE")
	SetFont(SystemFont_Shadow_Small,              BOLD, db.fontSize)
	SetFont(SystemFont_Small,                   NORMAL, db.fontSize)
	SetFont(SystemFont_Tiny,                    NORMAL, db.fontSize)
	SetFont(ChatBubbleFont,						NORMAL, db.fontSize)
	

	-- Derived fonts
	SetFont(BossEmoteNormalHuge,     BOLDITALIC, 27, "THICKOUTLINE")
	SetFont(CombatTextFont,              NORMAL, 26)
	SetFont(ErrorFont,                   ITALIC, 16, nil, 60)
	SetFont(QuestFontNormalSmall,          BOLD, db.fontSize, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(WorldMapTextFont,        BOLDITALIC, 31, "THICKOUTLINE",  40, nil, nil, 0, 0, 0, 1, -1)
end



------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

local options
function MODULE:GetOptions()
	if options then
		return options
	end

	local function isModuleDisabled()
		return not ADDON_NAME:GetModuleEnabled(MODULE_NAME)
	end

	options = {
		type = "group",
		name = L[MODULE_NAME],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value end,
		disabled = isModuleDisabled,
		args = {
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				desc = L["Enable the Media Module."],
				width = "full",
				disabled = false,
			},		
			--[[fontNormal = {
				type = 'select',
				order = 1,						
				name = L["|cff00B4FFBasic|rUI Normal Font"],
				desc = L["The font that the core of the UI will use"],
				dialogControl = 'LSM30_Font', --Select your widget here						
				values = AceGUIWidgetLSMlists.font,	
			},
			fontBold = {
				type = 'select',
				order = 2,						
				name = L["|cff00B4FFBasic|rUI Bold Font"],
				desc = L["The font that the core of the UI will use"],
				dialogControl = 'LSM30_Font', --Select your widget here						
				values = AceGUIWidgetLSMlists.font,	
			},
			fontItalic = {
				type = 'select',
				order = 3,						
				name = L["|cff00B4FFBasic|rUI Italic Font"],
				desc = L["The font that the core of the UI will use"],
				dialogControl = 'LSM30_Font', --Select your widget here						
				values = AceGUIWidgetLSMlists.font,	
			},
			fontBoldItalic = {
				type = 'select',
				order = 2,						
				name = L["|cff00B4FFBasic|rUI Bold Italic Font"],
				desc = L["The font that the core of the UI will use"],
				dialogControl = 'LSM30_Font', --Select your widget here						
				values = AceGUIWidgetLSMlists.font,	
			},
			fontNumber = {
				type = 'select',
				order = 4,						
				name = L["|cff00B4FFBasic|rUI Number Font"],
				desc = L["The font that the core of the UI will use"],
				dialogControl = 'LSM30_Font', --Select your widget here						
				values = AceGUIWidgetLSMlists.font,	
			},]]
			fontSize = {
				type = "range",
				order = 5,						
				name = L["Game Font Size"],
				desc = L["Controls the Size of the Game Font"],
				min = 0, max = 30, step = 1,
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		}
	}
	return options
end