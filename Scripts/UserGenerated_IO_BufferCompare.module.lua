-- Decompiled with Potassium's decompiler.

return function(p1, p2) --[[ Name: CompareBuffer, Line 20 ]]
    local v3 = buffer.len(p1);
    local v4 = buffer.len(p2);
    for v5 = 0, math.min(v3, v4) - 1 do
        local v6 = buffer.readu8(p1, v5);
        local v7 = buffer.readu8(p2, v5);
        if v6 ~= v7 then
            return v6 - v7;
        end;
    end;
    return v3 - v4;
end;