-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
local l__Heartbeat__2 = game:GetService("RunService").Heartbeat;
local u1 = {};
u1.__index = u1;
u1.ClassName = "Signal";
u1.totalConnections = 0;
function u1.new(p2) --[[ Line: 12 ]]
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    if p2 then
        v3.connectionsChanged = u1.new();
    end;
    v3.connections = {};
    v3.totalConnections = 0;
    v3.waiting = {};
    v3.totalWaiting = 0;
    return v3;
end;
function u1.Fire(p4, ...) --[[ Line: 30 ]]
    for _, v5 in pairs(p4.connections) do
        task.spawn(v5.Handler, ...);
    end;
    if p4.totalWaiting > 0 then
        local v6 = table.pack(...);
        for v7, _ in pairs(p4.waiting) do
            p4.waiting[v7] = v6;
        end;
    end;
end;
u1.fire = u1.Fire;
function u1.Connect(u8, p9) --[[ Line: 44 ]]
    -- upvalues: l__HttpService__1 (copy)
    if type(p9) ~= "function" then
        error(("connect(%s)"):format((typeof(p9))), 2);
    end;
    local u10 = l__HttpService__1:GenerateGUID(false);
    local u11 = {
        Connected = true,
        ConnectionId = u10,
        Handler = p9
    };
    u8.connections[u10] = u11;
    function u11.Disconnect(_) --[[ Line: 57 ]]
        -- upvalues: u8 (copy), u10 (copy), u11 (copy)
        u8.connections[u10] = nil;
        u11.Connected = false;
        local v12 = u8;
        v12.totalConnections = v12.totalConnections - 1;
        if u8.connectionsChanged then
            u8.connectionsChanged:Fire(-1);
        end;
    end;
    u11.Destroy = u11.Disconnect;
    u11.destroy = u11.Disconnect;
    u11.disconnect = u11.Disconnect;
    u8.totalConnections = u8.totalConnections + 1;
    if u8.connectionsChanged then
        u8.connectionsChanged:Fire(1);
    end;
    return u11;
end;
u1.connect = u1.Connect;
function u1.Wait(p13) --[[ Line: 77 ]]
    -- upvalues: l__HttpService__1 (copy), l__Heartbeat__2 (copy)
    local v14 = l__HttpService__1:GenerateGUID(false);
    p13.waiting[v14] = true;
    p13.totalWaiting = p13.totalWaiting + 1;
    repeat
        l__Heartbeat__2:Wait();
    until p13.waiting[v14] ~= true;
    p13.totalWaiting = p13.totalWaiting - 1;
    local v15 = p13.waiting[v14];
    p13.waiting[v14] = nil;
    return unpack(v15);
end;
u1.wait = u1.Wait;
function u1.Destroy(p16) --[[ Line: 89 ]]
    if p16.bindableEvent then
        p16.bindableEvent:Destroy();
        p16.bindableEvent = nil;
    end;
    if p16.connectionsChanged then
        p16.connectionsChanged:Fire(-p16.totalConnections);
        p16.connectionsChanged:Destroy();
        p16.connectionsChanged = nil;
    end;
    p16.totalConnections = 0;
    for v17, _ in pairs(p16.connections) do
        p16.connections[v17] = nil;
    end;
end;
u1.destroy = u1.Destroy;
u1.Disconnect = u1.Destroy;
u1.disconnect = u1.Destroy;
return u1;