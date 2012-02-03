
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_feralas_horde
-- Date: 2010-12-04 03:01
-- Who: Liavan
-- Log: deleted A step as the quest giver has moved to be inside Dire Maul.

-- URL: http://wow-pro.com/node/3245/revisions/23545/view
-- Date: 2010-12-04 02:54
-- Who: Liavan
-- Log: Updated a few U and L tags and some cords that where having zoning issues.

-- URL: http://wow-pro.com/node/3245/revisions/23371/view
-- Date: 2010-12-03 11:24
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3245/revisions/23370/view
-- Date: 2010-12-03 11:23
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('JiyFer3540', 'Feralas', 'Jiyambi', '35', '40', 'JiyTho4045', 'Horde', function()
return [[

R Camp Ataya|QID|25339|M|41.60,15.14|N|In Feralas.|
f Camp Ataya|QID|25339|M|41.60,15.14|N|From Konu Runetotem.|
A Vengeance on the Northspring|QID|25339|RANK|2|M|41.60,15.14|N|From Talo Thornhoof.|
A Dark Heart|QID|25340|RANK|2|M|41.61,15.21|N|From Talo Thornhoof.|
A Signs of Change|QID|25210|M|41.39,15.40|N|From Konu Runetotem.|
h Camp Ataya|QID|14411|US|M|41.40,15.73|N|At Adene Treetotem.|
C Vengeance on the Northspring|QID|25339|S|RANK|2|M|39.46,12.70|N|Kill harpies in the area.|
K Harpies|QID|25340|RANK|2|M|40.59,8.52|L|9530|N|Kill harpies until you find the Horn of the Hatetalon.|
C Dark Heart|QID|25340|RANK|2|M|40.59,8.52|U|9530|N|Use the Horn of the Hatetalon near the Hatetalon Stones. Kill and loot the summoned harpy.|
C Vengeance on the Northspring|QID|25339|US|RANK|2|M|39.46,12.70|N|Kill harpies in the area.|
T Vengeance on the Northspring|QID|25339|RANK|2|M|41.59,15.25|N|To Talo Thornhoof, back at Camp Ataya|
T Dark Heart|QID|25340|RANK|2|M|41.62,15.20|N|To Talo Thornhoof.|
C Signs of Change|QID|25210|M|41.90,23.10|N|From stags south of the camp.|
T Signs of Change|QID|25210|M|41.38,15.43|N|To Konu Runetotem, back at Camp Ataya.|
A More Than Illness|QID|25230|PRE|25210|M|41.38,15.43|N|From Konu Runetotem.|
C More Than Illness|QID|25230|M|48.86,9.32|N|The whelps can be found around the lake to the north-east.|
T More Than Illness|QID|25230|M|41.37,15.45|N|To Konu Runetotem, back at Camp Ataya.|
A Tears of Stone|QID|25237|PRE|25230|M|41.37,15.45|N|From Konu Runetotem.|
A The Land, Corrupted|QID|25241|PRE|25230|M|41.37,15.45|N|From Konu Runetotem.|
C The Land, Corrupted|QID|25241|S|M|38.45,24.40|N|The corrupted giants are fighting normal cliff giants in the area.|
C Tears of Stone|QID|25237|NC|M|38.77,24.84|N|The stones can be found on the ground to the south. They look like small crystals.|
C The Land, Corrupted|QID|25241|US|M|38.45,24.40|N|The corrupted giants are fighting normal cliff giants in the area.|
T Tears of Stone|QID|25237|M|41.38,15.46|N|To Konu Runetotem.|
T The Land, Corrupted|QID|25241|M|41.38,15.46|N|To Konu Runetotem.|
A Sealing the Dream|QID|25250|PRE|25237;25241|M|41.38,15.46|N|From Konu Runetotem.|
C Sealing the Dream|QID|25250|U|52576|M|51.26,10.87|N|Use the tear at the portal to seal it. There is a dragon guarding the path, but he's not too powerful.|
T Sealing the Dream|QID|25250|M|41.37,15.46|N|To Konu Runetotem, back at Camp Ataya.|
A To Stonemaul Hold|QID|25386|PRE|25250|M|41.37,15.46|N|From Konu Runetotem.|
A Still With The Zapped Giants|QID|25465|RANK|3|M|48.66,44.82|N|From Zorbin Fandazzle. He can be found along the road to the south.|
A Even More Fuel for the Zapping|QID|25466|RANK|3|M|48.66,44.82|N|From Zorbin Fandazzle.|
R Stonemaul Hold|QID|25386|M|51.92,48.07|N|Folow the road.|
T To Stonemaul Hold|QID|25386|M|51.92,48.07|N|To Orhan Ogreblade.|
A The Gordunni Threat|QID|25209|M|51.92,48.02|N|From Orhan Ogreblade.|
A The Gordunni Orb|QID|25341|M|51.92,48.02|N|From Orhan Ogreblade.|
f Stonemaul Hold|QID|27134|M|51.00,48.38|N|At Mergek.|
A Testing the Vessel|QID|25336|M|52.26,48.06|N|From Gombana.|
A The Mark of Quality|QID|25452|RANK|2|M|52.83,47.12|N|From Jangdor Swiftstrider.|
h Stonemaul Hold|QID|25452|M|51.90,47.47|N|At Chonk.|
C The Mark of Quality|QID|25452|RANK|2|M|52.07,31.60|N|The yetis can be found to the north. Follow the road north, then cut east to Rage Scar Hold.|
T The Mark of Quality|QID|25452|RANK|2|M|52.83,47.12|N|To Jangdor Swiftstrider, back at Stonemaul Hold.|
A Improved Quality|QID|25453|RANK|2|PRE|25452|M|52.82,47.10|N|From Jangdor Swiftstrider.|
C Testing the Vessel|QID|25336|U|9618|M|54.55,49.23|N|Kill wolves and bears, then use the vessel on them.|
T Testing the Vessel|QID|25336|US|M|52.27,48.05|N|To Gombana.|
A Hippogryph Muisek|QID|25337|PRE|25336|M|52.27,48.05|N|From Gombana.|
C Hippogryph Muisek|QID|25337|U|9619|M|53.80,72.02|N|Kill hippogryphs and use the vessel on their corpses.|
C The Gordunni Threat|QID|25209|S|M|59.09,63.13|N|Kill ogres around the Ruins of Isildien|
C The Gordunni Orb|QID|25341|M|59.34,65.78|N|The Orb drops from ogre warlocks in the Ruins of Isildien.|
C The Gordunni Threat|QID|25209|US|M|59.09,63.13|N|Kill ogres around the Ruins of Isildien|
K Kill Yetis|QID|25475|RANK|2|L|8705|M|55.52,55.81|N|Kill yetis until you find a distress beacon.|
A Find OOX-22/FE!|QID|25475|RANK|2|U|8705|N|Use the distress beacon.|
C Improved Quality|QID|25453|US|RANK|2|M|52.29,58.39|N|Kill ogres around the Ruins of Isildien|
T Find OOX-22/FE!|QID|25475|RANK|2|M|53.37,55.71|N|To Homing Robot OOX-22/FE.|
A Rescue OOX-22/FE!|QID|25476|RANK|2|M|53.37,55.71|N|From Homing Robot OOX-22/FE.|
C Rescue OOX-22/FE!|QID|25476|RANK|2|M|55.62,51.34|N|Follow the chicken. There will be one ambush of yetis when you get close to the road, so be ready.|
A Perfect Yeti Hide|QID|25454|O|RANK|2|U|55167|M|55.11,51.31|N|If you received a perfect yeti hide, use it to start a quest.|
C Even More Fuel for the Zapping|QID|25466|RANK|3|M|45.39,65.85|N|Kill and loot water elementals on the coast|
C Still With The Zapped Giants|QID|25465|RANK|3|U|18904|M|53.69,51.96;50.27,51.41;45.39,65.85|N|Use the zapper on the elite giants along the coastline  - they will shrink. Kill and loot them.|
C Even More Fuel for the Zapping|QID|25466|RANK|3|M|45.39,65.85|N|Kill and loot water elementals on the coast|
H Stonemaul Hold|QID|25465|RANK|3|M|51.91,48.01|N|If your hearth is down or you didn't set it there, run back.|
T Still With The Zapped Giants|QID|25465|RANK|3|M|48.66,44.85|N|To Zorbin Fandazzle.|
T Even More Fuel for the Zapping|QID|25466|RANK|3|M|48.68,44.79|N|To Zorbin Fandazzle.|
T The Gordunni Threat|QID|25209|M|51.91,48.01|N|To Orhan Ogreblade.|
A Rulers of Dire Maul|QID|25252|PRE|25209|M|51.91,48.01|N|From Orhan Ogreblade.|
T The Gordunni Orb|QID|25341|M|51.91,48.01|N|To Orhan Ogreblade.|
A Talk to Swar'jan|QID|25342|PRE|25341|M|51.91,48.01|N|From Orhan Ogreblade.|
T Hippogryph Muisek|QID|25337|M|52.26,48.06|N|To Gombana.|
A The Flow of Muisek|QID|25641|PRE|25337|M|52.26,48.06|N|From Gombana.|
T Improved Quality|QID|25453|RANK|2|M|52.80,47.11|N|To Jangdor Swiftstrider.|
T Perfect Yeti Hide|QID|25454|O|RANK|2|M|52.80,47.11|N|To Jangdor Swiftstrider.|
T Talk to Swar'jan|QID|25342|M|51.91,46.68|N|To Swar'jan.|
A Ogre Abduction|QID|25344|PRE|25342|M|51.91,46.68|N|From Swar'jan.|
C Rulers of Dire Maul|QID|25252|M|58.61,44.47|N|Kill ogres near Dire Maul.|
C Ogre Abduction|QID|25344|U|52833|M|59.85,46.59|N|Use the orb on an Ogre Mage after beating him down to 30% health.|
T Rulers of Dire Maul|QID|25252|M|51.91,48.03|N|To Orhan Ogreblade.|
T Ogre Abduction|QID|25344|M|51.91,46.62|N|To Swar'jan.|
A Might of the Stonemaul|QID|25329|PRE|25344|M|51.91,48.04|N|From Orhan Ogreblade.|
C Might of the Stonemaul|QID|25329|M|59.32,39.37;61.02,34.99;62.51,30.94|N|Head inside Dire Maul. Leap down into the arena. Watch the event as it progresses, don't worry, you'll get help from some NPCs.|
H Stonemaul Hold|QID|25329|M|51.90,48.02|N|If your hearth is up and set there, hearth back. Otherwise, ride back.|
T Might of the Stonemaul|QID|25329|M|51.90,48.02|N|To Orhan Ogreblade.|
A To Camp Mojache|QID|25387|PRE|25329|M|51.90,48.02|N|From Orhan Ogreblade.|
R Camp Mojache|QID|25641|M|74.46,43.38|N|Follow the road to the east.|
T The Flow of Muisek|QID|25641|M|74.46,43.38|N|To Witch Doctor Uzer'i.|
A Treant Muisek|QID|25338|PRE|25641|M|74.46,43.38|N|From Witch Doctor Uzer'i.|
T To Camp Mojache|QID|25387|M|74.61,42.91|N|To Chief Spirithorn.|
A The Hilltop Threat|QID|25373|M|74.60,42.89|N|From Chief Spirithorn.|
A Twisted Sisters|QID|25349|M|74.60,42.89|N|From Chief Spirithorn.|
A War on the Woodpaw|QID|25363|M|74.92,42.52|N|From Hadoken Swiftstrider.|
A The Highborne|QID|27132|M|74.92,42.52|N|From Hadoken Swiftstrider. Pick this up if you'd like to do Dire Maul.|
A The Darkmist Ruins|QID|25643|M|75.07,42.78|N|From Sage Palerunner.|
h Camp Mojache|QID|25643|M|74.79,45.12|N|At Innkeeper Greul.|
f Camp Mojache|QID|25643|M|74.79,45.12|N|At Shyn.|
C Treant Muisek|QID|25338|S|U|9606|M|76.55,40.33|N|Kill treants and use the vessel on their corpses.|
C Twisted Sisters|QID|25349|M|77.06,39.17|N|Kill dryads to the north-east of Camp Mojache.|
C The Hilltop Threat|QID|25373|M|76.94,34.81|N|The ogres are in the hills to the north.|
C War on the Woodpaw|QID|25363|M|72.11,36.67|N|There are several gnoll camps across the river to the west.|
C Treant Muisek|QID|25338|US|U|9606|M|76.55,40.33|N|Kill treants and use the vessel on their corpses.|
T Treant Muisek|QID|25338|M|74.45,43.36|N|To Witch Doctor Uzer'i.|
A Faerie Dragon Muisek|QID|25345|PRE|25338|M|74.50,43.30|N|From Witch Doctor Uzer'i.|
T The Hilltop Threat|QID|25373|M|74.59,42.89|N|To Chief Spirithorn.|
A Sasquatch Sighting|QID|25374|PRE|25373|M|74.59,42.89|N|From Chief Spirithorn.|
A Taming The Tamers|QID|25375|PRE|25373|M|74.59,42.89|N|From Chief Spirithorn.|
T Twisted Sisters|QID|25349|M|74.59,42.89|N|To Chief Spirithorn.|
A Ysondre's Call|QID|25378|PRE|25349|M|74.59,42.89|N|From Chief Spirithorn.|
T War on the Woodpaw|QID|25363|M|74.90,42.52|N|To Hadoken Swiftstrider.|
A Woodpaw Investigation|QID|25365|PRE|25363|M|74.90,42.52|N|From Hadoken Swiftstrider.|
A Alpha Strike|QID|25364|PRE|25363|M|74.90,42.52|N|From Hadoken Swiftstrider.|
A A New Cloak's Sheen|QID|25361|PRE|25338|M|75.00,42.99|N|From Krueg Skullsplitter.|
T Ysondre's Call|QID|25378|M|81.55,42.45|N|To Ysondre, on top of the hill to the east.|
A Taerar's Fall|QID|25379|M|81.55,42.45|N|From Ysondre.|
C Taerar's Fall|QID|25379|M|81.53,42.49|N|Allow Ysondre to tank for you, be cautious and you should be fine.|
T Taerar's Fall|QID|25379|M|81.54,42.46|N|To Ysondre.|
A Ysondre's Farewell|QID|25383|PRE|25379|M|81.54,42.46|N|From Ysondre.|
C Taming The Tamers|QID|25375|S|M|74.54,28.99|N|Kill ogres around the Gordunni Outpost.|
C Sasquatch Sighting|QID|25374|M|74.83,28.46|N|Bigfist can be found in the ogre camp in the hills to the north.|
C Taming The Tamers|QID|25375|US|M|74.54,28.99|N|Kill ogres around the Gordunni Outpost.|
H Camp Mojache|QID|25374|M|74.59,42.88|N|If your hearth is down or you didn't set it there, run back.|
T Sasquatch Sighting|QID|25374|M|74.59,42.88|N|To Chief Spirithorn.|
T Ysondre's Farewell|QID|25383|M|74.59,42.88|N|To Chief Spirithorn. Congrats on a very nice piece of gear!|
T Taming The Tamers|QID|25375|M|74.59,42.88|N|To Chief Spirithorn.|
T Woodpaw Investigation|QID|25365|M|71.65,55.91|N|To the attack plans on the box in a gnoll camp south-west of Camp Mojache|
A The Battle Plans|QID|25366|PRE|25365|M|71.64,55.92|N|From the gnoll plans.|
T The Darkmist Ruins|QID|25643|M|67.83,60.14;66.76,59.59;65.92,62.83|N|Nearby you will find the entrance to the Darkmist Ruins. Head there and turn-in to glowing bowl of light.|
A The Darkmist Legacy|QID|25422|PRE|25643|M|65.92,62.83|N|From Sensiria, who will appear next to you.|
A Ancient Suffering|QID|25423|PRE|25643|M|65.92,62.83|N|From Sensiria.|
C Ancient Suffering|QID|25423|S|M|64.77,62.72|N|Kill the spirits in the area.|
C The Darkmist Legacy|QID|25422|M|63.92,55.06|N|The soil looks lik sparkling patches of lighter-colored ground, and can be found all around the ruins. It's a little hard to see, so look closely.|
C Ancient Suffering|QID|25423|US|M|64.77,62.72|N|Kill the spirits in the area.|
T The Darkmist Legacy|QID|25422|M|65.93,62.79|N|To Sensiria.|
T Ancient Suffering|QID|25423|M|65.93,62.79|N|To Sensiria.|
A Verinias the Twisted|QID|25368|PRE|25422|M|65.93,62.79|N|From Sensiria.|
C Verinias the Twisted|QID|25368|U|54456|M|64.33,55.84|N|The tree is located to the north.|
T Verinias the Twisted|QID|25368|M|65.92,62.81|N|To Sensiria.|
A Return to Sage Palerunner|QID|25645|PRE|25368|M|65.92,62.84|N|From the pool of light next to you.|
C Alpha Strike|QID|25364|M|65.66,52.23|N|The alphas are found in the Woodpaw Den, in the hills to the north-east.|
C A New Cloak's Sheen|QID|25361|S|M|73.37,40.18|N|Kill and loot faerie dragons.|
C Faerie Dragon Muisek|QID|25345|U|9620|M|70.87,41.43|N|Kill faerie dragons and use the vessel on their corpses. Make sure to loot them first, though!|
C A New Cloak's Sheen|QID|25361|US|M|73.37,40.18|N|Kill and loot faerie dragons.|
T Faerie Dragon Muisek|QID|25345|M|74.44,43.38|N|To Witch Doctor Uzer'i.|
A Mountain Giant Muisek|QID|25346|PRE|25345|M|74.44,43.38|N|From Witch Doctor Uzer'i.|
T Alpha Strike|QID|25364|M|74.92,42.51|N|To Hadoken Swiftstrider.|
T The Battle Plans|QID|25366|M|74.92,42.51|N|To Hadoken Swiftstrider.|
A Zukk'ash Infestation|QID|25367|PRE|25364;25366|M|74.92,42.51|N|From Hadoken Swiftstrider.|
A Stinglasher|QID|25369|PRE|25364;25366|M|74.92,42.51|N|From Hadoken Swiftstrider.|
T A New Cloak's Sheen|QID|25361|M|75.03,42.95|N|To Krueg Skullsplitter.|
A A Grim Discovery|QID|25362|RANK|2|PRE|25361|M|75.03,42.95|N|From Krueg Skullsplitter.|
T Return to Sage Palerunner|QID|25645|M|75.07,42.77|N|To Sage Palerunner.|
C A Grim Discovery|QID|25362|RANK|2|M|69.01,38.55|N|There is a camp north of Mojache with many grimtotems.|
T A Grim Discovery|QID|25362|RANK|2|M|74.94,43.13|N|To Krueg Skullsplitter.|
C Mountain Giant Muisek|QID|25346|U|9621|M|70.31,61.99|N|Kill mountain giants and use the vessel on their corpses.|
C Zukk'ash Infestation|QID|25367|S|M|75.29,59.54|N|Kill and loot silithid.|
C Stinglasher|QID|25369|M|76.87,61.51;77.41,62.06;78.46,62.50|N|He is located underground in one of the silithid hives.|
C Zukk'ash Infestation|QID|25367|US|M|75.29,59.54|N|Kill and loot silithid.|
H Camp Mojache|QID|25369|M|74.91,42.53|N|If your hearth is down or you didn't set it there, run back.|
T Mountain Giant Muisek|QID|25346|M|74.43,43.43|N|To Witch Doctor Uzer'i.|
A Weapons of Spirit|QID|25391|PRE|25346|M|74.43,43.43|N|From Witch Doctor Uzer'i.|
T Weapons of Spirit|QID|25391|M|74.44,43.38|N|To Witch Doctor Uzer'i. Congrats on a very nice weapon!|
T Zukk'ash Infestation|QID|25367|M|74.91,42.53|N|To Hadoken Swiftstrider.|
T Stinglasher|QID|25369|M|74.91,42.53|N|To Hadoken Swiftstrider.|
]]

end)
