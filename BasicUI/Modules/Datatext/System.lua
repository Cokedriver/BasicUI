local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--[[

	All Credit for System.lua goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
	
]]

if C['datatext'].enable ~= true then return end

if C['datatext'].system and C['datatext'].system > 0 then

	local Stat = CreateFrame("Frame")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat:EnableMouse(true)
	Stat.tooltip = false

	local Text  = DataPanel:CreateFontString(nil, "OVERLAY")
	Text:SetFont(C['media'].fontNormal, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].system, Text)

	local bandwidthString = "%.2f Mbps"
	local percentageString = "%.2f%%"
	local homeLatencyString = "%d ms"
	local worldLatencyString = "%d ms"
	local kiloByteString = "%d kb"
	local megaByteString = "%.2f mb"

	local function formatMem(memory)
		local mult = 10^1
		if memory > 999 then
			local mem = ((memory/1024) * mult) / mult
			return string.format(megaByteString, mem)
		else
			local mem = (memory * mult) / mult
			return string.format(kiloByteString, mem)
		end
	end

	local memoryTable = {}

	local function RebuildAddonList(self)
		local addOnCount = GetNumAddOns()
		if (addOnCount == #memoryTable) or self.tooltip == true then return end

		-- Number of loaded addons changed, create new memoryTable for all addons
		memoryTable = {}
		for i = 1, addOnCount do
			memoryTable[i] = { i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i) }
		end
		self:SetAllPoints(Text)
	end

	local function UpdateMemory()
		-- Update the memory usages of the addons
		UpdateAddOnMemoryUsage()
		-- Load memory usage in table
		local addOnMem = 0
		local totalMemory = 0
		for i = 1, #memoryTable do
			addOnMem = GetAddOnMemoryUsage(memoryTable[i][1])
			memoryTable[i][3] = addOnMem
			totalMemory = totalMemory + addOnMem
		end
		-- Sort the table to put the largest addon on top
		table.sort(memoryTable, function(a, b)
			if a and b then
				return a[3] > b[3]
			end
		end)
		
		return totalMemory
	end

	-- initial delay for update (let the ui load)
	local int, int2 = 6, 5
	local statusColors = {
		"|cff0CD809",
		"|cffE8DA0F",
		"|cffFF9000",
		"|cffD80909"
	}

	local function Update(self, t)
		int = int - t
		int2 = int2 - t
		
		if int < 0 then
			RebuildAddonList(self)
			int = 10
		end
		if int2 < 0 then
			local framerate = floor(GetFramerate())
			local fpscolor = 4
			local latency = select(4, GetNetStats()) 
			local latencycolor = 4
						
			if latency < 150 then
				latencycolor = 1
			elseif latency >= 150 and latency < 300 then
				latencycolor = 2
			elseif latency >= 300 and latency < 500 then
				latencycolor = 3
			end
			if framerate >= 30 then
				fpscolor = 1
			elseif framerate >= 20 and framerate < 30 then
				fpscolor = 2
			elseif framerate >= 10 and framerate < 20 then
				fpscolor = 3
			end
			local displayFormat = string.join("", hexa.."FPS: "..hexb, statusColors[fpscolor], "%d|r", hexa.." MS: "..hexb, statusColors[latencycolor], "%d|r")
			Text:SetFormattedText(displayFormat, framerate, latency)
			int2 = 1
		end
	end
	Stat:SetScript("OnMouseDown", function () collectgarbage("collect") Update(Stat, 20) end)
	Stat:SetScript("OnEnter", function(self)
		if InCombatLockdown() then return end
		local bandwidth = GetAvailableBandwidth()
		local _, _, latencyHome, latencyWorld = GetNetStats() 
		local anchor, panel, xoff, yoff = B.DataTextTooltipAnchor(Text)
		GameTooltip:SetOwner(panel, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddLine(hexa..B.myname.."'s"..hexb.." Latency")
		GameTooltip:AddLine' '			
		if C['datatext'].fps.enable == true then 
			if C['datatext'].fps.home == true then
				GameTooltip:AddDoubleLine("Home Latency: ", string.format(homeLatencyString, latencyHome), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
			elseif C['datatext'].fps.world == true then
				GameTooltip:AddDoubleLine("World Latency: ", string.format(worldLatencyString, latencyWorld), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
			elseif C['datatext'].fps.both == true then
				GameTooltip:AddDoubleLine("Home Latency: ", string.format(homeLatencyString, latencyHome), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
				GameTooltip:AddDoubleLine("World Latency: ", string.format(worldLatencyString, latencyWorld), 0.80, 0.31, 0.31,0.84, 0.75, 0.65)
			end
		end
		if bandwidth ~= 0 then
			GameTooltip:AddDoubleLine(L.datatext_bandwidth , string.format(bandwidthString, bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
			GameTooltip:AddDoubleLine("Download: " , string.format(percentageString, GetDownloadedPercentage() *100),0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
			GameTooltip:AddLine(" ")
		end
		local totalMemory = UpdateMemory()
		GameTooltip:AddDoubleLine("Total Memory Usage:", formatMem(totalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		GameTooltip:AddLine(" ")
		for i = 1, #memoryTable do
			if (memoryTable[i][4]) then
				local red = memoryTable[i][3] / totalMemory
				local green = 1 - red
				GameTooltip:AddDoubleLine(memoryTable[i][2], formatMem(memoryTable[i][3]), 1, 1, 1, red, green + .5, 0)
			end						
		end
		GameTooltip:Show()
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end