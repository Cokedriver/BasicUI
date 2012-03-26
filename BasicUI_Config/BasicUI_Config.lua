local BasicUIConfig = LibStub("AceAddon-3.0"):NewAddon("BasicUIConfig", "AceConsole-3.0", "AceEvent-3.0")
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
			general = DB["general"],
			buff = DB["buff"],
			castbar = DB['castbar'],
			chat = DB["chat"],	
			datatext = DB["datatext"],			
			merchant = DB["merchant"],
			nameplates = DB["nameplates"],
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


function BasicUIConfig:OnInitialize()	
	BasicUIConfig:RegisterChatCommand("bc", "ShowConfig")
	BasicUIConfig:RegisterChatCommand("BasicUI", "ShowConfig")
	
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
		type = "group",
		name = "|cff00B4FFBasic|rUI",
		handler = BasicUI,
		childGroups = "tree",
		args = {
			general = {
				order = 1,
				type = "group",
				name = L["|cff00B4FFGeneral|r Options"],
				desc = L["General Modules for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.general[ info[#info] ] end,
				set = function(info, value) db.general[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["General Modules for BasicUI."],
					},
					autogreed = {
						order = 2,
						name = L["Autogreed"],
						desc = L["Enables Automatically rolling greed on green items when in a instance."],
						type = "toggle",							
					},
					cooldown = {
						order = 3,
						name = L["Cooldown"],
						desc = L["Enables cooldown counts on action buttons."],
						type = "toggle",						
					},
					itemquality = {
						order = 4,
						name = L["Item Quality"],
						desc = L["Enables Item Quality Button Border."],
						type = "toggle",						
					},
					slidebar = {
						order = 5,
						name = L["AddOn SlideBar"],
						desc = L["Enables the Minimap AddOn Button SlideBar."],
						type = "toggle",
					},					
					buttons = {
						type = "group",
						order = 6,
						name = L["Actionbar Buttons"],
						desc = L["Actionbar Button Modifications."],
						guiInline = true,
						get = function(info) return db.general.buttons[ info[#info] ] end,
						set = function(info, value) db.general.buttons[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Actionbar Button Options."],
							},					
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Actionbar Button Module"],
								type = "toggle",								
							},
							showHotKeys = {
								order = 3,
								name = L["Show Hot Keys"],
								desc = L["If Checked Hot Keys will Show."],
								type = "toggle",
								disabled = function() return not db.general.buttons.enable end,
							},
							showMacronames = {
								order = 3,
								name = L["Show Macro Names"],
								desc = L["If Checked Macros Will Show."],
								type = "toggle",
								disabled = function() return not db.general.buttons.enable end,
							},
							color = {
								type = "group",
								order = 5,
								name = L["Actionbar Button Color"],
								desc = L["Enables Actionbar Button Color Modifications."],
								guiInline = true,
								get = function(info) return db.general.buttons.color[ info[#info] ] end,
								set = function(info, value) db.general.buttons.color[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
								args = {
									intro = {
										order = 1,
										type = "description",
										name = L["Color for Action Buttons."],
									},					
									enable = {
										order = 2,
										name = L["Enable"],
										desc = L["Enables Coloring"],
										type = "toggle",								
									},								
									OutOfRange = {
										order = 4,
										type = "color",
										name = L["Out of Range"],
										desc = L["Picks the Out of Range Button Fade Color."],
										hasAlpha = false,
										disabled = function() return not db.general.buttons.enable or not db.general.buttons.color.enable end,
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
										order = 5,
										type = "color",
										name = L["Out of Mana"],
										desc = L["Picks the Out of Mana Button Fade Color."],
										hasAlpha = false,
										disabled = function() return not db.general.buttons.enable or not db.general.buttons.color.enable end,
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
										order = 6,
										type = "color",
										name = L["Not Usable"],
										desc = L["Picks the Not Usable Button Fade Color."],
										hasAlpha = false,
										disabled = function() return not db.general.buttons.enable or not db.general.buttons.color.enable end,
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
						type = "group",
						order = 7,
						name = L["Mail"],
						desc = L["Enables Mailbox Modifications."],
						guiInline = true,
						get = function(info) return db.general.mail[ info[#info] ] end,
						set = function(info, value) db.general.mail[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Enables Mailbox Modifications."],
							},					
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Mail Module"],
								type = "toggle",								
							},						
							openall = {
								order = 4,
								name = L["Open All"],
								desc = L["Enables Open All Collect Button on Mailbox"],
								type = "toggle",
								disabled = function() return not db.general.mail.enable end,
							},
							BlackBook = {
								type = "group",
								order = 5,
								name = L["BlackBook"],
								desc = L["Enables Send Mail Drop Down Menu. (Barrowed from Postal) "],
								guiInline = true,
								get = function(info) return db.general.mail.BlackBook[ info[#info] ] end,
								set = function(info, value) db.general.mail.BlackBook[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
								disabled = function() return not db.general.mail.enable end,
								args = {
									intro = {
										order = 1,
										type = "description",
										name = L["Enables Send Mail Drop Down Menu. (Barrowed from Postal) "],
									},					
									enable = {
										order = 2,
										name = L["Enable"],
										desc = L["Enables BlackBook Module"],
										type = "toggle",								
									},
									AutoFill = {
										order = 3,
										name = L["Auto Fill"],
										desc = L["AutoFill Names"],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									AutoCompleteAlts = {
										order = 4,
										name = L["Auto Complete Alts"],
										desc = L["Mailing list of Alts."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,										
									},
									AutoCompleteRecent = {
										order = 5,
										name = L["Auto Complete Recent"],
										desc = L["Mailing list of Recently Mailed People."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									AutoCompleteContacts = {
										order = 6,
										name = L["Auto Complete Contacts"],
										desc = L["Mailing list of Contacts."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									AutoCompleteFriends = {
										order = 7,
										name = L["Auto Complete Friends"],
										desc = L["Mailing list of Friends."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									AutoCompleteGuild = {
										order = 8,
										name = L["Auto Complete Guild"],
										desc = L["Mailing list of Guildies."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									ExcludeRandoms = {
										order = 9,
										name = L["Exclude Randoms"],
										desc = L["Mailing list of Random People."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									DisableBlizzardAutoComplete = {
										order = 10,
										name = L["Disable Blizzard Auto Complete"],
										desc = L["Disable blizzards Auto Complete when Typing."],
										type = "toggle",
										disabled = function() return not db.general.mail.enable or not db.general.mail.BlackBook.enable end,
									},
									UseAutoComplete = {
										order = 11,
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
							intro = {
								order = 1,
								type = "description",
								name = L["Adjust the scale of Blizzards Unit Frames."],
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
					skin = {
						type = "group",
						order = 9,
						name = L["Skin AddOns"],
						desc = L["Make a few AddOns match |cff00B4FFBasic|rUI."],	
						guiInline = true,
						get = function(info) return db.general.skin[ info[#info] ] end,
						set = function(info, value) db.general.skin[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Skin AddOns to match |cff00B4FFBasic|rUI.."],
							},					
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables AddOn Skinning"],
								type = "toggle",								
							},						
							DBM = {
								order = 3,
								name = L["DBM"],
								desc = L["Skins Deadly Boss Mods to match |cff00B4FFBasic|rUI."],
								type = "toggle",
								disabled = function() return not db.general.skin.enable end,
							},
							Recount = {
								order = 4,
								name = L["Recount"],
								desc = L["Skins Recount to match |cff00B4FFBasic|rUI."],
								type = "toggle",
								disabled = function() return not db.general.skin.enable end,
							},
							RecountBackdrop = {
								order = 5,
								name = L["Recount Backdrop"],
								desc = L["Keep the backdrop in the Recount Window."],
								type = "toggle",
								disabled = function() return not db.general.skin.enable end,
							},
						},
					},					
				},
			},
			buff = {
				order = 2,
				type = "group",
				name = L["|cff00B4FFBuff|r Options"],
				desc = L["Rescale the size of your buffs."],
				childGroups = "tree",
				get = function(info) return db.buff[ info[#info] ] end,
				set = function(info, value) db.buff[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Rescale the size of your buffs."],
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
						min = 0.5, max = 2, step = 0.05,
						disabled = function() return not db.buff.enable end,
					},
				},
			},
			castbar = {
				order = 3,
				type = "group",
				name = L["|cff00B4FFCastbar|r Options"],
				desc = L["Setup the Castbar."],
				childGroups = "tree",
				get = function(info) return db.castbar[ info[#info] ] end,
				set = function(info, value) db.castbar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Setup the Castbar."],
					},			
					enable = {
						order = 2,
						name = L["Enable"],
						desc = L["Enables Buff Module"],
						type = "toggle",							
					},					
					CastingBarFrame = {
						type = "group",
						order = 3,
						name = L["Player's Castbar."],
						desc = L["Player's Casting Bar."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.CastingBarFrame[ info[#info] ] end,
						set = function(info, value) db.castbar.CastingBarFrame[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Settings for the Player Castbar."],
								disabled = function() return not db.castbar.enable end,
							},
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Player's Castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							enableLag = {
								order = 4,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							enableTimer = {
								order = 5,
								name = L["Enable Timer"],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							selfAnchor = {
								order = 6,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 7,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 8,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							offSetY = {
								order = 9,
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
						order = 4,
						name = L["Target's Castbar."],
						desc = L["Target's Casting Bar."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.TargetFrameSpellBar[ info[#info] ] end,
						set = function(info, value) db.castbar.TargetFrameSpellBar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Settings for the Target Castbar."],
								disabled = function() return not db.castbar.enable end,
							},
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Target's Castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							enableLag = {
								order = 4,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							enableTimer = {
								order = 5,
								name = L["Enable Timer"],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							selfAnchor = {
								order = 6,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 7,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 8,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							offSetY = {
								order = 9,
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
						order = 5,
						name = L["Focus Castbar."],
						desc = L["Focus Casting Bar."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.FocusFrameSpellBar[ info[#info] ] end,
						set = function(info, value) db.castbar.FocusFrameSpellBar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Settings for the Focus Castbar."],
								disabled = function() return not db.castbar.enable end,
							},
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Focus' Castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							enableLag = {
								order = 4,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							enableTimer = {
								order = 5,
								name = L["Enable Timer"],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							selfAnchor = {
								order = 6,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 7,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 8,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							offSetY = {
								order = 9,
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
						order = 6,
						name = L["Mirror Timer."],
						desc = L["Settings for Mirror Timer."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.MirrorTimer1[ info[#info] ] end,
						set = function(info, value) db.castbar.MirrorTimer1[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Settings for Mirror Timer."],
								disabled = function() return not db.castbar.enable end,
							},
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Mirror Timer."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
								type = "select",
								values = B.regions;
							},
							enableTimer = {
								order = 5,
								name = L["Enable Timer"],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								width = "full",
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
							},
							selfAnchor = {
								order = 6,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 7,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 8,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
							},
							offSetY = {
								order = 9,
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
						order = 7,
						name = L["Pet Castbar"],
						desc = L["Settings for the Pet Casting Bar."],
						guiInline = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.PetCastingBarFrame[ info[#info] ] end,
						set = function(info, value) db.castbar.PetCastingBarFrame[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Settings for the Pet Casting Bar."],
								disabled = function() return not db.castbar.enable end,
							},
							enable = {
								order = 2,
								name = L["Enable"],
								desc = L["Enables Pet's Castbar."],
								type = "toggle",
								disabled = function() return not db.castbar.enable end,
							},
							textPosition = {
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							enableTimer = {
								order = 5,
								name = L["Enable Timer."],
								desc = L["Enables timer to show on castbar."],
								type = "toggle",
								width = "full",
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
							},
							selfAnchor = {
								order = 6,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							relAnchor = {
								order = 7,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								type = "select",
								values = B.regions;
							},
							offSetX = {
								order = 8,
								name = L["X Offset."],
								desc = L["Controls the X offset. (Left - Right)"],
								type = "range",
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
							},
							offSetY = {
								order = 9,
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
				name = L["|cff00B4FFChat|r Options"],
				desc = L["Modify the chat window and settings."],
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
					border = {
						order = 3,
						name = L["Border"],
						desc = L["Disables Border around Chat Windows."],
						type = "toggle",
						disabled = function() return not db.chat.enable end,
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
						desc = L["Tab Font Settings."],
						guiInline = true,
						disabled = function() return not db.chat.enable end,
						get = function(info) return db.chat.tab[ info[#info] ] end,
						set = function(info, value) db.chat.tab[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Tab Font Settings."],
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
				name = L["|cff00B4FFDatatext|r Options"],
				desc = L["Edit the display of information text on Datapanel."],
				childGroups = "tree",
				get = function(info) return db.datatext[ info[#info] ] end,
				set = function(info, value) db.datatext[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,				
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Edit the display of information text on Datapanel."],
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
						name = L["Datapanel Top"],
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
					recountraiddps = {
						order = 8,
						type = "toggle",
						name = L["Recount Raid DPS"],
						desc = L["Display Recount's Raid DPS (RECOUNT MUST BE INSTALLED)"],
						disabled = function() return not db.datatext.enable end,								
					},						
					threatbar = {
						order = 9,
						type = "toggle",
						name = L["Threatbar"],
						desc = L["Display Threat Text in center of panel."],
						disabled = function() return not db.datatext.enable end,						
					},
					fontsize = {
						order = 10,
						name = L["Font Scale"],
						desc = L["Font size for datatexts"],
						type = "range",
						min = 9, max = 25, step = 1,
						disabled = function() return not db.datatext.enable end,						
					},					
					colors = {
						order = 11,
						type = "group",
						name = L["Text Colors"],
						guiInline = true,
						get = function(info) return db.datatext.colors[ info[#info] ] end,
						set = function(info, value) db.datatext.colors[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,							
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
									local t = db.datatext.colors[ info[#info] ]
									return t.r, t.g, t.b
								end,
								set = function(info, r, g, b)
									db.datatext.colors[ info[#info] ] = {}
									local t = db.datatext.colors[ info[#info] ]
									t.r, t.g, t.b = r, g, b
									StaticPopup_Show("CFG_RELOAD")
								end,					
							},								
						},
					},					
					DataGroup = {
						order = 12,
						type = "group",
						name = L["Text Positions"],
						childGroups = "tree",
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
				name = L["|cff00B4FFMerchant|r Options"],
				desc = L["Options for enteraction with a merchant."],
				childGroups = "tree",
				get = function(info) return db.merchant[ info[#info] ] end,
				set = function(info, value) db.merchant[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Options for enteraction with a merchant."],
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
			nameplates = {
				order = 7,
				type = "group",
				name = L["|cff00B4FFNameplate|r Options"],
				desc = L["Options for Nameplates."],
				childGroups = "tree",
				get = function(info) return db.nameplates[ info[#info] ] end,
				set = function(info, value) db.nameplates[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Options for Nameplates."],
					},			
					enable = {
						type = "toggle",
						order = 2,
						width = "full",
						name = L["Enable"],
						desc = L["Enable Nameplate Settings"],							
					},
					framescale= {
						order = 3,
						name = L["Frame Scale"],
						desc = L["Controls the scale of the Nameplates Frame."],
						type = "range",
						min = 0.25, max = 2, step = 0.25,
						disabled = function() return not db.nameplates.enable end,
					},				
					raidmarkiconsize= {
						order = 4,
						name = L["Target Marker Icon Size"],
						desc = L["Controls the icon size of the Target Marker."],
						type = "range",
						min = 10, max = 50, step = 10,
						disabled = function() return not db.nameplates.enable end,
					},
					castbar = {
						type = "group",
						order = 5,
						name = L["Castbar"],
						desc = L["Nameplate Castbar Options"],
						guiInline = true,
						disabled = function() return not db.nameplates.enable end,
						get = function(info) return db.nameplates.castbar[ info[#info] ] end,
						set = function(info, value) db.nameplates.castbar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {							
							scale = {
								order = 1,
								name = L["Scale"],
								desc = L["Set the Scale of the Castbar."],
								type = "range",
								min = 0.5, max = 2, step = 0.5,
								disabled = function() return not db.nameplates.enable end,
							},
							iconsize = {
								order = 2,
								name = L["Icon Size"],
								desc = L["Set the Size of the Castbar Icon."],
								type = "range",
								min = 10, max = 50, step = 5,
								disabled = function() return not db.nameplates.enable end,
							},							
							colordefault = {
								order = 3,
								type = "color",
								name = L["Default Color"],
								desc = L["Picks the Default Color of the Nameplate Castbar."],
								hasAlpha = false,
								disabled = function() return not db.nameplates.enable end,
								get = function(info)
									local hb = db.nameplates.castbar[ info[#info] ]
									return hb.r, hb.g, hb.b
								end,
								set = function(info, r, g, b)
									db.nameplates.castbar[ info[#info] ] = {}
									local hb = db.nameplates.castbar[ info[#info] ]
									hb.r, hb.g, hb.b = r, g, b
								end,					
							},
							colorshielded = {
								order = 4,
								type = "color",
								name = L["Shielded Color"],
								desc = L["Picks the Shielded Color of the Nameplate Castbar."],
								hasAlpha = false,
								disabled = function() return not db.nameplates.enable end,
								get = function(info)
									local hb = db.nameplates.castbar[ info[#info] ]
									return hb.r, hb.g, hb.b
								end,
								set = function(info, r, g, b)
									db.nameplates.castbar[ info[#info] ] = {}
									local hb = db.nameplates.castbar[ info[#info] ]
									hb.r, hb.g, hb.b = r, g, b
								end,					
							},
						},
					},					
					hpvalue = {
						type = "group",
						order = 6,
						name = L["HP Value"],
						desc = L["Health Points Value on Nameplates."],
						guiInline = true,
						disabled = function() return not db.nameplates.enable end,
						get = function(info) return db.nameplates.hpvalue[ info[#info] ] end,
						set = function(info, value) db.nameplates.hpvalue[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {							
							enable = {
								order = 1,
								name = L["Enable"],
								desc = L["Enable HP Value on Nameplates."],
								width = "full",
								type = "toggle",
								disabled = function() return not db.nameplates.enable end,
							},
							size = {
								order = 2,
								name = L["Font Size"],
								desc = L["Set the Font Size of the HP Value on Nameplates."],
								width = "full",
								type = "range",
								min = 8, max = 20, step = 1,
								disabled = function() return not db.nameplates.enable end,
							},
						},
					},
					lowHpWarning = {
						type = "group",
						order = 7,
						name = L["Low HP Warning"],
						desc = L["Low HP Waring Options"],
						guiInline = true,
						disabled = function() return not db.nameplates.enable end,
						get = function(info) return db.nameplates.lowHpWarning[ info[#info] ] end,
						set = function(info, value) db.nameplates.lowHpWarning[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {							
							enable = {
								order = 1,
								name = L["Enable Low HP Warning"],
								desc = L["Check to enable Low HP Warning."],
								width = "full",
								type = "toggle",
								disabled = function() return not db.nameplates.enable end,
							},
							threshold = {
								order = 2,
								name = L["Threshold"],
								desc = L["Set the Threshold of the Low HP Warning."],
								width = "full",
								type = "range",
								min = 5, max = 100, step = 5,
								disabled = function() return not db.nameplates.enable end,
							},							
							color = {
								order = 3,
								type = "color",
								name = L["Color"],
								desc = L["Picks a Color for the Low HP Warning."],
								hasAlpha = false,
								disabled = function() return not db.nameplates.lowHpWarning.enable or not db.nameplates.enable end,
								get = function(info)
									local hb = db.nameplates.lowHpWarning[ info[#info] ]
									return hb.r, hb.g, hb.b
								end,
								set = function(info, r, g, b)
									db.nameplates.lowHpWarning[ info[#info] ] = {}
									local hb = db.nameplates.lowHpWarning[ info[#info] ]
									hb.r, hb.g, hb.b = r, g, b
								end,					
							},
						},
					},
					name = {
						type = "group",
						order = 8,
						name = L["Name's"],
						desc = L["Nameplates Name"],
						guiInline = true,
						disabled = function() return not db.nameplates.enable end,
						get = function(info) return db.nameplates.name[ info[#info] ] end,
						set = function(info, value) db.nameplates.name[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {							
							enable = {
								order = 1,
								name = L["Enable"],
								desc = L["Enable the Name's on the Nameplates."],
								width = "full",
								type = "toggle",
								disabled = function() return not db.nameplates.enable end,
							},
							size = {
								order = 2,
								name = L["Font Size"],
								desc = L["Set the Size of the Name's Font on the Nameplates."],
								width = "full",
								type = "range",
								min = 8, max = 20, step = 1,
								disabled = function() return not db.nameplates.enable end,
							},
						},
					},										
				},
			},
			powerbar = {
				order = 7,
				type = "group",
				name = L["|cff00B4FFPowerbar|r Options"],
				desc = L["Powerbar for all classes with ComboPoints, Runes, Shards, and HolyPower."],
				childGroups = "tree",
				get = function(info) return db.powerbar[ info[#info] ] end,
				set = function(info, value) db.powerbar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Powerbar for all classes with ComboPoints, Runes, Shards, and HolyPower."],
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
					showEclipseBar = {
						order = 4,
						name = L["Eclipsebar"],
						desc = L["Move the Eclipsebar above Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},					
					showSoulshards = {
						order = 5,
						name = L["Soulshards"],
						desc = L["Shows Shards as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showHolypower = {
						order = 6,
						name = L["Holypower"],
						desc = L["Shows Holypower as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showComboPoints = {
						order = 7,
						name = L["ComboPoints"],
						desc = L["Shows ComboPoints as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showRuneCooldown = {
						order = 8,
						name = L["Rune Cooldown"],
						desc = L["Shows Runes cooldowns as numbers."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					energybar = {
						order = 9,
						name = L["Energybar"],
						desc = L["Shows Energy Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					focusbar = {
						order = 10,
						name = L["Focusbar"],
						desc = L["Shows Focus Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					manabar = {
						order = 11,
						name = L["Manabar"],
						desc = L["Shows Mana Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					ragebar = {
						order = 12,
						name = L["Ragebar"],
						desc = L["Shows Rage Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					runebar = {
						order = 13,
						name = L["Runebar"],
						desc = L["Shows Rune Powerbar."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					sizeWidth= {
						order = 14,
						name = L["Width"],
						desc = L["Controls the width of Powerbar."],
						type = "range",
						min = 50, max = 350, step = 25,
						disabled = function() return not db.powerbar.enable end,
					},					
					combo = {
						type = "group",
						order = 15,
						name = L["Combo"],
						desc = L["Combo Points Options"],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.combo[ info[#info] ] end,
						set = function(info, value) db.powerbar.combo[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Options for Combo Points"],
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
						order = 16,
						name = L["Extra"],
						desc = L["Options for Soulshards and Holypower Text."],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.extra[ info[#info] ] end,
						set = function(info, value) db.powerbar.extra[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Options for Soulshards and Holypower Text."],
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
						order = 17,
						name = L["Rune"],
						desc = L["Options for Rune Text."],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.rune[ info[#info] ] end,
						set = function(info, value) db.powerbar.rune[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Options for Rune Text."],
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
						order = 18,
						name = L["Value"],
						desc = L["Shows the Value on the PowerBar."],
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.value[ info[#info] ] end,
						set = function(info, value) db.powerbar.value[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Shows the Value on the PowerBar."],
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
				name = L["|cff00B4FFQuest|r Options"],
				desc = L["Options for autocompleting your quests."],
				childGroups = "tree",
				get = function(info) return db.quest[ info[#info] ] end,
				set = function(info, value) db.quest[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Options for autocompleting your quests."],
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
				name = L["|cff00B4FFSelfbuff|r Options"],
				desc = L["Reminds player when they are missing there class buff."],
				childGroups = "tree",
				get = function(info) return db.selfbuffs[ info[#info] ] end,
				set = function(info, value) db.selfbuffs[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Reminds player when they are missing there class buff."],
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
				name = L["|cff00B4FFTooltip|r Options"],
				desc = L["Options for custom tooltip."],
				childGroups = "tree",
				get = function(info) return db.tooltip[ info[#info] ] end,
				set = function(info, value) db.tooltip[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,					
				args = {
					intro = {
						order = 1,
						type = "description",
						name = L["Options for custom tooltip."],
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
						disabled = function() return not db.tooltip.enable end,
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
						desc = L["Players Healthbar Options."],
						guiInline = true,
						disabled = function() return not db.tooltip.enable end,
						get = function(info) return db.tooltip.healthbar[ info[#info] ] end,
						set = function(info, value) db.tooltip.healthbar[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,						
						args = {
							intro = {
								order = 1,
								type = "description",
								name = L["Players Healthbar Options."],
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
								disabled = function() return not db.tooltip.enable end,
							},														
							custom = {
								type = "group",
								order = 5,
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
								order = 6,
								name = L["Text Position"],
								desc = L["Health Value Position."],
								disabled = function() return not db.tooltip.enable end,
								type = "select",
								values = B.regions;
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
		},
	}

end

function BasicUIConfig:SetDefaultOptions()
	local B, _, _ = unpack(BasicUI)
	local addon = self.db.profile;
	addon.buff = {
		['enable'] = true,
		['scale'] = 1.15,
	}
	addon.castbar = {
		['enable'] = true,
		
		["CastingBarFrame"] = {
			['enabled'] = true,
			['textPosition'] = "CENTER",
			['enableLag'] = true,
			['enableTimer'] = true,
			['selfAnchor'] = "BOTTOM",
			['relAnchor'] = "BOTTOM",
			['offSetX'] = 0,
			['offSetY']	= 175,
		},
		["TargetFrameSpellBar"] = {
			['enabled'] = false,
			['textPosition'] = "CENTER",
			['enableLag'] = true,
			['enableTimer'] = true,
			['selfAnchor'] = "TOP",
			['relAnchor'] = "TOP",
			['offSetX']	= 0,
			['offSetY']	= -200,
		},
		["FocusFrameSpellBar"] = {
			['enabled'] = true,
			['textPosition'] = "CENTER",
			['enableLag'] = true,
			['enableTimer'] = true,
			['selfAnchor'] = "TOP",
			['relAnchor'] = "TOP",
			['offSetX']	= 0,
			['offSetY']	= -165,
		},
		["MirrorTimer1"] = {
			['enabled'] = true,
			['textPosition'] = "CENTER",
			['enableTimer'] = true,
			['selfAnchor'] = "TOP",
			['relAnchor'] = "TOP",
			['offSetX']	= 0,
			['offSetY']	= -10,
		},
		["PetCastingBarFrame"] = {
			['enabled'] = true,
			['textPosition'] = "CENTER",
			['enableTimer'] = true,
			['selfAnchor'] = "BOTTOM",
			['relAnchor'] = "BOTTOM",
			['offSetX']	= 0,
			['offSetY']	= 200,
		},
	}	
	addon.chat = {
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
	addon.datatext = {	
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
	addon.general = {
		['autogreed'] = true,
		['cooldown'] = true,
		['itemquality'] = true,
		['font'] = "Fonts\\ARIALN.ttf",						
		['fontsize'] = 14,
		['slidebar'] = true,
		['scale'] = {
			['enable'] = true,
			['size'] = 1.15,
		},
		['mail'] = {
			['enable'] = true,
			['openall'] = true,
			['BlackBook'] = {
				['enable'] = true,
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
		['skin'] = {
			['enable'] = true,
			['DBM'] = true,
			['Recount'] = true,
			['RecountBackdrop'] = true,
		},

		['buttons'] = {
		
			['enable'] = true,
			['showHotKeys'] = false,
			['showMacronames'] = false,
			
			-- Button Colors
			['color'] = {   		
				['OutOfRange'] = { r = 0.9, g = 0, b = 0 },
				['OutOfMana'] = { r = 0, g = 0, b = 0.9 },			
				['NotUsable'] = { r = 0.3, g = 0.3, b = 0.3 },
			},
		},		
	}
	addon.merchant = {
		['enable'] = true,										-- enable merchant module.
		['sellMisc'] = true, 									-- allows the user to add spacific items to sell at merchant (please see the local filter in merchant.lua)
		['autoSellGrey'] = true,								-- autosell grey items at merchant.
		['autoRepair'] = true,									-- autorepair at merchant.
	}
	addon.nameplates = {
		['enable'] = true,
		['framescale'] = 1,
		['raidmarkiconsize'] = 25,
		['castbar'] = {
			['scale'] = 1,
			['iconsize'] = 30,
			['colordefault']   = { r = 1, g = 0.6, b = 0 },
			['colorshielded']  = { r = 0.8, g = 0.8, b = 0.8 },
		},
		['hpvalue'] = {
			['enable'] = true,
			['size'] = 11,
		},
		['lowHpWarning'] = {
			['enable'] = true,
			['threshold'] = 25,
			['color'] = { r = 1, g = 0, b = 0 },
		},	
		['name'] = {
			['enable'] = true,
			['size'] = 12,
		},
	}	
	addon.powerbar = {
		['enable'] = true,
		['sizeWidth'] = 200,
		
		['showCombatRegen'] = true, 
		['showSoulshards'] = true,
		['showHolypower'] = true,
		['showComboPoints'] = true,
		['showRuneCooldown'] = true,
		['showEclipseBar'] = true,
			
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
	addon.quest = {
		['enable'] = true,									-- enable quest module.
		['autocomplete'] = false,							-- enable the autoaccept quest and autocomplete quest if no reward.
	}
	addon.selfbuffs = {
		['enable'] = true,									-- enable selbuffs module.
		['sound'] = true,									-- sound warning
	}
	addon.tooltip = {											
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
end