local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['nameplates'].enable ~= true then return end

  -----------------------------
  -- FUNCTIONS
  -----------------------------

  --calc hex color from rgb
local function RGBPercToHex(r, g, b)
    r = r <= 1 and r >= 0 and r or 0
    g = g <= 1 and g >= 0 and g or 0
    b = b <= 1 and b >= 0 and b or 0
    return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

  --i dont like that
local hideStuff = function(f)
    f.name:Hide()
    f.level:Hide()
    f.dragon:SetTexture("")
    f.border:SetTexture("")
    f.boss:SetTexture("")
    f.highlight:SetTexture("")
    f.castbar.border:SetTexture("")
    f.castbar.shield:SetTexture("")
end

  --fix some more stuff
local fixStuff = function(f)
    f.threat:ClearAllPoints()
    f.threat:SetAllPoints(f.threat_holder)
    f.threat:SetParent(f.threat_holder)
    f.healthbar:ClearAllPoints()
    f.healthbar:SetAllPoints(f.back_holder)
    f.healthbar:SetParent(f.back_holder)
end

  --fix the damn castbar hopping
local fixCastbar = function(cb)
    --print("fix castbar")
    cb:ClearAllPoints()
    cb:SetAllPoints(cb.parent)
    cb:SetParent(cb.parent)
end

  --get the actual color
local fixColor = function(color)
    color.r,color.g,color.b = floor(color.r*100+.5)/100, floor(color.g*100+.5)/100, floor(color.b*100+.5)/100
end

  --get colorstring for level color
local getDifficultyColorString = function(f)
    local color = {}
    color.r,color.g,color.b = f.level:GetTextColor()
    fixColor(color)
    return RGBPercToHex(color.r,color.g,color.b)
end

  --get healthbar color func
local getHealthbarColor = function(f)
    local color = {}
    color.r,color.g,color.b = f.healthbar:GetStatusBarColor()
    fixColor(color)
    return color
end

  --set txt func
local updateText = function(f)
    if not C['nameplates'].name.enable then return end
    local cs = getDifficultyColorString(f)
    local color = getHealthbarColor(f)
    if color.r==0 and color.g==0 and color.b==1 then
		--dark blue color of members of the own faction is barely readable
		f.ns:SetTextColor(0,0.6,1)
    else
		f.ns:SetTextColor(color.r,color.g,color.b)
    end
    local name = f.name:GetText() or "Nobody"
    local level = f.level:GetText() or "-1"
    if f.boss:IsShown() == 1 then
		level = "??"
		cs = "ff6600"
    elseif f.dragon:IsShown() == 1 then
		level = level.." Elite"
    end
    f.ns:SetText("|c00"..cs..""..level.."|r "..name)
end

  --update castbar
local updateCastbar = function(cb)
    if cb.shield:IsShown() then
		cb:SetStatusBarColor(C['nameplates'].castbar.colorshielded.r,C['nameplates'].castbar.colorshielded.g,C['nameplates'].castbar.colorshielded.b)
    else
		cb:SetStatusBarColor(C['nameplates'].castbar.colordefault.r,C['nameplates'].castbar.colordefault.g,C['nameplates'].castbar.colordefault.b)
    end
end

  --number format func
local numFormat = function(v)
    if v > 1E10 then
		return (floor(v/1E9)).."b"
    elseif v > 1E9 then
		return (floor((v/1E9)*10)/10).."b"
    elseif v > 1E7 then
		return (floor(v/1E6)).."m"
    elseif v > 1E6 then
		return (floor((v/1E6)*10)/10).."m"
    elseif v > 1E4 then
		return (floor(v/1E3)).."k"
    elseif v > 1E3 then
		return (floor((v/1E3)*10)/10).."k"
    else
		return v
    end
end

  --update health
local updateHealth = function(hb,v)
    if not hb then return end
    local min, max = hb:GetMinMaxValues()
    local val = v or hb:GetValue()
    local p = floor(val/max*100)
    if C['nameplates'].lowHpWarning.enable then
		if p <= C['nameplates'].lowHpWarning.threshold then
			local c = C['nameplates'].lowHpWarning.color
			hb:SetStatusBarColor(c.r,c.g,c.b)
		end
    end
    if C['nameplates'].hpvalue.enable then
		hb.hpvalue:SetText(numFormat(val).." - "..p.."%")
    end
