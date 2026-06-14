-- Decompiled with Potassium's decompiler.

local function u2(p1) --[[ Line: 20 ]]
    warn((`{tostring(p1)}\nStack Begin\n{debug.traceback(nil, 3)}Stack End`));
end;
local function u5(p3, p4, ...) --[[ Line: 24 ]]
    -- upvalues: u2 (copy)
    xpcall(p3, u2);
    if not p4 then
        error((select(1, ...)));
    end;
    return ...;
end;
return function(p6, p7, ...) --[[ Name: Finally, Line 36 ]]
    -- upvalues: u5 (copy), u2 (copy)
    return u5(p7, xpcall(p6, u2, ...));
end;