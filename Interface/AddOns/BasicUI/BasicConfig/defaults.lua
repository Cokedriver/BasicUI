local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database


---------------
-- Buff Options
----------------
DB['buff'] = {
	['enable'] = true,
	['scale'] = 1.15,
}	

------------------
--Castbar Options
------------------
DB['castbar'] = {
	
	['enable'] = true,

	["CastingBarFrame"] = {
		enabled             = true,
		textPosition        = "CENTER",
		textFont            = {"Fonts\\FRIZQT__.TTF", 14, ""},
		castbarSize         = {245, 24, 5, 5},
		castbarColor        = {B.ccolor.r, B.ccolor.g, B.ccolor.b},
		castbarBGColor      = {.1, .1, .1, .95},
		castbarTextures     = {"Interface\\TargetingFrame\\UI-StatusBar", "Interface\\Tooltips\\UI-Tooltip-Background"},
		enableLag           = true,
		enableTimer         = true,
		selfAnchor			= "BOTTOM",
		relAnchor			= "BOTTOM",
		offSetX				= 0,
		offSetY				= 175,
	},
	["TargetFrameSpellBar"] = {
		enabled             = true,
		textPosition        = "CENTER",
		textFont            = {"Fonts\\FRIZQT__.TTF", 14, ""},
		castbarSize         = {245, 24, 5, 5},
		castbarColor        = {B.ccolor.r, B.ccolor.g, B.ccolor.b},
		castbarBGColor      = {.1, .1, .1, .95},
		castbarTextures     = {"Interface\\TargetingFrame\\UI-StatusBar", "Interface\\Tooltips\\UI-Tooltip-Background"},
		enableLag           = true,
		enableTimer         = true,
		selfAnchor			= "BOTTOM",
		relAnchor			= "BOTTOM",
		offSetX				= 0,
		offSetY				= 300,
	},
	["FocusFrameSpellBar"] = {
		enabled             = true,
		textPosition        = "CENTER",
		textFont            = {"Fonts\\FRIZQT__.TTF", 14, ""},
		castbarSize         = {245, 24, 5, 5},
		castbarColor        = {B.ccolor.r, B.ccolor.g, B.ccolor.b},
		castbarBGColor      = {.1, .1, .1, .95},
		castbarTextures     = {"Interface\\TargetingFrame\\UI-StatusBar", "Interface\\Tooltips\\UI-Tooltip-Background"},
		enableLag           = true,
		enableTimer         = true,
		selfAnchor			= "TOP",
		relAnchor			= "TOP",
		offSetX				= 0,
		offSetY				= -165,
	},
	["MirrorTimer1"] = {
		enabled             = true,
		textPosition        = "CENTER",
		textFont            = {"Fonts\\FRIZQT__.TTF", 14, ""},
		castbarSize         = {245, 24, 5, 5},
		castbarColor        = {B.ccolor.r, B.ccolor.g, B.ccolor.b},
		castbarBGColor      = {.1, .1, .1, .95},
		castbarTextures     = {"Interface\\TargetingFrame\\UI-StatusBar", "Interface\\Tooltips\\UI-Tooltip-Background"},
		enableTimer         = true,
		selfAnchor			= "TOP",
		relAnchor			= "TOP",
		offSetX				= 0,
		offSetY				= -10,
	},
	["PetCastingBarFrame"] = {
		enabled             = true,
		textPosition        = "CENTER",
		textFont            = {"Fonts\\FRIZQT__.TTF", 14, ""},
		castbarSize         = {245, 24, 5, 5},
		castbarColor        = {B.ccolor.r, B.ccolor.g, B.ccolor.b},
		castbarBGColor      = {.1, .1, .1, .95},
		castbarTextures     = {"Interface\\TargetingFrame\\UI-StatusBar", "Interface\\Tooltips\\UI-Tooltip-Background"},
		enableTimer         = true,
		selfAnchor			= "BOTTOM",
		relAnchor			= "BOTTOM",
		offSetX				= 0,
		offSetY				= 200,
	},
}

----------------
-- Chat Options
----------------
DB['chat'] = {
	['enable'] = true,
	['disableFade'] = false,
	['chatOutline'] = false,

	
	['enableBottomButton'] = true, 
	['enableHyperlinkTooltip'] = true, 
	['enableBorderColoring'] = true,

	['tab'] = {
		['fontSize'] = 15,
		['fontOutline'] = true, 
		['normalColor'] = {1, 1, 1},
		['specialColor'] = {1, 0, 1},
		['selectedColor'] = {0, 0.75, 1},
	},		
}
	
