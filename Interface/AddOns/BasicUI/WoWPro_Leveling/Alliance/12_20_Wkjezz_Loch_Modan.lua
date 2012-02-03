
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_loch_modan
-- Date: 2011-08-07 23:49
-- Who: Ludovicus Maior
-- Log: Corrected coords on [Stormpike's Orders]

-- URL: http://wow-pro.com/node/3216/revisions/24590/view
-- Date: 2011-06-25 00:57
-- Who: Crackerhead22
-- Log: ! Missing A step for step T qid 13636 - Added in accept step.
--	! Line 169 has missing space after step ;: [;F Thelsamar|QID|26128|N|Fly back to Thelsamar. Ignore quests at this new hub for now.|] - Removed line. 

-- URL: http://wow-pro.com/node/3216/revisions/24589/view
-- Date: 2011-06-25 00:54
-- Who: Crackerhead22
-- Log: ! Missing A step for step T qid 13636 - Added in accept step.

-- URL: http://wow-pro.com/node/3216/revisions/24514/view
-- Date: 2011-06-07 21:46
-- Who: Crackerhead22
-- Log: Removed unneeded zone tags, added in breadcrumb quest from Ironforge, added in missing quests, re-arranged certain quests to better flow for those coming from Dun Morogh. Added missing notes, missing cords. Fixed a few notes and cords. 

-- URL: http://wow-pro.com/node/3216/revisions/24427/view
-- Date: 2011-05-27 16:45
-- Who: Fluclo
-- Log: Added some notes to quests; Added couple Explorer's Leagues quests; Improved auto-complete and instruction for Axis of Awful; Added some stickies; Removed strange Farstrider Lodge flightpath obtaining to later in guide when already using the area; changed Z|Farstrider Lodge throughout as it generated zone not found errors when using guide.

-- URL: http://wow-pro.com/node/3216/revisions/24325/view
-- Date: 2011-04-29 15:51
-- Who: Ludovicus Maior
-- Log: Line 96 for step C has 1 M coords

-- URL: http://wow-pro.com/node/3216/revisions/24293/view
-- Date: 2011-04-29 14:23
-- Who: Ludovicus Maior
-- Log: Line 91 for step C has 1 M coords.

-- URL: http://wow-pro.com/node/3216/revisions/23969/view
-- Date: 2011-01-09 20:36
-- Who: Ludovicus Maior
-- Log: Verified previous changes.
--	Added Notes and coords to [A Decisive Strike], [Bigger and Uglier] and made the Stick.
--	Added a "R"un to the mountain trail to kill troggs.
--	Added an explicit path to [WANTED: The Dark Iron Spy].
--	Added a warning about the Dark Iron Courier.
--	

-- URL: http://wow-pro.com/node/3216/revisions/23968/view
-- Date: 2011-01-09 17:41
-- Who: Ludovicus Maior
-- Log: Sequence tweak to avoid traveling after [Bigger and Uglier].  See http://wow-pro.com/wiki/source_code_loch_modan#comment-35270 .

-- URL: http://wow-pro.com/node/3216/revisions/23967/view
-- Date: 2011-01-09 17:38
-- Who: Ludovicus Maior
-- Log: Quest [WANTED: The Dark Iron Spy] is not from Innkeeper.  See http://wow-pro.com/wiki/source_code_loch_modan#comment-35268 .

-- URL: http://wow-pro.com/node/3216/revisions/23966/view
-- Date: 2011-01-09 17:34
-- Who: Ludovicus Maior
-- Log: Sequence wrong after turning in [The Bearer of Gnoll-edge].  See http://wow-pro.com/wiki/source_code_loch_modan#comment-35267 .

-- URL: http://wow-pro.com/node/3216/revisions/23965/view
-- Date: 2011-01-09 17:32
-- Who: Ludovicus Maior
-- Log: Sequence wrong around [A Nasty Exploit].  See http://wow-pro.com/wiki/source_code_loch_modan#comment-35266 .

-- URL: http://wow-pro.com/node/3216/revisions/23964/view
-- Date: 2011-01-09 17:30
-- Who: Ludovicus Maior
-- Log: Sequence wrong around [A Who's In Charge Here?]
--	http://wow-pro.com/wiki/source_code_loch_modan#comment-35265

-- URL: http://wow-pro.com/node/3216/revisions/23963/view
-- Date: 2011-01-09 17:26
-- Who: Ludovicus Maior
-- Log: Initial checkin of guide as of release 2.1.1 of 11-Dec-2010

-- URL: http://wow-pro.com/node/3216/revisions/23302/view
-- Date: 2010-12-03 07:29
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3216/revisions/23301/view
-- Date: 2010-12-03 07:29
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('WkjLoc1220', 'Loch Modan', 'Wkjezz', '12', '20', 'WkjWet2025', 'Alliance', function()
return [[

F South Gate Outpost|QID|26131|Z|Ironforge|M|55.49,47.78|N|Talk to Gryth Thurden, and ask him to fly you to Loch Modan.|
T Reinforcements for Loch Modan|QID|26131|M|14,56.49|N|To Pilot Hammerfoot.|
A The Lost Pilot|QID|26854|M|14,56.49|N|From Pilot Hammerfoot.|
T The Lost Pilot|QID|26854|M|87.63,50.14|Z|Dun Morogh|N|To A Dwarven Corpse.|
A A Pilot's Revenge|QID|26855|M|87.63,50.14|Z|Dun Morogh|N|From A Dwarven Corpse.|
C A Pilot's Revenge|QID|26855|M|87.46,50.02|Z|Dun Morogh|N|Kill and Mangeclaw. He appears after you accept the quest.|
T A Pilot's Revenge|QID|26855|M|14,56.49|N|To Pilot Hammerfoot.|
A South Gate Status Report|QID|13635|M|14,56.49|N|From Pilot Hammerfoot.|
T South Gate Status Report|QID|13635|M|23.4,75|N|To Captain Rugelfuss.|

A In Defense of the King's Lands|QID|26146|M|23.48,75.03|N|From Captain Rugelfuss.|
A The Trogg Threat|QID|26145|M|23.44,74.94|N|From Mountaineer Cobbleflint.|
R Up the Trail|QID|26145|CC|M|23.21,76.52;22.58,77.34;26.66,77.34;23.48,79.83;24.85,78.01;27.51,76.46;30.31,78.37|N|Go up this mountain trail and kill Troggs around the valley.|

C The Trogg Threat|QID|26145|S|M|31.63,69.62|N|Collect the Trogg Stone Tooth that drops from the Troggs.|
C In Defense of the King's Lands|QID|26146|M|35.78,80.53|N|Kill 12 Stoneslinter Troggs.|
C The Trogg Threat|QID|26145|US|M|31.63,69.62|N|Finish off collecting the Trogg Stone Tooth that drops from the Troggs.|

T The Trogg Threat|QID|26145|M|23.45,74.98|N|To Mountaineer Cobbleflint.|
T In Defense of the King's Lands|QID|26146|M|23.41,75.00|N|To Captain Rugelfuss.|
A A Decisive Strike|QID|26148|M|23.37,75.01|N|From Captain Rugelfuss.|
A Bigger and Uglier|QID|26147|M|23.40,75.02|N|From Mountaineer Wallbang.|
C Bigger and Uglier|QID|26147|M|35.04,59.37|S|N|Kill Stonesplinter Shamans and Bonesnappers.|
C A Decisive Strike|QID|26148|M|33.08,70.65;35.36,65.18;35.64,62.25;33.86,62.19;35.60,61.10|N|Kill Grawmug, who is in the rear of the cave.|
C Bigger and Uglier|QID|26147|M|35.04,59.37|US|N|Finish killing the Stonesplinters needed.|
T A Decisive Strike|QID|26148|M|23.40,75.01|N|To Captain Rugelfuss.|
A Onward to Thelsamar|QID|26176|M|23.37,75.01|N|From Captain Rugelfuss.|
T Bigger and Uglier|QID|26147|M|23.34,75.01|N|To Mountaineer Wallbang.|
R Thelsamar|QID|26176|M|35,46.6|N|Follow the road north to Thelsamar.|
f Thelsamar|QID|26176|M|33.93,50.95|N|At Thorgum Borrelson.|
T Onward to Thelsamar|QID|26176|M|35,46.6|N|To Mountaineer Kadrell.|

A Out of Gnoll-where|QID|26842|M|35.09,46.41|N|From Mountaineer Kadrell.|
h Stoutlager Inn|QID|26860|M|35.48,48.44|N|At Innkeeper Hearthstove.|
A Thelsamar Blood Sausages|QID|26860|M|34.83,49.29|N|From Vidra Hearthstove.|
A Looking for Lurkers|QID|25118|M|35.37,42.86|N|From Dakk Blunderblast.|
A WANTED: The Dark Iron Spy|QID|13648|M|37.26,46.44|N|From "Wanted" sign.|
C Thelsamar Blood Sausages|QID|26860|M|34.83,49.29|N|Kill and loot bears for their rumps.|S|
C Looking for Lurkers|QID|25118|S|M|29.01,48.29|N|Kill 8 Forest Lurkers.|
C Out of Gnoll-where|QID|26842|M|26.25,42.37|N|Kill and loot Mosshide Scouts and Bashers to get their ears.|
C Thelsamar Blood Sausages|QID|26860|M|34.83,49.29|N|Kill and loot bears for their rumps.|US|
C Looking for Lurkers|QID|25118|US|M|29.01,48.29|N|Kill 8 Forest Lurkers.|
T Out of Gnoll-where|QID|26842|M|35.03,46.56|N|To Mountaineer Kadrell.|
A Stormpike's Orders|QID|13636|M|35.09,46.41|N|From Mountaineer Kadrell.|
T Looking for Lurkers|QID|25118|M|35.35,42.82|N|To Dakk Blunderblast.|
T Thelsamar Blood Sausages|QID|26860|M|34.83,49.29|N|To Vidra Hearthstove.|
R WANTED: The Dark Iron Spy|QID|13648|M|40.69,58.07;40.35,61.45;37.31,61.99|CC|N|Take the trail up and head into the cave.|
C WANTED: The Dark Iron Spy|QID|13648|M|36.46,61.23|N|Kill Gorick Guzzeldraught, then loot him.|
A Explorers' League Document (1 of 6)|QID|13656|M|36.76,61.25|N|From the Stolen Explorers' League Document.|
T Explorers' League Document (1 of 6)|QID|13656|M|37.18,47.82|N|To Torren Squarejaw.|
T WANTED: The Dark Iron Spy|QID|13648|M|34.60,44.50|N|To Magistrate Bluntnose.|

R Algaz Station|QID|13636|M|32.20,49.48|N|Get on the road, then head north to Algaz Station.|
T Stormpike's Orders|QID|13636|M|25.50,17.69|N|To Mountaineer Stormpike.|
A A Tiny, Clever Commander|QID|26843|M|25.50,17.69|N|From Mountaineer Stormpike.|
C A Tiny, Clever Commander|QID|26843|M|25.81,31.24|N|Head into the cave and kill "Commander" Nazrim.|
T A Tiny, Clever Commander|QID|26843|M|25.47,18.02|N|To Mountaineer Stormpike.|
A Kobold and Kobolder|QID|26844|M|25.47,18.02|N|From Mountaineer Stormpike.|
C Kobold and Kobolder|QID|26844|M|34.37,17.29|N|Kill Tunnel Rat Surveyors and Rat Foragers. They are not in the cave.|
T Kobold and Kobolder|QID|26844|M|25.41,17.90|N|To Mountaineer Stormpike.|
A Who's In Charge Here?|QID|26845|M|25.41,17.90|N|From Mountaineer Stormpike.|
A Filthy Paws|QID|26863|M|25.41,17.90|N|From Mountaineer Stormpike.|
A A Nasty Exploit|QID|26846|M|25.41,17.90|N|From Scout Dorli.|

R Filthy Paws|QID|26863|CC|M|35.29,17.93|N|Run here.|
C A Nasty Exploit|QID|26846|M|36.23,23.45|S|N|Kill Tunnel Rat Geomancers.|
C Filthy Paws|QID|26863|M|35.09,24.63|S|N|Loot Miners' League Crates. They sparkle.|
C Who's In Charge Here?|QID|26845|M|34.75,26.85|N|Head to the end of the cave. Kill and loot Foreman Sharpsneer.|
C A Nasty Exploit|QID|26846|M|36.23,23.45|US|N|Kill Tunnel Rat Geomancers.|
C Filthy Paws|QID|26863|M|35.09,24.63|US|N|Loot Miners' League Crates. They sparkle.|
T Filthy Paws|QID|26863|M|25.48,17.74|N|To Mountaineer Stormpike.|
T Who's In Charge Here?|QID|26845|M|25.48,17.74|N|To Mountaineer Stormpike.|
A The Bearer of Gnoll-edge|QID|26864|M|25.48,17.74|N|From Mountaineer Stormpike.|
T A Nasty Exploit|QID|26846|M|25.48,17.74|N|To Scout Dorli.|
H Thelsamar|QID|26864|M|37.17,46.40|N|Hearth back to Thelsamar.|
T The Bearer of Gnoll-edge|QID|26864|M|35.09,46.41|N|To Mountaineer Kadrell.|

A Suddenly, Murlocs!|QID|26927|M|35.09,46.41|N|From Mountaineer Kadrell.|
T Suddenly, Murlocs!|QID|26927|M|34.81,49.06|N|To Cannary Caskshot.|
A Smells Like A Plan|QID|26928|M|34.81,49.06|N|From Cannary Caskshot.|
C Smells Like A Plan|QID|26928|S|M|42.92,47.90|N|Kill and loot Murlocs until you get 7 glands.|
A Explorers' League Document (2 of 6)|QID|13655|M|41.35,39.00|N|From the Stolen Explorers' League Documents. It is hard to see, it is just under the south side of the bridge.|
C Smells Like A Plan|QID|26928|US|M|42.92,47.90|N|Kill and loot Murlocs until you get 7 glands.|

T Explorers' League Document (2 of 6)|QID|13655|M|37.18,47.82|N|To Torren Squarejaw.|
A Buzz Off|QID|26932|M|35.01,46.42|N|From Mountaineer Kadrell.|
T Smells Like A Plan|QID|26928|M|34.85,49.07|N|To Cannary Caskshot.|
A Axis of Awful|QID|26868|M|34.85,49.07|N|From Cannary Caskshot.|
A A Load of Croc|QID|26929|M|34.91,49.02|N|From Cannary Caskshot.|

C A Load of Croc|QID|26929|S|M|60.21,54.19|N|Kill and loot Loch Crocolisks to get their jaws.|
C Buzz Off|QID|26932|S|M|54.39,59.98|N|Kill Loch Buzzards.|
U Cannary's Cache|QID|26868|U|60681|M|50.99,55.70|N|Open up Cannary's Cache|L|60502|
C Axis of Awful|QID|26868|U|60503|M|50.99,55.70|N|Head to near the waypoint. Put on your Clever Plant Disguise Kit, then throw the Potent Murloc Pheromones at the Gnoll Representatives.|
C Buzz Off|QID|26932|US|M|54.39,59.98|N|Kill Loch Buzzards.|
C A Load of Croc|QID|26929|US|M|60.21,54.19|N|Looted from the Loch Crocolisk|

T Buzz Off|QID|26932|M|35.01,46.84|N|To Mountaineer Kadrell.|
T Axis of Awful|QID|26868|M|34.86,49.03|N|To Cannary Caskshot.|
T A Load of Croc|QID|26929|M|34.86,49.03|N|To Cannary Caskshot.|
A Resupplying the Excavation|QID|13639|M|37.26,47.60|N|From Jern Hornhelm.|
C Resupplying the Excavation|QID|13639|NC|M|56.39,65.97|N|Head to the waypoint to find Huldar, Miran and Saean.|
T Resupplying the Excavation|QID|13639|M|56.39,65.97|N|To Huldar.|
A Protecting the Shipment|QID|309|M|56.39,65.97|N|From Huldar.|
C Protecting the Shipment|QID|309|NC|M|56.37,65.90|N|Stay near Huldar and protect him.|
T Protecting the Shipment|QID|309|M|65.33,65.98|N|To Prospector Ironband.|

A Keep Your Hands Off The Goods!|QID|13650|M|65.19,66.02|N|From Prospector Ironband.|
A Gathering Idols|QID|26961|M|64.80,66.54|N|From Magmar Fellhew.|
C Gathering Idols|QID|26961|S|M|72.57,66.29|N|Kill and loot Troggs until you get 8 Carved Stone Idols.|
C Artifact of the Upturned Giant|QID|13650|M|70.13,59.79|N|Head to the Upturned Giant and stand on it (to simulate inspecting it, you don't need to click it).|QO|Artifact of the Upturned Giant Inspected: 1/1|
C Artifact of the Broken Tablet|QID|13650|M|70.71,67.57|N|Head to the Broken Tablet and stand on it (to simulate inspecting it, you don't need to click it).|QO|Artifact of the Broken Tablet Inspected: 1/1|
A Explorers' League Document (4 of 6)|QID|13658|M|68.20,65.97|N|Walk up a near by ramp located close to the last objective completed.|
C Keep Your Hands Off The Goods!|QID|13650|M|72.57,65.11|N|Head to the Overdressed Woman and stand on it (to simulate inspecting it, you don't need to click it).|
C Gathering Idols|QID|26961|US|M|72.57,66.29|N|Kill and loot Troggs until you get 8 Carved Stone Idols.|

T Gathering Idols|QID|26961|M|64.94,66.56|N|To Magmar Fellhew.|
T Keep Your Hands Off The Goods!|QID|13650|M|65.19,66.07|N|To Prospector Ironband.|
A Joining the Hunt|QID|13647|M|64.93,66.60|N|From Magmar Fellhew.|

A Thistle While You Work|QID|27025|M|82.79,63.42|N|From Safety Warden Pipsy.|
A The Joy of Boar Hunting|QID|27016|M|83.35,65.01|N|From Daryl the Youngling.|
f Farstrider Lodge|QID|13647|M|81.96,64.10|N|At Eeryven Grayer. |
A Wing Nut|QID|27031|M|81.70,64.59|N|From Bingles Blastenheimer.|
A Hornet Hunting|QID|27028|M|81.82,61.74|N|From Marek Ironheart.|
A Foxtails By The Handful|QID|27030|M|81.87,61.88|N|From Marek Ironheart.|
T Joining the Hunt|QID|13647|M|81.82,61.74|N|To Marek Ironheart.|

C Wing Nut|QID|27031|M|75.15,73.70|N|Kill and loot Golden Eagles for their feathers.|
C Foxtails By The Handful|QID|27030|M|68.77,42.89|S|N|Kill and loot foxes until you get 7 Fluffy Fox Tails.|
C Thistle While You Work|QID|27025|M|68.39,39.97|NC|N|Collect the Seeds from the ground.|S|
A Explorers' League Document (6 of 6)|QID|13659|M|73.09,35.91|N|From the Stolen Explorers' League Documents.|
C Thistle While You Work|QID|27025|M|68.39,39.97|NC|N|Collect the Seeds from the ground.|US|
C Foxtails By The Handful|QID|27030|M|68.77,42.89|US|N|Kill and loot foxes until you get 7 Fluffy Fox Tails.|
C Hornet Hunting|QID|27028|M|54.64,32.21|S|N|Kill and loot Marsh Hornets.|
C The Joy of Boar Hunting|QID|27016|M|57.54,34.71|S|N|Kill 10 Mudbelly Boars.|
A Explorers' League Document (5 of 6)|QID|13660|M|53.70,38.21|N|From the Stolen Explorers' League Documents.|
C The Joy of Boar Hunting|QID|27016|M|57.54,34.71|US|N|Kill 10 Mudbelly Boars.|
C Hornet Hunting|QID|27028|M|54.64,32.21|US|N|Kill and loot Marsh Hornets.|

H Thelsamar|QID|13660|M|37.17,46.40|N|Hearth back to Thelsamar.|
T Explorers' League Document (4 of 6)|QID|13658|M|37.18,47.75|N|To Torren Squarejaw.|
T Explorers' League Document (5 of 6)|QID|13660|M|37.18,47.75|N|To Torren Squarejaw.|
T Explorers' League Document (6 of 6)|QID|13659|M|37.18,47.75|N|To Torren Squarejaw.|
F Farstrider Lodge|QID|27031|M|33.96,50.88|N|Fly to Farstrider Lodge.|

T Wing Nut|QID|27031|M|81.68,64.66|N|To Bingles Blastenheimer.|
A Bird is the Word|QID|27032|M|81.70,64.63|N|From Bingles Blastenheimer.|
T Thistle While You Work|QID|27025|M|82.86,63.50|N|To Safety Warden Pipsy.|
A Defcon: Bobcat|QID|27026|M|82.86,63.50|N|From Safety Warden Pipsy.|
T Hornet Hunting|QID|27028|M|81.87,61.81|N|To Marek Ironheart.|
T Foxtails By The Handful|QID|27030|M|81.87,61.81|N|To Marek Ironheart.|
T The Joy of Boar Hunting|QID|27016|M|83.40,65.26|N|To Daryl the Youngling.|
A Vyrin's Revenge|QID|27036|M|81.99,64.44|N|From Vyrin Swiftwind.|

C Defcon: Bobcat|QID|27026|M|69.67,73.70|S|N|Kill Bobcats.|
R Ironwing Cavern|QID|27032|M|71.57,76.91|N|Run to Ironwing Cavern.|
T Bird is the Word|QID|27032|M|78.52,76.30|M|71.4,76.8|N|To the Rusted Skystrider.|
A Skystrider's Heart|QID|27033|M|78.51,76.32|N|From the Rusted Skystrider.|
C Vyrin's Revenge|QID|27036|M|80.28,52.17|N|Kill and loot Ol' Sooty.|
C Defcon: Bobcat|QID|27026|M|69.67,73.70|N|Finish killing the Bobcats.|US|
T Defcon: Bobcat|QID|27026|M|82.87,63.35|N|To Safety Warden Pipsy.|
T Skystrider's Heart|QID|27033|M|81.63,64.61|N|To Bingles Blastenheimer.|
A He's That Age|QID|27034|M|81.66,64.55|N|From Bingles Blastenheimer.|
T Vyrin's Revenge|QID|27036|M|83.39,65.25|N|To Daryl the Youngling.|
A Vyrin's Revenge|QID|27037|M|83.39,65.25|N|From Daryl the Youngling.|
T Vyrin's Revenge|QID|27037|M|81.88,64.42|N|To Vyrin Swiftwind.|
T He's That Age|QID|27034|M|58.47,28.99|N|To Ando Blastenheimer.|

A Standing Up|QID|27035|M|58.47,28.99|N|From Ando Blastenheimer.|
C Standing Up|QID|27035|M|50.64,23.82|N|Head into the center of the Twilight Camp and destroy the Twilight Landshaper.|
T Standing Up|QID|27035|M|58.59,28.96|N|To Ando Blastenheimer.|
A Fight the Hammer|QID|27074|M|58.59,28.96|N|From Ando Blastenheimer.|
T Fight the Hammer|QID|27074|M|64.05,26.80|N|To Ashlan Stonesmirk.|
A Servants of Cho'gall|QID|27075|M|64.05,26.80|N|From Ashlan Stonesmirk.|
A Clutching at Chaos|QID|27077|M|64.05,26.80|N|From Ashlan Stonesmirk.|
C Servants of Cho'gall|QID|27075|M|70.91,23.24|S|N|Kill 7 Mo'Grosh Ogres.|
C Clutching at Chaos|QID|27077|M|69.40,23.80|N|Sparkley black long spikes, click on them to pick them up.|
C Servants of Cho'gall|QID|27075|M|70.91,23.24|US|N|Kill 7 Mo'Grosh Ogres.|
T Servants of Cho'gall|QID|27075|M|64.05,26.83|N|To Ashlan Stonesmirk.|
T Clutching at Chaos|QID|27077|M|64.05,26.83|N|To Ashlan Stonesmirk.|
A Gor'kresh|QID|27078|M|64.05,26.83|N|From Ashlan Stonesmirk.|
C Gor'kresh|QID|27078|M|74.82,19.81;79.80,14.90|N|Head to the back of the cave, and kill Gor'kresh.|
T Gor'kresh|QID|27078|M|64.17,26.83|N|To Ashlan Stonesmirk.|
A Ando's Call|QID|27115|M|64.17,26.83|N|From Ashlan Stonesmirk.|
T Ando's Call|QID|27115|M|58.57,29.07|N|To Ando Blastenheimer.|
A The Winds of Loch Modan|QID|27116|M|58.57,29.07|N|From Ando Blastenheimer.|
T The Winds of Loch Modan|QID|27116|M|25.51,17.87|N|To Mountaineer Stormpike.|

]]
end)
