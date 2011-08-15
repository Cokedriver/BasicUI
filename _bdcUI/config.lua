local _, bc = ...

bc.config = {
	---------------------
	-- AutoGreed Options
	---------------------
	autogreed = {
		enable = true,
	},
	
	----------------
	-- Buff Options
	----------------
	buff = {
		enable = true,
		scale = 1.2,
	},	
	
	----------------
	-- Castbar 
	----------------
	castbar = {
		enable = true,
	},

	----------------
	-- Chat Options
	----------------
	chat = {
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
	},
	
	-----------------------
	-- Class Color Options
	-----------------------
	colors = {
		enable = true,
	},	

	---------------------
	-- Datatext Options
	---------------------
	datatext = {
	
		enable = true,
		
		datapanel = {	
			enable = true,										-- enable panel/panels	
			border = true,									
		},
		
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
		
	},
	
	-----------------
	-- Macro Options
	-----------------
	macro = {					
		enable = true,			-- enable bigger macros.
	},
	
	-----------------
	-- Media Options
	-----------------
	media = {
		font = 'Fonts\\ARIALN.ttf',
	},	
	
	--------------------
	-- Merchant Options
	--------------------
	merchant = {
		enable = true,			-- enable merchant module.
		sellMisc = true, 		-- allows the user to add spacific items to sell at merchant (please see the local filter in merchant.lua)
		autoSellGrey = true,	-- autosell grey items at merchant.
		autoRepair = true,		-- autorepair at merchant.
	},
	
	------------------
	--Minimap Options
	------------------
	minimap = {
		enable = true,
	},
	
	------------------
	-- OmniCC Options
	------------------
	omnicc = {
		enable = true,
	},
	
	--------------------
	-- Powerbar Options 
	--------------------
	power = {
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
	},	
	
	-----------------
	-- Quest Options
	-----------------
	quest = {
		enable = true,			-- enable quest module.
		autocomplete = false,	-- enable the autoaccept quest and autocomplete quest if no reward.
	},

	---------------------------
	-- Unitframe Scale Options
	---------------------------
	scale = {
		enable = true,
		size = 1.15,
	},
	
	----------------
	--Range Options
	----------------
	range = {
		enable = true,
	},
	-------------------------
	-- Reminder Buff Options
	-------------------------
	selfbuffs = {
		enable = true,			-- enable selbuffs module.
		sound = true,			-- sound warning
	},

	-------------------------
	-- Slash Command Options
	-------------------------
	slash = {
		enable = true,
	},

	---------------------
	-- Threatbar Options
	---------------------
	threatbar = {
		enable = true,										-- Enable the threatbar over the Center Panel.
	},
	
	-------------------
	-- Tooltip Options
	-------------------
	tooltip = {											
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
	},

	-------------------------------
	-- Localization (source Tukui)
	-------------------------------
	L = {
		datatext_download = 'Download: ',
		datatext_bandwidth = 'Bandwidth: ',
		datatext_guild = 'Guild',
		datatext_noguild = 'No Guild',
		datatext_bags = 'Bags: ',
		datatext_friends = 'Friends',
		datatext_online = 'Online: ',
		datatext_armor = 'Dur',
		datatext_earned = 'Earned:',
		datatext_spent = 'Spent:',
		datatext_deficit = 'Deficit:',
		datatext_profit = 'Profit:',
		datatext_timeto = 'Time to',
		datatext_friendlist = 'Friends list:',
		datatext_playersp = 'SP: ',
		datatext_playerap = 'AP: ',
		datatext_playerhaste = 'Haste',
		datatext_dps = 'DPS',
		datatext_hps = 'HPS',
		datatext_playerarp = 'ArP',
		datatext_session = 'Session: ',
		datatext_character = 'Character: ',
		datatext_server = 'Server: ',
		datatext_totalgold = 'Total: ',
		datatext_savedraid = 'Saved Raid(s)',
		datatext_currency = 'Currency:',
		datatext_fps = 'FPS: ',
		datatext_ms = ' MS: ',
		datatext_playercrit = 'Crit: ',
		datatext_playerheal = 'Heal: ',
		datatext_avoidancebreakdown = 'Avoidance Breakdown',
		datatext_lvl = 'lvl',
		datatext_boss = 'Boss',
		datatext_miss = 'Miss',
		datatext_dodge = 'Dodge',
		datatext_block = 'Block',
		datatext_parry = 'Parry',
		datatext_playeravd = 'AVD: ',
		datatext_servertime = 'Server Time: ',
		datatext_localtime = 'Local Time: ',
		datatext_mitigation = 'Mitigation By Level: ',
		datatext_healing = 'Healing : ',
		datatext_damage = 'Damage : ',
		datatext_honor = 'Honor : ',
		datatext_killingblows = 'Killing Blows : ',
		datatext_ttstatsfor = 'Stats for ',
		datatext_ttkillingblows = 'Killing Blows:',
		datatext_tthonorkills = 'Honorable Kills:',
		datatext_ttdeaths = 'Deaths:',
		datatext_tthonorgain = 'Honor Gained:',
		datatext_ttdmgdone = 'Damage Done:',
		datatext_tthealdone = 'Healing Done:',
		datatext_basesassaulted = 'Bases Assaulted:',
		datatext_basesdefended = 'Bases Defended:',
		datatext_towersassaulted = 'Towers Assaulted:',
		datatext_towersdefended = 'Towers Defended:',
		datatext_flagscaptured = 'Flags Captured:',
		datatext_flagsreturned = 'Flags Returned:',
		datatext_graveyardsassaulted = 'Graveyards Assaulted:',
		datatext_graveyardsdefended = 'Graveyards Defended:',
		datatext_demolishersdestroyed = 'Demolishers Destroyed:',
		datatext_gatesdestroyed = 'Gates Destroyed:',
		datatext_totalmemusage = 'Total Memory Usage:',
		datatext_control = 'Controlled by:',
		datatext_homelatency = 'Home Latency: ',
		datatext_worldlatency = 'World Latency: ',
		datatext_cta_allunavailable = 'Could not get Call To Arms information.',
		datatext_cta_nodungeons = 'No dungeons are currently offering a Call To Arms.',
		
		goldabbrev = '|cffffd700g|r',
		silverabbrev = '|cffc7c7cfs|r',
		copperabbrev = '|cffeda55fc|r',
		
		unitframes_ouf_threattext = 'Threat on current target:',

		
		Slots = {
			[1] = {1, 'Head', 1000},
			[2] = {3, 'Shoulder', 1000},
			[3] = {5, 'Chest', 1000},
			[4] = {6, 'Waist', 1000},
			[5] = {9, 'Wrist', 1000},
			[6] = {10, 'Hands', 1000},
			[7] = {7, 'Legs', 1000},
			[8] = {8, 'Feet', 1000},
			[9] = {16, 'Main Hand', 1000},
			[10] = {17, 'Off Hand', 1000},
			[11] = {18, 'Ranged', 1000}
		},
	},

		
}	