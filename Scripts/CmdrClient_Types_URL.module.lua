-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local u3 = {
    Validate = function(p1) --[[ Name: Validate, Line 4 ]]
        if p1:match("^https?://.+$") then
            return true;
        else
            return false, "URLs must begin with http:// or https://";
        end;
    end,
    Parse = function(p2) --[[ Name: Parse, Line 12 ]]
        return p2;
    end
};
return function(p4) --[[ Line: 17 ]]
    -- upvalues: u3 (copy), l__Util__1 (copy)
    p4:RegisterType("url", u3);
    p4:RegisterType("urls", l__Util__1.MakeListableType(u3));
end;