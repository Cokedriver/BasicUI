local BasicUI = LibStub("AceAddon-3.0"):NewAddon("BasicUI")

-- Media --
local BASIC_BORDER = [[Interface\Tooltips\UI-Tooltip-Border]]
local BASIC_BACKGROUND = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]]
local BASIC_STATUSBAR = [[Interface\TargetingFrame\UI-StatusBar]]
local BASIC_BORDERPANEL = [[Interface\AddOns\BasicUI\Media\UI-DialogBox-Border.blp]]

SlashCmdList['RELOADUI'] = function()
	ReloadUI()
end
SLASH_RELOADUI1 = '/rl'
	
local defaults = {

    profile = {
	
		ModuleEnabledState = {
			["*"] = true
		},

		media = {
			fontNormal = 		[[Interface\Addons\BasicUI\Media\NORMAL.ttf]],
			fontBold = 			[[Interface\Addons\BasicUI\Media\BOLD.ttf]],
			fontItalic = 		[[Interface\Addons\BasicUI\Media\ITALIC.ttf]],
			fontBoldItalic = 	[[Interface\Addons\BasicUI\Media\BOLDITALIC.ttf]],
			fontNumber = 		[[Interface\Addons\BasicUI\Media\NUMBER.ttf]],
			fontSize = 15,
		},
		
		misc = {
			classcolor = true,
			flashmapnodes = true,
			cooldown = true,
			quicky = true,
			vellum = true,
		},
		
		actionbar = {
			enable = true,
			showHotKeys = false,		-- Set the Alpha 
			showMacronames = false,		-- Set the Alpha 
			auraborder = false,
			
			-- Button Colors
			color = { 
				enable = true,
				OutOfRange = { r = 0.9, g = 0, b = 0 },
				OutOfMana = { r = 0, g = 0, b = 0.9 },			
				NotUsable = { r = 0.3, g = 0.3, b = 0.3 },
			},
		},
		
		buff = {
			enable = true,
			scale = 1.19,
		},
		
		castbar = {	
			enable = true,
			border = BASIC_BORDER,
			background = BASIC_BACKGROUND,
			statusbar = BASIC_STATUSBAR,
			

			CastingBarFrame = {
				enable = true,
				fontSize = 18,
				textPosition = "CENTER",
				enableLag = true,
				enableTimer = true,
				selfAnchor = "BOTTOM",
				relAnchor = "BOTTOM",
				offSetX = 0,
				offSetY	= 175,
			},
			TargetFrameSpellBar = {
				enable = false,
				fontSize = 18,
				textPosition = "CENTER",
				enableLag = true,
				enableTimer = true,
				selfAnchor = "TOP",
				relAnchor = "TOP",
				offSetX	= 0,
				offSetY	= -250,
			},
			FocusFrameSpellBar = {
				enable = true,
				fontSize = 18,
				textPosition = "CENTER",
				enableLag = true,
				enableTimer = true,
				selfAnchor = "TOP",
				relAnchor = "TOP",
				offSetX	= 0,
				offSetY	= -165,
			},
			MirrorTimer1 = {
				enable = true,
				fontSize = 18,
				enableTimer = true,
				selfAnchor = "TOP",
				relAnchor = "TOP",
				offSetX	= 0,
				offSetY	= -75,
			},
			PetCastingBarFrame = {
				enable = true,
				fontSize = 18,
				textPosition = "CENTER",
				enableTimer = true,
				selfAnchor = "BOTTOM",
				relAnchor = "BOTTOM",
				offSetX	= 0,
				offSetY	= 200,
			},
		},		
		chat = {
			enable = true,
			disableFade = false,
			chatOutline = false,
			windowborder = false,
			enableborder = false,
			
			-- Chat Media
			border = BASIC_BORDER,
			background = BASIC_BACKGROUND,
			editboxborder = BASIC_BORDER,
			editboxbackground = BASIC_BACKGROUND,
			sound = [[Interface\Addons\BasicUI\Media\Whisper.mp3]],
			
			enableBottomButton = true, 
			enableHyperlinkTooltip = true, 
			enableBorderColoring = true,

			tab = {
				fontSize = 15,
				fontOutline = true, 
				normalColor = {r = 1, g = 1, b = 1},
				specialColor = {r = 1, g = 0, b = 1},
				selectedColor = {r = 0, g = 0.75, b = 1},
			},		
		},	
		datapanel = {
			
			enable = true,
			enablepanel = true,
			battleground = true,                            	-- enable 3 stats in battleground only that replace stat1,stat2,stat3.
			bag = false,										-- True = Open Backpack; False = Open All bags			

			-- nData Media
			border = BASIC_BORDERPANEL,							-- Border for Datapanel ( Choose either Datapanel or Neav for border choice)
			background = BASIC_BACKGROUND,						-- Background for Datapanel	
			
			-- Color Datatext	
			customcolor = { r = 1, g = 1, b = 1},				-- Color of Text for Datapanel
			
			panel = "bottom",									-- 3 Choices for panel placement = "top", "bottom", or "shortbar". Shortbar is to match nMainbar shortbar.
			armor = 0,                                     		-- show your armor value against the level mob you are currently targeting.
			avd = 0,                                        	-- show your current avoidance against the level of the mob your targeting	
			bags = 9,                                       	-- show space used in bags on panel.
			haste = 0,                                      	-- show your haste rating on panels.	
			system = 0,                                     	-- show total memory and others systems info (FPS/MS) on panel.	
			guild = 4,                                      	-- show number on guildmate connected on panel.
			dur = 8,                                        	-- show your equipment durability on panel.
			friends = 6,                                    	-- show number of friends connected.
			dps_text = 0,                                   	-- show a dps meter on panel.
			hps_text = 0,                                   	-- show a heal meter on panel.
			spec = 5,											-- show your current spec on panel.
			coords = 0,											-- show your current coords on panel.
			pro = 7,											-- shows your professions and tradeskills
			stat1 = 1,											-- Stat Based on your Role (Avoidance-Tank, AP-Melee, SP/HP-Caster)
			stat2 = 3,											-- Stat Based on your Role (Armor-Tank, Crit-Melee, Crit-Caster)
			recount = 2,										-- Stat Based on Recount"s DPS
			recountraiddps = false,								-- Enables tracking or Recounts Raid DPS
			calltoarms = 0,										-- Show Current Call to Arms.
			
		},
		-- Merchant Options
		merchant = {
			enable = true,
			sellMisc = true, 		-- allows the user to add spacific items to sell at merchant (please see the local filter in merchant.lua)
			autoSellGrey = true,	-- autosell grey items at merchant.
			autoRepair = true,		-- autorepair at merchant.
			gpay = false,			-- let your guild pay for your repairs if they allow.
			disenchant = true,		-- Disenchant Green Item's on Roll
		},
		minimap = {
			enable = true,
			gameclock = true,
			farm = false,
			farmscale = 1.5,
			coords = true,
		},	
		nameplates = {
			enable = true,
			enableTankMode = true,              -- Color the nameplate threat border green, if you have no aggro
			colorNameWithThreat = true,         -- The name has the same color as the threat of the unit (better visibility)

			showFullHP = true,
			showLevel = true,
			showTargetBorder = true,
			showEliteBorder = true,
			showTotemIcon = true,
			abbrevLongNames = true,
		},
		powerbar = {
			enable = true,
			background = BASIC_BACKGROUND,
			statusbar = BASIC_STATUSBAR,	
			position = {
				selfAnchor = "CENTER",
				frameParent = "UIParent",
				offSetX = 0,
				offSetY = -100
			},
			sizeWidth = 200,
			
			showCombatRegen = true, 

			activeAlpha = 1,
			inactiveAlpha = 0.5,
			emptyAlpha = 0,
			
			valueAbbrev = true,
				
			valueFontSize = 20,
			valueFontOutline = true,
			valueFontAdjustmentX = 0,

			showSoulshards = true,
			showHolypower = true,
			showMana = true,
			showFocus = true,
			showRage = true,
			
			extraFontSize = 16,                             -- The fontsize for the holypower and soulshard number
			extraFontOutline = true,                        
				
			
			energy = {
				show = true,
				showComboPoints = true,
				comboPointsBelow = false,
				
				comboFontSize = 16,
				comboFontOutline = true,
			},
			
			
			rune = {
				show = true,
				showRuneCooldown = true,
			   
				runeFontSize = 16,
				runeFontOutline = true,
			},
		},		
		-- Quest Options
		quest = {
			enable = true,			-- enable quest module.
			tekvendor = true,		-- Tek's best quest item by vendor price.			
			autocomplete = false,	-- enable the autoaccept quest and autocomplete quest if no reward.
		},
		skin = {
			enable = true,
			border = BASIC_BORDER,
			statusbar = BASIC_STATUSBAR,
			DBM = true,
			Recount = true,
			RecountBackdrop = true,
		},		
		-- Tooltip
		tooltip = {
			enable = true,
			fontSize = 15,
			fontOutline = true,
			disableFade = false,                     		-- Can cause errors or a buggy tooltip!
			abbrevRealmNames = true, 	
			border = BASIC_BORDER,
			background = BASIC_BACKGROUND,
			statusbar = BASIC_STATUSBAR,
			hideInCombat = false,                       -- Hide unit frame tooltips during combat	
			hideRealmText = true,                      -- Hide the coalesced/interactive realm text	
			reactionBorderColor = true,
			itemqualityBorderColor = true,
			
			showPlayerTitles = true,
			showPVPIcons = false,                        	-- Show pvp icons instead of just a prefix
			showMouseoverTarget = true,
			showOnMouseover = false,
			showUnitRole = true,
			showItemLevel = true,
			showSpecializationIcon = false,
			
			healthbar = {
				showHealthValue = true,
				showOutline = true,
				healthFormat = '$cur / $max',           -- Possible: $cur, $max, $deficit, $perc, $smartperc, $smartcolorperc, $colorperc
				healthFullFormat = '$cur',              -- if the tooltip unit has 100% hp 		
				textPos = "CENTER",                     -- Possible "TOP" "BOTTOM" "CENTER"	
				reactionColoring = false,
				custom = {
					apply = false,
					color =	{ r = 1, g = 1, b = 0},
				},		
				fontSize = 15,
			},		
		},
		
		-- Unitframes
		unitframes = {
			enable = true,
			abbrevRealmNames = true,
			player = {
				enable = true,			-- Enable Player Frame Adjustments
				scale = 1.15,			-- Player Frame Scale
				fontSize = 13,			-- Stausbar Font Size
				fontSizepet = 10,			-- Stausbar Font Size
			},
			target = {
				enable = true,			-- Enable Target Frame Adjustments
				scale = 1.15,			-- Target Frame Scale
				fontSize = 13,			-- Stausbar Font Size
			},
			focus = {
				enable = true,			-- Enable Focus Frame Adjustments
				scale = 1.15,			-- Focus Frame Scale
				fontSize = 13,			-- Stausbar Font Size
			},
			party = {
				enable = true,
				scale = 1.15,
				fontSize = 11,			-- Stausbar Font Size
				position = {
					relAnchor = "TOPLEFT",
					offSetX = 10,		-- Controls the X offset. (Left - Right)
					offSetY = -150,		-- Controls the Y offset. (Up - Down)
				},
			},
			arena = {
				enable = true,
				scale = 1.5,
				fontSize = 11,			-- Stausbar Font Size
				tracker = true,
			},
			boss = {
				enable = true,
				scale = 1.15,
				fontSize = 13,			-- Stausbar Font Size	
				position = {
					relAnchor = "TOPRIGHT",
					offSetX = -50,		-- Controls the X offset. (Left - Right)
					offSetY = -250,		-- Controls the Y offset. (Up - Down)
				},
			},
		},
	},
}

