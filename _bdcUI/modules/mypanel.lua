local panel = CreateFrame("FRAME")
panel.name = "_bdcUI"
InterfaceOptions_AddCategory(panel)

-- Autogree Options Panel		
local agpanel = CreateFrame("FRAME", "AutoGreedPanel");
agpanel.name = "AutoGreed";
agpanel.parent = "_bdcUI";

	
agpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(agpanel);

-- Buff Options Panel
local bpanel = CreateFrame("FRAME", "BuffPanel");
bpanel.name = "Buff";
bpanel.parent = "_bdcUI";

	
bpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(bpanel);

-- Castbar Options Panel
local cbpanel = CreateFrame("FRAME", "CastbarPanel");
cbpanel.name = "Castbar";
cbpanel.parent = "_bdcUI";

	
cbpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(cbpanel);


-- Chat Options Panel
local cpanel = CreateFrame("FRAME", "ChatPanel");
cpanel.name = "Chat";
cpanel.parent = "_bdcUI";

	
cpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(cpanel);


--Classcolor Options Panel
local ccpanel = CreateFrame("FRAME", "ClassColorPanel");
ccpanel.name = "ClassColor";
ccpanel.parent = "_bdcUI";

	
ccpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(ccpanel);


-- Cooldown Options Panel
local cdpanel = CreateFrame("FRAME", "CooldownPanel");
cdpanel.name = "Cooldown";
cdpanel.parent = "_bdcUI";

	
cdpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(cdpanel);


-- Datatext Options Panel
local dtpanel = CreateFrame("FRAME", "DatatextPanel");
dtpanel.name = "Datatext";
dtpanel.parent = "_bdcUI";

	
dtpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(dtpanel);


-- Macro Options Panel
local mapanel = CreateFrame("FRAME", "MacroPanel");
mapanel.name = "Macro";
mapanel.parent = "_bdcUI";

	
mapanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(mapanel);


-- Merchant Options Panel
local mepanel = CreateFrame("FRAME", "MerchantPanel");
mepanel.name = "AutoGreed";
mepanel.parent = "_bdcUI";

	
mepanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(mepanel);


-- Minimap Options Panel
local mmpanel = CreateFrame("FRAME", "MinimapPanel");
mmpanel.name = "Minimap";
mmpanel.parent = "_bdcUI";

	
mmpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(mmpanel);


-- Powerbar Options Panel
local pbpanel = CreateFrame("FRAME", "PowerbarPanel");
pbpanel.name = "Powerbar";
pbpanel.parent = "_bdcUI";

	
pbpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(pbpanel);


-- Quest Options Panel
local qpanel = CreateFrame("FRAME", "QuestPanel");
qpanel.name = "Quest";
qpanel.parent = "_bdcUI";

	
qpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(qpanel);


-- Unitframe Scale Options Panel
local ufspanel = CreateFrame("FRAME", "UFScalePanel");
ufspanel.name = "Unitframe Scale";
ufspanel.parent = "_bdcUI";

	
ufspanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(ufspanel);


-- Range Options Panel
local rpanel = CreateFrame("FRAME", "RangePanel");
rpanel.name = "Range";
rpanel.parent = "_bdcUI";

	
rpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(rpanel);


-- Selfbuff Options Panel
local sbpanel = CreateFrame("FRAME", "SelfbuffPanel");
sbpanel.name = "Selfbuff";
sbpanel.parent = "_bdcUI";

	
sbpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(sbpanel);


-- Slash Commands Options Panel
local scpanel = CreateFrame("FRAME", "SlashPanel");
scpanel.name = "Slash Commands";
scpanel.parent = "_bdcUI";

	
scpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(scpanel);


-- Tooltip Options Panel
local ttpanel = CreateFrame("FRAME", "TooltipPanel");
ttpanel.name = "Tooltip";
ttpanel.parent = "_bdcUI";

	
ttpanel.okay = 
	function ()
		ReloadUI()
	end	

InterfaceOptions_AddCategory(ttpanel);
