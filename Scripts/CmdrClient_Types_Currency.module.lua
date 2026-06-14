-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
game:GetService("ReplicatedStorage");
local u5 = {
    Transform = function(p1) --[[ Name: Transform, Line 9 ]]
        -- upvalues: l__Util__1 (copy)
        return l__Util__1.MakeFuzzyFinder({ "IronBars", "Yen" })(p1);
    end,
    Validate = function(p2) --[[ Name: Validate, Line 15 ]]
        return #p2 > 0, "No currency with that name could be found.";
    end,
    Autocomplete = function(p3) --[[ Name: Autocomplete, Line 19 ]]
        return p3;
    end,
    Parse = function(p4) --[[ Name: Parse, Line 23 ]]
        return p4[1];
    end
};
return function(p6) --[[ Line: 28 ]]
    -- upvalues: u5 (copy)
    p6:RegisterType("currencyName", u5);
end;