end

  --health value string
local createHpValueString = function(f)
    if not C['nameplates'].hpvalue.enable then return end
    local n = f.gloss_holder:CreateFontString(nil, "BORDER")
    n:SetFont("Fonts\\ARIALN.ttf", C['nameplates'].hpvalue.size, "THINOUTLINE")
    n:SetPoint("CENTER", 0, 0)
    f.healthbar.hpvalue = n
end

  --new fontstrings for name and lvl func
local createNameString = function(f)
    if not C['nameplates'].name.enable then return end
    local n = f:CreateFontString(nil, "BORDER")
    n:SetFont("Fonts\\ARIALN.ttf", C['nameplates'].name.size, "THINOUTLINE")
    n:SetPoint("LEFT", -10, 0)
    n:SetPoint("RIGHT", 10, 0)
    n:SetPoint("TOP", 0, 7)
    n:SetJustifyH("CENTER")
    f.ns = n
end

  --create art
local createArt = function(f)
    f.w, f.h, f.hw, f.hh = f:GetWidth(), f:GetHeight(), f.healthbar:GetWidth(), f.healthbar:GetHeight()
    local w,h = f.w*C['nameplates'].framescale, f.w*C['nameplates'].framescale/4 --width/height ratio is 4:1
    local threat_adjust = 1.18 --threat size needs to be increased, texture is shrinked a bit to fit in
    --threat holder
    local th = CreateFrame("Frame",nil,f)
    th:SetSize(w*threat_adjust,h*threat_adjust)
    th:SetPoint("CENTER", 0, 0)
    --threat glow
    f.threat:SetTexCoord(0,1,0,1)
    f.threat:SetTexture("Interface\\Addons\\BasicUI\\Media\\nameplate_threat")
    f.threat:ClearAllPoints()
    f.threat:SetAllPoints(th)
    f.threat:SetParent(th)
    --background frame
    local bf = CreateFrame("Frame",nil,th)
    bf:SetSize(w,h)
    bf:SetPoint("CENTER",0,0)
    --bg texture
    local bg = bf:CreateTexture(nil,"BACKGROUND",nil,1)
    bg:SetAllPoints(bf)
    bg:SetTexture("Interface\\Addons\\BasicUI\\Media\\nameplate_bg")
    --position healthbar
    f.healthbar:SetStatusBarTexture("Interface\\Addons\\BasicUI\\Media\\nameplate_bar")
    f.healthbar:ClearAllPoints()
    f.healthbar:SetAllPoints(bf)
    f.healthbar:SetParent(bf)
    --highlight frame
    local hl = CreateFrame("Frame",nil,f.healthbar)
    hl:SetAllPoints(bf)
    --highlight texture
    local gl = hl:CreateTexture(nil,"BACKGROUND",nil,3)
    gl:SetAllPoints(hl)
    gl:SetTexture("Interface\\Addons\\BasicUI\\Media\\nameplate_highlight")
    --raid icon
    f.raid:ClearAllPoints()
    f.raid:SetSize(C['nameplates'].raidmarkiconsize,C['nameplates'].raidmarkiconsize)
    f.raid:SetPoint("CENTER", 0, 35)
    f.raid:SetParent(hl)
    --parent frames
    f.threat_holder = th
    f.back_holder = bf
    f.gloss_holder = hl
end

  --create castbar art
