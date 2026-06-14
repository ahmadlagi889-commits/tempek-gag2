-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__DeepEquals__2 = require(l__ReplicatedStorage__1.UserGenerated.Collections.DeepEquals);
local l__Bindable__3 = require(l__ReplicatedStorage__1.UserGenerated.Concurrency.Bindable);
local v4 = table.freeze({
    Get = function(p1) --[[ Name: Get, Line 45 ]]
        return p1.Value;
    end,
    Set = function(p2, p3) --[[ Name: Set, Line 62 ]]
        -- upvalues: l__DeepEquals__2 (copy)
        if p2.Assertion then
            p3 = p2.Assertion(p3);
        end;
        local l__Value__4 = p2.Value;
        p2.Value = p3;
        if not l__DeepEquals__2(p3, l__Value__4) then
            p2.Changed:Fire(p3, l__Value__4);
        end;
        return l__Value__4;
    end
});
local u5 = table.freeze({
    __index = v4
});
return table.freeze({
    new = function(p6, p7) --[[ Name: new, Line 84 ]]
        -- upvalues: l__Bindable__3 (copy), u5 (copy)
        local v8 = type(p6) == "function";
        assert(v8);
        local v9 = p6(p7);
        local v10 = {
            Changed = l__Bindable__3.new(),
            Assertion = p6,
            Value = v9
        };
        v10.Readonly = v10;
        return setmetatable(v10, u5);
    end,
    Unasserted = function(p11) --[[ Name: Unasserted, Line 100 ]]
        -- upvalues: l__Bindable__3 (copy), u5 (copy)
        local v12 = {
            Changed = l__Bindable__3.new(),
            Value = p11
        };
        v12.Readonly = v12;
        return setmetatable(v12, u5);
    end
});