local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database
local Crayon = LibStub:GetLibrary("LibCrayon-3.0")

if C['datatext'].enable ~= true then return end

if C['datatext'].dur and C['datatext'].dur > 0 then

	Slots = {
		[1] = {1, "Head", 1000},
		[2] = {3, "Shoulder", 1000},
		[3] = {5, "Chest", 1000},
		[4] = {6, "Waist", 1000},
		[5] = {9, "Wrist", 1000},
		[6] = {10, "Hands", 1000},
		[7] = {7, "Legs", 1000},
		[8] = {8, "Feet", 1000},
		[9] = {16, "Main Hand", 1000},
		[10] = {17, "Off Hand", 1000},
		[11] = {18, "Ranged", 1000}
	}
	

	local join = string.join
	local floor = math.floor
	local random = math.random
	local sort = table.sort

	local displayString = string.join("", hexa.."Armor: "..hexb, "%s%d%%|r")
	local tooltipString = "%d %%"

	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("MEDIUM")
	Stat:SetFrameLevel(3)

	local fader = CreateFrame("Frame", "DurabilityDataText", DataPanel)

	local Text  = DurabilityDataText:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C["datatext"].dur, Text)
	fader:SetFrameLevel(fader:GetParent():GetFrameLevel())
	fader:SetFrameStrata(fader:GetParent():GetFrameStrata())

	local Total = 0
	local current, max

	B.SetUpAnimGroup(DurabilityDataText)
	local function OnEvent(self)
		-- local hexString = "|cff%s"
		Total = 0
		for i = 1, 11 do
			if GetInventoryItemLink("player", Slots[i][1]) ~= nil then
				current, max = GetInventoryItemDurability(Slots[i][1])
				if current then 
					Slots[i][3] = current/max
					Total = Total + 1
				end
			end
		end
		sort(Slots, function(a, b) return a[3] < b[3] end)

		if Total > 0 then
			percent = floor(Slots[1][3] * 100)
			Text:SetFormattedText(displayString, format("|cff%s", Crayon:GetThresholdHexColor(Slots[1][3])), percent)
			if floor(Slots[1][3]*100) <= 20 then
				local int = -1
				Stat:SetScript("OnUpdate", function(self, t)
					int = int - t
					if int < 0 then
						B.Flash(DurabilityDataText, 0.53)
						int = 1
					end
				end)				
			else
				Stat:SetScript("OnUpdate", function() end)
				B.StopFlash(DurabilityDataText)
			end
		else
			Text:SetFormattedText(displayString, statusColors[1], 100)
		end
		-- Setup Durability Tooltip
		self:SetAllPoints(Text)
	end

	Stat:SetScript("OnEnter", function()
		if not InCombatLockdown() then
			local anchor, panel, xoff, yoff = B.DataTextTooltipAnchor(Text)
			GameTooltip:SetOwner(panel, anchor, xoff, yoff)
			GameTooltip:ClearLines()
			GameTooltip:AddLine(hexa..B.myname.."'s"..hexb.." Armor")
			for i = 1, 11 do
				if Slots[i][3] ~= 1000 then
					green = Slots[i][3]*2
					red = 1 - green
					-- print(green); print(red);
					GameTooltip:AddDoubleLine(Slots[i][2], format(tooltipString, floor(Slots[i][3]*100)), 1 ,1 , 1, red + 1, green, 0)
				end
			end
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine("|cffeda55fClick|r to Show Character Panel")
			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)

	Stat:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	Stat:RegisterEvent("MERCHANT_SHOW")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
	Stat:SetScript("OnEvent", OnEvent)
end