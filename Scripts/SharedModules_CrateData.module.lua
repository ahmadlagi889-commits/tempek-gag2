-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = nil;
local function u6() --[[ Line: 8 ]]
    -- upvalues: u3 (ref)
    if u3 == nil then
        local l__Parent__1 = script.Parent;
        if l__Parent__1 then
            l__Parent__1 = l__Parent__1:FindFirstChild("GuildCrateData");
        end;
        if l__Parent__1 and l__Parent__1:IsA("ModuleScript") then
            local v4, v5 = pcall(require, l__Parent__1);
            if v4 then
                u3 = v5;
            else
                warn((`[CrateData] GuildCrateData require failed; guild crate lookups disabled: {v5}`));
                u3 = false;
            end;
        else
            u3 = false;
        end;
    end;
    if u3 == false then
        return nil;
    else
        return u3;
    end;
end;
function u1.GetData(p7) --[[ Line: 42 ]]
    -- upvalues: u2 (copy), u6 (copy)
    if u2[p7] then
        return u2[p7];
    end;
    local u8 = script:FindFirstChild(p7);
    if not u8 then
        local v9 = u6();
        return v9 and v9.GetData(p7) or nil;
    end;
    local v10, v11 = pcall(function() --[[ Line: 63 ]]
        -- upvalues: u8 (copy)
        return require(u8);
    end);
    if not v10 then
        warn((`[CrateData] Crate module require failed ({p7}): {v11}`));
        return nil;
    end;
    local l__Parent__2 = script.Parent;
    local v12;
    if l__Parent__2 then
        local v13 = l__Parent__2:FindFirstChild("CrateImages");
        if v13 then
            local v14 = v13:FindFirstChild(p7);
            if v14 and (v14:IsA("StringValue") and v14.Value ~= "") then
                v12 = v14.Value;
            else
                v12 = nil;
            end;
        else
            v12 = nil;
        end;
    else
        v12 = nil;
    end;
    if v12 then
        v11.IMG = v12;
    end;
    u2[p7] = v11;
    return v11;
end;
function u1.IsGuildCrate(p15) --[[ Line: 83 ]]
    -- upvalues: u6 (copy)
    local v16 = u6();
    if v16 then
        return v16.GetData(p15) ~= nil;
    else
        return false;
    end;
end;
function u1.GetRandomItem(p17) --[[ Line: 89 ]]
    -- upvalues: u1 (copy)
    local v18 = u1.GetData(p17);
    if not v18 or (not v18.Items or #v18.Items == 0) then
        return nil;
    end;
    local v19 = 0;
    for _, v20 in v18.Items do
        v19 = v19 + v20.Chance;
    end;
    local v21 = math.random() * v19;
    local v22 = 0;
    for _, v23 in v18.Items do
        v22 = v22 + v23.Chance;
        if v21 <= v22 then
            return v23;
        end;
    end;
    return v18.Items[#v18.Items];
end;
function u1.GetAllCrates() --[[ Line: 113 ]]
    -- upvalues: u1 (copy), u6 (copy)
    local v24 = {};
    for _, v25 in script:GetChildren() do
        if v25:IsA("ModuleScript") then
            local v26 = u1.GetData(v25.Name);
            if v26 then
                table.insert(v24, v26);
            end;
        end;
    end;
    local v27 = u6();
    if v27 then
        for _, v28 in v27.GetAllCrates() do
            table.insert(v24, v28);
        end;
    end;
    return v24;
end;
return u1;