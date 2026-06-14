-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__FormatOdds__2 = require(l__ReplicatedStorage__1.UserGenerated.Strings.FormatOdds);
local l__FormatPercent__3 = require(l__ReplicatedStorage__1.UserGenerated.Strings.FormatPercent);
return function(p1, p2) --[[ Name: FormatChance, Line 31 ]]
    -- upvalues: l__FormatOdds__2 (copy), l__FormatPercent__3 (copy)
    local v3 = type(p1) == "number";
    assert(v3);
    local v4 = p2 == nil and true or type(p2) == "number";
    assert(v4);
    local v5 = math.clamp(p1, 0, 1);
    local v6 = math.clamp(p2 or v5, 0, 1);
    if v5 > 0 and (v6 <= 0.0002 and v5 <= 0.001) then
        return l__FormatOdds__2(v5);
    else
        return l__FormatPercent__3(v5);
    end;
end;