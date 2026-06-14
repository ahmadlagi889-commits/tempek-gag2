-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local u3 = l__Util__1.MakeSequenceType({
    Prefixes = "# hexColor3 ! brickColor3",
    Length = 3,
    ValidateEach = function(p1, p2) --[[ Name: ValidateEach, Line 5 ]]
        if p1 == nil then
            return false, ("Invalid or missing number at position %d in Color3 type."):format(p2);
        elseif p1 < 0 or p1 > 255 then
            return false, ("Number out of acceptable range 0-255 at position %d in Color3 type."):format(p2);
        elseif p1 % 1 == 0 then
            return true;
        else
            return false, ("Number is not an integer at position %d in Color3 type."):format(p2);
        end;
    end,
    TransformEach = tonumber,
    Constructor = Color3.fromRGB
});
local function u5(p4) --[[ Line: 21 ]]
    if #p4 == 1 then
        p4 = p4 .. p4;
    end;
    return tonumber(p4, 16);
end;
local u14 = {
    Transform = function(p6) --[[ Name: Transform, Line 30 ]]
        -- upvalues: l__Util__1 (copy), u5 (copy)
        local v7, v8, v9 = p6:match("^#?(%x%x?)(%x%x?)(%x%x?)$");
        return l__Util__1.Each(u5, v7, v8, v9);
    end,
    Validate = function(p10, p11, p12) --[[ Name: Validate, Line 35 ]]
        local v13;
        if p10 == nil or p11 == nil then
            v13 = false;
        else
            v13 = p12 ~= nil;
        end;
        return v13, "Invalid hex color";
    end,
    Parse = function(...) --[[ Name: Parse, Line 39 ]]
        return Color3.fromRGB(...);
    end
};
return function(p15) --[[ Line: 44 ]]
    -- upvalues: u3 (copy), l__Util__1 (copy), u14 (copy)
    p15:RegisterType("color3", u3);
    p15:RegisterType("color3s", l__Util__1.MakeListableType(u3, {
        Prefixes = "# hexColor3s ! brickColor3s"
    }));
    p15:RegisterType("hexColor3", u14);
    p15:RegisterType("hexColor3s", l__Util__1.MakeListableType(u14));
end;