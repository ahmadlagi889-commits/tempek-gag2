-- Decompiled with Potassium's decompiler.

require(script.Types);
local l__chunks__1 = require(script.chunks);
local l__crc32__2 = require(script.crc32);
local l__zlib__3 = require(script.zlib);
local u1 = {
    [0] = 1,
    [2] = 3,
    [3] = 1,
    [4] = 2,
    [6] = 4
};
local u2 = {
    0,
    0,
    4,
    0,
    2,
    0,
    1
};
local u3 = {
    0,
    4,
    0,
    2,
    0,
    1,
    0
};
local u4 = {
    8,
    8,
    8,
    4,
    4,
    2,
    2
};
local u5 = {
    8,
    8,
    4,
    4,
    2,
    2,
    1
};
return {
    decode = function(p6, p7) --[[ Name: decode, Line 38 ]]
        -- upvalues: l__crc32__2 (copy), l__chunks__1 (copy), u1 (copy), u3 (copy), u5 (copy), u2 (copy), u4 (copy), l__zlib__3 (copy)
        local v8 = buffer.len(p6);
        assert(v8 >= 8, "not a PNG");
        local v9 = buffer.readstring(p6, 0, 8) == "\137PNG\r\n\26\n";
        assert(v9, "not a PNG");
        local v10 = table.create(3);
        local v11 = 8;
        local v12;
        if p7 == nil then
            v12 = false;
        elseif p7.allowIncorrectCRC == true then
            v12 = true;
        else
            v12 = false;
        end;
        local v13;
        while true do
            local v14 = buffer.readu32(p6, v11);
            local v15 = bit32.byteswap(v14);
            local v16 = buffer.readstring(p6, v11 + 4, 4);
            local v17 = string.match(v16, "%a%a%a%a");
            local v18 = `invalid chunk type {v16}`;
            assert(v17, v18);
            local v19 = v11 + 8;
            v13 = v19 + v15 + 4;
            local v20 = v13 <= v8;
            local v21 = `EOF while reading {v16} chunk`;
            assert(v20, v21);
            local v22 = buffer.readu32(p6, v13 - 4);
            local v23 = v12 or bit32.byteswap(v22) == l__crc32__2(p6, v11 + 4, v13 - 5);
            local v24 = `incorrect checksum in {v16}`;
            assert(v23, v24);
            table.insert(v10, {
                type = v16,
                offset = v19,
                length = v15
            });
            if v8 <= v13 then
                break;
            end;
            v11 = v13;
        end;
        assert(v13 == v8, "trailing data in file");
        for _, v25 in v10 do
            local l__type__4 = v25.type;
            local v26 = string.byte(l__type__4, 1, 1);
            if bit32.extract(v26, 5) == 0 and (l__type__4 ~= "IHDR" and (l__type__4 ~= "IDAT" and (l__type__4 ~= "PLTE" and l__type__4 ~= "IEND"))) then
                error((`unhandled critical chunk {l__type__4}`));
            end;
        end;
        local v27 = v10[1];
        assert(v27.type == "IHDR", "first chunk must be IHDR");
        for v28 = 2, #v10 do
            assert(v10[v28].type ~= "IHDR", "multiple IHDR chunks are not allowed");
        end;
        local v29 = l__chunks__1.IHDR(p6, v27);
        local v30 = -1;
        local v31 = -1;
        local v32 = 0;
        for v33, v34 in v10 do
            if v34.type == "IDAT" then
                if v30 < 0 then
                    v30 = v33;
                else
                    assert(v33 == v31 + 1, "multiple IDAT chunks must be consecutive");
                end;
                v32 = v32 + v34.length;
                v31 = v33;
            end;
        end;
        assert(v30 > 0, "no IDAT chunks");
        assert(v32 > 0, "no image data in IDAT chunks");
        local v35 = nil;
        local v36 = -1;
        for v37, v38 in v10 do
            if v38.type == "PLTE" then
                assert(not v35, "multiple PLTE chunks are not allowed");
                assert(v37 < v30, "PLTE not allowed after IDAT chunks");
                local v39;
                if v29.colorType == 0 then
                    v39 = false;
                else
                    v39 = v29.colorType ~= 4;
                end;
                assert(v39, "PLTE not allowed for color type");
                v35 = l__chunks__1.PLTE(p6, v38, v29);
                v36 = v37;
            end;
        end;
        if v29.colorType == 3 then
            assert(v35 ~= nil, "color type requires a PLTE chunk");
        end;
        local v40 = nil;
        for v41, v42 in v10 do
            if v42.type == "tRNS" then
                assert(v40 == nil, "multiple tRNS chunks are not allowed");
                assert(v41 < v30, "tRNS not allowed after IDAT chunks");
                assert(not v35 or v36 < v41, "tRNS must be after PLTE");
                local v43;
                if v29.colorType == 4 then
                    v43 = false;
                else
                    v43 = v29.colorType ~= 6;
                end;
                assert(v43, "tRNS not allowed for color type");
                v40 = l__chunks__1.tRNS(p6, v42, v29, v35);
            end;
        end;
        local v44 = v10[#v10];
        assert(v44.type == "IEND", "final chunk must be IEND");
        assert(v44.length == 0, "IEND chunk must be empty");
        for v45 = 2, #v10 - 1 do
            assert(v10[v45].type ~= "IEND", "multiple IEND chunks are not allowed");
        end;
        local v46 = buffer.create(v32);
        local v47 = 0;
        for _, v48 in v10 do
            if v48.type == "IDAT" then
                buffer.copy(v46, v47, p6, v48.offset, v48.length);
                v47 = v47 + v48.length;
            end;
        end;
        local l__width__5 = v29.width;
        local l__height__6 = v29.height;
        local l__bitDepth__7 = v29.bitDepth;
        local l__colorType__8 = v29.colorType;
        local u49 = u1[l__colorType__8];
        local v50 = 0;
        if v29.interlaced then
            for v51 = 1, 7 do
                local v52 = math.ceil((l__width__5 - u3[v51]) / u5[v51]);
                local v53 = math.ceil((l__height__6 - u2[v51]) / u4[v51]);
                if v52 > 0 and v53 > 0 then
                    v50 = v50 + v53 * (math.ceil(v52 * u49 * l__bitDepth__7 / 8) + 1);
                end;
            end;
        else
            v50 = l__height__6 * (math.ceil(l__width__5 * u49 * l__bitDepth__7 / 8) + 1);
        end;
        local u54;
        if v35 then
            u54 = v35.colors;
        else
            u54 = nil;
        end;
        local u55;
        if l__colorType__8 == 3 or l__bitDepth__7 >= 8 then
            u55 = nil;
        else
            u55 = 255 / (2 ^ l__bitDepth__7 - 1);
        end;
        local u56 = math.ceil(u49 * l__bitDepth__7 / 8);
        local u57 = 2 ^ l__bitDepth__7 - 1;
        local u58 = 0;
        local u59 = buffer.create(v50);
        local v60 = l__zlib__3.inflate(v46, u59) == v50;
        assert(v60, "decompressed data size mismatch");
        local u61 = buffer.create(l__width__5 * l__height__6 * 4);
        local u62 = not v40 and -1 or v40.gray;
        local u63 = not v40 and -1 or v40.red;
        local u64 = not v40 and -1 or v40.green;
        local u65 = not v40 and -1 or v40.blue;
        local function v139(p66, p67, p68, p69) --[[ Line: 190 ]]
            -- upvalues: l__width__5 (copy), l__height__6 (copy), u49 (copy), l__bitDepth__7 (copy), u58 (ref), u59 (copy), u56 (copy), l__colorType__8 (copy), u62 (copy), u57 (copy), u63 (copy), u64 (copy), u65 (copy), u54 (ref), u55 (ref), u61 (copy)
            local v70 = math.ceil((l__width__5 - p66) / p68);
            local v71 = math.ceil((l__height__6 - p67) / p69);
            if v70 < 1 or v71 < 1 then
            else
                local v72 = math.ceil(v70 * u49 * l__bitDepth__7 / 8);
                local v73 = u58;
                for v74 = 1, v71 do
                    local v75 = buffer.readu8(u59, u58);
                    u58 = u58 + 1;
                    if v75 == 0 or v75 == 2 and v74 == 1 then
                        u58 = u58 + v72;
                    elseif v75 == 1 then
                        for v76 = 1, v72 do
                            local v77 = v76 <= u56 and 0 or buffer.readu8(u59, u58 - u56);
                            local v78 = buffer.readu8(u59, u58) + v77;
                            local v79 = bit32.band(v78, 255);
                            buffer.writeu8(u59, u58, v79);
                            u58 = u58 + 1;
                        end;
                    elseif v75 == 2 then
                        for _ = 1, v72 do
                            local v80 = buffer.readu8(u59, u58 - v72 - 1);
                            local v81 = buffer.readu8(u59, u58) + v80;
                            local v82 = bit32.band(v81, 255);
                            buffer.writeu8(u59, u58, v82);
                            u58 = u58 + 1;
                        end;
                    elseif v75 == 3 then
                        for v83 = 1, v72 do
                            local v84 = v83 <= u56 and 0 or buffer.readu8(u59, u58 - u56);
                            local v85 = v74 == 1 and 0 or buffer.readu8(u59, u58 - v72 - 1);
                            local v86 = buffer.readu8(u59, u58) + bit32.rshift(v84 + v85, 1);
                            local v87 = bit32.band(v86, 255);
                            buffer.writeu8(u59, u58, v87);
                            u58 = u58 + 1;
                        end;
                    elseif v75 == 4 then
                        for v88 = 1, v72 do
                            local v89 = v88 <= u56 and 0 or buffer.readu8(u59, u58 - u56);
                            local v90 = v74 == 1 and 0 or buffer.readu8(u59, u58 - v72 - 1);
                            local v91 = (v88 <= u56 or v74 == 1) and 0 or buffer.readu8(u59, u58 - v72 - u56 - 1);
                            local v92 = math.abs(v90 - v91);
                            local v93 = math.abs(v89 - v91);
                            local v94 = math.abs(v89 + v90 - v91 * 2);
                            if v92 <= v93 and v92 <= v94 then
                                v91 = v89;
                            elseif v93 <= v94 then
                                v91 = v90;
                            end;
                            local v95 = buffer.readu8(u59, u58) + v91;
                            local v96 = bit32.band(v95, 255);
                            buffer.writeu8(u59, u58, v96);
                            u58 = u58 + 1;
                        end;
                    else
                        error("invalid row filter");
                    end;
                end;
                local v97 = 8;
                local v98 = v97;
                for v99 = 1, v71 do
                    v73 = v73 + 1;
                    if v98 < 8 then
                        v97 = 8;
                        v73 = v73 + 1;
                        v98 = v97;
                    end;
                    for v100 = 1, v70 do
                        local v101 = nil;
                        local v102 = nil;
                        local v103 = nil;
                        local v104 = nil;
                        if l__colorType__8 == 0 then
                            v101 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v101 = bit32.extract(v101, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v105 = bit32.lshift(v101, 8);
                                local v106 = buffer.readu8(u59, v73 + 1);
                                v101 = bit32.bor(v105, v106);
                                v73 = v73 + 2;
                            end;
                            if v101 == u62 then
                                v103 = v101;
                                v102 = v103;
                                local v107 = v103;
                                v103 = v102;
                                v107 = v102;
                                v104 = 0;
                            else
                                v104 = u57;
                                v103 = v101;
                                v102 = v103;
                                local v108 = v103;
                                v103 = v102;
                                v108 = v102;
                            end;
                        elseif l__colorType__8 == 2 then
                            v101 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v101 = bit32.extract(v101, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v109 = bit32.lshift(v101, 8);
                                local v110 = buffer.readu8(u59, v73 + 1);
                                v101 = bit32.bor(v109, v110);
                                v73 = v73 + 2;
                            end;
                            v102 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v102 = bit32.extract(v102, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v111 = bit32.lshift(v102, 8);
                                local v112 = buffer.readu8(u59, v73 + 1);
                                v102 = bit32.bor(v111, v112);
                                v73 = v73 + 2;
                            end;
                            v103 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v103 = bit32.extract(v103, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v113 = bit32.lshift(v103, 8);
                                local v114 = buffer.readu8(u59, v73 + 1);
                                v103 = bit32.bor(v113, v114);
                                v73 = v73 + 2;
                            end;
                            if v101 == u63 and (v102 == u64 and v103 == u65) then
                                v104 = 0;
                            else
                                v104 = u57;
                            end;
                        elseif l__colorType__8 == 3 then
                            local v115 = u54;
                            local v116 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v116 = bit32.extract(v116, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v117 = bit32.lshift(v116, 8);
                                local v118 = buffer.readu8(u59, v73 + 1);
                                v116 = bit32.bor(v117, v118);
                                v73 = v73 + 2;
                            end;
                            local v119 = v115[v116 + 1];
                            v101 = v119.r;
                            v102 = v119.g;
                            v103 = v119.b;
                            v104 = v119.a;
                        elseif l__colorType__8 == 4 then
                            v101 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v101 = bit32.extract(v101, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v120 = bit32.lshift(v101, 8);
                                local v121 = buffer.readu8(u59, v73 + 1);
                                v101 = bit32.bor(v120, v121);
                                v73 = v73 + 2;
                            end;
                            v104 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v104 = bit32.extract(v104, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v122 = bit32.lshift(v104, 8);
                                local v123 = buffer.readu8(u59, v73 + 1);
                                v104 = bit32.bor(v122, v123);
                                v73 = v73 + 2;
                            end;
                            v103 = v101;
                            v102 = v103;
                            local v124 = v103;
                            v103 = v102;
                            v124 = v102;
                        elseif l__colorType__8 == 6 then
                            v101 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v101 = bit32.extract(v101, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v125 = bit32.lshift(v101, 8);
                                local v126 = buffer.readu8(u59, v73 + 1);
                                v101 = bit32.bor(v125, v126);
                                v73 = v73 + 2;
                            end;
                            v102 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v102 = bit32.extract(v102, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v127 = bit32.lshift(v102, 8);
                                local v128 = buffer.readu8(u59, v73 + 1);
                                v102 = bit32.bor(v127, v128);
                                v73 = v73 + 2;
                            end;
                            v103 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v103 = bit32.extract(v103, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v129 = bit32.lshift(v103, 8);
                                local v130 = buffer.readu8(u59, v73 + 1);
                                v103 = bit32.bor(v129, v130);
                                v73 = v73 + 2;
                            end;
                            v104 = buffer.readu8(u59, v73);
                            if l__bitDepth__7 < 8 then
                                v104 = bit32.extract(v104, v98 - l__bitDepth__7, l__bitDepth__7);
                                v97 = v98 - l__bitDepth__7;
                                if v97 == 0 then
                                    v97 = 8;
                                    v73 = v73 + 1;
                                    v98 = v97;
                                else
                                    v98 = v97;
                                end;
                            elseif l__bitDepth__7 == 8 then
                                v73 = v73 + 1;
                            else
                                local v131 = bit32.lshift(v104, 8);
                                local v132 = buffer.readu8(u59, v73 + 1);
                                v104 = bit32.bor(v131, v132);
                                v73 = v73 + 2;
                            end;
                        end;
                        local v133 = ((p67 + (v99 - 1) * p69) * l__width__5 + (p66 + (v100 - 1) * p68)) * 4;
                        if u55 then
                            v101 = math.round(v101 * u55);
                            v102 = math.round(v102 * u55);
                            v103 = math.round(v103 * u55);
                            v104 = math.round(v104 * u55);
                        elseif l__bitDepth__7 == 16 then
                            v101 = bit32.rshift(v101, 8);
                            v102 = bit32.rshift(v102, 8);
                            v103 = bit32.rshift(v103, 8);
                            v104 = bit32.rshift(v104, 8);
                        end;
                        local v134 = u61;
                        local v135 = bit32.lshift(v104, 24);
                        local v136 = bit32.lshift(v103, 16);
                        local v137 = bit32.lshift(v102, 8);
                        local v138 = bit32.bor(v135, v136, v137, v101);
                        buffer.writeu32(v134, v133, v138);
                    end;
                end;
            end;
        end;
        if v29.interlaced then
            for v140 = 1, 7 do
                v139(u3[v140], u2[v140], u5[v140], u4[v140]);
            end;
        else
            v139(0, 0, 1, 1);
        end;
        return {
            width = l__width__5,
            height = l__height__6,
            pixels = u61,
            readPixel = function(p141, p142) --[[ Name: readPixel, Line 336 ]]
                -- upvalues: l__width__5 (copy), l__height__6 (copy), u61 (copy)
                local v143;
                if p141 >= 1 and (p141 <= l__width__5 and p142 >= 1) then
                    v143 = p142 <= l__height__6;
                else
                    v143 = false;
                end;
                assert(v143, "pixel out of range");
                local v144 = ((p142 - 1) * l__width__5 + p141 - 1) * 4;
                return buffer.readu8(u61, v144), buffer.readu8(u61, v144 + 1), buffer.readu8(u61, v144 + 2), buffer.readu8(u61, v144 + 3);
            end
        };
    end,
    encode = function(p145, p146) --[[ Name: encode, Line 354 ]]
        -- upvalues: l__zlib__3 (copy), l__crc32__2 (copy)
        local l__width__9 = p146.width;
        local l__height__10 = p146.height;
        local v147 = buffer.len(p145);
        local v148 = l__width__9 * l__height__10 * 4;
        local v149 = v147 == v148;
        local v150 = `expected {v148} bytes, got {v147} bytes`;
        assert(v149, v150);
        local v151 = l__width__9 * 4 + 1;
        local v152 = buffer.create(l__height__10 * v151);
        for v153 = 0, l__height__10 - 1 do
            local v154 = v153 * l__width__9 * 4;
            local v155 = v153 * v151;
            buffer.writeu8(v152, v155, 0);
            buffer.copy(v152, v155 + 1, p145, v154, l__width__9 * 4);
        end;
        local v156, v157 = l__zlib__3.deflate(v152);
        local v158 = buffer.create(33 + (8 + v157 + 4) + 12);
        buffer.writestring(v158, 0, "\137PNG\r\n\26\n");
        local v159 = bit32.byteswap(13);
        buffer.writeu32(v158, 8, v159);
        buffer.writestring(v158, 12, "IHDR");
        local v160 = bit32.byteswap(l__width__9);
        buffer.writeu32(v158, 16, v160);
        local v161 = bit32.byteswap(l__height__10);
        buffer.writeu32(v158, 20, v161);
        buffer.writeu8(v158, 24, 8);
        buffer.writeu8(v158, 25, 6);
        buffer.writeu8(v158, 26, 0);
        buffer.writeu8(v158, 27, 0);
        buffer.writeu8(v158, 28, 0);
        local v162 = l__crc32__2(v158, 12, 28);
        local v163 = bit32.byteswap(v162);
        buffer.writeu32(v158, 29, v163);
        local v164 = bit32.byteswap(v157);
        buffer.writeu32(v158, 33, v164);
        buffer.writestring(v158, 37, "IDAT");
        buffer.copy(v158, 41, v156, 0, v157);
        local v165 = 41 + v157;
        local v166 = l__crc32__2(v158, 37, v165 - 1);
        local v167 = bit32.byteswap(v166);
        buffer.writeu32(v158, v165, v167);
        buffer.writeu32(v158, v165 + 4, 0);
        buffer.writestring(v158, v165 + 8, "IEND");
        buffer.writeu32(v158, v165 + 12, 2187346606);
        return v158;
    end
};