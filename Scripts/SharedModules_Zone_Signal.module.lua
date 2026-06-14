-- Decompiled with Potassium's decompiler.

local u1 = nil;
local function u4(p2, ...) --[[ Line: 34 ]]
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;
local function u5(...) --[[ Line: 45 ]]
    -- upvalues: u4 (copy)
    u4(...);
    while true do
        u4(coroutine.yield());
    end;
end;
local u6 = {};
u6.__index = u6;
function u6.new(p7, p8) --[[ Line: 56 ]]
    -- upvalues: u6 (copy)
    return setmetatable({
        _connected = true,
        _next = false,
        _signal = p7,
        _fn = p8
    }, u6);
end;
function u6.Disconnect(p9) --[[ Line: 65 ]]
    assert(p9._connected, "Can\'t disconnect a connection twice.", 2);
    p9._connected = false;
    local l___signal__1 = p9._signal;
    if l___signal__1._handlerListHead == p9 then
        l___signal__1._handlerListHead = p9._next;
    else
        local l___handlerListHead__2 = l___signal__1._handlerListHead;
        while l___handlerListHead__2 and l___handlerListHead__2._next ~= p9 do
            l___handlerListHead__2 = l___handlerListHead__2._next;
        end;
        if l___handlerListHead__2 then
            l___handlerListHead__2._next = p9._next;
        end;
    end;
    if l___signal__1.connectionsChanged then
        l___signal__1.totalConnections = l___signal__1.totalConnections - 1;
        l___signal__1.connectionsChanged:Fire(-1);
    end;
end;
setmetatable(u6, {
    __index = function(_, p10) --[[ Name: __index, Line 94 ]]
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p10))), 2);
    end,
    __newindex = function(_, p11, _) --[[ Name: __newindex, Line 97 ]]
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p11))), 2);
    end
});
local u12 = {};
u12.__index = u12;
function u12.new(p13) --[[ Line: 106 ]]
    -- upvalues: u12 (copy)
    local v14 = setmetatable({
        _handlerListHead = false
    }, u12);
    if p13 then
        v14.totalConnections = 0;
        v14.connectionsChanged = u12.new();
    end;
    return v14;
end;
function u12.Connect(p15, p16) --[[ Line: 117 ]]
    -- upvalues: u6 (copy)
    local v17 = u6.new(p15, p16);
    if p15._handlerListHead then
        v17._next = p15._handlerListHead;
        p15._handlerListHead = v17;
    else
        p15._handlerListHead = v17;
    end;
    if p15.connectionsChanged then
        p15.totalConnections = p15.totalConnections + 1;
        p15.connectionsChanged:Fire(1);
    end;
    return v17;
end;
function u12.DisconnectAll(p18) --[[ Line: 135 ]]
    p18._handlerListHead = false;
    if p18.connectionsChanged then
        p18.connectionsChanged:Fire(-p18.totalConnections);
        p18.connectionsChanged:Destroy();
        p18.connectionsChanged = nil;
        p18.totalConnections = 0;
    end;
end;
u12.Destroy = u12.DisconnectAll;
u12.destroy = u12.DisconnectAll;
function u12.Fire(p19, ...) --[[ Line: 152 ]]
    -- upvalues: u1 (ref), u5 (copy)
    local l___handlerListHead__3 = p19._handlerListHead;
    while l___handlerListHead__3 do
        if l___handlerListHead__3._connected then
            if not u1 then
                u1 = coroutine.create(u5);
            end;
            task.spawn(u1, l___handlerListHead__3._fn, ...);
        end;
        l___handlerListHead__3 = l___handlerListHead__3._next;
    end;
end;
function u12.Wait(p20) --[[ Line: 167 ]]
    local u21 = coroutine.running();
    local u22 = nil;
    u22 = p20:Connect(function(...) --[[ Line: 170 ]]
        -- upvalues: u22 (ref), u21 (copy)
        u22:Disconnect();
        task.spawn(u21, ...);
    end);
    return coroutine.yield();
end;
return u12;