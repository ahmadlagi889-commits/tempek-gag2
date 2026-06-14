-- Decompiled with Potassium's decompiler.

local u1 = {
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    13,
    15,
    17,
    19,
    23,
    27,
    31,
    35,
    43,
    51,
    59,
    67,
    83,
    99,
    115,
    131,
    163,
    195,
    227,
    258
};
local u2 = {};
local u3 = {};
local u4 = {
    1,
    1,
    1,
    1,
    2,
    2,
    2,
    2,
    3,
    3,
    3,
    3,
    4,
    4,
    4,
    4,
    5,
    5,
    5,
    5,
    0
};
local u5 = {};
local u6 = {
    1,
    2,
    3,
    4,
    5,
    7,
    9,
    13,
    17,
    25,
    33,
    49,
    65,
    97,
    129,
    193,
    257,
    385,
    513,
    769,
    1025,
    1537,
    2049,
    3073,
    4097,
    6145,
    8193,
    12289,
    16385,
    24577
};
local function u18(p7) --[[ Line: 56 ]]
    local v8 = table.create(15, 0);
    v8[0] = 0;
    for _, v9 in p7 do
        if v9 > 0 then
            v8[v9] = (v8[v9] or 0) + 1;
        end;
    end;
    local v10 = table.create(15);
    local v11 = 1;
    for v12 = 1, 15 do
        v11 = bit32.lshift(v11 + v8[v12 - 1], 1);
        v10[v12] = v11;
    end;
    local v13 = {};
    local v14 = {};
    local v15 = {};
    for v16, v17 in p7 do
        if v17 > 0 then
            v13[v10[v17]] = v16 - 1;
            v14[v16 - 1] = bit32.extract(v10[v17], 0, v17);
            v15[v16 - 1] = v17;
            v10[v17] = v10[v17] + 1;
        end;
    end;
    return v13, v14, v15;
end;
local v19 = {
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8
};
local u20 = {
    16,
    17,
    18,
    0,
    8,
    7,
    9,
    6,
    10,
    5,
    11,
    4,
    12,
    3,
    13,
    2,
    14,
    1,
    15
};
local u21 = {
    0,
    0,
    0,
    1,
    1,
    2,
    2,
    3,
    3,
    4,
    4,
    5,
    5,
    6,
    6,
    7,
    7,
    8,
    8,
    9,
    9,
    10,
    10,
    11,
    11,
    12,
    12,
    13,
    13
};
for v22 = 3, 258 do
    local v23 = nil;
    for v24 = #u1, 1, -1 do
        if u1[v24] <= v22 then
            v23 = v24;
            break;
        end;
    end;
    u2[v22] = 256 + v23;
    u3[v22] = v22 - u1[v23];
    u5[v22] = u4[v23 - 8] or 0;
end;
local u25 = {};
for v26 = 1, 1024 do
    local v27 = nil;
    for v28 = #u6, 1, -1 do
        if u6[v28] <= v26 then
            v27 = v28;
            break;
        end;
    end;
    u25[v26] = v27;
end;
local u29, u30, u31 = u18(v19);
local u32, u33, u34 = u18(table.create(32, 5));
local function u36(p35) --[[ Line: 122 ]]
    -- upvalues: u25 (copy)
    return p35 >= 1025 and (p35 < 1537 and 21 or (p35 < 2049 and 22 or (p35 < 3073 and 23 or (p35 < 4097 and 24 or (p35 < 6145 and 25 or (p35 < 8193 and 26 or (p35 < 12289 and 27 or (p35 < 16385 and 28 or (p35 < 24577 and 29 or 30))))))))) or u25[p35];
end;
local function u45(p37, p38, p39) --[[ Line: 139 ]]
    local v40 = 1;
    local v41 = 0;
    local v42 = 0;
    for v43 = p38, p38 + p39 - 1 do
        v40 = v40 + buffer.readu8(p37, v43);
        v41 = v41 + v40;
        v42 = v42 + 1;
        if v42 == 8400000 then
            v40 = v40 % 65521;
            v41 = v41 % 65521;
            v42 = 0;
        end;
    end;
    local v44 = bit32.lshift(v41 % 65521, 16);
    return bit32.bor(v44, v40 % 65521);
