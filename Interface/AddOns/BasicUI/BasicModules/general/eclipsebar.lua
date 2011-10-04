local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

local Opts = C['eclipsebar']

if Opts.enable ~= true then return end

EclipseBarFrame:UnregisterAllEvents()
EclipseBarFrame:Hide()
function EclipseBarFrame:Show() return nil end;

local nEF = CreateFrame("Frame")
nEF.direction = "none"
nEF.lastupdate = 0

local EventsRegistered

local Textures = {
	Arrow = "Interface\\PlayerFrame\\UI-DruidEclipse",
}

local ArrowDirection = {
	sun	= { 0.914, 1.0, 0.641, 0.82 },
	moon = { 1.0, 0.914, 0.641, 0.82 },
}

local retval = {}
local function HasEclipseBuffs()
	local spellIDs = {ECLIPSE_BAR_SOLAR_BUFF_ID, ECLIPSE_BAR_LUNAR_BUFF_ID}
	
	for i = 1, #spellIDs do
		retval[i] = false
	end

	local i = 1
	local name, _, texture, applications, _, _, _, _, _, _, auraID = UnitAura("player", i)
	while name do
		for i=1, #spellIDs do
			if spellIDs[i] == auraID then
				retval[i] = applications == 0 and true or applications
				break
			end
		end

		i = i + 1
		name, _, texture, applications, _, _, _, _, _, _, auraID = UnitAura("player", i)
	end

	return retval
end

---- Events
local function Eclipse_UpdateDirection()
	nEF.direction = GetEclipseDirection()
	if nEF.direction == "sun" then
		nEF.Frames.Arrow:Show()
		nEF.Frames.Arrow:ClearAllPoints()
		nEF.Frames.Arrow:SetPoint("LEFT", nEF.Frames.Main, "LEFT", -Opts.size.arrowoffset, Opts.size.arrowvertoffset)
		nEF.Frames.Arrow.bg:SetTexCoord(unpack(ArrowDirection.sun))
		
		nEF.Frames.Status:Show()
		nEF.Frames.Status:ClearAllPoints()
		nEF.Frames.Status:SetPoint("BOTTOMLEFT", nEF.Frames.Main, "BOTTOMLEFT", 1, 1)
		nEF.Frames.Status:SetWidth(1)
	elseif nEF.direction == "moon" then
		nEF.Frames.Arrow:Show()
		nEF.Frames.Arrow:ClearAllPoints()
		nEF.Frames.Arrow:SetPoint("RIGHT", nEF.Frames.Main, "RIGHT", Opts.size.arrowoffset, Opts.size.arrowvertoffset)
		nEF.Frames.Arrow.bg:SetTexCoord(unpack(ArrowDirection.moon))
		
		nEF.Frames.Status:Show()
		nEF.Frames.Status:ClearAllPoints()
		nEF.Frames.Status:SetPoint("BOTTOMRIGHT", nEF.Frames.Main, "BOTTOMRIGHT", -1, 1)
		nEF.Frames.Status:SetWidth(1)
	else
		nEF.Frames.Arrow:Hide()
		nEF.Frames.Status:Hide()
	end
end

local function Eclipse_UpdateAuras(...)
	if ... ~= "player" then return end
	
	local buffStatus = HasEclipseBuffs()
	local hasSolar = buffStatus[1]
	local hasLunar = buffStatus[2]

	if hasSolar then
		for i = 1, 3 do
			nEF.Frames.LunarBorder[i]:SetTexture(unpack(Opts.colors.border))
			nEF.Frames.SolarBorder[i]:SetTexture(unpack(Opts.colors.auraborder))
		end
	elseif hasLunar then
		for i = 1, 3 do
			nEF.Frames.LunarBorder[i]:SetTexture(unpack(Opts.colors.auraborder))
			nEF.Frames.SolarBorder[i]:SetTexture(unpack(Opts.colors.border))
		end
	else
		for i = 1, 3 do
			nEF.Frames.LunarBorder[i]:SetTexture(unpack(Opts.colors.border))
			nEF.Frames.SolarBorder[i]:SetTexture(unpack(Opts.colors.border))
		end
	end
