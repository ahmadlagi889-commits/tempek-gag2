-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local u1 = Enum.UserInputType:GetEnumItems();
for _, v2 in pairs(Enum.KeyCode:GetEnumItems()) do
    u1[#u1 + 1] = v2;
end;
local u7 = {
    Transform = function(p3) --[[ Name: Transform, Line 10 ]]
        -- upvalues: l__Util__1 (copy), u1 (copy)
        return l__Util__1.MakeFuzzyFinder(u1)(p3);
    end,
    Validate = function(p4) --[[ Name: Validate, Line 16 ]]
        return #p4 > 0;
    end,
    Autocomplete = function(p5) --[[ Name: Autocomplete, Line 20 ]]
        -- upvalues: l__Util__1 (copy)
        return l__Util__1.GetNames(p5);
    end,
    Parse = function(p6) --[[ Name: Parse, Line 24 ]]
        return p6[1];
    end
};
return function(p8) --[[ Line: 29 ]]
    -- upvalues: u7 (copy), l__Util__1 (copy)
    p8:RegisterType("userInput", u7);
    p8:RegisterType("userInputs", l__Util__1.MakeListableType(u7));
end;