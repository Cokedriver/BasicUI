----------------------------------
--      WoWPro_Widgets.lua      --
----------------------------------

function WoWPro:CreateCheck(parent)
	local check = CreateFrame("CheckButton", nil, parent)
	check:RegisterForClicks("AnyUp")
	check:SetPoint("TOPLEFT")
	check:SetWidth(15)
	check:SetHeight(15)
	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
	check:Hide()
	
	return check
end

function WoWPro:CreateAction(parent, anchor)
	local action = parent:CreateTexture()
	action:SetPoint("LEFT", anchor, "RIGHT", 3, 0)
	action:SetWidth(15)
	action:SetHeight(15)
	
	return action
end
	
function WoWPro:CreateStep(parent, anchor)
	local step = parent:CreateFontString(nil, nil, "GameFontHighlight")
	step:SetPoint("LEFT", anchor, "RIGHT", 3, 0)
	step:SetPoint("RIGHT")
	step:SetJustifyH("LEFT")
	
	return step
end

function WoWPro:CreateNote(parent, anchor1)
	local note = parent:CreateFontString(nil, nil, "GameFontNormalSmall")
	note:SetPoint("TOPLEFT", anchor1, "BOTTOMLEFT", 0, -3)
	note:SetPoint("RIGHT")
	note:SetJustifyH("LEFT")
	note:SetJustifyV("TOP")
	
	return note
end

function WoWPro:CreateTrack(parent, anchor1)
	local track = parent:CreateFontString(nil, nil, "GameFontNormalSmall")
	track:SetPoint("TOPLEFT", anchor1, "BOTTOMLEFT", 0, -3)
	track:SetPoint("RIGHT")
	track:SetJustifyH("LEFT")
	track:SetJustifyV("TOP")
	
	return track
end

function WoWPro:CreateItemButton(parent, id)
	local itembutton = CreateFrame("Button", "WoWPro_itembutton"..id, parent, "SecureActionButtonTemplate")
	itembutton:SetAttribute("type", "item")
	itembutton:SetFrameStrata("LOW")
	itembutton:SetHeight(20)
	itembutton:SetWidth(20)
	itembutton:SetPoint("TOPRIGHT", parent, "TOPLEFT", -10, -7)

	local cooldown = CreateFrame("Cooldown", nil, itembutton)
	cooldown:SetAllPoints(itembutton)

	local itemicon = itembutton:CreateTexture(nil, "ARTWORK")
	itemicon:SetWidth(24) itemicon:SetHeight(24)
	itemicon:SetTexture("Interface\\Icons\\INV_Misc_Bag_08")
	itemicon:SetAllPoints(itembutton)

	itembutton:RegisterForClicks("anyUp")
	itembutton:Hide()
	
	return itembutton, itemicon, cooldown
end

function WoWPro:CreateTargetButton(parent, id)
	local targetbutton = CreateFrame("Button", "WoWPro_targetbutton"..id, parent, "SecureActionButtonTemplate")
	targetbutton:SetAttribute("type", "macro")
	targetbutton:SetFrameStrata("LOW")
	targetbutton:SetHeight(20)
	targetbutton:SetWidth(20)
	targetbutton:SetPoint("TOPRIGHT", parent, "TOPLEFT", -35, -7)

	local targeticon = targetbutton:CreateTexture(nil, "ARTWORK")
	targeticon:SetWidth(24) targeticon:SetHeight(24)
	targeticon:SetTexture("Interface\\Icons\\Ability_Marksmanship")
	targeticon:SetAllPoints(targetbutton)

	targetbutton:RegisterForClicks("anyUp")
	targetbutton:Hide()
	
	return targetbutton, targeticon
end

function WoWPro:CreateHeading(parent, text, subtext)
	local title = parent:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(text)

	local subtitle = parent:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	subtitle:SetHeight(32)
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetPoint("RIGHT", parent, -32, 0)
	subtitle:SetNonSpaceWrap(true)
	subtitle:SetJustifyH("LEFT")
	subtitle:SetJustifyV("TOP")
	subtitle:SetText(subtext)

	return title, subtitle
