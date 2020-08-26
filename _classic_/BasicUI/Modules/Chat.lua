local MODULE_NAME = "Chat"
local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local MODULE = BasicUI:NewModule(MODULE_NAME, "AceEvent-3.0")
local L = BasicUI.L

------------------------------------------------------------------------
--	 Module Database
------------------------------------------------------------------------

local db
local defaults = {
	profile = {
		enable = true,
	}
}

------------------------------------------------------------------------
--	 Module Functions
------------------------------------------------------------------------

local classColor

local showLinkType = {
	-- 1 Normal tooltip things:
	achievement  = 1,
	enchant      = 1,
	glyph        = 1,
	item         = 1,
	instancelock = 1,
	quest        = 1,
	spell        = 1,
	talent       = 1,
	unit         = 1,
	currency       = 1,
	-- 2 Special tooltip things:
	battlepet           = 2,
	battlePetAbil       = 2,
	garrfollowerability = 2,
	garrfollower        = 2,
	garrmission         = 2,
}

local currentLinkType, itemRefLink, itemRefText, itemRefFrame
 
local function OnHyperlinkEnter(frame, link, text)
	currentLinkType = showLinkType[link:match("(%a+):%d+")]
	if currentLinkType == 1 then
		GameTooltip:SetOwner(ChatFrame1Tab, "ANCHOR_TOPLEFT", 20, 20)
		GameTooltip:SetHyperlink(link)
		GameTooltip:Show()
	elseif currentLinkType == 2 then
		-- Uses a special tooltip, just let the default function handle it.
		SetItemRef(link, text, "LeftButton", frame)
		itemRefLink, itemRefText, itemRefFrame = link, text, frame
	end
end

local function OnHyperlinkLeave(frame, link, text)
	if currentLinkType == 1 then
		GameTooltip:Hide()
	elseif currentLinkType == 2 then
		-- Uses a special tooltip, just let the default function handle it.
		SetItemRef(itemRefLink, itemRefText, "LeftButton", itemRefFrame)
		itemRefLink, itemRefText, itemRefFrame = nil,nil,nil
	end
	currentLinkType = nil
end
 
local function RegisterFrame(frame)
	frame:SetScript("OnHyperlinkEnter", OnHyperlinkEnter)
	frame:SetScript("OnHyperlinkLeave", OnHyperlinkLeave)
end
 
local cHyperLink = CreateFrame("Frame")
cHyperLink:RegisterEvent("PLAYER_LOGIN")
cHyperLink:SetScript("OnEvent", function(self, event, name)
	if event == "PLAYER_LOGIN" then
		for i = 1, NUM_CHAT_WINDOWS do
			RegisterFrame(_G["ChatFrame"..i])
		end
	end
	if GuildBankMessageFrame then
		RegisterFrame(GuildBankMessageFrame)
		self:UnregisterAllEvents()
		self:SetScript("OnEvent", nil)
		RegisterFrame = nil
	else
		self:RegisterEvent("ADDON_LOADED")
	end
end)

function MODULE:OnInitialize()
	self.db = BasicUI.db:RegisterNamespace(MODULE_NAME, defaults)
	db = self.db.profile	

	local _, class = UnitClass("player")
	classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]

	self:SetEnabledState(BasicUI:GetModuleEnabled(MODULE_NAME))
end

