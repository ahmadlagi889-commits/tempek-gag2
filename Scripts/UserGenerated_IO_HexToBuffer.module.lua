-- Decompiled with Potassium's decompiler.

local u1 = {
    [48] = 0,
    [49] = 1,
    [50] = 2,
    [51] = 3,
    [52] = 4,
    [53] = 5,
    [54] = 6,
    [55] = 7,
    [56] = 8,
    [57] = 9,
    [65] = 10,
    [66] = 11,
    [67] = 12,
    [68] = 13,
    [69] = 14,
    [70] = 15,
    [97] = 10,
    [98] = 11,
    [99] = 12,
    [100] = 13,
    [101] = 14,
    [102] = 15
};
return function(p2) --[[ Name: HexToBuffer, Line 45 ]]
    -- upvalues: u1 (copy)
    local v3 = #p2;
    assert(v3 % 2 == 0, "hex length must be even");
    local v4 = buffer.create(v3 // 2);
    local v5 = 0;
    for v6 = 1, v3, 2 do
        local v7, v8 = string.byte(p2, v6, v6 + 1);
        local v9 = u1[v7];
        if not v9 then
            error((`invalid hex at {v6}`));
        end;
        local v10 = u1[v8];
        if not v10 then
            error((`invalid hex at {v6 + 1}`));
        end;
        buffer.writeu8(v4, v5, v9 * 16 + v10);
        v5 = v5 + 1;
    end;
    return v4;
end;