
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_azshara
-- Date: 2011-07-11 22:23
-- Who: Ludovicus Maior
-- Log: Tweaks!

-- URL: http://wow-pro.com/node/3217/revisions/24551/view
-- Date: 2011-06-13 21:08
-- Who: Crackerhead22
-- Log: Put in completion step for "A Gigantic Snack" quest suggested by Skully0815.

-- URL: http://wow-pro.com/node/3217/revisions/24321/view
-- Date: 2011-04-29 15:32
-- Who: Ludovicus Maior
-- Log: Line 47 for step C has unknown tag [n], Line 47 for step C has unknown tag [Attack one of the ...], Line 379, for step A non-decimal PRE, Line 609 for step A has 1 M coords, Line 690 for step T has unknown tag [To Kadrak.].

-- URL: http://wow-pro.com/node/3217/revisions/24068/view
-- Date: 2011-01-29 17:01
-- Who: Ludovicus Maior
-- Log: Added QIDs to LVL 18,20 steps.

-- URL: http://wow-pro.com/node/3217/revisions/24020/view
-- Date: 2011-01-20 12:49
-- Who: Ludovicus Maior
-- Log: Optimize quest acceptance for [Military Breakthrough].  Optimize quest ordering for [First Degree Mortar], [Hand-me-downs], and [Military Breakthrough] to minimize time in the minefield.

-- URL: http://wow-pro.com/node/3217/revisions/24011/view
-- Date: 2011-01-18 12:03
-- Who: Ludovicus Maior
-- Log: Added two leadin quests to Azshara.  One in the goblin line and another you can get from the quest boards.

