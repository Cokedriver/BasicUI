
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_redridge_mountains
-- Date: 2011-08-19 12:59
-- Who: Fluclo
-- Log: Flagging Saving Foreman Oslow as non-combat

-- URL: http://wow-pro.com/node/3215/revisions/24738/view
-- Date: 2011-08-19 12:48
-- Who: Fluclo
-- Log: Tagged Like a Fart in the Wind as a Non-Combat, also repositioned sticky (should collect before finishing the gnolls)

-- URL: http://wow-pro.com/node/3215/revisions/24736/view
-- Date: 2011-08-16 21:41
-- Who: Fluclo
-- Log: Added Level info for guide

-- URL: http://wow-pro.com/node/3215/revisions/24444/view
-- Date: 2011-05-28 21:08
-- Who: Crackerhead22
-- Log: Added some notes, removed unneeded zone tags, fixed one or two cords.

-- URL: http://wow-pro.com/node/3215/revisions/24079/view
-- Date: 2011-01-30 19:13
-- Who: Ludovicus Maior
-- Log: Fixed RegisterGuide line to match GIT.

-- URL: http://wow-pro.com/node/3215/revisions/23593/view
-- Date: 2010-12-05 04:50
-- Who: Crackerhead22
-- Log: Added spaces, fixed date.

-- URL: http://wow-pro.com/node/3215/revisions/23592/view
-- Date: 2010-12-05 04:46
-- Who: Crackerhead22
-- Log: Finished source code.

