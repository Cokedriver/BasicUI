
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_feralas_alliance
-- Date: 2011-06-12 21:34
-- Who: Crackerhead22
-- Log: Minor fixes.

-- URL: http://wow-pro.com/node/3243/revisions/24418/view
-- Date: 2011-05-25 02:26
-- Who: Crackerhead22
-- Log: Added notes, added cords, fixed cords, fixed notes, added 1 or 2 sticky steps. Added in Thousand Needles breadcrumb accept. Condensed code.

-- URL: http://wow-pro.com/node/3243/revisions/23958/view
-- Date: 2011-01-09 00:23
-- Who: kayeich
-- Log: Removed Dire Maul quests

-- URL: http://wow-pro.com/node/3243/revisions/23367/view
-- Date: 2010-12-03 11:21
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3243/revisions/23366/view
-- Date: 2010-12-03 11:20
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('WkjFer3540', 'Feralas', 'WKjezz', '35', '40', 'WkjTho4045', 'Alliance', function()
return [[

R Feralas|QID|14410|M|42.81,97.92|Z|Desolace|N|Run to Feralas.|
f Dreamer's Rest|QID|14410|M|50.21,16.72|N|At Selor.|
h Dreamer's Rest|QID|14410|M|51.02,17.97|N|At Andoril.|

T The Wilds of Feralas|QID|14410|M|50.6,17|N|To Telaron Windflight.|
A Signs of Change|QID|25447|M|50.67,17.11|N|From Telaron Windflight.|
A The Northspring Menace|QID|25448|M|51.13,17.81|N|From Erina Willowborn.|
A Dark Heart|QID|25654|M|51.13,17.81|N|From Erina Willowborn.|
C Signs of Change|QID|25447|S|M|43.58,22.24|N|Kill and loot Stag for their antlers.|
C The Northspring Menace|QID|25448|S|M|39.46,12.70|N|Kill Northspring Harpies and Windcallers.|
l Horn of Hatetalon|QID|25448|M|39,13|N|Kill and loot any type of Harpy until the horn drops.|L|9530|
C Dark Heart|QID|25654|U|9530|M|40.54,8.63|N|Head to the waypoint and use the Horn, kill and loot Edana Hatetalon.|
C The Northspring Menace|QID|25448|US|M|40.15,14.23|N|Kill Northspring Harpies and Windcallers.|
C Signs of Change|QID|25447|US|M|45.43,17.89|N|Kill and loot Stag for their antlers.|
T Signs of Change|QID|25447|M|50.65,17.13|N|To Telaron Windflight.|

A More Than Illness|QID|25394|M|50.65,17.13|N|From Telaron Windflight.|
T The Northspring Menace|QID|25448|M|51.13,17.80|N|To Erina Willowborn.|
T Dark Heart|QID|25654|M|51.13,17.80|N|To Erina Willowborn.|
C More Than Illness|QID|25394|M|46.81,9.55|N|Kill 10 Noxious Whelps.|
T More Than Illness|QID|25394|M|50.63,17.11|N|To Telaron Windflight.|
A Tears of Stone|QID|25396|M|50.63,17.11|N|From Telaron Windflight.|
A The Land, Corrupted|QID|25397|M|50.63,17.11|N|From Telaron Windflight.|
C Tears of Stone|QID|25396|S|M|41.71,22.54|N|Loot Stonetears (greenish looking crystals) off of the ground.|
C The Land, Corrupted|QID|25397|M|38.77,24.85|N|Kill Corrupted Cliff Giants.|
C Tears of Stone|QID|25396|US|M|40.70,24.16|N|Finish gathering Stonetears.|
T Tears of Stone|QID|25396|M|50.66,17.09|N|To Telaron Windflight.|
T The Land, Corrupted|QID|25397|M|50.66,17.09|N|To Telaron Windflight.|

A Sealing the Dream|QID|25398|M|50.66,17.09|N|From Telaron Windflight.|
C Sealing the Dream|QID|25398|U|52576|M|51.26,10.87|N|Head up to the portal and use Ysondre's Tear.|
T Sealing the Dream|QID|25398|M|50.66,17.20|N|To Telaron Windflight.|
A General Shandris Feathermoon|QID|26402|M|50.66,17.20|N|From Telaron Windflight.|
A The Mark of Quality|QID|25449|M|45.31,41.48|N|From Pratt McGrubben.|
f Feathermoon Stronghold|QID|26402|M|46.80,45.35|N|Get the Flight Path at irela Moonfeather.|
h Feathermoon Stronghold|QID|26402|M|46.14,45.24|N|At Innkeeper Shyria.|
T General Shandris Feathermoon|QID|26402|M|46.05,49.09|N|To Shandris Feathermoon, she is at the top of the building.|

A The Battle of Sardor|QID|25304|M|46.05,49.09|N|From Shandris Feathermoon.|
F Ruins of Feathermoon|QID|25304|M|46.80,45.35|N|Ask the flightmaster to take you there. (Speech Bubble)|
T The Battle of Sardor|QID|25304|M|32.65,45.61|N|To Tambre.|
A Hatecrest Forces|QID|25399|M|32.65,45.61|N|From Tambre.|
A General Skessesh|QID|25458|M|32.65,45.61|N|From Tambre.|
C Hatecrest Forces|QID|25399|S|M|29.98,50.81|N|Kill 10 Nagas.|
C General Skessesh|QID|25458|M|30.65,45.46|N|Kill and loot General Skessesh for his head.|
C Hatecrest Forces|QID|25399|US|M|31.26,45.64|N|Finish killing Nagas.|

R Feathermoon Stronghold|QID|25399|M|32.60,45.60|N|Run to Tambre, and ask for a ride back to Feathermoon Stronghold.|
T Hatecrest Forces|QID|25399|M|46.03,49.11|N|To Shandris Feathermoon.|
T General Skessesh|QID|25458|M|46.03,49.11|N|To Shandris Feathermoon.|
A Report to Silvia|QID|25463|M|46.03,49.11|N|From Shandris Feathermoon.|
A Still With The Zapped Giants|QID|25465|M|48.64,44.78|N|From Zorbin Fandazzle.|
A Even More Fuel for the Zapping|QID|25466|M|48.59,44.60|N|From Zorbin Fandazzle.|
R Rage Scar Hold|QID|25449|M|51.77,32.07|N|Head to Rage Scar Hold, killing Yetis as you go.|
C The Mark of Quality|QID|25449|M|54.99,32.28|N|Kill and loot Yetis.|
C Even More Fuel for the Zapping|QID|25466|S|M|38.89,35.96|N|Kill Water Elementals and loot them.|
C Still With The Zapped Giants|QID|25465|U|18904|M|37.43,35.98|N|Zap a giant with Zorbin's Ultra-Shrinker, then kill and loot it.|
C Even More Fuel for the Zapping|QID|25466|US|M|35.97,34.29|N|Finish looting Water Elemental Cores.|

H Feathermoon Stronghold|QID|25449|N|Hearth back to Feathermoon Stronghold, or run if your hearth is not up.|
T The Mark of Quality|QID|25449|M|45.36,41.29|N|To Pratt McGrubben.|
A Improved Quality|QID|25450|M|45.36,41.50|N|From Pratt McGrubben.|
T Still With The Zapped Giants|QID|25465|M|48.67,44.83|N|To Zorbin Fandazzle.|
T Even More Fuel for the Zapping|QID|25466|M|48.67,44.83|N|To Zorbin Fandazzle.|
f Tower of Estulan|QID|25463|M|57.08,53.88|N|At Aryenda.|
T Report to Silvia|QID|25463|M|56.85,55.05|N|To Silvia.|

A The Gordunni Threat|QID|25400|M|56.85,55.05|N|From Silvia.|
A The Gordunni Orb|QID|25401|M|56.85,55.05|N|From Silvia.|
A Adella's Covert Camp|QID|26574|M|56.85,54.98|N|From Silvia.|
A Forces of Nature: Wisps|QID|25407|M|57.02,53.81|N|From Handler Tessina.|
A The Lost Apprentice|QID|25350|M|57.19,55.03|N|From Vestia Moonspear.|
C Forces of Nature: Wisps|QID|25407|U|53101|M|56.10,53.37|N|Target the Feralas Wisps and blow the whistle. Should find pleantly floating in the camp.|
T Forces of Nature: Wisps|QID|25407|M|57.08,53.79|N|To Handler Tessina.|

A Forces of Nature: Hippogryphs|QID|25409|M|57.08,53.79|N|From Handler Tessina.|
l Pristine Yeti Hide|QID|25451|L|55166|N|Make sure to loot the Yetis until this drops.|M|52.07,58.33|S|
C Improved Quality|QID|25450|M|52.07,58.33|N|Kill and loot Yetis. Accept the quest from the 'OOX-22/FE Distress Beacon' to stop it from appearing on every kill.|U|8705|
A Find OOX-22/FE!|QID|25475|M|53.30,55.84|N|Accpet this quest from the beacon.|
T Find OOX-22/FE!|QID|25475|M|53.33,55.75|N|To Homing Robot OOX-22/FE.|
A Rescue OOX-22/FE!|QID|25476|M|53.33,55.75|N|From Homing Robot OOX-22/FE. This is optional since the quest turn-in is in Booty Bay, and will not be covered by this guide.|
C Rescue OOX-22/FE!|QID|25476|M|55.58,51.21|N|Escort OOX-22/FE to safety.|O|
l Pristine Yeti Hide|QID|25451|L|55166|N|Keep killing and looting Yetis until you get this.|M|52.07,58.33|US|
A Pristine Yeti Hide|QID|25451|U|55166|N|Accept this quest from the Pristine Yeti Hide.|M|52.07,58.33|

F Feathermoon Stronghold|QID|25450|N|Go back to camp and fly out to Feathermoon Stronghold again.|M|57.06,53.95|
T Improved Quality|QID|25450|M|45.34,41.33|N|To Pratt McGrubben.|
T Pristine Yeti Hide|QID|25451|M|45.34,41.33|N|To Pratt McGrubben.|
F Tower of Estulan|QID|25350|N|Go back to camp and fly out to the tower.|M|46.78,45.34|
C Forces of Nature: Hippogryphs|QID|25409|U|53104|M|55.28,71.07|N|You can actually stay mounted and do this.|
C The Gordunni Threat|QID|25400|S|M|58.47,70.02|N|Kill 16 of any type of Gordunni ogres.|
C The Gordunni Orb|QID|25401|M|57.47,71.00|N|Kill and loot Gordunni magic-casters until they drop an Orb.|
C The Gordunni Threat|QID|25400|US|M|61.28,71.58|N|Finish killing Gordunni ogres.|

R Darkmist Ruins|QID|25350|CC|M|62.11,64.06;63.27,62.26;63.91,62.19|N|Head to the Darkmist Ruins.|
T The Lost Apprentice|QID|25350|M|65.91,62.84|N|To Lost Apprentice.|
A The Darkmist Legacy|QID|25422|M|65.89,62.82|N|From Sensiria.|
A Ancient Suffering|QID|25423|M|65.85,62.78|N|From Sensiria.|
C Ancient Suffering|QID|25423|M|64.29,58.91|N|Kill and loot Highborn ghosts for the Soul Essences.|S|
C The Darkmist Legacy|QID|25422|M|63.93,59.85|N|Loot the Glowing Soil from around Darkmist Ruins.|
C Ancient Suffering|QID|25423|M|64.29,58.91|N|Finish gathering Soul Essences.|US|
T The Darkmist Legacy|QID|25422|M|65.90,62.81|N|To Sensiria.|
T Ancient Suffering|QID|25423|M|65.90,62.81|N|To Sensiria.|

A Verinias the Twisted|QID|25368|M|65.90,62.81|N|From Sensiria.|
C Verinias the Twisted|QID|25368|U|54456|M|64.33,56.02|N|Head to the waypoint, use the Mournful Essence and kill Verinias the Twisted.|
T Verinias the Twisted|QID|25368|M|65.90,62.79|N|To Sensiria.|
A Return to Vestia|QID|26401|M|65.90,62.79|N|From the Empty Pedestal.|
T Return to Vestia|QID|26401|M|57.19,54.90|N|To Vestia Moonspear.|
T The Gordunni Threat|QID|25400|M|56.92,54.90|N|To Silvia.|
A Gordok Guards|QID|25406|M|56.92,54.90|N|From Silvia.|
T The Gordunni Orb|QID|25401|M|56.92,54.90|N|To Silvia.|

A Estulan's Examination|QID|25402|M|56.92,54.90|N|From Silvia.|
T Forces of Nature: Hippogryphs|QID|25409|M|57.04,53.80|N|To Handler Tessina.|
A Forces of Nature: Treants|QID|25410|M|57.04,53.80|N|From Handler Tessina.|
T Estulan's Examination|QID|25402|M|56.95,55.41|N|To Estulan.|
A Ogre Abduction|QID|25403|M|56.95,55.41|N|From Estulan.|
r Repair and Sell Junk|QID|25410|M|56.80,54.37|
C Forces of Nature: Treants|QID|25410|U|53105|M|58.23,58.86|N|Again you can stay mounted (unless ambushed).|
T Forces of Nature: Treants|QID|25410|M|57.06,53.82|N|To Handler Tessina.|
C Gordok Guards|QID|25406|S|M|61.91,40.97|N|Kill Gordok Enforcers and Ogre-Mages.|
C Ogre Abduction|QID|25403|U|52833|M|58.40,46.37|N|Get a Gordock Ogre-Mage low in health, then use the orb on it.|
C Gordok Guards|QID|25406|US|M|57.11,44.63|N|Kill Gordok Enforcers and Ogre-Mages.|
T Gordok Guards|QID|25406|M|56.89,54.94|N|To Silvia.|
T Ogre Abduction|QID|25403|M|56.95,55.41|N|To Estulan.|

A Tell Silvia|QID|25208|M|56.95,55.41|N|From Estulan.|
T Tell Silvia|QID|25208|M|56.85,54.93|N|To Silvia.|
A Might of the Sentinels|QID|25333|M|56.85,54.93|N|From Silvia.|
C Might of the Sentinels|QID|25333|M|62.68,28.97|N|Head into Dire Maul. Go North every chance you can. You will come across an Arena. Drop into it and walk all the way to the north end of the Arena and wait. Kill the 2 Ogres that drop down, then stay alive once Cho'gall decends.|
H Feathermoon Stronghold|QID|25333|N|Hearth back to Feathermoon.|
F Tower of Estulan|QID|25333|N|Catch a flight path to the Tower.|
T Might of the Sentinels|QID|25333|M|56.89,54.98|N|To Silvia.|
T Adella's Covert Camp|QID|26574|M|77.21,56.53|N|To Adella it's a long run, be careful of the Horde outpost.|
f Shadebough|QID|25426|N|Get the flight path.|

A War on the Woodpaw|QID|25426|M|77.21,56.53|N|From Adella.|
A It's Not "Ogre" Yet|QID|25432|M|77.21,56.53|N|From Adella.|
A Forces of Nature: Faerie Dragons|QID|25468|M|76.99,56.59|N|From Handler Jesana.|
A Forces of Nature: Mountain Giants|QID|25469|M|76.99,56.59|N|From Handler Jesana.|
C Forces of Nature: Mountain Giants|QID|25469|U|58967|M|69.41,62.73|N|Again you can stay mounted, unless ambushed.|
C War on the Woodpaw|QID|25426|M|71.83,55.00|N|Kill and loot Woodpaw Gnolls to get their manes.|
C Forces of Nature: Faerie Dragons|QID|25468|U|58966|M|73.59,40.47|N|Use Jesana's Faerie Dragon Call on the Faerie Dragons. Again you can stay mounted, unless ambushed.|
C It's Not "Ogre" Yet|QID|25432|M|77.31,33.69|N|Kill 5 Gordunni Hillguards.|
T Forces of Nature: Faerie Dragons|QID|25468|M|76.98,56.61|N|To Handler Jesana.|
T Forces of Nature: Mountain Giants|QID|25469|M|76.98,56.61|N|To Handler Jesana.|
T War on the Woodpaw|QID|25426|M|77.19,56.52|N|To Adella.|

A Alpha Strike|QID|25427|M|77.19,56.52|N|From Adella.|
T It's Not "Ogre" Yet|QID|25432|M|77.19,56.52|N|To Adella.|
A Sasquatch Sighting|QID|25433|M|77.19,56.52|N|From Adella.|
A Taming The Tamers|QID|25434|M|77.19,56.52|N|From Adella.|
R Woodpaw Den|QID|25427|M|68.11,53.70;67.22,52.02|N|Run up to Woodpaw Den.|
C Alpha Strike|QID|25427|M|65.59,52.17|N|Have fun killing Woodpaw Alphas here.|
C Taming The Tamers|QID|25434|M|74.94,29.12|N|Kill 6 Gordunni Tamers.|S|
C Sasquatch Sighting|QID|25433|M|74.79,28.41|N|Kill Bigfist.|
C Taming The Tamers|QID|25434|M|74.94,29.12|N|Finish killing Gordunni Tamers.|US|
T Alpha Strike|QID|25427|M|77.22,56.57|N|To Adella.|
T Sasquatch Sighting|QID|25433|M|77.22,56.57|N|To Adella.|
T Taming The Tamers|QID|25434|M|77.22,56.57|N|To Adella.|

A Zukk'ash Infestation|QID|25429|M|77.22,56.57|N|From Adella.|
A Stinglasher|QID|25431|M|77.22,56.57|N|From Adella.|
C Zukk'ash Infestation|QID|25429|S|M|76.54,62.08|N|Kill and loot the bugs.|
C Stinglasher|QID|25431|M|78.32,62.74;73.47,63.52|N|Kill Stinglasher. It wanders between, and inside, the two hives. So look for the skull icon on your minimap.|T|Stinglasher|
C Zukk'ash Infestation|QID|25429|US|M|74.68,63.05|N|Kill and loot the bugs.|
T Stinglasher|QID|25431|M|77.18,56.50|N|To Adella.|
T Zukk'ash Infestation|QID|25429|M|77.18,56.50|N|To Adella.|

A Spiteful Sisters|QID|25436|M|77.18,56.50|N|From Adella.|
C Spiteful Sisters|QID|25436|M|79.79,45.19|N|Kill 8 Corrupted Dryads.|
T Spiteful Sisters|QID|25436|M|77.23,56.51|N|To Adella.|
A Ysondre's Call|QID|25437|M|77.23,56.51|N|From Adella.|

R The Emerald Summit|QID|25437|M|80.25,42.81|N|Run to the Emerald Summit.|
T Ysondre's Call|QID|25437|M|81.53,42.37|N|To Ysondre at the top of the Emerald Summit.|
A Taerar's Fall|QID|25379|M|81.53,42.37|N|From Ysondre.|
C Taerar's Fall|QID|25379|M|81.48,42.46|N|Help Ysondre kill Taerar.|
T Taerar's Fall|QID|25379|M|81.50,42.47|N|To Ysondre.|
A Ysondre's Farewell|QID|25438|M|81.50,42.47|N|From Ysondre.|
T Ysondre's Farewell|QID|25438|M|77.19,56.54|N|To Adella.|
A To New Thalanaar |QID|25481|M|77.2,56.4|N|From Falfindel Waywarder.|

N End of guide.|N|This is the End of Feralas. Time to go to Thousand Needles! I would recommend going to Darnassas now for training, banking, and auction needs. Our Thousand Needles guide starts there.|
]]

end)
