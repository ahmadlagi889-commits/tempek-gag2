-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local u1 = {};
local u2 = {};
local u3 = {};
u3.__index = u3;
function u3.New(p4, p5) --[[ Line: 41 ]]
    -- upvalues: u3 (copy), u2 (copy)
    if p4 <= 0 then
        error("[RateLimit]: Invalid rate");
    end;
    local v6 = {
        sources = {},
        rate_period = 1 / p4,
        is_full_wait = p5 == true
    };
    setmetatable(v6, u3);
    u2[v6] = true;
    return v6;
end;
function u3.CheckRate(p7, p8) --[[ Line: 58 ]]
    -- upvalues: u1 (copy)
    local l__sources__2 = p7.sources;
    local v9 = os.clock();
    local v10 = p8 == nil and "nil" or p8;
    local v11 = l__sources__2[v10];
    if v11 == nil then
        if typeof(v10) == "Instance" and (v10:IsA("Player") and u1[v10] == nil) then
            return false;
        end;
        l__sources__2[v10] = v9 + p7.rate_period;
        return true;
    end;
    if p7.is_full_wait == true then
        if v11 > v9 then
            return false;
        end;
        l__sources__2[v10] = v9 + p7.rate_period;
        return true;
    end;
    local v12 = math.max(v9, v11 + p7.rate_period);
    if v12 - v9 >= 1 then
        return false;
    end;
    l__sources__2[v10] = v12;
    return true;
end;
function u3.CleanSource(p13, p14) --[[ Line: 98 ]]
    p13.sources[p14] = nil;
end;
function u3.Cleanup(p15) --[[ Line: 102 ]]
    p15.sources = {};
end;
function u3.Destroy(p16) --[[ Line: 106 ]]
    -- upvalues: u2 (copy)
    u2[p16] = nil;
end;
for _, v17 in ipairs(l__Players__1:GetPlayers()) do
    u1[v17] = true;
end;
l__Players__1.PlayerAdded:Connect(function(p18) --[[ Line: 116 ]]
    -- upvalues: u1 (copy)
    u1[p18] = true;
end);
l__Players__1.PlayerRemoving:Connect(function(p19) --[[ Line: 120 ]]
    -- upvalues: u1 (copy), u2 (copy)
    u1[p19] = nil;
    for v20 in pairs(u2) do
        v20.sources[p19] = nil;
    end;
end);
return u3;