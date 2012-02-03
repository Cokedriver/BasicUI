--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-deDE.lua - Localized string constants (de-DE).              *
  ****************************************************************************]]


if ( GetLocale() ~= "deDE" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/deDE/
local _NPCScan = select( 2, ... );
_NPCScan.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "Bro'Gaz der Klanlose",
		[ 32491 ] = "Zeitverlorener Protodrache",
		[ 33776 ] = "Gondria",
		[ 35189 ] = "Skoll",
		[ 38453 ] = "Arcturis",
		[ 49822 ] = "Jadezahn",
		[ 49913 ] = "Lady LaLa",
		[ 50005 ] = "Poseidus",
		[ 50009 ] = "Mobus",
		[ 50050 ] = "Shok'sharak",
		[ 50051 ] = "Geisterkrabbler",
		[ 50052 ] = "Bürgi Schwarzherz",
		[ 50053 ] = "Thartuk der Verbannte",
		[ 50056 ] = "Garr",
		[ 50057 ] = "Flammenschwinge",
		[ 50058 ] = "Terrorpene",
		[ 50059 ] = "Golgarok",
		[ 50060 ] = "Terborus",
		[ 50061 ] = "Xariona",
		[ 50062 ] = "Aeonaxx",
		[ 50063 ] = "Akma'hat",
		[ 50064 ] = "Cyrus der Schwarze",
		[ 50065 ] = "Armagürtlon",
		[ 50085 ] = "Oberanführer Zornesbeben",
		[ 50086 ] = "Tarvus der Üble",
		[ 50089 ] = "Julak-Doom",
		[ 50138 ] = "Karoma",
		[ 50154 ] = "Madexx", -- Needs review
		[ 50159 ] = "Sambas",
		[ 50409 ] = "Mysteriöse Kamelfigur",
		[ 50410 ] = "Mysteriöse Kamelfigur",
		[ 51071 ] = "Kapitän Florence",
		[ 51079 ] = "Kapitän Faulwind",
		[ 51401 ] = "Madexx", -- Needs review
		[ 51402 ] = "Madexx", -- Needs review
		[ 51403 ] = "Madexx", -- Needs review
		[ 51404 ] = "Madexx", -- Needs review
	}, { __index = _NPCScan.L.NPCs; } );

	BUTTON_FOUND = "NSC gefunden!",
	CACHED_FORMAT = "Die folgende(n) Einheit(en) befinden sich bereits im Cache: %s.",
	CACHED_LONG_FORMAT = "Die folgende(n) Einheit(en) befinden sich bereits im Cache. Entweder über |cff808080“/npcscan”|rs Menü entfernen oder deine Cache-Datei leeren: %s.",
	CACHED_PET_RESTING_FORMAT = "Die folgenden zähmbaren Begleiter wurden während des Ausruhens dem Cache hinzugefügt: %s.",
	CACHED_STABLED_FORMAT = "Nach den folgenden Einheiten kann nicht gesucht werden, weil schon gezähmt: %s.",
	CACHED_WORLD_FORMAT = "Die folgende(n) %2$s Einheite(n) befinden sich bereits im Cache: %1$s.",
	CACHELIST_ENTRY_FORMAT = "|cff808080“%s”|r",
	CACHELIST_SEPARATOR = ",",
	CMD_ADD = "ADD",
	CMD_CACHE = "CACHE",
	CMD_CACHE_EMPTY = "Keiner der zu suchenden Mobs befindet sich im Cache.",
	CMD_HELP = "Die Befehle sind  |cff808080“/npcscan add <NpcID> <Name>”|r, |cff808080“/npcscan remove <NpcID or Name>”|r, |cff808080“/npcscan cache”|r um Mobs hinzuzufügen, zu entfernen, oder in der Cache-Datei gelistete anzuzeigen, und |cff808080“/npcscan”|r für das Options-Menü.",
	CMD_REMOVE = "REMOVE",
	CMD_REMOVENOTFOUND_FORMAT = "NSC |cff808080“%s”|r nicht gefunden.",
	CONFIG_ALERT = "Warnungsoptionen",
	CONFIG_ALERT_SOUND = "Warnton-Datei",
	CONFIG_ALERT_SOUND_DEFAULT = "|cffffd200Default|r",
	CONFIG_ALERT_SOUND_DESC = "Wähle den abzuspielenden Warnton, wenn ein NSC gefunden wird. Zusätzliche Töne können über |cff808080“SharedMedia”|r Addons hinzugefügt werden.",
	CONFIG_ALERT_UNMUTE = "Stummschaltung für Warnton ausschalten",
	CONFIG_ALERT_UNMUTE_DESC = "Schaltet Spielgeräusche ein während die Zielschaltfläche angezeigt wird, um Warntöne trotz Stummschaltung zu hören.",
	CONFIG_CACHEWARNINGS = "Cache-Erinnerungsmitteilungen beim Einloggen und bei Gebietswechsel ausgeben",
	CONFIG_CACHEWARNINGS_DESC = "Falls ein NSC beim Einloggen oder beim Gebietswechsel bereits im Cache vorhanden ist, gibt diese Option eine Erinnerungsmitteilung aus, nach welchen Mobs nicht gesucht werden kann.",
	CONFIG_DESC = "Diese Option läßt dich einstellen, auf welche Weise _NPCScan dich warnt, wenn es einen seltenen NSC findet.",
	CONFIG_TEST = "Gefunden-Warnton testen",
	CONFIG_TEST_DESC = "Simuliert einen |cff808080“NSC gefunden”|r Warnton, um anzuzeigen, worauf du achten musst.",
	CONFIG_TEST_HELP_FORMAT = "Zielschaltfläche anklicken oder gebundene Taste verwenden, um den gefundenen Mob ins Ziel zu nehmen. Halten |cffffffff<%s>|r und ziehen, um die Zielschaltfläche zu bewegen. Beachte, dass die Zielschlaltfläche nur außerhalb eines Kampfes bzw. nach einem Kampf erscheint, falls ein NSC während des Kampfes aufgespürt wurde.",
	CONFIG_TEST_NAME = "Du! (Test)",
	CONFIG_TITLE = "_|cffCCCC88NPCScan|r",
	FOUND_FORMAT = "|cff808080“%s”|r gefunden!",
	FOUND_TAMABLE_FORMAT = "|cff808080“%s”|r gefunden!  |cffff2020(Anmerkung: Zähmbarer Mob, vielleicht nur ein Begleiter.)|r",
	FOUND_TAMABLE_WRONGZONE_FORMAT = "|cffff2020Falscher Alarm:|r Zähmbarer Mob gefunden |cff808080“%s”|r in %s anstatt von %s (ID %d); mit Sicherheit ein Begleiter.",
	PRINT_FORMAT = "%s_|cffCCCC88NPCScan|r: %s",
	SEARCH_ACHIEVEMENTADDFOUND = "Suche nach NSCs abgeschlossener Erfolge",
	SEARCH_ACHIEVEMENTADDFOUND_DESC = "Sucht weiter alle für Erfolge relevanten NSCs, auch wenn sie nicht mehr benötigt werden sollten.",
	SEARCH_ACHIEVEMENT_DISABLED = "Ausgeschaltet",
	SEARCH_ADD = "+",
	SEARCH_ADD_DESC = "Neuen NSC hinzufügen oder Änderungen bei bestehendem speichern.",
	SEARCH_ADD_TAMABLE_FORMAT = "Anmerkung: |cff808080“%s”|r ist zähmbar, somit wird ein falscher Alarm ertönen, wenn man ihm als gezähmten Begleiter eines Jägers begegnet.",
	SEARCH_CACHED = "Im Cache",
	SEARCH_COMPLETED = "Fertig",
	SEARCH_DESC = "Diese Tabelle ermöglicht dir, scanbare NSCs und Erfolge hinzuzufügen oder zu entfernen.",
	SEARCH_ID = "NSC ID:",
	SEARCH_ID_DESC = "Die ID des zu suchenden NSCs. Dieser Wert kann auf Internetseiten wie Wowhead.com gefunden werden.",
	SEARCH_MAP = "Gebiet:",
	SEARCH_NAME = "Name:",
	SEARCH_NAME_DESC = "Kennzeichnung für einen NSC. Diese muß nicht dem tatsächlichen Namen des NSCs entsprechen.",
	SEARCH_NPCS = "Normale NSCs",
	SEARCH_NPCS_DESC = "Jeden NSC zur Suche hinzufügen, auch wenn er irrelevant für Erfolge ist.",
	SEARCH_REMOVE = "-",
	SEARCH_TITLE = "Suche",
	SEARCH_WORLD = "Welt:",
	SEARCH_WORLD_DESC = "Ein frei wählbarer Gebietsname, wo gesucht werden soll. Dies kann der Name eines Kontinents sein oder ein |cffff7f3fInstanzenname|r (Groß- und Kleinschreibung beachten).",
	SEARCH_WORLD_FORMAT = "(%s)",
}, { __index = _NPCScan.L; } );


_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Auf letzten gefundenen Mob zielen
|cff808080(Benutzen, wenn _NPCScan dich warnt)|r]=];