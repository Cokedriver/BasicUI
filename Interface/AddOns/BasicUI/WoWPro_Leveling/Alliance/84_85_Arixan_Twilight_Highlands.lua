
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_twilight_highlands_alliance
-- Date: 2011-12-21 22:24
-- Who: Crackerhead22
-- Log: Fix from Censored.

-- URL: http://wow-pro.com/node/3311/revisions/24811/view
-- Date: 2011-11-17 12:28
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3311/revisions/24810/view
-- Date: 2011-11-17 12:27
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3311/revisions/24807/view
-- Date: 2011-11-16 18:10
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3311/revisions/24806/view
-- Date: 2011-11-16 18:05
-- Who: Fluclo

-- URL: http://wow-pro.com/node/3311/revisions/24768/view
-- Date: 2011-10-22 22:14
-- Who: Fluclo
-- Log: Added details on where Siren's Song is

-- URL: http://wow-pro.com/node/3311/revisions/24767/view
-- Date: 2011-10-22 21:54
-- Who: Fluclo
-- Log: Added detail to some notes

-- URL: http://wow-pro.com/node/3311/revisions/24766/view
-- Date: 2011-10-22 21:35
-- Who: Fluclo
-- Log: NC steps added

-- URL: http://wow-pro.com/node/3311/revisions/24671/view
-- Date: 2011-07-10 11:57
-- Who: Crackerhead22
-- Log: Fixed a spelling mistake per Aberdeen's catch.

-- URL: http://wow-pro.com/node/3311/revisions/24378/view
-- Date: 2011-05-11 18:35
-- Who: Crackerhead22
-- Log: Fixed Syntax Errors.

-- URL: http://wow-pro.com/node/3311/revisions/24369/view
-- Date: 2011-05-06 17:57
-- Who: Crackerhead22
-- Log: Added notes, etc.

-- URL: http://wow-pro.com/node/3311/revisions/24314/view
-- Date: 2011-04-29 15:17
-- Who: Ludovicus Maior
-- Log: Line 65 for step A has unknown tag [From Anduin Wrynn], Line 70 for step T has unknown tag [Stormwind City], Line 180 for step C has 1 M coords, Line 471 for step C has unknown tag [If you catch them ...], Line 480 for step A has 1 M coords, Line 647 for step C has 1 M coords

-- URL: http://wow-pro.com/node/3311/revisions/24098/view
-- Date: 2011-02-05 05:12
-- Who: Ludovicus Maior
-- Log: Re-sync from GitHub. Seems I picked up an earlier version of this guide.

-- URL: http://wow-pro.com/node/3311/revisions/24095/view
-- Date: 2011-02-04 22:27
-- Who: Ludovicus Maior
-- Log: Synchronize with GitHub Alliance/84_85_Arixan_Twilight_Highlands.lua

-- URL: http://wow-pro.com/node/3311/revisions/23734/view
-- Date: 2010-12-11 07:46
-- Who: MagicSN

-- URL: http://wow-pro.com/node/3311/revisions/23722/view
-- Date: 2010-12-10 07:19
-- Who: MagicSN

