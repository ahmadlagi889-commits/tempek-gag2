-- Decompiled with Potassium's decompiler.

local l__bxor__1 = bit32.bxor;
local l__rrotate__2 = bit32.rrotate;
local l__copy__3 = buffer.copy;
local l__create__4 = buffer.create;
local l__fromstring__5 = buffer.fromstring;
local l__len__6 = buffer.len;
local l__readu8__7 = buffer.readu8;
local l__readu16__8 = buffer.readu16;
local l__readu32__9 = buffer.readu32;
local l__tostring__10 = buffer.tostring;
local l__writestring__11 = buffer.writestring;
local l__writeu8__12 = buffer.writeu8;
local l__writeu16__13 = buffer.writeu16;
local l__writeu32__14 = buffer.writeu32;
local l__floor__15 = math.floor;
local l__sub__16 = string.sub;
local u1 = l__create__4(131072);
local u2 = l__create__4(65536);
local u3 = l__create__4(65536);
local u4 = l__create__4(65536);
local u5 = l__create__4(65536);
local u6 = l__create__4(65536);
local v7 = l__create__4(256);
local v8 = l__create__4(256);
local v9 = l__create__4(256);
local v10 = l__create__4(256);
local v11 = l__create__4(256);
l__writeu8__12(v7, 0, 99);
local v12 = 1;
local function v16(p13, p14) --[[ Line: 409 ]]
    -- upvalues: l__bxor__1 (copy), l__floor__15 (copy)
    local v15 = 0;
    for _ = 0, 7 do
        if p14 % 2 == 1 then
            v15 = l__bxor__1(v15, p13);
        end;
        if p13 >= 128 then
            p13 = l__bxor__1(p13 * 2 % 256, 27);
        else
            p13 = p13 * 2 % 256;
        end;
        p14 = l__floor__15(p14 / 2);
    end;
    return v15;
