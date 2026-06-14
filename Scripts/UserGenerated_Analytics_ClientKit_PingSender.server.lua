-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__Ping__2 = script.Parent:WaitForChild("Ping");
local u1 = 0;
local u2 = 0;
local function v3() --[[ Line: 27 ]]
    -- upvalues: u2 (ref), l__Ping__2 (copy)
    u2 = u2 + 1;
    l__Ping__2:FireServer(u2, workspace:GetServerTimeNow());
end;
l__RunService__1.Heartbeat:Connect(function(p4) --[[ Line: 34 ]]
    -- upvalues: u1 (ref), u2 (ref), l__Ping__2 (copy)
    u1 = u1 + p4;
    if u1 >= 1 then
        u1 = u1 % 1;
        u2 = u2 + 1;
        l__Ping__2:FireServer(u2, workspace:GetServerTimeNow());
    end;
end);
task.spawn(v3);