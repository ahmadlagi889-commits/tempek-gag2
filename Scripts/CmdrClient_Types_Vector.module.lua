-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local function v3(p1, p2) --[[ Line: 3 ]]
    if p1 == nil then
        return false, ("Invalid or missing number at position %d in Vector type."):format(p2);
    else
        return true;
    end;
end;
local u4 = l__Util__1.MakeSequenceType({
    Length = 3,
    ValidateEach = v3,
    TransformEach = tonumber,
    Constructor = Vector3.new
});
local u5 = l__Util__1.MakeSequenceType({
    Length = 2,
    ValidateEach = v3,
    TransformEach = tonumber,
    Constructor = Vector2.new
});
return function(p6) --[[ Line: 25 ]]
    -- upvalues: u4 (copy), l__Util__1 (copy), u5 (copy)
    p6:RegisterType("vector3", u4);
    p6:RegisterType("vector3s", l__Util__1.MakeListableType(u4));
    p6:RegisterType("vector2", u5);
    p6:RegisterType("vector2s", l__Util__1.MakeListableType(u5));
end;