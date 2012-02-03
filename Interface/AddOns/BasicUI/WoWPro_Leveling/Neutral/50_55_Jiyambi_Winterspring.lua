
-- WoWPro Guides by "The WoW-Pro Community" are licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License.
-- Based on a work at github.com.
-- Permissions beyond the scope of this license may be available at http://www.wow-pro.com/License.

-- URL: http://wow-pro.com/wiki/source_code_winterspring_neutral
-- Date: 2011-06-25 03:05
-- Who: Crackerhead22
-- Log: ! Duplicate A step for qid 28460 - Wrong QID for "Winterfall Runners".

-- URL: http://wow-pro.com/node/3264/revisions/24573/view
-- Date: 2011-06-21 20:31
-- Who: Crackerhead22

-- URL: http://wow-pro.com/node/3264/revisions/24440/view
-- Date: 2011-05-28 14:29
-- Who: Crackerhead22
-- Log: Note tweaks, added warning about Mazthoril cave portals.

-- URL: http://wow-pro.com/node/3264/revisions/24430/view
-- Date: 2011-05-28 04:16
-- Who: Crackerhead22
-- Log: Added "Blasted Lands: The Other Side of the World" in for both Horde and Alliance.

-- URL: http://wow-pro.com/node/3264/revisions/24404/view
-- Date: 2011-05-17 02:00
-- Who: Ludovicus Maior

-- URL: http://wow-pro.com/node/3264/revisions/24396/view
-- Date: 2011-05-17 01:10
-- Who: Ludovicus Maior

-- URL: http://wow-pro.com/node/3264/revisions/24140/view
-- Date: 2011-02-28 23:25
-- Who: Ludovicus Maior
-- Log: Add [Yetiphobia].

-- URL: http://wow-pro.com/node/3264/revisions/24139/view
-- Date: 2011-02-28 23:22
-- Who: Ludovicus Maior
-- Log: Added [Perfect Horns] to the Horde Winterfall guide.
--	The Alliance side had it.  Discovered by Josral.

-- URL: http://wow-pro.com/node/3264/revisions/23410/view
-- Date: 2010-12-03 11:56
-- Who: Jiyambi

-- URL: http://wow-pro.com/node/3264/revisions/23409/view
-- Date: 2010-12-03 11:55
-- Who: Jiyambi

