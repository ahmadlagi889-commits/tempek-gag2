-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__FastFlags__2 = require(l__ReplicatedStorage__1.UserGenerated.FastFlags);
local l__Asserts__3 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local v1 = l__FastFlags__2.Replicated("Game.Garden.ExpansionPriceOverrides", l__Asserts__3.Map(l__Asserts__3.String, l__Asserts__3.FiniteNonNegative), {});
return table.freeze({
    ExpansionPriceOverrides = v1
});