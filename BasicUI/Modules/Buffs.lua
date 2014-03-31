local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Buffs = BasicUI:NewModule("Buffs", "AceEvent-3.0")

-----------
-- Buffs --
-----------
function BasicUI_Buffs:OnEnable()	
	local db = BasicUI.db.profile
	
	if db.buff.enable ~= true then return end
	
	BuffFrame:ClearAllPoints()
	BuffFrame:SetScale(db.buff.scale)
	BuffFrame:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -25, 0)
end