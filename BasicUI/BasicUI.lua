local BasicUI = LibStub("AceAddon-3.0"):NewAddon("BasicUI")
BasicUI.L =  setmetatable({}, { __index = function(t,k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })

local L = BasicUI.L
local db
local defaults = {
	profile = {
		modules = {
			["*"] = true,
		}
	}
}

StaticPopupDialogs["CFG_RELOAD"] = {
	text = L["One or more of the changes you have made require a ReloadUI."],
	button1 = ACCEPT,
	button2 = CANCEL,
	OnAccept = function() ReloadUI() end,
	timeout = 0,
	whileDead = 1,
}

function BasicUI:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("BasicDB", defaults, true) -- true is important!
	db = self.db.profile

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	local Dialog = LibStub("AceConfigDialog-3.0")

	local options = self:GetOptions()
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("BasicUI", options)
	Dialog:AddToBlizOptions("BasicUI", nil, nil, "general")

	local panels = {}
	for k, v in self:IterateModules() do
		if type(v.GetOptions) == "function" then
			options.args[k] = v:GetOptions()
			tinsert(panels, k)
		end
	end
	sort(panels)
	for i = 1, #panels do
		local k = panels[i]
		Dialog:AddToBlizOptions("BasicUI", options.args[k].name, "BasicUI", k)
	end

	options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.profile.order = -1
	Dialog:AddToBlizOptions("BasicUI", options.args.profile.name, "BasicUI", "profile")	
end

function BasicUI:OnEnable()
	-- set up stuff here
	
	db = self.db.profile
	
	PLAYER_NAME = UnitName("player")
	
	SlashCmdList['RELOADUI'] = function()
		ReloadUI()
	end
	SLASH_RELOADUI1 = '/rl'	
	
end

function BasicUI:Refresh()
	db = self.db.profile -- update the upvalue to point to the new profile

	-- change stuff here

	for k, v in self:IterateModules() do
		local isEnabled, shouldEnable = v:IsEnabled(), self:GetModuleEnabled(k)
		if shouldEnable and not isEnabled then
			self:EnableModule(k)
		elseif isEnabled and not shouldEnable then
			self:DisableModule(k)
		end
		if type(v.Refresh) == "function" then
			v:Refresh()
		end
	end
end

function BasicUI:GetModuleEnabled(moduleName)
	return db.modules[moduleName]
end

function BasicUI:SetModuleEnabled(moduleName, newState)
	local oldState = db.modules[moduleName]
	if oldState == newState then return end
	if newState then
		self:EnableModule(moduleName)
	else
		self:DisableModule(moduleName)
	end
end

local options
function BasicUI:GetOptions()
	options = options or {
		type = "group",
		name = "BasicUI",
		args = {
			general = { -- @PHANX: moved all the "welcome" text into a group, you'll see why later
				type = "group",
				order = 1,
				name = "General",
				get = function(info) return db.general[ info[#info] ] end,
				set = function(info, value) db.general[ info[#info] ] = value;   end,					
				args = {
					Text = {
						type = "description",
						order = 0,
						name = L["Welcome to |cff00B4FFBasic|rUI Config Area!"],
						width = "full",
						fontSize = "large",
					},
					Text2 = {
						type = "description",
						order = 1,
						name = L[" "],
						width = "full",
					},
					Text3 = {
						type = "description",
						order = 2,
						name = L["Special Thanks for |cff00B4FFBasic|rUI goes out to: "],
						width = "full",
						fontSize = "medium",
					},
					Text4 = {
						type = "description",
						order = 3,
						name = L["Phanx, Neav, Tuks, Elv, Baine, Treeston, and many more."],
						width = "full",
						fontSize = "large",
					},
					Text5 = {
						type = "description",
						order = 4,
						name = L[" "],
						width = "full",
						fontSize = "medium",
					},
					Text6 = {
						type = "description",
						order = 5,
						name = L["Thank you all for your AddOns, coding help, and support in creating |cff00B4FFBasic|rUI."],
						width = "full",
						fontSize = "medium",
					},						
				},
			},			
		}
	}
	return options
end