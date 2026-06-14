-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__FastFlags__2 = require(l__ReplicatedStorage__1.UserGenerated.FastFlags);
local l__Asserts__3 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local v1 = l__FastFlags__2.Replicated("Game.AntiAfk.Enabled", l__Asserts__3.Boolean, true);
local v2 = l__FastFlags__2.Replicated("Game.AntiAfk.IdleSeconds", l__Asserts__3.FinitePositive, 1140);
return table.freeze({
    Enabled = v1,
    IdleSeconds = v2
});