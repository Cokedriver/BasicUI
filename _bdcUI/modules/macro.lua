local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if C.macro.enable ~= true then return end

--[[

	All Create for macro.lua goes to nightcracker.
	ncBiggerMacros = http://www.wowinterface.com/downloads/info16503-ncBiggerMacros.html
	Edited by Cokedriver.
	
]]

local function setbody(index, body)
	if InCombatLockdown() then return end

	local button = _G["ExtraMacros"..index] or CreateFrame("Button", "ExtraMacros"..index, nil, "SecureActionButtonTemplate")
	button:SetAttribute("type", "macro")
	button:SetAttribute("macrotext", body)
end

local function new()
	if InCombatLockdown() then return end

	local index = 1

	if MacroPopupFrame.mode == "new" then
		index = CreateMacro(MacroPopupEditBox:GetText(), MacroPopupFrame.selectedIcon, nil, MacroFrame.macroBase > 0)
		local global, perchar = GetNumMacros()
		if MacroFrame.macroBase == 0 then
			for i = global - 1, index, -1 do
				bdcUI[i + 1] = bdcUI[i]
			end
			bdcUI[index] = nil
		else
			for i = perchar + 36 - 1, index, -1 do
				bdcUIPerCharacter[i + 1] = bdcUIPerCharacter[i]
			end
			bdcUIPerCharacter[index] = nil
		end
	elseif MacroPopupFrame.mode == "edit" then
		index = EditMacro(MacroFrame.selectedMacro, MacroPopupEditBox:GetText(), MacroPopupFrame.selectedIcon)
	end
	MacroPopupFrame:Hide()
	MacroFrame_SelectMacro(index)
	MacroFrame_Update()
end

local function save()
	if InCombatLockdown() then return end

	if MacroFrame.textChanged and MacroFrame.selectedMacro then
		local body = MacroFrameText:GetText()

		if body:len() < 256 then
			if MacroFrame.macroBase == 0 then
				bdcUI[MacroFrame.selectedMacro] = nil
			else
				bdcUIPerCharacter[MacroFrame.selectedMacro] = nil
			end

			EditMacro(MacroFrame.selectedMacro, nil, nil, body)
		else
			if MacroFrame.macroBase == 0 then
				bdcUI[MacroFrame.selectedMacro] = body
			else
				bdcUIPerCharacter[MacroFrame.selectedMacro] = body
			end

			EditMacro(MacroFrame.selectedMacro, nil, nil, "/click ExtraMacros"..MacroFrame.selectedMacro)
			setbody(MacroFrame.selectedMacro, body)
		 end

		MacroFrame.textChanged = nil
	end
end

local function delete()
	if InCombatLockdown() then return end

	local selectedMacro = MacroFrame.selectedMacro
	local global, perchar = GetNumMacros()

	DeleteMacro(selectedMacro)
	
	if MacroFrame.macroBase == 0 then
		for i = selectedMacro, 35 do
			bdcUI[i] = bdcUI[i + 1]
			if bdcUI[i] then
				EditMacro(i, nil, nil, "/click ExtraMacros"..i)
			end
		end
		bdcUI[global] = nil
	else
		for i = selectedMacro, 71 do
			bdcUIPerCharacter[i] = bdcUIPerCharacter[i + 1]
			if bdcUIPerCharacter[i] then
				EditMacro(i, nil, nil, "/click ExtraMacros"..i)
			end
		end
		bdcUIPerCharacter[perchar] = nil
	end

	-- the order of the return values (account macros, character macros) matches up with the IDs of the tabs
	local numMacros = select(PanelTemplates_GetSelectedTab(MacroFrame), GetNumMacros())
	if selectedMacro > numMacros + MacroFrame.macroBase then
		selectedMacro = selectedMacro - 1
	end

	if selectedMacro <= MacroFrame.macroBase then
		MacroFrame.selectedMacro = nil
	else
		MacroFrame.selectedMacro = selectedMacro
	end
	MacroFrame_Update()
	MacroFrameText:ClearFocus()
end

local function update()
	local numMacros
	local numAccountMacros, numCharacterMacros = GetNumMacros()
	local macroButtonName, macroButton, macroIcon, macroName
	local name, texture, body
	local selectedName, selectedBody, selectedIcon
 
	if MacroFrame.macroBase == 0 then
		numMacros = numAccountMacros
	else
		numMacros = numCharacterMacros
	end
 
	-- Macro List
	local maxMacroButtons = max(MAX_ACCOUNT_MACROS, MAX_CHARACTER_MACROS)
	for i=1, maxMacroButtons do
		macroButtonName = "MacroButton"..i
		macroButton = _G[macroButtonName]
		macroIcon = _G[macroButtonName.."Icon"]
		macroName = _G[macroButtonName.."Name"]
		if i <= MacroFrame.macroMax then
			if i <= numMacros then
				name, texture, body = GetMacroInfo(MacroFrame.macroBase + i)
				body = MacroFrame.macroBase==0 and bdcUI[i] or MacroFrame.macroBase==36 and bdcUIPerCharacter[36 + i] or body -- load macro from database
				macroIcon:SetTexture(texture)
				macroName:SetText(name)
				macroButton:Enable()
				-- Highlight Selected Macro
				if MacroFrame.selectedMacro and i == (MacroFrame.selectedMacro - MacroFrame.macroBase) then
					macroButton:SetChecked(1)
					MacroFrameSelectedMacroName:SetText(name)
					MacroFrameText:SetText(body)
					MacroFrameSelectedMacroButton:SetID(i)
					MacroFrameSelectedMacroButtonIcon:SetTexture(texture)
					MacroPopupFrame.selectedIconTexture = texture
				else
					macroButton:SetChecked(0)
				end
			else
				macroButton:SetChecked(0)
				macroIcon:SetTexture("")
				macroName:SetText("")
				macroButton:Disable()
			end
			macroButton:Show()
		else
			macroButton:Hide()
		end
	end
 
	-- Macro Details
	if MacroFrame.selectedMacro ~= nil then
		MacroFrame_ShowDetails()
		MacroDeleteButton:Enable()
	else
		MacroFrame_HideDetails()
		MacroDeleteButton:Disable()
	end
	 
	--Update New Button
	if numMacros < MacroFrame.macroMax then
		MacroNewButton:Enable()
	else
		MacroNewButton:Disable()
	end
 
	-- Disable Buttons
	if MacroPopupFrame:IsShown() then
		MacroEditButton:Disable()
		MacroDeleteButton:Disable()
	else
		MacroEditButton:Enable()
		MacroDeleteButton:Enable()
	end
 
	if not MacroFrame.selectedMacro then
		MacroDeleteButton:Disable()
	end
end

local holder = CreateFrame("Frame")
holder:RegisterEvent("ADDON_LOADED")
holder:SetScript("OnEvent", function(f, event, addon)
	if addon == "_bdcUI" then
		bdcUI = bdcUI or {}
		bdcUIPerCharacter = bdcUIPerCharacter or {}

		for index, body in pairs(bdcUI) do
			setbody(index, body)
		end

		for index, body in pairs(bdcUIPerCharacter) do
			setbody(index, body)
		end
	elseif addon=="Blizzard_MacroUI" then
		MacroFrameText:SetMaxLetters(1500)
		MACROFRAME_CHAR_LIMIT = MACROFRAME_CHAR_LIMIT:gsub("%d+", "1500")

		MacroFrame_SaveMacro = save
		MacroFrame_DeleteMacro = delete
		MacroFrame_Update = update
		MacroPopupOkayButton_OnClick = new
	end
end)
