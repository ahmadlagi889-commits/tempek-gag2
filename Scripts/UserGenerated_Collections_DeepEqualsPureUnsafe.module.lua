-- Decompiled with Potassium's decompiler.

function DeepEqualsPureUnsafe(p1, p2)
    if rawequal(p1, p2) then
        return true;
    end;
    if type(p1) ~= "table" or type(p2) ~= "table" then
        return p1 ~= p1 and p2 ~= p2;
    end;
    if rawlen(p1) ~= rawlen(p2) then
        return false;
    end;
    if getmetatable(p1) ~= getmetatable(p2) then
        return false;
    end;
    for v3, v4 in next, p1 do
        local v5 = rawget(p2, v3);
        if v5 == nil or not DeepEqualsPureUnsafe(v4, v5) then
            return false;
        end;
    end;
    for v6, _ in next, p2 do
        if rawget(p1, v6) == nil then
            return false;
        end;
    end;
    return true;
end;
return DeepEqualsPureUnsafe;