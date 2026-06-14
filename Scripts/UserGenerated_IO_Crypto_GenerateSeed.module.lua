-- Decompiled with Potassium's decompiler.

local l__HttpService__1 = game:GetService("HttpService");
return function(p1) --[[ Name: GenerateSeed, Line 30 ]]
    -- upvalues: l__HttpService__1 (copy)
    local v2 = table.create(p1, 0);
    local v3 = p1 // 3;
    for v4 = 0, v3 - 1 do
        local v5 = v4 * 3 + 1;
        local v6 = v4 * 3 + 2;
        local v7 = v4 * 3 + 3;
        local v8 = l__HttpService__1:GenerateGUID(false);
        local v9 = string.sub(v8, 1, 8);
        local v10 = tonumber(v9, 16);
        local v11 = string.sub(v8, 10, 13) .. string.sub(v8, 25, 28);
        local v12 = tonumber(v11, 16);
        local v13 = string.sub(v8, 29, 36);
        local v14 = tonumber(v13, 16);
        v2[v5] = v10;
        v2[v6] = v12;
        v2[v7] = v14;
    end;
    local v15 = p1 - v3 * 3;
    if v15 ~= 1 then
        if v15 == 2 then
            local v16 = p1 - 1;
            local v17 = l__HttpService__1:GenerateGUID(false);
            local v18 = string.sub(v17, 1, 8);
            local v19 = tonumber(v18, 16);
            local v20 = string.sub(v17, 10, 13) .. string.sub(v17, 25, 28);
            local v21 = tonumber(v20, 16);
            local v22 = string.sub(v17, 29, 36);
            tonumber(v22, 16);
            v2[v16] = v19;
            v2[p1] = v21;
        end;
        return v2;
    end;
    local v23 = l__HttpService__1:GenerateGUID(false);
    local v24 = string.sub(v23, 1, 8);
    local v25 = tonumber(v24, 16);
    local v26 = string.sub(v23, 10, 13) .. string.sub(v23, 25, 28);
    tonumber(v26, 16);
    local v27 = string.sub(v23, 29, 36);
    tonumber(v27, 16);
    v2[p1] = v25;
    return v2;
end;