local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_FGN = BasicUI:NewModule("FGN", "AceEvent-3.0")


function BasicUI_FGN:OnEnable()
	if (IsAddOnLoaded('Zygor Guides Viewer 4')) then return end

	local db = BasicUI.db.profile
	
	function AssignButtonTexture(obj,tx,num,total)
		self.ChainCall(obj):SetNormalTexture(CreateTexWithCoordsNum(obj,tx,num,total,1,4))
			:SetPushedTexture(CreateTexWithCoordsNum(obj,tx,num,total,2,4))
			:SetHighlightTexture(CreateTexWithCoordsNum(obj,tx,num,total,3,4))
			:SetDisabledTexture(CreateTexWithCoordsNum(obj,tx,num,total,4,4))
	end

	function self.ChainCall(obj)  local T={}  setmetatable(T,{__index=function(self,fun)  if fun=="__END" then return obj end  return function(self,...) assert(obj[fun],fun.." missing in object") obj[fun](obj,...) return self end end})  return T  end

	local flash_interval = 0.25

	local flash = nil
	local MinimapNodeFlash = function(s)
		flash = not flash
		Minimap:SetBlipTexture("Interface\\AddOns\\BasicUI\\Media\\objecticons_"..(flash and "on" or "off"))
	end

	local q = 0
	do
		local F = CreateFrame("FRAME","PointerExtraFrame")
		local ant_last=GetTime()
		local flash_last=GetTime()
		F:SetScript("OnUpdate",function(self,elapsed)
			local t=GetTime()

			-- Flashing node dots. Prettier than the standard, too. And slightly bigger.
			if db.misc.flashmapnodes then
				if t-flash_last>=flash_interval then
					MinimapNodeFlash()
					flash_last=t-(t-flash_last)%flash_interval
				end
			else
				Minimap:SetBlipTexture("Interface\\AddOns\\BasicUI\\Media\\objecticons_on")		
			end
		end)

		local CHAIN = self.ChainCall
		F:SetPoint("CENTER",UIParent)
		F:Show()
		CHAIN(F:CreateTexture("PointerDotOn","OVERLAY")) :SetTexture("Interface\\AddOns\\BasicUI\\Media\\objecticons_on") :SetSize(50,50) :SetPoint("CENTER") :SetNonBlocking(true) :Show()
		CHAIN(F:CreateTexture("PointerDotOff","OVERLAY")) :SetTexture("Interface\\AddOns\\BasicUI\\Media\\objecticons_off") :SetSize(50,50) :SetPoint("RIGHT") :SetNonBlocking(true) :Show()
	end
end