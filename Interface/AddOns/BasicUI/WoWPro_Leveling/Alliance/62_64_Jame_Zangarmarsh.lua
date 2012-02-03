
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_zangarmarsh_alliance
-- Date: 2012-01-18 21:58
-- Who: Ludovicus Maior
-- Log: Changed Fertile Spores from a N step to an l step.

-- URL: http://wow-pro.com/node/3273/revisions/24865/view
-- Date: 2011-12-13 20:18
-- Who: Crackerhead22

-- URL: http://wow-pro.com/node/3273/revisions/24834/view
-- Date: 2011-12-04 16:06
-- Who: Crackerhead22
-- Log: 4.3 updates

-- URL: http://wow-pro.com/node/3273/revisions/24556/view
-- Date: 2011-06-15 20:29
-- Who: Crackerhead22
-- Log: Minor tweaks.

-- URL: http://wow-pro.com/node/3273/revisions/24223/view
-- Date: 2011-04-05 23:37
-- Who: Ludovicus Maior

-- URL: http://wow-pro.com/node/3273/revisions/24206/view
-- Date: 2011-04-04 15:00
-- Who: Crackerhead22
-- Log: Some note changes.

-- URL: http://wow-pro.com/node/3273/revisions/24103/view
-- Date: 2011-02-08 01:08
-- Who: Ludovicus Maior
-- Log: Submitted by andyarnolduk on Mon, 2011-02-07 15:20.
--	
--	The waypoint for step 10 is a little off... it should be:
--	A Disturbance at Umbrafen Lake|QID|9716|M|78.40,62.10|N|From Ysiel Windsinger.|
--	Cheers
--	Andy
--	
--	[And lo, WowHead agrees.  Looks like a typo]

-- URL: http://wow-pro.com/node/3273/revisions/23945/view
-- Date: 2011-01-07 19:15
-- Who: Crackerhead22
-- Log: Fixed step sequence errors, fixed note errors, fixed missing cords, fixed missing |N| tags.

-- URL: http://wow-pro.com/node/3273/revisions/23941/view
-- Date: 2011-01-07 16:04
-- Who: Crackerhead22
-- Log: Added more missing |N| tags.

-- URL: http://wow-pro.com/node/3273/revisions/23940/view
-- Date: 2011-01-07 15:48
-- Who: Crackerhead22
-- Log: Added missing |N| tags, added sticky step.

-- URL: http://wow-pro.com/node/3273/revisions/23708/view
-- Date: 2010-12-09 00:11
-- Who: Crackerhead22
-- Log: Updated source with NPC notes, waypoints.

-- URL: http://wow-pro.com/node/3273/revisions/23686/view
-- Date: 2010-12-07 20:48
-- Who: Crackerhead22
-- Log: Corrected first line so it would auto-load.