-- URL: http://wow-pro.com/node/3311/revisions/23517/view
-- Date: 2010-12-03 23:28
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3311/revisions/23516/view
-- Date: 2010-12-03 23:28
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('MagTwi8485', 'Twilight Highlands', 'Melliandra', '84', '85', nil, 'Alliance', function()
return [[

L Level 84 |QID|28716|LVL|84|N|You need to be Level 84 to do this guide.|

R Stormwind City |QID|28716|N|The questing will begin in Stormwind City, where you have a dozen quests around Stormwind City before being whisked off to the Twilight Highlands.|

A Hero's Call: Twilight Highlands!|QID|28716|M|62.90,71.78|N|From the Message boards at either end of town.|Z|Stormwind City|
T Hero's Call: Twilight Highlands!|QID|28716|M|85.62,31.93|N|To King Varian Wrynn.|Z|Stormwind City|

A My Son, the Prince|QID|26960|PRE|28716|M|85.62,31.93|N|From King Varian Wrynn.|Z|Stormwind City|
C My Son, the Prince|QID|26960|M|85.64,31.86|Z|Stormwind City|N|Talk to Anduin,|NC|
T My Son, the Prince|QID|26960|M|85.62,31.93|N|To King Varian Wrynn.|Z|Stormwind City|

A Rallying the Fleet|QID|26975|M|85.62,31.93|N|From King Varian Wrynn.|Z|Stormwind City|
A Twilight Investigation|QID|26977|M|85.62,31.93|N|From King Varian Wrynn.|Z|Stormwind City|
T Twilight Investigation|QID|26977|M|85.26,31.42|N|To Major Samuelson.|Z|Stormwind City|

A The Usual Suspects|QID|26997||PRE|26977|M|85.26,31.42|N|From Major Samuelson.|Z|Stormwind City|
C The Usual Suspects|QID|26997|M|29.06,25.46|N|Interrogate dock workers in this area.|Z|Stormwind City|NC|
T The Usual Suspects|QID|26997|M|29.06,25.46|N|To Anduin Wrynn.|Z|Stormwind City|

C Rallying the Fleet|QID|26975|M|33.33,39.07|N|Speak to Supply Sergeant Graves.|Z|Stormwind City|NC|
T Rallying the Fleet|QID|26975|M|33.33,39.07|N|To Supply Sergeant Graves.|Z|Stormwind City|

A Missing Parts|QID|27038|PRE|26975|M|33.33,39.07|N|From Supply Sergeant Graves.|Z|Stormwind City|
A Peasant Problems|QID|27044|PRE|26977|M|33.23,39.38|N|From Anduin Wrynn.|Z|Stormwind City|

C Missing Parts|QID|27038|PRE|26975|M|34.09,43.89|N|Found in this area around the docks.|Z|Stormwind City|NC|
T Missing Parts|QID|27038|PRE|26975|M|34.50,38.28|N|To Fargo Flintlocke.|Z|Stormwind City|

A He's Holding Out on Us|QID|27064|PRE|26977|N|From Anduin Wrynn|Z|Stormwind City|
C Peasant Problems|QID|27044|NC|M|52.07,6.26|N|Speak to Farmer Wallerton at the Walleton Stead.|Z|Stormwind City|NC|
T Peasant Problems|QID|27044|M|52.07,6.26|N|To Farmer Wallerton.|Z|Stormwind City|

A Unholy Cow|QID|27060|PRE|26977|M|51.96,5.83|N|From Farmer Wollerton.|Z|Stormwind City|
C Unholy Cow|QID|27060|M|44.05,4.28|N|Follow the trail of parts. You will be attacked once the first part of the quest is completed. If you die, then you will need to return to the throne room to retrive the prince again.|Z|Stormwind City|
T Unholy Cow|QID|27060|M|44.05,4.28|N|To Anduin Wrynn.|Z|Stormwind City|

C He's Holding Out on Us|QID|27064|M|80.39,62.34|N|Head to SI:7 in The Old Town. There is a small stairwell leading up to the 3rd floor.|Z|Stormwind City|NC|

T He's Holding Out on Us|QID|27064|M|80.39,62.34|N|To Anduin Wrynn.|Z|Stormwind City|
A Expert Opinion|QID|28807|PRE|26977|M|80.39,62.34|N|From Anduin Wrynn|Z|Stormwind City|
T Expert Opinion|QID|28807|M|81.28,63.32|N|To Master Mathias Shaw, same building.|Z|Stormwind City|

A The Old Barracks|QID|27072|PRE|26977|M|81.28,63.32|N|From Master Mathias Shaw.|Z|Stormwind City|
C The Old Barracks|QID|27072|M|37.24,56.47|N|Head to the Ruined Barracks. Kill crazed cultists. Work on the building at the waypoint, since you need to make your way down to the bottom floor to turn in this quest.|Z|Stormwind City|
T The Old Barracks|QID|27072|M|37.24,56.47|N|To Jack Bauden.|

A Cataclysm in the Catacombs|QID|27092|PRE|26977|M|37.24,56.47|N|From Jack Bauden.|Z|Stormwind City|
C Cataclysm in the Catacombs|QID|27092|M|51.30,42.30|N|Head to the Cathedral of Light, then back right hand side will be the route down to the catacombs found in the bottom of the Cathedral of Light. Kill the Black Bishop and then disarm the bomb.|Z|Stormwind City|
T Cataclysm in the Catacombs|QID|27092|M|50.45,42.42|N|To the disarmed bomb.|Z|Stormwind City|

A A Villain Unmasked|QID|27106|PRE|26977|M|50.45,42.42|N|From the disarmed bomb.|Z|Stormwind City|
C A Villain Unmasked|QID|27106|M|85.19,32.25|N|Head to Stormwind Keep, and talk to Major Samuelson. Once confronted, he will turn into a Level 84 elite, which the Guards will help you defeat.|Z|Stormwind City|
T A Villain Unmasked|QID|27106|M|85.66,32.00|N|To King Varian Wrynn.|Z|Stormwind City|

A Twilight Shores|QID|28238|PRE|26977|M|85.66,32.00|N|From King Varian Wrynn.|Z|Stormwind City|
T Twilight Shores|QID|28238|M|26.19,47.29|N|To Fargo Flintlocke in Stormwind Harbour.|Z|Stormwind City|

A Twilight Shores|QID|28832|PRE|26977|M|26.19,47.29|N|From Fargo Flintlocke. Then hop in his boat.|Z|Stormwind City|
T Twilight Shores|QID|28832|M|80.99,79.43|N|Hop into Flintlocke's Seaplane which will take you to The Twilight Highlands, then to Lieutenant Fawkes.|

A Welcome to Highbank!|QID|28596|PRE|26977|M|80.99,79.43|N|From Lieutenant Fawkes.|
C Welcome to Highbank!|QID|28596|M|79.04,76.01|N|Kill the Axebite Infantry (avoid the Bilgewater Gunman as well as Grit's 387k and a PvP flag)|
T Welcome to Highbank!|QID|28596|M|80.99,79.43|N|To Lieutenant Fawkes.|

A Burnin' at Both Ends|QID|28597|M|81.00,79.34|N|From Fargo Flintlocke.|
C Burnin' at Both Ends|QID|28597|M|78.74,76.27|N|Collect cannon powder around Highbank. You can stay mounted on your flying mount for this quest.|NC|
T Burnin' at Both Ends|QID|28597|M|78.68,76.85|N|To Fargo Flintlocke.|

A Aiming High|QID|28598|PRE|28597|M|78.68,76.85|N|From Fargo Flintlocke.|
C Aiming High|QID|28598|U|64660|M|78.68,76.85|N|Wait for a few seconds before you are loaded into the cannon. Once you arrive on the Skyshredder, plant the explosive, then jump off the flying boat.|NC|
T Aiming High|QID|28598|M|78.68,76.85|N|To Fargo Flintlocke.|

A Kurdran's Waitin'|QID|28599|PRE|28597|M|78.93,76.70|N|From Fargo Flintlocke.|
T Kurdran's Waitin'|QID|28599|M|79.10,78.32|N|To Kurdran Wildhammer upstairs inside the castle.|

A Our Boys on the Shore|QID|27338|PRE|28597|M|79.10,78.32|N|From Kurdran Wildhammer.|
A Salvage Operation|QID|27177|M|79.28,78.47|N|From Simon Chandler.|S|
A Naga Reinforcements|QID|27178|M|78.28,78.47|N|From Simon Chandler.|
A Salvage Operation|QID|27177|M|79.28,78.47|N|From Simon Chandler.|US|

A Siren's Song|QID|27200|M|76.02,79.70|N|From Ephram Hardstone, who's on the sinking ship at the Obsidian Breakers (southwest of Highbank).|
C Siren's Song|QID|27200|M|76.09,79.69|N|Once you're able to, attack and kill Ophelia. Make sure Ephram doesn't die.|
T Siren's Song|QID|27200|M|76.01,79.97|N|To Ephram Hardstone.|

C Salvage Operation|QID|27177|S|M|75.41,82.83|N|Collect crates around this area.|NC|
C Naga Reinforcements|QID|27178|M|76.55,83.43|N|Kill Blackscale Myrmidons or Blackscale Seacallers in this area.|
C Salvage Operation|QID|27177|US|M|75.41,82.83|N|Finish collecting crates around this area.|NC|

T Salvage Operation|QID|27177|M|79.31,78.49|N|To Simon Chandler.|S|
T Naga Reinforcements|QID|27178|M|79.31,78.49|N|To Simon Chandler.|
T Salvage Operation|QID|27177|M|79.31,78.49|N|To Simon Chandler.|US|

T Our Boys on the Shore|QID|27338|M|76.80,69.95|N|To Lieutenant Emry.|

A Scouting the Shore|QID|27341|M|76.80,69.95|N|From Lieutenant Emry.|S|
A Landgrab|QID|27366|M|76.80,69.95|N|From Lieutenant Emry.|
A Scouting the Shore|QID|27341|M|76.80,69.95|N|From Lieutenant Emry.|US|
A Shredderectomy|QID|27433|M|76.94,69.92|N|From Fargo Flintlocke.|

C Landgrab|QID|27366|M|75.24,63.20|N|Kill 12 Axebite Marines.|S|
C Scouting the Shore|QID|27341|NC|M|77.47,65.24|N|Look for wooden pikes and a stormwind banner. Stay in the air next to it.|
C Landgrab|QID|27366|M|75.24,63.20|N|Finish killing Axebite Marines.|US|
C Shredderectomy|QID|27433|M|70.10,66.99|N|Kill the mechanicals for shredder parts.|

T Scouting the Shore|QID|27341|M|76.84,69.83|N|To Lieutenant Emry.|S|
T Landgrab|QID|27366|M|76.84,69.83|N|To Lieutenant Emry.|
T Scouting the Shore|QID|27341|M|76.84,69.83|N|To Lieutenant Emry.|US|
A Bird Down! Bird Down!|QID|27514|M|76.84,69.83|N|From Lieutenant Emry.|

T Shredderectomy|QID|27433|M|76.93,69.79|N|To Fargo Flintlocke.|
A Siege Tank Rescue|QID|27468|M|76.93,69.79|N|From Fargo Flintlocke.|

C Siege Tank Rescue|QID|27468|M|70.96,71.16|N|Speak to the Siege Tank Commander when you are ready. Defend the tank while they do repairs.|

T Siege Tank Rescue|QID|27468|M|76.97,69.91|N|To Fargo Flintlocke.|
T Bird Down! Bird Down!|QID|27514|M|67.68,65.86|N|To Thordun Hammerblow.|

A Roots'll Do 'Er|QID|27515|M|67.68,65.86|N|From Thordun Hammerblow.|
C Roots'll Do 'Er|QID|27515|M|71.98,66.59|N|Collect the roots in the area.|NC|
T Roots'll Do 'Er|QID|27515|M|67.71,65.90|N|To Thordun Hammerblow.|

A Wings Over Highbank|QID|27516|M|67.71,65.90|N|From Thordun Hammerblow.|
C Wings Over Highbank|QID|27516|M|79.76,77.78|N|Speak to Thordun Hammerblow when you are ready to fly back.|NC|
T Wings Over Highbank|QID|27516|M|79.12,78.27|N|To Kurdran Wildhammer upstairs.|

A Any Portal in a Storm|QID|27537|M|79.12,78.27|N|From Kurdran Wildhammer.|
A The Perfect Poultice|QID|27538|M|79.20,78.28|N|From Thordun Hammerblow.|

C Any Portal in a Storm|QID|27537|M|69.47,48.51|N|Kill water elementals for the cores.|S|
C The Perfect Poultice|QID|27538|M|69.75,49.10|N|Collect the glittering piles of Verrall River Muck.|NC|
C Any Portal in a Storm|QID|27537|M|69.47,48.51|N|Kill water elementals for the cores.|US|

T Any Portal in a Storm|QID|27537|M|79.50,77.62|N|To Talaa in the center courtyard.|S|
T The Perfect Poultice|QID|27538|M|79.50,77.62|N|To Talaa in the center courtyard.|
T Any Portal in a Storm|QID|27537|M|79.50,77.62|N|To Talaa in the center courtyard.|US|

A The Way is Open|QID|27545|M|79.50,77.62|N|From Talaa in the center courtyard.|
T The Way is Open|QID|27545|M|79.09,78.23|N|To Kurdran Wildhammer upstairs.|

A Firebeard's Patrol|QID|27621|M|79.21,78.27|N|From Thordun Hammerblow.|

r Sell junk, Repair/Restock|QID|27621|M|79.11,76.50|N|From Brundall Chiselgut, 	Dorgan Slagfist, or Richard Maschner in the profession trainer area.  Also beef up your profession skills if needed.|

T Firebeard's Patrol|QID|27621|M|60.18,57.96|N|To Keegan Firebeard.|
A Welcome Relief|QID|27803|M|60.18,57.96|N|From Keegan Firebeard.|S|
A The Only Homes We Have|QID|27804|M|60.18,57.96|N|From Keegan Firebeard.|
A Welcome Relief|QID|27803|M|60.18,57.96|N|From Keegan Firebeard.|US|

f Firebeard's Patrol|QID|27804|M|0.00,0.00|N|At Farstad Stonegrip.|

C Welcome Relief|QID|27803|M|59.67,56.91|N|Kill subjugated firestarters.|S|
C The Only Homes We Have|QID|27804|PRE|27803|U|62508|M|59.68,56.89|N|Use the Water Bucket to put out fires.|
C Welcome Relief|QID|27803|M|59.67,56.91|N|Kill subjugated firestarters.|US|

T Welcome Relief|QID|27803|M|60.08,58.00|N|To Keegan Firebeard.|S|
T The Only Homes We Have|QID|27804|M|60.08,58.00|N|To Keegan Firebeard.|
T Welcome Relief|QID|27803|M|60.08,58.00|N|To Keegan Firebeard.|US|

A Honorable Bearing|QID|27806|PRE|27803|M|60.08,58.00|N|From Keegan Firebeard.|

A Small Comforts|QID|27805|M|60.39,58.25|N|From Cailin Longfellow inside the building.|
C Meara's Dried Roses|QID|27805|QO|Meara's Dried Roses: 1/1|M|59.85,56.20|N|Up the stone to enter the house, then left and left.|NC|
C Aprika's Doll|QID|27805|QO|Aprika's Doll: 1/1|M|59.46,55.88|N|Small blue bear.|NC|
C Small Comforts|QID|27805|QO|Parlan's Ivory Hammer: 1/1|M|59.32,56.88|N|Enter and to the left.|NC|
T Small Comforts|QID|27805|M|60.40,58.24|N|To Cailin Longfellow inside the building.|

T Honorable Bearing|QID|27806|M|57.44,58.09|N|To Iain Firebeard.|
A Clan Mullan|QID|27807|M|57.44,58.09|N|From Iain Firebeard.|S|
A Stubborn as a Doyle|QID|27808|M|57.44,58.09|N|From Iain Firebeard.|S|
A Firebeard Bellows|QID|27809|M|57.44,58.09|N|From Iain Firebeard.|
A Clan Mullan|QID|27807|M|57.44,58.09|N|From Iain Firebeard.|US|
A Stubborn as a Doyle|QID|27808|M|57.44,58.09|N|From Iain Firebeard.|US|

T Clan Mullan|QID|27807|M|50.81,60.16|N|To Duglas Mullan.|

A The Fighting Spirit|QID|27810|M|50.81,60.16|N|From Duglas Mullan.|
C The Fighting Spirit|QID|27810|M|51.52,60.10|N|Challenge a lone fighter.|
T The Fighting Spirit|QID|27810|M|50.82,60.22|N|To Duglas Mullan.|

A The Scent of Battle|QID|27811|M|50.82,60.22|N|From Edana Mullan.|
C The Scent of Battle|QID|27811|S|M|56.95,63.99|N|Locate the Mullan Gryphons and help them.\n\nSome will be tied down - kill the Twilight Trapper Bindings around them\nSome will appear almost dead - heal them or use first aid on them\nOthers will just be looking at you intently - select the chat option 'smell charred branch'.|NC|

T Stubborn as a Doyle|QID|27808|M|61.48,67.49|N|To Keeland Doyle.|
A The Fate of the Doyles|QID|27999|M|61.48,67.49|N|From Keeland Doyle.|

C The Scent of Battle|QID|27811|US|M|56.95,63.99|N|Locate the Mullan Gryphons and help them.\n\nSome will be tied down - kill the Twilight Trapper Bindings around them\nSome will appear almost dead - heal them or use first aid on them\nOthers will just be looking at you intently - select the chat option 'smell charred branch'.|NC|

T The Scent of Battle|QID|27811|M|50.88,60.30|N|To Edana Mullan.|
A The Loyalty of Clan Mullan|QID|27812|M|50.88,60.30|N|From Duglas Mullan.|

T The Fate of the Doyles|QID|27999|M|57.42,58.17|N|To Iain Firebeard.|S|
T The Loyalty of Clan Mullan|QID|27812|M|57.42,58.17|N|To Iain Firebeard.|
T The Fate of the Doyles|QID|27999|M|57.42,58.17|N|To Iain Firebeard.|US|
T Firebeard Bellows|QID|27809|M|62.49,48.35|N|To Mackay Firebeard.|

A Death Worthy of a Dragonmaw|QID|27813|M|62.49,48.35|N|From Mackay Firebeard.|
A The Lost Brother|QID|28233|M|62.51,48.58|N|From Ella Forgehammer.|

A Anything We Can Get|QID|27814|M|62.57,48.62|N|From Brom Forgehammer.|
T The Lost Brother|QID|28233|M|63.21,47.58|N|To Bahrum Forgehammer just over the fence.|
A They Took Me Pants!|QID|28234|M|63.21,47.58|N|From Bahrum Forgehammer.|

C Anything We Can Get|QID|27814|S|M|62.58,46.71|N|Found in various ways:\n\nHanging on the wall of the tower\nInside crates near the broken catapult\nBy finding Injured Dragonmaw Stragglers and selecting Help Up, then looting the weapon from the floor\nKilling and looting Dragonmaw Stragglers.|NC|
C Death Worthy of a Dragonmaw|QID|27813|M|61.97,49.53|N|Either find Injured Dragonmaw Stragglers and select Help Up (credit without the fight), or take down Dragonmaw Stragglers.|S|
C They Took Me Pants!|QID|28234|M|62.31,46.93|N|Upstairs of the building, sefeat then look Gorosh the Pant Stealer.|
C Death Worthy of a Dragonmaw|QID|27813|M|61.97,49.53|N|Either find Injured Dragonmaw Stragglers and select Help Up (credit without the fight), or take down Dragonmaw Stragglers.|US|
C Anything We Can Get|QID|27814|US|M|62.58,46.71|N|Found in various ways:\n\nHanging on the wall of the tower\nInside crates near the broken catapult\nBy finding Injured Dragonmaw Stragglers and selecting Help Up, then looting the weapon from the floor\nKilling and looting Dragonmaw Stragglers.|NC|

T They Took Me Pants!|QID|28234|M|63.20,47.65|N|To Bahrum Forgehammer.|
T Anything We Can Get|QID|27814|M|62.57,48.74|N|To Brom Forgehammer.|
T Death Worthy of a Dragonmaw|QID|27813|M|62.47,48.49|N|To Mackay Firebeard.|
A Somethin' for the Boys|QID|27815|M|62.41,48.56|N|From Mackay Firebeard.|

T Somethin' for the Boys|QID|27815|M|57.42,58.15|N|To Iain Firebeard.|

A Personal Request|QID|27816|M|57.42,58.15|N|From Iain Firebeard.|
T Personal Request|QID|27816|M|60.13,57.84|N|To Keegan Firebeard.|

A Dropping the Hammer|QID|27817|M|60.13,57.84|N|From Keegan Firebeard.|
C Dropping the Hammer|QID|27817|QO|Twilight Stormbender slain: 12/12|M|58.77,52.06|N|Mount up on one of the gryphons. Target Stormbenders and hit 1. Hit 2 if you get zapped.|
C Dropping the Hammer|QID|27817|N|Target Servias Windterror. Use 1 and 2 to bring down his health. When you are dismounted, finish him off. Avoid his power surges.|T|Servias Windterror|
T Dropping the Hammer|QID|27817|M|60.10,57.78|N|To Keegan Firebeard.|

A Dunwalds Don't Die|QID|27640|M|60.10,57.78|N|From Keegan Firebeard.|
A A Coward's Due|QID|28001|M|60.10,57.78|N|From Keegan Firebeard.|

T Dunwalds Don't Die|QID|27640|M|45.96,65.53|N|To Keely Dunwald. In the house and down the stairs.|
A Donnelly Dunwald|QID|27643|M|45.96,65.53|N|From Keely Dunwald.|
A Eoin Dunwald|QID|27644|M|45.96,65.53|N|From Keely Dunwald.|
A Cayden Dunwald|QID|27645|M|45.96,65.53|N|From Keely Dunwald.|
A While Meeting The Family|QID|27641|M|45.96,65.53|N|From Flynn Dunwald.|
A Sifting Through The Wreckage|QID|27642|M|45.96,65.53|N|From Flynn Dunwald.|
C Sifting Through The Wreckage|QID|27642|S|M|51.94,70.32|N|On the ground and in the buildings.|
C While Meeting The Family|QID|27641|M|49.80,71.20|N|Kill any Twilight "guest" you see.|S|

T Cayden Dunwald|QID|27645|M|45.72,71.63;47.95,74.65|N|To Cayden Dunwald. He could be at either end of the pass.|

A Once More Into The Fire|QID|27648|M|45.72,71.63;47.95,74.65|N|From Cayden Dunwald.|
C Once More Into The Fire|QID|27648|M|45.72,71.63;47.95,74.65|N|Escort quest. Talk to him to get it started.|
T Once More Into The Fire|QID|27648|M|45.72,71.63;47.95,74.65|N|To Cayden Dunwald.|

T Eoin Dunwald|QID|27644|M|52.93,74.36|N|To Eoin Dunwald.|
A Anything But Water|QID|27647|PRE|27644|M|52.93,74.36|N|From Eoin Dunwald.|
C Anything But Water|QID|27647|M|52.83,69.78|N|Downstairs. You will be ambushed, so be prepared. Eoin will help you though. Kegs are to your right.|
T Anything But Water|QID|27647|M|52.42,70.39|N|To Eoin Dunwald.|

A A Steady Supply|QID|27649|PRE|27644|M|52.42,70.39|N|From Eoin Dunwald.|

T Donnelly Dunwald|QID|27643|M|46.53,59.17|N|To Donnelly Dunwald.|
A Finding Beak|QID|27646|M|46.53,59.17|N|From Donnelly Dunwald.|

C A Steady Supply|QID|27649|S|M|49.54,71.85|N|Kegs in the buildings.|
C Finding Beak|QID|27646|QO|Search the buildings in eastern Dunwald Hovel: 1/1|M|48.44,52.57|N|Enter the building.|
C Finding Beak|QID|27646|QO|Search the cellar in northwestern Dunwald Hovel: 1/1|M|46.11,54.40|N|In the celler.|
C Finding Beak|QID|27646|M|45.83,59.28|N|Head inside and downwards.|

T Finding Beak|QID|27646|M|46.05,58.69|N|To Donnelly Dunwald.|
A Home Again|QID|27650|M|47.84,74.52|N|From Cayden Dunwald.|

C Sifting Through The Wreckage|QID|27642|US|M|51.94,70.32|N|On the ground and in the buildings.|
C Steady Supply|QID|27649|US|M|49.54,71.85|N|Kegs in the buildings.|
C While Meeting The Family|QID|27641|M|49.80,71.20|N|Finish killing Twilight "guests".|US|

T Home Again|QID|27650|M|45.97,65.53|N|To Keely Dunwald.|
A Doing It Like a Dunwald|QID|27651|M|45.97,65.53|N|From Keely Dunwald.|

T A Steady Supply|QID|27649|M|50.49,70.90|N|To Eoin Dunwald.|
C Doing It Like a Dunwald|QID|27651|M|50.49,70.90|N|Talk to Flynn Dunwald to start it.|

T Doing It Like a Dunwald|QID|27651|M|50.51,70.68|N|To Flynn Dunwald.|
T While Meeting The Family|QID|27641|M|50.51,70.68|N|To Flynn Dunwald.|
T Sifting Through The Wreckage|QID|27642|M|50.51,70.68|N|To Flynn Dunwald.|

A Dragonmaw Takedown|QID|27754|M|48.93,29.82|N|From Colin Thundermar.|
A My Sister, Fanny|QID|28369|M|48.93,29.82|N|From Colin Thundermar.|
T A Coward's Due|QID|28001|M|48.93,29.82|N|From Colin Thundermar.|

r Sell junk, Repair/Restock|QID|28369|M|49.04,29.15|
f Thundermar|QID|28369|M|48.53,28.18|N|At Doran Talonheart.|

T My Sister, Fanny|QID|28369|M|49.76,29.23|N|To Fanny Thundermar.|

A Never Leave a Dinner Behind|QID|27753|M|49.76,29.23|N|From Fanny Thundermar.|
A Fight Like a Wildhammer|QID|27752|M|49.76,29.23|N|From Low Shaman Blundy.|

C Fight Like a Wildhammer|QID|27752|S|M|53.08,27.73|N|You can go back and forth between towns.|
C Never Leave a Dinner Behind|QID|27753|S|M|52.55,27.99|N|You can go back and forth between towns.|
C Dragonmaw Takedown|QID|27754|M|48.76,39.88|N|Kill Dragonmaw Marauders and loot them to get the Dragonmar Insignia.|
C Fight Like a Wildhammer|QID|27752|US|M|53.08,27.73|N|You can go back and forth between towns. Try to pick those not fighting.|
C Never Leave a Dinner Behind|QID|27753|US|M|52.55,27.99|N|You can go back and forth between towns. Try to pick those not fighting.|

T Dragonmaw Takedown|QID|27754|M|49.03,29.69|N|To Colin Thundermar.|
T Fight Like a Wildhammer|QID|27752|M|49.77,29.20|N|To Low Shaman Blundy.|
T Never Leave a Dinner Behind|QID|27753|M|49.79,29.23|N|To Fanny Thundermar.|

A A Vision of Twilight|QID|28241|M|49.75,29.18|N|From Low Shaman Blundy.|
A Tempered in Elemental Flame|QID|28211|M|49.14,29.38|N|From Nivvet Channelock.|
A Hot Stuff|QID|28212|M|49.14,29.38|N|From Nivvet Channelock.|
A Potential Energy|QID|28215|M|49.14,29.38|N|From Nivvet Channelock.|
A Magmalord Falthazar|QID|28216|M|49.03,29.69|N|From Colin Thundermar.|

C Tempered in Elemental Flame|QID|28211|S|M|41.12,22.28|N|Loot Tempered Spears from the ground.|
C Hot Stuff|QID|28212|M|43.50,23.19|N|Kill and loot Unbound Emberfiends until you get 5 Molten Fury.|S|
C Magmalord Falthazar|QID|28216|M|43.12,24.32|N|Head to the waypoint and kill Magmalord Falthazar.|
C Tempered in Elemental Flame|QID|28211|US|M|41.12,22.28|N|Finish looting Tempered Spears.|
C Hot Stuff|QID|28212|M|43.50,23.19|N|Kill and loot Unbound Emberfiends until you get 5 Molten Fury.|US|

T Magmalord Falthazar|QID|28216|M|49.02,29.67|N|To Colin Thundermar.|
T Tempered in Elemental Flame|QID|28211|M|49.13,29.28|N|To Nivvet Channelock.|
T Hot Stuff|QID|28212|M|49.13,29.28|N|To Nivvet Channelock.|

T A Vision of Twilight|QID|28241|M|57.89,33.42|N|To the Eye of Twilight.|
A We All Must Sacrifice|QID|28242|M|57.89,33.42|N|From the Eye of Twilight.|
C We All Must Sacrifice|QID|28242|M|58.87,32.43|N|Kill Shamans of the Black.|
C Potential Energy|QID|28215|M|58.65,30.40|N|Kill and loot Obsidian Stoneslaves to get Twisted Elementium Loops.|
C We All Must Sacrifice|QID|28242|M|58.87,32.43|N|Finish killing Shamans of the Black.|
T We All Must Sacrifice|QID|28242|M|57.86,33.42|N|To the Eye of Twilight.|

A The Eyes Have It|QID|28243|M|57.86,33.42|N|From the Eye of Twilight.|
T The Eyes Have It|QID|28243|M|49.74,29.18|N|To Low Shaman Blundy.|

A Eye Spy|QID|28244|M|49.74,29.18|N|From Low Shaman Blundy.|
C Eye Spy|QID|28244|M|49.69,29.15|N|Look into the eye right next to Low Shaman Blundy.|
T Eye Spy|QID|28244|M|49.74,29.17|N|To Low Shaman Blundy.|

T Potential Energy|QID|28215|M|49.07,29.38|N|To Nivvet Channelock.|
A Tear Them From the Sky!|QID|28280|M|49.07,29.38|N|From Nivvet Channelock.|
C Tear Them From the Sky!|QID|28280|U|63393|T|Dragonmaw Black Drake|M|49.06,29.66|N|Target and then Use the Shoulder Mounted Drake Dropper to kill Black Drakes.|
T Tear Them From the Sky!|QID|28280|M|49.11,29.30|N|To Nivvet Channelock.|

A Last Stand at Thundermar|QID|28281|M|48.96,29.70|N|From Colin Thundermar.|
C Last Stand at Thundermar|QID|28281|M|48.56,29.79|N|Kill 8 Dragonmaw Skyclaw.|
T Last Stand at Thundermar|QID|28281|M|48.96,29.80|N|To Colin Thundermar.|

A Narkrall, The Drake-Tamer|QID|28282|M|48.96,29.80|N|From Colin Thundermar.|
C Narkrall, The Drake-Tamer|QID|28282|M|49.04,29.80|N|Speak to Colin Thundermar when you are ready to fight.|
T Narkrall, The Drake-Tamer|QID|28282|M|48.98,29.75|N|To Colin Thundermar.|

A The Kirthaven Summit|QID|28294|M|48.98,29.75|N|From Colin Thundermar.|
T The Kirthaven Summit|QID|28294|M|54.36,16.78|N|To Lachlan MacGraff.|

A The Bachelor|QID|28346|M|54.77,17.28|N|From Kurdran Wildhammer.|
T The Bachelor|QID|28346|M|54.43,16.82|N|To Keegan Firebeard.|

A Rescue at Glopgut's Hollow|QID|28377|M|54.43,16.82|N|From Keegan Firebeard.|

f Kirthaven|QID|28377|M|56.71,15.20|N|At Shaina Talonheart.|
T Rescue at Glopgut's Hollow|QID|28377|M|38.19,34.42|N|To Colin Thundermar.|

A Find Fanny|QID|28378|M|38.19,34.42|N|From Colin Thundermar.|
A Ogre Bashin'|QID|28379|M|38.19,34.42|N|From Colin Thundermar.|

C Ogre Bashin'|QID|28379|M|39.67,31.02|N|Kill any Glopgut Ogres you see.|S|
C Find Fanny|QID|28378|M|34.98,31.17|N|Enter the cave right behind Colin Thundermar.|
C Ogre Bashin'|QID|28379|M|39.67,31.02|N|Finish killing Glopgut Ogres.|US|

T Find Fanny|QID|28378|M|38.17,34.43|N|To Colin Thundermar.|
T Ogre Bashin'|QID|28379|M|38.17,34.43|N|To Colin Thundermar.|

A The Bachelorette|QID|28407|M|38.16,34.40|N|From Colin Thundermar.|
T The Bachelorette|QID|28407|M|54.69,17.91|N|To Fanny Thundermar.|

A Something Bold|QID|28408|M|54.36,16.79|N|From Lachlan MacGraff.|
A Something Brewed|QID|28409|M|54.36,16.79|N|From Lachlan MacGraff.|
A Something Stolen|QID|28410|M|54.36,16.79|N|From Lachlan MacGraff.|
A Something Stewed|QID|28411|M|54.36,16.79|N|From Lachlan MacGraff.|

A Words and Music By...|QID|28413|M|54.64,17.47|N|From Russell Brower.|
C Words and Music By...|QID|28413|M|54.64,17.47|N|Speak to Russell Brower when you are ready. (Doesn't matter what you choose.)|
T Words and Music By...|QID|28413|M|54.68,17.52|N|To Russell Brower.|

C Something Stolen|QID|28410|M|77.18,51.77|N|Look for the zeppelin that runs up and down the coast. Head down to the cargo hold.|
C Something Stewed|QID|28411|S|M|67.32,26.90|N|Kill and loot Elks and Does for the Venison, and Worgs for the Ribs.|
C Something Bold|QID|28408|M|72.07,27.83|N|From owls and on the ground.|
C Something Stewed|QID|28411|US|M|67.32,26.90|N|Kill and loot Elks and Does for the Venison, and Worgs for the Ribs.|
C Something Brewed|QID|28409|M|64.41,22.65|N|Speak to Hammelhand to start the quest.|

T Something Bold|QID|28408|M|54.35,16.74|N|To Lachlan MacGraff.|
T Something Brewed|QID|28409|M|54.35,16.74|N|To Lachlan MacGraff.|
T Something Stolen|QID|28410|M|54.35,16.74|N|To Lachlan MacGraff.|
T Something Stewed|QID|28411|M|54.35,16.74|N|To Lachlan MacGraff.|

A Wild, Wild, Wildhammer Wedding|QID|28655|M|54.35,16.74|N|From Grundy MacGraff.|
C Wild, Wild, Wildhammer Wedding|QID|28655|M|55.30,17.78|N|Talk to Grundy MacGraff to start the wedding. Kill "The Beast Unleashed" when it appears, it appears right near the Bride and Groom.|
T Wild, Wild, Wildhammer Wedding|QID|28655|M|55.21,17.25|N|To Kurdran Wildhammer.|

A The Maw of Madness|QID|27374|M|55.21,17.25|N|From Lachlan MacGraff.|
T The Maw of Madness|QID|27374|M|44.09,10.61|N|To Earthcaller Torunscar.|

A Torn Ground|QID|27299|M|44.09,10.61|N|From Earthcaller Torunscar.|
C Torn Ground|QID|27299|M|45.11,12.72|N|Go down and kill the non-elite Tentacles of Iso'rath.|
T Torn Ground|QID|27299|M|44.09,10.61|N|To Earthcaller Torunscar.|

A Pushing Back|QID|27300|M|44.09,10.61|N|From Earthcaller Torunscar.|
A Simple Solutions|QID|27302|M|44.34,11.40|N|From Initiate Goldmine.|

A Unbroken|QID|27301|M|44.01,11.29|N|From Earthmender Duarn.|
C Simple Solutions|QID|27302|M|41.09,17.07|N|Kegs of oil on the ground.|S|
C Pushing Back|QID|27300|S|M|43.60,18.85|N|Kill Drakgor Cultists.|
T Unbroken|QID|27301|M|44.22,18.23|N|To Earthcaller Yevaa.|
A Mercy for the Bound|QID|27303|M|44.22,18.23|N|From Earthcaller Yevaa.|

C Mercy for the Bound|QID|27303|M|41.38,16.91|N|Kill and loot Bound Fleshburners.|
C Simple Solutions|QID|27302|M|41.09,17.07|N|Kegs of oil on the ground.|US|
C Pushing Back|QID|27300|US|M|43.60,18.85|N|Kill Drakgor Cultists.|

T Pushing Back|QID|27300|M|44.03,10.66|N|To Earthcaller Torunscar.|
T Simple Solutions|QID|27302|M|44.39,11.46|N|To Initiate Goldmine.|
T Mercy for the Bound|QID|27303|M|43.85,11.42|N|To Earthcaller Yevaa.|

A The Maw of Iso'rath|QID|27376|M|44.02,10.67|N|From Earthcaller Torunscar.|
C The Maw of Iso'rath|QID|27376|M|44.46,10.48|N|Hop on a gryphon.|
T The Maw of Iso'rath|QID|27376|M|48.36,14.53|N|To Earthcaller Yevaa.|

A Devoured|QID|27377|M|48.36,14.53|N|From Earthcaller Yevaa.|
C Devoured|QID|27377|M|48.94,14.51|N|Just wait, once you get near death Thrall will save you.|
T Devoured|QID|27377|M|33.30,50.67|Z|The Maelstrom|N|To Thrall.|

A The Worldbreaker|QID|27378|M|33.30,50.67|Z|The Maelstrom|N|From Thrall.|
C The Worldbreaker|QID|27378|M|33.12,50.10|Z|The Maelstrom|N|Nothing to do. Be sure you are healed up.|
T The Worldbreaker|QID|27378|M|48.68,16.57|N|To Earthcaller Yevaa.|

A The Terrors of Iso'rath|QID|27379|M|48.68,16.57|N|From Earthcaller Yevaa.|
C Save Stormcaller Jalara|QID|27379|QO|Save Stormcaller Jalara: 1/1|M|49.58,15.74|N|Use the protective bubbles to heal up and get rid of the debuff. Kill the tentacle holding Stormcaller Jalara.|
C Save Earthmender Duar|QID|27379|QO|Save Earthmender Duarn: 1/1|M|49.05,13.05|N|Use the protective bubbles to heal up and get rid of the debuff. Kill the tentacle holding Earthmender Duarn.|
C Save Hargoth Dimblaze|QID|27379|QO|Save Hargoth Dimblaze: 1/1|M|47.25,13.61|N|Use the protective bubbles to heal up and get rid of the debuff. Kill the tentacle holding Hargoth Dimblaze.|
C The Terrors of Iso'rath|QID|27379|QO|Save Stormcaller Mylra: 1/1|M|47.48,15.30|N|Use the protective bubbles to heal upand get rid of the debuff. Kill the tentacle holding Stormcaller Mylra.|
T The Terrors of Iso'rath|QID|27379|M|48.67,16.64|N|To Earthcaller Yevaa.|

A Nightmare|QID|27380|M|48.67,16.64|N|From Earthcaller Yevaa.|
C Nightmare|QID|27380|M|48.34,14.00|N|You will need to run to his hit box. Just attack and the others will follow. Don't worry about heals since the healer will mend you. If he evades you, then abandon the quest and pick it up again.|
T Nightmare|QID|27380|M|44.03,10.56|N|To Earthcaller Torunscar.|

A Warm Welcome|QID|27485|M|44.06,10.50|N|From Lauriel Trueblade.|
C Warm Welcome|QID|27485|M|27.55,21.37|N|Head towards the waypoint and watch the scene.|
T Warm Welcome|QID|27485|M|29.34,26.00|N|To Calen.|

A Even Dragons Bleed|QID|27504|M|29.34,26.00|N|From Calen.|
f Vermillion Redoubt|QID|27509|M|28.47,24.95|N|At Aquinastrasz.|
T Even Dragons Bleed|QID|27504|M|29.84,31.15|N|To Velastrasza.|

A Draconic Mending|QID|27505|M|29.84,31.15|N|From Velastrasza.|
A Life from Death|QID|27506|M|29.80,31.25|N|From Baleflame.|

C Life from Death|QID|27506|S|U|61323|M|27.95,31.49|N|Plant the seeds after you kill them.|
C Draconic Mending|QID|27505|M|29.61,33.29|N|Protect the people healing the big dragon.|
C Life from Death|QID|27506|US|U|61323|M|27.95,31.49|

T Life from Death|QID|27506|M|29.80,31.28|N|To Baleflame.|
T Draconic Mending|QID|27505|M|29.80,31.28|N|To Velastrasza.|

A In Defense of the Redoubt|QID|27564|M|29.80,31.28|N|From Velastrasza.|
T In Defense of the Redoubt|QID|27564|M|29.34,25.94|N|To Calen.|

A Far from the Nest|QID|27508|M|29.34,25.94|N|From Lirastrasza.|
A Encroaching Twilight|QID|27507|M|29.34,25.94|N|From Calen.|
A Breach in the Defenses|QID|27509|M|29.34,25.94|N|From Calen.|

C Far from the Nest|QID|27508|S|M|20.81,15.71|N|Kill Twilight Abductors (ones that are holding eggs), then loot the eggs off of the ground.|
C Encroaching Twilight|QID|27507|M|22.10,17.65|N|Kill Twilight Invaders.|S|
C Breach in the Defenses|QID|27509|M|17.96,16.86|N|Use the Flashgrowth Mote at the Twilight Portal.|
C Encroaching Twilight|QID|27507|US|M|22.10,17.65|N|If you catch them in this strip after a dragon straffs it, they are a bit easier to kill.|
C Far from the Nest|QID|27508|US|M|20.81,15.71|N|Kill Twilight Abductors (ones that are holding eggs), then loot the eggs off of the ground.|

T Encroaching Twilight|QID|27507|M|29.29,26.05|N|To Calen.|
T Far from the Nest|QID|27508|M|29.29,26.05|N|To Lirastrasza.|
T Breach in the Defenses|QID|27509|M|29.29,26.05|N|To Calen.|

L Level 85|QID|27509|LVL|85|N|You should be around level 85 by this point.|

A Mathias' Command|QID|28101|M|29.34,25.94|N|From Calen.|
T Mathias' Command|QID|28101|M|26.02,38.92|N|To Master Mathias Shaw.|

A Easy Pickings|QID|28103|M|26.02,38.92|N|From Master Mathias Shaw.|
A Precious Goods|QID|28104|M|26.02,38.92|N|From Master Mathias Shaw.|

C Easy Pickings|QID|28103|M|25.21,36.76|N|Kill 8 Twilight Spearwardens.|S|
l Twilight Caravan Cargo Key|QID|28104|M|25.21,36.76|QO|Twilight Caravan Cargo Key: 1/1|N|Kill and loot Twilight Spearwardens until you get the key.|
C Precious Goods|QID|28104|M|24.69,37.89|N|Use the key at the Twilight Caravan Chest to get the Gatestone.|
C Easy Pickings|QID|28103|M|25.21,36.76|N|Kill 8 Twilight Spearwardens.|US|

T Easy Pickings|QID|28103|M|25.97,38.74|N|To Master Mathias Shaw.|
T Precious Goods|QID|28104|M|25.98,38.80|N|To Master Mathias Shaw.|

A If The Key Fits|QID|28108|M|25.98,38.80|N|From Master Mathias Shaw.|

A Paving the Way|QID|28107|M|26.01,38.94|N|From Highbank Lieutenant.|
C Paving the Way|QID|28107|M|29.45,50.17|N|Speak to Master Mathia Shaw to gather the troops. Then head out towards the waypoint killing any Twilight mob.|
T Paving the Way|QID|28107|M|29.46,50.37|N|To Highbank Lieutenant.|

C If The Key Fits|QID|28108|M|29.72,51.13|N|Head to the waypoint and watch the scene.|

T If The Key Fits|QID|28108|M|29.23,52.03|N|To Highbank Lieutenant.|

A Pressing Forward|QID|28109|M|29.23,52.03|N|From Highbank Lieutenant.|
C Pressing Forward|QID|28109|M|22.92,56.10|N|Head to the waypoint.|
T Pressing Forward|QID|28109|M|22.16,56.50|N|To Calen.|

A Enter the Dragon Queen|QID|28712|M|21.81,56.98|N|From Alexstrasza the Life-Binder.|
T Enter the Dragon Queen|QID|28712|M|14.89,16.36|N|To Lirastrasza.|

A Battle of Life and Death|QID|28758|M|14.15,15.47|N|From Calen.|
C Battle of Life and Death|QID|28758|M|20.15,51.53|N|Mount the Vermillion Vanguard. Kill 8 Twilight Shadowdrakes.|
T Battle of Life and Death|QID|28758|M|22.10,56.60|N|To Calen.|

A And the Sky Streaked Red|QID|28171|M|22.10,56.60|N|From Calen.|
C And the Sky Streaked Red|QID|28171|M|22.10,56.60|N|You'll automatically jump on a Vermillion Skyscreamer.|
T And the Sky Streaked Red|QID|28171|M|59.05,69.81|N|To Lirastrasza.|

A Shining Through the Dark|QID|28175|M|59.05,69.81|N|From Velastrasza.|
A A Fitting End|QID|28191|M|59.05,69.81|N|From Lirastrasza.|
A Blackout|QID|28173|M|59.05,69.81|N|From Lirastrasza.|

C A Fitting End|QID|28191|M|60.40,73.91|S|N|Kill Obsidian Dragonkin.|
C Blackout|QID|28173|S|U|63092|T|Obsidian Pyrewing|M|64.49,81.07|N|Pull the dragons from the sky with the hook. Then kill.|
C Shining Through the Dark|QID|28175|U|63139|M|63.26,77.46|N|Enter under the tree here, and plant the seed in the middle.|
C A Fitting End|QID|28191|M|60.40,73.91|US|N|Finish killing Obsidian Dragonkin.|
C Blackout|QID|28173|US|U|63092|T|Obsidian Pyrewing|M|64.49,81.07|N|Pull the dragons from the sky with the hook. Then kill.|

T A Fitting End|QID|28191|M|59.07,69.87|N|To Lirastrasza.|
T Blackout|QID|28173|M|59.07,69.87|N|To Lirastrasza.|
T Shining Through the Dark|QID|28175|M|59.07,69.87|N|To Velastrasza.|

A Following the Young Home|QID|28176|M|59.07,69.87|N|From Lirastrasza.|
C Following the Young Home|QID|28176|QO|Obsidian Whelps hatched: 1/1|U|63126|M|57.97,80.33|N|Use Mother's Flame on the Obsidian Eggs.|
C Following the Young Home|QID|28176|M|55.63,83.74|N|Just follow the tunnel downward.|
T Following the Young Home|QID|28176|M|44.92,91.02|N|To Baleflame.|

A Last of Her Kind|QID|28247|M|44.92,91.02|N|From Baleflame.|
C Last of Her Kind|QID|28247|M|44.98,91.51|N|Let Balflame get some threat then attack Obsidia. Pools of lava will appear around you now and then, move out of them. She will also have Whelplings attack now and then, they are weak.|
T Last of Her Kind|QID|28247|M|59.12,69.91|N|To Lirastrasza.|

A Victors' Point|QID|28248|M|59.12,69.91|N|From Lirastrasza.|
T Victors' Point|QID|28248|M|43.39,57.48|N|To Kurdran Wildhammer.|

A Ogres & Ettins|QID|27492|M|43.39,57.48|N|From Kurdran Wildhammer.|
A Call in the Artillery|QID|27496|M|43.39,57.48|N|From Cassius the White.|
A SI:7 Drop|QID|27490|M|43.39,57.48|N|From Cassius the White.|

f Victor's Point|QID|27496|M|43.82,57.31|N|At Desmond Chadsworth.|
r Sell junk, Repair/Restock|QID|27499|M|43.81,57.74|

C SI:7 Drop|QID|27490|QO|Get Wildhammer squad: 1/1|M|43.82,57.31|N|Talk to Angus, just left of the flight master, to pick up your squad.|
C SI:7 Drop|QID|27490|M|39.24,64.58|N|Head to the waypoint and land on the blue X that is on the ground.|
C Ogres & Ettins|QID|27492|M|43.03,63.11|S|N|Kill Twilight Ogres and Ettins.|
N Southwestern building targeted|QID|27496|QO|Southwestern building targeted: 1/1|U|61363|M|39.66,69.23|N|Southwestern building targeted.|
N Southern building targeted|QID|27496|QO|Southern building targeted: 1/1|U|61363|M|41.36,73.73|N|Southern building targeted.|
N Northeastern building targeted|QID|27496|QO|Northeastern building targeted: 1/1|U|61363|M|41.02,64.30|N|Northeasterb building targeted.|
C Call in the Artillery|QID|27496|U|61363|M|38.87,61.16|N|Northern building targeted.|
C Ogres & Ettins|QID|27492|M|43.03,63.11|US|N|Finish killing Twilight Ogres and Ettins.|

T SI:7 Drop|QID|27490|M|43.41,57.48|N|To Cassius the White.|
T Call in the Artillery|QID|27496|M|43.41,57.48|N|To Cassius the White.|
T Ogres & Ettins|QID|27492|M|43.41,57.48|N|To Kurdran Wildhammer.|

A Move the Mountain|QID|27494|M|43.41,57.48|N|From Kurdran Wildhammer.|
C Move the Mountain|QID|27494|M|38.05,66.08|N|Click on the Hidden Explosives to detonate them.|
T Move the Mountain|QID|27494|M|38.05,66.08|N|(UI Alert)|

A Signal the Attack|QID|27498|M|38.05,66.08|N|(UI Alert)|
C Signal the Attack|QID|27498|U|61511|M|40.41,62.38|N|Get to the top of the Gate Tower and use the Attack Signal.|
T Signal the Attack|QID|27498|M|40.41,62.38|N|(UI Alert)|

A Four Heads are Better than None|QID|27500|M|40.41,62.38|N|(UI Alert)|
C Beeble's and Phod|QID|27500|QO|Beeble's Head: 1/1|M|39.77,71.35;38.87,70.94|N|Enter the cave and head to the right. Kill and loot Beeble'phod for his two heads. Don't forget your towel.|
C Four Heads are Better than None|QID|27500|M|37.93,71.35|N|Head to the other side and kill then loot Za'brox for his heads.|
T Four Heads are Better than None|QID|27500|M|43.43,57.42|N|To Cassius the White.|

A Up to the Citadel|QID|27502|M|43.43,57.42|N|From Cassius the White.|
N Speak to the Squad Commander|QID|27502|M|38.95,64.01|QO|Speak to the Squad commander: 1/1|N|Do what the step title says.|
C Up to the Citadel|QID|27502|M|37.33,66.09|N|Stay with the SI:7 group, the move sloooow.|
T Up to the Citadel|QID|27502|M|37.33,66.08|N|To Cho'gall.|

A Just You and Mathias|QID|27636|M|37.33,66.08|N|(UI Alert)|
T Just You and Mathias|QID|27636|M|36.35,65.97|N|To Master Mathias Shaw.|

A Dark Assassins|QID|27652|M|36.35,65.97|N|From Master Mathias Shaw.|
A Bring the Hammer Down|QID|27654|M|36.35,65.97|N|From Master Mathias Shaw.|
A Help from the Earthcaller|QID|27657|M|36.35,65.97|N|From Master Mathias Shaw.|

C Bring the Hammer Down|QID|27654|S|M|33.69,66.45|N|Kill any combination of Citadel Veterans, Corrupted Elementalists, and/or Twilight Vindicators.|
C Dark Assassins|QID|27652|M|37.97,77.93|S|N|Kill and loot any Dark Assassin you see for their pendants.|

T Help from the Earthcaller|QID|27657|M|37.52,88.68|N|To Earthcaller Yevaa.|

A Portal Overload|QID|27659|M|37.52,88.68|N|From Earthcaller Yevaa.|
A Spirit of the Loch|QID|27660|M|37.52,88.68|N|From Earthcaller Yevaa.|
A Unbinding|QID|27662|M|37.52,88.68|N|From Initiate Goldmine.|

C Unbinding|QID|27662|S|M|43.29,78.33|N|Kill any Enslaved Elemental you see.|
K Apexar slain|QID|27659|QO|Debilitated Apexar slain: 1/1|M|38.14,80.32|N|Click on the Earth Portal Vontroller, then kill Apexar.|
K Aetharon slain|QID|27659|QO|Debilitated Aetharon slain: 1/1|M|44.28,81.51|N|Way up in the air. Click on the Earth Portal Controller, then kill Aetharon.|
C Portal Overload|QID|27659|M|33.02,62.42|N|Click on the Earth Portal Controller, then kill Edemantus.|
C Unbinding|QID|27662|US|M|34.29,69.07|N|Finish killing Enslaved Elementals.|
C Dark Assassins|QID|27652|M|37.97,77.93|US|N|Kill and loot any Dark Assassin you see for their pendants.|
C Bring the Hammer Down|QID|27654|US|M|33.69,66.45|N|Finish killing any Twilight Citadel Cultists you need.|
T Spirit of the Loch|QID|27660|M|27.62,63.93|N|To Countess Verrall.|

A Fire the Cannon|QID|27661|M|27.62,63.93|N|From Countess Verrall.|

T Dark Assassins|QID|27652|M|36.34,66.10|N|To Master Mathias Shaw.|
T Bring the Hammer Down|QID|27654|M|36.34,66.10|N|To Master Mathias Shaw.|

A Distract Them for Me|QID|27688|M|36.34,66.10|N|From Master Mathias Shaw.|
A The Elementium Axe|QID|27695|M|36.34,66.10|N|From Master Mathias Shaw.|
K Master Klem|QID|27688|M|36.14,70.84|QO|Master Klem slain: 1/1|N|Head down into the pit and attack Master Klem. Get him down in health, then Mathias will help kill him.|

C Fire the Cannon|QID|27661|M|40.88,78.89|N|Kill Lord Cannon.|
C The Elementium Axe|QID|27695|M|40.04,83.94|N|Kill and loot Blindeye the Guardian.|
K Mia the Rose|QID|27688|M|42.31,83.47|QO|Mia the Rose slain: 1/1|N|Kill Mia the Rose, she is at the top of the building stealthed.|
C Distract Them for Me|QID|27688|M|43.07,88.01|N|Finally kill Dame Alys Finnsson.|

T Unbinding|QID|27662|M|37.61,88.66|N|To Initiate Goldmine.|
T Portal Overload|QID|27659|M|37.54,88.67|N|To Earthcaller Yevaa.|
T Fire the Cannon|QID|27661|M|27.66,63.98|N|To Countess Verrall.|

A Water of Life|QID|27719|M|27.66,63.98|N|From Countess Verrall.|
C Water of Life|QID|27719|U|62503|M|35.08,60.99|N|Head to the Corpse of Foremaster Finlay and use the Water of Life on it.|
T Distract Them for Me|QID|27688|M|36.37,66.02|N|To Master Mathias Shaw.|

T The Elementium Axe|QID|27695|M|36.37,66.02|N|To Master Mathias Shaw.|

A Dragon, Unchained|QID|27700|M|36.37,66.02|N|From Master Mathias Shaw.|
T Water of Life|QID|27719|M|36.37,66.02|N|To Master Mathias Shaw.|
C Dragon, Unchained|QID|27700|U|62248|M|32.49,68.50|N|Head towards Lirastraza and use the Elementium Axe to free her.|
T Dragon, Unchained|QID|27700|M|36.34,66.10|N|To Master Mathias Shaw.|

A Coup de Grace|QID|27702|M|36.34,66.10|N|From Master Mathias Shaw.|
C Coup de Grace|QID|27702|M|35.62,73.86|N|Find a downed Twilight Skyterror and attack it to kill it.|
T Coup de Grace|QID|27702|M|36.33,66.09|N|To Master Mathias Shaw.|

A Back to the Elementium Depths|QID|27711|M|36.33,66.09|N|From Master Mathias Shaw.|
T Back to the Elementium Depths|QID|27711|M|37.51,88.63|N|To Initiate Goldmine.|

A Mr. Goldmine's Wild Ride|QID|27720|M|37.51,88.63|N|From Initiate Goldmine.|
C Mr. Goldmine's Wild Ride|QID|27720|M|38.29,93.90|N|Talk to Initiate Goldmine when you're ready. Enjoy the ride!|
T Mr. Goldmine's Wild Ride|QID|27720|M|38.29,93.90|N|To Initiate Goldmine.|

A A Little on the Side|QID|27742|M|38.29,93.90|N|From Initiate Goldmine.|
A While We're Here|QID|27743|M|38.29,93.90|N|From Initiate Goldmine.|

C A Little on the Side|QID|27742|S|M|38.96,94.10|N|Pick up Elementuim Shards off the ground, or kill and loot Elementum Spinners.|
C While We're Here|QID|27743|S|M|37.09,95.53|N|Kill any Twilight mob you see.|
A Rune Ruination|QID|27744|M|37.45,93.21|N|From the Twilight Rune of Earth.|
C Rune of Earth|QID|27744|QO|Rune of Earth destroyed: 1/1|M|37.42,93.24|N|Click on the Rune of Earth to destroy it.|
C Rune of Water|QID|27744|QO|Rune of Water destroyed: 1/1|M|35.15,90.39|N|Click on the Rune of Water to destroy it.|
C Rune of Air|QID|27744|QO|Rune of Air destroyed: 1/1|M|33.52,88.41|N|Click on the Rune of Air to destroy it.|
C Rune Ruination|QID|27744|M|34.32,86.70|N|Click on the Rune of Fire to destroy it.|
C While We're Here|QID|27743|US|M|37.09,95.53|N|Finish killing Twilight mobs.|
C A Little on the Side|QID|27742|US|M|38.96,94.10|N|Finish getting Elementium Shards.|

T While We're Here|QID|27743|M|37.11,95.46|N|To Initiate Goldmine.|
T A Little on the Side|QID|27742|M|38.96,94.10|N|To Initiate Goldmine.|
T Rune Ruination|QID|27744|M|34.91,85.75|N|To Initiate Goldmine.|

A A Fiery Reunion|QID|27745|M|34.91,85.75|N|From Initiate Goldmine.|
C A Fiery Reunion|QID|27745|QO|Fire Portal Controller: 1/1|M|36.4,83.77|N|Kill the fire elemental and retrieve the controller.|
C A Fiery Reunion|QID|27745|M|36.4,83.77|U|62394|N|Use the controller from within the circle.|
T A Fiery Reunion|QID|27745|M|37.58,88.69|N|To Initiate Goldmine.|

A Mathias Needs You|QID|27782|M|37.58,88.69|N|From Initiate Goldmine.|
T Mathias Needs You|QID|27782|M|36.42,66.05|N|To Master Mathias Shaw.|

A The Hammer of Twilight|QID|27784|M|36.42,66.05|N|From Master Mathias Shaw.|
T The Hammer of Twilight|QID|27784|M|45.40,87.93|N|To The Hammer of Twilight.|

A Skullcrusher the Mountain|QID|27787|M|45.40,87.93|N|From The Hammer of Twilight.|
C Skullcrusher the Mountain|QID|27787|M|45.31,88.25|N|Watch the scene, then head back to the spot and kill Skullcrusher. Activate the Altars when they appear to gain bonuses (Air gives +50% Crit, Earth +10 HP, Fire +50% dmg). If one of the NPCs go down, right-click on them to revive them. Once Skullcrusher gets to a certain health, all 3 NPCs go down, right click on the hammer that is on the ground next to Kurdran.|
T Skullcrusher the Mountain|QID|27787|M|43.36,57.51|N|To Kurdran Wildhammer.|

]]
end)
