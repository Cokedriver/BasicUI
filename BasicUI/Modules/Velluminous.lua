local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Velluminous = BasicUI:NewModule("Velluminous", "AceEvent-3.0")

-----------------
-- Velluminous --
-----------------
function BasicUI_Velluminous:OnEnable()
	local db = BasicUI.db.profile
	
	if db.misc.vellum then
		if not TradeSkillFrame then
			print("What the fuck?  Velluminous cannot initialize.  BAIL!  BAIL!  BAIL!")
			return
		end


		local butt = CreateFrame("Button", nil, TradeSkillCreateButton, "SecureActionButtonTemplate")
		butt:SetAttribute("type", "macro")
		butt:SetAttribute("macrotext", "/click TradeSkillCreateButton\n/use item:38682")

		butt:SetText("Vellum")

		butt:SetPoint("RIGHT", TradeSkillCreateButton, "LEFT")

		butt:SetWidth(80) butt:SetHeight(22)

		-- Fonts --
		butt:SetDisabledFontObject(GameFontDisable)
		butt:SetHighlightFontObject(GameFontHighlight)
		butt:SetNormalFontObject(GameFontNormal)

		-- Textures --
		butt:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up")
		butt:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down")
		butt:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
		butt:SetDisabledTexture("Interface\\Buttons\\UI-Panel-Button-Disabled")
		butt:GetNormalTexture():SetTexCoord(0, 0.625, 0, 0.6875)
		butt:GetPushedTexture():SetTexCoord(0, 0.625, 0, 0.6875)
		butt:GetHighlightTexture():SetTexCoord(0, 0.625, 0, 0.6875)
		butt:GetDisabledTexture():SetTexCoord(0, 0.625, 0, 0.6875)
		butt:GetHighlightTexture():SetBlendMode("ADD")

		local hider = CreateFrame("Frame", nil, TradeSkillCreateAllButton)
		hider:SetScript("OnShow", function() butt:Hide() end)
		hider:SetScript("OnHide", function() butt:Show() end)
	end
end