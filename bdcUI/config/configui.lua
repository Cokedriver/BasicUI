----------------------------------------------------------------------------
-- This Module loads new user settings if bdcUI_ConfigUI is loaded
----------------------------------------------------------------------------
local B, C, L, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; L - locales; DB - Database

--Convert default database
for group,options in pairs(DB) do
	if not C[group] then C[group] = {} end
	for option, value in pairs(options) do
		C[group][option] = value
	end
end

if IsAddOnLoaded("bdcUI_Config") then
	local bdcUIConfig = LibStub("AceAddon-3.0"):GetAddon("bdcUIConfig")
	bdcUIConfig:Load()

	--Load settings from bdcUIConfig database
	for group, options in pairs(bdcUIConfig.db.profile) do
		if C[group] then
			for option, value in pairs(options) do
				C[group][option] = value
			end
		end
	end
		
	B.SavePath = bdcUIConfig.db.profile
end




