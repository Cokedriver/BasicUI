local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

-- Below are the Default Settings for BasicUI


-----------------
-- Media Options
-----------------
DB["media"] = {
	["font"] = "BasicUI",
	["fontSize"] = 15,
}

-------------------
-- General Options
-------------------
DB["general"] = {
	["color"] = { r = 1, g = 1, b = 1},
	["classcolor"] = true,
	["cooldown"] = true,
	["slidebar"] = true,
	["btsw"] = true,
	["cbop"] = true,
	["quicky"] = true,
	["vellum"] = true,
	["mail"] = false,
	["watchframe"] = true,
	["flashmapnodes"] = true,
	["loot"] = {
		["enable"] = true,
		["disenchant"] = false,
	},	
	["BlackBook"] = {
		["enable"] = true,
		["AutoFill"] = true,
		["contacts"] = {},
		["recent"] = {},
		["AutoCompleteAlts"] = true,
		["AutoCompleteRecent"] = true,
		["AutoCompleteContacts"] = true,
		["AutoCompleteFriends"] = true,
		["AutoCompleteGuild"] = true,
		["ExcludeRandoms"] = true,
		["DisableBlizzardAutoComplete"] = false,
		["UseAutoComplete"] = true,
	},
	["OpenAll"] = {
		["enable"] = true,
		["collected"] = true,
		["OpenSpeed"] = 0.50,
		["ChatOutput"] = 1,
		["AHCancelled"] = true,
		["AHExpired"] = true,
		["AHOutbid"] = true,
		["AHSuccess"] = true,
		["AHWon"] = true,
		["NeutralAHCancelled"] = true,
		["NeutralAHExpired"] = true,
		["NeutralAHOutbid"] = true,
		["NeutralAHSuccess"] = true,
		["NeutralAHWon"] = true,
		["Attachments"] = true,
		["SpamChat"] = true,
		["KeepFreeSpace"] = 1,
	},
	["buttons"] = {	
		["enable"] = true,
		["showHotKeys"] = false,
		["showMacronames"] = false,
		["auraborder"] = false,
		
		-- Button Colors
		["color"] = { 
			["enable"] = true,
			["OutOfRange"] = { r = 0.9, g = 0, b = 0 },
			["OutOfMana"] = { r = 0, g = 0, b = 0.9 },			
			["NotUsable"] = { r = 0.3, g = 0.3, b = 0.3 },
		},
	},	

}

---------------
-- Buff Options
----------------
DB["buff"] = {
	["enable"] = true,
    ["buffScale"] = 1.19,
}	

------------------
--Castbar Options
------------------
DB["castbar"] = {	
	["enable"] = true,
	["border"] = "Blizzard Tooltip",
	["background"] = "Blizzard Dialog Background Dark",
	["statusbar"] = "Blizzard",
	

	["CastingBarFrame"] = {
		["enable"] = true,
		["fontSize"] = 18,
		["textPosition"] = "CENTER",
		["enableLag"] = true,
		["enableTimer"] = true,
		["selfAnchor"] = "BOTTOM",
		["relAnchor"] = "BOTTOM",
		["offSetX"] = 0,
		["offSetY"]	= 175,
	},
	["TargetFrameSpellBar"] = {
		["enable"] = false,
		["fontSize"] = 18,
		["textPosition"] = "CENTER",
		["enableLag"] = true,
		["enableTimer"] = true,
		["selfAnchor"] = "TOP",
		["relAnchor"] = "TOP",
		["offSetX"]	= 0,
		["offSetY"]	= -250,
	},
	["FocusFrameSpellBar"] = {
		["enable"] = true,
		["fontSize"] = 18,
		["textPosition"] = "CENTER",
		["enableLag"] = true,
		["enableTimer"] = true,
		["selfAnchor"] = "TOP",
		["relAnchor"] = "TOP",
		["offSetX"]	= 0,
		["offSetY"]	= -165,
	},
	["MirrorTimer1"] = {
		["enable"] = true,
		["fontSize"] = 18,
		["enableTimer"] = true,
		["selfAnchor"] = "TOP",
		["relAnchor"] = "TOP",
		["offSetX"]	= 0,
		["offSetY"]	= -75,
	},
	["PetCastingBarFrame"] = {
		["enable"] = true,
		["fontSize"] = 18,
		["textPosition"] = "CENTER",
		["enableTimer"] = true,
		["selfAnchor"] = "BOTTOM",
		["relAnchor"] = "BOTTOM",
		["offSetX"]	= 0,
		["offSetY"]	= 200,
	},
}

----------------
-- Chat Options
----------------
DB["chat"] = {
	["enable"] = true,
	["disableFade"] = false,
	["chatOutline"] = false,
	["windowborder"] = false,
	["enableborder"] = false,
	
	-- Chat Media
	["border"] = "Blizzard Tooltip",
	["background"] = "Blizzard Dialog Background Dark",
	["editboxborder"] = "Blizzard Tooltip",
	["editboxbackground"] = "Blizzard Dialog Background Dark",
	["sound"] = "Whisper",
	
	["enableBottomButton"] = true, 
	["enableHyperlinkTooltip"] = true, 
	["enableBorderColoring"] = true,

	["tab"] = {
		["fontSize"] = 15,
		["fontOutline"] = true, 
		["normalColor"] = {r = 1, g = 1, b = 1},
		["specialColor"] = {r = 1, g = 0, b = 1},
		["selectedColor"] = {r = 0, g = 0.75, b = 1},
	},		
}
	
