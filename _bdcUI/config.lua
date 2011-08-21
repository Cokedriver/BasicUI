local DB, L = unpack(select(2, ...)) -- Import: DB - config; L - locales

---------------------
-- AutoGreed Options
---------------------
DB.autogreed = {
	enable = true,
}
	
----------------
-- Buff Options
----------------
DB.buff = {
	enable = true,
	scale = 1.2,
}	
	
----------------
-- Castbar 
----------------
DB.castbar = {
	enable = true,
}

----------------
-- Chat Options
----------------
DB.chat = {
	enable = true,
	disableFade = false,
	chatOutline = true,

	enableBottomButton = true, 
	enableHyperlinkTooltip = true, 
	enableBorderColoring = true,

	tab = {
		fontSize = 15,
		fontOutline = true, 
		normalColor = {1, 1, 1},
		specialColor = {1, 0, 1},
		selectedColor = {0, 0.75, 1},
	},		
}
	
-----------------------
-- Class Color Options
-----------------------
DB.colors = {
	enable = true,
}	

------------------
-- Cooldown Options
------------------
DB.cooldown = {
	enable = true,
}
	
---------------------
-- Datatext Options
---------------------
DB.datatext = {
	
	enable = true,
		
	datapanel = {	
		enable = true,										-- enable panel/panels	
		border = true,									
	},
		
	top = false,											-- position the datpanel true = top, false = bottom
	
	toc = 40200,
	
	fontsize = 15,                                  	-- font size for panels.
	system = 0,                                     	-- show total memory and others systems info (FPS/MS) on panel.
	gold = 9,                                       	-- show your current gold on panel.
	wowtime = 0,                                    	-- show time on panel.
	guild = 0,                                      	-- show number on guildmate connected on panel.
	dur = 8,                                        	-- show your equipment durability on panel.
	friends = 7,                                    	-- show number of friends connected.
	dps_text = 0,                                   	-- show a dps meter on panel.
	hps_text = 0,                                   	-- show a heal meter on panel.
	currency = 0,                                   	-- show your tracked currency on panel.
	micromenu = 0,										-- show the micromenu on panel.
	spec = 5,											-- show your current spec on panel.
	zone = 0,											-- show your current zone on panel.
	coords = 0,											-- show your current coords on panel.
	pro = 4,											-- shows your professions and tradeskills
	stat1 = 1,											-- Stat Based on your Role (Avoidance-Tank, AP-Melee, SP/HP-Caster)
	stat2 = 3,											-- Stat Based on your Role (Armor-Tank, Crit-Melee, Crit-Caster)
	recount = 2,										-- Stat Based on Recount's DPS
	recountraiddps = false,								-- Enables tracking or Recounts Raid DPS
	calltoarms = 6,										-- Show Current Call to Arms.
	
	-- Color Datatext
	classcolor = true,               			    	-- classcolored datatexts
	color = '|cffFFFF33',                           	-- datatext color if classcolor = false (|cffFFFF33 = yellow)
	
	battleground = true,                            	-- enable 3 stats in battleground only that replace stat1,stat2,stat3.

	
	-- Clock Settings
	time24 = false,                                  	-- set time to 24h format.
	localtime = true,                              		-- set time to local time instead of server time.	
		
	-- FPS Settings
	fps = {
		enable = true,									-- enable the FPS on the System Tooltip
		-- ONLY ONE OF THESE CAN BE TRUE	
		home = false,									-- Only Show Home Latency
		world = false,									-- Only Show World Latency
		both = true,									-- Show both Home and World Latency
	},
		
	threatbar = {
		enable = true,									-- Enable the threatbar over the Center Panel.
	},
		
}
	
-----------------
-- Macro Options
-----------------
DB.macro = {					
	enable = true,			-- enable bigger macros.
}
	
-----------------
-- Media Options
-----------------
DB.media = {
	font = 'Fonts\\ARIALN.ttf',
}
	
