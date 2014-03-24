local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Unitframes = BasicUI:NewModule("Unitframes", "AceEvent-3.0")

----------------
-- Unitframes --
----------------
function BasicUI_Unitframes:OnEnable()
	local db = BasicUI.db.profile
	
	-- Player Frame
	if db.unitframes.player.enable then
		if PlayerFrame then
			PlayerFrame:SetScale(db.unitframes.player.scale);
			PlayerFrameHealthBarText:SetFont(db.fontNormal, db.unitframes.player.fontSize,"THINOUTLINE");
			PlayerFrameManaBarText:SetFont(db.fontNormal, db.unitframes.player.fontSize, "THINOUTLINE");
			PlayerFrameAlternateManaBarText:SetFont(db.fontNormal, db.unitframes.player.fontSize, "THINOUTLINE");
			PetFrameHealthBarText:SetFont(db.fontNormal, db.unitframes.player.fontSizepet,"THINOUTLINE");
			PetFrameManaBarText:SetFont(db.fontNormal, db.unitframes.player.fontSizepet, "THINOUTLINE");
		end
	end

	-- Target Frame
	if db.unitframes.target.enable then
		if TargetFrame then
			TargetFrame:SetScale(db.unitframes.target.scale);
			TargetFrameTextureFrameHealthBarText:SetFont(db.fontNormal, db.unitframes.target.fontSize, "THINOUTLINE");
			TargetFrameTextureFrameManaBarText:SetFont(db.fontNormal, db.unitframes.target.fontSize, "THINOUTLINE");		
		end;
	end;

	-- Focus Frame
	if db.unitframes.focus.enable then
		if FocusFrame then
			FocusFrame:SetScale(db.unitframes.focus.scale)
			FocusFrameTextureFrameHealthBarText:SetFont(db.fontNormal, db.unitframes.focus.fontSize,"THINOUTLINE")
			FocusFrameTextureFrameManaBarText:SetFont(db.fontNormal, db.unitframes.focus.fontSize,"THINOUTLINE")		
		end;
	end;


	-- Party Frames --
	if db.unitframes.party.enable then
		for i = 1, MAX_PARTY_MEMBERS do
			local partyFrame = "PartyMemberFrame"..i
			_G[partyFrame]:SetScale(db.unitframes.party.scale);
			_G[partyFrame.."HealthBarText"]:SetFont(db.fontNormal, db.unitframes.party.fontSize, "THINOUTLINE");
			_G[partyFrame.."ManaBarText"]:SetFont(db.fontNormal, db.unitframes.party.fontSize, "THINOUTLINE");		
		end
		
	end;

	 -- Arena Frames
	if db.unitframes.arena.enable then
		hooksecurefunc("Arena_LoadUI", function()
			for i = 1, MAX_ARENA_ENEMIES do
				arenaFrame = "ArenaEnemyFrame"..i
				_G[arenaFrame]:SetScale(db.unitframes.arena.scale);
				_G[arenaFrame.."HealthBarText"]:SetFont(db.fontNormal, db.unitframes.arena.fontSize,"THINOUTLINE");
				_G[arenaFrame.."ManaBarText"]:SetFont(db.fontNormal, db.unitframes.arena.fontSize, "THINOUTLINE");
			end
		end)	
	end;

	 -- Boss Frames
	if db.unitframes.boss.enable then
		for i = 1, MAX_BOSS_FRAMES do
			local bossFrame = "Boss"..i.."TargetFrame"
			_G[bossFrame]:SetScale(db.unitframes.boss.scale);	
		end;	
	end;

	-- Font Style / Color thanks to Phanx from WoWinterface.

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
	hooksecurefunc("UnitFrame_Update", function(self)
		if not self.name then return end
		
		local PET_COLOR = { r = 157/255, g = 197/255, b = 255/255 }
		local unit, color = self.unit
		if UnitPlayerControlled(unit) then
			if UnitIsPlayer(unit) then
				local _, class = UnitClass(unit)
				color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
			else
				color = PET_COLOR
			end
		elseif UnitIsDead(unit) or UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) then
			color = GRAY_FONT_COLOR
		else
			color = FACTION_BAR_COLORS[UnitIsEnemy(unit, "player") and 1 or UnitReaction(unit, "player") or 5]
		end
	 
		if not color then
			color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)["PRIEST"]
		end
	 
		self.name:SetTextColor(color.r, color.g, color.b)
	end)

	local frame = CreateFrame("FRAME")
	frame:RegisterEvent("GROUP_ROSTER_UPDATE")
	frame:RegisterEvent("PLAYER_TARGET_CHANGED")
	frame:RegisterEvent("PLAYER_FOCUS_CHANGED")
	frame:RegisterEvent("UNIT_FACTION")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")

	local unitRegions = {
		target = TargetFrameNameBackground,
		focus = FocusFrameNameBackground,
		boss1 = Boss1TargetFrameNameBackground,
		boss2 = Boss2TargetFrameNameBackground,
		boss3 = Boss3TargetFrameNameBackground,
		boss4 = Boss4TargetFrameNameBackground,	
	}

	frame:SetScript("OnEvent", function(self, event, ...)
		for unit, region in pairs(unitRegions) do
			if UnitIsPlayer(unit) then
				region:SetTexture('Interface\\DialogFrame\\UI-DialogBox-Background')
			end
		end
	end)

	-- Disable healing/damage spam over player/pet frame:
	PlayerHitIndicator:SetText(nil)
	PlayerHitIndicator.SetText = function() end
	PetHitIndicator:SetText(nil)
	PetHitIndicator.SetText = function() end
end