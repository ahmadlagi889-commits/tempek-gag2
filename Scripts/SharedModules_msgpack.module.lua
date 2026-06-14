-- Decompiled with Potassium's decompiler.

local l__EncodingService__1 = game:GetService("EncodingService");
local u1 = newproxy(false);
local u2 = {};
function u2.new(p3, p4) --[[ Line: 22 ]]
    -- upvalues: u2 (copy)
    return {
        _msgpackType = u2,
        type = p3,
        data = p4
    };
end;
table.freeze(u2);
local u5 = {};
function u5.new(p6, p7) --[[ Line: 38 ]]
    -- upvalues: u5 (copy)
    return {
        _msgpackType = u5,
        mostSignificantPart = p6,
        leastSignificantPart = p7
    };
end;
table.freeze(u5);
local u8 = {};
function u8.new(p9, p10) --[[ Line: 54 ]]
    -- upvalues: u8 (copy)
    return {
        _msgpackType = u8,
        mostSignificantPart = p9,
        leastSignificantPart = p10
    };
end;
table.freeze(u8);
local function u128(p11, p12) --[[ Line: 138 ]]
    -- upvalues: u1 (copy), u2 (copy), u128 (copy)
    local v13 = buffer.readu8(p11, p12);
    if v13 == 192 then
        return u1, p12 + 1;
    elseif v13 == 194 then
        return false, p12 + 1;
    elseif v13 == 195 then
        return true, p12 + 1;
    elseif v13 == 196 then
        local v14 = buffer.readu8(p11, p12 + 1);
        local v15 = buffer.create(v14);
        buffer.copy(v15, 0, p11, p12 + 2, v14);
        return v15, p12 + 2 + v14;
    elseif v13 == 197 then
        local v16 = buffer.readu16(p11, p12 + 1);
        local v17 = bit32.band(v16, 65535);
        local v18 = bit32.rshift(v17, 8);
        local v19 = bit32.lshift(v17, 8);
        local v20 = bit32.band(v19, 65535);
        local v21 = bit32.bor(v18, v20);
        local v22 = buffer.create(v21);
        buffer.copy(v22, 0, p11, p12 + 3, v21);
        return v22, p12 + 3 + v21;
    elseif v13 == 198 then
        local v23 = buffer.readu32(p11, p12 + 1);
        local v24 = bit32.byteswap(v23);
        local v25 = buffer.create(v24);
        buffer.copy(v25, 0, p11, p12 + 5, v24);
        return v25, p12 + 5 + v24;
    elseif v13 == 199 then
        local v26 = buffer.readu8(p11, p12 + 1);
        local v27 = buffer.create(v26);
        buffer.copy(v27, 0, p11, p12 + 3, v26);
        return {
            _msgpackType = u2,
            type = buffer.readu8(p11, p12 + 2),
            data = v27
        }, p12 + 3 + v26;
    elseif v13 == 200 then
        local v28 = buffer.readu16(p11, p12 + 1);
        local v29 = bit32.band(v28, 65535);
        local v30 = bit32.rshift(v29, 8);
        local v31 = bit32.lshift(v29, 8);
        local v32 = bit32.band(v31, 65535);
        local v33 = bit32.bor(v30, v32);
        local v34 = buffer.create(v33);
        buffer.copy(v34, 0, p11, p12 + 4, v33);
        return {
            _msgpackType = u2,
            type = buffer.readu8(p11, p12 + 3),
            data = v34
        }, p12 + 4 + v33;
    elseif v13 == 201 then
        local v35 = buffer.readu32(p11, p12 + 1);
        local v36 = bit32.byteswap(v35);
        local v37 = buffer.create(v36);
        buffer.copy(v37, 0, p11, p12 + 6, v36);
        return {
            _msgpackType = u2,
            type = buffer.readu8(p11, p12 + 5),
            data = v37
        }, p12 + 6 + v36;
    elseif v13 == 202 then
        local v38 = p12 + 1;
        local v39 = buffer.readu32(p11, v38);
        local v40 = bit32.byteswap(v39);
        buffer.writeu32(p11, v38, v40);
        return buffer.readf32(p11, v38), p12 + 5;
    elseif v13 == 203 then
        local v41 = p12 + 1;
        local v42 = buffer.readu32(p11, v41);
        local v43 = bit32.byteswap(v42);
        local v44 = buffer.readu32(p11, v41 + 4);
        local v45 = bit32.byteswap(v44);
        buffer.writeu32(p11, v41, v45);
        buffer.writeu32(p11, v41 + 4, v43);
        return buffer.readf64(p11, v41), p12 + 9;
    elseif v13 == 204 then
        return buffer.readu8(p11, p12 + 1), p12 + 2;
    elseif v13 == 205 then
        local v46 = buffer.readu16(p11, p12 + 1);
        local v47 = bit32.band(v46, 65535);
        local v48 = bit32.rshift(v47, 8);
        local v49 = bit32.lshift(v47, 8);
        local v50 = bit32.band(v49, 65535);
        return bit32.bor(v48, v50), p12 + 3;
    elseif v13 == 206 then
        local v51 = buffer.readu32(p11, p12 + 1);
        return bit32.byteswap(v51), p12 + 5;
    elseif v13 == 207 then
        local v52 = buffer.readu32(p11, p12 + 1);
        local v53 = bit32.byteswap(v52);
        local v54 = buffer.readu32(p11, p12 + 5);
        local v55 = bit32.byteswap(v54);
        return v53 * 4294967296 + v55, p12 + 9;
    elseif v13 == 208 then
        return buffer.readi8(p11, p12 + 1), p12 + 2;
    elseif v13 == 209 then
        local v56 = buffer.readu16(p11, p12 + 1);
        local v57 = bit32.band(v56, 65535);
        local v58 = bit32.rshift(v57, 8);
        local v59 = bit32.lshift(v57, 8);
        local v60 = bit32.band(v59, 65535);
        local v61 = bit32.bor(v58, v60);
        if v61 >= 32768 then
            v61 = v61 - 65536;
        end;
        return v61, p12 + 3;
    elseif v13 == 210 then
        local v62 = buffer.readu32(p11, p12 + 1);
        local v63 = bit32.byteswap(v62);
        if v63 >= 2147483648 then
            v63 = v63 - 4294967296;
        end;
        return v63, p12 + 5;
    elseif v13 == 211 then
        local v64 = buffer.readu32(p11, p12 + 1);
        local v65 = bit32.byteswap(v64);
        local v66 = buffer.readu32(p11, p12 + 5);
        local v67 = bit32.byteswap(v66);
        if v65 >= 2147483648 then
            return (v65 - 4294967296) * 4294967296 + v67, p12 + 9;
        else
            return v65 * 4294967296 + v67, p12 + 9;
        end;
    else
        if v13 == 212 then
            local v68 = buffer.create(1);
            buffer.copy(v68, 0, p11, p12 + 2, 1);
            return {
                _msgpackType = u2,
                type = buffer.readu8(p11, p12 + 1),
                data = v68
            }, p12 + 3;
        end;
        if v13 == 213 then
            local v69 = buffer.create(2);
            buffer.copy(v69, 0, p11, p12 + 2, 2);
            return {
                _msgpackType = u2,
                type = buffer.readu8(p11, p12 + 1),
                data = v69
            }, p12 + 4;
        end;
        if v13 == 214 then
            local v70 = buffer.create(4);
            buffer.copy(v70, 0, p11, p12 + 2, 4);
            return {
                _msgpackType = u2,
                type = buffer.readu8(p11, p12 + 1),
                data = v70
            }, p12 + 6;
        end;
        if v13 == 215 then
            local v71 = buffer.create(8);
            buffer.copy(v71, 0, p11, p12 + 2, 8);
            return {
                _msgpackType = u2,
                type = buffer.readu8(p11, p12 + 1),
                data = v71
            }, p12 + 10;
        end;
        if v13 == 216 then
            local v72 = buffer.create(16);
            buffer.copy(v72, 0, p11, p12 + 2, 16);
            return {
                _msgpackType = u2,
                type = buffer.readu8(p11, p12 + 1),
                data = v72
            }, p12 + 18;
        end;
        if v13 == 217 then
            local v73 = buffer.readu8(p11, p12 + 1);
            return buffer.readstring(p11, p12 + 2, v73), p12 + 2 + v73;
        end;
        if v13 == 218 then
            local v74 = buffer.readu16(p11, p12 + 1);
            local v75 = bit32.band(v74, 65535);
            local v76 = bit32.rshift(v75, 8);
            local v77 = bit32.lshift(v75, 8);
            local v78 = bit32.band(v77, 65535);
            local v79 = bit32.bor(v76, v78);
            return buffer.readstring(p11, p12 + 3, v79), p12 + 3 + v79;
        end;
        if v13 == 219 then
            local v80 = buffer.readu32(p11, p12 + 1);
            local v81 = bit32.byteswap(v80);
            return buffer.readstring(p11, p12 + 5, v81), p12 + 5 + v81;
        end;
        if v13 == 220 then
            local v82 = buffer.readu16(p11, p12 + 1);
            local v83 = bit32.band(v82, 65535);
            local v84 = bit32.rshift(v83, 8);
            local v85 = bit32.lshift(v83, 8);
            local v86 = bit32.band(v85, 65535);
            local v87 = bit32.bor(v84, v86);
            local v88 = table.create(v87);
            local v89 = p12 + 3;
            for v90 = 1, v87 do
                local v91;
                v91, v89 = u128(p11, v89);
                v88[v90] = v91;
            end;
            return v88, v89;
        end;
        if v13 == 221 then
            local v92 = buffer.readu32(p11, p12 + 1);
            local v93 = bit32.byteswap(v92);
            local v94 = table.create(v93);
            local v95 = p12 + 5;
            for v96 = 1, v93 do
                local v97;
                v97, v95 = u128(p11, v95);
                v94[v96] = v97;
            end;
            return v94, v95;
        end;
        if v13 == 222 then
            local v98 = buffer.readu16(p11, p12 + 1);
            local v99 = bit32.band(v98, 65535);
            local v100 = bit32.rshift(v99, 8);
            local v101 = bit32.lshift(v99, 8);
            local v102 = bit32.band(v101, 65535);
            local v103 = bit32.bor(v100, v102);
            local v104 = p12 + 3;
            local v105 = {};
            for _ = 1, v103 do
                local v106, v107 = u128(p11, v104);
                local v108;
                v108, v104 = u128(p11, v107);
                v105[v106] = v108;
            end;
            return v105, v104;
        end;
        if v13 == 223 then
            local v109 = buffer.readu32(p11, p12 + 1);
            local v110 = bit32.byteswap(v109);
            local v111 = p12 + 5;
            local v112 = {};
            for _ = 1, v110 do
                local v113, v114 = u128(p11, v111);
                local v115;
                v115, v111 = u128(p11, v114);
                v112[v113] = v115;
            end;
            return v112, v111;
        end;
        if v13 >= 224 then
            return v13 - 256, p12 + 1;
        end;
        if v13 <= 127 then
            return v13, p12 + 1;
        end;
        if v13 - 128 <= 15 then
            local v116 = bit32.band(v13, 15);
            local v117 = p12 + 1;
            local v118 = {};
            for _ = 1, v116 do
                local v119, v120 = u128(p11, v117);
                local v121;
                v121, v117 = u128(p11, v120);
                v118[v119] = v121;
            end;
            return v118, v117;
        end;
        if v13 - 144 <= 15 then
            local v122 = bit32.band(v13, 15);
            local v123 = table.create(v122);
            local v124 = p12 + 1;
            for v125 = 1, v122 do
                local v126;
                v126, v124 = u128(p11, v124);
                v123[v125] = v126;
            end;
            return v123, v124;
        end;
        if v13 - 160 <= 31 then
            local v127 = v13 - 160;
            return buffer.readstring(p11, p12 + 1, v127), p12 + 1 + v127;
        end;
        error("Unknown type");
    end;
