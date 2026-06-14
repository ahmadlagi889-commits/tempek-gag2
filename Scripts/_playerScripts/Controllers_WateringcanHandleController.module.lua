-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__WateringCans__3 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("WateringCans");
local l__BackpackListener__4 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = CFrame.new(0, 1.5, -0.75);
local u6 = CFrame.new(0, -0.25, 1.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
function v1.Init(_) --[[ Line: 19 ]] end;
local l__Wateringcan_SFX__6 = game.SoundService.SFX.Wateringcan_SFX;
local l__Equip__7 = l__Wateringcan_SFX__6.Equip;
local l__Unequip__8 = l__Wateringcan_SFX__6.Unequip;
function v1.Start(u7) --[[ Line: 26 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v8 in l__Players__1:GetPlayers() do
        u7:SetupPlayer(v8);
    end;
    l__Players__1.PlayerAdded:Connect(function(p9) --[[ Line: 31 ]]
        -- upvalues: u7 (copy)
        u7:SetupPlayer(p9);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p10) --[[ Line: 35 ]]
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
function v1.PreparePartForTool(_, p13) --[[ Line: 46 ]]
    p13.Anchored = false;
    p13.CanCollide = false;
    p13.CanQuery = false;
    p13.CanTouch = false;
end;
function v1.DisableVFX(_, p14) --[[ Line: 53 ]]
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
function v1.ClearHandle(_, p16) --[[ Line: 65 ]]
    -- upvalues: l__Unequip__8 (copy)
    local u17 = false;
    for _, u18 in p16:GetChildren() do
        if u18.Name == "Handle" or (u18.Name == "Build" or u18:IsA("Model")) then
            u18.Parent = nil;
            task.defer(function() --[[ Line: 70 ]]
                -- upvalues: u18 (copy), u17 (ref)
                if u18 then
                    u17 = true;
                    u18:Destroy();
                end;
            end);
        end;
    end;
    if u17 then
        l__Unequip__8.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l__Unequip__8.TimePosition = 0;
        l__Unequip__8.Playing = true;
    end;
end;
function v1.HasHandle(_, p19) --[[ Line: 85 ]]
    for _, v20 in p19:GetChildren() do
        if v20.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p21, p22, p23) --[[ Line: 94 ]]
    -- upvalues: u4 (copy), l__Equip__7 (copy), l__WateringCans__3 (copy), l__LocalPlayer__5 (copy), u5 (copy), u6 (copy)
    if u4[p22] then
    else
        u4[p22] = true;
        p21:ClearHandle(p22);
        local v24 = p22:GetAttribute("WateringCan");
        if v24 then
            l__Equip__7.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__Equip__7.Playing = true;
            l__Equip__7.TimePosition = 0;
            local v25 = l__WateringCans__3:FindFirstChild(v24);
            if v25 then
                local v26 = p23:FindFirstChild("Right Arm") or p23:FindFirstChild("RightHand");
                if v26 then
                    local v27 = v25:Clone();
                    p21:DisableVFX(v27);
                    local v28 = l__LocalPlayer__5;
                    if v28 then
                        v28 = l__LocalPlayer__5.Character == p23;
                    end;
                    if v27:IsA("BasePart") then
                        p21:PreparePartForTool(v27);
                        v27.Name = "Handle";
                        v27.Parent = p22;
                        if v28 then
                            p22.Grip = u5;
                        else
                            v27.CFrame = v26.CFrame * u6;
                            local v29 = Instance.new("WeldConstraint");
                            v29.Part0 = v27;
                            v29.Part1 = v26;
                            v29.Parent = v27;
                        end;
                    elseif v27:IsA("Model") then
                        local l__PrimaryPart__9 = v27.PrimaryPart;
                        if not l__PrimaryPart__9 then
                            v27:Destroy();
                            u4[p22] = nil;
                            return;
                        end;
                        for _, v30 in v27:GetDescendants() do
                            if v30:IsA("BasePart") then
                                p21:PreparePartForTool(v30);
                            end;
                        end;
                        for _, v31 in v27:GetDescendants() do
                            if v31:IsA("BasePart") and v31 ~= l__PrimaryPart__9 then
                                local v32 = Instance.new("WeldConstraint");
                                v32.Part0 = l__PrimaryPart__9;
                                v32.Part1 = v31;
                                v32.Parent = v31;
                            end;
                        end;
                        v27.Name = "Build";
                        v27.Parent = p22;
                        l__PrimaryPart__9.Name = "Handle";
                        l__PrimaryPart__9.Parent = p22;
                        if v28 then
                            p22.Grip = u5;
                        else
                            l__PrimaryPart__9.CFrame = v26.CFrame * u6;
                            local v33 = Instance.new("WeldConstraint");
                            v33.Part0 = l__PrimaryPart__9;
                            v33.Part1 = v26;
                            v33.Parent = l__PrimaryPart__9;
                        end;
                    end;
                    u4[p22] = nil;
                else
                    u4[p22] = nil;
                end;
            else
                u4[p22] = nil;
            end;
        else
            u4[p22] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p34, p35) --[[ Line: 187 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4[p35] then
    else
        local v36 = u3[p35];
        if v36 then
            local v37 = p35.Parent == v36;
            local v38 = p34:HasHandle(p35);
            if v37 and not v38 then
                p34:SpawnHandle(p35, v36);
            else
                if not v37 and v38 then
                    p34:ClearHandle(p35);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p39) --[[ Line: 203 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v40 = u2[p39];
    if v40 then
        for _, v41 in v40 do
            v41:Disconnect();
        end;
        u2[p39] = nil;
    end;
    u3[p39] = nil;
    u4[p39] = nil;
end;
function v1.CleanupTool(p42, p43) --[[ Line: 215 ]]
    p42:ClearHandle(p43);
    p42:DisconnectTool(p43);
end;
function v1.IsTrackedTool(_, p44) --[[ Line: 220 ]]
    return p44:GetAttribute("WateringCan") ~= nil;
end;
function v1.SetupTool(u45, u46, p47) --[[ Line: 224 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u45:DisconnectTool(u46);
    local v48 = {};
    u3[u46] = p47;
    local v49 = u46:GetPropertyChangedSignal("Parent");
    table.insert(v48, v49:Connect(function() --[[ Line: 230 ]]
        -- upvalues: u46 (copy), u3 (ref), u45 (copy)
        task.defer(function() --[[ Line: 231 ]]
            -- upvalues: u46 (ref), u3 (ref), u45 (ref)
            if u46 and u3[u46] then
                u45:UpdateToolState(u46);
            end;
        end);
    end));
    u2[u46] = v48;
    task.defer(function() --[[ Line: 240 ]]
        -- upvalues: u46 (copy), u3 (ref), u45 (copy)
        if u46 and u3[u46] then
            u45:UpdateToolState(u46);
        end;
    end);
end;
function v1.SetupCharacter(u50, u51) --[[ Line: 247 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 248 ]]
        -- upvalues: u51 (copy), u50 (copy), l__Players__1 (ref)
        if u51 and u51.Parent then
            for _, v52 in u51:GetChildren() do
                if v52:IsA("Tool") and u50:IsTrackedTool(v52) then
                    u50:SetupTool(v52, u51);
                end;
            end;
            local v53 = l__Players__1:GetPlayerFromCharacter(u51);
            if v53 and v53.Backpack then
                for _, v54 in v53.Backpack:GetChildren() do
                    if v54:IsA("Tool") and u50:IsTrackedTool(v54) then
                        u50:SetupTool(v54, u51);
                    end;
                end;
            end;
            u51.ChildAdded:Connect(function(u55) --[[ Line: 266 ]]
                -- upvalues: u50 (ref), u51 (ref)
                if u55:IsA("Tool") and u50:IsTrackedTool(u55) then
                    task.defer(function() --[[ Line: 268 ]]
                        -- upvalues: u55 (copy), u51 (ref), u50 (ref)
                        if u55 and (u55.Parent and (u51 and u51.Parent)) then
                            u50:SetupTool(u55, u51);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u56, u57) --[[ Line: 278 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u57.Character then
        u56:SetupCharacter(u57.Character);
    end;
    u57.CharacterAdded:Connect(function(p58) --[[ Line: 283 ]]
        -- upvalues: u56 (copy)
        u56:SetupCharacter(p58);
    end);
    l__BackpackListener__4.bind(u57, function(u59) --[[ Line: 287 ]]
        -- upvalues: u56 (copy), u57 (copy)
        if u59:IsA("Tool") and u56:IsTrackedTool(u59) then
            task.defer(function() --[[ Line: 289 ]]
                -- upvalues: u57 (ref), u59 (copy), u56 (ref)
                local l__Character__10 = u57.Character;
                if u59 and (u59.Parent and (l__Character__10 and l__Character__10.Parent)) then
                    u56:SetupTool(u59, l__Character__10);
                end;
            end);
        end;
    end);
end;
return v1;