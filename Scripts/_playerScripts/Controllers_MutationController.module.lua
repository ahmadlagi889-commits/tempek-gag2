-- Decompiled with Potassium's decompiler.

local v1 = {};
local u2 = {};
function v1.Init(_) --[[ Line: 6 ]]
    for _, v3 in pairs(script:GetChildren()) do
        require(v3);
    end;
end;
function v1.GetMutationModule(_, p4) --[[ Line: 12 ]]
    -- upvalues: u2 (copy)
    if u2[p4] then
        return u2[p4];
    end;
    local v5 = script:FindFirstChild(p4);
    if not v5 then
        return nil;
    end;
    u2[p4] = require(v5);
    return u2[p4];
end;
function v1.ApplyMutation(p6, p7) --[[ Line: 26 ]]
    local v8 = p7:GetAttribute("Mutation");
    if v8 then
        local v9 = p6:GetMutationModule(v8);
        if v9 and v9.ApplyMutationEffect then
            v9.ApplyMutationEffect(p7);
        end;
    end;
end;
function v1.SetupListener(u10, p11) --[[ Line: 36 ]]
    for _, v12 in p11:GetDescendants() do
        if v12:GetAttribute("Mutation") then
            u10:ApplyMutation(v12);
        end;
    end;
    p11.DescendantAdded:Connect(function(p13) --[[ Line: 45 ]]
        -- upvalues: u10 (copy)
        if p13:GetAttribute("Mutation") then
            u10:ApplyMutation(p13);
        end;
    end);
    p11.DescendantAdded:Connect(function(u14) --[[ Line: 52 ]]
        -- upvalues: u10 (copy)
        u14:GetAttributeChangedSignal("Mutation"):Connect(function() --[[ Line: 53 ]]
            -- upvalues: u14 (copy), u10 (ref)
            if u14:GetAttribute("Mutation") then
                u10:ApplyMutation(u14);
            end;
        end);
    end);
end;
function v1.Start(p15) --[[ Line: 61 ]]
    p15:SetupListener(workspace);
end;
return v1;