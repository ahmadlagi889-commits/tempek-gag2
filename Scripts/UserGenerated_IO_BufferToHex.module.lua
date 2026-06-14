-- Decompiled with Potassium's decompiler.

function BufferToHex(p1)
    local v2 = buffer.len(p1);
    local v3 = buffer.create(v2 * 2);
    for v4 = 0, v2 - 1 do
        local v5 = buffer.readu8(p1, v4);
        local v6 = bit32.rshift(v5, 4);
        local v7 = bit32.band(v5, 15);
        local v8 = v4 * 2 + 0;
        local v9;
        if v6 < 10 then
            v9 = v6 + 48;
        else
            v9 = v6 + 87;
        end;
        buffer.writeu8(v3, v8, v9);
        local v10 = v4 * 2 + 1;
        local v11;
        if v7 < 10 then
            v11 = v7 + 48;
        else
            v11 = v7 + 87;
        end;
        buffer.writeu8(v3, v10, v11);
    end;
    return buffer.tostring(v3);
end;
return BufferToHex;