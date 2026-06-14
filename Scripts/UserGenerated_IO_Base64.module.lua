-- Decompiled with Potassium's decompiler.

local u1 = buffer.create(64);
local u2 = buffer.create(256);
for v3 = 1, 64 do
    local v4 = v3 - 1;
    local v5 = string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", v3);
    buffer.writeu8(u1, v4, v5);
    buffer.writeu8(u2, v5, v4);
end;
function encode(p6, p7)
    -- upvalues: u1 (copy)
    local v8 = p7 or buffer.len(p6);
    local v9 = math.ceil(v8 / 3);
    local v10 = v9 * 4;
    local v11 = buffer.create(v10);
    for v12 = 1, v9 - 1 do
        local v13 = (v12 - 1) * 3;
        local v14 = (v12 - 1) * 4;
        local v15 = buffer.readu32(p6, v13);
        local v16 = bit32.byteswap(v15);
        local v17 = bit32.rshift(v16, 26);
        local v18 = bit32.rshift(v16, 20);
        local v19 = bit32.band(v18, 63);
        local v20 = bit32.rshift(v16, 14);
        local v21 = bit32.band(v20, 63);
        local v22 = bit32.rshift(v16, 8);
        local v23 = bit32.band(v22, 63);
        local v24 = buffer.readu8(u1, v17);
        buffer.writeu8(v11, v14, v24);
        local v25 = v14 + 1;
        local v26 = buffer.readu8(u1, v19);
        buffer.writeu8(v11, v25, v26);
        local v27 = v14 + 2;
        local v28 = buffer.readu8(u1, v21);
        buffer.writeu8(v11, v27, v28);
        local v29 = v14 + 3;
        local v30 = buffer.readu8(u1, v23);
        buffer.writeu8(v11, v29, v30);
    end;
    local v31 = v8 % 3;
    if v31 == 1 then
        local v32 = buffer.readu8(p6, v8 - 1);
        local v33 = bit32.rshift(v32, 2);
        local v34 = bit32.lshift(v32, 4);
        local v35 = bit32.band(v34, 63);
        local v36 = v10 - 4;
        local v37 = buffer.readu8(u1, v33);
        buffer.writeu8(v11, v36, v37);
        local v38 = v10 - 3;
        local v39 = buffer.readu8(u1, v35);
        buffer.writeu8(v11, v38, v39);
        buffer.writeu8(v11, v10 - 2, 61);
        buffer.writeu8(v11, v10 - 1, 61);
        return v11;
    end;
    if v31 ~= 2 then
        if v31 == 0 and v8 ~= 0 then
            local v40 = buffer.readu8(p6, v8 - 3);
            local v41 = bit32.lshift(v40, 16);
            local v42 = buffer.readu8(p6, v8 - 2);
            local v43 = bit32.lshift(v42, 8);
            local v44 = buffer.readu8(p6, v8 - 1);
            local v45 = bit32.bor(v41, v43, v44);
            local v46 = bit32.rshift(v45, 18);
            local v47 = bit32.rshift(v45, 12);
            local v48 = bit32.band(v47, 63);
            local v49 = bit32.rshift(v45, 6);
            local v50 = bit32.band(v49, 63);
            local v51 = bit32.band(v45, 63);
            local v52 = v10 - 4;
            local v53 = buffer.readu8(u1, v46);
            buffer.writeu8(v11, v52, v53);
            local v54 = v10 - 3;
            local v55 = buffer.readu8(u1, v48);
            buffer.writeu8(v11, v54, v55);
            local v56 = v10 - 2;
            local v57 = buffer.readu8(u1, v50);
            buffer.writeu8(v11, v56, v57);
            local v58 = v10 - 1;
            local v59 = buffer.readu8(u1, v51);
            buffer.writeu8(v11, v58, v59);
        end;
        return v11;
    end;
    local v60 = buffer.readu8(p6, v8 - 2);
    local v61 = bit32.lshift(v60, 8);
    local v62 = buffer.readu8(p6, v8 - 1);
    local v63 = bit32.bor(v61, v62);
    local v64 = bit32.rshift(v63, 10);
    local v65 = bit32.rshift(v63, 4);
    local v66 = bit32.band(v65, 63);
    local v67 = bit32.lshift(v63, 2);
    local v68 = bit32.band(v67, 63);
    local v69 = v10 - 4;
    local v70 = buffer.readu8(u1, v64);
    buffer.writeu8(v11, v69, v70);
    local v71 = v10 - 3;
    local v72 = buffer.readu8(u1, v66);
    buffer.writeu8(v11, v71, v72);
    local v73 = v10 - 2;
    local v74 = buffer.readu8(u1, v68);
    buffer.writeu8(v11, v73, v74);
    buffer.writeu8(v11, v10 - 1, 61);
    return v11;
