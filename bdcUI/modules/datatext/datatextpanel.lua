local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

if C['datatext'].enable == true then 

	--[[

		All Credit for datatext goes to Tuks.
		Tukui = http://www.tukui.org/download.php.
		Edited by Cokedriver.
		
	]]

	if C['datatext'].datapanel == true then
		
		local DataBorderPanel = CreateFrame('Frame', 'DataBorderPanel', UIParent)
		if C['datatext'].top == true then
			DataBorderPanel:SetPoint('TOP', UIParent, 0, 0)
			DataBorderPanel:SetHeight(28)
			DataBorderPanel:SetWidth(GetScreenWidth())
			DataBorderPanel:SetFrameStrata('LOW')
			DataBorderPanel:SetFrameLevel(0)
			DataBorderPanel:SetBackdrop({
				bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
				edgeFile = "Interface\\AddOns\\bdcUI\\media\\UI-Tooltip-Border",							
				tile = true, tileSize = 16, edgeSize = 18,
				insets = {left = 3, right = 3, top = 3, bottom = 3},
			})
			local ccolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass("player"))]
			DataBorderPanel:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor.b, 1)
		elseif C['datatext'].top == false then
			DataBorderPanel:SetPoint('BOTTOM', UIParent, 0, 0)
			DataBorderPanel:SetHeight(35)
			DataBorderPanel:SetWidth(1200)
			DataBorderPanel:SetFrameStrata('LOW')
			DataBorderPanel:SetFrameLevel(0)
			DataBorderPanel:SetBackdrop({
				bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
				edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
				edgeSize = 25,
				insets = {left = 9, right = 9, top = 9, bottom = 8}
			})
			DataBorderPanel:SetBackdropColor(0, 0, 0, 1)
		end



		local DataPanelLeft = CreateFrame('Frame', 'DataPanelLeft', UIParent)
		DataPanelLeft:SetPoint('LEFT', DataBorderPanel, 5, 0)
		DataPanelLeft:SetHeight(35)
		if C['datatext'].top == true then
			DataPanelLeft:SetWidth(GetScreenWidth() / 3)
		elseif C['datatext'].top == false then
			DataPanelLeft:SetWidth(1200 / 3)
		end
		DataPanelLeft:SetFrameStrata('LOW')
		DataPanelLeft:SetFrameLevel(1)		


		local DataPanelCenter = CreateFrame('Frame', 'DataPanelCenter', UIParent)
		DataPanelCenter:SetPoint('CENTER', DataBorderPanel, 0, 0)
		DataPanelCenter:SetHeight(35)
		if C['datatext'].top == true then
			DataPanelCenter:SetWidth(GetScreenWidth() / 3)
		elseif C['datatext'].top == false then
			DataPanelCenter:SetWidth(1200 / 3)
		end
		DataPanelCenter:SetFrameStrata('LOW')
		DataPanelCenter:SetFrameLevel(1)		


		local DataPanelRight = CreateFrame('Frame', 'DataPanelRight', UIParent)
		DataPanelRight:SetPoint('RIGHT', DataBorderPanel, -5, 0)
		DataPanelRight:SetHeight(35)
		if C['datatext'].top == true then
			DataPanelRight:SetWidth(GetScreenWidth() / 3)
		elseif C['datatext'].top == false then
			DataPanelRight:SetWidth(1200 / 3)
		end
		DataPanelRight:SetFrameStrata('LOW')
		DataPanelRight:SetFrameLevel(1)		


			 
		local BattleGroundPanel = CreateFrame('Frame', 'BattleGroundPanel', UIParent)
		BattleGroundPanel:SetAllPoints(DataPanelLeft)
		BattleGroundPanel:SetFrameStrata('LOW')
		BattleGroundPanel:SetFrameLevel(1)
		BattleGroundPanel:SetBackdrop({
			bgFile = [[Interface\Buttons\WHITE8x8]],
			insets = {top = 1, left = 4.5, bottom = 1, right = 1},
		})
		BattleGroundPanel:SetBackdropColor(0, 0, 0, 0)

		-- move some frames to make way for the datapanel
		if C['datatext'].top == true then
			hooksecurefunc("PlayerFrame_ResetPosition", function(self)
				self:ClearAllPoints()
				self:SetPoint("TOPLEFT", -19, -20)
			end)	
			
			local bf = BuffFrame
			bf:ClearAllPoints()
			bf:SetPoint('TOP', MinimapCluster, -100, 0)
			
			local mc = MinimapCluster
			mc:ClearAllPoints()
			mc:SetPoint('TOPRIGHT', UIParent, 0, -32)
			
			local tf = TargetFrame
			tf:ClearAllPoints()
			tf:SetPoint("TOPLEFT", 250, -20)
		elseif C['datatext'].top == false then
			-- Move the Bottom Action Bar Up on Top of the Datapanel
			-- Code help from Nibelheim on Wowinterface Forums
			local Movebar = CreateFrame("Frame")
			local NeedsUpdate = false
			local function RaiseBars(self)
				-- Check if in combat lockdown, and set NeedsUpdate
				if InCombatLockdown() then
					NeedsUpdate = true
					return
				end
							
				--Update bars
				MainMenuBar:ClearAllPoints()
				MainMenuBar:SetPoint('BOTTOM', DataBorderPanel, 0, 32)
				VehicleMenuBar:ClearAllPoints()
				VehicleMenuBar:SetPoint('BOTTOM', DataBorderPanel, 0, 40)

			end
			Movebar:SetScript("OnUpdate", function(MainMenuBar) RaiseBars(); end)
			RaiseBars()

			
			 -- Move the tooltip above the Actionbar
			if C['tooltip'].enable == true then
				hooksecurefunc('GameTooltip_SetDefaultAnchor', function(self)
					self:SetPoint('BOTTOMRIGHT', UIParent, -95, 175)
				end)
			end

			 -- Move the Bags above the Actionbar
			CONTAINER_WIDTH = 192;
			CONTAINER_SPACING = 5;
			VISIBLE_CONTAINER_SPACING = 3;
			CONTAINER_OFFSET_Y = 70;
			CONTAINER_OFFSET_X = 0;
			CONTAINER_SCALE = 0.75;
			BACKPACK_HEIGHT = 240; 
			 
			function updateContainerFrameAnchors()
				local frame, xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column;
				local screenWidth = GetScreenWidth();
				local containerScale = 1;
				local leftLimit = 0;
				if ( BankFrame:IsShown() ) then
					leftLimit = BankFrame:GetRight() - 25;
				end
				 
				while ( containerScale > CONTAINER_SCALE ) do
					screenHeight = GetScreenHeight() / containerScale;
					-- Adjust the start anchor for bags depending on the multibars
					xOffset = CONTAINER_OFFSET_X / containerScale; 
					yOffset = CONTAINER_OFFSET_Y / containerScale; 
					-- freeScreenHeight determines when to start a new column of bags
					freeScreenHeight = screenHeight - yOffset;
					leftMostPoint = screenWidth - xOffset;
					column = 1;
					local frameHeight;
					for index, frameName in ipairs(ContainerFrame1.bags) do
						frameHeight = _G[frameName]:GetHeight();
						if ( freeScreenHeight < frameHeight ) then
							-- Start a new column
							column = column + 1;
							leftMostPoint = screenWidth - ( column * CONTAINER_WIDTH * containerScale ) - xOffset;
							freeScreenHeight = screenHeight - yOffset;
						end
						freeScreenHeight = freeScreenHeight - frameHeight - VISIBLE_CONTAINER_SPACING;
					end
					if ( leftMostPoint < leftLimit ) then
						containerScale = containerScale - 0.01;
					else
						break;
					end
				end
				 
				if ( containerScale < CONTAINER_SCALE ) then
					containerScale = CONTAINER_SCALE;
				end
				 
				screenHeight = GetScreenHeight() / containerScale;
				-- Adjust the start anchor for bags depending on the multibars
				xOffset = CONTAINER_OFFSET_X / containerScale;
				yOffset = CONTAINER_OFFSET_Y / containerScale;
				-- freeScreenHeight determines when to start a new column of bags
				freeScreenHeight = screenHeight - yOffset;
				column = 0;
				for index, frameName in ipairs(ContainerFrame1.bags) do
					frame = _G[frameName];
					frame:SetScale(containerScale);
					if ( index == 1 ) then
						-- First bag
						frame:SetPoint('BOTTOMRIGHT', frame:GetParent(), 'BOTTOMRIGHT', -xOffset, yOffset+20 );
					elseif ( freeScreenHeight < frame:GetHeight() ) then
						-- Start a new column
						column = column + 1;
						freeScreenHeight = screenHeight - yOffset;
						frame:SetPoint('BOTTOMRIGHT', frame:GetParent(), 'BOTTOMRIGHT', -(column * CONTAINER_WIDTH) - xOffset, yOffset+20 );
					else
						-- Anchor to the previous bag
						frame:SetPoint('BOTTOMRIGHT', ContainerFrame1.bags[index - 1], 'TOPRIGHT', 0, CONTAINER_SPACING);   
					end
					freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING;
				end
			end
		end	
	end
end