-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__Mushrooms__4 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Mushrooms");
local l__BackpackListener__5 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = CFrame.new(0, 0, 0);
local u6 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
function v1.Init(_) --[[ Line: 24 ]] end;
function v1.Start(u7) --[[ Line: 27 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v8 in l__Players__1:GetPlayers() do
        u7:SetupPlayer(v8);
    end;
    l__Players__1.PlayerAdded:Connect(function(p9) --[[ Line: 32 ]]
        -- upvalues: u7 (copy)
        u7:SetupPlayer(p9);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p10) --[[ Line: 36 ]]
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
function v1.PreparePartForTool(_, p13) --[[ Line: 47 ]]
    p13.Anchored = false;
    p13.CanCollide = false;
    p13.CanQuery = false;
    p13.CanTouch = false;
end;
function v1.DisableVFX(_, p14) --[[ Line: 54 ]]
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
function v1.ClearHandle(_, p16) --[[ Line: 66 ]]
    for _, u17 in p16:GetChildren() do
        if u17.Name == "Handle" or (u17.Name == "Build" or u17:IsA("Model")) then
            u17.Parent = nil;
            task.defer(function() --[[ Line: 70 ]]
                -- upvalues: u17 (copy)
                if u17 then
                    u17:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p18) --[[ Line: 79 ]]
    for _, v19 in p18:GetChildren() do
        if v19.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p20, p21, p22) --[[ Line: 88 ]]
    -- upvalues: u4 (copy), l__Mushrooms__4 (copy), l__LocalPlayer__6 (copy), u5 (copy), u6 (copy)
    if u4[p21] then
    else
        u4[p21] = true;
        p20:ClearHandle(p21);
        local v23 = p22:FindFirstChild("Right Arm") or p22:FindFirstChild("RightHand");
        if v23 then
            local v24 = p21:GetAttribute("Mushroom");
            if v24 then
                local v25 = l__Mushrooms__4:FindFirstChild(v24);
                if v25 then
                    local v26 = v25:Clone();
                    p20:DisableVFX(v26);
                    local v27 = p22:GetScale();
                    if math.abs(v27 - 1) > 0.0001 then
                        v26:ScaleTo(v27);
                    end;
                    local v28 = l__LocalPlayer__6;
                    if v28 then
                        v28 = l__LocalPlayer__6.Character == p22;
                    end;
                    local l__PrimaryPart__7 = v26.PrimaryPart;
                    if l__PrimaryPart__7 then
                        for _, v29 in v26:GetDescendants() do
                            if v29:IsA("BasePart") then
                                p20:PreparePartForTool(v29);
                            end;
                        end;
                        for _, v30 in v26:GetDescendants() do
                            if v30:IsA("BasePart") and v30 ~= l__PrimaryPart__7 then
                                local v31 = Instance.new("WeldConstraint");
                                v31.Part0 = l__PrimaryPart__7;
                                v31.Part1 = v30;
                                v31.Parent = v30;
                            end;
                        end;
                        v26.Name = "Build";
                        v26.Parent = p21;
                        l__PrimaryPart__7.Name = "Handle";
                        l__PrimaryPart__7.Parent = p21;
                        if v28 then
                            local v32 = u5;
                            p21.Grip = CFrame.new(v32.Position * v27) * v32.Rotation;
                        else
                            local v33 = u6;
                            l__PrimaryPart__7.CFrame = v23.CFrame * (CFrame.new(v33.Position * v27) * v33.Rotation);
                            local v34 = Instance.new("WeldConstraint");
                            v34.Part0 = l__PrimaryPart__7;
                            v34.Part1 = v23;
                            v34.Parent = l__PrimaryPart__7;
                        end;
                        u4[p21] = nil;
                    else
                        v26:Destroy();
                        u4[p21] = nil;
                    end;
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
function v1.UpdateToolState(p35, p36) --[[ Line: 166 ]]
    -- upvalues: u4 (copy), u3 (copy)
    if u4[p36] then
    else
        local v37 = u3[p36];
        if v37 then
            local v38 = p36.Parent == v37;
            local v39 = p35:HasHandle(p36);
            if v38 and not v39 then
                p35:SpawnHandle(p36, v37);
            else
                if not v38 and v39 then
                    p35:ClearHandle(p36);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p40) --[[ Line: 182 ]]
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
function v1.CleanupTool(p43, p44) --[[ Line: 194 ]]
    p43:ClearHandle(p44);
    p43:DisconnectTool(p44);
