-- Decompiled with Potassium's decompiler.

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash);
local function u17(u1, p2) --[[ Line: 46 ]]
    local l__BlockSize__1 = u1.BlockSize;
    if l__BlockSize__1 < buffer.len(p2) then
        p2 = u1.DigestBuffer(p2);
    end;
    local v3 = buffer.create(l__BlockSize__1);
    buffer.copy(v3, 0, p2);
    local u4 = buffer.create(l__BlockSize__1);
    local u5 = buffer.create(l__BlockSize__1);
    for v6 = 0, l__BlockSize__1 - 1 do
        local v7 = buffer.readu8(v3, v6);
        local v8 = bit32.bxor(v7, 92);
        buffer.writeu8(u4, v6, v8);
        local v9 = bit32.bxor(v7, 54);
        buffer.writeu8(u5, v6, v9);
    end;
    local function u14(p10) --[[ Line: 72 ]]
        -- upvalues: l__BlockSize__1 (copy), u5 (copy), u1 (copy), u4 (copy)
        local v11 = buffer.create(l__BlockSize__1 + buffer.len(p10));
        buffer.copy(v11, 0, u5);
        buffer.copy(v11, l__BlockSize__1, p10);
        local v12 = u1.DigestBuffer(v11);
        local v13 = buffer.create(l__BlockSize__1 + buffer.len(v12));
        buffer.copy(v13, 0, u4);
        buffer.copy(v13, l__BlockSize__1, v12);
        return u1.DigestBuffer(v13);
    end;
    return {
        Name = "HMAC-" .. u1.Name,
        BlockSize = u1.BlockSize,
        OutputSize = u1.OutputSize,
        Digest = function(p15) --[[ Name: Digest, Line 92 ]]
            -- upvalues: u14 (copy)
            return buffer.tostring(u14(buffer.fromstring(p15)));
        end,
        DigestBuffer = u14,
        DigestToBuffer = function(p16) --[[ Name: DigestToBuffer, Line 96 ]]
            -- upvalues: u14 (copy)
            return u14(buffer.fromstring(p16));
        end
    };
end;
return {
    Derive = u17,
    DeriveString = function(p18, p19) --[[ Name: DeriveString, Line 111 ]]
        -- upvalues: u17 (copy)
        return u17(p18, buffer.fromstring(p19));
    end
};