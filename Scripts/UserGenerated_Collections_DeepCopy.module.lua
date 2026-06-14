-- Decompiled with Potassium's decompiler.

function DeepCopyWithMetatables(p1, p2)
    if type(p1) ~= "table" then
        return p1;
    end;
    local v3 = p2 or {};
    local v4 = v3[p1];
    if v4 then
        return v4;
    end;
    local v5 = {};
    v3[p1] = v5;
    for v6, v7 in next, p1 do
        v5[DeepCopyWithMetatables(v6, v3)] = DeepCopyWithMetatables(v7, v3);
    end;
    local v8 = getmetatable(p1);
    if v8 then
        setmetatable(v5, v8);
    end;
    return v5;
end;
return DeepCopyWithMetatables;