-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Teleporter__3 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Teleporter");
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
function v1.PreparePartForTool(_, p13, p14) --[[ Line: 42 ]]
    p13.Anchored = false;
    p13.CanCollide = false;
    p13.CanQuery = false;
    p13.CanTouch = p14 == true;
end;
function v1.DisableVFX(_, p15) --[[ Line: 49 ]]
    for _, v16 in p15:GetDescendants() do
        if v16:IsA("ParticleEmitter") or (v16:IsA("Trail") or v16:IsA("Beam")) then
            v16.Enabled = false;
        elseif v16:IsA("Fire") or (v16:IsA("Smoke") or v16:IsA("Sparkles")) then
            v16.Enabled = false;
        elseif v16:IsA("Light") then
            v16.Enabled = false;
        end;
    end;
end;
function v1.ClearHandle(_, p17) --[[ Line: 61 ]]
    for _, u18 in p17:GetChildren() do
        if u18.Name == "Handle" or (u18.Name == "Build" or u18:IsA("Model")) then
            u18.Parent = nil;
            task.defer(function() --[[ Line: 65 ]]
                -- upvalues: u18 (copy)
                if u18 then
                    u18:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p19) --[[ Line: 74 ]]
    for _, v20 in p19:GetChildren() do
        if v20.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p21, p22, p23) --[[ Line: 83 ]]
    -- upvalues: u4 (copy), l__Teleporter__3 (copy), l__LocalPlayer__5 (copy), u5 (copy), u6 (copy)
    if u4[p22] then
    else
        u4[p22] = true;
        p21:ClearHandle(p22);
        local v24 = p23:FindFirstChild("Right Arm") or p23:FindFirstChild("RightHand");
        if v24 then
            local v25 = l__Teleporter__3:Clone();
            p21:DisableVFX(v25);
            local v26 = l__LocalPlayer__5;
            if v26 then
                v26 = l__LocalPlayer__5.Character == p23;
            end;
            if v25:IsA("BasePart") then
                p21:PreparePartForTool(v25, v26);
                v25.Name = "Handle";
                v25.Parent = p22;
                if v26 then
                    p22.Grip = u5;
                else
                    v25.CFrame = v24.CFrame * u6;
                    local v27 = Instance.new("WeldConstraint");
                    v27.Part0 = v25;
                    v27.Part1 = v24;
                    v27.Parent = v25;
                end;
            elseif v25:IsA("Model") then
                local l__PrimaryPart__6 = v25.PrimaryPart;
                if not l__PrimaryPart__6 then
                    v25:Destroy();
                    u4[p22] = nil;
                    return;
                end;
                for _, v28 in v25:GetDescendants() do
                    if v28:IsA("BasePart") then
                        p21:PreparePartForTool(v28, v26);
                    end;
                end;
                for _, v29 in v25:GetDescendants() do
                    if v29:IsA("BasePart") and v29 ~= l__PrimaryPart__6 then
                        local v30 = Instance.new("WeldConstraint");
                        v30.Part0 = l__PrimaryPart__6;
                        v30.Part1 = v29;
                        v30.Parent = v29;
                    end;
                end;
                v25.Name = "Build";
                v25.Parent = p22;
                l__PrimaryPart__6.Name = "Handle";
                l__PrimaryPart__6.Parent = p22;
                if v26 then
                    p22.Grip = u5;
                else
                    l__PrimaryPart__6.CFrame = v24.CFrame * u6;
                    local v31 = Instance.new("WeldConstraint");
                    v31.Part0 = l__PrimaryPart__6;
                    v31.Part1 = v24;
                    v31.Parent = l__PrimaryPart__6;
                end;
            end;
            u4[p22] = nil;
        else
            u4[p22] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p32, p33) --[[ Line: 160 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4[p33] then
    else
        local v34 = u3[p33];
        if v34 then
            local v35 = p33.Parent == v34;
            local v36 = p32:HasHandle(p33);
            if v35 and not v36 then
                p32:SpawnHandle(p33, v34);
            else
                if not v35 and v36 then
                    p32:ClearHandle(p33);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p37) --[[ Line: 176 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v38 = u2[p37];
    if v38 then
        for _, v39 in v38 do
            v39:Disconnect();
        end;
        u2[p37] = nil;
    end;
    u3[p37] = nil;
    u4[p37] = nil;
end;
function v1.CleanupTool(p40, p41) --[[ Line: 188 ]]
    p40:ClearHandle(p41);
    p40:DisconnectTool(p41);
end;
function v1.IsTrackedTool(_, p42) --[[ Line: 193 ]]
    return p42:GetAttribute("Teleporter") ~= nil;
end;
function v1.SetupTool(u43, u44, p45) --[[ Line: 197 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u43:DisconnectTool(u44);
    local v46 = {};
    u3[u44] = p45;
    local v47 = u44:GetPropertyChangedSignal("Parent");
    table.insert(v46, v47:Connect(function() --[[ Line: 203 ]]
        -- upvalues: u44 (copy), u3 (ref), u43 (copy)
        task.defer(function() --[[ Line: 204 ]]
            -- upvalues: u44 (ref), u3 (ref), u43 (ref)
            if u44 and u3[u44] then
                u43:UpdateToolState(u44);
            end;
        end);
    end));
    u2[u44] = v46;
    task.defer(function() --[[ Line: 213 ]]
        -- upvalues: u44 (copy), u3 (ref), u43 (copy)
        if u44 and u3[u44] then
            u43:UpdateToolState(u44);
        end;
    end);
end;
function v1.SetupCharacter(u48, u49) --[[ Line: 220 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 221 ]]
        -- upvalues: u49 (copy), u48 (copy), l__Players__1 (ref)
        if u49 and u49.Parent then
            for _, v50 in u49:GetChildren() do
                if v50:IsA("Tool") and u48:IsTrackedTool(v50) then
                    u48:SetupTool(v50, u49);
                end;
            end;
            local v51 = l__Players__1:GetPlayerFromCharacter(u49);
            if v51 and v51.Backpack then
                for _, v52 in v51.Backpack:GetChildren() do
                    if v52:IsA("Tool") and u48:IsTrackedTool(v52) then
                        u48:SetupTool(v52, u49);
                    end;
                end;
            end;
            u49.ChildAdded:Connect(function(u53) --[[ Line: 240 ]]
                -- upvalues: u48 (ref), u49 (ref)
                if u53:IsA("Tool") and u48:IsTrackedTool(u53) then
                    task.defer(function() --[[ Line: 242 ]]
                        -- upvalues: u53 (copy), u49 (ref), u48 (ref)
                        if u53 and (u53.Parent and (u49 and u49.Parent)) then
                            u48:SetupTool(u53, u49);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u54, u55) --[[ Line: 252 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u55.Character then
        u54:SetupCharacter(u55.Character);
    end;
    u55.CharacterAdded:Connect(function(p56) --[[ Line: 257 ]]
        -- upvalues: u54 (copy)
        u54:SetupCharacter(p56);
    end);
    l__BackpackListener__4.bind(u55, function(u57) --[[ Line: 261 ]]
        -- upvalues: u54 (copy), u55 (copy)
        if u57:IsA("Tool") and u54:IsTrackedTool(u57) then
            task.defer(function() --[[ Line: 263 ]]
                -- upvalues: u55 (ref), u57 (copy), u54 (ref)
                local l__Character__7 = u55.Character;
                if u57 and (u57.Parent and (l__Character__7 and l__Character__7.Parent)) then
                    u54:SetupTool(u57, l__Character__7);
                end;
            end);
        end;
    end);
end;
return v1;