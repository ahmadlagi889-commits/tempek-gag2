-- Decompiled with Potassium's decompiler.

function DeepFreezeUnsafe(p1)
    if type(p1) ~= "table" then
        return p1;
    end;
    if not table.isfrozen(p1) then
        table.freeze(p1);
    end;
    for v2, v3 in next, p1 do
        DeepFreezeUnsafe(v2);
        DeepFreezeUnsafe(v3);
    end;
    return p1;
end;
return DeepFreezeUnsafe;