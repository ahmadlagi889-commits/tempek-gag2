-- Decompiled with Potassium's decompiler.

local function u10(p1, p2, p3) --[[ Line: 31 ]]
    -- upvalues: u10 (copy)
    if rawequal(p1, p2) then
        return true;
    end;
    if type(p1) ~= "table" or type(p2) ~= "table" then
        return p1 ~= p1 and p2 ~= p2;
    end;
    if rawlen(p1) ~= rawlen(p2) then
        return false;
    end;
    local v4 = getmetatable(p1);
    if v4 ~= getmetatable(p2) then
        return false;
    end;
    if v4 ~= nil and v4.__eq then
        return p1 == p2;
    end;
    local v5 = p3 or {};
    v5[p1] = v5[p1] or {};
    v5[p2] = v5[p2] or {};
    if v5[p1][p2] then
        return true;
    end;
    v5[p1][p2] = true;
    v5[p2][p1] = true;
    for v6, v7 in next, p1 do
        local v8 = rawget(p2, v6);
        if v8 == nil or not u10(v7, v8, v5) then
            return false;
        end;
    end;
    for v9, _ in next, p2 do
        if rawget(p1, v9) == nil then
            return false;
        end;
    end;
    return true;
end;
return u10;