function BasicUI:OnInitialize()
	-- Assuming the .toc says ## SavedVariables: MyAddonDB
	self.db = LibStub("AceDB-3.0"):New("BasicDB", defaults, true)
	
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	
	for name, module in self:IterateModules() do
		module:SetEnabledState(self.db.profile.ModuleEnabledState[name] or false)
	end
	
	self:SetUpOptions();
	self:Greeting()
	
	self.OnInitialize = nil
end

function BasicUI:OnProfileChanged(event, database, newProfileKey)
	for name, module in self:IterateModules() do
		if self.db.profile.ModuleEnabledState[name] then
			module:Enable()
		else
			module:Disable()
		end
	end
end

function BasicUI:Greeting()
	-- Greeting
	local addonversion = GetAddOnMetadata("BasicUI", "Version")
	local ccolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
	local EventFrame = CreateFrame("Frame")
	EventFrame:RegisterEvent("PLAYER_LOGIN")
	EventFrame:SetScript("OnEvent", function(self,event,...) 
		hexa = ("|cff%.2x%.2x%.2x"):format(ccolor.r * 255, ccolor.g * 255, ccolor.b * 255)
		hexb = "|r"
		if type(BasicDBPerCharacter) ~= "number" then
			BasicDBPerCharacter = 1
			ChatFrame1:AddMessage('Welcome to Azeroth '..hexa..UnitName("Player")..hexb..". I do believe this is the first time we've met. Nice to meet you! You're using |cff00B4FFBasic|rUI v"..addonversion..'.',255,255,0)
		else
			if BasicDBPerCharacter == 1 then
				ChatFrame1:AddMessage('Welcome to Azeroth '..hexa..UnitName("Player")..hexb..". How nice to see you again. You're using |cff00B4FFBasic|r".."|cffffffffUI|r".." v"..addonversion..'.',255,255,0)
			else
				ChatFrame1:AddMessage('Welcome to Azeroth '..hexa..UnitName("Player")..hexb..". How nice to see you again. You're using |cff00B4FFBasic|r".."|cffffffffUI|r".." v"..addonversion..'.',255,255,0)
			end
			BasicDBPerCharacter = BasicDBPerCharacter + 1
		end
	end)
end