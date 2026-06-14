-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Trowel__3 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Trowel");
local l__BackpackListener__4 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__Trowel_SFX__5 = game.SoundService.SFX.Trowel_SFX;
local l__Equip__6 = l__Trowel_SFX__5.Equip;
local l__Unequip__7 = l__Trowel_SFX__5.Unequip;
local l__LocalPlayer__8 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = CFrame.new(0, 0, 0);
local u6 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
function v1.Init(_) --[[ Line: 25 ]] end;
function v1.Start(u7) --[[ Line: 28 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v8 in l__Players__1:GetPlayers() do
        u7:SetupPlayer(v8);
    end;
    l__Players__1.PlayerAdded:Connect(function(p9) --[[ Line: 33 ]]
        -- upvalues: u7 (copy)
        u7:SetupPlayer(p9);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p10) --[[ Line: 37 ]]
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
function v1.PreparePartForTool(_, p13) --[[ Line: 48 ]]
    p13.Anchored = false;
    p13.CanCollide = false;
    p13.CanQuery = false;
    p13.CanTouch = false;
end;
function v1.DisableVFX(_, p14) --[[ Line: 55 ]]
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
function v1.ClearHandle(_, p16) --[[ Line: 67 ]]
    for _, u17 in p16:GetChildren() do
        if u17.Name == "Handle" or (u17.Name == "Build" or u17:IsA("Model")) then
            u17.Parent = nil;
            task.defer(function() --[[ Line: 71 ]]
                -- upvalues: u17 (copy)
                if u17 then
                    u17:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p18) --[[ Line: 80 ]]
    for _, v19 in p18:GetChildren() do
        if v19.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p20, p21, p22) --[[ Line: 89 ]]
    -- upvalues: u4 (copy), l__Trowel__3 (copy), l__LocalPlayer__8 (copy), l__Equip__6 (copy), u5 (copy), u6 (copy)
    if u4[p21] then
    else
        u4[p21] = true;
        p20:ClearHandle(p21);
        local v23 = p22:FindFirstChild("Right Arm") or p22:FindFirstChild("RightHand");
        if v23 then
            local v24 = l__Trowel__3:Clone();
            p20:DisableVFX(v24);
            local v25 = l__LocalPlayer__8;
            if v25 then
                v25 = l__LocalPlayer__8.Character == p22;
            end;
            local v26 = p22:FindFirstChild("HumanoidRootPart");
            if v26 then
                local v27 = l__Equip__6:Clone();
                v27.Parent = v26;
                v27.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                v27.Playing = true;
                game.Debris:AddItem(v27, v27.PlaybackSpeed * v27.TimeLength);
            end;
            if v24:IsA("BasePart") then
                p20:PreparePartForTool(v24);
                v24.Name = "Handle";
                v24.Parent = p21;
                if v25 then
                    p21.Grip = u5;
                else
                    v24.CFrame = v23.CFrame * u6;
                    local v28 = Instance.new("WeldConstraint");
                    v28.Part0 = v24;
                    v28.Part1 = v23;
                    v28.Parent = v24;
                end;
            elseif v24:IsA("Model") then
                local l__PrimaryPart__9 = v24.PrimaryPart;
                if not l__PrimaryPart__9 then
                    v24:Destroy();
                    u4[p21] = nil;
                    return;
                end;
                for _, v29 in v24:GetDescendants() do
                    if v29:IsA("BasePart") then
                        p20:PreparePartForTool(v29);
                    end;
                end;
                for _, v30 in v24:GetDescendants() do
                    if v30:IsA("BasePart") and v30 ~= l__PrimaryPart__9 then
                        local v31 = Instance.new("WeldConstraint");
                        v31.Part0 = l__PrimaryPart__9;
                        v31.Part1 = v30;
                        v31.Parent = v30;
                    end;
                end;
                v24.Name = "Build";
                v24.Parent = p21;
                l__PrimaryPart__9.Name = "Handle";
                l__PrimaryPart__9.Parent = p21;
                if v25 then
                    p21.Grip = u5;
                else
                    l__PrimaryPart__9.CFrame = v23.CFrame * u6;
                    local v32 = Instance.new("WeldConstraint");
                    v32.Part0 = l__PrimaryPart__9;
                    v32.Part1 = v23;
                    v32.Parent = l__PrimaryPart__9;
                end;
            end;
            u4[p21] = nil;
        else
            u4[p21] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p33, p34) --[[ Line: 176 ]]
    -- upvalues: u4 (copy), u3 (copy), l__Unequip__7 (copy)
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
                    local v38 = v35:FindFirstChild("HumanoidRootPart");
                    if v38 then
                        local v39 = l__Unequip__7:Clone();
                        v39.Parent = v38;
                        v39.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                        v39.Playing = true;
                        game.Debris:AddItem(v39, v39.PlaybackSpeed * v39.TimeLength);
                    end;
                    p33:ClearHandle(p34);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p40) --[[ Line: 203 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v41 = u2[p40];
    if v41 then
        for _, v42 in v41 do
            v42:Disconnect();
        end;
        u2[p40] = nil;
    end;
    u3[p40] = nil;
    u4[p40] = nil;
end;
function v1.CleanupTool(p43, p44) --[[ Line: 215 ]]
    p43:ClearHandle(p44);
    p43:DisconnectTool(p44);
end;
function v1.IsTrackedTool(_, p45) --[[ Line: 220 ]]
    return p45:GetAttribute("Trowel") ~= nil;
end;
function v1.SetupTool(u46, u47, p48) --[[ Line: 224 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u46:DisconnectTool(u47);
    local v49 = {};
    u3[u47] = p48;
    local v50 = u47:GetPropertyChangedSignal("Parent");
    table.insert(v49, v50:Connect(function() --[[ Line: 230 ]]
        -- upvalues: u47 (copy), u3 (ref), u46 (copy)
        task.defer(function() --[[ Line: 231 ]]
            -- upvalues: u47 (ref), u3 (ref), u46 (ref)
            if u47 and u3[u47] then
                u46:UpdateToolState(u47);
            end;
        end);
    end));
    u2[u47] = v49;
    task.defer(function() --[[ Line: 240 ]]
        -- upvalues: u47 (copy), u3 (ref), u46 (copy)
        if u47 and u3[u47] then
            u46:UpdateToolState(u47);
        end;
    end);
end;
function v1.SetupCharacter(u51, u52) --[[ Line: 247 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 248 ]]
        -- upvalues: u52 (copy), u51 (copy), l__Players__1 (ref)
        if u52 and u52.Parent then
            for _, v53 in u52:GetChildren() do
                if v53:IsA("Tool") and u51:IsTrackedTool(v53) then
                    u51:SetupTool(v53, u52);
                end;
            end;
            local v54 = l__Players__1:GetPlayerFromCharacter(u52);
            if v54 and v54.Backpack then
                for _, v55 in v54.Backpack:GetChildren() do
                    if v55:IsA("Tool") and u51:IsTrackedTool(v55) then
                        u51:SetupTool(v55, u52);
                    end;
                end;
            end;
            u52.ChildAdded:Connect(function(u56) --[[ Line: 267 ]]
                -- upvalues: u51 (ref), u52 (ref)
                if u56:IsA("Tool") and u51:IsTrackedTool(u56) then
                    task.defer(function() --[[ Line: 269 ]]
                        -- upvalues: u56 (copy), u52 (ref), u51 (ref)
                        if u56 and (u56.Parent and (u52 and u52.Parent)) then
                            u51:SetupTool(u56, u52);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u57, u58) --[[ Line: 279 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u58.Character then
        u57:SetupCharacter(u58.Character);
    end;
    u58.CharacterAdded:Connect(function(p59) --[[ Line: 284 ]]
        -- upvalues: u57 (copy)
        u57:SetupCharacter(p59);
    end);
    l__BackpackListener__4.bind(u58, function(u60) --[[ Line: 288 ]]
        -- upvalues: u57 (copy), u58 (copy)
        if u60:IsA("Tool") and u57:IsTrackedTool(u60) then
            task.defer(function() --[[ Line: 290 ]]
                -- upvalues: u58 (ref), u60 (copy), u57 (ref)
                local l__Character__10 = u58.Character;
                if u60 and (u60.Parent and (l__Character__10 and l__Character__10.Parent)) then
                    u57:SetupTool(u60, l__Character__10);
                end;
            end);
        end;
    end);
end;
return v1;