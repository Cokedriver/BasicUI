local MODULE_NAME = "Unitframes"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

local db

local defaults = {
	profile = {
		enable = true,
		--abbrevRealmNames = true,
		player = {
			enable = true,			-- Enable Player Frame Adjustments
			scale = 1.15,			-- Player Frame Scale
			fontSize = 13,			-- Stausbar Font Size
			fontSizepet = 10,		-- Stausbar Font Size
		},
		target = {
			enable = true,			-- Enable Target Frame Adjustments
			scale = 1.15,			-- Target Frame Scale
			fontSize = 13,			-- Stausbar Font Size
		},
		focus = {
			enable = true,			-- Enable Focus Frame Adjustments
			scale = 1.15,			-- Focus Frame Scale
			fontSize = 13,			-- Stausbar Font Size
		},
		party = {
			enable = true,
			scale = 1.15,
			fontSize = 11,			-- Stausbar Font Size
			position = {
				relAnchor = "TOPLEFT",
				offSetX = 10,		-- Controls the X offset. (Left - Right)
				offSetY = -150,		-- Controls the Y offset. (Up - Down)
			},				
		},
		arena = {
			enable = true,
			scale = 1.5,
			fontSize = 11,			-- Stausbar Font Size
		},
		boss = {
			enable = true,
			scale = 1.15,
			--fontSize = 13,			-- Stausbar Font Size
			position = {
				relAnchor = "RIGHT",
				offSet = -50,		-- Controls the X offset. (Left - Right)
				offSetY = -250,		-- Controls the Y offset. (Up - Down)
			},		
		},
	},
}

local CUSTOM_FACTION_BAR_COLORS = {
	[1] = {r = 1, g = 0, b = 0},
	[2] = {r = 1, g = 0, b = 0},
	[3] = {r = 1, g = 1, b = 0},
	[4] = {r = 1, g = 1, b = 0},
	[5] = {r = 0, g = 1, b = 0},
	[6] = {r = 0, g = 1, b = 0},
	[7] = {r = 0, g = 1, b = 0},
	[8] = {r = 0, g = 1, b = 0},
}

-- Font Style
local shorts = {
	{ 1e10, 1e9, "%.0fB" }, --  10b+ as  12b
	{  1e9, 1e9, "%.1fB" }, --   1b+ as 8.3b
	{  1e7, 1e6, "%.0fM" }, --  10m+ as  14m
	{  1e6, 1e6, "%.1fM" }, --   1m+ as 7.4m
	{  1e5, 1e3, "%.0fK" }, -- 100k+ as 840k
	{  1e3, 1e3, "%.1fK" }, --   1k+ as 2.5k
	{    0,   1,    "%d" }, -- < 1k  as  974
}
for i = 1, #shorts do
	shorts[i][4] = shorts[i][3] .. " (%.0f%%)"
end

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function MODULE:OnEnable()

	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEnable")
	end
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")

	db = self.db.profile

	if enabled or not db.enable then return end
	enabled = true -- since most of this stuff is non-undoable (eg. hooksecurefunc)

	-- Move Party Frames
	PartyMemberFrame1:SetPoint(db.party.position.relAnchor, UIParent, db.party.position.offSetX, db.party.position.offSetY);
	
	-- Move Boss Frames
	local movingBossFrame
	hooksecurefunc(Boss1TargetFrame, "SetPoint", function(f, ...)
		if movingBossFrame or InCombatLockdown() then
			return
		end
		movingBossFrame = true
		Boss1TargetFrame:ClearAllPoints()
		Boss1TargetFrame:SetPoint(db.boss.position.relAnchor, UIParent, db.boss.position.offSetX, db.boss.position.offSetY)
		movingBossFrame = nil
	end)
	
	-- Update Unit Frames
	self:ApplySettings()

	-- Disable healing/damage spam over player/pet frame:
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = function() end
	PetHitIndicator:SetText(nil)
	PetHitIndicator.SetText = function() end

	-- Change other frames' name backgrounds to match player frame
	for _, region in pairs({
		TargetFrameNameBackground,
		FocusFrameNameBackground,
		Boss1TargetFrameNameBackground,
		Boss2TargetFrameNameBackground,
		Boss3TargetFrameNameBackground,
		Boss4TargetFrameNameBackground,
	}) do
		region:SetTexture(0, 0, 0, 0.5)
	end
	
	-- Font Style / Color thanks to Phanx from WoWinterface.
	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(statusBar, fontString, value, valueMin, valueMax)
		if value == 0 then
			return fontString:SetText("")
		end

		local style = GetCVar("statusTextDisplay")
		if style == "PERCENT" then
			return fontString:SetFormattedText("%.0f%%", value / valueMax * 100)
		end
		for i = 1, #shorts do
			local t = shorts[i]
			if value >= t[1] then
				if style == "BOTH" then
					return fontString:SetFormattedText(t[4], value / t[2], value / valueMax * 100)
				else
					if value < valueMax then
						for j = 1, #shorts do
							local v = shorts[j]
							if valueMax >= v[1] then
								return fontString:SetFormattedText(t[3] .. " / " .. v[3], value / t[2], valueMax / v[2])
							end
						end
					end
					return fontString:SetFormattedText(t[3], value / t[2])
				end
			end
		end
	end)

	-- Font Color
	hooksecurefunc("UnitFrame_Update", function(self, isParty)
		if not self.name or not self:IsShown() then return end

		local PET_COLOR = { r = 157/255, g = 197/255, b = 255/255 }
		local unit, color = self.unit
		if UnitPlayerControlled(unit) then
			if UnitIsPlayer(unit) then
				local _, class = UnitClass(unit)
				color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
			else
				color = PET_COLOR
			end
		elseif UnitIsDeadOrGhost(unit) or UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
			color = GRAY_FONT_COLOR
		else
			color = CUSTOM_FACTION_BAR_COLORS[UnitIsEnemy(unit, "player") and 1 or UnitReaction(unit, "player") or 5]
		end

		if not color then
			color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)["PRIEST"]
		end

		self.name:SetTextColor(color.r, color.g, color.b)
		if isParty then
			self.name:SetText(GetUnitName(self.overrideName or unit))
		end
	end)
