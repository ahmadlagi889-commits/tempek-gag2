-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__ServerScriptService__3 = game:GetService("ServerScriptService");
require(l__ReplicatedStorage__1.UserGenerated.ABTests.SharedABTests);
if l__RunService__2:IsServer() then
    return require(l__ServerScriptService__3.UserGenerated.Server.ServerABTests);
else
    return require(l__ReplicatedStorage__1.UserGenerated.Client.ClientABTests);
end;