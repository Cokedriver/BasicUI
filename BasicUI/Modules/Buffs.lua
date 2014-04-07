local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicBuffs = BasicUI:NewModule("Buffs", "AceEvent-3.0")

-----------
-- Buffs --
-----------

function BasicBuffs:UpdatePoint()
	BuffFrame:ClearAllPoints()
	BuffFrame:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -25, 0)
end

function BasicBuffs:UpdateScale()
	local db = BasicUI.db.profile
	BuffFrame:SetScale(db.buff.scale)
end

function BasicBuffs:OnEnable()	
	local db = BasicUI.db.profile	
	if db.buff.enable ~= true then return end
	self:UpdatePoint()
	self:UpdateScale()
end