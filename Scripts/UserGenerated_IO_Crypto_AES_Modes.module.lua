-- Decompiled with Potassium's decompiler.

local l__bxor__1 = bit32.bxor;
local l__copy__2 = buffer.copy;
local l__create__3 = buffer.create;
local l__len__4 = buffer.len;
local l__readu8__5 = buffer.readu8;
local l__readu32__6 = buffer.readu32;
local _ = buffer.tostring;
local l__writestring__7 = buffer.writestring;
local l__writeu8__8 = buffer.writeu8;
local l__writeu32__9 = buffer.writeu32;
local _ = math.floor;
local l__random__10 = math.random;
local l__pack__11 = string.pack;
local u1 = l__create__3(16);
local function u13(p2, p3, p4, p5, p6) --[[ Line: 30 ]]
    -- upvalues: l__readu8__5 (copy), l__writeu8__8 (copy)
    if not p6 then
        local v7 = l__readu8__5(p2, p5) + p3;
        l__writeu8__8(p2, p5, v7);
        if v7 >= 256 then
            for v8 = p5 - 1, p4, -1 do
                local v9 = l__readu8__5(p2, v8) + 1;
                l__writeu8__8(p2, v8, v9);
                if v9 < 256 then
                    break;
                end;
            end;
        end;
        return;
    end;
    local v10 = l__readu8__5(p2, p4) + p3;
    l__writeu8__8(p2, p4, v10);
    if v10 >= 256 then
        for v11 = p4 + 1, p5 do
            local v12 = l__readu8__5(p2, v11) + 1;
            l__writeu8__8(p2, v11, v12);
            if v12 < 256 then
                return;
            end;
        end;
    end;
