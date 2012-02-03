
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_zul039drak_neutral
-- Date: 2011-12-10 03:50
-- Who: Crackerhead22
-- Log: Minor tweaking, plus 4.3 updates.

-- URL: http://wow-pro.com/node/3295/revisions/24758/view
-- Date: 2011-10-10 23:49
-- Who: Gethe

-- URL: http://wow-pro.com/node/3295/revisions/24757/view
-- Date: 2011-10-10 17:34
-- Who: Crackerhead22
-- Log: Created neutral guide, credit to Gethe. 

-- URL: http://wow-pro.com/node/3295/revisions/24750/view
-- Date: 2011-09-21 08:37
-- Who: Crackerhead22
-- Log: Added sticky steps, added missing notes, added missing cords, changed a couple of notes.

-- URL: http://wow-pro.com/node/3295/revisions/24327/view
-- Date: 2011-04-29 16:06
-- Who: Ludovicus Maior
-- Log: Line 40 for step A has 3 M coords, Line 182 for step A has unknown tag [12740].

-- URL: http://wow-pro.com/node/3295/revisions/24203/view
-- Date: 2011-04-02 19:18
-- Who: Ludovicus Maior
-- Log: OK, this is a HUGE update. Added From/To notes to most quests.   Added [The Amphitheater of Anguish] series.  Eliminated LightSpeed advice dependencies and added some notes and QO tags.

-- URL: http://wow-pro.com/node/3295/revisions/24166/view
-- Date: 2011-03-12 18:33
-- Who: Ludovicus Maior
-- Log: Make guide IDs unique

