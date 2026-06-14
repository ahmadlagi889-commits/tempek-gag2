-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.UserGenerated.Randoms.Base);
local l__GenerateSeed__2 = require(l__ReplicatedStorage__1.UserGenerated.IO.Crypto.GenerateSeed);
local l__Theory__3 = require(script.Theory);
local l__bxor__4 = bit32.bxor;
local l__bor__5 = bit32.bor;
local l__band__6 = bit32.band;
local l__lshift__7 = bit32.lshift;
local l__rshift__8 = bit32.rshift;
local l__floor__9 = math.floor;
local l__ldexp__10 = math.ldexp;
local l__sqrt__11 = math.sqrt;
local l__log__12 = math.log;
local l__max__13 = math.max;
local l__sin__14 = math.sin;
local l__cos__15 = math.cos;
local l__clamp__16 = math.clamp;
local l__format__17 = string.format;
local l__new__18 = Vector2.new;
local l__new__19 = Vector3.new;
assert(true);
local u1 = Random.new();
local function u19(p2, p3) --[[ Line: 165 ]]
    -- upvalues: u1 (copy), l__bor__5 (copy), l__rshift__8 (copy), l__band__6 (copy), l__lshift__7 (copy)
    local v4 = p3 == nil and {} or (type(p3) == "number" and { p3 } or p3);
    local v5 = v4[1];
    local v6 = v4[2];
    local v7 = v4[3];
    local v8 = v4[4];
    local v9 = l__bor__5(v5 or u1:NextInteger(0, 4294967295), 0);
    if not v6 then
        local v10 = l__rshift__8(v9, 16);
        local v11 = l__band__6(v9, 65535);
        v6 = l__lshift__7(l__band__6(v11 * 27655 + v10 * 35173, 65535), 16) + v11 * 35173 + 1;
    end;
    local v12 = l__bor__5(v6, 0);
    if not v7 then
        local v13 = l__rshift__8(v12, 16);
        local v14 = l__band__6(v12, 65535);
        v7 = l__lshift__7(l__band__6(v14 * 27655 + v13 * 35173, 65535), 16) + v14 * 35173 + 1;
    end;
    local v15 = l__bor__5(v7, 0);
    if not v8 then
        local v16 = l__rshift__8(v15, 16);
        local v17 = l__band__6(v15, 65535);
        v8 = l__lshift__7(l__band__6(v17 * 27655 + v16 * 35173, 65535), 16) + v17 * 35173 + 1;
    end;
    local v18 = l__bor__5(v8, 0);
    p2.x = v9;
    p2.y = v12;
    p2.z = v15;
    p2.w = v18;
