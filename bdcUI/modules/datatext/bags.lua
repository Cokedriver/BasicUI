local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

if C['datatext'].enable ~= true then return end

if C['datatext'].bags and C['datatext'].bags > 0 then
	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanel:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].bags, Text)

	local function OnEvent(self, event, ...)
		local totalSlots, freeSlots = 0, 0
		local itemLink, subtype, isBag
		for i = 0,NUM_BAG_SLOTS do
			isBag = true
			if i > 0 then
				itemLink = GetInventoryItemLink('player', ContainerIDToInventoryID(i))
				if itemLink then
					subtype = select(7, GetItemInfo(itemLink))
					if (subtype == 'Soul Bag') or (subtype == 'Ammo Pouch') or (subtype == 'Quiver') or (subtype == 'Mining Bag') or (subtype == 'Gem Bag') or (subtype == 'Engineering Bag') or (subtype == 'Enchanting Bag') or (subtype == 'Herb Bag') or (subtype == 'Inscription Bag') or (subtype == 'Leatherworking Bag')then
						isBag = false
					end
				end
			end
			if isBag then
				totalSlots = totalSlots + GetContainerNumSlots(i)
				freeSlots = freeSlots + GetContainerNumFreeSlots(i)
			end
			Text:SetText(hexa..L.datatext_bags..hexb.. freeSlots.. '/' ..totalSlots)
				if freeSlots < 10 then
					Text:SetTextColor(1,0,0)
				elseif freeSlots > 10 then
					Text:SetTextColor(1,1,1)
				end
			self:SetAllPoints(Text)
		end
	end
          
	Stat:RegisterEvent('PLAYER_LOGIN')
	Stat:RegisterEvent('BAG_UPDATE')
	Stat:SetScript('OnMouseDown', 
		function()
			if C['datatext'].bag == true then
				ToggleBag(0)
			elseif C['datatext'].bag == false then
				ToggleAllBags()
			end
		end)
	Stat:SetScript('OnEvent', OnEvent)
end