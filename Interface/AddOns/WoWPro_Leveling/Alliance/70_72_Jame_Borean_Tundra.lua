
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_borean_tundra_alliance
-- Date: 2011-12-10 15:28
-- Who: Crackerhead22
-- Log: 4.3 updates

-- URL: http://wow-pro.com/node/3289/revisions/24665/view
-- Date: 2011-07-06 14:37
-- Who: Crackerhead22
-- Log: Added notes in the "The Hunt is On" steps about talking to the cultists.

-- URL: http://wow-pro.com/node/3289/revisions/24595/view
-- Date: 2011-06-25 01:24
-- Who: Crackerhead22
-- Log: Removed "This quest needs to be manually clicked off because there is no turnin." from the line of "A A Mission Statement |QID|11864|N|From Arch Druid Lathorius.|M|57.06,44.30|"

-- URL: http://wow-pro.com/node/3289/revisions/24364/view
-- Date: 2011-05-04 09:35
-- Who: Crackerhead22
-- Log: Added |P| tag for cooking quest line.

-- URL: http://wow-pro.com/node/3289/revisions/24258/view
-- Date: 2011-04-24 00:31
-- Who: Crackerhead22
-- Log: Fixed line-! Line 363 for step A has unknown tag [3]: [A Surrounded! |QID|11944|N|From Corporal Venn.|M|82.02,46.42|3]
--	Fixed line-! Line 502 for step F Bad coord 334.14: [F Amber Ledge |QID|11704|N|Fly to Amber Ledge or take a free teleport from Librarian Tiare.|M|33.28,334.14|]

-- URL: http://wow-pro.com/node/3289/revisions/24015/view
-- Date: 2011-01-18 19:23
-- Who: Fluclo
-- Log: Added NonCombat tag to quest Khu'nok Will Know 

-- URL: http://wow-pro.com/node/3289/revisions/24014/view
-- Date: 2011-01-18 19:04
-- Who: Fluclo
-- Log: Added QID to Flying so that it doesn't show each time the guide is reset

-- URL: http://wow-pro.com/node/3289/revisions/24013/view
-- Date: 2011-01-18 18:58
-- Who: Fluclo
-- Log: Changed Overcharged Capacity to Buy instead of Note

-- URL: http://wow-pro.com/node/3289/revisions/24012/view
-- Date: 2011-01-18 18:52
-- Who: Fluclo
-- Log: Added more info for Overcharged Capacitor step

-- URL: http://wow-pro.com/node/3289/revisions/23975/view
-- Date: 2011-01-10 15:07
-- Who: Crackerhead22
-- Log: ;

-- URL: http://wow-pro.com/node/3289/revisions/23946/view
-- Date: 2011-01-07 22:46
-- Who: Crackerhead22
-- Log: Cleaned up(condensed) code, added quest accept and turn-in of "Hero's Call: Northrend!" and added note about purchasing Cold Weather Flying.

