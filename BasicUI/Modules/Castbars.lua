local MODULE_NAME = "Castbars"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Castbars = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		
		CastingBarFrame = {
			enable = true,
			fontSize = 15,
			textPosition = "LEFT",
			enableLag = true,
			enableTimer = true,
			selfAnchor = "BOTTOM",
			relAnchor = "BOTTOM",
			offSetX = 0,
			offSetY	= 175,
		},
		TargetFrameSpellBar = {
			enable = true,
			fontSize = 15,
			textPosition = "CENTER",
			enableLag = true,
			enableTimer = true,
			selfAnchor = "TOP",
			relAnchor = "TOP",
			offSetX	= 0,
			offSetY	= -250,
		},
		FocusFrameSpellBar = {
			enable = true,
			fontSize = 15,
			textPosition = "CENTER",
			enableLag = true,
			enableTimer = true,
			selfAnchor = "TOP",
			relAnchor = "TOP",
			offSetX	= 0,
			offSetY	= -165,
		},
		MirrorTimer1 = {
			enable = true,
			fontSize = 18,
			enableTimer = true,
			selfAnchor = "TOP",
			relAnchor = "TOP",
			offSetX	= 0,
			offSetY	= -75,
		},
		PetCastingBarFrame = {
			enable = true,
			fontSize = 15,
			textPosition = "CENTER",
			enableTimer = true,
			selfAnchor = "BOTTOM",
			relAnchor = "BOTTOM",
			offSetX	= 0,
			offSetY	= 200,
		},
	},
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