end

function WoWPro:CreateBG(parent)
	local bg = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	}
	local box = CreateFrame('Frame', nil, parent)
	box:SetBackdrop(bg)
	box:SetBackdropBorderColor(0.4, 0.4, 0.4)
	box:SetBackdropColor(0.1, 0.1, 0.1)
	
	return box
end

function WoWPro:CreateTab(name, parent)

	local bg = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		tile = true,
		tileSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	}
	local tab = CreateFrame('Button', nil, parent)
	tab:SetBackdrop(bg)
	tab:SetBackdropColor(0.1, 0.1, 0.1, 1)
	tab:RegisterForClicks("anyUp")
	
	tab.border = tab:CreateTexture('border')
	tab.border:SetAllPoints(tab)
	tab.border:SetPoint("BOTTOM", 0, 5)
	tab.border:SetTexture("Interface\\OPTIONSFRAME\\UI-OptionsFrame-InactiveTab")
	
	tab.text = tab:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	tab.text:SetHeight(35)
	tab.text:SetPoint("TOPLEFT", tab, "TOPLEFT", 0, -3)
	tab.text:SetPoint("TOPRIGHT", tab, "TOPRIGHT", 0, -3)
	tab.text:SetJustifyH("CENTER")
	tab.text:SetText(name)
	
	tab:SetWidth(tab.text:GetWidth()+20)
	tab:SetHeight(35)
	
	return tab
end

-- Creates a scrollbar
-- Parent is required, offset and step are optional
function WoWPro:CreateScrollbar(parent, offset, step)

	local bg = {
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 12,
		insets = { left = 0, right = 0, top = 5, bottom = 5 }
	}

	local f = CreateFrame("Slider", nil, parent)
	f:SetWidth(16)

	f:SetPoint("TOPRIGHT", 0 - (offset or 0), -16 - (offset or 0))
	f:SetPoint("BOTTOMRIGHT", 0 - (offset or 0), 16 + (offset or 0))

	local up = CreateFrame("Button", nil, f)
	up:SetPoint("BOTTOM", f, "TOP")
	up:SetWidth(16) up:SetHeight(16)
	up:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up")
	up:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down")
	up:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled")
	up:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Highlight")

	up:GetNormalTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	up:GetPushedTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	up:GetDisabledTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	up:GetHighlightTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	up:GetHighlightTexture():SetBlendMode("ADD")

	up:SetScript("OnClick", function(self)
		local parent = self:GetParent()
		parent:SetValue(parent:GetValue() - (step or parent:GetHeight()/2))
		PlaySound("UChatScrollButton")
	end)

	local down = CreateFrame("Button", nil, f)
	down:SetPoint("TOP", f, "BOTTOM")
	down:SetWidth(16) down:SetHeight(16)
	down:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up")
	down:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down")
	down:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled")
	down:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Highlight")

	down:GetNormalTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	down:GetPushedTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	down:GetDisabledTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	down:GetHighlightTexture():SetTexCoord(1/4, 3/4, 1/4, 3/4)
	down:GetHighlightTexture():SetBlendMode("ADD")

	down:SetScript("OnClick", function(self)
		local parent = self:GetParent()
		parent:SetValue(parent:GetValue() + (step or parent:GetHeight()/2))
		PlaySound("UChatScrollButton")
	end)

	f:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	local thumb = f:GetThumbTexture()
	thumb:SetWidth(16) thumb:SetHeight(24)
	thumb:SetTexCoord(1/4, 3/4, 1/8, 7/8)

	f:SetScript("OnValueChanged", function(self, value)
		local min, max = self:GetMinMaxValues()
		if value == min then up:Disable() else up:Enable() end
		if value == max then down:Disable() else down:Enable() end
	end)

	local border = CreateFrame("Frame", nil, f)
	border:SetPoint("TOPLEFT", up, -5, 5)
	border:SetPoint("BOTTOMRIGHT", down, 5, -3)
	border:SetBackdrop(bg)
	border:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 0.5)

	return f, up, down, border
end
