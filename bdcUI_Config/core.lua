local bdcUIConfig = LibStub("AceAddon-3.0"):NewAddon("bdcUIConfig", "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("bdcUIConfig", false)
local LSM = LibStub("LibSharedMedia-3.0")
local db
local defaults

function bdcUIConfig:LoadDefaults()
	local B, _, _, DB = unpack(bdcUI)
	--Defaults
	defaults = {
		profile = {
			general = DB["general"],
			buff = DB["buff"],
			chat = DB["chat"],	
			datatext = DB["datatext"],			
			merchant = DB["merchant"],
			--powerbar = DB["powerbar"],			
			quest = DB["quest"],
			selfbuffs = DB["selfbuffs"],
			--tooltip = DB["tooltip"],
		},
	}
end	

function bdcUIConfig:OnInitialize()	
	bdcUIConfig:RegisterChatCommand("bc", "ShowConfig")
	bdcUIConfig:RegisterChatCommand("bdcUI", "ShowConfig")
	
	self.OnInitialize = nil
end

function bdcUIConfig:ShowConfig(arg)
	InterfaceOptionsFrame_OpenToCategory(self.profilesFrame)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end

function bdcUIConfig:Load()
	self:LoadDefaults()

	-- Create savedvariables
	self.db = LibStub("AceDB-3.0"):New("bdcUIConfig", defaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChanged")
	db = self.db.profile
	
	self:SetupOptions()
end

function bdcUIConfig:OnProfileChanged(event, database, newProfileKey)
	StaticPopup_Show("CFG_RELOAD")
end

function bdcUIConfig:SetupOptions()
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("bdcUIConfig", self.GenerateOptions)
	--Create Profiles Table
	self.profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
	LibStub("AceConfig-3.0"):RegisterOptionsTable("bdcUIProfiles", self.profileOptions)
	
	-- Setup our UI's options in the Blizzard Interface Options
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("bdcUIConfig", "bdcUI");
	self.profilesFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("bdcUIProfiles", L["Profiles"], "bdcUI");	
	self.SetupOptions = nil
end

function bdcUIConfig.GenerateOptions()
	if bdcUIConfig.noconfig then assert(false, bdcUIConfig.noconfig) end
	if not bdcUIConfig.Options then
		bdcUIConfig.GenerateOptionsInternal()
		bdcUIConfig.GenerateOptionsInternal = nil
	end
	return bdcUIConfig.Options
end

function bdcUIConfig.GenerateOptionsInternal()
	local B, C, _, DB = unpack(bdcUI)

	StaticPopupDialogs["CFG_RELOAD"] = {
		text = L["CFG_RELOAD"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function() ReloadUI() end,
		timeout = 0,
		whileDead = 1,
	}

	bdcUIConfig.Options = {
		type = "group",
		name = "bdcUI",
		handler = bdcUI,
		args = {
			general = {
				order = 1,
				type = "group",
				name = L["General Options"],
				desc = L["GENERAL_DESC"],
				guiInline = true,
				get = function(info) return db.general[ info[#info] ] end,
				set = function(info, value) db.general[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 0,
						type = "description",
						name = L["GENERAL_DESC"],
					},
					autogreed = {
						order = 2,
						name = L["Autogreed"],
						desc = L["Enables Automaticly rolling greed on green items when in a instance."],
						type = "toggle",							
					},
					colors = {
						order = 3,
						name = L["Colors"],
						desc = L["Enables class colors for UI."],
						type = "toggle",						
					},
					cooldown = {
						order = 4,
						name = L["Cooldown"],
						desc = L["Enables cooldown counts on action buttons."],
						type = "toggle",						
					},
					macro = {
						order = 5,
						name = L["Macro"],
						desc = L["Enables user to creat macros up to 1500 charactors."],
						type = "toggle",							
					},
					range = {
						order = 6,
						name = L["Range"],
						desc = L["Enables action buttons to turn red when target is out of range."],
						type = "toggle",						
					},
					slash = {
						order = 7,
						name = L["Slash"],
						desc = L["Enables slash commands."],
						type = "toggle",						
					},					
					scale = {
						type = "group",
						order = 8,
						name = L["Unitframe Scale"],
						desc = L["SCALE_DESC"],	
						guiInline = true,
						get = function(info) return db.general.scale[ info[#info] ] end,
						set = function(info, value) db.general.scale[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["SCALE_DESC"],
							},					
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Scale Module"],
								type = "toggle",								
							},						
							size = {
								order = 3,
								name = L["Size"],
								desc = L["Controls the scaling of Blizzard's Unit Frames"],
								type = "range",
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.general.scale.enable end,
							},
						},
					},
				},
			},
			buff = {
				order = 2,
				type = "group",
				name = L["Buff Options"],
				desc = L["BUFF_DESC"],
				guiInline = true,
				get = function(info) return db.buff[ info[#info] ] end,
				set = function(info, value) db.buff[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["BUFF_DESC"],
					},			
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Buff Module"],
						type = "toggle",							
					},					
					scale = {
						order = 3,
						name = L["Scale"],
						desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 0.5, max = 2, step = 0.1,
						disabled = function() return not db.buff.enable end,
					},
				},
			},
			chat = {
				order = 3,
				type = "group",
				name = L["Chat Options"],
				desc = L["CHAT_DESC"],
				guiInline = true,
				get = function(info) return db.chat[ info[#info] ] end,
				set = function(info, value) db.chat[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["CHAT_DESC"],
					},			
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Chat Module."],
						type = "toggle",							
					},
					disableFade = {
						order = 3,
						name = L["Disable Fade"],
						desc = L["Disables Chat Fading."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},
					chatOutline = {
						order = 4,
						name = L["Chat Outline"],
						desc = L["Outlines the chat Text."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},
					enableBottomButton = {
						order = 5,
						name = L["Enable Bottom Button"],
						desc = L["Enables the scroll down button in the lower right hand corner."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},
					enableHyperlinkTooltip = {
						order = 6,
						name = L["Enable Hyplerlink Tooltip"],
						desc = L["Enables the mouseover items in chat tooltip."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},
					enableBorderColoring = {
						order = 7,
						name = L["Enable Editbox Channel Border Coloring"],
						desc = L["Enables the coloring of the border to the edit box to match what channel you are typing in."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},					
					tab = {
						type = "group",
						order = 8,
						name = L["Tabs"],
						guiInline = true,
						desc = L["TAB_DESC"],
						disabled = function() return not db.chat.enable end,
						get = function(info) return db.chat.tab[ info[#info] ] end,
						set = function(info, value) db.chat.tab[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["TAB_DESC"],
							},					
							fontSize = {
								type = "range",
								order = 2,
								name = L["Font Scale"],
								desc = L["Controls the size of the tab font"],
								type = "range",
								min = 9, max = 20, step = 1,									
							},
							fontOutline = {
								order = 3,
								name = L["Outline Tab Font"],
								desc = L["Enables the outlineing of tab font."],
								type = "toggle",								
							},						
						},
					},
				},
			},			
			datatext = {
				order = 5,
				type = "group",
				name = L["Datatext Options"],
				desc = L["DATATEXT_DESC"],
				guiInline = true,
				get = function(info) return db.datatext[ info[#info] ] end,
				set = function(info, value) db.datatext[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["DATATEXT_DESC"],
					},
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Datatext Module."],
						type = "toggle",							
					},
					datapanel = {
						order = 3,
						name = L["Datapanel"],
						desc = L["Enables Datapanel Module."],
						type = "toggle",
						disabled = function() return not db.datatext.enable end,
					},
					top = {
						order = 3,
						name = L["Datapanel Location"],
						desc = L["Checked puts panel on top of the screen, Unchecked puts panel below MainMenuBar."],
						type = "toggle",
						disabled = function() return not db.datatext.enable end,						
					},					
					battleground = {
						order = 4,
						type = "toggle",
						name = L["BG Text"],
						desc = L["Display special datatexts when inside a battleground"],
						disabled = function() return not db.datatext.enable end,						
					},
					fontsize = {
						order = 5,
						name = L["Font Scale"],
						desc = L["Font size for datatexts"],
						type = "range",
						min = 9, max = 25, step = 1,
						disabled = function() return not db.datatext.enable end,						
					},
					time24 = {
						order = 6,
						type = "toggle",
						name = L["24-Hour Time"],
						desc = L["Display time datatext on a 24 hour time scale"],
							disabled = function() return not db.datatext.enable end,					
					},
					localtime = {
						order = 7,
						type = "toggle",
						name = L["Local Time"],
						desc = L["Display local time instead of server time"],
						disabled = function() return not db.datatext.enable end,						
						disabled = function() return db.datatext.wowtime == 0 end,
					},
					threatbar = {
						order = 8,
						type = "toggle",
						name = L["Threatbar"],
						desc = L["Display Threat Text in center of panel."],
						disabled = function() return not db.datatext.enable end,						
					},					
					classcolor = {
						order = 9,
						type = "toggle",
						name = L["Class Color"],
						desc = L["Color the datatext values based on your class"],
						disabled = function() return not db.datatext.enable end,						
					},
					bag = {
						order = 10,
						type = "toggle",
						name = L["Bag Open"],
						desc = L["Checked opens Backpack only, Unchecked opens all bags."],
						disabled = function() return not db.datatext.enable end,						
					},					
					DataGroup = {
						order = 11,
						type = "group",
						name = L["Text Positions"],
						guiInline = true,
						disabled = function() return not db.datatext.enable end,						
						args = {
							stat1 = {
								order = 1,
								type = "range",
								name = L["Stat #1"],
								desc = L["Display stat based on your role (Avoidance-Tank, AP-Melee, SP/HP-Caster)"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,			
							},
							dur = {
								order = 2,
								type = "range",
								name = L["Durability"],
								desc = L["Display your current durability"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,
							},
							stat2 = {
								order = 3,
								type = "range",
								name = L["Stat #2"],
								desc = L["Display stat based on your role (Armor-Tank, Crit-Melee, Crit-Caster)"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,						
							},
							system = {
								order = 4,
								type = "range",
								name = L["System"],
								desc = L["Display FPS and Latency"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							wowtime = {
								order = 5,
								type = "range",
								name = L["Time"],
								desc = L["Display current time"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							gold = {
								order = 6,
								type = "range",
								name = L["Gold"],
								desc = L["Display current gold"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							guild = {
								order = 7,
								type = "range",
								name = L["Guild"],
								desc = L["Display current online people in guild"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							friends = {
								order = 8,
								type = "range",
								name = L["Friends"],
								desc = L["Display current online friends"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							bags = {
								order = 9,
								type = "range",
								name = L["Bags"],
								desc = L["Display ammount of bag space"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							dps_text = {
								order = 10,
								type = "range",
								name = L["DPS"],
								desc = L["Display ammount of DPS"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,																
							},
							hps_text = {
								order = 11,
								type = "range",
								name = L["HPS"],
								desc = L["Display ammount of HPS"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							currency = {
								order = 12,
								type = "range",
								name = L["Currency"],
								desc = L["Display current watched items in backpack"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							spec = {
								order = 13,
								type = "range",
								name = L["Talent Spec"],
								desc = L["Display current spec"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							pro = {
								order = 14,
								type = "range",
								name = L["Professions"],
								desc = L["Display Professions"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							micromenu = {
								order = 15,
								type = "range",
								name = L["Micromenu"],
								desc = L["Display the Micromenu"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,								
							},
							recount = {
								order = 16,
								type = "range",
								name = L["Recount"],
								desc = L["Display Recount's DPS (RECOUNT MUST BE INSTALLED)"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,								
							},							
							recountraiddps = {
								order = 17,
								type = "range",
								name = L["Recount Raid DPS"],
								desc = L["Display Recount's Raid DPS (RECOUNT MUST BE INSTALLED)"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,																
							},
							coords = {
								order = 18,
								type = "range",
								name = L["Coordinates"],
								desc = L["Display Player's Coordinates"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,																
							},
							zone = {
								order = 19,
								type = "range",
								name = L["Zone"],
								desc = L["Display Player's Current Zone."]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							calltoarms = {
								order = 20,
								type = "range",
								name = L["Call to Arms"],
								desc = L["Display the active roles that will recieve a reward for completing a random dungeon"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,																
							},
						},
					},
				},
			},
			merchant = {
				order = 6,
				type = "group",
				name = L["Merchant Options"],
				desc = L["MERCH_DESC"],
				guiInline = true,
				get = function(info) return db.merchant[ info[#info] ] end,
				set = function(info, value) db.merchant[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["MERCH_DESC"],
					},			
					enable = {
						type = "toggle",
						order = 2,
						name = L["Enable"],
						desc = L["Enable Merchant Settings"],							
					},
					sellMisc = {
						type = "toggle",
						order = 3,
						name = L["Sell Misc Items"],
						desc = L["Automatically sell a user selected item."],
						disabled = function() return not db.merchant.enable end,
					},
					autoSellGrey = {
						type = "toggle",
						order = 4,
						name = L["Sell Grays"],
						desc = L["Automatically sell gray items when visiting a vendor"],
						disabled = function() return not db.merchant.enable end,
					},
					autoRepair = {
						type = "toggle",
						order = 5,
						name = L["Auto Repair"],
						desc = L["Automatically repair when visiting a vendor"],
						disabled = function() return not db.merchant.enable end,
					},
				},
			},
			quest = {
				order = 7,
				type = "group",
				name = L["Quest Options"],
				desc = L["QUEST_DESC"],
				guiInline = true,
				get = function(info) return db.quest[ info[#info] ] end,
				set = function(info, value) db.quest[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["QUEST_DESC"],
					},			
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Quest Module"],
						type = "toggle",							
					},					
					autocomplete = {
						order = 3,
						name = L["Autocomplete"],
						desc = L["Automatically complete your quest."],
						type = "toggle",
						disabled = function() return not db.quest.enable end,
					},
				},
			},
			selfbuffs = {
				order = 8,
				type = "group",
				name = L["Selfbuff Options"],
				desc = L["SELFBUFF_DESC"],
				guiInline = true,
				get = function(info) return db.selfbuffs[ info[#info] ] end,
				set = function(info, value) db.selfbuffs[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["SELFBUFF_DESC"],
					},			
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Selfbuff Module"],
						type = "toggle",							
					},					
					sound = {
						order = 3,
						name = L["Sound"],
						desc = L["Play's a warning sound when a players class buff is not applied."],
						type = "toggle",
						disabled = function() return not db.selfbuffs.enable end,
					},
				},
			},					
		},
	}
end


