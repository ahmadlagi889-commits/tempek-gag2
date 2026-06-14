-- Decompiled with Potassium's decompiler.

local function u33(p1, p2, p3) --[[ Line: 20 ]]
    local v4 = bit32.bor(p1, 0);
    local v5 = bit32.bor(p2, 0);
    local v6 = bit32.bor(p3, 0);
    local v7 = v4 - v5 - v6;
    local v8 = bit32.rshift(v6, 13);
    local v9 = bit32.bxor(v7, v8);
    local v10 = v5 - v6 - v9;
    local v11 = bit32.lshift(v9, 8);
    local v12 = bit32.bxor(v10, v11);
    local v13 = v6 - v9 - v12;
    local v14 = bit32.rshift(v12, 13);
    local v15 = bit32.bxor(v13, v14);
    local v16 = v9 - v12 - v15;
    local v17 = bit32.rshift(v15, 12);
    local v18 = bit32.bxor(v16, v17);
    local v19 = v12 - v15 - v18;
    local v20 = bit32.lshift(v18, 16);
    local v21 = bit32.bxor(v19, v20);
    local v22 = v15 - v18 - v21;
    local v23 = bit32.rshift(v21, 5);
    local v24 = bit32.bxor(v22, v23);
    local v25 = v18 - v21 - v24;
    local v26 = bit32.rshift(v24, 3);
    local v27 = bit32.bxor(v25, v26);
    local v28 = v21 - v24 - v27;
    local v29 = bit32.lshift(v27, 10);
    local v30 = bit32.bxor(v28, v29);
    local v31 = v24 - v27 - v30;
    local v32 = bit32.rshift(v30, 15);
    return bit32.bxor(v31, v32);
end;
return table.freeze({
    Mix = u33,
    DoubleFromInt64 = function(p34, p35) --[[ Name: DoubleFromInt64, Line 44 ]]
        -- upvalues: u33 (copy)
        local v36, v37;
        if p34 < 0 then
            local v38 = -1 - p34;
            v36 = bit32.bnot(v38 // 4294967296);
            v37 = bit32.bnot(v38);
        else
            v36 = bit32.bor(p34 // 4294967296, 0);
            v37 = bit32.bor(p34, 0);
        end;
        return u33(v37, v36, p35) / 4294967296;
    end,
    DoubleFromUUID = function(p39, p40) --[[ Name: DoubleFromUUID, Line 59 ]]
        -- upvalues: u33 (copy)
        local v41 = string.sub(p39, 1, 8);
        local v42 = tonumber(v41, 16);
        local v43 = string.sub(p39, 10, 13) .. string.sub(p39, 15, 18);
        local v44 = tonumber(v43, 16);
        local v45 = string.sub(p39, 20, 23) .. string.sub(p39, 25, 28);
        local v46 = tonumber(v45, 16);
        local v47 = string.sub(p39, 29, 36);
        local v48 = tonumber(v47, 16);
        return u33(u33(v42, v44, 2197175160), u33(v46, v48, 2821953579), p40) / 4294967296;
    end,
    IntegerFromUUID = function(p49, p50, p51, p52) --[[ Name: IntegerFromUUID, Line 68 ]]
        -- upvalues: u33 (copy)
        local v53 = p52 - p51 + 1;
        local v54 = string.sub(p49, 1, 8);
        local v55 = tonumber(v54, 16);
        local v56 = string.sub(p49, 10, 13) .. string.sub(p49, 15, 18);
        local v57 = tonumber(v56, 16);
        local v58 = string.sub(p49, 20, 23) .. string.sub(p49, 25, 28);
        local v59 = tonumber(v58, 16);
        local v60 = string.sub(p49, 29, 36);
        local v61 = tonumber(v60, 16);
        local v62 = p51 + v53 * (u33(u33(v55, v57, 2197175160), u33(v59, v61, 2821953579), p50) / 4294967296);
        return math.floor(v62);
    end
});