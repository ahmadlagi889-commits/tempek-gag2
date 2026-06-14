-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local u1 = table.create(80, 0);
function processBlocks(p2, p3, p4, p5)
    -- upvalues: u1 (copy)
    local v6 = u1;
    local v7 = p2[1];
    local v8 = p2[2];
    local v9 = p2[3];
    local v10 = p2[4];
    local v11 = p2[5];
    for v21 = p4, p5, 64 do
        local _ = v21;
        for v13 = 1, 16 do
            local v14, v15, v16, v17 = string.byte(p3, v21, v21 + 3);
            local v18 = bit32.lshift(v14, 24);
            local v19 = bit32.lshift(v15, 16);
            local v20 = bit32.lshift(v16, 8);
            v6[v13] = bit32.bor(v18, v19, v20, v17);
            local v21 = v21 + 4;
        end;
        for v22 = 17, 80 do
            local v23 = bit32.bxor(v6[v22 - 3], v6[v22 - 8], v6[v22 - 14], v6[v22 - 16]);
            v6[v22] = bit32.lrotate(v23, 1);
        end;
        local v24 = v11;
        local v25 = v10;
        local v26 = v9;
        local v27 = v8;
        local v28 = v7;
        for v29 = 1, 20 do
            local v30 = bit32.lrotate(v7, 5) + bit32.band(v8, v9);
            local v31 = bit32.bnot(v8);
            local v32 = v30 + bit32.band(v31, v10) + v11 + 1518500249 + v6[v29];
            local v33 = bit32.lrotate(v8, 30);
            v11 = v10;
            v10 = v9;
            v9 = v33;
            v8 = v7;
            v7 = v32;
        end;
        for v34 = 21, 40 do
            local v35 = bit32.lrotate(v7, 5) + bit32.bxor(v8, v9, v10) + v11 + 1859775393 + v6[v34];
            local v36 = bit32.lrotate(v8, 30);
            v11 = v10;
            v10 = v9;
            v9 = v36;
            v8 = v7;
            v7 = v35;
        end;
        for v37 = 41, 60 do
            local v38 = bit32.lrotate(v7, 5) + bit32.band(v10, v9);
            local v39 = bit32.bxor(v10, v9);
            local v40 = v38 + bit32.band(v8, v39) + v11 + 2400959708 + v6[v37];
            local v41 = bit32.lrotate(v8, 30);
            v11 = v10;
            v10 = v9;
            v9 = v41;
            v8 = v7;
            v7 = v40;
        end;
        for v42 = 61, 80 do
            local v43 = bit32.lrotate(v7, 5) + bit32.bxor(v8, v9, v10) + v11 + 3395469782 + v6[v42];
            local v44 = bit32.lrotate(v8, 30);
            v11 = v10;
            v10 = v9;
            v9 = v44;
            v8 = v7;
            v7 = v43;
        end;
        v7 = bit32.bor(v7 + v28, 0);
        v8 = bit32.bor(v8 + v27, 0);
        v9 = bit32.bor(v9 + v26, 0);
        v10 = bit32.bor(v10 + v25, 0);
        v11 = bit32.bor(v11 + v24, 0);
    end;
    p2[1] = v7;
    p2[2] = v8;
    p2[3] = v9;
    p2[4] = v10;
    p2[5] = v11;
end;
function sha1(p45)
    local v46 = {
        1732584193,
        4023233417,
        2562383102,
        271733878,
        3285377520
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
        string.pack(">L", v47 * 8)
    };
    local v51 = table.concat(v50);
    processBlocks(v46, v51, 1, #v51);
    local v52 = buffer.create(20);
    local v53 = bit32.byteswap(v46[1]);
    buffer.writeu32(v52, 0, v53);
    local v54 = bit32.byteswap(v46[2]);
    buffer.writeu32(v52, 4, v54);
    local v55 = bit32.byteswap(v46[3]);
    buffer.writeu32(v52, 8, v55);
    local v56 = bit32.byteswap(v46[4]);
    buffer.writeu32(v52, 12, v56);
    local v57 = bit32.byteswap(v46[5]);
    buffer.writeu32(v52, 16, v57);
    return v52;
end;
local v60 = {
    Name = "SHA-1",
    BlockSize = 64,
    OutputSize = 20,
    Digest = function(p58) --[[ Name: Digest, Line 153 ]]
        return buffer.tostring(sha1(p58));
    end,
    DigestBuffer = function(p59) --[[ Name: DigestBuffer, Line 156 ]]
        return sha1(buffer.tostring(p59));
    end,
    DigestToBuffer = sha1
};
table.freeze(v60);
return v60;