---------------------
-- Datatext Options
---------------------
DB["datatext"] = {	
	["enable"] = true,
	["tooltipadjust"] = true,

	-- Datapanel Media
	["border"] = "Blizzard Dialog",
	["background"] = "Blizzard Dialog Background Dark",
	
	["top"] = false,										-- if = true then panel on top of screen, if = false panel below mainmenubar
	["fontsize"] = 15,                                  	-- font size for panels.
	["bags"] = 9,                                       	-- show space used in bags on panel.
	["system"] = 0,                                     	-- show total memory and others systems info (FPS/MS) on panel.
	["wowtime"] = 0,                                    	-- show time on panel.
	["guild"] = 4,                                      	-- show number on guildmate connected on panel.
	["dur"] = 8,                                        	-- show your equipment durability on panel.
	["friends"] = 6,                                    	-- show number of friends connected.
	["dps_text"] = 0,                                   	-- show a dps meter on panel.
	["hps_text"] = 0,                                   	-- show a heal meter on panel.
	["spec"] = 5,											-- show your current spec on panel.
	["zone"] = 0,											-- show your current zone on panel.
	["coords"] = 0,											-- show your current coords on panel.
	["pro"] = 7,											-- shows your professions and tradeskills
	["stat1"] = 1,											-- Stat Based on your Role (Avoidance-Tank, AP-Melee, SP/HP-Caster)
	["stat2"] = 3,											-- Stat Based on your Role (Armor-Tank, Crit-Melee, Crit-Caster)
	["recount"] = 2,										-- Stat Based on Recount"s DPS
	["recountraiddps"] = false,								-- Enables tracking or Recounts Raid DPS
	["calltoarms"] = 0,										-- Show Current Call to Arms.
	
	-- Color Datatext
	["colors"] = {
		["color"] = { r = 0, g = 0, b = 1},                 -- datatext color if classcolor = false 
	},
	
	["battleground"] = true,                            	-- enable 3 stats in battleground only that replace stat1,stat2,stat3.

	["bag"] = false,										-- True = Open Backpack; False = Open All bags

	-- Clock Settings
	["time24"] = false,                                  	-- set time to 24h format.
	["localtime"] = true,                              		-- set time to local time instead of server time.	
		
	-- FPS Settings
	["fps"] = {
		["enable"] = true,									-- enable the FPS on the System Tooltip
		-- ONLY ONE OF THESE CAN BE TRUE	
		["home"] = false,									-- Only Show Home Latency
		["world"] = false,									-- Only Show World Latency
		["both"] = true,									-- Show both Home and World Latency
	},
		
	["threatbar"] = true,									-- Enable the threatbar over the Center Panel.
}

--------------------
-- Merchant Options
--------------------

DB["merchant"] = {
	["enable"] = true,										-- enable merchant module.
	["sellMisc"] = true, 									-- allows the user to add spacific items to sell at merchant (please see the local filter in merchant.lua)
	["autoSellGrey"] = true,								-- autosell grey items at merchant.
	["autoRepair"] = true,									-- autorepair at merchant.
}

--------------------
-- Minimap Options
--------------------
DB["minimap"] = {
	["enable"] = true,
	["gameclock"] = true,
	["farm"] = false,
	["farmscale"] = 3,
}

---------------------
-- Nameplates Options
---------------------
DB["nameplates"] = {
	["enable"] = true,
    ["enableTankMode"] = true,              -- Color the nameplate threat border green, if you have no aggro
    ["colorNameWithThreat"] = true,         -- The name has the same color as the threat of the unit (better visibility)

    ["showFullHP"] = true,
    ["showLevel"] = true,
    ["showTargetBorder"] = true,
    ["showEliteBorder"] = true,
    ["showTotemIcon"] = true,
    ["abbrevLongNames"] = true,
}

--------------------
-- Powerbar Options 
--------------------
DB["powerbar"] = {
	["enable"] = true,
	["background"] = "Blizzard Dialog Background Dark",
	["statusbar"] = "Blizzard",	
    ["position"] = {
		["selfAnchor"] = "CENTER",
		["frameParent"] = "UIParent",
		["offSetX"] = 0,
		["offSetY"] = -100
	},
    ["sizeWidth"] = 200,
    
    ["showCombatRegen"] = true, 

    ["activeAlpha"] = 1,
    ["inactiveAlpha"] = 0.5,
    ["emptyAlpha"] = 0,
    
    ["valueAbbrev"] = true,
        
    ["valueFontSize"] = 20,
    ["valueFontOutline"] = true,
    ["valueFontAdjustmentX"] = 0,

    ["showSoulshards"] = true,
    ["showHolypower"] = true,
    ["showMana"] = true,
	["showFocus"] = true,
	["showRage"] = true,
	
    ["extraFontSize"] = 16,                             -- The fontsize for the holypower and soulshard number
    ["extraFontOutline"] = true,                        
        
    
    ["energy"] = {
        ["show"] = true,
        ["showComboPoints"] = true,
		["comboPointsBelow"] = false,
        
        ["comboFontSize"] = 16,
        ["comboFontOutline"] = true,
    },
    
    
    ["rune"] = {
        ["show"] = true,
        ["showRuneCooldown"] = true,
       
        ["runeFontSize"] = 16,
        ["runeFontOutline"] = true,
    },
}
	
