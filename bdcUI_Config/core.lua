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
			powerbar = DB["powerbar"],			
			quest = DB["quest"],
			selfbuffs = DB["selfbuffs"],
			tooltip = DB["tooltip"],
		},
		global = {
			BlackBook = {
				alts = {},
			},
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
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
	db = self.db.profile
	
	self:SetupOptions()
end

function bdcUIConfig:RefreshConfig(db, name)
	db = self.db.profile
	self:Print("Profile changed.")
	self:updateConfig(true)
	
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
	
	bdcUIConfig.Options = {
		type = "group",
		name = "bdcUI",
		handler = bdcUI,
		childGroups = "tree",
		args = {
			general = {
				order = 1,
				type = "group",
				name = L["General Options"],
				desc = L["GENERAL_DESC"],
				childGroups = "tree",
				get = function(info) return db.general[ info[#info] ] end,
				set = function(info, value) db.general[ info[#info] ] = value;  end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["GENERAL_DESC"],
					},
					autogreed = {
						order = 2,
						name = L["Autogreed"],
						desc = L["Enables Automatically rolling greed on green items when in a instance."],
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
					range = {
						order = 5,
						name = L["Range"],
						desc = L["Enables action buttons to turn red when target is out of range."],
						type = "toggle",						
					},
					slash = {
						order = 6,
						name = L["Slash"],
						desc = L["Enables slash commands."],
						type = "toggle",						
					},
					mail = {
						type = "group",
						order = 7,
						name = L["Mail"],
						desc = L["MAIL_DESC"],
						guiInline = true,
						get = function(info) return db.general.mail[ info[#info] ] end,
						set = function(info, value) db.general.mail[ info[#info] ] = value;  end,
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["MAIL_DESC"],
							},					
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Mail Module"],
								type = "toggle",								
							},						
							gold = {
								order = 3,
								name = L["Gold"],
								desc = L["Enables Gold Collect Button on Mailbox."],
								type = "toggle",
								disabled = function() return not db.general.mail.enable end,
							},
							item = {
								order = 4,
								name = L["Item"],
								desc = L["Enables Item Collect Button on Mailbox"],
								type = "toggle",
								disabled = function() return not db.general.mail.enable end,
							},
							openall = {
								order = 5,
								name = L["Open All"],
								desc = L["Enables Open All Collect Button on Mailbox"],
								type = "toggle",
								disabled = function() return not db.general.mail.enable end,
							},							
						},
					},					
					scale = {
						type = "group",
						order = 8,
						name = L["Unitframe Scale"],
						desc = L["SCALE_DESC"],	
						guiInline = true,
						get = function(info) return db.general.scale[ info[#info] ] end,
						set = function(info, value) db.general.scale[ info[#info] ] = value;  end,						
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
				childGroups = "tree",
				get = function(info) return db.buff[ info[#info] ] end,
				set = function(info, value) db.buff[ info[#info] ] = value;  end,				
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
						order = 4,
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
				childGroups = "tree",
				get = function(info) return db.chat[ info[#info] ] end,
				set = function(info, value) db.chat[ info[#info] ] = value;  end,				
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
						desc = L["TAB_DESC"],
						guiInline = true,
						disabled = function() return not db.chat.enable end,
						get = function(info) return db.chat.tab[ info[#info] ] end,
						set = function(info, value) db.chat.tab[ info[#info] ] = value;  end,					
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
				childGroups = "tree",
				get = function(info) return db.datatext[ info[#info] ] end,
				set = function(info, value) db.datatext[ info[#info] ] = value;  end,				
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
					time24 = {
						order = 3,
						type = "toggle",
						name = L["24-Hour Time"],
						desc = L["Display time datatext on a 24 hour time scale"],
							disabled = function() return not db.datatext.enable end,					
					},					
					bag = {
						order = 4,
						type = "toggle",
						name = L["Bag Open"],
						desc = L["Checked opens Backpack only, Unchecked opens all bags."],
						disabled = function() return not db.datatext.enable end,						
					},				
					battleground = {
						order = 5,
						type = "toggle",
						name = L["Battleground Text"],
						desc = L["Display special datatexts when inside a battleground"],
						disabled = function() return not db.datatext.enable end,						
					},
					top = {
						order = 6,
						name = L["Datapanel"],
						desc = L["If checked then panel moves to top of screen, If unchecked panel moves below MainMenuBar"],
						type = "toggle",
						disabled = function() return not db.datatext.enable end,						
					},					
					localtime = {
						order = 7,
						type = "toggle",
						name = L["Local Time"],
						desc = L["Display local time instead of server time"],
						disabled = function() return not db.datatext.enable end,						
					},
					threatbar = {
						order = 8,
						type = "toggle",
						name = L["Threatbar"],
						desc = L["Display Threat Text in center of panel."],
						disabled = function() return not db.datatext.enable end,						
					},
					fontsize = {
						order = 9,
						name = L["Font Scale"],
						desc = L["Font size for datatexts"],
						type = "range",
						min = 9, max = 25, step = 1,
						disabled = function() return not db.datatext.enable end,						
					},					
					colors = {
						order = 10,
						type = "group",
						name = L["Text Colors"],
						guiInline = true,
						get = function(info) return db.datatext.colors[ info[#info] ] end,
						set = function(info, value) db.datatext.colors[ info[#info] ] = value;  end,							
						disabled = function() return not db.datatext.enable end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Datatext Text Colors."],
							},						
							classcolor = {
								order = 2,
								type = "toggle",
								name = L["Class Color"],
								desc = L["Color the datatext values based on your class"],
								disabled = function() return not db.datatext.enable end,						
							},
							color = {
								type = "color",
								name = L["Custom Color"],
								desc = L["Picks a Custom Color for the datatext values."],
								hasAlpha = false,
								disabled = function() return db.datatext.colors.classcolor end,
								get = function(info)
									local dt = db.datatext.colors[ info[#info] ]
									return dt.r, dt.g, dt.b
								end,
								set = function(info, r, g, b)
									db.datatext.colors[ info[#info] ] = {}
									local dt = db.datatext.colors[ info[#info] ]
									dt.r, dt.g, dt.b = r, g, b
									
								end,					
							},								
						},
					},					
					DataGroup = {
						order = 11,
						type = "group",
						name = L["Text Positions"],
						childGroups = "tree",
						disabled = function() return not db.datatext.enable end,						
						args = {
							bags = {
								order = 1,
								type = "range",
								name = L["Bags"],
								desc = L["Display ammount of bag space"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							calltoarms = {
								order = 2,
								type = "range",
								name = L["Call to Arms"],
								desc = L["Display the active roles that will recieve a reward for completing a random dungeon"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,																
							},
							coords = {
								order = 3,
								type = "range",
								name = L["Coordinates"],
								desc = L["Display Player's Coordinates"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,																
							},
							currency = {
								order = 4,
								type = "range",
								name = L["Currency"],
								desc = L["Display current watched items in backpack"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},							
							dps_text = {
								order = 5,
								type = "range",
								name = L["DPS"],
								desc = L["Display ammount of DPS"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,																
							},						
							dur = {
								order = 6,
								type = "range",
								name = L["Durability"],
								desc = L["Display your current durability"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,
							},
							friends = {
								order = 7,
								type = "range",
								name = L["Friends"],
								desc = L["Display current online friends"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							gold = {
								order = 8,
								type = "range",
								name = L["Gold"],
								desc = L["Display current gold"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							guild = {
								order = 9,
								type = "range",
								name = L["Guild"],
								desc = L["Display current online people in guild"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							hps_text = {
								order = 10,
								type = "range",
								name = L["HPS"],
								desc = L["Display ammount of HPS"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							micromenu = {
								order = 11,
								type = "range",
								name = L["Micromenu"],
								desc = L["Display the Micromenu"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,								
							},
							pro = {
								order = 12,
								type = "range",
								name = L["Professions"],
								desc = L["Display Professions"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							recount = {
								order = 13,
								type = "range",
								name = L["Recount"],
								desc = L["Display Recount's DPS (RECOUNT MUST BE INSTALLED)"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,								
							},							
							recountraiddps = {
								order = 14,
								type = "range",
								name = L["Recount Raid DPS"],
								desc = L["Display Recount's Raid DPS (RECOUNT MUST BE INSTALLED)"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,																
							},
							spec = {
								order = 15,
								type = "range",
								name = L["Talent Spec"],
								desc = L["Display current spec"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							stat1 = {
								order = 16,
								type = "range",
								name = L["Stat #1"],
								desc = L["Display stat based on your role (Avoidance-Tank, AP-Melee, SP/HP-Caster)"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,			
							},							
							stat2 = {
								order = 17,
								type = "range",
								name = L["Stat #2"],
								desc = L["Display stat based on your role (Armor-Tank, Crit-Melee, Crit-Caster)"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,						
							},
							system = {
								order = 18,
								type = "range",
								name = L["System"],
								desc = L["Display FPS and Latency"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							wowtime = {
								order = 19,
								type = "range",
								name = L["Time"],
								desc = L["Display current time"]..L["DATATEXT_POS"],
								min = 0, max = 9, step = 1,															
							},
							zone = {
								order = 20,
								type = "range",
								name = L["Zone"],
								desc = L["Display Player's Current Zone."]..L["DATATEXT_POS"],
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
				childGroups = "tree",
				get = function(info) return db.merchant[ info[#info] ] end,
				set = function(info, value) db.merchant[ info[#info] ] = value;  end,					
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
					autoRepair = {
						type = "toggle",
						order = 3,
						name = L["Auto Repair"],
						desc = L["Automatically repair when visiting a vendor"],
						disabled = function() return not db.merchant.enable end,
					},
					autoSellGrey = {
						type = "toggle",
						order = 4,
						name = L["Sell Grays"],
						desc = L["Automatically sell gray items when visiting a vendor"],
						disabled = function() return not db.merchant.enable end,
					},					
					sellMisc = {
						type = "toggle",
						order = 5,
						name = L["Sell Misc Items"],
						desc = L["Automatically sell a user selected item."],
						disabled = function() return not db.merchant.enable end,
					},
				},
			},
			powerbar = {
				order = 7,
				type = "group",
				name = L["Powerbar Options"],
				desc = L["POWER_DESC"],
				childGroups = "tree",
				get = function(info) return db.powerbar[ info[#info] ] end,
				set = function(info, value) db.powerbar[ info[#info] ] = value;  end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["POWER_DESC"],
					},			
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Powerbar Module"],
						type = "toggle",							
					},
					showCombatRegen = {
						order = 3,
						name = L["CombatRegen"],
						desc = L["Shows a players Regen while in combat."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showSoulshards = {
						order = 4,
						name = L["Soulshards"],
						desc = L["Shows Shards as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showHolypower = {
						order = 5,
						name = L["Holypower"],
						desc = L["Shows Holypower as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showComboPoints = {
						order = 6,
						name = L["ComboPoints"],
						desc = L["Shows ComboPoints as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showRuneCooldown = {
						order = 7,
						name = L["Rune Cooldown"],
						desc = L["Shows Runes cooldowns as numbers."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					energybar = {
						order = 8,
						name = L["Energybar"],
						desc = L["Shows Energy Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					focusbar = {
						order = 9,
						name = L["Focusbar"],
						desc = L["Shows Focus Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					manabar = {
						order = 10,
						name = L["Manabar"],
						desc = L["Shows Mana Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					ragebar = {
						order = 11,
						name = L["Ragebar"],
						desc = L["Shows Rage Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					runebar = {
						order = 12,
						name = L["Runebar"],
						desc = L["Shows Rune Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					sizeWidth= {
						order = 13,
						name = L["Width"],
						desc = L["Controls the width of Powerbar."],
						type = "range",
						min = 50, max = 350, step = 25,
						disabled = function() return not db.powerbar.enable end,
					},					
					combo = {
						type = "group",
						order = 14,
						name = L["Combo"],
						desc = L["COMBO_DESC"],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.combo[ info[#info] ] end,
						set = function(info, value) db.powerbar.combo[ info[#info] ] = value;  end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["COMBO_DESC"],
							},											
							FontOutline = {
								order = 2,
								name = L["Font Outline"],
								desc = L["Adds a font outline to ComboPoints."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							FontSize= {
								order = 3,
								name = L["Font Size"],
								desc = L["Controls the ComboPoints font size."],
								type = "range",
								min = 8, max = 25, step = 1,
								disabled = function() return not db.powerbar.enable end,
							},						
						},
					},
					extra = {
						type = "group",
						order = 15,
						name = L["Extra"],
						desc = L["Extra_DESC"],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.extra[ info[#info] ] end,
						set = function(info, value) db.powerbar.extra[ info[#info] ] = value;  end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Extra_DESC"],
							},						
							FontOutline = {
								order = 2,
								name = L["Font Outline"],
								desc = L["Adds a font outline to Extra."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
								FontSize= {
								order = 3,
								name = L["Font Size"],
								desc = L["Controls the Extra font size."],
								type = "range",
								min = 8, max = 25, step = 1,
								disabled = function() return not db.powerbar.enable end,
							},						
						},
					},
					rune = {
						type = "group",
						order = 16,
						name = L["Rune"],
						desc = L["RUNE_DESC"],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.rune[ info[#info] ] end,
						set = function(info, value) db.powerbar.rune[ info[#info] ] = value;  end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["RUNE_DESC"],
							},						
							FontOutline = {
								order = 2,
								name = L["Font Outline"],
								desc = L["Adds a font outline to Runes."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							FontSize= {
								order = 3,
								name = L["Font Size"],
								desc = L["Controls the Runes font size."],
								type = "range",
								min = 8, max = 25, step = 1,
								disabled = function() return not db.powerbar.enable end,
							},						
						},
					},					
					value = {
						type = "group",
						order = 17,
						name = L["Value"],
						desc = L["VALUE_DESC"],
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.value[ info[#info] ] end,
						set = function(info, value) db.powerbar.value[ info[#info] ] = value;  end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["VALUE_DESC"],
							},						
							Abbrev = {
								order = 2,
								name = L["Abbrev"],
								desc = L["Abbreviates the value. 17000 = 17K"],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							FontOutline = {
								order = 3,
								name = L["Font Outline"],
								desc = L["Adds a font outline to value."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							FontSize= {
								order = 4,
								name = L["Font Size"],
								desc = L["Controls the value font size."],
								type = "range",
								min = 8, max = 25, step = 1,
								disabled = function() return not db.powerbar.enable end,
							},							
						},
					},
				},
			},
			quest = {
				order = 7,
				type = "group",
				name = L["Quest Options"],
				desc = L["QUEST_DESC"],
				childGroups = "tree",
				get = function(info) return db.quest[ info[#info] ] end,
				set = function(info, value) db.quest[ info[#info] ] = value;  end,					
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
				childGroups = "tree",
				get = function(info) return db.selfbuffs[ info[#info] ] end,
				set = function(info, value) db.selfbuffs[ info[#info] ] = value;  end,					
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
			tooltip = {
				order = 8,
				type = "group",
				name = L["Tooltip Options"],
				desc = L["TOOLTIP_DESC"],
				childGroups = "tree",
				get = function(info) return db.tooltip[ info[#info] ] end,
				set = function(info, value) db.tooltip[ info[#info] ] = value;  end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["TOOLTIP_DESC"],
					},			
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Tooltip Module"],
						type = "toggle",							
					},					
					disableFade = {
						order = 3,
						name = L["Disable Fade"],
						desc = L["Disables Tooltip Fade."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					reactionBorderColor = {
						order = 4,
						name = L["Reaction Border Color"],
						desc = L["Colors the borders match targets classcolors."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable or not db.general.colors end,
					},
					itemqualityBorderColor = {
						order = 5,
						name = L["Item Quality Border Color"],
						desc = L["Colors the border of the tooltip to match the items quality."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					showPlayerTitles = {
						order = 6,
						name = L["Player Titles"],
						desc = L["Shows players title in tooltip."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					showPVPIcons = {
						order = 7,
						name = L["PVP Icons"],
						desc = L["Shows PvP Icons in tooltip."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					abbrevRealmNames = {
						order = 8,
						name = L["Abberviate Realm Names"],
						desc = L["Abberviates Players Realm Name."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					showMouseoverTarget = {
						order = 9,
						name = L["Mouseover Target"],
						desc = L["Shows mouseover target."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					showItemLevel = {
						order = 10,
						name = L["Item Level"],
						desc = L["Shows targets average item level."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					healthbar = {
						type = "group",
						order = 11,
						name = L["Healthbar"],
						desc = L["HEALTH_DESC"],
						guiInline = true,
						disabled = function() return not db.tooltip.enable end,
						get = function(info) return db.tooltip.healthbar[ info[#info] ] end,
						set = function(info, value) db.tooltip.healthbar[ info[#info] ] = value;  end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["HEALTH_DESC"],
							},						
							showHealthValue = {
								order = 2,
								name = L["Health Value"],
								desc = L["Shows health value over healthbar."],
								type = "toggle",
								disabled = function() return not db.tooltip.enable end,
							},
							showOutline = {
								order = 3,
								name = L["Font Outline"],
								desc = L["Adds a font outline to health value."],
								type = "toggle",
								disabled = function() return not db.tooltip.enable end,
							},
							reactionColoring = {
								order = 4,
								name = L["Reaction Coloring"],
								desc = L["Change healthbar color to targets classcolor. (Overides Custom Color)"],
								type = "toggle",
								width = "full",
								disabled = function() return not db.tooltip.enable or not db.general.colors end,
							},														
							custom = {
								type = "group",
								order = 5,
								name = L["Custom"],
								desc = L["Custom Coloring"],
								guiInline = true,
								disabled = function() return not db.tooltip.enable end,
								get = function(info) return db.tooltip.healthbar.custom[ info[#info] ] end,
								set = function(info, value) db.tooltip.healthbar.custom[ info[#info] ] = value;  end,						
								args = {							
									apply = {
										order = 1,
										name = L["Apply Custom Color"],
										desc = L["Use the Custom Color you have chosen."],
										type = "toggle",
										disabled = function() return not db.tooltip.enable end,
									},
									color = {
										order = 2,
										type = "color",
										name = L["Custom Color"],
										desc = L["Picks a Custom Color for the tooltip border."],
										hasAlpha = false,
										disabled = function() return not db.tooltip.healthbar.custom.apply or not db.tooltip.enable end,
										get = function(info)
											local hb = db.tooltip.healthbar.custom[ info[#info] ]
											return hb.r, hb.g, hb.b
										end,
										set = function(info, r, g, b)
											db.tooltip.healthbar.custom[ info[#info] ] = {}
											local hb = db.tooltip.healthbar.custom[ info[#info] ]
											hb.r, hb.g, hb.b = r, g, b
											
										end,					
									},
								},
							},
							textPos = {
								order = 6,
								name = L["Text Position"],
								desc = L["Health Value Position."],
								disabled = function() return not db.tooltip.enable end,
								type = "select",
								values = {
									["BOTTOM"] = L["BOTTOM"],
									["CENTER"] = L["CENTER"],
									["TOP"] = L["TOP"],
								},
							},						
							fontSize= {
								order = 7,
								name = L["Font Size"],
								desc = L["Controls the healthbar value font size."],
								type = "range",
								min = 8, max = 25, step = 1,
								disabled = function() return not db.tooltip.enable end,
							},							
						},
					},					
				},
			},
			bdcUI_Header = {
				order = 1,
				type = "header",
				name = L["FOR CHANGES TO TAKE EFFECT PLEASE CLICK |cff00B4FFAPPLY CHANGES|r BUTTON"],			
				width = "full",		
			},			
			reloadUI = {
				type = "execute",
				name = "APPLY CHANGES",
				desc = "Apply changes you made to the UI.",
				order = 3,
				--pos = "center",
				func = 	function()
					ReloadUI()
				end,
			},			
		},		
	}
end