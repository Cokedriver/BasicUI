local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

local f = CreateFrame('Frame')
f:RegisterEvent('VARIABLES_LOADED')
f:RegisterEvent('ADDON_LOADED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')


f:SetScript('OnEvent', function(self, ...)
    if (C['general'].skin.DBM == true and IsAddOnLoaded('DBM-Core')) then	
		-- Normal Bars (Credit for DBM codeing goes to Elv from ElvUI)
        hooksecurefunc(DBT, 'CreateBar', function(self)
			for bar in self:GetBarIterator() do
				if not bar.injected then
						bar.ApplyStyle=function()
						local frame = bar.frame
						local tbar = _G[frame:GetName().."Bar"]
						local spark = _G[frame:GetName().."BarSpark"]
						local texture = _G[frame:GetName().."BarTexture"]
						local icon1 = _G[frame:GetName().."BarIcon1"]
						local icon2 = _G[frame:GetName().."BarIcon2"]
						local name = _G[frame:GetName().."BarName"]
						local timer = _G[frame:GetName().."BarTimer"]
						
						if not (icon1.overlay) then
							icon1.overlay = CreateFrame("Frame", "$parentIcon1Overlay", tbar)
							icon1.overlay:SetSize(26, 26)
							icon1.overlay:SetFrameStrata("MEDIUM");
							icon1.overlay:SetPoint("BOTTOMRIGHT", tbar, "BOTTOMLEFT", -22/4, -4);
							icon1.overlay:SetBackdrop({
								edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border',
								edgeSize = 13,
							})
							icon1.overlay:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)								
							icon1.overlay.styled=true
						end

						if not (icon2.overlay) then
							icon2.overlay = CreateFrame("Frame", "$parentIcon2Overlay", tbar)
							icon2.overlay:SetSize(26, 26)
							icon2.overlay:SetFrameStrata("MEDIUM");
							icon2.overlay:SetPoint("BOTTOMLEFT", tbar, "BOTTOMRIGHT", 22/4, -4);
							icon2.overlay:SetBackdrop({
								edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border',
								edgeSize = 13,
							})
							icon2.overlay:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)								
							icon2.overlay.styled=true				
						end

						if bar.color then
							tbar:SetStatusBarColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
						else
							tbar:SetStatusBarColor(bar.owner.options.StartColorR, bar.owner.options.StartColorG, bar.owner.options.StartColorB)
						end
						
						if bar.enlarged then frame:SetWidth(bar.owner.options.HugeWidth) else frame:SetWidth(bar.owner.options.Width) end
						if bar.enlarged then tbar:SetWidth(bar.owner.options.HugeWidth) else tbar:SetWidth(bar.owner.options.Width) end

						if not frame.styled then
							frame:SetScale(1)
							frame.SetScale=B.dummy
							frame:SetHeight(22)
							local border = CreateFrame("Frame", nil, frame);
							border:SetFrameStrata("MEDIUM");
							border:SetPoint("TOPLEFT", -2, 2);
							border:SetPoint("BOTTOMRIGHT", 2, -2);
							border:SetBackdrop({
								edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border',
								edgeSize = 13,
							})
							border:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)								
							frame.styled=true
						end

						if not spark.killed then
							spark:SetAlpha(0)
							spark:SetTexture(nil)
							spark.killed=true
						end
			
						if not icon1.styled then
							icon1:SetTexCoord(0.08, 0.92, 0.08, 0.92)
							icon1:ClearAllPoints()
							icon1:SetPoint("TOPLEFT", icon1.overlay, 2, -2)
							icon1:SetPoint("BOTTOMRIGHT", icon1.overlay, -2, 2)
							icon1.styled=true
						end
						
						if not icon2.styled then
							icon2:SetTexCoord(0.08, 0.92, 0.08, 0.92)
							icon2:ClearAllPoints()
							icon2:SetPoint("TOPLEFT", icon2.overlay, 2, -2)
							icon2:SetPoint("BOTTOMRIGHT", icon2.overlay, -2, 2)
							icon2.styled=true
						end

						if not texture.styled then
							texture:SetTexture("Interface\\TargetingFrame\\UI-StatusBar")
							texture.styled=true
						end
						
						tbar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
						if not tbar.styled then
							tbar:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -2)
							tbar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
							
							tbar.styled=true
						end

						if not name.styled then
							name:ClearAllPoints()
							name:SetPoint("LEFT", frame, "LEFT", 4, 0)
							name:SetWidth(165)
							name:SetHeight(8)
							name:SetFont(C['general'].font, C['general'].fontsize)
							name:SetJustifyH("LEFT")
							name:SetShadowColor(0, 0, 0, 0)
							name.SetFont = B.dummy
							name.styled=true
						end
						
						if not timer.styled then	
							timer:ClearAllPoints()
							timer:SetPoint("RIGHT", frame, "RIGHT", -4, 0)
							timer:SetFont(C['general'].font, C['general'].fontsize)
							timer:SetJustifyH("RIGHT")
							timer:SetShadowColor(0, 0, 0, 0)
							timer.SetFont = B.dummy
							timer.styled=true
						end

						if bar.owner.options.IconLeft then icon1:Show() icon1.overlay:Show() else icon1:Hide() icon1.overlay:Hide() end
						if bar.owner.options.IconRight then icon2:Show() icon2.overlay:Show() else icon2:Hide() icon2.overlay:Hide() end
						tbar:SetAlpha(1)
						frame:SetAlpha(1)
						texture:SetAlpha(1)
						frame:Show()
						bar:Update(0)
						bar.injected=true
					end
					bar:ApplyStyle()
				end

			end
        end)
		
		-- Boss Healthbars
		hooksecurefunc(DBM.BossHealth,"Show",function()
			local anchor=DBMBossHealthDropdown:GetParent()
			if not anchor.styled then
				local header={anchor:GetRegions()}
					if header[1]:IsObjectType("FontString") then
						header[1]:SetFont(C['general'].font, C['general'].fontsize)
						header[1]:SetTextColor(1,1,1,1)
						header[1]:SetShadowColor(0, 0, 0, 0)
						anchor.styled=true	
					end
				header=nil
			end
			anchor=nil
		end)
		
     	hooksecurefunc(DBM.BossHealth, "AddBoss", function()
			local count = 1
			while (_G[format("DBM_BossHealth_Bar_%d", count)]) do
				local bar = _G[format("DBM_BossHealth_Bar_%d", count)]
				local background = _G[bar:GetName().."BarBorder"]
				local progress = _G[bar:GetName().."Bar"]
				local name = _G[bar:GetName().."BarName"]
				local timer = _G[bar:GetName().."BarTimer"]
				local prev = _G[format("DBM_BossHealth_Bar_%d", count-1)]	

				if (count == 1) then
					local	_, anch, _ ,_, _ = bar:GetPoint()
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("BOTTOM", anch, "TOP" , 0 , 12)
					else
						bar:SetPoint("TOP", anch, "BOTTOM" , 0, -22)
					end
				else
					bar:ClearAllPoints()
					if DBM_SavedOptions.HealthFrameGrowUp then
						bar:SetPoint("TOPLEFT", prev, "TOPLEFT", 0, 26)
					else
						bar:SetPoint("TOPLEFT", prev, "TOPLEFT", 0, -26)
					end
				end

				if not bar.styled then
					bar:SetHeight(22)
					background:SetNormalTexture(nil)
					local barb = CreateFrame("Frame", nil, bar);
					barb:SetFrameStrata("MEDIUM");
					barb:SetPoint("TOPLEFT", -2, 2);
					barb:SetPoint("BOTTOMRIGHT", 2, -2);
					barb:SetBackdrop({
						edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border',
						edgeSize = 13,
					})
					barb:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)					
					bar.styled=true
				end	
				
				if not progress.styled then
					progress:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
					progress:SetStatusBarColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
					progress.styled=true
				end				
				progress:ClearAllPoints()
				progress:SetPoint("TOPLEFT", bar, "TOPLEFT", 2, -2)
				progress:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", -2, 2)

				if not name.styled then
					name:ClearAllPoints()
					name:SetPoint("LEFT", bar, "LEFT", 4, 0)
					name:SetFont(C['general'].font, C['general'].fontsize)
					name:SetJustifyH("LEFT")
					name:SetShadowColor(0, 0, 0, 0)
					name.styled=true
				end
				
				if not timer.styled then
					timer:ClearAllPoints()
					timer:SetPoint("RIGHT", bar, "RIGHT", -4, 0)
					timer:SetFont(C['general'].font, C['general'].fontsize)
					timer:SetJustifyH("RIGHT")
					timer:SetShadowColor(0, 0, 0, 0)
					timer.styled=true
				end
				count = count + 1
			end
		end)
    end

    if (C['general'].skin.Recount == true and IsAddOnLoaded('Recount')) then
		local rm = Recount.MainWindow
		rm:SetBackdrop(nil)
		local bgs = CreateFrame("Frame", nil, rm);
		bgs:SetFrameStrata("MEDIUM");
		bgs:SetPoint("TOPLEFT", -3, -8);
		bgs:SetPoint("BOTTOMRIGHT", 1, 0);
		bgs:SetBackdrop({
			edgeFile = 'Interface\\AddOns\\BasicUI\\Media\\UI-Tooltip-Border',
			edgeSize = 13,
		})
		bgs:SetBackdropBorderColor(B.ccolor.r, B.ccolor.g, B.ccolor.b)
    end
end)