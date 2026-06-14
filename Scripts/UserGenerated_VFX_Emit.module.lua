-- Decompiled with Potassium's decompiler.

local l__EmitOnce__1 = require(game.ReplicatedStorage.UserGenerated.VFX.EmitOnce);
local function u4(p1) --[[ Line: 22 ]]
    -- upvalues: l__EmitOnce__1 (copy), u4 (copy)
    local v2 = 0;
    if p1:IsA("ParticleEmitter") then
        v2 = math.max(v2, l__EmitOnce__1(p1));
    end;
    for _, v3 in ipairs(p1:GetChildren()) do
        v2 = math.max(v2, u4(v3));
    end;
    return v2;
end;
return u4;