local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

local f = CreateFrame('Frame')
f:RegisterEvent('VARIABLES_LOADED')
f:RegisterEvent('ADDON_LOADED')
f:RegisterEvent('PLAYER_ENTERING_WORLD')

f:SetScript('OnEvent', function(self)

        -- a example for addons like pitbull

    --[[ 
    if (IsAddOnLoaded('PitBull4')) then
        f:SetScript('OnUpdate', function(self)
                
                -- works fine because beautycase will not create multiple textures/borders
                
            for _, pitframe in pairs({
                PitBull4_Frames_player,
                PitBull4_Frames_target,
                PitBull4_Frames_targettarget,
            }) do
                if (pitframe:IsShown()) then
                    pitframe:CreateBeautyBorder(11)
                    pitframe:SetBeautyBorderPadding(2)
                end
            end
        end)
    end
    --]]

    if (IsAddOnLoaded('DBM-Core')) then
        hooksecurefunc(DBT, 'CreateBar', function(self)
            for bar in self:GetBarIterator() do
                local frame = bar.frame
                local tbar = _G[frame:GetName()..'Bar']
                local spark = _G[frame:GetName()..'BarSpark']
                local texture = _G[frame:GetName()..'BarTexture']
                local icon1 = _G[frame:GetName()..'BarIcon1']
                local icon2 = _G[frame:GetName()..'BarIcon2']
                local name = _G[frame:GetName()..'BarName']
                local timer = _G[frame:GetName()..'BarTimer']
			

                texture:SetHeight(28)

                timer:ClearAllPoints()
                timer:SetPoint('RIGHT', tbar, 'RIGHT', -4, 0)
                timer:SetFont('Fonts\\ARIALN.ttf', 22)
                timer:SetJustifyH('RIGHT')

                name:ClearAllPoints()
                name:SetPoint('LEFT', tbar, 4, 0)
                name:SetPoint('RIGHT', timer, 'LEFT', -4, 0)
                name:SetFont('Fonts\\ARIALN.ttf', 15)

                tbar:SetHeight(30)
				local size = -5,
				tbar:SetBackdrop({
					edgeFile = "Interface\\AddOns\\BasicUI\\BasicMedia\\UI-Tooltip-Border",
					edgeSize = 15,
					insets = {left = size, right = size, top = size, bottom = size}
				})
				local ccolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass("player"))]
				tbar:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor, 1)					

                icon1:SetTexCoord(0.07, 0.93, 0.07, 0.93)
                icon1:SetSize(tbar:GetHeight(), tbar:GetHeight() - 1)

                icon2:SetTexCoord(0.07, 0.93, 0.07, 0.93)
                icon2:SetSize(tbar:GetHeight(), tbar:GetHeight() - 1)
            end
        end)
    end

    if (IsAddOnLoaded('Recount')) then
        if (not Recount.MainWindow) then
			local bgsize = 3,
			Recount.MainWindow:SetBackdrop({
				edgeFile = "Interface\\AddOns\\BasicUI\\BasicMedia\\UI-Tooltip-Border",
				tile = true, tileSize = 16, edgeSize = 18,
				insets = {left = bgsize, right = bgsize, top = bgsize, bottom = bgsize}
			})
			local ccolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2,UnitClass("player"))]
			Recount.MainWindow:SetBackdropBorderColor(ccolor.r, ccolor.g, ccolor, 1)			
        end
    end
end)
