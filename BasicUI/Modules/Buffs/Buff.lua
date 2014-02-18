local B, C, DB = unpack(select(2, ...)) -- Import:  B - function; C - config; DB - Database

if C['buff'].enable ~= true then return end

BuffFrame:ClearAllPoints()
BuffFrame:SetScale(C["buff"].buffScale)
BuffFrame:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -25, 0)

