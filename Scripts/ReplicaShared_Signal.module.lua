-- Decompiled with Potassium's decompiler.

local u1 = nil;
local function u4(p2, ...) --[[ Line: 42 ]]
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;
local function u5(...) --[[ Line: 50 ]]
    -- upvalues: u4 (copy)
    u4(...);
    while true do
        u4(coroutine.yield());
    end;
end;
local u6 = {};
u6.__index = u6;
local u7 = {};
u7.__index = u7;
function u6.Disconnect(p8) --[[ Line: 77 ]]
    if p8.IsConnected == false then
    else
        local l__signal__1 = p8.signal;
        p8.IsConnected = false;
        if l__signal__1.head == p8 then
            l__signal__1.head = p8.next;
        else
            local l__head__2 = l__signal__1.head;
            while l__head__2 ~= nil and l__head__2.next ~= p8 do
                l__head__2 = l__head__2.next;
            end;
            if l__head__2 ~= nil then
                l__head__2.next = p8.next;
            end;
        end;
    end;
end;
function u7.New() --[[ Line: 100 ]]
    -- upvalues: u7 (copy)
    local v9 = {
        head = nil
    };
    setmetatable(v9, u7);
    return v9;
end;
function u7.Connect(p10, p11) --[[ Line: 111 ]]
    -- upvalues: u6 (copy)
    if type(p11) ~= "function" then
        error((`[{script.Name}]: "listener" must be a function; Received {typeof(p11)}`));
    end;
    local v12 = {
        IsConnected = true,
        listener = p11,
        signal = p10,
        next = p10.head
    };
    setmetatable(v12, u6);
    p10.head = v12;
    return v12;
end;
function u7.Fire(p13, ...) --[[ Line: 131 ]]
    -- upvalues: u1 (ref), u5 (copy)
    local l__head__3 = p13.head;
    while l__head__3 ~= nil do
        if l__head__3.IsConnected == true then
            if not u1 then
                u1 = coroutine.create(u5);
            end;
            task.spawn(u1, l__head__3.listener, ...);
        end;
        l__head__3 = l__head__3.next;
    end;
end;
function u7.Wait(p14) --[[ Line: 144 ]]
    local u15 = coroutine.running();
    local u16 = nil;
    u16 = p14:Connect(function(...) --[[ Line: 147 ]]
        -- upvalues: u16 (ref), u15 (copy)
        u16:Disconnect();
        task.spawn(u15, ...);
    end);
    return coroutine.yield();
end;
function u7.FireUntil(p17, u18, ...) --[[ Line: 154 ]]
    if type(u18) ~= "function" then
        error((`[{script.Name}]: "continue_callback" must be a function; Received {typeof(u18)}`));
    end;
    local u19 = table.pack(...);
    local l__head__4 = p17.head;
    local u20 = {};
    while l__head__4 ~= nil do
        table.insert(u20, l__head__4);
        l__head__4 = l__head__4.next;
    end;
    task.spawn(function() --[[ Line: 169 ]]
        -- upvalues: u20 (copy), u19 (copy), u18 (copy)
        for _, v21 in ipairs(u20) do
            if v21.IsConnected == true then
                v21.listener(table.unpack(u19));
                if u18() ~= true then
                    return;
                end;
            end;
        end;
    end);
end;
return table.freeze({
    New = u7.New
});