end;
local v17 = 1;
local function u54(p18, p19, p20, p21) --[[ Line: 158 ]]
    -- upvalues: l__copy__3 (copy), l__writestring__11 (copy), l__readu32__9 (copy), l__rrotate__2 (copy), u1 (copy), l__floor__15 (copy), l__readu16__8 (copy), l__bxor__1 (copy), l__writeu32__14 (copy)
    if p21 then
        l__copy__3(p20, 0, p18, 0, p19);
    else
        l__writestring__11(p20, 0, p18, p19);
    end;
    local v22 = l__rrotate__2(l__readu32__9(p20, p19 - 4), 8);
    local v23 = 0.5;
    if p19 == 32 then
        for v24 = 32, 192, 32 do
            v23 = v23 * 2 % 229;
            local v25 = l__bxor__1(l__readu32__9(p20, v24 - 32), l__readu16__8(u1, l__floor__15(v22 / 65536) * 2) * 65536 + l__readu16__8(u1, v22 % 65536 * 2), v23);
            l__writeu32__14(p20, v24, v25);
            local v26 = l__bxor__1(l__readu32__9(p20, v24 - 28), v25);
            l__writeu32__14(p20, v24 + 4, v26);
            local v27 = l__bxor__1(l__readu32__9(p20, v24 - 24), v26);
            l__writeu32__14(p20, v24 + 8, v27);
            local v28 = l__bxor__1(l__readu32__9(p20, v24 - 20), v27);
            l__writeu32__14(p20, v24 + 12, v28);
            local v29 = l__bxor__1(l__readu32__9(p20, v24 - 16), l__readu16__8(u1, l__floor__15(v28 / 65536) * 2) * 65536 + l__readu16__8(u1, v28 % 65536 * 2));
            l__writeu32__14(p20, v24 + 16, v29);
            local v30 = l__bxor__1(l__readu32__9(p20, v24 - 12), v29);
            l__writeu32__14(p20, v24 + 20, v30);
            local v31 = l__bxor__1(l__readu32__9(p20, v24 - 8), v30);
            l__writeu32__14(p20, v24 + 24, v31);
            local v32 = l__bxor__1(l__readu32__9(p20, v24 - 4), v31);
            l__writeu32__14(p20, v24 + 28, v32);
            v22 = l__rrotate__2(v32, 8);
        end;
        local v33 = l__bxor__1(l__readu32__9(p20, 192), l__readu16__8(u1, l__floor__15(v22 / 65536) * 2) * 65536 + l__readu16__8(u1, v22 % 65536 * 2), 64);
        l__writeu32__14(p20, 224, v33);
        local v34 = l__bxor__1(l__readu32__9(p20, 196), v33);
        l__writeu32__14(p20, 228, v34);
        local v35 = l__bxor__1(l__readu32__9(p20, 200), v34);
        l__writeu32__14(p20, 232, v35);
        l__writeu32__14(p20, 236, (l__bxor__1(l__readu32__9(p20, 204), v35)));
        return p20;
    elseif p19 == 24 then
        for v36 = 24, 168, 24 do
            v23 = v23 * 2 % 229;
            local v37 = l__bxor__1(l__readu32__9(p20, v36 - 24), l__readu16__8(u1, l__floor__15(v22 / 65536) * 2) * 65536 + l__readu16__8(u1, v22 % 65536 * 2), v23);
            l__writeu32__14(p20, v36, v37);
            local v38 = l__bxor__1(l__readu32__9(p20, v36 - 20), v37);
            l__writeu32__14(p20, v36 + 4, v38);
            local v39 = l__bxor__1(l__readu32__9(p20, v36 - 16), v38);
            l__writeu32__14(p20, v36 + 8, v39);
            local v40 = l__bxor__1(l__readu32__9(p20, v36 - 12), v39);
            l__writeu32__14(p20, v36 + 12, v40);
            local v41 = l__bxor__1(l__readu32__9(p20, v36 - 8), v40);
            l__writeu32__14(p20, v36 + 16, v41);
            local v42 = l__bxor__1(l__readu32__9(p20, v36 - 4), v41);
            l__writeu32__14(p20, v36 + 20, v42);
            v22 = l__rrotate__2(v42, 8);
        end;
        local v43 = l__bxor__1(l__readu32__9(p20, 168), l__readu16__8(u1, l__floor__15(v22 / 65536) * 2) * 65536 + l__readu16__8(u1, v22 % 65536 * 2), 128);
        l__writeu32__14(p20, 192, v43);
        local v44 = l__bxor__1(l__readu32__9(p20, 172), v43);
        l__writeu32__14(p20, 196, v44);
        local v45 = l__bxor__1(l__readu32__9(p20, 176), v44);
        l__writeu32__14(p20, 200, v45);
        l__writeu32__14(p20, 204, (l__bxor__1(l__readu32__9(p20, 180), v45)));
        return p20;
    else
        for v46 = 16, 144, 16 do
            v23 = v23 * 2 % 229;
            local v47 = l__bxor__1(l__readu32__9(p20, v46 - 16), l__readu16__8(u1, l__floor__15(v22 / 65536) * 2) * 65536 + l__readu16__8(u1, v22 % 65536 * 2), v23);
            l__writeu32__14(p20, v46, v47);
            local v48 = l__bxor__1(l__readu32__9(p20, v46 - 12), v47);
            l__writeu32__14(p20, v46 + 4, v48);
            local v49 = l__bxor__1(l__readu32__9(p20, v46 - 8), v48);
            l__writeu32__14(p20, v46 + 8, v49);
            local v50 = l__bxor__1(l__readu32__9(p20, v46 - 4), v49);
            l__writeu32__14(p20, v46 + 12, v50);
            v22 = l__rrotate__2(v50, 8);
        end;
        local v51 = l__bxor__1(l__readu32__9(p20, 144), l__readu16__8(u1, l__floor__15(v22 / 65536) * 2) * 65536 + l__readu16__8(u1, v22 % 65536 * 2), 54);
        l__writeu32__14(p20, 160, v51);
        local v52 = l__bxor__1(l__readu32__9(p20, 148), v51);
        l__writeu32__14(p20, 164, v52);
        local v53 = l__bxor__1(l__readu32__9(p20, 152), v52);
        l__writeu32__14(p20, 168, v53);
        l__writeu32__14(p20, 172, (l__bxor__1(l__readu32__9(p20, 156), v53)));
        return p20;
    end;
