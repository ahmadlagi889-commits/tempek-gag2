-- Decompiled with Potassium's decompiler.

local function u2(p1) --[[ Line: 20 ]]
    warn((`{tostring(p1)}\nStack Begin\n{debug.traceback(nil, 3)}Stack End`));
end;
return function(p3, ...) --[[ Name: WCall, Line 24 ]]
    -- upvalues: u2 (copy)
    return xpcall(p3, u2, ...);
end;