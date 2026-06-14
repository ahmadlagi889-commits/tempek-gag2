-- Decompiled with Potassium's decompiler.

local l__ServerStorage__1 = game:GetService("ServerStorage");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__FastFlags__3 = require(l__ReplicatedStorage__2.UserGenerated.FastFlags);
local l__Asserts__4 = require(l__ReplicatedStorage__2.UserGenerated.Lang.Asserts);
local u1 = {
    Gold = require(script.Gold),
    Rainbow = require(script.Rainbow),
    Electric = require(script.Electric),
    Frozen = require(script.Frozen),
    Bloodlit = require(script.Bloodlit),
    Chained = require(script.Chained),
    Starstruck = require(script.Starstruck)
};
local v2 = {};
local v3 = {};
for v4, v5 in u1 do
    v2[v4] = v5.PriceMultiplier or 1;
end;
local u6 = l__FastFlags__3.Replicated("Game.Mutations.PriceMultipliers", l__Asserts__4.Map(l__Asserts__4.String, l__Asserts__4.FinitePositive), v2);
local function u11(p7, p8) --[[ Line: 62 ]]
    local v9 = math.floor(p7);
    local v10 = 1 / math.max(v9, 1);
    return (p8 <= 1 or v10 >= 0.3) and {
        GlobalChance = v10,
        EffectiveChance = v10
    } or {
        GlobalChance = v10,
        EffectiveChance = math.min(v10 * p8, 0.3)
    };
end;
function v3.GetMutation(p12) --[[ Line: 74 ]]
    -- upvalues: u1 (copy)
    return u1[p12];
end;
function v3.ReturnPriceMultiplier(p13) --[[ Line: 78 ]]
    -- upvalues: u6 (copy), u1 (copy)
    local v14 = u6:Get()[p13];
    if v14 then
        return v14;
    end;
    local v15 = u1[p13];
    return v15 and (v15.PriceMultiplier or 1) or 1;
end;
function v3.ReturnFruitMutation(p16, p17) --[[ Line: 95 ]]
    -- upvalues: u1 (copy), l__ServerStorage__1 (copy), u11 (copy)
    local v18 = Random.new(p16);
    for v19, v20 in u1 do
        if v20.FruitChance and v20.CanGetOnGrowth then
            local v21 = l__ServerStorage__1:FindFirstChild("MutationChanceMultipliers");
            local v22;
            if v21 then
                local v23 = v21:FindFirstChild(v19);
                if v23 and v23:IsA("NumberValue") then
                    local l__Value__5 = v23.Value;
                    v22 = l__Value__5 <= 0 and 1 or l__Value__5;
                else
                    v22 = 1;
                end;
            else
                v22 = 1;
            end;
            local v24 = p17 and (p17[v19] or 1) or 1;
            local v25 = u11(v20.FruitChance / v22, v24);
            local v26 = v18:NextNumber();
            if v26 < v25.EffectiveChance then
                local v27;
                if v24 > 1 then
                    v27 = v25.GlobalChance <= v26;
                else
                    v27 = false;
                end;
                return v19, v27;
            end;
        end;
    end;
    return nil, false;
end;
function v3.ReturnPlantMutation(p28, p29) --[[ Line: 113 ]]
    -- upvalues: u1 (copy), l__ServerStorage__1 (copy), u11 (copy)
    local v30 = Random.new(p28);
    for v31, v32 in u1 do
        if v32.PlantChance and v32.CanGetOnGrowth then
            local v33 = l__ServerStorage__1:FindFirstChild("MutationChanceMultipliers");
            local v34;
            if v33 then
                local v35 = v33:FindFirstChild(v31);
                if v35 and v35:IsA("NumberValue") then
                    local l__Value__6 = v35.Value;
                    v34 = l__Value__6 <= 0 and 1 or l__Value__6;
                else
                    v34 = 1;
                end;
            else
                v34 = 1;
            end;
            local v36 = p29 and (p29[v31] or 1) or 1;
            local v37 = u11(v32.PlantChance / v34, v36);
            local v38 = v30:NextNumber();
            if v38 < v37.EffectiveChance then
                local v39;
                if v36 > 1 then
                    v39 = v37.GlobalChance <= v38;
                else
                    v39 = false;
                end;
                return v31, v39;
            end;
        end;
    end;
    return nil, false;
end;
return v3;