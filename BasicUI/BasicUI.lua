local BasicUI = LibStub("AceAddon-3.0"):NewAddon("BasicUI")
local LSM = LibStub("LibSharedMedia-3.0")

local db
local defaults = {
	profile = {
		general = {
			fontNormal 		= "Friz Quadrata TT", 	 --[[Interface\Addons\BasicUI\Media\NORMAL.ttf]]
			fontBold 		= "Friz Quadrata TT", 		 --[[Interface\Addons\BasicUI\Media\BOLD.ttf]]
			fontItalic 		= "Friz Quadrata TT",		 --[[Interface\Addons\BasicUI\Media\ITALIC.ttf]]
			fontBoldItalic 	= "Friz Quadrata TT", --[[Interface\Addons\BasicUI\Media\BOLDITALIC.ttf]]
			fontNumber		= "Friz Quadrata TT",		 --[[Interface\Addons\BasicUI\Media\NUMBER.ttf]]
			fontSize 		= 15,
			classcolor = true,
			statusbar 		= "Blizzard",
			border 			= "Blizzard Tooltip",
			panelborder		= "BasicUI Border",
			background 		= "Blizzard Dialog Background Dark",
			sound			= "Whisper",
		},
		modules = {
			["*"] = true,
		}
	}
}
BasicUI.L = setmetatable({}, { __index = function(t,k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })

local L = BasicUI.L
BasicUI.media = {}

function BasicUI:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BasicDB", defaults, true) -- true is important!
	db = self.db.profile

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	local Dialog = LibStub("AceConfigDialog-3.0")

	local options = self:GetOptions()
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("BasicUI", options)
	Dialog:AddToBlizOptions("BasicUI", nil, nil, "general")

	local panels = {}
	for k, v in self:IterateModules() do
		if type(v.GetOptions) == "function" then
			options.args[k] = v:GetOptions()
			tinsert(panels, k)
		end
	end
	sort(panels)
	for i = 1, #panels do
		local k = panels[i]
		Dialog:AddToBlizOptions("BasicUI", options.args[k].name, "BasicUI", k)
	end

	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profile.order = -1
	Dialog:AddToBlizOptions("BasicUI", options.args.profile.name, "BasicUI", "profile")	
	
	self:UpdateMedia()
end

function BasicUI:OnEnable()
	-- set up stuff here
	
	db = self.db.profile
	
	SlashCmdList['RELOADUI'] = function()
		ReloadUI()
	end
	SLASH_RELOADUI1 = '/rl'	

	self:UpdateBlizzardFonts()
end


function BasicUI:UpdateMedia()
	
	-- Fonts
	self.media.fontNormal 		= LSM:Fetch("font", db.general.fontNormal)
	self.media.fontBold 		= LSM:Fetch("font", db.general.fontBold)
	self.media.fontItalic 		= LSM:Fetch("font", db.general.fontItalic)
	self.media.fontBoldItalic	= LSM:Fetch("font", db.general.fontBoldItalic)
	self.media.fontNumber 		= LSM:Fetch("font", db.general.fontNumber)
	
	-- Background
	self.media.background 		= LSM:Fetch("background", db.general.background)
	
	-- Borders
	self.media.border 			= LSM:Fetch("border", db.general.border)
	self.media.panelborder 		= LSM:Fetch("border", db.general.panelborder)
	
	-- Statusbar
	self.media.statusbar 		= LSM:Fetch("statusbar", db.general.statusbar)
	
	-- Sound
	self.media.sound			= LSM:Fetch("sound", db.general.sound)
end

function BasicUI:UpdateBlizzardFonts()

	local function SetFont(obj, font, size, style, r, g, b, sr, sg, sb, sox, soy)
		obj:SetFont(font, size, style)
		if sr and sg and sb then obj:SetShadowColor(sr, sg, sb) end
		if sox and soy then obj:SetShadowOffset(sox, soy) end
		if r and g and b then obj:SetTextColor(r, g, b)
		elseif r then obj:SetAlpha(r) end
	end	

	local NORMAL     = self.media.fontNormal
	local BOLD       = self.media.fontBold
	local BOLDITALIC = self.media.fontBoldItalic
	local ITALIC     = self.media.fontItalic
	local NUMBER     = self.media.fontNormal

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 15
	CHAT_FONT_HEIGHTS = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24}

	UNIT_NAME_FONT     = NORMAL
	DAMAGE_TEXT_FONT   = NUMBER
	STANDARD_TEXT_FONT = NORMAL

	-- Base fonts
	SetFont(AchievementFont_Small,                BOLD, 13)
	SetFont(FriendsFont_Large,                  NORMAL, db.general.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Normal,                 NORMAL, db.general.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_Small,                  NORMAL, 15, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(FriendsFont_UserText,               NUMBER, db.general.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(GameTooltipHeader,                    BOLD, db.general.fontSize, "OUTLINE")
	SetFont(GameFont_Gigantic,                    BOLD, 32, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(GameFontNormal,						NORMAL, db.general.fontSize)
	SetFont(GameFontNormalSmall,				NORMAL, 14)
	SetFont(GameFontHighlightSmall,				NORMAL, 14)
	SetFont(InvoiceFont_Med,                    ITALIC, db.general.fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(InvoiceFont_Small,                  ITALIC, 13, nil, 0.15, 0.09, 0.04)
	SetFont(MailFont_Large,                     ITALIC, db.general.fontSize, nil, 0.15, 0.09, 0.04, 0.54, 0.4, 0.1, 1, -1)
	SetFont(NumberFont_OutlineThick_Mono_Small, NUMBER, db.general.fontSize, "OUTLINE")
	SetFont(NumberFont_Outline_Huge,            NUMBER, 30, "THICKOUTLINE", 30)
	SetFont(NumberFont_Outline_Large,           NUMBER, 17, "OUTLINE")
	SetFont(NumberFont_Outline_Med,             NUMBER, db.general.fontSize, "OUTLINE")
	SetFont(NumberFont_Shadow_Med,              NORMAL, db.general.fontSize)
	SetFont(NumberFont_Shadow_Small,            NORMAL, 13)
	SetFont(QuestFont_Shadow_Small,             NORMAL, 13)
	SetFont(QuestFont_Large,                    NORMAL, 16)
	SetFont(QuestFont_Shadow_Huge,                BOLD, 19, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(QuestFont_Super_Huge,                 BOLD, 24)
	SetFont(ReputationDetailFont,                 BOLD, db.general.fontSize, nil, nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SpellFont_Small,                      BOLD, 13)
	SetFont(SystemFont_InverseShadow_Small,       BOLD, db.general.fontSize)
	SetFont(SystemFont_Large,                   NORMAL, 17)
	SetFont(SystemFont_Med1,                    NORMAL, 13)
	SetFont(SystemFont_Med2,                    ITALIC, db.general.fontSize, nil, 0.15, 0.09, 0.04)
	SetFont(SystemFont_Med3,                    NORMAL, db.general.fontSize)
	SetFont(SystemFont_OutlineThick_Huge2,      NORMAL, 22, "THICKOUTLINE")
	SetFont(SystemFont_OutlineThick_Huge4,  BOLDITALIC, 27, "THICKOUTLINE")
	SetFont(SystemFont_OutlineThick_WTF,    BOLDITALIC, 31, "THICKOUTLINE", nil, nil, nil, 0, 0, 0, 1, -1)
	SetFont(SystemFont_Outline_Small,           NUMBER, 13, "OUTLINE")
	SetFont(SystemFont_Shadow_Huge1,              BOLD, 20)
	SetFont(SystemFont_Shadow_Huge3,              BOLD, 25)
	SetFont(SystemFont_Shadow_Large,            NORMAL, 17)
	SetFont(SystemFont_Shadow_Med1,             NORMAL, 13)
	SetFont(SystemFont_Shadow_Med2,             NORMAL, db.general.fontSize)
	SetFont(SystemFont_Shadow_Med3,             NORMAL, 17)
	SetFont(SystemFont_Shadow_Outline_Huge2,    NORMAL, 22, "OUTLINE")
	SetFont(SystemFont_Shadow_Small,              BOLD, 15)
	SetFont(SystemFont_Small,                   NORMAL, 13)
	SetFont(SystemFont_Tiny,                    NORMAL, 12)
	SetFont(ChatBubbleFont,						NORMAL, db.general.fontSize)
	

	-- Derived fonts
	SetFont(BossEmoteNormalHuge,     BOLDITALIC, 27, "THICKOUTLINE")
	SetFont(CombatTextFont,              NORMAL, 26)
	SetFont(ErrorFont,                   ITALIC, 16, nil, 60)
	SetFont(QuestFontNormalSmall,          BOLD, db.general.fontSize, nil, nil, nil, nil, 0.54, 0.4, 0.1)
	SetFont(WorldMapTextFont,        BOLDITALIC, 31, "THICKOUTLINE",  40, nil, nil, 0, 0, 0, 1, -1)	
	
end

function BasicUI:Refresh()
	db = self.db.profile -- update the upvalue to point to the new profile

	-- change stuff here

	for k, v in self:IterateModules() do
		local isEnabled, shouldEnable = v:IsEnabled(), self:GetModuleEnabled(k)
		if shouldEnable and not isEnabled then
			self:EnableModule(k)
		elseif isEnabled and not shouldEnable then
			self:DisableModule(k)
		end
		if type(v.Refresh) == "function" then
			v:Refresh()
		end
	end
	
	self:UpdateMedia()
	self:UpdateBlizzardFonts()
end

function BasicUI:GetModuleEnabled(moduleName)
	return db.modules[moduleName]
end

function BasicUI:SetModuleEnabled(moduleName, newState)
	local oldState = db.modules[moduleName]
	if oldState == newState then return end
	if newState then
		self:EnableModule(moduleName)
	else
		self:DisableModule(moduleName)
	end
end

local options
function BasicUI:GetOptions()
	options = options or {
		type = "group",
		name = "BasicUI",
		args = {
			general = { -- @PHANX: moved all the "welcome" text into a group, you'll see why later
				type = "group",
				order = 1,
				name = "Media",
				get = function(info) return db.general[ info[#info] ] end,
				set = function(info, value) db.general[ info[#info] ] = value;   end,					
				args = {
					Text = {
						type = "description",
						order = 0,
						name = L["Welcome to |cff00B4FFBasic|rUI Config Area!"],
						width = "full",
						fontSize = "large",
					},
					Text2 = {
						type = "description",
						order = 1,
						name = L[" "],
						width = "full",
					},
					Text3 = {
						type = "description",
						order = 2,
						name = L["Special Thanks for |cff00B4FFBasic|rUI goes out to: "],
						width = "full",
						fontSize = "medium",
					},
					Text4 = {
						type = "description",
						order = 3,
						name = L["Phanx, Neav, Tuks, Elv, Baine, Treeston, and many more."],
						width = "full",
						fontSize = "large",
					},
					Text5 = {
						type = "description",
						order = 4,
						name = L[" "],
						width = "full",
						fontSize = "medium",
					},
					Text6 = {
						type = "description",
						order = 5,
						name = L["Thank you all for your AddOns, coding help, and support in creating |cff00B4FFBasic|rUI."],
						width = "full",
						fontSize = "medium",
					},
					Text7 = {
						type = "description",
						order = 6,
						name = L[" "],
						width = "full",
						fontSize = "medium",
					},					
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 7,
						func = 	function()
							ReloadUI()
						end,
					},
					Text8 = {
						type = "description",
						order = 8,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text9 = {
						type = "description",
						order = 9,
						name = " ",
						width = "full",
					},
					classcolor = {
						type = "toggle",					
						order = 10,
						name = L["Class Color"],
						desc = L["Use your classcolor for border and some text color."],
					},
					Text11 = {
						type = "description",
						order = 11,
						name = " ",
						width = "full",
					},						
					fontSize = {
						type = "range",
						order = 11,						
						name = L["Game Font Size"],
						desc = L["Controls the Size of the Game Font"],
						min = 0,
						max = 30,
						step = 1,
					},
					Text12 = {
						type = "description",
						order = 12,
						name = " ",
						width = "full",
					},					
					fontNormal = {
						type = 'select',
						order = 12,						
						name = L["BasicUI Normal Font"],
						dialogControl = 'LSM30_Font', --Select your widget here						
						values = AceGUIWidgetLSMlists.font,	
					},
					fontBold = {
						type = 'select',
						order = 12,						
						name = L["BasicUI Bold Font"],
						dialogControl = 'LSM30_Font', --Select your widget here						
						values = AceGUIWidgetLSMlists.font,	
					},
					fontItalic = {
						type = 'select',
						order = 12,						
						name = L["BasicUI Italic Font"],
						dialogControl = 'LSM30_Font', --Select your widget here						
						values = AceGUIWidgetLSMlists.font,	
					},
					fontBoldItalic = {
						type = 'select',
						order = 12,						
						name = L["BasicUI Bold Italic Font"],
						dialogControl = 'LSM30_Font', --Select your widget here						
						values = AceGUIWidgetLSMlists.font,	
					},
					fontNumber = {
						type = 'select',
						order = 12,						
						name = L["BasicUI Number Font"],
						dialogControl = 'LSM30_Font', --Select your widget here						
						values = AceGUIWidgetLSMlists.font,
					},
					Text13 = {
						type = "description",
						order = 13,
						name = " ",
						width = "full",
					},
					background = {
						type = 'select',
						order = 13,						
						name = L["BasicUI Background"],
						width = "normal",
						dialogControl = 'LSM30_Background', --Select your widget here						
						values = AceGUIWidgetLSMlists.background,							
					},					
					border = {
						type = 'select',
						order = 13,						
						name = L["BasicUI Border"],
						dialogControl = 'LSM30_Border', --Select your widget here						
						values = AceGUIWidgetLSMlists.border,
					},					
					panelborder = {
						type = 'select',
						order = 13,						
						name = L["BasicUI Datapanel Border"],
						dialogControl = 'LSM30_Border', --Select your widget here						
						values = AceGUIWidgetLSMlists.border,
					},
					Text14 = {
						type = "description",
						order = 14,
						name = " ",
						width = "full",
					},					
					statusbar = {
						type = 'select',
						order = 14,						
						name = L["BasicUI Statusbar"],
						dialogControl = 'LSM30_Statusbar', --Select your widget here						
						values = AceGUIWidgetLSMlists.statusbar,
					},
					Text15 = {
						type = "description",
						order = 15,
						name = " ",
						width = "full",
					},
					sound = {
						type = 'select',
						order = 15,						
						name = L["BasicUI Sound"],
						dialogControl = 'LSM30_Sound', --Select your widget here						
						values = AceGUIWidgetLSMlists.sound,
					},
				},
			},			
		}
	}
	return options
end