end

local function Eclipse_UpdateShown()
	local form = GetShapeshiftFormID()
	if form == MOONKIN_FORM or not form then
		if ( (GetPrimaryTalentTree() == 1) and UnitExists("target") and UnitCanAttack("player", "target") and not(UnitIsDeadOrGhost("player")) and not(UnitIsDeadOrGhost("target")) and not(UnitInVehicle("player")) ) then
			nEF.Frames.Main:Show()
		else
			nEF.Frames.Main:Hide()
		end
	else
		nEF.Frames.Main:Hide()
	end
end

function nEF.OnUpdate()
	local CurTime = GetTime()
	
	if CurTime >= nEF.lastupdate + 0.05 then
		local power = UnitPower("player", SPELL_POWER_ECLIPSE)
		local maxPower = UnitPowerMax("player", SPELL_POWER_ECLIPSE)
		
		if maxPower <= 0 or power > maxPower then
			return
		end
		
		local powerper = 0
		if nEF.direction == "sun" then
			powerper = (power + 100) / (maxPower + 100)
		elseif nEF.direction == "moon" then
			powerper = 1 - ((power + 100) / (maxPower + 100))
		else
			powerper = 0
		end
		powerper = max(powerper, 0)
		powerper = min(powerper, 1)
		
		nEF.Frames.Status:SetWidth(powerper * (Opts.size.width - 2) + 1)
		nEF.Frames.Text.str:SetText(tostring(abs(power)))
		
		nEF.lastupdate = CurTime
	end
end

local function Eclipse_PlayerEnteringWorld()
	Eclipse_UpdateShown()
	Eclipse_UpdateAuras("player")
	Eclipse_UpdateDirection()
end