function Castbars:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function Castbars:OnEnable()

	local db = self.db.profile
	
	if db.enable ~= true then return end
	
	local ccolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]
	local m = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")));
	local scale = function(v) return m * floor(v/m+.5) end;

	--[[

		All Credit for Castbar.lua goes to thek.
		thek: Castbar = http://www.wowinterface.com/downloads/info11334-thekCastbar.html.
		Edited by Cokedriver.
		
	]]

	local d = {};
	local find = string.find;
	local floor = math.floor;

	local function Set(a, k)
		a:SetFrameLevel(_G[k]:GetFrameLevel() - 1);
		if find(k, "MirrorTimer") then
			_G[k.."StatusBar"]:SetStatusBarColor(ccolor.r, ccolor.g, ccolor.b);
			_G[k.."StatusBar"]:SetWidth(240);
			_G[k.."StatusBar"]:SetHeight(24);
			_G[k]:ClearAllPoints();
			_G[k]:SetPoint("TOPLEFT", a, "TOPLEFT", scale(_G[k].d.x), -scale(_G[k].d.y));
			_G[k.."StatusBar"]:ClearAllPoints();
			_G[k.."StatusBar"]:SetPoint("TOPLEFT", a, "TOPLEFT", scale(5), -scale(_G[k].d.y));
		else
			_G[k]:SetStatusBarColor(ccolor.r, ccolor.g, ccolor.b);
			_G[k]:SetWidth(240);
			_G[k]:SetHeight(24);
			_G[k]:ClearAllPoints();
			_G[k]:SetPoint("TOPLEFT", a, "TOPLEFT", scale(_G[k].d.x), -scale(_G[k].d.y))
		end;
		if db[k].enableLag then
			local d, u, l = GetNetStats();
			local min, max = _G[k]:GetMinMaxValues();
			local lv = ( l / 1000 ) / ( max - min );
			if ( lv < 0 ) then lv = 0; elseif ( lv > 1 ) then lv = 1 end;
			if ( _G[k].channeling ) then
				_G[k].lag:ClearAllPoints();
				_G[k].lag:SetPoint("LEFT", _G[k], "LEFT", 0, 0);
			else
				_G[k].lag:ClearAllPoints();
				_G[k].lag:SetPoint("RIGHT", _G[k], "RIGHT", 0, 0);
			end;
			_G[k].lag:SetWidth(_G[k]:GetWidth() * lv);
		end
	end;

	if db["TargetFrameSpellBar"].enable then
		function Target_Spellbar_AdjustPosition()
			Set(_G["TargetFrameSpellBar"].df, "TargetFrameSpellBar");
		end;
	end;
	if db["FocusFrameSpellBar"].enable then
		function Focus_Spellbar_AdjustPosition()
			Set(_G["FocusFrameSpellBar"].df, "FocusFrameSpellBar");
		end;
	end

	for k, _ in pairs(db) do
		if (k ~="enable" and db[k].enable) then
			local a = CreateFrame("Frame", "Castbar"..k, UIParent);
			d.w, d.h, d.x, d.y = nil, nil, nil, nil;

			_G[k.."Border"]:SetTexture("");
			_G[k.."Text"]:ClearAllPoints("");
			_G[k.."Text"]:SetFont(BasicUI.media.fontNormal, db[k].fontSize, "");

			if find(k, "MirrorTimer") then
				d.w = 240 + (5 * 2);
				d.h = 24 + (5 * 2);
				d.x = 5;
				d.y = 5;
				
				_G[k.."Text"]:SetPoint("CENTER", k, -10, 2);
				_G[k.."StatusBar"]:SetStatusBarTexture(BasicUI.media.statusbar);
			else
				d.w = 240 + 24 + (5 * 2) + 5;
				d.h = 24 + (5 * 2);
				d.x = 24 + 5 + 5;
				d.y = 5;
				
				_G[k.."Text"]:SetPoint(db[k].textPosition, k, 0, 0);
				_G[k]:SetStatusBarTexture(BasicUI.media.statusbar);
				_G[k.."Flash"].Show = _G[k.."Flash"].Hide;
				_G[k.."Spark"].Show = _G[k.."Spark"].Hide;
				
				if _G[k.."BorderShield"] then
					_G[k.."BorderShield"].Show = _G[k.."BorderShield"].Hide;
				end;
				
				if _G[k.."Icon"] then
					_G[k.."Icon"]:Show();
					_G[k.."Icon"]:ClearAllPoints();
					_G[k.."Icon"]:SetPoint("LEFT", _G[k], -27, 0);
					_G[k.."Icon"]:SetWidth(23);
					_G[k.."Icon"]:SetHeight(23);
					_G[k.."Icon"]:SetTexCoord(.08, .92, .08, .92);
				end;
				
				_G[k]:HookScript("OnSizeChanged", function() 
					_G[k].reset = true;
				end);
				_G[k]:HookScript("OnValueChanged", function(self)
					if self.reset and not self.reseting then
						self.reseting = true
						Set(a, k)
						self.reseting = nil
						self.reset = nil
					end
				end)
				
				if db[k].enableLag then
					_G[k].lag = _G[k]:CreateTexture(nil, "BACKGROUND")
					_G[k].lag:SetHeight(24)
					_G[k].lag:SetWidth(0)
					_G[k].lag:SetPoint("RIGHT", _G[k], "RIGHT", 0, 0)
					_G[k].lag:SetTexture(1, 0, 0, 1)
				end;
			end;    
				 
			if db[k].enableTimer then
				_G[k].timer = _G[k]:CreateFontString(nil);
				_G[k].timer:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize, "");
				_G[k].timer:SetPoint("RIGHT", _G[k], "RIGHT", -5, 0);
				_G[k].update = .1;
			end;
			
			a:SetPoint(db[k].relAnchor,"UIParent",db[k].selfAnchor, scale(db[k].offSetX),scale(db[k].offSetY))
				
			a:SetWidth(d.w); a:SetHeight(d.h);
			a:SetBackdropColor(.1, .1, .1, .95);
			a:SetBackdrop({
				bgFile = BasicUI.media.background,
				edgeFile = BasicUI.media.border,
				tile = true, tileSize = 16, edgeSize = 15,
				insets = {left = 3, right = 3, top = 3, bottom = 3}
			})
			if BasicUI.db.profile.general.classcolor == true then
				a:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
			end
			a:SetParent(_G[k]);
			a:SetMovable(true);
			a:EnableMouse(false);
			a:RegisterForDrag("LeftButton");
			a:SetScript("OnDragStart", function(self) self:StartMoving() end);
			a:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
			a.name = a:CreateFontString(nil, "OVERLAY");
			a.name:SetFont(BasicUI.media.fontNormal, BasicUI.db.profile.general.fontSize, "");
			a.name:SetPoint("CENTER", a);
			_G[k].d = d; _G[k].df = a; _G[k].name = a.name; _G[k].l = true;
		   
			hooksecurefunc(_G[k], "Show", function() Set(a, k) end);
		end;
	end;

	hooksecurefunc("CastingBarFrame_OnUpdate", function(self, elapsed)
		if not self.timer then return end
		if self.update and self.update < elapsed then
			if self.casting then
				self.timer:SetText(format("(%.1f)", max(self.maxValue - self.value, 0)))
			elseif self.channeling then
				self.timer:SetText(format("(%.1f)", max(self.value, 0)))
			else
				self.timer:SetText("")
			end
			self.update = .1
		else
			self.update = self.update - elapsed
		end
	end)
	UIPARENT_MANAGED_FRAME_POSITIONS["CastingBarFrame"] = nil;