function MODULE:OnEnable()
	
	local type = type
	local select = select
	local gsub = string.gsub
	local format = string.format
	local HIDE_BUTTONS = false
	local FULL_MOVEMENT = false

	CHAT_FRAME_TAB_SELECTED_MOUSEOVER_ALPHA = 1
	CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = 0

	CHAT_FRAME_TAB_NORMAL_MOUSEOVER_ALPHA = 0.5
	CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = 0


	CHAT_FONT_HEIGHTS = {
		[1] = 8,
		[2] = 9,
		[3] = 10,
		[4] = 11,
		[5] = 12,
		[6] = 13,
		[7] = 14,
		[8] = 15,
		[9] = 16,
		[10] = 17,
		[11] = 18,
		[12] = 19,
		[13] = 20,
	}


	CHAT_FLAG_AFK = '[AFK] '
	CHAT_FLAG_DND = '[DND] '
	CHAT_FLAG_GM = '[GM] '

	CHAT_GUILD_GET = '(|Hchannel:Guild|hG|h) %s:\32'
	CHAT_OFFICER_GET = '(|Hchannel:o|hO|h) %s:\32'

	CHAT_PARTY_GET = '(|Hchannel:party|hP|h) %s:\32'
	CHAT_PARTY_LEADER_GET = '(|Hchannel:party|hPL|h) %s:\32'
	CHAT_PARTY_GUIDE_GET = '(|Hchannel:party|hDG|h) %s:\32'
	CHAT_MONSTER_PARTY_GET = '(|Hchannel:raid|hR|h) %s:\32'

	CHAT_RAID_GET = '(|Hchannel:raid|hR|h) %s:\32'
	CHAT_RAID_WARNING_GET = '(RW!) %s:\32'
	CHAT_RAID_LEADER_GET = '(|Hchannel:raid|hL|h) %s:\32'

	CHAT_BATTLEGROUND_GET = '(|Hchannel:Battleground|hBG|h) %s:\32'
	CHAT_BATTLEGROUND_LEADER_GET = '(|Hchannel:Battleground|hBL|h) %s:\32'

	CHAT_INSTANCE_CHAT_GET = '|Hchannel:INSTANCE_CHAT|h[I]|h %s:\32';
	CHAT_INSTANCE_CHAT_LEADER_GET = '|Hchannel:INSTANCE_CHAT|h[IL]|h %s:\32';


	local AddMessage = ChatFrame1.AddMessage
	local function FCF_AddMessage(self, text, ...)
		if (type(text) == 'string') then
			text = gsub(text, '(|HBNplayer.-|h)%[(.-)%]|h', '%1%2|h')
			text = gsub(text, '(|Hplayer.-|h)%[(.-)%]|h', '%1%2|h')
			text = gsub(text, '%[(%d0?)%. (.-)%]', '[%1]') 			
		end

		return AddMessage(self, text, ...)
	end

		-- Modify the editbox

	ChatFrame1EditBox:SetAltArrowKeyMode(false)
	ChatFrame1EditBox:ClearAllPoints()
	ChatFrame1EditBox:SetPoint('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', 2, 33)
	ChatFrame1EditBox:SetPoint('BOTTOMRIGHT', ChatFrame1, 'TOPRIGHT', 0, 33)
	ChatFrame1EditBox:SetBackdrop({
		bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
		edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
		tile = true, tileSize = 16, edgeSize = 18,
		insets = {left = 3, right = 3, top = 2, bottom = 3},
	})


	ChatFrame1EditBox:SetBackdropColor(0, 0, 0, 1)


		-- Move the Toast Frame
	BNToastFrame:HookScript('OnShow', function(self)
		BNToastFrame:ClearAllPoints()
		BNToastFrame:SetPoint('BOTTOMLEFT', ChatFrame1EditBox, 'TOPLEFT', 0, 15)
	end)


		-- Tab text colors for the tabs

	hooksecurefunc('FCFTab_UpdateColors', function(self, selected)
		if (selected) then
			self:GetFontString():SetTextColor(0, 0.75, 1)
		else
			self:GetFontString():SetTextColor(1, 1, 1)
		end
	end)

	hooksecurefunc('ChatEdit_UpdateHeader', function(editBox)
		local type = editBox:GetAttribute('chatType')
		if (not type) then
			return
		end

		local info = ChatTypeInfo[type]
		ChatFrame1EditBox:SetBackdropBorderColor(info.r, info.g, info.b)
	end)


	local function ModChat(self)
		local chat = _G[self]
		local font, fontsize, fontflags = chat:GetFont()
		
		if FULL_MOVEMENT == true then
			chat:SetClampedToScreen(false)
			chat:SetClampRectInsets(0, 0, 0, 0)
			chat:SetMaxResize(UIParent:GetWidth(), UIParent:GetHeight())
			chat:SetMinResize(150, 25)
		end

		if (self ~= 'ChatFrame2') then
			chat.AddMessage = FCF_AddMessage
		end

		if HIDE_BUTTONS == true then
			QuickJoinToastButton:SetAlpha(0)
			QuickJoinToastButton:EnableMouse(false)
			QuickJoinToastButton:UnregisterAllEvents()
			
			ChatFrameMenuButton:SetAlpha(0)
			ChatFrameMenuButton:EnableMouse(false)	
			
			local buttonUp = _G[self..'ButtonFrameUpButton']
			buttonUp:SetAlpha(0)
			buttonUp:EnableMouse(false)

			local buttonDown = _G[self..'ButtonFrameDownButton']
			buttonDown:SetAlpha(0)
			buttonDown:EnableMouse(false)

			local buttonBottom = _G[self..'ButtonFrameBottomButton']
			buttonBottom:SetAlpha(0)
			buttonBottom:EnableMouse(false)
		end
		
		--[[for _, texture in pairs({
			'ButtonFrameBackground',
			'ButtonFrameTopLeftTexture',
			'ButtonFrameBottomLeftTexture',
			'ButtonFrameTopRightTexture',
			'ButtonFrameBottomRightTexture',
			'ButtonFrameLeftTexture',
			'ButtonFrameRightTexture',
			'ButtonFrameBottomTexture',
			'ButtonFrameTopTexture',
		}) do
			_G[self..texture]:SetTexture(nil)
		end	

			-- Modify the editbox

		for k = 3, 8 do
			select(k, _G[self..'EditBox']:GetRegions()):SetTexture(nil)
		end]]

	end

	local function SetChatStyle()
		for _, v in pairs(CHAT_FRAMES) do
			local chat = _G[v]
			if (chat and not chat.hasModification) then
				ModChat(chat:GetName())

				chat.hasModification = true
			end
		end
	end
	hooksecurefunc('FCF_OpenTemporaryWindow', SetChatStyle)
	SetChatStyle()

	------------------------------------------------------------------------
	--	 add a sound notification on incoming whispers
	------------------------------------------------------------------------
	local SoundFrame = CreateFrame('Frame')
	SoundFrame:RegisterEvent('ADDON_LOADED')
	SoundFrame:RegisterEvent('CHAT_MSG_WHISPER')
	SoundFrame:RegisterEvent('CHAT_MSG_BN_WHISPER')
	SoundFrame:SetScript('OnEvent', function(_, event)
		if (event == 'CHAT_MSG_WHISPER' or event == 'CHAT_MSG_BN_WHISPER') then
			PlaySoundFile([[Interface\AddOns\BasicUI\Media\Whisper.mp3]])
		end
	end)	
