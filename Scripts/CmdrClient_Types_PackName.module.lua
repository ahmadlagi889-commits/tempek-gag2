-- Decompiled with Potassium's decompiler.

local l__Util__1 = require(script.Parent.Parent.Shared.Util);
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local function u5() --[[ Line: 4 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy)
    local v1 = l__ReplicatedStorage__2:FindFirstChild("Modules"):FindFirstChild("Pack_MODULE");
    local v2 = require(v1:FindFirstChild("PackData"));
    local v3 = {};
    for v4, _ in pairs(v2) do
        table.insert(v3, v4);
    end;
    table.sort(v3);
    return v3;
end;
local u11 = {
    Transform = function(p6) --[[ Name: Transform, Line 18 ]]
        -- upvalues: u5 (copy), l__Util__1 (copy)
        local v7 = u5();
        return l__Util__1.MakeFuzzyFinder(v7)(p6);
    end,
    Validate = function(p8) --[[ Name: Validate, Line 24 ]]
        return #p8 > 0, "No pack with that name could be found.";
    end,
    Autocomplete = function(p9) --[[ Name: Autocomplete, Line 28 ]]
        return p9;
    end,
    Parse = function(p10) --[[ Name: Parse, Line 32 ]]
        return p10[1];
    end
};
return function(p12) --[[ Line: 37 ]]
    -- upvalues: u11 (copy)
    p12:RegisterType("packName", u11);
end;