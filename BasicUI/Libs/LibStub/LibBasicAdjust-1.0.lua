

local MAJOR_VERSION = "LibBasicAdjust-1.0"
local MINOR_VERSION = tonumber(("$Revision: 1 $"):match("(%d+)")) + 90000

if not LibStub then error(MAJOR_VERSION .. " requires LibStub") end

local oldLib = LibStub:GetLibrary(MAJOR_VERSION, true)
local Adjust = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not Adjust then
	return
end

local blizzardFrames = {'MainMenuBar',}

local blizzardFramesData = {}

local _G = _G

Adjust.hooks = oldLib and oldLib.hooks or {}
Adjust.bottomFrames = oldLib and oldLib.bottomFrames or {}
Adjust.topAdjust = oldLib and oldLib.topAdjust
Adjust.bottomAdjust = oldLib and oldLib.bottomAdjust

if Adjust.bottomAdjust == nil then
	Adjust.bottomAdjust = true
end

Adjust.frame = oldLib and oldLib.frame or CreateFrame("Frame")
local AdjustFrame = Adjust.frame
local start = GetTime()
local nextTime = 0
local fullyInitted = false
AdjustFrame:SetScript("OnUpdate", function(this, elapsed)
	local now = GetTime()
	if now - start >= 3 then
		fullyInitted = true
		for k,v in pairs(blizzardFramesData) do
			blizzardFramesData[k] = nil
		end
		this:SetScript("OnUpdate", function(this, elapsed)
			if GetTime() >= nextTime then
				Adjust:Refresh()
				this:Hide()
			end
		end)
	end
end)

function AdjustFrame:Schedule(time)
	time = time or 0
	nextTime = GetTime() + time
	self:Show()
end

AdjustFrame:UnregisterAllEvents()

AdjustFrame:SetScript("OnEvent", function(this, event, ...)
	return Adjust[event](Adjust, ...)
end)

AdjustFrame:RegisterEvent("PLAYER_AURAS_CHANGED")
AdjustFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
AdjustFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
AdjustFrame:RegisterEvent("PLAYER_CONTROL_GAINED")

function Adjust:PLAYER_AURAS_CHANGED()
	AdjustFrame:Schedule()
end

function Adjust:GetScreenBottom()
	local top = 0
	for _,frame in ipairs(self.bottomFrames) do
		if frame.IsShown and frame:IsShown() and frame.GetTop and frame:GetTop() and frame:GetTop() > top then
			top = frame:GetTop()
		end
	end
	return top
end

function Adjust:RegisterBottom(frame)
	for _,f in ipairs(self.bottomFrames) do
		if f == frame then
			return
		end
	end
	table.insert(self.bottomFrames, frame)
	AdjustFrame:Schedule()
	return true
end

function Adjust:Unregister(frame)
	for k,f in ipairs(self.bottomFrames) do
		if f == frame then
			table.remove(self.bottomFrames, k)
			AdjustFrame:Schedule()
			return true
		end
	end
end

function Adjust:IsBottomAdjusting()
	return self.bottomAdjust
end

function Adjust:EnableBottomAdjusting()
	if not self.bottomAdjust then
		self.bottomAdjust = not self.bottomAdjust
		AdjustFrame:Schedule()
	end
end

function Adjust:DisableBottomAdjusting()
	if self.bottomAdjust then
		self.bottomAdjust = not self.bottomAdjust
		AdjustFrame:Schedule()
	end
end

local tmp = {}
local queue = {}
local inCombat = false
function Adjust:ProcessQueue()
	if not inCombat and HasFullControl() then
		for k in pairs(queue) do
			self:Refresh(k)
			queue[k] = nil
		end
	end
end
function Adjust:PLAYER_CONTROL_GAINED()
	self:ProcessQueue()
end

function Adjust:PLAYER_REGEN_ENABLED()
	inCombat = false
	self:ProcessQueue()
end

function Adjust:PLAYER_REGEN_DISABLED()
	inCombat = true
end

local function isClose(alpha, bravo)
	return math.abs(alpha - bravo) < 0.1
end

function Adjust:Refresh(...)
	if not fullyInitted then
		return
	end
	
	local screenHeight = GetScreenHeight()
	local bottomOffset = self:IsBottomAdjusting() and self:GetScreenBottom() or 0
	if topOffset ~= bottomOffset ~= 0 then
		AdjustFrame:Schedule(10)
	end
	
	local frames
	if select('#', ...) >= 1 then
		for k in pairs(tmp) do
			tmp[k] = nil
		end
		for i = 1, select('#', ...) do
			tmp[i] = select(i, ...)
		end
		frames = tmp
	else
		frames = blizzardFrames
	end

	if inCombat or not HasFullControl() and not UnitHasVehicleUI("player") then
		for _,frame in ipairs(frames) do
			if type(frame) == "string" then
				frame = _G[frame]
			end
			if frame then
				queue[frame] = true
			end
		end
		return
	end
	
	local screenHeight = GetScreenHeight()
	for _,frame in ipairs(frames) do
		if type(frame) == "string" then
			frame = _G[frame]
		end

		local framescale = frame and frame.GetScale and frame:GetScale() or 1

		if frame and not blizzardFramesData[frame] and frame.GetTop and frame:GetCenter() and select(2, frame:GetCenter()) then
			if select(2, frame:GetCenter()) <= screenHeight / 2 then
				blizzardFramesData[frame] = {y = frame:GetBottom(), top = false}
			else
				blizzardFramesData[frame] = {y = frame:GetTop() - screenHeight / framescale, top = true}
			end
		end
	end
	
	for _,frame in ipairs(frames) do
		if type(frame) == "string" then
			frame = _G[frame]
		end

		local framescale = frame and frame.GetScale and frame:GetScale() or 1

		if (frame and frame.IsUserPlaced and not frame:IsUserPlaced()) then
			local frameData = blizzardFramesData[frame]
			if (select(2, frame:GetPoint(1)) ~= UIParent and select(2, frame:GetPoint(1)) ~= WorldFrame) then
				-- do nothing
			elseif frame == MainMenuBar and Gypsy_HotBarCapsule then
				-- do nothing
			elseif frame == MainMenuBar or not (frameData.lastScale and frame.GetScale and frameData.lastScale == frame:GetScale()) or not (frameData.lastX and frameData.lastY and (not isClose(frameData.lastX, frame:GetLeft()) or not isClose(frameData.lastY, frame:GetTop()))) then
				local anchor
				local anchorAlt
				local width, height = GetScreenWidth(), GetScreenHeight()
				local x

				if frame:GetRight() and frame:GetLeft() then
					local anchorFrame = UIParent
					if frame == MainMenuBar or frame == GroupLootFrame1 then
						x = 0
						anchor = ""
					end
					local y = blizzardFramesData[frame].y
					local offset = 0
					if not blizzardFramesData[frame].top then
						anchor = "BOTTOM" .. anchor
						offset = bottomOffset / framescale
					end	
					frame:ClearAllPoints()
					frame:SetPoint(anchor, anchorFrame, anchorAlt or anchor, x, y + offset - 4)
					blizzardFramesData[frame].lastX = frame:GetLeft()
					blizzardFramesData[frame].lastY = frame:GetTop()
					blizzardFramesData[frame].lastScale = framescale
				end
			end
		end
	end
end

if AceLibrary then
	compat()
elseif Rock then
	function Adjust:OnLibraryLoad(major, version)
		if major == "AceLibrary" then
			compat()
		end
	end
end