end
------------------------------------------------------------------------
--	 Module options
------------------------------------------------------------------------

local options
function MODULE:GetOptions()
	if options then
		return options
	end

	local function isModuleDisabled()
		return not BasicUI:GetModuleEnabled(MODULE_NAME)
	end

	options = {
		type = "group",
		name = L[MODULE_NAME],
		get = function(info) return db[ info[#info] ] end,
		set = function(info, value) db[ info[#info] ] = value; StaticPopup_Show("CFG_RELOAD") end,
		disabled = isModuleDisabled(),
		args = {
			---------------------------
			--Option Type Seperators
			sep1 = {
				type = "description",
				order = 2,
				name = " ",
			},
			sep2 = {
				type = "description",
				order = 3,
				name = " ",
			},
			sep3 = {
				type = "description",
				order = 4,
				name = " ",
			},
			sep4 = {
				type = "description",
				order = 5,
				name = " ",
			},
			---------------------------
			Text1 = {
				type = "description",
				order = 1,
				name = " ",
				width = "full",
			},
			enable = {
				type = "toggle",
				order = 1,
				name = L["Enable"],
				desc = L["Enables the Chat Module for |cff00B4FFBasic|rUI."],
				width = "full",
				disabled = function() return isModuleDisabled() or not db.enable end,
			},
		},
	}
	return options
end