-- Decompiled with Potassium's decompiler.

local function u4(p1) --[[ Line: 23 ]]
    local v2 = table.clone(p1);
    for v3 = 1, #v2 do
        v2[v3] = table.clone(v2[v3]);
    end;
    return v2;
end;
local function u8(p5) --[[ Line: 33 ]]
    local v6 = table.create(p5);
    for v7 = 1, p5 do
        v6[v7] = table.create(p5, 0);
    end;
    return v6;
end;
local function u12(p9) --[[ Line: 43 ]]
    -- upvalues: u8 (copy)
    local v10 = u8(p9);
    for v11 = 1, p9 do
        v10[v11][v11] = 1;
    end;
    return v10;
end;
local function u25(p13, p14) --[[ Line: 53 ]]
    local v15 = #p13;
    local v16 = #p13[1];
    local v17 = #p14[1];
    local v18 = {};
    for v19 = 1, v15 do
        local v20 = table.create(v17, 0);
        for v21 = 1, v17 do
            local v22 = 0;
            for v23 = 1, v16 do
                local v24 = bit32.band(p13[v19][v23], p14[v23][v21]);
                v22 = bit32.bxor(v22, v24);
            end;
            v20[v21] = v22;
        end;
        v18[v19] = v20;
    end;
    return v18;
end;
local function u35(p26, p27) --[[ Line: 73 ]]
    local v28 = #p26;
    local v29 = #p26[1];
    local v30 = table.create(v28, 0);
    for v31 = 1, v28 do
        local v32 = 0;
        for v33 = 1, v29 do
            local v34 = bit32.band(p26[v31][v33], p27[v33]);
            v32 = bit32.bxor(v32, v34);
        end;
        v30[v31] = v32;
    end;
    return v30;
end;
local function u43(p36, p37) --[[ Line: 89 ]]
    -- upvalues: u8 (copy)
    local v38 = #p36;
    local v39 = #p36[1];
    local v40 = u8(v38);
    for v41 = 1, v38 do
        for v42 = 1, v39 do
            v40[v41][v42] = bit32.bxor(p36[v41][v42], p37[v41][v42]);
        end;
    end;
    return v40;
end;
local function u58(p44) --[[ Line: 103 ]]
    -- upvalues: u4 (copy), u8 (copy)
    local v45 = #p44;
    local v46 = u4(p44);
    local v47 = u8(v45);
    for v48 = 1, v45 do
        v47[v48][v48] = 1;
    end;
    for v49 = 1, v45 do
        local v50 = nil;
        for v51 = v49, v45 do
            if v46[v51][v49] == 1 then
                v50 = v51;
                break;
            end;
        end;
        assert(v50, "not invertible");
        local v52 = v46[v50];
        local v53 = v46[v49];
        v46[v49] = v52;
        v46[v50] = v53;
        local v54 = v47[v50];
        local v55 = v47[v49];
        v47[v49] = v54;
        v47[v50] = v55;
        for v56 = 1, v45 do
            if v56 ~= v49 and v46[v56][v49] == 1 then
                for v57 = 1, v45 do
                    v46[v56][v57] = bit32.bxor(v46[v56][v57], v46[v49][v57]);
                    v47[v56][v57] = bit32.bxor(v47[v56][v57], v47[v49][v57]);
                end;
            end;
        end;
    end;
    return v47;
end;
local function u66(p59, p60) --[[ Line: 132 ]]
    -- upvalues: u8 (copy), u58 (copy), u4 (copy), u25 (copy)
    local v61 = #p59;
    local v62 = u8(v61);
    for v63 = 1, v61 do
        v62[v63][v63] = 1;
    end;
    local v64;
    if p60 < 0 then
        v64 = u58(p59);
    else
        v64 = u4(p59);
    end;
    local v65 = math.abs(p60);
    while v65 > 0 do
        if math.fmod(v65, 2) >= 0.5 then
            v62 = u25(v62, v64);
        end;
        v64 = u25(v64, v64);
        v65 = math.floor(v65 / 2);
    end;
    return v62;
