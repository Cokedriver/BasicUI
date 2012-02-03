
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_bloodmyst_isle
-- Date: 2011-08-01 01:26
-- Who: Ludovicus Maior
-- Log: [Newfound Allies] needed a zone tag ...

-- URL: http://wow-pro.com/node/3220/revisions/24588/view
-- Date: 2011-06-25 00:51
-- Who: Crackerhead22
-- Log: ! Duplicate A step for qid 9641 - Removed duplicate
--	! Duplicate T step for qid 9641 - Removed duplicate

-- URL: http://wow-pro.com/node/3220/revisions/24518/view
-- Date: 2011-06-07 23:09
-- Who: Ludovicus Maior
-- Log: ! Line 71 for step C has unknown tag [58.3,86.28]: [C Alien Predators|QID|9634|N|Kill Bloodmyst Hatchlings.|58.3,86.28|S|]
--	! Line 73 for step C has unknown tag [58.3,86.28]: [C Alien Predators|QID|9634|N|Kill Bloodmyst Hatchlings.|58.3,86.28|US|]
--	! Line 184 for step C has 1 M coords: [C Culling the Flutterers|QID|9647|N|Go between the waypoints, and kill the last Royal Blue Flutterers that you need.|US|M|47.21;32.72;43.5,36.58|]

-- URL: http://wow-pro.com/node/3220/revisions/24496/view
-- Date: 2011-06-03 09:55
-- Who: Crackerhead22
-- Log: Added a bunch of notes, fixed some cords, added a bunch of cords. Removed outdated quest chain.

-- URL: http://wow-pro.com/node/3220/revisions/24463/view
-- Date: 2011-05-31 20:55
-- Who: Ludovicus Maior
-- Log: Corrected Invalid Z tag argument.

-- URL: http://wow-pro.com/node/3220/revisions/24292/view
-- Date: 2011-04-29 14:21
-- Who: Ludovicus Maior
-- Log: Line 113 for step A has unknown tag [10], Line 114 for step T has unknown tag [10].

-- URL: http://wow-pro.com/node/3220/revisions/24217/view
-- Date: 2011-04-05 23:28
-- Who: Ludovicus Maior

-- URL: http://wow-pro.com/node/3220/revisions/24078/view
-- Date: 2011-01-30 18:27
-- Who: Fluclo
-- Log: Improved information flow for many quests as well as included Map points in many others.

