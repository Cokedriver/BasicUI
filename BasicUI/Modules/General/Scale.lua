local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C["general"].scale.enable ~= true then return end

local _G = _G

_G["PlayerFrame"]:SetScale(C["general"].scale.playerFrame)
_G["TargetFrame"]:SetScale(C["general"].scale.targetFrame)
_G["FocusFrame"]:SetScale(C["general"].scale.focusFrame)

 -- Party Frames
for i = 1,4 do
	local party = _G["PartyMemberFrame"..i]
	if party then
		party:SetScale(C["general"].scale.partyFrame)
	end
end

 -- Party Pet Frames
for i = 1,4 do
	local partypet = _G["PartyMemberPetFrame"..i]
	if partypet then
		partypet:SetScale(C["general"].scale.partypetFrame)
	end
end

 -- Arena Frames
for i = 1,5 do
	local arena = _G["ArenaEnemyFrame"..i]
	if arena then
		arena:SetScale(C["general"].scale.arenaFrame)
	end
end

 -- Boss Frames
for i = 1,4 do
	local boss = _G["Boss"..i.."TargetFrame"]
	if boss then
		boss:SetScale(C["general"].scale.bossFrame)
	end
end


--[[local function a() end 
for i=1, 4 do 
	local f = _G["Boss"..i.."TargetFrame"] 
	f:SetScript("OnShow", f.Hide) 
	f.SetScript = a f:Hide() 
end]]