---------------------
-- Datatext Options
---------------------
DB['datatext'] = {
	
	['enable'] = true,

	['top'] = false,										-- if = true then panel on top of screen, if = false panel below mainmenubar
	
	['fontsize'] = 15,                                  	-- font size for panels.
	['bags'] = 9,                                       	-- show space used in bags on panel.
	['system'] = 0,                                     	-- show total memory and others systems info (FPS/MS) on panel.
	['wowtime'] = 0,                                    	-- show time on panel.
	['guild'] = 0,                                      	-- show number on guildmate connected on panel.
	['dur'] = 8,                                        	-- show your equipment durability on panel.
	['friends'] = 7,                                    	-- show number of friends connected.
	['dps_text'] = 0,                                   	-- show a dps meter on panel.
	['hps_text'] = 0,                                   	-- show a heal meter on panel.
	['spec'] = 5,											-- show your current spec on panel.
	['zone'] = 0,											-- show your current zone on panel.
	['coords'] = 0,											-- show your current coords on panel.
	['pro'] = 4,											-- shows your professions and tradeskills
	['stat1'] = 1,											-- Stat Based on your Role (Avoidance-Tank, AP-Melee, SP/HP-Caster)
	['stat2'] = 3,											-- Stat Based on your Role (Armor-Tank, Crit-Melee, Crit-Caster)
	['recount'] = 2,										-- Stat Based on Recount's DPS
	['recountraiddps'] = false,								-- Enables tracking or Recounts Raid DPS
	['calltoarms'] = 6,										-- Show Current Call to Arms.
	
	-- Color Datatext
	['colors'] = {
		['classcolor'] = true,               			    -- classcolored datatexts
		['color'] = { r = 0, g = 0, b = 1},                 -- datatext color if classcolor = false 
	},
	
	['battleground'] = true,                            	-- enable 3 stats in battleground only that replace stat1,stat2,stat3.

	['bag'] = false,										-- True = Open Backpack; False = Open All bags

	-- Clock Settings
	['time24'] = false,                                  	-- set time to 24h format.
	['localtime'] = true,                              		-- set time to local time instead of server time.	
		
	-- FPS Settings
	['fps'] = {
		['enable'] = true,									-- enable the FPS on the System Tooltip
		-- ONLY ONE OF THESE CAN BE TRUE	
		['home'] = false,									-- Only Show Home Latency
		['world'] = false,									-- Only Show World Latency
		['both'] = true,									-- Show both Home and World Latency
	},
		
	['threatbar'] = true,									-- Enable the threatbar over the Center Panel.

		
}

-------------------
-- General Options
-------------------
DB['general'] = {

	['autogreed'] = true,
	['colors'] = true,
	['cooldown'] = true,										-- enable bigger macros.
	['font'] = "Fonts\\ARIALN.ttf",							-- general font for UI
	['range'] = true,
	['slash'] = true,
	['scale'] = {
		['enable'] = true,
		['size'] = 1.15,
	},
	['mail'] = {
		['enable'] = true,
		['gold'] = true,
		['item'] = true,
		['openall'] = true,
		['BlackBook'] = {
			['AutoFill'] = true,
			['contacts'] = {},
			['recent'] = {},
			['AutoCompleteAlts'] = true,
			['AutoCompleteRecent'] = true,
			['AutoCompleteContacts'] = true,
			['AutoCompleteFriends'] = true,
			['AutoCompleteGuild'] = true,
			['ExcludeRandoms'] = true,
			['DisableBlizzardAutoComplete'] = false,
			['UseAutoComplete'] = true,
		},		
	},	
}

-------------------
-- Nameplate Options
--------------------
DB['nameplates'] = {
	['enable'] = true,

	['colorswitcher'] = true,  			 						-- true/false will swap back- and foregroundcolor
	['showhpvalue']   = true, 									-- true/false will enable disable of hp value on the nameplate
	['alwaysshowhp']  = true, 									-- true/false will make the hp value appear even if the unit has 100% life, requires showhpvalue to be true	
}

-------------------
-- Merchant Options
--------------------
DB['merchant'] = {
	['enable'] = true,										-- enable merchant module.
	['sellMisc'] = true, 									-- allows the user to add spacific items to sell at merchant (please see the local filter in merchant.lua)
	['autoSellGrey'] = true,								-- autosell grey items at merchant.
	['autoRepair'] = true,									-- autorepair at merchant.
}
	
--------------------
-- Powerbar Options 
--------------------
DB['powerbar'] = {
	['enable'] = true,
	['sizeWidth'] = 200,
		
	['showCombatRegen'] = true, 
	['showSoulshards'] = true,
	['showHolypower'] = true,
	['showComboPoints'] = true,
	['showRuneCooldown'] = true,

	
	['energybar'] = true,
	['focusbar'] =  true,
	['manabar'] =  true,
	['ragebar'] = true,
	['runebar']= true,

	
	['combo'] = {
		['FontOutline'] = true,
		['FontSize'] = 16,	
	},
	
	['extra'] = {
		['FontOutline'] = true,	
		['FontSize'] = 16,
	},
	
	['rune'] = {
		['FontOutline'] = true,
		['FontSize'] = 16,		
	},
	
	['value'] = {	
		['Abbrev'] = true,	
		['FontOutline'] = true,
		['FontSize'] = 15,
	},	

}	
	
-----------------
-- Quest Options
-----------------
DB['quest'] = {
	['enable'] = true,									-- enable quest module.
	['autocomplete'] = false,							-- enable the autoaccept quest and autocomplete quest if no reward.
}

-------------------------
-- Reminder Buff Options
-------------------------
DB['selfbuffs'] = {
	['enable'] = true,									-- enable selbuffs module.
	['sound'] = true,									-- sound warning
}

-------------------
-- Tooltip Options
-------------------
DB['tooltip'] = {											
	['enable'] = true,									-- Move the tooltip up so its not overlapping the MainMenubar

	['disableFade'] = false,                     		-- Can cause errors or a buggy tooltip!
	
	['reactionBorderColor'] = true,
	['itemqualityBorderColor'] = true,
	
	['showPlayerTitles'] = true,
	['showPVPIcons'] = false,                        	-- Show pvp icons instead of just a prefix
	['abbrevRealmNames'] = false, 
	['showMouseoverTarget'] = true,
	
	['showItemLevel'] = true,
	
	['healthbar'] = {
		['showHealthValue'] = true,
		['showOutline'] = false,
		['textPos'] = 'CENTER',                     -- Possible 'TOP' 'BOTTOM' 'CENTER'	
		['reactionColoring'] = false,
		['customColorapply'] = false, 
        ['custom'] = {
			['apply'] = false,
			['color'] =	{ r = 1, g = 1, b = 0},
		},		
		['fontSize'] = 14,
	},		
}


