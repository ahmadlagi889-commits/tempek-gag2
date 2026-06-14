-- Decompiled with Potassium's decompiler.

local l__BehaviorBase__1 = require(script.Parent.BehaviorBase);
local u1 = setmetatable({}, {
    __index = l__BehaviorBase__1
});
u1.__index = u1;
u1.Name = "StealFruit";
function u1.new(p2) --[[ Line: 10 ]]
    -- upvalues: l__BehaviorBase__1 (copy), u1 (copy)
    local v3 = l__BehaviorBase__1.New(u1, p2);
    v3.TargetPlayer = nil;
    v3.TargetPlantId = nil;
    v3.TargetFruitId = nil;
    v3.CarriedFruitData = nil;
    v3.States = {
        Targeting = {
            Enter = function(p4) --[[ Name: Enter, Line 23 ]]
                p4:Stop("NotImplemented");
            end
        }
    };
    return v3;
end;
function u1.GetInitialState(_) --[[ Line: 33 ]]
    return "Targeting";
end;
function u1.CanStart(_) --[[ Line: 38 ]]
    return true;
end;
return u1;