end;
local function u71(p67, p68) --[[ Line: 150 ]]
    -- upvalues: u8 (copy)
    local v69 = u8(p68);
    for v70 = 1, p68 - p67 do
        v69[v70][v70 + p67] = 1;
    end;
    return v69;
end;
local function u76(p72, p73) --[[ Line: 161 ]]
    -- upvalues: u8 (copy)
    local v74 = u8(p73);
    for v75 = p72 + 1, p73 do
        v74[v75][v75 - p72] = 1;
    end;
    return v74;
end;
local function u84(p77, p78, p79, p80) --[[ Line: 172 ]]
    -- upvalues: u8 (copy)
    local v81 = u8(p78);
    for v82 = 1, #p77 do
        for v83 = 1, #p77[1] do
            v81[p79 + v82][p80 + v83] = p77[v82][v83];
        end;
    end;
    return v81;
end;
local function u99(p85, p86, p87, p88) --[[ Line: 187 ]]
    local v89 = table.create(128, 0);
    for v90 = 0, 31 do
        local v91 = 32 - v90;
        local v92 = bit32.rshift(p85, v90);
        v89[v91] = bit32.band(v92, 1);
        local v93 = 64 - v90;
        local v94 = bit32.rshift(p86, v90);
        v89[v93] = bit32.band(v94, 1);
        local v95 = 96 - v90;
        local v96 = bit32.rshift(p87, v90);
        v89[v95] = bit32.band(v96, 1);
        local v97 = 128 - v90;
        local v98 = bit32.rshift(p88, v90);
        v89[v97] = bit32.band(v98, 1);
    end;
    return v89;
end;
local function u110(p100) --[[ Line: 203 ]]
    local v101 = 0;
    local v102 = 0;
    local v103 = 0;
    local v104 = 0;
    for v105 = 0, 31 do
        local v106 = bit32.lshift(p100[32 - v105], v105);
        v101 = bit32.bor(v101, v106);
        local v107 = bit32.lshift(p100[64 - v105], v105);
        v102 = bit32.bor(v102, v107);
        local v108 = bit32.lshift(p100[96 - v105], v105);
        v103 = bit32.bor(v103, v108);
        local v109 = bit32.lshift(p100[128 - v105], v105);
        v104 = bit32.bor(v104, v109);
    end;
    return v101, v102, v103, v104;
end;
local u117 = (function() --[[ Name: BuildMatTransform, Line 216 ]]
    -- upvalues: u12 (copy), u71 (copy), u25 (copy), u43 (copy), u84 (copy), u76 (copy)
    local v111 = u12(32);
    local v112 = u12(128);
    local v113 = u25(u43(v112, (u84(u71(11, 32), 128, 0, 0))), v112);
    local v114 = u25(u43(v112, (u84(u76(8, 32), 128, 0, 0))), v113);
    local v115 = u25(u43(v112, (u84(v111, 128, 0, 96))), v114);
    local v116 = u25(u43(v112, (u84(u76(19, 32), 128, 0, 96))), v115);
    return u25(u43(u71(32, 128), (u76(96, 128))), v116);
end)();
return table.freeze({
    ToColumnVector128 = u99,
    FromColumnVector128 = u110,
    MatTransform = function() --[[ Name: MatTransform, Line 249 ]]
        -- upvalues: u4 (copy), u117 (copy)
        return u4(u117);
    end,
    Transform = function(p118, p119, p120, p121, p122) --[[ Name: Transform, Line 253 ]]
        -- upvalues: u99 (copy), u35 (copy), u66 (copy), u4 (copy), u117 (copy), u110 (copy)
        local v123 = u99(p118, p119, p120, p121);
        return u110((u35(u66(u4(u117), p122), v123)));
    end
});