-- URL: http://wow-pro.com/node/3289/revisions/23860/view
-- Date: 2010-12-30 03:47
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3289/revisions/23469/view
-- Date: 2010-12-03 22:16
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3289/revisions/23468/view
-- Date: 2010-12-03 22:13
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide("JamBor7072", "Borean Tundra", "Jame", "70", "72", "JamHow7274", "Alliance", function()
return [[

B Overcharged Capacitor |QID|11650|N|The quest Just a Few More Things... in Borean Tundra will require an Overcharged Capacitor.  The quest pays out 4g70s and 20k XP and leads to two further quests each worth the same (and one with a 2-3g green reward), so worth while looking for this item now in Auction House if you can't find an Engineer with 4 Cobalt Bars and 1 Crystallized Earth. You can leave it in your delivery box to save space, as the questgiver above is near a mailbox.|L|39682|M|62.9,71.7|Z|Stormwind City|
N Cold Weather Flying|QID|11672|N|Purchase Cold Weather Flying from Bralla Cloudwing for 500 gold(faction discounts apply).|M|70.29,73.37|Z|Stormwind City|
A Hero's Call: Northrend! |QID|28709|N|From the Hero's Callboard in Darnassus, Ironforge, or either Callboard in Stormwind City.  May not show if your level is too high.|M|62.9,71.7|Z|Stormwind City|
R Stormwind Harbor |QID|11672|N|Go to Stormwind Harbor.|Z|Stormwind City|M|27.06,25.50|
b Valiance Keep |QID|11672|N|Take the boat from the north dock to get to Valiance Keep.|Z|Stormwind City|M|18.01,25.48|
f Valiance Keep |QID|11672|N|Get the flight path at Valiance Keep.|M|58.94,68.30|
T Hero's Call: Northrend!|QID|28709|N|To Recruitment Officer Blythe.|M|57.9,67.7|
A Enlistment Day |QID|11672|M|57.8,67.7|N|From Recruitment Officer Blythe.|
T Enlistment Day |QID|11672|N|Upstairs into the keep. Then turn the quest into General Arlos.|M|56.7,72.6|
A A Time for Heroes |QID|11727|M|56.7,72.6|N|From General Arlos.|
T A Time for Heroes |QID|11727|M|56.4,69.6|N|To Sergeant Hammerhill.|
A The Siege |QID|11797|M|56.4,69.6|N|From Sergeant Hammerhill.|
A A Soldier in Need|QID|11789|M|55.01,68.88|N|From Medic Hawthorn.|
C The Siege |QID|11797|N|Kill Crypt Crawlers just outside of the keep to complete this quest.|M|54.30,68.34|
T The Siege |QID|11797|M|56.4,69.6|N|To Sergeant Hammerhill.|
A Death From Above |QID|11889|M|56.4,69.6|N|From Sergeant Hammerhill.|
C A Soldier in Need |QID|11789|N|Downstairs in the hold of the boat at the center of town, loot the First Aid Supplies.|M|57.47,69.24|
A Cultists Among Us |QID|11920|N|Click the Cultist Shrine to accept this quest.|M|57.55,69.13|
T Cultists Among Us |QID|11920|N|Turn this quest in up on deck to Captain "Lefty" Lugsail.|M|57.8,69.2|

A Notify Arlos |QID|11791|M|57.8,69.2|N|From Admiral Cantlebree.|
T A Soldier in Need |QID|11789|M|55,69|N|To Medic Hawthorn.|
C Death From Above |QID|11889|U|35278|N|Use the net on the Scourged Flamespitters in the air outside town and kill them when they land.|M|55,70|
T Death From Above |QID|11889|M|56.37,69.58|N|To Sergeant Hammerhill.|
A Plug the Sinkholes |QID|11897|M|56.4,69.6|N|From Sergeant Hammerhill.|
U Southern Sinkhole |QID|11897|QO|Explosives set at southern sinkhole: 1/1|U|35704|N|Use the Incendiary Explosives on the southern sinkhole here.|M|50.60,71.43|
C Plug the Sinkholes |QID|11897|U|35704|N|Use the Incendiary Explosives on the northern sinkhole here.|M|54.26,63.89|
T Plug the Sinkholes |QID|11897|N|To Sergeant Hammerhill.|M|56.37,69.58|
A Farshire |QID|11928|M|56.4,69.6|N|From Sergeant Hammerhill.|
A Word on the Street |QID|11927|M|56.8,69.5|N|From Mark Hanes.|
T Notify Arlos |QID|11791|N|To General Arlos, inside the keep.|M|56.67,72.64|
A A Diplomatic Mission |QID|12141|M|56.7,72.6|N|From Counselor Talbot.|
A Enemies of the Light |QID|11792|M|56.6,72.5|N|From Harbringer Vurenn.|

N Cooking Quest |QID|13088|N|If the quest is available to you, grab Northern Cooking from Rollick MacKreel here. When you finish the quest, turn it in next time you're in Valiance Keep. There will be no future reminders. Move onto the next step when ready.|M|57.9,71.5|P|Cooking,350|
A Nick of Time |QID|11575|N|From Midge, inside the inn.|M|58.41,67.85|
T Word on the Street |QID|11927|N|To Leryssa on the top floor of the inn.|M|58.72,68.32|
A Thassarian, My Brother |QID|11599|M|58.7,68.4|N|From Leryssa.|
A Distress Call |QID|11707|N|Jump out of the inn, then accept this from Airman Skyhopper.|M|58.81,68.65|
R Farshire|QID|11928|N|Take the north exit from town to get to Farshire.|M|58.15,62.75|
T Farshire |QID|11928|N|To Gerald Green.|M|58.15,62.75|
A Military? What Military? |QID|11901|M|58.2,62.8|N|From Gerald Green.|
T Military? What Military? |QID|11901|N|Head inside the mine and turn this quest in at the sack of Plagued Grain.|M|56.82,55.67|
A Pernicious Evidence |QID|11902|M|56.8,55.6|N|From Plagued Grain.|
T Thassarian, My Brother |QID|11599|N|Go a little further into the mine to turn this one in at the corpse of William Allerton.|M|56.05,55.46|

A The Late William Allerton |QID|11600|M|56.0,55.4|N|From the corpse of William Allerton.|
T Pernicious Evidence |QID|11902|N|Go back to Gerald Green at Farshire.|M|58.19,62.76|
A It's Time for Action |QID|11903|N|From Gerald Green.|M|58.19,62.76|
A Take No Chances |QID|11913|N|From Wendy Darren.|M|58.29,62.76|
A Reference Material |QID|11908|N|From Jeremiah Hawning.|M|58.19,62.98|
C It's Time for Action |QID|11903|N|Kill the Plagued Scavengers you need for this quest.|S|
C Take No Chances |QID|11913|N|Burn Farshire Grain using the torch.|S|
C Reference Material |QID|11908|N|Loot the red book in the burning building near the mine.|M|55.77,58.37|
C It's Time for Action |QID|11903|N|Kill the Plagued Scavengers you need for this quest.|US|
C Take No Chances |QID|11913|N|Burn Farshire Grain using the torch.|US|
T It's Time for Action |QID|11903|N|Go back to Gerald Green.|M|58.19,62.76|
A Fruits of Our Labor |QID|11904|N|From Gerald Green.|M|58.19,62.76|
T Take No Chances |QID|11913|N|To Wendy Darren.|M|58.29,62.76|
T Reference Material |QID|11908|N|To Jeremiah Hawning.|M|58.19,62.98|

A Repurposed Technology |QID|12035|N|From Jeremiah Hawning.|M|58.19,62.98|
C Repurposed Technology |QID|12035|U|35943|N|Kill Harvest Collectors and using Jeremiah's Tools on their corpses.|Z|Borean Tundra|M|58.1,61.1|S|
C Enemies of the Light |QID|11792|N|Kill Cultist Necrolytes at the summoning circles until one drops a Cultist Communique.|M|55.24,63.35|
l Cart Release Key|QID|11904|M|57.94,53.7|L|35705|N|Kill and loot Captain Jacobs at the end of the mine.|
C Fruits of Our Labor |QID|11904|N|Click on the lever next to the cart to release it.|M|57.09,54.69|
C Repurposed Technology |QID|12035|U|35943|N| Kill Harvest Collectors and using Jeremiah's Tools on their corpses.|M|58.1,61.1|US|
T Fruits of Our Labor |QID|11904|N|Go back to Gerald Green.|M|58.19,62.76|
A One Last Delivery |QID|11962|N|From Gerald Green.|M|58.19,62.76|
T Repurposed Technology |QID|12035|N|To Jeremiah Hawning.|M|58.19,62.98|
T One Last Delivery |QID|11962|N|To Hilda Stoneforge in Valiance Keep.|M|57.31,66.59|
A Weapons for Farshire |QID|11963|N|From Hilda Stoneforge in Valiance Keep.|M|57.31,66.59|
r Sell junk, repair and re-stock food/drink.|QID|11897|M|57.82,66.04|

T Enemies of the Light |QID|11792|N|To Harbinger Vurenn inside the keep.|M|56.65,72.46|
A Further Investigation |QID|11793|N|From Harbinger Vurenn.|M|56.65,72.46|
T Further Investigation |QID|11793|N|To Vindicator Yaala on the top floor of the inn.|M|58.55,67.30|
A The Hunt is On |QID|11794|N|From Vindicator Yaala on the top floor of the inn.|M|58.55,67.30|
T The Late William Allerton |QID|11600|N|To Leryssa.|M|58.73,68.34|
A Lost and Found |QID|11601|N|From Leryssa.|M|58.73,68.34|
T Lost and Found |QID|11601|N|To James Deacon the inn barkeep.|M|58.29,68.05|
A In Wine, Truth |QID|11603|N|From James Deacon the inn barkeep.|M|58.29,68.05|
N Cultist in Kitchen |QID|11794|QO|Cultist in kitchen defeated: 1/1|U|35125|N|Use the Oculus of the Exorcist in the kitchen of the inn, then talk to and kill the cultist.|M|58.62,67.10|
N Cultist in Docks |QID|11794|QO|Cultist in docks defeated: 1/1|U|35125|N|Use the Oculus on the lower dock outside, then talk to and kill the cultist.|M|59.18,68.56|
C The Hunt is On |QID|11794|U|35125|N|Use the oculus in the jail underneath the keep, then talk to and kill the cultist.|M|56.67,71.76|
T The Hunt is On |QID|11794|N|To Vindicator Yaala on the top floor of the inn.|M|58.55,67.30|
T Weapons for Farshire |QID|11963|N|Go back to Gerald at Farshire.|M|58.16,62.75|

A Call to Arms! |QID|11965|N|From Gerald Green|M|58.19,62.76|
C Call to Arms! |QID|11965|N|Ring the bell upstairs in the town hall.|M|57.39,59.31|
T Call to Arms! |QID|11965|N|Go back to Gerald.|M|58.16,62.75|
R D.E.H.T.A. Encampment |QID|11864|M|57,44|
A A Mission Statement |QID|11864|N|From Arch Druid Lathorius.|M|57.06,44.30|
A Ears of Our Enemies |QID|11866|N|From Arch Druid Lathorius.|M|57.06,44.30|
A Help Those That Cannot Help Themselves |QID|11876|N|From Arch Druid Lathorius.|M|57.06,44.30|
A Happy as a Clam |QID|11869|N|From Heirophant Cenius.|M|57.33,44.08|
A Ned, Lord of Rhinos... |QID|11884|N|From Killinger the Den Watcher, the bear that circles.|M|57.0,44.0|
A Unfit for Death |QID|11865|N|From Zaza.|M|56.80,44.03|

C Ears of Our Enemies |QID|11866|N|Kill Loot Crazed enemies south of D.E.H.T.A.|M|57.57,45.49|S|
C Unfit for Death |QID|11865|U|35127|N|In the field south of the camp, find traps and use the Fake Furs on them to complete this quest.|M|57.57,45.49|
C Help Those That Cannot Help Themselves |QID|11876|U|35228|N|Go east and use the D.E.H.T.A. Trap Smasher on Trapped Mammoth Calves.|M|53.73,39.87|S|
C Happy as a Clam |QID|11869|N|Go west to Lake Kum'uya and kill 10 Loot Crazed Divers.|M|53.04,46.21|
C Ned, Lord of Rhinos... |QID|11884|N|Go west of the lake and look for Nedar, Lord of Rhinos on his mount.|M|47.19,40.14|
C Help Those That Cannot Help Themselves |QID|11876|U|35228|N|Go east and use the D.E.H.T.A. Trap Smasher on Trapped Mammoth Calves.|M|53.73,39.87|US|
C Ears of Our Enemies |QID|11866|N|Kill Loot Crazed enemies south of D.E.H.T.A.|M|57.57,45.49|US|
T Unfit for Death |QID|11865|N|To Zaza at the D.E.H.T.A. Encampment.|M|56.80,44.03|
A The Culler Cometh |QID|11868|N|From Zaza|M|56.80,44.03|
T Help Those That Cannot Help Themselves |QID|11876|N|To Arch Druid Lathorius.|M|57.06,44.30|
A Khu'nok Will Know |QID|11878|NC|N|From Arch Druid Lathorius.|M|57.06,44.30|
T Ears of Our Enemies |QID|11866|N|To Arch Druid Lathorius.|M|57.06,44.30|
T Happy as a Clam |QID|11869|N|To Heirophant Cenius|M|57.33,44.08|
A The Abandoned Reach |QID|11870|N|From Heirophant Cenius|M|57.33,44.08|
T Ned, Lord of Rhinos... |QID|11884|N|To Killinger the Den Watcher, the bear that circles|M|57.0,44.0|
C Khu'nok Will Know |QID|11878|N|Deliver the Orphaned Mammoth Calk here.|M|59.43,30.61|
T Khu'nok Will Know |QID|11878|M|59.5,30.4|N|To Khu'nok.|

A Kaw the Mammoth Destroyer |QID|11879|M|59.5,30.4|N|From Khu'nok.|
C Kaw the Mammoth Destroyer |QID|11879|N|Find a Wooly Mammoth Bull and right-click it to mount up. Go northwest to find Kaw the Mammoth Destroyer and kill him with the help of your mammoth. When he's dead, loot the item off the ground.|M|53.68,24.37|
K Robots |QID|11729|L|34984|N|Kill robots in this area until one drops The Ultrasonic Screwdriver.|M|58.27,22.84|
A The Ultrasonic Screwdriver |QID|11729|U|34984|N|Right-click The Ultrasonic Screwdriver and accept the quest.|M|58.5,17.6|
R Fizzcrank Airstrip |QID|11707|M|57,20|
f Fizzcrank Airstrip |QID|11707|N|Get the flight path at Fizzcrank Airstrip.|M|56.58,20.06|
T Distress Call |QID|11707|N|Inside the inn on the second floor.|M|57.03,18.71|
A The Mechagnomes |QID|11708|N|From Fizzcrank Fullthrottle|M|57.03,18.71|
C The Mechagnomes |QID|11708|N|Listen to Fizzcrank Fullthrottle until the quest completes.|M|57.03,18.71|
T The Mechagnomes |QID|11708|N|To Jinky Wingnut outside the inn.|M|57.44,18.74|
A Re-Cursive |QID|11712|N|From Jinky Wingnut|M|57.44,18.74|
T The Ultrasonic Screwdriver |QID|11729|N|To Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|

A Master and Servant |QID|11730|N|From Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
A Dirty, Stinkin' Snobolds! |QID|11645|N|From Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
A What's the Matter with the Transmatter? |QID|11710|N|From Mordle Cogspinner.|M|57.51,18.61|
A King Mrgl-Mrgl |QID|11704|N|From Mordle Cogspinner|M|57.51,18.61|
C Crafty's Stuff |QID|11645|M|58,15|S|N|Loot crates that you see.|
A Get Me Outa Here! |QID|11673|N|Jump down the hole here and try to land in the water so you don't die. From the gnome nearby, get this escort quest.|M|55.57,12.59|
C Get Me Outa Here! |QID|11673|N|Continue collecting Crafty's Stuff as needed while escorting the Gnome out.|M|55.6,12.6|
C Crafty's Stuff |QID|11645|M|58,15|US|N|Finishing getting any crates that you need.|
T Get Me Outa Here!|QID|11673|N|To Fizzcrank Fullthrottle in the inn on the second floor at Fizzcrank Airstrip.|M|57.03,18.71|
T Dirty, Stinkin' Snobolds! |QID|11645|N|To Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
A Just a Few More Things... |QID|11650|N|From Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
C What's the Matter with the Transmatter? |QID|11710|N|Pick up Fizzcrank Spare Parts.|M|15,19.5|S|
C Re-Cursive |QID|11712|U|34973|N|Kill Mechagnomes and use the Re-Cursive Transmatter Injection on them.|M|58.4,19.5|S|
C Master and Servant |QID|11730|U|35116|N|Kill robots and use The Ultrasonic Screwdriver on them.|M|57.52,25.03|S|
l Crafty's Tools |QID|11650|L|34802|N|Loot Crafty's Tools below the Fizzcrank Pumping Station.|M|64.37,23.06|
C Re-Cursive |QID|11712|U|34973|N|Kill Mechagnomes and use the Re-Cursive Transmatter Injection on them.|M|58.4,19.5|US|
T Re-Cursive |QID|11712|N|To Jinky Wingnut outside the inn.|M|57.44,18.74|

A Lefty Loosey, Righty Tighty |QID|11788|N|From Jinky Wingnut|M|57.45,18.74|
A Finding Pilot Tailspin |QID|11725|N|From Fizzcrank Fullthrottle in the inn on the second floor.|M|57.03,18.71|
K Twonky |QID|11788|QO|Twonky slain: 1/1|N|Click the controls here and kill Twonky.|M|60.20,20.42|
K ED-210 |QID|11788|QO|ED-210 slain: 1/1|N|Click the controls here and kill ED-210.|M|65.46,17.51|
K Max Blasto |QID|11788|QO|Max Blasto slain: 1/1|N|Click the controls here and kill Max Blasto.|M|63.74,22.40|
C Lefty Loosey, Righty Tighty |QID|11788|N|Click the controls here and kill The Grinder.|M|65.19,28.79|
C What's the Matter with the Transmatter? |QID|11710|N|Pick up Fizzcrank Spare Parts.|M|15,19.5|US|
T Finding Pilot Tailspin |QID|11725|N|To Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|
A A Little Bit of Spice |QID|11726|N|From Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|
C A Little Bit of Spice |QID|11726|N|Kill gorlocs here until you get 4 Gorloc Spice Pouches.|M|65,41|
T A Little Bit of Spice |QID|11726|N|To Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|

A Lupus Pupus |QID|11728|N|From Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|
C Lupus Pupus |QID|11728|U|35121|N|Target Oil-stained Wolves in the area and use the bait. Loot the Microfilm they produce until you complete this quest.|
T Lupus Pupus |QID|11728|N|To Iggy "Tailspin" Cogtoggle|M|61.63,35.79|
A Emergency Protocol: Section 8.2, Paragraph C |QID|11795|N|From Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|
C Emergency Protocol: Section 8.2, Paragraph C |QID|11795|N|Look for dead gnomes scattered around the area and search their bodies.|M|61.0,37.8|
T Emergency Protocol: Section 8.2, Paragraph C |QID|11795|N|To Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|
A Emergency Protocol: Section 8.2, Paragraph D |QID|11796|N|From Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|
U Northwestern Wreck |QID|11796|QO|Scuttle a Northwestern Wreck: 1/1|U|35224|N|Use the Emergency Torch on the crash here.|M|60.89,33.74|
U Southern Wreck |QID|11796|QO|Scuttle a Southern Wreck: 1/1|U|35224|N|Use the Emergency Torch on the crash here.|M|61.08,39.96|
C Emergency Protocol: Section 8.2, Paragraph D |QID|11796|U|35224|N|Use the Emergency Torch on the crash here.|M|63.38,36.91|
T Emergency Protocol: Section 8.2, Paragraph D |QID|11796|N|To Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|

A Give Fizzcrank the News |QID|11873|N|From Iggy "Tailspin" Cogtoggle.|M|61.63,35.79|
A The Honored Ancestors |QID|11605|N|From Elder Atkanok at the Coldrock Quarry.|M|54.69,35.69|
A Reclaiming the Quarry |QID|11612|N|From Etaruk.|M|54.3,36.1|
C Reclaiming the Quarry |QID|11612|N|Kill Beryl Treasure Hunters.|S|
N Elder Sagani |QID|11605|QO|Elder Sagani identified: 1/1|N|Click the Elder here.|M|52.84,34.05|
N Elder Kesuk |QID|11605|QO|Elder Kesuk identified: 1/1|N|Click the Elder here.|M|50.81,32.38|
C The Honored Ancestors |QID|11605|N|Click the Elder here.|M|52.32,31.19|
T The Honored Ancestors |QID|11605|N|To Elder Atkanok.|M|54.69,35.69|
A The Lost Spirits |QID|11607|N|From Elder Atkanok.|M|54.69,35.69|
C The Lost Spirits |QID|11607|U|34711|N|Kill Beryl Hounds and use the Cores of Malice on the Tuskarr in the quarry.|M|51.5,31.4|
C Reclaiming the Quarry |QID|11612|N|Kill Beryl Treasure Hunters.|US|
T The Lost Spirits |QID|11607|N|To Elder Atkanok.|M|54.69,35.69|

A Picking Up the Pieces |QID|11609|N|From Elder Atkanok|M|54.69,35.69|
C Picking Up the Pieces |QID|11609|N|Pick up Tuskarr Ritual Objects.|M|53.1,33.3|S|
T Reclaiming the Quarry |QID|11612|N|To Etaruk|M|54.3,36.1|
A Hampering Their Escape |QID|11617|N|From Etaruk|M|54.3,36.1|
N East Platform |QID|11617|QO|East Platform Destroyed: 1/1|U|34772|N|Kill Beryl Reclaimers until you get a grenade and throw it at the East Platform here.|M|52.44,35.31|
N West Platform |QID|11617|QO|West Platform Destroyed: 1/1|U|34772|N|Kill Beryl Reclaimers until you get a grenade and throw it at the West Platform here.|M|50.48,34.84|
C Hampering Their Escape |QID|11617|U|34772|N|Kill Beryl Reclaimers until you get a grenade and throw it at the North Platform here.|M|51.91,31.86|
C Picking Up the Pieces |QID|11609|N|Pick up Tuskarr Ritual Objects.|M|53.1,33.3|US|
T Picking Up the Pieces |QID|11609|N|To Elder Atkanok|M|54.69,35.69|
A Leading the Ancestors Home |QID|11610|N|From Elder Atkanok|M|54.69,35.69|
T Hampering Their Escape |QID|11617|N|To Etaruk|M|54.3,36.1|

A A Visit to the Curator |QID|11623|N|From Etaruk|M|54.3,36.1|
C Leading the Ancestors Home |QID|11610|U|34715|N|Use the Tuskarr Ritual Object at each of the Elders' stones you were previously at.|M|52.84,34.05;50.81,32.38;52.32,31.19|
C A Visit to the Curator |QID|11623|N|Kill Curator Insivius on the landed platform.|M|50.08,32.73|
f Amber Ledge |QID|11623|N|Get the flight path at Amber Ledge.|M|45.32,34.59|
T A Visit to the Curator |QID|11623|N|To Etaruk.|M|54.3,36.1|
T Leading the Ancestors Home |QID|11610|N|To Elder Atkanok.|M|54.69,35.69|
T The Abandoned Reach |QID|11870|N|To Hierophant Liandra.|M|57.79,55.10|
A Not On Our Watch |QID|11871|N|From Hierophant Liandra.|M|57.79,55.10|
C Not On Our Watch |QID|11871|N|Pick up Shipments of Animal Parts off the ground to complete this quest (Northsea Thugs also drop them).|M|59.1,55.9|
T Not On Our Watch |QID|11871|N|To Hierophant Liandra.|M|57.79,55.10|

A The Nefarious Clam Master... |QID|11872|N|From Hierophant Liandra.|M|57.79,55.10|
C The Nefarious Clam Master... |QID|11872|N|Kill Clam Master K at the shipwreck in the water to the southeast.|M|61.61,66.40|
C In Wine, Truth |QID|11603|N|At the bottom of the ship, loot the wine crate for Kul'Tiras Wine.|M|61.9,65.7|
T In Wine, Truth |QID|11603|N|Swim southwest back to Valiance Keep to Old Man Colburn in the inn.|M|58.52,68.12|
A A Deserter |QID|11604|N|From Old Man Colburn.|M|58.52,68.12|
T A Deserter |QID|11604|N|Go to the keep to Private Brau.|M|56.70,71.46|
A Cowards and Fools |QID|11932|N|From Private Brau.|M|56.7,71.5|
r Sell junk, repair and re-stock food/drink. |QID|12141|M|57.82,66.04|
T A Diplomatic Mission |QID|12141|N|Take the road southwest out of town to Karuk.|M|47.15,75.40|
A Karuk's Oath |QID|11613|M|47.1,75.5|N|From Karuk.|
C Karuk's Oath |QID|11613|N|Kill the Skadir Raiders and Longboatsmen.|S|

A Cruelty of the Kvaldir |QID|12471|N|Go down to Riplash Strand and head west until you see a Captured Tuskarr Prisoner fighting a Naga. Help him and quickly accept his quest.|M|44.2,77.9|
C Karuk's Oath |QID|11613|N|Kill the Skadirs Raiders and Longboatsmen.|US|
T Karuk's Oath |QID|11613|M|47.15,75.40|N|To Karuk.|
A Gamel the Cruel |QID|11619|M|47.1,75.5|N|From Karuk.|
T Cruelty of the Kvaldir |QID|12471|M|47.1,75.5|N|To Karuk.|
C Gamel the Cruel |QID|11619|N|Kill Gamal in the cave on the beach.|M|46.26,78.83|
T Gamel the Cruel |QID|11619|M|47.1,75.5|N|To Karuk.|
A A Father's Words |QID|11620|M|47.1,75.5|N|From Karuk.|
T A Father's Words |QID|11620|N|Go to the Shrine of Scales southwest and turn the quest into Veehja.|M|43.63,80.52|

A The Trident of Naz'jan |QID|11625|M|43.6,80.5|N|From Veehja.|
C The Trident of Naz'jan |QID|11625|N|Swim/fly southeast to Riplash Ruins. Kill Ragnar Drakkarlund and loot the Trident of Naz'jan.|M|53.13,90.70|
T The Trident of Naz'jan |QID|11625|N|Back to Veehja at the Shrine of Scales.|M|43.63,80.62|
A The Emissary |QID|11626|M|43.6,80.5|N|From  Veehja.|
C The Emissary |QID|11626|U|35850|N|Swim to the large iceberg at Riplash Ruins and dive down to find Leviroth. Use the Trident of Naz'jan on him and finish him off.|M|51.40,88.19|
T The Emissary |QID|11626|N|To Karuk.|M|47.15,75.39|N|To
C The Culler Cometh |QID|11868|N|Kill Karen at the far south edge of this field.|M|57.20,56.03|
T The Culler Cometh |QID|11868|N|To Zaza.|M|56.81,44.12|
T The Nefarious Clam Master... |QID|11872|N|To Heirophant Cenius|M|57.3,44.1|
T Kaw the Mammoth Destroyer |QID|11879|M|57.0,44.3|N|To Arch Druid Lathorius.|

A The Assassination of Harold Lane |QID|11892|N|From Arch Druid Lathorius.|M|57.06,44.30|
C The Assassination of Harold Lane |QID|11892|U|35293|N|Use the Cenarion Horn at the start of the fight to take out a lot of his Health.|M|49.91,41.54|
T The Assassination of Harold Lane |QID|11892|N|To Arch Druid Lathorius.|M|57.04,44.25|
T Cowards and Fools |QID|11932|N|To Ataika in Kaskala.|M|63.81,46.10|
A The Son of Karkut |QID|12086|N|From Ataika.|M|63.81,46.10|
A Not Without a Fight! |QID|11949|N|From Ataika.|M|63.81,46.10|
A Preparing for the Worst |QID|11945|N|From Utaik.|M|64.0,45.7|
C Preparing for the Worst |QID|11945|N|Pick up these supplies off the ground.|M|65.76,47.55|S|
C Not Without a Fight! |QID|11949|N|Kill Kvaldir Raiders.|M|65.76,47.55|
T Not Without a Fight! |QID|11949|N|To Ataika.|M|63.81,46.10|

A Muahit's Wisdom |QID|11950|N|From Ataika.|M|63.81,46.10|
C Preparing for the Worst |QID|11945|N|Pick up these supplies off the ground.|M|65.76,47.55|US|
T Preparing for the Worst |QID|11945|N|To Utaik.|M|64.0,45.7|
T Muahit's Wisdom |QID|11950|N|To Elder Muahit on the island in Njord's Breath Bay.|M|67.21,54.84|
A Spirits Watch Over Us |QID|11961|N|From Elder Muahit.|M|67.21,54.84|
C Spirits Watch Over Us |QID|11961|N|Search the dead Tuskarr (Iruk) in the water.|M|67.7,50.4|
T Spirits Watch Over Us |QID|11961|N|To Elder Muahit.|M|67.21,54.84|
A The Tides Turn |QID|11968|N|From Elder Muahit.|M|67.21,54.84|
C The Tides Turn |QID|11968|N|Kill Heigarr the Horrible.|M|67.5,56.7|
T The Tides Turn |QID|11968|N|To Elder Muahit.|M|67.21,54.84|
A Travel to Moa'ki Harbor |QID|12117|N|From Hotawa.|M|67.27,54.87|
R Unu'pe |QID|11788|M|77.5,51|

r Sell junk, repair and re-stock food/drink.|QID|11788|M|77.91,52.51|
f Unu'pe |QID|11788|N|Get the flight path at Unu'pe from Bilko Driftspark.|M|78.53,51.53|
F Fizzcrank Airstrip |QID|11788|N|Fly to Fizzcrank Airstrip.|
T Lefty Loosey, Righty Tighty |QID|11788|N|To Jinky Wingnut.|M|57.45,18.74|
A The Gearmaster |QID|11798|N|From Jinky Wingnut.|M|57.45,18.74|
T What's the Matter with the Transmatter? |QID|11710|M|57.37,18.82|N|To Mordle Cogspinner.|
A Check in With Bixie |QID|11692|M|57.4,18.7|N|From Mordle Cogspinner.|
T Give Fizzcrank the News |QID|11873|N|To Fizzcrank Fullthrottle in the building on the second floor.|M|56.98,18.70|
h Fizzcrank Airstrip |QID|11713|N|Set your hearthstone here with "Charlie" Northrop in the building on the first floor.|M|57.12,18.72|

A Scouting the Sinkholes |QID|11713|N|From Abner Fizzletorque.|M|57.06,20.12|
N Northwest Sinkhole |U|34920|QID|11713|QO|Mark Location of Northwest Sinkhole: 1/1|N|Use the Map of the Geyser Fields at the Northwest Sinkhole.|M|66.23,32.15|
N Northeast Sinkhole |U|34920|QID|11713|QO|Mark Location of Northeast Sinkhole: 1/1|N|Use the Map of the Geyser Fields at the Northeast Sinkhole.|M|69.68,32.59|
C Scouting the Sinkholes |QID|11713|U|34920|N|Use the Map of the Geyser Fields at the South Sinkhole to complete the quest.|M|70.23,36.34|
H Fizzcrank Airstrip |QID|11713|N|Hearthstone to Fizzcrank Airstrip.|
T Scouting the Sinkholes |QID|11713|N|To Abner Fizzletorque.|M|57.06,20.12|
A Fueling the Project |QID|11715|N|From Abner Fizzletorque.|M|57.06,20.12|
C Fueling the Project |QID|11715|U|34975|N|Use the Portable Oil Collector on Oil Slicks in the pools southeast of town until you complete this quest.|M|57.52,25.03|
C Master and Servant |QID|11730|U|35116|N|Kill robots and use The Ultrasonic Screwdriver on them.|M|57.52,25.03|US|
T Fueling the Project |QID|11715|N|To Abner Fizzletorque.|M|57.06,20.12|
A A Bot in Mammoth's Clothing |QID|11718|N|From Abner Fizzletorque.|M|57.06,20.12|
T Master and Servant |QID|11730|M|57.84,18.70|N|To
C A Bot in Mammoth's Clothing |QID|11718|N|Kill mammoths until you get 6 Thick Mammoth Hides.|M|53.66,21.74|
T A Bot in Mammoth's Clothing |QID|11718|N|To Abner Fizzletorque.|M|57.06,20.12|

A Deploy the Shake-n-Quake! |QID|11723|N|From Abner Fizzletorque.|M|57.06,20.12|
T Check in With Bixie |QID|11692|N|Talk to the Air Traffic Controller and choose the free ride to Dens of Dying.|M|56.58,20.06|
A Oh Great... Plagued Magnataur! |QID|11693|N|From Bixie Wrenchshanker.|M|73.42,18.79|
C Oh Great... Plagued Magnataur! |QID|11693|N|Kill 10 Plagued Magnataurs to complete this quest.|M|74.83,19.88|
T Oh Great... Plagued Magnataur! |QID|11693|N|To Bixie Wrenchshanker.|M|73.42,18.79|
A There's Something Going On In Those Caves |QID|11694|N|From Bixie Wrenchshanker.|M|73.42,18.79|
C There's Something Going On In Those Caves |QID|11694|U|34915|N|Head up to the cave and use Bixie's Inhibiting Powder on the cauldron.|M|74.79,14.24|
T There's Something Going On In Those Caves |QID|11694|N|To Bixie Wrenchshanker.|M|73.42,18.79|
A Rats, Tinky Went into the Necropolis! |QID|11697|N|From Bixie Wrenchshanker.|M|73.42,18.79|
A Might As Well Wipe Out the Scourge |QID|11698|N|From Bixie Wrenchshanker.|M|73.42,18.79|
C Might As Well Wipe Out the Scourge |QID|11698|N|Kill the scourge monsters you need for this quest.|M|68.2,17.0|S|
T Rats, Tinky Went into the Necropolis! |QID|11697|N|Use the lower entrance on the southwestern side of the Necropolis and stick to the right to find him.|M|69.89,14.76|

A I'm Stuck in this Damned Cage... But Not For Long! |QID|11699|N|From Tinky Wickwhistle.|M|69.9,14.7|
K Lich-Lord Chillwinter |QID|11699|QO|Piloting Scourgestone: 1/1|N|Go outside and around to get to the top. Kill and loot Lich-Lord Chillwinter.|M|69.73,11.85|
K Doctor Razorgrin |QID|11699|QO|Magical Gyroscope: 1/1|N|Jump down to the room below and kill and loot Doctor Razorgrin.|M|69.98,13.88|
C I'm Stuck in this Damned Cage... But Not For Long! |QID|11699|N|Kill Festering Ghouls on your way back down to Tinky Wickwhistle until one drops an Engine-Core Crystal.|M|69.98,13.88|
T I'm Stuck in this Damned Cage... But Not For Long! |QID|11699|N|Back at Tinky.|M|69.89,14.75|
A Let Bixie Know |QID|11700| |N|From Tinky Wickwhistle.|M|69.9,14.7|
C Might As Well Wipe Out the Scourge |QID|11698|N|Kill the scourge monsters you need for this quest.|M|68.2,17.0|US|
T Might As Well Wipe Out the Scourge |QID|11698|N|To Bixie Wrenchshanker.|M|73.42,18.79|
T Let Bixie Know |QID|11700|N|To Bixie Wrenchshanker.|M|73.42,18.79|
A Back to the Airstrip |QID|11701|N|From Bixie Wrenchshanker.|M|73.42,18.79|
C The Gearmaster |QID|11798|N|Go up the ramp here, loot The Gearmaster's Manual and kill Gearmaster Mechazod when he's done talking. |M|64.50,23.40|
C Deploy the Shake-n-Quake! |QID|11723|U|34981|N|Head down to the south sinkhole and use the Shake-n-Quake 5000 Control Unit. Kill Lord Kryxix when he spawns.|M|69.99,37.09|
T The Son of Karkut |QID|12086|N|To Corporal Venn at Death's Stand.|M|82.02,46.42|

A Surrounded! |QID|11944|N|From Corporal Venn.|M|82.02,46.42|
C Surrounded! |QID|11944|N|Kill Ziggurat Defenders.|S|
l Rocknar's Grit |QID|11650|L|34804|N|Kill Rocknar and loot A Handful of Rocknar's Grit.|M|81.47,42.49|
C Surrounded! |QID|11944|N|Kill Ziggurat Defenders.|US|
T Surrounded! |QID|11944|N|To Corporal Venn.|M|82.02,46.42|
A Thassarian, the Death Knight |QID|12088|N|From Corporal Venn.|M|82.02,46.42|
T Thassarian, the Death Knight |QID|12088|N|To Thassarian inside the Ziggurat.|M|84.80,41.67|
A Finding the Phylactery |QID|11956|N|From Thassarian.|M|84.80,41.67|
C Finding the Phylactery |QID|11956|N|When ready with full health/mana, dive into the water and click the Frozen Phylactery. 4 monsters will attack you. Kill the Phylactery Guardian and loot Tanathal's Phylactery. |M|85.40,33.35|
T Finding the Phylactery |QID|11956|N|To Thassarian inside the Ziggurat.|M|84.80,41.67|
A Buying Some Time |QID|11938|N|From Thassarian.|M|84.80,41.67|
C Buying Some Time |QID|11938|N|Head north into the Temple City of En'kilah and kill 20 En'kilah enemies.|M|85,26|
T Buying Some Time |QID|11938|N|To Thassarian inside the Ziggurat.|M|84.80,41.67|

A Words of Power |QID|11942|N|From Thassarian.|M|84.80,41.67|
l High Priest Talet-Kha's Scroll |QID|11942|QO|High Priest Talet-Kha's Scroll: 1/1|N|Kill High Priest Talet-Kha for his scroll.|M|89.37,28.94|
l High Priest Andorath's Scroll |QID|11942|QO|High Priest Andorath's Scroll: 1/1|N|Kill High Priest Andorath on the upper floor for his scroll.|M|87.81,20.71|
C Words of Power |QID|11942|N|Kill the Necromancers around him, then High Priest Naferset himself for his scroll.|M|83.92,20.45|
T Words of Power |QID|11942|N|To Thassarian inside the Ziggurat.|M|84.80,41.67|
A Last Rites |QID|12019|N|From Thassarian.|M|84.80,41.67|
C Last Rites |QID|12019|N|You'll have Thassarian's help. Take the portal up to Naxxanar in En'kilah, then take the portal above it to the top.|M|86.60,28.50|
T Last Rites |QID|12019|N|To Thassarian.|M|86.60,28.50;84.80,41.67|
N Abandon The Lost Courier |QID|11701|N|If you accepted The Lost Courier and plan to continue using Jame's guide, abandon it now. There is a better quest in Howling Fjord later, and the two are mutually exclusive.|
H Fizzcrank Airstrip |QID|11701|N|If your hearthstone isn't up yet, go back to Unu'pe and fly instead.|
T Back to the Airstrip |QID|11701|N|To Fizzcrank Fullthrottle in the building on the second floor.|M|56.98,18.70|
T The Gearmaster |QID|11798|N|To Fizzcrank Fullthrottle in the building on the second floor.|M|56.98,18.70|
T Deploy the Shake-n-Quake! |QID|11723|N|To Abner Fizzletorque.|M|57.06,20.12|
C Just a Few More Things... |QID|11650|L|39682|N|Grab the Overcharged Capacitor out of your delivery box. If you don't have it, skip this and the next quest and finish them when you get it.|M|56.98,18.85|
T Just a Few More Things... |QID|11650|N|To Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|

A Hah... You're Not So Big Now! |QID|11653|N|From Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
r Sell junk, repair and re-stock food/drink. |QID|11701|M|57.07,19.85|
C Hah... You're Not So Big Now! |QID|11653|U|34812|N|Use Crafty's Ultra-Advanced Proto-Typical Shortening Blaster on Magmoth monsters north of town until you complete this quest.|M|56.37,14.55|
T Hah... You're Not So Big Now! |QID|11653|N|To Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
A Plan B |QID|11658|N|From Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
F Amber Ledge |QID|11575|N|Fly to Amber Ledge from Kara Thricestar.|M|56.57,20.06|
T Nick of Time |QID|11575|N|To Librarian Donathan.|M|45.27,33.36|
A Prison Break |QID|11587|N|From Librarian Donathan.|M|45.27,33.36|
A Monitoring the Rift: Cleftcliff Anomaly |QID|11576|N|From Librarian Garren.|M|44.98,33.38|
K Beryl Mage Hunters |QID|11587|L|34688|N|Kill Beryl Mage Hunters until one drops a Beryl Prison Key.|M|42.51,37.85|
C Prison Break |QID|11587|N|Click an Arcane Prison to free a Mage Prisoner.|M|42.74,36.95|
C Monitoring the Rift: Cleftcliff Anomaly |QID|11576|U|34669|N|Southwest, past Beryl Point, take a swim to the Westrift and use the Arcanometer next to it.|M|34.36,42.13|
T Prison Break |QID|11587|N|To Librarian Donathan.|M|45.27,33.36|

A Abduction |QID|11590|N|From Librarian Donathan.|M|45.27,33.36|
T Monitoring the Rift: Cleftcliff Anomaly |QID|11576|N|To Librarian Garren.|M|44.98,33.38|
A Monitoring the Rift: Sundered Chasm |QID|11582|N|From Librarian Garren.|M|44.98,33.38|
C Monitoring the Rift: Sundered Chasm |QID|11582|U|34669|N|If you don't have flying, using a 100% speed mount, jump off the end of the wooden plank on the western side of Amber Ledge. Swim northeast, dive down to the Sundered Chasm, and use the Arcanometer.|M|44.01,28.63|
C Abduction |QID|11590|U|34691|N|Get out of the water back at Beryl Point and find a Beryl Sorcerer. Fight it down to low health, then use the Arcane Binder on it.|M|42.51,38.01|
T Abduction |QID|11590|N|To Librarian Donathan.|M|45.27,33.36|
A The Borean Inquisition |QID|11646|N|From Librarian Donathan.|M|45.27,33.36|
T Monitoring the Rift: Sundered Chasm |QID|11582|N|To Librarian Garren.|M|44.98,33.38|
A Monitoring the Rift: Winterfin Cavern |QID|12728|N|From Librarian Garren.|M|44.98,33.38|
T The Borean Inquisition |QID|11646|N|To Librarian Normantis on the second floor of the tower.|M|46.33,32.84|
A The Art of Persuasion |QID|11648|N|From Librarian Normantis on the second floor of the tower.|M|46.33,32.84|
C The Art of Persuasion |QID|11648|U|34811|N|Use the Neural needler on the Imprisoned Beryl Sorcerer several times until the quest completes.|M|46.33,32.84|
T The Art of Persuasion |QID|11648|N|To Librarian Normantis on the second floor of the tower.|M|46.33,32.84|
A Sharing Intelligence |QID|11663|N|From Librarian Normantis on the second floor of the tower.|M|46.33,32.84|
T Sharing Intelligence |QID|11663|N|To Librarian Donathan.|M|45.27,33.36|
A A Race Against Time |QID|11671|N|From Librarian Donathan.|M|45.27,33.36|
C A Race Against Time |QID|11671|U|34897|N|Head down to the large round platform, use the Beryl Shield Detonator to bring Inquisitor Salrand out and kill her. Loot Salrand's Lockbox.|M|41.79,39.22|
T A Race Against Time |QID|11671|N|To Librarian Donathan.|M|45.27,33.36|

A Reforging the Key |QID|11679|N|From Librarian Donathan.|M|45.27,33.36|
T Reforging the Key |QID|11679|N|To Surristrasz.|M|45.3,34.5|
A Taking Wing |QID|11680|N|From Surristrasz.|M|45.3,34.5|
T Taking Wing |QID|11680|N|To Warmage Anzim.|M|46.37,37.31|
A Rescuing Evanor |QID|11681|N|From Warmage Anzim.|M|46.37,37.31|
T Rescuing Evanor |QID|11681|N|Stay close to Evanor when the drake drops you on the platform.|M|46.4,32.4|
A Dragonspeak |QID|11682|N|From Archmage Evanor.|M|46.38,32.40|
T Dragonspeak |QID|11682|N|To Surristrasz.|M|45.3,34.5|
A Traversing the Rift |QID|11733|N|From Surristrasz.|M|45.3,34.5|
T Traversing the Rift |QID|11733|N|To Archmage Berinand.|M|32.95,34.40|

A Reading the Meters |QID|11900|N|From Archmage Berinand.|M|32.95,34.40|
A Secrets of the Ancients |QID|11910|N|From Archmage Berinand.|M|32.95,34.40|
A Nuts for Berries |QID|11912|N|From Librarian Serrah.|M|33.48,34.38|
A Basic Training |QID|11918|N|From Raelorasz.|M|33.31,34.53|
C Basic Training |QID|11918|N|Kill Coldarra Spellweavers.|S|
C Secrets of the Ancients |QID|11910|N|Kill Glacial Ancients and Magic-bound Ancients.|S|
C Nuts for Berries |QID|11912|N|Pick up Frostberries.|S|
K Coldarra Spellbinders |QID|11941|L|35648|N|Kill Coldarra Spellbinders until one drops a Scintillating Fragment|M|33,28|
A Puzzling... |QID|11941|U|35648|N|Right-click the Scintillating Fragment to accept this quest.|M|35.0,28.0|
T Puzzling... |QID|11941|N|To Raelorasz.|M|33.31,34.53|

A The Cell |QID|11943|N|From Raelorasz.|M|33.31,34.53|
N Southern Coldarra Reading |QID|11900|QO|Southern Coldarra Reading: 1/1|N|Follow the path west to find a Coldarra Geological Monitor and click it.|M|28.33,34.98|
l Energy Core |QID|11943|QO|Energy Core: 1/1|N|Kill Warbringer Goredrak and loot the Energy Core.|M|24.24,28.92|
N Western Coldarra Reading |QID|11900|QO|Western Coldarra Reading: 1/1|N|Go northwest to find another Coldarra Geological Monitor and click it.|M|22.36,24.17|
C The Cell |QID|11943|N|Kill General Cerulean and loot the Prison Casing.|M|27.31,20.40|
N Northern Coldarra Reading |QID|11900|QO|Northern Coldarra Reading: 1/1|N|Go east to find another Coldarra Geological Monitor and click it.|M|31.31,20.29|
T The Cell |QID|11943|N|To Raelorasz.|M|33.31,34.53|
A Keristrasza |QID|11946|U|35671|N|Use your Augmented Arcane Prison to make Keristrasza appear.|M|33.1,34.11|
T Keristrasza |QID|11946|N|To Keristraza.|M|33.1,34.11|

A Bait and Switch |QID|11951|N|From Keristrasza.|M|33.1,34.11|
C Bait and Switch |QID|11951|N|Loot the purple crystals all around the Nexus.|M|28.36,32.54|
C Nuts for Berries |QID|11912|N|Pick up Frostberries.|US|
C Secrets of the Ancients |QID|11910|N|Kill Glacial Ancients and Magic-bound Ancients.|US|
C Basic Training |QID|11918|N|Kill Coldarra Spellweavers.|US|
T Basic Training |QID|11918|N|To Raelorasz.|M|33.31,34.53|
A Hatching a Plan |QID|11936|N|From Raelorasz.|M|33.31,34.53|
T Nuts for Berries |QID|11912|N|To Librarian Serrah.|M|33.48,34.38|
A Keep the Secret Safe |QID|11914|N|From Librarian Serrah.|M|33.48,34.38|
T Secrets of the Ancients |QID|11910|N|To Archmage Berinand.|M|32.95,34.40|
T Bait and Switch |QID|11951|U|35671|N|Use your Augmented Arcane Prison.|
A Saragosa's End |QID|11957|N|From Keristrasza.|
C Saragosa's End |QID|11957|U|35690|N|Talk to Keristrasza tell her you're prepared. Use the Arcane Power Focus to bring out Saragosa, then kill her and loot Saragosa's Corpse.|
T Saragosa's End |QID|11957|U|35671|N|Wait until the cooldown is up then use your Augmented Arcane Prison.|
A Mustering the Reds |QID|11967|N|From Keristrasza.|

R Transitus Shield |QID|11967|N|Talk to Keristrasza for a teleport back to the Transitus Shield.|
T Mustering the Reds |QID|11967|N|To Raelorasz.|M|33.31,34.53|
A Springing the Trap |QID|11969|N|From Raelorasz.|M|33.31,34.53|
C Keep the Secret Safe |QID|11914|N|Kill Arcane Serpents near the Nexus.|Z|Borean Tundra|M|27.8,24.2|S|
K Coldarra Wyrmkins |QID|11936|L|35586 5|N|Kill Coldarra Wyrmkins until you get 5 Frozen Axes.|M|23.60,34.32|S|
C Reading the Meters |QID|11900|N|Go down to the Nexus to find another Coldarra Geological Monitor and click it.|M|28.26,28.47|
K Coldarra Wyrmkins |QID|11936|L|35586 5|N|Kill Coldarra Wyrmkins until you get 5 Frozen Axes.|M|23.60,34.32|US|
C Hatching a Plan |QID|11936|N|Click on the Blue Dragon Eggs near the Nexus.|M|27.8,24.2|
C Keep the Secret Safe |QID|11914|N|Kill Arcane Serpents near the Nexus.|M|27.8,24.2|US|
C Springing the Trap |QID|11969|U|44950|N|Get out of the ravine and go northeast to the Signal Fire at the Nexus's Northwestern Entrance. Dismount, then use Raelorasz's Spark. Stay close to Keristrasza until she takes off and run close to her when she lands.|M|25.41,21.81|
T Keep the Secret Safe |QID|11914|N|To Librarian Serrah.|M|33.48,34.38|
T Hatching a Plan |QID|11936|N|To Raelorasz.|M|33.31,34.53|

A Drake Hunt |QID|11919|N|From Raelorasz.|M|33.31,34.53|
T Springing the Trap |QID|11969|N|To Raelorasz.|M|33.31,34.53|
T Reading the Meters |QID|11900|N|To Archmage Berinand.|M|32.95,34.40|
C Drake Hunt |QID|11919|U|35506|N|Find a Nexus Drake Hatchling flying around to the west of the Nexus. Use Raelorasz's Spear on it and tank it until it becomes friendly (about 10 seconds). Ride back to the Transitus Shield quickly, you have 3 minutes to turn this quest in.|M|23,26|
T Drake Hunt |QID|11919|N|To Raelorasz.|M|33.31,34.53|
A Cracking the Code |QID|11931|N|From Raelorasz.|M|33.31,34.53|
N Drake Hunt |QID|12117|N|Drake Hunt is now a repeatable daily quest. You may pick it up again and if you wish and do it again after the next step.|
C Cracking the Code |QID|11931|N|Kill Inquisitor Caleras to the north and loot the Azure Codex. Kill Coldarra Spellbinders around him until you get 3 Shimmering Runes.|M|32.77,27.84|
T Cracking the Code |QID|11931|N|To Raelorasz.|M|33.31,34.53|

F Amber Ledge |QID|11704|N|Fly to Amber Ledge or take a free teleport from Librarian Tiare.|M|33.28,34.14|
C Plan B |QID|11658|N|Grab the Warsong Banner here and loot 10 Warsong Outfits from the bodies around the area.|M|49.57,26.55|
T King Mrgl-Mrgl |QID|11704|N|Go north to the road, then follow it east to Winterfin Retreat.|M|43.50,13.97|
A Learning to Communicate |QID|11571|N|From King Mrgl-Mrgl.|M|43.50,13.97|
C Learning to Communicate |QID|11571|U|34598|N|Kill Scalder at the bottom of the sea. Target his corpse and use the conch. Scalder is immune to frost.|M|42.53,15.85|
T Learning to Communicate |QID|11571|N|To King Mrgl-Mrgl.|M|43.50,13.97|
A Winterfin Commerce |QID|11559|N|From King Mrgl-Mrgl.|M|43.50,13.97|
C Winterfin Commerce |QID|11559|N|Swim across the water and loot 5 Winterfin Clams off the ground. The murlocs here can also drop them.|M|41.55,17.35|
T Winterfin Commerce |QID|11559|N|To Ahlurglgr.|M|43.04,13.81|
A Oh Noes, the Tadpoles! |QID|11560|N|From King Mrgl-Mrgl.|M|43.50,13.97|
A Them! |QID|11561|N|From Brglmurgl.|M|42.83,13.66|
C Oh Noes, the Tadpoles! |QID|11560|N|Free Murloc Tadpoles by clicking on the cages.|M|40.6,17.5|S|
C Them! |QID|11561|N|Kill Winterfin murlocs.|S|
C Monitoring the Rift: Winterfin Cavern |QID|12728|U|34669|N|Use the Arcanometer once inside the cave.|M|39.97,20.14|

A Keymaster Urmgrgl |QID|11569|N|Get this quest from Glrglrglr.|M|37.8,23.2|
C Keymaster Urmgrgl |QID|11569|N|Go downstairs and kill Urmgrgl for his key.|M|38.75,22.71|
T Keymaster Urmgrgl |QID|11569|N|To Glrglrglr.|M|37.8,23.2|
A Escape from the Winterfin Caverns |QID|11570|N|From Lurgglbr.|M|37.8,23.0|
C Escape from the Winterfin Caverns |QID|11570|N|Escort Lurgglbr outside.|M|38.27,21.94;39.72,21.51;39.50,18.46;40.11,16.70;40.90,16.89;41.36,16.33|
C Oh Noes, the Tadpoles! |QID|11560|N|Free Murloc Tadpoles by clicking on the cages.|M|40.6,17.5|US|
C Them! |QID|11561|N|Kill Winterfin murlocs.|US|
T Oh Noes, the Tadpoles! |QID|11560|N|To King Mrgl-Mrgl.|M|43.50,13.97|
A I'm Being Blackmailed By My Cleaner |QID|11562|N|From King Mrgl-Mrgl.|M|43.50,13.97|
T Escape from the Winterfin Caverns |QID|11570|N|To King Mrgl-Mrgl.|M|43.50,13.97|
T Them! |QID|11561|N|To Brglmurgl.|M|42.83,13.66|
T I'm Being Blackmailed By My Cleaner |QID|11562|N|To Mrmrglmr.|M|42.00,12.77|

A Grmmurggll Mrllggrl Glrggl!!! |QID|11563|N|From Mrmrglmr.|M|42.00,12.77|
A Succulent Orca Stew |QID|11564|N|From Cleaver Bmurglbrm.|M|42.03,13.15|
C Succulent Orca Stew |QID|11564|N|Kill Glimmer Bay Orcas for their Succulent Orca Blubber.|M|40.3,12.4|S|
C Grmmurggll Mrllggrl Glrggl!!! |QID|11563|N|Kill Glrggl, a large orca that swims around the iceberg to the northwest, and loot his head.|M|39.34,7.96|T|Glrggl|
C Succulent Orca Stew |QID|11564|N|Kill Glimmer Bay Orcas for their Succulent Orca Blubber.|M|40.3,12.4|US|
T Grmmurggll Mrllggrl Glrggl!!! |QID|11563|N|To Mrmrglmr.|M|42.00,12.77|
A The Spare Suit |QID|11565|N|From Mrmrglmr.|M|42.00,12.77|
T Succulent Orca Stew |QID|11564|N|To Cleaver Bmurglbrm.|M|42.03,13.15|
T The Spare Suit |QID|11565|N|To King Mrgl-Mrgl.|M|43.50,13.97|
A Surrender... Not! |QID|11566|N|From King Mrgl-Mrgl.|M|43.50,13.97|
C Surrender... Not! |QID|11566|U|34620|N|Swim back to Winterfin Village and use King Mrgl-Mrgl's Spare Suit. Follow the right wall inside the cave until you reach Claximus. Kill him and loot his claw, then put the suit back on.|M|37.72,27.07|
T Surrender... Not! |QID|11566|U|34620|N|Leave the cave and get back to King Mrgl-Mrgl at the Winterfin Retreat.|M|43.50,13.97|
T Plan B |QID|11658|N|Ride back to Crafty Wobblesprocket who wanders a bit at the Fizzcrank Airstrip.|M|57.58,18.71;58.18,18.34|

A It Was The Orcs, Honest! |QID|11670|N|From Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
U Use Crafty's Sack |QID|11670|L|34869|N|Loot the items from Crafty's Sack.|U|34871|
C It Was The Orcs, Honest! |QID|11670|U|34869|N|Go north to the cave we jumped into earlier. Use the Orc Disguise, then jump down and try to land in the water. Kill Magmothregar and plant the Warsong Banner in his corpse.|M|55.29,12.11|
H Fizzcrank Airstrip |QID|11670|N|Hearthstone back to Fizzcrank.|M|57.07,18.76|
T It Was The Orcs, Honest! |QID|11670|N|To Crafty Wobblesprocket who wanders a bit.|M|57.58,18.71;58.18,18.34|
F Amber Ledge |QID|12728|N|Fly to Amber Ledge.|M|56.58,20|
T Monitoring the Rift: Winterfin Cavern |QID|12728|N|To Librarian Garren.|M|44.98,33.38|
N Done with Borean Tundra, but... |N|That concludes Borean Tundra, but if you plan on continuing with Jame's guide, follow the next few steps right to the end to get to Valgarde Keep.|
F Unu'pe |QID|12117|N|Fly to Unu'pe.|M|45.26,34.42|
b Moa'ki Harbor |QID|12117|N|Take the turtle to Moa'ki Harbor in Dragonblight.|M|78.91,53.67|
f Moa'ki Harbor |QID|12117|N|Get the flight path at Moa'ki Harbor.|Z|Dragonblight|M|48.51,74.39|
T Travel to Moa'ki Harbor |QID|12117|N|To Ko'nani|Z|Dragonblight|M|48.01,74.88|
b Kamagua |QID|11228|N|Use the pier on your left-hand side to travel to Kamagua.|Z|Dragonblight|M|49.63,78.42|
f Kamagua |QID|11228|N|Get the flight path at Kamagua.|Z|Howling Fjord|M|24.66,57.78|
R Valgarde |QID|11228|N|Take the Ancient Lift, then follow the waypoint arrows.|Z|Howling Fjord|M|24.70,62.27;44.3,59.1;46,50;51,44.67;52.3,47.8;59.6,61.0|

]]
end)
