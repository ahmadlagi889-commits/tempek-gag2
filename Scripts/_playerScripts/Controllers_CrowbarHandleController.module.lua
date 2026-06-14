-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Crowbar__3 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Crowbar");
local l__BackpackListener__4 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = CFrame.new(0, 0, 0);
local u6 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
function v1.Init(_) --[[ Line: 19 ]] end;
function v1.Start(u7) --[[ Line: 22 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v8 in l__Players__1:GetPlayers() do
        u7:SetupPlayer(v8);
    end;
    l__Players__1.PlayerAdded:Connect(function(p9) --[[ Line: 27 ]]
        -- upvalues: u7 (copy)
        u7:SetupPlayer(p9);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p10) --[[ Line: 31 ]]
        -- upvalues: u2 (ref), l__Players__1 (ref), u7 (copy)
        for v11 in u2 do
            local v12 = not l__Players__1:GetPlayerFromCharacter(v11.Parent) and (v11.Parent and v11.Parent:IsA("Backpack"));
            if v12 then
                v12 = l__Players__1:GetPlayerFromCharacter(v11.Parent.Parent);
            end;
            if v12 == p10 then
                u7:CleanupTool(v11);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p13) --[[ Line: 42 ]]
    p13.Anchored = false;
    p13.CanCollide = false;
    p13.CanQuery = false;
    p13.CanTouch = true;
end;
function v1.DisableVFX(_, p14) --[[ Line: 49 ]]
    for _, v15 in p14:GetDescendants() do
        if v15:IsA("ParticleEmitter") or (v15:IsA("Trail") or v15:IsA("Beam")) then
            v15.Enabled = false;
        elseif v15:IsA("Fire") or (v15:IsA("Smoke") or v15:IsA("Sparkles")) then
            v15.Enabled = false;
        elseif v15:IsA("Light") then
            v15.Enabled = false;
        end;
    end;
end;
function v1.ClearHandle(_, p16) --[[ Line: 61 ]]
    for _, u17 in p16:GetChildren() do
        if u17.Name == "Handle" or (u17.Name == "Build" or u17:IsA("Model")) then
            u17.Parent = nil;
            task.defer(function() --[[ Line: 65 ]]
                -- upvalues: u17 (copy)
                if u17 then
                    u17:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p18) --[[ Line: 74 ]]
    for _, v19 in p18:GetChildren() do
        if v19.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p20, p21, p22) --[[ Line: 83 ]]
    -- upvalues: u4 (copy), l__Crowbar__3 (copy), l__LocalPlayer__5 (copy), u5 (copy), u6 (copy)
    if u4[p21] then
    else
        u4[p21] = true;
        p20:ClearHandle(p21);
        local v23 = p22:FindFirstChild("Right Arm") or p22:FindFirstChild("RightHand");
        if v23 then
            local v24 = l__Crowbar__3:Clone();
            p20:DisableVFX(v24);
            local v25 = l__LocalPlayer__5;
            if v25 then
                v25 = l__LocalPlayer__5.Character == p22;
            end;
            if v24:IsA("BasePart") then
                p20:PreparePartForTool(v24);
                v24.Name = "Handle";
                v24.Parent = p21;
                if v25 then
                    p21.Grip = u5;
                else
                    v24.CFrame = v23.CFrame * u6;
                    local v26 = Instance.new("WeldConstraint");
                    v26.Part0 = v24;
                    v26.Part1 = v23;
                    v26.Parent = v24;
                end;
            elseif v24:IsA("Model") then
                local l__PrimaryPart__6 = v24.PrimaryPart;
                if not l__PrimaryPart__6 then
                    v24:Destroy();
                    u4[p21] = nil;
                    return;
                end;
                for _, v27 in v24:GetDescendants() do
                    if v27:IsA("BasePart") then
                        p20:PreparePartForTool(v27);
                    end;
                end;
                for _, v28 in v24:GetDescendants() do
                    if v28:IsA("BasePart") and v28 ~= l__PrimaryPart__6 then
                        local v29 = Instance.new("WeldConstraint");
                        v29.Part0 = l__PrimaryPart__6;
                        v29.Part1 = v28;
                        v29.Parent = v28;
                    end;
                end;
                v24.Name = "Build";
                v24.Parent = p21;
                l__PrimaryPart__6.Name = "Handle";
                l__PrimaryPart__6.Parent = p21;
                if v25 then
                    p21.Grip = u5;
                else
                    l__PrimaryPart__6.CFrame = v23.CFrame * u6;
                    local v30 = Instance.new("WeldConstraint");
                    v30.Part0 = l__PrimaryPart__6;
                    v30.Part1 = v23;
                    v30.Parent = l__PrimaryPart__6;
                end;
            end;
            u4[p21] = nil;
        else
            u4[p21] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p31, p32) --[[ Line: 160 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4[p32] then
    else
        local v33 = u3[p32];
        if v33 then
            local v34 = p32.Parent == v33;
            local v35 = p31:HasHandle(p32);
            if v34 and not v35 then
                p31:SpawnHandle(p32, v33);
            else
                if not v34 and v35 then
                    p31:ClearHandle(p32);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p36) --[[ Line: 176 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v37 = u2[p36];
    if v37 then
        for _, v38 in v37 do
            v38:Disconnect();
        end;
        u2[p36] = nil;
    end;
    u3[p36] = nil;
    u4[p36] = nil;
end;
function v1.CleanupTool(p39, p40) --[[ Line: 188 ]]
    p39:ClearHandle(p40);
    p39:DisconnectTool(p40);
end;
function v1.IsTrackedTool(_, p41) --[[ Line: 193 ]]
    return p41:GetAttribute("Crowbar") ~= nil;
end;
function v1.SetupTool(u42, u43, p44) --[[ Line: 197 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u42:DisconnectTool(u43);
    local v45 = {};
    u3[u43] = p44;
    local v46 = u43:GetPropertyChangedSignal("Parent");
    table.insert(v45, v46:Connect(function() --[[ Line: 203 ]]
        -- upvalues: u43 (copy), u3 (ref), u42 (copy)
        task.defer(function() --[[ Line: 204 ]]
            -- upvalues: u43 (ref), u3 (ref), u42 (ref)
            if u43 and u3[u43] then
                u42:UpdateToolState(u43);
            end;
        end);
    end));
    u2[u43] = v45;
    task.defer(function() --[[ Line: 213 ]]
        -- upvalues: u43 (copy), u3 (ref), u42 (copy)
        if u43 and u3[u43] then
            u42:UpdateToolState(u43);
        end;
    end);
end;
function v1.SetupCharacter(u47, u48) --[[ Line: 220 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 221 ]]
        -- upvalues: u48 (copy), u47 (copy), l__Players__1 (ref)
        if u48 and u48.Parent then
            for _, v49 in u48:GetChildren() do
                if v49:IsA("Tool") and u47:IsTrackedTool(v49) then
                    u47:SetupTool(v49, u48);
                end;
            end;
            local v50 = l__Players__1:GetPlayerFromCharacter(u48);
            if v50 and v50.Backpack then
                for _, v51 in v50.Backpack:GetChildren() do
                    if v51:IsA("Tool") and u47:IsTrackedTool(v51) then
                        u47:SetupTool(v51, u48);
                    end;
                end;
            end;
            u48.ChildAdded:Connect(function(u52) --[[ Line: 240 ]]
                -- upvalues: u47 (ref), u48 (ref)
                if u52:IsA("Tool") and u47:IsTrackedTool(u52) then
                    task.defer(function() --[[ Line: 242 ]]
                        -- upvalues: u52 (copy), u48 (ref), u47 (ref)
                        if u52 and (u52.Parent and (u48 and u48.Parent)) then
                            u47:SetupTool(u52, u48);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u53, u54) --[[ Line: 252 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u54.Character then
        u53:SetupCharacter(u54.Character);
    end;
    u54.CharacterAdded:Connect(function(p55) --[[ Line: 257 ]]
        -- upvalues: u53 (copy)
        u53:SetupCharacter(p55);
    end);
    l__BackpackListener__4.bind(u54, function(u56) --[[ Line: 261 ]]
        -- upvalues: u53 (copy), u54 (copy)
        if u56:IsA("Tool") and u53:IsTrackedTool(u56) then
            task.defer(function() --[[ Line: 263 ]]
                -- upvalues: u54 (ref), u56 (copy), u53 (ref)
                local l__Character__7 = u54.Character;
                if u56 and (u56.Parent and (l__Character__7 and l__Character__7.Parent)) then
                    u53:SetupTool(u56, l__Character__7);
                end;
            end);
        end;
    end);
end;
return v1;