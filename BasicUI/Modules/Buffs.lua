local MODULE_NAME = "Buffs"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local Buffs = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
		buffSize = 36,
		buffScale = 1,

		buffFontSize = 14,
		buffCountSize = 16,

		debuffSize = 36,
		debuffScale = 1,

		debuffFontSize = 14,
		debuffCountSize = 16,

		paddingX = 8,
		paddingY = 8,
		buffPerRow = 8,

		font = 'Fonts\\ARIALN.ttf',
		
		color = { r = 1, g = 1, b = 1},
		classcolor = true,
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

function Buffs:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function Buffs:OnEnable()
	-- set up stuff here
	db = self.db.profile
	
	local _G = _G
	local unpack = unpack
	local ccolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]

	_G.DAY_ONELETTER_ABBR = '|cffffffff%dd|r'
	_G.HOUR_ONELETTER_ABBR = '|cffffffff%dh|r'
	_G.MINUTE_ONELETTER_ABBR = '|cffffffff%dm|r'
	_G.SECOND_ONELETTER_ABBR = '|cffffffff%d|r'

	_G.DEBUFF_MAX_DISPLAY = 32 -- show more debuffs
	_G.BUFF_MIN_ALPHA = 1

	local origSecondsToTimeAbbrev = _G.SecondsToTimeAbbrev
	local function SecondsToTimeAbbrevHook(seconds)
		origSecondsToTimeAbbrev(seconds)

		local tempTime
		if (seconds >= 86400) then
			tempTime = ceil(seconds / 86400)
			return '|cffffffff%dd|r', tempTime
		end

		if (seconds >= 3600) then
			tempTime = ceil(seconds / 3600)
			return '|cffffffff%dh|r', tempTime
		end

		if (seconds >= 60) then
			tempTime = ceil(seconds / 60)
			return '|cffffffff%dm|r', tempTime
		end

		return '|cffffffff%d|r', seconds
	end
	SecondsToTimeAbbrev = SecondsToTimeAbbrevHook

	BuffFrame:SetScript('OnUpdate', nil)
	hooksecurefunc(BuffFrame, 'Show', function(self)
		self:SetScript('OnUpdate', nil)
	end)

	-- TemporaryEnchantFrame ...
	TempEnchant1:ClearAllPoints()
	TempEnchant1:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -30, 0)
	-- TempEnchant1.SetPoint = function() end

	TempEnchant2:ClearAllPoints()
	TempEnchant2:SetPoint('TOPRIGHT', TempEnchant1, 'TOPLEFT', -db.paddingX, 0)

	ConsolidatedBuffs:SetSize(20, 20)
	ConsolidatedBuffs:ClearAllPoints()
	ConsolidatedBuffs:SetPoint('BOTTOM', TempEnchant1, 'TOP', 1, 2)
	-- ConsolidatedBuffs.SetPoint = function() end

	ConsolidatedBuffsIcon:SetAlpha(0)

	ConsolidatedBuffsCount:ClearAllPoints()
	ConsolidatedBuffsCount:SetPoint('CENTER', ConsolidatedBuffsIcon, 0, 1)
	ConsolidatedBuffsCount:SetFont(db.font, db.buffFontSize+2, 'THINOUTLINE')
	ConsolidatedBuffsCount:SetShadowOffset(0, 0)

	ConsolidatedBuffsTooltip:SetScale(1.2)

	local function UpdateFirstButton(self)
		if (self and self:IsShown()) then
			self:ClearAllPoints()
			if (UnitHasVehicleUI('player')) then
				self:SetPoint('TOPRIGHT', TempEnchant1)
				return
			else
				if (BuffFrame.numEnchants > 0) then
					self:SetPoint('TOPRIGHT', _G['TempEnchant'..BuffFrame.numEnchants], 'TOPLEFT', -db.paddingX, 0)
					return
				else
					self:SetPoint('TOPRIGHT', TempEnchant1)
					return
				end
			end
		end
	end

	local function CheckFirstButton()
		if (BuffButton1) then
			--if (not BuffButton1:GetParent() == ConsolidatedBuffsContainer) then
			if (not BuffButton1:GetParent() == ConsolidatedBuffsTooltipBuff1) then
				UpdateFirstButton(BuffButton1)
			end
		end
	end

	hooksecurefunc('BuffFrame_UpdatePositions', function()
		if (CONSOLIDATED_BUFF_ROW_HEIGHT ~= 26) then
			CONSOLIDATED_BUFF_ROW_HEIGHT = 26
		end
	end)

	hooksecurefunc('BuffFrame_UpdateAllBuffAnchors', function()  
		local previousBuff, aboveBuff
		local numBuffs = 0
		local numTotal = BuffFrame.numEnchants 

		for i = 1, BUFF_ACTUAL_DISPLAY do
			local buff = _G['BuffButton'..i]

			if (not buff.consolidated) then
				numBuffs = numBuffs + 1
				numTotal = numTotal + 1

				buff:ClearAllPoints()
				if (numBuffs == 1) then
					UpdateFirstButton(buff)
				elseif (numBuffs > 1 and mod(numTotal, db.buffPerRow) == 1) then
					if (numTotal == db.buffPerRow + 1) then
						buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, -db.paddingY)
					else
						buff:SetPoint('TOP', aboveBuff, 'BOTTOM', 0, -db.paddingY)
					end

					aboveBuff = buff
				else
					buff:SetPoint('TOPRIGHT', previousBuff, 'TOPLEFT', -db.paddingX, 0)
				end

				previousBuff = buff
			end
		end
	end)

	hooksecurefunc('DebuffButton_UpdateAnchors', function(self, index)
		local numBuffs = BUFF_ACTUAL_DISPLAY + BuffFrame.numEnchants
		if (ShouldShowConsolidatedBuffFrame()) then
			numBuffs = numBuffs + 1 -- consolidated buffs
		end

		local rowSpacing
		local debuffSpace = db.buffSize + db.paddingY
		local numRows = ceil(numBuffs/db.buffPerRow)

		if (numRows and numRows > 1) then
			rowSpacing = -numRows * debuffSpace
		else
			rowSpacing = -debuffSpace
		end

		local buff = _G[self..index]
		buff:ClearAllPoints()

		if (index == 1) then
			buff:SetPoint('TOP', TempEnchant1, 'BOTTOM', 0, rowSpacing)
		elseif (index >= 2 and mod(index, db.buffPerRow) == 1) then
			buff:SetPoint('TOP', _G[self..(index-db.buffPerRow)], 'BOTTOM', 0, -db.paddingY)
		else
			buff:SetPoint('TOPRIGHT', _G[self..(index-1)], 'TOPLEFT', -db.paddingX, 0)
		end
	end)

	for i = 1, NUM_TEMP_ENCHANT_FRAMES do
		local button = _G['TempEnchant'..i]
		local borderbg = CreateFrame("Frame", nil, button)
		borderbg:SetPoint('TOPRIGHT', button, 4, 4)
		borderbg:SetPoint('BOTTOMLEFT', button, -4, -4)    
		borderbg:SetBackdrop({
			edgeFile = BasicUI.media.border,
			tile = true, tileSize = 16, edgeSize = 15,
			insets = {left = 3, right = 3, top = 3, bottom = 3}
		})
		borderbg:SetBackdropBorderColor( 1, 0, 0)		
		button:SetScale(db.buffScale)
		button:SetSize(db.buffSize, db.buffSize)

		button:SetScript('OnShow', function()
			CheckFirstButton()
		end)

		button:SetScript('OnHide', function()
			CheckFirstButton()
		end)

		local icon = _G['TempEnchant'..i..'Icon']

		icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)

		local duration = _G['TempEnchant'..i..'Duration']
		duration:ClearAllPoints()
		duration:SetPoint('BOTTOM', button, 'BOTTOM', 1, 2)
		duration:SetFont(db.font, db.buffFontSize, 'THINOUTLINE')
		duration:SetShadowOffset(0, 0)
		duration:SetDrawLayer('OVERLAY')

		local border = _G['TempEnchant'..i..'Border']
		border:SetTexture(nil)
		border:ClearAllPoints()	
	end

	hooksecurefunc('AuraButton_Update', function(self, index, borderOffset)
		local button = _G[self..index]
		
		if (button and not button.Shadow) then
			if (button) then
				if (self:match('Debuff')) then
					button:SetSize(db.debuffSize, db.debuffSize)
					button:SetScale(db.debuffScale)
				else
					button:SetSize(db.buffSize, db.buffSize)
					button:SetScale(db.buffScale)
				end
			end

			local icon = _G[self..index..'Icon']
			if (icon) then
				icon:SetTexCoord(0.04, 0.96, 0.04, 0.96)
			end

			local duration = _G[self..index..'Duration']
			if (duration) then
				duration:ClearAllPoints()
				duration:SetPoint('BOTTOM', button, 'BOTTOM', 1, 2)
				if (self:match('Debuff')) then
					duration:SetFont(db.font, db.debuffFontSize, 'THINOUTLINE')
				else
					duration:SetFont(db.font, db.buffFontSize, 'THINOUTLINE')
				end
				duration:SetShadowOffset(0, 0)
				duration:SetDrawLayer('OVERLAY')
			end

			local count = _G[self..index..'Count']
			if (count) then
				count:ClearAllPoints()
				count:SetPoint('TOP', button, 'TOP', 0, -2)
				if (self:match('Debuff')) then
					count:SetFont(db.font, db.debuffCountSize, 'THINOUTLINE')
				else
					count:SetFont(db.font, db.buffCountSize, 'THINOUTLINE')
				end
				count:SetShadowOffset(0, 0)
				count:SetDrawLayer('OVERLAY')
			end

			local border = _G[self..index..'Border']
			if (border) then
				border:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
				border:ClearAllPoints()
				local borderbg = CreateFrame("Frame", nil, button)
				borderbg:SetPoint("TOPLEFT", -4, 3)
				borderbg:SetPoint("BOTTOMRIGHT", 3, -4)				
				--borderbg:SetPoint('TOPRIGHT', button, 4, 4)
				--borderbg:SetPoint('BOTTOMLEFT', button, -4, -4)    
				borderbg:SetBackdrop({
					edgeFile = BasicUI.media.border,
					tile = true, tileSize = 16, edgeSize = 15,
				})
				borderbg:SetBackdropBorderColor( 1, 0, 0)
				borderbg:SetFrameStrata('MEDIUM')
			end

			if (button and not border) then
				if (not button.texture) then
					button.texture = button:CreateTexture('$parentOverlay', 'ARTWORK')
					button.texture:SetParent(button)
					button.texture:SetTexture("Interface\\BUTTONS\\UI-Quickslot2")
					button.texture:ClearAllPoints()
					local buttonbg = CreateFrame("Frame", nil, button)
					buttonbg:SetPoint("TOPLEFT", -4, 3)
					buttonbg:SetPoint("BOTTOMRIGHT", 3, -4)					
					--buttonbg:SetPoint('TOPRIGHT', button, 4, 4)
					--buttonbg:SetPoint('BOTTOMLEFT', button, -4, -4)    
					buttonbg:SetBackdrop({
						edgeFile = BasicUI.media.border,
						tile = true, tileSize = 16, edgeSize = 15,
					})
					if db.classcolor ~= true then
						buttonbg:SetBackdropBorderColor(db.color.r,db.color.g,db.color.b)
					else
						buttonbg:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b)
					end
					buttonbg:SetFrameStrata('MEDIUM')				
				end
			end
		end
	end)