end;
return {
    inflate = function(p46, p47) --[[ Name: inflate, Line 156 ]]
        -- upvalues: u29 (copy), u32 (copy), u20 (copy), u18 (copy), u1 (copy), u4 (copy), u6 (copy), u21 (copy), u45 (copy)
        local v48, v49, v50, v51, v52, v53, v54, v55, v56, v57, v58, v59, v60, v61, v62, v63, v64;
        local v65 = 0;
        while true do
            local v66, v67, v68;
            if v65 == 0 then
                v65 = -1;
                -- block 115
                local v69 = buffer.readu8(p46, 0);
                local v70 = buffer.readu8(p46, 1);
                local v71 = bit32.extract(v69, 0, 4) == 8;
                assert(v71, "invalid zlib comp method");
                local v72 = bit32.extract(v69, 4, 4) <= 7;
                assert(v72, "invalid zlib window size");
                local v73 = bit32.extract(v70, 5, 1) == 0;
                assert(v73, "preset dictionary is not allowed");
                local v74 = bit32.lshift(v69, 8);
                local v75 = bit32.bor(v74, v70) % 31 == 0;
                assert(v75, "zlib header sum mismatch");
                v49 = 2;
                v54 = 0;
                v50 = 0;
                local v76;
                while true do
                    local v77 = buffer.readu8(p46, v49);
                    v52 = bit32.extract(v77, v54);
                    v54 = v54 + 1;
                    if v54 == 8 then
                        v54 = 0;
                        v49 = v49 + 1;
                    end;
                    v76 = buffer.readbits(p46, v49 * 8 + v54, 2);
                    v54 = v54 + 2;
                    v49 = v49 + bit32.rshift(v54, 3);
                    v54 = bit32.band(v54, 7);
                    assert(v76 ~= 3, "reserved btype");
                    if v76 ~= 0 then
                        break;
                    end;
                    if v54 > 0 then
                        v49 = v49 + 1;
                        v54 = 0;
                    end;
                    local v78 = buffer.readu16(p46, v49);
                    local v79 = buffer.readu16(p46, v49 + 2);
                    local v80 = bit32.bxor(v78, v79) == 65535;
                    assert(v80, "len ~= nlen");
                    v49 = v49 + 4;
                    buffer.copy(p47, v50, p46, v49, v78);
                    v50 = v50 + v78;
                    v49 = v49 + v78;
                    ::l0::;
                    if v52 == 1 then
                        if v54 > 0 then
                            v54 = 0;
                            v49 = v49 + 1;
                        end;
                        v55 = u45(p47, 0, buffer.len(p47));
                        v56 = buffer.readu32(p46, v49);
                        v51 = v55 == bit32.byteswap(v56);
                        assert(v51, "adler-32 checksum mismatch");
                        return v50;
                    end;
                end;
                v48 = u29;
                v62 = u32;
                if v76 ~= 2 then
                    ::l2::;
                    v66 = 2;
                    v67 = buffer.readu8(p46, v49);
                    v68 = bit32.extract(v67, v54);
                    v54 = v54 + 1;
                    if v54 == 8 then
                        v54 = 0;
                        v49 = v49 + 1;
                    end;
                    v63 = v66 + v68;
                    v59 = v48;
                    v65 = 3;
                    continue;
                end;
                local v81 = buffer.readbits(p46, v49 * 8 + v54, 5);
                v54 = v54 + 5;
                v49 = v49 + bit32.rshift(v54, 3);
                v54 = bit32.band(v54, 7);
                v53 = v81 + 257;
                local v82 = buffer.readbits(p46, v49 * 8 + v54, 5);
                v54 = v54 + 5;
                v49 = v49 + bit32.rshift(v54, 3);
                v54 = bit32.band(v54, 7);
                v60 = v82 + 1;
                local v83 = buffer.readbits(p46, v49 * 8 + v54, 4);
                v54 = v54 + 4;
                v49 = v49 + bit32.rshift(v54, 3);
                v54 = bit32.band(v54, 7);
                local v84 = v83 + 4;
                local v85 = table.create(19, 0);
                for v86 = 1, v84 do
                    local v87 = u20[v86] + 1;
                    local v88 = buffer.readbits(p46, v49 * 8 + v54, 3);
                    v54 = v54 + 3;
                    v49 = v49 + bit32.rshift(v54, 3);
                    v54 = bit32.band(v54, 7);
                    v85[v87] = v88;
                end;
                v61 = u18(v85);
                v57 = table.create(v53);
                v58 = nil;
                v65 = 1;
                continue;
            elseif v65 == 1 then
                v65 = -1;
                local v89 = 2;
                local v90 = buffer.readu8(p46, v49);
                local v91 = bit32.extract(v90, v54);
                v54 = v54 + 1;
                if v54 == 8 then
                    v54 = 0;
                    v49 = v49 + 1;
                end;
                local v92 = v89 + v91;
                while not v61[v92] do
                    local v93 = 2 * v92;
                    local v94 = buffer.readu8(p46, v49);
                    local v95 = bit32.extract(v94, v54);
                    v54 = v54 + 1;
                    if v54 == 8 then
                        v54 = 0;
                        v49 = v49 + 1;
                    end;
                    v92 = v93 + v95;
                end;
                local v96 = v61[v92];
                local v97 = 1;
                if v96 <= 15 then
                    v58 = v96;
                elseif v96 == 16 then
                    local v98 = buffer.readbits(p46, v49 * 8 + v54, 2);
                    v54 = v54 + 2;
                    v49 = v49 + bit32.rshift(v54, 3);
                    v54 = bit32.band(v54, 7);
                    v97 = v98 + 3;
                elseif v96 == 17 then
                    v58 = 0;
                    local v99 = buffer.readbits(p46, v49 * 8 + v54, 3);
                    v54 = v54 + 3;
                    v49 = v49 + bit32.rshift(v54, 3);
                    v54 = bit32.band(v54, 7);
                    v97 = v99 + 3;
                elseif v96 == 18 then
                    v58 = 0;
                    local v100 = buffer.readbits(p46, v49 * 8 + v54, 7);
                    v54 = v54 + 7;
                    v49 = v49 + bit32.rshift(v54, 3);
                    v54 = bit32.band(v54, 7);
                    v97 = v100 + 11;
                end;
                for _ = 1, v97 do
                    table.insert(v57, v58);
                end;
                if v53 <= #v57 then
                    v48 = u18(v57);
                    local v101 = table.create(v60);
                    local v102 = nil;
                    local v103 = 2;
                    local v104 = buffer.readu8(p46, v49);
                    local v105 = bit32.extract(v104, v54);
                    v54 = v54 + 1;
                    if v54 == 8 then
                        v54 = 0;
                        v49 = v49 + 1;
                    end;
                    local v106 = v103 + v105;
                    while not v61[v106] do
                        local v107 = 2 * v106;
                        local v108 = buffer.readu8(p46, v49);
                        local v109 = bit32.extract(v108, v54);
                        v54 = v54 + 1;
                        if v54 == 8 then
                            v54 = 0;
                            v49 = v49 + 1;
                        end;
                        v106 = v107 + v109;
                    end;
                    local v110 = v61[v106];
                    local v111 = 1;
                    if v110 <= 15 then
                        v102 = v110;
                    elseif v110 == 16 then
                        local v112 = buffer.readbits(p46, v49 * 8 + v54, 2);
                        v54 = v54 + 2;
                        v49 = v49 + bit32.rshift(v54, 3);
                        v54 = bit32.band(v54, 7);
                        v111 = v112 + 3;
                    elseif v110 == 17 then
                        v102 = 0;
                        local v113 = buffer.readbits(p46, v49 * 8 + v54, 3);
                        v54 = v54 + 3;
                        v49 = v49 + bit32.rshift(v54, 3);
                        v54 = bit32.band(v54, 7);
                        v111 = v113 + 3;
                    elseif v110 == 18 then
                        v102 = 0;
                        local v114 = buffer.readbits(p46, v49 * 8 + v54, 7);
                        v54 = v54 + 7;
                        v49 = v49 + bit32.rshift(v54, 3);
                        v54 = bit32.band(v54, 7);
                        v111 = v114 + 11;
                    end;
                    for _ = 1, v111 do
                        table.insert(v101, v102);
                    end;
                    if v60 <= #v101 then
                        v62 = u18(v101);
                        v66 = 2;
                        v67 = buffer.readu8(p46, v49);
                        v68 = bit32.extract(v67, v54);
                        v54 = v54 + 1;
                        if v54 == 8 then
                            v54 = 0;
                            v49 = v49 + 1;
                        end;
                        v63 = v66 + v68;
                        v59 = v48;
                        v65 = 3;
                        continue;
                    end;
                    goto l6;
                end;
                v65 = 1;
                continue;
            elseif v65 == 2 then
                v65 = -1;
                local v115 = 2 * v63;
                local v116 = buffer.readu8(p46, v49);
                local v117 = bit32.extract(v116, v54);
                v54 = v54 + 1;
                if v54 == 8 then
                    v54 = 0;
                    v49 = v49 + 1;
                end;
                v63 = v115 + v117;
                v65 = 3;
                continue;
            elseif v65 == 3 then
                v65 = -1;
                if v48[v63] then
                    v65 = 4;
                    continue;
                else
                    v65 = 2;
                    continue;
                end;
                v65 = 4;
                continue;
            elseif v65 == 4 then
                v65 = -1;
                v64 = v48[v63];
                if v64 < 256 then
                    buffer.writeu8(p47, v50, v64);
                    v50 = v50 + 1;
                elseif v64 > 256 then
                    local v118 = u1[v64 - 256];
                    if v64 > 268 then
                        local v119 = u4[v64 - 264];
                        local v120 = buffer.readbits(p46, v49 * 8 + v54, v119);
                        v54 = v54 + v119;
                        v49 = v49 + bit32.rshift(v54, 3);
                        v54 = bit32.band(v54, 7);
                        v118 = v118 + v120;
                    elseif v64 > 264 then
                        local v121 = buffer.readu8(p46, v49);
                        local v122 = bit32.extract(v121, v54);
                        v54 = v54 + 1;
                        if v54 == 8 then
                            v54 = 0;
                            v49 = v49 + 1;
                        end;
                        v118 = v118 + v122;
                    end;
                    local v123 = 2;
                    local v124 = buffer.readu8(p46, v49);
                    local v125 = bit32.extract(v124, v54);
                    v54 = v54 + 1;
                    if v54 == 8 then
                        v54 = 0;
                        v49 = v49 + 1;
                    end;
                    local v126 = v123 + v125;
                    local v127 = v62;
                    while not v62[v126] do
                        local v128 = 2 * v126;
                        local v129 = buffer.readu8(p46, v49);
                        local v130 = bit32.extract(v129, v54);
                        v54 = v54 + 1;
                        if v54 == 8 then
                            v54 = 0;
                            v49 = v49 + 1;
                        end;
                        v126 = v128 + v130;
                    end;
                    local v131 = v62[v126];
                    local v132 = u6[v131 + 1];
                    if v131 > 5 then
                        local v133 = u21[v131];
                        local v134 = buffer.readbits(p46, v49 * 8 + v54, v133);
                        v54 = v54 + v133;
                        v49 = v49 + bit32.rshift(v54, 3);
                        v54 = bit32.band(v54, 7);
                        v132 = v132 + v134;
                    elseif v131 > 3 then
                        local v135 = buffer.readu8(p46, v49);
                        local v136 = bit32.extract(v135, v54);
                        v54 = v54 + 1;
                        if v54 == 8 then
                            v54 = 0;
                            v49 = v49 + 1;
                        end;
                        v132 = v132 + v136;
                    end;
                    if v118 <= v132 then
                        buffer.copy(p47, v50, p47, v50 - v132, v118);
                        v50 = v50 + v118;
                        v62 = v127;
                    else
                        repeat
                            local v137 = math.min(v118, v132);
                            buffer.copy(p47, v50, p47, v50 - v132, v137);
                            v50 = v50 + v137;
                            v118 = v118 - v137;
                            v132 = v132 + v137;
                        until v118 == 0;
                        v62 = v127;
                    end;
                    v65 = 5;
                    continue;
                end;
                v65 = 5;
                continue;
            elseif v65 == 5 then
                v65 = -1;
                if v64 == 256 then
                    if v52 == 1 then
                        if v54 > 0 then
                            v54 = 0;
                            v49 = v49 + 1;
                        end;
                        v55 = u45(p47, 0, buffer.len(p47));
                        v56 = buffer.readu32(p46, v49);
                        v51 = v55 == bit32.byteswap(v56);
                        assert(v51, "adler-32 checksum mismatch");
                        return v50;
                    end;
                end;
                v48 = v59;
                v66 = 2;
                v67 = buffer.readu8(p46, v49);
                v68 = bit32.extract(v67, v54);
                v54 = v54 + 1;
                if v54 == 8 then
                    v54 = 0;
                    v49 = v49 + 1;
                end;
                v63 = v66 + v68;
                v59 = v48;
                v65 = 3;
                continue;
                break;
            else
                break;
            end;
        end;
    end,
    deflate = function(p138) --[[ Name: deflate, Line 322 ]]
        -- upvalues: u30 (copy), u31 (copy), u2 (copy), u3 (copy), u5 (copy), u36 (copy), u33 (copy), u34 (copy), u6 (copy), u21 (copy), u45 (copy)
        local v139 = buffer.len(p138);
        local u140 = buffer.create(math.ceil(v139 / 32768) * 5 + v139 + 6);
        buffer.writeu16(u140, 0, 24184);
        local u141 = 2;
        local u142 = 0;
        local function u171(p143, p144) --[[ Line: 341 ]]
            -- upvalues: u140 (copy), u141 (ref), u142 (ref)
            local v145 = bit32.rshift(p143, 1);
            local v146 = bit32.band(v145, 1431655765);
            local v147 = bit32.lshift(p143, 1);
            local v148 = bit32.band(v147, 2863311530);
            local v149 = bit32.bor(v146, v148);
            local v150 = bit32.rshift(v149, 2);
            local v151 = bit32.band(v150, 858993459);
            local v152 = bit32.lshift(v149, 2);
            local v153 = bit32.band(v152, 3435973836);
            local v154 = bit32.bor(v151, v153);
            local v155 = bit32.rshift(v154, 4);
            local v156 = bit32.band(v155, 252645135);
            local v157 = bit32.lshift(v154, 4);
            local v158 = bit32.band(v157, 4042322160);
            local v159 = bit32.bor(v156, v158);
            local v160 = bit32.rshift(v159, 8);
            local v161 = bit32.band(v160, 16711935);
            local v162 = bit32.lshift(v159, 8);
            local v163 = bit32.band(v162, 4278255360);
            local v164 = bit32.bor(v161, v163);
            local v165 = bit32.rshift(v164, 16);
            local v166 = bit32.lshift(v164, 16);
            local v167 = bit32.bor(v165, v166);
            local v168 = bit32.rshift(v167, 32 - p144);
            local v169 = bit32.lshift(1, p144) - 1;
            local v170 = bit32.band(v168, v169);
            buffer.writebits(u140, u141 * 8 + u142, p144, v170);
            u142 = u142 + p144;
            u141 = u141 + bit32.rshift(u142, 3);
            u142 = bit32.band(u142, 7);
        end;
        local function v180(p172, p173) --[[ Line: 355 ]]
            -- upvalues: u2 (ref), u171 (copy), u30 (ref), u31 (ref), u3 (ref), u5 (ref), u140 (copy), u141 (ref), u142 (ref), u36 (ref), u33 (ref), u34 (ref), u6 (ref), u21 (ref)
            local v174 = u2[p173];
            u171(u30[v174], u31[v174]);
            if p173 > 10 then
                local v175 = u3[p173];
                local v176 = u5[p173];
                buffer.writebits(u140, u141 * 8 + u142, v176, v175);
                u142 = u142 + v176;
                u141 = u141 + bit32.rshift(u142, 3);
                u142 = bit32.band(u142, 7);
            end;
            local v177 = u36(p172);
            u171(u33[v177 - 1], u34[v177 - 1]);
            if v177 > 3 then
                local v178 = p172 - u6[v177];
                local v179 = u21[v177 - 1];
                buffer.writebits(u140, u141 * 8 + u142, v179, v178);
                u142 = u142 + v179;
                u141 = u141 + bit32.rshift(u142, 3);
                u142 = bit32.band(u142, 7);
            end;
        end;
        local v181 = {};
        local v182 = {};
        local v183 = {};
        local v184 = 0;
        local v185 = u142;
        for v191 = 0, v139 - 1, 32768 do
            local v187 = math.min(v139, v191 + 32768);
            local v188 = v191;
            local v189 = {};
            local v190 = 0;
            local v191;
            while v191 < v187 - 3 do
                local v192 = buffer.readu32(p138, v191);
                local v193 = bit32.band(v192, 16777215);
                local v194 = v183[v193] or 0;
                v184 = v184 + 1;
                v181[v184] = v191;
                v182[v184] = v194;
                local v195 = v184;
                v183[v193] = v195;
                local v196 = v182[v195];
                local v197 = -1;
                local v198 = 0;
                local v199 = 0;
                local v200, v201;
                while true do
                    if not v196 or ((v181[v196] or (-1 / 0)) < v191 - 32510 or (v198 >= 12 or v199 >= 96)) then
                        v200 = v197;
                        v201 = v199;
                        break;
                    end;
                    v201 = 3;
                    v200 = v181[v196];
                    local v202;
                    if math.min(v187, v191 + 258) > v191 + v199 and buffer.readu8(p138, v200 + v199) ~= buffer.readu8(p138, v191 + v199) then
                        v202 = true;
                    else
                        v202 = false;
                    end;
                    while not v202 and (v201 < 258 and (v191 + v201 < v187 and buffer.readu8(p138, v200 + v201) == buffer.readu8(p138, v191 + v201))) do
                        v201 = v201 + 1;
                    end;
                    if v199 < v201 then
                        if v201 >= 258 then
                            break;
                        end;
                    else
                        v200 = v197;
                        v201 = v199;
                    end;
                    v196 = v182[v196];
                    v198 = v198 + 1;
                    v199 = v201;
                    v197 = v200;
                end;
                if v201 == 0 then
                    local v203 = buffer.readu8(p138, v191);
                    v190 = v190 + u31[v203];
                    local v204 = vector.create(0, v203);
                    table.insert(v189, v204);
                    v191 = v191 + 1;
                else
                    local v205 = u36(v191 - v200);
                    v190 = v190 + (u31[u2[v201]] + u5[v201] + u34[v205 - 1] + (u21[v205 - 1] or 0));
                    local v206 = vector.create(1, v191 - v200, v201);
                    table.insert(v189, v206);
                    for v207 = v191 + 1, math.min(v191 + v201 - 1, v187 - 4) do
                        local v208 = buffer.readu32(p138, v207);
                        local v209 = bit32.band(v208, 16777215);
                        local v210 = v183[v209] or 0;
                        v184 = v184 + 1;
                        v181[v184] = v207;
                        v182[v184] = v210;
                        v183[v209] = v184;
                    end;
                    v191 = v191 + v201;
                end;
            end;
            while v191 < v187 do
                local v211 = buffer.readu8(p138, v191);
                v190 = v190 + u31[v211];
                local v212 = vector.create(0, v211);
                table.insert(v189, v212);
                v191 = v191 + 1;
            end;
            local v213 = v190 + u31[256];
            table.insert(v189, Vector3.new(0, 256, 0));
            local v214;
            if v187 == v139 then
                buffer.writebits(u140, u141 * 8 + v185, 1, 1);
                u142 = v185 + 1;
                u141 = u141 + bit32.rshift(u142, 3);
                u142 = bit32.band(u142, 7);
                v214 = u142;
            else
                buffer.writebits(u140, u141 * 8 + v185, 1, 0);
                u142 = v185 + 1;
                u141 = u141 + bit32.rshift(u142, 3);
                u142 = bit32.band(u142, 7);
                v214 = u142;
            end;
            local v215 = v187 - v188;
            if math.ceil(v213 / 8) + 1 < math.ceil(v215 / 32768) * 5 + v215 then
                buffer.writebits(u140, u141 * 8 + v214, 2, 1);
                u142 = v214 + 2;
                u141 = u141 + bit32.rshift(u142, 3);
                u142 = bit32.band(u142, 7);
                v185 = u142;
                for _, v216 in v189 do
                    if v216.x == 0 then
                        local l__y__1 = v216.y;
                        u171(u30[l__y__1], u31[l__y__1]);
                    else
                        v180(v216.y, v216.z);
                    end;
                end;
            else
                buffer.writebits(u140, u141 * 8 + v214, 2, 0);
                u142 = v214 + 2;
                u141 = u141 + bit32.rshift(u142, 3);
                u142 = bit32.band(u142, 7);
                if u142 > 0 then
                    u141 = u141 + 1;
                    u142 = 0;
                    v185 = u142;
                else
                    v185 = u142;
                end;
                buffer.writeu16(u140, u141, v215);
                local v217 = u141 + 2;
                local v218 = bit32.bxor(65535, v215);
                buffer.writeu16(u140, v217, v218);
                buffer.copy(u140, u141 + 4, p138, v188, v215);
                u141 = u141 + (v215 + 4);
            end;
            if v184 > 50000 then
                table.clear(v181);
                table.clear(v182);
                table.clear(v183);
                v184 = 0;
            end;
        end;
        if v185 > 0 then
            u141 = u141 + 1;
        end;
        local v219 = u45(p138, 0, buffer.len(p138));
        local v220 = bit32.byteswap(v219);
        buffer.writeu32(u140, u141, v220);
        return u140, u141 + 4;
    end
};