local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("bdcUIConfig", "enUS", true)
if not L then return end

-- Locale
L["bdcUI"] = true
L["Enables bdcUI"] = true
L["Open configuration dialog"] = true
L["Configure"] = true


--Buff Locale
L["Buffs"] = true
L["Buff Options"] = true
L["BUFF_DESC"] = "Rescale the size of your buffs."
L["Enable"] = true
L["Enables Buff Module"] = true
L["Scale"] = true
L["Controls the scaling of Blizzard's Buff Frames"] = true

		
-- Chat Locale	
L["Chat"] = true		
L["Chat Options"] = true
L["CHAT_DESC"] = "Modify the chat window and settings."
L["Enable"] = true
L["Enables Chat Module."] = true
L["Disable Fade"] = true
L["Disables Chat Fading."] = true
L["Chat Outline"] = true
L["Outlines the chat Text."] = true
L["Enable Bottom Button"] = true
L["Enables the scroll down button in the lower right hand corner."] = true
L["Enable Hyplerlink Tooltip"] = true
L["Enables the mouseover items in chat tooltip."] = true
L["Enable Editbox Channel Border Coloring"] = true
L["Enables the coloring of the border to the edit box to match what channel you are typing in."] = true
L["Tabs"] = true
L["TAB_DESC"] = "Tab Font Settings"
L["Font Scale"] = true
L["Controls the size of the tab font"] = true
L["Outline Tab Font"] = true
L["Enables the outlineing of tab font."] = true
L["Outline Tab Font"] = true
L["Enables the outlineing of tab font."] = true
L["Normal Tab Color"] = true
L["Enables the outlineing of tab font."] = true
L["Special Tab Color"] = true
L["Enables the outlineing of tab font."] = true
L["Selected Tab Color"] = true
L["Enables the outlineing of tab font."] = true


-- Datatext Locale
L["Datatexts"] = true
L["Enables Datatext Module."] = true
L["Datatext Options"] = true
L["DATATEXT_DESC"] = "Edit the display of information text on Datapanel"
L["DATATEXT_POS"] = "\n\n0 - Disabled\n1 - POSITION #1\n2 - POSITION #2\n3 - POSITION #3\n4 - POSITION #4\n5 - POSITION #5\n6 - POSITION #6\n7 - POSITION #7\n8 - POSITION #8\n9 - POSITION #9"
L["Text Positions"] = true
L["Datapanel Location"] = true
L["Checked puts panel on top of the screen, Unchecked puts panel below MainMenuBar."] = true
L["Threatbar"] = true
L["Display Threat Text in center of panel."] = true
L["BG Text"] = true
L["Display special datatexts when inside a battleground"] = true
L["Font size for datatexts"] = true
L["24-Hour Time"] = true
L["Display time datatext on a 24 hour time scale"] = true
L["Local Time"] = true
L["Display local time instead of server time"] = true
L["Class Color"] = true
L["Color the datatext values based on your class"] = true
L["Stat #1"] = true
L["Display stat based on your role (Avoidance-Tank, AP-Melee, SP/HP-Caster)"] = true
L["Durability"] = true
L["Display your current durability"] = true
L["Stat #2"] = true
L["Display stat based on your role (Armor-Tank, Crit-Melee, Crit-Caster)"] = true
L["System"] = true
L["Display FPS and Latency"] = true
L["Time"] = true
L["Display current time"] = true
L["Gold"] = true
L["Display current gold"] = true
L["Guild"] = true
L["Display current online people in guild"] = true
L["Friends"] = true	
L["Display current online friends"] = true
L["Bags"] = true
L["Display ammount of bag space"] = true
L["DPS"] = true
L["Display ammount of DPS"] = true
L["HPS"] = true	
L["Display ammount of HPS"] = true	
L["Currency"] = true	
L["Display current watched items in backpack"] = true
L["Talent Spec"] = true	
L["Display current spec"] = true
L["Bag Open"] = true
L["Checked opens Backpack only, Unchecked opens all bags."] = true
L["Professions"] = true
L["Display Professions"] = true
L["Micromenu"] = true
L["Display the Micromenu"] = true
L["Recount"] = true
L["Display Recount's DPS (RECOUNT MUST BE INSTALLED)"] = true
L["Recount Raid DPS"] = true
L["Display Recount's Raid DPS (RECOUNT MUST BE INSTALLED)"] = true
L["Call to Arms"] = true
L["Display the active roles that will recieve a reward for completing a random dungeon"] = true
L["Coordinates"] = true
L["Display Player's Coordinates"] = true
L["Zone"] = true
L["Display Player's Current Zone."] = true
	

