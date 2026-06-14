-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local u1 = {
    "^%a[%w_]*$",
    "^%$%a[%w_]*$",
    "^%.%a[%w_]*$",
    "^%$%.%a[%w_]*$"
};
return function(u2) --[[ Line: 10 ]]
    -- upvalues: u1 (copy), l__Util__1 (copy)
    local v7 = {
        Autocomplete = function(p3) --[[ Name: Autocomplete, Line 12 ]]
            -- upvalues: u2 (copy)
            return u2.Cmdr.Util.MakeFuzzyFinder(u2.Cmdr.Util.DictionaryKeys(u2:GetStore("vars_used") or {}))(p3);
        end,
        Validate = function(p4) --[[ Name: Validate, Line 18 ]]
            -- upvalues: u1 (ref)
            for _, v5 in ipairs(u1) do
                if p4:match(v5) then
                    return true;
                end;
            end;
            return false, "Key names must start with an optional modifier: . $ or $. and must begin with a letter.";
        end,
        Parse = function(p6) --[[ Name: Parse, Line 28 ]]
            return p6;
        end
    };
    u2:RegisterType("storedKey", v7);
    u2:RegisterType("storedKeys", l__Util__1.MakeListableType(v7));
end;