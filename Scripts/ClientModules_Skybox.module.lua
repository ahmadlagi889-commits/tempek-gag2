-- Decompiled with Potassium's decompiler.

local u1 = {
    List = {}
};
local u2 = nil;
local function u7() --[[ Line: 7 ]]
    -- upvalues: u1 (copy), u2 (ref)
    local v3 = nil;
    local v4 = nil;
    for v5, v6 in u1.List do
        if not v3 or v3 <= v6 then
            v4 = v5;
            v3 = v6;
        end;
    end;
    if u2 and u2 ~= v4 then
        u2.Parent = script;
    end;
    u2 = v4;
    v4.Parent = game.Lighting;
end;
function u1.SetOrder(p8, p9) --[[ Line: 28 ]]
    -- upvalues: u1 (copy), u7 (copy)
    u1.List[p8] = p9;
    u7();
end;
u1.SetOrder(game.Lighting.Sky, 1);
return u1;