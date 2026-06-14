-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__CollectionService__2 = game:GetService("CollectionService");
local l__LocalPlayer__3 = l__Players__1.LocalPlayer;
local u1 = l__CollectionService__2:HasTag(l__LocalPlayer__3, "PersistentLoaded") and true or false;
local v3 = l__CollectionService__2:GetInstanceAddedSignal("PersistentLoaded"):Connect(function(p2) --[[ Line: 10 ]]
    -- upvalues: l__LocalPlayer__3 (copy), u1 (ref)
    if p2 == l__LocalPlayer__3 then
        u1 = true;
    end;
end);
local v4 = workspace.PersistentLoaded:Connect(function() --[[ Line: 17 ]]
    -- upvalues: u1 (ref)
    u1 = true;
end);
repeat
    task.wait();
until u1;
if v3 then
    v3:Disconnect();
end;
if v4 then
    v4:Disconnect();
end;
repeat
    task.wait();
until game:IsLoaded();
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__RunService__5 = game:GetService("RunService");
local l__Environment__6 = require(l__ReplicatedStorage__4.SharedModules.Environment);
local l__Controllers__7 = script.Parent:WaitForChild("Controllers");
local v5 = os.clock();
local function v20(p6, p7, u8) --[[ Line: 55 ]]
    local u9 = false;
    local u10 = false;
    local u11 = nil;
    task.spawn(function() --[[ Line: 60 ]]
        -- upvalues: u10 (ref), u11 (ref), u8 (copy), u9 (ref)
        local v12, v13 = pcall(u8);
        u10 = v12;
        u11 = v13;
        u9 = true;
    end);
    local v14 = os.clock();
    local v15 = u11;
    local v16 = u10;
    local v17 = 3;
    while not u9 do
        task.wait(0.1);
        if u9 then
            break;
        end;
        local v18 = os.clock() - v14;
        if v18 >= 30 then
            warn(string.format("%s \'%s\' %s exceeded %ds and was abandoned -- this controller likely yields forever (e.g. WaitForChild for an instance that never replicates). Continuing startup so the player can still load.", "[ControllerStarter]", p7, p6, 30));
            return false, "timeout";
        end;
        if v17 <= v18 then
            warn(string.format("%s \'%s\' still running %s after %.1fs -- this is blocking all remaining controllers and the loading screen.", "[ControllerStarter]", p7, p6, v18));
            v17 = v17 + 3;
        end;
    end;
    local v19 = os.clock() - v14;
    if v19 >= 1 then
        warn(string.format("%s \'%s\' %s took %.0fms.", "[ControllerStarter]", p7, p6, v19 * 1000));
    end;
    if not v16 then
        warn(string.format("%s \'%s\' %s errored: %s", "[ControllerStarter]", p7, p6, (tostring(v15))));
    end;
    return v16, v15;
end;
local v21 = {};
local v22 = 3;
while not l__LocalPlayer__3.Character do
    task.wait(0.1);
    local v23 = os.clock() - v5;
    if v22 <= v23 then
        warn(string.format("%s Still waiting for the character to spawn after %.1fs -- spawn is gated on profile data load; controllers can\'t start until StarterGui has cloned into PlayerGui.", "[ControllerStarter]", v23));
        v22 = v22 + 3;
    end;
end;
local v24 = os.clock();
local u25 = require;
for _, u26 in l__Controllers__7:GetChildren() do
    local v27, v28 = v20("require", u26.Name, function() --[[ Line: 133 ]]
        -- upvalues: u25 (copy), u26 (copy)
        return u25(u26);
    end);
    if v27 then
        table.insert(v21, {
            name = u26.Name,
            module = v28
        });
    end;
end;
table.sort(v21, function(p29, p30) --[[ Line: 143 ]]
    return (p29.module.StartOrder or 0) < (p30.module.StartOrder or 0);
end);
for _, u31 in v21 do
    if u31.module.Init and (not (u31.module.Disabled or v20("Init", u31.name, function() --[[ Line: 152 ]]
        -- upvalues: u31 (copy)
        u31.module:Init();
    end)) and true or false) then
        u31.failed = true;
    end;
end;
for _, u32 in v21 do
    if not u32.failed and u32.module.Start then
        v20("Start", u32.name, function() --[[ Line: 166 ]]
            -- upvalues: u32 (copy)
            u32.module:Start();
        end);
    end;
end;
if l__RunService__5:IsStudio() or l__Environment__6.env == "Dev" then
    print(string.format("%s All controllers started in %.0fms (%d loaded).", "[ControllerStarter]", (os.clock() - v24) * 1000, #v21));
end;
l__LocalPlayer__3:AddTag("ControllersStarted");