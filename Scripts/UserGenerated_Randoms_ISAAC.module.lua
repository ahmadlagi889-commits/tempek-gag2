-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
require(l__ReplicatedStorage__1.UserGenerated.Randoms.Base);
local l__GenerateSeed__2 = require(l__ReplicatedStorage__1.UserGenerated.IO.Crypto.GenerateSeed);
local l__bxor__3 = bit32.bxor;
local l__bor__4 = bit32.bor;
local l__band__5 = bit32.band;
local l__lshift__6 = bit32.lshift;
local l__rshift__7 = bit32.rshift;
local l__floor__8 = math.floor;
local l__ldexp__9 = math.ldexp;
local l__sqrt__10 = math.sqrt;
local l__log__11 = math.log;
local l__max__12 = math.max;
local l__sin__13 = math.sin;
local l__cos__14 = math.cos;
local l__clamp__15 = math.clamp;
local l__create__16 = table.create;
local l__clone__17 = table.clone;
local l__format__18 = string.format;
local l__new__19 = Vector2.new;
local l__new__20 = Vector3.new;
assert(true);
local u1 = Random.new();
local function u27(p2) --[[ Line: 77 ]]
    -- upvalues: l__lshift__6 (copy), l__bxor__3 (copy), l__bor__4 (copy), l__rshift__7 (copy)
    local v3 = p2[1];
    local v4 = p2[2];
    local v5 = p2[3];
    local v6 = p2[4];
    local v7 = p2[5];
    local v8 = p2[6];
    local v9 = p2[7];
    local v10 = p2[8];
    local v11 = l__bxor__3(v3, (l__lshift__6(v4, 11)));
    local v12 = l__bor__4(v6 + v11, 0);
    local v13 = l__bxor__3(l__bor__4(v4 + v5, 0), (l__rshift__7(v5, 2)));
    local v14 = l__bor__4(v7 + v13, 0);
    local v15 = l__bxor__3(l__bor__4(v5 + v12, 0), (l__lshift__6(v12, 8)));
    local v16 = l__bor__4(v8 + v15, 0);
    local v17 = l__bxor__3(l__bor__4(v12 + v14, 0), (l__rshift__7(v14, 16)));
    local v18 = l__bor__4(v9 + v17, 0);
    local v19 = l__bxor__3(l__bor__4(v14 + v16, 0), (l__lshift__6(v16, 10)));
    local v20 = l__bor__4(v10 + v19, 0);
    local v21 = l__bxor__3(l__bor__4(v16 + v18, 0), (l__rshift__7(v18, 4)));
    local v22 = l__bor__4(v11 + v21, 0);
    local v23 = l__bxor__3(l__bor__4(v18 + v20, 0), (l__lshift__6(v20, 8)));
    local v24 = l__bor__4(v13 + v23, 0);
    local v25 = l__bxor__3(l__bor__4(v20 + v22, 0), (l__rshift__7(v22, 9)));
    local v26 = l__bor__4(v15 + v25, 0);
    p2[1] = l__bor__4(v22 + v24, 0);
    p2[2] = v24;
    p2[3] = v26;
    p2[4] = v17;
    p2[5] = v19;
    p2[6] = v21;
    p2[7] = v23;
    p2[8] = v25;
end;
local function u35(p28) --[[ Line: 92 ]]
    -- upvalues: l__bor__4 (copy), l__band__5 (copy), l__rshift__7 (copy), l__bxor__3 (copy), l__lshift__6 (copy)
    local l__AA__21 = p28.AA;
    local l__BB__22 = p28.BB;
    local l__CC__23 = p28.CC;
    local l__MM__24 = p28.MM;
    local l__RSL__25 = p28.RSL;
    local v29 = l__bor__4(l__CC__23 + 1, 0);
    local v30 = l__bor__4(l__BB__22 + v29, 0);
    for v31 = 1, 256 do
        local v32 = l__MM__24[v31];
        local v33 = l__band__5(v31, 3);
        if v33 == 0 then
            l__AA__21 = l__bxor__3(l__AA__21, (l__rshift__7(l__AA__21, 16)));
        elseif v33 == 1 then
            l__AA__21 = l__bxor__3(l__AA__21, (l__lshift__6(l__AA__21, 13)));
        elseif v33 == 2 then
            l__AA__21 = l__bxor__3(l__AA__21, (l__rshift__7(l__AA__21, 6)));
        elseif v33 == 3 then
            l__AA__21 = l__bxor__3(l__AA__21, (l__lshift__6(l__AA__21, 2)));
        end;
        l__AA__21 = l__bor__4(l__MM__24[l__band__5(v31 + 127, 255) + 1] + l__AA__21, 0);
        local v34 = l__bor__4(l__MM__24[l__band__5(l__rshift__7(v32, 2), 255) + 1] + l__AA__21 + v30, 0);
        l__MM__24[v31] = v34;
        v30 = l__bor__4(l__MM__24[l__band__5(l__rshift__7(v34, 10), 255) + 1] + v32, 0);
        l__RSL__25[v31] = v30;
    end;
    p28.AA = l__AA__21;
    p28.BB = v30;
    p28.CC = v29;