-- URL: http://wow-pro.com/node/3295/revisions/23482/view
-- Date: 2010-12-03 22:28
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3295/revisions/23481/view
-- Date: 2010-12-03 22:28
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide("ScoZul7778", "Zul'Drak", "Scoot", "77", "78", "ScoSho7879|ScoSho7879", "Neutral", function()
return [[
N READ THIS! |QID|12902|N|If you followed Jame's Dragonblight guide you have the quest Into the Breach!, which will be the first quest in the Achievement, but you will have to make your own way to Light's Breach.|
N READ THIS 2! |QID|12902|N|Otherwise you can do the optional quest that starts at Westfall Brigade Encampment in Grizzly Hills, it will fly you there, but doesn't count toward the Achievement.|FACTION|Alliance|
N READ THIS 3! |QID|12902|N|To do the optional quest abandon Into the Breach! and get Reallocating Resources from Captain Gryan Stoutmantle.|FACTION|Alliance|
N Amphitheater of Anguish |QID|12948|N|While questing look for a group for the Amphitheater of Anguish. There are 6 quests here . You will need some of them for the Achievement, so anytime you can get in, do so. You must be 75 to do these quests.|
N Amphitheater of Anguish |QID|12948|N|There is an optional leadin quest from Dalaran's Underbelly for the Amphitheater of Anguish, get that now before going to Light's Breach.|
N Darkkari Offerings|QID|12859|N|As you kill things, loot everything. They have a chance to drop Drakkari Offerings (need 30 total) which are used in 3 quests, and give you a few types of buffs while in Zul'Drak.|
A The Champion's Call! |QID|12974|O|Z|Dalaran|M|53.2,48.8|N|In the underbelly in Dalaran, find Shifty Vickers. This breadcrumb quest is not availible if you do ANY of the Amphitheater line and it counts to Loremaster.|

f Light's Breach |QID|12883|N|Fly to Light's Breach.|Z|Zul'Drak|M|32.05,74.50|
T Into the Breach! |QID|12789|O|N|To Sargent Riannah, who is next to the Flightmaster.|M|32.05,74.50|
A Reallocating Resources |QID|12770|O|N|From Captain Gryan Stoutmantle.|Z|Grizzly Hills|M|59.51,26.15|FACTION|Alliance|
T Reallocating Resources |QID|12770|O|N|To Sergeant Riannah. Talk to the Flightmaster; he'll send you to Light's Breach.|FACTION|Alliance|
A This Just In: Fire Still Hot! |QID|12859|M|32.0,75.6|N|From Elder Shaman Moky.|
A Trolls Is Gone Crazy! |QID|12861|M|32.2,75.7|N|From Chief Rageclaw.|
A In Search Of Answers |QID|12902|M|32.2,75.7|N|From Crusader Lord Lantinga.|

A Wanted: Ragemane's Flipper |QID|12857|N|From Wanted!|M|32.26,75.67|
C This Just In: Fire Still Hot! |QID|12859|S|N|Use the fire extinguisher on the burning huts. Each fire will take multiple hits.|U|41131|M|34.9,81.0|
C Trolls Is Gone Crazy! |QID|12861|N|Kill and loot Drakuru Trolls to get "Lock Openers". Use the "Lock Openers" next to the chains to free the Captured Rageclaws.|U|41161|M|34.9,81.0|S|
T In Search Of Answers |QID|12902|N|To Orders From Drakuru, the glowing blue scroll on the pedestal at Rageclaw Den.|M|34.92,83.84|
A Orders From Drakuru |QID|12883|M|34.9,83.9|N|From Orders From Drakuru.|
C Trolls Is Gone Crazy! |QID|12861|N|Finish freeing the Captured Rageclaws.|U|41161|M|34.9,81.0|US|
C This Just In: Fire Still Hot! |QID|12859|US|N|Use the fire extinguisher on the burning huts. Each fire will take multiple hits.|U|41131|M|34.9,81.0|
C Wanted: Ragemane's Flipper |QID|12857|N|Head out into the middle of the pond and kill Ragemane and loot his flipper.|M|38.2,85.6|
T Wanted: Ragemane's Flipper |QID|12857|N|To Chief Rageclaw.|M|32.2,75.7|

T This Just In: Fire Still Hot! |QID|12859|N|To Elder Shaman Moky at Light's Breach.|M|32.0,75.6|
T Trolls Is Gone Crazy! |QID|12861|M|32.2,75.7|N|To Chief Rageclaw.|
T Orders From Drakuru |QID|12883|M|32.2,75.7|N|To Crusader Lord Lantinga.|
A The Ebon Watch |QID|12884|M|32.2,75.7|N|From Crusader Lord Lantinga.|
A Crusader Forward Camp |QID|12894|M|32.2,75.7|N|From Crusader Lord Lantinga.|
T Crusader Forward Camp |QID|12894||M|25.34,63.97|N|To Crusader MacKellar, just across the road.|
A That's What Friends Are For... |QID|12903|M|25.3,64.0|N|From Crusader MacKellar.|
A Making Something Out Of Nothing |QID|12901|M|25.3,64.0|N|From Engineer Reed.|
C Making Something Out Of Nothing |QID|12901|N|The Scrap Metal is on the ground all over.|M|19.4,61.4|S|
A A Great Storm Approaches |QID|12912|N|From Gymer, who is in the big cage at Thrym's End.|M|20.03,56.59|

A Light Won't Grant Me Vengeance |QID|12904|N|From Gerk, who is in one of the glowing green vats a little west of Gymer.|M|17.63,57.52|
C Light Won't Grant Me Vengeance |QID|12904|N|Kill the Varguls.|M|19,56|S|
C Find Burr |N|He's across the courtyard to the west on one of the tables. |QID|12903|QO|Burr found: 1/1|M|15.56,59.44|
C That's What Friends Are For... |QID|12903|N|Head to Dargath's Demise and find Crusader Dargath in the ruins. He's got a glowing swirl around him. |M|24.73,51.54|
C Making Something Out Of Nothing |QID|12901|N|The Scrap Metal is on the ground all over.|M|19.4,56|US|
C Light Won't Grant Me Vengeance |QID|12904|N|Kill the Varguls.|M|19,56|US|
T Light Won't Grant Me Vengeance |QID|12904|N|To Gerk. Remember the glowing green vats?|M|17.6,57.6|
T That's What Friends Are For... |QID|12903|N|Back to Crusader MacKellar at Crusader Forward Camp.|M|25.34,63.97|
T Making Something Out Of Nothing |QID|12901|M|25.3,64.0|N|To Engineer Reed.|
T A Great Storm Approaches |QID|12912|M|25.3,64.0|N|To Engineer Reed.|

A Gymer's Salvation |QID|12914|M|25.3,64.0|N|From Engineer Reed.|
K Banshees |QID|12914|N|Kill the banshees in The Dead Fields for their essence. They are floating so you will probably have to pull them to you.|L|41504 6|
C Gymer's Salvation |QID|12914|N|Now head to the area around Ebon Watch and kill the Icetouched Earthragers. |M|14.26,73.60|
T The Ebon Watch |QID|12884|M|14.12,73.79|N|To Stefan Vadu.|
A Kickin' Nass and Takin' Manes |QID|12630|M|14.1,73.8|N|From Stefan Vadu.|
C Kickin' Nass and Takin' Manes |QID|12630|N|Kill the trolls, put the boot to Nass!|U|38659|M|15.5,69.8|
T Kickin' Nass and Takin' Manes |QID|12630|N|Back to Ebon Watch.|M|14.12,73.79|
A An Invitation, of Sorts... |QID|12631|O|N|From the Unliving Choker. You get this quest chain if you didn't complete the Drakuru quest chain in Grizzly Hills.|U|38660|M|15.5,69.8|
T An Invitation, of Sorts... |QID|12631|O|M|14.1,73.8|N|To Stefan Vadu.|
A Near Miss |QID|12637|O|PRE|12631|M|14.1,73.8|N|From Stefan Vadu.|
C Near Miss |QID|12637|O|N|Bloodrose Datura will give you a demo. |M|14.29,74.03|
A Darkness Calling |QID|12633|O|N|From the Writhing Choker. You get this quest chain if you completed the Drakuru quest chain in Grizzly Hills.|U|38673|
T Darkness Calling |QID|12633|O|N|To Stefan Vadu.|
A Close Call |QID|12638|O|PRE|12633|N|From Stefan Vadu.|
C Close Call |QID|12638|O|N|Bloodrose Datura will give you a demo.|M|14.29,74.03|

A Taking a Stand |QID|12795|M|14.3,74.0|N|From Bloodrose Datura.|
T Near Miss |QID|12637|O|M|14.1,73.8|N|To Stefan Vadu.|
A You Can Run, But You Can't Hide |QID|12629|O|PRE|12631|M|14.1,73.8|N|From Stefan Vadu.|
C You Can Run, But You Can't Hide |QID|12629|O|N|Around the Reliquary of Agony. Pick up the Drool from the ground. Kill and loot the Abominations.|M|21.24,75.01|
T You Can Run, But You Can't Hide |QID|12629|O|N|Back to Stefan Vadu at Ebon Watch.|M|14.26,73.60|
A Dressing Down |QID|12648|O|PRE|12631|M|14.1,73.8|N|From Stefan Vadu.|
C Dressing Down |QID|12648|O|N|Return to the Reliquary of Agony and use the choker. Buy the plasma from Gristlegut.|U|38699|M|19.82,75.32|
T Close Call |QID|12638|O|M|14.1,73.8|N|To Stefan Vadu.|
A Silver Lining |QID|12643|O|PRE|12633|N|From Stefan Vadu.|
C Silver Lining |QID|12643|O|N|Around the Reliquary of Agony . Pick up the Drool from the ground. Kill the Abominations.|M|21.24,75.01|
T Silver Lining |QID|12643|O|N|Back to Ebon Watch. |M|14.12,73.79|

A Suit Up! |QID|12649|O|PRE|12633|N|From Stefan Vadu.|
C Suit Up! |QID|12649|O|N|Return to the Reliquary of Agony and use the choker. You cannot use while shapeshifted. Buy the plasma from Gristlegut.|U|38699|M|19.91,75.44|
A Feedin' Da Goolz |QID|12652|M|19.9,75.5|N|From Gristlegut.|
C Feedin' Da Goolz |QID|12652|N|Use the bowl near the ghouls. Be careful of the Blightguards, they see through your disguise. You should hotkey the chocker because your diguise will fail at some point.|U|38701|
T Feedin' Da Goolz |QID|12652|N|Back to Gristlegut.|M|19.9,75.5|
T Dressing Down |QID|12648|O|N|Back to Ebon Watch.|M|14.12,73.79|
T Suit Up! |QID|12649|O|N|Back to Ebon Watch.|M|14.12,73.79|
A Infiltrating Voltarus |QID|12661|M|14.1,73.8|N|From Stefan Vadu.|
T Gymer's Salvation |QID|12914|N|Back to Crusader Forward Camp.|M|25.34,63.97|
A Our Only Hope |QID|12916|M|25.3,64.0|N|From Engineer Reed.|
C Our Only Hope |QID|12916|N|Use the Jumbo Seaforium Charge on the cage. |M|19.65,56.47|
T Our Only Hope |QID|12916|M|19.7,56.4|N|To Gymer.|

A The Storm King's Vengeance |QID|12919|N|From Gymer.|
N The Storm King's Vengeance |QID|12919|N|Do not bother to look for the scourge: they will find you.|
N The Storm King's Vengeance |QID|12919|N|Talk to Gymer to mount him and go!|
K Algar the Chosen |QID|12919|QO|Algar the Chosen slain: 1/1|M|29.2,46|N|He flies in circles underneath Volatrus, above the circular platform on the ground.|
K Prince Navarius  |QID|12919|QO|Prince Navarius slain: 1/1|M|29.8,65.4;32.4,63.6|N|At one of these two spots.|
K Thrym |QID|12919|QO|Thrym slain: 1/1|N|He will spawn after killing the Prince. Snack on clouds and wait.|
C The Storm King's Vengeance |QID|12919|N|Finish killing scourge.|
T The Storm King's Vengeance |QID|12919|N|Back to Crusader Forward Camp.|M|25.43,63.97|

N Overlord Drakuru 1|QID|12661|N|Hotkey the disguise so you can reequip it when it fails. Close this step.|M|23.81,45.01|
N Overlord Drakuru 2|QID|12661|N|Go to Reliquary of Pain, where you killed Algar the Chosen. Equip your disguise and port up to Voltarus from the center of the platform. Close this step.|U|38699|M|23.81,45.01|
N Overlord Drakuru 3|QID|12661|N|Overlord Drakuru is up the ramp on the outer ring of the platform. Talk to him to get one of two quests depending on whether or not you did Grizzly Hills. Close this step.|M|27.12,46.10|
A Dark Horizon |QID|12664|O|N|You got this because you didn't finish the Drakuru quest chain in Grizzly Hills.|M|27.1,46.2|
C Dark Horizon |QID|12664|O|N|Circle around the platform until you find a ramp on the outer ring. Gorebag is up there. Enjoy the ride.|M|29.76,47.90|
T Dark Horizon |QID|12664|O|M|27.1,46.2|N|To Overlord Drakuru.|
A Reunited |QID|12663|O|N|You got this because you finished the Drakuru quest chain in Grizzly Hills.|M|27.1,46.2|
C Reunited |QID|12663|O|N|Circle around the platform until you find a ramp on the outer ring. Gorebag is up there. Enjoy the ride.|M|29.76,47.90|
T Reunited |QID|12663|O|N|To Overlord Drakuru.|M|27.1,46.2|
T Infiltrating Voltarus |QID|12661|N|Port back down, blow the horn.|U|41390|

A So Far, So Bad |QID|12669|N|From Stefan Vadu.|
A It Rolls Downhill |QID|12673|N|From Overlord Drakuru.|M|27.12,46.10|
C It Rolls Downhill |QID|12673|N|Port back down, target a geist, use the scepter to charm it and send it for a crystal (the button is on the pet bar, get close they're not too bright). You MUST wait until the geist ports up to get credit, so don't get in a rush to charm another one.|U|39157|M|27.2,45.1|
T It Rolls Downhill |QID|12673|N|Back to Overlord Drakuru.|M|27.12,46.10|
C So Far, So Bad |QID|12669|N|Port back down, use the Diluting Additive near the cauldrons. Blightguards will spawn mobs, run away to try to avoid aggro. The Cauldrons are at the waypoints.|U|39154|M|31.29,43.2;31.16,44.31;31.04,45.16;29.6,47.43;26.80,46.92|
T So Far, So Bad |QID|12669|N|Blow the horn...again.|U|41390|
A Hazardous Materials |QID|12677|N|From Stefan Vadu.|

A Zero Tolerance |QID|12686|N|From Overlord Drakuru. |M|27.12,46.10|
C Zero Tolerance |QID|12686|N|Use the scepter on a Servent of Drakuru, then head to the big platform. Target Darmuk and let the troll do all the work. DO NOT FIGHT!! You will lose your disguise and your pet. Open with Ferocious Enrage, use Gut Rip and Stunning Force when they are up, repeat as necessary.|U|39206|M|30.51,51.57|
T Zero Tolerance |QID|12686|N|Back to Overlord Drakuru. |M|27.12,46.10|
C Hazardous Materials |QID|12677|N|The crates are all over the platform. Looting the crates can drop your disguise, be alert. You must be disguised to gather the crates.|M|27.1,43.9|
T Hazardous Materials |QID|12677|N|Port back down, blow the horn. Are you tired of this yet?|U|41390|
A Sabotage |QID|12676|N|From Stefan Vadu.|
A Fuel for the Fire |QID|12690|N|From Overlord Drakuru.|M|27.12,46.10|
C Fuel for the Fire |QID|12690|N|Go to the Frigid Breach. Time for some fun! Use the scepter to charm an abomination. Send him out to gather up trolls. Just before he dies, blow him up! Repeat until you've killed 60. Don't worry about the chieftans, they get carried off before they attack.|U|39238|M|32.74,38.72|
N Destroy Scourgewagons |N|They are all over the Reliquary of Pain. Use the explosive and run.|QID|12676|QO|Scourgewagons destroyed: 5/5|U|39165|
T Fuel for the Fire |QID|12690|N|Back to Overlord Drakuru.|M|27.12,46.10|

A Disclosure |QID|12710|M|27.1,46.2|N|From Overlord Drakuru.|
C Disclosure |QID|12710|N|Take the upper portal (on top of the one you've been using). Click on the coffin to take the tour.|M|27.2,42.3|
T Disclosure |QID|12710|N|Back to Overlord Drakuru.|M|27.12,46.10|
C Sabotage |QID|12676|M|30.6,45.3|
T Sabotage |QID|12676|N|You know what to do. Pucker up and blow.|U|41390|
A Betrayal |QID|12713|N|From Stefan Vadu.|
C Betrayal |QID|12713|N|Back to Overlord Drakuru. Talk to him to start. Don't worry when your disguise when it fails,you don't need it anymore. Use the scepter to charm one of the Captive Trolls and send him after Drakuru. Keep him attacking while you avoid the Blight Crystals and the fog they create. If you're solo, you'll probably need to charm another Troll, but wait until the first one dies. The Trolls can be healed.|U|39664|M|27.12,46.10|
U PORT DOWN NOW!! |QID|12713|N|You only have 3 minutes, so quit reading this, Heal yourself, and click on [Drakuru's Last Wish] to port down. (Right next to the skull.)|
T Betrayal |QID|12713|N|Blow the horn one last time.|U|41390|
N End of the Ebon Watch quests.|QID|12795|

T Taking a Stand |QID|12795|N|Head to the Argent Stand. Turn this quest into Commander Falstaav.|M|39.44,66.90|
A Defend the Stand |QID|12503|M|39.4,67.0|N|From Commander Falstaav.|
A Parachutes for the Argent Crusade |QID|12740|M|39.4,67.0|N|From Commander Falstaav.|
C Defend the Stand |QID|12503|N|Kill Scourge.|M|38.4,67.1|S|
C Parachutes for the Argent Crusade |QID|12740|N|Throw parachutes to the Argent fighters out in the battlefield. Has a heck of a range on it.|U|39615|M|38.4,67.1|
C Defend the Stand |QID|12503|N|Kill anymore you need.|M|38.4,67.1|US|
T Defend the Stand |QID|12503|N|Back to the Argent Stand, to Commander Falstaav.|M|39.44,66.90|
T Parachutes for the Argent Crusade |QID|12740|M|39.4,67.0|N|To Commander Falstaav.|
A Pa'Troll |QID|12596|M|40.3,66.6|N|From Commander Kunz.|

A New Orders for Sergeant Stackhammer |QID|12505|M|40.3,66.6|N|From Commander Kunz.|
A Trouble at the Altar of Sseratus |QID|12506|M|40.5,65.6|N|From Hexxer Ubungo.|
A The Blessing of Zim'Abwa |QID|12565|M|40.5,65.6|N|From Hexxer Ubungo.|
T The Blessing of Zim'Abwa |QID|12565|N|Big statue to the SW.|M|36.71,72.78|
T New Orders for Sergeant Stackhammer |QID|12505|N|Straight North from the Argent Stand. Just follow the road.|M|40.41,48.27|
A Argent Crusade, We Are Leaving! |QID|12504|M|40.4,48.2|N|From Sergeant Stackhammer.|

A Mopping Up |QID|12508|M|40.4,48.2|N|From Corporal Maga.|
C Argent Crusade, We Are Leaving! |QID|12504|M|40.4,47.0|S|N|Talk to Argent Soldiers and tell them to pack it. They can be killed by the trolls.|
C Mopping Up |QID|12508|M|40.4,47.0|S|N|Kill 10 Followers of Sseratus.|
C Trouble at the Altar of Sseratus |QID|12506|N|Avoid the Prophet in front and go into the temple. Kill Trolls and give Argents their orders on the way.|M|40.0,39.0|
C Argent Crusade, We Are Leaving! |QID|12504|M|40.4,47.0|US|N|Finish telling Argent Soldiers to pull back.|
C Mopping Up |QID|12508|M|40.4,47.0|US|N|Finish killing trolls.|

A Strange Mojo |QID|12507|N|It's a drop. Keep killing trolls until you get it.|U|38321|M|40.4,47.0|
T Argent Crusade, We Are Leaving! |QID|12504|N|Back to Sergeant Stackhammer.|M|40.41,48.27|
T Mopping Up |QID|12508|M|40.4,48.2|N|From Corporal Maga.|
A Lab Work |QID|12557|N|Inside the building at Heb'Valok.|M|35.08,52.09|
C Lab Work |QID|12557|N|Find the items on or around the shelves in the 2 rooms.|
T Lab Work |QID|12557|M|35.0,52.1|N|To Alchemist Finklestein.|
A Siphoning the Spirits |QID|12799|N|From Captain Arnath. He's at the front door.|M|35.6,52.2|
C Siphoning the Spirits |QID|12799|N|Head to the Pools of Zha'Jin, directly south. Kill the neutral mobs (they glow blue), don't bother with the aggressive ones.|M|36.74,61.90|
T Siphoning the Spirits |QID|12799|N|To Captain Arnath, back to Heb'Valok.|M|35.6,52.2|

A Stocking the Shelves |QID|12609|M|35.6,52.2|N|From Captain Arnath.|
A Clipping Their Wings |QID|12610|M|35.6,52.2|N|From Captain Arnath.|
C Stocking the Shelves |QID|12609|N|Kill and loot the spiders.|M|36.1,51.1|S|
C Clipping Their Wings |QID|12610|N|Kill and loot the bats.|M|36.1,51.1|
C Stocking the Shelves |QID|12609|N|Kill and loot the spiders.|M|36.1,51.1|US|
T Stocking the Shelves |QID|12609|M|35.6,52.2|N|To Captain Arnath.
T Clipping Their Wings |QID|12610|M|35.6,52.2|N|To Captain Arnath.|
T Trouble at the Altar of Sseratus |QID|12506|N|Back to the Argent Stand.|M|40.52,65.58|
T Strange Mojo |QID|12507|M|40.5,65.6|N|To Hexxer Ubungo.|
A Precious Elemental Fluids |QID|12510|M|40.5,65.6|N|From Hexxer Ubungo.|
A The Drakkari Do Not Need Water Elementals! |QID|12562|N|From Sub-Lieutenant Jax at the Southern part of the Argent Stand next to the Leatherworking supplier.|M|40.18,68.91|

A Something for the Pain |QID|12597|N|Take the road southeast.|M|48.76,78.85|
C Something for the Pain |QID|12597|N|Gather 5 Mature Water-Poppies.|M|44.9,79.5|S|
C The Drakkari Do Not Need Water Elementals! |QID|12562|N|Kill 10 Drakkari Water Binders.|S|
K Crazed Water Elementals |QID|12510|N|Head West to the Drak'Sotra Fields. Kill the Elementals, you need 3 links to make a tether (You'll need 9 links total). Kill Trolls and gather plants also.|L|38323 3|M|44.74,78.99|
N Make a tether now!! |QID|12510|N|Make a tether. You can't loot more than 3 at a time.|U|38323|L|38324|
K Watery Lord |QID|12510|N|Use the tether to summon.|U|38324|L|38325 1|
K Kill more Elementals |QID|12510|N|Keep killing the Elementals.|L|38323 3|
N Make another tether now!! |QID|12510|U|38323|L|38324|
K Summon again |QID|12510|U|38324|L|38325 2|
K Go for the last 3 Links |QID|12510|L|38323 3|
U Make the last tether.|QID|12510|U|38323|L|38324|
C Precious Elemental Fluids |QID|12510|N|Last time...finally.|U|38324|M|40.2,73.6|
C The Drakkari Do Not Need Water Elementals! |QID|12562|N|Kill any trolls you still need.|US|
C Something for the Pain |QID|12597|N|Gather any plants you still need.|M|44.9,79.5|US|
T Something for the Pain |QID|12597|N|Back to Drak'Sotra. |M|48.76,78.85|

A Throwing Down |QID|12598|N|Following the aquaduct to the South will take you to the crusader camp. |M|58.04,72.48|
A Leave No One Behind |QID|12512|N|He's in the back, right corner.|M|58.7,72.5|
C Throwing Down |QID|12598|N|Throw the High Impact Grenades in the craters (they actually look like pyramids), then run. Crispy Spider Treats, not just for Hallows End anymore.|U|38574|M|53.4,68.7|
N Crusader Jonathan |N|In the tower at the waypoint. Bandage him and lead him back to the camp. You've got 3 minutes, but remember he's injured, avoid all combat and don't lose him on the run back.|QID|12512|QO|Saved Crusader Jonathan: 1/1|U|38330|M|50.7,69.9|
N Crusader Josephine |N|In the tower at waypoint. Same plan as before.|QID|12512|QO|Saved Crusader Josephine: 1/1|U|38330|M|49.4,74.7|
C Leave No One Behind |QID|12512|N|Crusader Lamoof is in the tower at waypoint. Lead him home, or at least to the doctor.|U|38330|M|53.6,75.0|
T Leave No One Behind |QID|12512|M|58.7,72.5|N|To Dr. Rogers.|
T Throwing Down |QID|12598|M|58.1,72.4|N|To Captain Rupert.|

A Cocooned! |QID|12606|M|58.1,72.4|N|From Captain Rupert.|
A Death to the Necromagi |QID|12552|M|58.1,72.0|N|From Sergeant Moonshard.|
A Skimmer Spinnerets |QID|12553|M|58.3,72.0|N|From Specialist Cogwheel.|
C Cocooned! |QID|12606|N|Back where you blew up the craters, attack the coccons until you free 3 Footmen. Not always a Footman.|M|54.88,70.00|
C Death to the Necromagi |QID|12552|N|Kill 8 Hath'ar Necromagi (the large spiders).|S|
C Skimmer Spinnerets |QID|12553|N|Kill and loot Hath'ar Skimmers until you get 5 Intact Skimmers Spinnerets.|M|57.48,79.90|
C Death to the Necromagi |QID|12552|N|Need any more big spiders? Get them now. Usually 3-4 inside the fallen Necropolis.|US|

T Cocooned! |QID|12606|N|Back to the camp. To Captain Rupert.|M|58.04,72.48|
T Death to the Necromagi |QID|12552|M|58.1,72.0|N|To Sergeant Moonshard.|
A Malas the Corrupter |QID|12554|N|From Sergeant Moonshard.|M|58.1,72.0|
A Pure Evil |QID|12584|M|58.1,72.4|N|From Captain Rupert.|
T Skimmer Spinnerets |QID|12553|M|58.3,72.0|N|To Specialist Cogwheel.|
A Crashed Sprayer |QID|12583|M|58.3,72.0|N|From Specialist Cogwheel.|
C Crashed Sprayer |QID|12583|N|Over near Crusader Josephine's tower .|M|48.80,75.56|
T Crashed Sprayer |QID|12583|N|Back to the camp |M|58.28,72.05|N|To Specialist Cogwheel.|

A A Tangled Skein |QID|12555|M|58.3,72.0|N|From Specialist Cogwheel.|
C A Tangled Skein |QID|12555|N|Oh! What a tangled skein we weave. Use the it on the plague sprayers.|U|38515|M|58.3,74.3|
C Pure Evil |QID|12584|N|Inside Kolramas. Little, glowing chunks of ore that are hard to see. Look in all the nooks and crannies.|M|60.15,79.31|
C Malas the Corrupter |QID|12554|N|Malas is at the top of the Kolramas necropolis.|M|60.80,80.32|
T A Tangled Skein |QID|12555|N|Back to the camp. To Specialist Cogwheel.|M|58.04,72.48|
T Malas the Corrupter |QID|12554|N|To Sergeant Moonshard.|M|58.1,72.0|
T The Drakkari Do Not Need Water Elementals! |QID|12562|N|To Sub-Lieutenant Jax back at the Argent Stand.|M|40.18,68.91|
T Pure Evil |QID|12584|M|40.8,66.6|N|To Eitrigg.|
T Precious Elemental Fluids |QID|12510|M|40.5,65.6|N|To Hexxer Ubungo.|
A Mushroom Mixer |QID|12514|M|40.5,65.6|N|From Hexxer Ubungo.|
A Gluttonous Lurkers |QID|12527|N|From Apprentive Pestlepot.|M|41.3,65.1|

A Creature Comforts |QID|12599|N|Go West to Drak'Agal. From Captain Grondel, he's in a building south of the Amphitheater of Anguish.|M|48.13,63.83|
C Mushroom Mixer |QID|12514|N|All over the area, you need 10. Herbalists can use their tracking to make it easier.|M|41.4,57.4|S|
C Creature Comforts |QID|12599|N|They are all over too, but can be hard to see. They look like a big thorn sticking up. Mouse over the area to find them.|M|46.9,61.4|S|
C Gluttonous Lurkers |QID|12527|N|Loot 5 rats, they can be hard to see. After you get 5, feed all of them to one basilisk. You throw one at a time. If you can Root them this is alot easier. Repeat until you get 5 crystals.|U|38380|M|41.4,57.4|
C Mushroom Mixer |QID|12514|N|All over the area, you need 10. Herbalists can use their tracking to make it easier.|M|41.4,57.4|US|
C Creature Comforts |QID|12599|N|They are all over too, but can be hard to see. They look like a big thorn sticking up. Mouse over the area to find them.|M|46.9,61.4|US|
T Creature Comforts |QID|12599|N|To Captain Grondel.|M|48.13,63.83|
T Mushroom Mixer |QID|12514|N|To Hexxer Ubungo.|M|40.61,65.59|

A Too Much of a Good Thing |QID|12516|M|40.5,65.6|N|From Hexxer Ubungo.|
T Pa'Troll |QID|12596|M|40.3,66.6|N|To Commander Kunz.|
C Too Much of a Good Thing |QID|12516|N|Head back North to the Altar of Sseratus. The big guy you avoided earlier. Weaken him with the Mojo and give him a whuppin'.|U|38332|M|40.52,42.77|
T Gluttonous Lurkers |QID|12527|N|Inside the building at Heb'Valok, again. To Alchemist Finklestein.|M|35.08,52.09|
T Too Much of a Good Thing |QID|12516|N|From Hexxer Ubungo.|M|40.61,65.59|

A To the Witch Doctor |QID|12623|M|40.5,65.6|N|From Hexxer Ubungo.|
N End of the Argent Stand Quests. |QID|12623|
T To the Witch Doctor |QID|12623|N|Go up the stairs next to the Amphitheater of Anguish. Zim'Torga is just ahead on your right. To Witch Doctor Khufu.|M|59.52,57.98|
A Breaking Through Jin'Alai |QID|12627|M|59.5,58.1|N|From Witch Doctor Khufu.|
A The Blessing of Zim'Torga |QID|12615|M|59.5,58.1|N|From Witch Doctor Khufu.|
T The Blessing of Zim'Torga |QID|12615|N|Big statue in the middle.|M|59.4,57.2|

A The Leaders at Jin'Alai |QID|12622|M|59.2,56.2|N|From Scalper Ahunae.|
C The Leaders at Jin'Alai |QID|12622|N|Kill Trolls, you must kill trolls to get the bosses to spawn (Also check to see if one is up). Pay attention to you chat log, when the "bosses" yell, find him by his Totem. The items can be looted by everyone, so don't worry if someone else tags the mob first. Just don't forget to loot, they spawn in order, so it could be awhile if you miss one.|S|
C Breaking Through Jin'Alai |QID|12627|N|Just South, Click on the Purple cauldron.|M|57.62,61.72|QO|Purple Cauldron disturbed: 1/1|
C Breaking Through Jin'Alai |QID|12627|N|Click on the Red cauldron.|M|58.78,62.71|QO|Red Cauldron disturbed: 1/1|
C Breaking Through Jin'Alai |QID|12627|N|Click on the Blue cauldron.|M|57.20,65.34|QO|Blue Cauldron disturbed: 1/1|
C Breaking Through Jin'Alai |QID|12627|N|Click on the Green cauldron.|M|55.70,64.31|

C The Leaders at Jin'Alai |QID|12622|N|Kill Trolls, you must kill trolls to get the bosses to spawn (Also check to see if one is up). Pay attention to you chat log, when the "bosses" yell, find him by his Totem. The items can be looted by everyone, so don't worry if someone else tags the mob first. Just don't forget to loot, they spawn in order, so it could be awhile if you miss one.|US|
T Breaking Through Jin'Alai |QID|12627|N|To Witch Doctor Khufu.|M|59.51,57.99|
A To Speak With Har'koa |QID|12628|M|59.5,58.1|N|From Witch Doctor Khufu.|
A Relics of the Snow Leopard Goddess |QID|12635|M|60.0,57.9|N|From Chronicler To'kini.|
; The quest "Just Checkin" on the following line is missing the ' after "Checkin" (it should read " Just Checkin' ")so it does not auto-accept, since it is optional.|
A Just Checkin |QID|29836|M|60.0,57.9|N|From Chronicler To'kini. This quest takes you into Gundrak, you can do this if you wish. There is another quest that leads you into Gundrak later in the guide.|
T The Leaders at Jin'Alai |QID|12622|M|59.2,56.2|N|To Scalper Ahunae.|
T To Speak With Har'koa |QID|12628|N|Head to the Altar of Har'koa to the SE. To Har'koa.|M|63.73,70.44|
A But First My Offspring |QID|12632|M|63.8,70.5|N|From Har'koa.|
C Relics of the Snow Leopard Goddess |QID|12635|N|Pick up 10 Har'koan Relics.|M|62.9,70.6|S|
C But First My Offspring |QID|12632|N|Kill Har'koa's Offspring and use the whisker to release their spirits. Collect Relics when you see them. They blend in to the stonework.|U|38676|M|62.9,70.6|
C Relics of the Snow Leopard Goddess |QID|12635|N|Get the rest of the Relics.|M|62.9,70.6|US|
T But First My Offspring |QID|12632|M|63.8,70.5|N|To Har'koa.|

A Spirit of Rhunok |QID|12642|M|63.8,70.5|N|From Har'koa.|
T Relics of the Snow Leopard Goddess |QID|12635|N|To Chronicler To'kini.|M|59.51,57.99|
A Plundering Their Own |QID|12650|M|60.0,57.9|N|From Chronicler To'kini.|
A Tails Up |QID|13549|M|60.0,57.9|N|From Chronicler To'kini.|
A Sealing the Rifts |QID|12640|M|59.2,56.2|N|From Scalper Ahunae.|
A The Frozen Earth |QID|12639|M|59.4,56.4|N|From Element-Tamer Dagoda.|
A The Blessing of Zim'Rhuk |QID|12655|M|59.5,58.1|N|From Witch Doctor Khufu.|
C Plundering Their Own |QID|12650|N|Kill Trolls for the Artifacts.|M|54.0,49.1|S|
C Sealing the Rifts |QID|12640|N|Close the Rifts when you can.|M|56.4,52.8|S|
C The Frozen Earth |QID|12639|N|Kill and loot Frozen Earth.|M|56.4,52.8|S|
T The Blessing of Zim'Rhuk |QID|12655|N|Zim'Rhuk is the big statue at the waypoint.|M|59.46,44.46|
T Spirit of Rhunok |QID|12642|N|Altar of Rhunok to the NW.|M|53.37,39.09|

A My Prophet, My Enemy |QID|12646|M|53.4,39.2|N|From Spirit of Rhunok.|
C My Prophet, My Enemy |QID|12646|N|Go swimming in the lake and kill the Prohpet of Rhunok. |M|54.13,47.28|
T My Prophet, My Enemy |QID|12646|N|Back to Rhunok.|M|53.37,39.09|
A An End to the Suffering |QID|12647|M|53.4,39.2|N|From Spirit of Rhunok.|
C An End to the Suffering |QID|12647|N|Get the incense from the Rhunok's Tormenter, use it and kill the bear.|U|38696|M|53.4,35.9|
T An End to the Suffering |QID|12647|N|Back to Rhunok.|M|53.37,39.09|
A Back to Har'koa |QID|12653|M|53.4,39.2|N|From Spirit of Rhunok.|
C Plundering Their Own |QID|12650|N|Kill Trolls for the Artifacts.|M|54.0,49.1|US|
C Sealing the Rifts |QID|12640|N|Around the lake. Finish closing the Rifts.|M|56.4,52.8|US|
C The Frozen Earth |QID|12639|N|Still need Elemental Essence? Get them now.|M|56.4,52.8|US|
T Plundering Their Own |QID|12650|N|To Chronicler To'kini.|M|59.51,57.99|
T The Frozen Earth |QID|12639|M|59.4,56.4|N|To Element-Tamer Dagoda.|
T Sealing the Rifts |QID|12640|M|59.2,56.2|N|To Scalper Ahunae.|

A Scalps! |QID|12659|M|59.2,56.2|N|From Scalper Ahunae.|
A Bringing Down Heb'Jin |QID|12662|M|59.4,56.4|N|From Element-Tamer Dagoda.|
T Back to Har'koa |QID|12653|N|Quest name says it all.|M|63.73,70.44|
A I Sense a Disturbance |QID|12665|M|63.8,70.5|N|From Har'koa.|
C I Sense a Disturbance |QID|12665|N|Talk to Har'koa, then enjoy the ride.|M|63.8,70.5|
T I Sense a Disturbance |QID|12665|M|63.8,70.5|N|To Har'koa.|
A Preparations for the Underworld |QID|12666|M|63.8,70.5|N|From Har'koa.|
C Preparations for the Underworld |QID|12666|N|Kill Trolls and steal their jewlery.|M|64.1,69.9|
T Preparations for the Underworld |QID|12666|M|63.8,70.5|N|To Har'koa.|

A Seek the Wind Serpent Goddess |QID|12667|M|63.8,70.5|N|From Har'koa.|
C Tails Up |QID|13549|N|Shoot the bears and leopards with the blowgun, can not be in combat. Go up to them can check them. Males will attack, you will automatically keep the females.|U|44890|M|74.56,68.45|
T Seek the Wind Serpent Goddess |QID|12667|N|To Quetz'lun's Spirit at the Altar of Quetz'lun. The place you rode the cat to.|M|75.38,58.65|
A Setting the Stage |QID|12672|M|75.4,58.6|N|From Quetz'lun's Spirit.|
C Setting the Stage |QID|12672|N|Loot the crystals. They are floating all over the place.|M|74.6,59.8|
T Setting the Stage |QID|12672|M|75.4,58.6|N|To Quetz'lun's Spirit.|
A Foundation for Revenge |QID|12668|M|75.4,58.6|N|From Quetz'lun's Spirit.|
C Foundation for Revenge |QID|12668|N|The Soul Fonts look like big dragon heads. There are a lot of them around. Kill trolls near them. You have to be pretty close, they need to have the 'Soul Font Void' debuff on them or it doesn't count.|
T Foundation for Revenge |QID|12668|M|75.4,58.6|N|To Quetz'lun's Spirit.|

A Hell Hath a Fury |QID|12674|M|75.4,58.6|N|From Quetz'lun's Spirit.|
C Hell Hath a Fury |QID|12674|QO|High Priest Mu'funu hexed at death: 1/1|U|39158|N|Use the hex stick on the priests, then give them a beat down. Mu'funu is down the stairs to the right|M|74.55,57.37|
C Hell Hath a Fury |QID|12674|QO|High Priestess Tua-Tua hexed at death: 1/1|U|39158|N|Tua-Tua is to the South.|M|73.94,60.16|
C Hell Hath a Fury |QID|12674|U|39158|N|Hawinni patrols the North side of the same tier. He's a big, hulking SOB.|M|75,54;78,54|
T Hell Hath a Fury |QID|12674|M|75.4,58.6|N|To Quetz'lun's Spirit.|
A One Last Thing |QID|12675|M|75.4,58.6|N|From Quetz'lun's Spirit.|
T One Last Thing |QID|12675|N|Back to Har'koa|M|63.73,70.44|N|To Har'koa.|

A Blood of a Dead God |QID|12684|M|63.8,70.5|N|From Har'koa.|
C Scalps! |QID|12659|N|Heb'Drakkar is just NE of Zim'Torga. Kill the trolls, loot them, then use the scalping knife.|U|38731|M|64.02,53.38|S|
C Bringing Down Heb'Jin |QID|12662|N|Beat on the drum. Use the net on the bat, when they land. Kill Heb'Jin.|U|39041|M|64.28,52.48|
C Scalps! |QID|12659|N|Kill the trolls, loot them, then use the scalping knife.|U|38731|M|64.02,53.38|US|
C Blood of a Dead God |QID|12684|N|Mam'toth Crater to the NE. Kill and loot the ooze things.|M|72.21,50.11|
T Blood of a Dead God |QID|12684|N|Back to Har'koa.|M|63.73,70.44|

A You Reap What You Sow |QID|12685|M|63.8,70.5|N|From Har'koa.|
C You Reap What You Sow |QID|12685|N|Complete the Ritual (you can't be stealthed or shapeshifted) and kill the Prophet. You have to wait on the dialogue.|U|39187|M|75.38,58.65|
T You Reap What You Sow |QID|12685|N|To Witch Doctor Khufu.|M|59.51,57.99|
T Bringing Down Heb'Jin |QID|12662|M|59.4,56.4|N|To Element-Tamer Dagoda.|

A Enchanted Tiki Warriors |QID|12708|M|59.4,56.4|N|From Element-Tamer Dagoda.|
T Scalps! |QID|12659|M|59.2,56.2|N|To Scalper Ahunae.|

A Wooly Justice |QID|12707|M|59.2,56.2|N|From Scalper Ahunae.|
A The Key of Warlord Zol'Maz |QID|12712|M|60.3,57.8|N|From Har'koa.|

T Tails Up |QID|13549|M|60.0,57.9|N|From Chronicler To'kini.|
A Hexed Caches |QID|12709|M|60.0,57.9|N|From Chronicler To'kini.|
C Hexed Caches |QID|12709|N|Loot the Hexed Caches you see. There is a good chance you will get cursed, the Tiki Warriors can drop items that cure the curses if you aren't a class that can do that.|U|39305|M|69.2,35.9|S|
C Enchanted Tiki Warriors |QID|12708|N|Kill 12 Enchanted Tiki Warriors.|M|69.2,35.9|S|
K Tiri |QID|12712|N|In the buliding, kill and loot Tiri for her Incantation.|M|63.75,37.11|L|39316|
K Drek'Maz |QID|12712|N|In the building, kill and loot Drek' Maz for Drek'Maz's Tiki.|M|68.23,35.29|L|39315|
K Yara |QID|12712|N|In the building, finally kill Yara to get Yara's Sword.|M|67.94,32.92|L|39313|
U Combine Items |QID|12712|N|Combine the items to make the Tiki Dervish Ceremony.|U|39315|L|39314|
C The Key of Warlord Zol'Maz |QID|12712|N|Warlord Zol'Maz is in the big building. Use the item to open the gate, and kill him. If he dies inside the room, make sure you are in there with him, the gate won't open from the outside (if you're inside and he's outside there is a lever). You'll have to kill the 3 Trolls and make the item again.|U|39314|M|66.15,33.06|
C Hexed Caches |QID|12709|N|Finish gathering caches.|U|39305|M|69.2,35.9|US|
C Enchanted Tiki Warriors |QID|12708|N|Finish killing Tiki Warriors.|M|69.2,35.9|US|
C Wooly Justice |QID|12707|N|Tame a mammoth, mount up, and trample Trolls! Troll pancakes......yummy.|U|39268|M|72.95,41.79|
T Wooly Justice |QID|12707|N|To Scalper Ahunae.|M|59.16,56.26|
T Enchanted Tiki Warriors |QID|12708|M|59.4,56.4|N|To Element-Tamer Dagoda.|
T The Key of Warlord Zol'Maz |QID|12712|M|60.3,57.8|N|To Har'koa.|

A Rampage |QID|12721|M|60.3,57.8|N|From Har'koa.|
T Hexed Caches |QID|12709|M|60.0,57.9|N|To Chronicler To'kini.|
C Rampage |QID|12721|N|Right in front of Gundrak, you can't miss him. He's the only giant Rhino god around. Run around and unlock all of the chains, then watch him work.|M|79.03,24.32|
A Eggs for Dubra'Jin |QID|13556|N|From Ha'wana.|
f Dubra'Jin |QID|13556|N|Get the Flightpath. |M|70.41,23.21|
C Eggs for Dubra'Jin |QID|13556|N|Collect the eggs on the ground in the small wooded areas. They are hard to see, so look everywhere. you can kill the Raptors if you want to, but the drop rate isn't very good.|M|73.64,21.41|
T Eggs for Dubra'Jin |QID|13556|N|Turn in to Ha'wana.|M|70.06,20.99|
F Zim'Torga|QID|12721|N|Fly to Zim'Torga,|M|70.46,23.29|
T Rampage |QID|12721|N|To Witch Doctor Khufu.|M|59.51,57.99|

A The Gods Have Spoken |QID|12729|N|From Witch Doctor Khufu.|
l Unblemished Heart of the Guardian |QID|12729|N|Get the buff from Zim'Torga. Kill the Guardians around Zim'Rhuk for the Heart.|L|39540|M|59.46,44.46|
C The Gods Have Spoken |QID|12729|N|The Wardens are around The Altar of Quetz'lun. Kill them for the Essence.|M|75.38,58.65|
T The Gods Have Spoken |QID|12729|N|Back to Har'koa. Remember she's at Zim'Torga now.|M|60.13,57.72|

A Convocation at Zol'Heb |QID|12730|N|From Har'koa.|
C Convocation at Zol'Heb |QID|12730|N|Use the item in the circle to summon the Prophet. After you get him to about 75% health, Har'koa will show up to help. The Prophet has an evil AoE, but Har'koa can remove it so stay close to her. If you die just run back and try to pick a good time to rez. He may kill Har'koa, so be prepared to finish him off, if necessary.|U|39566|M|77.55,36.67|
T Convocation at Zol'Heb |QID|12730|N|Back to Har'koa.|M|60.13,57.72|
; The quest "Unfinished business" on the following line has wrong caps on 'Business' so it does not auto-accept since it is optional.|
A Unfinished business |QID|29833|N|From Har'koa.|

N Amphitheater of Anguish |QID|12948|N|If you haven't gotten the achievement yet (and you know you want it), get a group up for the Amphitheater of Anguish. |

T The Champion's Call! |QID|12974|O|N|To Gurgthock.|M|48.43,56.35|O|
A The Amphitheater of Anguish: Yggdras!|QID|12932;12954|M|48.43,56.35|N|Welcome Champion of The Ring of Blood. From Gurgthock|
C The Amphitheater of Anguish: Yggdras!|QID|12932;12954|M|48.00,57.00|N|L75 Worm, 106K Health.|
T The Amphitheater of Anguish: Yggdras!|QID|12932;12954|M|48.48,56.42|N|To Wodin the Troll-Servant.|

A The Amphitheater of Anguish: Magnataur!|QID|12933|M|48.43,56.35|N|From Gurgthock.|
C The Amphitheater of Anguish: Magnataur!|QID|12933|M|48.00,57.00|N|L75 Stinky Magnataur, 138K Health.|
T The Amphitheater of Anguish: Magnataur!|QID|12933|M|48.48,56.42|N|To Wodin the Troll-Servant.|
A The Amphitheater of Anguish: From Beyond!|QID|12934|M|48.43,56.35|N|From Gurgthock.|
C The Amphitheater of Anguish: From Beyond!|QID|12934|M|48.00,57.00|N|Pick one: Az'Barin, Prince of the Gust (165K), Duke Singen (165K), Erathius, King of Dirt (143K), Gargoral the Water Lord (165K).|
T The Amphitheater of Anguish: From Beyond!|QID|12934|M|48.48,56.42|N|To Wodin the Troll-Servant.|
A The Amphitheater of Anguish: Tuskarrmageddon!|QID|12935|M|48.43,56.35|N|From Gurgthock.|
C The Amphitheater of Anguish: Tuskarrmageddon!|QID|12935|M|48.00,57.00|N|L76 Tuskarr with pet, 198K Health.|
T The Amphitheater of Anguish: Tuskarrmageddon!|QID|12935|M|48.48,56.42|N|To Wodin the Troll-Servant.|
A The Amphitheater of Anguish: Korrak the Bloodrager!|QID|12936|M|48.43,56.35|N|From Gurgthock.|
C The Amphitheater of Anguish: Korrak the Bloodrager!|QID|12936|M|48.00,57.00|N|L77 Troll, 228K Health.|
T The Amphitheater of Anguish: Korrak the Bloodrager!|QID|12936|M|48.48,56.42|N|To Wodin the Troll-Servant.|
A The Champion of Anguish|QID|12948|M|48.43,56.35|N|From Gurgthock.|M|48.43,56.35|N|From Gurgthock.|
C The Champion of Anguish|QID|12948|M|48.00,57.00|N|From Gurgthock.|N|L77 DK, 250K Health.|
T The Champion of Anguish|QID|12948|M|48.48,56.42|N|To Wodin the Troll-Servant.|

]]
end)
