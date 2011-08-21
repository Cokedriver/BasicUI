----------------------------------
-- Engine to make all files communicate.

-- Credit Nightcracker
----------------------------------
 
-- including system
local addon, engine = ...
engine[1] = {} -- T, functions, constants, variables
engine[2] = {} -- C, config
engine[3] = {} -- L, localization

--	This should be at the top of every file inside of the _bdcUI AddOn:	
--	local T, C, L = unpack(select(2, ...))