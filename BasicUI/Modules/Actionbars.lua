local MODULE_NAME = "Actionbar"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Actionbars = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable 			= true,		
		showHotKeys 	= false,	 -- Set the Alpha
		showMacronames 	= false,	 -- Set the Alpha
		auraborder 		= true,
		color = {
			enable = true,
			OutOfRange 	= { r = 0.9, g = 0, b = 0 },
			OutOfMana 	= { r = 0, g = 0, b = 0.9 },
			NotUsable 	= { r = 0.3, g = 0.3, b = 0.3 },
		},
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

local classColor

function Actionbars:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function Actionbars:OnEnable()
	if InCombatLockdown() then
		return self:RegisterEvent("PLAYER_REGEN_ENABLED", "OnEnable")
	end
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")

	if self.SetupHooks then
		self:SetupHooks()
	end
	
	self:Refresh()
end

function Actionbars:Refresh()

	local hotkeyAlpha = db.showHotKeys and 1 or 0
	for i = 1, 12 do
		_G["ActionButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- main bar
		_G["MultiBarBottomRightButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- bottom right bar
		_G["MultiBarBottomLeftButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- bottom left bar
		_G["MultiBarRightButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- right bar
		_G["MultiBarLeftButton"..i.."HotKey"]:SetAlpha(hotkeyAlpha) -- left bar
	end

	local macroAlpha = db.showMacronames and 1 or 0
	for i = 1, 12 do
		_G["ActionButton"..i.."Name"]:SetAlpha(macroAlpha) -- main bar
		_G["MultiBarBottomRightButton"..i.."Name"]:SetAlpha(macroAlpha) -- bottom right bar
		_G["MultiBarBottomLeftButton"..i.."Name"]:SetAlpha(macroAlpha) -- bottom left bar
		_G["MultiBarRightButton"..i.."Name"]:SetAlpha(macroAlpha) -- right bar
		_G["MultiBarLeftButton"..i.."Name"]:SetAlpha(macroAlpha) -- left bar
	end
end

function Actionbars:SetupHooks()
	local function AddRegionKeys(self)
		local name = self:GetName()
		self.__name = _G[name.."Name"]
		self.__count = _G[name.."Count"]
		self.__hotkey = _G[name.."HotKey"]
		self.__border = _G[name.."Border"]
		self.__flash = _G[name.."Flash"]
		self.__normalTexture = _G[name.."NormalTexture"]
		self.__normalTexture2 = _G[name.."NormalTexture2"]
		self.__pushedTexture = self:GetPushedTexture()
		self.__highlightTexture = self:GetHighlightTexture()
		self.__checkedTexture = self:GetCheckedTexture()
		return name
	end

	local function ColorButton(texture)
		if BasicUI.db.profile.general.classcolor then
			texture:SetVertexColor(classColor.r * 1.2, classColor.g * 1.2, classColor.b * 1.2)
		else
			texture:SetVertexColor(db.color.r, db.color.g, db.color.b)
		end
	end

	local function UpdateButton(button, iconOffset, borderOffset)
		if not button then return end
		iconOffset = iconOffset or 1
		borderOffset = borderOffset or 15

		button:SetNormalTexture("Interface\\BUTTONS\\UI-Quickslot2")

		local icon = button.icon
		icon:ClearAllPoints()
		icon:SetPoint("TOPLEFT", -iconOffset, iconOffset)
		icon:SetPoint("BOTTOMRIGHT", iconOffset, -iconOffset)
		icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

		local normalTexture = button.__normalTexture2 or button.__normalTexture
		normalTexture:ClearAllPoints()
		normalTexture:SetPoint("TOPLEFT", -borderOffset, borderOffset)
		normalTexture:SetPoint("BOTTOMRIGHT", borderOffset, -borderOffset)

		ColorButton(normalTexture)
	end

	local extraActionButtons = setmetatable({}, { __index = function(t, self)
		local name = AddRegionKeys(self)
		local v = not not strmatch(name, "ExtraActionButton")
		t[self] = v
		return v
	end })

	hooksecurefunc("ActionButton_Update", function(self)
		if not extraActionButtons[self] then
			UpdateButton(self, 0, 14)
		end
	end)

	hooksecurefunc("ActionButton_UpdateUsable", function(self)
		if not extraActionButtons[self] then
			ColorButton(self.__normalTexture)
		end
	end)

	hooksecurefunc("ActionButton_ShowGrid", function(self)
		if not extraActionButtons[self] then
			ColorButton(self.__normalTexture)
		end
	end)

	for i = 1, NUM_PET_ACTION_SLOTS do
		AddRegionKeys(_G["PetActionButton"..i])
	end
	hooksecurefunc("PetActionBar_Update", function()
		for i = 1, NUM_PET_ACTION_SLOTS do
			UpdateButton(_G["PetActionButton"..i])
		end
	end)

	for i = 1, NUM_POSSESS_SLOTS do
		AddRegionKeys(_G["PossessButton"..i])
	end
	hooksecurefunc("PossessBar_UpdateState", function()
		for i = 1, NUM_POSSESS_SLOTS do
			UpdateButton(_G["PossessButton"..i])
		end
	end)

	for i = 1, NUM_STANCE_SLOTS do
		AddRegionKeys(_G["StanceButton"..i])
	end
	hooksecurefunc("StanceBar_UpdateState", function()
		for i = 1, NUM_STANCE_SLOTS do
			UpdateButton(_G["StanceButton"..i])
		end
	end)

	---------------------------------------------------------------------

	hooksecurefunc("AuraButton_Update", function(self, index)
		if not db.auraborder then return end

		local buffName 		= _G[self..index]
		local buffIcon		= _G[self..index.."Icon"]
		local buffBorder 	= _G[self..index.."Border"]

		if buffIcon then
			buffIcon:SetTexCoord(.07, .93, .07, .93)
		end

		if buffBorder then
			buffBorder:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
			buffBorder:ClearAllPoints()
			buffBorder:SetPoint("TOPLEFT", buffName, -12, 12)
			buffBorder:SetPoint("BOTTOMRIGHT", buffName, 12, -12)
			buffBorder:SetTexCoord(0, 1, 0, 1)
			ColorButton(buffBorder)
		end
		
		if buffName and not buffBorder then
			nobuffBorder = buffName:CreateTexture("$parentOverlay", "ARTWORK")
			nobuffBorder:SetParent(buffName)
			nobuffBorder:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
			nobuffBorder:ClearAllPoints()
			nobuffBorder:SetPoint("TOPLEFT", buffName, -12, 12)
			nobuffBorder:SetPoint("BOTTOMRIGHT", buffName, 12, -12)
			ColorButton(nobuffBorder)
		end
	end)

	---------------------------------------------------------------------

	local rangeAddons = {
		"GreenRange",
		"RangeColors",
		"RedRange",
		"tullaRange",
	}
	for i = 1, #rangeAddons do
		local _, _, _, enabled = GetAddOnInfo(rangeAddons[i])
		if enabled then
			rangeAddons = nil
			break
		end
	end

	if rangeAddons then
		hooksecurefunc("ActionButton_UpdateUsable", function(self)
			local isUsable, notEnoughMana = IsUsableAction(self.action)
			if isUsable then
				self.icon:SetVertexColor(1, 1, 1)
			elseif notEnoughMana then
				local color = db.color.OutOfMana
				self.icon:SetVertexColor(color.r, color.g, color.b)
			else
				local color = db.color.NotUsable
				self.icon:SetVertexColor(color.r, color.g, color.b)
			end
		end)

		function ActionButton_OnUpdate(self, elapsed)
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
						local color = db.color.OutOfRange
						_G[self:GetName()..'Icon']:SetVertexColor(color.r, color.g, color.b)
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

	self.SetupHooks = nil
end

------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

local options
function Actionbars:GetOptions()

	if options then
		return options
	end

	local function isModuleDisabled()
		return not BasicUI:GetModuleEnabled(MODULE_NAME)
	end

	options = {
		type = "group",
		name = L[MODULE_NAME],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value end,
		disabled = isModuleDisabled(),
		args = {
			reloadUI = {
				type = "execute",
				name = "Reload UI",
				desc = " ",
				order = 0,
				func = 	function()
					ReloadUI()
				end,
			},
			Text = {
				type = "description",
				order = 0,
				name = "When changes are made a reload of the UI is needed.",
				width = "full",
			},
			Text1 = {
				type = "description",
				order = 1,
				name = " ",
				width = "full",
			},		
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable Actionbar Module"],
				width = "full",
				disabled = false,
			},
			Text2 = {
				type = "description",
				name = " ",
				width = "full",
			},			
			auraborder = {
				type = "toggle",
				name = L["Aura borders"],
				desc = L["Show colored borders on action buttons to show when auras are active."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showHotKeys = {
				type = "toggle",
				name = L["Show Hot Keys"],
				desc = L["Show key bindings on action buttons."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			showMacronames = {
				type = "toggle",
				name = L["Show Macro Names"],
				desc = L["Show macro names on action buttons."],
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
			color = {
				type = "group",
				order = -1,
				name = L["Button Coloring"],
				guiInline  = true,
				get = function(info) return db.color[ info[#info] ] end,
				set = function(info, value) db.color[ info[#info] ] = value;   end,				
				args = {
					enable = {
						order = 1,
						type = "toggle",
						name = L["Enable"],
						desc = L["Enable action button coloring."],
						width = "full",
						disabled = function() return isModuleDisabled() or not db.enable end,
					},
					OutOfRange = {
						order = 2,
						type = "color",
						name = L["Out of Range"],
						desc = L["Use this color for actions you are too far from the target to use."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.color.enable end,
						get = function(info)
							return db.color.OutOfRange.r, db.color.OutOfRange.g, db.color.OutOfRange.b
						end,
						set = function(info, r, g, b)
							db.color.OutOfRange.r, db.color.OutOfRange.g, db.color.OutOfRange.b = r, g, b
						end,
					},
					OutOfMana = {
						order = 3,
						type = "color",
						name = L["Out of Mana"],
						desc = L["Use this color for actions you don't have enough mana to use."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.color.enable end,
						get = function(info)
							return db.color.OutOfMana.r, db.color.OutOfMana.g, db.color.OutOfMana.b
						end,
						set = function(info, r, g, b)
							db.color.OutOfMana.r, db.color.OutOfMana.g, db.color.OutOfMana.b = r, g, b
						end,
					},
					NotUsable = {
						order = 4,
						type = "color",
						name = L["Not Usable"],
						desc = L["Use this color for actions you can't use for some other reason."],
						disabled = function() return isModuleDisabled() or not db.enable or not db.color.enable end,						
						get = function(info)
							return db.color.NotUsable.r, db.color.NotUsable.g, db.color.NotUsable.b
						end,
						set = function(info, r, g, b)
							db.color.NotUsable.r, db.color.NotUsable.g, db.color.NotUsable.b = r, g, b
						end,
					}
				}
			}
		}
	}
	return options
end