end;
local function u110(p55, p56, p57, p58, p59, p60) --[[ Line: 259 ]]
    -- upvalues: l__readu8__7 (copy), l__bxor__1 (copy), u2 (copy), u3 (copy), u1 (copy), l__readu16__8 (copy), l__readu32__9 (copy), l__writeu32__14 (copy)
    local v61 = l__bxor__1(l__readu8__7(p57, p58), (l__readu8__7(p55, 0)));
    local v62 = l__bxor__1(l__readu8__7(p57, p58 + 1), (l__readu8__7(p55, 1)));
    local v63 = l__bxor__1(l__readu8__7(p57, p58 + 2), (l__readu8__7(p55, 2)));
    local v64 = l__bxor__1(l__readu8__7(p57, p58 + 3), (l__readu8__7(p55, 3)));
    local v65 = l__bxor__1(l__readu8__7(p57, p58 + 4), (l__readu8__7(p55, 4)));
    local v66 = l__bxor__1(l__readu8__7(p57, p58 + 5), (l__readu8__7(p55, 5)));
    local v67 = l__bxor__1(l__readu8__7(p57, p58 + 6), (l__readu8__7(p55, 6)));
    local v68 = l__bxor__1(l__readu8__7(p57, p58 + 7), (l__readu8__7(p55, 7)));
    local v69 = l__bxor__1(l__readu8__7(p57, p58 + 8), (l__readu8__7(p55, 8)));
    local v70 = l__bxor__1(l__readu8__7(p57, p58 + 9), (l__readu8__7(p55, 9)));
    local v71 = l__bxor__1(l__readu8__7(p57, p58 + 10), (l__readu8__7(p55, 10)));
    local v72 = l__bxor__1(l__readu8__7(p57, p58 + 11), (l__readu8__7(p55, 11)));
    local v73 = l__bxor__1(l__readu8__7(p57, p58 + 12), (l__readu8__7(p55, 12)));
    local v74 = l__bxor__1(l__readu8__7(p57, p58 + 13), (l__readu8__7(p55, 13)));
    local v75 = l__bxor__1(l__readu8__7(p57, p58 + 14), (l__readu8__7(p55, 14)));
    local v76 = l__bxor__1(l__readu8__7(p57, p58 + 15), (l__readu8__7(p55, 15)));
    local v77 = v61 * 256 + v66;
    local v78 = v66 * 256 + v71;
    local v79 = v71 * 256 + v76;
    local v80 = v76 * 256 + v61;
    local v81 = v65 * 256 + v70;
    local v82 = v70 * 256 + v75;
    local v83 = v75 * 256 + v64;
    local v84 = v64 * 256 + v65;
    local v85 = v69 * 256 + v74;
    local v86 = v74 * 256 + v63;
    local v87 = v63 * 256 + v68;
    local v88 = v68 * 256 + v69;
    local v89 = v73 * 256 + v62;
    local v90 = v62 * 256 + v67;
    local v91 = v67 * 256 + v72;
    local v92 = v72 * 256 + v73;
    for v93 = 16, p56, 16 do
        local v94 = l__bxor__1(l__readu8__7(u2, v77), l__readu8__7(u3, v79), (l__readu8__7(p55, v93)));
        local v95 = l__bxor__1(l__readu8__7(u2, v78), l__readu8__7(u3, v80), (l__readu8__7(p55, v93 + 1)));
        local v96 = l__bxor__1(l__readu8__7(u2, v79), l__readu8__7(u3, v77), (l__readu8__7(p55, v93 + 2)));
        local v97 = l__bxor__1(l__readu8__7(u2, v80), l__readu8__7(u3, v78), (l__readu8__7(p55, v93 + 3)));
        local v98 = l__bxor__1(l__readu8__7(u2, v81), l__readu8__7(u3, v83), (l__readu8__7(p55, v93 + 4)));
        local v99 = l__bxor__1(l__readu8__7(u2, v82), l__readu8__7(u3, v84), (l__readu8__7(p55, v93 + 5)));
        local v100 = l__bxor__1(l__readu8__7(u2, v83), l__readu8__7(u3, v81), (l__readu8__7(p55, v93 + 6)));
        local v101 = l__bxor__1(l__readu8__7(u2, v84), l__readu8__7(u3, v82), (l__readu8__7(p55, v93 + 7)));
        local v102 = l__bxor__1(l__readu8__7(u2, v85), l__readu8__7(u3, v87), (l__readu8__7(p55, v93 + 8)));
        local v103 = l__bxor__1(l__readu8__7(u2, v86), l__readu8__7(u3, v88), (l__readu8__7(p55, v93 + 9)));
        local v104 = l__bxor__1(l__readu8__7(u2, v87), l__readu8__7(u3, v85), (l__readu8__7(p55, v93 + 10)));
        local v105 = l__bxor__1(l__readu8__7(u2, v88), l__readu8__7(u3, v86), (l__readu8__7(p55, v93 + 11)));
        local v106 = l__bxor__1(l__readu8__7(u2, v89), l__readu8__7(u3, v91), (l__readu8__7(p55, v93 + 12)));
        local v107 = l__bxor__1(l__readu8__7(u2, v90), l__readu8__7(u3, v92), (l__readu8__7(p55, v93 + 13)));
        local v108 = l__bxor__1(l__readu8__7(u2, v91), l__readu8__7(u3, v89), (l__readu8__7(p55, v93 + 14)));
        local v109 = l__bxor__1(l__readu8__7(u2, v92), l__readu8__7(u3, v90), (l__readu8__7(p55, v93 + 15)));
        v77 = v94 * 256 + v99;
        v78 = v99 * 256 + v104;
        v79 = v104 * 256 + v109;
        v80 = v109 * 256 + v94;
        v81 = v98 * 256 + v103;
        v82 = v103 * 256 + v108;
        v83 = v108 * 256 + v97;
        v84 = v97 * 256 + v98;
        v85 = v102 * 256 + v107;
        v86 = v107 * 256 + v96;
        v87 = v96 * 256 + v101;
        v88 = v101 * 256 + v102;
        v89 = v106 * 256 + v95;
        v90 = v95 * 256 + v100;
        v91 = v100 * 256 + v105;
        v92 = v105 * 256 + v106;
    end;
    l__writeu32__14(p59, p60, (l__bxor__1(l__readu16__8(u1, l__bxor__1(l__readu8__7(u2, v92), l__readu8__7(u3, v90), (l__readu8__7(p55, p56 + 31))) * 512 + l__bxor__1(l__readu8__7(u2, v87), l__readu8__7(u3, v85), (l__readu8__7(p55, p56 + 26))) * 2) * 65536 + l__readu16__8(u1, l__bxor__1(l__readu8__7(u2, v82), l__readu8__7(u3, v84), (l__readu8__7(p55, p56 + 21))) * 512 + l__bxor__1(l__readu8__7(u2, v77), l__readu8__7(u3, v79), (l__readu8__7(p55, p56 + 16))) * 2), (l__readu32__9(p55, p56 + 32)))));
    l__writeu32__14(p59, p60 + 4, (l__bxor__1(l__readu16__8(u1, l__bxor__1(l__readu8__7(u2, v80), l__readu8__7(u3, v78), (l__readu8__7(p55, p56 + 19))) * 512 + l__bxor__1(l__readu8__7(u2, v91), l__readu8__7(u3, v89), (l__readu8__7(p55, p56 + 30))) * 2) * 65536 + l__readu16__8(u1, l__bxor__1(l__readu8__7(u2, v86), l__readu8__7(u3, v88), (l__readu8__7(p55, p56 + 25))) * 512 + l__bxor__1(l__readu8__7(u2, v81), l__readu8__7(u3, v83), (l__readu8__7(p55, p56 + 20))) * 2), (l__readu32__9(p55, p56 + 36)))));
    l__writeu32__14(p59, p60 + 8, (l__bxor__1(l__readu16__8(u1, l__bxor__1(l__readu8__7(u2, v84), l__readu8__7(u3, v82), (l__readu8__7(p55, p56 + 23))) * 512 + l__bxor__1(l__readu8__7(u2, v79), l__readu8__7(u3, v77), (l__readu8__7(p55, p56 + 18))) * 2) * 65536 + l__readu16__8(u1, l__bxor__1(l__readu8__7(u2, v90), l__readu8__7(u3, v92), (l__readu8__7(p55, p56 + 29))) * 512 + l__bxor__1(l__readu8__7(u2, v85), l__readu8__7(u3, v87), (l__readu8__7(p55, p56 + 24))) * 2), (l__readu32__9(p55, p56 + 40)))));
    l__writeu32__14(p59, p60 + 12, (l__bxor__1(l__readu16__8(u1, l__bxor__1(l__readu8__7(u2, v88), l__readu8__7(u3, v86), (l__readu8__7(p55, p56 + 27))) * 512 + l__bxor__1(l__readu8__7(u2, v83), l__readu8__7(u3, v81), (l__readu8__7(p55, p56 + 22))) * 2) * 65536 + l__readu16__8(u1, l__bxor__1(l__readu8__7(u2, v78), l__readu8__7(u3, v80), (l__readu8__7(p55, p56 + 17))) * 512 + l__bxor__1(l__readu8__7(u2, v89), l__readu8__7(u3, v91), (l__readu8__7(p55, p56 + 28))) * 2), (l__readu32__9(p55, p56 + 44)))));
