-- Decompiled with Potassium's decompiler.

local l__byte__1 = string.byte;
local l__char__2 = string.char;
local l__find__3 = string.find;
local l__gsub__4 = string.gsub;
local l__sub__5 = string.sub;
local l__concat__6 = table.concat;
local l__sort__7 = table.sort;
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = {
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
local u11 = {
    0,
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
local u12 = {};
local u13 = {};
local u14 = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
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
local u15 = {};
local u16 = {};
local u17 = {
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
local u18 = {};
local u19 = {};
local u20 = {};
local u21 = {
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
local u22 = {};
for v23 = 0, 255 do
    u1[v23] = l__char__2(v23);
end;
local v24 = 1;
for v25 = 0, 32 do
    u2[v25] = v24;
    v24 = v24 * 2;
end;
for v26 = 1, 9 do
    u3[v26] = {};
    for v31 = 0, u2[v26 + 1] - 1 do
        local v28 = v31;
        local v29 = 0;
        for _ = 1, v26 do
            local v30 = v29 - v29 % 2 + ((v29 % 2 == 1 or v31 % 2 == 1) and 1 or 0);
            local v31 = (v31 - v31 % 2) / 2;
            v29 = v30 * 2;
        end;
        u3[v26][v28] = (v29 - v29 % 2) / 2;
    end;
end;
local v32 = 1;
local v33 = 18;
local v34 = 16;
local v35 = 265;
for v36 = 3, 258 do
    if v36 <= 10 then
        u5[v36] = v36 + 254;
        u6[v36] = 0;
    elseif v36 == 258 then
        u5[v36] = 285;
        u6[v36] = 0;
    else
        if v33 < v36 then
            v33 = v33 + v34;
            v34 = v34 * 2;
            v35 = v35 + 4;
            v32 = v32 + 1;
        end;
        local v37 = v36 - v33 - 1 + v34 / 2;
        u5[v36] = (v37 - v37 % (v34 / 8)) / (v34 / 8) + v35;
        u6[v36] = v32;
        u4[v36] = v37 % (v34 / 8);
    end;
end;
u7[1] = 0;
u7[2] = 1;
u8[1] = 0;
u8[2] = 0;
local v38 = 4;
local v39 = 3;
local v40 = 2;
local v41 = 0;
for v42 = 3, 256 do
    if v38 < v42 then
        v39 = v39 * 2;
        v38 = v38 * 2;
        v40 = v40 + 2;
        v41 = v41 + 1;
    end;
    u7[v42] = v42 <= v39 and v40 and v40 or v40 + 1;
    u8[v42] = v41 < 0 and 0 or v41;
    if v38 >= 8 then
        u9[v42] = (v42 - v38 / 2 - 1) % (v38 / 4);
    end;
end;
function u13.Adler32(_, p43) --[[ Line: 371 ]]
    -- upvalues: l__byte__1 (copy)
    if type(p43) ~= "string" then
        error(("Usage: LibDeflate:Adler32(str): \'str\' - string expected got \'%s\'."):format((type(p43))), 2);
    end;
    local v44 = #p43;
    local v45 = 1;
    local v46 = 1;
    local v47 = 0;
    while v45 <= v44 - 15 do
        local v48, v49, v50, v51, v52, v53, v54, v55, v56, v57, v58, v59, v60, v61, v62, v63 = l__byte__1(p43, v45, v45 + 15);
        v47 = (v47 + v46 * 16 + v48 * 16 + 15 * v49 + 14 * v50 + 13 * v51 + 12 * v52 + 11 * v53 + 10 * v54 + 9 * v55 + 8 * v56 + 7 * v57 + 6 * v58 + 5 * v59 + 4 * v60 + 3 * v61 + 2 * v62 + v63) % 65521;
        v46 = (v46 + v48 + v49 + v50 + v51 + v52 + v53 + v54 + v55 + v56 + v57 + v58 + v59 + v60 + v61 + v62 + v63) % 65521;
        v45 = v45 + 16;
    end;
    while v45 <= v44 do
        v46 = (v46 + l__byte__1(p43, v45, v45)) % 65521;
        v47 = (v47 + v46) % 65521;
        v45 = v45 + 1;
    end;
    return (v47 * 65536 + v46) % 4294967296;
end;
local function v66(p64, p65) --[[ Line: 416 ]]
    return p64 % 4294967296 == p65 % 4294967296;
end;
function u13.CreateDictionary(p67, p68, p69, p70) --[[ Line: 462 ]]
    -- upvalues: l__byte__1 (copy)
    if type(p68) ~= "string" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - string expected got \'%s\'."):format((type(p68))), 2);
    end;
    if type(p69) ~= "number" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'strlen\' - number expected got \'%s\'."):format((type(p69))), 2);
    end;
    if type(p70) ~= "number" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'adler32\' - number expected got \'%s\'."):format((type(p70))), 2);
    end;
    if p69 ~= #p68 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'strlen\' does not match the actual length of \'str\'. \'strlen\': %u, \'#str\': %u . Please check if \'str\' is modified unintentionally."):format(p69, #p68));
    end;
    if p69 == 0 then
        error("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - Empty string is not allowed.", 2);
    end;
    if p69 > 32768 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'str\' - string longer than 32768 bytes is not allowed. Got %d bytes."):format(p69), 2);
    end;
    local v71 = p67:Adler32(p68);
    if p70 % 4294967296 ~= v71 % 4294967296 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): \'adler32\' does not match the actual adler32 of \'str\'. \'adler32\': %u, \'Adler32(str)\': %u . Please check if \'str\' is modified unintentionally."):format(p70, v71));
    end;
    local v72 = {
        adler32 = p70,
        hash_tables = {},
        string_table = {},
        strlen = p69
    };
    local l__string_table__8 = v72.string_table;
    local l__hash_tables__9 = v72.hash_tables;
    l__string_table__8[1] = l__byte__1(p68, 1, 1);
    l__string_table__8[2] = l__byte__1(p68, 2, 2);
    if p69 >= 3 then
        local v73 = l__string_table__8[1] * 256 + l__string_table__8[2];
        local v74 = 1;
        while v74 <= p69 - 2 - 3 do
            local v75, v76, v77, v78 = l__byte__1(p68, v74 + 2, v74 + 5);
            l__string_table__8[v74 + 2] = v75;
            l__string_table__8[v74 + 3] = v76;
            l__string_table__8[v74 + 4] = v77;
            l__string_table__8[v74 + 5] = v78;
            local v79 = (v73 * 256 + v75) % 16777216;
            local v80 = l__hash_tables__9[v79];
            if not v80 then
                v80 = {};
                l__hash_tables__9[v79] = v80;
            end;
            v80[#v80 + 1] = v74 - p69;
            local v81 = v74 + 1;
            local v82 = (v79 * 256 + v76) % 16777216;
            local v83 = l__hash_tables__9[v82];
            if not v83 then
                v83 = {};
                l__hash_tables__9[v82] = v83;
            end;
            v83[#v83 + 1] = v81 - p69;
            local v84 = v81 + 1;
            local v85 = (v82 * 256 + v77) % 16777216;
            local v86 = l__hash_tables__9[v85];
            if not v86 then
                v86 = {};
                l__hash_tables__9[v85] = v86;
            end;
            v86[#v86 + 1] = v84 - p69;
            local v87 = v84 + 1;
            v73 = (v85 * 256 + v78) % 16777216;
            local v88 = l__hash_tables__9[v73];
            if not v88 then
                v88 = {};
                l__hash_tables__9[v73] = v88;
            end;
            v88[#v88 + 1] = v87 - p69;
            v74 = v87 + 1;
        end;
        while v74 <= p69 - 2 do
            local v89 = l__byte__1(p68, v74 + 2);
            l__string_table__8[v74 + 2] = v89;
            v73 = (v73 * 256 + v89) % 16777216;
            local v90 = l__hash_tables__9[v73];
            if not v90 then
                v90 = {};
                l__hash_tables__9[v73] = v90;
            end;
            v90[#v90 + 1] = v74 - p69;
            v74 = v74 + 1;
        end;
    end;
    return v72;
end;
local function u92(p91) --[[ Line: 560 ]]
    if p91 == nil or type(p91) ~= "table" then
        return false, ("\'dictionary\' - table expected got \'%s\'."):format((type(p91)));
    elseif type(p91.adler32) == "number" and (type(p91.string_table) == "table" and (type(p91.strlen) == "number" and (p91.strlen > 0 and (p91.strlen <= 32768 and (p91.strlen == #p91.string_table and type(p91.hash_tables) == "table"))))) then
        return true, "";
    else
        return false, ("\'%s\' - corrupted dictionary."):format((type(p91)));
    end;
end;
local u93 = {
    [0] = {
        false,
        nil,
        0,
        0,
        0
    },
    [1] = {
        false,
        nil,
        4,
        8,
        4
    },
    [2] = {
        false,
        nil,
        5,
        18,
        8
    },
    [3] = {
        false,
        nil,
        6,
        32,
        32
    },
    [4] = {
        true,
        4,
        4,
        16,
        16
    },
    [5] = {
        true,
        8,
        16,
        32,
        32
    },
    [6] = {
        true,
        8,
        16,
        128,
        128
    },
    [7] = {
        true,
        8,
        32,
        128,
        256
    },
    [8] = {
        true,
        32,
        128,
        258,
        1024
    },
    [9] = {
        true,
        32,
        258,
        258,
        4096
    }
};
local function u104(p94, p95, p96, p97, p98) --[[ Line: 640 ]]
    -- upvalues: u92 (copy), u93 (copy)
    if type(p94) ~= "string" then
        return false, ("\'str\' - string expected got \'%s\'."):format((type(p94)));
    end;
    if p95 then
        local v99, v100 = u92(p96);
        if not v99 then
            return false, v100;
        end;
    end;
    if p97 then
        local v101 = type(p98);
        if v101 ~= "nil" and v101 ~= "table" then
            return false, ("\'configs\' - nil or table expected got \'%s\'."):format((type(p98)));
        end;
        if v101 == "table" then
            assert(p98);
            for v102, v103 in pairs(p98) do
                if v102 ~= "level" and v102 ~= "strategy" then
                    return false, ("\'configs\' - unsupported table key in the configs: \'%s\'."):format(v102);
                end;
                if v102 == "level" and not u93[v103] then
                    return false, ("\'configs\' - unsupported \'level\': %s."):format((tostring(v103)));
                end;
                if v102 == "strategy" and (v103 ~= "fixed" and (v103 ~= "huffman_only" and v103 ~= "dynamic")) then
                    return false, ("\'configs\' - unsupported \'strategy\': \'%s\'."):format((tostring(v103)));
                end;
            end;
        end;
    end;
    return true, "";
end;
local function u118() --[[ Line: 702 ]]
    -- upvalues: u2 (copy), u1 (copy), l__char__2 (copy), l__concat__6 (copy)
    local u105 = 0;
    local u106 = 0;
    local u107 = 0;
    local u108 = 0;
    local u109 = {};
    local u110 = {};
    return function(p111, p112) --[[ Name: WriteBits, Line 715 ]]
        -- upvalues: u106 (ref), u2 (ref), u107 (ref), u108 (ref), u105 (ref), u109 (ref), u1 (ref)
        u106 = u106 + p111 * u2[u107];
        u107 = u107 + p112;
        u108 = u108 + p112;
        if u107 >= 32 then
            u105 = u105 + 1;
            u109[u105] = u1[u106 % 256] .. u1[(u106 - u106 % 256) / 256 % 256] .. u1[(u106 - u106 % 65536) / 65536 % 256] .. u1[(u106 - u106 % 16777216) / 16777216 % 256];
            local v113 = u2[32 - u107 + p112];
            u106 = (p111 - p111 % v113) / v113;
            u107 = u107 - 32;
        end;
    end, function(p114) --[[ Name: WriteString, Line 737 ]]
        -- upvalues: u107 (ref), u105 (ref), u109 (ref), u106 (ref), l__char__2 (ref), u108 (ref)
        for _ = 1, u107, 8 do
            u105 = u105 + 1;
            u109[u105] = l__char__2(u106 % 256);
            u106 = (u106 - u106 % 256) / 256;
        end;
        u107 = 0;
        u105 = u105 + 1;
        u109[u105] = p114;
        u108 = u108 + #p114 * 8;
    end, function(p115) --[[ Name: FlushWriter, Line 756 ]]
        -- upvalues: u108 (ref), u107 (ref), u106 (ref), u2 (ref), u105 (ref), u109 (ref), u1 (ref), l__concat__6 (ref), u110 (copy)
        if p115 == 3 then
            return u108, nil;
        else
            if p115 == 1 or p115 == 2 then
                local v116 = (8 - u107 % 8) % 8;
                if u107 > 0 then
                    u106 = u106 - u2[u107] + u2[u107 + v116];
                    for _ = 1, u107, 8 do
                        u105 = u105 + 1;
                        u109[u105] = u1[u106 % 256];
                        u106 = (u106 - u106 % 256) / 256;
                    end;
                    u106 = 0;
                    u107 = 0;
                end;
                if p115 == 2 then
                    u108 = u108 + v116;
                    return u108, nil;
                end;
            end;
            local v117 = l__concat__6(u109);
            u109 = {};
            u105 = 0;
            u110[#u110 + 1] = v117;
            if p115 == 0 then
                return u108, nil;
            else
                return u108, l__concat__6(u110);
            end;
        end;
    end;
end;
local function u127(p119, p120, p121) --[[ Line: 808 ]]
    local v122 = p121 + 1;
    p119[v122] = p120;
    local v123 = p120[1];
    local v124 = (v122 - v122 % 2) / 2;
    while v124 >= 1 and v123 < p119[v124][1] do
        local v125 = p119[v124];
        p119[v124] = p120;
        p119[v122] = v125;
        local v126 = (v124 - v124 % 2) / 2;
        v122 = v124;
        v124 = v126;
    end;
end;
local function u141(p128, p129) --[[ Line: 829 ]]
    local v130 = p128[1];
    local v131 = p128[p129];
    local v132 = v131[1];
    p128[1] = v131;
    p128[p129] = v130;
    local v133 = p129 - 1;
    local v134 = 1;
    local v135 = v134 * 2;
    local v136 = v135 + 1;
    while v135 <= v133 do
        local v137 = p128[v135];
        local v138;
        if v136 <= v133 and p128[v136][1] < v137[1] then
            local v139 = p128[v136];
            if v139[1] >= v132 then
                break;
            end;
            p128[v136] = v131;
            p128[v134] = v139;
            v138 = v136 * 2;
            local v140 = v138 + 1;
            v135 = v136;
            v136 = v140;
        else
            if v137[1] >= v132 then
                break;
            end;
            p128[v135] = v131;
            p128[v134] = v137;
            v138 = v135 * 2;
            v136 = v138 + 1;
        end;
        v134 = v135;
        v135 = v138;
    end;
    return v130;
end;
local function u155(p142, p143, p144, p145) --[[ Line: 879 ]]
    -- upvalues: u3 (copy)
    local v146 = 0;
    local v147 = {};
    local v148 = {};
    for v149 = 1, p145 do
        v146 = (v146 + (p142[v149 - 1] or 0)) * 2;
        v147[v149] = v146;
    end;
    for v150 = 0, p144 do
        local v151 = p143[v150];
        if v151 then
            local v152 = v147[v151];
            v147[v151] = v152 + 1;
            if v151 <= 9 then
                v148[v150] = u3[v151][v152];
            else
                local v153 = 0;
                for _ = 1, v151 do
                    local v154 = v153 - v153 % 2 + ((v153 % 2 == 1 or v152 % 2 == 1) and 1 or 0);
                    v152 = (v152 - v152 % 2) / 2;
                    v153 = v154 * 2;
                end;
                v148[v150] = (v153 - v153 % 2) / 2;
            end;
        end;
    end;
    return v148;
end;
local function u159(p156, p157) --[[ Line: 923 ]]
    local v158;
    if p156[1] < p157[1] then
        v158 = true;
    elseif p156[1] == p157[1] then
        v158 = p156[2] < p157[2];
    else
        v158 = false;
    end;
    return v158;
end;
local function u191(p160, p161, p162) --[[ Line: 938 ]]
    -- upvalues: l__sort__7 (copy), u159 (copy), u141 (copy), u127 (copy), u155 (copy)
    local v163 = 0;
    local v164 = {};
    local v165 = {};
    local v166 = {};
    local v167 = -1;
    local v168 = {};
    local v169 = {};
    for v170, v171 in pairs(p160) do
        v163 = v163 + 1;
        v164[v163] = { v171, v170 };
    end;
    if v163 == 0 then
        return {}, {}, -1;
    end;
    if v163 == 1 then
        local v172 = v164[1][2];
        v166[v172] = 1;
        v169[v172] = 0;
        return v166, v169, v172;
    end;
    l__sort__7(v164, u159);
    for v173 = 1, v163 do
        v165[v173] = v164[v173];
    end;
    while v163 > 1 do
        local v174 = u141(v165, v163);
        local v175 = v163 - 1;
        local v176 = u141(v165, v175);
        local v177 = v175 - 1;
        u127(v165, {
            v174[1] + v176[1],
            -1,
            v174,
            v176
        }, v177);
        v163 = v177 + 1;
    end;
    local v178 = {
        v165[1],
        {},
        {},
        {}
    };
    v165[1][1] = 0;
    local v179 = 1;
    local v180 = 1;
    local v181 = 0;
    while v179 <= v180 do
        local v182 = v178[v179];
        local v183 = v182[1];
        local v184 = v182[2];
        local v185 = v182[3];
        local v186 = v182[4];
        if v185 then
            v180 = v180 + 1;
            v178[v180] = v185;
            v185[1] = v183 + 1;
        end;
        if v186 then
            v180 = v180 + 1;
            v178[v180] = v186;
            v186[1] = v183 + 1;
        end;
        v179 = v179 + 1;
        if p161 < v183 then
            v181 = v181 + 1;
            v183 = p161;
        end;
        if v184 >= 0 then
            v166[v184] = v183;
            if v167 < v184 then
                v167 = v184 or v167;
            end;
            v168[v183] = (v168[v183] or 0) + 1;
        end;
    end;
    if v181 > 0 then
        while true do
            local v187 = p161 - 1;
            while (v168[v187] or 0) == 0 do
                v187 = v187 - 1;
            end;
            v168[v187] = v168[v187] - 1;
            v168[v187 + 1] = (v168[v187 + 1] or 0) + 2;
            v168[p161] = v168[p161] - 1;
            v181 = v181 - 2;
            if v181 <= 0 then
                local v188 = 1;
                for v189 = p161, 1, -1 do
                    local v190 = v168[v189] or 0;
                    while v190 > 0 do
                        v166[v164[v188][2]] = v189;
                        v190 = v190 - 1;
                        v188 = v188 + 1;
                    end;
                end;
                return v166, u155(v168, v166, p162, p161), v167;
            end;
        end;
    else
        return v166, u155(v168, v166, p162, p161), v167;
    end;
end;
local function u208(p192, p193, p194, p195) --[[ Line: 1073 ]]
    local v196 = p193 + (p195 < 0 and 0 or p195) + 1;
    local v197 = nil;
    local v198 = 0;
    local v199 = 0;
    local v200 = {};
    local v201 = 0;
    local v202 = {};
    local v203 = {};
    for v204 = 0, v196 + 1 do
        local v205;
        if v204 <= p193 then
            v205 = p192[v204] or 0;
        else
            v205 = v204 <= v196 and (p194[v204 - p193 - 1] or 0) or nil;
        end;
        if v205 == v197 then
            v198 = v198 + 1;
            if v205 == 0 or v198 ~= 6 then
                if v205 == 0 and v198 == 138 then
                    v199 = v199 + 1;
                    v200[v199] = 18;
                    v201 = v201 + 1;
                    v202[v201] = 127;
                    v203[18] = (v203[18] or 0) + 1;
                    v198 = 0;
                end;
            else
                v199 = v199 + 1;
                v200[v199] = 16;
                v201 = v201 + 1;
                v202[v201] = 3;
                v203[16] = (v203[16] or 0) + 1;
                v198 = 0;
            end;
        else
            if v198 == 1 then
                assert(v197);
                v199 = v199 + 1;
                v200[v199] = v197;
                v203[v197] = (v203[v197] or 0) + 1;
            elseif v198 == 2 then
                assert(v197);
                local v206 = v199 + 1;
                v200[v206] = v197;
                v199 = v206 + 1;
                v200[v199] = v197;
                v203[v197] = (v203[v197] or 0) + 2;
            elseif v198 >= 3 then
                v199 = v199 + 1;
                local v207 = v197 == 0 and (v198 <= 10 and 17 or 18) or 16;
                v200[v199] = v207;
                v203[v207] = (v203[v207] or 0) + 1;
                v201 = v201 + 1;
                v202[v201] = v198 <= 10 and v198 - 3 or v198 - 11;
            end;
            if v205 and v205 ~= 0 then
                v199 = v199 + 1;
                v200[v199] = v205;
                v203[v205] = (v203[v205] or 0) + 1;
                v197 = v205;
                v198 = 0;
            else
                v197 = v205;
                v198 = 1;
            end;
        end;
    end;
    return v200, v202, v203;
end;
local function u246(p209, p210, p211, p212, p213) --[[ Line: 1162 ]]
    -- upvalues: l__byte__1 (copy)
    local v214 = p211 - p213;
    while v214 <= p212 - 15 - p213 do
        local v215 = v214 + 1;
        local v216 = v214 + 2;
        local v217 = v214 + 3;
        local v218 = v214 + 4;
        local v219 = v214 + 5;
        local v220 = v214 + 6;
        local v221 = v214 + 7;
        local v222 = v214 + 8;
        local v223 = v214 + 9;
        local v224 = v214 + 10;
        local v225 = v214 + 11;
        local v226 = v214 + 12;
        local v227 = v214 + 13;
        local v228 = v214 + 14;
        local v229 = v214 + 15;
        local v230, v231, v232, v233, v234, v235, v236, v237, v238, v239, v240, v241, v242, v243, v244, v245 = l__byte__1(p209, v214 + p213, v214 + 15 + p213);
        p210[v214] = v230;
        p210[v215] = v231;
        p210[v216] = v232;
        p210[v217] = v233;
        p210[v218] = v234;
        p210[v219] = v235;
        p210[v220] = v236;
        p210[v221] = v237;
        p210[v222] = v238;
        p210[v223] = v239;
        p210[v224] = v240;
        p210[v225] = v241;
        p210[v226] = v242;
        p210[v227] = v243;
        p210[v228] = v244;
        p210[v229] = v245;
        v214 = v214 + 16;
    end;
    while v214 <= p212 - p213 do
        p210[v214] = l__byte__1(p209, v214 + p213, v214 + p213);
        v214 = v214 + 1;
    end;
    return p210;
end;
local function u315(p247, p248, p249, p250, p251, p252, p253) --[[ Line: 1219 ]]
    -- upvalues: u93 (copy), u5 (copy), u6 (copy), u7 (copy), u9 (copy), u8 (copy), u4 (copy)
    local v254 = u93[p247];
    local v255 = v254[1];
    local v256 = v254[2];
    local v257 = v254[3];
    local v258 = v254[4];
    local v259 = v254[5];
    local v260 = (v255 or not v257) and 2147483646 or v257;
    local v261 = v259 - v259 % 4 / 4;
    local v262, v263, v264;
    if p253 then
        v262 = p253.hash_tables;
        v263 = p253.string_table;
        v264 = p253.strlen;
        assert(p250 == 1);
        if p250 <= p251 and v264 >= 2 then
            local v265 = v263[v264 - 1] * 65536 + v263[v264] * 256 + p248[1];
            local v266 = p249[v265];
            if not v266 then
                v266 = {};
                p249[v265] = v266;
            end;
            v266[#v266 + 1] = -1;
        end;
        if p250 + 1 <= p251 and v264 >= 1 then
            local v267 = v263[v264] * 65536 + p248[1] * 256 + p248[2];
            local v268 = p249[v267];
            if not v268 then
                v268 = {};
                p249[v267] = v268;
            end;
            v268[#v268 + 1] = 0;
        end;
    else
        v264 = 0;
        v263 = {};
        v262 = {};
    end;
    local v269 = v264 + 3;
    local v270 = (p248[p250 - p252] or 0) * 256 + (p248[p250 + 1 - p252] or 0);
    local v271 = p251 + (v255 and 1 or 0);
    local v272 = 0;
    local v273 = 0;
    local v274 = {};
    local v275 = 0;
    local v276 = {};
    local v277 = {};
    local v278 = 0;
    local v279 = {};
    local v280 = 0;
    local v281 = {};
    local v282 = false;
    local v283 = 0;
    local v284 = {};
    while true do
        if p250 > v271 then
            v281[v280 + 1] = 256;
            v276[256] = (v276[256] or 0) + 1;
            return v281, v284, v276, v279, v274, v277;
        end;
        local v285 = p250 - p252;
        local v286 = p252 - 3;
        local v287 = 0;
        v270 = (v270 * 256 + (p248[v285 + 2] or 0)) % 16777216;
        local v288 = nil;
        local v289 = p249[v270];
        local v290, v291, v292;
        if v289 then
            v290 = #v289;
            v291 = v290;
            v292 = v289;
        else
            v290 = 0;
            v292 = {};
            p249[v270] = v292;
            if v262 then
                v289 = v262[v270];
                v291 = v289 and (#v289 or 0) or 0;
            else
                v289 = v288;
                v291 = 0;
            end;
        end;
        if p250 <= p251 then
            v292[v290 + 1] = p250;
        end;
        local v293, v294;
        if v291 > 0 and (p250 + 2 <= p251 and (not v255 or v272 < v257)) then
            local v295;
            if v255 and (v256 <= v272 and v261) then
                v295 = v261;
            else
                v295 = v259;
            end;
            local v296 = p251 - p250;
            local v297 = (v296 >= 257 and 257 or v296) + v285;
            local v298 = v285 + 3;
            v293 = v273;
            while true do
                if v291 < 1 or v295 <= 0 then
                    v294 = v287;
                    break;
                end;
                local v299 = v289[v291];
                if p250 - v299 > 32768 then
                    v294 = v287;
                    break;
                end;
                local v300;
                if v299 < p250 then
                    if v299 >= -257 then
                        local v301 = v299 - v286;
                        v300 = v298;
                        while v298 <= v297 and p248[v301] == p248[v298] do
                            v298 = v298 + 1;
                            v301 = v301 + 1;
                        end;
                    else
                        local v302 = v269 + v299;
                        local v303 = v298;
                        while v303 <= v297 and v263[v302] == p248[v303] do
                            v303 = v303 + 1;
                            v302 = v302 + 1;
                        end;
                        v300 = v298;
                        v298 = v303;
                    end;
                    v294 = v298 - v285;
                    if v287 < v294 then
                        v293 = p250 - v299;
                    else
                        v294 = v287;
                    end;
                    if v258 <= v294 then
                        break;
                    end;
                else
                    v294 = v287;
                    v300 = v298;
                end;
                v291 = v291 - 1;
                v295 = v295 - 1;
                if v291 == 0 and (v299 > 0 and v262) then
                    v289 = v262[v270];
                    v291 = v289 and (#v289 or 0) or 0;
                end;
                v298 = v300;
                v287 = v294;
            end;
        else
            v294 = v287;
            v293 = v273;
        end;
        if not v255 then
            v272 = v294;
            v273 = v293;
        end;
        if v255 and not v282 or (v272 <= 3 and (v272 ~= 3 or v273 >= 4096) or v294 > v272) then
            if v255 and not v282 then
                p250 = p250 + 1;
                v282 = true;
            else
                if v255 then
                    v285 = v285 - 1 or v285;
                end;
                local v304 = p248[v285];
                v280 = v280 + 1;
                v281[v280] = v304;
                v276[v304] = (v276[v304] or 0) + 1;
                p250 = p250 + 1;
            end;
        else
            local v305 = u5[v272];
            local v306 = u6[v272];
            local v307, v308, v309;
            if v273 <= 256 then
                v307 = u7[v273];
                v308 = u9[v273];
                v309 = u8[v273];
            else
                v307 = 16;
                v309 = 7;
                local v310 = 384;
                local v311 = 512;
                while true do
                    if v273 <= v310 then
                        v308 = (v273 - v311 / 2 - 1) % (v311 / 4);
                    end;
                    if v273 <= v311 then
                        v308 = (v273 - v311 / 2 - 1) % (v311 / 4);
                        v307 = v307 + 1;
                    end;
                    v307 = v307 + 2;
                    v309 = v309 + 1;
                    v310 = v310 * 2;
                    v311 = v311 * 2;
                end;
            end;
            v280 = v280 + 1;
            v281[v280] = v305;
            v276[v305] = (v276[v305] or 0) + 1;
            v278 = v278 + 1;
            v279[v278] = v307;
            v277[v307] = (v277[v307] or 0) + 1;
            if v306 > 0 then
                local v312 = u4[v272];
                v283 = v283 + 1;
                v284[v283] = v312;
            end;
            if v309 > 0 then
                v275 = v275 + 1;
                v274[v275] = v308;
            end;
            for v313 = p250 + 1, p250 + v272 - (v255 and 2 or 1) do
                v270 = (v270 * 256 + (p248[v313 - p252 + 2] or 0)) % 16777216;
                if v272 <= v260 then
                    local v314 = p249[v270];
                    if not v314 then
                        v314 = {};
                        p249[v270] = v314;
                    end;
                    v314[#v314 + 1] = v313;
                end;
            end;
            p250 = p250 + v272 - (v255 and 1 or 0);
            v282 = false;
        end;
        v273 = v293;
        v272 = v294;
    end;
end;
local function u334(p316, p317) --[[ Line: 1478 ]]
    -- upvalues: u191 (copy), u208 (copy), u21 (copy)
    local v318, v319, v320 = u191(p316, 15, 285);
    local v321, v322, v323 = u191(p317, 15, 29);
    local v324, v325, v326 = u208(v318, v320, v321, v323);
    local v327, v328 = u191(v326, 7, 18);
    local v329 = 0;
    for v330 = 1, 19 do
        if (v327[u21[v330]] or 0) ~= 0 then
            v329 = v330;
        end;
    end;
    local v331 = v329 - 4;
    local v332 = v320 + 1 - 257;
    local v333 = v323 + 1 - 1;
    return v332, v333 < 0 and 0 or v333, v331, v327, v328, v324, v325, v318, v319, v321, v322;
end;
local function u349(p335, p336, p337, p338, p339, p340, p341) --[[ Line: 1516 ]]
    -- upvalues: u14 (copy)
    local v342 = 17 + (p337 + 4) * 3;
    for v343 = 1, #p339 do
        local v344 = p339[v343];
        v342 = v342 + p338[v344];
        if v344 >= 16 then
            v342 = v342 + (v344 == 16 and 2 or (v344 == 17 and 3 or 7));
        end;
    end;
    local v345 = 0;
    for v346 = 1, #p335 do
        local v347 = p335[v346];
        v342 = v342 + p340[v347];
        if v347 > 256 then
            v345 = v345 + 1;
            if v347 > 264 and v347 < 285 then
                v342 = v342 + u14[v347 - 256];
            end;
            local v348 = p336[v345];
            v342 = v342 + p341[v348];
            if v348 > 3 then
                v342 = v342 + ((v348 - v348 % 2) / 2 - 1);
            end;
        end;
    end;
    return v342;
end;
local function u377(p350, p351, p352, p353, p354, p355, p356, p357, p358, p359, p360, p361, p362, p363, p364, p365, p366) --[[ Line: 1564 ]]
    -- upvalues: u21 (copy), u14 (copy)
    p350(p351 and 1 or 0, 1);
    p350(2, 2);
    p350(p356, 5);
    p350(p357, 5);
    p350(p358, 4);
    for v367 = 1, p358 + 4 do
        p350(p359[u21[v367]] or 0, 3);
    end;
    local v368 = 1;
    for v369 = 1, #p361 do
        local v370 = p361[v369];
        p350(p360[v370], p359[v370]);
        if v370 >= 16 then
            p350(p362[v368], v370 == 16 and 2 or (v370 == 17 and 3 or 7));
            v368 = v368 + 1;
        end;
    end;
    local v371 = 0;
    local v372 = 0;
    local v373 = 0;
    for v374 = 1, #p352 do
        local v375 = p352[v374];
        p350(p364[v375], p363[v375]);
        if v375 > 256 then
            v372 = v372 + 1;
            if v375 > 264 and v375 < 285 then
                v371 = v371 + 1;
                p350(p353[v371], u14[v375 - 256]);
            end;
            local v376 = p354[v372];
            p350(p366[v376], p365[v376]);
            if v376 > 3 then
                v373 = v373 + 1;
                p350(p355[v373], (v376 - v376 % 2) / 2 - 1);
            end;
        end;
    end;
end;
local function u385(p378, p379) --[[ Line: 1635 ]]
    -- upvalues: u15 (ref), u14 (copy)
    local v380 = 3;
    local v381 = 0;
    for v382 = 1, #p378 do
        local v383 = p378[v382];
        v380 = v380 + u15[v383];
        if v383 > 256 then
            v381 = v381 + 1;
            if v383 > 264 and v383 < 285 then
                v380 = v380 + u14[v383 - 256];
            end;
            local v384 = p379[v381];
            v380 = v380 + 5;
            if v384 > 3 then
                v380 = v380 + ((v384 - v384 % 2) / 2 - 1);
            end;
        end;
    end;
    return v380;
end;
local function u398(p386, p387, p388, p389, p390, p391) --[[ Line: 1664 ]]
    -- upvalues: u22 (ref), u15 (ref), u14 (copy), u16 (ref)
    p386(p387 and 1 or 0, 1);
    p386(1, 2);
    local v392 = 0;
    local v393 = 0;
    local v394 = 0;
    for v395 = 1, #p388 do
        local v396 = p388[v395];
        p386(u22[v396], u15[v396]);
        if v396 > 256 then
            v392 = v392 + 1;
            if v396 > 264 and v396 < 285 then
                v393 = v393 + 1;
                p386(p389[v393], u14[v396 - 256]);
            end;
            local v397 = p390[v392];
            p386(u16[v397], 5);
            if v397 > 3 then
                v394 = v394 + 1;
                p386(p391[v394], (v397 - v397 % 2) / 2 - 1);
            end;
        end;
    end;
end;
local function u408(p399, p400, p401, p402, p403, p404, p405) --[[ Line: 1721 ]]
    -- upvalues: u2 (copy)
    assert(p404 - p403 + 1 <= 65535);
    p399(p401 and 1 or 0, 1);
    p399(0, 2);
    local v406 = (8 - (p405 + 3) % 8) % 8;
    if v406 > 0 then
        p399(u2[v406] - 1, v406);
    end;
    local v407 = p404 - p403 + 1;
    p399(v407, 16);
    p399(255 - v407 % 256 + (255 - (v407 - v407 % 256) / 256) * 256, 16);
    p400(p402:sub(p403, p404));
end;
local function u460(p409, p410, p411, p412, p413, p414) --[[ Line: 1752 ]]
    -- upvalues: u246 (copy), u315 (copy), u334 (copy), u349 (copy), u385 (copy), u408 (copy), u398 (copy), u377 (copy)
    local v415 = {};
    local v416 = {};
    local v417 = nil;
    local v418 = 0;
    local v419 = 0;
    local v420, _ = p412(3);
    local v421 = #p413;
    local v422 = nil;
    local v423 = nil;
    if p409 then
        if p409.level then
            v422 = p409.level;
        end;
        if p409.strategy then
            v423 = p409.strategy;
        end;
    end;
    if not v422 then
        if v421 < 2048 then
            v422 = 7;
        elseif v421 > 65536 then
            v422 = 3;
        else
            v422 = 5;
        end;
    end;
    while not v417 do
        local v424;
        if v418 == 0 then
            v418 = 1;
            v424 = 0;
            v419 = 65535;
        else
            v418 = v419 + 1;
            v419 = v419 + 32768;
            v424 = v418 - 32768 - 1;
        end;
        if v421 <= v419 then
            v419 = v421;
            v417 = true;
        else
            v417 = false;
        end;
        local v425, v426, v427, v428, v429, v430, v431, v432, v433, v434, v435, v436, v437, v438, v439, v440, v441;
        if v422 == 0 then
            v425 = {};
            v426 = {};
            v427 = {};
            v428 = {};
            v429 = nil;
            v430 = {};
            v431 = {};
            v432 = {};
            v433 = {};
            v434 = {};
            v435 = {};
            v436 = nil;
            v437 = {};
            v438 = {};
            v439 = nil;
            v440 = nil;
            v441 = nil;
        else
            u246(p413, v415, v418, v419 + 3, v424);
            if v418 == 1 and p414 then
                local l__string_table__10 = p414.string_table;
                local l__strlen__11 = p414.strlen;
                for v442 = 0, -l__strlen__11 + 1 < -257 and -257 or -l__strlen__11 + 1, -1 do
                    v415[v442] = l__string_table__10[l__strlen__11 + v442];
                end;
            end;
            local v443, v444;
            if v423 == "huffman_only" then
                v432 = {};
                u246(p413, v432, v418, v419, v418 - 1);
                v432[v419 - v418 + 2] = 256;
                v443 = {};
                v435 = {};
                for v445 = 1, v419 - v418 + 2 do
                    local v446 = v432[v445];
                    v443[v446] = (v443[v446] or 0) + 1;
                end;
                v426 = {};
                v427 = {};
                v444 = {};
            else
                v432, v435, v443, v426, v427, v444 = u315(v422, v415, v416, v418, v419, v424, p414);
            end;
            v441, v440, v429, v434, v430, v431, v425, v438, v428, v433, v437 = u334(v443, v444);
            v436 = u349(v432, v426, v429, v434, v431, v438, v433);
            v439 = u385(v432, v426);
        end;
        assert(v419 - v418 + 1 <= 65535);
        local v447 = 3 + (8 - (v420 + 3) % 8) % 8 + 32 + (v419 - v418 + 1) * 8;
        local v448;
        if v439 and (v439 < v447 and v439) then
            v448 = v439;
        else
            v448 = v447;
        end;
        if v436 and (v436 < v448 and v436) then
            v448 = v436;
        end;
        if v422 == 0 or v423 ~= "fixed" and (v423 ~= "dynamic" and v447 == v448) then
            u408(p410, p411, v417, p413, v418, v419, v420);
            v420 = v420 + v447;
        elseif v423 == "dynamic" or v423 ~= "fixed" and v439 ~= v448 then
            if v423 == "dynamic" or v436 == v448 then
                u377(p410, v417, v432, v435, v426, v427, v441, v440, v429, v434, v430, v431, v425, v438, v428, v433, v437);
                v420 = v420 + assert(v436);
            end;
        else
            u398(p410, v417, v432, v435, v426, v427);
            v420 = v420 + assert(v439);
        end;
        local v449;
        if v417 then
            v449 = p412(3);
        else
            v449 = p412(0);
        end;
        assert(v449 == v420);
        if not v417 then
            if p414 and v418 == 1 then
                local v450 = 0;
                while v415[v450] do
                    v415[v450] = nil;
                    v450 = v450 - 1;
                end;
            end;
            local v451 = 1;
            p414 = nil;
            for v452 = v419 - 32767, v419 do
                v415[v451] = v415[v452 - v424];
                v451 = v451 + 1;
            end;
            for v453, v454 in pairs(v416) do
                local v455 = #v454;
                if v455 > 0 and v419 + 1 - v454[1] > 32768 then
                    if v455 == 1 then
                        v416[v453] = nil;
                    else
                        local v456 = 0;
                        local v457 = {};
                        for v458 = 2, v455 do
                            local v459 = v454[v458];
                            if v419 + 1 - v459 <= 32768 then
                                v456 = v456 + 1;
                                v457[v456] = v459;
                            end;
                        end;
                        v416[v453] = v457;
                    end;
                end;
            end;
        end;
    end;
end;
local function u469(p461, p462, p463) --[[ Line: 1966 ]]
    -- upvalues: u118 (copy), u460 (copy)
    local v464, v465, v466 = u118();
    u460(p463, v464, v465, v466, p461, p462);
    local v467, v468 = v466(1);
    assert(v468);
    return v468, (8 - v467 % 8) % 8;
end;
local function u491(p470, p471, p472) --[[ Line: 1977 ]]
    -- upvalues: u118 (copy), u460 (copy), u13 (copy)
    local v473, v474, v475 = u118();
    v473(120, 8);
    local v476 = p471 and 1 or 0;
    local v477 = 128 + v476 * 32;
    v473(v477 + (31 - (30720 + v477) % 31), 8);
    if v476 == 1 then
        assert(p471);
        local l__adler32__12 = p471.adler32;
        local v478 = l__adler32__12 % 256;
        local v479 = (l__adler32__12 - v478) / 256;
        local v480 = v479 % 256;
        local v481 = (v479 - v480) / 256;
        local v482 = v481 % 256;
        v473((v481 - v482) / 256 % 256, 8);
        v473(v482, 8);
        v473(v480, 8);
        v473(v478, 8);
    end;
    u460(p472, v473, v474, v475, p470, p471);
    v475(2);
    local v483 = u13:Adler32(p470);
    local v484 = v483 % 256;
    local v485 = (v483 - v484) / 256;
    local v486 = v485 % 256;
    local v487 = (v485 - v486) / 256;
    local v488 = v487 % 256;
    v473((v487 - v488) / 256 % 256, 8);
    v473(v488, 8);
    v473(v486, 8);
    v473(v484, 8);
    local v489, v490 = v475(1);
    assert(v490);
    return v490, (8 - v489 % 8) % 8;
end;
function u13.CompressDeflate(_, p492, p493) --[[ Line: 2048 ]]
    -- upvalues: u104 (copy), u469 (copy)
    local v494, v495 = u104(p492, false, nil, true, p493);
    if not v494 then
        error("Usage: LibDeflate:CompressDeflate(str, configs): " .. v495, 2);
    end;
    return u469(p492, nil, p493);
end;
function u13.CompressDeflateWithDict(_, p496, p497, p498) --[[ Line: 2072 ]]
    -- upvalues: u104 (copy), u469 (copy)
    local v499, v500 = u104(p496, true, p497, true, p498);
    if not v499 then
        error("Usage: LibDeflate:CompressDeflateWithDict" .. "(str, dictionary, configs): " .. v500, 2);
    end;
    return u469(p496, p497, p498);
end;
function u13.CompressZlib(_, p501, p502) --[[ Line: 2092 ]]
    -- upvalues: u104 (copy), u491 (copy)
    local v503, v504 = u104(p501, false, nil, true, p502);
    if not v503 then
        error("Usage: LibDeflate:CompressZlib(str, configs): " .. v504, 2);
    end;
    return u491(p501, nil, p502);
end;
function u13.CompressZlibWithDict(_, p505, p506, p507) --[[ Line: 2113 ]]
    -- upvalues: u104 (copy), u491 (copy)
    local v508, v509 = u104(p505, true, p506, true, p507);
    if not v508 then
        error("Usage: LibDeflate:CompressZlibWithDict" .. "(str, dictionary, configs): " .. v509, 2);
    end;
    return u491(p505, p506, p507);
end;
local function u551(u510) --[[ Line: 2142 ]]
    -- upvalues: u2 (copy), l__byte__1 (copy), l__char__2 (copy), l__sub__5 (copy), u3 (copy)
    local u511 = #u510;
    local u512 = 1;
    local u513 = 0;
    local u514 = 0;
    return function(p515) --[[ Name: ReadBits, Line 2155 ]]
        -- upvalues: u2 (ref), u513 (ref), u514 (ref), u510 (copy), u512 (ref), l__byte__1 (ref)
        local v516 = u2[p515];
        if p515 <= u513 then
            local v517 = u514 % v516;
            u514 = (u514 - v517) / v516;
            u513 = u513 - p515;
            return v517;
        end;
        local v518 = u2[u513];
        local v519, v520, v521, v522 = l__byte__1(u510, u512, u512 + 3);
        u514 = u514 + ((v519 or 0) + (v520 or 0) * 256 + (v521 or 0) * 65536 + (v522 or 0) * 16777216) * v518;
        u512 = u512 + 4;
        u513 = u513 + 32 - p515;
        local v523 = u514 % v516;
        u514 = (u514 - v523) / v516;
        return v523;
    end, function(p524, p525, p526) --[[ Name: ReadBytes, Line 2185 ]]
        -- upvalues: u513 (ref), u514 (ref), l__char__2 (ref), u511 (copy), u512 (ref), u510 (copy), l__sub__5 (ref)
        assert(u513 % 8 == 0);
        local v527;
        if u513 / 8 < p524 then
            v527 = u513 / 8 or p524;
        else
            v527 = p524;
        end;
        for _ = 1, v527 do
            local v528 = u514 % 256;
            p526 = p526 + 1;
            p525[p526] = l__char__2(v528);
            u514 = (u514 - v528) / 256;
        end;
        u513 = u513 - v527 * 8;
        local v529 = p524 - v527;
        if (u511 - u512 - v529 + 1) * 8 + u513 < 0 then
            return -1;
        end;
        for v530 = u512, u512 + v529 - 1 do
            p526 = p526 + 1;
            p525[p526] = l__sub__5(u510, v530, v530);
        end;
        u512 = u512 + v529;
        return p526;
    end, function(p531, p532, p533) --[[ Name: Decode, Line 2221 ]]
        -- upvalues: u513 (ref), u510 (copy), u2 (ref), u512 (ref), l__byte__1 (ref), u514 (ref), u3 (ref)
        local v534, v535, v536;
        if p533 > 0 then
            if u513 < 15 and u510 then
                local v537 = u2[u513];
                local v538, v539, v540, v541 = l__byte__1(u510, u512, u512 + 3);
                u514 = u514 + ((v538 or 0) + (v539 or 0) * 256 + (v540 or 0) * 65536 + (v541 or 0) * 16777216) * v537;
                u512 = u512 + 4;
                u513 = u513 + 32;
            end;
            local v542 = u2[p533];
            u513 = u513 - p533;
            local v543 = u514 % v542;
            u514 = (u514 - v543) / v542;
            local v544 = u3[p533][v543];
            v534 = p531[p533];
            if v544 < v534 then
                return p532[v544];
            end;
            v535 = v534 * 2;
            v536 = v544 * 2;
        else
            v536 = 0;
            v535 = 0;
            v534 = 0;
        end;
        for v545 = p533 + 1, 15 do
            local v546 = u514 % 2;
            u514 = (u514 - v546) / 2;
            u513 = u513 - 1;
            if v546 == 1 then
                v536 = v536 + 1 - v536 % 2 or v536;
            end;
            local v547 = p531[v545] or 0;
            local v548 = v536 - v535;
            if v548 < v547 then
                return p532[v534 + v548];
            end;
            v534 = v534 + v547;
            v535 = (v535 + v547) * 2;
            v536 = v536 * 2;
        end;
        return -10;
    end, function() --[[ Name: ReaderBitlenLeft, Line 2273 ]]
        -- upvalues: u511 (copy), u512 (ref), u513 (ref)
        return (u511 - u512 + 1) * 8 + u513;
    end, function() --[[ Name: SkipToByteBoundary, Line 2277 ]]
        -- upvalues: u513 (ref), u2 (ref), u514 (ref)
        local v549 = u513 % 8;
        local v550 = u2[v549];
        u513 = u513 - v549;
        u514 = (u514 - u514 % v550) / v550;
    end;
end;
local function u559(p552, p553) --[[ Line: 2292 ]]
    -- upvalues: u551 (copy)
    local v554, v555, v556, v557, v558 = u551(p552);
    return {
        buffer_size = 0,
        ReadBits = v554,
        ReadBytes = v555,
        Decode = v556,
        ReaderBitlenLeft = v557,
        SkipToByteBoundary = v558,
        buffer = {},
        result_buffer = {},
        dictionary = p553
    };
end;
local function u574(p560, p561, p562) --[[ Line: 2318 ]]
    local v563 = p562;
    local v564 = {};
    for v565 = 0, p561 do
        local v566 = p560[v565] or 0;
        if v566 > 0 and (v566 < p562 and v566) then
            p562 = v566;
        end;
        v564[v566] = (v564[v566] or 0) + 1;
    end;
    if v564[0] == p561 + 1 then
        return 0, v564, {}, 0;
    end;
    local v567 = 1;
    for v568 = 1, v563 do
        v567 = v567 * 2 - (v564[v568] or 0);
        if v567 < 0 then
            return v567, {}, {}, 0;
        end;
    end;
    local v569 = { 0 };
    for v570 = 1, v563 - 1 do
        v569[v570 + 1] = v569[v570] + (v564[v570] or 0);
    end;
    local v571 = {};
    for v572 = 0, p561 do
        local v573 = p560[v572] or 0;
        if v573 ~= 0 then
            v571[v569[v573]] = v572;
            v569[v573] = v569[v573] + 1;
        end;
    end;
    return v567, v564, v571, p562;
end;
local function u593(p575, p576, p577, p578, p579, p580, p581) --[[ Line: 2380 ]]
    -- upvalues: u1 (copy), u17 (copy), u14 (copy), u10 (copy), u11 (copy), l__concat__6 (copy)
    local l__buffer__13 = p575.buffer;
    local l__buffer_size__14 = p575.buffer_size;
    local l__ReadBits__15 = p575.ReadBits;
    local l__Decode__16 = p575.Decode;
    local l__ReaderBitlenLeft__17 = p575.ReaderBitlenLeft;
    local l__result_buffer__18 = p575.result_buffer;
    local l__dictionary__19 = p575.dictionary;
    local v582, v583, v584;
    if l__dictionary__19 and not l__buffer__13[0] then
        v582 = l__dictionary__19.string_table;
        v583 = l__dictionary__19.strlen;
        v584 = -v583 + 1;
        for v585 = 0, -v583 + 1 < -257 and -257 or -v583 + 1, -1 do
            l__buffer__13[v585] = u1[v582[v583 + v585]];
        end;
    else
        v584 = 1;
        v583 = nil;
        v582 = {};
    end;
    while true do
        local v586 = l__Decode__16(p576, p577, p578);
        if v586 < 0 or v586 > 285 then
            break;
        end;
        if v586 < 256 then
            l__buffer_size__14 = l__buffer_size__14 + 1;
            l__buffer__13[l__buffer_size__14] = u1[v586];
        elseif v586 > 256 then
            local v587 = v586 - 256;
            local v588 = u17[v587];
            if v587 >= 8 then
                v588 = v588 + l__ReadBits__15(u14[v587]) or v588;
            end;
            v586 = l__Decode__16(p579, p580, p581);
            if v586 < 0 or v586 > 29 then
                return -10;
            end;
            local v589 = u10[v586];
            if v589 > 4 then
                v589 = v589 + l__ReadBits__15(u11[v586]) or v589;
            end;
            local v590 = l__buffer_size__14 - v589 + 1;
            if v590 < v584 then
                return -11;
            end;
            if v590 >= -257 then
                for _ = 1, v588 do
                    l__buffer_size__14 = l__buffer_size__14 + 1;
                    l__buffer__13[l__buffer_size__14] = l__buffer__13[v590];
                    v590 = v590 + 1;
                end;
            else
                local v591 = v583 + v590;
                for _ = 1, v588 do
                    l__buffer_size__14 = l__buffer_size__14 + 1;
                    l__buffer__13[l__buffer_size__14] = u1[v582[v591]];
                    v591 = v591 + 1;
                end;
            end;
        end;
        if l__ReaderBitlenLeft__17() < 0 then
            return 2;
        end;
        if l__buffer_size__14 >= 65536 then
            l__result_buffer__18[#l__result_buffer__18 + 1] = l__concat__6(l__buffer__13, "", 1, 32768);
            for v592 = 32769, l__buffer_size__14 do
                l__buffer__13[v592 - 32768] = l__buffer__13[v592];
            end;
            l__buffer_size__14 = l__buffer_size__14 - 32768;
            l__buffer__13[l__buffer_size__14 + 1] = nil;
        end;
        if v586 == 256 then
            p575.buffer_size = l__buffer_size__14;
            return 0;
        end;
    end;
    return -10;
end;
local function u599(p594) --[[ Line: 2480 ]]
    -- upvalues: l__concat__6 (copy)
    local l__buffer__20 = p594.buffer;
    local l__buffer_size__21 = p594.buffer_size;
    local l__ReadBits__22 = p594.ReadBits;
    local l__ReadBytes__23 = p594.ReadBytes;
    local l__ReaderBitlenLeft__24 = p594.ReaderBitlenLeft;
    local l__SkipToByteBoundary__25 = p594.SkipToByteBoundary;
    local l__result_buffer__26 = p594.result_buffer;
    l__SkipToByteBoundary__25();
    local v595 = l__ReadBits__22(16);
    if l__ReaderBitlenLeft__24() < 0 then
        return 2;
    end;
    local v596 = l__ReadBits__22(16);
    if l__ReaderBitlenLeft__24() < 0 then
        return 2;
    end;
    if v595 % 256 + v596 % 256 ~= 255 then
        return -2;
    end;
    if (v595 - v595 % 256) / 256 + (v596 - v596 % 256) / 256 ~= 255 then
        return -2;
    end;
    local v597 = l__ReadBytes__23(v595, l__buffer__20, l__buffer_size__21);
    if v597 < 0 then
        return 2;
    end;
    if v597 >= 65536 then
        l__result_buffer__26[#l__result_buffer__26 + 1] = l__concat__6(l__buffer__20, "", 1, 32768);
        for v598 = 32769, v597 do
            l__buffer__20[v598 - 32768] = l__buffer__20[v598];
        end;
        v597 = v597 - 32768;
        l__buffer__20[v597 + 1] = nil;
    end;
    p594.buffer_size = v597;
    return 0;
end;
local function u624(p600) --[[ Line: 2536 ]]
    -- upvalues: u21 (copy), u574 (copy), u593 (copy)
    local l__ReadBits__27 = p600.ReadBits;
    local l__Decode__28 = p600.Decode;
    local v601 = l__ReadBits__27(5) + 257;
    local v602 = l__ReadBits__27(5) + 1;
    local v603 = l__ReadBits__27(4) + 4;
    if v601 > 286 or v602 > 30 then
        return -3;
    end;
    local v604 = {};
    for v605 = 1, v603 do
        v604[u21[v605]] = l__ReadBits__27(3);
    end;
    local v606, v607, v608, v609 = u574(v604, 18, 7);
    if v606 ~= 0 then
        return -4;
    end;
    local v610 = 0;
    local v611 = {};
    local v612 = {};
    while v610 < v601 + v602 do
        local v613 = l__Decode__28(v607, v608, v609);
        if v613 < 0 then
            return v613;
        end;
        if v613 < 16 then
            if v610 < v601 then
                v611[v610] = v613;
            else
                v612[v610 - v601] = v613;
            end;
            v610 = v610 + 1;
        else
            local v614 = 0;
            local v615;
            if v613 == 16 then
                if v610 == 0 then
                    return -5;
                end;
                if v610 - 1 < v601 then
                    v614 = v611[v610 - 1];
                else
                    v614 = v612[v610 - v601 - 1];
                end;
                v615 = 3 + l__ReadBits__27(2);
            elseif v613 == 17 then
                v615 = 3 + l__ReadBits__27(3);
            else
                v615 = 11 + l__ReadBits__27(7);
            end;
            if v610 + v615 > v601 + v602 then
                return -6;
            end;
            while v615 > 0 do
                v615 = v615 - 1;
                if v610 < v601 then
                    v611[v610] = v614;
                else
                    v612[v610 - v601] = v614;
                end;
                v610 = v610 + 1;
            end;
        end;
    end;
    if (v611[256] or 0) == 0 then
        return -9;
    end;
    local v616, v617, v618, v619 = u574(v611, v601 - 1, 15);
    if v616 ~= 0 and (v616 < 0 or v601 ~= (v617[0] or 0) + (v617[1] or 0)) then
        return -7;
    end;
    local v620, v621, v622, v623 = u574(v612, v602 - 1, 15);
    return v620 ~= 0 and (v620 < 0 or v602 ~= (v621[0] or 0) + (v621[1] or 0)) and -8 or u593(p600, v617, v618, v619, v621, v622, v623);
end;
local function u629(p625) --[[ Line: 2650 ]]
    -- upvalues: u599 (copy), u593 (copy), u18 (ref), u19 (ref), u20 (ref), u12 (ref), u624 (copy), l__concat__6 (copy)
    local l__ReadBits__29 = p625.ReadBits;
    local v626 = nil;
    while not v626 do
        v626 = l__ReadBits__29(1) == 1;
        local v627 = l__ReadBits__29(2);
        local v628;
        if v627 == 0 then
            v628 = u599(p625);
        elseif v627 == 1 then
            v628 = u593(p625, u18, u19, 7, u20, u12, 5);
        else
            if v627 ~= 2 then
                return nil, -1;
            end;
            v628 = u624(p625);
        end;
        if v628 ~= 0 then
            return nil, v628;
        end;
    end;
    p625.result_buffer[#p625.result_buffer + 1] = l__concat__6(p625.buffer, "", 1, p625.buffer_size);
    return l__concat__6(p625.result_buffer), 0;
end;
local function u636(p630, p631) --[[ Line: 2678 ]]
    -- upvalues: u559 (copy), u629 (copy)
    local v632 = u559(p630, p631);
    local v633, v634 = u629(v632);
    if not v633 then
        return nil, v634;
    end;
    local v635 = v632.ReaderBitlenLeft();
    return v633, (v635 - v635 % 8) / 8;
end;
local function u659(p637, p638) --[[ Line: 2690 ]]
    -- upvalues: u559 (copy), u629 (copy), u13 (copy)
    local v639 = u559(p637, p638);
    local l__ReadBits__30 = v639.ReadBits;
    local v640 = l__ReadBits__30(8);
    if v639.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;
    local v641 = v640 % 16;
    local v642 = (v640 - v641) / 16;
    if v641 ~= 8 then
        return nil, -12;
    end;
    if v642 > 7 then
        return nil, -13;
    end;
    local v643 = l__ReadBits__30(8);
    if v639.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;
    if (v640 * 256 + v643) % 31 ~= 0 then
        return nil, -14;
    end;
    local v644 = (v643 - v643 % 32) / 32 % 2;
    local _ = (v643 - v643 % 64) / 64 % 4;
    if v644 == 1 then
        if not p638 then
            return nil, -16;
        end;
        local v645 = l__ReadBits__30(8);
        local v646 = l__ReadBits__30(8);
        local v647 = l__ReadBits__30(8);
        local v648 = l__ReadBits__30(8);
        local v649 = v645 * 16777216 + v646 * 65536 + v647 * 256 + v648;
        if v639.ReaderBitlenLeft() < 0 then
            return nil, 2;
        end;
        if v649 % 4294967296 ~= p638.adler32 % 4294967296 then
            return nil, -17;
        end;
    end;
    local v650, v651 = u629(v639);
    if not v650 then
        return nil, v651;
    end;
    v639.SkipToByteBoundary();
    local v652 = l__ReadBits__30(8);
    local v653 = l__ReadBits__30(8);
    local v654 = l__ReadBits__30(8);
    local v655 = l__ReadBits__30(8);
    if v639.ReaderBitlenLeft() < 0 then
        return nil, 2;
    end;
    local v656 = v652 * 16777216 + v653 * 65536 + v654 * 256 + v655;
    local v657 = u13:Adler32(v650);
    if v656 % 4294967296 ~= v657 % 4294967296 then
        return nil, -15;
    end;
    local v658 = v639.ReaderBitlenLeft();
    return v650, (v658 - v658 % 8) / 8;
end;
function u13.DecompressDeflate(_, p660) --[[ Line: 2772 ]]
    -- upvalues: u636 (copy)
    local v661, v662;
    if type(p660) == "string" then
        v661 = true;
        v662 = "";
    else
        v662 = ("\'str\' - string expected got \'%s\'."):format((type(p660)));
        v661 = false;
    end;
    if not v661 then
        error("Usage: LibDeflate:DecompressDeflate(str): " .. v662, 2);
    end;
    return u636(p660);
end;
function u13.DecompressDeflateWithDict(_, p663, p664) --[[ Line: 2798 ]]
    -- upvalues: u92 (copy), u636 (copy)
    local v665, v666;
    if type(p663) == "string" then
        local v667;
        v667, v665 = u92(p664);
        if v667 then
            v666 = true;
            v665 = "";
        else
            v666 = false;
        end;
    else
        v665 = ("\'str\' - string expected got \'%s\'."):format((type(p663)));
        v666 = false;
    end;
    if not v666 then
        error("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): " .. v665, 2);
    end;
    return u636(p663, p664);
end;
function u13.DecompressZlib(_, p668) --[[ Line: 2820 ]]
    -- upvalues: u659 (copy)
    local v669, v670;
    if type(p668) == "string" then
        v669 = true;
        v670 = "";
    else
        v670 = ("\'str\' - string expected got \'%s\'."):format((type(p668)));
        v669 = false;
    end;
    if not v669 then
        error("Usage: LibDeflate:DecompressZlib(str): " .. v670, 2);
    end;
    return u659(p668);
end;
function u13.DecompressZlibWithDict(_, p671, p672) --[[ Line: 2846 ]]
    -- upvalues: u92 (copy), u659 (copy)
    local v673, v674;
    if type(p671) == "string" then
        local v675;
        v675, v673 = u92(p672);
        if v675 then
            v674 = true;
            v673 = "";
        else
            v674 = false;
        end;
    else
        v673 = ("\'str\' - string expected got \'%s\'."):format((type(p671)));
        v674 = false;
    end;
    if not v674 then
        error("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): " .. v673, 2);
    end;
    return u659(p671, p672);
end;
local v676 = {};
local v677 = v676;
for v678 = 0, 143 do
    v677[v678] = 8;
end;
for v679 = 144, 255 do
    v677[v679] = 9;
end;
v677[256] = 7;
v677[257] = 7;
v677[258] = 7;
v677[259] = 7;
v677[260] = 7;
v677[261] = 7;
v677[262] = 7;
v677[263] = 7;
v677[264] = 7;
v677[265] = 7;
v677[266] = 7;
v677[267] = 7;
v677[268] = 7;
v677[269] = 7;
v677[270] = 7;
v677[271] = 7;
v677[272] = 7;
v677[273] = 7;
v677[274] = 7;
v677[275] = 7;
v677[276] = 7;
v677[277] = 7;
v677[278] = 7;
v677[279] = 7;
v677[280] = 8;
v677[281] = 8;
v677[282] = 8;
v677[283] = 8;
v677[284] = 8;
v677[285] = 8;
v677[286] = 8;
v677[287] = 8;
local v680 = {};
for v681 = 0, 31 do
    v680[v681] = 5;
end;
local v682, v683, v684 = u574(v677, 287, 9);
local v685 = v683;
local _ = v684;
assert(v682 == 0);
local v686, v687, v688 = u574(v680, 31, 5);
local v689 = v687;
local _ = v688;
assert(v686 == 0);
local _ = u155(v685, v677, 287, 9);
local _ = u155(v689, v680, 31, 5);
local u690 = {
    ["\0"] = "%z",
    ["("] = "%(",
    [")"] = "%)",
    ["."] = "%.",
    ["%"] = "%%",
    ["+"] = "%+",
    ["-"] = "%-",
    ["*"] = "%*",
    ["?"] = "%?",
    ["["] = "%[",
    ["]"] = "%]",
    ["^"] = "%^",
    ["$"] = "%$"
};
function u13.CreateCodec(_, p691, p692, p693) --[[ Line: 2952 ]]
    -- upvalues: l__byte__1 (copy), l__sub__5 (copy), l__concat__6 (copy), u690 (copy), u1 (copy), l__gsub__4 (copy), l__find__3 (copy)
    if type(p691) ~= "string" or (type(p692) ~= "string" or type(p693) ~= "string") then
        error("Usage: LibDeflate:CreateCodec(reserved_chars, escape_chars, map_chars): All arguments must be string.", 2);
    end;
    if p692 == "" then
        return nil, "No escape characters supplied.";
    end;
    if #p691 < #p693 then
        return nil, "The number of reserved characters must be at least as many as the number of mapped chars.";
    end;
    if p691 == "" then
        return nil, "No characters to encode.";
    end;
    local v694 = p691 .. p692 .. p693;
    local v695 = {};
    for v696 = 1, #v694 do
        local v697 = l__byte__1(v694, v696, v696);
        if v695[v697] then
            return nil, "There must be no duplicate characters in the concatenation of reserved_chars, escape_chars and map_chars.";
        end;
        v695[v697] = true;
    end;
    local u698 = {};
    local u699 = {};
    local v700 = {};
    local u701 = {};
    if #p693 > 0 then
        local v702 = {};
        local v703 = {};
        for v704 = 1, #p693 do
            local v705 = l__sub__5(p691, v704, v704);
            local v706 = l__sub__5(p693, v704, v704);
            u701[v705] = v706;
            v700[#v700 + 1] = v705;
            v702[v706] = v705;
            v703[#v703 + 1] = v706;
        end;
        local v707 = #u698 + 1;
        local v708, _ = l__concat__6(v703):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u690);
        u698[v707] = "([" .. v708 .. "])";
        u699[#u699 + 1] = v702;
    end;
    local v709 = 1;
    local v710 = l__sub__5(p692, v709, v709);
    local v711 = 0;
    local v712 = {};
    local v713 = {};
    for v714 = 1, #v694 do
        local v715 = l__sub__5(v694, v714, v714);
        if not u701[v715] then
            while v711 >= 256 or v695[v711] do
                v711 = v711 + 1;
                if v711 > 255 then
                    local v716 = #u698 + 1;
                    local v717, _ = v710:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u690);
                    local v718, _ = l__concat__6(v712):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u690);
                    u698[v716] = v717 .. "([" .. v718 .. "])";
                    u699[#u699 + 1] = v713;
                    v709 = v709 + 1;
                    v710 = l__sub__5(p692, v709, v709);
                    if not v710 or v710 == "" then
                        return nil, "Out of escape characters.";
                    end;
                    v711 = 0;
                    v712 = {};
                    v713 = {};
                end;
            end;
            local v719 = u1[v711];
            u701[v715] = v710 .. v719;
            v700[#v700 + 1] = v715;
            v713[v719] = v715;
            v712[#v712 + 1] = v719;
            v711 = v711 + 1;
        end;
        if v714 == #v694 then
            local v720 = #u698 + 1;
            local v721, _ = v710:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u690);
            local v722, _ = l__concat__6(v712):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u690);
            u698[v720] = v721 .. "([" .. v722 .. "])";
            u699[#u699 + 1] = v713;
        end;
    end;
    local v723 = {};
    local v724, _ = l__concat__6(v700):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u690);
    local u725 = "([" .. v724 .. "])";
    function v723.Encode(_, p726) --[[ Line: 3065 ]]
        -- upvalues: l__gsub__4 (ref), u725 (copy), u701 (copy)
        if type(p726) ~= "string" then
            error(("Usage: codec:Encode(str): \'str\' - string expected got \'%s\'."):format((type(p726))), 2);
        end;
        local v727, _ = l__gsub__4(p726, u725, u701);
        return v727;
    end;
    local u728 = #u698;
    local v729, _ = p691:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u690);
    local u730 = "([" .. v729 .. "])";
    function v723.Decode(_, p731) --[[ Line: 3078 ]]
        -- upvalues: l__find__3 (ref), u730 (copy), u728 (copy), l__gsub__4 (ref), u698 (copy), u699 (copy)
        if type(p731) ~= "string" then
            error(("Usage: codec:Decode(str): \'str\' - string expected got \'%s\'."):format((type(p731))), 2);
        end;
        if l__find__3(p731, u730) then
            return nil;
        end;
        for v732 = 1, u728 do
            p731 = l__gsub__4(p731, u698[v732], u699[v732]);
        end;
        return p731;
    end;
    return v723, "";
end;
u13.internals = {
    LoadStringToTable = u246,
    IsValidDictionary = u92,
    IsEqualAdler32 = v66
};
return table.freeze(u13);