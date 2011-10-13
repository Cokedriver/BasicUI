local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[ 
	Original Code from nibEclipse
	Edited by Cokderiver for BasicUI
]]

if C['eclipsebar'].enable ~= true then return end

EclipseBarFrame:UnregisterAllEvents()
EclipseBarFrame:Hide()
function EclipseBarFrame:Show() return nil end;

local BasicEclipse = CreateFrame("Frame")
BasicEclipse.direction = "none"
BasicEclipse.lastupdate = 0

local EventsRegistered

local Textures = {
	Arrow = "Interface\\PlayerFrame\\UI-DruidEclipse",
}

local IconShow = {
	moon = { 0.55859375, 0.72656250, 0.00781250, 0.35937500 },
	sun = { 0.73437500, 0.90234375, 0.00781250, 0.35937500 },
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
	BasicEclipse.direction = GetEclipseDirection()
	if BasicEclipse.direction == "sun" then
		
		BasicEclipse.Frames.Icon:Show()
		BasicEclipse.Frames.Icon:ClearAllPoints()
		BasicEclipse.Frames.Icon:SetPoint("LEFT", BasicEclipse.Frames.Main, "LEFT", -45, 0)
		BasicEclipse.Frames.Icon.bg:SetTexCoord(unpack(IconShow.sun))
		B.Flash(BasicEclipse.Frames.Icon, 1)
		
		BasicEclipse.Frames.Status:Show()
		BasicEclipse.Frames.Status:ClearAllPoints()
		BasicEclipse.Frames.Status:SetPoint("BOTTOMLEFT", BasicEclipse.Frames.Main, "BOTTOMLEFT", 1, 1)
		BasicEclipse.Frames.Status:SetWidth(1)
		BasicEclipse.Frames.Status.bg:SetTexture(unpack(C['eclipsebar'].colors.lunar))
		BasicEclipse.Frames.Status.bg:SetAllPoints(BasicEclipse.Frames.Status)
		
		BasicEclipse.Frames.Below:SetPoint('TOP', BasicEclipse.Frames.Status, 'BOTTOMRIGHT', 0, 0)			
		
	elseif BasicEclipse.direction == "moon" then
		
		BasicEclipse.Frames.Icon:Show()
		BasicEclipse.Frames.Icon:ClearAllPoints()
		BasicEclipse.Frames.Icon:SetPoint("RIGHT", BasicEclipse.Frames.Main, "RIGHT", 47, 1)
		BasicEclipse.Frames.Icon.bg:SetTexCoord(unpack(IconShow.moon))
		B.Flash(BasicEclipse.Frames.Icon, 1)
		
		BasicEclipse.Frames.Status:Show()
		BasicEclipse.Frames.Status:ClearAllPoints()
		BasicEclipse.Frames.Status:SetPoint("BOTTOMRIGHT", BasicEclipse.Frames.Main, "BOTTOMRIGHT", -1, 1)
		BasicEclipse.Frames.Status:SetWidth(1)
		BasicEclipse.Frames.Status.bg:SetTexture(unpack(C['eclipsebar'].colors.solar))
		BasicEclipse.Frames.Status.bg:SetAllPoints(BasicEclipse.Frames.Status)
		
		BasicEclipse.Frames.Below:SetPoint('TOP', BasicEclipse.Frames.Status, 'BOTTOMLEFT', 0, 0)			
		
	else
	
		BasicEclipse.Frames.Arrow:Hide()
		BasicEclipse.Frames.Status:Hide()
		B.StopFlash(BasicEclipse.Frames.Icon)
	end


end

local function Eclipse_UpdateAuras(...)
	if ... ~= "player" then return end
	
	local buffStatus = HasEclipseBuffs()
	local hasSolar = buffStatus[1]
	local hasLunar = buffStatus[2]

end

local function Eclipse_UpdateShown()
	local form = GetShapeshiftFormID()
	if form == MOONKIN_FORM or not form then
		if (InCombatLockdown()) then
			securecall('UIFrameFadeIn', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 1)
		else
			securecall('UIFrameFadeOut', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 0)
		end
	else
		securecall('UIFrameFadeOut', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 0)
	end
	
end

function BasicEclipse.OnUpdate()
	local CurTime = GetTime()
	
	if CurTime >= BasicEclipse.lastupdate + 0.05 then
		local power = UnitPower("player", SPELL_POWER_ECLIPSE)
		local maxPower = UnitPowerMax("player", SPELL_POWER_ECLIPSE)
		
		if maxPower <= 0 or power > maxPower then
			return
		end
		
		local powerper = 0
		if BasicEclipse.direction == "sun" then
			powerper = (power + 100) / (maxPower + 100)
		elseif BasicEclipse.direction == "moon" then
			powerper = 1 - ((power + 100) / (maxPower + 100))
		else
			powerper = 0
		end
		powerper = max(powerper, 0)
		powerper = min(powerper, 1)
		
		if (UnitPower('player') == 0) then
			BasicEclipse.Frames.Below:SetAlpha(0.3)
			BasicEclipse.Frames.Above:SetAlpha(0.3)
		else
			BasicEclipse.Frames.Below:SetAlpha(1)
			BasicEclipse.Frames.Above:SetAlpha(1)
		end
		
		BasicEclipse.Frames.Status:SetWidth(powerper * (C['eclipsebar'].size.width - 2) + 1)
		BasicEclipse.Frames.Text.str:SetText(tostring(abs(power)))
		
		BasicEclipse.lastupdate = CurTime
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
	elseif event == "UPDATE_SHAPESHIFT_FORM" or event == "PLAYER_TALENT_UPDATE" or event == "MASTERY_UPDATE" or event == "PLAYER_UNGHOST" or event == "PLAYER_ALIVE" or event == "PLAYER_DEAD" then
		Eclipse_UpdateShown()
	elseif event == "UNIT_AURA" then
		Eclipse_UpdateAuras(...)
	elseif event == "ECLIPSE_DIRECTION_CHANGE" then
		Eclipse_UpdateDirection()
	elseif event == 'PLAYER_REGEN_DISABLED' then
		securecall('UIFrameFadeIn', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 1)
	elseif event == 'PLAYER_REGEN_ENABLED' then
		securecall('UIFrameFadeOut', BasicEclipse.Frames.Main, 0.35, BasicEclipse.Frames.Main:GetAlpha(), 0)
	end
end

function BasicEclipse.SetupEvents()
	if EventsRegistered then return end
	
	BasicEclipse.Frames.Main:RegisterEvent("PLAYER_ENTERING_WORLD")
	BasicEclipse.Frames.Main:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	BasicEclipse.Frames.Main:RegisterEvent("PLAYER_TALENT_UPDATE")
	BasicEclipse.Frames.Main:RegisterEvent("MASTERY_UPDATE")
	BasicEclipse.Frames.Main:RegisterEvent("PLAYER_TARGET_CHANGED")
	BasicEclipse.Frames.Main:RegisterEvent("PLAYER_UNGHOST")
	BasicEclipse.Frames.Main:RegisterEvent("PLAYER_REGEN_DISABLED")
	BasicEclipse.Frames.Main:RegisterEvent("PLAYER_REGEN_ENABLED")
	BasicEclipse.Frames.Main:RegisterEvent("PLAYER_ALIVE")
	BasicEclipse.Frames.Main:RegisterEvent("PLAYER_DEAD")
	BasicEclipse.Frames.Main:RegisterEvent("UNIT_AURA")
	BasicEclipse.Frames.Main:RegisterEvent("ECLIPSE_DIRECTION_CHANGE")
	BasicEclipse.Frames.Main:SetScript("OnEvent", EclipseEvents)
	
	-- Enable OnUpdate handler
	BasicEclipse.LastTime = 0
	BasicEclipse.Frames.Main:SetScript("OnUpdate", BasicEclipse.OnUpdate)
	
	EventsRegistered = true
end

-- Settings Update
function BasicEclipse.UpdateSettings()
	local PF = _G[C['eclipsebar'].position.parent] or UIParent
	BasicEclipse.Frames.Main:SetParent(PF)
	BasicEclipse.Frames.Main:SetPoint(C['eclipsebar'].position.anchor, PF, C['eclipsebar'].position.anchor, B.scale(C['eclipsebar'].position.x), B.scale(C['eclipsebar'].position.y))
	BasicEclipse.Frames.Main:SetFrameStrata(PF:GetFrameStrata())
	BasicEclipse.Frames.Main:SetFrameLevel(PF:GetFrameLevel() + 4)
	BasicEclipse.Frames.Main:SetWidth(C['eclipsebar'].size.width)
	BasicEclipse.Frames.Main:SetHeight(C['eclipsebar'].size.height)
	local EclipseBorder = CreateFrame("Frame", nil, BasicEclipse.Frames.Main);
	EclipseBorder:SetFrameStrata("MEDIUM");
	EclipseBorder:SetPoint("TOPLEFT", -3, 3);
	EclipseBorder:SetPoint("BOTTOMRIGHT", 3, -3);
	EclipseBorder:SetBackdrop({
		edgeFile = 'Interface\\AddOns\\BasicUI\\BasicMedia\\UI-Tooltip-Border',
		edgeSize = 15,
	})
	EclipseBorder:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
	

	-- Lunar BG
	BasicEclipse.Frames.LunarBG:SetWidth((C['eclipsebar'].size.width / 2) - 1)
	BasicEclipse.Frames.LunarBG:SetHeight(C['eclipsebar'].size.height - 2)
	BasicEclipse.Frames.LunarBG:SetTexture("Interface\\AddOns\\BasicUI\\BasicMedia\\Eclipse_Lunar.tga")
	
	-- Solar BG
	BasicEclipse.Frames.SolarBG:SetWidth((C['eclipsebar'].size.width / 2) - 1)
	BasicEclipse.Frames.SolarBG:SetHeight(C['eclipsebar'].size.height - 2)
	BasicEclipse.Frames.SolarBG:SetTexture("Interface\\AddOns\\BasicUI\\BasicMedia\\Eclipse_Solar.tga")
	
	
	BasicEclipse.Frames.Below = BasicEclipse.Frames.Main:CreateTexture(nil, 'BACKGROUND')
	BasicEclipse.Frames.Below:SetHeight(14)
	BasicEclipse.Frames.Below:SetWidth(14)
	BasicEclipse.Frames.Below:SetTexture('Interface\\AddOns\\BasicUI\\BasicMedia\\textureArrowBelow')

	BasicEclipse.Frames.Above = BasicEclipse.Frames.Main:CreateTexture(nil, 'BACKGROUND')
	BasicEclipse.Frames.Above:SetHeight(14)
	BasicEclipse.Frames.Above:SetWidth(14)
	BasicEclipse.Frames.Above:SetTexture('Interface\\AddOns\\BasicUI\\BasicMedia\\textureArrowAbove')
	BasicEclipse.Frames.Above:SetPoint('BOTTOM', BasicEclipse.Frames.Below, 'TOP', 0, BasicEclipse.Frames.Main:GetHeight() - 2)
	
	-- Icons (Solar - Lunar)
	BasicEclipse.Frames.Icon:SetPoint("CENTER", BasicEclipse.Frames.Main, "CENTER", 0, 1)
	BasicEclipse.Frames.Icon:SetFrameLevel(BasicEclipse.Frames.Main:GetFrameLevel() + 2)
	BasicEclipse.Frames.Icon:SetWidth(C['eclipsebar'].size.icon * C['eclipsebar'].size.iconscale)
	BasicEclipse.Frames.Icon:SetHeight(C['eclipsebar'].size.icon * C['eclipsebar'].size.iconscale)	
	
	BasicEclipse.Frames.Icon.bg:SetTexture(Textures.Arrow)
	BasicEclipse.Frames.Icon.bg:SetAllPoints(BasicEclipse.Frames.Icon)
	
	-- Status Bar
	BasicEclipse.Frames.Status:SetPoint("BOTTOM", BasicEclipse.Frames.Main, "BOTTOM", 0, 1)
	BasicEclipse.Frames.Status:SetFrameLevel(BasicEclipse.Frames.Main:GetFrameLevel() + 1)
	BasicEclipse.Frames.Status:SetWidth(1)
	BasicEclipse.Frames.Status:SetHeight(C['eclipsebar'].size.height - 2)

	
	-- Text
	local font = C['eclipsebar'].font.name
	BasicEclipse.Frames.Text:SetPoint("CENTER", BasicEclipse.Frames.Main, "CENTER", 0, C['eclipsebar'].font.vertoffset)
	BasicEclipse.Frames.Text:SetFrameLevel(BasicEclipse.Frames.Main:GetFrameLevel() + 2)
	BasicEclipse.Frames.Text:SetWidth(24)
	BasicEclipse.Frames.Text:SetHeight(24)
	BasicEclipse.Frames.Text.str:SetFont(font, C['eclipsebar'].font.size, C['eclipsebar'].font.tags)
	BasicEclipse.Frames.Text.str:SetText("0")
	if C['eclipsebar'].font.hidetext then BasicEclipse.Frames.Text:Hide() end
end

-- Frame Creation
function BasicEclipse.CreateFrames()
	if BasicEclipse.Frames then return end
	
	BasicEclipse.Frames = {}
	
	-- Create main frame
	BasicEclipse.Frames.Main = CreateFrame("Frame", "EclipseBar", UIParent)
	
	-- Lunar BG
	BasicEclipse.Frames.LunarBG = BasicEclipse.Frames.Main:CreateTexture("BACKGROUND")
	BasicEclipse.Frames.LunarBG:SetPoint("LEFT", BasicEclipse.Frames.Main, "LEFT", 1, 0)
	
	-- Solar BG
	BasicEclipse.Frames.SolarBG = BasicEclipse.Frames.Main:CreateTexture("BACKGROUND")
	BasicEclipse.Frames.SolarBG:SetPoint("RIGHT", BasicEclipse.Frames.Main, "RIGHT", -1, 0)
	
	-- Arrow
	BasicEclipse.Frames.Arrow = CreateFrame("Frame", nil, BasicEclipse.Frames.Main)
	BasicEclipse.Frames.Arrow.bg = BasicEclipse.Frames.Arrow:CreateTexture()
	BasicEclipse.Frames.Arrow.bg:SetBlendMode("ADD")

	--  Icon
	BasicEclipse.Frames.Icon = CreateFrame("Frame", nil, BasicEclipse.Frames.Main)
	BasicEclipse.Frames.Icon.bg = BasicEclipse.Frames.Icon:CreateTexture()
		
	-- Status Bar
	BasicEclipse.Frames.Status = CreateFrame("Frame", nil, BasicEclipse.Frames.Main)
	BasicEclipse.Frames.Status.bg = BasicEclipse.Frames.Status:CreateTexture()
	
	-- Text
	BasicEclipse.Frames.Text = CreateFrame("Frame", nil, BasicEclipse.Frames.Main)
	BasicEclipse.Frames.Text.str = BasicEclipse.Frames.Text:CreateFontString()
	BasicEclipse.Frames.Text.str:SetPoint("CENTER", BasicEclipse.Frames.Text, "CENTER")
end

----
function BasicEclipse.PLAYER_LOGIN()
	if not (select(2, UnitClass("player")) == "DRUID") then return end
	
	BasicEclipse.CreateFrames()
	BasicEclipse.UpdateSettings()
	BasicEclipse.SetupEvents()
end

local function EventHandler(self, event, ...)
	if event == "PLAYER_LOGIN" then
		BasicEclipse.PLAYER_LOGIN()
	end
end
BasicEclipse:RegisterEvent("PLAYER_LOGIN")
BasicEclipse:SetScript("OnEvent", EventHandler)