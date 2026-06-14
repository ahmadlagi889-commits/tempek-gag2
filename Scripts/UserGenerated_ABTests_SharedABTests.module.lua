-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.UserGenerated.Concurrency.Bindable);
local l__FastFlags__2 = require(l__ReplicatedStorage__1.UserGenerated.FastFlags);
local l__Asserts__3 = require(l__ReplicatedStorage__1.UserGenerated.Lang.Asserts);
local v1 = l__FastFlags__2.Replicated("UserGenerated.ABTestDefaults", l__Asserts__3.Map(l__Asserts__3.String, l__Asserts__3.Any), {});
return table.freeze({
    UpdateRemote = script:WaitForChild("Update"),
    ABTestDefaults = v1
});