-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__FormatFigures__2 = require(l__ReplicatedStorage__1.UserGenerated.Strings.FormatFigures);
return function(p1) --[[ Name: FormatPercent, Line 24 ]]
    -- upvalues: l__FormatFigures__2 (copy)
    return l__FormatFigures__2(p1 * 100, 4, 5) .. "%";
end;