local createCastbarArt = function(f)
    f.w, f.h = f:GetWidth(), f:GetHeight()
    local w,h = f.w*C['nameplates'].castbar.scale, f.w*C['nameplates'].castbar.scale/4 --width/height ratio is 4:1
    --background frame
    local bf = CreateFrame("Frame",nil,f)
    bf:SetSize(w,h)
    bf:SetPoint("CENTER", 0, -17)
    --bg texture
    local bg = bf:CreateTexture(nil,"BACKGROUND",nil,1)
    bg:SetAllPoints(bf)
    bg:SetTexture("Interface\\Addons\\BasicUI\\Media\\nameplate_bg")
    --position castbar
    f.castbar:SetStatusBarTexture("Interface\\Addons\\BasicUI\\Media\\nameplate_bar")
    f.castbar:ClearAllPoints()
    f.castbar:SetAllPoints(bf)
    f.castbar:SetParent(bf)
    bg:SetParent(f.castbar)
    --highlight frame
    local hl = CreateFrame("Frame",nil,f.castbar)
    hl:SetAllPoints(bf)
    --highlight texture
    local gl = hl:CreateTexture(nil,"BACKGROUND",nil,3)
    gl:SetAllPoints(hl)
    gl:SetTexture("Interface\\Addons\\BasicUI\\Media\\nameplate_highlight")
    --move icon to gloss frame
    local ic = CreateFrame("Frame",nil,hl)
    ic:SetSize(C['nameplates'].castbar.iconsize,C['nameplates'].castbar.iconsize)
    ic:SetPoint("LEFT", -35, 8)
    --castbar icon adjust
    f.castbar.icon:SetTexCoord(0.1,0.9,0.1,0.9)
    f.castbar.icon:ClearAllPoints()
    f.castbar.icon:SetAllPoints(ic)
    f.castbar.icon:SetParent(ic)
    f.castbar.icon:SetDrawLayer("BACKGROUND",3)
	local ib = ic:CreateTexture(nil,"BACKGROUND",nil,5)
    ib:SetPoint("TOPLEFT", ic, "TOPLEFT", -2, 2)
    ib:SetPoint("BOTTOMRIGHT", ic, "BOTTOMRIGHT", 2, -2)
    f.castbar.parent = bf --keep reference to parent element for later
    f.castbar_holder = bf
end

  --update style func
local updateStyle = function(f)
    hideStuff(f)
    fixStuff(f)
    updateText(f)
    updateHealth(f.healthbar)
end

  --init style func
local styleNameplate = function(f)
    --make objects available for later
    f.healthbar, f.castbar = f:GetChildren()
    f.threat, f.border, f.highlight, f.name, f.level, f.boss, f.raid, f.dragon = f:GetRegions()
    f.castbar.texture, f.castbar.border, f.castbar.shield, f.castbar.icon = f.castbar:GetRegions()
    f.unit = {}
    --create stuff
    createArt(f)
    createCastbarArt(f)
    createNameString(f)
    createHpValueString(f)
    updateText(f)
    --hide stuff
    hideStuff(f)
    --hook stuff
    f:HookScript("OnShow", updateStyle)
    f.castbar:HookScript("OnShow", updateCastbar)
    --fix castbar
    f.castbar:SetScript("OnValueChanged", fixCastbar)
    --update health
    f.healthbar:SetScript("OnValueChanged", updateHealth)
    updateHealth(f.healthbar)
    --set var
    f.styled = true
end

  --check
local IsNamePlateFrame = function(f)
    local o = select(2,f:GetRegions())
    if not o or o:GetObjectType() ~= "Texture" or o:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
		f.styled = true --don't touch this frame again
		return false
    end
    return true
end

  --onupdate
local lastupdate = 0
local searchNamePlates = function(self,elapsed)
    lastupdate = lastupdate + elapsed
    if lastupdate > 0.33 then
		lastupdate = 0
		local num = select("#", WorldFrame:GetChildren())
		for i = 1, num do
			local f = select(i, WorldFrame:GetChildren())
			if not f.styled and IsNamePlateFrame(f) then
				styleNameplate(f)
			end
		end
    end
end

  --init
local a = CreateFrame("Frame")
a:SetScript("OnEvent", function(self, event)
    if(event=="PLAYER_LOGIN") then
		SetCVar("bloattest",0)--0.0
		SetCVar("bloatnameplates",0)--0.0
		SetCVar("bloatthreat",0)--1
		self:SetScript("OnUpdate", searchNamePlates)
    end
end)
a:RegisterEvent("PLAYER_LOGIN")
