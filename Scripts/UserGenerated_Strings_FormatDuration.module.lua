-- Decompiled with Potassium's decompiler.

local u1 = {
    0,
    2,
    2,
    2
};
return function(p2) --[[ Name: FormatDuration, Line 22 ]]
    -- upvalues: u1 (copy)
    local v3 = type(p2) == "number";
    assert(v3);
    if p2 == (1 / 0) then
        return "Infinity";
    end;
    if p2 ~= p2 then
        return "NaN";
    end;
    local v4 = math.max(0, p2);
    local v5 = math.ceil(v4);
    local v6 = v5 % 60;
    local v7 = v5 // 60;
    local v8 = v7 % 60;
    local v9 = v7 // 60;
    local v10 = {
        v9 // 24,
        v9 % 24,
        v8,
        v6
    };
    local v11 = #v10;
    for v12, v13 in ipairs(v10) do
        if v13 > 0 then
            v11 = v12;
            break;
        end;
    end;
    if v11 == #v10 then
        return tostring(v6) .. "s";
    end;
    local v14 = { (tostring(v10[v11])) };
    for v15 = v11 + 1, #v10 do
        local v16 = tostring(v10[v15]);
        local v17 = u1[v15];
        while #v16 < v17 do
            v16 = "0" .. v16;
        end;
        table.insert(v14, ":" .. v16);
    end;
    return table.concat(v14);
end;