-- URL: http://wow-pro.com/node/3217/revisions/23324/view
-- Date: 2010-12-03 09:00
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3217/revisions/23304/view
-- Date: 2010-12-03 07:31
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3217/revisions/23303/view
-- Date: 2010-12-03 07:30
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('BitAzs1220', 'Azshara', 'Bitsem', '12', '20', 'BitAsh2025', 'Horde', function()


return [[

T Beyond Durotar|O|QID|25648|M|26.84,77.00|N|To Ag'tor Bloodfist.|
T Warchief's Command: Azshara!|O|QID|28496|M|26.84,77.00|N|To Ag'tor Bloodfist.|

A Venison for the Troops|QID|14118|M|26.88,76.98|N|From Ag'tor Bloodfist.|

A The Eyes of Ashenvale|QID|14117|M|26.88,76.98|N|From Ag'tor Bloodfist.|

C Venison for the Troops|QID|14118|S|M|27.98,68.76|N|Kill Weakened Mosshoof Stags and Talrendis Scouts while you are doing the next few quests.|
C The Eyes of Ashenvale|QID|14117|S|M|29.80,74.71|N|Kill 8 Talrendis Scouts. If you loot Scout's Orders, activate the quest Return of the Highborne?|

T Report to the Labor Captain|O|QID|25275|M|26.93,77.04|N|To Labor Captain Grabbit|
A Runaway Shredder!|QID|14129|M|26.93,77.04|N|From Labor Captain Grabbit.|

C Runaway Shredder!|QID|14129|M|27.00,72.83|N|Attack one of the runaway shredders and hop inside when it's damaged enough.|

T Runaway Shredder!|QID|14129|M|27.00,72.83|N|To Reprogrammed Shredder.|
A The Captain's Logs|QID|14134|PRE|14129|M|27.00,72.83|N|From Reprogrammed Shredder.|

C The Captain's Logs|QID|14134|M|26.45,75.40|N|Use the Reprogrammed Shredder to collect 6 piles of Azshara Lumber.|

T The Captain's Logs|QID|14134|M|26.45,75.40|
A Up a Tree|QID|14135|PRE|14134|M|26.98,77.08|N|From Labor Captain Grabbit.|

C Up a Tree|QID|14135|M|23.08,74.40|N|Use the shredder's buzzsaw to cut down Azshara Saplings, kill 9 Talrendis Snipers as they emerge.|

T Up a Tree|QID|14135|M|23.08,74.40|
A Defend the Gates!|QID|14146|PRE|14135|M|23.08,74.40|

C Defend the Gates!|QID|14146|M|27.08,76.63|N|Go back to the Rear Gate of Orgrimmar to slay 20 Night Elf Raiders.|

T Defend the Gates!|QID|14146|M|26.91,77.02|
A Arborcide|QID|14155|PRE|14146|M|26.91,77.02|

C Arborcide|QID|14155|M|21.92,75.71|N|Use the shredder to destroy the Talrendis Ancient.|
C Venison for the Troops|QID|14118|US|M|27.98,68.76|N|Exit Shredder.Collect 15 Slabs of Venison from Weakened Mosshoof Stags.|
C The Eyes of Ashenvale|QID|14117|US|M|29.80,74.71|N|Kill 8 Talrendis Scouts. |

A Return of the Highborne?|QID|14127|RANK|2|M|29.95,74.40|U|47039|N|From the Scout's Orders you looted.|
T Arborcide|QID|14155|M|26.90,77.06|N|To Labor Captain Grabbit.|

A Report to Horzak|QID|14162|M|26.90,77.06|N|From Labor Captain Grabbit.|
T Venison for the Troops|QID|14118|M|26.87,76.90|N|To Ag'tor Bloodfist.|

L Level 13|QID|14127|LVL|13|N|You should be around level 13 by this point.|

T The Eyes of Ashenvale|QID|14117|M|26.87,76.90|N|To Ag'tor Bloodfist.|

T Return of the Highborne?|QID|14127|M|26.87,76.90|N|To Ag'tor Bloodfist.|
A Return of the Highborne?|QID|14128|PRE|14127|RANK|2|M|26.87,76.90|N|From Ag'tor Bloodfist.|

T Return of the Highborne?|QID|14128|M|29.65,66.96|N|To Malynea Skyreaver.|
T Report to Horzak|QID|14162|M|29.15,66.34|N|To Horzak Zignibble.|
A Basilisk Bashin'|QID|14161|PRE|14162|M|29.15,66.34|N|From Horzak Zignibble.|
A Stone Cold|QID|14165|M|29.15,66.34|N|From Horzak Zignibble.|
A A Quota to Meet|QID|14197|M|29.21,66.44|N|From Foreman Fisk.|

C A Quota to Meet|QID|14197|S|M|23.20,67.44|N|Gather 20 ingots of Mountainfoot Iron.|
C Basilisk Bashin'|QID|14161|M|25.50,68.50|N|Kill Greystone Basilisks while you search for a stonified Mountainfoot Miner at the Mountainfoot Strip Mine.|
N Stone Cold|QID|14165|NC|M|26.56,68.50|N|Make sure you get a stonified Mountainfoot Miner on your back.|

T Basilisk Bashin'|QID|14161|M|29.17,66.35|N|To Horzak Zignibble.|

L Level 14|QID|14197|LVL|14|N|You should be around level 14 by this point.|

T Stone Cold|QID|14165|M|29.17,66.35|N|To Horzak Zignibble.|
A The Perfect Prism|QID|14190|PRE|14165|M|29.17,66.35|N|From Horzak Zignibble.|

C The Perfect Prism|QID|14190|M|21.57,66.10|N|Kill Talrendis Saboteurs until you loot a Crystal Pendant.|
C A Quota to Meet|QID|14197|US|M|23.20,67.44|N|Gather 20 ingots of Mountainfoot Iron.|

T The Perfect Prism|QID|14190|M|20.29,70.31|
A Prismbreak|QID|14192|PRE|14190|M|20.29,70.31|

T Prismbreak|QID|14192|M|20.09,70.06|N|To Marius Tanolaar.|
A Refleshification|QID|14194|PRE|14192|M|20.09,70.06|

C Refleshification|QID|14194|U|48104|M|24.56,72.63|N|Use The Refleshifier to de-stonify eight Mountainfoot Miners.|

T A Quota to Meet|QID|14197|M|29.15,66.27|N|To Foreman Fisk.|
T Refleshification|QID|14194|M|29.16,66.33|N|To Horzak Zignibble.|

A Another Warm Body|QID|14468|M|29.44,66.76|RANK|2|N|From Private Worcester.|
T Another Warm Body|QID|14468|M|29.43,57.68|N|To Commander Molotov.|
A Hand-me-downs|QID|14469|RANK|2|M|29.43,57.68|N|From Commander Molotov.|
A Military Breakthrough|QID|14470|RANK|2|M|29.43,57.68|N|From Glix Grindlock.|
A First Degree Mortar|QID|14471|RANK|2|M|29.13,57.90|N|From Xiz "The Eye" Salvoblast.|

C Military Breakthrough|QID|14470|M|27.63,51.91|N|Kill Warlord Krellen and recover the SFG.|
C Hand-me-downs|QID|14469|S|M|27.75,54.06|N|Retrieve 12 Military Supply Packs from the central minefield.|
C First Degree Mortar|QID|14471|M|31.10,57.63|N|Use a Goblin Mortar to slaughter 60 Spitelash Attackers.|
T First Degree Mortar|QID|14471|M|29.20,57.91|N|To Xiz "The Eye" Salvoblast.|

C Hand-me-downs|QID|14469|US|M|27.75,54.06|N|Retrieve 12 Military Supply Packs from the central minefield.|

T Military Breakthrough|QID|14470|M|29.32,57.71|N|To Glix Grindlock.|
L Level 15|QID|14471|LVL|15|N|You should be around level 15 by this point.|
T Hand-me-downs|QID|14469|M|29.41,57.68|N|To Commander Molotov.|
A In The Face!|QID|14472|RANK|2|M|29.41,57.68|N|From Glix Grindlock.|

C In The Face!|QID|14472|M|31.44,60.75|N|Use an SFG to kill an Enslaved Son of Arkkoroc in the southern minefield.|

T In The Face!|QID|14472|M|29.38,57.71|N|To Glix Grindlock.|
A Profitability Scouting|QID|24452|RANK|2|M|29.38,57.71|N|From Commander Molotov.|

C Profitability Scouting|QID|24452|NC|U|49701|M|31.31,49.92|N|Use the stealth field generator to infiltrate the Ruins of Eldarath and identify the Heart of Arkkoroc.|

T Profitability Scouting|QID|24452|M|29.47,57.78|N|To Commander Molotov.|
A Private Chat|QID|24453|PRE|24452|RANK|2|M|29.47,57.78|N|From Commander Molotov.|
T Private Chat|QID|24453|M|29.55,66.73|N|Back to the Orgrimmar Rocketway Exchange, to Private Worcester.|
A A Thousand Stories in the Sand|QID|14201|M|29.7,66.9|N|From Malynea Skyreaver.|
A Survey the Lakeshore|QID|14202|M|29.71,67.11|N|From Custer Clubnik.|N|Protect the goblin that you call with the beacon, while they survey the West, North and East Markers.|

C Survey the Lakeshore|QID|14202|U|48665|S|M|34.79,71.77|U|48665|N|Collect Recovered Artifacts while on your way to use the Surveyor's Beacon at the Markers on the West, North and East banks of the lake.|
C A Thousand Stories in the Sand|QID|14201|M|33.57,74.65|
C Survey the Lakeshore|QID|14202|U|48665|US|M|34.29,76.66;34.79,71.77;37.40,74.60|U|48665|N|Collect Recovered Artifacts while on your way to use the Surveyor's Beacon at the Markers on the West, North and East banks of the lake.|

T A Thousand Stories in the Sand|QID|14201|M|29.64,66.86|N|To Malynea Skyreaver.|
A Memories of the Dead|QID|14215|PRE|14201|M|29.64,66.86|N|From Malynea Skyreaver.|
T Survey the Lakeshore|QID|14202|M|29.71,67.11|N|To Custer Clubnik.|

C Memories of the Dead|QID|14215|M|36.57,72.50;37.52,74.53|N|Talk to the Spirit of Kalytha then follow the arrow to Archmage Selwyn.|

T Memories of the Dead|QID|14215|M|37.52,74.53|
A Mystery of the Sarcen Stone|QID|14216|PRE|14201|M|37.52,74.53|

C Mystery of the Sarcen Stone|QID|14216|M|35.52,75.28|N|Open the Ancient Stone Cask at the bottom of the Lake.

T Mystery of the Sarcen Stone|QID|14216|M|29.66,66.88|N|To Malynea Skyreaver.|
A Gunk in the Trunk|QID|14209|PRE|14202|M|29.71,67.11|N|From Custer Clubnik.|

C Gunk in the Trunk|QID|14209|M|30.02,67.37|N|Click on the Dozer and kill the Ectoplasmic Exhaust that appears. Loot the sample.|

T Gunk in the Trunk|QID|14209|M|29.73,67.15|N|To Custer Clubnik.|
A Dozercism|QID|14423|PRE|14209|M|29.73,67.15|N|From Custer Clubnik. USe the Blessed Flaregun by Clubnik's Dozer. Be sure you have the Dozer targeted when the priest appears.|

C Dozercism|QID|14423|U|49350|M|28.94,66.54|

T Dozercism|QID|14423|M|29.62,67.07|N|To Custer Clubnik.|
A Need More Science|QID|14424|M|29.62,67.07;29.39,66.63|N|From Custer Clubnik. Ride the lift to the top of the tower and talk to the goblin for a rocket ride to the Southern Rocketway Terminus.|

T Need More Science|QID|14424|M|50.38,74.25|N|To Assistant Greely. Go to the top of the tower and ride the rocket to Southern Rocketway Terminus.|
L Level 16|QID|14424|LVL|16|N|You should be around level 16 by this point.|
A When Science Attacks|QID|14308|PRE|14424|M|50.38,74.25|N|From Assistant Greely.|

f Southern Rocketway Terminus|QID|14308|M|51.42,74.33|N|At Friz Groundspin.|

A Mortar the Point|QID|14258|M|52.17,74.22|N|From Bombardier Captain Smooks.|
A Bad Science! Bad!|QID|14322|M|45.09,75.46|N|From Twistex Happytongs.|

C Mortar the Point|QID|14258|M|43.11,77.18|U|49132|N|Put out fires as you go.|
C When Science Attacks|QID|14308|U|49132|M|43.39,76.07|

A Nine's Plan|QID|14408|RANK|2|M|42.19,76.13|N|From Subject Nine.|

C Bad Science! Bad!|QID|14322|M|44.40,79.00|

T Bad Science! Bad!|QID|14322|M|45.06,75.53|N|To Twistex Happytongs.|

C Nine's Plan|QID|14408|M|45.97,76.06|N|Activate the Buzzer. It looks like a torch to the right of the locked door.|

T Nine's Plan|QID|14408|M|42.22,76.12|N|To Subject Nine.|

A Raptor Raptor Rocket|QID|14422|PRE|14408|RANK|2|M|42.22,76.12|N|From Subject Nine.|

C Raptor Raptor Rocket|QID|14422|M|42.21,76.09|N|Go back down, Free 5 raptors and return to Subject Nine with them.|

T Raptor Raptor Rocket|QID|14422|M|42.21,76.09|N|To Subject Nine.|
T When Science Attacks|QID|14308|M|43.80,77.36|
A Segmentation Fault: Core Dumped|QID|14310|PRE|14308|M|43.80,77.36|

C Segmentation Fault: Core Dumped|QID|14310|U|49132|M|49.37,74.92|N|Pull the lever! Use the Extinguisher on the cart when it starts flaming.|

T Segmentation Fault: Core Dumped|QID|14310|M|50.38,74.28|N|To Assistant Greely.|
A Mysterious Azsharite|QID|14370|M|50.38,74.28|N|From Assistant Greely.|
A A Gigantic Snack|QID|14371|M|50.38,74.28|N|From Assistant Greely.|

T Mortar the Point|QID|14258|M|52.21,74.23|N|To Bombardier Captain Smooks.|
A To Gut a Fish|QID|14262|M|50.70,75.23|N|From Torg Twocrush.|
A Investigating the Sea Shrine|QID|14267|M|50.70,75.23|N|From Torg Twocrush.|

L Level 17|QID|14267|LVL|17|N|You should be around level 17 by this point.|
C A Gigantic Snack|QID|14371|M|46.7,72.2|N||S|
C Mysterious Azsharite|QID|14370|M|50.55,82.10|
C A Gigantic Snack|QID|14371|M|46.7,72.2|N||US|
C To Gut a Fish|QID|14262|M|55.49,76.45|S|

T Investigating the Sea Shrine|QID|14267|M|58.98,71.98|
A The Keystone Shard|QID|14270|PRE|14267|M|58.98,71.98|

C The Keystone Shard|QID|14270|M|57.57,71.02|

T The Keystone Shard|QID|14270|M|58.99,71.93|
A Report to Twocrush|QID|14271|PRE|14270|M|58.99,71.93|

C To Gut a Fish|QID|14262|M|55.49,76.45|US|

T To Gut a Fish|QID|14262|M|50.70,75.24|N|To Torg Twocrush.|
T Report to Twocrush|QID|14271|M|50.69,75.20|N|To Torg Twocrush.|
A Sisters of the Sea|QID|14295|PRE|14271|RANK|3|M|50.69,75.20|N|From Torg Twocrush.|
T Mysterious Azsharite|QID|14370|M|50.45,74.37|N|To Assistant Greely.|
T A Gigantic Snack|QID|14371|M|50.45,74.37|N|To Assistant Greely.|
A Befriending Giants|QID|14377|M|50.45,74.37|N|From Assistant Greely.|

C Sisters of the Sea|QID|14295|M|57.57,75.80;63.13,79.38;62.81,76.32|N|Kill Lady Vesthra and Lady Silisthra and disable the Power Stones behind them.|

T Sisters of the Sea|QID|14295|M|50.70,75.21|N|To Torg Twocrush.|

C Befriending Giants|QID|14377|M|47.78,75.47|

T Befriending Giants|QID|14377|M|50.39,74.30|N|To Assistant Greely.|
A Azsharite Experiment Number One|QID|14385|PRE|14377|M|50.39,74.30|N|From Assistant Greely.|
A The Terrible Tinkers of the Ruined Reaches|QID|14383|M|50.50,74.75|N|From Hobart Grapplehammer.|
L Level 18|QID|14383|LVL|18|N|You should be around level 18 by this point.|

C The Terrible Tinkers of the Ruined Reaches|QID|14383|S|M|43.49,83.00;40.07,84.43|N|Follow the lit path West, kill gnomes on your way to Bingham Gadgetspring inside the house. Kill him.|
C Azsharite Experiment Number One|QID|14385|PRE|14377|M|43.49,83.00;40.07,84.43|QO|Giant-Sized Laxative: 1/1|N|The Laxative is upstairs in Bingham's house.|
C Azsharite Experiment Number One|QID|14385|PRE|14377|M|47.8,75.5|QO|Try to Feed Gormungan: 1/1|
C The Terrible Tinkers of the Ruined Reaches|QID|14383|US|M|43.49,83.00;40.07,84.43|N|Kill the rest of the gnomes needed to finish the quest.|

T Azsharite Experiment Number One|QID|14385|M|50.38,74.29|N|To Assistant Greely.|
A Azsharite Experiment Number Two|QID|14388|PRE|14385|M|50.38,74.29|N|From Assistant Greely.|
T The Terrible Tinkers of the Ruined Reaches|QID|14383|M|50.51,74.74|N|To Hobart Grapplehammer.|

C Azsharite Experiment Number Two|QID|14388|M|50.38,74.29;47.71,75.51|N|Talk to Assistant Greely when you're ready to shrink. Hop on a rat and run to Gormungan.|

T Azsharite Experiment Number Two|QID|14388|M|50.39,74.29|N|To Assistant Greely.|
A A Hello to Arms|QID|24458|M|50.53,74.77;51.48,74.32|N|From Hobart Grapplehammer.|
A Operation Fishgut|QID|14478|M|56.99,50.13|N|Speak with Friz Groundspin for a free airlift. From the poster|
h Bilgewater Harbor|QID|14478|M|57.02,50.29|N|At Grimy Greasefingers.|
f Bilgewater Harbor|QID|14340|M|52.95,49.85|N|At Kroum.|
A Azshara Blues|QID|14407|M|59.38,50.68|N|From Teemo.|

T A Hello to Arms|QID|24458|M|60.51,50.86|N|To Bleenik Fizzlefuse.|
T Operation Fishgut|QID|14478|M|60.62,50.67|N|To Commander Molotov.|
A Rapid Deployment|QID|24455|PRE|14478|M|60.62,50.67|N|From Commander Molotov.|
T Rapid Deployment|QID|24455|M|58.07,52.32|N|To Captain Desoto.|
A There Are Many Like It|QID|14479|PRE|24455|M|58.07,52.32|N|From Captain Desoto.
A First Come, First Served|QID|24437|M|39.13,51.63|N|From Ruckus.||N|Hop on the rocket when you're ready to leave.|
T There Are Many Like It|QID|14479|M|41.50,53.63|N|To Lieutenant Drex.|

L Level 19|QID|14324|LVL|19|N|You should be around level 19 by this point.|

A Mop Up|QID|24435|PRE|14479|M|41.50,53.63|N|From Lieutenant Drex.|
A Halo Drops|QID|24436|M|41.41,53.92|N|From Sergeant Hort.|

C Mop Up|QID|24435|PRE|14479|S|U|49679|M|41.50,53.63|N|Kill Naga and and use Flare near Wounded Soldiers whole setting flags for First Come, First Served.|
C First Come, First Served|QID|24437|U|49685|M|43.84,59.85;43.61,43.44;45.46,38.54|N|Set flags at these blue glowing points.|
C Halo Drops|QID|24436|U|49679|M|41.41,53.92|N|Use the Flare Gun near Wounded Soldiers.|
C Mop Up|QID|24435|PRE|14479|US|M|41.50,53.63|N|Finish killing Nagas for this quest.|

T First Come, First Served|QID|24437|M|39.13,51.63|N|To Ruckus.|
T Mop Up|QID|24435|M|41.50,53.63|N|To Lieutenant Drex.|
T Halo Drops|QID|24436|M|41.41,53.92|N|To Sergeant Hort.|

A Field Promotion|QID|24448|PRE|24436|M|41.50,53.63|N|From Lieutenant Drex.|
T Field Promotion|QID|24448|M|34.34,44.89|N|To Captain Tork.|
A Still Beating Heart|QID|14487|PRE|24448|M|34.34,44.89|N|From Captain Tork.|
A Extermination|QID|14480|M|34.44,44.77|N|From Sergeant Zelks.|
A Head of the Snake|QID|14484|PRE|14487|M|34.44,44.77|N|From Sergeant Zelks.|
A Ticker Required|QID|14485|PRE|14487|M|34.44,44.77|N|From Sergeant Zelks.|
A Handling the Goods|QID|14486|PRE|14487|M|34.52,44.71|N|From Tora Halotrix.|

C Handling the Goods|QID|14486|U|49629|S|M|35.11,49.95|N|Collect 12 Highborne Tablets from the Ruins of Eldarath.|
C Extermination|QID|14480|U|49629|S|M|33.49,48.16|N|Kill 30 Spitelash Naga in the Ruins of Eldarath.|
C Ticker Required|QID|14485|U|49629|M|34.12,48.13;34.26,51.79;35.35,49.85|N|Bring Ticker into the ruins and cover him as he sets up bombs at 3 of the Spitelash Runestones. Last one is on second floor.|
C Head of the Snake|QID|14484|U|49629|M|34.44,44.77|N|Kill Lord Kassarus. Pick up the Impaling Spines he throws and throw them back during the fight. Lots of Highborne Tablets in here.|
C Still Beating Heart|QID|14487|U|49629|M|31.92,50.20|N|Recover the Heart of Arkkoroc from the center of the Ruins of Eldarath.|
C Handling the Goods|QID|14486|U|49629|US|M|35.11,49.95|N|Collect 12 Highborne Tablets from the Ruins of Eldarath.|
C Extermination|QID|14480|U|49629|US|M|33.49,48.16|N|Kill 30 Spitelash Naga in the Ruins of Eldarath.|

T Still Beating Heart|QID|14487|M|34.34,44.89|N|To Captain Tork.|
T Head of the Snake|QID|14484|M|34.44,44.77|N|To Sergeant Zelks.|
T Ticker Required|QID|14485|M|34.44,44.77|N|To Sergeant Zelks.|
T Extermination|QID|14480|M|34.44,44.77|N|From Sergeant Zelks.|
T Handling the Goods|QID|14486|M|34.52,44.71|N|To Tora Halotrix.|
A Shore Leave|QID|24449|PRE|14485|M|34.33,44.88;34.48,44.59|N|From Captain Tork.
T Shore Leave|QID|24449|M|60.59,50.57|N|To Uncle Bedlam. Hop on Copter when ready to leave.|
L Level 20|QID|14407|LVL|20|N|You should be around level 20 by this point.|

T Azshara Blues|QID|14407|M|55.47,52.16|N|To Kalec.|
A Friends Come In All Colors|QID|14130|PRE|14407|M|55.47,52.16|N|From Kalec.|
T Friends Come In All Colors|QID|14130|M|70.33,36.28|N|Take the flight path the to Southern Terminus and then ride the rocket to the Northern Terminus. To Ergll.|
A A Little Pick-me-up|QID|14131|M|70.33,36.28|N|From Ergll.|
A That's Just Rude!|QID|14132|M|70.33,36.28|N|From Ergll.|
A Absorbent|QID|14323|M|70.33,36.28|N|From Ergll.|

C That's Just Rude!|QID|14132|S|M|71.58,36.23|N|Collect Kawphi Beans and kill Makrinni while collecting Simmering Water Droplets.|
C A Little Pick-me-up|QID|14131|S|
C Absorbent|QID|14323|M|82.13,40.46|U|49168|N|Use the Enchanted Azshari Sea Sponge and run past the Vile Splashes.|

T Absorbent|QID|14323|M|81.91,40.71|
A Full of Hot Water|QID|14324|PRE|14323|M|81.91,40.71|N|Obtain a Globe of Boiling Water from a Scalding Water Lord at the Tower of Eldara.|

C Full of Hot Water|QID|14324|U|49176|M|81.18,30.62|N|Use the sponge, kill Scalding Water Lord, loot the Globe.|
C A Little Pick-me-up|QID|14131|M|72.58,34.56|N|Collect 10 Kawphi Beans. lol. Kawphi...Coffee! Nice!|
C That's Just Rude!|QID|14132|US|M|71.58,36.23|N|Kill 10 Makrinni in the Ruins of Arkkoran.|

T A Little Pick-me-up|QID|14131|M|70.36,36.25|N|To Ergll.|
T That's Just Rude!|QID|14132|M|70.36,36.25|N|To Ergll.|
T Full of Hot Water|QID|14324|M|70.36,36.25|N|To Ergll.|
A Wash Out|QID|14345|M|70.36,36.25|N|From Ergll.|N|Take a magic turtle ride.|
T Wash Out|QID|14345|M|42.73,25.20|N|To Sorata Firespinner.|
A Dressed to Impress|QID|14340|PRE|14345|M|42.73,25.20|N|From Sorata Firespinner.|N|Put on your new wizard hat and then speak to the Image of Archmage Xylem just northeast of the Northern Rocketway Exchange. |
A The Blackmaw Scar|QID|14431|M|42.40,23.62|N|From Haggrum Bloodfist.|

C The Blackmaw Scar|QID|14431|US|M|37.50,34.06|N|Slay 8 Talrendis Biologists and gather up Blackmaw Intelligence from one of the bodies.|

T The Blackmaw Scar|QID|14431|M|42.40,23.71|N|To Haggrum Bloodfist.|
A A Pale Brew|QID|14432|M|42.40,23.71|N|From Haggrum Bloodfist.|
A Diplomacy by Another Means|QID|14433|M|42.40,23.71|N|From Haggrum Bloodfist.|

C A Pale Brew|QID|14432|S|M|30.27,39.35|N|Gather up 10 samples of Briaroot Brew from outside Blackmaw Hold.|
C Diplomacy by Another Means|QID|14433|M|29.83,38.58|N|Gather a Blackmaw Meeting Agenda at Blackmaw Hold, and kill a Talrendis Ambassador to collect her Ambassador's Robes.|
C A Pale Brew|QID|14432|US|M|30.27,39.35|N|Gather up 10 samples of Briaroot Brew from outside Blackmaw Hold.|

T A Pale Brew|QID|14432|M|42.43,23.61|N|To Haggrum Bloodfist.|
T Diplomacy by Another Means|QID|14433|M|42.43,23.61|N|To Haggrum Bloodfist.|
A The Blackmaw Doublecross|QID|14435|M|42.43,23.61|N|From Haggrum Bloodfist.|

C The Blackmaw Doublecross|QID|14435|U|49368|M|42.65,23.71;32.13,30.41|N|Use Ambassador Disguise, talk to Andorel when you're ready. Speak with Ungarl to wreck the negotiations, then kill 4 Blackmaw Warriors and 4 Blackmaw Shaman on your way out. |

T The Blackmaw Doublecross|QID|14435|M|42.39,23.62|N|To Haggrum Bloodfist.|

C Dressed to Impress|QID|14340|NC|U|49201|M|47.76,18.35;47.22,20.83|N|Follow the path up the hill.|

T Dressed to Impress|QID|14340|M|47.22,20.83|N|To Image of Archmage Xylem.|

A Renewable Resource|QID|14250|M|47.30,21.16|N|From Tharkul Ironskull.|
A Shear Will|QID|14249|M|47.13,21.10|N|From Will Robotronic.|
A Waste of Thyme|QID|14263|M|47.04,21.02|N|From Quarla Whistlebreak.|
A Amberwind's Journal|QID|14428|M|42.59,23.72|N|From Andorel Sunsworn.|

C Waste of Thyme|QID|14263|S|M|49.27,18.71|N|Kill Hippogryphs and collect Living Ire Thyme while doing next quests. Almost impossible to see on the ground, watch for sparkles.|
C Renewable Resource|QID|14250|U|49038|M|52.10,20.10|N|Use the Arcane Charge in front of Balboa near the Ruins of Nordressa, loot 5 Animate Basalt after it goes off.|
C Amberwind's Journal|QID|14428|M|49.85,28.43|N|Slay Lorekeeper Amberwind at the Darnassian Base Camp and retrieve her journal.|

T Amberwind's Journal|QID|14428|M|49.53,28.73|
A Arcane De-Construction|QID|14429|PRE|14428|M|49.53,28.73|

C Arcane De-Construction|QID|14429|M|52.49,26.79|N|Slay Apprentice Investigators and Apprentice Illuminators to collect 10 Attuned Runestones.|

T Arcane De-Construction|QID|14429|M|52.99,29.00|
A Hacking the Construct|QID|14430|PRE|14429|M|52.99,29.00|

C Hacking the Construct|QID|14430|NC|M|52.97,29.84|N|Speak with the Arcane Construct at the Darnassian Base Camp and utter the words of arcane power.|
C Shear Will|QID|14249|M|42.38,18.43|N|Obtain 80 Pristine Thunderhead Feathers from the Hippogryphs near the Ruins of Nordressa.|
C Waste of Thyme|QID|14263|US|M|49.27,18.71|N|Collect 8 bundles of Living Ire Thyme near the Ruins of Nordressa. Almost impossible to see on the ground, watch for sparkles. You get 20% damage reduction per patch you pick up.|

T Waste of Thyme|QID|14263|M|47.04,21.02|N|To Quarla Whistlebreak.|
T Shear Will|QID|14249|M|47.11,21.04|N|To Will Robotronic.|
T Renewable Resource|QID|14250|M|47.28,21.19|N|To Tharkul Ironskull.|
A Manual Labor|QID|14230|M|47.22,21.24|N|From Teresa Spireleaf.|
A Trouble Under Foot|QID|14226|M|47.23,20.83|N|From Image of Archmage Xylem.|

L Level 21|QID|14226|LVL|21|N|You should be around level 21 by this point.|

C Trouble Under Foot|QID|14226|S|M|54.17,23.96|N|Use the polymorph spell on demons and kill them while looking for the Manual.|
C Manual Labor|QID|14230|M|55.23,25.07|N|Retrieve the Abjurer's Manual from the Lagash Encampment.|
C Trouble Under Foot|QID|14226|US|M|54.17,23.96|N|Use your Personal Arcane Assistant to turn 12 Legash demons into insects and then squash them.|

T Trouble Under Foot|QID|14226|M|47.18,20.83|N|To Image of Archmage Xylem. Use your personal Arcane Assistant to port you back.|
T Manual Labor|QID|14230|M|47.28,21.20|N|To Teresa Spireleaf.|
A The Pinnacle of Learning|QID|14413|M|47.28,20.80|N|From Image of Archmage Xylem.|N|I found the next quest incredibly annoying, but there are quite a few after it, so it's your call.|
T The Pinnacle of Learning|QID|14413|M|55.67,14.66|N|To Image of Archmage Xylem.|
A Watch Your Step|QID|14296|PRE|14413|M|55.67,14.66|N|From Image of Archmage Xylem.|

C Watch Your Step|QID|14296|M|55.95,11.89|N|Click on every conduit and run to the glowing circles to jump. Don't get hit by energy charges or you start over.|

T Watch Your Step|QID|14296|M|55.92,12.20|N|To Image of Archmage Xylem.|
A The Trial of Fire|QID|14300|PRE|14296|M|55.92,12.20|N|From Image of Archmage Xylem.|
A The Trial of Frost|QID|24478|PRE|14296|M|55.92,12.20|N|From Image of Archmage Xylem.|
A The Trial of Shadow|QID|24479|PRE|14296|M|55.92,12.20|N|From Image of Archmage Xylem.|

C The Trial of Shadow|QID|24479|M|31.06,26.76|N|Lure 20 Weeping Souls into the shadow runes. Every time one hits you, you lose one.|

T The Trial of Shadow|QID|24479|M|31.06,26.76|N|To Image of Archmage Xylem.|
C The Trial of Fire|QID|14300|M|32.98,23.59|N|Stand in the fire runes without getting hit by flame for 10 consecutive bursts. Watch for flares before they flame.|

T The Trial of Fire|QID|14300|M|32.98,23.59|N|To Image of Archmage Xylem.|
C The Trial of Frost|QID|24478|M|61.98,21.02|N|Collect 20 small ice orbs. Getting hit by Frostburns will lose some. Can use runes to jump straight up.|

T The Trial of Frost|QID|24478|M|62.16,21.16|N|To Image of Archmage Xylem.|
A Xylem's Asylum|QID|14299|M|55.92,12.17|N|From Image of Archmage Xylem.|

T Xylem's Asylum|QID|14299|M|56.17,12.11;25.54,38.01|N|To Joanna. Take the portal at 56.17,12.11.|

A Wasn't It Obvious?|QID|14389|PRE|14299|M|25.54,38.01|N|From Joanna.|

C Wasn't It Obvious?|QID|14389|NC|M|27.75,40.81|N|Take the portal behind her.|

L Level 22|QID|14389|LVL|22|N|You should be around level 22 by this point.|

T Wasn't It Obvious?|QID|14389|M|27.79,40.62|
A Easy is Boring|QID|14390|PRE|14389|M|27.79,40.62|

C Easy is Boring|QID|14390|NC|M|27.88,40.21|N|Talk to Azuregos.|

T Easy is Boring|QID|14390|M|27.88,40.21|N|To Spirit of Azuregos.|
A Turning the Tables|QID|14391|PRE|14390|M|27.88,40.21|N|From Spirit of Azuregos.|
T Hacking the Construct|QID|14430|M|66.59,20.39;42.58,23.72|N|Talk to Anara and rez. Turn in to Andorel Sunsworn.|
T Turning the Tables|QID|14391|M|66.59,20.39|N|Take the Rocket to the Northern Rocketway Terminus. Turn in to Kalec.|
A Fade to Black|QID|24467|M|66.51,20.34|N|From Kalec.|
A Pro-liberation|QID|14297|M|66.42,20.29|N|From Jellix Fuselighter.|
A Ice Cold|QID|14261|M|66.57,19.63|N|From Feno Blastnoggin.|

f Bitter Reaches|QID|14435|M|66.45,20.93|N|At Blitz Blastospazz.|

C Ice Cold|QID|14261|S|N|Kill cultists and dragonkin for keys and free Goblin Workers.|

C Fade to Black|QID|24467|M|71.74,16.39|N|Kill Twilight Lord Katrana and Malicion in Sable Ridge.|

T Fade to Black|QID|24467|M|71.79,16.68|N|To Kalecgos.|

C Pro-liberation|QID|14297|M|69.16,16.89|N|Kill cultists and dragonkin for Ironwrought Keys, use them to free 4 Goblin Workers.|

C Ice Cold|QID|14261|U|49596|US|M|69.59,19.40|N|Use the Cryomatic 16 to freeze and kill 8 Sable Drakes. Usually flying or on top of hills.|

T Ice Cold|QID|14261|M|66.57,19.63|N|To Blastnoggin.|
T Pro-liberation|QID|14297|M|66.42,20.29|N|To Jellix Fuselighter.|
A Farewell, Minnow|QID|14392|PRE|24467|M|67,20.4|N|From Azuregos.|

H Bilgewater Harbor|QID|14392|U|6948|

T Farewell, Minnow|QID|14392|M|53.53,49.05|N|Speak to Sorata Firespinner in Bilgewater Harbor.|
A Airborne Again|QID|24497|PRE|14392|M|53.00,49.00|N|Secure a ride to Valermok with the Airborne Priests in the eastern portion of Bilgewater Harbor.|

R Wings of Steel|QID|24497|M|60.58,52.55|CC|N|Hop in a Wings of Steel and fly to Valormok.|
T Airborne Again|QID|24497|PRE|14392|M|13.98,64.78|N|To Chawg.|

A Where's My Head?|QID|14462|M|13.98,64.78|N|From Chawg.|
A Let Them Feast on Fear|QID|24433|M|13.98,64.78|N|From Chawg.|
A Commando Drop|QID|24434|M|13.87,64.50|N|From Andorel Sunsworn.|

f Valormok|QID|24434|M|14.33,65.01|N|At Kroum.|
A Grounded!|QID|14475|M|14.33,65.01|N|From Kroum.|

F Orgrimmar|QID|14475|M|14.33,65.01|N|Train, repair, sell, etc.|

h Valley of Wisdom|QID|14475|M|39.06,48.55|Z|Orgrimmar|N|At Miwana. I set my hearth here because it was close to my trainer. We're almost done with Azshara!|

F Valormok|QID|14475|

C Let Them Feast on Fear|QID|24433|S|M|12.74,74.19|N|Slay 12 Talrendis Defenders, 5 Talrendis Lorekeepers and 6 Talrendis Sentinels.|

T Where's My Head?|QID|14462|M|12.55,67.45|N|To Slinky Sharpshiv.|
A Lightning Strike Assassination|QID|14464|PRE|14462|M|12.55,67.45|N|From Slinky Sharpshiv.|

C Lightning Strike Assassination|QID|14464|M|11.83,68.25|N|Talk to Slinky Sharpshiv to ascend the tower and assassinate Captain Grunwald. Collect Captain Grunwald's head.|

T Grounded!|QID|14475|M|14.51,75.56|N|Find Bombardier Captain Smooks at the southernmost night elf tower at Talrendis Point.|
A Rigged to Blow|QID|14476|PRE|14475|M|14.51,75.56|N|From Bombardier Captain Smooks.|

C Rigged to Blow|QID|14476|M|14.99,74.22;15.42,73.60;15.63,74.38|N|Arm the three Explosive Charges located around the base of the southern-most tower at Talrendis Point. |

T Rigged to Blow|QID|14476|M|14.55,75.54|N|To Bombardier Captain Smooks.|
A Push the Button!|QID|14477|PRE|14476|M|14.39,75.63|N|From Bombardier Captain Smooks.|

C Push the Button!|QID|14477|NC|M|14.39,75.63|N|You get to push THE BUTTON and detonate the explosives!|
C Commando Drop|QID|24434|M|10.06,71.18|N|Slay 5 Talrendis Lorekeepers and locate a Lorekeeper Summoning Stone somewhere within Talrendis Point.|
C Let Them Feast on Fear|QID|24433|US|M|12.74,74.19|N|Fight your way across Talrendis Point, slaying 12 Talrendis Defenders and 6 Talrendis Sentinels.|

T Commando Drop|QID|24434|M|10.51,69.85|N|To Lorekeeper's Summoning Stone.|
T Lightning Strike Assassination|QID|14464|M|13.95,64.79|N|To Chawg.|
T Let Them Feast on Fear|QID|24433|M|13.95,64.79|N|To Chawg.|
T Push the Button!|QID|14477|M|14.30,64.99|N|To Kroum.|
A Blacken the Skies|QID|24430|M|14.45,65.64|N|From Jr. Bombardier Hacke.|

C Blacken the Skies|QID|24430|M|9.28,72.53|N|Mount a Grounded Wind Rider. Destroy 6 Talrendis Glaive Throwers and bomb the Command Center. Don't fly too low.|

T Blacken the Skies|QID|24430|M|14.44,65.74|N|To Jr. Bombardier Hackel.|
A The Conquest of Azshara|QID|24439|PRE|24430|M|14.05,64.86|N|From Chawg.|

C The Conquest of Azshara|QID|24439|M|9.14,72.80|N|Slay Commander Jarrodenus in Talrendis Point and collect his head.|

L Level 24|QID|24439|LVL|24|N|You should be around level 24 by this point.|

T The Conquest of Azshara|QID|24439|M|14.03,64.78|N|To Chawg.|
A Probing into Ashenvale|QID|24463|PRE|24439|M|14.32,65.05|N|From Kroum.|
T Probing into Ashenvale|QID|24463|M|94.39,46.80|Z|Ashenvale|N|Run back through all the hostile mobs and across the bridge to Kulg Gorespatter.|
A To The Ramparts!|QID|13866|PRE|24463|M|94.39,46.80|Z|Ashenvale|N|From Kulg Gorespatter.|

F Northern Barrens |QID|13866|M|94.39,46.80|Z|Ashenvale|N|Talk to Kulg for a free flight.|
T To The Ramparts!|QID|13866|M|42.41,15.18|Z|Northern Barrens|N|To Kadrak.|
f The Mor'shan Rampart|QID|13866|M|42.02,15.81|Z|Northern Barrens|N|At Gort Goreflight.|

]]

end)
