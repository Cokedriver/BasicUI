local _, bc = ...
local cfg = bc.config

if cfg.castbar.enable ~= true then return end

--[[

	All Create for castbar.lua goes to Esamynn.
	Casting Bar Timer = http://www.wowinterface.com/downloads/info4572-CastingBarTimer.html.
	Edited by Cokedriver.
	
]]


CastingBarTimer_DisplayString = " (%0.1fs)";

local eventFrame = CreateFrame("Frame");
eventFrame:Hide();
eventFrame.castingInfo = {};
eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
eventFrame:RegisterEvent("UNIT_SPELLCAST_START");
eventFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
eventFrame:RegisterEvent("UNIT_SPELLCAST_STOP");
eventFrame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");

eventFrame:SetScript("OnEvent",
	function( self, event, arg1 )
		if ( event == "UNIT_SPELLCAST_START" ) then
			local _, _, text = UnitCastingInfo(arg1);
			self.castingInfo[arg1] = text..CastingBarTimer_DisplayString;
		
		elseif ( event == "UNIT_SPELLCAST_CHANNEL_START" ) then
			local _, _, text = UnitChannelInfo(arg1);
			self.castingInfo[arg1] = text..CastingBarTimer_DisplayString;
		
		elseif ( event == "PLAYER_TARGET_CHANGED" ) then
			local _, _, text = UnitCastingInfo("target");
			if not ( text ) then
				_, _, text = UnitChannelInfo("target");
			end
			if ( text ) then
				self.castingInfo["target"] = text..CastingBarTimer_DisplayString;
			else
				self.castingInfo["target"] = nil;
			end
		
		else
			self.castingInfo[arg1] = nil;
		end
	end
);


local OLD_CastingBarFrame_OnUpdate = CastingBarFrame_OnUpdate;
function CastingBarFrame_OnUpdate(self, ... )
  OLD_CastingBarFrame_OnUpdate(self, ...);
	
	local timeLeft = nil;
	if ( self.casting ) then
		timeLeft = self.maxValue - self:GetValue();
	
	elseif ( self.channeling ) then
		timeLeft = self.duration + self:GetValue() - self.endTime;
	
	end
	if ( timeLeft ) then
		local textDisplay = getglobal(self:GetName().."Text")
		timeleft = (timeLeft < 0.1) and 0.01 or timeLeft;
		local displayName = eventFrame.castingInfo[self.unit];
		if not ( displayName ) then
			local _, text;
			if ( self.casting ) then
				_, _, text = UnitCastingInfo(self.unit);
			elseif ( self.channeling ) then
				_, _, text = UnitChannelInfo(self.unit);
			end
			if ( text ) then
				displayName = text..CastingBarTimer_DisplayString;
				eventFrame.castingInfo[self.unit] = displayName;
			else
				displayName = (textDisplay:GetText() or "")..CastingBarTimer_DisplayString;
			end
		end
		textDisplay:SetText( format(displayName, timeLeft) );
	end
end