-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
return function(u1) --[[ Line: 3 ]]
    -- upvalues: l__Util__1 (copy)
    local v6 = {
        Transform = function(p2) --[[ Name: Transform, Line 5 ]]
            -- upvalues: l__Util__1 (ref), u1 (copy)
            return l__Util__1.MakeFuzzyFinder(u1:GetTypeNames())(p2);
        end,
        Validate = function(p3) --[[ Name: Validate, Line 11 ]]
            return #p3 > 0, "No type with that name could be found.";
        end,
        Autocomplete = function(p4) --[[ Name: Autocomplete, Line 15 ]]
            return p4;
        end,
        Parse = function(p5) --[[ Name: Parse, Line 19 ]]
            return p5[1];
        end
    };
    u1:RegisterType("type", v6);
    u1:RegisterType("types", l__Util__1.MakeListableType(v6));
end;