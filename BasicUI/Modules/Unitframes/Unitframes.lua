local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C["unitframes"].enable ~= true then return end


-- Special Thanks to the guys over at Arena Junkies for most of these scripts
-- http://www.arenajunkies.com/topic/222642-default-ui-scripts/

local _G = _G


-- Player Frame
if C["unitframes"].player.enable then

	-- Frame Scale
	_G["PlayerFrame"]:SetScale(C["unitframes"].player.scale);	
	PlayerFrameHealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].player.fontSize,"THINOUTLINE");
	PlayerFrameManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].player.fontSize, "THINOUTLINE");
	PlayerFrameAlternateManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].player.fontSize, "THINOUTLINE");
	PetFrameHealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].player.fontSizepet,"THINOUTLINE");
	PetFrameManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].player.fontSizepet, "THINOUTLINE");

end

-- Target Frame
if C["unitframes"].target.enable then

	-- Frame Scale
	 _G["TargetFrame"]:SetScale(C["unitframes"].target.scale);
 	TargetFrameTextureFrameHealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].target.fontSize, "THINOUTLINE");
	TargetFrameTextureFrameManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].target.fontSize, "THINOUTLINE");

end;

-- Focus Frame
if C["unitframes"].focus.enable then

	-- Frame Scale
	 _G["FocusFrame"]:SetScale(C["unitframes"].focus.scale)
	FocusFrameTextureFrameHealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].focus.fontSize,"THINOUTLINE")
	FocusFrameTextureFrameManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].focus.fontSize,"THINOUTLINE")

end;


-- Party Frames --
if C["unitframes"].party.enable then

	-- Clear all old settings
	PartyMemberFrame1:ClearAllPoints();
	PartyMemberFrame2:ClearAllPoints();
	PartyMemberFrame3:ClearAllPoints();
	PartyMemberFrame4:ClearAllPoints();

	-- Create new locations
	PartyMemberFrame1:SetPoint(C['unitframes'].party.position.relAnchor, UIParent, C['unitframes'].party.position.offSetX, C['unitframes'].party.position.offSetY);
	PartyMemberFrame2:SetPoint("TOPLEFT", PartyMemberFrame1, 0, -75);
	PartyMemberFrame3:SetPoint("TOPLEFT", PartyMemberFrame2, 0, -75);
	PartyMemberFrame4:SetPoint("TOPLEFT", PartyMemberFrame3, 0, -75);

	-- Make the new locations stay
	PartyMemberFrame1.SetPoint = function() end;
	PartyMemberFrame2.SetPoint = function() end;
	PartyMemberFrame3.SetPoint = function() end;
	PartyMemberFrame4.SetPoint = function() end;

	-- Set the scale of all the frames
	PartyMemberFrame1:SetScale(C["unitframes"].party.scale);
	PartyMemberFrame2:SetScale(C["unitframes"].party.scale);
	PartyMemberFrame3:SetScale(C["unitframes"].party.scale);
	PartyMemberFrame4:SetScale(C["unitframes"].party.scale);
	
	-- Set Font Size
	PartyMemberFrame1HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].party.fontSize, "THINOUTLINE")
	PartyMemberFrame1ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].party.fontSize, "THINOUTLINE")
	PartyMemberFrame2HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].party.fontSize, "THINOUTLINE")
	PartyMemberFrame2ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].party.fontSize, "THINOUTLINE")
	PartyMemberFrame3HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].party.fontSize, "THINOUTLINE")
	PartyMemberFrame3ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].party.fontSize, "THINOUTLINE")
	PartyMemberFrame4HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].party.fontSize, "THINOUTLINE")
	PartyMemberFrame4ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].party.fontSize, "THINOUTLINE")
end;

 -- Arena Frames
