local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C["unitframes"].enable ~= true then return end


-- Special Thanks to the guys over at Arena Junkies for most of these scripts
-- http://www.arenajunkies.com/topic/222642-default-ui-scripts/

local _G = _G
local UF = function() end

-- Player Frame
if C["unitframes"].player.enable then

	-- Frame Scale
	 _G["PlayerFrame"]:SetScale(C["unitframes"].player.scale)
	 
	-- Font Size/Style
	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
	
		-- Player Healthbar Font Formating
		if C["unitframes"].player.tsHealth == "XX" then
			PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player")))
		elseif C["unitframes"].player.tsHealth == "XX/XX" then
			PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player")).." / "..(UnitHealthMax("player")))
		elseif C["unitframes"].player.tsHealth == "XX (%)" then
			PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player"))..' ('..(floor(((UnitHealth("player"))/(UnitHealthMax("player")))*100))..'%)')
		elseif C["unitframes"].player.tsHealth == "XX/XX (%)" then
			PlayerFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("player")).." / "..(UnitHealthMax("player"))..' ('..(floor(((UnitHealth("player"))/(UnitHealthMax("player")))*100))..'%)')
		end
		PlayerFrameHealthBar.TextString:SetFont(C['media'].font, C["unitframes"].player.hfSize, "OUTLINE")

		-- Player Manabar Font Formating
		if C["unitframes"].player.tsMana == "XX" then
			PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")))
		elseif C["unitframes"].player.tsMana == "XX/XX" then
			PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")).." / "..(UnitManaMax("player")))
		elseif C["unitframes"].player.tsMana == "XX (%)" then
			PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player"))..' ('..(floor(((UnitMana("player"))/(UnitManaMax("player")))*100))..'%)')
		elseif C["unitframes"].player.tsMana == "XX/XX (%)" then
			PlayerFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("player")).." / "..(UnitManaMax("player"))..' ('..(floor(((UnitMana("player"))/(UnitManaMax("player")))*100))..'%)')
		end		
		PlayerFrameManaBar.TextString:SetFont(C['media'].font, C["unitframes"].player.mfSize, "OUTLINE")
		
		-- Player Alternate Manabar Font Formating (Druid Cat/Bear Form)
		if C["unitframes"].player.tsAltMana == "XX" then
			PlayerFrameAlternateManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitPower("Player", 0)))
		elseif C["unitframes"].player.tsAltMana == "XX/XX" then
			PlayerFrameAlternateManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitPower("Player", 0)).." / "..(UnitPowerMax("Player", 0)))
		elseif C["unitframes"].player.tsAltMana == "XX (%)" then
			PlayerFrameAlternateManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitPower("Player", 0))..' ('..(floor(((UnitPower("Player", 0))/(UnitPowerMax("Player", 0)))*100))..'%)')
		elseif C["unitframes"].player.tsAltMana == "XX/XX (%)" then
			PlayerFrameAlternateManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitPower("Player", 0)).." / "..(UnitPowerMax("Player", 0))..' ('..(floor(((UnitPower("Player", 0))/(UnitPowerMax("Player", 0)))*100))..'%)')
		end	
		PlayerFrameAlternateManaBar.TextString:SetFont(C['media'].font, C["unitframes"].player.amfSize, "OUTLINE")			
	end)
end

-- Target Frame
if C["unitframes"].target.enable then

	-- Frame Scale
	 _G["TargetFrame"]:SetScale(C["unitframes"].target.scale)
	 
	-- Font Size/Style
	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
	
		-- Target Healthbar Font Formating
		if C["unitframes"].target.tsHealth == "XX" then
			TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target")))
		elseif C["unitframes"].target.tsHealth == "XX/XX" then
			TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target")).." / "..(UnitHealthMax("target")))
		elseif C["unitframes"].target.tsHealth == "XX (%)" then
			TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target"))..' ('..(floor(((UnitHealth("target"))/(UnitHealthMax("target")))*100))..'%)')
		elseif C["unitframes"].target.tsHealth == "XX/XX (%)" then
			TargetFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("target")).." / "..(UnitHealthMax("target"))..' ('..(floor(((UnitHealth("target"))/(UnitHealthMax("target")))*100))..'%)')
		end
		TargetFrameHealthBar.TextString:SetFont(C['media'].font, C["unitframes"].target.hfSize, "OUTLINE")

		-- Target Manabar Font Formating
		if C["unitframes"].target.tsMana == "XX" then
			TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")))
		elseif C["unitframes"].target.tsMana == "XX/XX" then
			TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")).." / "..(UnitManaMax("target")))
		elseif C["unitframes"].target.tsMana == "XX (%)" then
			TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target"))..' ('..(floor(((UnitMana("target"))/(UnitManaMax("target")))*100))..'%)')
		elseif C["unitframes"].target.tsMana == "XX/XX (%)" then
			TargetFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("target")).." / "..(UnitManaMax("target"))..' ('..(floor(((UnitMana("target"))/(UnitManaMax("target")))*100))..'%)')
		end		
		TargetFrameManaBar.TextString:SetFont(C['media'].font, C["unitframes"].target.mfSize, "OUTLINE")		
	end)
