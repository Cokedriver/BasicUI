
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_burning_steppes_alliance
-- Date: 2011-06-11 20:38
-- Who: Crackerhead22
-- Log: Removed Hero's Call, fixed a couple of cords, added 1 or 2 sticky steps.

-- URL: http://wow-pro.com/node/3265/revisions/24482/view
-- Date: 2011-06-01 11:32
-- Who: Fluclo
-- Log: Added additional instruction notes for A Perfect Costume

-- URL: http://wow-pro.com/node/3265/revisions/24304/view
-- Date: 2011-04-29 14:48
-- Who: Ludovicus Maior
-- Log: Line 121 for step C has 1 M coords, Line 123 for step C has 1 M coords, Line 127 for step C has 1 M coords, Line 179 for step K has 3 M coords.

-- URL: http://wow-pro.com/node/3265/revisions/23930/view
-- Date: 2011-01-04 20:09
-- Who: Crackerhead22
-- Log: Added missing cords.

-- URL: http://wow-pro.com/node/3265/revisions/23928/view
-- Date: 2011-01-04 20:07
-- Who: Crackerhead22
-- Log: Fixed several notes, steps, sticky steps.

-- URL: http://wow-pro.com/node/3265/revisions/23591/view
-- Date: 2010-12-05 04:41
-- Who: Crackerhead22
-- Log: Fixed spelling error which would have caused a step to not Auto-complete.

