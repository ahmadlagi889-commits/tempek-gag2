-- Decompiled with Potassium's decompiler.

local l__Task__1 = require(script.Parent.Task);
local u1 = {};
local u2 = {};
u1.__index = u1;
u1.Type = "Signal";
function u1.Connect(p3, p4) --[[ Line: 48 ]]
    -- upvalues: u2 (copy)
    local v5 = setmetatable({}, u2);
    v5.Previous = p3.Previous;
    v5.Next = p3;
    v5.Once = false;
    v5.Function = p4;
    p3.Previous.Next = v5;
    p3.Previous = v5;
    return v5;
end;
function u1.Once(p6, p7) --[[ Line: 59 ]]
    -- upvalues: u2 (copy)
    local v8 = setmetatable({}, u2);
    v8.Previous = p6.Previous;
    v8.Next = p6;
    v8.Once = true;
    v8.Function = p7;
    p6.Previous.Next = v8;
    p6.Previous = v8;
    return v8;
end;
function u1.Wait(p9) --[[ Line: 70 ]]
    -- upvalues: u2 (copy)
    local v10 = setmetatable({}, u2);
    v10.Previous = p9.Previous;
    v10.Next = p9;
    v10.Once = true;
    v10.Thread = coroutine.running();
    p9.Previous.Next = v10;
    p9.Previous = v10;
    return coroutine.yield();
end;
function u1.Fire(p11, ...) --[[ Line: 81 ]]
    -- upvalues: l__Task__1 (copy)
    local l__Next__2 = p11.Next;
    while l__Next__2.Type == "Connection" do
        if l__Next__2.Function then
            l__Task__1:Defer(l__Next__2.Function, ...);
        else
            task.defer(l__Next__2.Thread, ...);
        end;
        if l__Next__2.Once then
            l__Next__2.Previous.Next = l__Next__2.Next;
            l__Next__2.Next.Previous = l__Next__2.Previous;
        end;
        l__Next__2 = l__Next__2.Next;
    end;
end;
u2.__index = u2;
u2.Type = "Connection";
function u2.Disconnect(p12) --[[ Line: 95 ]]
    p12.Previous.Next = p12.Next;
    p12.Next.Previous = p12.Previous;
end;
return function() --[[ Name: Constructor, Line 36 ]]
    -- upvalues: u1 (copy)
    local v13 = setmetatable({}, u1);
    v13.Previous = v13;
    v13.Next = v13;
    return v13;
end;