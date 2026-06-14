-- Decompiled with Potassium's decompiler.

local u1 = {};
for v4 = 0, 255 do
    local v3 = v4;
    for _ = 1, 8 do
        local v4;
        if bit32.band(v4, 1) == 0 then
            v4 = bit32.rshift(v4, 1);
        else
            local v5 = bit32.rshift(v4, 1);
            v4 = bit32.bxor(v5, 3988292384);
        end;
    end;
    u1[v3 + 1] = v4;
end;
local u29 = {
    Init = function() --[[ Name: Init, Line 45 ]]
        return 4294967295;
    end,
    Update = function(p6, p7, p8, p9) --[[ Name: Update, Line 49 ]]
        -- upvalues: u1 (copy)
        local v10 = p8 or 1;
        for v11 = v10, v10 + (p9 or string.len(p7)) - 1 do
            local v12 = string.byte(p7, v11);
            local v13 = bit32.rshift(p6, 8);
            local v14 = u1;
            local v15 = bit32.bxor(p6, v12);
            local v16 = v14[bit32.band(v15, 255) + 1];
            p6 = bit32.bxor(v13, v16);
        end;
        return p6;
    end,
    UpdateBuffer = function(p17, p18, p19, p20) --[[ Name: UpdateBuffer, Line 65 ]]
        -- upvalues: u1 (copy)
        local v21 = p19 or 0;
        for v22 = v21, v21 + (p20 or buffer.len(p18)) - 1 do
            local v23 = buffer.readu8(p18, v22);
            local v24 = bit32.rshift(p17, 8);
            local v25 = u1;
            local v26 = bit32.bxor(p17, v23);
            local v27 = v25[bit32.band(v26, 255) + 1];
            p17 = bit32.bxor(v24, v27);
        end;
        return p17;
    end,
    Finish = function(p28) --[[ Name: Finish, Line 81 ]]
        return bit32.bnot(p28);
    end
};
function u29.Digest(p30, p31, p32) --[[ Line: 87 ]]
    -- upvalues: u29 (copy)
    local v33 = u29.Init();
    local v34 = u29.Update(v33, p30, p31, p32);
    return u29.Finish(v34);
end;
function u29.DigestBuffer(p35, p36, p37) --[[ Line: 97 ]]
    -- upvalues: u29 (copy)
    local v38 = u29.Init();
    local v39 = u29.UpdateBuffer(v38, p35, p36, p37);
    return u29.Finish(v39);
end;
return table.freeze(u29);