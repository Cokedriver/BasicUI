local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

if C['general'].scale.enable ~= true then return end

local _G = _G

 -- Player Frame
local player = _G['PlayerFrame']
if player then
	player:SetScale(C['general'].scale.size)
end

 -- Target Frame
local target = _G['TargetFrame']
if target then
	target:SetScale(C['general'].scale.size)
end

 -- Party Frames
for i = 1,4 do
	local party = _G['PartyMemberFrame'..i]
	if party then
		party:SetScale(C['general'].scale.size)
	end
end

 -- Focus Frame
local focus = _G['FocusFrame']
if focus then
	focus:SetScale(C['general'].scale.size)
end

 -- Arena Frames
for i = 1,2 do
	local arena = _G['ArenaEnemyFrame'..i]
	if arena then
		arena:SetScale(C['general'].scale.size)
	end
end

 -- Boss Frames
for i = 1,4 do
	local boss = _G['BossFrame'..i]
	if boss then
		boss:SetScale(C['general'].scale.size)
	end
end
	
 -- Casting Bar
local cast = _G['CastingBarFrame'] 
if cast then
	cast:SetScale(C['general'].scale.size)
end

 -- Hide Keybindings
function ActionButton_UpdateHotkeys (self, actionButtonType)
    
end

for _, button in pairs({        
    _G['PetActionButton1'],
}) do
    button:ClearAllPoints()
    button:SetPoint('BOTTOM', UIParent, -170, 105)
end