-- Genaeral Locale
L["General"] = true
L["General Options"] = true
L["GENERAL_DESC"] = "General Modules for bdcUI"
L["Font"] = true
L["The font that the core of the UI will use"] = true
L["Autogreed"] = true
L["Enables Automatically rolling greed on green items when in a instance."] = true
L["Castbar"] = true
L["Enables count down of cast on castbar."] = true
L["Colors"] = true
L["Enables class colors for UI."] = true
L["Cooldown"] = true
L["Enables cooldown counts on action buttons."] = true
L["Mail"] = true
L["MAIL_DESC"] = "Enables Mailbox Modifications."
L["Enables Mail Module"] = true
L["Gold"] = true
L["Enables Gold Collect Button on Mailbox."] = true
L["Item"] = true
L["Enables Item Collect Button on Mailbox"] = true
L["Range"] = true
L["Enables action buttons to turn red when target is out of range."] = true
L["Unitframe Scale"] = true
L["SCALE_DESC"] = "Adjust the scale of Blizzards Unit Frames."
L["Enables Scale Module"] = true
L["Size"] = true
L["Controls the scaling of Blizzard's Unit Frames"] = true
L["Slash"] = true
L["Enables slash commands."] = true

		
-- Merchant Locale
L["Merchants"] = true
L["Merchant Options"] = true
L["MERCH_DESC"] = "Options for enteraction with a merchant"
L["Enable Merchant Settings"] = true
L["Sell Misc Items"] = true
L["Automatically sell a user selected item."] = true
L["Sell Grays"] = true
L["Automatically sell gray items when visiting a vendor"] = true
L["Auto Repair"] = true
L["Automatically repair when visiting a vendor"] = true


-- Powerbar Locale
L["Powerbar Options"] = true
L["POWER_DESC"] = "Powerbar for all classes with ComboPoints, Runes, Shards, and HolyPower."
L["Enables Powerbar Module"] = true
L["Width"] = true
L["Controls the width of Powerbar."] = true
L["CombatRegen"] = true
L["Shows a players Regen while in combat."] = true
L["Value"] = true
L["VALUE_DESC"] = "Shows the Value on the PowerBar"
L["Abbrev"] = true
L["Abbreviates the value. 17000 = 17K"] = true
L["Font Size"] = true
L["Controls the value font size."] = true
L["Font Outline"] = true
L["Adds a font outline to value."] = true
L["Soulshards"] = true
L["Shows Shards as a number value."] = true
L["Holypower"] = true
L["Shows Holypower as a number value."] = true
L["Extra"] = true
L["Extra_DESC"] = "Options for Soulshards and Holypower Text."
L["Font Size"] = true
L["Controls the Extra font size."] = true
L["Font Outline"] = true
L["Adds a font outline to Extra."] = true
L["Manabar"] = true
L["Shows Mana Powerbar."] = true
L["Energybar"] = true
L["Shows Energy Powerbar."] = true
L["ComboPoints"] = true
L["Combo"] = true
L["COMBO_DESC"] = "Options for ComboPoint Text"
L["Shows ComboPoints as a number value."] = true
L["Font Size"] = true
L["Controls the ComboPoints font size."] = true
L["Font Outline"] = true
L["Adds a font outline to ComboPoints."] = true
L["Focusbar"] = true
L["Shows Focus Powerbar."] = true
L["Ragebar"] = true
L["Shows Rage Powerbar."] = true
L["Runebar"] = true
L["Shows Rune Powerbar."] = true
L["Rune Cooldown"] = true
L["Rune"] = true
L["RUNE_DESC"] = "Options for Rune Text."
L["Shows Runes cooldowns as numbers."] = true
L["Font Size"] = true
L["Controls the Runes font size."] = true
L["Font Outline"] = true
L["Adds a font outline to Runes."] = true


-- Quest Locale
L["Quests"] = true
L["Quest Options"] = true
L["QUEST_DESC"] = "Options for autocompleting your quests."
L["Enables Quest Module"] = true
L["Autocomplete"] = true
L["Automatically complete your quest."] = true


-- Selfbuff Locale
L["Selfbuffs"] = true
L["Selfbuff Options"] = true
L["SELFBUFF_DESC"] = "Reminds player when they are missing there class buff."
L["Enables Selfbuff Module"] = true
L["Sound"] = true
L["Play's a warning sound when a players class buff is not applied."] = true

--Tooltip Locale
L["Tooltip Options"] = true
L["TOOLTIP_DESC"] = "Options for custom tooltip."
L["Enables Tooltip Module"] = true
L["Disable Fade"] = true
L["Disables Tooltip Fade."] = true
L["Reaction Border Color"] = true
L["Colors the borders match targets classcolors."] = true
L["Item Quality Border Color"] = true
L["Colors the border of the tooltip to match the items quality."] = true
L["Player Titles"] = true
L["Shows players title in tooltip."] = true
L["PVP Icons"] = true
L["Shows PvP Icons in tooltip."] = true
L["Abberviate Realm Names"] = true
L["Abberviates Players Realm Name."] = true
L["Mouseover Target"] = true
L["Shows mouseover target."] = true
L["Item Level"] = true
L["Shows targets average item level."] = true
L["Healthbar"] = true
L["HEALTH_DESC"] = "Players Healthbar Options"
L["Health Value"] = true
L["Shows health value over healthbar."] = true
L["Font Outline"] = true
L["Adds a font outline to health value."] = true
L["Text Position"] = true
L["Health Value Position."] = true
L["TOP"] = true
L["CENTER"] = true
L["BOTTOM"] = true
L["Reaction Coloring"] = true
L["Change healthbar color to targets classcolor."] = true
L["Font Size"] = true
L["Controls the healthbar value font size."] = true




--Profiles Locale
L["Profiles"] = true
L["CFG_RELOAD"] = "A setting you have changed requires a ReloadUI for changes to take effect, when you are done configing hit Accept to ReloadUI."
