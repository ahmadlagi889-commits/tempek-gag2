-- Decompiled with Potassium's decompiler.

local l__RunService__1 = game:GetService("RunService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local v1 = l__RunService__1:IsStudio();
local u2 = l__RunService__1:IsServer();
local u3 = {};
local u4 = nil;
local u5;
if u2 == true then
    u5 = l__ReplicatedStorage__2:FindFirstChild("RemoteEvents");
    if u5 == nil then
        u5 = Instance.new("Folder");
        u5.Name = "RemoteEvents";
        u5.Parent = l__ReplicatedStorage__2;
    else
        local _ = v1 == true;
    end;
else
    u5 = l__ReplicatedStorage__2:FindFirstChild("RemoteEvents");
    if u5 == nil then
        local u6 = Instance.new("BindableEvent");
        task.spawn(function() --[[ Line: 49 ]]
            -- upvalues: u5 (ref), l__ReplicatedStorage__2 (copy), u6 (ref)
            while task.wait() do
                u5 = l__ReplicatedStorage__2:FindFirstChild("RemoteEvents");
                if u5 ~= nil then
                    u6:Fire();
                    return;
                end;
            end;
        end);
        u4 = u6;
    end;
end;
local u7 = {};
u7.__index = u7;
function u7.New(p8) --[[ Line: 70 ]]
    -- upvalues: u7 (copy)
    return setmetatable({
        is_disconnected = false,
        real_connection = nil,
        fn = p8
    }, u7);
end;
function u7.Disconnect(p9) --[[ Line: 78 ]]
    p9.is_disconnected = true;
    if p9.real_connection ~= nil then
        p9.real_connection:Disconnect();
    end;
end;
local u10 = {};
u10.__index = u10;
function u10.New(u11, p12) --[[ Line: 88 ]]
    -- upvalues: u2 (copy), u3 (copy), u5 (ref), u7 (copy), u10 (copy), u4 (ref)
    if type(u11) ~= "string" then
        error((`[{script.Name}]: name must be a string`));
    end;
    if u2 == true then
        if u3[u11] ~= nil then
            error((`[{script.Name}]: RemoteEvent {u11} was already defined`));
        end;
        u3[u11] = true;
        local v13 = Instance.new(p12 == true and "UnreliableRemoteEvent" or "RemoteEvent");
        v13.Name = u11;
        v13.Parent = u5;
        return v13;
    end;
    local u14 = u5;
    if u14 then
        u14 = u5:FindFirstChild(u11);
    end;
    if u14 ~= nil then
        return u14;
    end;
    local u15 = {};
    local u18 = setmetatable({
        RemoteEvent = nil,
        OnClientEvent = {
            Connect = function(_, p16) --[[ Name: Connect, Line 120 ]]
                -- upvalues: u14 (ref), u7 (ref), u15 (ref)
                if u14 ~= nil then
                    return u14.OnClientEvent:Connect(p16);
                end;
                local v17 = u7.New(p16);
                table.insert(u15, v17);
                return v17;
            end
        },
        OnServerEvent = {
            Connect = function() --[[ Name: Connect, Line 133 ]]
                error((`[{script.Name}]: Can't connect to "OnServerEvent" client-side`));
            end
        }
    }, u10);
    local function u21() --[[ Line: 140 ]]
        -- upvalues: u14 (ref), u5 (ref), u11 (copy), u15 (ref), u18 (copy)
        local v19 = os.clock();
        while true do
            u14 = u5:FindFirstChild(u11);
            if u14 ~= nil then
                break;
            end;
            if v19 ~= nil and os.clock() - v19 > 20 then
                v19 = nil;
            end;
            task.wait();
        end;
        for _, v20 in ipairs(u15) do
            if v20.is_disconnected == false then
                v20.real_connection = u14.OnClientEvent:Connect(v20.fn);
            end;
        end;
        u18.RemoteEvent = u14;
        u15 = nil;
    end;
    if u5 == nil then
        local u22 = nil;
        u22 = u4.Event:Connect(function() --[[ Line: 171 ]]
            -- upvalues: u22 (ref), u21 (copy)
            u22:Disconnect();
            u21();
        end);
    else
        task.spawn(u21);
    end;
    return u18;
end;
function u10.FireServer(p23, ...) --[[ Line: 183 ]]
    if p23.RemoteEvent ~= nil then
        p23.RemoteEvent:FireServer(...);
    end;
end;
function u10.FireClient(_) --[[ Line: 189 ]]
    error((`[{script.Name}]: Can't use "FireClient" client-side`));
end;
function u10.FireAllClients(_) --[[ Line: 193 ]]
    error((`[{script.Name}]: Can't use "FireAllClients" client-side`));
end;
return u10;