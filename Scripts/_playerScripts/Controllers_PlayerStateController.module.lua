-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 0
};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__PlayerStateClient__2 = require(l__ReplicatedStorage__1.ClientModules.PlayerStateClient);
function v1.Init(_) --[[ Line: 8 ]] end;
function v1.Start(_) --[[ Line: 11 ]]
    -- upvalues: l__PlayerStateClient__2 (copy)
    l__PlayerStateClient__2:GetLocalReplica();
end;
return v1;