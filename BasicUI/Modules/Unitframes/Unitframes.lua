local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C["unitframes"].enable ~= true then return end

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



 -- Party Frames
for i = 1,4 do
	local party = _G["PartyMemberFrame"..i]
	if party then
		party:SetScale(C["unitframes"].party.scale)	
		party:ClearAllPoints()
		party:SetPoint(C['unitframes'].party.position.relAnchor, "UIParent", C['unitframes'].party.position.offSetX, C['unitframes'].party.position.offSetY)

	end
end

 -- Party Pet Frames
for i = 1,4 do
	local partypet = _G["PartyMemberPetFrame"..i]
	if partypet then
		partypet:SetScale(C["unitframes"].party.petScale)
	end
end

 -- Arena Frames
for i = 1,5 do
	local arena = _G["ArenaEnemyFrame"..i]
	if arena then
		arena:SetScale(C["unitframes"].arena.scale)
		arena:ClearAllPoints()
		arena:SetPoint(C['unitframes'].arena.position.relAnchor, "UIParent", C['unitframes'].arena.position.selfAnchor, C['unitframes'].arena.position.offSetX, C['unitframes'].arena.position.offSetY)
		arena.ClearAllPoints = UF
		arena.SetPoint = UF		
	end
end

 -- Boss Frames
for i = 1,4 do
	local boss = _G["Boss"..i.."TargetFrame"]
	if boss then
		boss:SetScale(C["unitframes"].boss.scale)
		boss:ClearAllPoints()
		boss:SetPoint(C['unitframes'].boss.position.relAnchor, "UIParent", C['unitframes'].boss.position.selfAnchor, C['unitframes'].boss.position.offSetX, C['unitframes'].boss.position.offSetY)
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
