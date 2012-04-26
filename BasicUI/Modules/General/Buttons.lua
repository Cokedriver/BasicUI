local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for Buttons.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.
	
]]

if C['general'].buttons.enable == true then 

	 -- Hide Keybindings
	if C['general'].buttons.showHotKeys ~= true then
		function ActionButton_UpdateHotkeys(self, actionButtonType) end
	end
	
	if C['general'].buttons.showMacronames ~= true then
		hooksecurefunc('ActionButton_Update', function(self)
			if self.buttonType == "EXTRAACTIONBUTTON" then return end
			local macroname = _G[self:GetName()..'Name']
			if (not C['general'].buttons.showMacronames) then
				macroname:SetAlpha(0)
			end
		end)
	end

	hooksecurefunc('ActionButton_UpdateUsable', function(self)
		if (IsAddOnLoaded('RedRange') or IsAddOnLoaded('GreenRange') or IsAddOnLoaded('tullaRange') or IsAddOnLoaded('RangeColors')) then
			return
		end    
		
		local isUsable, notEnoughMana = IsUsableAction(self.action)
		if (isUsable) then
			_G[self:GetName()..'Icon']:SetVertexColor(1, 1, 1)
		elseif (notEnoughMana) then
			_G[self:GetName()..'Icon']:SetVertexColor(C['general'].buttons.color.OutOfMana.r,C['general'].buttons.color.OutOfMana.g,C['general'].buttons.color.OutOfMana.b)
		else
			_G[self:GetName()..'Icon']:SetVertexColor(C['general'].buttons.color.NotUsable.r, C['general'].buttons.color.NotUsable.g, C['general'].buttons.color.NotUsable.b)
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
		if C['general'].classcolor ~= true then
			bo:SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
		else
			bo:SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
		end	
	end);
	
	hooksecurefunc("ActionButton_UpdateUsable", function(self)
	if self:GetName():match("ExtraActionButton") then return end
		if C['general'].classcolor ~= true then
			(_G[self:GetName().."NormalTexture"]):SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
		else
			(_G[self:GetName().."NormalTexture"]):SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
		end	
	end);

	hooksecurefunc("ActionButton_ShowGrid", function(self)
	if self:GetName():match("ExtraActionButton") then return end
		if C['general'].classcolor ~= true then
			(_G[self:GetName().."NormalTexture"]):SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
		else
			(_G[self:GetName().."NormalTexture"]):SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
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
					if C['general'].classcolor ~= true then
						bo:SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
					else
						bo:SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
					end					
				end
			end
		end
	end);

	hooksecurefunc("AuraButton_Update", function(self, index)
		if C['general'].buttons.auraborder then
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
				if C['general'].classcolor ~= true then
					bo:SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
				else
					bo:SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
				end				
			end
			if bu and not bo then 
				nbo = bu:CreateTexture("$parentOverlay", "ARTWORK")
				nbo:SetParent(bu)
				nbo:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
				nbo:SetPoint("TOPLEFT", bu, -12, 12)
				nbo:SetPoint("BOTTOMRIGHT", bu, 12, -12)
				if C['general'].classcolor ~= true then
					nbo:SetVertexColor(C['general'].color.r, C['general'].color.g, C['general'].color.b)
				else
					nbo:SetVertexColor((B.ccolor.r * 1.2), (B.ccolor.g * 1.2), (B.ccolor.b * 1.2))
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
					_G[self:GetName()..'Icon']:SetVertexColor(C['general'].buttons.color.OutOfRange.r, C['general'].buttons.color.OutOfRange.g, C['general'].buttons.color.OutOfRange.b)
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