--------------------
-- Merchant Options
--------------------
DB.merchant = {
	enable = true,			-- enable merchant module.
	sellMisc = true, 		-- allows the user to add spacific items to sell at merchant (please see the local filter in merchant.lua)
	autoSellGrey = true,	-- autosell grey items at merchant.
	autoRepair = true,		-- autorepair at merchant.
}
	
------------------
--Minimap Options
------------------
DB.minimap = {
	enable = true,
}
	
--------------------
-- Powerbar Options 
--------------------
DB.power = {
	enable = true,
	position = {'CENTER', UIParent, 0, -165},
	sizeWidth = 200,
		
	showCombatRegen = true, 

	activeAlpha = 1,
	inactiveAlpha = 0.3,
	emptyAlpha = 0,
		
	valueAbbrev = true,
			
	valueFont = 'Fonts\\ARIALN.ttf',
	valueFontSize = 15,
	valueFontOutline = true,
	valueFontAdjustmentX = 0,

	showSoulshards = true,
	showHolypower = true,
		
	extraFont = 'Fonts\\ARIALN.ttf',                -- The font for the holypower and soulshard number
	extraFontSize = 16,                             -- The fontsiz for the holypower and soulshard number
	extraFontOutline = true,                        
			
	mana = {
		show = true,
	},
		
	energy = {
		show = true,
		showComboPoints = true,
			
		comboColor = {
			[1] = {r = 1.0, g = 1.0, b = 1.0},
			[2] = {r = 1.0, g = 1.0, b = 1.0},
			[3] = {r = 1.0, g = 1.0, b = 1.0},
			[4] = {r = 0.9, g = 0.7, b = 0.0},
			[5] = {r = 1.0, g = 0.0, b = 0.0},
		},
			
		comboFont = 'Fonts\\ARIALN.ttf',
		comboFontSize = 16,
		comboFontOutline = true,
	},
		
	focus = {
		show = true,
	},
		
	rage = {
		show = true,
	},
		
	rune = {
		show = true,
		showRuneCooldown = true,
			
		runeFont = 'Fonts\\ARIALN.ttf',
		runeFontSize = 16,
		runeFontOutline = true,
	},
}	
	
-----------------
-- Quest Options
-----------------
DB.quest = {
	enable = true,			-- enable quest module.
	autocomplete = false,	-- enable the autoaccept quest and autocomplete quest if no reward.
}

---------------------------
-- Unitframe Scale Options
---------------------------
DB.scale = {
	enable = true,
	size = 1.15,
}
	
----------------
--Range Options
----------------
DB.range = {
	enable = true,
}

-------------------------
-- Reminder Buff Options
-------------------------
DB.selfbuffs = {
	enable = true,			-- enable selbuffs module.
	sound = true,			-- sound warning
}

-------------------------
-- Slash Command Options
-------------------------
DB.slash = {
	enable = true,
}

-------------------
-- Tooltip Options
-------------------
DB.tooltip = {											
	enable = true,										-- Move the tooltip up so its not overlapping the MainMenubar
	position = {
		'BOTTOMRIGHT', UIParent, -95, 150
	},
	
	disableFade = false,                        -- Can cause errors or a buggy tooltip!
	
	reactionBorderColor = true,
	itemqualityBorderColor = true,
		
	showPlayerTitles = true,
	showPVPIcons = false,                        -- Show pvp icons instead of just a prefix
	abbrevRealmNames = false, 
	showMouseoverTarget = true,
		
	showItemLevel = true,
		
	healthbar = {
		showHealthValue = true,
		fontSize = 14,
		font = 'Fonts\\ARIALN.ttf',
		showOutline = false,
		textPos = 'CENTER',                     -- Possible 'TOP' 'BOTTOM' 'CENTER'
			
		reactionColoring = false,               -- Overrides customColor 
		customColor = {
			apply = false, 
			r = 0, 
			g = 1, 
			b = 1
		} 
	},		
}