end

function MODULE:ApplySettings(event)

	db = self.db.profile
	
	if event then
		self:UnregisterEvent(event)
	end

	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "ApplySettings")
	end

	local failure
	for unit, func in pairs(self.UnitFunctions) do
		if db[unit].enable then
			if func(self) then
				failure = true
			end
		end
	end
	
	if failure then
		self:RegisterEvent("ADDON_LOADED", "ApplySettings")
	end
		
end

------------------------------------------------------------------------


MODULE.UnitFunctions = {


	player = function(self)	
		PlayerFrame:SetScale(db.player.scale)
		PlayerFrameHealthBarText:SetFont(BasicUI.media.fontNormal, db.player.fontSize,"THINOUTLINE")
		PlayerFrameManaBarText:SetFont(BasicUI.media.fontNormal, db.player.fontSize, "THINOUTLINE")
		PlayerFrameAlternateManaBarText:SetFont(BasicUI.media.fontNormal, db.player.fontSize, "THINOUTLINE")

		PetFrameHealthBarText:SetFont(BasicUI.media.fontNormal, db.player.fontSizepet,"THINOUTLINE")
		PetFrameManaBarText:SetFont(BasicUI.media.fontNormal, db.player.fontSizepet, "THINOUTLINE")
	end,

	target = function(self)		
		TargetFrame:SetScale(db.target.scale)
		TargetFrameTextureFrameHealthBarText:SetFont(BasicUI.media.fontNormal, db.target.fontSize, "THINOUTLINE")
		TargetFrameTextureFrameManaBarText:SetFont(BasicUI.media.fontNormal, db.target.fontSize, "THINOUTLINE")
	end,

	focus = function(self)		
		FocusFrame:SetScale(db.focus.scale)
		FocusFrameTextureFrameHealthBarText:SetFont(BasicUI.media.fontNormal, db.focus.fontSize,"THINOUTLINE")
		FocusFrameTextureFrameManaBarText:SetFont(BasicUI.media.fontNormal, db.focus.fontSize,"THINOUTLINE")
	end,

	party = function(self)		
		for i = 1, MAX_PARTY_MEMBERS do
			local partyFrame = "PartyMemberFrame"..i
			_G[partyFrame]:SetScale(db.party.scale)
			_G[partyFrame.."HealthBarText"]:SetFont(BasicUI.media.fontNormal, db.party.fontSize, "THINOUTLINE")
			_G[partyFrame.."ManaBarText"]:SetFont(BasicUI.media.fontNormal, db.party.fontSize, "THINOUTLINE")
		end
	end,

	arena = function(self)		
		if not ArenaEnemyFrame1 then
			return true
		end

		for i = 1, MAX_ARENA_ENEMIES do
			local prepFrame = "ArenaPrepFrame"..i
			_G[prepFrame]:SetScale(db.arena.scale)
			_G[prepFrame.."HealthBarText"]:SetFont(BasicUI.media.fontNormal, db.arena.fontSize,"THINOUTLINE")
			_G[prepFrame.."ManaBarText"]:SetFont(BasicUI.media.fontNormal, db.arena.fontSize, "THINOUTLINE")

			local arenaFrame = "ArenaEnemyFrame"..i
			_G[arenaFrame]:SetScale(db.arena.scale)
			_G[arenaFrame.."HealthBarText"]:SetFont(BasicUI.media.fontNormal, db.arena.fontSize,"THINOUTLINE")
			_G[arenaFrame.."ManaBarText"]:SetFont(BasicUI.media.fontNormal, db.arena.fontSize, "THINOUTLINE")
		end
	end,

	boss = function(self)
		for i = 1, MAX_BOSS_FRAMES do
			local bossFrame = "Boss"..i.."TargetFrame"
			_G[bossFrame]:SetScale(db.boss.scale)
		end
	end,

}
------------------------------------------------------------------------------

