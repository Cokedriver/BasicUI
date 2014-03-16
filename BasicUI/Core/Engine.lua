----------------------------------
-- Engine to make all files communicate.

-- Credit Nightcracker
----------------------------------
 
-- including system
local addon, engine = ...
engine[1] = {} -- B, functions, constants
engine[2] = {} -- C, config

BasicUI = engine --Allow other addons to use Engine

--[[
	This should be at the top of every file inside of the BasicUI AddOn:
	
	local B, C, DB = unpack(select(2, ...))

	This is how another addon imports the BasicUI engine:
	
	local B, C, DB = unpack(BasicUI)
]]