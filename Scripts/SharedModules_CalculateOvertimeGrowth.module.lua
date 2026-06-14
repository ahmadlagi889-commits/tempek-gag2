-- Decompiled with Potassium's decompiler.

local u1 = {
    { 0, 1 },
    { 3, 1.5 },
    { 12, 2 },
    { 24, 2.5 },
    { 74, 3 },
    { 200, 3.5 },
    { 500, 4 },
    { 1000, 4.5 },
    { 2000, 5 }
};
return function(p2) --[[ Line: 7 ]]
    -- upvalues: u1 (copy)
    if p2 <= 0 then
        return 1;
    end;
    local v3 = p2 / 3600;
    if v3 >= 2000 then
        return math.log(v3 / 2000) * 0.5 / 0.6931471805599453 + 5;
    end;
    for v4 = 2, #u1 do
        if v3 <= u1[v4][1] then
            local v5 = u1[v4 - 1][1];
            local v6 = u1[v4 - 1][2];
            return v6 + (u1[v4][2] - v6) * (v3 - v5) / (u1[v4][1] - v5);
        end;
    end;
    return 5;
end;