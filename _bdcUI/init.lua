----------------------------------
-- Engine to make all files communicate.

-- Credit Nightcracker
----------------------------------
 
-- including system
local addon, engine = ...
engine[1] = {} -- DB, config
engine[2] = {} -- L, localization

--	This should be at the top of every file inside of the _bdcUI AddOn:	
--	local DB, L = unpack(select(2, ...))