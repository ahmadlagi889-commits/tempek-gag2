-- Decompiled with Potassium's decompiler.

function DeepCopyPureUnsafe(p1)
    if type(p1) ~= "table" then
        return p1;
    end;
    local v2 = {};
    for v3, v4 in next, p1 do
        v2[DeepCopyPureUnsafe(v3)] = DeepCopyPureUnsafe(v4);
    end;
    return v2;
end;
return DeepCopyPureUnsafe;