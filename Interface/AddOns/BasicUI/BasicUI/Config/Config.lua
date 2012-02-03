----------------------------------------------------------------------------
-- This Module loads new user settings if bdcUI_ConfigUI is loaded
----------------------------------------------------------------------------
local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

--Convert default database
for group,options in pairs(DB) do
	if not C[group] then C[group] = {} end
	for option, value in pairs(options) do
		C[group][option] = value
	end
end

if IsAddOnLoaded("BasicUI_Config") then
	local BasicUIConfig = LibStub("AceAddon-3.0"):GetAddon("BasicUIConfig")
	BasicUIConfig:Load()

	--Load settings from bdcUIConfig database
	for group, options in pairs(BasicUIConfig.db.profile) do
		if C[group] then
			for option, value in pairs(options) do
				C[group][option] = value
			end
		end
	end
		
	B.SavePath = BasicUIConfig.db.profile
end




