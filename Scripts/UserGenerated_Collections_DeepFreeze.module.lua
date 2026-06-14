-- Decompiled with Potassium's decompiler.

function DeepFreeze(p1, p2)
    if type(p1) ~= "table" then
        return p1;
    end;
    if not table.isfrozen(p1) then
        table.freeze(p1);
    end;
    local v3 = p2 or {};
    if not v3[p1] then
        v3[p1] = true;
        for v4, v5 in next, p1 do
            DeepFreeze(v4, v3);
            DeepFreeze(v5, v3);
        end;
        v3[p1] = nil;
    end;
    return p1;
end;
return DeepFreeze;