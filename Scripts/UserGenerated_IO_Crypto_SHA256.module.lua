-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local u1 = {
    1116352408,
    1899447441,
    3049323471,
    3921009573,
    961987163,
    1508970993,
    2453635748,
    2870763221,
    3624381080,
    310598401,
    607225278,
    1426881987,
    1925078388,
    2162078206,
    2614888103,
    3248222580,
    3835390401,
    4022224774,
    264347078,
    604807628,
    770255983,
    1249150122,
    1555081692,
    1996064986,
    2554220882,
    2821834349,
    2952996808,
    3210313671,
    3336571891,
    3584528711,
    113926993,
    338241895,
    666307205,
    773529912,
    1294757372,
    1396182291,
    1695183700,
    1986661051,
    2177026350,
    2456956037,
    2730485921,
    2820302411,
    3259730800,
    3345764771,
    3516065817,
    3600352804,
    4094571909,
    275423344,
    430227734,
    506948616,
    659060556,
    883997877,
    958139571,
    1322822218,
    1537002063,
    1747873779,
    1955562222,
    2024104815,
    2227730452,
    2361852424,
    2428436474,
    2756734187,
    3204031479,
    3329325298
};
local u2 = table.create(64, 0);
function processBlocks(p3, p4, p5, p6)
    -- upvalues: u2 (copy), u1 (copy)
    local v7 = u2;
    local v8 = p3[1];
    local v9 = p3[2];
    local v10 = p3[3];
    local v11 = p3[4];
    local v12 = p3[5];
    local v13 = p3[6];
    local v14 = p3[7];
    local v15 = p3[8];
    for v25 = p5, p6, 64 do
        local _ = v25;
        for v17 = 1, 16 do
            local v18, v19, v20, v21 = string.byte(p4, v25, v25 + 3);
            local v22 = bit32.lshift(v18, 24);
            local v23 = bit32.lshift(v19, 16);
            local v24 = bit32.lshift(v20, 8);
            v7[v17] = bit32.bor(v22, v23, v24, v21);
            local v25 = v25 + 4;
        end;
        for v26 = 17, 64 do
            local v27 = v7[v26 - 2];
            local v28 = v7[v26 - 15];
            local v29 = bit32.rrotate(v27, 17);
            local v30 = bit32.rrotate(v27, 19);
            local v31 = bit32.rshift(v27, 10);
            local v32 = bit32.bxor(v29, v30, v31) + v7[v26 - 7];
            local v33 = bit32.rrotate(v28, 7);
            local v34 = bit32.rrotate(v28, 18);
            local v35 = bit32.rshift(v28, 3);
            v7[v26] = v32 + bit32.bxor(v33, v34, v35) + v7[v26 - 16];
        end;
        local v36 = v15;
        local v37 = v11;
        local v38 = v14;
        local v39 = v12;
        local v40 = v10;
        local v41 = v9;
        local v42 = v8;
        local v43 = v13;
        for v44 = 1, 64 do
            local v45 = bit32.rrotate(v12, 6);
            local v46 = bit32.rrotate(v12, 11);
            local v47 = bit32.rrotate(v12, 25);
            local v48 = v15 + bit32.bxor(v45, v46, v47) + bit32.band(v12, v13);
            local v49 = bit32.bnot(v12);
            local v50 = v48 + bit32.band(v49, v14) + u1[v44] + v7[v44];
            local v51 = bit32.band(v10, v9);
            local v52 = bit32.bxor(v10, v9);
            local v53 = v51 + bit32.band(v8, v52);
            local v54 = bit32.rrotate(v8, 2);
            local v55 = bit32.rrotate(v8, 13);
            local v56 = bit32.rrotate(v8, 22);
            local v57 = v53 + bit32.bxor(v54, v55, v56);
            local v58 = v11 + v50;
            local v59 = v50 + v57;
            v15 = v14;
            v14 = v13;
            v13 = v12;
            v12 = v58;
            v11 = v10;
            v10 = v9;
            v9 = v8;
            v8 = v59;
        end;
        v8 = bit32.bor(v8 + v42, 0);
        v9 = bit32.bor(v9 + v41, 0);
        v10 = bit32.bor(v10 + v40, 0);
        v11 = bit32.bor(v11 + v37, 0);
        v12 = bit32.bor(v12 + v39, 0);
        v13 = bit32.bor(v13 + v43, 0);
        v14 = bit32.bor(v14 + v38, 0);
        v15 = bit32.bor(v15 + v36, 0);
    end;
    p3[1] = v8;
    p3[2] = v9;
    p3[3] = v10;
    p3[4] = v11;
    p3[5] = v12;
    p3[6] = v13;
    p3[7] = v14;
    p3[8] = v15;
end;
function sha256(p60)
    local v61 = {
        1779033703,
        3144134277,
        1013904242,
        2773480762,
        1359893119,
        2600822924,
        528734635,
        1541459225
    };
    local v62 = #p60;
    local v63 = v62 % 64;
    if v62 >= 64 then
        processBlocks(v61, p60, 1, v62 - v63);
    end;
    local v64 = bit32.band(v63 + 32, 4294967232);
    local v65 = {
        v63 == 0 and "" or string.sub(p60, -v63),
        "\128",
        string.rep("\0", (v64 - v63 - 9) % 64),
        string.pack(">L", v62 * 8)
    };
    local v66 = table.concat(v65);
    processBlocks(v61, v66, 1, #v66);
    local v67 = buffer.create(32);
    local v68 = bit32.byteswap(v61[1]);
    buffer.writeu32(v67, 0, v68);
    local v69 = bit32.byteswap(v61[2]);
    buffer.writeu32(v67, 4, v69);
    local v70 = bit32.byteswap(v61[3]);
    buffer.writeu32(v67, 8, v70);
    local v71 = bit32.byteswap(v61[4]);
    buffer.writeu32(v67, 12, v71);
    local v72 = bit32.byteswap(v61[5]);
    buffer.writeu32(v67, 16, v72);
    local v73 = bit32.byteswap(v61[6]);
    buffer.writeu32(v67, 20, v73);
    local v74 = bit32.byteswap(v61[7]);
    buffer.writeu32(v67, 24, v74);
    local v75 = bit32.byteswap(v61[8]);
    buffer.writeu32(v67, 28, v75);
    return v67;
end;
local v78 = {
    Name = "SHA-256",
    BlockSize = 64,
    OutputSize = 32,
    Digest = function(p76) --[[ Name: Digest, Line 172 ]]
        return buffer.tostring(sha256(p76));
    end,
    DigestBuffer = function(p77) --[[ Name: DigestBuffer, Line 175 ]]
        return sha256(buffer.tostring(p77));
    end,
    DigestToBuffer = sha256
};
table.freeze(v78);
return v78;