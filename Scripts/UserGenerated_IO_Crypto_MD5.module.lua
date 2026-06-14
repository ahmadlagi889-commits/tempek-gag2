-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local u1 = {
    3614090360,
    3905402710,
    606105819,
    3250441966,
    4118548399,
    1200080426,
    2821735955,
    4249261313,
    1770035416,
    2336552879,
    4294925233,
    2304563134,
    1804603682,
    4254626195,
    2792965006,
    1236535329,
    4129170786,
    3225465664,
    643717713,
    3921069994,
    3593408605,
    38016083,
    3634488961,
    3889429448,
    568446438,
    3275163606,
    4107603335,
    1163531501,
    2850285829,
    4243563512,
    1735328473,
    2368359562,
    4294588738,
    2272392833,
    1839030562,
    4259657740,
    2763975236,
    1272893353,
    4139469664,
    3200236656,
    681279174,
    3936430074,
    3572445317,
    76029189,
    3654602809,
    3873151461,
    530742520,
    3299628645,
    4096336452,
    1126891415,
    2878612391,
    4237533241,
    1700485571,
    2399980690,
    4293915773,
    2240044497,
    1873313359,
    4264355552,
    2734768916,
    1309151649,
    4149444226,
    3174756917,
    718787259,
    3951481745
};
local u2 = {
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    7,
    12,
    17,
    22,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    5,
    9,
    14,
    20,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    4,
    11,
    16,
    23,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21,
    6,
    10,
    15,
    21
};
local u3 = table.create(64, 0);
function processBlocks(p4, p5, p6, p7)
    -- upvalues: u3 (copy), u1 (copy), u2 (copy)
    local v8 = u3;
    local v9 = p4[1];
    local v10 = p4[2];
    local v11 = p4[3];
    local v12 = p4[4];
    for v22 = p6, p7, 64 do
        local _ = v22;
        for v14 = 1, 16 do
            local v15, v16, v17, v18 = string.byte(p5, v22, v22 + 3);
            local v19 = bit32.lshift(v18, 24);
            local v20 = bit32.lshift(v17, 16);
            local v21 = bit32.lshift(v16, 8);
            v8[v14] = bit32.bor(v19, v20, v21, v15);
            local v22 = v22 + 4;
        end;
        local v23 = v12;
        local v24 = v11;
        local v25 = v10;
        local v26 = v9;
        for v27 = 0, 15 do
            local v28 = bit32.bxor(v11, v12);
            local v29 = bit32.band(v10, v28);
            local v30 = v9 + bit32.bxor(v12, v29) + u1[v27 + 1] + v8[v27 + 1];
            local v31 = v10 + bit32.lrotate(v30, u2[v27 + 1]);
            v9 = v12;
            v12 = v11;
            v11 = v10;
            v10 = v31;
        end;
        for v32 = 16, 31 do
            local v33 = bit32.bxor(v10, v11);
            local v34 = bit32.band(v12, v33);
            local v35 = v9 + bit32.bxor(v11, v34) + u1[v32 + 1] + v8[(v32 * 5 + 1) % 16 + 1];
            local v36 = v10 + bit32.lrotate(v35, u2[v32 + 1]);
            v9 = v12;
            v12 = v11;
            v11 = v10;
            v10 = v36;
        end;
        for v37 = 32, 47 do
            local v38 = v9 + bit32.bxor(v10, v11, v12) + u1[v37 + 1] + v8[(v37 * 3 + 5) % 16 + 1];
            local v39 = v10 + bit32.lrotate(v38, u2[v37 + 1]);
            v9 = v12;
            v12 = v11;
            v11 = v10;
            v10 = v39;
        end;
        for v40 = 48, 63 do
            local v41 = bit32.bnot(v12);
            local v42 = bit32.bor(v10, v41);
            local v43 = v9 + bit32.bxor(v11, v42) + u1[v40 + 1] + v8[v40 * 7 % 16 + 1];
            local v44 = v10 + bit32.lrotate(v43, u2[v40 + 1]);
            v9 = v12;
            v12 = v11;
            v11 = v10;
            v10 = v44;
        end;
        v9 = bit32.bor(v9 + v26);
        v10 = bit32.bor(v10 + v25);
        v11 = bit32.bor(v11 + v24);
        v12 = bit32.bor(v12 + v23);
    end;
    p4[1] = v9;
    p4[2] = v10;
    p4[3] = v11;
    p4[4] = v12;
end;
function md5(p45)
    local v46 = {
        1732584193,
        4023233417,
        2562383102,
        271733878
    };
    local v47 = #p45;
    local v48 = v47 % 64;
    if v47 >= 64 then
        processBlocks(v46, p45, 1, v47 - v48);
    end;
    local v49 = bit32.band(v48 + 32, 4294967232);
    local v50 = {
        v48 == 0 and "" or string.sub(p45, -v48),
        "\128",
        string.rep("\0", (v49 - v48 - 9) % 64),
        string.pack("<L", v47 * 8)
    };
    local v51 = table.concat(v50);
    processBlocks(v46, v51, 1, #v51);
    local v52 = buffer.create(16);
    buffer.writeu32(v52, 0, v46[1]);
    buffer.writeu32(v52, 4, v46[2]);
    buffer.writeu32(v52, 8, v46[3]);
    buffer.writeu32(v52, 12, v46[4]);
    return v52;
end;
local v55 = {
    Name = "MD5",
    BlockSize = 64,
    OutputSize = 16,
    Digest = function(p53) --[[ Name: Digest, Line 181 ]]
        return buffer.tostring(md5(p53));
    end,
    DigestBuffer = function(p54) --[[ Name: DigestBuffer, Line 184 ]]
        return md5(buffer.tostring(p54));
    end,
    DigestToBuffer = md5
};
table.freeze(v55);
return v55;