-----------------
-- Quest Options
-----------------
DB["quest"] = {
	["enable"] = true,									-- enable quest module.
	["autocomplete"] = false,							-- enable the autoaccept quest and autocomplete quest if no reward.	
}

-------------------------
-- Skinning Options
-------------------------
DB["skin"] = {
	["enable"] = true,
	["border"] = "Blizzard Tooltip",
	["statusbar"] = "Blizzard",
	["DBM"] = true,
	["Recount"] = true,
	["RecountBackdrop"] = true,
}

-------------------
-- Tooltip Options
-------------------
DB["tooltip"] = {											
	["enable"] = true,									-- Move the tooltip up so its not overlapping the MainMenubar
	["fontSize"] = 15,
	["fontOutline"] = true,
	["disableFade"] = false,                     		-- Can cause errors or a buggy tooltip!
	["abbrevRealmNames"] = true, 	
	["border"] = "Blizzard Tooltip",
	["background"] = "Blizzard Dialog Background Dark",
	["statusbar"] = "Blizzard",
    ["hideInCombat"] = false,                       -- Hide unit frame tooltips during combat	
    ["hideRealmText"] = true,                      -- Hide the coalesced/interactive realm text	
	["reactionBorderColor"] = true,
	["itemqualityBorderColor"] = true,
	
	["showPlayerTitles"] = true,
	["showPVPIcons"] = false,                        	-- Show pvp icons instead of just a prefix
	["showMouseoverTarget"] = true,
    ["showOnMouseover"] = false,
    ["showUnitRole"] = true,
    ["showItemLevel"] = true,
    ["showSpecializationIcon"] = false,

    ["position"] = {
		["selfAnchor"] = "BOTTOM",
		["relAnchor"] = "BOTTOM",
		["offSetX"]	= 0,
		["offSetY"]	= 200,
	},	
	
	["healthbar"] = {
		["showHealthValue"] = true,
		["showOutline"] = true,
        ["healthFormat"] = '$cur / $max',           -- Possible: $cur, $max, $deficit, $perc, $smartperc, $smartcolorperc, $colorperc
        ["healthFullFormat"] = '$cur',              -- if the tooltip unit has 100% hp 		
		["textPos"] = "CENTER",                     -- Possible "TOP" "BOTTOM" "CENTER"	
		["reactionColoring"] = false,
        ["custom"] = {
			["apply"] = false,
			["color"] =	{ r = 1, g = 1, b = 0},
		},		
		["fontSize"] = 15,
	},		
}


--------------
-- Unitframes
--------------
DB["unitframes"] = {
	
	["enable"] = true,
	["player"] = {
		["enable"] = true,			-- Enable Player Frame Adjustments
		["scale"] = 1.15,			-- Player Frame Scale
		["fontSize"] = 13,			-- Stausbar Font Size
		["fontSizepet"] = 10,			-- Stausbar Font Size
	},
	["target"] = {
		["enable"] = true,			-- Enable Target Frame Adjustments
		["scale"] = 1.15,			-- Target Frame Scale
		["fontSize"] = 13,			-- Stausbar Font Size
	},
	["focus"] = {
		["enable"] = true,			-- Enable Focus Frame Adjustments
		["scale"] = 1.15,			-- Focus Frame Scale
		["fontSize"] = 13,			-- Stausbar Font Size
	},
	["party"] = {
		["enable"] = true,
		["scale"] = 1.15,
		["fontSize"] = 11,			-- Stausbar Font Size
		["position"] = {
			["relAnchor"] = "TOPLEFT",
			["offSetX"] = 10,		-- Controls the X offset. (Left - Right)
			["offSetY"] = -150,		-- Controls the Y offset. (Up - Down)
		},
	},
	["arena"] = {
		["enable"] = true,
		["scale"] = 1.5,
		["fontSize"] = 11,			-- Stausbar Font Size
		["tracker"] = true,
	},
	["boss"] = {
		["enable"] = true,
		["scale"] = 1.15,
		["fontSize"] = 13,			-- Stausbar Font Size	
		["position"] = {
			["relAnchor"] = "TOPRIGHT",
			["offSetX"] = -50,		-- Controls the X offset. (Left - Right)
			["offSetY"] = -250,		-- Controls the Y offset. (Up - Down)
		},
	},
}	


