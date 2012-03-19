local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['buff'].enable ~= true then return end

--[[

	All Credit for Buff.lua goes to Zergreth. 
	Buffy = http://www.wowinterface.com/downloads/info12859-Buffy.html.
	Edited by Cokedriver.
	
]]

local f = CreateFrame("Frame");
local match = string.match;

-- Custom Timers Duration
local timerSeconds = "%ds"; -- format for seconds
local timerMinutes = "%dm"; -- format for minutes
local timerHours   = "%dh"; -- format for hours
local timerDays    = "%dd"; -- format for days, %d is the value
local customTimers = true;  -- custom look for the buff timers, uses the above formats (true = on; false = off)

local function Buff_Event(self, event)
	-- scale and reposition!
	if event == "PLAYER_LOGIN" then
		BuffFrame:SetScale(C['buff'].scale);
		TemporaryEnchantFrame:SetScale(C['buff'].scale);
		ConsolidatedBuffs:SetScale(C['buff'].scale);
		
		-- hook the duration update function
		if customTimers then
			hooksecurefunc("AuraButton_UpdateDuration", function(button, timeLeft)
				if not timeLeft then
					return;
				end
			
				-- copied (from pre 3.3.3 UIParent.lua) and altered
				if timeLeft >= 86400 then
					timeLeft = ceil(timeLeft / 86400);
					button.duration:SetFormattedText(timerDays, timeLeft);
				elseif timeLeft >= 3600 then
					timeLeft = ceil(timeLeft / 3600);
					button.duration:SetFormattedText(timerHours, timeLeft);
				elseif timeLeft >= 60 then
					timeLeft = ceil(timeLeft / 60);
					button.duration:SetFormattedText(timerMinutes, timeLeft);
				else
					button.duration:SetFormattedText(timerSeconds, timeLeft);
				end
			end);
		end
	end
end

f:RegisterEvent("PLAYER_LOGIN");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:RegisterEvent("UNIT_AURA");

f:SetScript("OnEvent", Buff_Event);