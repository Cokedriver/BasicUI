local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C["general"].scale.enable ~= true then return end

local _G = _G

_G["PlayerFrame"]:SetScale(C["general"].scale.size)
_G["TargetFrame"]:SetScale(C["general"].scale.size)
_G["FocusFrame"]:SetScale(C["general"].scale.size)
--_G["CastingBarFrame"]:SetScale(C["general"].scale.size)

 -- Party Frames
for i = 1,4 do
	local party = _G["PartyMemberFrame"..i]
	if party then
		party:SetScale(C["general"].scale.size)
	end
end

 -- Party Pet Frames
for i = 1,4 do
	local partypet = _G["PartyMemberPetFrame"..i]
	if partypet then
		partypet:SetScale(C["general"].scale.size)
	end
end

 -- Arena Frames
for i = 1,5 do
	local arena = _G["ArenaEnemyFrame"..i]
	if arena then
		arena:SetScale(C["general"].scale.size)
	end
end

 -- Boss Frames
for i = 1,4 do
	local boss = _G["BossFrame"..i]
	if boss then
		boss:SetScale(C["general"].scale.size)
	end
end