end


-- Leave this out if the module doesn't have any settings:
function Castbars:Refresh()
	db = self.db.profile -- update the upvalue

	-- change stuff here
end

------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

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

-- Leave this out if the module doesn't have any options:
local options
function Castbars:GetOptions()

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
		set = function(info, value) db[ info[#info] ] = value end,
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
				name = L["Enable Castbar Module"],
				width = "full",
			},
			Text2 = {
				type = "description",
				order = 2,
				name = " ",
				width = "full",
			},
			CastingBarFrame = {
				type = "group",
				order = 2,
				name = L["Player's Castbar"],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.CastingBarFrame[ info[#info] ] end,
				set = function(info, value) db.CastingBarFrame[ info[#info] ] = value;   end,
				args = {
					enable = {
						type = "toggle",
						order = 0,
						name = L["Enable Player Castbar"],
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enableLag = {
						type = "toggle",
						order = 1,
						name = L["Enable Lag"],
						desc = L["Enables lag to show on castbar."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.CastingBarFrame.enable end,
					},
					enableTimer = {
						type = "toggle",
						order = 1,
						name = L["Show Timer"],
						desc = L["Enables timer to show on castbar."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.CastingBarFrame.enable end,
					},
					Text2 = {
						type = "description",
						order = 2,
						name = " ",
						width = "full",
					},					
					fontSize = {
						type = "range",
						order = 2,
						name = L["Font Size"],
						desc = L["Controls the Size of the Font"],
						min = 0, max = 30, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.CastingBarFrame.enable end,
					},
					offSetX = {
						type = "range",
						order = 2,
						name = L["X Offset"],
						desc = L["Controls the X offset. (Left - Right)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.CastingBarFrame.enable end,
					},
					offSetY = {
						type = "range",
						order = 2,
						name = L["Y Offset"],
						desc = L["Controls the Y offset. (Up - Down)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.CastingBarFrame.enable end,
					},					
					Text3 = {
						type = "description",
						order = 3,
						name = " ",
						width = "full",
					},
					selfAnchor = {
						type = "select",
						order = 3,
						name = L["Self Anchor"],
						desc = L["Self Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.CastingBarFrame.enable end,
						values = regions,
					},
					relAnchor = {
						type = "select",
						order = 3,
						name = L["Relative Anchor"],
						desc = L["Relative Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.CastingBarFrame.enable end,
						values = regions,
					},
				},
			},
			MirrorTimer1 = {
				type = "group",
				order = 3,
				name = L["Mirror Timer"],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.MirrorTimer1[ info[#info] ] end,
				set = function(info, value) db.MirrorTimer1[ info[#info] ] = value;   end,
				args = {
					enable = {
						type = "toggle",
						order = 0,
						name = L["Enable Mirror Timer Castbar"],
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enableTimer = {
						type = "toggle",
						order = 1,
						name = L["Show Timer"],
						desc = L["Enables timer to show on castbar."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.MirrorTimer1.enable end,
					},
					Text2 = {
						type = "description",
						order = 2,
						name = " ",
						width = "full",
					},
					fontSize = {
						type = "range",
						order = 2,
						name = L["Font Size"],
						desc = L["Controls the Size of the Font"],
						min = 0, max = 30, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.MirrorTimer1.enable end,
					},
					offSetX = {
						type = "range",
						order = 2,
						name = L["X Offset"],
						desc = L["Controls the X offset. (Left - Right)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.MirrorTimer1.enable end,
					},
					offSetY = {
						type = "range",
						order = 2,
						name = L["Y Offset"],
						desc = L["Controls the Y offset. (Up - Down)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.MirrorTimer1.enable end,
					},					
					Text3 = {
						type = "description",
						order = 3,
						name = " ",
						width = "full",
					},
					selfAnchor = {
						type = "select",
						order = 3,
						name = L["Self Anchor"],
						desc = L["Self Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.MirrorTimer1.enable end,
						values = regions,
					},
					relAnchor = {
						type = "select",
						order = 3,
						name = L["Relative Anchor"],
						desc = L["Relative Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.MirrorTimer1.enable end,
						values = regions,
					},
				},
			},
			PetCastingBarFrame = {
				type = "group",
				order = 4,
				name = L["Pet Castbar"],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.PetCastingBarFrame[ info[#info] ] end,
				set = function(info, value) db.PetCastingBarFrame[ info[#info] ] = value;   end,
				args = {
					enable = {
						type = "toggle",
						order = 0,
						name = L["Enable Pet Castbar"],
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},					
					enableTimer = {
						type = "toggle",
						order = 1,
						name = L["Show Timer"],
						desc = L["Enables timer to show on castbar."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.PetCastingBarFrame.enable end,
					},
					Text2 = {
						type = "description",
						order = 2,
						name = " ",
						width = "full",
					},
					offSetX = {
						type = "range",
						order = 2,
						name = L["X Offset."],
						desc = L["Controls the X offset. (Left - Right)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.PetCastingBarFrame.enable end,
					},
					offSetY = {
						type = "range",
						order = 2,
						name = L["Y Offset."],
						desc = L["Controls the Y offset. (Up - Down)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.PetCastingBarFrame.enable end,
					},
					fontSize = {
						type = "range",
						order = 2,
						name = L["Font Size"],
						desc = L["Controls the Size of the Font"],
						min = 0, max = 30, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.PetCastingBarFrame.enable end,
					},
					Text3 = {
						type = "description",
						order = 3,
						name = " ",
						width = "full",
					},					
					selfAnchor = {
						type = "select",
						order = 3,
						name = L["Self Anchor"],
						desc = L["Self Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.PetCastingBarFrame.enable end,
						values = regions,
					},
					relAnchor = {
						type = "select",
						order = 3,
						name = L["Relative Anchor"],
						desc = L["Relative Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.PetCastingBarFrame.enable end,
						values = regions,
					},
				},
			},
			TargetFrameSpellBar = {
				type = "group",
				order = 5,
				name = L["Target's Castbar"],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.TargetFrameSpellBar[ info[#info] ] end,
				set = function(info, value) db.TargetFrameSpellBar[ info[#info] ] = value;   end,
				args = {
					enable = {
						type = "toggle",
						order = 0,
						name = L["Enable Target Castbar"],
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enableLag = {
						type = "toggle",
						order = 1,
						name = L["Enable Lag"],
						desc = L["Enables lag to show on castbar."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.TargetFrameSpellBar.enable end,
					},
					enableTimer = {
						type = "toggle",
						order = 1,
						name = L["Show Timer"],
						desc = L["Enables timer to show on castbar."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.TargetFrameSpellBar.enable end,
					},					
					Text2 = {
						type = "description",
						order = 2,
						name = " ",
						width = "full",
					},
					fontSize = {
						type = "range",
						order = 2,
						name = L["Font Size"],
						desc = L["Controls the Size of the Font"],
						min = 0, max = 30, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.TargetFrameSpellBar.enable end,
					},
					offSetX = {
						type = "range",
						order = 2,
						name = L["X Offset"],
						desc = L["Controls the X offset. (Left - Right)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.TargetFrameSpellBar.enable end,
					},
					offSetY = {
						type = "range",
						order = 2,
						name = L["Y Offset"],
						desc = L["Controls the Y offset. (Up - Down)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.TargetFrameSpellBar.enable end,
					},					
					Text3 = {
						type = "description",
						order = 3,
						name = " ",
						width = "full",
					},
					selfAnchor = {
						type = "select",
						order = 3,
						name = L["Self Anchor"],
						desc = L["Self Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.TargetFrameSpellBar.enable end,
						values = regions,
					},
					relAnchor = {
						type = "select",
						order = 3,
						name = L["Relative Anchor"],
						desc = L["Relative Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.TargetFrameSpellBar.enable end,
						values = regions,
					},
				},
			},
			FocusFrameSpellBar = {
				type = "group",
				order = 6,
				name = L["Focus Castbar"],
				guiInline  = true,
				disabled = function() return isModuleDisabled() or not db.enable end,
				get = function(info) return db.FocusFrameSpellBar[ info[#info] ] end,
				set = function(info, value) db.FocusFrameSpellBar[ info[#info] ] = value;   end,
				args = {
					enable = {
						type = "toggle",
						order = 0,
						name = L["Enable Focus Castbar"],
						width = "full",
					},
					Text1 = {
						type = "description",
						order = 1,
						name = " ",
						width = "full",
					},
					enableLag = {
						type = "toggle",
						order = 1,
						name = L["Enable Lag"],
						desc = L["Enables lag to show on castbar."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.FocusFrameSpellBar.enable end,
					},
					enableTimer = {
						type = "toggle",
						order = 1,
						name = L["Show Timer"],
						desc = L["Enables timer to show on castbar."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.FocusFrameSpellBar.enable end,
					},					
					Text2 = {
						type = "description",
						order = 2,
						name = " ",
						width = "full",
					},
					offSetX = {
						type = "range",
						order = 2,
						name = L["X Offset"],
						desc = L["Controls the X offset. (Left - Right)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.FocusFrameSpellBar.enable end,
					},
					offSetY = {
						type = "range",
						order = 2,
						name = L["Y Offset"],
						desc = L["Controls the Y offset. (Up - Down)"],
						min = -250, max = 250, step = 5,
						disabled = function() return isModuleDisabled() or not db.enable or not db.FocusFrameSpellBar.enable end,
					},					
					fontSize = {
						type = "range",
						order = 2,
						name = L["Font Size"],
						desc = L["Controls the Size of the Font"],
						min = 0, max = 30, step = 1,
						disabled = function() return isModuleDisabled() or not db.enable or not db.FocusFrameSpellBar.enable end,
					},
					Text3 = {
						type = "description",
						order = 3,
						name = " ",
						width = "full",
					},
					selfAnchor = {
						type = "select",
						order = 3,
						name = L["Self Anchor"],
						desc = L["Self Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.FocusFrameSpellBar.enable end,
						values = regions,
					},
					relAnchor = {
						type = "select",
						order = 3,
						name = L["Relative Anchor"],
						desc = L["Relative Anchor Position."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.FocusFrameSpellBar.enable end,
						values = regions,
					},
				},
			},
		},
	}
	return options
end