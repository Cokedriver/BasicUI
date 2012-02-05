local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['datatext'].enable ~= true then return end

--[[
	All Credit for datatext goes to Tuks.
	Tukui = http://www.tukui.org/download.php.
	Edited by Cokedriver.
]]

local DataPanel = CreateFrame('Frame', 'DataPanel', UIParent)
local PanelLeft = CreateFrame('Frame', 'PanelLeft', UIParent)
local PanelCenter = CreateFrame('Frame', 'PanelCenter', UIParent)
local PanelRight = CreateFrame('Frame', 'PanelRight', UIParent)
local BattleGroundPanel = CreateFrame('Frame', 'BattleGroundPanel', UIParent)
local ccolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass("player"))]

if C['datatext'].top == true then
	DataPanel:SetPoint('TOP', UIParent, 0, 0)
	DataPanel:SetHeight(28)
	DataPanel:SetWidth(B.getscreenwidth)
	DataPanel:SetFrameStrata('LOW')
	DataPanel:SetFrameLevel(0)
	DataPanel:SetBackdrop({
		bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
		edgeFile = "Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border",							
		tile = true, tileSize = 16, edgeSize = 18,
		insets = {left = 3, right = 3, top = 3, bottom = 3},
	})
	DataPanel:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b, 1)

	-- Left Panel
	PanelLeft:SetPoint('LEFT', DataPanel, 5, 0)
	PanelLeft:SetHeight(35)
	PanelLeft:SetWidth(B.getscreenwidth / 3)
	PanelLeft:SetFrameStrata('LOW')
	PanelLeft:SetFrameLevel(1)		

	-- Center Panel
	PanelCenter:SetPoint('CENTER', DataPanel, 0, 0)
	PanelCenter:SetHeight(35)
	PanelCenter:SetWidth(B.getscreenwidth / 3)
	PanelCenter:SetFrameStrata('LOW')
	PanelCenter:SetFrameLevel(1)		

	-- Right Panel
	PanelRight:SetPoint('RIGHT', DataPanel, -5, 0)
	PanelRight:SetHeight(35)
	PanelRight:SetWidth(B.getscreenwidth / 3)
	PanelRight:SetFrameStrata('LOW')
	PanelRight:SetFrameLevel(1)		

	-- Battleground Panel
	BattleGroundPanel:SetAllPoints(PanelLeft)
	BattleGroundPanel:SetFrameStrata('LOW')
	BattleGroundPanel:SetFrameLevel(1)	
else
	DataPanel:SetPoint('BOTTOM', UIParent, 0, 0)
	DataPanel:SetHeight(35)
	DataPanel:SetWidth(1200)
	DataPanel:SetFrameStrata('LOW')
	DataPanel:SetFrameLevel(0)
	DataPanel:SetBackdrop({
		bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
		edgeFile = "Interface\\AddOns\\BasicUI\\Media\\UI-DialogBox-Border",
		edgeSize = 25,
		insets = {left = 9, right = 9, top = 9, bottom = 8}
	})
	DataPanel:SetBackdropColor(0, 0, 0, 1)
	
	-- Left Panel
	PanelLeft:SetPoint('LEFT', DataPanel, 5, 0)
	PanelLeft:SetHeight(35)
	PanelLeft:SetWidth(1200 / 3)
	PanelLeft:SetFrameStrata('LOW')
	PanelLeft:SetFrameLevel(1)		

	-- Center Panel
	PanelCenter:SetPoint('CENTER', DataPanel, 0, 0)
	PanelCenter:SetHeight(35)
	PanelCenter:SetWidth(1200 / 3)
	PanelCenter:SetFrameStrata('LOW')
	PanelCenter:SetFrameLevel(1)		

	-- Right panel
	PanelRight:SetPoint('RIGHT', DataPanel, -5, 0)
	PanelRight:SetHeight(35)
	PanelRight:SetWidth(1200 / 3)
	PanelRight:SetFrameStrata('LOW')
	PanelRight:SetFrameLevel(1)		

	-- Battleground Panel
	BattleGroundPanel:SetAllPoints(PanelLeft)
	BattleGroundPanel:SetFrameStrata('LOW')
	BattleGroundPanel:SetFrameLevel(1)
	
end


	-- move some frames to make way for the datapanel
