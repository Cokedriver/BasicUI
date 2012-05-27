local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

-- Below are the Default Settings for BasicUI


-----------------
-- Media Options
-----------------
DB["media"] = {
	["font"] = "BasicUI",
	["fontSize"] = 14,
	["fontxSmall"] = 10,
	["fontSmall"] = 12,
	["fontMedium"] = 14,
	["fontLarge"] = 16,
	["fontHuge"] = 20,
}

-------------------
-- General Options
-------------------
DB["general"] = {
	["color"] = { r = 1, g = 1, b = 1},
	["classcolor"] = true,
	["autogreed"] = true,
	["cooldown"] = true,
	["slidebar"] = true,
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
	["facepaint"] = {
		["enable"] = true,
		["custom"] = {
			["gradient"] = false, -- false applies one solid color (class color if class = true, topcolor if not)
			["topcolor"] = { r = 0.9, g = 0.9, b = 0.9 }, -- top gradient color (rgb)
			["bottomcolor"] = {	r = 0.1, g = 0.1, b = 0.1 }, -- bottom gradient color (rgb)
			["topalpha"] = 1,	-- top gradient alpha (global if gradient = false)
			["bottomalpha"] = 1,	-- bottom gradient alpha (not used if gradient = false)
		},
	},	
	["mail"] = {
		["enable"] = true,
		["openall"] = true,
		-- BlackBook is barrowed from Postal with permission.
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
	},	
	["scale"] = {
		["enable"] = true,
		["playerFrame"] = 1.15,
		["targetFrame"] = 1.15,
		["focusFrame"] = 1.15,
		["partyFrame"] = 1.15,
		["partypetFrame"] = 1.15,
		["arenaFrame"] = 1.15,
		["bossFrame"] = 1.15,
	},
}

---------------
-- Buff Options
----------------
DB["buff"] = {
	["enable"] = true,
	["border"] = "Blizzard Dialog",
	["background"] = "Black",
    ["buffSize"] = 36,
    ["buffScale"] = 1,

    ["buffFontSize"] = 14,
    ["buffCountSize"] = 16,

    ["debuffSize"] = 36,
    ["debuffScale"] = 1,

    ["debuffFontSize"] = 14,
    ["debuffCountSize"] = 16,

    ["paddingX"] = 10,
    ["paddingY"] = 10,
    ["buffPerRow"] = 6,
}	

------------------
--Castbar Options
------------------
DB["castbar"] = {	
	["enable"] = true,
	["border"] = "Blizzard Dialog",
	["background"] = "Black",
	["statusbar"] = "Blizzard",
	

	["CastingBarFrame"] = {
		["enable"] = true,
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
		["textPosition"] = "CENTER",
		["enableTimer"] = true,
		["selfAnchor"] = "TOP",
		["relAnchor"] = "TOP",
		["offSetX"]	= 0,
		["offSetY"]	= -10,
	},
	["PetCastingBarFrame"] = {
		["enable"] = true,
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
	["windowborder"] = true,
	["enableborder"] = true,
	
	-- Chat Media
	["border"] = "Blizzard Dialog",
	["background"] = "Blizzard Dialog Background",
	["editboxborder"] = "Blizzard Dialog",
	["editboxbackground"] = "Blizzard Dialog Background",
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

	-- Datapanel Media
	["border"] = "Blizzard Dialog",
	["background"] = "Blizzard Dialog Background",
	
	["top"] = false,										-- if = true then panel on top of screen, if = false panel below mainmenubar
	["fontsize"] = 15,                                  	-- font size for panels.
	["bags"] = 9,                                       	-- show space used in bags on panel.
	["system"] = 0,                                     	-- show total memory and others systems info (FPS/MS) on panel.
	["wowtime"] = 0,                                    	-- show time on panel.
	["guild"] = 0,                                      	-- show number on guildmate connected on panel.
	["dur"] = 8,                                        	-- show your equipment durability on panel.
	["friends"] = 7,                                    	-- show number of friends connected.
	["dps_text"] = 0,                                   	-- show a dps meter on panel.
	["hps_text"] = 0,                                   	-- show a heal meter on panel.
	["spec"] = 5,											-- show your current spec on panel.
	["zone"] = 0,											-- show your current zone on panel.
	["coords"] = 0,											-- show your current coords on panel.
	["pro"] = 4,											-- shows your professions and tradeskills
	["stat1"] = 1,											-- Stat Based on your Role (Avoidance-Tank, AP-Melee, SP/HP-Caster)
	["stat2"] = 3,											-- Stat Based on your Role (Armor-Tank, Crit-Melee, Crit-Caster)
	["recount"] = 2,										-- Stat Based on Recount"s DPS
	["recountraiddps"] = false,								-- Enables tracking or Recounts Raid DPS
	["calltoarms"] = 6,										-- Show Current Call to Arms.
	
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
	["border"] = "BasicUI",
	["gameclock"] = true,
	["farm"] = false,
	["farmscale"] = 3,
	["zoneText"] = true,
	["instanceDifficulty"] = false,
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
	["border"] = "BasicUI",
	["statusbar"] = "Blizzard",
	["sizeWidth"] = 200,
		
	["showCombatRegen"] = true, 
	["showSoulshards"] = true,
	["showHolypower"] = true,
	["showComboPoints"] = true,
	["showRuneCooldown"] = true,
	["showEclipseBar"] = true,

	
	["energybar"] = true,
	["focusbar"] =  true,
	["manabar"] =  true,
	["ragebar"] = true,
	["runebar"]= true,

	
	["combo"] = {
		["FontOutline"] = true,
		["FontSize"] = 16,	
	},
	
	["extra"] = {
		["FontOutline"] = true,	
		["FontSize"] = 16,
	},
	
	["rune"] = {
		["FontOutline"] = true,
		["FontSize"] = 16,		
	},
	
	["value"] = {	
		["Abbrev"] = true,	
		["FontOutline"] = true,
		["FontSize"] = 15,
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
-- Reminder Buff Options
-------------------------
DB["selfbuffs"] = {
	["enable"] = true,									-- enable selbuffs module.
	["border"] = "BasicUI",
	["playsound"] = true,								-- sound warning
	["sound"] = "Warning",	
}

-------------------------
-- Skinning Options
-------------------------
DB["skin"] = {
	["enable"] = true,
	["border"] = "BasicUI",
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

	["disableFade"] = false,                     		-- Can cause errors or a buggy tooltip!
	["border"] = "BasicUI",
	["background"] = "Black",
	["statusbar"] = "Blizzard",
	["reactionBorderColor"] = true,
	["itemqualityBorderColor"] = true,
	
	["showPlayerTitles"] = true,
	["showPVPIcons"] = false,                        	-- Show pvp icons instead of just a prefix
	["abbrevRealmNames"] = false, 
	["showMouseoverTarget"] = true,
	
	["showItemLevel"] = true,
	
	["healthbar"] = {
		["showHealthValue"] = true,
		["showOutline"] = false,
		["textPos"] = "CENTER",                     -- Possible "TOP" "BOTTOM" "CENTER"	
		["reactionColoring"] = false,
		["customColorapply"] = false, 
        ["custom"] = {
			["apply"] = false,
			["color"] =	{ r = 1, g = 1, b = 0},
		},		
		["fontSize"] = 14,
	},		
}


