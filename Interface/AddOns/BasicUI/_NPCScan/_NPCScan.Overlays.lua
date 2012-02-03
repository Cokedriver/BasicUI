--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Overlays.lua - Integration with NPC map overlay mods.             *
  ****************************************************************************]]


local AddOnName, _NPCScan = ...;
local NS = LibStub( "AceEvent-3.0" ):Embed( {} );
_NPCScan.Overlays = NS;

local MESSAGE_REGISTER = "NpcOverlay_RegisterScanner";
local MESSAGE_ADD = "NpcOverlay_Add";
local MESSAGE_REMOVE = "NpcOverlay_Remove";
local MESSAGE_FOUND = "NpcOverlay_Found";




--- Announces to overlay mods that _NPCScan will take over control of shown paths.
function NS.Register ()
	NS:SendMessage( MESSAGE_REGISTER, AddOnName );
end


--- Enables overlay maps for a given NPC ID.
function NS.Add ( NpcID )
	NS:SendMessage( MESSAGE_ADD, NpcID, AddOnName );
end
--- Disables overlay maps for a given NPC ID.
function NS.Remove ( NpcID )
	NS:SendMessage( MESSAGE_REMOVE, NpcID, AddOnName );
end
--- Lets overlay mods know the NPC ID was found.
function NS.Found ( NpcID )
	NS:SendMessage( MESSAGE_FOUND, NpcID, AddOnName );
end