end;
local v140 = table.freeze({
    NextU32 = function(p20) --[[ Name: NextU32, Line 88 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy)
        local l__x__20 = p20.x;
        local l__w__21 = p20.w;
        local v21 = l__bxor__4(l__x__20, (l__lshift__7(l__x__20, 11)));
        local v22 = l__bxor__4(l__bxor__4(l__bxor__4(v21, (l__rshift__8(v21, 8))), l__w__21), (l__rshift__8(l__w__21, 19)));
        local l__y__22 = p20.y;
        local l__z__23 = p20.z;
        p20.x = l__y__22;
        p20.y = l__z__23;
        p20.z = l__w__21;
        p20.w = v22;
        return v22;
    end,
    NextU64 = function(p23) --[[ Name: NextU64, Line 98 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy)
        local l__x__24 = p23.x;
        local l__w__25 = p23.w;
        local v24 = l__bxor__4(l__x__24, (l__lshift__7(l__x__24, 11)));
        local v25 = l__bxor__4(l__bxor__4(l__bxor__4(v24, (l__rshift__8(v24, 8))), l__w__25), (l__rshift__8(l__w__25, 19)));
        local l__y__26 = p23.y;
        local l__z__27 = p23.z;
        p23.x = l__y__26;
        p23.y = l__z__27;
        p23.z = l__w__25;
        p23.w = v25;
        local v26 = l__ldexp__10(v25, 32);
        local l__x__28 = p23.x;
        local l__w__29 = p23.w;
        local v27 = l__bxor__4(l__x__28, (l__lshift__7(l__x__28, 11)));
        local v28 = l__bxor__4(l__bxor__4(l__bxor__4(v27, (l__rshift__8(v27, 8))), l__w__29), (l__rshift__8(l__w__29, 19)));
        local l__y__30 = p23.y;
        local l__z__31 = p23.z;
        p23.x = l__y__30;
        p23.y = l__z__31;
        p23.z = l__w__29;
        p23.w = v28;
        return v26 + v28;
    end,
    NextFloat = function(p29) --[[ Name: NextFloat, Line 102 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy)
        local l__x__32 = p29.x;
        local l__w__33 = p29.w;
        local v30 = l__bxor__4(l__x__32, (l__lshift__7(l__x__32, 11)));
        local v31 = l__bxor__4(l__bxor__4(l__bxor__4(v30, (l__rshift__8(v30, 8))), l__w__33), (l__rshift__8(l__w__33, 19)));
        local l__y__34 = p29.y;
        local l__z__35 = p29.z;
        p29.x = l__y__34;
        p29.y = l__z__35;
        p29.z = l__w__33;
        p29.w = v31;
        return l__ldexp__10(v31, -32);
    end,
    NextDouble = function(p32) --[[ Name: NextDouble, Line 106 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy)
        local l__x__36 = p32.x;
        local l__w__37 = p32.w;
        local v33 = l__bxor__4(l__x__36, (l__lshift__7(l__x__36, 11)));
        local v34 = l__bxor__4(l__bxor__4(l__bxor__4(v33, (l__rshift__8(v33, 8))), l__w__37), (l__rshift__8(l__w__37, 19)));
        local l__y__38 = p32.y;
        local l__z__39 = p32.z;
        p32.x = l__y__38;
        p32.y = l__z__39;
        p32.z = l__w__37;
        p32.w = v34;
        local v35 = l__ldexp__10(v34, 32);
        local l__x__40 = p32.x;
        local l__w__41 = p32.w;
        local v36 = l__bxor__4(l__x__40, (l__lshift__7(l__x__40, 11)));
        local v37 = l__bxor__4(l__bxor__4(l__bxor__4(v36, (l__rshift__8(v36, 8))), l__w__41), (l__rshift__8(l__w__41, 19)));
        local l__y__42 = p32.y;
        local l__z__43 = p32.z;
        p32.x = l__y__42;
        p32.y = l__z__43;
        p32.z = l__w__41;
        p32.w = v37;
        return l__ldexp__10(v35 + v37, -64);
    end,
    NextNumber = function(p38, p39, p40) --[[ Name: NextNumber, Line 110 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy)
        local v41 = p40 - p39;
        local l__x__44 = p38.x;
        local l__w__45 = p38.w;
        local v42 = l__bxor__4(l__x__44, (l__lshift__7(l__x__44, 11)));
        local v43 = l__bxor__4(l__bxor__4(l__bxor__4(v42, (l__rshift__8(v42, 8))), l__w__45), (l__rshift__8(l__w__45, 19)));
        local l__y__46 = p38.y;
        local l__z__47 = p38.z;
        p38.x = l__y__46;
        p38.y = l__z__47;
        p38.z = l__w__45;
        p38.w = v43;
        local v44 = l__ldexp__10(v43, 32);
        local l__x__48 = p38.x;
        local l__w__49 = p38.w;
        local v45 = l__bxor__4(l__x__48, (l__lshift__7(l__x__48, 11)));
        local v46 = l__bxor__4(l__bxor__4(l__bxor__4(v45, (l__rshift__8(v45, 8))), l__w__49), (l__rshift__8(l__w__49, 19)));
        local l__y__50 = p38.y;
        local l__z__51 = p38.z;
        p38.x = l__y__50;
        p38.y = l__z__51;
        p38.z = l__w__49;
        p38.w = v46;
        return p39 + v41 * l__ldexp__10(v44 + v46, -64);
    end,
    NextInteger = function(p47, p48, p49) --[[ Name: NextInteger, Line 114 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy), l__floor__9 (copy)
        local v50 = p49 - p48 + 1;
        local l__x__52 = p47.x;
        local l__w__53 = p47.w;
        local v51 = l__bxor__4(l__x__52, (l__lshift__7(l__x__52, 11)));
        local v52 = l__bxor__4(l__bxor__4(l__bxor__4(v51, (l__rshift__8(v51, 8))), l__w__53), (l__rshift__8(l__w__53, 19)));
        local l__y__54 = p47.y;
        local l__z__55 = p47.z;
        p47.x = l__y__54;
        p47.y = l__z__55;
        p47.z = l__w__53;
        p47.w = v52;
        local v53 = l__ldexp__10(v52, 32);
        local l__x__56 = p47.x;
        local l__w__57 = p47.w;
        local v54 = l__bxor__4(l__x__56, (l__lshift__7(l__x__56, 11)));
        local v55 = l__bxor__4(l__bxor__4(l__bxor__4(v54, (l__rshift__8(v54, 8))), l__w__57), (l__rshift__8(l__w__57, 19)));
        local l__y__58 = p47.y;
        local l__z__59 = p47.z;
        p47.x = l__y__58;
        p47.y = l__z__59;
        p47.z = l__w__57;
        p47.w = v55;
        return l__floor__9(p48 + v50 * l__ldexp__10(v53 + v55, -64));
    end,
    NextNormal = function(p56, p57, p58) --[[ Name: NextNormal, Line 118 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy), l__max__13 (copy), l__log__12 (copy), l__sqrt__11 (copy), l__cos__15 (copy), l__sin__14 (copy)
        local l__x__60 = p56.x;
        local l__w__61 = p56.w;
        local v59 = l__bxor__4(l__x__60, (l__lshift__7(l__x__60, 11)));
        local v60 = l__bxor__4(l__bxor__4(l__bxor__4(v59, (l__rshift__8(v59, 8))), l__w__61), (l__rshift__8(l__w__61, 19)));
        local l__y__62 = p56.y;
        local l__z__63 = p56.z;
        p56.x = l__y__62;
        p56.y = l__z__63;
        p56.z = l__w__61;
        p56.w = v60;
        local v61 = l__ldexp__10(v60, 32);
        local l__x__64 = p56.x;
        local l__w__65 = p56.w;
        local v62 = l__bxor__4(l__x__64, (l__lshift__7(l__x__64, 11)));
        local v63 = l__bxor__4(l__bxor__4(l__bxor__4(v62, (l__rshift__8(v62, 8))), l__w__65), (l__rshift__8(l__w__65, 19)));
        local l__y__66 = p56.y;
        local l__z__67 = p56.z;
        p56.x = l__y__66;
        p56.y = l__z__67;
        p56.z = l__w__65;
        p56.w = v63;
        local v64 = l__sqrt__11(l__log__12((l__max__13(2.2250738585072014e-308, (l__ldexp__10(v61 + v63, -64))))) * -2) * (p58 or 0);
        local l__x__68 = p56.x;
        local l__w__69 = p56.w;
        local v65 = l__bxor__4(l__x__68, (l__lshift__7(l__x__68, 11)));
        local v66 = l__bxor__4(l__bxor__4(l__bxor__4(v65, (l__rshift__8(v65, 8))), l__w__69), (l__rshift__8(l__w__69, 19)));
        local l__y__70 = p56.y;
        local l__z__71 = p56.z;
        p56.x = l__y__70;
        p56.y = l__z__71;
        p56.z = l__w__69;
        p56.w = v66;
        local v67 = l__ldexp__10(v66, 32);
        local l__x__72 = p56.x;
        local l__w__73 = p56.w;
        local v68 = l__bxor__4(l__x__72, (l__lshift__7(l__x__72, 11)));
        local v69 = l__bxor__4(l__bxor__4(l__bxor__4(v68, (l__rshift__8(v68, 8))), l__w__73), (l__rshift__8(l__w__73, 19)));
        local l__y__74 = p56.y;
        local l__z__75 = p56.z;
        p56.x = l__y__74;
        p56.y = l__z__75;
        p56.z = l__w__73;
        p56.w = v69;
        local v70 = 6.283185307179586 * l__ldexp__10(v67 + v69, -64);
        local v71 = p57 or 0;
        return l__cos__15(v70) * v64 + v71, l__sin__14(v70) * v64 + v71;
    end,
    NextBoolean = function(p72, p73) --[[ Name: NextBoolean, Line 130 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy)
        local l__x__76 = p72.x;
        local l__w__77 = p72.w;
        local v74 = l__bxor__4(l__x__76, (l__lshift__7(l__x__76, 11)));
        local v75 = l__bxor__4(l__bxor__4(l__bxor__4(v74, (l__rshift__8(v74, 8))), l__w__77), (l__rshift__8(l__w__77, 19)));
        local l__y__78 = p72.y;
        local l__z__79 = p72.z;
        p72.x = l__y__78;
        p72.y = l__z__79;
        p72.z = l__w__77;
        p72.w = v75;
        local v76 = l__ldexp__10(v75, 32);
        local l__x__80 = p72.x;
        local l__w__81 = p72.w;
        local v77 = l__bxor__4(l__x__80, (l__lshift__7(l__x__80, 11)));
        local v78 = l__bxor__4(l__bxor__4(l__bxor__4(v77, (l__rshift__8(v77, 8))), l__w__81), (l__rshift__8(l__w__81, 19)));
        local l__y__82 = p72.y;
        local l__z__83 = p72.z;
        p72.x = l__y__82;
        p72.y = l__z__83;
        p72.z = l__w__81;
        p72.w = v78;
        return l__ldexp__10(v76 + v78, -64) < (p73 or 0.5);
    end,
    NextVector2 = function(p79, p80) --[[ Name: NextVector2, Line 134 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy), l__new__18 (copy), l__cos__15 (copy), l__sin__14 (copy)
        local v81 = p80 or 1;
        local l__x__84 = p79.x;
        local l__w__85 = p79.w;
        local v82 = l__bxor__4(l__x__84, (l__lshift__7(l__x__84, 11)));
        local v83 = l__bxor__4(l__bxor__4(l__bxor__4(v82, (l__rshift__8(v82, 8))), l__w__85), (l__rshift__8(l__w__85, 19)));
        local l__y__86 = p79.y;
        local l__z__87 = p79.z;
        p79.x = l__y__86;
        p79.y = l__z__87;
        p79.z = l__w__85;
        p79.w = v83;
        local v84 = l__ldexp__10(v83, 32);
        local l__x__88 = p79.x;
        local l__w__89 = p79.w;
        local v85 = l__bxor__4(l__x__88, (l__lshift__7(l__x__88, 11)));
        local v86 = l__bxor__4(l__bxor__4(l__bxor__4(v85, (l__rshift__8(v85, 8))), l__w__89), (l__rshift__8(l__w__89, 19)));
        local l__y__90 = p79.y;
        local l__z__91 = p79.z;
        p79.x = l__y__90;
        p79.y = l__z__91;
        p79.z = l__w__89;
        p79.w = v86;
        local v87 = 6.283185307179586 * l__ldexp__10(v84 + v86, -64);
        return l__new__18(l__cos__15(v87) * v81, l__sin__14(v87) * v81);
    end,
    NextVector3 = function(p88, p89) --[[ Name: NextVector3, Line 143 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy), l__sqrt__11 (copy), l__cos__15 (copy), l__sin__14 (copy), l__new__19 (copy)
        local v90 = p89 or 1;
        local l__x__92 = p88.x;
        local l__w__93 = p88.w;
        local v91 = l__bxor__4(l__x__92, (l__lshift__7(l__x__92, 11)));
        local v92 = l__bxor__4(l__bxor__4(l__bxor__4(v91, (l__rshift__8(v91, 8))), l__w__93), (l__rshift__8(l__w__93, 19)));
        local l__y__94 = p88.y;
        local l__z__95 = p88.z;
        p88.x = l__y__94;
        p88.y = l__z__95;
        p88.z = l__w__93;
        p88.w = v92;
        local v93 = l__ldexp__10(v92, 32);
        local l__x__96 = p88.x;
        local l__w__97 = p88.w;
        local v94 = l__bxor__4(l__x__96, (l__lshift__7(l__x__96, 11)));
        local v95 = l__bxor__4(l__bxor__4(l__bxor__4(v94, (l__rshift__8(v94, 8))), l__w__97), (l__rshift__8(l__w__97, 19)));
        local l__y__98 = p88.y;
        local l__z__99 = p88.z;
        p88.x = l__y__98;
        p88.y = l__z__99;
        p88.z = l__w__97;
        p88.w = v95;
        local v96 = 6.283185307179586 * l__ldexp__10(v93 + v95, -64);
        local l__x__100 = p88.x;
        local l__w__101 = p88.w;
        local v97 = l__bxor__4(l__x__100, (l__lshift__7(l__x__100, 11)));
        local v98 = l__bxor__4(l__bxor__4(l__bxor__4(v97, (l__rshift__8(v97, 8))), l__w__101), (l__rshift__8(l__w__101, 19)));
        local l__y__102 = p88.y;
        local l__z__103 = p88.z;
        p88.x = l__y__102;
        p88.y = l__z__103;
        p88.z = l__w__101;
        p88.w = v98;
        local v99 = l__ldexp__10(v98, 32);
        local l__x__104 = p88.x;
        local l__w__105 = p88.w;
        local v100 = l__bxor__4(l__x__104, (l__lshift__7(l__x__104, 11)));
        local v101 = l__bxor__4(l__bxor__4(l__bxor__4(v100, (l__rshift__8(v100, 8))), l__w__105), (l__rshift__8(l__w__105, 19)));
        local l__y__106 = p88.y;
        local l__z__107 = p88.z;
        p88.x = l__y__106;
        p88.y = l__z__107;
        p88.z = l__w__105;
        p88.w = v101;
        local v102 = l__ldexp__10(v99 + v101, -64) * 2 - 1;
        local v103 = l__sqrt__11(1 - v102 * v102);
        return l__new__19(l__cos__15(v96) * v103 * v90, l__sin__14(v96) * v103 * v90, v102 * v90);
    end,
    NextUUIDv4 = function(p104) --[[ Name: NextUUIDv4, Line 155 ]]
        -- upvalues: l__format__17 (copy), l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__band__6 (copy), l__bor__5 (copy)
        local v105 = l__format__17;
        local l__x__108 = p104.x;
        local l__w__109 = p104.w;
        local v106 = l__bxor__4(l__x__108, (l__lshift__7(l__x__108, 11)));
        local v107 = l__bxor__4(l__bxor__4(l__bxor__4(v106, (l__rshift__8(v106, 8))), l__w__109), (l__rshift__8(l__w__109, 19)));
        local l__y__110 = p104.y;
        local l__z__111 = p104.z;
        p104.x = l__y__110;
        p104.y = l__z__111;
        p104.z = l__w__109;
        p104.w = v107;
        local l__x__112 = p104.x;
        local l__w__113 = p104.w;
        local v108 = l__bxor__4(l__x__112, (l__lshift__7(l__x__112, 11)));
        local v109 = l__bxor__4(l__bxor__4(l__bxor__4(v108, (l__rshift__8(v108, 8))), l__w__113), (l__rshift__8(l__w__113, 19)));
        local l__y__114 = p104.y;
        local l__z__115 = p104.z;
        p104.x = l__y__114;
        p104.y = l__z__115;
        p104.z = l__w__113;
        p104.w = v109;
        local v110 = l__bor__5(l__band__6(v109, 4294905855), 16384);
        local l__x__116 = p104.x;
        local l__w__117 = p104.w;
        local v111 = l__bxor__4(l__x__116, (l__lshift__7(l__x__116, 11)));
        local v112 = l__bxor__4(l__bxor__4(l__bxor__4(v111, (l__rshift__8(v111, 8))), l__w__117), (l__rshift__8(l__w__117, 19)));
        local l__y__118 = p104.y;
        local l__z__119 = p104.z;
        p104.x = l__y__118;
        p104.y = l__z__119;
        p104.z = l__w__117;
        p104.w = v112;
        local v113 = l__bor__5(l__band__6(v112, 1073741823), 2147483648);
        local l__x__120 = p104.x;
        local l__w__121 = p104.w;
        local v114 = l__bxor__4(l__x__120, (l__lshift__7(l__x__120, 11)));
        local v115 = l__bxor__4(l__bxor__4(l__bxor__4(v114, (l__rshift__8(v114, 8))), l__w__121), (l__rshift__8(l__w__121, 19)));
        local l__y__122 = p104.y;
        local l__z__123 = p104.z;
        p104.x = l__y__122;
        p104.y = l__z__123;
        p104.z = l__w__121;
        p104.w = v115;
        return v105("%08x%08x%08x%08x", v107, v110, v113, v115);
    end,
    Seed = u19,
    Shuffle = function(p116, p117) --[[ Name: Shuffle, Line 196 ]]
        -- upvalues: l__lshift__7 (copy), l__bxor__4 (copy), l__rshift__8 (copy), l__ldexp__10 (copy), l__floor__9 (copy)
        local v118 = type(p117) == "table";
        assert(v118);
        for v119 = #p117, 2, -1 do
            local v120 = v119 - 1 + 1;
            local l__x__124 = p116.x;
            local l__w__125 = p116.w;
            local v121 = l__bxor__4(l__x__124, (l__lshift__7(l__x__124, 11)));
            local v122 = l__bxor__4(l__bxor__4(l__bxor__4(v121, (l__rshift__8(v121, 8))), l__w__125), (l__rshift__8(l__w__125, 19)));
            local l__y__126 = p116.y;
            local l__z__127 = p116.z;
            p116.x = l__y__126;
            p116.y = l__z__127;
            p116.z = l__w__125;
            p116.w = v122;
            local v123 = l__ldexp__10(v122, 32);
            local l__x__128 = p116.x;
            local l__w__129 = p116.w;
            local v124 = l__bxor__4(l__x__128, (l__lshift__7(l__x__128, 11)));
            local v125 = l__bxor__4(l__bxor__4(l__bxor__4(v124, (l__rshift__8(v124, 8))), l__w__129), (l__rshift__8(l__w__129, 19)));
            local l__y__130 = p116.y;
            local l__z__131 = p116.z;
            p116.x = l__y__130;
            p116.y = l__z__131;
            p116.z = l__w__129;
            p116.w = v125;
            local v126 = l__floor__9(v120 * l__ldexp__10(v123 + v125, -64) + 1);
            local v127 = p117[v126];
            local v128 = p117[v119];
            p117[v119] = v127;
            p117[v126] = v128;
        end;
    end,
    Clone = function(p129) --[[ Name: Clone, Line 204 ]]
        local v130 = {
            x = p129.x,
            y = p129.y,
            z = p129.z,
            w = p129.w
        };
        local v131 = getmetatable(p129);
        return setmetatable(v130, v131);
    end,
    GetState = function(p132) --[[ Name: GetState, Line 214 ]]
        return {
            p132.x,
            p132.y,
            p132.z,
            p132.w
        };
    end,
    Skip = function(p133, p134) --[[ Name: Skip, Line 218 ]]
        -- upvalues: l__floor__9 (copy), l__Theory__3 (copy)
        local v135;
        if type(p134) == "number" and (l__floor__9(p134) == p134 and p134 ~= (1 / 0)) then
            v135 = p134 ~= (-1 / 0);
        else
            v135 = false;
        end;
        if not v135 then
            error("Integer", 2);
        end;
        local v136, v137, v138, v139 = l__Theory__3.Transform(p133.x, p133.y, p133.z, p133.w, p134);
        p133.x = v136;
        p133.y = v137;
        p133.z = v138;
        p133.w = v139;
    end
});
local u141 = table.freeze({
    __index = v140
});
local u144 = {
    new = function(p142) --[[ Name: new, Line 246 ]]
        -- upvalues: u19 (copy), u141 (copy)
        local v143 = {
            x = 0,
            y = 0,
            z = 0,
            w = 0
        };
        u19(v143, p142);
        return setmetatable(v143, u141);
    end
};
function u144.Unique(p145) --[[ Line: 257 ]]
    -- upvalues: l__floor__9 (copy), l__clamp__16 (copy), u144 (copy), l__GenerateSeed__2 (copy)
    if p145 ~= nil then
        local v146;
        if type(p145) == "number" and (l__floor__9(p145) == p145 and p145 ~= (1 / 0)) then
            v146 = p145 ~= (-1 / 0);
        else
            v146 = false;
        end;
        if not v146 then
            error("Integer", 2);
        end;
        if p145 < 0 then
            error("NonNegative", 2);
        end;
    end;
    local v147 = l__clamp__16(p145 or 4, 0, 4);
    return u144.new(l__GenerateSeed__2(v147));
end;
u144.R = u144.Unique();
return table.freeze(u144);