end;
local function u133(p129, p130) --[[ Line: 303 ]]
    local v131 = buffer.len(p129);
    if p130 <= v131 then
        return p129;
    end;
    while v131 < p130 do
        v131 = v131 * 2;
    end;
    local v132 = buffer.create(v131);
    buffer.copy(v132, 0, p129);
    return v132;
end;
local u134 = {
    [1] = 212,
    [2] = 213,
    [4] = 214,
    [8] = 215,
    [16] = 216
};
local function u252(p135, p136, p137, p138) --[[ Line: 324 ]]
    -- upvalues: u1 (copy), u133 (copy), u5 (copy), u8 (copy), u2 (copy), u134 (copy), u252 (copy)
    if p137 == u1 then
        p137 = nil;
    end;
    local v139 = type(p137);
    if p137 == nil then
        local v140 = u133(p135, p136 + 1);
        buffer.writestring(v140, p136, "\192");
        return v140, p136 + 1;
    end;
    if p137 == false then
        local v141 = u133(p135, p136 + 1);
        buffer.writestring(v141, p136, "\194");
        return v141, p136 + 1;
    end;
    if p137 == true then
        local v142 = u133(p135, p136 + 1);
        buffer.writestring(v142, p136, "\195");
        return v142, p136 + 1;
    end;
    if v139 == "string" then
        local v143 = #p137;
        if v143 <= 31 then
            local v144 = u133(p135, p136 + 1 + v143);
            local v145 = bit32.bor(160, v143);
            buffer.writeu8(v144, p136, v145);
            buffer.writestring(v144, p136 + 1, p137);
            return v144, p136 + 1 + v143;
        end;
        if v143 <= 255 then
            local v146 = u133(p135, p136 + 2 + v143);
            buffer.writeu8(v146, p136, 217);
            buffer.writeu8(v146, p136 + 1, v143);
            buffer.writestring(v146, p136 + 2, p137);
            return v146, p136 + 2 + v143;
        end;
        if v143 <= 65535 then
            local v147 = u133(p135, p136 + 3 + v143);
            buffer.writeu8(v147, p136, 218);
            local v148 = p136 + 1;
            local v149 = bit32.band(v143, 65535);
            local v150 = bit32.rshift(v149, 8);
            local v151 = bit32.lshift(v149, 8);
            local v152 = bit32.band(v151, 65535);
            local v153 = bit32.bor(v150, v152);
            buffer.writeu16(v147, v148, v153);
            buffer.writestring(v147, p136 + 3, p137);
            return v147, p136 + 3 + v143;
        end;
        if v143 <= 4294967295 then
            local v154 = u133(p135, p136 + 5 + v143);
            buffer.writeu8(v154, p136, 219);
            local v155 = p136 + 1;
            local v156 = bit32.byteswap(v143);
            buffer.writeu32(v154, v155, v156);
            buffer.writestring(v154, p136 + 5, p137);
            return v154, p136 + 5 + v143;
        end;
        error("Could not encode - too long string");
    elseif v139 == "buffer" then
        local v157 = buffer.len(p137);
        if v157 <= 255 then
            local v158 = u133(p135, p136 + 2 + v157);
            buffer.writeu8(v158, p136, 196);
            buffer.writeu8(v158, p136 + 1, v157);
            buffer.copy(v158, p136 + 2, p137);
            return v158, p136 + 2 + v157;
        end;
        if v157 <= 65535 then
            local v159 = u133(p135, p136 + 3 + v157);
            buffer.writeu8(v159, p136, 197);
            local v160 = p136 + 1;
            local v161 = bit32.band(v157, 65535);
            local v162 = bit32.rshift(v161, 8);
            local v163 = bit32.lshift(v161, 8);
            local v164 = bit32.band(v163, 65535);
            local v165 = bit32.bor(v162, v164);
            buffer.writeu16(v159, v160, v165);
            buffer.copy(v159, p136 + 3, p137);
            return v159, p136 + 3 + v157;
        end;
        if v157 <= 4294967295 then
            local v166 = u133(p135, p136 + 5 + v157);
            buffer.writeu8(v166, p136, 198);
            local v167 = p136 + 1;
            local v168 = bit32.byteswap(v157);
            buffer.writeu32(v166, v167, v168);
            buffer.copy(v166, p136 + 5, p137);
            return v166, p136 + 5 + v157;
        end;
        error("Could not encode - too long binary buffer");
    elseif v139 == "number" then
        if p137 == 0 then
            local v169 = u133(p135, p136 + 1);
            buffer.writeu8(v169, p136, 0);
            return v169, p136 + 1;
        end;
        if p137 ~= p137 then
            local v170 = u133(p135, p136 + 5);
            buffer.writestring(v170, p136, "\202\127\128\0\1");
            return v170, p136 + 5;
        end;
        if p137 == (1 / 0) then
            local v171 = u133(p135, p136 + 5);
            buffer.writestring(v171, p136, "\202\127\128\0\0");
            return v171, p136 + 5;
        end;
        if p137 == (-1 / 0) then
            local v172 = u133(p135, p136 + 5);
            buffer.writestring(v172, p136, "\202\255\128\0\0");
            return v172, p136 + 5;
        end;
        local v173, v174 = math.modf(p137);
        local v175 = math.sign(p137);
        if v174 ~= 0 or (v173 > 4294967295 or v173 < -2147483648) then
            local v176 = u133(p135, p136 + 9);
            buffer.writeu8(v176, p136, 203);
            local v177 = p136 + 1;
            buffer.writef64(v176, v177, p137);
            local v178 = buffer.readu32(v176, v177);
            local v179 = bit32.byteswap(v178);
            local v180 = buffer.readu32(v176, v177 + 4);
            local v181 = bit32.byteswap(v180);
            buffer.writeu32(v176, v177, v181);
            buffer.writeu32(v176, v177 + 4, v179);
            return v176, p136 + 9;
        end;
        if v175 > 0 then
            if v173 <= 127 then
                local v182 = u133(p135, p136 + 1);
                buffer.writeu8(v182, p136, v173);
                return v182, p136 + 1;
            end;
            if v173 <= 255 then
                local v183 = u133(p135, p136 + 2);
                buffer.writeu8(v183, p136, 204);
                buffer.writeu8(v183, p136 + 1, v173);
                return v183, p136 + 2;
            end;
            if v173 <= 65535 then
                local v184 = u133(p135, p136 + 3);
                buffer.writeu8(v184, p136, 205);
                local v185 = p136 + 1;
                local v186 = bit32.band(v173, 65535);
                local v187 = bit32.rshift(v186, 8);
                local v188 = bit32.lshift(v186, 8);
                local v189 = bit32.band(v188, 65535);
                local v190 = bit32.bor(v187, v189);
                buffer.writeu16(v184, v185, v190);
                return v184, p136 + 3;
            end;
            if v173 <= 4294967295 then
                local v191 = u133(p135, p136 + 5);
                buffer.writeu8(v191, p136, 206);
                local v192 = p136 + 1;
                local v193 = bit32.byteswap(v173);
                buffer.writeu32(v191, v192, v193);
                return v191, p136 + 5;
            end;
        else
            if v173 >= -32 then
                local v194 = u133(p135, p136 + 1);
                local v195 = bit32.extract(v173, 0, 5);
                local v196 = bit32.bor(224, v195);
                buffer.writeu8(v194, p136, v196);
                return v194, p136 + 1;
            end;
            if v173 >= -128 then
                local v197 = u133(p135, p136 + 2);
                buffer.writeu8(v197, p136, 208);
                buffer.writei8(v197, p136 + 1, v173);
                return v197, p136 + 2;
            end;
            if v173 >= -32768 then
                local v198 = u133(p135, p136 + 3);
                buffer.writeu8(v198, p136, 209);
                local v199 = p136 + 1;
                local v200 = bit32.band(v173, 65535);
                local v201 = bit32.rshift(v200, 8);
                local v202 = bit32.lshift(v200, 8);
                local v203 = bit32.band(v202, 65535);
                local v204 = bit32.bor(v201, v203);
                buffer.writeu16(v198, v199, v204);
                return v198, p136 + 3;
            end;
            if v173 >= -2147483648 then
                local v205 = u133(p135, p136 + 5);
                buffer.writeu8(v205, p136, 210);
                local v206 = p136 + 1;
                local v207 = bit32.byteswap(v173);
                buffer.writeu32(v205, v206, v207);
                return v205, p136 + 5;
            end;
        end;
        error(string.format("Could not encode - unhandled number \"%s\"", (typeof(p137))));
    elseif v139 == "table" then
        local l___msgpackType__2 = p137._msgpackType;
        if l___msgpackType__2 then
            if l___msgpackType__2 == u5 or l___msgpackType__2 == u8 then
                local v208 = u133(p135, p136 + 9);
                buffer.writeu8(v208, p136, l___msgpackType__2 == u8 and 207 or 211);
                local v209 = p136 + 1;
                local v210 = bit32.byteswap(p137.mostSignificantPart);
                buffer.writeu32(v208, v209, v210);
                local v211 = p136 + 5;
                local v212 = bit32.byteswap(p137.leastSignificantPart);
                buffer.writeu32(v208, v211, v212);
                return v208, p136 + 9;
            end;
            if l___msgpackType__2 == u2 then
                local v213 = buffer.len(p137.data);
                local v214 = u134[v213];
                if v214 then
                    local v215 = u133(p135, p136 + 2 + v213);
                    buffer.writeu8(v215, p136, v214);
                    buffer.writeu8(v215, p136 + 1, p137.type);
                    buffer.copy(v215, p136 + 2, p137.data);
                    return v215, p136 + 2 + v213;
                end;
                if v213 <= 255 then
                    local v216 = u133(p135, p136 + 3 + v213);
                    buffer.writeu8(v216, p136, 199);
                    buffer.writeu8(v216, p136 + 1, v213);
                    buffer.writeu8(v216, p136 + 2, p137.type);
                    buffer.copy(v216, p136 + 3, p137.data);
                    return v216, p136 + 3 + v213;
                end;
                if v213 <= 65535 then
                    local v217 = u133(p135, p136 + 4 + v213);
                    buffer.writeu8(v217, p136, 200);
                    local v218 = p136 + 1;
                    local v219 = bit32.band(v213, 65535);
                    local v220 = bit32.rshift(v219, 8);
                    local v221 = bit32.lshift(v219, 8);
                    local v222 = bit32.band(v221, 65535);
                    local v223 = bit32.bor(v220, v222);
                    buffer.writeu16(v217, v218, v223);
                    buffer.writeu8(v217, p136 + 3, p137.type);
                    buffer.copy(v217, p136 + 4, p137.data);
                    return v217, p136 + 4 + v213;
                end;
                if v213 <= 4294967295 then
                    local v224 = u133(p135, p136 + 6 + v213);
                    buffer.writeu8(v224, p136, 201);
                    local v225 = p136 + 1;
                    local v226 = bit32.byteswap(v213);
                    buffer.writeu32(v224, v225, v226);
                    buffer.writeu8(v224, p136 + 5, p137.type);
                    buffer.copy(v224, p136 + 6, p137.data);
                    return v224, p136 + 6 + v213;
                end;
                error("Could not encode - too long extension data");
            end;
        end;
        if p138[p137] then
            error("Can not serialize cyclic table");
        else
            p138[p137] = true;
        end;
        local v227 = #p137;
        local v228 = 0;
        for _, _ in pairs(p137) do
            v228 = v228 + 1;
        end;
        if v227 == v228 then
            if v227 <= 15 then
                p135 = u133(p135, p136 + 1);
                local v229 = bit32.bor(144, v228);
                buffer.writeu8(p135, p136, v229);
                p136 = p136 + 1;
            elseif v227 <= 65535 then
                p135 = u133(p135, p136 + 3);
                buffer.writeu8(p135, p136, 220);
                local v230 = p136 + 1;
                local v231 = bit32.band(v227, 65535);
                local v232 = bit32.rshift(v231, 8);
                local v233 = bit32.lshift(v231, 8);
                local v234 = bit32.band(v233, 65535);
                local v235 = bit32.bor(v232, v234);
                buffer.writeu16(p135, v230, v235);
                p136 = p136 + 3;
            elseif v227 <= 4294967295 then
                p135 = u133(p135, p136 + 5);
                buffer.writeu8(p135, p136, 221);
                local v236 = p136 + 1;
                local v237 = bit32.byteswap(v227);
                buffer.writeu32(p135, v236, v237);
                p136 = p136 + 5;
            else
                error("Could not encode - too long array");
            end;
            for _, v238 in ipairs(p137) do
                p135, p136 = u252(p135, p136, v238, p138);
            end;
            return p135, p136;
        else
            if v228 <= 15 then
                p135 = u133(p135, p136 + 1);
                local v239 = bit32.bor(128, v228);
                buffer.writeu8(p135, p136, v239);
                p136 = p136 + 1;
            elseif v228 <= 65535 then
                p135 = u133(p135, p136 + 3);
                buffer.writeu8(p135, p136, 222);
                local v240 = p136 + 1;
                local v241 = bit32.band(v228, 65535);
                local v242 = bit32.rshift(v241, 8);
                local v243 = bit32.lshift(v241, 8);
                local v244 = bit32.band(v243, 65535);
                local v245 = bit32.bor(v242, v244);
                buffer.writeu16(p135, v240, v245);
                p136 = p136 + 3;
            elseif v228 <= 4294967295 then
                p135 = u133(p135, p136 + 5);
                buffer.writeu8(p135, p136, 223);
                local v246 = p136 + 1;
                local v247 = bit32.byteswap(v228);
                buffer.writeu32(p135, v246, v247);
                p136 = p136 + 5;
            else
                error("Could not encode - too long map");
            end;
            for v248, v249 in pairs(p137) do
                local v250, v251 = u252(p135, p136, v248, p138);
                p135, p136 = u252(v250, v251, v249, p138);
            end;
            return p135, p136;
        end;
    end;
    error(string.format("Could not encode - unsupported datatype \"%s\"", (typeof(p137))));
