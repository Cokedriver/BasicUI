local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Actionbar = BasicUI:NewModule("Actionbar", "AceEvent-3.0")

---------------
-- Actionbar --
---------------
function BasicUI_Actionbar:OnEnable()
	local db = BasicUI.db.profile
	
	if db.actionbar.enable ~= true then return end
	
	local ccolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]	
	-- Hide Keybindings
	if db.actionbar.showHotKeys ~= true then
		for i=1, 12 do        
			_G["ActionButton"..i.."HotKey"]:SetAlpha(0) -- main bar        
			_G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(0) -- bottom right bar        
			_G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(0) -- bottom left bar        
			_G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(0) -- right bar        
			_G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(0) -- left bar
		end
	end

	-- Hide Macros
	if db.actionbar.showMacronames ~= true then
		for i=1, 12 do        
			_G["ActionButton"..i.."Name"]:SetAlpha(0) -- main bar        
			_G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(0) -- bottom right bar        
			_G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(0) -- bottom left bar        
			_G["MultiBarRightButton"..i.."Name"]:SetAlpha(0) -- right bar        
			_G["MultiBarLeftButton"..i.."Name"]:SetAlpha(0) -- left bar
		end
	end

	hooksecurefunc('ActionButton_UpdateUsable', function(self)
		if (IsAddOnLoaded('RedRange') or IsAddOnLoaded('GreenRange') or IsAddOnLoaded('tullaRange') or IsAddOnLoaded('RangeColors')) then
			return
		end    
		
		local isUsable, notEnoughMana = IsUsableAction(self.action)
		if (isUsable) then
			_G[self:GetName()..'Icon']:SetVertexColor(1, 1, 1)
		elseif (notEnoughMana) then
			_G[self:GetName()..'Icon']:SetVertexColor(db.actionbar.color.OutOfMana.r,db.actionbar.color.OutOfMana.g,db.actionbar.color.OutOfMana.b)
		else
			_G[self:GetName()..'Icon']:SetVertexColor(db.actionbar.color.NotUsable.r, db.actionbar.color.NotUsable.g, db.actionbar.color.NotUsable.b)
		end
	end)

	-- BetterBlizzardButtonBorder v1.1.1
	-- By Aprikot - http://aprikot.wowinterface.com
	-- Based upon functions within nMainbar by Neal, and thek: Buttonskin by thek

	-- Functions
	hooksecurefunc("ActionButton_Update", function(self)
	if self:GetName():match("ExtraActionButton") then return end
		local bu = _G[self:GetName()]
		local ic = _G[self:GetName().."Icon"]
		local bo = _G[self:GetName().."NormalTexture"]
		bu:SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot2")
		ic:SetTexCoord(.05, .95, .05, .95);
		ic:SetPoint("TOPLEFT", bu, 0, 0);
		ic:SetPoint("BOTTOMRIGHT", bu, 0, 0);
		bo:ClearAllPoints()
		bo:SetPoint("TOPLEFT", bu, -14, 14)
		bo:SetPoint("BOTTOMRIGHT", bu, 14, -14)
		if db.misc.classcolor ~= true then
			bo:SetVertexColor(db.actionbar.color.r, db.actionbar.color.g, db.actionbar.color.b)
		else
			bo:SetVertexColor((ccolor.r * 1.2), (ccolor.g * 1.2), (ccolor.b * 1.2))
		end	
	end);

	hooksecurefunc("ActionButton_UpdateUsable", function(self)
	if self:GetName():match("ExtraActionButton") then return end
		if db.misc.classcolor ~= true then
			(_G[self:GetName().."NormalTexture"]):SetVertexColor(db.actionbar.color.r, db.actionbar.color.g, db.actionbar.color.b)
		else
			(_G[self:GetName().."NormalTexture"]):SetVertexColor((ccolor.r * 1.2), (ccolor.g * 1.2), (ccolor.b * 1.2))
		end	
	end);

	hooksecurefunc("ActionButton_ShowGrid", function(self)
	if self:GetName():match("ExtraActionButton") then return end
		if db.misc.classcolor ~= true then
			(_G[self:GetName().."NormalTexture"]):SetVertexColor(db.actionbar.color.r, db.actionbar.color.g, db.actionbar.color.b)
		else
			(_G[self:GetName().."NormalTexture"]):SetVertexColor((ccolor.r * 1.2), (ccolor.g * 1.2), (ccolor.b * 1.2))
		end	
	end);

	hooksecurefunc("PetActionBar_Update",  function()
		for i, v in pairs({"PetActionButton", "ShapeshiftButton", "PossessButton"}) do
			for i = 1, 12 do
				local bu = _G[v..i]
				if bu then
					bu:SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot2")
					local ic = _G[v..i.."Icon"];
					ic:SetTexCoord(.05, .95, .05, .95);
					ic:SetPoint("TOPLEFT", bu, -1, 1);
					ic:SetPoint("BOTTOMRIGHT", bu, 1, -1);
					local bo = _G[v..i.."NormalTexture2"] or _G[v..i.."NormalTexture"]
					bo:ClearAllPoints()
					bo:SetPoint("TOPLEFT", bu, -15, 15)
					bo:SetPoint("BOTTOMRIGHT", bu, 15, -15)
					if db.misc.classcolor ~= true then
						bo:SetVertexColor(db.actionbar.color.r, db.actionbar.color.g, db.actionbar.color.b)
					else
						bo:SetVertexColor((ccolor.r * 1.2), (ccolor.g * 1.2), (ccolor.b * 1.2))
					end					
				end
			end
		end
	end);

	hooksecurefunc("AuraButton_Update", function(self, index)
		if db.actionbar.auraborder then
			local bu = _G[self..index]
			local ic = _G[self..index.."Icon"]
			local bo = _G[self..index.."Border"]
			if ic then 
				ic:SetTexCoord(.07, .93, .07, .93);
			end
			if bo then
				bo:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
				bo:ClearAllPoints()
				bo:SetPoint("TOPLEFT", bu, -12, 12)
				bo:SetPoint("BOTTOMRIGHT", bu, 12, -12)
				bo:SetTexCoord(0, 1, 0, 1)
				if db.misc.classcolor ~= true then
					bo:SetVertexColor(db.color.r, db.color.g, db.color.b)
				else
					bo:SetVertexColor((ccolor.r * 1.2), (ccolor.g * 1.2), (ccolor.b * 1.2))
				end				
			end
			if bu and not bo then 
				nbo = bu:CreateTexture("$parentOverlay", "ARTWORK")
				nbo:SetParent(bu)
				nbo:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
				nbo:SetPoint("TOPLEFT", bu, -12, 12)
				nbo:SetPoint("BOTTOMRIGHT", bu, 12, -12)
				if db.misc.classcolor ~= true then
					nbo:SetVertexColor(db.actionbar.color.r, db.actionbar.color.g, db.actionbar.color.b)
				else
					nbo:SetVertexColor((ccolor.r * 1.2), (ccolor.g * 1.2), (ccolor.b * 1.2))
				end
			end
		end
	end);	

	function ActionButton_OnUpdate(self, elapsed)
		if (IsAddOnLoaded('RedRange') or IsAddOnLoaded('GreenRange') or IsAddOnLoaded('tullaRange') or IsAddOnLoaded('RangeColors')) then
			return
		end     

		if (ActionButton_IsFlashing(self)) then
			local flashtime = self.flashtime
			flashtime = flashtime - elapsed

			if (flashtime <= 0) then
				local overtime = - flashtime
				if (overtime >= ATTACK_BUTTON_FLASH_TIME) then
					overtime = 0
				end

				flashtime = ATTACK_BUTTON_FLASH_TIME - overtime

				local flashTexture = _G[self:GetName()..'Flash']
				if (flashTexture:IsShown()) then
					flashTexture:Hide()
				else
					flashTexture:Show()
				end
			end

			self.flashtime = flashtime
		end

		local rangeTimer = self.rangeTimer
		if (rangeTimer) then
			rangeTimer = rangeTimer - elapsed
			if (rangeTimer <= 0.1) then
				local isInRange = false
				if (ActionHasRange(self.action) and IsActionInRange(self.action) == 0) then
					_G[self:GetName()..'Icon']:SetVertexColor(db.actionbar.color.OutOfRange.r, db.actionbar.color.OutOfRange.g, db.actionbar.color.OutOfRange.b)
					isInRange = true
				end

				if (self.isInRange ~= isInRange) then
					self.isInRange = isInRange
					ActionButton_UpdateUsable(self)
				end

				rangeTimer = TOOLTIP_UPDATE_TIME
			end

			self.rangeTimer = rangeTimer
		end
	end
end