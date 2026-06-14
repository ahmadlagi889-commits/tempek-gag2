-- Decompiled with Potassium's decompiler.

local u1 = nil;
local v2 = {};
local u3 = {};
v2.Type = "Task";
function v2.Spawn(_, p4, ...) --[[ Line: 22 ]]
    -- upvalues: u3 (copy), u1 (ref)
    return task.spawn(table.remove(u3) or task.spawn(u1), p4, ...);
end;
function v2.Defer(_, p5, ...) --[[ Line: 26 ]]
    -- upvalues: u3 (copy), u1 (ref)
    return task.defer(table.remove(u3) or task.spawn(u1), p5, ...);
end;
function v2.Delay(_, p6, p7, ...) --[[ Line: 30 ]]
    -- upvalues: u3 (copy), u1 (ref)
    return task.delay(p6, table.remove(u3) or task.spawn(u1), p7, ...);
end;
local function u9(p8, ...) --[[ Line: 36 ]]
    -- upvalues: u3 (copy)
    p8(...);
    table.insert(u3, coroutine.running());
end;
u1 = function() --[[ Name: Thread, Line 41 ]]
    -- upvalues: u9 (ref)
    while true do
        u9(coroutine.yield());
    end;
end;
return v2;