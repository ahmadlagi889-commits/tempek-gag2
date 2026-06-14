-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__FormatAbbreviated__2 = require(l__ReplicatedStorage__1.UserGenerated.Strings.FormatAbbreviated);
return function(p1) --[[ Name: FormatOdds, Line 24 ]]
    -- upvalues: l__FormatAbbreviated__2 (copy)
    local v2 = type(p1) == "number";
    assert(v2);
    return p1 == 0 and "0" or (p1 == (1 / 0) and "Infinity" or (p1 == (-1 / 0) and "-Infinity" or (p1 ~= p1 and "NaN" or "1/" .. l__FormatAbbreviated__2(1 / p1))));
end;