end;
local function u43(p36, p37) --[[ Line: 115 ]]
    -- upvalues: l__create__16 (copy), u27 (copy), l__bor__4 (copy)
    p36.AA = 0;
    p36.BB = 0;
    p36.CC = 0;
    p36.Count = 256;
    local l__MM__26 = p36.MM;
    local l__RSL__27 = p36.RSL;
    local v38 = l__create__16(8, 2654435769);
    u27(v38);
    u27(v38);
    u27(v38);
    u27(v38);
    for v39 = 0, 255, 8 do
        if p37 then
            for v40 = 1, 8 do
                v38[v40] = l__bor__4(v38[v40] + l__RSL__27[v39 + v40], 0);
            end;
        end;
        u27(v38);
        l__MM__26[v39 + 1] = v38[1];
        l__MM__26[v39 + 2] = v38[2];
        l__MM__26[v39 + 3] = v38[3];
        l__MM__26[v39 + 4] = v38[4];
        l__MM__26[v39 + 5] = v38[5];
        l__MM__26[v39 + 6] = v38[6];
        l__MM__26[v39 + 7] = v38[7];
        l__MM__26[v39 + 8] = v38[8];
    end;
    if p37 then
        for v41 = 0, 255, 8 do
            for v42 = 1, 8 do
                v38[v42] = l__bor__4(v38[v42] + l__MM__26[v41 + v42], 0);
            end;
            u27(v38);
            l__MM__26[v41 + 1] = v38[1];
            l__MM__26[v41 + 2] = v38[2];
            l__MM__26[v41 + 3] = v38[3];
            l__MM__26[v41 + 4] = v38[4];
            l__MM__26[v41 + 5] = v38[5];
            l__MM__26[v41 + 6] = v38[6];
            l__MM__26[v41 + 7] = v38[7];
            l__MM__26[v41 + 8] = v38[8];
        end;
    end;
