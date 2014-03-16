local B, C = unpack(select(2, ...)) -- Import:  B - function; C - config
local cfg = C["buff"]

if cfg.enable ~= true then return end

BuffFrame:ClearAllPoints()
BuffFrame:SetScale(cfg.buffScale)
BuffFrame:SetPoint('TOPRIGHT', Minimap, 'TOPLEFT', -25, 0)

