-- Decompiled with Potassium's decompiler.

local l__FastFlags__1 = require(game.ReplicatedStorage.UserGenerated.FastFlags);
local l__Parent__2 = require(script.Parent);
local v1 = l__FastFlags__1.Replicated("UserGenerated.Logging.ClientLevel", l__Parent__2.AssertLevel, "Warn");
l__Parent__2.SetLevel(v1:Get());
v1.Changed:Connect(function(p2) --[[ Line: 27 ]]
    -- upvalues: l__Parent__2 (copy)
    l__Parent__2.SetLevel(p2);
end);