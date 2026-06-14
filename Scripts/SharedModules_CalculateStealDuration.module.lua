-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__SellValueData__1 = require(game.ReplicatedStorage.SharedModules.SellValueData);
local l__MutationData__2 = require(game.ReplicatedStorage.SharedModules.MutationData);
function v1.Start(_) --[[ Line: 6 ]] end;
function v1.Init(_) --[[ Line: 10 ]] end;
function v1.CalculateStealDuration(_, p2, p3, p4) --[[ Line: 14 ]]
    -- upvalues: l__SellValueData__1 (copy), l__MutationData__2 (copy)
    local v5 = math.floor(l__SellValueData__1[p2 or "Carrot"] * (p3 == nil and 1 or p3) ^ 3);
    if p4 then
        v5 = v5 * l__MutationData__2.ReturnPriceMultiplier(p4);
    end;
    return math.sqrt(v5);
end;
return v1;