end

-- Focus Frame
if C["unitframes"].focus.enable then

	-- Frame Scale
	 _G["FocusFrame"]:SetScale(C["unitframes"].focus.scale)
	 
	-- Font Size/Style
	hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function()
	
		-- Focus Healthbar Font Formating
		if C["unitframes"].focus.tsHealth == "XX" then
			FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus")))
		elseif C["unitframes"].focus.tsHealth == "XX/XX" then
			FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus")).." / "..(UnitHealthMax("focus")))
		elseif C["unitframes"].focus.tsHealth == "XX (%)" then
			FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus"))..' ('..(floor(((UnitHealth("focus"))/(UnitHealthMax("focus")))*100))..'%)')
		elseif C["unitframes"].focus.tsHealth == "XX/XX (%)" then
			FocusFrameHealthBar.TextString:SetText(AbbreviateLargeNumbers(UnitHealth("focus")).." / "..(UnitHealthMax("focus"))..' ('..(floor(((UnitHealth("focus"))/(UnitHealthMax("focus")))*100))..'%)')
		end
		FocusFrameHealthBar.TextString:SetFont(C['media'].font, C["unitframes"].focus.hfSize, "OUTLINE")

		-- focus Manabar Font Formating
		if C["unitframes"].focus.tsMana == "XX" then
			FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")))
		elseif C["unitframes"].focus.tsMana == "XX/XX" then
			FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")).." / "..(UnitManaMax("focus")))
		elseif C["unitframes"].focus.tsMana == "XX (%)" then
			FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus"))..' ('..(floor(((UnitMana("focus"))/(UnitManaMax("focus")))*100))..'%)')
		elseif C["unitframes"].focus.tsMana == "XX/XX (%)" then
			FocusFrameManaBar.TextString:SetText(AbbreviateLargeNumbers(UnitMana("focus")).." / "..(UnitManaMax("focus"))..' ('..(floor(((UnitMana("focus"))/(UnitManaMax("focus")))*100))..'%)')
		end		
		FocusFrameManaBar.TextString:SetFont(C['media'].font, C["unitframes"].focus.mfSize, "OUTLINE")		
	end)
end



-- Party Frames --

-- Clear all old settings
PartyMemberFrame1:ClearAllPoints()
PartyMemberFrame2:ClearAllPoints()
PartyMemberFrame3:ClearAllPoints()
PartyMemberFrame4:ClearAllPoints()

-- Create new locations
PartyMemberFrame1:SetPoint(C['unitframes'].party.position.relAnchor, UIParent, C['unitframes'].party.position.offSetX, C['unitframes'].party.position.offSetY)
PartyMemberFrame2:SetPoint("TOPLEFT", PartyMemberFrame1, 0, -75)
PartyMemberFrame3:SetPoint("TOPLEFT", PartyMemberFrame2, 0, -75)
PartyMemberFrame4:SetPoint("TOPLEFT", PartyMemberFrame3, 0, -75)

-- Make the new locations stay
PartyMemberFrame1.SetPoint = function() end
PartyMemberFrame2.SetPoint = function() end
PartyMemberFrame3.SetPoint = function() end
PartyMemberFrame4.SetPoint = function() end

-- Set the scale of all the frames
PartyMemberFrame1:SetScale(C["unitframes"].party.scale)
PartyMemberFrame2:SetScale(C["unitframes"].party.scale)
PartyMemberFrame3:SetScale(C["unitframes"].party.scale)
PartyMemberFrame4:SetScale(C["unitframes"].party.scale)


 -- Arena Frames
 
LoadAddOn("Blizzard_ArenaUI") -- You only need to run this once. You can safely delete any copies of this line.
 
ArenaEnemyFrames:SetScale(C["unitframes"].arena.scale)

