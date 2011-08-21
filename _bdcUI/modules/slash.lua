local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if C.slash.enable ~= true then return end

--[[

	All Create for slash.lua goes to Neal and ballagarba.
	Neav UI = http://www.wowinterface.com/downloads/info13981-NeavUI.html.
	Edited by Cokedriver.
	
]]

SlashCmdList['FRAMENAME'] = function()
    local name = GetMouseFocus():GetName()

    if (name) then
        DEFAULT_CHAT_FRAME:AddMessage('|cff00FF00   '..name)
    else
        DEFAULT_CHAT_FRAME:AddMessage('|cff00FF00This frame has no name!')
    end
end
SLASH_FRAMENAME1 = '/frame'

SlashCmdList['RELOADUI'] = function()
    ReloadUI()
end
SLASH_RELOADUI1 = '/rl'

function AuraTest()
    function UnitAura() 
        return 'TestAura', nil, 'Interface\\Icons\\Spell_Nature_RavenForm', 9, nil, 120, 120, 1, 0 
    end
end