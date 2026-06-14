-- Decompiled with Potassium's decompiler.

return function(u1) --[[ Name: EmitOnce, Line 20 ]]
    local l__TimeScale__1 = u1.TimeScale;
    if l__TimeScale__1 <= 0 then
        return 0;
    end;
    local l__Rate__2 = u1.Rate;
    local v2 = u1:GetAttribute("EmitCount");
    if type(v2) ~= "number" then
        v2 = l__Rate__2;
    end;
    local u3 = math.floor(v2);
    local v4 = v2 - u3;
    if v4 > 0 and math.random() < v4 then
        u3 = u3 + 1;
    end;
    if u3 < 1 then
        return 0;
    end;
    local v5 = u1:GetAttribute("EmitDelay");
    local v6 = type(v5) ~= "number" and 0 or v5;
    if v6 == (1 / 0) then
        return 0;
    end;
    local v7 = math.max(v6, 0);
    task.delay(v7, function() --[[ Line: 53 ]]
        -- upvalues: u1 (copy), u3 (ref)
        u1:Emit(u3);
    end);
    return v7 + u1.Lifetime.Max / l__TimeScale__1;
end;