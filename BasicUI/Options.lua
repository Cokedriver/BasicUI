local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI", "AceConsole-3.0", "AceEvent-3.0")
local LSM = LibStub("LibSharedMedia-3.0")

local L = setmetatable({}, { __index = function(t,k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })

local options

local function GetOptions()
	if options then
		return options -- @PHANX: do this first, no point in defining variables if they won't be used
	end

	local db = BasicUI.db.profile -- @PHANX: this should be local here

	local regions = {
		['BOTTOM'] = L['Bottom'],
		['BOTTOMLEFT'] = L['Bottom Left'],
		['BOTTOMRIGHT'] = L['Bottom Right'],
		['CENTER'] = L['Center'],
		['LEFT'] = L['Left'],
		['RIGHT'] = L['Right'],
		['TOP'] = L['Top'],
		['TOPLEFT'] = L['Top Left'],
		['TOPRIGHT'] = L['Top Right'],
	}

	-----------------------
	-- Options Order Chart
	-----------------------
	-- ReloadUI = 0
	-- Enable = 1
	-- toggle = 2
	-- select = 3
	-- color = 4
	-- range = 5
	-- group = 6

	options = {
		type = "group",
		name = "BasicUI", -- @PHANX: don't use colors here, it will screw up alphabetizing
		handler = BasicUI,
		--childGroups = "tab", -- @PHANX: this is the default, you don't need to specify it, you can delete this line
		args = {
			welcome = { -- @PHANX: moved all the "welcome" text into a group, you'll see why later
				type = "group",
				order = 1,
				name = "BasicUI",
				args = {
					Text = {
						type = "description",
						order = 1,
						name = L["Welcome to |cff00B4FFBasic|rUI Config Area!"],
						width = "full",
						fontSize = "medium",
					},
					Text2 = {
						type = "description",
						order = 2,
						name = L["When changes are made a reload of the UI is needed."],
						width = "full",
						fontSize = "medium",
					},
					Text3 = {
						type = "description",
						order = 3,
						name = L["Special Thanks for |cff00B4FFBasic|rUI goes out to: Phanx, Neav, Tuks, Elv, Baine, Treeston, and many more."],
						width = "full",
						fontSize = "medium",
					},
					Text4 = {
						type = "description",
						order = 4,
						name = L["Thank you all for your AddOns, coding help, and support in creating |cff00B4FFBasic|rUI."],
						width = "full",
						fontSize = "medium",
					},
				},
			},			
			media = {
				type = "group",	
				order = 0,				
				name = L["Media"],
				desc = L["Media Options for BasicUI."],
				get = function(info) return db.media[ info[#info] ] end,
				set = function(info, value) db.media[ info[#info] ] = value;   end,														
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,						
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,						
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,						
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,						
						name = " ",
					},	
					---------------------------	
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},					
					fontSize = {
						type = "range",
						order = 5,						
						name = L["Game Font Size"],
						desc = L["Controls the Size of the Game Font"],
						min = 0,
						max = 30,
						step = 1,
					},									
				},
			},
			misc = {
				type = "group",
				order = 1,
				name = L["Miscellaneous"],
				desc = L["Miscellaneous options for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.misc[ info[#info] ] end,
				set = function(info, value) db.misc[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,						
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,						
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,						
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,						
						name = " ",
					},	
					---------------------------	
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},					
					classcolor = {
						type = "toggle",					
						order = 2,
						name = L["Class Color"],
						desc = L["Use your classcolor for border and some text color."],
					},				
					vellum = {
						type = "toggle",
						order = 2,						
						name = L["Vellum"],
						desc = L["Enables a vellum button for Enchanters to click."],							
					},
					flashmapnodes = {
						type = "toggle",
						order = 2,						
						name = L["Flashing Map Nodes"],
						desc = L["Enables flashing map nodes for tracking herbs and ore."],							
					},
					cooldown = {
						type = "toggle",
						order = 2,						
						name = L["Cooldown"],
						desc = L["Enables a version of OmniCC."],							
					},
					quicky = {
						type = "toggle",
						order = 2,						
						name = L["Quicky"],
						desc = L["Enables a quick hide show for your helm and cloak on your character page."],							
					},
				},
			},			
			actionbar = {
				type = "group",
				order = 2,
				name = L["Actionbars"],
				desc = L["Actionbar Button Modifications."],
				childGroups = "tree",
				get = function(info) return db.actionbar[ info[#info] ] end,
				set = function(info, value) db.actionbar[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables Actionbar Button Module"],
						width = "full",
					},
					auraborder = {
						type = "toggle",
						order = 2,
						name = L["Aura Border"],
						desc = L["Make & Color Aura Borders."],
						disabled = function() return not db.actionbar.enable end,
					},
					showHotKeys = {
						type = "toggle",
						order = 2,
						name = L["Show Hot Keys"],
						desc = L["If Checked Hot Keys will Show."],
						disabled = function() return not db.actionbar.enable end,
					},
					showMacronames = {
						type = "toggle",
						order = 2,
						name = L["Show Macro Names"],
						desc = L["If Checked Macros Will Show."],
						disabled = function() return not db.actionbar.enable end,
					},
					color = {
						type = "group",
						order = 6,
						name = L["Actionbar Button Color"],
						desc = L["Enables Actionbar Button Color Modifications."],
						guiInline  = true,
						get = function(info) return db.actionbar.color[ info[#info] ] end,
						set = function(info, value) db.actionbar.color[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 5,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 1,
								name = L["Enable"],
								desc = L["Enables Coloring"],
								width = "full",
							},
							OutOfRange = {
								type = "color",
								order = 4,
								name = L["Out of Range"],
								desc = L["Picks the Out of Range Button Fade Color."],
								disabled = function() return not db.actionbar.enable or not db.actionbar.color.enable end,
								get = function(info)
									local rc = db.actionbar.color[ info[#info] ]
									return rc.r, rc.g, rc.b
								end,
								set = function(info, r, g, b)
									db.actionbar.color[ info[#info] ] = {}
									local rc = db.actionbar.color[ info[#info] ]
									rc.r, rc.g, rc.b = r, g, b
								end,
							},
							OutOfMana = {
								type = "color",
								order = 4,
								name = L["Out of Mana"],
								desc = L["Picks the Out of Mana Button Fade Color."],
								disabled = function() return not db.actionbar.enable or not db.actionbar.color.enable end,
								get = function(info)
									local mc = db.actionbar.color[ info[#info] ]
									return mc.r, mc.g, mc.b
								end,
								set = function(info, r, g, b)
									db.actionbar.color[ info[#info] ] = {}
									local mc = db.actionbar.color[ info[#info] ]
									mc.r, mc.g, mc.b = r, g, b
								end,
							},
							NotUsable = {
								type = "color",
								order = 4,
								name = L["Not Usable"],
								desc = L["Picks the Not Usable Button Fade Color."],
								disabled = function() return not db.actionbar.enable or not db.actionbar.color.enable end,
								get = function(info)
									local nu = db.actionbar.color[ info[#info] ]
									return nu.r, nu.g, nu.b
								end,
								set = function(info, r, g, b)
									db.actionbar.color[ info[#info] ] = {}
									local nu = db.actionbar.color[ info[#info] ]
									nu.r, nu.g, nu.b = r, g, b
								end,
							},
						},
					},
				},
			},
			buff = {
				type = "group",
				order = 3,
				name = L["Buffs"],
				desc = L["Buff Module for BasicUI."],
				get = function(info) return db.buff[ info[#info] ] end,
				set = function(info, value) db.buff[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables Buff Module."],
						width = "full",
					},
					scale = {
						type = "range",
						order = 5,
						name = L["Buff Scale"],
						--desc = L["Controls the scaling of the Buff Frames"],
						min = 0.05, max = 5, step = 0.05,
						disabled = function() return not db.buff.enable end,
						set = function(info, value) 
							db.buff[ info[#info] ] = value
							local BasicBuffs = BasicUI:GetModule("Buffs")
							BasicBuffs:UpdateScale()
						end,
					},
				},
			},
			castbar = {
				type = "group",
				order = 4,
				name = L["Castbars"],
				desc = L["Castbar Module for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.castbar[ info[#info] ] end,
				set = function(info, value) db.castbar[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables Buff Module"],
						width = "full",
					},
					CastingBarFrame = {
						type = "group",
						order = 5,
						name = L["Player's Castbar."],
						desc = L["Settings for the Player Castbar."],
						guiInline  = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.CastingBarFrame[ info[#info] ] end,
						set = function(info, value) db.castbar.CastingBarFrame[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 1,
								name = L["Enable"],
								desc = L["Enables Player's Castbar."],
								disabled = function() return not db.castbar.enable end,
								width = "full",
							},
							fontSize = {
								type = "range",
								order = 5,
								name = L["Font Size"],
								desc = L["Controls the Size of the Font"],
								min = 0, max = 30, step = 1,
							},
							textPosition = {
								type = "select",
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								values = regions,
							},
							enableLag = {
								type = "toggle",
								order = 2,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							enableTimer = {
								type = "toggle",
								order = 2,
								name = L["Show Timer"],
								desc = L["Enables timer to show on castbar."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							selfAnchor = {
								type = "select",
								order = 3,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								values = regions,
							},
							relAnchor = {
								type = "select",
								order = 3,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
								values = regions,
							},
							offSetX = {
								type = "range",
								order = 5,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
							offSetY = {
								type = "range",
								order = 5,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.CastingBarFrame.enable end,
							},
						},
					},
					PetCastingBarFrame = {
						type = "group",
						order = 6,
						name = L["Pet Castbar"],
						desc = L["Settings for the Pet Casting Bar."],
						guiInline  = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.PetCastingBarFrame[ info[#info] ] end,
						set = function(info, value) db.castbar.PetCastingBarFrame[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 1,
								name = L["Enable"],
								desc = L["Enables Pet's Castbar."],
								disabled = function() return not db.castbar.enable end,
								width = "full",
							},
							fontSize = {
								type = "range",
								order = 5,
								name = L["Font Size"],
								desc = L["Controls the Size of the Font"],
								min = 0, max = 30, step = 1,
							},
							textPosition = {
								type = "select",
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								values = regions,
							},
							enableTimer = {
								type = "toggle",
								order = 2,
								name = L["Show Timer"],
								desc = L["Enables timer to show on castbar."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
							},
							selfAnchor = {
								type = "select",
								order = 3,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								values = regions,
							},
							relAnchor = {
								type = "select",
								order = 3,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
								values = regions,
							},
							offSetX = {
								type = "range",
								order = 5,
								name = L["X Offset."],
								desc = L["Controls the X offset. (Left - Right)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
							},
							offSetY = {
								type = "range",
								order = 5,
								name = L["Y Offset."],
								desc = L["Controls the Y offset. (Up - Down)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.PetCastingBarFrame.enable end,
							},
						},
					},
					TargetFrameSpellBar = {
						type = "group",
						order = 7,
						name = L["Target's Castbar."],
						desc = L["Settings for the Target Castbar."],
						guiInline  = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.TargetFrameSpellBar[ info[#info] ] end,
						set = function(info, value) db.castbar.TargetFrameSpellBar[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 1,
								name = L["Enable"],
								desc = L["Enables Target's Castbar."],
								disabled = function() return not db.castbar.enable end,
								width = "full",
							},
							fontSize = {
								type = "range",
								order = 5,
								name = L["Font Size"],
								desc = L["Controls the Size of the Font"],
								min = 0, max = 30, step = 1,
							},
							textPosition = {
								type = "select",
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								values = regions,
							},
							enableLag = {
								type = "toggle",
								order = 2,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							enableTimer = {
								type = "toggle",
								order = 2,
								name = L["Show Timer"],
								desc = L["Enables timer to show on castbar."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							selfAnchor = {
								type = "select",
								order = 3,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								values = regions,
							},
							relAnchor = {
								type = "select",
								order = 3,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
								values = regions,
							},
							offSetX = {
								type = "range",
								order = 5,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
							offSetY = {
								type = "range",
								order = 5,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.TargetFrameSpellBar.enable end,
							},
						},
					},
					FocusFrameSpellBar = {
						type = "group",
						order = 8,
						name = L["Focus Castbar."],
						desc = L["Settings for the Focus Castbar."],
						guiInline  = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.FocusFrameSpellBar[ info[#info] ] end,
						set = function(info, value) db.castbar.FocusFrameSpellBar[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 1,
								name = L["Enable"],
								desc = L["Enables Focus' Castbar."],
								disabled = function() return not db.castbar.enable end,
								width = "full",
							},
							fontSize = {
								type = "range",
								order = 5,
								name = L["Font Size"],
								desc = L["Controls the Size of the Font"],
								min = 0, max = 30, step = 1,
							},
							textPosition = {
								type = "select",
								order = 3,
								name = L["Text Position"],
								desc = L["Spell Text Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								values = regions,
							},
							enableLag = {
								type = "toggle",
								order = 2,
								name = L["Enable Lag"],
								desc = L["Enables lag to show on castbar."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							enableTimer = {
								type = "toggle",
								order = 2,
								name = L["Show Timer"],
								desc = L["Enables timer to show on castbar."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							selfAnchor = {
								type = "select",
								order = 3,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								values = regions,
							},
							relAnchor = {
								type = "select",
								order = 3,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
								values = regions,
							},
							offSetX = {
								type = "range",
								order = 5,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
							offSetY = {
								type = "range",
								order = 5,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.FocusFrameSpellBar.enable end,
							},
						},
					},
					MirrorTimer1 = {
						type = "group",
						order = 9,
						name = L["Mirror Timer."],
						desc = L["Settings for Mirror Timer."],
						guiInline  = true,
						disabled = function() return not db.castbar.enable end,
						get = function(info) return db.castbar.MirrorTimer1[ info[#info] ] end,
						set = function(info, value) db.castbar.MirrorTimer1[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 1,
								name = L["Enable"],
								desc = L["Enables Mirror Timer."],
								disabled = function() return not db.castbar.enable end,
								width = "full",
							},
							fontSize = {
								type = "range",
								order = 5,
								name = L["Font Size"],
								desc = L["Controls the Size of the Font"],
								min = 0, max = 30, step = 1,
							},
							enableTimer = {
								type = "toggle",
								order = 2,
								name = L["Show Timer"],
								desc = L["Enables timer to show on castbar."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
							},
							selfAnchor = {
								type = "select",
								order = 3,
								name = L["Self Anchor"],
								desc = L["Self Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
								values = regions,
							},
							relAnchor = {
								type = "select",
								order = 3,
								name = L["Relative Anchor"],
								desc = L["Relative Anchor Position."],
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
								values = regions,
							},
							offSetX = {
								type = "range",
								order = 5,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
							},
							offSetY = {
								type = "range",
								order = 5,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.castbar.enable or not db.castbar.MirrorTimer1.enable end,
							},
						},
					},
				},
			},
			chat = {
				type = "group",
				order = 5,
				name = L["Chat"],
				desc = L["Chat Module for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.chat[ info[#info] ] end,
				set = function(info, value) db.chat[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables Chat Module."],
						width = "full",
					},
					windowborder = {
						type = "toggle",
						order = 2,
						name = L["Window Border"],
						desc = L["Enables Chat Window Border."],
						disabled = function() return not db.chat.enable end,
					},
					disableFade = {
						type = "toggle",
						order = 2,
						name = L["Disable Fade"],
						desc = L["Disables Chat Fading."],
						disabled = function() return not db.chat.enable end,
					},
					chatOutline = {
						type = "toggle",
						order = 2,
						name = L["Chat Outline"],
						desc = L["Outlines the chat Text."],
						disabled = function() return not db.chat.enable end,
					},
					enableBottomButton = {
						type = "toggle",
						order = 2,
						name = L["Enable Bottom Button"],
						desc = L["Enables the scroll down button in the lower right hand corner."],
						disabled = function() return not db.chat.enable end,
					},
					enableHyperlinkTooltip = {
						type = "toggle",
						order = 2,
						name = L["Enable Hyplerlink Tooltip"],
						desc = L["Enables the mouseover items in chat tooltip."],
						disabled = function() return not db.chat.enable end,
					},
					enableBorderColoring = {
						type = "toggle",
						order = 2,
						name = L["Enable Editbox Channel Border Coloring"],
						desc = L["Enables the coloring of the border to the edit box to match what channel you are typing in."],
						disabled = function() return not db.chat.enable end,
					},
					tab = {
						type = "group",
						order = 6,
						name = L["Tabs"],
						desc = L["Tab Font Settings."],
						guiInline  = true,
						disabled = function() return not db.chat.enable end,
						get = function(info) return db.chat.tab[ info[#info] ] end,
						set = function(info, value) db.chat.tab[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 5,
								name = " ",
							},
							---------------------------
							fontSize = {
								type = "range",
								order = 5,
								name = L["Font Size"],
								desc = L["Controls the size of the tab font"],
								type = "range",
								min = 9, max = 20, step = 1,
							},
							fontOutline = {
								type = "toggle",
								order = 2,
								name = L["Outline Tab Font"],
								desc = L["Enables the outlineing of tab font."],
							},
							normalColor = {
								type = "color",
								order = 4,
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
									StaticPopup_Show("BASICUI_CFG_RELOAD")
								end,
							},
							specialColor = {
								type = "color",
								order = 4,
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
									StaticPopup_Show("BASICUI_CFG_RELOAD")
								end,
							},
							selectedColor = {
								type = "color",
								order = 4,
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
									StaticPopup_Show("BASICUI_CFG_RELOAD")
								end,
							},
						},
					},
				},
			},
			datapanel = {
				type = "group",
				order = 6,
				name = L["Datapanel"],
				desc = L["datapanel Module for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.datapanel[ info[#info] ] end,
				set = function(info, value) db.datapanel[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables datapanel Module."],
					},
					time24 = {
						type = "toggle",
						order = 2,
						name = L["24-Hour Time"],
						desc = L["Display time datapanel on a 24 hour time scale"],
						disabled = function() return not db.datapanel.enable end,
					},
					bag = {
						type = "toggle",
						order = 2,
						name = L["Bag Open"],
						desc = L["Checked opens Backpack only, Unchecked opens all bags."],
						disabled = function() return not db.datapanel.enable end,
					},
					battleground = {
						type = "toggle",
						order = 2,
						name = L["Battleground Text"],
						desc = L["Display special datapanels when inside a battleground"],
						disabled = function() return not db.datapanel.enable end,
					},
					recountraiddps = {
						type = "toggle",
						order = 2,
						name = L["Recount Raid DPS"],
						desc = L["Display Recount's Raid DPS (RECOUNT MUST BE INSTALLED)"],
						disabled = function() return not db.datapanel.enable end,
					},
					DataGroup = {
						type = "group",
						order = 6,
						name = L["Text Positions"],
						guiInline  = true,
						disabled = function() return not db.datapanel.enable end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 5,
								name = " ",
							},
							---------------------------
							bags = {
								type = "range",
								order = 5,
								name = L["Bags"],
								desc = L["Display ammount of bag space"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							calltoarms = {
								type = "range",
								order = 5,
								name = L["Call to Arms"],
								desc = L["Display the active roles that will recieve a reward for completing a random dungeon"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							coords = {
								type = "range",
								order = 5,
								name = L["Coordinates"],
								desc = L["Display Player's Coordinates"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							dps_text = {
								type = "range",
								order = 5,
								name = L["DPS"],
								desc = L["Display ammount of DPS"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							dur = {
								type = "range",
								order = 5,
								name = L["Durability"],
								desc = L["Display your current durability"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							friends = {
								type = "range",
								order = 5,
								name = L["Friends"],
								desc = L["Display current online friends"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							guild = {
								type = "range",
								order = 5,
								name = L["Guild"],
								desc = L["Display current online people in guild"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							hps_text = {
								type = "range",
								order = 5,
								name = L["HPS"],
								desc = L["Display ammount of HPS"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							pro = {
								type = "range",
								order = 5,
								name = L["Professions"],
								desc = L["Display Professions"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							recount = {
								type = "range",
								order = 5,
								name = L["Recount"],
								desc = L["Display Recount's DPS (RECOUNT MUST BE INSTALLED)"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							spec = {
								type = "range",
								order = 5,
								name = L["Talent Spec"],
								desc = L["Display current spec"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							stat1 = {
								type = "range",
								order = 5,
								name = L["Stat #1"],
								desc = L["Display stat based on your role (Avoidance-Tank, AP-Melee, SP/HP-Caster)"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							stat2 = {
								type = "range",
								order = 5,
								name = L["Stat #2"],
								desc = L["Display stat based on your role (Armor-Tank, Crit-Melee, Crit-Caster)"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							system = {
								type = "range",
								order = 5,
								name = L["System"],
								desc = L["Display FPS and Latency"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							wowtime = {
								type = "range",
								order = 5,
								name = L["Time"],
								desc = L["Display current time"]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
							zone = {
								type = "range",
								order = 5,
								name = L["Zone"],
								desc = L["Display Player's Current Zone."]..L["\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"],
								min = 0, max = 9, step = 1,
								disabled = function() return not db.datapanel.enable end,
							},
						},
					},
				},
			},
			merchant = {
				type = "group",
				order = 7,
				name = L["Merchant"],
				desc = L["Merchant Module for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.merchant[ info[#info] ] end,
				set = function(info, value) db.merchant[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enable Merchant Settings"],
						width = "full",
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
						order = 2,
						name = L["Sell Grays"],
						desc = L["Automatically sell gray items when visiting a vendor"],
						disabled = function() return not db.merchant.enable end,
					},
					sellMisc = {
						type = "toggle",
						order = 2,
						name = L["Sell Misc Items"],
						desc = L["Automatically sell a user selected item."],
						disabled = function() return not db.merchant.enable end,
					},
				},
			},
			minimap = {
				type = "group",
				order = 8,
				name = L["Minimap"],
				desc = L["Enables Minimap Modifications."],
				get = function(info) return db.minimap[ info[#info] ] end,
				set = function(info, value) db.minimap[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables Minimap Modifications."],
						width = "full"
					},
					farm = {
						type = "toggle",
						order = 2,
						name = L["Farming"],
						desc = L["Enlarges the Minimap when Farming."],
						disabled = function() return not db.minimap.enable end,
					},
					farmscale = {
						type = "range",
						order = 5,
						name = L["Farming Map Scale"],
						desc = L["Controls the Size of the Farming Map"],
						disabled = function() return not db.minimap.enable or not db.minimap.farm end,
						min = 1, max = 5, step = 0.1,
					},
					gameclock = {
						type = "toggle",
						order = 2,
						name = L["Game Clock"],
						desc = L["Enable the Clock Frame on Minimap."],
						disabled = function() return not db.minimap.enable end,
					},
				},
			},
			nameplates = {
				type = "group",
				order = 9,
				name = L["Nameplates"],
				desc = L["Nameplate Module for BasicUI."],
				get = function(info) return db.nameplates[ info[#info] ] end,
				set = function(info, value) db.nameplates[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enable Nameplate Settings"],
						width = "full",
					},
					enableTankMode = {
						type = "toggle",
						order = 2,
						name = L["Enable Tank Mode"],
						disabled = function() return not db.nameplates.enable end,
					},
					colorNameWithThreat = {
						type = "toggle",
						order = 2,
						name = L["Color Name With Threat"],
						disabled = function() return not db.nameplates.enable end,
					},
					showFullHP = {
						type = "toggle",
						order = 2,
						name = L["Show Full HP"],
						disabled = function() return not db.nameplates.enable end,
					},
					showLevel = {
						type = "toggle",
						order = 2,
						name = L["Show Level"],
						disabled = function() return not db.nameplates.enable end,
					},
					showTargetBorder = {
						type = "toggle",
						order = 2,
						name = L["Show Target Border"],
						disabled = function() return not db.nameplates.enable end,
					},
					showEliteBorder = {
						type = "toggle",
						order = 2,
						name = L["Show Elite Border"],
						disabled = function() return not db.nameplates.enable end,
					},
					showTotemIcon = {
						type = "toggle",
						order = 2,
						name = L["Show Totem Icon"],
						disabled = function() return not db.nameplates.enable end,
					},
					abbrevLongNames = {
						type = "toggle",
						order = 2,
						name = L["Abbrev Long Names"],
						disabled = function() return not db.nameplates.enable end,
					},
				},
			},
			powerbar = {
				order = 10,
				type = "group",
				name = L["Powerbar"],
				desc = L["Powerbar for all classes with ComboPoints, Runes, Shards, and HolyPower."],
				--childGroups = "tree",
				get = function(info) return db.powerbar[ info[#info] ] end,
				set = function(info, value) db.powerbar[ info[#info] ] = value;  end,					
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,								
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",								
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},	
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},					
					enable = {
						order = 1,
						name = L["Enable"],
						width = "full",
						--desc = L["Enables Powerbar Module"],
						type = "toggle",							
					},					
					showCombatRegen = {
						order = 2,
						name = L["Show Combat Regen"],
						--desc = L["Shows a players Regen while in combat."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},				
					showSoulshards = {
						order = 2,
						name = L["Show Soulshards"],
						--desc = L["Shows Shards as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showHolypower = {
						order = 2,
						name = L["Show Holypower"],
						--desc = L["Shows Holypower as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showMana = {
						order = 2,
						name = L["Show Mana"],
						--desc = L["Shows Holypower as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showFocus = {
						order = 2,
						name = L["Show Focus"],
						--desc = L["Shows Holypower as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					showRage = {
						order = 2,
						name = L["Show Rage"],
						--desc = L["Shows Holypower as a number value."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					valueAbbrev = {
						order = 2,
						name = L["Value Abbrev"],
						--desc = L["Shows Runes cooldowns as numbers."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},
					valueFontOutline = {
						order = 2,
						name = L["Value Font Outline"],
						--desc = L["Shows Focus power."],
						type = "toggle",
						disabled = function() return not db.powerbar.enable end,
					},					
					sizeWidth= {
						order = 5,
						name = L["Size Width"],
						--desc = L["Controls the width of power."],
						type = "range",
						min = 50, max = 350, step = 25,
						disabled = function() return not db.powerbar.enable end,
					},					
					activeAlpha = {
						order = 5,
						name = L["Active Alpha"],
						--desc = L["Shows ComboPoints as a number value."],
						type = "range",
						min = 0, max = 1, step = 0.1,
						disabled = function() return not db.powerbar.enable end,
					},
					inactiveAlpha = {
						order = 5,
						name = L["In Active Alpha"],
						--desc = L["Shows ComboPoints as a number value."],
						type = "range",
						min = 0, max = 1, step = 0.1,
						disabled = function() return not db.powerbar.enable end,
					},
					emptyAlpha = {
						order = 5,
						name = L["Empty Alpha"],
						--desc = L["Shows ComboPoints as a number value."],
						type = "range",
						min = 0, max = 1, step = 0.1,
						disabled = function() return not db.powerbar.enable end,
					},										
					valueFontSize = {
						order = 5,
						name = L["Value Font Size"],
						--desc = L["Shows ComboPoints as a number value."],
						type = "range",
						min = 8, max = 30, step = 1,
						disabled = function() return not db.powerbar.enable end,
					},	
					valueFontAdjustmentX = {
						order = 5,
						name = L["Value Font Adjustment X"],
						--desc = L["Shows ComboPoints as a number value."],
						type = "range",
						min = -200, max = 200, step = 1,
						disabled = function() return not db.powerbar.enable end,
					},
					position = {
						type = "group",
						order = 6,
						guiInline = true,
						name = L["Position"],
						--desc = L["Combo Points Options"],	
						guiInline = true,
						disabled = function() return not db.powerbar.enable end,						
						get = function(info) return db.powerbar.position[ info[#info] ] end,
						set = function(info, value) db.powerbar.position[ info[#info] ] = value;  end,						
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 2,								
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 3,
								name = " ",								
							},
							sep3 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 5,
								name = " ",
							},	
							---------------------------							
							selfAnchor = {
								order = 3,
								name = L["Self Anchor"],
								--desc = L["Style of Border for Sqaure Minimap."],
								disabled = function() return not db.powerbar.enable end,
								type = "select",
								values = regions;
							},
							offSetX = {
								type = "range",							
								order = 5,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.powerbar.enable end,
							},
							offSetY = {
								type = "range",							
								order = 5,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								min = -250, max = 250, step = 5,
								disabled = function() return not db.powerbar.enable end,
							},
						},
					},					
					energy = {
						type = "group",
						order = 5,
						guiInline = true,
						name = L["Energy"],
						--desc = L["Combo Points Options"],	
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.energy[ info[#info] ] end,
						set = function(info, value) db.powerbar.energy[ info[#info] ] = value;  end,						
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 2,								
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 3,
								name = " ",								
							},
							sep3 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 5,
								name = " ",
							},	
							---------------------------							
							show = {
								order = 2,
								name = L["Show"],
								--desc = L["Adds a font outline to ComboPoints."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							showComboPoints = {
								order = 2,
								name = L["Show Combo Points"],
								--desc = L["Adds a font outline to ComboPoints."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							comboPointsBelow = {
								order = 2,
								name = L["Combo Points Below"],
								--desc = L["Adds a font outline to ComboPoints."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},							
							comboFontOutline = {
								order = 2,
								name = L["Combo Font Outline"],
								--desc = L["Adds a font outline to ComboPoints."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							comboFontSize = {
								order = 5,
								name = L["Combo Font Size"],
								--desc = L["Controls the ComboPoints font size."],
								type = "range",
								min = 8, max = 25, step = 1,
								disabled = function() return not db.powerbar.enable end,
							},
						},
					},
					rune = {
						type = "group",
						order = 5,
						guiInline = true,
						name = L["Rune"],
						--desc = L["Options for Rune Text."],	
						disabled = function() return not db.powerbar.enable end,
						get = function(info) return db.powerbar.rune[ info[#info] ] end,
						set = function(info, value) db.powerbar.rune[ info[#info] ] = value;  end,						
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 2,								
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 3,
								name = " ",								
							},
							sep3 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 5,
								name = " ",
							},	
							---------------------------							
							show = {
								order = 2,
								name = L["Show"],
								--desc = L["Adds a font outline to Runes."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							showRuneCooldown = {
								order = 2,
								name = L["Show Rune Cooldown"],
								--desc = L["Adds a font outline to Runes."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},							
							runeFontOutline = {
								order = 2,
								name = L["Rune Font Outline"],
								--desc = L["Adds a font outline to Runes."],
								type = "toggle",
								disabled = function() return not db.powerbar.enable end,
							},
							runeFontSize= {
								order = 5,
								name = L["Rune Font Size"],
								--desc = L["Controls the Runes font size."],
								type = "range",
								min = 8, max = 25, step = 1,
								disabled = function() return not db.powerbar.enable end,
							},						
						},
					},					
				},
			},				
			quest = {
				type = "group",			
				order = 11,
				name = L["Quest"],
				desc = L["Quest Module for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.quest[ info[#info] ] end,
				set = function(info, value) db.quest[ info[#info] ] = value; end,					
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,										
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,										
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,										
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,										
						name = " ",
					},	
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},					
					enable = {
						type = "toggle",					
						order = 1,
						name = L["Enable"],
						desc = L["Enables Quest Module"],							
					},					
					autocomplete = {
						type = "toggle",					
						order = 2,
						name = L["Autocomplete"],
						desc = L["Automatically complete your quest."],
						disabled = function() return not db.quest.enable end,
					},
					tekvendor = {
						type = "toggle",
						order = 2,						
						name = L["Tek's Vendor"],
						desc = L["Enables Tek's best quest item by vendor price."],							
					},
				},
			},
			skin = {
				type = "group",
				order = 12,
				name = L["Skin"],
				desc = L["Skin Module for BasicUI."],
				--childGroups = "tree",				
				get = function(info) return db.skin[ info[#info] ] end,
				set = function(info, value) db.skin[ info[#info] ] = value;  end,						
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,										
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,										
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,										
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,										
						name = " ",
					},	
					---------------------------	
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},					
					enable = {
						type = "toggle",					
						order = 1,
						name = L["Enable"],
						desc = L["Enables AddOn Skinning"],
						width = "full",						
					},						
					DBM = {
						type = "toggle",					
						order = 2,
						name = L["DBM"],
						desc = L["Skins Deadly Boss Mods to match BasicUI."],
						disabled = function() return not db.skin.enable end,
					},
					Recount = {
						type = "toggle",					
						order = 2,
						name = L["Recount"],
						desc = L["Skins Recount to match BasicUI."],
						disabled = function() return not db.skin.enable end,
					},
					RecountBackdrop = {
						type = "toggle",					
						order = 2,
						name = L["Recount Backdrop"],
						desc = L["Keep the backdrop in the Recount Window."],
						disabled = function() return not db.skin.enable end,
					},
				},
			},							
			tooltip = {
				type = "group",
				order = 13,
				name = L["Tooltips"],
				desc = L["Tooltip Module for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.tooltip[ info[#info] ] end,
				set = function(info, value) db.tooltip[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 5,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables Tooltip Module"],
					},
					disableFade = {
						type = "toggle",
						order = 2,
						name = L["Disable Fade"],
						desc = L["Disables Tooltip Fade."],
						disabled = function() return not db.tooltip.enable end,
					},
					reactionBorderColor = {
						type = "toggle",
						order = 2,
						name = L["Reaction Border Color"],
						desc = L["Colors the borders match targets classcolors."],
						disabled = function() return not db.tooltip.enable end,
					},
					itemqualityBorderColor = {
						type = "toggle",
						order = 2,
						name = L["Item Quality Border Color"],
						desc = L["Colors the border of the tooltip to match the items quality."],
						disabled = function() return not db.tooltip.enable end,
					},
					showPlayerTitles = {
						type = "toggle",
						order = 2,
						name = L["Player Titles"],
						desc = L["Shows players title in tooltip."],
						disabled = function() return not db.tooltip.enable end,
					},
					showPVPIcons = {
						type = "toggle",
						order = 2,
						name = L["PVP Icons"],
						desc = L["Shows PvP Icons in tooltip."],
						disabled = function() return not db.tooltip.enable end,
					},
					showUnitRole = {
						type = "toggle",
						order = 2,
						name = L["Show Units Role"],
						desc = L["Shows Units Role in tooltip."],
						disabled = function() return not db.tooltip.enable end,
					},
					abbrevRealmNames = {
						type = "toggle",
						order = 2,
						name = L["Abberviate Realm Names"],
						desc = L["Abberviates Players Realm Name."],
						disabled = function() return not db.tooltip.enable end,
					},
					showMouseoverTarget = {
						type = "toggle",
						order = 2,
						name = L["Mouseover Target"],
						desc = L["Shows mouseover target."],
						disabled = function() return not db.tooltip.enable end,
					},
					showItemLevel = {
						type = "toggle",
						order = 2,
						name = L["Item Level"],
						desc = L["Shows targets average item level."],
						disabled = function() return not db.tooltip.enable end,
					},
					hideInCombat = {
						type = "toggle",
						order = 2,
						name = L["Hide in Combat"],
						desc = L["Hides unit frame tooltips during combat."],
						disabled = function() return not db.tooltip.enable end,
					},
					hideRealmText = {
						type = "toggle",
						order = 2,
						name = L["Hide Realm Text"],
						desc = L["Hide the coalesced/interactive realm text."],
						disabled = function() return not db.tooltip.enable end,
					},
					healthbar = {
						type = "group",
						order = 6,
						name = L["Healthbar"],
						desc = L["Players Healthbar Options."],
						guiInline  = true,
						disabled = function() return not db.tooltip.enable end,
						get = function(info) return db.tooltip.healthbar[ info[#info] ] end,
						set = function(info, value) db.tooltip.healthbar[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 5,
								name = " ",
							},
							---------------------------
							showHealthValue = {
								type = "toggle",
								order = 2,
								name = L["Health Value"],
								desc = L["Shows health value over healthbar."],
								disabled = function() return not db.tooltip.enable end,
							},
							showOutline = {
								type = "toggle",
								order = 2,
								name = L["Font Outline"],
								desc = L["Adds a font outline to health value."],
								disabled = function() return not db.tooltip.enable end,
							},
							reactionColoring = {
								type = "toggle",
								order = 2,
								name = L["Reaction Coloring"],
								desc = L["Change healthbar color to targets classcolor. (Overides Custom Color)"],
								disabled = function() return not db.tooltip.enable end,
							},
							custom = {
								type = "group",
								order = 6,
								name = L["Custom"],
								desc = L["Custom Coloring"],
								childGroups = "tree",
								disabled = function() return not db.tooltip.enable end,
								get = function(info) return db.tooltip.healthbar.custom[ info[#info] ] end,
								set = function(info, value) db.tooltip.healthbar.custom[ info[#info] ] = value;   end,
								args = {
									---------------------------
									--Option Type Seperators
									sep1 = {
										type = "description",
										name = " ",
										order = 2,
									},
									sep2 = {
										type = "description",
										name = " ",
										order = 3,
									},
									sep3 = {
										type = "description",
										name = " ",
										order = 4,
									},
									sep4 = {
										type = "description",
										name = " ",
										order = 5,
									},
									---------------------------
									apply = {
										type = "toggle",
										order = 2,
										name = L["Apply Custom Color"],
										desc = L["Use the Custom Color you have chosen."],
										disabled = function() return not db.tooltip.enable end,
									},
									color = {
										type = "color",
										order = 4,
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
								type = "select",
								order = 3,
								name = L["Text Position"],
								desc = L["Health Value Position."],
								disabled = function() return not db.tooltip.enable end,
								values = regions,
							},
							fontSize= {
								type = "range",
								order = 5,
								name = L["Font Size"],
								desc = L["Controls the healthbar value font size."],
								min = 8, max = 25, step = 1,
								disabled = function() return not db.tooltip.enable end,
							},
						},
					},
				},
			},
			unitframes = {
				type = "group",
				order = 14,
				name = L["Unitframes"],
				desc = L["Unitframes Module for BasicUI."],
				childGroups = "tree",
				get = function(info) return db.unitframes[ info[#info] ] end,
				set = function(info, value) db.unitframes[ info[#info] ] = value;   end,
				args = {
					---------------------------
					--Option Type Seperators
					sep1 = {
						type = "description",
						order = 1,
						name = " ",
					},
					sep2 = {
						type = "description",
						order = 2,
						name = " ",
					},
					sep3 = {
						type = "description",
						order = 3,
						name = " ",
					},
					sep4 = {
						type = "description",
						order = 4,
						name = " ",
					},
					sep5 = {
						type = "description",
						order = 5,
						name = " ",
					},
					sep6 = {
						type = "description",
						order = 6,
						name = " ",
					},
					sep7 = {
						type = "description",
						order = 7,
						name = " ",
					},
					---------------------------
					reloadUI = {
						type = "execute",
						name = "Reload UI",
						desc = " ",
						order = 0,
						func = 	function()
							ReloadUI()
						end,
					},
					Text = {
						type = "description",
						order = 0,
						name = "When changes are made a reload of the UI is needed.",
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enables Uniframes Module"],
					},
					player = {
						type = "group",
						order = 3,
						name = L["Player Frame"],
						desc = L["Adjust the Player Frame."],
						guiInline  = true,
						get = function(info) return db.unitframes.player[ info[#info] ] end,
						set = function(info, value) db.unitframes.player[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 0,
								name = L["Enable"],
								desc = L["Enables Player Frame Adjustments"],
							},
							scale = {
								type = "range",
								order = 1,
								name = L["Frame Scale"],
								desc = L["Controls the scaling of Blizzard's Player Frame"],
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.unitframes.enable or not db.unitframes.player.enable end,
							},
							fontSize= {
								type = "range",
								order = 2,
								name = L["HP/Mana Font Size"],
								desc = L["Controls the Player Healthbar/Manabar value font size."],
								min = 8, max = 25, step = 1,
								disabled = function() return not db.unitframes.enable or not db.unitframes.player.enable end,
							},
							fontSizepet= {
								type = "range",
								order = 2,
								name = L["HP/Mana Font Size for your pet"],
								desc = L["Controls the Player Pet Healthbar/Manabar value font size."],
								min = 8, max = 25, step = 1,
								disabled = function() return not db.unitframes.enable or not db.unitframes.player.enable end,
							},
						},
					},
					target = {
						type = "group",
						order = 4,
						name = L["Target Frame"],
						desc = L["Adjust the Target Frame."],
						guiInline  = true,
						get = function(info) return db.unitframes.target[ info[#info] ] end,
						set = function(info, value) db.unitframes.target[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 0,
								name = L["Enable"],
								desc = L["Enables Target Frame Adjustments"],
							},
							scale = {
								type = "range",
								order = 1,
								name = L["Frame Scale"],
								desc = L["Controls the scaling of Blizzard's Target Frame"],
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.unitframes.enable or not db.unitframes.target.enable end,
							},
							fontSize= {
								type = "range",
								order = 2,
								name = L["HP/Mana Font Size"],
								desc = L["Controls the Target Healthbar/Manabar value font size."],
								min = 8, max = 25, step = 1,
								disabled = function() return not db.unitframes.enable or not db.unitframes.target.enable end,
							},
						},
					},
					focus = {
						type = "group",
						order = 5,
						name = L["Focus Frame"],
						desc = L["Adjust the Focus Frame."],
						guiInline  = true,
						get = function(info) return db.unitframes.focus[ info[#info] ] end,
						set = function(info, value) db.unitframes.focus[ info[#info] ] = value;   end,
						args = {
							---------------------------
							--Option Type Seperators
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 0,
								name = L["Enable"],
								desc = L["Enables Focus Frame Adjustments"],
							},
							scale = {
								type = "range",
								order = 1,
								name = L["Frame Scale"],
								desc = L["Controls the scaling of Blizzard's Focus Frame"],
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.unitframes.enable or not db.unitframes.focus.enable end,
							},
							fontSize= {
								type = "range",
								order = 2,
								name = L["HP/Mana Font Size"],
								desc = L["Controls the Focus Healthbar/Manabar value font size."],
								min = 8, max = 25, step = 1,
								disabled = function() return not db.unitframes.enable or not db.unitframes.focus.enable end,
							},
						},
					},
					party = {
						type = "group",
						order = 6,
						name = L["Party Frame"],
						desc = L["Adjust the scale of Blizzards Unit Frames."],
						guiInline  = true,
						get = function(info) return db.unitframes.party[ info[#info] ] end,
						set = function(info, value) db.unitframes.party[ info[#info] ] = value;   end,
						args = {
							---------------------------
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep5 = {
								type = "description",
								order = 5,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 0,
								name = L["Enable"],
								desc = L["Enables Party Frame Adjustments"],
							},
							scale = {
								type = "range",
								order = 1,
								name = L["Scale"],
								desc = L["Controls the scaling of Blizzard's Party Frame"],
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.unitframes.enable end,
							},
							fontSize= {
								type = "range",
								order = 2,
								name = L["HP/Mana Font Size"],
								desc = L["Controls the Party Healthbar/Manabar value font size."],
								min = 8, max = 25, step = 1,
								disabled = function() return not db.unitframes.enable or not db.unitframes.party.enable end,
							},
							position = {
								type = "group",
								order = 2,
								childGroups = "tree",
								name = L["Position"],
								--desc = L["Combo Points Options"],
								disabled = function() return not db.unitframes.enable end,
								get = function(info) return db.unitframes.party.position[ info[#info] ] end,
								set = function(info, value) db.unitframes.party.position[ info[#info] ] = value;   end,
								args = {
									---------------------------
									--Option Type Seperators
									sep1 = {
										type = "description",
										order = 1,
										name = " ",
									},
									sep2 = {
										type = "description",
										order = 2,
										name = " ",
									},
									sep3 = {
										type = "description",
										order = 3,
										name = " ",
									},
									sep4 = {
										type = "description",
										order = 4,
										name = " ",
									},
									---------------------------
									relAnchor = {
										order = 1,
										name = L["Self Anchor"],
										--desc = L["Style of Border for Sqaure Minimap."],
										disabled = function() return not db.unitframes.enable end,
										type = "select",
										values = regions,
									},
									offSetX = {
										type = "range",
										order = 2,
										name = L["X Offset"],
										desc = L["Controls the X offset. (Left - Right)"],
										min = -250, max = 250, step = 5,
										disabled = function() return not db.unitframes.enable end,
									},
									offSetY = {
										type = "range",
										order = 3,
										name = L["Y Offset"],
										desc = L["Controls the Y offset. (Up - Down)"],
										min = -250, max = 250, step = 5,
										disabled = function() return not db.unitframes.enable end,
									},
								},
							},
						},
					},
					arena = {
						type = "group",
						order = 7,
						name = L["Arena Frames"],
						desc = L["Adjust the Arena Frames."],
						guiInline  = true,
						get = function(info) return db.unitframes.arena[ info[#info] ] end,
						set = function(info, value) db.unitframes.arena[ info[#info] ] = value;   end,
						args = {
							---------------------------
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 0,
								name = L["Enable"],
								desc = L["Enables Arena Frame Adjustments"],
							},
							tracker = {
								type = "toggle",
								order = 1,
								name = L["Trinket Tracker"],
								desc = L["This puts icons to the right of the arena frames. Does not track WotF - it now simply shares 30 seconds CD with trinkets, so it's impossible to track with just 1 icon. Only enables in arenas"],
							},
							scale = {
								type = "range",
								order = 2,
								name = L["Scale"],
								desc = L["Controls the scaling of Blizzard's Arena Frames"],
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.unitframes.enable end,
							},
							fontSize= {
								type = "range",
								order = 2,
								name = L["HP/Mana Font Size"],
								desc = L["Controls the Arena Healthbar/Manabar value font size."],
								min = 8, max = 25, step = 1,
								disabled = function() return not db.unitframes.enable or not db.unitframes.arena.enable end,
							},
						},
					},
					boss = {
						type = "group",
						order = 8,
						name = L["Boss Frame"],
						desc = L["Adjust the Boss Frames."],
						guiInline  = true,
						get = function(info) return db.unitframes.boss[ info[#info] ] end,
						set = function(info, value) db.unitframes.boss[ info[#info] ] = value;   end,
						args = {
							---------------------------
							sep1 = {
								type = "description",
								order = 1,
								name = " ",
							},
							sep2 = {
								type = "description",
								order = 2,
								name = " ",
							},
							sep3 = {
								type = "description",
								order = 3,
								name = " ",
							},
							sep4 = {
								type = "description",
								order = 4,
								name = " ",
							},
							sep5 = {
								type = "description",
								order = 5,
								name = " ",
							},
							---------------------------
							enable = {
								type = "toggle",
								order = 0,
								name = L["Enable"],
								desc = L["Enables Boss Frame Adjustments"],
							},
							scale = {
								type = "range",
								order = 1,
								name = L["Scale"],
								desc = L["Controls the scaling of Blizzard's Boss Frames"],
								min = 0.5, max = 2, step = 0.05,
								disabled = function() return not db.unitframes.enable end,
							},
							fontSize= {
								type = "range",
								order = 2,
								name = L["HP/Mana Font Size"],
								desc = L["Controls the Boss Healthbar/Manabar value font size."],
								min = 8, max = 25, step = 1,
								disabled = function() return not db.unitframes.enable or not db.unitframes.boss.enable end,
							},
							position = {
								type = "group",
								order = 5,
								childGroups = "tree",
								name = L["Position"],
								--desc = L["Combo Points Options"],
								disabled = function() return not db.unitframes.enable end,
								get = function(info) return db.unitframes.boss.position[ info[#info] ] end,
								set = function(info, value) db.unitframes.boss.position[ info[#info] ] = value;   end,
								args = {
									---------------------------
									--Option Type Seperators
									sep1 = {
										type = "description",
										order = 1,
										name = " ",
									},
									sep2 = {
										type = "description",
										order = 2,
										name = " ",
									},
									sep3 = {
										type = "description",
										order = 3,
										name = " ",
									},
									sep4 = {
										type = "description",
										order = 4,
										name = " ",
									},
									---------------------------
									relAnchor = {
										type = "select",
										order = 1,
										name = L["Relative Anchor"],
										desc = L["Relative Anchor Position."],
										disabled = function() return not db.unitframes.enable end,
										values = regions,
									},
									offSetX = {
										type = "range",
										order = 2,
										name = L["X Offset"],
										desc = L["Controls the X offset. (Left - Right)"],
										min = -250, max = 250, step = 5,
										disabled = function() return not db.unitframes.enable end,
									},
									offSetY = {
										type = "range",
										order = 3,
										name = L["Y Offset"],
										desc = L["Controls the Y offset. (Up - Down)"],
										min = -250, max = 250, step = 5,
										disabled = function() return not db.unitframes.enable end,
									},
								},
							},
						},
					},
				},
			},
		},
	}

	return options
end


function BasicUI:SetUpOptions()
	local options = GetOptions()

	-- @PHANX: add this to your options table instead of registering it separately:
	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

	LibStub("AceConfig-3.0"):RegisterOptionsTable("BasicUI", options)

	-- @PHANX: You could write out each subkey but let's be lazy:
	local panels = {}
	for k in pairs(options.args) do -- this assumes all immediate children are groups
		if k ~= "welcome" and k ~= "profile" then -- skip these so we can add them manually as the first and last panels
			tinsert(panels, k)
		end
	end
	sort(panels) -- alphabetize so it looks nice and is easy to navigate

	local Dialog = LibStub("AceConfigDialog-3.0")

	-- Use the "welcome" panel as the main one:
	self.optionsFrame = Dialog:AddToBlizOptions("BasicUI", "BasicUI", nil, "welcome")

	-- Add all the rest as sub-panels:
	for i = 1, #panels do
		local k = panels[i]
		Dialog:AddToBlizOptions("BasicUI", options.args[k].name, "BasicUI", k)
	end

	-- Add the profile panel last:
	Dialog:AddToBlizOptions("BasicUI", options.args.profile.name, "BasicUI", "profile")

end