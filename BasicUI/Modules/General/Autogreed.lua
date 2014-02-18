local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['general'].loot.enable ~= true then return end

--[[

	All Credit for Autogreed.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.
	
]]

local AddOn = CreateFrame('Frame')

AddOn:RegisterEvent('START_LOOT_ROLL')
AddOn:SetScript('OnEvent', function(_, _, RollID)
    local texture, name, count, quality, bindOnPickUp , canNeed, canGreed, canDisenchant = GetLootRollItemInfo(RollID)
	
	if C['general'].loot.disenchant ~= true then
	    if (quality == 2 and not bindOnPickUp) then
			RollOnLoot(RollID, canGreed and 3 or 2)
		end
	else
		if (quality == 2 and not bindOnPickUp) then
			RollOnLoot(RollID, canDisenchant and 3 or 2)
		end
	end
end)