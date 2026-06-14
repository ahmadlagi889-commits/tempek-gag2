-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__StableExp10__2 = require(l__ReplicatedStorage__1.UserGenerated.Math.StableExp10);
return function(p1, p2, p3, p4) --[[ Name: RoundFigures, Line 40 ]]
    -- upvalues: l__StableExp10__2 (copy)
    local v5 = type(p1) == "number";
    assert(v5);
    local v6 = p2 == nil and true or type(p2) == "number";
    assert(v6);
    local v7 = p3 == nil and true or type(p3) == "number";
    assert(v7);
    local v8 = p4 == nil and true or type(p4) == "function";
    assert(v8);
    if p1 ~= p1 or (p1 == (1 / 0) or p1 == (-1 / 0)) then
        return p1;
    end;
    local v9 = p2 or 3;
    local v10 = p3 or 1;
    local v11 = p4 or math.round;
    local v12 = math.sign(p1);
    if v12 == 0 then
        return 0;
    end;
    local v13 = p1 * v12;
    local v14 = math.log10(v13);
    local v15 = math.floor(v14) - v9 + 1;
    if v10 ~= 1 then
        v13 = v13 / v10;
    end;
    return l__StableExp10__2(v11((l__StableExp10__2(v13, -v15))) * v10, v15) * v12;
end;