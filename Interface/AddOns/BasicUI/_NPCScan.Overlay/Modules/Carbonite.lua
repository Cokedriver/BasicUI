--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Modules/Carbonite.lua - Modifies the WorldMap and Minimap modules for      *
  *   compatibility with Carbonite.                                            *
  ****************************************************************************]]


if ( not IsAddOnLoaded( "Carbonite" ) ) then
	return;
end

local Overlay = select( 2, ... );
if ( NxData.NXGOpts.MapMMOwn ) then -- Minimap docked into WorldMap
	Overlay.Modules.Unregister( "Minimap" );
end
local WorldMap = Overlay.Modules.List[ "WorldMap" ];
if ( not ( WorldMap and WorldMap.Registered ) ) then
	return;
end

local CarboniteMap = NxMap1.NxM1;
local NS = CreateFrame( "Frame", nil, WorldMap );
Overlay.Modules.Carbonite = NS;




--- Repositions the canvas as the Carbonite map moves.
function NS:OnUpdate ()
	CarboniteMap:CZF( CarboniteMap.Con, CarboniteMap.Zon, WorldMap, 1 );
	WorldMap.RangeRing.Child:SetScale( WorldMap:GetScale() ); -- CarboniteMap:CZF also sets point
	WorldMap.KeyParent:SetAlpha( NxMap1.NxW.BaF ); -- Obey window's "Fade Out" setting
end




--- Adjusts the canvas when leaving Carbonite mode to view the default WorldMap.
function NS:WorldMapFrameOnShow ()
	if ( WorldMap.Loaded ) then
		NS:Hide(); -- Stop updating with Carbonite
		WorldMap.Toggle:Show();

		-- Undo Carbonite scaling/fading
		WorldMap:SetScale( 1 );
		WorldMap.RangeRing.Child:SetScale( 1 );
		WorldMap.KeyParent:SetAlpha( 1 );

		WorldMap:SetParent( WorldMapDetailFrame );
		WorldMap:SetAllPoints();

		WorldMap.KeyParent:SetParent( WorldMapButton );
		WorldMap.KeyParent:SetAllPoints();

		WorldMap.RangeRing:SetParent( WorldMapDetailFrame );
		WorldMap.RangeRing:SetAllPoints();
		WorldMap.RangeRingSetTarget( PlayerArrowEffectFrame );
	end
end
--- Adjusts the canvas when entering Carbonite mode.
function NS:WorldMapFrameOnHide ()
	if ( WorldMap.Loaded ) then
		NS:Show(); -- Begin updating with Carbonite
		WorldMap.Toggle:Hide();

		local ScrollFrame = CarboniteMap.TSF;
		WorldMap:SetParent( ScrollFrame:GetScrollChild() );
		WorldMap:ClearAllPoints();

		WorldMap.KeyParent:SetParent( ScrollFrame );
		WorldMap.KeyParent:SetAllPoints();

		WorldMap.RangeRing:SetParent( ScrollFrame );
		WorldMap.RangeRing:SetAllPoints();
		WorldMap.RangeRingSetTarget( CarboniteMap.PlF );
	end
end




local function OnUnload ()
	NS.OnUpdate = nil;
	if ( WorldMap.Loaded ) then
		NS:SetScript( "OnUpdate", nil );
	end
end
local function OnLoad ()
	NS:SetScript( "OnUpdate", NS.OnUpdate );

	-- Give the canvas an explicit size so it paints correctly in Carbonite mode
	WorldMap:SetSize( WorldMapDetailFrame:GetSize() );

	-- Hooks to swap between Carbonite's map mode and the default UI map mode
	WorldMapFrame:HookScript( "OnShow", NS.WorldMapFrameOnShow );
	WorldMapFrame:HookScript( "OnHide", NS.WorldMapFrameOnHide );
	NS[ WorldMapFrame:IsVisible() and "WorldMapFrameOnShow" or "WorldMapFrameOnHide" ]( WorldMapFrame );
end

--- Sets a module's handler, or hooks the old one if it exists.
local function HookHandler ( Name, Handler )
	local Backup = WorldMap[ Name ];
	WorldMap[ Name ] = not Backup and Handler or function ( ... )
		Backup( ... );
		Handler( ... );
	end;
end
if ( WorldMap.Loaded ) then
	OnLoad();
else
	HookHandler( "OnLoad", OnLoad );
end
HookHandler( "OnUnload", OnUnload );