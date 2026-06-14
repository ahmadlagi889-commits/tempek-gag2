-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
require(l__ReplicatedStorage__1.UserGenerated.FastFlags.SharedFastFlags);
local v1 = nil;
if l__RunService__2:IsClient() then
    return require(l__ReplicatedStorage__1.UserGenerated.Client.ClientFastFlags);
elseif l__RunService__2:IsServer() then
    local l__ServerScriptService__3 = game:GetService("ServerScriptService");
    return require(l__ServerScriptService__3.UserGenerated.Server.ServerFastFlags);
else
    error("RunContext");
    return v1;
end;