if C['datatext'].top == true then

	local top = function() end
	PlayerFrame:ClearAllPoints() PlayerFrame:SetPoint("TOPLEFT", -19, -20) PlayerFrame.ClearAllPoints = top PlayerFrame.SetPoint = top
	TargetFrame:ClearAllPoints() TargetFrame:SetPoint("TOPLEFT", 250, -20) TargetFrame.ClearAllPoints = top TargetFrame.SetPoint = top
	MinimapCluster:ClearAllPoints() MinimapCluster:SetPoint('TOPRIGHT', 0, -32) MinimapCluster.ClearAllPoints = top MinimapCluster.SetPoint = top
	BuffFrame:ClearAllPoints() BuffFrame:SetPoint('TOP', MinimapCluster, -100, 0) BuffFrame.ClearAllPoints = top BuffFrame.SetPoint = top
	WorldStateAlwaysUpFrame:ClearAllPoints() WorldStateAlwaysUpFrame:SetPoint('TOP', 0, -32) WorldStateAlwaysUpFrame.ClearAllpoints = top WorldStateAlwaysUpFrame.Setpoint = top

else

	-- Move some stuff for the panel on bottom.

	local bottom = function() end
	MainMenuBar:ClearAllPoints() MainMenuBar:SetPoint("BOTTOM", DataPanel, "TOP", 0, -4) MainMenuBar.ClearAllPoints = bottom MainMenuBar.SetPoint = bottom
	VehicleMenuBar:ClearAllPoints() VehicleMenuBar:SetPoint("BOTTOM", DataPanel, "TOP", 0, 4) VehicleMenuBar.ClearAllPoints = bottom VehicleMenuBar.SetPoint = bottom
	PetActionBarFrame:ClearAllPoints() PetActionBarFrame:SetPoint("BOTTOM", MainMenuBar, "TOP", 40, 47) PetActionBarFrame.ClearAllPoints = bottom PetActionBarFrame.SetPoint = bottom		
	WorldStateAlwaysUpFrame:ClearAllPoints() WorldStateAlwaysUpFrame:SetPoint('TOP', -20, -20) WorldStateAlwaysUpFrame.ClearAllpoints = bottom WorldStateAlwaysUpFrame.Setpoint = bottom
	BuffFrame:ClearAllPoints() BuffFrame:SetPoint('TOP', MinimapCluster, -110, -15) BuffFrame.ClearAllPoints = bottom BuffFrame.SetPoint = bottom	

	-- Move the tooltip above the Actionbar
	if C["tooltip"].enable == true then
		hooksecurefunc('GameTooltip_SetDefaultAnchor', function(self)
			self:SetPoint('BOTTOMRIGHT', UIParent, -95, 135)
		end)
	end 
	
	 -- Move the Bags above the Actionbar
	CONTAINER_WIDTH = 192;
	CONTAINER_SPACING = 5;
	VISIBLE_CONTAINER_SPACING = 3;
	CONTAINER_OFFSET_Y = 70;
	CONTAINER_OFFSET_X = 0;

	 
	function updateContainerFrameAnchors()
		local _, xOffset, yOffset, _, _, _, _;
		local containerScale = 1;
		screenHeight = GetScreenHeight() / containerScale;
		-- Adjust the start anchor for bags depending on the multibars
		xOffset = CONTAINER_OFFSET_X / containerScale;
		yOffset = CONTAINER_OFFSET_Y / containerScale + 25;
		-- freeScreenHeight determines when to start a new column of bags
		freeScreenHeight = screenHeight - yOffset;
		column = 0;
		for index, frameName in ipairs(ContainerFrame1.bags) do
			frame = _G[frameName];
			frame:SetScale(containerScale);
			if ( index == 1 ) then
				-- First bag
				frame:SetPoint('BOTTOMRIGHT', frame:GetParent(), 'BOTTOMRIGHT', -xOffset, yOffset );
			elseif ( freeScreenHeight < frame:GetHeight() ) then
				-- Start a new column
				column = column + 1;
				freeScreenHeight = screenHeight - yOffset;
				frame:SetPoint('BOTTOMRIGHT', frame:GetParent(), 'BOTTOMRIGHT', -(column * CONTAINER_WIDTH) - xOffset, yOffset );
			else
				-- Anchor to the previous bag
				frame:SetPoint('BOTTOMRIGHT', ContainerFrame1.bags[index - 1], 'TOPRIGHT', 0, CONTAINER_SPACING);   
			end
			freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING;
		end
	end	 
end	