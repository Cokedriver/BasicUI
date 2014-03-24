local BasicUI = LibStub("AceAddon-3.0"):GetAddon("BasicUI")
local BasicUI_Quest = BasicUI:NewModule("Quest", "AceEvent-3.0")

-----------
-- Quest --
-----------
function BasicUI_Quest:OnEnable()
	local db = BasicUI.db.profile
	-- Credit for Quest goes to nightcracker for his ncQuest addon.
	-- You can find his addon at http://www.wowinterface.com/downloads/info14972-ncQuest.html
	-- Editied by Cokedriver

	if db.quest.enable then

		local f = CreateFrame("Frame")

		local function MostValueable()
			local bestp, besti = 0
			for i=1,GetNumQuestChoices() do
				local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
				local price = link and select(11, GetItemInfo(link))
				if not price then
					return
				elseif (price * (qty or 1)) > bestp then
					bestp, besti = (price * (qty or 1)), i
				end
			end
			if besti then		
				local btn = _G["QuestInfoItem"..besti]
				if (btn.type == "choice") then
					btn:GetScript("OnClick")(btn)
				end
			end
		end
		
		f:RegisterEvent("QUEST_ITEM_UPDATE")
		f:RegisterEvent("GET_ITEM_INFO_RECEIVED")	
		f:RegisterEvent("QUEST_ACCEPT_CONFIRM")    
		f:RegisterEvent("QUEST_DETAIL")
		f:RegisterEvent("QUEST_COMPLETE")
		f:SetScript("OnEvent", function(self, event, ...)
			if db.quest.autocomplete ~= false then
				if (event == "QUEST_DETAIL") then
					AcceptQuest()
					CompleteQuest()
				elseif (event == "QUEST_COMPLETE") then
					if (GetNumQuestChoices() and GetNumQuestChoices() < 1) then
						GetQuestReward()
					else
						MostValueable()
					end
				elseif (event == "QUEST_ACCEPT_CONFIRM") then
					ConfirmAcceptQuest()
				end
			else
				if (event == "QUEST_COMPLETE") then
					if (GetNumQuestChoices() and GetNumQuestChoices() < 1) then
						GetQuestReward()
					else
						MostValueable()
					end
				end
			end
		end)

	end


	if db.vendor.enable then

		local timeout = CreateFrame("Frame")
		timeout:Hide()

		local f = LibStub("tekShiner").new(QuestRewardScrollChildFrame)
		f:Hide()


		f:RegisterEvent("QUEST_COMPLETE")
		f:RegisterEvent("QUEST_ITEM_UPDATE")
		f:RegisterEvent("GET_ITEM_INFO_RECEIVED")
		f:SetScript("OnEvent", function(self, ...)
			self:Hide()
			local bestp, besti = 0
			for i=1,GetNumQuestChoices() do
				local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
				if not link then
					timeout:Show()
					return
				end
				local price = link and select(11, GetItemInfo(link))
				if not price then return
				elseif (price * (qty or 1)) > bestp then bestp, besti = (price * (qty or 1)), i end
			end

			if besti then
				self:ClearAllPoints()
				self:SetAllPoints("QuestInfoItem"..besti.."IconTexture")
				self:Show()
			end
		end)


		local elapsed
		timeout:SetScript("OnShow", function() elapsed = 0 end)
		timeout:SetScript("OnHide", function() f:GetScript("OnEvent")(f) end)
		timeout:SetScript("OnUpdate", function(self, elap)
			elapsed = elapsed + elap
			if elapsed < 1 then return end
			self:Hide()
		end)

		if QuestInfoItem1:IsVisible() then f:GetScript("OnEvent")(f) end
		
	end
end