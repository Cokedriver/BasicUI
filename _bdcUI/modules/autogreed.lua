local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if C.autogreed.enable ~= true then return end

--[[

	All Create for autogreed.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.
	
]]

local AddOn = CreateFrame('Frame')

AddOn:RegisterEvent('START_LOOT_ROLL')
AddOn:SetScript('OnEvent', function(_, _, RollID)
    local _, Name, _, Quality, BoP, _, _, CanDisenchant = GetLootRollItemInfo(RollID)
    if (Quality == 2 and not BoP) then
        RollOnLoot(RollID, CanDisenchant and 3 or 2)
    end
end)