end;
local function u166(p111, p112, p113, p114, p115, p116) --[[ Line: 326 ]]
    -- upvalues: u4 (copy), l__readu8__7 (copy), l__bxor__1 (copy), u5 (copy), u6 (copy), l__writeu32__14 (copy)
    local v117 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114) * 256 + l__readu8__7(p111, p112 + 32)), (l__readu8__7(p111, p112 + 16)));
    local v118 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 13) * 256 + l__readu8__7(p111, p112 + 45)), (l__readu8__7(p111, p112 + 17)));
    local v119 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 10) * 256 + l__readu8__7(p111, p112 + 42)), (l__readu8__7(p111, p112 + 18)));
    local v120 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 7) * 256 + l__readu8__7(p111, p112 + 39)), (l__readu8__7(p111, p112 + 19)));
    local v121 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 4) * 256 + l__readu8__7(p111, p112 + 36)), (l__readu8__7(p111, p112 + 20)));
    local v122 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 1) * 256 + l__readu8__7(p111, p112 + 33)), (l__readu8__7(p111, p112 + 21)));
    local v123 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 14) * 256 + l__readu8__7(p111, p112 + 46)), (l__readu8__7(p111, p112 + 22)));
    local v124 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 11) * 256 + l__readu8__7(p111, p112 + 43)), (l__readu8__7(p111, p112 + 23)));
    local v125 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 8) * 256 + l__readu8__7(p111, p112 + 40)), (l__readu8__7(p111, p112 + 24)));
    local v126 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 5) * 256 + l__readu8__7(p111, p112 + 37)), (l__readu8__7(p111, p112 + 25)));
    local v127 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 2) * 256 + l__readu8__7(p111, p112 + 34)), (l__readu8__7(p111, p112 + 26)));
    local v128 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 15) * 256 + l__readu8__7(p111, p112 + 47)), (l__readu8__7(p111, p112 + 27)));
    local v129 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 12) * 256 + l__readu8__7(p111, p112 + 44)), (l__readu8__7(p111, p112 + 28)));
    local v130 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 9) * 256 + l__readu8__7(p111, p112 + 41)), (l__readu8__7(p111, p112 + 29)));
    local v131 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 6) * 256 + l__readu8__7(p111, p112 + 38)), (l__readu8__7(p111, p112 + 30)));
    local v132 = l__bxor__1(l__readu8__7(u4, l__readu8__7(p113, p114 + 3) * 256 + l__readu8__7(p111, p112 + 35)), (l__readu8__7(p111, p112 + 31)));
    local v133 = v117 * 256 + v118;
    local v134 = v118 * 256 + v119;
    local v135 = v119 * 256 + v120;
    local v136 = v120 * 256 + v117;
    local v137 = v121 * 256 + v122;
    local v138 = v122 * 256 + v123;
    local v139 = v123 * 256 + v124;
    local v140 = v124 * 256 + v121;
    local v141 = v125 * 256 + v126;
    local v142 = v126 * 256 + v127;
    local v143 = v127 * 256 + v128;
    local v144 = v128 * 256 + v125;
    local v145 = v129 * 256 + v130;
    local v146 = v130 * 256 + v131;
    local v147 = v131 * 256 + v132;
    local v148 = v132 * 256 + v129;
    for v149 = p112, 16, -16 do
        local v150 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v133) * 256 + l__readu8__7(u6, v135)), (l__readu8__7(p111, v149)));
        local v151 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v146) * 256 + l__readu8__7(u6, v148)), (l__readu8__7(p111, v149 + 1)));
        local v152 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v143) * 256 + l__readu8__7(u6, v141)), (l__readu8__7(p111, v149 + 2)));
        local v153 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v140) * 256 + l__readu8__7(u6, v138)), (l__readu8__7(p111, v149 + 3)));
        local v154 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v137) * 256 + l__readu8__7(u6, v139)), (l__readu8__7(p111, v149 + 4)));
        local v155 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v134) * 256 + l__readu8__7(u6, v136)), (l__readu8__7(p111, v149 + 5)));
        local v156 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v147) * 256 + l__readu8__7(u6, v145)), (l__readu8__7(p111, v149 + 6)));
        local v157 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v144) * 256 + l__readu8__7(u6, v142)), (l__readu8__7(p111, v149 + 7)));
        local v158 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v141) * 256 + l__readu8__7(u6, v143)), (l__readu8__7(p111, v149 + 8)));
        local v159 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v138) * 256 + l__readu8__7(u6, v140)), (l__readu8__7(p111, v149 + 9)));
        local v160 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v135) * 256 + l__readu8__7(u6, v133)), (l__readu8__7(p111, v149 + 10)));
        local v161 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v148) * 256 + l__readu8__7(u6, v146)), (l__readu8__7(p111, v149 + 11)));
        local v162 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v145) * 256 + l__readu8__7(u6, v147)), (l__readu8__7(p111, v149 + 12)));
        local v163 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v142) * 256 + l__readu8__7(u6, v144)), (l__readu8__7(p111, v149 + 13)));
        local v164 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v139) * 256 + l__readu8__7(u6, v137)), (l__readu8__7(p111, v149 + 14)));
        local v165 = l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v136) * 256 + l__readu8__7(u6, v134)), (l__readu8__7(p111, v149 + 15)));
        v133 = v150 * 256 + v151;
        v134 = v151 * 256 + v152;
        v135 = v152 * 256 + v153;
        v136 = v153 * 256 + v150;
        v137 = v154 * 256 + v155;
        v138 = v155 * 256 + v156;
        v139 = v156 * 256 + v157;
        v140 = v157 * 256 + v154;
        v141 = v158 * 256 + v159;
        v142 = v159 * 256 + v160;
        v143 = v160 * 256 + v161;
        v144 = v161 * 256 + v158;
        v145 = v162 * 256 + v163;
        v146 = v163 * 256 + v164;
        v147 = v164 * 256 + v165;
        v148 = v165 * 256 + v162;
    end;
    l__writeu32__14(p115, p116, l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v140) * 256 + l__readu8__7(u6, v138)), (l__readu8__7(p111, 3))) * 16777216 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v143) * 256 + l__readu8__7(u6, v141)), (l__readu8__7(p111, 2))) * 65536 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v146) * 256 + l__readu8__7(u6, v148)), (l__readu8__7(p111, 1))) * 256 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v133) * 256 + l__readu8__7(u6, v135)), (l__readu8__7(p111, 0))));
    l__writeu32__14(p115, p116 + 4, l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v144) * 256 + l__readu8__7(u6, v142)), (l__readu8__7(p111, 7))) * 16777216 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v147) * 256 + l__readu8__7(u6, v145)), (l__readu8__7(p111, 6))) * 65536 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v134) * 256 + l__readu8__7(u6, v136)), (l__readu8__7(p111, 5))) * 256 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v137) * 256 + l__readu8__7(u6, v139)), (l__readu8__7(p111, 4))));
    l__writeu32__14(p115, p116 + 8, l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v148) * 256 + l__readu8__7(u6, v146)), (l__readu8__7(p111, 11))) * 16777216 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v135) * 256 + l__readu8__7(u6, v133)), (l__readu8__7(p111, 10))) * 65536 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v138) * 256 + l__readu8__7(u6, v140)), (l__readu8__7(p111, 9))) * 256 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v141) * 256 + l__readu8__7(u6, v143)), (l__readu8__7(p111, 8))));
    l__writeu32__14(p115, p116 + 12, l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v136) * 256 + l__readu8__7(u6, v134)), (l__readu8__7(p111, 15))) * 16777216 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v139) * 256 + l__readu8__7(u6, v137)), (l__readu8__7(p111, 14))) * 65536 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v142) * 256 + l__readu8__7(u6, v144)), (l__readu8__7(p111, 13))) * 256 + l__bxor__1(l__readu8__7(u4, l__readu8__7(u5, v145) * 256 + l__readu8__7(u6, v147)), (l__readu8__7(p111, 12))));
