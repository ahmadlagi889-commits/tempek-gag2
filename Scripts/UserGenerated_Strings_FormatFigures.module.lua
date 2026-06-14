-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RoundFigures__2 = require(l__ReplicatedStorage__1.UserGenerated.Math.RoundFigures);
local l__Commas__3 = require(l__ReplicatedStorage__1.UserGenerated.Strings.Commas);
return function(p1, p2, p3, p4) --[[ Name: FormatFigures, Line 44 ]]
    -- upvalues: l__Commas__3 (copy), l__RoundFigures__2 (copy)
    return l__Commas__3(l__RoundFigures__2(p1, p2, p3, p4));
end;