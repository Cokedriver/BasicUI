local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config
local LSM = LibStub("LibSharedMedia-3.0")

-- Load All SharedMedia

-- Font Media

C["media"].fontNormal = LSM:Fetch("font", C["media"].fontNormal)
C["media"].fontBold = LSM:Fetch("font", C["media"].fontBold)
C["media"].fontItalic = LSM:Fetch("font", C["media"].fontItalic)
C["media"].fontBoldItalic = LSM:Fetch("font", C["media"].fontBoldItalic)
C["media"].fontNumber = LSM:Fetch("font", C["media"].fontNumber)

-- Minimap Media
C["minimap"].border = LSM:Fetch("border", C["minimap"].border)

-- Skins Media
C["skin"].border = LSM:Fetch("border", C["skin"].border)
C["skin"].statusbar = LSM:Fetch("statusbar", C["skin"].statusbar)

-- Buff Media
C["buff"].border = LSM:Fetch("border", C["buff"].border)

-- Castbar Media
C["castbar"].border = LSM:Fetch("border", C["castbar"].border)
C["castbar"].background = LSM:Fetch("background", C["castbar"].background)
C["castbar"].statusbar = LSM:Fetch("statusbar", C["castbar"].statusbar)

-- Chat Media
C["chat"].border = LSM:Fetch("border", C["chat"].border)
C["chat"].background = LSM:Fetch("background", C["chat"].background)
C["chat"].editboxborder = LSM:Fetch("border", C["chat"].editboxborder)
C["chat"].editboxbackground = LSM:Fetch("background", C["chat"].editboxbackground)
C["chat"].sound = LSM:Fetch("sound", C["chat"].sound)

-- Datatext Media
C["datatext"].border = LSM:Fetch("border", C["datatext"].border)
C["datatext"].background = LSM:Fetch("background", C["datatext"].background)

-- Nameplates Media
C["nameplates"].border = LSM:Fetch("border", C["nameplates"].border)
C["nameplates"].background = LSM:Fetch("background", C["nameplates"].background)
C["nameplates"].statusbar = LSM:Fetch("statusbar", C["nameplates"].statusbar)

-- Powerbar Media
C["powerbar"].background = LSM:Fetch("background", C["powerbar"].background)
C["powerbar"].statusbar = LSM:Fetch("statusbar", C["powerbar"].statusbar)

-- Tooltip Media
C["tooltip"].border = LSM:Fetch("border", C["tooltip"].border)
C["tooltip"].background = LSM:Fetch("background", C["tooltip"].background)
C["tooltip"].statusbar = LSM:Fetch("statusbar", C["tooltip"].statusbar)