end;
for _ = 1, 255 do
    v12 = l__bxor__1(v12, v12 * 2, v12 < 128 and 0 or 27) % 256;
    local v167 = l__bxor__1(v17, v17 * 2);
    local v168 = l__bxor__1(v167, v167 * 4);
    v17 = l__bxor__1(v168, v168 * 16) % 256;
    if v17 >= 128 then
        v17 = l__bxor__1(v17, 9);
    end;
    local v169 = l__bxor__1(v17, v17 % 128 * 2 + v17 / 128, v17 % 64 * 4 + v17 / 64, v17 % 32 * 8 + v17 / 32, v17 % 16 * 16 + v17 / 16, 99);
    l__writeu8__12(v7, v12, v169);
    l__writeu8__12(v8, v169, v12);
    l__writeu8__12(v9, v12, (v16(3, v12)));
    l__writeu8__12(v10, v12, (v16(9, v12)));
    l__writeu8__12(v11, v12, (v16(11, v12)));
end;
local v170 = 0;
for v171 = 0, 255 do
    local v172 = l__readu8__7(v7, v171);
    local v173 = v172 * 256;
    local v174 = v16(2, v172);
    local v175 = v16(13, v171);
    local v176 = v16(14, v171);
    for v177 = 0, 255 do
        local v178 = l__readu8__7(v7, v177);
        l__writeu16__13(u1, v170 * 2, v173 + v178);
        l__writeu8__12(u4, v170, (l__readu8__7(v8, (l__bxor__1(v171, v177)))));
        l__writeu8__12(u2, v170, (l__bxor__1(v174, (l__readu8__7(v9, v178)))));
        l__writeu8__12(u3, v170, (l__bxor__1(v172, v178)));
        l__writeu8__12(u5, v170, (l__bxor__1(v176, (l__readu8__7(v11, v177)))));
        l__writeu8__12(u6, v170, (l__bxor__1(v175, (l__readu8__7(v10, v177)))));
        v170 = v170 + 1;
    end;