if C["unitframes"].arena.tracker == true then
	trinkets = {}
	local arenaFrame,trinket
	for i = 1, 5 do
		arenaFrame = "ArenaEnemyFrame"..i
        trinket = CreateFrame("Cooldown", arenaFrame.."Trinket", ArenaEnemyFrames)
        trinket:SetPoint("TOPRIGHT", arenaFrame, 30, -6)
        trinket:SetSize(24, 24)
        trinket.icon = trinket:CreateTexture(nil, "BACKGROUND")
        trinket.icon:SetAllPoints()
        trinket.icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_01")
        trinket:Hide()
        trinkets["arena"..i] = trinket
	end
	local events = CreateFrame("Frame")
	function events:UNIT_SPELLCAST_SUCCEEDED(unitID, spell, rank, lineID, spellID)
		if not trinkets[unitID] then
			return
		end        
		if spellID == 59752 or spellID == 42292 then
			CooldownFrame_SetTimer(trinkets[unitID], GetTime(), 120, 1)
			SendChatMessage("Trinket used by: "..GetUnitName(unitID, true), "PARTY")
		end
	end
	function events:PLAYER_ENTERING_WORLD()
		local _, instanceType = IsInInstance()
		if instanceType == "arena" then
			self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		elseif self:IsEventRegistered("UNIT_SPELLCAST_SUCCEEDED") then
			self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED") 
			for _, trinket in pairs(trinkets) do
				trinket:SetCooldown(0, 0)
				trinket:Hide()
            end        
		end
	end
	events:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end)
	events:RegisterEvent("PLAYER_ENTERING_WORLD")
end
 

 -- Boss Frames
for i = 1,4 do
	local boss = _G["Boss"..i.."TargetFrame"]
	if boss then
		boss:SetScale(C["unitframes"].boss.scale)
		boss:ClearAllPoints()
		boss:SetPoint(C['unitframes'].boss.position.relAnchor, UIParent, C['unitframes'].boss.position.offSetX, C['unitframes'].boss.position.offSetY)
		boss.ClearAllPoints = UF
		boss.SetPoint = UF		
	end
end


local UnitFromFrame = {
  ["PetFrame"] = "pet",
  ["PartyMemberFrame1"] = "party1",
  ["PartyMemberFrame2"] = "party2",
  ["PartyMemberFrame3"] = "party3",
  ["PartyMemberFrame4"] = "party4",
  ["PartyMemberFrame1PetFrame"] = "party1pet",
  ["PartyMemberFrame2PetFrame"] = "party2pet",
  ["PartyMemberFrame3PetFrame"] = "party3pet",
  ["PartyMemberFrame4PetFrame"] = "party4pet",
  ["ArenaEnemyFrame1"] = "arena1",
  ["ArenaEnemyFrame2"] = "arena2",
  ["ArenaEnemyFrame3"] = "arena3",
  ["ArenaEnemyFrame4"] = "arena4",
  ["ArenaEnemyFrame5"] = "arena5",
  ["ArenaEnemyFrame1PetFrame"] = "arena1pet",
  ["ArenaEnemyFrame2PetFrame"] = "arena2pet",
  ["ArenaEnemyFrame3PetFrame"] = "arena3pet",
  ["ArenaEnemyFrame4PetFrame"] = "arena4pet",
  ["ArenaEnemyFrame5PetFrame"] = "arena5pet",
  ["Boss1TargetFrame"] = "boss1",
  ["Boss2TargetFrame"] = "boss2",
  ["Boss3TargetFrame"] = "boss3",
  ["Boss4TargetFrame"] = "boss4",
 }
 
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", function(Frame)
	if not UnitFromFrame[Frame:GetParent():GetName()] then return end
	local Unit = UnitFromFrame[Frame:GetParent():GetName()]
	Frame.TextString:SetText(AbbreviateLargeNumbers(UnitPower(Unit)))
	if Frame:GetName():find("Health") then
		Frame.TextString:SetText(AbbreviateLargeNumbers(UnitHealth(Unit)))	
	end
	if Frame:GetName():find("Mana") then
		Frame.TextString:SetText(AbbreviateLargeNumbers(UnitMana(Unit)))
	end

	Frame.TextString:SetFont(C['media'].font, C["unitframes"].pppaapb, "OUTLINE")
end)

-- Disable healing/damage spam over player/pet frame:
PlayerHitIndicator:SetText(nil)
PlayerHitIndicator.SetText = function() end
PetHitIndicator:SetText(nil)
PetHitIndicator.SetText = function() end
