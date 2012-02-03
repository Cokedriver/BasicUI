
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_wetlands
-- Date: 2011-07-01 16:05
-- Who: Fluclo
-- Log: Added Rank 2 tag to quests in Dun Algaz, for those wanting to get straight into the Wetlands action!

-- URL: http://wow-pro.com/node/3224/revisions/24592/view
-- Date: 2011-06-25 01:04
-- Who: Crackerhead22
-- Log: ! Line 200 for step C has unknown tag [53.33,54.44]: [C The Angerfang Menace|QID|26189|QO|Angerfang Dragonmaw slain: 16/16M|53.33,54.44|N|Kill Angerfang Dragonmaw Orcs.|US|] - Fixed

-- URL: http://wow-pro.com/node/3224/revisions/24522/view
-- Date: 2011-06-08 00:29
-- Who: Crackerhead22
-- Log: Added missing notes, fixed some notes, added more info for some notes. Fixed a couple of stickies, added a sticky step or two.

-- URL: http://wow-pro.com/node/3224/revisions/24487/view
-- Date: 2011-06-01 13:40
-- Who: Fluclo
-- Log: Gizmos and Gadgets and The Mosshide Job done together

-- URL: http://wow-pro.com/node/3224/revisions/24486/view
-- Date: 2011-06-01 13:29
-- Who: Fluclo
-- Log: Unsticky Claws from the Deep which was stickied earlier

-- URL: http://wow-pro.com/node/3224/revisions/24485/view
-- Date: 2011-06-01 13:23
-- Who: Fluclo
-- Log: When Life Gives You Crabs and A Mother's Worries can be done at same time

-- URL: http://wow-pro.com/node/3224/revisions/24484/view
-- Date: 2011-06-01 13:22
-- Who: Fluclo
-- Log: Typo

-- URL: http://wow-pro.com/node/3224/revisions/24467/view
-- Date: 2011-05-31 21:02
-- Who: Ludovicus Maior
-- Log: Two Extra [A The Battle of Thandol Span|QID|26128|M|50.75,49.97|Z|] stuck at the end!

