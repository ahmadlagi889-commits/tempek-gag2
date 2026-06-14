-- Decompiled with Potassium's decompiler.

local u1 = {
    Big = 2,
    Huge = 4
};
local u2 = {
    Big = 2,
    Huge = 3
};
local u3 = {};
function u3.GetScale(p4, p5) --[[ Line: 21 ]]
    -- upvalues: u3 (copy), u1 (copy)
    if type(p4) ~= "string" then
        return 1;
    end;
    local v6 = u3.Normalize(p4);
    if v6 == nil then
        return 1;
    end;
    if p5 ~= nil then
        local v7 = p5[v6];
        if type(v7) == "number" then
            return v7;
        end;
    end;
    return u1[v6] or 1;
end;
function u3.GetBoostMultiplier(p8) --[[ Line: 34 ]]
    -- upvalues: u3 (copy), u2 (copy)
    local v9 = u3.Normalize(p8);
    return v9 and (u2[v9] or 1) or 1;
end;
function u3.Normalize(p10) --[[ Line: 41 ]]
    -- upvalues: u1 (copy)
    if type(p10) ~= "string" then
        return nil;
    end;
    for v11 in u1 do
        if string.lower(p10) == string.lower(v11) then
            return v11;
        end;
    end;
    return nil;
end;
function u3.DisplayName(p12, p13) --[[ Line: 51 ]]
    -- upvalues: u3 (copy)
    local v14 = u3.Normalize(p13);
    if v14 then
        return `{v14} {p12}`;
    else
        return p12;
    end;
end;
u3.Scales = table.freeze(u1);
u3.BoostMultipliers = table.freeze(u2);
return table.freeze(u3);