-- URL: http://wow-pro.com/node/3265/revisions/23412/view
-- Date: 2010-12-03 11:59
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3265/revisions/23411/view
-- Date: 2010-12-03 11:58
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('CraBur5052', 'Burning Steppes', 'Crackerhead22', '50', '52', 'CraSwa5254', 'Alliance', function()
return [[

H Iron Summit|QID|28514|N|Hearth back to Iron Summit, or fly if your hearth is on cooldown.|
R Blackrock Mountain|QID|28514|M|33.49,74.91|Z|Searing Gorge|N|Run to the waypoint.|
R Burning Steppes|QID|28514|M|19.61,24.26;17.42,29.28;19.74,34.51|N|Run through Blackrock Mountain to Burning Steppes.|
f Flamestar Post|M|17.82,52.63|N|At Hans Oreflight.|QID|28514|
T Mouton Flamestar|QID|28514|M|17.12,51.32|N|To Mouton Flamestar.|
A Done Nothing Wrong|QID|28172|M|17.12,51.32|N|From Mouton Flamestar.|
T Hero's Call: Burning Steppes!|QID|28666|M|17.4,52.5|N|To John J. Keeshan.|O|
A Burning Vengeance|QID|28416;28174|M|17.31,51.98|N|From John J. Keeshan.|

C Done Nothing Wrong|QID|28172|S|M|23.13,60.14|N|Free a Red, Green, Blue and Bronze Fettered Whelping.|
C Burning Vengeance|QID|28174;28416|M|17.00,63.80|N|Kill Blackrock Whelpers and Flamescale Broodlings.|
C Done Nothing Wrong|QID|28172|US|M|23.13,60.14|N|Free a Red, Green, Blue and Bronze Fettered Whelping.|
T Burning Vengeance|QID|28174;28416|M|17.34,52.18|N|To John J. Keeshan.|
A Stocking Up|QID|28177|M|17.34,52.18|N|From John J. Keeshan.|
A A Future Project|QID|28178|M|17.34,52.18|N|From John J. Keeshan.|
A Mud Hunter|QID|28179|M|17.25,51.89|N|From John J. Keeshan.|
T Done Nothing Wrong|QID|28172|M|17.04,51.52|N|To Mouton Flamestar.|

C A Future Project|QID|28178|S|M|9.51,52.65|N|Kill the worgs and loot them.|
C Stocking Up|QID|28177|M|11.59,45.41|N|Kill scorpions and loot them.|S|
C Mud Hunter|QID|28179|M|18.39,42.83|N|Go around the edge of the lava to find the dirt mounds. Warning: The Obsidian Elementals have a 20% spell reflect (which can feel like 100% at times, so caster beware).|
C A Future Project|QID|28178|US|M|9.51,52.65|N|Kill the worgs and loot them.|
C Stocking Up|QID|28177|M|11.59,45.41|N|Kill scorpions and loot them.|US|
T Stocking Up|QID|28177|M|17.36,51.96|N|To John J. Keeshan.|
T A Future Project|QID|28178|M|17.36,51.96|N|To John J. Keeshan.|
T Mud Hunter|QID|28179|M|17.36,51.96|N|To John J. Keeshan.|
A The Sand, the Cider, and the Orb|QID|28180|M|17.36,51.96|N|From John J. Keeshan.|
T The Sand, the Cider, and the Orb|QID|28180|M|8.29,35.91|N|To Gorzeeki Wildeyes.|

A Warlocks Have the Neatest Stuff|QID|28181|M|8.29,35.91|N|From Gorzeeki Wildeyes.|
A Shadow Boxing|QID|28182|M|8.29,35.91|N|From Gorzeeki Wildeyes.|
C Warlocks Have the Neatest Stuff|QID|28181|M|5.25,31.15|N|The Blackrock Warlocks have the orb. Kill them until one drops.|S|
C Shadow Boxing|QID|28182|M|9.85,29.74|N|Kill Ner'gosh the Shadow.|
C Warlocks Have the Neatest Stuff|QID|28181|M|5.25,31.15|N|The Blackrock Warlocks have the orb. Kill them until one drops. The other stuff needed is by the waypoint.|US|
T Warlocks Have the Neatest Stuff|QID|28181|M|8.37,35.77|N|To Gorzeeki Wildeyes.|
T Shadow Boxing|QID|28182|M|8.37,35.77|N|To Gorzeeki Wildeyes.|
A Return to Keeshan|QID|28183|M|8.33,35.89|N|From Gorzeeki Wildeyes.|
T Return to Keeshan|QID|28183|M|17.33,51.86|N|To John J. Keeshan.|
A Chiselgrip, the Heart of the Steppes|QID|28184|M|17.33,51.86|N|From John J. Keeshan.|
C Chiselgrip, the Heart of the Steppes|QID|28184|M|37.35,54.33|N|Kill 15 Blackrock mobs.|
T Chiselgrip, the Heart of the Steppes|QID|28184|M|46.69,44.24|N|To Stebben Oreknuckle.|

A Prove Yer Allegiance|QID|28225|M|46.69,44.24|N|From Stebben Oreknuckle.|
A Scrapped Golems|QID|28226|M|46.69,44.24|N|From Stebben Oreknuckle.|
f Chiselgrip|QID|28254|M|46.17,41.97|N|At Grimly Singefeather.|
A A Needle in a Hellhole|QID|28254|M|46.37,45.82|N|From John J. Keeshan.|
T A Needle in a Hellhole|QID|28254|M|45.45,46.11|N|To Thelaron Direneedle.|

A A Perfect Costume|QID|28203|R|Worgen,Draenei|M|45.45,46.34|N|From Thelaron Direneedle.|N|You will need 4 hides, 1 mud and 3 thread.|
A A Perfect Costume|QID|28205|R|Night Elf|M|45.45,46.34|N|From Thelaron Direneedle.|N|You will need 3 hides, 2 mud and 1 thread.|
A A Perfect Costume|QID|28202|R|Human,Dwarf|M|45.45,46.34|N|From Thelaron Direneedle.|N|You will need 2 hides, 4 mud 2 thread.|
A A Perfect Costume|QID|28204|R|Gnome|M|45.45,46.34|N|From Thelaron Direneedle.|N|You will need 1 hide, 3 mud and 4 thread.|
C A Perfect Costume|QID|28203|R|Worgen,Draenei|M|45.45,46.11|QO|Perfect Costume created: 1/1|N|You will need 4 hides, 1 mud and 3 thread. Click on the Tailor's Table, then select the correct number of hides, mud then thread. Then speak with Thelaron Direneedle to make the disguise.|
C A Perfect Costume|QID|28205|R|Night Elf|M|45.45,46.11|QO|Perfect Costume created: 1/1|N|You will need 3 hides, 2 mud and 1 thread. Click on the Tailor's Table, then select the correct number of hides, mud then thread. Then speak with Thelaron Direneedle to make the disguise.|
C A Perfect Costume|QID|28202|R|Human,Dwarf|M|45.45,46.11|QO|Perfect Costume created: 1/1|N|You will need 2 hides, 4 mud 2 thread. Click on the Tailor's Table, then select the correct number of hides, mud then thread. Then speak with Thelaron Direneedle to make the disguise.|
C A Perfect Costume|QID|28204|R|Gnome|M|45.45,46.11|QO|Perfect Costume created: 1/1|N|You will need 1 hide, 3 mud and 4 thread. Click on the Tailor's Table, then select the correct number of hides, mud then thread. Then speak with Thelaron Direneedle to make the disguise.|
T A Perfect Costume|QID|28203|R|Worgen,Draenei|M|46.40,46.03|N|At John H. Keeshan|
T A Perfect Costume|QID|28205|R|Night Elf|M|46.40,46.03|N|At John H. Keeshan|
T A Perfect Costume|QID|28202|R|Human,Dwarf|M|46.40,46.03|N|At John H. Keeshan|
T A Perfect Costume|QID|28204|R|Gnome|M|46.40,46.03|N|At John H. Keeshan|

A Into the Black Tooth Hovel|QID|28239|M|46.35,45.91|N|From John J. Keeshan.|
T Into the Black Tooth Hovel|QID|28239|U|63357|M|45.33,51.60|N|Remember to put on your disguise. To Quartermaster Kaoshin.|
A Grunt Work|QID|28245|M|45.33,51.60|N|From Quartermaster Kaoshin.|
A Strategic Cuts|QID|28246|M|45.33,51.60|N|Automatically accepted.|
C Grunt Work|QID|28245|S|U|63357|M|35.43,55.39|N|Look for boots. Sometimes spiders will spawn when you have polished a boot.|
K Voodooist Timan|QID|28246|U|63350|QO|Voodooist Timan slain: 1/1|M|45.37,52.47|N|Find him at the top of the tower, and use the barb.|
K Worgmistress Othana|QID|28246|U|63350|QO|Worgmistress Othana slain: 1/1|M|39.17,56.14|N|Find her wandering around inside the stable.|
C Strategic Cuts|QID|28246|U|63350|QO|Gorlop slain: 1/1|M|43.89,60.15;40.01,60.27|N|Gorlop wanders between these two points, you can only use the barb when he is at a lava pool.|
T Strategic Cuts|QID|28246|M|40.13,59.45|N|(UI Alert)|
C Grunt Work|QID|28245|US|U|63357|M|35.43,55.39|N|Look for boots. Sometimes spiders will spawn when you have polished a boot.|
T Grunt Work|QID|28245|M|45.29,51.57|N|To Quartermaster Kaoshin.|
A The Kodocaller's Horn|QID|28252|M|45.35,51.53|N|From Quartermaster Kaoshin.|
C The Kodocaller's Horn|QID|28252|U|63356|M|42.58,62.65|N|The kodos can attack you. If that happens knock them down to under 60% health.|
T The Kodocaller's Horn|QID|28252|M|42.69,61.85|N|(UI Alert)|
A Taking the Horn For Ourselves|QID|28253|M|42.69,61.85|N|(UI Alert)|
T Taking the Horn For Ourselves|QID|28253|M|46.33,45.79|N|To Colonel Troteman.|

C Scrapped Golems|QID|28226|S|M|50.78,38.86;43.80,37.25;56.28,37.35|N|When you kill a War Reaver, look around on the ground for an item that has spawned, it will be sparkling but still can be hard to see. It could be where you are standing or around the reaver, so use the force.|
C Prove Yer Allegiance|QID|28225|M|50.78,38.86;43.80,37.25;56.28,37.35|N|They are mainly inside and around the building ruins.|
C Scrapped Golems|QID|28226|US|M|50.78,38.86;43.80,37.25;56.28,37.35|N|When you kill a War Reaver, look around on the ground for an item that has spawned, it will be sparkling but still can be hard to see. It could be where you are standing or around the reaver, so use the force.|
T Prove Yer Allegiance|QID|28225|M|46.72,44.25|N|To Stebben Oreknuckle.|
T Scrapped Golems|QID|28226|M|46.72,44.25|N|To Stebben Oreknuckle.|
A Golem Training|QID|28227|M|46.72,44.25|N|From Stebben Oreknuckle.|
C Golem Training|QID|28227|M|44.72,43.79;46.75,46.6|N|Go into either tower, talk to a golem. You need to defeat each one 3 times.|
T Golem Training|QID|28227|M|46.72,44.23|N|To Stebben Oreknuckle.|
A General Thorg'izog|QID|28265|M|46.33,45.84|N|From John J. Keeshan.|
T General Thorg'izog|QID|28265|U|63357|M|30.79,33.76;32.49,34.99;31.53,33.57|N|To General Thorg'izog. Remember to put on your disguise, he is the middle of the building.|

A Trial by Magma|QID|28266|M|30.79,33.76|N|From General Thorg'izog.|
C Trial by Magma|QID|28266|M|30.75,33.41|N|Talk to Wyrtle Spreelthonket and choose to fight the elmental.|
T Trial by Magma|QID|28266|M|30.75,33.77|N|To General Thorg'izog.|
A I Am the Law and I Am the Lash|QID|28278|M|30.75,33.77|N|From General Thorg'izog.|
A Abuse of Power|QID|28279|M|30.75,33.77|N|Automatically accepted.|
C Abuse of Power|QID|28279|S|U|63390|M|35.10,35.83|N|Spam the cudgel to kill the Blackrock Sergeants.|
C I Am the Law and I Am the Lash|QID|28278|U|63390|M|36.34,37.49|N|I recommend putting the cudgel on the action bar. That way if you are spotting you can spam the crap out of it, to kill the mob.|
C Abuse of Power|QID|28279|US|U|63390|M|35.10,35.83|N|Spam the cudgel to kill the Blackrock Sergeants.|
T Abuse of Power|QID|28279|M|35.13,35.86|N|(UI Alert)|
A Enough Damage For One Day|QID|28286|M|35.13,35.86|N|(UI Alert)|
T I Am the Law and I Am the Lash|QID|28278|M|30.78,33.76|N|To General Thorg'izog.|
T Enough Damage For One Day|QID|28286|M|46.38,45.75|N|To Colonel Troteman.|
A Morgan's Vigil|QID|28310|M|46.38,45.75|N|From Colonel Troteman.|
R Morgan's Vigil|QID|28310|M|46.05,50.46;54.81,47.61;65.38,54.58;70.62,60.97;71.85,63.17|N|Run to Morgan's Vigil.|
f Morgan's Vigil|QID|28310|M|72.23,65.68|N|At Borgus Stoutarm.|
r Sell junk, repair/restock.|QID|28310|M|72.81,65.71|N|At Felder Stover. Close this step when your done.|

T Morgan's Vigil|QID|28310|M|71.98,67.97|N|To Oralius.|
A SEVEN! YUP!|QID|28415|M|71.98,67.97|N|From Oralius. Don't worry, you won't have to find Captain Winky.|
A The Bogpaddle Bullet|QID|28569|M|71.98,67.97|N|From Oralius.|
A Blackened Ashes|QID|28311|M|73.51,67.07|N|From Colonel Troteman.|
A Latent Demons of the Land|QID|28312|M|73.51,67.07|N|From Colonel Troteman.|
A A Heap of Delicious Worg|QID|28313|M|73.51,67.07|
C A Heap of Delicious Worg|QID|28313|U|63427|M|72.57,56.14|N|Kill the worgs around this spot. Loot before you use the knife or you will lose out on the loot.|
C Blackened Ashes|QID|28311|M|62.80,39.92|N|Warning to spellcasters: the elementals have a 20% spell reflect. Kill and loot any elemental you see.|
C SEVEN! YUP!|QID|28415|S|M|66.24,70.82|N|Grab the Flameflies as you see them. They can be a little hard to grab sometimes.|
C Latent Demons of the Land|QID|28312|M|66.24,70.82|N|Kill and loot Flamekin Imps.|
C SEVEN! YUP!|QID|28415|US|M|66.24,70.82|N|Grab the Flameflies as you see them. They can be a little hard to grab sometimes.|
T SEVEN! YUP!|QID|28415|M|71.97,67.99|N|To Oralius. You get a new companion pet. A "Tiny Flamefly".|
T Blackened Ashes|QID|28311|M|73.52,67.13|N|To Colonel Troteman.|
T Latent Demons of the Land|QID|28312|M|73.52,67.13|N|To Colonel Troteman.|
T A Heap of Delicious Worg|QID|28313|M|73.52,67.13|N|To Colonel Troteman.|

A Blood Tour|QID|28314|M|73.52,67.13|N|From John J. Keeshan.|
A Draconic Vanguard|QID|28315|M|73.52,67.13|N|From John J. Keeshan.|
A A Deal With a Dragon|QID|28316|M|73.52,67.13|N|From John J. Keeshan.|
C Blood Tour|QID|28314|S|M|77.82,35.84|N|Kill any Black Dragonspawn or Black Wyrmkin you see.|
K Draconic Vanguard|QID|28315|QO|Whelptamer Akumi slain: 1/1|M|65.03,59.84|N|Kill Wheltamer Akumi here.|
K Draconic Vanguard|QID|28315|QO|Minyoth slain: 1/1|M|79.50,51.41|N|Kill Minyoth here.|
K Draconic Vanguard|QID|28315|QO|Tugnar Goremaw slain: 1/1|M|75.67,37.08|N|Kill Tugnar Goremaw here.|
T A Deal With a Dragon|QID|28316|M|82.04,31.54|N|To Acride.|
C Draconic Vanguard|QID|28315|QO|Terromath the Seared slain: 1/1|M|72.29,26.73|N|Kill Terromath.|
C Blood Tour|QID|28314|US|M|77.82,35.84|N|Kill any Black Dragonspawn or Black Wyrmkin you have you left.|
T Blood Tour|QID|28314|M|72.29,26.73|N|To John J. Keeshan.|
T Draconic Vanguard|QID|28315|M|72.29,26.73|N|To John J. Keeshan.|

A Placing the Pawns|QID|28326|M|72.31,26.63|N|(UI Alert)|
T Placing the Pawns|QID|28326|M|73.58,67.07|N|To Colonel Troteman.|
A A Delivery for Thorg'izog|QID|28317|M|73.58,67.07|N|From Colonel Troteman.|
A A Delivery for Neeralak|QID|28318|M|73.58,67.07|N|From Colonel Troteman.|
A A Delivery for Xi'lun|QID|28319|M|73.58,67.07|N|From Colonel Troteman.|
T A Delivery for Thorg'izog|U|63357|QID|28317|M|65.12,46.66|N|Put on your disguise, then head towards General Thorg'izog. Enter the cave at the waypoint, at the split head left.|
T A Delivery for Xi'lun|QID|28319|M|69.52,43.10;63.79,37.81;66.31,37.96;68.88,44.14|N|To High Warlock Xi'lun Follow the path up, he is in the cave.|
T A Delivery for Neeralak|QID|28318|M|70.88,38.13|N|To Dragon-Lord Neeralak. Enter the cave at the waypoint, at the split head left.|
A Locked and Loaded|QID|28327|M|69.52,43.10|N|(UI Alert)|
T Locked and Loaded|QID|28327|M|73.53,67.08|N|To Colonel Troteman.|
A Assault on Dreadmaul Rock|QID|28320|M|73.16,66.39|N|From John J. Keeshan.|
C Assault on Dreadmaul Rock|QID|28320|U|63681|M|69.36,51.35|N|Only 1 button to use, have fun on the dragon.|
T Assault on Dreadmaul Rock|QID|28320|M|73.52,67.05|N|To Colonel Troteman.|

A Glory Amidst Chaos|QID|28321|M|73.52,67.05|N|From Colonel Troteman.|
K General Thorg'izog|QID|28321|QO|General Thorg'izog slain: 1/1|M|65.12,46.66|N|General Thorg'izog needs to be killed. Enter the cave at the waypoint, at the split head left.|
K Dragon-Lord Neeralak|QID|28321|QO|Dragon-Lord Neeralak slain: 1/1|M|69.52,43.10;63.79,37.81;66.31,37.96;68.88,44.14|N|Dragon-Lord Neeralak's turn to die. Follow the path up, he is in the cave.|
C Glory Amidst Chaos|QID|28321|QO|High Warlock Xi'lun slain: 1/1|M|70.88,38.13|N|Time to kill High Warlock Xi'lun. Enter the cave at the waypoint, at the split head left.|
T Glory Amidst Chaos|QID|28321|M|73.52,67.00|N|To Colonel Troteman.|
A The Spoils of War|QID|28322|M|73.52,67.00|N|From Colonel Troteman.|
T The Spoils of War|QID|28322|M|73.66,67.23|N|To Crate of Left Over Supplies.|
N If you still have|QID|28322|N|the Blackrock Cudgel of Discipline, go ahead and toss it.|
F Stormwind City|QID|28569|M|72.16,65.71|N|Fly to Stormwind to train, visit AH, sell junk and repair/restock.|
F Morgan's Vigil|QID|28569|M|71.05,72.68|Z|Stormwind City|N|When you're done, fly back to Morgan's Vigil.|
R Swamp of Sorrows|QID|28569|N|Run to Sharon Boomgetter and talk to her to head to the Swamp of Sorrows.|M|78.39,58.85|
T The Bogpaddle Bullet|QID|28569|M|73.10,14.72|Z|Swamp of Sorrows|N|To Trade Baron Silversnap.|
]]

end)
