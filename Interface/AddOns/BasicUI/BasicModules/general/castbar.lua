local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['castbar'].enable ~= true then return end

--[[
--  thekCastbar
--  version: 3.0.cataclysm
--  author:  thek
--]]


local d = {};
local find = string.find;
local floor = math.floor;

-- doing some border math (taken from tukui)
local m = 768/string.match(GetCVar("gxResolution"), "%d+x(%d+)")/min(2, max(.64, 768/string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")));
local scale = function(v) return m * floor(v/m+.5) end;

local function Set(a, k)
    a:SetFrameLevel(_G[k]:GetFrameLevel() - 1);
    if find(k, "MirrorTimer") then
        _G[k.."StatusBar"]:SetStatusBarColor(unpack(C['castbar'][k].castbarColor));
        _G[k.."StatusBar"]:SetWidth(C['castbar'][k].castbarSize[1]);
        _G[k.."StatusBar"]:SetHeight(C['castbar'][k].castbarSize[2]);
        _G[k]:ClearAllPoints();
        _G[k]:SetPoint("TOPLEFT", a, "TOPLEFT", scale(_G[k].d.x), -scale(_G[k].d.y));
        _G[k.."StatusBar"]:ClearAllPoints();
        _G[k.."StatusBar"]:SetPoint("TOPLEFT", a, "TOPLEFT", scale(C['castbar'][k].castbarSize[3]), -scale(_G[k].d.y));
    else
        _G[k]:SetStatusBarColor(unpack(C['castbar'][k].castbarColor));
        _G[k]:SetWidth(C['castbar'][k].castbarSize[1]);
        _G[k]:SetHeight(C['castbar'][k].castbarSize[2]);
        _G[k]:ClearAllPoints();
        _G[k]:SetPoint("TOPLEFT", a, "TOPLEFT", scale(_G[k].d.x), -scale(_G[k].d.y))
    end;
    if C['castbar'][k].enableLag then
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

if C['castbar']["TargetFrameSpellBar"].enabled then
    function Target_Spellbar_AdjustPosition()
        Set(_G["TargetFrameSpellBar"].df, "TargetFrameSpellBar");
    end;
end;
if C['castbar']["FocusFrameSpellBar"].enabled then
    function Focus_Spellbar_AdjustPosition()
        Set(_G["FocusFrameSpellBar"].df, "FocusFrameSpellBar");
    end;
end

for k, _ in pairs(C['castbar']) do
    if (k ~="enable" and C['castbar'][k].enabled) then
        local a = CreateFrame("Frame", "Castbar"..k, UIParent);
        d.w, d.h, d.x, d.y = nil, nil, nil, nil;

        _G[k.."Border"]:SetTexture("");
        _G[k.."Text"]:ClearAllPoints("");
        _G[k.."Text"]:SetPoint(C['castbar'][k].textPosition);
        _G[k.."Text"]:SetFont(unpack(C['castbar'][k].textFont));

        if find(k, "MirrorTimer") then
            d.w = C['castbar'][k].castbarSize[1] + (C['castbar'][k].castbarSize[3] * 2);
            d.h = C['castbar'][k].castbarSize[2] + (C['castbar'][k].castbarSize[3] * 2);
            d.x = C['castbar'][k].castbarSize[3];
            d.y = C['castbar'][k].castbarSize[4];
            
            _G[k.."StatusBar"]:SetStatusBarTexture(C['castbar'][k].castbarTextures[1]);
        else
            d.w = C['castbar'][k].castbarSize[1] + C['castbar'][k].castbarSize[2] + (C['castbar'][k].castbarSize[3] * 2) + C['castbar'][k].castbarSize[4];
            d.h = C['castbar'][k].castbarSize[2] + (C['castbar'][k].castbarSize[3] * 2);
            d.x = C['castbar'][k].castbarSize[2] + C['castbar'][k].castbarSize[3] + C['castbar'][k].castbarSize[4];
            d.y = C['castbar'][k].castbarSize[4];

            _G[k]:SetStatusBarTexture(C['castbar'][k].castbarTextures[1]);
            _G[k.."Flash"].Show = _G[k.."Flash"].Hide;
            _G[k.."Spark"].Show = _G[k.."Spark"].Hide;
            
            if _G[k.."BorderShield"] then
                _G[k.."BorderShield"].Show = _G[k.."BorderShield"].Hide;
            end;
            
            if _G[k.."Icon"] then
                _G[k.."Icon"]:Show();
                _G[k.."Icon"]:ClearAllPoints();
                _G[k.."Icon"]:SetPoint("RIGHT", _G[k], "LEFT", -3, 0);
                _G[k.."Icon"]:SetWidth(C['castbar'][k].castbarSize[2] - 1);
                _G[k.."Icon"]:SetHeight(C['castbar'][k].castbarSize[2] - 1);
                _G[k.."Icon"]:SetTexCoord(.08, .92, .08, .92);
            end;
            
            _G[k]:HookScript("OnSizeChanged", function() 
                _G[k].reset = true;
            end);
            _G[k]:HookScript("OnValueChanged", function()
                if _G[k].reset then
                    Set(a, k);
                    _G[k].reset = false;
                end;
            end);
            
            if C['castbar'][k].enableLag then
                _G[k].lag = _G[k]:CreateTexture(nil, "BACKGROUND")
                _G[k].lag:SetHeight(C['castbar'][k].castbarSize[2])
                _G[k].lag:SetWidth(0)
                _G[k].lag:SetPoint("RIGHT", _G[k], "RIGHT", 0, 0)
                _G[k].lag:SetTexture(1, 0, 0, 1)
            end;
        end;    
             
        if C['castbar'][k].enableTimer then
            _G[k].timer = _G[k]:CreateFontString(nil);
            _G[k].timer:SetFont(unpack(C['castbar'][k].textFont));
            _G[k].timer:SetPoint("RIGHT", _G[k], "RIGHT", -5, 0);
            _G[k].update = .1;
        end;
		
		a:SetPoint(C['castbar'][k].relAnchor,"UIParent",C['castbar'][k].selfAnchor, scale(C['castbar'][k].offSetX),scale(C['castbar'][k].offSetY))
            
        a:SetWidth(d.w); a:SetHeight(d.h);
        a:SetBackdropColor(unpack(C['castbar'][k].castbarBGColor));
		a:SetBackdrop({
			bgFile = "Interface\\AddOns\\BasicUI\\BasicMedia\\BLACK8X8",
			edgeFile = 'Interface\\AddOns\\BasicUI\\BasicMedia\\UI-Tooltip-Border',
			edgeSize = 13,
			insets = {left = 3, right = 3, top = 3, bottom = 3}
		})
		a:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
        a:SetParent(_G[k]);
        a:SetMovable(true);
        a:EnableMouse(false);
        a:RegisterForDrag("LeftButton");
        a:SetScript("OnDragStart", function(self) self:StartMoving() end);
        a:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end);
        a.name = a:CreateFontString(nil, "OVERLAY");
        a.name:SetFont(unpack(C['castbar'][k].textFont));
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