-- URL: http://wow-pro.com/node/3224/revisions/23662/view
-- Date: 2010-12-06 23:38
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3224/revisions/23318/view
-- Date: 2010-12-03 07:40
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3224/revisions/23317/view
-- Date: 2010-12-03 07:40
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('WkjWet2025', 'Wetlands', 'Wkjezz', '20', '25', 'BitAra2025', 'Alliance', function()
return [[

A Checking on the Boys|QID|26137|M|25.55,17.79|Z|Loch Modan|N|From Mountaineer Stormpike.|
T Checking on the Boys|QID|26137|M|49.96,79.24|N|To Mountaineer Rharen.|
A The Stolen Keg|QID|25395|M|49.96,79.24|N|From Mountaineer Rharen.|RANK|2|
A Cleaning Hovel|QID|25211|M|49.96,79.24|N|From Mountaineer Grugelm.|RANK|2|
C Cleaning Hovel|QID|25211|S|M|47.99,75.41|N|Kill 5 Dragonmaw Orcs.|RANK|2|
C The Stolen Keg|QID|25395|M|47.86,74.35|N|This is in the top of the bunker.|RANK|2|
C Cleaning Hovel|QID|25211|US|M|47.99,75.41|N|Kill 5 Dragonmaw Orcs.|RANK|2|
T Cleaning Hovel|QID|25211|M|49.88,79.19|N|To Mountaineer Grugelm.|RANK|2|
T The Stolen Keg|QID|25395|M|49.90,79.19|N|To Mountaineer Rharen.|RANK|2|

A Keg Run|QID|25770|M|50.00,79.18|N|From Mountaineer Rharen.|RANK|2|
R Wetlands|QID|25770,25721,25722,25723|M|48.23,67.29;49.23,70.51;53.93,70.37|N|Follow the path until you get to Wetlands.|
f Slabchisel's Survey|QID|25770|M|56.87,71.17|N|At Elgin Baelor.|
T Keg Run|QID|25770|M|57.48,71.76|N|To Forba Slabchisel.|RANK|2|

A Fight the Flood|QID|25721|M|57.48,71.76|N|From Forba Slabchisel.|
A Sedimentary, My Dear|QID|25722|M|57.57,71.54|N|From Surveyor Thurdan.|
A Thresh Out of Luck|QID|25723|M|57.73,71.53|N|From Dunlor Marblebeard.|
r Repair/Restock|QID|25722|M|57.73,71.44|N|At Darvish Quickhammer.|
C Fight the Flood|QID|25721|S|M|64.51,67.95|N|Kill the Flood Elementals.|
C Thresh Out of Luck|QID|25723|S|M|64.25,70.07|N|Kill and loot Threshers.|
C Sedimentary, My Dear|QID|25722|M|63.77,74.00|N|Click on Sediment Deposits in the water.|
C Thresh Out of Luck|QID|25723|US|M|64.25,70.07|N|Kill and loot Threshers.|
C Fight the Flood|QID|25721|US|M|64.51,67.95|N|Kill the Flood Elementals.|
T Thresh Out of Luck|QID|25723|M|57.93,71.46|N|To Dunlor Marblebeard.|

A Fenbush Berries|QID|25725|M|57.92,71.47|N|From Dunlor Marblebeard.|
T Fight the Flood|QID|25721|M|57.55,71.76|N|To Forba Slabchisel.|
A Drungeld Glowerglare|QID|25727|M|57.55,71.76|N|From Forba Slabchisel.|
T Sedimentary, My Dear|QID|25722|M|57.57,71.48|N|To Surveyor Thurdan.|
A A Dumpy Job|QID|25726|M|57.60,71.45|N|From Surveyor Thurdan.|
C Fenbush Berries|QID|25725|S|M|63.29,76.08|N|Loot the sparkling Fenbush Berry bushes from around the lake.|
C Drungeld Glowerglare|QID|25727|M|63.82,78.19|N|In the cave by the lake, kill and loot Drungeld.|
C Fenbush Berries|QID|25725|US|M|63.29,76.08|N|Loot the sparkling Fenbush Berry bushes.|
C A Dumpy Job|QID|25726|M|55.71,72.21|N|Kill and loot Silty Oozelings until you have a Dumpy level in your bags.|
T A Dumpy Job|QID|25726|M|57.43,71.47|N|To Surveyor Thurdan.|
A Down In Thelgen Rock|QID|25734|M|57.43,71.47|N|From Surveyor Thurdan.|
T Fenbush Berries|QID|25725|M|57.83,71.50|N|To Dunlor Marblebeard.|
A Incendicite Ore|QID|25735|M|57.82,71.61|N|From Dunlor Marblebeard.|
T Drungeld Glowerglare|QID|25727|M|57.57,71.80|N|To Forba Slabchisel.|

A Get Out Of Here, Stalkers|QID|25733|M|57.55,71.79|N|From Forba Slabchisel.|
C Get Out Of Here, Stalkers|QID|25733|QO|Leech Stalker slain: 7/7|M|54.10,63.39|N|Kill spiders by the cave until you have killed 7 Leech Stalkers.|
R Thelgen Rock Cave|QID|25733|CC|M|52.05,62.73|N|Run into this cave.|
C Get Out Of Here, Stalkers|QID|25733|S|M|53.99,66.00|N|Kill Cave Stalkers.|
C Incendicite Ore|QID|25735|S|U|55240|M|47.82,65.97|N|Gather Incedicite Ore.|
C Down In Thelgen Rock|QID|25734|NC|M|47.78,65.99|N|Keep to the left as you go through the cave. Pick up the Thelgen Seismic Record.|
A The Floodsurge Core|QID|25736|U|55243|N|Kill Torrention who will appear behind you. Loot , then accept this quest from the Floodsurge Core.|
C Incendicite Ore|QID|25735|US|U|55240|M|47.82,65.97|N|Gather Incedicite Ore.|
C Get Out Of Here, Stalkers|QID|25733|US|M|48.54,60.83|N|Kill CaveStalkers.|
T Get Out Of Here, Stalkers|QID|25733|M|57.46,71.81|N|To Forba Slabchisel.|
T The Floodsurge Core|QID|25736|M|57.46,71.81|N|To Forba Slabchisel.|
T Down In Thelgen Rock|QID|25734|M|57.50,71.49|N|To Surveyor Thurdan.|
T Incendicite Ore|QID|25735|M|57.83,71.63|N|To Dunlor Marblebeard.|

A Onwards to Menethil|QID|25777|M|57.47,71.79|N|From Forba Slabchisel.|
r Repair/Restock|QID|25777|M|57.69,71.35|N|At Darvish Quickhammer.|
R Menethil Harbor|QID|25777|M|57.07,71.67;10.53,55.66|N|Click on Brisket, the Ram you see, to get a free ride to Menethil Harbor.|
T Onwards to Menethil|QID|25777|M|10.53,55.66|N|To Captain Stoutfist.|
A Assault on Menethil Keep|QID|25780|M|10.53,55.66|N|From Captain Stoutfist.|
C Assault on Menethil Keep|QID|25780|M|9.91,57.60|N|Work your way to the upper room of the keep, then kill Horghast Flarecrazed.|
T Assault on Menethil Keep|QID|25780|M|10.50,55.71|N|To Captain Stoutfist.|
A A Mother's Worries|QID|25820|M|11.83,57.90|N|From Derina Rumdnul.|
A When Life Gives You Crabs|QID|25800|M|11.18,57.72|N|From Karl Boran.|
A The Third Fleet|QID|25815|M|10.86,59.59|N|From First Mate Fitzsimmons.|
h Deepwater Tavern|QID|25815|M|10.66,61.02|N|At Innkeeper Helbrek.|
C The Third Fleet|QID|25815|M|10.64,61.69|N|In the cellar, loot the Fitzsimmons' Mead.|
T The Third Fleet|QID|25815|M|10.90,59.70|N|To First Mate Fitzsimmons.|

A Cursed to Roam|QID|25816|M|10.90,59.70|N|From First Mate Fitzsimmons.|
f Menethil Harbor|QID|25820|M|09.53,59.56|N|From Shellei Brondir.|
C When Life Gives You Crabs|QID|25800|S|M|19.85,59.98|N|Kill the crabs and loot them.|
C A Mother's Worries|QID|25820|M|19.42,58.34|N|Kill the sharks.|
C When Life Gives You Crabs|QID|25800|US|M|19.85,59.98|N|Kill the crabs and loot them.|
T A Mother's Worries|QID|25820|M|11.79,57.85|N|To Derina Rumdnul.|
T When Life Gives You Crabs|QID|25800|M|11.18,57.85|N|To Karl Boran.|
A Claws from the Deep|QID|25801|M|11.18,57.85|N|From Karl Boran.|
A Reclaiming Goods|QID|25802|M|11.18,57.85|N|From Karl Boran.|
C Claws from the Deep|QID|25801|S|QO|Bluegill Murloc slain: 12/12|M|8.33,58.56|N|Kill Murlocs as you travel.|
T Reclaiming Goods|QID|25802|M|13.53,41.48|N|To the Damaged Crate.|

A The Search Continues|QID|25803|M|13.53,41.48|N|From the Damaged Crate.|
T The Search Continues|QID|25803|M|13.66,38.26|N|To the Sealed Barrel.|
A Search More Hovels|QID|25804|M|13.66,38.26|N|From the Sealed Barrel.|
K Gobbler|QID|25801|L|3618 |M|14.43,37.44|N|Kill and loot Gobbler.|
T Search More Hovels|QID|25804|M|13.93,34.90|N|To the Half-Buried Barrel|
A Return the Statuette|QID|25805|M|13.93,34.90|N|From the Half-Buried Barrel|
C Claws from the Deep|QID|25801|QO|Bluegill Murloc slain: 12/12|M|15.13,31.76|N|Finish killing Murlocs.|US|
T Cursed to Roam|QID|25816|M|15.25,29.48|N|To First Mate Snellig.|
A The Cursed Crew|QID|25817|M|15.25,29.48|N|From First Mate Snellig.|
C The Cursed Crew|QID|25817|M|14.06,24.34|N|Kill Cursed Sailors and Marines between the two ships.|
T The Cursed Crew|QID|25817|M|15.23,29.43|N|To First Mate Snellig.|
A Lifting the Curse|QID|25818|M|15.17,29.23|N|From First Mate Snellig.|
C Lifting the Curse|QID|25818|M|15.08,23.79|N|Kill and loot Captain Halyndor, he is on deck near the wheel.|
T Lifting the Curse|QID|25818|M|14.37,24.02|N|Jump off the northside of the boat, swim down to the bottom of the ship and look for a hole. Swim in and turn the quest into the Intrepid's Locked Strongbox.|

A The Eye of Paleth|QID|25819|M|14.37,24.02|N|From the Intrepid's Locked Strongbox.|
H Menethil Harbor|QID|25819|M|10.58,60.59|N|Hearth back to Menethal Harbor.|
T The Eye of Paleth|QID|25819|M|10.61,60.56|N|To Glorin Steelbrow.|
T Claws from the Deep|QID|25801|M|11.14,57.76|N|To Karl Boran.|
T Return the Statuette|QID|25805|M|11.14,57.76|N|To Karl Boran.|
A Swiftgear Station|QID|26980|M|10.47,55.70|N|From Captain Stoutfist.|
T Swiftgear Station|QID|26980|M|26.83,26.14|N|To Shilah Slabchisel.|
A Dinosaur Crisis|QID|25864|M|26.83,26.14|N|From Shilah Slabchisel.|
A I'll Call Him Bitey|QID|25854|M|26.81,25.97|N|From Fradd Swiftgear.|
A Crocolisk Hides|QID|25856|M|26.77,26.64|N|From James Halloran.|
r Repair/Restock|QID|25856|M|25.67,25.86|N|At Wenna Silkbeard.|
C Crocolisk Hides|QID|25856|S|M|27.23,23.21|N|Kill and loot any Crocolisk you see.|
C Dinosaur Crisis|QID|25864|M|39.28,20.68|N|Kill 8 Highland Raptors.|S|
C I'll Call Him Bitey|QID|25854|M|35.45,20.20|N|Collect 6 Wobbling Raptor Eggs.|
C Dinosaur Crisis|QID|25864|M|39.28,20.68|N|Kill 8 Highland Raptors.|US|
C Crocolisk Hides|QID|25856|US|M|27.23,23.21|N|Kill and loot any Crocolisk you see.|
T Dinosaur Crisis|QID|25864|M|26.98,26.03|N|To Shilah Slabchisel.|

A The Mosshide Job|QID|25865|M|26.98,26.03|N|From Shilah Slabchisel.|
T Crocolisk Hides|QID|25856|M|26.79,26.63|N|To James Halloran.|
A Hunting Horrorjaw|QID|25857|M|26.75,26.63|N|From James Halloran.|
T I'll Call Him Bitey|QID|25854|M|26.78,25.92|N|To Fradd Swiftgear.|
A Gizmos and Gadgets|QID|25855|M|26.78,25.92|N|From Fradd Swiftgear.|
C Hunting Horrorjaw|QID|25857|M|31.16,22.11|N|Kill and loot Horrorjaw for his hide.|
C The Mosshide Job|QID|25865|S|M|33.73,31.21|N|Loot from gnolls.|
C Gizmos and Gadgets|QID|25855|M|31.39,29.92|N|Look for sparkles in the ground and loot them.|
C The Mosshide Job|QID|25865|US|M|33.73,31.21|N|Loot from gnolls.|
T Hunting Horrorjaw|QID|25857|M|26.79,26.65|N|To James Halloran.|
T The Mosshide Job|QID|25865|M|26.90,26.16|N|To Shilah Slabchisel.|
T Gizmos and Gadgets|QID|25855|M|26.82,25.92|N|To Fradd Swiftgear.|

A Dark Iron Trappers|QID|25866|M|26.94,26.15|N|From Shilah Slabchisel.|
A Gnoll Escape|QID|25867|M|26.94,26.15|N|From Shilah Slabchisel.|
C Gnoll Escape|QID|25867|M|45.38,34.90|S|N|Free Gnolls from the Gnoll Cages when you get keys from Dark Iron Trappers.|
C Dark Iron Trappers|QID|25866|M|43.62,34.27|N|Kill Dark Iron Trappers and loot their keys.|
C Gnoll Escape|QID|25867|M|45.38,34.90|US|N|Free Gnolls from the Gnoll Cages when you get keys from Dark Iron Trappers.|
T Dark Iron Trappers|QID|25866|M|26.91,26.18|N|To Shilah Slabchisel.|
T Gnoll Escape|QID|25867|M|26.91,26.18|N|To Shilah Slabchisel.|
A Yorla Darksnare|QID|25868|M|26.91,26.18|N|From Shilah Slabchisel.|
C Yorla Darksnare|QID|25868|M|41.25,22.00|N|Kill Yorla Darksnare.|
T Yorla Darksnare|QID|25868|M|27.00,26.03|N|To Shilah Slabchisel.|
A Whelgar's Retreat|QID|26981|M|27.00,26.03|N|From Shilah Slabchisel.|
f Whelgar's Retreat|QID|26981|M|38.77,39.03|N|At Damon Baelor.|
T Whelgar's Retreat|QID|26981|M|38.84,39.30|N|To Prospector Whelgar.|

A When Archaeology Attacks|QID|25849|M|38.84,39.30|N|From Prospector Whelgar.|
A Strike the Earth!|QID|25850|M|38.65,39.47|N|From Ormer Ironbraid.|
A Tooling Around|QID|25853|M|38.81,39.71|N|From Merrin Rockweaver.|
C Strike the Earth!|QID|25850|M|33.59,47.47|S|N|Kill Paleolithic Elementals.|
C When Archaeology Attacks|QID|25849|M|34.49,46.65|S|N|Kill and loot Living Fossils.|
C Tooling Around|QID|25853|M|35.37,50.71|N|The Tools are little sparkling boxes.|
C Strike the Earth!|QID|25850|M|33.59,47.47|US|N|Kill Paleolithic Elementals.|
C When Archaeology Attacks|QID|25849|M|34.49,46.65|US|N|Kill and loot Living Fossils.|
T Strike the Earth!|QID|25850|M|38.67,39.48|N|To Ormer Ironbraid.|
T Tooling Around|QID|25853|M|38.77,39.65|N|To Merrin Rockweaver.|
T When Archaeology Attacks|QID|25849|M|38.89,39.47|N|To Prospector Whelgar.|
A The Angerfang Menace|QID|26189|M|38.89,39.47|N|From Prospector Whelgar.|
C The Angerfang Menace|QID|26189|QO|Angerfang Dragonmaw slain: 16/16|M|53.33,54.44|N|Kill Angerfang Dragonmaw Orcs.|S|
K Gorfax Angerfang|QID|26189|M|53.33,54.44|QO|Gorfax Angerfang slain: 1/1|N|Kill Gorfax Angerfang.|
C The Angerfang Menace|QID|26189|QO|Angerfang Dragonmaw slain: 16/16|M|53.33,54.44|N|Kill Angerfang Dragonmaw Orcs.|US|
T The Angerfang Menace|QID|26189|M|38.94,39.46|N|To Prospector Whelgar.|

A Who Wards The Greenwarden|QID|26195|M|38.94,39.46|N|From Prospector Whelgar.|
f Greenwarden's Grove|QID|26195|M|56.32,41.85|N|At Halana.|
T Who Wards The Greenwarden|QID|26195|M|56.48,39.93|N|To Ferilon Leafborn.|
A The Crazed Dragonmaw|QID|26120|M|56.47,39.79|N|From Huntress Iczelia.|
A Mired in Hatred|QID|25926|M|56.40,40.35|N|From Rethiel the Greenwarden.|
r Repair/Restock|QID|25926|M|57.88,40.78|N|At Victorina.|
C The Crazed Dragonmaw|QID|26120|M|62.53,42.62|N|Kill 12 Dragonmaw Whelpstealers.|
C Mired in Hatred|QID|25926|M|55.90,35.67|N|Kill 10 Mouldering Mirebeasts.|
T The Crazed Dragonmaw|QID|26120|M|56.38,39.70|N|To Huntress Iczelia.|
T Mired in Hatred|QID|25926|M|56.36,40.23|N|To Rethiel the Greenwarden.|
A The Threat of Flame|QID|25927|M|56.36,40.23|N|From Rethiel the Greenwarden.|
A For Peat's Sake|QID|25939|M|56.41,39.93|N|From Ferilon Leafborn.|
C The Threat of Flame|QID|25927|M|56.74,29.50|S|N|Kill Rampant Fire Elementals.|
C For Peat's Sake|QID|25939|U|56134|M|63.43,33.10|N|Stand in the fire and use your Floodlilly.|
C The Threat of Flame|QID|25927|M|56.74,29.50|US|N|Kill Rampant Fire Elementals.|
T The Threat of Flame|QID|25927|M|56.48,40.39|N|To Rethiel the Greenwarden.|
T For Peat's Sake|QID|25939|M|56.41,39.94|N|To Rethiel the Greenwarden.|

A Longbraid the Grim|QID|26196|M|56.41,39.94|N|From Rethiel the Greenwarden.|
f Dun Modr|QID|26196|M|49.98,18.58|N|At Caleb Baelor.|
T Longbraid the Grim|QID|26196|M|49.88,18.36|N|To Longbraid the Grim.|
A Anvilmar the Hero|QID|26327|M|49.88,18.36|N|From Longbraid the Grim.|
T Anvilmar the Hero|QID|26327|M|49.53,17.29|N|To Thargas Anvilmar.|
A The Twilight's Hammer Revealed|QID|26127|M|49.53,17.29|N|From Thargas Anvilmar.|
C The Twilight's Hammer Revealed|QID|26127|M|46.49,15.98|N|Kill 12 Twilight Converts.|
T The Twilight's Hammer Revealed|QID|26127|M|49.39,17.23|N|To Thargas Anvilmar.|
A The Battle of Thandol Span|QID|26128|M|49.50,17.28|N|From Thargas Anvilmar.|
C The Battle of Thandol Span|QID|26128|M|51.11,9.04|N|Go onto the bridge, but not past the waypoint. Watch the little scene (pun intended), then kill Calamoth Ashbeard.|
T The Battle of Thandol Span|QID|26128|M|49.53,17.25|N|(UI Alert) Or you can go and turn the quest into Thargas Anvilmar.|
A In to Arathi|QID|26139|M|49.53,17.25|N|(UI Alert) Or you can get this quest from Thargas Anvilmar.|

]]

end)
