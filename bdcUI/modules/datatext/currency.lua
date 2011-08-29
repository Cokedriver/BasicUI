local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

if C['datatext'].enable ~= true then return end

if C['datatext'].currency and C['datatext'].currency > 0 then
	local Stat = CreateFrame('Frame')
	Stat:EnableMouse(true)
	Stat:SetFrameStrata('BACKGROUND')
	Stat:SetFrameLevel(3)

	local Text  = DataPanelLeft:CreateFontString(nil, 'OVERLAY')
	Text:SetFont(C['general'].font, C['datatext'].fontsize,'THINOUTLINE')
	B.PP(C['datatext'].currency, Text)
	
	local function update()
		local _text = '---'
		for i = 1, MAX_WATCHED_TOKENS do
			local name, count, _, _, _ = GetBackpackCurrencyInfo(i)
			if name and count then
				if(i ~= 1) then _text = _text .. ' ' else _text = '' end
				words = { strsplit(' ', name) }
				for _, word in ipairs(words) do
					_text = _text .. string.sub(word,1,1)
				end
				_text = _text .. ': ' .. count
			end
		end
		
		Text:SetText(_text)
	end
	
	local function OnEvent(self, event, ...)
		update()
		self:SetAllPoints(Text)
		Stat:UnregisterEvent('PLAYER_LOGIN')	
	end

	Stat:RegisterEvent('PLAYER_LOGIN')	
	hooksecurefunc('BackpackTokenFrame_Update', update)
	Stat:SetScript('OnEvent', OnEvent)
	Stat:SetScript('OnMouseDown', function() ToggleCharacter('TokenFrame') end)
end