end;
local function u52(p44, p45, p46) --[[ Line: 229 ]]
    -- upvalues: u1 (copy), l__bor__4 (copy), u43 (copy)
    if p45 == nil then
        p45 = { u1:NextInteger(0, 4294967295) };
    elseif type(p45) == "number" then
        p45 = { p45 };
    else
        local v47 = type(p45) == "table";
        assert(v47);
    end;
    if p46 == nil then
        p46 = true;
    else
        local v48 = type(p46) == "boolean";
        assert(v48);
    end;
    local v49 = math.min(256, #p45);
    local l__MM__28 = p44.MM;
    local l__RSL__29 = p44.RSL;
    for v50 = 1, 256 do
        l__MM__28[v50] = 0;
        l__RSL__29[v50] = 0;
    end;
    for v51 = 1, v49 do
        l__RSL__29[v51] = l__bor__4(p45[v51], 0);
    end;
    u43(p44, p46);
end;
local v143 = table.freeze({
    NextU32 = function(p53) --[[ Name: NextU32, Line 152 ]]
        -- upvalues: u35 (copy)
        local v54 = p53.Count + 1;
        if v54 > 256 then
            u35(p53);
            v54 = 1;
        end;
        p53.Count = v54;
        return p53.RSL[v54];
    end,
    NextU64 = function(p55) --[[ Name: NextU64, Line 162 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy)
        local v56 = p55.Count + 1;
        if v56 > 256 then
            u35(p55);
            v56 = 1;
        end;
        p55.Count = v56;
        local v57 = l__ldexp__9(p55.RSL[v56], 32);
        local v58 = p55.Count + 1;
        if v58 > 256 then
            u35(p55);
            v58 = 1;
        end;
        p55.Count = v58;
        return v57 + p55.RSL[v58];
    end,
    NextFloat = function(p59) --[[ Name: NextFloat, Line 166 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy)
        local v60 = p59.Count + 1;
        if v60 > 256 then
            u35(p59);
            v60 = 1;
        end;
        p59.Count = v60;
        return l__ldexp__9(p59.RSL[v60], -32);
    end,
    NextDouble = function(p61) --[[ Name: NextDouble, Line 170 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy)
        local v62 = p61.Count + 1;
        if v62 > 256 then
            u35(p61);
            v62 = 1;
        end;
        p61.Count = v62;
        local v63 = l__ldexp__9(p61.RSL[v62], 32);
        local v64 = p61.Count + 1;
        if v64 > 256 then
            u35(p61);
            v64 = 1;
        end;
        p61.Count = v64;
        return l__ldexp__9(v63 + p61.RSL[v64], -64);
    end,
    NextNumber = function(p65, p66, p67) --[[ Name: NextNumber, Line 174 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy)
        local v68 = p67 - p66;
        local v69 = p65.Count + 1;
        if v69 > 256 then
            u35(p65);
            v69 = 1;
        end;
        p65.Count = v69;
        local v70 = l__ldexp__9(p65.RSL[v69], 32);
        local v71 = p65.Count + 1;
        if v71 > 256 then
            u35(p65);
            v71 = 1;
        end;
        p65.Count = v71;
        return p66 + v68 * l__ldexp__9(v70 + p65.RSL[v71], -64);
    end,
    NextInteger = function(p72, p73, p74) --[[ Name: NextInteger, Line 178 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy), l__floor__8 (copy)
        local v75 = p74 - p73 + 1;
        local v76 = p72.Count + 1;
        if v76 > 256 then
            u35(p72);
            v76 = 1;
        end;
        p72.Count = v76;
        local v77 = l__ldexp__9(p72.RSL[v76], 32);
        local v78 = p72.Count + 1;
        if v78 > 256 then
            u35(p72);
            v78 = 1;
        end;
        p72.Count = v78;
        return l__floor__8(p73 + v75 * l__ldexp__9(v77 + p72.RSL[v78], -64));
    end,
    NextNormal = function(p79, p80, p81) --[[ Name: NextNormal, Line 182 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy), l__max__12 (copy), l__log__11 (copy), l__sqrt__10 (copy), l__cos__14 (copy), l__sin__13 (copy)
        local v82 = 2.2250738585072014e-308;
        local v83 = p79.Count + 1;
        if v83 > 256 then
            u35(p79);
            v83 = 1;
        end;
        p79.Count = v83;
        local v84 = l__ldexp__9(p79.RSL[v83], 32);
        local v85 = p79.Count + 1;
        if v85 > 256 then
            u35(p79);
            v85 = 1;
        end;
        p79.Count = v85;
        local v86 = l__sqrt__10(l__log__11((l__max__12(v82, (l__ldexp__9(v84 + p79.RSL[v85], -64))))) * -2) * (p81 or 0);
        local v87 = 6.283185307179586;
        local v88 = p79.Count + 1;
        if v88 > 256 then
            u35(p79);
            v88 = 1;
        end;
        p79.Count = v88;
        local v89 = l__ldexp__9(p79.RSL[v88], 32);
        local v90 = p79.Count + 1;
        if v90 > 256 then
            u35(p79);
            v90 = 1;
        end;
        p79.Count = v90;
        local v91 = v87 * l__ldexp__9(v89 + p79.RSL[v90], -64);
        local v92 = p80 or 0;
        return l__cos__14(v91) * v86 + v92, l__sin__13(v91) * v86 + v92;
    end,
    NextBoolean = function(p93, p94) --[[ Name: NextBoolean, Line 194 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy)
        local v95 = p93.Count + 1;
        if v95 > 256 then
            u35(p93);
            v95 = 1;
        end;
        p93.Count = v95;
        local v96 = l__ldexp__9(p93.RSL[v95], 32);
        local v97 = p93.Count + 1;
        if v97 > 256 then
            u35(p93);
            v97 = 1;
        end;
        p93.Count = v97;
        return l__ldexp__9(v96 + p93.RSL[v97], -64) < (p94 or 0.5);
    end,
    NextVector2 = function(p98, p99) --[[ Name: NextVector2, Line 198 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy), l__new__19 (copy), l__cos__14 (copy), l__sin__13 (copy)
        local v100 = p99 or 1;
        local v101 = 6.283185307179586;
        local v102 = p98.Count + 1;
        if v102 > 256 then
            u35(p98);
            v102 = 1;
        end;
        p98.Count = v102;
        local v103 = l__ldexp__9(p98.RSL[v102], 32);
        local v104 = p98.Count + 1;
        if v104 > 256 then
            u35(p98);
            v104 = 1;
        end;
        p98.Count = v104;
        local v105 = v101 * l__ldexp__9(v103 + p98.RSL[v104], -64);
        return l__new__19(l__cos__14(v105) * v100, l__sin__13(v105) * v100);
    end,
    NextVector3 = function(p106, p107) --[[ Name: NextVector3, Line 207 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy), l__sqrt__10 (copy), l__cos__14 (copy), l__sin__13 (copy), l__new__20 (copy)
        local v108 = p107 or 1;
        local v109 = 6.283185307179586;
        local v110 = p106.Count + 1;
        if v110 > 256 then
            u35(p106);
            v110 = 1;
        end;
        p106.Count = v110;
        local v111 = l__ldexp__9(p106.RSL[v110], 32);
        local v112 = p106.Count + 1;
        if v112 > 256 then
            u35(p106);
            v112 = 1;
        end;
        p106.Count = v112;
        local v113 = v109 * l__ldexp__9(v111 + p106.RSL[v112], -64);
        local v114 = p106.Count + 1;
        if v114 > 256 then
            u35(p106);
            v114 = 1;
        end;
        p106.Count = v114;
        local v115 = l__ldexp__9(p106.RSL[v114], 32);
        local v116 = p106.Count + 1;
        if v116 > 256 then
            u35(p106);
            v116 = 1;
        end;
        p106.Count = v116;
        local v117 = l__ldexp__9(v115 + p106.RSL[v116], -64) * 2 - 1;
        local v118 = l__sqrt__10(1 - v117 * v117);
        return l__new__20(l__cos__14(v113) * v118 * v108, l__sin__13(v113) * v118 * v108, v117 * v108);
    end,
    NextUUIDv4 = function(p119) --[[ Name: NextUUIDv4, Line 219 ]]
        -- upvalues: l__format__18 (copy), u35 (copy), l__band__5 (copy), l__bor__4 (copy)
        local v120 = l__format__18;
        local v121 = "%08x%08x%08x%08x";
        local v122 = p119.Count + 1;
        if v122 > 256 then
            u35(p119);
            v122 = 1;
        end;
        p119.Count = v122;
        local v123 = p119.RSL[v122];
        local v124 = p119.Count + 1;
        if v124 > 256 then
            u35(p119);
            v124 = 1;
        end;
        p119.Count = v124;
        local v125 = l__bor__4(l__band__5(p119.RSL[v124], 4294905855), 16384);
        local v126 = p119.Count + 1;
        if v126 > 256 then
            u35(p119);
            v126 = 1;
        end;
        p119.Count = v126;
        local v127 = l__bor__4(l__band__5(p119.RSL[v126], 1073741823), 2147483648);
        local v128 = p119.Count + 1;
        if v128 > 256 then
            u35(p119);
            v128 = 1;
        end;
        p119.Count = v128;
        return v120(v121, v123, v125, v127, p119.RSL[v128]);
    end,
    Seed = u52,
    Shuffle = function(p129, p130) --[[ Name: Shuffle, Line 260 ]]
        -- upvalues: u35 (copy), l__ldexp__9 (copy), l__floor__8 (copy)
        local v131 = type(p130) == "table";
        assert(v131);
        for v132 = #p130, 2, -1 do
            local v133 = v132 - 1 + 1;
            local v134 = p129.Count + 1;
            if v134 > 256 then
                u35(p129);
                v134 = 1;
            end;
            p129.Count = v134;
            local v135 = l__ldexp__9(p129.RSL[v134], 32);
            local v136 = p129.Count + 1;
            if v136 > 256 then
                u35(p129);
                v136 = 1;
            end;
            p129.Count = v136;
            local v137 = l__floor__8(v133 * l__ldexp__9(v135 + p129.RSL[v136], -64) + 1);
            local v138 = p130[v137];
            local v139 = p130[v132];
            p130[v132] = v138;
            p130[v137] = v139;
        end;
    end,
    Clone = function(p140) --[[ Name: Clone, Line 268 ]]
        -- upvalues: l__clone__17 (copy)
        local v141 = {
            RSL = l__clone__17(p140.RSL),
            Count = p140.Count,
            MM = l__clone__17(p140.MM),
            AA = p140.AA,
            BB = p140.BB,
            CC = p140.CC
        };
        local v142 = getmetatable(p140);
        return setmetatable(v141, v142);
    end
});
local u144 = table.freeze({
    __index = v143
});
local u148 = {
    new = function(p145, p146) --[[ Name: new, Line 300 ]]
        -- upvalues: l__create__16 (copy), u52 (copy), u144 (copy)
        local v147 = {
            Count = 0,
            AA = 0,
            BB = 0,
            CC = 0,
            RSL = l__create__16(256, 0),
            MM = l__create__16(256, 0)
        };
        u52(v147, p145, p146);
        return setmetatable(v147, u144);
    end
};
function u148.Unique(p149) --[[ Line: 316 ]]
    -- upvalues: l__floor__8 (copy), l__clamp__15 (copy), u148 (copy), l__GenerateSeed__2 (copy)
    if p149 ~= nil then
        local v150;
        if type(p149) == "number" and (l__floor__8(p149) == p149 and p149 ~= (1 / 0)) then
            v150 = p149 ~= (-1 / 0);
        else
            v150 = false;
        end;
        if not v150 then
            error("Integer", 2);
        end;
        if p149 < 0 then
            error("NonNegative", 2);
        end;
    end;
    local v151 = l__clamp__15(p149 or 32, 0, 256);
    return u148.new(l__GenerateSeed__2(v151), true);
end;
u148.R = u148.Unique();
return table.freeze(u148);