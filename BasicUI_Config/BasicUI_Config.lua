local BasicUIConfig = LibStub("AceAddon-3.0"):NewAddon("BasicUIConfig", "AceConsole-3.0", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local db
local defaults

local L = setmetatable({}, { __index = function(t,k)
    local v = tostring(k)
    rawset(t, k, v)
    return v
end })

function BasicUIConfig:LoadDefaults()
	local B, _, DB = unpack(BasicUI)
	--Defaults
	defaults = {
		profile = {
			media = DB["media"],
			general = DB["general"],
			buff = DB["buff"],
			castbar = DB['castbar'],
			chat = DB["chat"],	
			datatext = DB["datatext"],		
			merchant = DB["merchant"],
			minimap = DB["minimap"],			
			nameplates = DB["nameplates"],
			powerbar = DB["powerbar"],			
			quest = DB["quest"],
			selfbuffs = DB["selfbuffs"],
			skin = DB["skin"],
			tooltip = DB["tooltip"],
		},
		global = {
			BlackBook = {
				alts = {},
			},
		},		
	}
end	


function BasicUIConfig:OnInitialize()	
	BasicUIConfig:RegisterChatCommand("ui", "ShowConfig")
	BasicUIConfig:RegisterChatCommand("basicui", "ShowConfig")
	
	self.OnInitialize = nil
end

function BasicUIConfig:ShowConfig(arg)
	InterfaceOptionsFrame_OpenToCategory(self.profilesFrame)
	InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end

function BasicUIConfig:Load()
	self:LoadDefaults()

	-- Create savedvariables
	self.db = LibStub("AceDB-3.0"):New("BasicUIConfig", defaults)
	self.db.RegisterCallback(self, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileCopied", "RefreshConfig")
	self.db.RegisterCallback(self, "OnProfileReset", "RefreshConfig")
	db = self.db.profile
	
	self:SetupOptions()
end

function BasicUIConfig:RefreshConfig(db, name)
	db = self.db.profile
	self:Print("Profile changed.")
end

function BasicUIConfig:SetupOptions()
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("BasicUIConfig", self.GenerateOptions)
	--Create Profiles Table
	self.profileOptions = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db);
	LibStub("AceConfig-3.0"):RegisterOptionsTable("BasicUIProfiles", self.profileOptions)
	
	-- Setup our UI's options in the Blizzard Interface Options
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("BasicUIConfig", "|cff00B4FFBasic|rUI");
	self.optionsFrame.default = function() self:SetDefaultOptions(); ReloadUI(); end;
	self.profilesFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("BasicUIProfiles", L["|cff00B4FFBasic|rUI Profiles"], "|cff00B4FFBasic|rUI");	
	self.SetupOptions = nil
end

function BasicUIConfig.GenerateOptions()
	if BasicUIConfig.noconfig then assert(false, BasicUIConfig.noconfig) end
	if not BasicUIConfig.Options then
		BasicUIConfig.GenerateOptionsInternal()
		BasicUIConfig.GenerateOptionsInternal = nil
	end
	return BasicUIConfig.Options
end

function BasicUIConfig.GenerateOptionsInternal()
	local B, C, DB = unpack(BasicUI)
	
	StaticPopupDialogs["CFG_RELOAD"] = {
		text = L["One or more of the changes you have made require a ReloadUI."],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = function() ReloadUI() end,
		timeout = 0,
		whileDead = 1,
	}
	
	BasicUIConfig.Options = {		
		name = "|cff00B4FFBasic|rUI",
		handler = BasicUI,
		type = "group",
		childGroups = "tree",
		args = {
			Header = {
				order = 1,
				type = "header",
				name = L["Welcome to |cff00B4FFBasic|rUI Config Area!"],			
				width = "full",		
			},
			Text = {
				order = 2,
				type = "header",
				name = L["When changes are made a Reload of the UI is needed."],			
				width = "full",		
			},
			sep1 = {
				type = "description",
				name = " ",
				order = 3,
			},			
			Text2 = {
				order = 4,
				type = "description",
				name = L["Special Thanks for |cff00B4FFBasic|rUI goes out to: Neav, Tuks, Elv, Baine, Treeston, and many more."],			
				width = "full",
				fontSize = "large",
			},
			Text3 = {
				order = 5,
				type = "description",
				name = L["Thank you all for your AddOns, coding help, and support in creating |cff00B4FFBasic|rUI."],			
				width = "full",
				fontSize = "large",				
			},
			sep2 = {
				type = "description",
				name = " ",
				order = 6,
			},				
			media = {				
				name = L["|cff00B4FFMedia|r"],
				desc = L["Media Module for |cff00B4FFBasic|rUI."],
				order = 0,				
				type = "group",
				childGroups = "tree",
				get = function(info) return db.media[ info[#info] ] end,
				set = function(info, value) db.media[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					font = {						
						name = L["|cff00B4FFBasic|rUI Font"],
						desc = L["The font that the core of the UI will use"],
						order = 1,
						type = 'select',
						width = "full",
						dialogControl = 'LSM30_Font', --Select your widget here						
						values = AceGUIWidgetLSMlists.font,	
					},
					fontSize = {						
						name = L["Game Font Size"],
						desc = L["Controls the Size of the Game Font"],
						order = 2,
						type = "range",
						min = 0, max = 30, step = 1,
					},					
					fontxSmall = {						
						name = L["Font Extra Small"],
						desc = L["Controls the Size of the Extra Small Font"],
						order = 3,
						type = "range",
						min = 0, max = 30, step = 1,
					},
					fontSmall = {						
						name = L["Font Small"],
						desc = L["Controls the Size of the Small Font"],
						order = 4,
						type = "range",
						min = 0, max = 30, step = 1,
					},
					fontMedium = {
						name = L["Font Medium"],
						desc = L["Controls the Size of Medium Font"],
						order = 5,
						type = "range",						
						min = 0, max = 30, step = 1,
					},
					fontLarge = {
						name = L["Font Large"],
						desc = L["Controls the Size of the Large Font"],
						order = 6,
						type = "range",						
						min = 0, max = 30, step = 1,
					},
					fontHuge = {
						name = L["Font Huge"],
						desc = L["Controls the Size of the Huge Font"],
						order = 7,
						type = "range",						
						min = 0, max = 30, step = 1,
					},				
				},
			},
			general = {
				name = L["|cff00B4FFGeneral|r"],
				desc = L["General Modules for |cff00B4FFBasic|rUI."],
				order = 1,
				type = "group",				
				childGroups = "tree",
				get = function(info) return db.general[ info[#info] ] end,
				set = function(info, value) db.general[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					autogreed = {
						name = L["Autogreed"],
						desc = L["Enables Automatically rolling greed on green items when in a instance."],	
						order = 1,
						type = "toggle",						
					},
					cooldown = {
						name = L["Cooldown"],
						desc = L["Enables cooldown counts on action buttons."],	
						order = 2,
						type = "toggle",						
					},
					slidebar = {
						name = L["AddOn SlideBar"],
						desc = L["Enables the Minimap AddOn Button SlideBar."],	
						order = 3,
						type = "toggle",						
					},
					buttons = {						
						name = L["Actionbar Buttons"],
						desc = L["Actionbar Button Modifications."],
						order = 4,
						type = "group",						
						guiInline = true,
						get = function(info) return db.general.buttons[ info[#info] ] end,
						set = function(info, value) db.general.buttons[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
						args = {					
							enable = {
								name = L["Enable"],
								desc = L["Enables Actionbar Button Module"],
								order = 1,
								type = "toggle",								
							},
							showHotKeys = {
								name = L["Show Hot Keys"],
								desc = L["If Checked Hot Keys will Show."],
								order = 2,
								disabled = function() return not db.general.buttons.enable end,
								type = "toggle",																
							},
							showMacronames = {
								name = L["Show Macro Names"],
								desc = L["If Checked Macros Will Show."],
								order = 3,
								disabled = function() return not db.general.buttons.enable end,
								type = "toggle",																
							},
							color = {														
								name = L["Actionbar Button Color"],
								desc = L["Enables Actionbar Button Color Modifications."],
								order = 4,
								type = "group",
								guiInline = true,
								get = function(info) return db.general.buttons.color[ info[#info] ] end,
								set = function(info, value) db.general.buttons.color[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
								args = {				
									enable = {
										name = L["Enable"],
										desc = L["Enables Coloring"],
										order = 2,
										type = "toggle",										
									},								
									OutOfRange = {
										name = L["Out of Range"],
										desc = L["Picks the Out of Range Button Fade Color."],
										order = 3,
										disabled = function() return not db.general.buttons.enable or not db.general.buttons.color.enable end,
										type = "color",										
										get = function(info)
											local rc = db.general.buttons.color[ info[#info] ]
											return rc.r, rc.g, rc.b
										end,
										set = function(info, r, g, b)
											db.general.buttons.color[ info[#info] ] = {}
											local rc = db.general.buttons.color[ info[#info] ]
											rc.r, rc.g, rc.b = r, g, b
										end,										
									},
									OutOfMana = {
										name = L["Out of Mana"],
										desc = L["Picks the Out of Mana Button Fade Color."],
										order = 4,
										disabled = function() return not db.general.buttons.enable or not db.general.buttons.color.enable end,
										type = "color",										
										get = function(info)
											local mc = db.general.buttons.color[ info[#info] ]
											return mc.r, mc.g, mc.b
										end,
										set = function(info, r, g, b)
											db.general.buttons.color[ info[#info] ] = {}
											local mc = db.general.buttons.color[ info[#info] ]
											mc.r, mc.g, mc.b = r, g, b
										end,									
									},
									NotUsable = {
										name = L["Not Usable"],
										desc = L["Picks the Not Usable Button Fade Color."],
										order = 5,
										disabled = function() return not db.general.buttons.enable or not db.general.buttons.color.enable end,
										type = "color",										
										get = function(info)
											local nu = db.general.buttons.color[ info[#info] ]
											return nu.r, nu.g, nu.b
										end,
										set = function(info, r, g, b)
											db.general.buttons.color[ info[#info] ] = {}
											local nu = db.general.buttons.color[ info[#info] ]
											nu.r, nu.g, nu.b = r, g, b
										end,										
									},
								},
							},
						},
					},
					mail = {											
						name = L["Mail"],
						desc = L["Enables Mailbox Modifications."],
						order = 6,
						type = "group",
						guiInline = true,
						get = function(info) return db.general.mail[ info[#info] ] end,
						set = function(info, value) db.general.mail[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
						args = {					
							enable = {								
								name = L["Enable"],
								desc = L["Enables Mail Module"],
								order = 1,
								type = "toggle",								
							},						
							openall = {
								name = L["Open All"],
								desc = L["Enables Open All Collect Button on Mailbox"],	
								order = 2,
								disabled = function() return not db.general.mail.enable end,
								type = "toggle",																
							},
							BlackBook = {								
								name = L["BlackBook"],
								desc = L["Enables Send Mail Drop Down Menu. (Barrowed from Postal) "],
								order = 3,
								disabled = function() return not db.general.mail.enable end,								
								type = "group",								
								guiInline = true,
								get = function(info) return db.general.mail.BlackBook[ info[#info] ] end,
								set = function(info, value) db.general.mail.BlackBook[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
								args = {					
									enable = {
										name = L["Enable"],
										desc = L["Enables BlackBook Module"],
										order = 1,
										type = "toggle",								
									},
									AutoFill = {										
										name = L["Auto Fill"],
										desc = L["AutoFill Names"],
										order = 2,
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
										type = "toggle",										
									},
									AutoCompleteAlts = {									
										name = L["Auto Complete Alts"],
										desc = L["Mailing list of Alts."],
										order = 3,
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
										type = "toggle",																				
									},
									AutoCompleteRecent = {										
										name = L["Auto Complete Recent"],
										desc = L["Mailing list of Recently Mailed People."],
										order = 4,
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
										type = "toggle",										
									},
									AutoCompleteContacts = {										
										name = L["Auto Complete Contacts"],
										desc = L["Mailing list of Contacts."],
										order = 5,
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
										type = "toggle",										
									},
									AutoCompleteFriends = {
										order = 6,
										name = L["Auto Complete Friends"],
										desc = L["Mailing list of Friends."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									AutoCompleteGuild = {
										order = 7,
										name = L["Auto Complete Guild"],
										desc = L["Mailing list of Guildies."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									ExcludeRandoms = {
										order = 8,
										name = L["Exclude Randoms"],
										desc = L["Mailing list of Random People."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									DisableBlizzardAutoComplete = {
										order = 9,
										name = L["Disable Blizzard Auto Complete"],
										desc = L["Disable blizzards Auto Complete when Typing."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									UseAutoComplete = {
										order = 10,
										name = L["Use Auto Complete"],
										desc = L["Enable Auto Complete when Typing"],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
								},
							},	
						},
					},
					scale = {
						type = "group",
						order = 8,
						name = L["Scale"],
						desc = L["Adjust the scale of Blizzards Unit Frames."],	
						guiInline = true,
						get = function(info) return db.general.scale[ info[#info] ] end,
						set = function(info, value) db.general.scale[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {					
							enable = {
								order = 1,
								name = L["Enable"],
								desc = L["Enables Scale Module"],
								type = "toggle",								
							},						
							playerFrame = {
								order = 2,
								name = L["Player Frame"],
								desc = L["Controls the scaling of Blizzard's Player Frame"],
								type = "range",
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.general.scale.enable end,
							},
							targetFrame = {
								order = 3,
								name = L["Target Frame"],
								desc = L["Controls the scaling of Blizzard's Target Frame"],
								type = "range",
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.general.scale.enable end,
							},
							focusFrame = {
								order = 3,
								name = L["Focus Frame"],
								desc = L["Controls the scaling of Blizzard's Focus Frame"],
								type = "range",
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.general.scale.enable end,
							},
							partyFrame = {
								order = 4,
								name = L["Party Frame"],
								desc = L["Controls the scaling of Blizzard's Party Frames"],
								type = "range",
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.general.scale.enable end,
							},
							partypetFrame = {
								order = 5,
								name = L["Party Pet Frame"],
								desc = L["Controls the scaling of Blizzard's Party Pet Frames"],
								type = "range",
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.general.scale.enable end,
							},
							arenaFrame = {
								order = 6,
								name = L["Arena Frame"],
								desc = L["Controls the scaling of Blizzard's Arena Frames"],
								type = "range",
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.general.scale.enable end,
							},
							bossFrame = {
								order = 7,
								name = L["Boss Frame"],
								desc = L["Controls the scaling of Blizzard's Boss Frames"],
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
				name = L["|cff00B4FFBuff|r"],
				desc = L["Buff Module for |cff00B4FFBasic|rUI."],
				get = function(info) return db.buff[ info[#info] ] end,
				set = function(info, value) db.buff[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {		
					enable = {
						order = 1,
						name = L["Enable"],
						desc = L["Enables Buff Module."],
						type = "toggle",
						width = "full",						
					},
					border = {
						name = L["Border Style."],
						desc = L["Choose the Border Style"],
						order = 2,
						disabled = function() return not db.buff.enable end,
						type = 'select',
						dialogControl = 'LSM30_Border',
						width = "full",						
						values = AceGUIWidgetLSMlists.border,								
					},									
					buffSize = {
						order = 4,
						name = L["Buff Size"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 1, max = 50, step = 1,
						disabled = function() return not db.buff.enable end,
					},
					buffScale = {
						order = 5,
						name = L["Buff Scale"],
						--desc = L["Controls the scaling of the Buff Frames"],
						type = "range",
						min = 0.5, max = 5, step = 0.05,
						disabled = function() return not db.buff.enable end,
					},
					buffFontSize = {
						order = 6,
						name = L["Buff Font Size"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 8, max = 25, step = 1,
						disabled = function() return not db.buff.enable end,
					},
					buffCountSize = {
						order = 7,
						name = L["Buff Count Size"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 1, max = 10, step = 1,
						disabled = function() return not db.buff.enable end,
					},
					debuffSize = {
						order = 8,
						name = L["DeBuff Size"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 1, max = 50, step = 1,
						disabled = function() return not db.buff.enable end,
					},
					debuffScale = {
						order = 9,
						name = L["DeBuff Scale"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 0.5, max = 5, step = 0.05,
						disabled = function() return not db.buff.enable end,
					},
					debuffFontSize = {
						order = 10,
						name = L["DeBuff Font Size"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 8, max = 25, step = 0.05,
						disabled = function() return not db.buff.enable end,
					},
					debuffCountSize = {
						order = 11,
						name = L["DeBuff Count Size"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 1, max = 10, step = 1,
						disabled = function() return not db.buff.enable end,
					},
					paddingX = {
						order = 12,
						name = L["Padding X"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 1, max = 20, step = 1,
						disabled = function() return not db.buff.enable end,
					},
					paddingY = {
						order = 13,
						name = L["Padding Y"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 1, max = 20, step = 1,
						disabled = function() return not db.buff.enable end,
					},						
					buffPerRow = {
						order = 14,
						name = L["Buffs Per Row"],
						--desc = L["Controls the scaling of Blizzard's Buff Frames"],
						type = "range",
						min = 1, max = 20, step = 1,
						disabled = function() return not db.buff.enable end,
					},					
				},
			},	
			castbar = {
				order = 3,
				type = "group",
				name = L["|cff00B4FFCastbar|r"],
				desc = L["Castbar Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",
				get = function(info) return db.castbar[ info[#info] ] end,
				set = function(info, value) db.castbar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {			
					enable = {
						order = 1,
						name = L["Enable"],
						desc = L["Enables Buff Module"],
						width = "full",
						type = "toggle",							
					},
					border = {
						order = 2,
						name = L["Border Style"],
						desc = L["Style of Border for Castbars."],
						disabled = function() return not db.castbar.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here
						values = AceGUIWidgetLSMlists.border,
					},
					background = {
						order = 3,
						name = L["Background Style"],
						desc = L["Style of Background for Castbars."],
						disabled = function() return not db.castbar.enable end,
						type = "select",
						dialogControl = 'LSM30_Background', --Select your widget here
						values = AceGUIWidgetLSMlists.background,
					},					
					CastingBarFrame = {
						type = "group",
						order = 5,
						name = L["Player's Castbar."],
						desc = L["Settings for the Player Castbar."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.CastingBarFrame[ info[#info] ] end,
						set = function(info, value) db.castbar.CastingBarFrame[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							enable = {
								order = 1,
								name = L["Enable"],
								desc = L["Enables Player's Castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 2,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							enableLag = {
								order = 3,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							enableTimer = {
								order = 4,
								name = L["Enable Timer"],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							selfAnchor = {
								order = 5,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 6,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 7,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							offSetY = {
								order = 8,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
						},
					},	
					TargetFrameSpellBar = {
						type = "group",
						order = 6,
						name = L["Target's Castbar."],
						desc = L["Settings for the Target Castbar."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.TargetFrameSpellBar[ info[#info] ] end,
						set = function(info, value) db.castbar.TargetFrameSpellBar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							enable = {
								order = 1,
								name = L["Enable"],
								desc = L["Enables Target's Castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 2,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							enableLag = {
								order = 3,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							enableTimer = {
								order = 4,
								name = L["Enable Timer"],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							selfAnchor = {
								order = 5,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 6,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 7,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							offSetY = {
								order = 8,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
						},
					},						
					FocusFrameSpellBar = {
						type = "group",
						order = 7,
						name = L["Focus Castbar."],
						desc = L["Settings for the Focus Castbar."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.FocusFrameSpellBar[ info[#info] ] end,
						set = function(info, value) db.castbar.FocusFrameSpellBar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							enable = {
								order = 1,
								name = L["Enable"],
								desc = L["Enables Focus' Castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 2,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							enableLag = {
								order = 3,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							enableTimer = {
								order = 4,
								name = L["Enable Timer"],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							selfAnchor = {
								order = 5,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 6,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 7,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							offSetY = {
								order = 8,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
						},
					},						
					MirrorTimer1 = {
						type = "group",
						order = 8,
						name = L["Mirror Timer."],
						desc = L["Settings for Mirror Timer."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.MirrorTimer1[ info[#info] ] end,
						set = function(info, value) db.castbar.MirrorTimer1[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							enable = {
								order = 1,
								name = L["Enable"],
								desc = L["Enables Mirror Timer."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 2,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
								type = "select",
								values = B.regions;
							},
							enableTimer = {
								order = 3,
								name = L["Enable Timer"],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								width = "full",
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
							},
							selfAnchor = {
								order = 4,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 5,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 6,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
							},
							offSetY = {
								order = 7,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
							},
						},
					},						
					PetCastingBarFrame = {
						type = "group",
						order = 9,
						name = L["Pet Castbar"],
						desc = L["Settings for the Pet Casting Bar."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.PetCastingBarFrame[ info[#info] ] end,
						set = function(info, value) db.castbar.PetCastingBarFrame[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							enable = {
								order = 1,
								name = L["Enable"],
								desc = L["Enables Pet's Castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 2,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							enableTimer = {
								order = 3,
								name = L["Enable Timer."],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								width = "full",
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
							},
							selfAnchor = {
								order = 4,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 5,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 6,
								name = L["X Offset."],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
							},
							offSetY = {
								order = 7,
								name = L["Y Offset."],
								desc = L["Controls the Y offset. (Up - Down)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
							},
						},
					},						
				},
			},			
			chat = {
				order = 4,
				type = "group",
				name = L["|cff00B4FFChat|r"],
				desc = L["Chat Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",
				get = function(info) return db.chat[ info[#info] ] end,
				set = function(info, value) db.chat[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Modify the chat window and settings."],
					},			
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Chat Module."],
						type = "toggle",							
					},
					enableborder = {
						order = 3,
						name = L["Window Border"],
						desc = L["Enables Chat Window Border."],
						disabled = function() return not db.chat.enable end,
						type = "toggle",							
					},					
					border = {
						order = 4,
						name = L["Border Style"],
						desc = L["Style of Border for Chat Window."],
						disabled = function() return not db.chat.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here
						values = AceGUIWidgetLSMlists.border,
					},
					background = {
						order = 5,
						name = L["Background Style"],
						desc = L["Style of Background for Chat Window."],
						disabled = function() return not db.chat.enable end,
						type = "select",
						dialogControl = 'LSM30_Background', --Select your widget here
						values = AceGUIWidgetLSMlists.background,
					},
					editboxborder = {
						order = 6,
						name = L["Editbox Border Style"],
						desc = L["Style of Editbox Border for Chat."],
						disabled = function() return not db.chat.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here
						values = AceGUIWidgetLSMlists.border,
					},
					editboxbackground = {
						order = 7,
						name = L["Editbox Background Style"],
						desc = L["Style of Editbox Background for Chat."],
						disabled = function() return not db.chat.enable end,
						type = "select",
						dialogControl = 'LSM30_Background', --Select your widget here
						values = AceGUIWidgetLSMlists.background,
					},
					sound = {
						order = 8,
						name = L["Whisper Sound"],
						desc = L["MP3 that Will Play when you get a Whisper."],
						disabled = function() return not db.chat.enable end,
						type = "select",
						dialogControl = 'LSM30_Sound', --Select your widget here
						values = AceGUIWidgetLSMlists.sound,
					},					
					disableFade = {
						order = 9,
						name = L["Disable Fade"],
						desc = L["Disables Chat Fading."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},
					chatOutline = {
						order = 10,
						name = L["Chat Outline"],
						desc = L["Outlines the chat Text."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},
					enableBottomButton = {
						order = 11,
						name = L["Enable Bottom Button"],
						desc = L["Enables the scroll down button in the lower right hand corner."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},
					enableHyperlinkTooltip = {
						order = 12,
						name = L["Enable Hyplerlink Tooltip"],
						desc = L["Enables the mouseover items in chat tooltip."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},
					enableBorderColoring = {
						order = 13,
						name = L["Enable Editbox Channel Border Coloring"],
						desc = L["Enables the coloring of the border to the edit box to match what channel you are typing in."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
					},					
					tab = {
						type = "group",
						order = 14,
						name = L["Tabs"],
						desc = L["Tab Font Settings."],
						guiInline = true,
						disabled = function() return not db.chat.enable end,
						get = function(info) return db.chat.tab[ info[#info] ] end,
						set = function(info, value) db.chat.tab[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {				
							fontSize = {
								type = "range",
								order = 1,
								name = L["Font Size"],
								desc = L["Controls the size of the tab font"],
								width = "full",
								type = "range",
								min = 9, max = 20, step = 1,									
							},
							fontOutline = {
								order = 2,
								name = L["Outline Tab Font"],
								desc = L["Enables the outlineing of tab font."],
								type = "toggle",								
							},
							normalColor = {
								order = 3,
								type = "color",
								name = L["Tab Normal Color"],
								desc = L["Picks the Normal Color of the Chat Tab."],
								hasAlpha = false,
								disabled = function() return not db.chat.enable end,
								get = function(info)
									local hb = db.chat.tab[ info[#info] ]
									return hb.r, hb.g, hb.b
								end,
								set = function(info, r, g, b)
									db.chat.tab[ info[#info] ] = {}
									local hb = db.chat.tab[ info[#info] ]
									hb.r, hb.g, hb.b = r, g, b
									StaticPopup_Show("CFG_RELOAD") 
								end,					
							},
							specialColor = {
								order = 4,
								type = "color",
								name = L["Tab Special Color"],
								desc = L["Picks the Special Color of the Chat Tab."],
								hasAlpha = false,
								disabled = function() return not db.chat.enable end,
								get = function(info)
									local hb = db.chat.tab[ info[#info] ]
									return hb.r, hb.g, hb.b
								end,
								set = function(info, r, g, b)
									db.chat.tab[ info[#info] ] = {}
									local hb = db.chat.tab[ info[#info] ]
									hb.r, hb.g, hb.b = r, g, b
									StaticPopup_Show("CFG_RELOAD") 
								end,					
							},
							selectedColor = {
								order = 5,
								type = "color",
								name = L["Tab Selected Color"],
								desc = L["Picks the Selected Color of the Chat Tab."],
								hasAlpha = false,
								disabled = function() return not db.chat.enable end,
								get = function(info)
									local hb = db.chat.tab[ info[#info] ]
									return hb.r, hb.g, hb.b
								end,
								set = function(info, r, g, b)
									db.chat.tab[ info[#info] ] = {}
									local hb = db.chat.tab[ info[#info] ]
									hb.r, hb.g, hb.b = r, g, b
									StaticPopup_Show("CFG_RELOAD") 
								end,					
							},							
						},
					},
				},
			},			
			datatext = {
				order = 5,
				type = "group",
				name = L["|cff00B4FFDatatext|r"],
				desc = L["Datatext Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",
				get = function(info) return db.datatext[ info[#info] ] end,
				set = function(info, value) db.datatext[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					enable = {
						order = 1,
						name = L["Enable"],
						desc = L["Enables Datatext Module."],
						type = "toggle",							
					},
					time24 = {
						order = 2,
						type = "toggle",
						name = L["24-Hour Time"],
						desc = L["Display time datatext on a 24 hour time scale"],
							disabled = function() return not db.datatext.enable end,					
					},					
					bag = {
						order = 3,
						type = "toggle",
						name = L["Bag Open"],
						desc = L["Checked opens Backpack only, Unchecked opens all bags."],
						disabled = function() return not db.datatext.enable end,						
					},				
					battleground = {
						order = 4,
						type = "toggle",
						name = L["Battleground Text"],
						desc = L["Display special datatexts when inside a battleground"],
						disabled = function() return not db.datatext.enable end,						
					},
					top = {
						order = 5,
						name = L["Datapanel Top"],
						desc = L["If checked then panel moves to top of screen, If unchecked panel moves below MainMenuBar"],
						type = "toggle",
						disabled = function() return not db.datatext.enable end,						
					},					
					localtime = {
						order = 6,
						type = "toggle",
						name = L["Local Time"],
						desc = L["Display local time instead of server time"],
						disabled = function() return not db.datatext.enable end,						
					},
					recountraiddps = {
						order = 7,
						type = "toggle",
						name = L["Recount Raid DPS"],
						desc = L["Display Recount's Raid DPS (RECOUNT MUST BE INSTALLED)"],
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
						width = "full",
						type = "range",
						min = 9, max = 25, step = 1,
						disabled = function() return not db.datatext.enable end,						
					},
					border = {
						order = 10,
						name = L["Border Style"],
						desc = L["Style of Border for Castbars."],
						disabled = function() return not db.castbar.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here
						values = AceGUIWidgetLSMlists.border,
					},
					background = {
						order = 11,
						name = L["Background Style"],
						desc = L["Style of Background for Castbars."],
						disabled = function() return not db.castbar.enable end,
						type = "select",
						dialogControl = 'LSM30_Background', --Select your widget here
						values = AceGUIWidgetLSMlists.background,
					},					
					colors = {
						order = 12,
						type = "group",
						name = L["Text Colors"],
						guiInline = true,
						get = function(info) return db.datatext.colors[ info[#info] ] end,
						set = function(info, value) db.datatext.colors[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,							
						disabled = function() return not db.datatext.enable end,						
						args = {						
							classcolor = {
								order = 1,
								type = "toggle",
								name = L["Class Color"],
								desc = L["Color the datatext values based on your class"],
								disabled = function() return not db.datatext.enable end,						
							},							
							color = {
								order = 2,
								type = "color",
								name = L["Custom Color"],
								desc = L["Picks a Custom Color for the datatext values."],
								disabled = function() return db.datatext.colors.classcolor or not db.datatext.enable end,
								get = function(info)
									local hb = db.datatext.colors[ info[#info] ]
									return hb.r, hb.g, hb.b
								end,
								set = function(info, r, g, b)
									db.datatext.colors[ info[#info] ] = {}
									local hb = db.datatext.colors[ info[#info] ]
									hb.r, hb.g, hb.b = r, g, b
									StaticPopup_Show("CFG_RELOAD")
								end,					
							},								
						},
					},					
					DataGroup = {
						order = 13,
						type = "group",
						name = L["Text Positions"],
						disabled = function() return not db.datatext.enable end,						
						args = {
							bags = {
								order = 1,
								type = "range",
								name = L["Bags"],
								desc = L["Display ammount of bag space"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
							calltoarms = {
								order = 2,
								type = "range",
								name = L["Call to Arms"],
								desc = L["Display the active roles that will recieve a reward for completing a random dungeon"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,																
							},
							coords = {
								order = 3,
								type = "range",
								name = L["Coordinates"],
								desc = L["Display Player's Coordinates"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,																
							},						
							dps_text = {
								order = 4,
								type = "range",
								name = L["DPS"],
								desc = L["Display ammount of DPS"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,																
							},						
							dur = {
								order = 5,
								type = "range",
								name = L["Durability"],
								desc = L["Display your current durability"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
							},
							friends = {
								order = 6,
								type = "range",
								name = L["Friends"],
								desc = L["Display current online friends"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
							guild = {
								order = 7,
								type = "range",
								name = L["Guild"],
								desc = L["Display current online people in guild"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
							hps_text = {
								order = 8,
								type = "range",
								name = L["HPS"],
								desc = L["Display ammount of HPS"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
							pro = {
								order = 10,
								type = "range",
								name = L["Professions"],
								desc = L["Display Professions"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
							recount = {
								order = 11,
								type = "range",
								name = L["Recount"],
								desc = L["Display Recount's DPS (RECOUNT MUST BE INSTALLED)"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,								
							},							
							spec = {
								order = 12,
								type = "range",
								name = L["Talent Spec"],
								desc = L["Display current spec"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
							stat1 = {
								order = 13,
								type = "range",
								name = L["Stat #1"],
								desc = L["Display stat based on your role (Avoidance-Tank, AP-Melee, SP/HP-Caster)"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,			
							},							
							stat2 = {
								order = 14,
								type = "range",
								name = L["Stat #2"],
								desc = L["Display stat based on your role (Armor-Tank, Crit-Melee, Crit-Caster)"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,						
							},
							system = {
								order = 15,
								type = "range",
								name = L["System"],
								desc = L["Display FPS and Latency"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
							wowtime = {
								order = 16,
								type = "range",
								name = L["Time"],
								desc = L["Display current time"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
							zone = {
								order = 17,
								type = "range",
								name = L["Zone"],
								desc = L["Display Player's Current Zone."]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,															
							},
						},
					},
				},
			},		
			merchant = {
				order = 6,
				type = "group",
				name = L["|cff00B4FFMerchant|r"],
				desc = L["Merchant Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",
				get = function(info) return db.merchant[ info[#info] ] end,
				set = function(info, value) db.merchant[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {			
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enable Merchant Settings"],							
					},
					autoRepair = {
						type = "toggle",
						order = 2,
						name = L["Auto Repair"],
						desc = L["Automatically repair when visiting a vendor"],
						disabled = function() return not db.merchant.enable end,
					},
					autoSellGrey = {
						type = "toggle",
						order = 3,
						name = L["Sell Grays"],
						desc = L["Automatically sell gray items when visiting a vendor"],
						disabled = function() return not db.merchant.enable end,
					},					
					sellMisc = {
						type = "toggle",
						order = 4,
						name = L["Sell Misc Items"],
						desc = L["Automatically sell a user selected item."],
						disabled = function() return not db.merchant.enable end,
					},
				},
			},
			minimap = {
				type = "group",
				order = 7,
				name = L["|cff00B4FFMinimap|r"],
				desc = L["Enables Minimap Modifications."],
				get = function(info) return db.minimap[ info[#info] ] end,
				set = function(info, value) db.minimap[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
				args = {					
					enable = {
						order = 1,
						name = L["Enable"],
						desc = L["Enables Minimap Modifications."],
						type = "toggle",
						width = "full"
					},
					farm = {
						order = 2,
						name = L["Farming"],
						desc = L["Enlarges the Minimap when Farming."],
						disabled = function() return not db.minimap.enable end,
						type = "toggle",						
					},
					farmscale = {
						name = L["Farming Map Scale"],
						desc = L["Controls the Size of the Farming Map"],
						order = 3,
						disabled = function() return not db.minimap.enable or not db.minimap.farm end,
						type = "range",						
						min = 1, max = 5, step = 0.1,
					},					
					gameclock = {
						order = 4,
						name = L["Game Clock"],
						desc = L["Enable the Clock Frame on Minimap."],
						disabled = function() return not db.minimap.enable end,
						type = "toggle",								
					},													
					border = {							
						name = L["Border Style"],
						desc = L["Style of Border for Minimap."],
						order = 5,
						disabled = function() return not db.minimap.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here																
						values = AceGUIWidgetLSMlists.border,
					},
					zoneText = {
						order = 6,
						name = L["Zone Text"],
						desc = L["Enable Mouseover Zone Text."],
						disabled = function() return not db.minimap.enable end,
						type = "toggle",								
					},
					instanceDifficulty = {
						order = 7,
						name = L["Instance Difficulty"],
						desc = L["Enable Mouseover Instance Difficulty."],
						disabled = function() return not db.minimap.enable end,
						type = "toggle",								
					},									
				},
			},			
			nameplates = {
				order = 6,
				type = "group",
				name = L["|cff00B4FFNameplate|r"],
				desc = L["Nameplate Module for |cff00B4FFBasic|rUI."],
				get = function(info) return db.nameplates[ info[#info] ] end,
				set = function(info, value) db.nameplates[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {		
					enable = {
						type = "toggle",
						order = 2,
						width = "full",
						name = L["Enable"],
						desc = L["Enable Nameplate Settings"],							
					},
					enableTankMode = {
						type = "toggle",
						order = 3,
						name = L["Enable Tank Mode"],
						disabled = function() return not db.nameplates.enable end,
					},				
					colorNameWithThreat = {
						type = "toggle",
						order = 4,
						name = L["Color Name With Threat"],
						disabled = function() return not db.nameplates.enable end,
					},
					showFullHP = {
						type = "toggle",
						order = 5,
						name = L["Show Full HP"],
						disabled = function() return not db.nameplates.enable end,
					},	
					showLevel = {
						type = "toggle",
						order = 6,
						name = L["Show Level"],
						disabled = function() return not db.nameplates.enable end,
					},	
					showTargetBorder = {
						type = "toggle",
						order = 7,
						name = L["Show Target Border"],
						disabled = function() return not db.nameplates.enable end,
					},	
					showEliteBorder = {
						type = "toggle",
						order = 8,
						name = L["Show Elite Border"],
						disabled = function() return not db.nameplates.enable end,
					},	
					showTotemIcon = {
						type = "toggle",
						order = 9,
						name = L["Show Totem Icon"],
						disabled = function() return not db.nameplates.enable end,
					},
					abbrevLongNames = {
						type = "toggle",
						order = 9,
						name = L["Abbrev Long Names"],
						disabled = function() return not db.nameplates.enable end,
					},						
				},
			},
			powerbar = {
				order = 9,
				type = "group",
				name = L["|cff00B4FFPowerbar|r"],
				desc = L["Powerbar Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",
				get = function(info) return db.powerbar[ info[#info] ] end,
				set = function(info, value) db.powerbar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {		
					enable = {
						type = "toggle",
						order = 1,
						width = "full",
						name = L["Enable"],
						desc = L["Enable Powerbar Settings"],							
					},
					border = {
						order = 2,
						name = L["Border Style"],
						desc = L["Style of Border for Powerbar."],
						disabled = function() return not db.powerbar.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here
						values = AceGUIWidgetLSMlists.border,
					},
					statusbar = {
						order = 3,
						name = L["Statusbar Style"],
						desc = L["Style of Statusbar for Powerbar."],
						disabled = function() return not db.powerbar.enable end,
						type = "select",
						dialogControl = 'LSM30_Statusbar', --Select your widget here
						values = AceGUIWidgetLSMlists.statusbar,
					},					
					showCombatRegen = {
						order = 4,
						name = L["CombatRegen"],
						desc = L["Shows a players Regen while in combat."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showEclipseBar = {
						order = 5,
						name = L["Eclipsebar"],
						desc = L["Move the Eclipsebar above Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},					
					showSoulshards = {
						order = 6,
						name = L["Soulshards"],
						desc = L["Shows Shards as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showHolypower = {
						order = 7,
						name = L["Holypower"],
						desc = L["Shows Holypower as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showComboPoints = {
						order = 8,
						name = L["ComboPoints"],
						desc = L["Shows ComboPoints as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showRuneCooldown = {
						order = 9,
						name = L["Rune Cooldown"],
						desc = L["Shows Runes cooldowns as numbers."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					energybar = {
						order = 10,
						name = L["Energybar"],
						desc = L["Shows Energy Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					focusbar = {
						order = 11,
						name = L["Focusbar"],
						desc = L["Shows Focus Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					manabar = {
						order = 12,
						name = L["Manabar"],
						desc = L["Shows Mana Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					ragebar = {
						order = 13,
						name = L["Ragebar"],
						desc = L["Shows Rage Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					runebar = {
						order = 14,
						name = L["Runebar"],
						desc = L["Shows Rune Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					sizeWidth= {
						order = 15,
						name = L["Width"],
						desc = L["Controls the width of Powerbar."],
						type = "range",
						min = 50, max = 350, step = 25,
						disabled = function() return not db.powerbar.enable end,
					},					
					combo = {
						type = "group",
						order = 16,
						name = L["Combo"],
						desc = L["Combo Points Options"],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.combo[ info[#info] ] end,
						set = function(info, value) db.powerbar.combo[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {											
							FontOutline = {
								order = 1,
								name = L["Font Outline"],
								desc = L["Adds a font outline to ComboPoints."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							FontSize= {
								order = 2,
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
						order = 17,
						name = L["Extra"],
						desc = L["Options for Soulshards and Holypower Text."],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.extra[ info[#info] ] end,
						set = function(info, value) db.powerbar.extra[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {						
							FontOutline = {
								order = 1,
								name = L["Font Outline"],
								desc = L["Adds a font outline to Extra."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
								FontSize= {
								order = 2,
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
						order = 18,
						name = L["Rune"],
						desc = L["Options for Rune Text."],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.rune[ info[#info] ] end,
						set = function(info, value) db.powerbar.rune[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {						
							FontOutline = {
								order = 1,
								name = L["Font Outline"],
								desc = L["Adds a font outline to Runes."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							FontSize= {
								order = 2,
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
						order = 19,
						name = L["Value"],
						desc = L["Shows the Value on the PowerBar."],
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.value[ info[#info] ] end,
						set = function(info, value) db.powerbar.value[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {						
							Abbrev = {
								order = 1,
								name = L["Abbrev"],
								desc = L["Abbreviates the value. 17000 = 17K"],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							FontOutline = {
								order = 2,
								name = L["Font Outline"],
								desc = L["Adds a font outline to value."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							FontSize= {
								order = 3,
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
				order = 10,
				type = "group",
				name = L["|cff00B4FFQuest|r"],
				desc = L["Quest Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",
				get = function(info) return db.quest[ info[#info] ] end,
				set = function(info, value) db.quest[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {			
					enable = {
						order = 1,
						name = L["Enable"],
						desc = L["Enables Quest Module"],
						type = "toggle",							
					},					
					autocomplete = {
						order = 2,
						name = L["Autocomplete"],
						desc = L["Automatically complete your quest."],
						type = "toggle",
						disabled = function() return not db.quest.enable end,
					},
				},
			},
			selfbuffs = {
				order = 11,
				type = "group",
				name = L["|cff00B4FFSelfbuff|r"],
				desc = L["Selfbuff Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",
				get = function(info) return db.selfbuffs[ info[#info] ] end,
				set = function(info, value) db.selfbuffs[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {			
					enable = {
						order = 1,
						name = L["Enable"],
						desc = L["Enables Selfbuff Module"],
						type = "toggle",							
					},					
					playsound = {
						order = 2,
						name = L["Play Sound"],
						desc = L["Play's a warning sound when a players class buff is not applied."],
						type = "toggle",
						disabled = function() return not db.selfbuffs.enable end,
					},
					border = {
						order = 3,
						name = L["Border Style"],
						desc = L["Style of Border for Nameplates."],
						disabled = function() return not db.selfbuffs.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here
						values = AceGUIWidgetLSMlists.border,
					},
					sound = {
						order = 4,
						name = L["Warning Sound"],
						desc = L["Pick the MP3 you want for your Warning Sound."],
						disabled = function() return not db.selfbuffs.enable end,
						type = "select",
						dialogControl = 'LSM30_Sound', --Select your widget here
						values = AceGUIWidgetLSMlists.sound,
					},				
				},
			},
			skin = {
				type = "group",
				order = 9,
				name = L["|cff00B4FFSkin|r"],
				desc = L["Skin Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",				
				get = function(info) return db.skin[ info[#info] ] end,
				set = function(info, value) db.skin[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
				args = {				
					enable = {
						order = 1,
						name = L["Enable"],
						desc = L["Enables AddOn Skinning"],
						type = "toggle",
						width = "full",						
					},
					border = {
						order = 2,
						name = L["Border Style"],
						desc = L["Style of Border for Skinning."],
						disabled = function() return not db.skin.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here
						values = AceGUIWidgetLSMlists.border,
					},
					statusbar = {
						order = 3,
						name = L["Statusbar Style"],
						desc = L["Style of Statusbar for Skinning."],
						disabled = function() return not db.skin.enable end,
						type = "select",
						dialogControl = 'LSM30_Statusbar', --Select your widget here
						values = AceGUIWidgetLSMlists.statusbar,
					},							
					DBM = {
						order = 4,
						name = L["DBM"],
						desc = L["Skins Deadly Boss Mods to match |cff00B4FFBasic|rUI."],
						type = "toggle",
						disabled = function() return not db.skin.enable end,
					},
					Recount = {
						order = 5,
						name = L["Recount"],
						desc = L["Skins Recount to match |cff00B4FFBasic|rUI."],
						type = "toggle",
						disabled = function() return not db.skin.enable end,
					},
					RecountBackdrop = {
						order = 6,
						name = L["Recount Backdrop"],
						desc = L["Keep the backdrop in the Recount Window."],
						type = "toggle",
						disabled = function() return not db.skin.enable end,
					},
				},
			},			
			tooltip = {
				order = 12,
				type = "group",
				name = L["|cff00B4FFTooltip|r"],
				desc = L["Tooltip Module for |cff00B4FFBasic|rUI."],
				childGroups = "tree",
				get = function(info) return db.tooltip[ info[#info] ] end,
				set = function(info, value) db.tooltip[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {		
					enable = {
						order = 1,
						name = L["Enable"],
						desc = L["Enables Tooltip Module"],
						type = "toggle",							
					},					
					disableFade = {
						order = 2,
						name = L["Disable Fade"],
						desc = L["Disables Tooltip Fade."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					border = {
						order = 3,
						name = L["Border Style"],
						desc = L["Style of Border for Tooltip."],
						disabled = function() return not db.tooltip.enable end,
						type = "select",
						dialogControl = 'LSM30_Border', --Select your widget here
						values = AceGUIWidgetLSMlists.border,
					},
					background = {
						order = 4,
						name = L["Background Style"],
						desc = L["Style of Background for Tooltip."],
						disabled = function() return not db.tooltip.enable end,
						type = "select",
						dialogControl = 'LSM30_Background', --Select your widget here
						values = AceGUIWidgetLSMlists.background,
					},
					statusbar = {
						order = 5,
						name = L["Statusbar Style"],
						desc = L["Style of Statusbar for Tooltip."],
						disabled = function() return not db.tooltip.enable end,
						type = "select",
						dialogControl = 'LSM30_Statusbar', --Select your widget here
						values = AceGUIWidgetLSMlists.statusbar,
					},					
					reactionBorderColor = {
						order = 6,
						name = L["Reaction Border Color"],
						desc = L["Colors the borders match targets classcolors."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					itemqualityBorderColor = {
						order = 7,
						name = L["Item Quality Border Color"],
						desc = L["Colors the border of the tooltip to match the items quality."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					showPlayerTitles = {
						order = 8,
						name = L["Player Titles"],
						desc = L["Shows players title in tooltip."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					showPVPIcons = {
						order = 9,
						name = L["PVP Icons"],
						desc = L["Shows PvP Icons in tooltip."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					abbrevRealmNames = {
						order = 10,
						name = L["Abberviate Realm Names"],
						desc = L["Abberviates Players Realm Name."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					showMouseoverTarget = {
						order = 11,
						name = L["Mouseover Target"],
						desc = L["Shows mouseover target."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					showItemLevel = {
						order = 12,
						name = L["Item Level"],
						desc = L["Shows targets average item level."],
						type = "toggle",
						disabled = function() return not db.tooltip.enable end,
					},
					healthbar = {
						type = "group",
						order = 13,
						name = L["Healthbar"],
						desc = L["Players Healthbar Options."],
						guiInline = true,
						disabled = function() return not db.tooltip.enable end,
						get = function(info) return db.tooltip.healthbar[ info[#info] ] end,
						set = function(info, value) db.tooltip.healthbar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {						
							showHealthValue = {
								order = 1,
								name = L["Health Value"],
								desc = L["Shows health value over healthbar."],
								type = "toggle",
								disabled = function() return not db.tooltip.enable end,
							},
							showOutline = {
								order = 2,
								name = L["Font Outline"],
								desc = L["Adds a font outline to health value."],
								type = "toggle",
								disabled = function() return not db.tooltip.enable end,
							},
							reactionColoring = {
								order = 3,
								name = L["Reaction Coloring"],
								desc = L["Change healthbar color to targets classcolor. (Overides Custom Color)"],
								type = "toggle",
								width = "full",
								disabled = function() return not db.tooltip.enable end,
							},														
							custom = {
								type = "group",
								order = 4,
								name = L["Custom"],
								desc = L["Custom Coloring"],
								guiInline = true,
								disabled = function() return not db.tooltip.enable end,
								get = function(info) return db.tooltip.healthbar.custom[ info[#info] ] end,
								set = function(info, value) db.tooltip.healthbar.custom[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
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
								order = 5,
								name = L["Text Position"],
								desc = L["Health Value Position."],
								disabled = function() return not db.tooltip.enable end,
								type = "select",
								values = B.regions;
							},						
							fontSize= {
								order = 6,
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
		},
	}
end

function BasicUIConfig:SetDefaultOptions()
	local B, _, _ = unpack(BasicUI)
	local addon = self.db.profile;
	addon.media = {
		["font"] = "BasicUI",
		['fontSize'] = 14,
		['fontxSmall'] = 10,
		["fontSmall"] = 12,
		['fontMedium'] = 14,
		['fontLarge'] = 16,
		['fontHuge'] = 20,
	}
	addon.general = {
		["autogreed"] = true,
		["cooldown"] = true,
		["slidebar"] = true,		
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
		["itemquality"] = {
			['enable'] = false,
			['border'] = "Item Quality",
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
		["buttons"] = {
		
			["enable"] = true,
			["showHotKeys"] = false,
			["showMacronames"] = false,
			
			-- Button Colors
			["color"] = { 
				["enable"] = true,
				["OutOfRange"] = { r = 0.9, g = 0, b = 0 },
				["OutOfMana"] = { r = 0, g = 0, b = 0.9 },			
				["NotUsable"] = { r = 0.3, g = 0.3, b = 0.3 },
			},
		},	
	}	
	addon.buff = {
		['enable'] = true,
		['border'] = "BasicUI",
		['buffSize'] = 36,
		['buffScale'] = 1,

		['buffFontSize'] = 14,
		['buffCountSize'] = 16,

		['debuffSize'] = 36,
		['debuffScale'] = 1,

		['debuffFontSize'] = 14,
		['debuffCountSize'] = 16,

		['paddingX'] = 10,
		['paddingY'] = 10,
		['buffPerRow'] = 6,
	}
	addon.castbar = {
		["enable"] = true,
		['border'] = "BasicUI",
		['background'] = "Black",
		['statusbar'] = "Blizzard",
		

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
	addon.chat = {
		["enable"] = true,
		["disableFade"] = false,
		["chatOutline"] = false,
		["windowborder"] = true,
		['enableborder'] = true,
		
		-- Chat Media
		['border'] = "BasicUI",
		['background'] = "Blizzard Dialog Background",
		['editboxborder'] = "BasicUI",
		['editboxbackground'] = "Blizzard Dialog Background",
		['sound'] = "Whisper",
		
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
	addon.datatext = {	
		["enable"] = true,

		-- Datapanel Media
		['border'] = "Blizzard Dialog",
		['background'] = "Blizzard Dialog Background",
		
		["top"] = false,										
		["fontsize"] = 15,                                  	
		["bags"] = 9,                                       	
		["system"] = 0,                                     	
		["wowtime"] = 0,                                    	
		["guild"] = 0,                                      	
		["dur"] = 8,                                        	
		["friends"] = 7,                                    	
		["dps_text"] = 0,                                   	
		["hps_text"] = 0,                                   	
		["spec"] = 5,											
		["zone"] = 0,											
		["coords"] = 0,											
		["pro"] = 4,											
		["stat1"] = 1,											
		["stat2"] = 3,											
		["recount"] = 2,										
		["recountraiddps"] = false,								
		["calltoarms"] = 6,										
		
		-- Color Datatext
		["colors"] = {
			["classcolor"] = true,               			    
			["color"] = { r = 0, g = 0, b = 1},                
		},
		
		["battleground"] = true,                            	

		["bag"] = false,									

		-- Clock Settings
		["time24"] = false,                                  	
		["localtime"] = true,                              		
			
		-- FPS Settings
		["fps"] = {
			["enable"] = true,									
			-- ONLY ONE OF THESE CAN BE TRUE	
			["home"] = false,									
			["world"] = false,									
			["both"] = true,									
		},
			
		["threatbar"] = true,									
	}
	addon.itemquality = {
		['enable'] = false,
		['border'] = "Item Quality",
	}	
	addon.merchant = {
		['enable'] = true,										
		['sellMisc'] = true, 									
		['autoSellGrey'] = true,								
		['autoRepair'] = true,									
	}
	addon.minimap = {
		['enable'] = true,
		['border'] = "BasicUI",
		['gameclock'] = true,
		['farm'] = false,
		['farmscale'] = 3,
		['zoneText'] = true,
		['instanceDifficulty'] = false,
	}	
	addon.nameplates = {
		['enable'] = true,
		['enableTankMode'] = true,
		['colorNameWithThreat'] = true,

		['showFullHP'] = true,
		['showLevel'] = true,
		['showTargetBorder'] = true,
		['showEliteBorder'] = true,
		['showTotemIcon'] = true,
		['abbrevLongNames'] = true,
	}	
	addon.powerbar = {
		["enable"] = true,
		['border'] = "BasicUI",
		['statusbar'] = "Blizzard",
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
	addon.quest = {
		['enable'] = true,									
		['autocomplete'] = false,							
	}
	addon.selfbuffs = {
		["enable"] = true,								
		['border'] = "BasicUI",
		["playsound"] = true,								
		['sound'] = "Warning",								
	}
	addon.skin = {
		["enable"] = true,
		['border'] = "BasicUI",
		['statusbar'] = "Blizzard",
		["DBM"] = true,
		["Recount"] = true,
		["RecountBackdrop"] = true,
	}	
	addon.tooltip = {											
		["enable"] = true,

		["disableFade"] = false,
		['border'] = "BasicUI",
		['background'] = "Black",
		['statusbar'] = "Blizzard",
		["reactionBorderColor"] = true,
		["itemqualityBorderColor"] = true,
		
		["showPlayerTitles"] = true,
		["showPVPIcons"] = false, 
		["abbrevRealmNames"] = false, 
		["showMouseoverTarget"] = true,
		
		["showItemLevel"] = true,
		
		["healthbar"] = {
			["showHealthValue"] = true,
			["showOutline"] = false,
			["textPos"] = "CENTER",
			["reactionColoring"] = false,
			["customColorapply"] = false, 
			["custom"] = {
				["apply"] = false,
				["color"] =	{ r = 1, g = 1, b = 0},
			},		
			["fontSize"] = 14,
		},			
	}
end