end;
function v1.IsTrackedTool(_, p45) --[[ Line: 199 ]]
    return p45:GetAttribute("Mushroom") ~= nil;
end;
function v1.SetupTool(u46, u47, p48) --[[ Line: 203 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u46:DisconnectTool(u47);
    local v49 = {};
    u3[u47] = p48;
    local v50 = u47:GetPropertyChangedSignal("Parent");
    table.insert(v49, v50:Connect(function() --[[ Line: 209 ]]
        -- upvalues: u47 (copy), u3 (ref), u46 (copy)
        task.defer(function() --[[ Line: 210 ]]
            -- upvalues: u47 (ref), u3 (ref), u46 (ref)
            if u47 and u3[u47] then
                u46:UpdateToolState(u47);
            end;
        end);
    end));
    u2[u47] = v49;
    task.defer(function() --[[ Line: 219 ]]
        -- upvalues: u47 (copy), u3 (ref), u46 (copy)
        if u47 and u3[u47] then
            u46:UpdateToolState(u47);
        end;
    end);
end;
function v1.SetupCharacter(u51, u52) --[[ Line: 226 ]]
    -- upvalues: l__Players__1 (copy), l__RunService__3 (copy)
    task.defer(function() --[[ Line: 227 ]]
        -- upvalues: u52 (copy), u51 (copy), l__Players__1 (ref), l__RunService__3 (ref)
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
            u52.ChildAdded:Connect(function(u56) --[[ Line: 246 ]]
                -- upvalues: u51 (ref), u52 (ref)
                if u56:IsA("Tool") and u51:IsTrackedTool(u56) then
                    task.defer(function() --[[ Line: 248 ]]
                        -- upvalues: u56 (copy), u52 (ref), u51 (ref)
                        if u56 and (u56.Parent and (u52 and u52.Parent)) then
                            u51:SetupTool(u56, u52);
                        end;
                    end);
                end;
            end);
            local u57 = u52:GetScale();
            local u58 = nil;
            u58 = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 258 ]]
                -- upvalues: u52 (ref), u58 (ref), u51 (ref), u57 (ref)
                if not (u52 and u52.Parent) then
                    u58:Disconnect();
                    return;
                end;
                local v59 = false;
                for _, v60 in u52:GetChildren() do
                    if v60:IsA("Tool") and u51:IsTrackedTool(v60) then
                        v59 = true;
                        break;
                    end;
                end;
                local v61 = v59 and (u52:FindFirstChild("Right Arm") or u52:FindFirstChild("RightHand"));
                if v61 then
                    local v62 = v61:FindFirstChild("RightGrip");
                    local v63 = v61:FindFirstChild("RightGripAttachment");
                    if v62 and (v62:IsA("Weld") and v63) then
                        local l__C0__8 = v62.C0;
                        local l__Position__9 = v63.CFrame.Position;
                        if (l__C0__8.Position - l__Position__9).Magnitude > 0.0001 then
                            v62.C0 = CFrame.new(l__Position__9) * (l__C0__8 - l__C0__8.Position);
                        end;
                    end;
                end;
                local v64 = u52:GetScale();
                if math.abs(v64 - u57) < 0.0001 then
                else
                    u57 = v64;
                    for _, v65 in u52:GetChildren() do
                        if v65:IsA("Tool") and u51:IsTrackedTool(v65) then
                            u51:SpawnHandle(v65, u52);
                        end;
                    end;
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u66, u67) --[[ Line: 300 ]]
    -- upvalues: l__BackpackListener__5 (copy)
    if u67.Character then
        u66:SetupCharacter(u67.Character);
    end;
    u67.CharacterAdded:Connect(function(p68) --[[ Line: 305 ]]
        -- upvalues: u66 (copy)
        u66:SetupCharacter(p68);
    end);
    l__BackpackListener__5.bind(u67, function(u69) --[[ Line: 309 ]]
        -- upvalues: u66 (copy), u67 (copy)
        if u69:IsA("Tool") and u66:IsTrackedTool(u69) then
            task.defer(function() --[[ Line: 311 ]]
                -- upvalues: u67 (ref), u69 (copy), u66 (ref)
                local l__Character__10 = u67.Character;
                if u69 and (u69.Parent and (l__Character__10 and l__Character__10.Parent)) then
                    u66:SetupTool(u69, l__Character__10);
                end;
            end);
        end;
    end);
end;
return v1;