-- Leave this out if the module doesn't have any settings:
function MODULE:Refresh()
	db = self.db.profile -- update the upvalue

	-- change stuff here
end

-- Leave this out if the module doesn't have any options:
local options
function MODULE:GetOptions()


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

	if options then
		return options
	end

	local function isModuleDisabled()
		return not BasicUI:GetModuleEnabled(MODULE_NAME)
	end
	
	options = {
		type = "group",
		name = L[MODULE_NAME],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value; self:ApplySettings(event) end,
		disabled = isModuleDisabled(),
		args = {
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
				name = "When you enable or disable a Unitframe a reload of the UI is needed.",
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
				name = L["Enable Uniframes Module"],
				width = "full",
				disabled = false,				
			},
			Text2 = {
				type = "description",
				order = 2,
				name = " ",
				width = "full",
			},			
			player = {
				type = "group",
				order = 2,
				name = L["Player Frame Adjustments"],
				get = function(info) return db.player[ info[#info] ] end,
				set = function(info, value) db.player[ info[#info] ] = value; self:ApplySettings(event) end,
				disabled = function() return isModuleDisabled() or not db.enable end,				
				guiInline  = true,						
				args = {
					enable = {
						type = "toggle",
						order = 0,
						name = L["Enable Player Frame"],
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					scale = {
						type = "range",
						order = 1,
						name = L["Frame Scale"],
						desc = L["Controls the scaling of Blizzard's Player Frame"],
						min = 0.5, max = 2, step = 0.05,								
						disabled = function() return isModuleDisabled() or not db.enable or not db.player.enable end,							
					},
					fontSize= {
						type = "range",
						order = 2,
						name = L["HP/Mana Font Size"],
						desc = L["Controls the Player Healthbar/Manabar value font size."],
						min = 8, max = 25, step = 1,								
						disabled = function() return isModuleDisabled() or not db.enable or not db.player.enable end,							
					},
					Text2 = {
						type = "description",
						order = 2,
						name = " ",
						width = "full",
					},
					fontSizepet= {
						type = "range",
						order = 2,
						name = L["HP/Mana Font Size for your pet"],
						desc = L["Controls the Player Pet Healthbar/Manabar value font size."],
						min = 8, max = 25, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.player.enable end,								
					},
				},
			},
			target = {
				type = "group",
				order = 4,
				name = L["Target Frame Adjustments"],
				get = function(info) return db.target[ info[#info] ] end,
				set = function(info, value) db.target[ info[#info] ] = value; self:ApplySettings(event) end,
				disabled = function() return isModuleDisabled() or not db.enable end,
				guiInline  = true,
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
						name = L["Enable Target Frame"],
						width = "full",
					},
					scale = {
						type = "range",
						order = 1,
						name = L["Frame Scale"],
						desc = L["Controls the scaling of Blizzard's Target Frame"],
						min = 0.5, max = 2, step = 0.05,
						disabled = function() return isModuleDisabled() or not db.enable or not db.target.enable end,																
					},
					fontSize= {
						type = "range",
						order = 2,
						name = L["HP/Mana Font Size"],
						desc = L["Controls the Target Healthbar/Manabar value font size."],
						min = 8, max = 25, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.target.enable end,															
					},
				},
			},
			focus = {
				type = "group",
				order = 5,
				name = L["Focus Frame Adjustments"],
				get = function(info) return db.focus[ info[#info] ] end,
				set = function(info, value) db.focus[ info[#info] ] = value; self:ApplySettings(event) end,
				disabled = function() return isModuleDisabled() or not db.enable end,
				guiInline  = true,
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
						name = L["Enable Focus Frame"],
						width = "full",
					},
					scale = {
						type = "range",
						order = 1,
						name = L["Frame Scale"],
						desc = L["Controls the scaling of Blizzard's Focus Frame"],
						min = 0.5, max = 2, step = 0.05,
						disabled = function() return isModuleDisabled() or not db.enable or not db.focus.enable end,																
					},
					fontSize= {
						type = "range",
						order = 2,
						name = L["HP/Mana Font Size"],
						desc = L["Controls the Focus Healthbar/Manabar value font size."],
						min = 8, max = 25, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.focus.enable end,															
					},
				},
			},
			party = {
				type = "group",
				order = 6,
				name = L["Party Frame Adjustments"],
				get = function(info) return db.party[ info[#info] ] end,
				set = function(info, value) db.party[ info[#info] ] = value; self:ApplySettings(event) end,
				disabled = function() return isModuleDisabled() or not db.enable end,
				guiInline  = true,
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
						name = L["Enable Party Frame"],
						width = "full",
					},
					scale = {
						type = "range",
						order = 1,
						name = L["Scale"],
						desc = L["Controls the scaling of Blizzard's Party Frame"],
						min = 0.5, max = 2, step = 0.05,
						disabled = function() return isModuleDisabled() or not db.enable or not db.party.enable end,																
					},
					fontSize= {
						type = "range",
						order = 2,
						name = L["HP/Mana Font Size"],
						desc = L["Controls the Party Healthbar/Manabar value font size."],
						min = 8, max = 25, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.party.enable end,																
					},
					position = {
						type = "group",
						order = 2,
						childGroups = "tree",
						name = L["Party Frame Position"],
						disabled = function() return isModuleDisabled() or not db.enable or not db.party.enable end,
						get = function(info) return db.party.position[ info[#info] ] end,
						set = function(info, value) db.party.position[ info[#info] ] = value; self:ApplySettings(event) end,						
						
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
								type = "select",
								values = regions,
								disabled = function() return isModuleDisabled() or not db.enable or not db.party.enable end,																		
							},
							offSetX = {
								type = "range",
								order = 2,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								min = -250, max = 250, step = 5,
								disabled = function() return isModuleDisabled() or not db.enable or not db.party.enable end,																		
							},
							offSetY = {
								type = "range",
								order = 3,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								min = -250, max = 250, step = 5,
								disabled = function() return isModuleDisabled() or not db.enable or not db.party.enable end,																		
							},
						},
					},
				},
			},
			arena = {
				type = "group",
				order = 7,
				name = L["Arena Frame Adjustments"],
				get = function(info) return db.arena[ info[#info] ] end,
				set = function(info, value) db.arena[ info[#info] ] = value; self:ApplySettings(event) end,
				disabled = function() return isModuleDisabled() or not db.enable end,
				guiInline  = true,
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
						name = L["Enable Arena Frame"],																
					},
					scale = {
						type = "range",
						order = 1,
						name = L["Scale"],
						desc = L["Controls the scaling of Blizzard's Arena Frames"],
						min = 0.5, max = 2, step = 0.05,
						disabled = function() return isModuleDisabled() or not db.enable or not db.arena.enable end,																
					},
					fontSize= {
						type = "range",
						order = 2,
						name = L["HP/Mana Font Size"],
						desc = L["Controls the Arena Healthbar/Manabar value font size."],
						min = 8, max = 25, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.arena.enable end,																
					},
				},
			},
			boss = {
				type = "group",
				order = 8,
				name = L["Boss Frame Adjustments"],
				get = function(info) return db.boss[ info[#info] ] end,
				set = function(info, value) db.boss[ info[#info] ] = value; self:ApplySettings(event) end,
				disabled = function() return isModuleDisabled() or not db.enable end,
				guiInline  = true,
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
						name = L["Enable Boss Frame"],
						width = "full",
					},
					scale = {
						type = "range",
						order = 1,
						name = L["Scale"],
						desc = L["Controls the scaling of Blizzard's Boss Frames"],
						min = 0.5, max = 2, step = 0.05,
						disabled = function() return isModuleDisabled() or not db.enable or not db.boss.enable end,																
					},
					--[[fontSize= {
						type = "range",
						order = 2,
						name = L["HP/Mana Font Size"],
						desc = L["Controls the Boss Healthbar/Manabar value font size."],
						min = 8, max = 25, step = 1,
						disabled = function() return not db.enable or not db.boss.enable end,																
					},]]
					position = {
						type = "group",
						order = 5,
						childGroups = "tree",
						name = L["Position"],
						--desc = L["Combo Points Options"],
						disabled = function() return isModuleDisabled() or not db.enable or not db.boss.enable end,
						get = function(info) return db.boss.position[ info[#info] ] end,
						set = function(info, value) db.boss.position[ info[#info] ] = value; self:ApplySettings(event) end,														
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
								disabled = function() return isModuleDisabled() or not db.enable or not db.boss.enable end,
								values = regions,																	
							},
							offSetX = {
								type = "range",
								order = 2,
								name = L["X Offset"],
								desc = L["Controls the X offset. (Left - Right)"],
								min = -250, max = 250, step = 5,
								disabled = function() return isModuleDisabled() or not db.enable or not db.boss.enable end,																	
							},
							offSetY = {
								type = "range",
								order = 3,
								name = L["Y Offset"],
								desc = L["Controls the Y offset. (Up - Down)"],
								min = -250, max = 250, step = 5,
								disabled = function() return isModuleDisabled() or not db.enable or not db.boss.enable end,							
							},
						},
					}
				},
			},
		},
	}
	return options
end