end;
local u253 = buffer.create(4096);
return table.freeze({
    Null = u1,
    Coalesce = function(p254, p255) --[[ Name: Coalesce, Line 9 ]]
        -- upvalues: u1 (copy)
        if p254 == u1 then
            return p255;
        else
            return p254;
        end;
    end,
    Optional = function(p256) --[[ Name: Optional, Line 13 ]]
        -- upvalues: u1 (copy)
        if p256 == nil then
            return u1;
        else
            return p256;
        end;
    end,
    Int64 = u5,
    UInt64 = u8,
    Extension = u2,
    uint64 = function(p257) --[[ Name: uint64, Line 681 ]]
        -- upvalues: u8 (copy)
        local v258, v259;
        if p257 < 0 then
            local v260 = -1 - p257;
            v258 = bit32.bnot(v260 // 4294967296);
            v259 = bit32.bnot(v260);
        else
            v258 = bit32.bor(p257 // 4294967296, 0);
            v259 = bit32.bor(p257, 0);
        end;
        return {
            _msgpackType = u8,
            mostSignificantPart = v258,
            leastSignificantPart = v259
        };
    end,
    int64 = function(p261) --[[ Name: int64, Line 686 ]]
        -- upvalues: u5 (copy)
        local v262, v263;
        if p261 < 0 then
            local v264 = -1 - p261;
            v262 = bit32.bnot(v264 // 4294967296);
            v263 = bit32.bnot(v264);
        else
            v262 = bit32.bor(p261 // 4294967296, 0);
            v263 = bit32.bor(p261, 0);
        end;
        return {
            _msgpackType = u5,
            mostSignificantPart = v262,
            leastSignificantPart = v263
        };
    end,
    uint64optional = function(p265) --[[ Name: uint64optional, Line 691 ]]
        -- upvalues: u8 (copy)
        if p265 == nil then
            return nil;
        end;
        local v266, v267;
        if p265 < 0 then
            local v268 = -1 - p265;
            v266 = bit32.bnot(v268 // 4294967296);
            v267 = bit32.bnot(v268);
        else
            v266 = bit32.bor(p265 // 4294967296, 0);
            v267 = bit32.bor(p265, 0);
        end;
        return {
            _msgpackType = u8,
            mostSignificantPart = v266,
            leastSignificantPart = v267
        };
    end,
    int64optional = function(p269) --[[ Name: int64optional, Line 698 ]]
        -- upvalues: u5 (copy)
        if p269 == nil then
            return nil;
        end;
        local v270, v271;
        if p269 < 0 then
            local v272 = -1 - p269;
            v270 = bit32.bnot(v272 // 4294967296);
            v271 = bit32.bnot(v272);
        else
            v270 = bit32.bor(p269 // 4294967296, 0);
            v271 = bit32.bor(p269, 0);
        end;
        return {
            _msgpackType = u5,
            mostSignificantPart = v270,
            leastSignificantPart = v271
        };
    end,
    utf8Encode = function(p273) --[[ Name: utf8Encode, Line 594 ]]
        local v274 = math.ceil(#p273 * 1.1428571428571428);
        local v275 = buffer.create(v274);
        local v276 = 0;
        for v277 = 1, v274 do
            local v278 = math.floor(v276 / 8) + 1;
            local v279 = v276 % 8;
            local v280 = string.byte(p273, v278);
            if v279 == 0 then
                local v281 = v277 - 1;
                local v282 = bit32.extract(v280, 1, 7);
                buffer.writeu8(v275, v281, v282);
            elseif v279 == 1 then
                local v283 = v277 - 1;
                local v284 = bit32.extract(v280, 0, 7);
                buffer.writeu8(v275, v283, v284);
            else
                local v285 = string.byte(p273, v278 + 1) or 0;
                local v286 = v277 - 1;
                local v287 = bit32.extract(v280, 0, 8 - v279);
                local v288 = bit32.lshift(v287, v279 - 1);
                local v289 = bit32.extract(v285, 9 - v279, v279 - 1);
                local v290 = bit32.bor(v288, v289);
                buffer.writeu8(v275, v286, v290);
            end;
            v276 = v276 + 7;
        end;
        return buffer.tostring(v275);
    end,
    utf8Decode = function(p291) --[[ Name: utf8Decode, Line 623 ]]
        local v292 = math.floor(#p291 * 7 / 8);
        local v293 = buffer.create(v292);
        local v294 = 0;
        for v295 = 1, v292 do
            local v296 = v294 % 7;
            local v297 = math.floor(v294 / 7) + 1;
            local v298 = string.byte(p291, v297);
            local v299 = math.floor(v294 / 7) + 2;
            local v300 = string.byte(p291, v299);
            local v301 = v295 - 1;
            local v302 = bit32.extract(v298, 0, 7 - v296);
            local v303 = bit32.lshift(v302, v296 + 1);
            local v304 = bit32.extract(v300, 6 - v296, v296 + 1);
            local v305 = bit32.bor(v303, v304);
            buffer.writeu8(v293, v301, v305);
            v294 = v294 + 8;
        end;
        return buffer.tostring(v293);
    end,
    decode = function(p306) --[[ Name: decodeData, Line 644 ]]
        -- upvalues: u128 (copy)
        local v307 = type(p306) == "string";
        assert(v307, "must be string");
        assert(#p306 > 0, "input too short");
        return u128(buffer.fromstring(p306), 0);
    end,
    decodeBuffer = u128,
    encode = function(p308) --[[ Name: encodeData, Line 654 ]]
        -- upvalues: u252 (copy), u253 (ref)
        local v309, v310 = u252(u253, 0, p308, {});
        u253 = v309;
        return buffer.readstring(v309, 0, v310);
    end,
    encodeb64 = function(p311) --[[ Name: encodeb64, Line 660 ]]
        -- upvalues: u252 (copy), u253 (ref), l__EncodingService__1 (copy)
        local v312, v313 = u252(u253, 0, p311, {});
        u253 = v312;
        local v314 = buffer.create(v313);
        buffer.copy(v314, 0, v312, 0, v313);
        return buffer.tostring(l__EncodingService__1:Base64Encode(v314));
    end,
    decodeb64 = function(p315) --[[ Name: decodeb64, Line 668 ]]
        -- upvalues: l__EncodingService__1 (copy), u128 (copy)
        return u128(l__EncodingService__1:Base64Decode(buffer.fromstring(p315)), 0);
    end
});