-- URL: http://wow-pro.com/node/3215/revisions/23300/view
-- Date: 2010-12-03 07:27
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3215/revisions/23299/view
-- Date: 2010-12-03 07:27
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide("KurRed1520", "Redridge Mountains", "Kurich", "15", "20", "TwiDus2025", "Alliance", function()
return [[

L Level 14 |QID|13518|LVL|8|N|This guide requires a minimum level of 14 to do.|

R Redridge Mountains|QID|26365|M|96.68,72.33|Z|Elwynn Forest|N|Head to Redridge Mountains, to the east of Elwynn Forest.  You can fly to Eastvale Logging Camp, then run east along the road.\n\nThe two breadcrumb quests to this zone are Threat to the Kingdom from Marshal Gryan Stoutmantle in Sentinel Hill for those who quested in Westfall, and Hero's Call: Redridge Mountains! available from both Hero's Callboards in Stormwind City, as well as from King Varian Wrynn. |

A Wanted: Redridge Gnolls|QID|26504|M|16.15,64.54|N|From the Wanted Poster board.|
A Franks and Beans|QID|26506|M|15.67,65.28|N|From Darcy Parker.|
T Hero's Call: Redridge Mountains!|QID|26363|M|15.32,64.86|N|To Watch Captain Parker.|O|
T Hero's Call: Redridge Mountains!|QID|26365|M|15.32,64.86|N|To Watch Captain Parker.|O|
A Still Assessing the Threat|QID|26503|M|15.32,64.86|N|From Watch Captain Parker.|
C Wanted: Redridge Gnolls|QID|26504|S|M|28.21,73.94|N|Kill any Gnoll you come across.|
C Franks and Beans|QID|26506|S|M|20.46,64.70|N|Kill any Tarantulas, Condors, and Gortusks you see, to get their respective body part.|
l Gnoll Battle Plans|QID|26503|L|58887 |M|16.19,55.25|N|Pick up the Gnoll Battle Plans here.|
l Gnoll Orders|QID|26503|L|58888 |M|28.02,74.72|N|Pick up the Gnoll Orders at this waypoint.|
C Still Assessing the Threat|QID|26503|M|30.57,62.7|N|Pick up the Gnoll Strategy Guide here.|
C Wanted: Redridge Gnolls|QID|26504|US|M|28.21,73.94|N|Kill any Gnoll you come across.|
C Franks and Beans|QID|26506|US|M|20.46,64.70|N|Kill any Tarantulas, Condors, and Gortusks you see, to get their respective body part.|
T Franks and Beans|QID|26506|M|15.71,65.27|N|To Darcy Parker.|
T Still Assessing the Threat|QID|26503|M|15.31,64.82|N|To Watch Captain Parker.|
A Parker's Report|QID|26505|M|15.31,64.82|N|From Watch Captain Parker.|
T Wanted: Redridge Gnolls|QID|26504|M|15.31,64.82|N|To Watch Captain Parker.|

f Lakeshire|M|29.48,53.77|N|At Ariena Stormfeather.|QID|26761|
T Threat To The Kingdom|QID|26761|M|28.91,41.11|N|To Magistrate Solomon.|O|
T Parker's Report|QID|26505|M|28.78,41.15|N|To Magistrate Solomon.|
A We Must Prepare!|QID|26510|M|28.78,41.15|N|From Magistrate Solomon.|
A Lake Everstill Clean Up|QID|26511|M|28.61,40.99|N|From Bailiff Conacher.|
h Lakeshire|QID|26511|M|26.38,41.54|N|At Innkeeper Brianna.|QID|26509|
A An Unwelcome Guest|QID|26509|M|22.03,42.79|N|From Martie Jainrose.|
C An Unwelcome Guest|QID|26509|M|17.59,44.80|N|Find and kill Bellygrub. Loot his tusk, once he is dead.|
T An Unwelcome Guest|QID|26509|M|21.89,42.82|N|To Martie Jainrose.|
r Sell junk, Repair/Restock|QID|26509|M|29.57,42.98|N|At Dorin Songblade.|
A Nida's Necklace|QID|26508|M|28.35,48.72|N|From Shawn.|
l Nida's Necklace|QID|26508|L|10958 |M|20.43,47.21;35.6,49.6|N|Jump in the water and look for Glinting Mud. It can be anywhere within the 2 waypoints.  Head to the west first, if not there then head east.|
C Lake Everstill Clean Up|QID|26511|S|M|37.46,43.48|N|Kill any murloc you see.|
l We Must Prepare!|QID|26510|L|58894 |M|37.82,42.14|N|Pick up the Gnomecorder on the small isle.|
C Lake Everstill Clean Up|QID|26511|US|M|37.46,43.48|N|Kill any murloc you see.|
T Nida's Necklace|QID|26508|M|28.30,48.73|N|To Nida.|
T Lake Everstill Clean Up|QID|26511|M|28.62,41.01|N|To Bailiff Conacher.|
T We Must Prepare!|QID|26510|M|28.74,41.10|N|To Magistrate Solomon.|
A Tuning the Gnomecorder|QID|26512|M|28.74,41.10|N|From Magistrate Solomon.|
A Like a Fart in the Wind|QID|26513|M|31.73,44.80|N|From Marshal Marris.|
C Tuning the Gnomecorder|QID|26512|NC|M|32.36,39.53|N|Head to the Lakeshire Graveyard.|
T Tuning the Gnomecorder|QID|26512|M|32.31,39.51|N|(UI Alert)|

A Canyon Romp|QID|26514|M|32.31,39.51|N|(UI Alert)|
C Like a Fart in the Wind|QID|26513|S|M|32.27,25.10|N|Look for the sparkling supply crates, grab them when you see them.|NC|
C Canyon Romp|QID|26514|M|32.14,25.18|N|Kill and loot any Gnoll you see. Be careful of the elite Etin wandering around.|S|
l Dirt-Stained Scroll|QID|26519|L|58898|M|32.14,25.18|N|Kill and loot Gnolls until this drops.|
A He Who Controls the Ettins|QID|26519|U|58898|M|33.92,24.55|N|Accept this quest from the Dirt-Stained Scroll.|
C Like a Fart in the Wind|QID|26513|US|M|32.27,25.10|N|Look for the sparkling supply crates, grab them when you see them.|NC|
C Canyon Romp|QID|26514|M|32.14,25.18|N|Kill and loot any Gnoll you see.|US|
T Canyon Romp|QID|26514|M|32.57,25.13|N|(UI Alert)|
A They've Wised Up...|QID|26544|M|32.57,25.13|N|(UI Alert)|
l They've Wised Up...|QID|26544|L|58936 |M|20.22,23.77|N|Head inside of Rethbane Caverns and look for a Blackrock Overseer. Kill him to get the Blackrock Missive.|
T They've Wised Up...|QID|26544|M|20.22,23.77|N|(UI Alert)|
A Yowler Must Die!|QID|26545|M|20.22,23.77|N|(UI Alert)|
C He Who Controls the Ettins|QID|26519|M|18.05,18.48|N|Find and kill Ardo Dirtpaw.|
T He Who Controls the Ettins|QID|26519|M|17.93,18.53|N|Turn it in at the orb.|
A Saving Foreman Oslow|QID|26520|M|17.93,18.53|N|From the Ettin Control Panel.|
K Yowler Must Die!|QID|26545|U|58895|L|58937 |M|27.45,22.09|N|Ok, time to grab some help, go around looking for a Canyon Enttin. When you see one, use the orb and quickly get it down to around 50% health. Find Yowler, kill him and loot the plans.|
C Saving Foreman Oslow|QID|26520|U|58895|M|31.75,44.41|N|Run to the boulder at Lakeshire Bridge.  When you get near the boulder use the orb again to get the rock off Oslow.|NC|

T Like a Fart in the Wind|QID|26513|M|31.80,44.76|N|To Marshal Marris.|
T Yowler Must Die!|QID|26545|M|28.76,41.12|N|To Magistrate Solomon.|
T Saving Foreman Oslow|QID|26520|M|28.76,41.12|N|To Magistrate Solomon.|
A John J. Keeshan|QID|26567|M|28.76,40.90|N|From Colonel Troteman.|
T John J. Keeshan|QID|26567|M|26.20,39.86|N|Head to the basement of the Inn to find John J. Keeshan.|
A This Ain't My War|QID|26568|M|26.20,39.90|N|From John J. Keeshan.|
T This Ain't My War|QID|26568|M|28.57,40.84|N|To Colonel Troteman.|
A Weapons of War|QID|26571|M|28.57,40.84|N|From Colonel Troteman.|
A In Search of Bravo Company|QID|26586|M|28.58,40.90|N|From Colonel Troteman.|
A Surveying Equipment|QID|26569|M|29.63,44.41|N|From Foreman Oslow.|
A Render's Army|QID|26570|M|29.63,44.41|N|From Marshal Marris.|
C Render's Army|QID|26570|S|M|29.35,10.76|N|Kill any and all orcs for this quest.  Except for the elites.|
T In Search of Bravo Company|QID|26586|M|47.42,41.68|N|To Messner.|
A Breaking Out is Hard to Do|QID|26587|M|47.42,41.68|N|From Messner.|
C Weapons of War|QID|26571|M|50.82,41.45|N|Kill Homurk for the knife, and Murdunk for the bow.|
T Weapons of War|QID|26571|M|51.45,41.30|N|(UI Alert)|
A His Heart Must Be In It|QID|26573|M|51.45,41.30|N|(UI Alert)|
C Breaking Out is Hard to Do|QID|26587|M|49.06,37.83|N|Be careful not to be seen by the Worg Captain, go into the center of the sleeping Worgs and loot the key from the stump.|
T Breaking Out is Hard to Do|QID|26587|M|47.57,41.81|N|To Messner.|
A Jorgensen|QID|26560|M|47.60,41.83|N|From Messner.|
C Surveying Equipment|QID|26569|M|32.46,9.82|N|Kill and loot Blackrock Trackers.|S|
C Jorgensen|QID|26560|L|58969 |M|43.56,11.03|N|Kill Utroka the Keymistress to get Jorgensen's Cage Key.|
T Jorgensen|QID|26560|M|33.62,11.75|N|To Jorgensen.|
A Krakauer|QID|26561|M|33.63,11.37|N|From Jorgensen.|
C His Heart Must Be In It|QID|26573|M|26.67,10.65|N|Enter the cave, and then at the split turn right, loot the Blackrock Coffer.|
C Krakauer|QID|26561|M|26.41,10.40|N|Kill Ritualist Tarak.|
T Krakauer|QID|26561|M|26.03,10.45|N|To Krakauer.|
A And Last But Not Least... Danforth|QID|26562|M|26.08,10.48|N|From Krakauer.|
C And Last But Not Least... Danforth|QID|26562|M|28.13,18.25|N|Kill Overlord Barbarius and recover the Blackrock Lever Key. Use the Blackrock Lever Key to free Danforth. |
T And Last But Not Least... Danforth|QID|26562|M|28.21,17.11|N|To Danforth.|
A Return of the Bravo Company|QID|26563|M|28.07,17.29|N|From Danforth.|
C Surveying Equipment|QID|26569|M|32.46,9.82|N|Kill and loot Blackrock Trackers.|US|
C Render's Army|QID|26570|US|M|29.35,10.76|N|Kill any and all orcs for this quest. Except for the elites.|

H Lakeshire|QID|26563|N|Hearth back to Lakeshire or run if it is on cooldown.|
T His Heart Must Be In It|QID|26573|M|28.51,40.85|N|To Colonel Troteman.|
T Return of the Bravo Company|QID|26563|M|28.51,40.85|N|To Colonel Troteman.|
A They Drew First Blood|QID|26607|M|28.51,40.85|N|From Colonel Troteman.|
T Surveying Equipment|QID|26569|M|29.65,44.38|N|To Foreman Oslow.|
T Render's Army|QID|26570|M|29.65,44.38|N|To Marshal Marris.|
r Repair/Restock|QID|26607|M|29.61,43.00|N|At Dorin Songblade.|
T They Drew First Blood|QID|26607|M|26.29,39.90|N|Head to the basement of the inn to John J. Keeshan.|
A It's Never Over|QID|26616|M|26.29,39.90|N|From John J. Keeshan.|
C It's Never Over|QID|26616|NC|M|34.25,45.6|N|Click on the boat to head to Camp Everstill.|
f Camp Everstill|QID|26616|M|52.87,54.51|N|At Arlen Marsters.|

T It's Never Over|QID|26616|M|52.48,55.19|N|To John J. Keeshan.|
A Point of Contact: Brubaker|QID|26639|M|52.48,55.19|N|From John J. Keeshan.|
A Hunting the Hunters|QID|26638|M|52.46,55.38|N|From Danforth.|
A Bravo Company Field Kit: Chloroform|QID|26637|M|52.49,55.47|N|From Messner.|
A Bravo Company Field Kit: Camouflage|QID|26636|M|52.49,55.47|N|From Krakauer.|
l Bravo Company Field Kit: Chloroform|QID|26637|L|59156 8|M|42.75,53.87|N|Enter the lake and kill any Muckdweller you see.  Don't forget to surface now and then, and be careful of Ol' Gummers.|
C Hunting the Hunters|QID|26638|S|M|52.95,67.78|N|Kill any Blackrock Hunter you see. They are stealthed.|
C Bravo Company Field Kit: Camouflage|QID|26636|M|50.40,65.50|N|The poop is everywhere, look for the sparkling piles. The leaves are under trees.|
C Hunting the Hunters|QID|26638|US|M|52.95,67.78|N|Kill any Blackrock Hunter you see. They are stealthed.|
T Point of Contact: Brubaker|QID|26639|M|53.01,67.78|N|To Brubaker.|
A Unspeakable Atrocities|QID|26640|M|53.01,67.78|N|From Brubaker.|
T Bravo Company Field Kit: Camouflage|QID|26636|M|52.47,55.45|N|To Krakauer.|
T Bravo Company Field Kit: Chloroform|QID|26637|M|52.47,55.45|N|To Messner.|
T Hunting the Hunters|QID|26638|M|52.47,55.45|N|To Danforth.|
T Unspeakable Atrocities|QID|26640|M|52.47,55.45|N|To John J. Keeshan.|
A Prisoners of War|QID|26646|M|52.50,55.48|N|From John J. Keeshan.|
l Blackrock Holding Pen Key|QID|26646|U|60384|L|59261 |M|69.4,76.53|N|Use the field kit. Then use ability #1 (Camoflauge) when you get near the camp. Use #2 (Distraction) to get past guards (can backfire somewhat). Use #3 (Chloroform) on the orc where the key is.|
C Prisoners of War|QID|26646|U|60384|M|69.40,58.59|N|If the orc is about to wake up, use ability #3 again. Use #2 to get out of the cave. Then head to the waypoint, click on one of the cages to free the people.|
T Prisoners of War|QID|26646|M|69.46,58.62|N|(UI Alert)|
A To Win a War, You Gotta Become War|QID|26651|M|69.46,58.62|N|(UI Alert)|
C To Win a War, You Gotta Become War|QID|26651|U|60385|QO|Seaforium Planted at Blackrock Tower: 1/1|M|66.4,71.43|N|Re-apply the Camouflage if it's low. Head to the waypoint and use #2 to get in the tower. Use the Chloroform to get to the top. Once inside at the top use ability #4.|
C To Win a War, You Gotta Become War|QID|26651|U|60385|M|63.86,70.34|N|Same deal as the Tower. Use a distraction to get in and plant a charge,|

R Shalewind Canyon|QID|26651|U|60385|M|72.4,64.3;77.26,65.86|N|Head to Shalewind Canyon. Use your field kit abilities to get there.|
T To Win a War, You Gotta Become War|QID|26651|M|77.60,65.56|N|To John J. Keeshan.|
A Detonation|QID|26668|M|77.60,65.56|N|From John J. Keeshan.|
C Detonation|QID|26668|NC|M|77.60,65.61|N|Enjoy the brief cut scene.|
T Detonation|QID|26668|M|77.60,65.61|N|To John J. Keeshan.|
f Shalewind Canyon|QID|26668|M|77.91,65.85|N|At Nora Baldwin.|
A The Dark Tower|QID|26693|M|77.57,65.57|N|From John J. Keeshan.|
A Shadowhide Extinction|QID|26692|M|77.59,65.54|N|From Danforth.|
r Repair/Restock|QID|26692|M|78.71,63.46|N|At Clyde Ranthal.|
C Shadowhide Extinction|QID|26692|S|N|Kill any Gnoll you come across.|
C The Dark Tower|QID|26693|M|67.58,29.61|N|Enter the cave and kill General Fangore. Loot his corpse to get the Key of Ilgalar.|
T The Dark Tower|QID|26693|M|67.55,29.54|N|(UI Alert)|
A The Grand Magus Doane|QID|26694|M|67.55,29.54|N|(UI Alert)|
C The Grand Magus Doane|QID|26694|U|59522|M|71.30,45.17|N|Click on the Ward of Ilgalar to enter the tower, then head to the top and kick Grand Magus Doane's butt.|
C Shadowhide Extinction|QID|26692|US|M|70.24,39.53|N|Kill any Gnoll you come across.|
T Shadowhide Extinction|QID|26692|M|77.79,65.16|N|To Danforth.|
T The Grand Magus Doane|QID|26694|M|77.77,65.23|N|To John J. Keeshan.|

A AHHHHHHHHHHHH! AHHHHHHHHH!!!|QID|26708|M|77.29,65.80|N|From Colonel Troteman.|
C AHHHHHHHHHHHH! AHHHHHHHHH!!!|QID|26708|M|60.76,36.57|N|Hop in the tank and head towared Keeshan's post. You should have all 200 when you get there.|
T AHHHHHHHHHHHH! AHHHHHHHHH!!!|QID|26708|M|60.76,36.57|N|To Colonel Troteman.|
A Showdown at Stonewatch|QID|26713|M|60.76,36.57|N|From Colonel Troteman.|
C Showdown at Stonewatch|QID|26713|QO|Tharil'zun slain: 1/1|M|60.29,47.27|N|First up is Tharil'zun.|
C Showdown at Stonewatch|QID|26713|M|58.44,55.60|N|Head to the waypoint to kill Gath'Ilzogg.|
T Showdown at Stonewatch|QID|26713|M|58.44,55.53|N|(UI Alert)|
A Darkblaze, Brood of the Worldbreaker|QID|26714|M|58.44,55.53|N|(UI Alert)|
C Darkblaze, Brood of the Worldbreaker|QID|26714|M|58.89,55.27|N|Use the horn tha should be next to Gath'Ilzogg's corpse. Try to stay on Darkblaze's side, and just attack as hard as you can. You can not pull it off of Keeshan.|
T Darkblaze, Brood of the Worldbreaker|QID|26714|M|60.55,36.46|N|To Colonel Troteman.|
A Triumphant Return|QID|26726|M|60.55,36.46|N|From Colonel Troteman.|
H Lakeshire|QID|26726|N|Hearth back to Lakeshire Inn, or run if your hearth is on cooldown.|
T Triumphant Return|QID|26726|M|28.79,41.11|N|To Magistrate Solomon.|
F Stormwind City|M|21.78,57.70|N|Fly to Stormwind visit your trainers, and AH.|
N Close this|N|step when you are ready to go to the next guide.
]]

end)