end;
local function u180(_, p179) --[[ Line: 481 ]]
    return error((`{p179} cannot be assigned to`));
end;
local function u181() --[[ Line: 484 ]]
    return "AesCipher";
end;
local l__Modes__17 = require(script.Modes);
local l__Pads__18 = require(script.Pads);
local function u186(p182, p183) --[[ Line: 490 ]]
    -- upvalues: l__len__6 (copy), u54 (copy), l__create__4 (copy)
    local v184 = typeof(p182) == "buffer";
    local v185;
    if v184 then
        v185 = l__len__6(p182);
    else
        v185 = #p182;
    end;
    return u54(p182, v185, p183 or l__create__4(v185 == 32 and 240 or (v185 == 24 and 208 or (v185 == 16 and 176 or error("Key must be either 16, 24 or 32 bytes long")))), v184);
end;
local function u238(p187, p188, p189) --[[ Line: 496 ]]
    -- upvalues: l__len__6 (copy), l__tostring__10 (copy), l__sub__16 (copy), l__Modes__17 (copy), l__Pads__18 (copy), u110 (copy), u166 (copy), l__fromstring__5 (copy), l__create__4 (copy), u180 (copy), u181 (copy)
    local u190 = l__len__6(p187);
    local u191 = nil;
    local u192 = nil;
    local u193 = l__tostring__10(p187);
    if u190 == 240 then
        u192 = l__sub__16(u193, 1, 32);
        u191 = 192;
    elseif u190 == 208 then
        u192 = l__sub__16(u193, 1, 24);
        u191 = 160;
    elseif u190 == 176 then
        u192 = l__sub__16(u193, 1, 16);
        u191 = 128;
    else
        error("Round keys must be either 240, 208 or 128 bytes long");
    end;
    local u194 = p187;
    local u195 = p188 or l__Modes__17.ECB;
    local l__FwdMode__19 = u195.FwdMode;
    local l__InvMode__20 = u195.InvMode;
    local u196 = u195.SegmentSize or 16;
    local u197 = p189 or l__Pads__18.Pkcs7;
    local l__Pad__21 = u197.Pad;
    local l__Unpad__22 = u197.Unpad;
    local u198 = newproxy(true);
    local v199 = getmetatable(u198);
    local function u204(p200, p201, p202, p203) --[[ Line: 523 ]]
        -- upvalues: u110 (ref), u194 (ref), u191 (ref)
        u110(u194, u191, p200, p201, p202, p203);
    end;
    local function u209(p205, p206, p207, p208) --[[ Line: 526 ]]
        -- upvalues: u166 (ref), u194 (ref), u191 (ref)
        u166(u194, u191, p205, p206, p207, p208);
    end;
    local function u217(p210, p211, p212, ...) --[[ Line: 529 ]]
        -- upvalues: l__fromstring__5 (ref), u198 (copy), u191 (ref), l__Pad__21 (copy), u196 (copy), l__FwdMode__19 (ref), u204 (copy), u209 (copy), u197 (ref), u195 (ref), l__create__4 (ref)
        if typeof(p211) ~= "buffer" then
            if typeof(p211) == "string" then
                p211 = l__fromstring__5(p211);
            else
                p211 = error((`Unable to cast {typeof(p211)} to buffer`));
            end;
        end;
        if typeof(p212) ~= "buffer" then
            p212 = false;
        end;
        if p210 ~= u198 then
            return p210:Encrypt(p211, p212, ...);
        end;
        if not u191 then
            error("AesCipher object\'s already destroyed");
            return l__create__4(0);
        end;
        local v213 = l__Pad__21(p211, p212, u196);
        local v214 = l__FwdMode__19;
        local v215 = u204;
        local v216 = u209;
        if u197.Overwrite ~= false then
            p211 = v213;
        end;
        v214(v215, v216, p211, v213, u195, ...);
        return v213;
    end;
    local function u223(p218, p219, p220, p221, p222) --[[ Line: 544 ]]
        -- upvalues: u198 (copy), u191 (ref), u110 (ref), u194 (ref)
        if p218 == u198 then
            if u191 then
                u110(u194, u191, p219, p220, p221 or p219, p222 or p220);
            else
                error("AesCipher object\'s already destroyed");
            end;
        else
            p218:EncryptBlock(p219, p220, p221, p222);
        end;
    end;
    local function u228(p224, p225, p226, ...) --[[ Line: 553 ]]
        -- upvalues: l__fromstring__5 (ref), u198 (copy), u191 (ref), u197 (ref), l__create__4 (ref), l__len__6 (ref), l__InvMode__20 (ref), u204 (copy), u209 (copy), u195 (ref), l__Unpad__22 (copy), u196 (copy)
        if typeof(p225) ~= "buffer" then
            if typeof(p225) == "string" then
                p225 = l__fromstring__5(p225);
            else
                p225 = error((`Unable to cast {typeof(p225)} to buffer`));
            end;
        end;
        if typeof(p226) ~= "buffer" then
            p226 = false;
        end;
        if p224 ~= u198 then
            return p224:Decrypt(p225, p226, ...);
        end;
        if not u191 then
            error("AesCipher object\'s already destroyed");
            return l__create__4(0);
        end;
        local l__Overwrite__23 = u197.Overwrite;
        local v227;
        if l__Overwrite__23 == nil then
            v227 = l__create__4(l__len__6(p225));
        elseif l__Overwrite__23 then
            v227 = p225;
        else
            v227 = p226 or l__create__4(l__len__6(p225));
        end;
        l__InvMode__20(u204, u209, p225, v227, u195, ...);
        return l__Unpad__22(v227, p226, u196);
    end;
    local function u234(p229, p230, p231, p232, p233) --[[ Line: 569 ]]
        -- upvalues: u198 (copy), u191 (ref), u166 (ref), u194 (ref)
        if p229 == u198 then
            if u191 then
                u166(u194, u191, p230, p231, p232 or p230, p233 or p231);
            else
                error("AesCipher object\'s already destroyed");
            end;
        else
            p229:DecryptBlock(p230, p231, p232, p233);
        end;
    end;
    local function u236(p235) --[[ Line: 578 ]]
        -- upvalues: u198 (copy), u191 (ref), u193 (ref), u194 (ref), l__FwdMode__19 (ref), l__InvMode__20 (ref), u195 (ref), u197 (ref), u192 (ref), u190 (ref)
        if p235 == u198 then
            if u191 then
                u193 = nil;
                u194 = nil;
                u191 = nil;
                l__FwdMode__19 = nil;
                l__InvMode__20 = nil;
                u195 = nil;
                u197 = nil;
                u192 = nil;
                u190 = nil;
            else
                error("AesCipher object\'s already destroyed");
            end;
        else
            p235:Destroy();
        end;
    end;
    function v199.__index(_, p237) --[[ Line: 589 ]]
        -- upvalues: u217 (copy), u228 (copy), u223 (copy), u234 (copy), u236 (copy), u191 (ref), u192 (ref), u193 (ref), u195 (ref), u197 (ref), u190 (ref)
        if p237 == "Encrypt" then
            return u217;
        elseif p237 == "Decrypt" then
            return u228;
        elseif p237 == "EncryptBlock" then
            return u223;
        elseif p237 == "DecryptBlock" then
            return u234;
        elseif p237 == "Destroy" then
            return u236;
        elseif u191 then
            if p237 == "Key" then
                return u192;
            elseif p237 == "RoundKeys" then
                return u193;
            elseif p237 == "Mode" then
                return u195;
            elseif p237 == "Padding" then
                return u197;
            elseif p237 == "Length" then
                return u190;
            else
                return error((`{p237} is not a valid member of AesCipher`));
            end;
        else
            return error("AesCipher object\'s already destroyed");
        end;
    end;
    v199.__newindex = u180;
    v199.__tostring = u181;
    function v199.__len() --[[ Line: 597 ]]
        -- upvalues: u190 (ref)
        return u190 or error("AesCipher object\'s destroyed");
    end;
    v199.__metatable = "AesCipher object: Metatable\'s locked";
    return u198;
end;
return table.freeze({
    new = function(p239, p240, p241) --[[ Name: new, Line 605 ]]
        -- upvalues: u238 (copy), u186 (copy)
        return u238(u186(p239), p240, p241);
    end,
    expandKey = u186,
    fromKey = u238,
    modes = l__Modes__17,
    pads = l__Pads__18
});