end;
function decode(p75)
    -- upvalues: u2 (copy)
    local v76 = buffer.len(p75);
    local v77 = math.ceil(v76 / 4);
    local v78 = 0;
    if v76 ~= 0 then
        if buffer.readu8(p75, v76 - 1) == 61 then
            v78 = v78 + 1;
        end;
        if buffer.readu8(p75, v76 - 2) == 61 then
            v78 = v78 + 1;
        end;
    end;
    local v79 = buffer.create(v77 * 3 - v78);
    for v80 = 1, v77 - 1 do
        local v81 = (v80 - 1) * 4;
        local v82 = (v80 - 1) * 3;
        local v83 = u2;
        local v84 = buffer.readu8(p75, v81);
        local v85 = buffer.readu8(v83, v84);
        local v86 = u2;
        local v87 = buffer.readu8(p75, v81 + 1);
        local v88 = buffer.readu8(v86, v87);
        local v89 = u2;
        local v90 = buffer.readu8(p75, v81 + 2);
        local v91 = buffer.readu8(v89, v90);
        local v92 = u2;
        local v93 = buffer.readu8(p75, v81 + 3);
        local v94 = buffer.readu8(v92, v93);
        local v95 = bit32.lshift(v85, 18);
        local v96 = bit32.lshift(v88, 12);
        local v97 = bit32.lshift(v91, 6);
        local v98 = bit32.bor(v95, v96, v97, v94);
        local v99 = bit32.rshift(v98, 16);
        local v100 = bit32.rshift(v98, 8);
        local v101 = bit32.band(v100, 255);
        local v102 = bit32.band(v98, 255);
        buffer.writeu8(v79, v82, v99);
        buffer.writeu8(v79, v82 + 1, v101);
        buffer.writeu8(v79, v82 + 2, v102);
    end;
    if v76 ~= 0 then
        local v103 = (v77 - 1) * 4;
        local v104 = (v77 - 1) * 3;
        local v105 = u2;
        local v106 = buffer.readu8(p75, v103);
        local v107 = buffer.readu8(v105, v106);
        local v108 = u2;
        local v109 = buffer.readu8(p75, v103 + 1);
        local v110 = buffer.readu8(v108, v109);
        local v111 = u2;
        local v112 = buffer.readu8(p75, v103 + 2);
        local v113 = buffer.readu8(v111, v112);
        local v114 = u2;
        local v115 = buffer.readu8(p75, v103 + 3);
        local v116 = buffer.readu8(v114, v115);
        local v117 = bit32.lshift(v107, 18);
        local v118 = bit32.lshift(v110, 12);
        local v119 = bit32.lshift(v113, 6);
        local v120 = bit32.bor(v117, v118, v119, v116);
        if v78 <= 2 then
            local v121 = bit32.rshift(v120, 16);
            buffer.writeu8(v79, v104, v121);
            if v78 <= 1 then
                local v122 = bit32.rshift(v120, 8);
                local v123 = bit32.band(v122, 255);
                buffer.writeu8(v79, v104 + 1, v123);
                if v78 == 0 then
                    local v124 = bit32.band(v120, 255);
                    buffer.writeu8(v79, v104 + 2, v124);
                end;
            end;
        end;
    end;
    return v79;
end;
function Encode(p125)
    return buffer.tostring(encode(buffer.fromstring(p125)));
end;
function Decode(p126)
    return buffer.tostring(decode(buffer.fromstring(p126)));
end;
return table.freeze({
    Encode = Encode,
    Decode = Decode,
    EncodeBuffer = encode,
    DecodeBuffer = decode
});