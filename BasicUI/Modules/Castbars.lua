local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Castbars = BasicUI:NewModule("Castbars", "AceEvent-3.0")

--------------
-- CastBars --
--------------
function BasicUI_Castbars:OnEnable()
	local db = BasicUI.db.profile
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
		if db.castbar[k].enableLag then
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

	if db.castbar["TargetFrameSpellBar"].enable then
		function Target_Spellbar_AdjustPosition()
			Set(_G["TargetFrameSpellBar"].df, "TargetFrameSpellBar");
		end;
	end;
	if db.castbar["FocusFrameSpellBar"].enable then
		function Focus_Spellbar_AdjustPosition()
			Set(_G["FocusFrameSpellBar"].df, "FocusFrameSpellBar");
		end;
	end

	for k, _ in pairs(db.castbar) do
		if (k ~="enable" and db.castbar[k].enable) then
			local a = CreateFrame("Frame", "Castbar"..k, UIParent);
			d.w, d.h, d.x, d.y = nil, nil, nil, nil;

			_G[k.."Border"]:SetTexture("");
			_G[k.."Text"]:ClearAllPoints("");
			_G[k.."Text"]:SetFont(db.fontNormal, db.castbar[k].fontSize, "");

			if find(k, "MirrorTimer") then
				d.w = 240 + (5 * 2);
				d.h = 24 + (5 * 2);
				d.x = 5;
				d.y = 5;
				
				_G[k.."Text"]:SetPoint("CENTER", k, -10, 2);
				_G[k.."StatusBar"]:SetStatusBarTexture(db.castbar.statusbar);
			else
				d.w = 240 + 24 + (5 * 2) + 5;
				d.h = 24 + (5 * 2);
				d.x = 24 + 5 + 5;
				d.y = 5;
				
				_G[k.."Text"]:SetPoint(db.castbar[k].textPosition);
				_G[k]:SetStatusBarTexture(db.castbar.statusbar);
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
				
				if db.castbar[k].enableLag then
					_G[k].lag = _G[k]:CreateTexture(nil, "BACKGROUND")
					_G[k].lag:SetHeight(24)
					_G[k].lag:SetWidth(0)
					_G[k].lag:SetPoint("RIGHT", _G[k], "RIGHT", 0, 0)
					_G[k].lag:SetTexture(1, 0, 0, 1)
				end;
			end;    
				 
			if db.castbar[k].enableTimer then
				_G[k].timer = _G[k]:CreateFontString(nil);
				_G[k].timer:SetFont(db.fontNormal, db.fontSize, "");
				_G[k].timer:SetPoint("RIGHT", _G[k], "RIGHT", -5, 0);
				_G[k].update = .1;
			end;
			
			a:SetPoint(db.castbar[k].relAnchor,"UIParent",db.castbar[k].selfAnchor, scale(db.castbar[k].offSetX),scale(db.castbar[k].offSetY))
				
			a:SetWidth(d.w); a:SetHeight(d.h);
			a:SetBackdropColor(.1, .1, .1, .95);
			a:SetBackdrop({
				bgFile = db.castbar.background,
				edgeFile = db.castbar.border,
				tile = true, tileSize = 16, edgeSize = 15,
				insets = {left = 3, right = 3, top = 3, bottom = 3}
			})
			if db.classcolor == true then
				a:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
			end
			a:SetParent(_G[k]);
			a:SetMovable(true);
			a:EnableMouse(false);
			a:RegisterForDrag("LeftButton");
			a:SetScript("OnDragStart", function(self) self:StartMoving() end);
			a:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
			a.name = a:CreateFontString(nil, "OVERLAY");
			a.name:SetFont(db.fontNormal, db.fontSize, "");
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