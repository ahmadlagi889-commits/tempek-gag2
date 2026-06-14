-- Decompiled with Potassium's decompiler.

local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local u1 = nil;
local u2 = nil;
local function u7(p3, p4) --[[ Line: 35 ]]
    if p3 then
        for _, v5 in p3:GetChildren() do
            if v5:IsA("StringValue") then
                local v6 = tonumber(string.match(v5.Value, "rbxassetid://(%d+)"));
                if v6 and v6 > 0 then
                    p4[v6] = true;
                end;
            end;
        end;
    end;
end;
local function u12() --[[ Line: 46 ]]
    -- upvalues: l__ReplicatedStorage__1 (copy), u7 (copy), u1 (ref), u2 (ref)
    local v8 = {};
    local v9 = l__ReplicatedStorage__1.SharedModules:FindFirstChild("SeedData");
    if v9 then
        u7(v9:FindFirstChild("SeedImages"), v8);
        u7(v9:FindFirstChild("FruitImages"), v8);
        u7(v9:FindFirstChild("PlantImages"), v8);
    end;
    u7(l__ReplicatedStorage__1.SharedModules:FindFirstChild("GearImages"), v8);
    local v10 = {};
    for v11 in v8 do
        table.insert(v10, v11);
    end;
    if #v10 == 0 then
        v8[81520753924742] = true;
        table.insert(v10, 81520753924742);
    end;
    u1 = v10;
    u2 = v8;
end;
return table.freeze({
    FALLBACK_ICON_ID = 81520753924742,
    DEFAULT_ICON_ID = 81520753924742,
    GetPool = function() --[[ Name: GetPool, Line 84 ]]
        -- upvalues: u1 (ref), u2 (ref), u12 (copy)
        if not (u1 and u2) then
            u12();
        end;
        return u1;
    end,
    Random = function() --[[ Name: Random, Line 89 ]]
        -- upvalues: u1 (ref), u2 (ref), u12 (copy)
        if not (u1 and u2) then
            u12();
        end;
        local v13 = u1;
        return v13[math.random(#v13)];
    end,
    IsPoolIcon = function(p14) --[[ Name: IsPoolIcon, Line 94 ]]
        -- upvalues: u1 (ref), u2 (ref), u12 (copy)
        if typeof(p14) ~= "number" then
            return false;
        end;
        if not (u1 and u2) then
            u12();
        end;
        return u2[p14] == true;
    end
});