local function EclipseEvents(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		Eclipse_PlayerEnteringWorld()
	elseif event == "UPDATE_SHAPESHIFT_FORM" or event == "PLAYER_TALENT_UPDATE" or 
			event == "MASTERY_UPDATE" or event == "PLAYER_TARGET_CHANGED" or
			event == "PLAYER_UNGHOST" or event == "PLAYER_ALIVE" or event == "PLAYER_DEAD" then
		Eclipse_UpdateShown()
	elseif event == "UNIT_AURA" then
		Eclipse_UpdateAuras(...)
	elseif event == "ECLIPSE_DIRECTION_CHANGE" then
		Eclipse_UpdateDirection()
	end
end

function nEF.SetupEvents()
	if EventsRegistered then return end
	
	nEF.Frames.Main:RegisterEvent("PLAYER_ENTERING_WORLD")
	nEF.Frames.Main:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	nEF.Frames.Main:RegisterEvent("PLAYER_TALENT_UPDATE")
	nEF.Frames.Main:RegisterEvent("MASTERY_UPDATE")
	nEF.Frames.Main:RegisterEvent("PLAYER_TARGET_CHANGED")
	nEF.Frames.Main:RegisterEvent("PLAYER_UNGHOST")
	nEF.Frames.Main:RegisterEvent("PLAYER_ALIVE")
	nEF.Frames.Main:RegisterEvent("PLAYER_DEAD")
	nEF.Frames.Main:RegisterEvent("UNIT_AURA")
	nEF.Frames.Main:RegisterEvent("ECLIPSE_DIRECTION_CHANGE")
	nEF.Frames.Main:SetScript("OnEvent", EclipseEvents)
	
	-- Enable OnUpdate handler
	nEF.LastTime = 0
	nEF.Frames.Main:SetScript("OnUpdate", nEF.OnUpdate)
	
	EventsRegistered = true
end

-- Settings Update
function nEF.UpdateSettings()
	local PF = _G[Opts.position.parent] or UIParent
	nEF.Frames.Main:SetParent(PF)
	nEF.Frames.Main:SetPoint(Opts.position.anchor, PF, Opts.position.anchor, B.scale(Opts.position.x), B.scale(Opts.position.y))
	nEF.Frames.Main:SetFrameStrata(PF:GetFrameStrata())
	nEF.Frames.Main:SetFrameLevel(PF:GetFrameLevel() + 4)
	nEF.Frames.Main:SetWidth(Opts.size.width)
	nEF.Frames.Main:SetHeight(Opts.size.height)
	
	-- Lunar Border
	nEF.Frames.LunarBorder[1]:SetPoint("TOPLEFT", nEF.Frames.Main, "TOPLEFT", 0, 0)
	nEF.Frames.LunarBorder[1]:SetWidth(Opts.size.width / 2)
	nEF.Frames.LunarBorder[1]:SetHeight(1)
	nEF.Frames.LunarBorder[1]:SetTexture(unpack(Opts.colors.border))
	nEF.Frames.LunarBorder[2]:SetPoint("LEFT", nEF.Frames.Main, "LEFT", 0, 0)
	nEF.Frames.LunarBorder[2]:SetWidth(1)
	nEF.Frames.LunarBorder[2]:SetHeight(Opts.size.height)
	nEF.Frames.LunarBorder[2]:SetTexture(unpack(Opts.colors.border))
	nEF.Frames.LunarBorder[3]:SetPoint("BOTTOMLEFT", nEF.Frames.Main, "BOTTOMLEFT", 0, 0)
	nEF.Frames.LunarBorder[3]:SetWidth(Opts.size.width / 2)
	nEF.Frames.LunarBorder[3]:SetHeight(1)
	nEF.Frames.LunarBorder[3]:SetTexture(unpack(Opts.colors.border))
	
	-- Solar Border
	nEF.Frames.SolarBorder[1]:SetPoint("TOPRIGHT", nEF.Frames.Main, "TOPRIGHT", 0, 0)
	nEF.Frames.SolarBorder[1]:SetWidth(Opts.size.width / 2)
	nEF.Frames.SolarBorder[1]:SetHeight(1)
	nEF.Frames.SolarBorder[1]:SetTexture(unpack(Opts.colors.border))
	nEF.Frames.SolarBorder[2]:SetPoint("RIGHT", nEF.Frames.Main, "RIGHT", 0, 0)
	nEF.Frames.SolarBorder[2]:SetWidth(1)
	nEF.Frames.SolarBorder[2]:SetHeight(Opts.size.height)
	nEF.Frames.SolarBorder[2]:SetTexture(unpack(Opts.colors.border))
	nEF.Frames.SolarBorder[3]:SetPoint("BOTTOMRIGHT", nEF.Frames.Main, "BOTTOMRIGHT", 0, 0)
	nEF.Frames.SolarBorder[3]:SetWidth(Opts.size.width / 2)
	nEF.Frames.SolarBorder[3]:SetHeight(1)
	nEF.Frames.SolarBorder[3]:SetTexture(unpack(Opts.colors.border))
	
	-- Lunar BG
	nEF.Frames.LunarBG:SetWidth((Opts.size.width / 2) - 1)
	nEF.Frames.LunarBG:SetHeight(Opts.size.height - 2)
	nEF.Frames.LunarBG:SetTexture(unpack(Opts.colors.lunar))
	
	-- Solar BG
	nEF.Frames.SolarBG:SetWidth((Opts.size.width / 2) - 1)
	nEF.Frames.SolarBG:SetHeight(Opts.size.height - 2)
	nEF.Frames.SolarBG:SetTexture(unpack(Opts.colors.solar))
	
	-- Arrow
	nEF.Frames.Arrow:SetPoint("CENTER", nEF.Frames.Main, "CENTER", 0, 1)
	nEF.Frames.Arrow:SetFrameLevel(nEF.Frames.Main:GetFrameLevel() + 2)
	nEF.Frames.Arrow:SetWidth(Opts.size.height * Opts.size.arrowscale)
	nEF.Frames.Arrow:SetHeight(Opts.size.height * Opts.size.arrowscale)
	
	nEF.Frames.Arrow.bg:SetTexture(Textures.Arrow)
	nEF.Frames.Arrow.bg:SetVertexColor(unpack(Opts.colors.arrow))
	nEF.Frames.Arrow.bg:SetAllPoints(nEF.Frames.Arrow)
	
	-- Status Bar
	nEF.Frames.Status:SetPoint("BOTTOM", nEF.Frames.Main, "BOTTOM", 0, 1)
	nEF.Frames.Status:SetFrameLevel(nEF.Frames.Main:GetFrameLevel() + 1)
	nEF.Frames.Status:SetWidth(1)
	nEF.Frames.Status:SetHeight(Opts.size.height - 2)
	
	nEF.Frames.Status.bg:SetTexture(1, 1, 1, Opts.colors.statusopacity)	
	nEF.Frames.Status.bg:SetAllPoints(nEF.Frames.Status)
	
	-- Text
	local font = Opts.font.name
	nEF.Frames.Text:SetPoint("CENTER", nEF.Frames.Main, "CENTER", 0, Opts.font.vertoffset)
	nEF.Frames.Text:SetFrameLevel(nEF.Frames.Main:GetFrameLevel() + 2)
	nEF.Frames.Text:SetWidth(Opts.size.width - 2)
	nEF.Frames.Text:SetHeight(Opts.size.height - 2)
	nEF.Frames.Text.str:SetFont(font, Opts.font.size, Opts.font.tags)
	nEF.Frames.Text.str:SetText("0")
	if Opts.font.hidetext then nEF.Frames.Text:Hide() end
end

-- Frame Creation
function nEF.CreateFrames()
	if nEF.Frames then return end
	
	nEF.Frames = {}
	
	-- Create main frame
	nEF.Frames.Main = CreateFrame("Frame", "EclipseBar", UIParent)
	
	-- Lunar Border
	nEF.Frames.LunarBorder = {}
	for i = 1, 3 do
		nEF.Frames.LunarBorder[i] = nEF.Frames.Main:CreateTexture()
	end
	
	-- Solar Border
	nEF.Frames.SolarBorder = {}
	for i = 1, 3 do
		nEF.Frames.SolarBorder[i] = nEF.Frames.Main:CreateTexture()
	end
	
	-- Lunar BG
	nEF.Frames.LunarBG = nEF.Frames.Main:CreateTexture("BACKGROUND")
	nEF.Frames.LunarBG:SetPoint("LEFT", nEF.Frames.Main, "LEFT", 1, 0)
	
	-- Solar BG
	nEF.Frames.SolarBG = nEF.Frames.Main:CreateTexture("BACKGROUND")
	nEF.Frames.SolarBG:SetPoint("RIGHT", nEF.Frames.Main, "RIGHT", -1, 0)
	
	-- Arrow
	nEF.Frames.Arrow = CreateFrame("Frame", nil, nEF.Frames.Main)
	nEF.Frames.Arrow.bg = nEF.Frames.Arrow:CreateTexture()
	nEF.Frames.Arrow.bg:SetBlendMode("ADD")
	
	-- Status Bar
	nEF.Frames.Status = CreateFrame("Frame", nil, nEF.Frames.Main)
	nEF.Frames.Status.bg = nEF.Frames.Status:CreateTexture()
	
	-- Text
	nEF.Frames.Text = CreateFrame("Frame", nil, nEF.Frames.Main)
	nEF.Frames.Text.str = nEF.Frames.Text:CreateFontString()
	nEF.Frames.Text.str:SetPoint("CENTER", nEF.Frames.Text, "CENTER")
end

----
function nEF.PLAYER_LOGIN()
	if not (select(2, UnitClass("player")) == "DRUID") then return end
	
	nEF.CreateFrames()
	nEF.UpdateSettings()
	nEF.SetupEvents()
end

local function EventHandler(self, event, ...)
	if event == "PLAYER_LOGIN" then
		nEF.PLAYER_LOGIN()
	end
end
nEF:RegisterEvent("PLAYER_LOGIN")
nEF:SetScript("OnEvent", EventHandler)