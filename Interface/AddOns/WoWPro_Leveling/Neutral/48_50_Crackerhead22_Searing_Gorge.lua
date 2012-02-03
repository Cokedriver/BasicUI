
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_searing_gorge_neutral
-- Date: 2011-06-21 20:30
-- Who: Crackerhead22

-- URL: http://wow-pro.com/node/3255/revisions/24558/view
-- Date: 2011-06-18 17:27
-- Who: Ludovicus Maior
-- Log: ! Line 66, for step T non-decimal QID: [T A New Master... But Who?|QID||M|68.52,53.49|N|To Jack Rockleg.|]

-- URL: http://wow-pro.com/node/3255/revisions/24555/view
-- Date: 2011-06-14 22:14
-- Who: Fluclo
-- Log: Moved the Incendisaur and Bullet stickies further down as they are still collectable whilst doing on the following tower quests.

-- URL: http://wow-pro.com/node/3255/revisions/24554/view
-- Date: 2011-06-14 21:59
-- Who: Fluclo
-- Log: Moved Heat That Just Don't Quit to after the spiders, since it can still be done around the spiders.

-- URL: http://wow-pro.com/node/3255/revisions/24542/view
-- Date: 2011-06-11 15:59
-- Who: Crackerhead22
-- Log: Added in faction tags, removed the notice about quests needed to be closed since the step did not autocomplete.

-- URL: http://wow-pro.com/node/3255/revisions/24402/view
-- Date: 2011-05-17 01:58
-- Who: Ludovicus Maior

-- URL: http://wow-pro.com/node/3255/revisions/24394/view
-- Date: 2011-05-17 01:10
-- Who: Ludovicus Maior

-- URL: http://wow-pro.com/node/3255/revisions/24303/view
-- Date: 2011-04-29 14:45
-- Who: Ludovicus Maior
-- Log: Line 46 for step A has unknown tag [68.94,53.5], Line 111 for step R has 1 M coords, Line 167 for step C has 1 M coords.

-- URL: http://wow-pro.com/node/3255/revisions/23929/view
-- Date: 2011-01-04 20:08
-- Who: Crackerhead22
-- Log: Changed date on Change log to correct date.

-- URL: http://wow-pro.com/node/3255/revisions/23925/view
-- Date: 2011-01-04 17:34
-- Who: Crackerhead22
-- Log: Added notes, added more sticky steps, fixed notes, fixed steps not auto-completing, fixed wrong steps.

