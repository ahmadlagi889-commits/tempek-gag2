-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__SellValueData__2 = require(script.Parent.SellValueData);
local l__MutationData__3 = require(script.Parent.MutationData);
local l__SeedData__4 = require(script.Parent.SeedData);
local l__FastFlags__5 = require(l__ReplicatedStorage__1.UserGenerated.FastFlags);
local l__Asserts__6 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local u1 = l__FastFlags__5.Replicated("Game.Selling.SizeMultiplier", l__Asserts__6.FinitePositive, 1);
local u2 = l__FastFlags__5.Replicated("Game.Selling.MutationMultiplier", l__Asserts__6.FinitePositive, 1);
local u3 = l__FastFlags__5.Replicated("Game.Selling.SizeExponent", l__Asserts__6.FinitePositive, 2.65);
local u4 = l__FastFlags__5.Replicated("Game.Selling.SizeExponentOverrides", l__Asserts__6.Map(l__Asserts__6.String, l__Asserts__6.FinitePositive), {
    Bamboo = 2.4
});
local u5 = {};
local u6 = {
    Carrot = 4
};
for _, v7 in l__SeedData__4 do
    u5[v7.SeedName] = v7.IsSingleHarvest == true;
end;
return function(p8, p9, p10, p11, p12) --[[ Name: Calculate, Line 30 ]]
    -- upvalues: l__SellValueData__2 (copy), l__MutationData__3 (copy), u5 (copy), u2 (copy), u4 (copy), u3 (copy), u1 (copy), u6 (copy)
    local v13 = l__SellValueData__2[p8] or 0;
    local v14 = not p10 and 1 or l__MutationData__3.ReturnPriceMultiplier(p10);
    if u5[p8] and v14 > 1 then
        v14 = 1 + (v14 - 1) * 0.25;
    end;
    if p10 then
        v14 = v14 * u2:Get();
    end;
    local v15 = (typeof(p12) ~= "number" or p12 <= 0) and 1 or 1 - math.clamp(p12, 0, 1) * 0.8;
    local v16 = v13 * p9 ^ (u4:Get()[p8] or u3:Get()) * u1:Get() * v14 * v15;
    local v17 = math.floor(v16) * (1 + (p11:GetAttribute("Friends") or 0) * 0.1);
    local v18 = math.floor(v17);
    local v19 = u6[p8];
    if v19 then
        if v18 >= v19 then
            v19 = v18;
        end;
    else
        v19 = v18;
    end;
    return v19;
end;