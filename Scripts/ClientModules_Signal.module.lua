-- Decompiled with Potassium's decompiler.

local u1 = nil;
local function u4(p2, ...) --[[ Line: 44 ]]
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;
local function u5(...) --[[ Line: 55 ]]
    -- upvalues: u4 (copy)
    u4(...);
    while true do
        u4(coroutine.yield());
    end;
end;
local u6 = {};
u6.__index = u6;
function u6.Disconnect(p7) --[[ Line: 79 ]]
    if p7.Connected then
        p7.Connected = false;
        if p7._signal._handlerListHead == p7 then
            p7._signal._handlerListHead = p7._next;
        else
            local l___handlerListHead__1 = p7._signal._handlerListHead;
            while l___handlerListHead__1 and l___handlerListHead__1._next ~= p7 do
                l___handlerListHead__1 = l___handlerListHead__1._next;
            end;
            if l___handlerListHead__1 then
                l___handlerListHead__1._next = p7._next;
            end;
        end;
    end;
end;
u6.Destroy = u6.Disconnect;
setmetatable(u6, {
    __index = function(_, p8) --[[ Name: __index, Line 106 ]]
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p8))), 2);
    end,
    __newindex = function(_, p9, _) --[[ Name: __newindex, Line 109 ]]
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p9))), 2);
    end
});
local u10 = {};
u10.__index = u10;
function u10.new() --[[ Line: 129 ]]
    -- upvalues: u10 (copy)
    return setmetatable({
        _handlerListHead = false,
        _proxyHandler = nil,
        _yieldedThreads = nil
    }, u10);
end;
function u10.Wrap(p11) --[[ Line: 151 ]]
    -- upvalues: u10 (copy)
    local v12 = typeof(p11) == "RBXScriptSignal";
    local v13 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p11);
    assert(v12, v13);
    local u14 = u10.new();
    u14._proxyHandler = p11:Connect(function(...) --[[ Line: 158 ]]
        -- upvalues: u14 (copy)
        u14:Fire(...);
    end);
    return u14;
end;
function u10.Is(p15) --[[ Line: 171 ]]
    -- upvalues: u10 (copy)
    local v16;
    if type(p15) == "table" then
        v16 = getmetatable(p15) == u10;
    else
        v16 = false;
    end;
    return v16;
end;
function u10.Connect(p17, p18) --[[ Line: 187 ]]
    -- upvalues: u6 (copy)
    local v19 = setmetatable({
        Connected = true,
        _next = false,
        _signal = p17,
        _fn = p18
    }, u6);
    if not p17._handlerListHead then
        p17._handlerListHead = v19;
        return v19;
    end;
    v19._next = p17._handlerListHead;
    p17._handlerListHead = v19;
    return v19;
end;
function u10.ConnectOnce(p20, p21) --[[ Line: 210 ]]
    return p20:Once(p21);
end;
function u10.Once(p22, u23) --[[ Line: 228 ]]
    local u24 = nil;
    local u25 = false;
    u24 = p22:Connect(function(...) --[[ Line: 232 ]]
        -- upvalues: u25 (ref), u24 (ref), u23 (copy)
        if u25 then
        else
            u25 = true;
            u24:Disconnect();
            u23(...);
        end;
    end);
    return u24;
end;
function u10.GetConnections(p26) --[[ Line: 245 ]]
    local l___handlerListHead__2 = p26._handlerListHead;
    local v27 = {};
    while l___handlerListHead__2 do
        table.insert(v27, l___handlerListHead__2);
        l___handlerListHead__2 = l___handlerListHead__2._next;
    end;
    return v27;
end;
function u10.DisconnectAll(p28) --[[ Line: 265 ]]
    local l___handlerListHead__3 = p28._handlerListHead;
    while l___handlerListHead__3 do
        l___handlerListHead__3.Connected = false;
        l___handlerListHead__3 = l___handlerListHead__3._next;
    end;
    p28._handlerListHead = false;
    local v29 = rawget(p28, "_yieldedThreads");
    if v29 then
        for v30 in v29 do
            if coroutine.status(v30) == "suspended" then
                task.cancel(v30);
            end;
        end;
        table.clear(p28._yieldedThreads);
    end;
end;
function u10.Fire(p31, ...) --[[ Line: 299 ]]
    -- upvalues: u1 (ref), u5 (copy)
    local l___handlerListHead__4 = p31._handlerListHead;
    while l___handlerListHead__4 do
        if l___handlerListHead__4.Connected then
            if not u1 then
                u1 = coroutine.create(u5);
            end;
            task.spawn(u1, l___handlerListHead__4._fn, ...);
        end;
        l___handlerListHead__4 = l___handlerListHead__4._next;
    end;
end;
function u10.FireDeferred(p32, ...) --[[ Line: 320 ]]
    local l___handlerListHead__5 = p32._handlerListHead;
    while l___handlerListHead__5 do
        task.defer(function(...) --[[ Line: 324 ]]
            -- upvalues: l___handlerListHead__5 (copy)
            if l___handlerListHead__5.Connected then
                l___handlerListHead__5._fn(...);
            end;
        end, ...);
        l___handlerListHead__5 = l___handlerListHead__5._next;
    end;
end;
function u10.Wait(p33) --[[ Line: 347 ]]
    local u34 = rawget(p33, "_yieldedThreads");
    if not u34 then
        u34 = {};
        rawset(p33, "_yieldedThreads", u34);
    end;
    local u35 = coroutine.running();
    u34[u35] = true;
    p33:Once(function(...) --[[ Line: 357 ]]
        -- upvalues: u34 (ref), u35 (copy)
        u34[u35] = nil;
        task.spawn(u35, ...);
    end);
    return coroutine.yield();
end;
function u10.Destroy(p36) --[[ Line: 377 ]]
    p36:DisconnectAll();
    local v37 = rawget(p36, "_proxyHandler");
    if v37 then
        v37:Disconnect();
    end;
end;
setmetatable(u10, {
    __index = function(_, p38) --[[ Name: __index, Line 388 ]]
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p38))), 2);
    end,
    __newindex = function(_, p39, _) --[[ Name: __newindex, Line 391 ]]
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p39))), 2);
    end
});
return table.freeze({
    new = u10.new,
    Wrap = u10.Wrap,
    Is = u10.Is
});