-- URL: http://wow-pro.com/node/3255/revisions/23394/view
-- Date: 2010-12-03 11:42
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3255/revisions/23391/view
-- Date: 2010-12-03 11:41
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3255/revisions/23390/view
-- Date: 2010-12-03 11:40
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('CraSea4850', 'Searing Gorge', 'Crackerhead22', '48', '50', 'CraBur5052|LiaBur5052', 'Neutral', function()
return [[

H Dragon's Mouth|QID|27963|N|Hearth back to Dragon's Mouth.|FACTION|Alliance|
R Searing Gorge|QID|27963|M|9.79,51.31;2.29,51.97|Z|Badlands|N|Follow the arrows into Searing Gorge.|
T To the Aid of the Thorium Brotherhood|QID|28512|M|68.54,53.59|N|To Jack Rockleg.|O|
T Hero's Call: Searing Gorge!|QID|28582|M|68.54,53.59|N|To Jack Rockleg.|O|FACTION|Alliance|
A A New Master... But Who?|QID|27963|M|68.54,53.59|N|From Jack Rockleg.|
A The Fewer, the Better|QID|27960|M|68.54,53.59|N|From Burrian Coalpart.|
A Lunk's Task|QID|27956|M|68.77,53.31|N|From Lunk.|
C The Fewer, the Better|QID|27960|S|M|61.90,59.92|N|Kill Dark Iron Geologists or Watchmen.|
C Lunk's Task|QID|27956|M|62.98,64.43|N|Kill Tempered War Golems to get "Tempered Flywheel"s that you need.|S|
C A New Master... But Who?|QID|27963|M|63.75,59.21|N|Look for Gravius Grimesilt, kill him then loot his corpse.|
C The Fewer, the Better|QID|27960|US|M|61.90,59.92|N|Kill Dark Iron Geologists or Watchmen.|
C Lunk's Task|QID|27956|M|62.98,64.43|N|Finish getting the rest of the "Tempered Flywheel"s that you need.|US|
T A New Master... But Who?|QID|27963|M|68.52,53.49|N|To Jack Rockleg.|

A Dig-Boss Dinwhisker|QID|27964|M|68.52,53.49|N|From Jack Rockleg.|
T The Fewer, the Better|QID|27960|M|68.52,53.49|N|To Burrian Coalpart.|
A Out of Place|QID|27961|M|68.52,53.49|N|From Burrian Coalpart.|
A A Lumbering Relic|QID|27962|M|68.52,53.49|N|From Burrian Coalpart.|
T Lunk's Task|QID|27956|M|68.94,53.50|N|To Lunk.|
A Lunk No Kill|QID|27957|M|68.94,53.5|N|From Lunk.|
A A Proper Antivenom|QID|27958|M|68.61,53.38|N|From Prisanne Dustcropper.|
A Lunk's Adventure: Spider Rider|QID|27959|M|60.27,55.13|N|Once you kill a spider, Lunk will appear out of nowhere. Get his quest.|
C Out of Place|QID|27961|S|N|Grab the chickens as quickly as you can, they can be looted from on a mount.. The spiders will kill the chickens.|
C Lunk's Adventure: Spider Rider|QID|27959|M|59.50,65.62|N|Get the spiders about halfway down, then Lunk will jump on them, laughs will be had. Make sure to click on Lunk to get the Glassweb Venom, after he is done riding the spider.|
T Lunk's Adventure: Spider Rider|QID|27959|M|59.50,65.60|N|(UI Alert).|
C A Proper Antivenom|QID|27958|M|60.21,67.72|N|Get whatever you need left.|
C A Lumbering Relic|QID|27962|M|70.63,73.24|N|Head to the waypoint, kill and loot Margol the Rager.|
C Out of Place|QID|27961|US|M|63.59,72.99|N|Finish gathering what you need, they can be looted from on a mount.|
T Out of Place|QID|27961|M|68.48,53.50|N|To Burrian Coalpart.|
T A Lumbering Relic|QID|27962|M|68.48,53.50|N|To Burrian Coalpart.|
T A Proper Antivenom|QID|27958|M|68.59,53.44|N|To Prisanne Dustcropper.|

r Sell junk, repair/restock.|QID|27964|M|68.41,53.43|N|At Burian Coalpart.|
R The Cauldron|QID|27964|M|70.11,39.80;65.53,38.36;62.84,38.85|N|Head to The Cauldron.|
C Dig-Boss Dinwhisker|QID|27964|M|54.93,45.64|N|Kill Dark Iron Excavators and Footmen until Dig-Boss Dinwhisker appears. After you kill him, loot the "Dark Ember" off the ground.|
T Dig-Boss Dinwhisker|QID|27964|M|68.52,53.68|N|To Jack Rockleg.|
A Thorium Point: The Seat of the Brotherhood|QID|27965|M|68.52,53.68|N|From Jack Rockleg.|
R Thorium Point|QID|27965|M|70.11,39.80;66.61,34.57;41.25,34.23|N|Head to Thorium Point.|
f Thorium Point|QID|27965|M|38.01,30.67|N|At Lanie Reed.|FACTION|Alliance|
f Thorium Point|QID|27965|M|34.8,30.8|N|At Grisha.|FACTION|Horde|
T Thorium Point: The Seat of the Brotherhood|QID|27965|M|38.21,26.83|N|To Overseer Oilfist.|

A Rasha'krak|QID|28099|M|38.21,26.83|N|From Overseer Oilfist.|
A Mouton Flamestar|QID|28514|M|38.21,26.83|N|From Overseer Oilfist.|
A The Spiders Have to Go|QID|27980|M|37.66,27.05|N|From Lookout Captain Lolo Longstriker.|
A Curse These Fat Fingers|QID|27976|M|38.30,27.73|N|From Hansel Heavyhands.|
A Heat That Just Don't Quit|QID|27981|M|38.30,27.73|N|From Hansel Heavyhands.|
A Recon Essentials|QID|27977|M|36.56,27.78|N|From Taskmaster Scrange.|
A Lunk's Adventure: Cranky Little Dwarfs|QID|27983|M|36.63,36.89|N|Kill a Dark Iron Steamsmith to have Lunk appear. Get his quest.|
C Curse These Fat Fingers|QID|27976|M|39.22,41.08|N|Kill Heavy War Golems.|S|
C Heat That Just Don't Quit|S|QID|27981|U|62826|M|31.15,43.81;39.07,41.43;42.88,35.89|N|Use the Furnace Flasks on the Elementals at the start of the fight.|
C Lunk's Adventure: Cranky Little Dwarfs|QID|27983|S|M|38.72,49.87|N|Get the Dark Iron Steamsmiths down below 50% health. He will sit on the dwarves, when he gets up you will get a random item. Including the items needed for "Recon Essentials".|
C Rasha'krak|QID|28099|U|62826|M|31.15,43.81;39.07,41.43;42.88,35.89|N|Rasha'krak wanders between these waypoints. Use the "Furnace Flasks" on him at the start.|
C Lunk's Adventure: Cranky Little Dwarfs|QID|27983|US|M|38.72,49.87|N|Finish having Lunk put the Dark Iron Steamsmiths to sleep.|
C Recon Essentials|QID|27977|M|36.29,47.13|N|Kill Dark Iron Steamsmiths until the two items needed drop, if they did not drop during "Lunk's Adventure: Cranky Little Dwarfs".|
T Lunk's Adventure: Cranky Little Dwarfs|QID|27983|M|38.72,49.87|N|(UI Alert).|

C Curse These Fat Fingers|QID|27976|M|39.22,41.08|N|Kill however many golems you have left to kill.|US|
C The Spiders Have to Go|QID|27980|M|30.03,57.16;28.42,44.85|N|Wander between the two waypoints to get all your spider kills.|
C Heat That Just Don't Quit|US|QID|27981|U|62826|M|31.15,43.81;39.07,41.43;42.88,35.89|N|Finish collecting the flasks.|
T Curse These Fat Fingers|QID|27976|M|38.32,28.04|N|To Hansel Heavyhands.|
T Heat That Just Don't Quit|QID|27981|M|38.32,28.04|N|To Hansel Heavyhands.|
T Rasha'krak|QID|28099|M|38.09,26.66|N|To Overseer Oilfist.|
T The Spiders Have to Go|QID|27980|M|37.64,26.73|N|To Lookout Captain Lolo Longstriker.|
T Recon Essentials|QID|27977|M|36.65,28.25|N|To Taskmaster Scrange.|
A Twilight Collars|QID|27982|M|36.75,28.25|N|From Taskmaster Scrange.|
A Dark Ministry|QID|27979|M|38.33,27.99|N|From Hansel Heavyhands.|
C Twilight Collars|QID|27982|S|M|38.68,28.71|N|Kill any Twilight mobs as you go along.|
l Finister's Spherule|QID|27979|L|62824|M|24.68,26.29|N|Kill and loot Finister to get "Finister's Spherule".|

A Lunthistle's Tale|QID|27984|M|29.43,26.46|N|From Zamael Lunthistle.|
C Lunthistle's Tale|QID|27984|NC|M|29.43,26.46|N|Listen to his tale.|
T Lunthistle's Tale|QID|27984|M|29.43,26.46|N|To Zamael Lunthistle.|
A Prayer to Elune|QID|27985|M|29.43,26.46|N|From Zamael Lunthistle.|
C Prayer to Elune|QID|27985|M|23.10,35.28|N|Head down the mountain to the waypoint and open the Twilight Hammer Crate.|
T Prayer to Elune|QID|27985|M|23.10,35.28|N|(UI Alert).|
l Kyuubi's Spherule|QID|27979|L|62825|M|17.49,42.58|N|Enter the cave. Kill and loot Kyuubi to get "Kyuubi's Spherule".|
l Letherio's Spherule|QID|27979|L|62823|M|14.49,37.25|N|Kill Letherio and loot to get "Letherio's Spherule".|
C Dark Ministry|QID|27979|U|62824|M|14.49,37.25|N|Use one of the Spherules to combine them.|
C Twilight Collars|QID|27982|US|M|13.44,42.20|N|Kill Twilight mobs to get the rest of the "Twilight Necklace"s you need.|
T Dark Ministry|QID|27979|M|38.25,28.00|N|To Hansel Heavyhands.|
A In the Hall of the Mountain-Lord|QID|27986|M|38.28,28.04|N|From Hansel Heavyhands.|
T Twilight Collars|QID|27982|M|38.48,28.65|N|To Master Smith Burninate.|

r Sell junk, repair/restock.|QID|27986|M|38.48,28.65|N|At Master Smith Burninate.|
R Iron Summit|QID|27986|M|39.59,31.28;29.51,50.22;31.78,59.97;37.68,62.88|N|Head to the Iron Summit.|
f Iron Summit|QID|27986|M|40.95,68.58|N|At Doug Deepdown.|
T In the Hall of the Mountain-Lord|QID|27986|M|39.26,67.78|N|To Mountain-Lord Rendan.|
A Siege!|QID|28028|M|39.26,67.78|N|From Mountain-Lord Rendan.|
A Set Them Ablaze!|QID|28029|M|39.26,67.78|N|From Mountain-Lord Rendan.|
A They Build a Better Bullet|QID|28030|M|39.26,67.78|N|From Mountain-Lord Rendan.|
A The Mysteries of the Fire-Gizzard|QID|28032|M|39.00,68.83|N|From Agnes Flimshale.|
C They Build a Better Bullet|QID|28030|S|M|49.17,73.38|N|Pick up the Dark Iron Bullet crates, the bullets can also drop off of Dark Iron Marskmen and Lookouts.|
C Siege!|QID|28028|M|48.59,66.16|N|Kill Dark Iron Marksman near the Iron Summit.|S|
C The Mysteries of the Fire-Gizzard|QID|28032|M|34.85,67.89|S|N|Kill the Incendosaurs to get the items needed for this quest.|
C Southeastern tower|QID|28029|QO|Southeastern tower ablaze: 1/1|M|44.03,60.94|N|Click on the Southeastern tower brazier.|
C Eastern tower|QID|28029|QO|Eastern tower ablaze: 1/1|M|50.06,54.72|N|Click on the Eastern tower brazier.|
C Southwestern tower|QID|28029|QO|Southwestern tower ablaze: 1/1|M|35.67,60.67|N|Click on the Southwestern tower brazier.|
C Set Them Ablaze!|QID|28029|QO|Western tower ablaze: 1/1|M|33.32,54.47|N|Click on the Western tower brazier.|
C Siege!|QID|28028|M|48.59,66.16|N|Kill Dark Iron Marksman near the Iron Summit.|
C The Mysteries of the Fire-Gizzard|QID|28032|M|34.85,67.89|US|N|Finish killing the Incendosaurs to get the items needed for this quest.|
C They Build a Better Bullet|QID|28030|US|M|49.17,73.38|N|Finish collecting the Dark Iron Bullet crates, the bullets also drop off of Dark Iron Marskmen and Lookouts.|
T The Mysteries of the Fire-Gizzard|QID|28032|M|39.02,68.77|N|To Agnes Flimshale.|
T Siege!|QID|28028|M|39.32,67.71|N|To Mountain-Lord Rendan.|
T Set Them Ablaze!|QID|28029|M|39.32,67.71|N|To Mountain-Lord Rendan.|
T They Build a Better Bullet|QID|28030|M|39.32,67.71|N|To Mountain-Lord Rendan.|

A Deceit|QID|28033|M|39.32,67.71|N|From Mountain-Lord Rendan.|
T Deceit|QID|28033|M|39.74,67.93|N|Find Lunk at the base of the tower.|
A Lunk's Adventure: Rendan's Weakness|QID|28034|M|39.74,67.93|N|Get from Lunk.|
C Lunk's Adventure: Rendan's Weakness|QID|28034|M|39.74,67.93|N|Speak with three Iron Summit Guards and ask them to join your dance. |
T Lunk's Adventure: Rendan's Weakness|QID|28034|M|39.36,67.81|N|Go back up to Mountain-Lord Rendan to turn the quest in.|
A The Mountain-Lord's Support|QID|28035|M|39.41,67.84|N|From Mountain-Lord Rendan.|
h Iron Summit|M|39.21,66.02|N|At Velma Rockslide.|QID|28035|
F Thorium Point|QID|28035|M|40.89,68.91|N|Fly to Thorium Point.|
T The Mountain-Lord's Support|QID|28035|M|38.09,26.82|N|To Overseer Oilfist.|
A Operation: Stir the Cauldron|QID|28052|M|38.09,26.82|N|From Overseer Oilfist.|
C Operation: Stir the Cauldron|QID|28052|M|41.44,55.72|N|Talk to Lanie Reed, choose the option to take the flying machine. Hit the 1 button and aim where you want to fire and click to fire.|
T Operation: Stir the Cauldron|QID|28052|M|40.89,51.84|N|To Mountain-Lord Rendan.|

A Slavery is Bad|QID|28054|M|40.89,51.84|N|From Mountain-Lord Rendan.|
A Sweet, Horrible Freedom|QID|28055|M|40.89,51.84|N|From Mountain-Lord Rendan.|
A Rise, Obsidion|QID|28056|M|40.74,51.71|N|From Mountain-Lord Rendan.|
C Slavery is Bad|QID|28054|S|M|39.19,34.30|N|Kill the Dark Iron Taskmasters or Dark Iron Slavers as you go along.|
C Sweet, Horrible Freedom|QID|28055|M|40.18,36.41|N|Attempt to free slaves, they may try to attack you.|S|
C Rise, Obsidion|QID|28056|M|41.28,25.77|N|Click on the "Altar of Suntara", then kill Obsidian and Lathoric the Black.|
C Sweet, Horrible Freedom|QID|28055|M|40.18,36.41|N|Finish attempting to free however many you have left.|US|
C Slavery is Bad|QID|28054|US|M|39.19,34.30|N|Finish killing any Dark Iron Taskmasters or Dark Iron Slavers that you need..|
T Slavery is Bad|QID|28054|M|43.72,28.46|N|Run up the ramp to Evonice Sootsmoker.|
T Sweet, Horrible Freedom|QID|28055|M|43.72,28.46|N|To Evonice Sootsmoker.|
T Rise, Obsidion|QID|28056|M|43.72,28.46|N|To Evonice Sootsmoker.|
A Kill 'em With Sleep Deprivation|QID|28057|M|43.66,28.46|N|From Evonice Sootsmoker.|

N Warning: Wall of text on next step.|QID|28057|N|Close this step.|
N Kill 'em With Sleep Deprivation|QID|28057|N|After looting the first pillow a timed event starts. After some time, a pack of Sleepy Dark Iron Workers spawns from one of the ends, after a bit more time another pack spawns, there are about 10+ but they are fairly weak and easy to kill. After some more time, a level 49 elite, Chambermaid Pillaclencher, will spawn. She likes to do knockback and silence ALOT! If you can kill her she will drop on the ground a lootable item. Close this step.|
C Kill 'em With Sleep Deprivation|QID|28057|M|44.87,31.65|N|Loot pillows.|
A Look at the Size of It!|QID|28058|U|62933|M|45.21,30.66|N|After you kill Chambermaid Pillaclencher, loot the sparkling pillow next to her corpse, then accept the quest. Skip this if you did not wait or kill her.|
T Look at the Size of It!|QID|28058|M|43.73,28.58|N|To Evonice Sootsmoker.|O|
T Kill 'em With Sleep Deprivation|QID|28057|M|42.38,34.34|N|To Taskmaster Scrange.|
A Twisted Twilight Ties|QID|28060|M|42.47,34.22|N|From Taskmaster Scrange.|
C Twisted Twilight Ties|QID|28060|M|40.88,35.71|N|Speak with Hansel Heavyhands and help him assault Overseer Maltorius and Twilight-Lord Arkkus.|
T Twisted Twilight Ties|QID|28060|M|47.69,41.96;49.96,39.28|N|To Overseer Oilfist. Drop down at the first waypoint.|

A From Whence He Came|QID|28062|M|49.96,39.28|N|From Overseer Oilfist.|
A Minions of Calcinder|QID|28061|M|50.19,38.90|N|From Overseer Oilfist.|
C Minions of Calcinder|QID|28061|M|43.78,27.65|N|Kill 6 Searing Flamewraiths.|S|
C From Whence He Came|QID|28062|U|62925|M|42.83,29.81|N|Take Archduke Calcinder down in health, once you see the UI Alert, use the Consecrated Tripetricine.|
C Minions of Calcinder|QID|28061|M|43.78,27.65|N|Kill 6 Searing Flamewraiths.|US|
T Minions of Calcinder|QID|28061|M|46.77,27.06|N|(UI Alert)|
T From Whence He Came|QID|28062|M|43.78,27.65|N|(UI Alert)|
A Welcome to the Brotherhood|QID|28064|M|43.78,27.65|N|(UI Alert)|
H Iron Summit|QID|28053|N|Hearth back to Iron Summit.|
F Thorium Point|QID|28053|M|40.89,68.91|N|Fly to Thorium Point.|
A Lunk Like Your Style|QID|28053|M|39.02,25.97|N|Get from Lunk up the ramp of the tower.|
T Welcome to the Brotherhood|QID|28064|M|38.08,26.70|N|To Overseer Oilfist.|
F Stormwind City|QID|28666|M|38.01,30.67|N|Fly to Stormwind to train, visit AH, etc.|FACTION|Alliance|
]]

end)