end

------------------------------------------------------------------------
--	 Module Options
------------------------------------------------------------------------

-- Leave this out if the module doesn't have any options:
local options
function Buffs:GetOptions()

	if options then
		return options
	end

	local function isModuleDisabled()
		return not BasicUI:GetModuleEnabled(MODULE_NAME)
	end

	options = {
		type = "group",
		name = L[MODULE_NAME],
		desc = L["Buff Module for BasicUI."],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value end,
		disabled = isModuleDisabled(),		
		args = {
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				desc = L["Enables Buff Module."],
				width = "full",
				disabled = false,
			},								
			buffSize = {
				type = "range",					
				order = 4,
				name = L["Buff Size"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 1, max = 50, step = 1,
				disabled = function() return not db.enable end,
			},
			buffScale = {
				type = "range",					
				order = 4,
				name = L["Buff Scale"],
				--desc = L["Controls the scaling of the Buff Frames"],
				min = 0.5, max = 5, step = 0.05,
				disabled = function() return not db.enable end,
			},
			buffFontSize = {
				type = "range",					
				order = 4,
				name = L["Buff Font Size"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 8, max = 25, step = 1,
				disabled = function() return not db.enable end,
			},
			buffCountSize = {
				type = "range",					
				order = 4,
				name = L["Buff Count Size"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 1, max = 10, step = 1,
				disabled = function() return not db.enable end,
			},
			debuffSize = {
				type = "range",					
				order = 4,
				name = L["DeBuff Size"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 1, max = 50, step = 1,
				disabled = function() return not db.enable end,
			},
			debuffScale = {
				type = "range",					
				order = 4,
				name = L["DeBuff Scale"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 0.5, max = 5, step = 0.05,
				disabled = function() return not db.enable end,
			},
			debuffFontSize = {
				type = "range",					
				order = 4,
				name = L["DeBuff Font Size"],
				min = 8, max = 25, step = 0.05,
				disabled = function() return not db.enable end,
			},
			debuffCountSize = {
				type = "range",					
				order = 4,
				name = L["DeBuff Count Size"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 1, max = 10, step = 1,
				disabled = function() return not db.enable end,
			},
			paddingX = {
				type = "range",					
				order = 4,
				name = L["Padding X"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 1, max = 20, step = 1,
				disabled = function() return not db.enable end,
			},
			paddingY = {
				type = "range",					
				order = 4,
				name = L["Padding Y"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 1, max = 20, step = 1,
				disabled = function() return not db.enable end,
			},						
			buffPerRow = {
				type = "range",					
				order = 4,
				name = L["Buffs Per Row"],
				--desc = L["Controls the scaling of Blizzard's Buff Frames"],
				min = 1, max = 20, step = 1,
				disabled = function() return not db.enable end,
			},					
		}
	}
	return options
end