-- URL: http://wow-pro.com/node/3273/revisions/23428/view
-- Date: 2010-12-03 12:12
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3273/revisions/23427/view
-- Date: 2010-12-03 12:11
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide("JamZan6264", "Zangarmarsh", "Jame", "62","64", "JamTer6466", "Alliance", function()
return [[

R Zangarmarsh|QID|9912|N|Go to Zangarmarsh.|M|82.9,65.08|
A The Umbrafen Tribe|QID|9747|M|80.40,64.20|N|From Ikeyen.|
A Plants of Zangarmarsh|QID|9802|M|80.30,64.20|N|From Lauranna Thar'well.|
A Leader of the Darkcrest|M|79.10,64.80|QID|9730|N|From the Wanted Poster.|
A Leader of the Bloodscale|M|79.10,64.80|QID|9817|N|From the Wanted Poster.|
A The Dying Balance|QID|9895|M|78.60,63.10|N|From Lethyn Moonfire.|
h Cenarion Refuge|QID|9912|N|Set your hearthstone to Cenarion Refuge.|M|78.50,63.00|
T The Cenarion Expedition|QID|9912|M|78.40,62.10|N|To Ysiel Windsinger.|
A Disturbance at Umbrafen Lake|QID|9716|M|78.40,62.10|N|From Ysiel Windsinger.|
A Warden Hamoot|QID|9778|M|78.40,62.10|N|From Ysiel Windsinger.|
; The quest "Checking up" on the following line has wrong caps on 'Up' so it does not auto-accept since it is optional.|
A Checking up|QID|29566|M|78.40,62.10|N|From Ysiel Windsinger. This quest leads into The Slave Pens, this is completely optional, there will be no follow up for it. Once you take it, feel free to join queue for The Slave Pens if you wish.|
T Warden Hamoot|QID|9778|M|79.10,65.20|N|To Warden Hamoot.|
A A Warm Welcome|QID|9728|M|79.10,65.20|N|From Warden Hamoot.|
r Sell junk, repair, restock|M|79.27,63.78|N|Repair at Fedryen Swiftwhisper.|QID|9901|

R Telredor|QID|9901|N|Use the platform here to get up to Telredor.|M|70.00, 49.00|CC|
A Fulgor Spores|QID|9777|M|68.6,48.7|N|From Ruam.|
A Unfinished Business|QID|9901|M|68.6,49.4|N|From Prospector Conall.|
A The Orebor Harborage|QID|9776|M|68.2,49.4|N|From Anchorite Ahuurn.|
A The Boha'mu Ruins|QID|9786|M|68.2,49.4|N|From Anchorite Ahuurn.|
A The Fate of Tuurem|QID|9793|M|68.3,50.1|N|From Vindicator Idaar.|
A The Dead Mire|QID|9782|M|68.3,50.1|N|From Vindicator Idaar.|
f Telredor|QID|9901|N|Get the flight-path.|M|67.80,51.5|
A Too Many Mouths to Feed|QID|9781|M|67.7,48.0|N|From Haalrun.|
A Menacing Marshfangs|QID|9791|M|67.7,48.0|N|From Noraani.|
C Menacing Marshfangs|N|Kill Marshfang Rippers needed for this quest.|M|85.00,47.0|QID|9791|S|
l Fulgor Spores|N|Loot the green mushroom looking things off the ground around Telredor, until you finish this quest.|M|67.00,50.0|QID|9777|L|24383 6|
l Fertile Spores|L|24449 6|N|From now on, kill then loot Sporebats, Greater Sporebats, Marsh Walkers and Fen Striders, and keep any Fertile Spores you find, you will need 6.|

C Unfinished Business|N|Go here, find, then kill Sporewing. It wanders between the waypoints.|M|77.00,45.0;79.52,47.75|QID|9901|T|Sporewing|
l Withered Basidium|QID|9901|N|Kill and loot Withered Giants until you get the Withered Basidium.|L|24483|S|
l Bog Lord Tendrils|QID|10355|N|Kill and loot Withered Giants and Withered Bog Lords until you get 6 Bog Lord Tendrils.|L|24291 6|S|
C The Dead Mire|N|Go to either waypoint and loot the soil that should be near it.|M|83.80,43.3;70.71,43.44|QID|9782|
l Withered Basidium|QID|9901|N|Kill Withered Giants until you get the Withered Basidium.|L|24483|US|
A Withered Basidium|N|Right-click the Withered Basidium to start this quest.|QID|9827|U|24483|M|78.3,45.2|
C Menacing Marshfangs|N|Kill the rest of the Marshfang Rippers for this quest.|M|85.00,47.0|QID|9791|US|
T Fulgor Spores|QID|9777|M|68.6,48.7|N|To Ruam.|
T Withered Basidium|QID|9827|M|68.6,48.7|N|To Ruam.|
A Withered Flesh|QID|10355|M|68.6,48.7|N|From Ruam.|
T Unfinished Business|QID|9901|M|68.6,49.4|N|To Prospector Conall.|
A Blacksting's Bane|QID|9896|M|68.6,49.4|N|From Prospector Conall.|
T The Dead Mire|QID|9782|M|68.3,50.1|N|To Vindicator Idaar.|
A An Unnatural Drought|QID|9783|M|68.3,50.1|N|From Vindicator Idaar.|
T Menacing Marshfangs|QID|9791|M|67.7,48.0|N|To Noraani.|
A Umbrafen Eel Filets|QID|9780|M|67.7,48.0|N|From Noraani.|

C An Unnatural Drought|N|Kill Withered Giants until you are finished this quest.|M|82.00,39.0|QID|9783|S|
C Withered Flesh|N|Kill and loot Hydras and Bog Lords for their various samples.|M|80.00,40.0|QID|10355|
C Plants of Zangarmarsh|N|Keep killing and looting mobs until you get the plant parts for this quest.|QID|9802|M|80.1,73.3|
C An Unnatural Drought|N|Kill mobs until you finish this quest.|M|82.00,39.0|QID|9783|US|
l Bog Lord Tendrils|QID|10355|N|Kill and loot Withered Giants and Withered Bog Lords until you get 6 Bog Lord Tendrils.|L|24291 6|US|
l Unidentified Plant Parts|QID|10355|N|Kill mobs until you have at least 30 Unidentified Plant Parts. Reason being that another quest opens when you are Friendly with the Cenarion Expedition.|L|24401 30|M|82.00,39.0|

T Withered Flesh|QID|10355|M|68.6,48.7|N|To Ruam.|
T An Unnatural Drought|QID|9783|M|68.3,50.1|N|To Vindicator Idaar.|
C Too Many Mouths to Feed|N|Kill the Hydras.|QID|9781|S|
C Umbrafen Eel Filets|S|N|Kill Eels until you have 8 Eel Filets. You may need to use the potion of underwater breathing.|QID|9780|M|74.2,60.7|
C Disturbance at Umbrafen Lake|N|Go to this spot to automatically finish this quest. Kill any Naga you come across as well.|M|69.40, 79.7|QID|9716|
C Too Many Mouths to Feed|N|Kill the rest of the Hydras needed for this quest in the lake.|QID|9781|US|
C Umbrafen Eel Filets|US|N|Kill Eels until you have 8 Eel Filets. You may need to use the Potion of Water Breathing.|QID|9780|M|74.2,60.7|
C The Dying Balance|N|Kill Boglash, he wanders so it may take a minute to find him.|M|82.00,74.0|QID|9895|T|Boglash|
C The Umbrafen Tribe|N|Kill the mobs needed for this quest. Kataru is at the location of the waypoint, at the top of the building.|M|85.00, 90.0|QID|9747|
A Escape from Umbrafen|QID|9752|M|83.4,85.5|N|From Kayra Longmane. If she isn't there, someone else is doing the quest, so just be patient.|
C Escape from Umbrafen|N|Do this Escort Quest. You will get ambushed twice by 2 Umbrafen each time.|QID|9752|M|83.4,85.5|

T The Umbrafen Tribe|QID|9747|M|80.4,64.2|N|At Ikeyen.|
A A Damp, Dark Place|QID|9788|M|80.4,64.2|N|From Ikeye.|
T Plants of Zangarmarsh|QID|9802|M|80.4,64.2|N|To Lauranna Thar'well.|
N Plant Parts|QID|9895|N|Turn in any plant parts you have. If you had 30 from before, then you should hit Friendly.|
A Saving the Sporeloks|QID|10096|M|80.4,64.2|N|From Lauranna Thar'well.|
A Blessings of the Ancients|QID|9785|M|80.4,64.7|N|From Windcaller Blackhoof.|
A Safeguarding the Watchers|QID|9894|M|80.4,64.7|N|From Windcaller Blackhoof.|
C Blessings of the Ancients|N|Talk to Keleth and Ashyen, giants walking around, and get the marks from them.|QID|9785|M|78.1,63.8|
T Blessings of the Ancients|QID|9785|M|80.4,64.7|N|To Windcaller Blackhoof.|
T The Dying Balance|QID|9895|M|78.5,63.1|N|To Lethyn Moonfire.|
A Watcher Leesa'oh|QID|9697|M|78.5,63.1|N|From Lethyn Moonfire.|
A What's Wrong at Cenarion Thicket?|QID|9957|M|78.5,63.1|N|From Lethyn Moonfire.|
T Disturbance at Umbrafen Lake|QID|9716|M|78.4,62.0|N|To Ysiel Windsinger.|
A As the Crow Flies|QID|9718|M|78.4,62.0|N|From Ysiel Windsinger.|
T Escape from Umbrafen|QID|9752|M|78.4,62.0|N|To Ysiel Windsinger.|
C As the Crow Flies|N|Use the Stormcrow Amulet to take a ride around the zone.|QID|9718|U|25465|
T As the Crow Flies|QID|9718|M|78.4,62.0|N|To Ysiel Windsinger.|
A Balance Must Be Preserved|QID|9720|M|78.4,62.0|N|From Ysiel Windsinger.|
r Sell junk, repair, restock|QID|9894|N|Make sure you do not sell the Bog Lord Tendrils, or any Fertile spores you have.|M|79.27, 63.78|

R Funggor Cavern|QID|9894|N|Go to the cave here.|M|74.80, 91.1|
C Saving the Sporeloks|N|Kill mobs until you are finished with this quest.|QID|10096|S|
C A Damp, Dark Place|QID|9788|N|After you enter the cave, go right at the first fork, then right again at the second fork and down the slope, Ikeyen's Belongings are down the bottom on top of a flat rock.|M|70.53,97.91|
C Safeguarding the Watchers|N|Kill Lord Klaq inside the cave.|M|72.00, 94.0|QID|9894|
C Saving the Sporeloks|N|Kill mobs until you are finished with this quest.|QID|10096|US|
L Level 63 or 50,000 xp|LVL|63|QID|9894|N|Kill mobs until you are level 63 or make 50,000 non-rested xp, whichever takes longer.|LVL|63|
U Umbrafen Lake Controls Disabled|QID|9720|QO|Umbrafen Lake Controls Disabled: 1/1|N|Use the ironvine seeds on the control panel at|M|70.5,80.|U|24355|
l Drain Schematics|QID|9731|N|Kill Steam Pump Overseers and loot the Schematics if he has it. Use the Ironvine Seeds on the Control Console to get more Overseers to spawn. Repeat until you get the Drain Schematics.|M|70.50, 80.3|L|24330|U|24355|
A Drain Schematics|N|Right click the Drain Schematics to start the quest.|QID|9731|U|24330|M|62.0,40.8|
C A Warm Welcome|S|N|Kill and loot Nagas for this quest.|QID|9728|M|70.9,82.1|
U Lagoon Controls Disabled|N|Go here and disable the pump with the Ironvine Seeds.|M|63.10,64.1|QID|9720|QO|Lagoon Controls Disabled: 1/1|U|24355|
C Leader of the Darkcrest|N|Kill Rajah Haghazed.|M|65.00,69.0|QID|9730|
C A Warm Welcome|US|N|Finish killing Nagas for their claws. You can use the seeds over and over again if you don't want to run around.|QID|9728|M|70.9,82.1;63.16,66.15|U|24355|
C Blacksting's Bane|N|Kill Blacksting and take his Stinger.|M|50.00,59.0|QID|9896|
C The Boha'mu Ruins|N|Go here to complete the quest.|M|44.20,68.9|QID|9786|
C Drain Schematics|N|Go here and dive underwater a bit until you get the quest complete message.|M|50.50,41.0|QID|9731|
U Serpent Lake Controls Disabled|QID|9720|QO|Serpent Lake Controls Disabled: 1/1|U|24355|N|Use the Ironvine Seeds here.|M|62.00,41.0|
C Leader of the Bloodscale|N|Kill Rajis Fyashe here.|M|65.00,41.0|QID|9817|
T Umbrafen Eel Filets|QID|9780|M|67.7,48.0|N|To Noraani.|
T Too Many Mouths to Feed|QID|9781|M|67.7,48.0|N|To Haalrun.|
A Diaphanous Wings|QID|9790|M|67.7,48.0|N|From Haalrun.|
T The Boha'mu Ruins|QID|9786|M|68.2,49.4|N|To Anchorite Ahuurn.|
A Idols of the Feralfen|QID|9787|M|68.2,49.4|N|From Anchorite Ahuurn.|
T Blacksting's Bane|QID|9896|M|68.6,49.4|N|To Prospector Conall.|

T Drain Schematics|QID|9731|M|78.4,62.0|N|To Ysiel Windsinger.|
A Warning the Cenarion Circle|QID|9724|M|78.4,62.0|N|From Ysiel Windsinger.|
T Safeguarding the Watchers|QID|9894|M|80.4,64.7|N|To Windcaller Blackhoof.|
T Saving the Sporeloks|QID|10096|M|80.4,64.2|N|To Lauranna Thar'well.|
T A Damp, Dark Place|QID|9788|M|80.4,64.2|N|To Ikeyen.|
N Plant Parts|QID|9724|N|Turn in any plant parts you have to Lauranna Thar'well.|M|80.4,64.2|
T A Warm Welcome|QID|9728|M|79.1,65.3|N|To Warden Hamoot.|
T Leader of the Bloodscale|QID|9817|N|To Warden Hamoot.|
T Leader of the Darkcrest|QID|9730|N|To Warden Hamoot.|
R Hellfire Peninsula|QID|9724|N|Go to Hellfire Peninsula.|M|83.00, 65.0|
T Warning the Cenarion Circle|QID|9724|M|15.7,52.0|Z|Hellfire Peninsula|N|To Amythiel Mistwalker.|
A Return to the Marsh|QID|9732|M|15.7,52.0|N|From Amythiel Mistwalker.|
H Cenarion Refuge|QID|9732|N|Hearth to Cenarion Refuge.|U|6948|M|78.50,63.00|
T Return to the Marsh|QID|9732|M|78.4,62.0|N|To Ysiel Windsinger.|
r Sell junk, repair, restock, train skills|QID|9732|N|Make sure you do not sell the Bog Lord Tendrils, or any Fertile spores you have.|M|79.27, 63.78|

f Orebor Harborage|QID|9776|N|Get the flight-path from Halu.|M|41.25, 29.0|
A Secrets of the Daggerfen|QID|9848|M|41.2,28.7|N|From Timothy Daniels.|
T The Orebor Harborage|QID|9776|M|41.9,27.2|N|To Ikuti.|
A Ango'rosh Encroachment|QID|9835|M|41.9,27.2|N|From Ikuti.|
A Daggerfen Deviance|QID|10115|M|41.9,27.2|N|From Ikuti.|
A Wanted: Chieftain Mummaki|QID|10116|M|41.7,27.3|N|From Wanted Poster.|
N From now on..|QID|9808|N|From now on, loot Glowcaps (red glowing mushrooms) off the ground. You will need 10 of them.|
C Ango'rosh Encroachment|N|Kill the Ogres needed for this quest.|M|36.00,28.0|QID|9835|S|
C Daggerfen Deviance|N|Kill the Daggerfen needed for this quest.|QID|10115|M|24,27|S|
l Daggerfen Poison Vial|N|Go in this area and loot the Daggerfen Poison Vial.|M|25.40,25.0|L|24500|
C Secrets of the Daggerfen|N|Go up the tower, and loot the manual from the ground.|M|24.40,27.0|QID|9848|
C Wanted: Chieftain Mummaki|N|Kill Mummaki and loot the item from him.|QID|10116|M|23.8,26.8|
C Daggerfen Deviance|N|Kill the Daggerfen needed for this quest.|QID|10115|US|M|24,27|
C Ango'rosh Encroachment|N|Kill the Ogres needed for this quest.|M|36.00,28.0|QID|9835|US|
T Secrets of the Daggerfen|QID|9848|M|41.2,28.7|N|To Timothy Daniels.|
T Ango'rosh Encroachment|QID|9835|M|41.9,27.2|N|To Ikuti.|
A Overlord Gorefist|QID|9839|M|41.9,27.2|N|From Ikuti.|
T Daggerfen Deviance|QID|10115|M|41.9,27.2|N|To Ikuti.|
T Wanted: Chieftain Mummaki|QID|10116|M|41.9,27.2|N|To Ikuti.|
A Natural Armor|QID|9834|M|41.6,27.3|N|From Maktu.|
A Stinger Venom|QID|9830|M|40.8,28.7|N|From Puluu.|
A Lines of Communication|QID|9833|M|40.8,28.7|N|From Puluu.|
A The Terror of Marshlight Lake|QID|9902|M|40.8,28.7|N|From Puluu.|

N From now on...|QID|9830|N|From now on, kill Umbraglow Stingers, Marshlight Bleeders, Bogflare Needlers, Marshfang Slicers, and Spore Bats|
T Watcher Leesa'oh|M|23.30, 66.2|QID|9697|N|To Watcher Leesa'oh.|
A Observing the Sporelings|QID|9701|M|23.3,66.2|N|From Watcher Leesa'oh.|
A The Sporelings' Plight|QID|9739|M|19.1,63.9|N|From Fahssn.|
A Natural Enemies|QID|9743|M|19.1,63.9|N|From Fahssn.|
T Natural Enemies|QID|9743|M|19.1,63.9|N|To Fahssn.|
l The Sporelings' Plight|N|Loot Mature Spore Sacs off the ground until you finish this quest.|QID|9739|M|14.5,61.6|L|24290 10|S|
C Observing the Sporelings|N|Go here to complete this quest.|M|13.00,60.0|QID|9701|
l The Sporelings' Plight|N|Loot Mature Spore Sacs off the ground until you finish this quest.|QID|9739|M|14.5,61.6|L|24290 10|US|
T The Sporelings' Plight|QID|9739|M|19.1,63.9|N|To Fahssn.|
N Neutral with Sporeggar|QID|9701|N|You have to be Neutral with the Sporeggar for the next portion this can be done by handing in Bog Lord Tendrils, more Mature Spore Sacs, or by grinding on mobs in the dead mire.|M|13.00,60.0|
A Sporeggar|QID|9919|M|19.1,63.9|N|From Fahssn.|
T Observing the Sporelings|M|23.30,66.2|QID|9701|N|To Watcher Leesa'oh.|
A A Question of Gluttony|QID|9702|M|23.3,66.2|N|From Watcher Leesa'oh.|
C A Question of Gluttony|N|Go here, killing giants on the way. Loot Discarded Nutriments off the ground until you get enough for this quest.|M|27.00,63.0|QID|9702|
T A Question of Gluttony|M|23.30,66.2|QID|9702|N|To Watcher Leesa'oh.|
A Familiar Fungi|QID|9708|M|23.3,66.2|N|From Leesa'oh.|
C Lines of Communication|N|Kill Slicers until you finish this quest.|QID|9833|M|32.8,59.1|S|
l "Count" Ungula's Mandible|QID|9911|N|Go here and look for a mob called Count Ungula. Kill it and loot the mandible.|M|33.00,60.0|L|25459 1|
A The Count of the Marshes|N|Right-click the Mandible to start the quest.|QID|9911|U|25459|M|32.8,59.1|
C Lines of Communication|N|Kill Slicers until you finish this quest.|QID|9833|M|32.8,59.1|US|
l Idols of the Feralfen|N|Kill mobs and loot Idols off the ground until you finish this quest.|M|49.60,59.7|QID|9787|L|24422 6|
C Natural Armor|N|Kill Fenclaw Trashers until you get the hides needed for this quest.|M|50.00,40.0|QID|9834|

H Cenarion Refuge|QID|9787|N|Hearth to Cenarion Refuge.|U|6948|M|78.59,62.87|
N Sell junk, repair, restock, turn in plant parts|QID|9787|N|Sell junk, repair, restock, turn in plant parts.|M|79.25, 63.7|
T Idols of the Feralfen|QID|9787|M|68.2,49.4|N|To Anchorite Ahuurn.|
A Gathering the Reagents|QID|9801|M|68.2,49.4|N|From Anchorite Ahuurn.|
F Orebor Harborage|QID|9834|N|Fly to Orebor Harborage|M|67.80, 51.5|
T Lines of Communication|QID|9833|M|40.8,28.7|N|To Puluu.|
T Natural Armor|QID|9834|M|41.6,27.3|N|To Maktu.|
A Maktu's Revenge|QID|9905|M|41.6,27.3|N|From Maktu.|
C Maktu's Revenge|N|Kill Mragash here.|M|42.00, 42.0|QID|9905|
C Familiar Fungi|N|Kill ogres until you get the Mushroom Samples for this quest.|M|35.00,34.0|QID|9708|
C Stinger Venom|N|Kill Marshlight Bleeders and bee mobs until you get the items needed for this quest.|M|20.00,30.0|QID|9830|
C Diaphanous Wings|N|Kill mobs until you get the wings for this quest.|M|20.00,30.0|QID|9790|
C Balance Must Be Preserved|N|Go here and use the Ironvine Seeds to disable the pump.|M|25.40,42.9|QID|9720|U|24355|
C The Terror of Marshlight Lake|N|Kill Terrorclaw here, Terrorclaw can fear.|M|22.20,45.3|QID|9902|

T Sporeggar|QID|9919|M|19.7,52.1|N|To Msshi'fn.|
A Glowcap Mushrooms|QID|9808|N|From Msshi'fn. Will disappear if you are friendly with Sporeggar.|M|19.7,52.1|
C Glowcap Mushrooms|N|Get the rest of the glowcaps needed for this quest.|M|40.00,36.3|QID|9808|
T Glowcap Mushrooms|QID|9808|N|To Msshi'fn.|M|19.7,52.1|
N Friendly with Sporeggar|QID|9708|M|19.11,63.51;15.33,61.15|N|Kill giants; turn in 10 Mature Spore Sacs (easiest to do, 2-3 turn-ins should get you friendly), or 6 Bog Lord Tendrils to Fahssn until you are friendly with Sporeggar.|
A Now That We're Friends...|QID|9726|M|19.5,50.0|N|From Gzhun'tt.|
A Oh, It's On!|QID|9717|N|From T'shu. Optional dungeon quest, skip if you do not want to do it.|
C Gathering the Reagents|N|Kill and loot Marsh Walkers, Fen Striders and Sporebats, until you finish this quest.|M|63.00,51.0|QID|9801|S|
T Familiar Fungi|M|23.30,66.2|QID|9708|N|To Watcher Leesa'oh.|
A Stealing Back the Mushrooms|QID|9709|M|23.3,66.2|N|From Watcher Leesa'oh.|
T The Count of the Marshes|QID|9911|M|23.3,66.2|N|To Watcher Leesa'oh.|

H Cenarion Refuge|QID|9720|N|Hearth to Cenarion Refuge.|U|6948|M|78.56,62.82|
T Balance Must Be Preserved|QID|9720|M|78.4,62.0|N|To Ysiel Windsinger.|
r Sell junk, repair, restock|QID|9801|N|Sell junk, repair, restock|M|79.23,63.7|
C Gathering the Reagents|N|Kill and loot Marsh Walkers, Fen Striders and Sporebats, until you finish this quest.|M|63.00,51.0|QID|9801|US|
T Gathering the Reagents|QID|9801|M|68.2,49.4|N|To Anchorite Ahuurn.|
A Messenger to the Feralfen|QID|9803|M|68.2,49.4|N|From Anchorite Ahuurn.|
T Diaphanous Wings|QID|9790|M|67.7,48.0|N|To Haalrun.|

F Orebor Harborage|QID|9902|N|Fly to Orebor Harborage.|M|67.80,51.4|N|
T Stinger Venom|QID|9830|M|40.8,28.7|N|To Puluu.|
T The Terror of Marshlight Lake|QID|9902|M|40.8,28.7|N|To Puluu.|
T Maktu's Revenge|QID|9905|M|41.6,27.3|N|To Maktu.|
h Orebor Harborage|QID|9726|N|Set your hearthstone to Orebor Harborage.|M|41.85,26.2|
l Stealing Back the Mushrooms|N|Loot mushrooms from the boxes scattered in the area. Can drop off of Ogres as well.|M|17.00,10.0|QID|9709|S|L|24240 10|
C Overlord Gorefist|N|Kill Overlord Gorefist, then kill the rest of the mobs needed for this quest.|M|18.00,8.0|QID|9839|
l Stealing Back the Mushrooms|N|Loot mushrooms from the boxes scattered in the area.|M|17.00,10.0|QID|9709|US|L|24240 10|
C Now That We're Friends...|N|Kill Bloodscale Slavedrivers and Enchantresses needed for this quest. Can drop off of Ogres as well.|M|26.00,36.0|QID|9726|
C Fertile Spores|N|Kill mobs until you get the spores for this quest.|M|20.00,16.0|QID|9806|
T Now That We're Friends...|QID|9726|M|19.5,50.0|N|To Gzhun'tt.|
T Fertile Spores|QID|9806|M|19.2,49.4|N|To Gshaff.|
T Stealing Back the Mushrooms|M|23.30,66.2|QID|9709|N|To Watcher Leesa'oh.|
C Messenger to the Feralfen|N|Go here and use Ahuurn's Elixir, then talk to Elder Kurutiin in the building, and go through the dialogue.|M|44.00,66.0|QID|9803|

H Orebor Harborage|QID|9839|N|Hearth to Orebor Harborage.|U|6948|M|41.89,26.29|
T Overlord Gorefist|QID|9839|M|41.9,27.2|N|To Ikuti.|
A A Message to Telaar|QID|9792|M|41.9,27.2|N|From Ikuti.|
F Telredor|QID|9803|N|Fly to Telredor.|M|41.30,29.0|
T Messenger to the Feralfen|QID|9803|M|68.2,49.4|N|
r Sell junk, repair, restock|QID|9803|N|Sell junk, repair, restock. Close this step to go to the next guide.|M|68.5,50.14|
]]
end)
