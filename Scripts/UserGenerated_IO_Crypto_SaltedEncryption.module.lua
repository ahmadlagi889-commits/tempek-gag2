-- Decompiled with Potassium's decompiler.

local l__AES__1 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.AES);
local l__Base64__2 = require(game.ReplicatedStorage.UserGenerated.IO.Base64);
local l__HMAC__3 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.HMAC);
local l__ISAAC__4 = require(game.ReplicatedStorage.UserGenerated.Randoms.ISAAC);
local l__SHA256__5 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.SHA256);
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local u1 = l__ISAAC__4.Unique();
local function u6(p2) --[[ Line: 44 ]]
    -- upvalues: u1 (copy)
    local v3 = buffer.create(p2);
    for v4 = 0, p2 - 1 do
        local v5 = u1:NextInteger(0, 255);
        buffer.writeu8(v3, v4, v5);
    end;
    return v3;
end;
local function u27(p7, p8, p9, p10, p11) --[[ Line: 62 ]]
    -- upvalues: l__HMAC__3 (copy)
    local v12 = l__HMAC__3.Derive(p11, p7);
    local l__OutputSize__6 = p11.OutputSize;
    local v13 = math.ceil(p9 / l__OutputSize__6);
    local v14 = buffer.create(p9);
    local v15 = 0;
    for v16 = 1, v13 do
        local v17 = buffer.create(buffer.len(p8) + 4);
        buffer.copy(v17, 0, p8);
        local v18 = buffer.len(p8);
        local v19 = bit32.byteswap(v16);
        buffer.writeu32(v17, v18, v19);
        local v20 = v12.DigestBuffer(v17);
        local v21 = buffer.create(buffer.len(v20));
        buffer.copy(v21, 0, v20);
        for _ = 2, p10 do
            v20 = v12.DigestBuffer(v20);
            for v22 = 0, buffer.len(v20) - 1 do
                local v23 = buffer.readu8(v21, v22);
                local v24 = buffer.readu8(v20, v22);
                local v25 = bit32.bxor(v23, v24);
                buffer.writeu8(v21, v22, v25);
            end;
        end;
        local v26 = math.min(l__OutputSize__6, p9 - v15);
        buffer.copy(v14, v15, v21, 0, v26);
        v15 = v15 + v26;
    end;
    return v14;
end;
local function u34(p28) --[[ Line: 115 ]]
    local v29 = buffer.len(p28);
    local v30 = 16 - v29 % 16;
    local v31 = v29 + v30;
    local v32 = buffer.create(v31);
    buffer.copy(v32, 0, p28);
    for v33 = v29, v31 - 1 do
        buffer.writeu8(v32, v33, v30);
    end;
    return v32;
end;
local function u41(p35) --[[ Line: 137 ]]
    local v36 = buffer.len(p35);
    if v36 == 0 then
        error("Invalid padding: empty input");
    end;
    local v37 = buffer.readu8(p35, v36 - 1);
    if v37 < 1 or v37 > 16 then
        error("Invalid padding length: " .. v37);
    end;
    for v38 = v36 - v37, v36 - 1 do
        if buffer.readu8(p35, v38) ~= v37 then
            error("Invalid padding");
        end;
    end;
    local v39 = v36 - v37;
    local v40 = buffer.create(v39);
    buffer.copy(v40, 0, p35, 0, v39);
    return v40;
end;
local function u55(p42, p43, p44) --[[ Line: 172 ]]
    -- upvalues: l__SHA256__5 (copy), u6 (copy), u27 (copy), u34 (copy), l__AES__1 (copy), l__Base64__2 (copy)
    local v45 = p44 or l__SHA256__5;
    local v46 = buffer.fromstring(p42);
    local v47 = u6(8);
    local v48 = u27(p43, v47, 48, 10000, v45);
    local v49 = buffer.create(32);
    buffer.copy(v49, 0, v48, 0, 32);
    local v50 = buffer.create(16);
    buffer.copy(v50, 0, v48, 32, 16);
    local v51 = u34(v46);
    local v52 = l__AES__1.new(buffer.tostring(v49), l__AES__1.modes.CBC, l__AES__1.pads.None):Encrypt(v51, nil, v50);
    local v53 = 16 + buffer.len(v52);
    local v54 = buffer.create(v53);
    buffer.writestring(v54, 0, "Salted__");
    buffer.copy(v54, 8, v47);
    buffer.copy(v54, 16, v52);
    return buffer.tostring(l__Base64__2.EncodeBuffer(v54));
end;
local function u69(p56, p57, p58) --[[ Line: 226 ]]
    -- upvalues: l__SHA256__5 (copy), l__Base64__2 (copy), u27 (copy), l__AES__1 (copy), u41 (copy)
    local v59 = p58 or l__SHA256__5;
    local v60 = l__Base64__2.DecodeBuffer(buffer.fromstring(p56));
    if buffer.len(v60) < 16 then
        error("Invalid data: too short");
    end;
    local v61 = buffer.create(8);
    buffer.copy(v61, 0, v60, 0, 8);
    if buffer.tostring(v61) ~= "Salted__" then
        error("Invalid data: Missing \'Salted__\' header");
    end;
    local v62 = buffer.create(8);
    buffer.copy(v62, 0, v60, 8, 8);
    local v63 = buffer.len(v60) - 16;
    local v64 = buffer.create(v63);
    buffer.copy(v64, 0, v60, 16, v63);
    local v65 = u27(p57, v62, 48, 10000, v59);
    local v66 = buffer.create(32);
    buffer.copy(v66, 0, v65, 0, 32);
    local v67 = buffer.create(16);
    buffer.copy(v67, 0, v65, 32, 16);
    local v68 = u41((l__AES__1.new(buffer.tostring(v66), l__AES__1.modes.CBC, l__AES__1.pads.None):Decrypt(v64, nil, v67)));
    return buffer.tostring(v68);
end;
local v76 = {
    Encrypt = u55,
    Decrypt = u69,
    EncryptString = function(p70, p71, p72) --[[ Name: EncryptString, Line 287 ]]
        -- upvalues: u55 (copy)
        return u55(p70, buffer.fromstring(p71), p72);
    end,
    DecryptString = function(p73, p74, p75) --[[ Name: DecryptString, Line 300 ]]
        -- upvalues: u69 (copy)
        return u69(p73, buffer.fromstring(p74), p75);
    end,
    PBKDF2 = u27,
    GetRandomBytes = u6
};
table.freeze(v76);
return v76;