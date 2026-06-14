-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__FastFlags__2 = require(l__ReplicatedStorage__1.UserGenerated.FastFlags);
local l__Asserts__3 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local v1 = l__FastFlags__2.Replicated("Game.Perf.Client.AgeUpdateMaxHz", l__Asserts__3.FinitePositive, 60);
local v2 = l__FastFlags__2.Replicated("Game.Perf.Client.MutationVFXDisabled", l__Asserts__3.Boolean, false);
local v3 = l__FastFlags__2.Replicated("Game.Perf.Client.DroppedItemAnimationsDisabled", l__Asserts__3.Boolean, false);
local v4 = l__FastFlags__2.Replicated("Game.Perf.Client.AnimatedGradientsDisabled", l__Asserts__3.Boolean, false);
local v5 = l__FastFlags__2.Replicated("Game.Perf.Client.PlantVisualizerBudget", l__Asserts__3.FinitePositive, 75);
return table.freeze({
    AgeUpdateMaxHz = v1,
    MutationVFXDisabled = v2,
    DroppedItemAnimationsDisabled = v3,
    AnimatedGradientsDisabled = v4,
    PlantVisualizerBudget = v5
});