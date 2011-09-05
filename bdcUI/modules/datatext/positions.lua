local B, C, L, DB = unpack(select(2, ...)) -- Import:  F - function; C - config; L - locales; DB - Database

if C['datatext'].enable ~= true then return end

-- Datatext Positions
B.PP = function(p, obj)

	local left = PanelLeft
	local center = PanelCenter
	local right = PanelRight
	
		-- Left Panel Data
	if p == 1 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('LEFT', left, 30, 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 2 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
	elseif p == 3 then
		obj:SetParent(left)
		obj:SetHeight(left:GetHeight())
		obj:SetPoint('RIGHT', left, -30, 0)
		obj:SetPoint('TOP', left)
		obj:SetPoint('BOTTOM', left)
		
		-- Center Panel Data
	elseif p == 4 then
		obj:SetParent(center)
		obj:SetHeight(center:GetHeight())
		obj:SetPoint('LEFT', center, 30, 0)
		obj:SetPoint('TOP', center)
		obj:SetPoint('BOTTOM', center)
	elseif p == 5 then
		obj:SetParent(center)
		obj:SetHeight(center:GetHeight())
		obj:SetPoint('TOP', center)
		obj:SetPoint('BOTTOM', center)
	elseif p == 6 then
		obj:SetParent(center)
		obj:SetHeight(center:GetHeight())
		obj:SetPoint('RIGHT', center, -30, 0)
		obj:SetPoint('TOP', center)
		obj:SetPoint('BOTTOM', center)
		
		-- Right Panel Data
	elseif p == 7 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('LEFT', right, 30, 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	elseif p == 8 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	elseif p == 9 then
		obj:SetParent(right)
		obj:SetHeight(right:GetHeight())
		obj:SetPoint('RIGHT', right, -30, 0)
		obj:SetPoint('TOP', right)
		obj:SetPoint('BOTTOM', right)
	end

end

B.DataTextTooltipAnchor = function(self)
	local panel = self:GetParent()
	local anchor = 'GameTooltip'
	local xoff = 1
	local yoff = 3
	
	
	for _, panel in pairs ({
		PanelLeft,
		PanelCenter,
		PanelRight,
	})	do
		if C['datatext'].top == true then
			anchor = 'ANCHOR_BOTTOM'
		else
			anchor = 'ANCHOR_TOP'
		end
	end	
	return anchor, panel, xoff, yoff
end