end;
local v24 = {
    ECB = {
        FwdMode = function(p14, _, p15, p16) --[[ Name: FwdMode, Line 66 ]]
            -- upvalues: l__len__4 (copy)
            local v17 = l__len__4(p15) - 16;
            assert(v17 % 16 == 0, "Input length must be a multiple of 16 bytes");
            for v18 = 0, v17, 16 do
                p14(p15, v18, p16, v18);
            end;
        end,
        InvMode = function(_, p19, p20, p21) --[[ Name: InvMode, Line 73 ]]
            -- upvalues: l__len__4 (copy)
            local v22 = l__len__4(p20) - 16;
            assert(v22 % 16 == 0, "Input length must be a multiple of 16 bytes");
            for v23 = 0, v22, 16 do
                p19(p20, v23, p21, v23);
            end;
        end
    }
};
table.freeze(v24.ECB);
v24.CBC = {
    FwdMode = function(p25, _, p26, p27, _, p28) --[[ Name: FwdMode, Line 89 ]]
        -- upvalues: l__len__4 (copy), u1 (copy), l__readu32__6 (copy), l__bxor__1 (copy), l__writeu32__9 (copy)
        local v29 = l__len__4(p26) - 16;
        assert(v29 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v30 = p28 or u1;
        local v31 = l__len__4(v30) == 16;
        assert(v31, "Initialization vector must be 16 bytes long");
        l__writeu32__9(p27, 0, (l__bxor__1(l__readu32__6(p26, 0), (l__readu32__6(v30, 0)))));
        l__writeu32__9(p27, 4, (l__bxor__1(l__readu32__6(p26, 4), (l__readu32__6(v30, 4)))));
        l__writeu32__9(p27, 8, (l__bxor__1(l__readu32__6(p26, 8), (l__readu32__6(v30, 8)))));
        l__writeu32__9(p27, 12, (l__bxor__1(l__readu32__6(p26, 12), (l__readu32__6(v30, 12)))));
        p25(p27, 0, p27, 0);
        for v32 = 16, v29, 16 do
            l__writeu32__9(p27, v32, (l__bxor__1(l__readu32__6(p26, v32), (l__readu32__6(p27, v32 - 16)))));
            l__writeu32__9(p27, v32 + 4, (l__bxor__1(l__readu32__6(p26, v32 + 4), (l__readu32__6(p27, v32 - 12)))));
            l__writeu32__9(p27, v32 + 8, (l__bxor__1(l__readu32__6(p26, v32 + 8), (l__readu32__6(p27, v32 - 8)))));
            l__writeu32__9(p27, v32 + 12, (l__bxor__1(l__readu32__6(p26, v32 + 12), (l__readu32__6(p27, v32 - 4)))));
            p25(p27, v32, p27, v32);
        end;
    end,
    InvMode = function(_, p33, p34, p35, _, p36) --[[ Name: InvMode, Line 107 ]]
        -- upvalues: l__len__4 (copy), u1 (copy), l__readu32__6 (copy), l__bxor__1 (copy), l__writeu32__9 (copy)
        local v37 = l__len__4(p34) - 16;
        assert(v37 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v38 = p36 or u1;
        local v39 = l__len__4(v38) == 16;
        assert(v39, "Initialization vector must be 16 bytes long");
        local v40 = l__readu32__6(p34, 0);
        local v41 = l__readu32__6(p34, 4);
        local v42 = l__readu32__6(p34, 8);
        local v43 = l__readu32__6(p34, 12);
        p33(p34, 0, p35, 0);
        l__writeu32__9(p35, 0, (l__bxor__1(l__readu32__6(p35, 0), (l__readu32__6(v38, 0)))));
        l__writeu32__9(p35, 4, (l__bxor__1(l__readu32__6(p35, 4), (l__readu32__6(v38, 4)))));
        l__writeu32__9(p35, 8, (l__bxor__1(l__readu32__6(p35, 8), (l__readu32__6(v38, 8)))));
        l__writeu32__9(p35, 12, (l__bxor__1(l__readu32__6(p35, 12), (l__readu32__6(v38, 12)))));
        for v44 = 16, v37, 16 do
            local v45 = l__readu32__6(p34, v44);
            local v46 = l__readu32__6(p34, v44 + 4);
            local v47 = l__readu32__6(p34, v44 + 8);
            local v48 = l__readu32__6(p34, v44 + 12);
            p33(p34, v44, p35, v44);
            l__writeu32__9(p35, v44, (l__bxor__1(l__readu32__6(p35, v44), v40)));
            l__writeu32__9(p35, v44 + 4, (l__bxor__1(l__readu32__6(p35, v44 + 4), v41)));
            l__writeu32__9(p35, v44 + 8, (l__bxor__1(l__readu32__6(p35, v44 + 8), v42)));
            l__writeu32__9(p35, v44 + 12, (l__bxor__1(l__readu32__6(p35, v44 + 12), v43)));
            v40 = v45;
            v43 = v48;
            v42 = v47;
            v41 = v46;
        end;
    end
};
table.freeze(v24.CBC);
v24.PCBC = {
    FwdMode = function(p49, _, p50, p51, _, p52) --[[ Name: FwdMode, Line 142 ]]
        -- upvalues: l__len__4 (copy), u1 (copy), l__readu32__6 (copy), l__bxor__1 (copy), l__writeu32__9 (copy)
        local v53 = l__len__4(p50) - 16;
        assert(v53 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v54 = p52 or u1;
        local v55 = l__len__4(v54) == 16;
        assert(v55, "Initialization vector must be 16 bytes long");
        local v56 = l__readu32__6(p50, 0);
        local v57 = l__readu32__6(p50, 4);
        local v58 = l__readu32__6(p50, 8);
        local v59 = l__readu32__6(p50, 12);
        l__writeu32__9(p51, 0, (l__bxor__1(v56, (l__readu32__6(v54, 0)))));
        l__writeu32__9(p51, 4, (l__bxor__1(v57, (l__readu32__6(v54, 4)))));
        l__writeu32__9(p51, 8, (l__bxor__1(v58, (l__readu32__6(v54, 8)))));
        l__writeu32__9(p51, 12, (l__bxor__1(v59, (l__readu32__6(v54, 12)))));
        p49(p51, 0, p51, 0);
        for v60 = 16, v53, 16 do
            local v61 = l__readu32__6(p50, v60);
            local v62 = l__readu32__6(p50, v60 + 4);
            local v63 = l__readu32__6(p50, v60 + 8);
            local v64 = l__readu32__6(p50, v60 + 12);
            l__writeu32__9(p51, v60, (l__bxor__1(v56, v61, (l__readu32__6(p51, v60 - 16)))));
            l__writeu32__9(p51, v60 + 4, (l__bxor__1(v57, v62, (l__readu32__6(p51, v60 - 12)))));
            l__writeu32__9(p51, v60 + 8, (l__bxor__1(v58, v63, (l__readu32__6(p51, v60 - 8)))));
            l__writeu32__9(p51, v60 + 12, (l__bxor__1(v59, v64, (l__readu32__6(p51, v60 - 4)))));
            p49(p51, v60, p51, v60);
            v57 = v62;
            v56 = v61;
            v59 = v64;
            v58 = v63;
        end;
    end,
    InvMode = function(_, p65, p66, p67, _, p68) --[[ Name: InvMode, Line 168 ]]
        -- upvalues: l__len__4 (copy), u1 (copy), l__readu32__6 (copy), l__bxor__1 (copy), l__writeu32__9 (copy)
        local v69 = l__len__4(p66) - 16;
        assert(v69 % 16 == 0, "Input length must be a multiple of 16 bytes");
        local v70 = p68 or u1;
        local v71 = l__len__4(v70) == 16;
        assert(v71, "Initialization vector must be 16 bytes long");
        local v72 = l__readu32__6(p66, 0);
        local v73 = l__readu32__6(p66, 4);
        local v74 = l__readu32__6(p66, 8);
        local v75 = l__readu32__6(p66, 12);
        p65(p66, 0, p67, 0);
        local v76 = l__bxor__1(l__readu32__6(p67, 0), (l__readu32__6(v70, 0)));
        local v77 = l__bxor__1(l__readu32__6(p67, 4), (l__readu32__6(v70, 4)));
        local v78 = l__bxor__1(l__readu32__6(p67, 8), (l__readu32__6(v70, 8)));
        local v79 = l__bxor__1(l__readu32__6(p67, 12), (l__readu32__6(v70, 12)));
        l__writeu32__9(p67, 0, v76);
        l__writeu32__9(p67, 4, v77);
        l__writeu32__9(p67, 8, v78);
        l__writeu32__9(p67, 12, v79);
        local v80 = 0;
        local v81 = 4;
        local v82 = 8;
        local v83 = 12;
        for v84 = 16, v69, 16 do
            v80 = v80 + 16;
            v81 = v81 + 16;
            v82 = v82 + 16;
            v83 = v83 + 16;
            local v85 = l__readu32__6(p66, v80);
            local v86 = l__readu32__6(p66, v81);
            local v87 = l__readu32__6(p66, v82);
            local v88 = l__readu32__6(p66, v83);
            p65(p66, v84, p67, v84);
            v76 = l__bxor__1(v72, v76, (l__readu32__6(p67, v80)));
            v77 = l__bxor__1(v73, v77, (l__readu32__6(p67, v81)));
            v78 = l__bxor__1(v74, v78, (l__readu32__6(p67, v82)));
            v79 = l__bxor__1(v75, v79, (l__readu32__6(p67, v83)));
            l__writeu32__9(p67, v80, v76);
            l__writeu32__9(p67, v81, v77);
            l__writeu32__9(p67, v82, v78);
            l__writeu32__9(p67, v83, v79);
            v73 = v86;
            v72 = v85;
            v75 = v88;
            v74 = v87;
        end;
    end
};
table.freeze(v24.PCBC);
local function u107(p89, _, p90, p91, p92, p93) --[[ Line: 216 ]]
    -- upvalues: l__len__4 (copy), u1 (copy), l__create__3 (copy), l__readu8__5 (copy), l__bxor__1 (copy), l__writeu8__8 (copy), l__copy__2 (copy)
    local l__SegmentSize__12 = p92.SegmentSize;
    local v94 = l__len__4(p90);
    assert(v94 % l__SegmentSize__12 == 0, "Input length must be a multiple of segment size");
    local v95 = p93 or u1;
    local v96 = l__len__4(v95) == 16;
    assert(v96, "Initialization vector must be 16 bytes long");
    local v97 = p92.CommonTemp or l__create__3(31);
    if v94 == l__SegmentSize__12 then
        p89(v95, 0, v97, 0);
        for v98 = 0, l__SegmentSize__12 - 1 do
            l__writeu8__8(p91, v98, (l__bxor__1(l__readu8__5(p90, v98), (l__readu8__5(v97, v98)))));
        end;
    else
        local v99 = v94 - l__SegmentSize__12;
        local v100 = 16 - l__SegmentSize__12;
        p89(v95, 0, v97, 0);
        for v101 = 0, l__SegmentSize__12 - 1 do
            l__writeu8__8(p91, v101, (l__bxor__1(l__readu8__5(p90, v101), (l__readu8__5(v97, v101)))));
        end;
        l__copy__2(v97, 0, v95, l__SegmentSize__12, v100);
        l__copy__2(v97, v100, p91, 0, l__SegmentSize__12);
        for v102 = l__SegmentSize__12, v99 - l__SegmentSize__12, l__SegmentSize__12 do
            l__copy__2(v97, 16, v97, l__SegmentSize__12, v100);
            p89(v97, 0, v97, 0);
            local v103 = 0;
            for v104 = v102, v102 + l__SegmentSize__12 - 1 do
                l__writeu8__8(p91, v104, (l__bxor__1(l__readu8__5(p90, v104), (l__readu8__5(v97, v103)))));
                v103 = v103 + 1;
            end;
            l__copy__2(v97, 0, v97, 16, v100);
            l__copy__2(v97, v100, p91, v102, l__SegmentSize__12);
        end;
        p89(v97, 0, v97, 0);
        local v105 = 0;
        for v106 = v99, v94 - 1 do
            l__writeu8__8(p91, v106, (l__bxor__1(l__readu8__5(p90, v106), (l__readu8__5(v97, v105)))));
            v105 = v105 + 1;
        end;
    end;
end;
local function u126(p108, _, p109, p110, p111, p112) --[[ Line: 256 ]]
    -- upvalues: l__len__4 (copy), u1 (copy), l__create__3 (copy), l__readu8__5 (copy), l__bxor__1 (copy), l__writeu8__8 (copy), l__copy__2 (copy)
    local v113 = l__len__4(p109);
    local l__SegmentSize__13 = p111.SegmentSize;
    assert(v113 % l__SegmentSize__13 == 0, "Input length must be a multiple of segment size");
    local v114 = p112 or u1;
    local v115 = l__len__4(v114) == 16;
    assert(v115, "Initialization vector must be 16 bytes long");
    local v116 = p111.CommonTemp or l__create__3(31);
    if v113 == l__SegmentSize__13 then
        p108(v114, 0, v116, 0);
        for v117 = 0, l__SegmentSize__13 - 1 do
            l__writeu8__8(p110, v117, (l__bxor__1(l__readu8__5(p109, v117), (l__readu8__5(v116, v117)))));
        end;
    else
        local v118 = v113 - l__SegmentSize__13;
        local v119 = 16 - l__SegmentSize__13;
        p108(v114, 0, v116, 0);
        for v120 = 0, l__SegmentSize__13 - 1 do
            l__writeu8__8(p110, v120, (l__bxor__1(l__readu8__5(p109, v120), (l__readu8__5(v116, v120)))));
        end;
        l__copy__2(v116, 0, v114, l__SegmentSize__13, v119);
        l__copy__2(v116, v119, p109, 0, l__SegmentSize__13);
        for v121 = l__SegmentSize__13, v118 - l__SegmentSize__13, l__SegmentSize__13 do
            l__copy__2(v116, 16, v116, l__SegmentSize__13, v119);
            p108(v116, 0, v116, 0);
            local v122 = 0;
            for v123 = v121, v121 + l__SegmentSize__13 - 1 do
                l__writeu8__8(p110, v123, (l__bxor__1(l__readu8__5(p109, v123), (l__readu8__5(v116, v122)))));
                v122 = v122 + 1;
            end;
            l__copy__2(v116, 0, v116, 16, v119);
            l__copy__2(v116, v119, p109, v121, l__SegmentSize__13);
        end;
        p108(v116, 0, v116, 0);
        local v124 = 0;
        for v125 = v118, v113 - 1 do
            l__writeu8__8(p110, v125, (l__bxor__1(l__readu8__5(p109, v125), (l__readu8__5(v116, v124)))));
            v124 = v124 + 1;
        end;
    end;
end;
local function v147(p127, _, p128, p129, _, p130) --[[ Line: 304 ]]
    -- upvalues: l__len__4 (copy), u1 (copy), l__readu32__6 (copy), l__bxor__1 (copy), l__writeu32__9 (copy)
    local v131 = l__len__4(p128) - 16;
    assert(v131 % 16 == 0, "Input length must be a multiple of 16 bytes");
    local v132 = p130 or u1;
    local v133 = l__len__4(v132) == 16;
    assert(v133, "Initialization vector must be 16 bytes long");
    local v134 = l__readu32__6(p128, 0);
    local v135 = l__readu32__6(p128, 4);
    local v136 = l__readu32__6(p128, 8);
    local v137 = l__readu32__6(p128, 12);
    p127(v132, 0, p129, 0);
    local v138 = l__bxor__1(v134, (l__readu32__6(p129, 0)));
    local v139 = l__bxor__1(v135, (l__readu32__6(p129, 4)));
    local v140 = l__bxor__1(v136, (l__readu32__6(p129, 8)));
    local v141 = l__bxor__1(v137, (l__readu32__6(p129, 12)));
    for v142 = 16, v131, 16 do
        local v143 = l__readu32__6(p128, v142);
        local v144 = l__readu32__6(p128, v142 + 4);
        local v145 = l__readu32__6(p128, v142 + 8);
        local v146 = l__readu32__6(p128, v142 + 12);
        p127(p129, v142 - 16, p129, v142);
        l__writeu32__9(p129, v142 - 16, v138);
        l__writeu32__9(p129, v142 - 12, v139);
        l__writeu32__9(p129, v142 - 8, v140);
        l__writeu32__9(p129, v142 - 4, v141);
        v138 = l__bxor__1(v143, (l__readu32__6(p129, v142)));
        v139 = l__bxor__1(v144, (l__readu32__6(p129, v142 + 4)));
        v140 = l__bxor__1(v145, (l__readu32__6(p129, v142 + 8)));
        v141 = l__bxor__1(v146, (l__readu32__6(p129, v142 + 12)));
    end;
    l__writeu32__9(p129, v131, v138);
    l__writeu32__9(p129, v131 + 4, v139);
    l__writeu32__9(p129, v131 + 8, v140);
    l__writeu32__9(p129, v131 + 12, v141);
end;
v24.OFB = {
    FwdMode = v147,
    InvMode = v147
};
table.freeze(v24.OFB);
local function u164(p148, _, p149, p150, p151) --[[ Line: 357 ]]
    -- upvalues: l__len__4 (copy), l__writestring__7 (copy), l__readu32__6 (copy), l__bxor__1 (copy), l__writeu32__9 (copy), u13 (copy)
    local v152 = l__len__4(p149) - 16;
    assert(v152 % 16 == 0, "Input length must be a multiple of 16 bytes");
    local l__CommonTemp__14 = p151.CommonTemp;
    local l__InitValue__15 = p151.InitValue;
    local l__Prefix__16 = p151.Prefix;
    local l__Suffix__17 = p151.Suffix;
    local l__Step__18 = p151.Step;
    local l__LittleEndian__19 = p151.LittleEndian;
    local v153 = #l__Prefix__16;
    local v154 = v153 + #l__InitValue__15 - 1;
    l__writestring__7(l__CommonTemp__14, 0, l__Prefix__16);
    l__writestring__7(l__CommonTemp__14, v153, l__InitValue__15);
    l__writestring__7(l__CommonTemp__14, v154 + 1, l__Suffix__17);
    local v155 = l__readu32__6(p149, 0);
    local v156 = l__readu32__6(p149, 4);
    local v157 = l__readu32__6(p149, 8);
    local v158 = l__readu32__6(p149, 12);
    p148(l__CommonTemp__14, 0, p150, 0);
    l__writeu32__9(p150, 0, (l__bxor__1(l__readu32__6(p150, 0), v155)));
    l__writeu32__9(p150, 4, (l__bxor__1(l__readu32__6(p150, 4), v156)));
    l__writeu32__9(p150, 8, (l__bxor__1(l__readu32__6(p150, 8), v157)));
    l__writeu32__9(p150, 12, (l__bxor__1(l__readu32__6(p150, 12), v158)));
    for v159 = 16, v152, 16 do
        local v160 = l__readu32__6(p149, v159);
        local v161 = l__readu32__6(p149, v159 + 4);
        local v162 = l__readu32__6(p149, v159 + 8);
        local v163 = l__readu32__6(p149, v159 + 12);
        u13(l__CommonTemp__14, l__Step__18, v153, v154, l__LittleEndian__19);
        p148(l__CommonTemp__14, 0, p150, v159);
        l__writeu32__9(p150, v159, (l__bxor__1(v160, (l__readu32__6(p150, v159)))));
        l__writeu32__9(p150, v159 + 4, (l__bxor__1(v161, (l__readu32__6(p150, v159 + 4)))));
        l__writeu32__9(p150, v159 + 8, (l__bxor__1(v162, (l__readu32__6(p150, v159 + 8)))));
        l__writeu32__9(p150, v159 + 12, (l__bxor__1(v163, (l__readu32__6(p150, v159 + 12)))));
    end;
end;
local v166 = {
    __index = function(_, p165) --[[ Name: __index, Line 390 ]]
        -- upvalues: u107 (copy), u126 (copy), l__create__3 (copy), u164 (copy), l__pack__11 (copy), l__random__10 (copy)
        return p165 == "CFB" and {
            SegmentSize = 16,
            FwdMode = u107,
            InvMode = u126,
            CommonTemp = l__create__3(31)
        } or (p165 == "CTR" and {
            Prefix = "",
            Suffix = "",
            Step = 1,
            LittleEndian = false,
            FwdMode = u164,
            InvMode = u164,
            InitValue = l__pack__11("I2I2I2I2I2I2I2I2", l__random__10(0, 65535), l__random__10(0, 65535), l__random__10(0, 65535), l__random__10(0, 65535), l__random__10(0, 65535), l__random__10(0, 65535), l__random__10(0, 65535), l__random__10(0, 65535)),
            CommonTemp = l__create__3(16)
        } or nil);
    end,
    __newindex = function() --[[ Name: __newindex, Line 403 ]] end
};
setmetatable(v24, v166);
v24.CFB = {};
v24.CTR = {};
table.freeze(v24);
v166.__metatable = "This metatable is locked";
return v24;