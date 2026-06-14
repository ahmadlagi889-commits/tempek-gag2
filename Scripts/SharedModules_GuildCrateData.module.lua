-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
function u1.GetData(p3) --[[ Line: 45 ]]
    -- upvalues: u2 (copy)
    if u2[p3] then
        return u2[p3];
    end;
    local u4 = script:FindFirstChild(p3);
    if not (u4 and u4:IsA("ModuleScript")) then
        return nil;
    end;
    local v5, v6 = pcall(function() --[[ Line: 55 ]]
        -- upvalues: u4 (copy)
        return require(u4);
    end);
    if not v5 or type(v6) ~= "table" then
        warn((`[GuildCrateData] Crate module require failed ({p3}): {v5 and "not a table" or v6}`));
        return nil;
    end;
    local v7 = script:FindFirstChild("GuildCrateImages");
    local v8;
    if v7 then
        local v9 = v7:FindFirstChild(p3);
        if v9 and (v9:IsA("StringValue") and v9.Value ~= "") then
            v8 = v9.Value;
        else
            v8 = nil;
        end;
    else
        v8 = nil;
    end;
    if v8 then
        v6.IMG = v8;
    elseif not v6.IMG or v6.IMG == "" then
        v6.IMG = "rbxassetid://102182642774885";
    end;
    u2[p3] = v6;
    return v6;
end;
function u1.GetRandomItem(p10) --[[ Line: 77 ]]
    -- upvalues: u1 (copy)
    local v11 = u1.GetData(p10);
    if not v11 or (not v11.Items or #v11.Items == 0) then
        return nil;
    end;
    local v12 = 0;
    for _, v13 in v11.Items do
        v12 = v12 + v13.Chance;
    end;
    local v14 = math.random() * v12;
    local v15 = 0;
    for _, v16 in v11.Items do
        v15 = v15 + v16.Chance;
        if v14 <= v15 then
            return v16;
        end;
    end;
    return v11.Items[#v11.Items];
end;
function u1.GetAllCrates() --[[ Line: 101 ]]
    -- upvalues: u1 (copy)
    local v17 = {};
    for _, v18 in script:GetChildren() do
        if v18:IsA("ModuleScript") then
            local v19 = u1.GetData(v18.Name);
            if v19 then
                table.insert(v17, v19);
            end;
        end;
    end;
    return v17;
end;
function u1.IsGuildCrate(p20) --[[ Line: 114 ]]
    -- upvalues: u1 (copy)
    return u1.GetData(p20) ~= nil;
end;
return u1;