-- URL: http://wow-pro.com/node/3220/revisions/23326/view
-- Date: 2010-12-03 09:09
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3220/revisions/23310/view
-- Date: 2010-12-03 07:35
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3220/revisions/23309/view
-- Date: 2010-12-03 07:35
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide("SveBlo1220", "Bloodmyst Isle", "Sven", "12", "20", "WkjAsh2025", "Alliance", function()
return [[

R Bloodmyst Isle |QID|9624|M|65.25,94.00|Z|Bloodmyst Isle|N|There are two quests to lead you to Bloodmyst Isle. 'Elekks Are Serious Business' from Torallius the Pack Handler outside The Exodar if you have done the Coming of Age quest in Azuremyst Isle, or Hero's Call: Bloodmyst Isle! from the Hero's Callboard in The Exodar. Take either of these two quests, then head north to Booodmyst Isle.|
T Elekks Are Serious Business |QID|9625|M|63.1,88.0|O|N|To Vorkhan the Elekk Herder.|
T Hero's Call: Bloodmyst Isle! |QID|28559|M|63.1,88.0|O|N|To Vorkhan the Elekk Herder.|
A Alien Predators |QID|9634|M|63.1,88.0|N|From Vorkhan the Elekk Herder.|
A A Favorite Treat |QID|9624|M|63.4,88.8|N|From Aonar.|
A The Kessel Run |QID|9663|M|63.0,87.5|N|From Kessel.  Please note this quest is timed (15 minutes).  You will receive a mount, note that you can't resummon it if you get dismounted, so stay out of caves, water and buildings. Although you can do it without the elekk, it will take substantially longer.|
N Warn Chief Stillpine |QID|9663|QO|High Chief Stillpine Warned: 1/1|N|Warn High Chief Stillpine outside Stillpine Hold. Note that you can't resummon the mount it if you get dismounted, so stay out of caves, water and buildings.|Z|Azuremyst Isle|M|46.7,20.8|
N Warn Exarch Menelauos |QID|9663|QO|Exarch Menelaous Warned: 1/1|N|Warn Exarch Menelaous in Azure Watch. Note that you can't resummon the mount it if you get dismounted, so stay out of caves, water and buildings.|Z|Azuremyst Isle|M|47.2,50.6|
N Warn Admiral Odesyus |QID|9663|QO|Admiral Odesyus Warned: 1/1|N|Warn Admiral Odyseus at Odesyus' Landing. Note that you can't resummon the mount it if you get dismounted, so stay out of caves, water and buildings.|Z|Azuremyst Isle|M|47.0,70.2|
T The Kessel Run |QID|9663|M|62.99,87.52|N|Return to Kessel at Kessel's Crossing.|
A Declaration of Power |QID|9666|N|From Kessel.|M|63.0,87.5|
A Catch and Release |QID|9629|M|53.2,57.7|N|Follow the road north to Blood Watch, then head to Morae.|
r Repair/Restock |QID|9693|M|53.32,56.67|N|Repair/Sell Junk at Beega.|
A Learning from the Crystals |QID|9581|M|52.6,53.2|N|From Harbinger Mikolaas.|
A What Argus Means to Me |QID|9693|M|52.67,53.21|N|From Exarch Admetius.|
T What Argus Means to Me |QID|9693|M|55.39,55.27|N|To Vindicator Boros.|
A Blood Watch |QID|9694|M|55.39,55.27|N|From Vindicator Boros.|

f Blood Watch |QID|9634|M|57.69,53.92|N|Get the flight path for Blood Watch.|
A Mac'Aree Mushroom Menagerie |QID|9648|M|56.4,56.8|N|From Jessera of Mac'Aree.|
A WANTED: Deathclaw|QID|9646|M|55.2,59.1|N|From the Wanted Board outside the Inn.|
h Blood Watch |QID|9634|M|55.84,59.80|N|Set hearthstone to Blood Watch with Caregiver Topher Loaal.|
l Blood Mushroom|QID|9648|QO|Blood Mushroom: 1/1|L|24040|M|62.8,60.0;60.8,61.0;58.6,55.0;62.2,53.1;65.2,54.6;58.9,61.8;58.3,66.7;54.0,67.5|N|Obtain a Blood Mushroom, they are small and glow red.|
l Aquatic Stinkhorn|QID|9648|M|63.75,62.90|QO|Aquatic Stinkhorn: 1/1|L|24041|N|Obtain an Aquatic Sinkhorn from Stinkhorn Striker in the Blood River.|
l Ruinous Polyspore|QID|9648|M|67.86,66.53;60.6,42.1;62.0,41.9;60.8,49.6;64.1,47.2;68.6,65.1;66.5,70.1;68.7,71.7|L|24042|QO|Ruinous Polyspore: 1/1|N|Obtain a Ruinous Polyspore, they are black/grey and tan.|
K Lord Xiz|QID|9666|QO|Lord Xiz slain: 1/1|U|24084|M|68.8,67.3|N|Kill Lord Xiz.|
C Declaration of Power |QID|9666|U|24084|M|8.8,67.3|N|Plant the banner at the corpse of Lord Xiz.|
C A Favorite Treat|QID|9624|N|Pick up Sand Pears.|S|
A Saving Princess Stillpine |QID|9667|M|68.2,81.2|PRE|9559|N|From Princess Stillpine.|
K Furlblogs |QID|9667|L|24099|M|64.25,76.50|N|Head north-west to the small camp, killing furbolgs there until High Chief Bristlelimb spawns and yells 'Face the wrath of Bristlelimb!' - kill him, and loot the key.|
C Saving Princess Stillpine |QID|9667|M|68.2,81.2|N|Open Princess Stillpine's cage.|
C Alien Predators|QID|9634|N|Kill Bloodmyst Hatchlings.|M|58.3,86.28|S|
C Learning from the Crystals |QID|9581|U|23875|M|58.25,83.44|N|Use your Crystal Mining Pick on the Impact Site Crystal.|
C Alien Predators|QID|9634|N|Kill Bloodmyst Hatchlings.|M|58.3,86.28|US|
C A Favorite Treat|QID|9624|M|59.4,88.39|N|Finish picking up the Sand Pears at the base of the trees.|US|
T A Favorite Treat |QID|9624|M|63.43,88.78|N|To Aonar.|
T Alien Predators |QID|9634|M|63.05,87.92|N|To Vorkhan the Elekk Herder.|
T Declaration of Power |QID|9666|M|62.99,87.54|N|To Kessel.|

A Report to Exarch Admetius|QID|9668|M|62.99,87.54|N|From Kessel.|
C Catch and Release|QID|9629|U|23995|M|43.8,93.3|N|Use the Murloc Tagger on 6 Blacksilt Scouts.|S|
K Cruelfin |QID|9576|L|23870|M|49.5,94.8;34.6,93.1|N|Find and kill cruelfin, then loot the Red Crystal Pendant. He patrols along the south coast, spawning on the east side.|T|Cruelfin|
A Cruelfin's Necklace|QID|9576|U|23870|N|Quest starts from the Red Crystal Pendant dropped from Cruelfin.|
C Catch and Release|QID|9629|U|23995|M|43.8,93.3|N|Continue to use the Murloc Tagger on 6 Blacksilt Scouts.|US|
L Level 14 |LVL|14|QID|9576|N|Grind on murlocs until you are 4,800 XP from Level 14.|
C Mac'Aree Mushroom Menagerie |QID|9648|M|44,78;35,79|N|Obtain a Fel Cone Fungus. They're kind of grey brown in comparison to the rest of the mushrooms they're with.|
H Blood Watch |QID|9576|N|Hearth back to Blood Watch.|M|55.84,59.80|
T Cruelfin's Necklace|QID|9576|M|53.25,57.75|N|To Morae.|
T Catch and Release |QID|9629|M|53.25,57.75|N|To Morae.|
A Victims of Corruption|QID|9574|M|53.25,57.75|N|From Morae.|
r Repair/Restock |QID|9668|M|53.32,56.67|N|Repair/Sell Junk at Beega.|
T Learning from the Crystals|QID|9581|M|52.60,53.22|N|To Harbringer Mikolaas.|
A The Missing Survey Team|QID|9620|M|52.60,53.22|N|From Harbringer Mikolaas.|
T Report to Exarch Admetius |QID|9668|M|52.68,53.22|N|To Exarch Admetius.|
T Saving Princess Stillpine|QID|9667|M|55.15,55.99|N|To Stillpine Ambassador Frasaboo.|
T Mac'Aree Mushroom Menagerie|QID|9648|M|56.42,56.83|N|To Jessera of Mac'Aree.|

T The Missing Survey Team|QID|9620|N|To the corpse of the Draenei Cartographer.|M|61.23,48.38|
A Salvaging the Data|QID|9628|N|From the corpse of the Draenei Cartographer.|M|61.23,48.38|
C Salvaging the Data|QID|9628|N|Kill Nagas until the Survey Data Crystal Drops.|M|61.23,48.38|
C Blood Watch|QID|9694|N|Kill Sunhawk Spies north of Blood Watch.|M|49,47|
T Salvaging the Data|QID|9628|N|To Harbringer Mikolaas.|M|52.6,53.23|
A The Second Sample|QID|9584|N|From Harbringer Mikolaas.|M|52.6,53.23|
T Blood Watch|QID|9694|N|To Vindicator Boros.|M|55.42,55.25|
A Intercepting the Message|QID|9779|N|From Vindicator Boros.|M|55.42,55.25|
A Know Thine Enemy|QID|9567|M|55.1,58.0|N|From Vindicator Aalesia.|

C Victims of Corruption|QID|9574|N|Kill Corrupted Treants for the bark.|M|49,73|
K Tzerak |QID|9594|L|23900|N|Kill Tzerak, and loot Tzerak's Armor Plate. He looks like a Felguard. If you don't see him, grind on Satyrs until he yells as he spawns.|M|38.41,82.02|
A Signs of the Legion|QID|9594|U|23900|N|From Tzreak's Armor Plate.|
C Signs of the Legion|QID|9594|N|Kill Satyrs and Felsworns|S|
C Know Thine Enemy|QID|9567|N|Loot the Nazzivus Monument Glyph|L|23859|M|36.49,71.36|
C Signs of the Legion|QID|9594|N|Finish killing Satyrs and Felsworns.|US|M|35.54,77.43|
H Blood Watch|QID|9567|N|Hearth to Blood Watch|U|6948|M|55.84,59.80|
T Know Thine Enemy|QID|9567|N|To Vindicator Aalesia.|M|55.1,58.0|
T Signs of the Legion|QID|9594|N|To Vindicator Aalesia.|M|55.1,58.0|
A Containing the Threat|QID|9569|N|From Vindicator Aalesia.|M|55.1,58.0|
T Victims of Corruption|QID|9574|N|To Morae.|M|53.24,57.73|
A Irradiated Crystal Shards|QID|9641|L|23984 10|O|N|If you already have 10 Irradiated Crystal Shards, then accept this quest from Vindicator Boros.|M|55.42,55.25|
T Irradiated Crystal Shards|QID|9641|O|N|To Vindicator Boros.|M|55.42,55.25|
r Repair/Restock |QID|584|M|53.32,56.67|N|Repair/Sell Junk at Beega.|

C Intercepting the Message|QID|9779|N|Kill Sunhawk Spies until the Sunhawk Missive drops.|S|
C The Second Sample|QID|9584|N|Use the Crystal Mining Pick on the Altered Crystal Sample.|U|23876|M|45.75,47.62|
C Intercepting the Message|QID|9779|N|Kill Sunhawk Spies until the Sunhawk Missive drops.|US|M|45.75,47.62|
N Grinding Time |QID|9584|N|Grind on spies until you are 10,000 XP away from Level 16.|LVL|16|M|45.75,47.62|
T The Second Sample|QID|9584|N|To Harbinger Mikolaas.|M|52.6,53.23|
A The Final Sample|QID|9585|N|From Harbinger Mikolaas.|M|52.6,53.23|
T Intercepting the Message|QID|9779|N|To Vindicator Boros.|M|55.42,55.25|
A Translations...|QID|9696|N|From Vindicator Boros.|M|55.42,55.25|
T Translations...|QID|9696|M|54.4,54.4|N|To Interrogator Elysia.|M|54.4,54.4|
A Audience with the Prophet|QID|9698|N|From Interrogator Elysia.|M|54.4,54.4|
F The Exodar |QID|9698|N|Fly to The Exodar.|M|57.7,53.9|
T Audience with the Prophet|QID|9698|M|32.9,54.5|Z|The Exodar|N|To Prophet Velen.|
A Truth or Fiction|QID|9699|M|32.9,54.5|Z|The Exodar|N|To Prophet Velen.|

N Train new skills |QID|9699|N|Train your skills, professions, etc.|R|Draenei|
H Blood Watch |QID|9699|M|54.43,36.39|N|If your hearth is up, use it to get back to Blood Watch. Otherwise, fly back to Bloodmyst Isle.|U|6948|Z|The Exodar|
T Truth or Fiction|QID|9699|N|To Vindicator Boros.|M|55.42,55.25|
A I Shoot Magic Into the Darkness|QID|9700|N|From Vindicator Boros.|M|55.42,55.25|
r Repair/Restock |QID|10063|M|53.32,56.67|N|Repair/Sell Junk at Beega.|
A Constrictor Vines|QID|9643|M|55.9,57.0|N|From Tracker Lyceon.|M|55.83,56.93|
A The Bear Necessities|QID|9580|N|From Tracker Lyceon.|M|55.83,56.93|
A Explorers' League, Is That Something for Gnomes?|QID|10063|M|56.3,54.2|N|From Prospector Nachlan.|

C Constrictor Vines|QID|9643|N|Kill Mutated Constrictors for 6 Thorny Constrictor Vines. |M|45.9,33.9|S|
C The Bear Necessities|QID|9580|N|Kill Elder Brown Bears until you have 8 flanks. |S|
T Explorers' League, Is That Something for Gnomes?|QID|10063|N|To Clopper Wizbang.|M|42.11,21.23|
A Pilfered Equipment|QID|9548|N|From Clopper Wizbang.|M|42.11,21.23|
A Artifacts of the Blacksilt|QID|9549|N|From Clopper Wizbang.|M|42.11,21.23|
C Artifacts of the Blacksilt|QID|9549|S|N|Kill murlocs for Idols and Knives.|M|41.38,20.11|
C Pilfered Equipment|QID|9548|S|N|Watch for Clopper's Equipment.|M|38.4,22.4;40.4,20;44,22.4;46.4,20.4|
C WANTED: Deathclaw|QID|9646|N|Kill Deathclaw, and loot his Paw.|M|37,30|
C Artifacts of the Blacksilt|QID|9549|US|N|Kill murlocs for Idols and Knives.|M|41.38,20.11|
C Pilfered Equipment|QID|9548|US|N|Look for Clopper's Equipment.|M|38.4,22.4;40.4,20;44,22.4;46.4,20.4|
T Artifacts of the Blacksilt|QID|9549|N|To Clopper Wizbang.|M|42.11,21.23|
T Pilfered Equipment|QID|9548|N|To Clopper Wizbang.|M|42.11,21.23|
A A Map to Where?|QID|9550|U|23837|N|Click the Weathered Treasure Map you just got to start the next quest.|
C I Shoot Magic Into the Darkness|QID|9700|N|Kill Void Anomalies, and approach the entrance to the Warp Piston to get the complete message|M|51.81,21.77|
C Constrictor Vines|QID|9643|N|Kill Mutated Constrictors for 6 Thorny Constrictor Vines. |M|45.9,33.9|US|
C The Bear Necessities|QID|9580|N|Finish killing Elder Brown Bears until you have 8 flanks. |US|M|46.15,34.62;48.77,24.08|
T A Map to Where?|QID|9550|N|There's a book you have to click in order to complete.|M|61.19,41.78|
A Deciphering the Book|QID|9557|N|From the Battered Ancient Book.|M|61.19,41.78|
H Blood Watch |QID|9643|N|Hearth back to Blood Watch.|U|6948|
T Constrictor Vines|QID|9643|N|To Tracker Lyceon.|M|55.83,56.93|
T The Bear Necessities|QID|9580|N|To Tracker Lyceon.|M|55.83,56.93|
A Culling the Flutterers|QID|9647|N|From Tracker Lyceon.|M|55.83,56.93|
T I Shoot Magic Into the Darkness|QID|9700|N|To Vindicator Boros.|M|55.42,55.25|
A The Cryo-Core|QID|9703|N|From Vindicator Kuros.|M|55.64,55.28|
T Deciphering the Book|QID|9557|N|To Anchorite Paetheus.|M|54.69,54.01|
A Nolkai's Words|QID|9561|N|From Anchorite Paetheus.|M|54.69,54.01|
T WANTED: Deathclaw|QID|9646|N|To Harbinger Mikolaas.|M|52.63,53.27|
A Searching for Galaen|QID|9578|M|53.3,57.7|N|From Morae.|
r Repair/Restock |QID|9578|M|53.32,56.67|N|Repair/Sell Junk at Beega.|

C Culling the Flutterers|QID|9647|N|Kill every Royal Blue Flutterer you see.|S|
C The Cryo-Core|QID|9703|N|Loot Medical Supplies from the ground and from Blood Elves.|S|
T Searching for Galaen|QID|9578|M|37.51,61.27|N|To Galaen's Coprse.|
A Galaen's Fate|QID|9579|N|From Galaen's Coprse.|M|37.51,61.27|
A Galaen's Journal - The Fate of Vindicator Saruan|QID|9706|N|From the book on the ground next to Galaen's Coprse.|
C Galaen's Fate|QID|9579|N|The amulet drops off of the Blood Elves outside the Cryo Core.|M|39.27,60.42|
C The Cryo-Core|QID|9703|N|Loot Medical Supplies from the ground and from Blood Elves.|US|M|39.27,60.42|
C Culling the Flutterers|QID|9647|N|Go between the waypoints, and kill the last Royal Blue Flutterers that you need.|US|M|47.21,32.72;43.5,36.58|
T Culling the Flutterers|QID|9647|N|To Tracker Lyceon.|M|55.83,56.93|
T Galaen's Journal - The Fate of Vindicator Saruan|QID|9706|M|55.6,55.2|N|To Vindicator Kuros.|M|55.64,55.28|
A Matis the Cruel|QID|9711|N|From Vindicator Kuros.|M|55.64,55.28|
T The Cryo-Core|QID|9703|N|To Vindicator Kuros.|M|55.64,55.28|
A Don't Drink the Water|QID|9748|N|From Vindicator Aesom.|M|55.57,55.38|
T Galaen's Fate|QID|9579|M|53.3,57.7|N|To Morae.|
A Talk to the Hand|QID|10064|M|52.6,53.2|N|From Harbinger Mikolaas.|
r Repair/Restock |QID|10064|M|53.32,56.67|N|Repair/Sell Junk at Beega.|

A Fouled Water Spirits|QID|10067|N|Behind the tower, accept the quest from Defender Adrielle.|M|51.74,52.13|
C Containing the Threat|QID|9569|N|Head back to Axxarien. Collect 5 Corrupted Crystals while killing Hellcallers and Shadowstalkers, on the way to kill Zevrax.|M|41.6,29.8|S|
C The Final Sample|QID|9585|U|23877|N|Use the pick on the Axxarien crystal|
C Containing the Threat|QID|9569|N|Head back to Axxarien. Collect 5 Corrupted Crystals while killing Hellcallers and Shadowstalkers, on the way to kill Zevrax.|M|41.6,29.8|US|
T Talk to the Hand|QID|10064|N|To Scout Joril.|M|30.27,45.94|
C Fouled Water Spirits|QID|10067|N|Kill 6 Fouled Water Spirits.|M|30,39|
N Grind some more |QID|9569|N|Grind until you are 4,000 XP from level 18.|LVL|18|
C Don't Drink the Water|QID|9748|N|Jump down the waterfall, and use your flask.|U|24318|M|34.37,33.56|
H Blood Watch |QID|9569|N|Hearth back to Blood Watch.|U|6948|
T Containing the Threat|QID|9569|N|To Vindicator Aalesia.|M|55.05,58.01|
T Don't Drink the Water|QID|9748|N|To Vindicator Aesom.|M|55.57,55.38|
A Limits of Physical Exhaustion|QID|9746|N|From Vindicator Aesom.|M|55.57,55.38|
T The Final Sample|QID|9585|M|52.6,53.2|N|To Harbinger Mikolaas.|

A What we Know...|R|Draenei|QID|9753|M|55.6,55.4|N|From Vindicator Aesom.|
T What we Know...|R|Draenei|QID|9753|M|52.66,53.23|N|To Exarch Admetius.|
A What we Don't Know...|R|Draenei|QID|9756|N|From Exarch Admetius.|M|52.66,53.23|
C What we Don't Know...|R|Draenei|QID|9756|M|54.4,54.3|N|Talk to the prisoner.|
T What we Don't Know...|R|Draenei|QID|9756|N|To Exarch Admetius.|M|52.66,53.23|
A Vindicator's Rest|R|Draenei|QID|9760|N|From Exarch Admetius.|M|52.66,53.23|

A Oh, the Tangled Webs They Weave|QID|10066|M|51.7,52.1|N|From Defender Adrielle.|
A The Missing Expedition|QID|9669|M|53.3,57.0|N|From Achelus.|
C Matis the Cruel|QID|9711|N|Use the flare gun! When you get into range, just use your flare gun, and the quest is easy. He pats along the road, you should see him somewhere near Vindicator's Rest.|U|24278|M|31.5,48|
T Fouled Water Spirits|QID|10067|N|To Vindicator Corin.|M|30.6,46.6|
T Vindicator's Rest|R|Draenei|QID|9760|N|To Vindicator Corin.|M|30.6,46.6|
A Cutting a Path|QID|10065|M|30.3,45.9|N|From Scout Joril.|M|30.28,45.88|
A Critters of the Void|QID|9741|N|From Scout Loryi.|M|30.28,45.88|
C Cutting a Path|QID|10065|N|Kill 10 Enraged Ravagers.|M|31.25,56.68|S|
C Oh, the Tangled Webs they Weave|QID|10066|N|Kill 8 Mutated Tanglers.|M|31.25,56.68|
C Cutting a Path|QID|10065|N|Kill 10 Enraged Ravagers.|M|31.25,56.68|US|
C Limits of Physical Exhaustion|QID|9746|M|26,53|S|N|Kill Sunhawk Pyromancers and Defenders.|
C Critters of the Void|QID|9741|M|19,62|N|Kill 12 Void Critters. They are small and can be hard to target sometimes.|
C Limits of Physical Exhaustion|QID|9746|M|26,53|US|N|Finish killing Sunhawk Pyromancers and Defenders.|
A They're Alive! Maybe...|QID|9670|M|24.9,34.3|N|From Researcher Cornelius.|
C They're Alive! Maybe...|QID|9670|S|M|22,36|N|Attack the Webbed Creatures. You may free a Researcher, or you may get a hostile mob.|
C The Missing Expedition |QID|9669|N|Kill spiders on the way, then kill Zarakh.|M|22,36;18,37|
C They're Alive! Maybe...|QID|9670|US|M|22,36|N|Attack the Webbed Creatures. You may free a Researcher, or you may get a hostile mob.|
T They're Alive! Maybe...|QID|9670|M|24.9,34.3|N|To Researcher Cornelius.|
T Cutting a Path|QID|10065|N|To Scout Joril.|M|30.28,45.88|
T Oh, the Tangled Webs they Weave|QID|10066|N|To Vindicator Corin.|M|30.6,46.6|
H Blood Watch |QID|9711|N|Hearth back to Blood Watch.|U|6948|
T Matis the Cruel|QID|9711|N|To Vindicator Kuros.|M|55.61,55.14|
T Limits of Physical Exhaustion|QID|9746|N|To Vindicator Aesom.|M|55.56,55.37|
A The Sun Gate|QID|9740|N|From Vindicator Aesom.|M|55.56,55.37|
T Critters of the Void|QID|9741|N|To Vindicator Aesom.|M|55.56,55.37|
T The Missing Expedition|QID|9669|N|To Achelus.|M|53.25,57.02|
N Go train your skills |QID|9671|N|Train skills, then restock on food/water, etc.|

A Urgent Delivery|QID|9671|N|From Messenger Hermesius, who walks all over Blood Watch.|
N Check your mailbox|QID|9561|N|Urgent Delivery results in a mail sent to your mailbox.|L|24132|M|55.18,59.19|
A The Bloodcurse Legacy|QID|9672|U|24132|N|From A Letter from the Admiral.|
A Ysera's Tears|QID|9649|M|56.4,56.8|N|From Jessera of Mac'Aree.|
T Nolkai's Words|QID|9561|N|It's a pile of dirt.|M|61.2,49.7|
A Restoring Sanctity|QID|9687|M|73.7,33.7|N|From Prince Toreth. He pats around the area.|
T The Bloodcurse Legacy|QID|9672|N|To Captain Edward Hanes.|M|79.14,22.66|
A The Bloodcursed Naga|QID|9674|N|From Captain Edward Hanes.|M|79.14,22.66|
C The Bloodcursed Naga|QID|9674|N|Head into the water and kill Naga.|M|81.33,21.06|
T The Bloodcursed Naga|QID|9674|N|To Captain Edward Hanes.|M|79.14,22.66|
A The Hopeless Ones...|QID|9682|N|From Captain Edward Hanes.|M|79.14,22.66|
C The Hopeless Ones...|QID|9682|N|Kill and loot Bloodcursed Voyagers in and around the submerged ships, until you have 4 Bloodcursed Souls.|M|83,22;87.2,18.5|
N The Captain's Kiss Buff|QID|9682|N|The swim speed and water breathing buff is really useful for another quest. Go back to Captain Edward Hanes, but don't turn in the quest. Ask him to renew the buff on you.|M|79,22|
C Ysera's Tears|QID|9649|N|Loot the green glowing mushrooms from the ground.|S|M|74.55,13.69|
C Restoring Sanctity|QID|9687|N|Loot the bones. They are around where the small Wildkin camps are.|M|60.05,35.47;58.09,29.47|
T Restoring Sanctity|QID|9687|M|73.7,33.7|N|To Prince Toreth.|
A Into the Dream|QID|9688|N|From Prince Toreth.|M|73.7,33.7|
C Into the Dream|QID|9688|N|Kill Veridian Whelps and Broodlings. They are all over the island.|M|72.6,27.78|
T Into the Dream|QID|9688|N|To Prince Toreth.|M|73.7,33.7|
A Razormaw|QID|9689|N|From Prince Toreth.|M|73.7,33.7|
C Razormaw|QID|9689|N|Move to the top of the hill. Clear the whelplings, and get ready for a fight.|U|24221|M|72,20|
C Ysera's Tears|QID|9649|N|Loot the green glowing mushrooms from the ground.|US|M|74.55,13.69|
T The Hopeless Ones...|QID|9682|N|To Captain Edward Hanes. Before turning in, refresh your buff again.|M|79.14,22.66|
A Ending the Bloodcurse|QID|9683|N|From Captain Edward Hanes.|M|79.14,22.66|
T Razormaw|QID|9689|N|To Prince Toreth.|M|73.7,33.7|
C Ending the Bloodcurse|QID|9683|N|Clear the top of the hill, then click the statue, and kill Atoph the Bloodcursed|M|85,54|
T Ending the Bloodcurse|QID|9683|N|To Captain Edward Hanes.|M|79.14,22.66|
N Grind some more|QID|9649|N|Grind on whelplings until you are 1,350 XP from level 20.|LVL|20|
H Blood Watch|QID|9649|N|Hearth back to Blood Watch.|U|6948|
T Ysera's Tears|QID|9649|N|To Jessera of Mac'Aree.|M|56.4,56.8|
F The Exodar|QID|9740|N|Fly to The Exodar and train your new skills.|R|Draenei|M|57.68,53.89|
N If you aren't draenei|QID|9740|N|If you're not draenei, there's only one quest left on bloodmyst that you can do. Decide if you are interested, if not, just follow the next guide.|
N Mount and Skills|N|Find your the trainer and get one. You'll need 4 gold for training and 1 gold for the mount. Also train your skills.|R|Draenei|

F Blood Watch|QID|9740|N|Fly back to Blood Watch.|Z|The Exodar|M|54.46,36.4|R|Draenei|
A Clearing the Way|QID|9761|R|Draenei|N|From Vindicator Corin.|M|30.6,46.6|
A Ending Their World|QID|9759|R|Draenei|M|30.8,46.7|N|From Demolitionist Legoso.|
C Clearing the Way|QID|9761|R|Draenei|S|M|19.8,52.6|N|Kill Sunhawk Agents and Saboteurs. Let the Legoso do most of the workMake sure you do 50%+ dmg to the quest mobs, so you get credit.|
C Ending Their World|QID|9759|N|Follow Legoso, he will stop in 2 places to plant explosives. Then you will have to kill Sironas.|R|Draenei|
C Clearing the Way|QID|9761|R|Draenei|US|M|19.8,52.6|N|Finish killing Sunhawk Agents and Saboteurs.|
C The Sun Gate|QID|9740|N|Go to the Sun Gate. Right click the 4 portal controllers, then right click the Sun Gate.|M|18.95,63.5|
T Clearing the Way|QID|9761|R|Draenei|N|To Vindicator Corin.|M|30.6,46.6|
H Blood Watch|N|Hearth back to Blood Watch.|U|6948|
T The Sun Gate|QID|9740|N|To Vindicator Aesom.|M|55.54,55.42|
T Ending Their World|QID|9759|N|This is one of the best quest turn-ins in WoW. Get ready to enjoy a bit of a show. Turn the quest into Exarch Admetius.|R|Draenei|M|52.6,53.2|
A The Unwritten Prophecy|QID|9762|N|From Prophet Velen. If Prophet Velen despawns before you accept the quest, go to The Exodar to get the quest.|R|Draenei|M|54,55.4|

A Newfound Allies|QID|9632|M|54.69,54.01|N|From Anchorite Paetheus.|
F The Exodar|QID|9632|N|Fly to The Exodar.|M|57.68,53.89|
A Hero's Call: Ashenvale!|QID|28492|M|55.31,47.38|N|From the Hero's Call Board. Will not show up if your level is too high.|Z|The Exodar|
T Newfound Allies|QID|9632|M|24.18,54.33|Z|Azuremyst Isle|N|To Huntress Kella Nightbow.|

N Thus ends Bloodmyst Isles.|N|Next stop Ashenvale. Take the boat or fly to Rutheran Village, then onto Ashenvale. Close this step.|
]]
end)