if C["unitframes"].arena.enable then
	LoadAddOn("Blizzard_ArenaUI"); -- You only need to run this once. You can safely delete any copies of this line.
	 
	ArenaEnemyFrames:SetScale(C["unitframes"].arena.scale);
	
	ArenaEnemyFrame1HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize,"THINOUTLINE");
	ArenaEnemyFrame1ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize, "THINOUTLINE");
	ArenaEnemyFrame2HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize,"THINOUTLINE");
	ArenaEnemyFrame2ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize, "THINOUTLINE");
	ArenaEnemyFrame3HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize,"THINOUTLINE");
	ArenaEnemyFrame3ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize, "THINOUTLINE");
	ArenaEnemyFrame4HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize,"THINOUTLINE");
	ArenaEnemyFrame4ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize, "THINOUTLINE");
	ArenaEnemyFrame5HealthBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize,"THINOUTLINE");
	ArenaEnemyFrame5ManaBarText:SetFont(C['media'].fontNormal, C["unitframes"].arena.fontSize, "THINOUTLINE");


	if C["unitframes"].arena.tracker == true then
		trinkets = {};
		local arenaFrame,trinket;
		for i = 1, 5 do
			arenaFrame = "ArenaEnemyFrame"..i;
			trinket = CreateFrame("Cooldown", arenaFrame.."Trinket", ArenaEnemyFrames);
			trinket:SetPoint("TOPRIGHT", arenaFrame, 30, -6);
			trinket:SetSize(24, 24);
			trinket.icon = trinket:CreateTexture(nil, "BACKGROUND");
			trinket.icon:SetAllPoints();
			trinket.icon:SetTexture("Interface\\Icons\\inv_jewelry_trinketpvp_01");
			trinket:Hide();
			trinkets["arena"..i] = trinket;
		end;
		local events = CreateFrame("Frame");
		function events:UNIT_SPELLCAST_SUCCEEDED(unitID, spell, rank, lineID, spellID)
			if not trinkets[unitID] then
				return;
			end ;       
			if spellID == 59752 or spellID == 42292 then
				CooldownFrame_SetTimer(trinkets[unitID], GetTime(), 120, 1);
				SendChatMessage("Trinket used by: "..GetUnitName(unitID, true), "PARTY");
			end;
		end;
		function events:PLAYER_ENTERING_WORLD()
			local _, instanceType = IsInInstance();
			if instanceType == "arena" then
				self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
			elseif self:IsEventRegistered("UNIT_SPELLCAST_SUCCEEDED") then
				self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED"); 
				for _, trinket in pairs(trinkets) do
					trinket:SetCooldown(0, 0);
					trinket:Hide();
				end;        
			end;
		end;
		events:SetScript("OnEvent", function(self, event, ...) return self[event](self, ...) end);
		events:RegisterEvent("PLAYER_ENTERING_WORLD");
	end;
end;

 -- Boss Frames
if C["unitframes"].boss.enable then
	for i = 1,4 do
		local boss = _G["Boss"..i.."TargetFrame"];
		if boss then
			boss:SetScale(C["unitframes"].boss.scale)
			boss:ClearAllPoints();
			boss:SetPoint(C['unitframes'].boss.position.relAnchor, UIParent, C['unitframes'].boss.position.offSetX, C['unitframes'].boss.position.offSetY);
			boss.ClearAllPoints = function() end;
			boss.SetPoint = function() end;		
		end;
	end;
end;

-- Font Style thanks to Phanx from WoWinterface.
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
				return fontString:SetFormattedText(t[3], value / t[2])				
			end
		end
	end
end)

hooksecurefunc("UnitFrame_Update", function(self)
    if not self.name then return end

    local unit, color = self.unit
    if UnitPlayerControlled(unit) then
        if UnitIsPlayer(unit) then
            local _, class = UnitClass(unit)
            color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
        else
            color = HIGHLIGHT_FONT_COLOR
        end
    elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
        color = GRAY_FONT_COLOR
    else
        color = FACTION_BAR_COLORS[UnitIsEnemy(unit, "player") and 1 or UnitReaction(unit, "player") or 5]
    end
 
    if not color then
        color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)["PRIEST"]
    end
 
    self.name:SetTextColor(color.r, color.g, color.b)
end)


-- Disable healing/damage spam over player/pet frame:
PlayerHitIndicator:SetText(nil)
PlayerHitIndicator.SetText = function() end
PetHitIndicator:SetText(nil)
PetHitIndicator.SetText = function() end