WoWPro.Leveling:RegisterGuide('JiyWin5055', 'Winterspring', 'Jiyambi', '50', '55', 'CraBla5458|JiyBla5560', 'Neutral', function()
return [[

R Winterspring|QID|28521|M|21.04,46.22|N|Head through the Timbermaw tunnels to Winterspring.|
T Speak to Salfa|QID|28521|M|21.04,46.22|N|To Salfa.|
A Delivery for Donova|QID|28524|M|21.07,46.25|N|From Salfa.|
A Winterfall Activity|QID|28522|M|21.07,46.25|N|From Salfa.|
R Snowden Chalet|QID|28524|M|25.15,58.52|N|Follow the road.|
T Delivery for Donova|QID|28524|M|25.15,58.52|N|To Donova Snowden.|
A Threat of the Winterfall|QID|28460|M|25.15,58.52|N|From Donova Snowden.|
A Falling to Corruption|QID|28464|M|25.15,58.52|N|From Donova Snowden.|
A Doin' De E'ko Magic|QID|28540|M|25.16,58.50|N|From Witch Doctor Mau'ari.|
C Doin' De E'ko Magic|QID|28540|M|28.90,58.62|N|Kill and loot Rimepelt, on a hill to the east.|
T Doin' De E'ko Magic|QID|28540|N|To Witch Doctor Mau'ari.|
C Threat of the Winterfall|QID|28460|S|M|27.09,48.97|N|Kill furbolgs in the Frostfire Hot Springs area.|
C Winterfall Activity|QID|28522|S|M|24.80,49.13|N|Kill and loot furbolgs in the Frostfire Hot Springs area.|

A Strange Life Forces|QID|28656|M|24.45,47.67|N|Kill Winterfall Furbolgs. The quest will appear automatically.|
T Falling to Corruption|QID|28464|M|24.45,47.67|N|To the cauldron in the furbolg camp.|
A Mystery Goo|QID|28467|M|24.45,47.67|N|From the cauldron in the furbolg camp.|
C Threat of the Winterfall|QID|28460|US|M|27.09,48.97|N|Kill furbolgs in the Frostfire Hot Springs area.|
C Winterfall Activity|QID|28522|US|M|24.80,49.13|N|Kill and loot furbolgs in the Frostfire Hot Springs area.|
T Strange Life Forces|QID|28656|M|25.18,58.53|N|To Witch Doctor Mau'ari.|
T Threat of the Winterfall|QID|28460|M|25.11,58.51|N|To Donova Snowden.|
T Mystery Goo|QID|28467|M|25.11,58.51|N|To Donova Snowden.|
A Winterfall Runners|QID|28469|M|25.11,58.51|N|From Donova Snowden.|
C Winterfall Runners|QID|28469|M|25.01,55.44|N|The runners patrol the road to the north.|
T Winterfall Runners|QID|28469|M|25.12,58.53|N|To Donova Snowden.|
A High Chief Winterfall|QID|28470|M|25.12,58.53|N|From Donova Snowden.|
A Scalding Signs|QID|28530|M|25.12,58.53|N|From Donova Snowden.|
C High Chief Winterfall|QID|28470|M|36.91,55.61|N|Kill and loot the chief in the camp to the east.|

A The Final Piece|QID|28471|U|12842|M|59.26,50.58|N|Use the Crudely Written Log you looted from the chief.|
C Scalding Signs|QID|28530|M|32.99,48.65|N|At the hot spring to the north. Kill and loot Scalding Springsurges and Boiling Springbubbles.|
T High Chief Winterfall|QID|28470|M|25.11,58.56|N|To Donova Snowden.|
T The Final Piece|QID|28471|M|25.14,58.49|N|To Donova Snowden.|
A Words of the High Chief|QID|28472|PRE|28471|M|25.14,58.49|N|From Donova Snowden.|
T Scalding Signs|QID|28530|M|25.11,58.56|N|To Donova Snowden.|
T Winterfall Activity|QID|28522|M|21.05,46.26|N|To Salfa.|
R Lake Kel'Theril|QID|28472|M|46.85,53.86|N|Follow the road east.|
T Words of the High Chief|QID|28472|M|46.85,53.86|N|To Kelek Skykeeper. Congrats on a very nice trinket!|
A The Ruins of Kel'Theril|QID|28479|PRE|28472|M|46.85,53.86|N|From Kelek Skykeeper.|
T The Ruins of Kel'Theril|QID|28479|M|50.67,54.87|N|To Kaldorei Spirit.|
A Pride of the Highborne|QID|28513|M|50.67,54.87|N|From Kaldorei Spirit.|
C Pride of the Highborne|QID|28513|M|52.73,52.91|N|Kill the spirits on the north side of the ruins.|
T Pride of the Highborne|QID|28513|M|50.74,54.85|N|To Kaldorei Spirit.|

A Descendants of the Highborne|QID|28534|M|50.74,54.85|N|From Kaldorei Spirit.|
T Descendants of the Highborne|QID|28534|M|50.81,54.94|N|To Quel'dorei Spirit.|
A Legacy of the High Elves|QID|28518|M|50.81,54.94|N|From Quel'dorei Spirit.|
C Legacy of the High Elves|QID|28518|M|53.96,57.83|N|Kill and loot Archmage Maenius in the ruins to the south.|
T Legacy of the High Elves|QID|28518|M|50.82,55.03|N|To Quel'dorei Spirit.|
A Descendants of the High Elves|QID|28535|M|50.82,55.03|N|From Quel'dorei Spirit.|
T Descendants of the High Elves|QID|28535|M|50.68,55.10|N|To Sin'dorei Spirit.|
A Pain of the Blood Elves|QID|28519|M|50.68,55.10|N|From Sin'dorei Spirit.|
C Pain of the Blood Elves|QID|28519|M|49.38,57.64|N|Kill wretched spirits to the south-west.|
T Pain of the Blood Elves|QID|28519|M|50.64,55.05|N|To Sin'dorei Spirit.|
A The Curse of Zin-Malor|QID|28536|M|50.64,55.05|N|From Sin'dorei Spirit.|
T The Curse of Zin-Malor|QID|28536|M|46.87,53.83|N|To Kelek Skykeeper.|
A In Pursuit of Shades|QID|28537|M|46.87,53.83|N|From Kelek Skykeeper.|
C In Pursuit of Shades|QID|28537|M|50.71,63.60|N|Follow the frozen river to the south. There will be arcane "boulders" rolling down it - dodge them, they knock you back. You should eventually come to the Shade of the Spiritspeaker - kill and loot him.|
T In Pursuit of Shades|QID|28537|M|46.82,53.89|N|To Kelek Skykeeper.|

A Trailing the Spiritspeaker|QID|28848|M|46.82,53.89|N|From Kelek Skykeeper.|
R Everlook|QID|28848|M|59.65,50.46|N|Follow the road east.|
f Everlook|QID|28848|M|58.8,48.3|N|From Yugrek.|FACTION|Horde|
T Trailing the Spiritspeaker|QID|28848|M|59.65,50.46|N|To Nymn.|
A Hammer Time|QID|28609|M|59.85,49.17|N|From Lilith the Lithe.|
T Hammer Time|QID|28609|M|59.77,49.65|N|To Deez Rocksnitch.|
A Rubble Trouble|QID|28610|PRE|28609|M|59.77,49.65|N|From Deez Rocksnitch.|
h Everlook|QID|28848|M|59.84,51.17|N|At Innkeeper Vizzie.|
f Everlook|QID|28610|M|61.00,48.61|N|At Maethrya.|FACTION|Alliance|
C Rubble Trouble|QID|28610|M|60.04,57.18|N|Kill and loot earth elementals in the hills to the south.|
T Rubble Trouble|QID|28610|M|59.77,49.70|N|To Deez Rocksnitch, back in Everlook.|
A Boulder Delivery|QID|28618|PRE|28610|M|59.77,49.70|N|From Deez Rocksnitch.|
T Boulder Delivery|QID|28618|M|59.89,49.21|N|To Lilith the Lithe.|

A Kilram's Boast|QID|28624|PRE|28618|M|59.82,49.18|N|From Kilram.|
T Kilram's Boast|QID|28624|M|59.77,49.66|N|To Deez Rocksnitch.|
A Chop Chop|QID|28625|PRE|28624|M|59.77,49.66|N|From Deez Rocksnitch.|
C Chop Chop|QID|28625|M|47.93,51.18|N|Kill and loot treants in the hills west of Everlook.|
T Chop Chop|QID|28625|M|59.77,49.70|N|To Deez Rocksnitch, back in Everlook.|
A Tree Delivery|QID|28626|PRE|28625|M|59.77,49.70|N|From Deez Rocksnitch.|
T Tree Delivery|QID|28626|M|59.82,49.18|N|To Kilram.|
A Seril's Boast|QID|28627|PRE|28626|M|59.80,49.24|N|From Seril Scourgebane.|
T Seril's Boast|QID|28627|M|59.79,49.61|N|To Deez Rocksnitch.|

A Fresh From The Hills|QID|28632|PRE|28627|M|59.79,49.61|N|From Deez Rocksnitch.|
A Are We There, Yeti?|QID|28629|PRE|28627|M|59.33,49.84|N|From Umi Rumplesnicker.|
A The Perfect Horns|QID|28631|M|59.34,49.83|N|From Umi Rumplesnicker.|
A Echo Three|QID|28630|PRE|28627|M|59.33,49.84|N|From Umi Rumplesnicker.|
C Are We There, Yeti?|QID|28629|S|M|71.73,51.91|N|Kill and loot yetis.|
T Echo Three|QID|28630|M|67.03,55.11|N|To Echo Three, the box outside the yeti cave.|
C The Perfect Horns|QID|28631|M|69.65,49.72|N|Don't be alarmed! Attack the ice imprisoning you to be set free. Once you are free, kill and loot Icewhomp.|
C Fresh From The Hills|QID|28632|M|69.69,54.61|N|Make your way out of the cave, attacking any chunks of pure ice you might see.|
C Are We There, Yeti?|QID|28629|US|M|71.73,51.91|N|Kill and loot yetis.|
T Are We There, Yeti?|QID|28629|M|59.35,49.84|N|To Umi Rumplesnicker, back in Everlook.|
T The Perfect Horns|QID|28631|M|59.31,49.79|N|To Umi Rumplesnicker.|

A Yetiphobia|QID|28722|M|59.31,49.79|N|From Umi Rumplesnicker.|
C Yetiphobia|QID|28722|U|12928|M|60.04,50.87|N|Go over to Legacki, target her and use the yeti device.|T|Legacki|
T Yetiphobia|QID|28722|M|59.30,49.81|N|To Umi Rumplesnicker.|
T Fresh From The Hills|QID|28632|M|59.79,49.62|N|To Deez Rocksnitch.|
A Ice Delivery|QID|28628|PRE|28632|M|59.79,49.62|N|From Deez Rocksnitch.|
T Ice Delivery|QID|28628|M|59.76,49.18|N|To Seril Scourgebane.|
A Starfall Village|QID|28674|PRE|28628|M|59.78,49.65|N|From Deez Rocksnitch.|
A The Pursuit of Umbranse|QID|28847|PRE|28628|M|59.66,50.45|N|From Nymn.|
R Starfall Village|QID|28674|M|48.65,41.03|N|To Wynd Nightchaser.|
T Starfall Village|QID|28674|M|48.65,41.03|N|To Wynd Nightchaser.|
A Exterminators at Work|QID|28676|PRE|28674|M|48.65,41.03|N|From Wynd Nightchaser.|
A Out of Harm's Way|QID|28701|PRE|28674|M|48.65,41.03|N|From Wynd Nightchaser.|
T Exterminators at Work|QID|28676|M|45.77,40.97|N|To Rinno Curtainfire, just inside the barrow den.|

A Step Into My Barrow|QID|28703|M|45.77,40.97|N|From Rinno Curtainfire.|
A Spray it Forward|QID|28706|M|45.77,40.97|N|From Rinno Curtainfire.|
C Out of Harm's Way|QID|28701|S|NC|M|46.33,42.00|N|Loot the relics scattered around the barrow den.|
C Step Into My Barrow|QID|28703|S|M|47.53,40.82|N|Kill worms and spiders in the barrow den.|
T Spray it Forward|QID|28706|M|45.63,41.60|N|To Remma Curtainfire, at the bottom of the first room in the barrow den.|
A Spray it Again|QID|28707|PRE|28706|M|45.63,41.60|N|From Remma Curtainfire.|
T Spray it Again|QID|28707|M|46.30,42.52|N|Continue down the tunnel past Rema. Turn-in to Marcy Curtainfire, at the bottom of the next room.|
A Spray it One More Time|QID|28710|PRE|28707|M|46.30,42.52|N|From Marcy Curtainfire.|
T Spray it One More Time|QID|28710|M|48.10,40.64|N|To Sana Curtainfire. Follow the tunnel to the final room, and head up up to the center walkway, then through the south-eastern tunnel to reach her.|
A Where There's Smoke, There's Delicious Meat|QID|28718|PRE|28710|M|48.10,40.64|N|From Sana Curtainfire.|
C Step Into My Barrow|QID|28703|US|M|47.53,40.82|N|Kill worms and spiders in the barrow den.|
C Out of Harm's Way|QID|28701|US|NC|N|Loot the relics scattered around the barrow den.|
T Step Into My Barrow|QID|28703|M|45.78,41.04|N|To Rinno Curtainfire, back at the entrance to the barrow den.|
T Out of Harm's Way|QID|28701|M|48.65,40.99|N|To Wynd Nightchaser, at Starfall Village.|

R Goodgrub Smoking Pit|QID|28718|M|55.98,28.13|N|To the east.|
T Where There's Smoke, There's Delicious Meat|QID|28718|M|55.98,28.13|N|To Jez Goodgrub.|
A Fresh Frostsabers|QID|28640|PRE|28718|M|55.98,28.13|N|From Jez Goodgrub.|
A You Gotta Have Eggs|QID|28828|M|55.98,28.13|N|From Jez Goodgrub.|
A A Taste for Bear|QID|28637|M|55.87,28.27|N|From Francis Morcott.|
A The Owls Have It|QID|28638|M|56.01,28.25|N|From Jeb Guthrie.|
C A Taste for Bear|QID|28637|S|M|53.40,31.60|N|Kill bears south of the camp.|
C The Owls Have It|QID|28638|M|59.85,30.83|N|Kill owls south of the camp.|
C A Taste for Bear|QID|28637|US|M|53.40,31.60|N|Kill bears south of the camp.|
T The Owls Have It|QID|28638|N|(UI Alert)|
A Screechy Keen|QID|28745|PRE|28638|N|(UI Alert)|
T A Taste for Bear|QID|28637|N|(UI Alert)|

A A Little Gamy|QID|28719|PRE|28637|N|(UI Alert)|
C A Little Gamy|QID|28719|M|52.65,41.37|N|Kill bears further to the south.|S|
C Screechy Keen|QID|28745|N|Kill owls on the mountain to the south-west.|
T Screechy Keen|QID|28745|N|(UI Alert)|
A A Bird of Legend|QID|28782|PRE|28745|N|(UI Alert)|
C A Bird of Legend|QID|28782|N|At the very top of the hill.|
C A Little Gamy|QID|28719|M|52.65,41.37|N|Kill bears further to the south.|US|
T A Little Gamy|QID|28719|N|(UI Alert)|
A Ursius|QID|28639|PRE|28719|N|(UI Alert)|
C Ursius|QID|28639|M|59.51,40.77|N|In a cave to the east.|
C Fresh Frostsabers|QID|28640|M|51.83,24.72|N|Kill frostsabers to the north.|
T Fresh Frostsabers|QID|28640|N|(UI Alert)|
A Pride of the Dinner Table|QID|28641|PRE|28640|N|(UI Alert)|
C Pride of the Dinner Table|QID|28641|M|45.91,24.37|N|Kill frostsabers west of the road.|
T Pride of the Dinner Table|QID|28641|N|(UI Alert)|

A Shy-Rotam|QID|28742|PRE|28641|N|(UI Alert)|
C Shy-Rotam|QID|28742|M|46.25,17.86|N|At Frostsaber Rock to the north.|
C You Gotta Have Eggs|QID|28828|NC|M|58.68,19.64|N|In the hills to the east. The chimeras will attack if they see you taking their eggs.|
T A Bird of Legend|QID|28782|M|55.90,28.32|N|To Jeb Guthrie, back at the Goodgrub Smoking Pit.|
T Ursius|QID|28639|M|55.96,28.13|N|To Francis Morcott.|
T Shy-Rotam|QID|28742|N|To Jez Goodgrub.|
T You Gotta Have Eggs|QID|28828|M|56.01,28.17|N|To Jez Goodgrub.|
R Winterfall Village|QID|28614|M|65.31,46.14|N|East of Everlook|
A Bearzerker|QID|28614|M|65.31,46.14|N|From Burndl.|
A Turning the Earth|QID|28615|M|65.31,46.14|N|From Tanrir.|
C Turning the Earth|QID|28615|U|64637|M|67.37,50.25|N|Use the totem on Winterfall totems in the village.|
C Bearzerker|QID|28614|M|69.48,50.50|N|Kill Grolnar the Berserk in the cave at the top of Winterfall Village.|
T Turning the Earth|QID|28615|M|65.36,46.15|N|To Tanrir.|
T Bearzerker|QID|28614|M|65.33,46.15|N|To Burndl.|

R Beryl Egress|QID|28847|M|58.03,63.76|N|South of Everlook.|
T The Pursuit of Umbranse|QID|28847|M|58.03,63.76|N|To Haleh.|
A Altered Beasts|QID|28837|PRE|28847|M|55.24,67.70|N|From Haleh.|
C Altered Beasts|QID|28837|N|Kill and loot altered beasts. They can be found all around Mazthoril.|
T Altered Beasts|QID|28837|M|58.05,63.87|N|To Haleh, back at the Beryl Egress.|
A The Owlbeasts' Defense|QID|28838|M|58.05,63.87|N|From Haleh.|
C The Owlbeasts' Defense|QID|28838|NC|M|57.15,75.40|N|In a chest at the abandoned camp in Dun Mandarr, to the south.|
T The Owlbeasts' Defense|QID|28838|N|(UI Alert)|
A Magic Prehistoric|QID|28839|PRE|28838|N|(UI Alert)|
A Razor Beak and Antlers Pointy|QID|28829|M|61.90,74.69|N|From Jadrag the Slicer.|
C Razor Beak and Antlers Pointy|QID|28829|S|M|64.30,77.76|N|Kill owlbeasts in the Owl Wing Thicket.|
C Essence of the Claw-Totem|QID|28839|NC|QO|Essence of the Claw-Totem: 1/1|M|65.1,73.9|N|Right-click the Claw-Totem inside the cave.|
C Essence of the Life-Totem|QID|28839|NC|QO|Essence of the Life-Totem: 1/1|M|65.6,77.6|N|Right-click the Life-Totem inside the cave.|
C Essence of the Moon-Totem|QID|28839|NC|QO|Essence of the Moon-Totem: 1/1|M|64.79,81.04|N|Right-click the Moon-Totem inside the cave.|
T Magic Prehistoric|QID|28839|N|(UI Alert)|
A Winterwater|QID|28840|PRE|28839|N|(UI Alert)|
C Razor Beak and Antlers Pointy|QID|28829|US|N|Kill owlbeasts in the Owl Wing Thicket.|
T Razor Beak and Antlers Pointy|QID|28829|M|61.92,74.70|N|To Jadrag the Slicer.|

A Chips off the Old Block|QID|28830|PRE|28829|M|61.92,74.70|N|From Jadrag the Slicer.|
A Damn You, Frostilicus|QID|28831|PRE|28829|M|61.92,74.70|N|From Jadrag the Slicer.|
C Chips off the Old Block|QID|28830|M|59.44,80.51|N|Kill frost giants.|
C Winterwater|QID|28840|S|M|62.47,86.04|N|Kill and loot ice avatars at the bottom of Frostwhisper Gorge.|
C Damn You, Frostilicus|QID|28831|M|63.14,86.09|N|Frostilicus is at the bottom of Frostwhisper Gorge, on the east side. The ramp down is on the wast side.|
C Winterwater|QID|28840|US|M|62.47,86.04|N|Kill and loot ice avatars at the bottom of Frostwhisper Gorge.|
T Chips off the Old Block|QID|28830|M|61.85,74.61|N|To Jadrag the Slicer.|
T Damn You, Frostilicus|QID|28831|M|61.85,74.61|N|To Jadrag the Slicer.|
T Winterwater|QID|28840|M|58.04,63.78|N|To Haleh, back at the Beryl Egress.|
A The Arcane Storm Within|QID|28841|PRE|28840|M|58.04,63.78|N|From Haleh.|
A Umbranse's Deliverance|QID|28842|PRE|28840|M|58.04,63.78|N|From Haleh.|
N Warning to epileptics|QID|28841|N|And those with sensitive eyes to flashing lights. Inside Mazthoril cave the portals are flashing red, pink, white and blue lights.|
C The Arcane Storm Within|QID|28841|S|U|66060|M|49.52,70.39|N|In Mazthoril, kill the guardians for each portal, then use the totem to close it.|
C Umbranse's Deliverance|QID|28842|M|49.52,70.39|N|Kill Umbranse at the bottom of the cave.|
C The Arcane Storm Within|QID|28841|US|U|66060|M|49.52,70.39|N|In Mazthoril, kill the guardians for each portal, then use the totem to close it.|
T The Arcane Storm Within|QID|28841|U|66061|M|57.99,63.82|N|Use the sigil to return to Haleh.|
T Umbranse's Deliverance|QID|28842|M|57.99,63.82|N|To Haleh. Congrats on a very nice piece of gear!|

A Blasted Lands: The Other Side of the World|QID|28857|M|59.8,51.2|N|From Innkeeper Vizzie.|FACTION|Alliance|
A Blasted Lands: The Other Side of the World|QID|28858|M|59.8,51.2|N|From Innkeeper Vizzie.|FACTION|Horde|

N This ends|N|The Winterspring guide, next stop is Blasted Lands. Close this step to continue on.|
]]

end)
