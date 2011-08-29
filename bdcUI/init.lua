----------------------------------
-- Engine to make all files communicate.

-- Credit Nightcracker
----------------------------------
 
-- including system
local addon, engine = ...
engine[1] = {} -- B, functions, constants
engine[2] = {} -- C, config
engine[3] = {} -- L, localization
engine[4] = {} -- DB, database, post config load

bdcUI = engine --Allow other addons to use Engine

--[[
	This should be at the top of every file inside of the bdcUI AddOn:
	
	local B, C, L, DB = unpack(select(2, ...))

	This is how another addon imports the bdcUI engine:
	
	local B, C, L, DB = unpack(bdcUI)
]]