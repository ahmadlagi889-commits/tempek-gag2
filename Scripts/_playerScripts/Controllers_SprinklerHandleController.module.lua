-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Sprinklers__3 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Sprinklers");
local l__BackpackListener__4 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = CFrame.new(0, 0.5, 0.25);
local u6 = CFrame.new(0, -1.25, 0.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
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
    p13.CanTouch = false;
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
        if u17:GetAttribute("ClientHandle") and (u17.Name == "Handle" or (u17.Name == "Build" or u17:IsA("Model"))) then
            u17.Parent = nil;
            task.defer(function() --[[ Line: 66 ]]
                -- upvalues: u17 (copy)
                if u17 then
                    u17:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p18) --[[ Line: 75 ]]
    for _, v19 in p18:GetChildren() do
        if v19.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p20, p21, p22) --[[ Line: 84 ]]
    -- upvalues: u4 (copy), l__Sprinklers__3 (copy), l__LocalPlayer__5 (copy), u5 (copy), u6 (copy)
    if u4[p21] then
    else
        u4[p21] = true;
        p20:ClearHandle(p21);
        local v23 = p21:GetAttribute("Sprinkler");
        if v23 then
            local v24 = l__Sprinklers__3:FindFirstChild(v23);
            if v24 then
                local v25 = p22:FindFirstChild("Right Arm") or p22:FindFirstChild("RightHand");
                if v25 then
                    local v26 = v24:Clone();
                    p20:DisableVFX(v26);
                    local v27 = l__LocalPlayer__5;
                    if v27 then
                        v27 = l__LocalPlayer__5.Character == p22;
                    end;
                    if v26:IsA("BasePart") then
                        p20:PreparePartForTool(v26);
                        v26.Name = "Handle";
                        v26:SetAttribute("ClientHandle", true);
                        v26.Parent = p21;
                        if v27 then
                            p21.Grip = u5;
                        else
                            v26.CFrame = v25.CFrame * u6;
                            local v28 = Instance.new("WeldConstraint");
                            v28.Part0 = v26;
                            v28.Part1 = v25;
                            v28.Parent = v26;
                        end;
                    elseif v26:IsA("Model") then
                        local l__PrimaryPart__6 = v26.PrimaryPart;
                        if not l__PrimaryPart__6 then
                            v26:Destroy();
                            u4[p21] = nil;
                            return;
                        end;
                        for _, v29 in v26:GetDescendants() do
                            if v29:IsA("BasePart") then
                                p20:PreparePartForTool(v29);
                            end;
                        end;
                        for _, v30 in v26:GetDescendants() do
                            if v30:IsA("BasePart") and v30 ~= l__PrimaryPart__6 then
                                local v31 = Instance.new("WeldConstraint");
                                v31.Part0 = l__PrimaryPart__6;
                                v31.Part1 = v30;
                                v31.Parent = v30;
                            end;
                        end;
                        v26.Name = "Build";
                        v26:SetAttribute("ClientHandle", true);
                        v26.Parent = p21;
                        l__PrimaryPart__6.Name = "Handle";
                        l__PrimaryPart__6:SetAttribute("ClientHandle", true);
                        l__PrimaryPart__6.Parent = p21;
                        if v27 then
                            p21.Grip = u5;
                        else
                            l__PrimaryPart__6.CFrame = v25.CFrame * u6;
                            local v32 = Instance.new("WeldConstraint");
                            v32.Part0 = l__PrimaryPart__6;
                            v32.Part1 = v25;
                            v32.Parent = l__PrimaryPart__6;
                        end;
                    end;
                    u4[p21] = nil;
                else
                    u4[p21] = nil;
                end;
            else
                u4[p21] = nil;
            end;
        else
            u4[p21] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p33, p34) --[[ Line: 176 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4[p34] then
    else
        local v35 = u3[p34];
        if v35 then
            local v36 = p34.Parent == v35;
            local v37 = p33:HasHandle(p34);
            if v36 and not v37 then
                p33:SpawnHandle(p34, v35);
            else
                if not v36 and v37 then
                    p33:ClearHandle(p34);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p38) --[[ Line: 192 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v39 = u2[p38];
    if v39 then
        for _, v40 in v39 do
            v40:Disconnect();
        end;
        u2[p38] = nil;
    end;
    u3[p38] = nil;
    u4[p38] = nil;
end;
function v1.CleanupTool(p41, p42) --[[ Line: 204 ]]
    p41:ClearHandle(p42);
    p41:DisconnectTool(p42);
end;
function v1.IsTrackedTool(_, p43) --[[ Line: 209 ]]
    return p43:GetAttribute("Sprinkler") ~= nil;
end;
function v1.SetupTool(u44, u45, p46) --[[ Line: 213 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u44:DisconnectTool(u45);
    local v47 = {};
    u3[u45] = p46;
    local v48 = u45:GetPropertyChangedSignal("Parent");
    table.insert(v47, v48:Connect(function() --[[ Line: 219 ]]
        -- upvalues: u45 (copy), u3 (ref), u44 (copy)
        task.defer(function() --[[ Line: 220 ]]
            -- upvalues: u45 (ref), u3 (ref), u44 (ref)
            if u45 and u3[u45] then
                u44:UpdateToolState(u45);
            end;
        end);
    end));
    u2[u45] = v47;
    task.defer(function() --[[ Line: 229 ]]
        -- upvalues: u45 (copy), u3 (ref), u44 (copy)
        if u45 and u3[u45] then
            u44:UpdateToolState(u45);
        end;
    end);
end;
function v1.SetupCharacter(u49, u50) --[[ Line: 236 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 237 ]]
        -- upvalues: u50 (copy), u49 (copy), l__Players__1 (ref)
        if u50 and u50.Parent then
            for _, v51 in u50:GetChildren() do
                if v51:IsA("Tool") and u49:IsTrackedTool(v51) then
                    u49:SetupTool(v51, u50);
                end;
            end;
            local v52 = l__Players__1:GetPlayerFromCharacter(u50);
            if v52 and v52.Backpack then
                for _, v53 in v52.Backpack:GetChildren() do
                    if v53:IsA("Tool") and u49:IsTrackedTool(v53) then
                        u49:SetupTool(v53, u50);
                    end;
                end;
            end;
            u50.ChildAdded:Connect(function(u54) --[[ Line: 256 ]]
                -- upvalues: u49 (ref), u50 (ref)
                if u54:IsA("Tool") and u49:IsTrackedTool(u54) then
                    task.defer(function() --[[ Line: 258 ]]
                        -- upvalues: u54 (copy), u50 (ref), u49 (ref)
                        if u54 and (u54.Parent and (u50 and u50.Parent)) then
                            u49:SetupTool(u54, u50);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u55, u56) --[[ Line: 268 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u56.Character then
        u55:SetupCharacter(u56.Character);
    end;
    u56.CharacterAdded:Connect(function(p57) --[[ Line: 273 ]]
        -- upvalues: u55 (copy)
        u55:SetupCharacter(p57);
    end);
    l__BackpackListener__4.bind(u56, function(u58) --[[ Line: 277 ]]
        -- upvalues: u55 (copy), u56 (copy)
        if u58:IsA("Tool") and u55:IsTrackedTool(u58) then
            task.defer(function() --[[ Line: 279 ]]
                -- upvalues: u56 (ref), u58 (copy), u55 (ref)
                local l__Character__7 = u56.Character;
                if u58 and (u58.Parent and (l__Character__7 and l__Character__7.Parent)) then
                    u55:SetupTool(u58, l__Character__7);
                end;
            end);
        end;
    end);
end;
return v1;