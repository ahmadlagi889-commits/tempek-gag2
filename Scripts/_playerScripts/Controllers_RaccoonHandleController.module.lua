-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Assets__3 = l__ReplicatedStorage__2:WaitForChild("Assets");
local v2 = l__Assets__3:FindFirstChild("Pets");
local u3 = v2 and v2:FindFirstChild("Raccoon") or l__Assets__3:WaitForChild("Raccoon");
local l__BackpackListener__4 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = CFrame.Angles(1.5707963267948966, 1.5707963267948966, 0);
function v1.Init(_) --[[ Line: 28 ]] end;
function v1.Start(u8) --[[ Line: 31 ]]
    -- upvalues: l__Players__1 (copy), u4 (copy)
    for _, v9 in l__Players__1:GetPlayers() do
        u8:SetupPlayer(v9);
    end;
    l__Players__1.PlayerAdded:Connect(function(p10) --[[ Line: 36 ]]
        -- upvalues: u8 (copy)
        u8:SetupPlayer(p10);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p11) --[[ Line: 40 ]]
        -- upvalues: u4 (ref), l__Players__1 (ref), u8 (copy)
        for v12 in u4 do
            local v13 = not l__Players__1:GetPlayerFromCharacter(v12.Parent) and (v12.Parent and v12.Parent:IsA("Backpack"));
            if v13 then
                v13 = l__Players__1:GetPlayerFromCharacter(v12.Parent.Parent);
            end;
            if v13 == p11 then
                u8:CleanupTool(v12);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p14) --[[ Line: 51 ]]
    p14.Anchored = false;
    p14.CanCollide = false;
    p14.CanQuery = false;
    p14.CanTouch = false;
end;
function v1.DisableVFX(_, p15) --[[ Line: 58 ]]
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
function v1.ClearHandle(_, p17) --[[ Line: 70 ]]
    for _, u18 in p17:GetChildren() do
        if u18.Name == "Handle" or (u18.Name == "Build" or u18:IsA("Model")) then
            u18.Parent = nil;
            task.defer(function() --[[ Line: 74 ]]
                -- upvalues: u18 (copy)
                if u18 then
                    u18:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p19) --[[ Line: 83 ]]
    for _, v20 in p19:GetChildren() do
        if v20.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p21, p22, p23) --[[ Line: 92 ]]
    -- upvalues: u6 (copy), u3 (copy), l__LocalPlayer__5 (copy), u7 (copy)
    if u6[p22] then
    else
        u6[p22] = true;
        p21:ClearHandle(p22);
        local v24 = p23:FindFirstChild("Right Arm") or p23:FindFirstChild("RightHand");
        if v24 then
            if p22:GetAttribute("Raccoon") then
                local v25 = u3:Clone();
                p21:DisableVFX(v25);
                local v26 = l__LocalPlayer__5;
                if v26 then
                    v26 = l__LocalPlayer__5.Character == p23;
                end;
                local l__PrimaryPart__6 = v25.PrimaryPart;
                if l__PrimaryPart__6 then
                    for _, v27 in v25:GetDescendants() do
                        if v27:IsA("BasePart") then
                            p21:PreparePartForTool(v27);
                        end;
                    end;
                    local v28 = v25:FindFirstChildOfClass("AnimationController") or Instance.new("AnimationController");
                    local u29 = v28:FindFirstChildOfClass("Animator");
                    if not u29 then
                        u29 = Instance.new("Animator");
                        u29.Parent = v28;
                    end;
                    local u30 = v25:FindFirstChild("Idle");
                    if not u30 then
                        local v31 = v25:FindFirstChild("Animations");
                        if v31 then
                            u30 = v31:FindFirstChild("Idle");
                        end;
                    end;
                    v25.Name = "Build";
                    v25.Parent = p22;
                    l__PrimaryPart__6.Name = "Handle";
                    l__PrimaryPart__6.Parent = p22;
                    v28.Parent = l__PrimaryPart__6;
                    p22.Grip = u7;
                    if not v26 then
                        l__PrimaryPart__6.CFrame = v24.CFrame * CFrame.new(0, -1, 0) * u7;
                        local v32 = Instance.new("WeldConstraint");
                        v32.Part0 = v24;
                        v32.Part1 = l__PrimaryPart__6;
                        v32.Parent = l__PrimaryPart__6;
                    end;
                    if u30 and u30:IsA("Animation") then
                        local v33, v34 = pcall(function() --[[ Line: 178 ]]
                            -- upvalues: u29 (ref), u30 (ref)
                            return u29:LoadAnimation(u30);
                        end);
                        if v33 and v34 then
                            v34.Looped = true;
                            v34:Play(0);
                        end;
                    end;
                    u6[p22] = nil;
                else
                    v25:Destroy();
                    u6[p22] = nil;
                end;
            else
                u6[p22] = nil;
            end;
        else
            u6[p22] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p35, p36) --[[ Line: 190 ]]
    -- upvalues: u6 (copy), u5 (copy)
    if u6[p36] then
    else
        local v37 = u5[p36];
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
function v1.DisconnectTool(_, p40) --[[ Line: 206 ]]
    -- upvalues: u4 (copy), u5 (copy), u6 (copy)
    local v41 = u4[p40];
    if v41 then
        for _, v42 in v41 do
            v42:Disconnect();
        end;
        u4[p40] = nil;
    end;
    u5[p40] = nil;
    u6[p40] = nil;
end;
function v1.CleanupTool(p43, p44) --[[ Line: 218 ]]
    p43:ClearHandle(p44);
    p43:DisconnectTool(p44);
end;
function v1.IsTrackedTool(_, p45) --[[ Line: 223 ]]
    return p45:GetAttribute("Raccoon") ~= nil;
end;
function v1.SetupTool(u46, u47, p48) --[[ Line: 227 ]]
    -- upvalues: u5 (copy), u4 (copy)
    u46:DisconnectTool(u47);
    local v49 = {};
    u5[u47] = p48;
    local v50 = u47:GetPropertyChangedSignal("Parent");
    table.insert(v49, v50:Connect(function() --[[ Line: 233 ]]
        -- upvalues: u47 (copy), u5 (ref), u46 (copy)
        task.defer(function() --[[ Line: 234 ]]
            -- upvalues: u47 (ref), u5 (ref), u46 (ref)
            if u47 and u5[u47] then
                u46:UpdateToolState(u47);
            end;
        end);
    end));
    u4[u47] = v49;
    task.defer(function() --[[ Line: 243 ]]
        -- upvalues: u47 (copy), u5 (ref), u46 (copy)
        if u47 and u5[u47] then
            u46:UpdateToolState(u47);
        end;
    end);
end;
function v1.SetupCharacter(u51, u52) --[[ Line: 250 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 251 ]]
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
            u52.ChildAdded:Connect(function(u56) --[[ Line: 270 ]]
                -- upvalues: u51 (ref), u52 (ref)
                if u56:IsA("Tool") and u51:IsTrackedTool(u56) then
                    task.defer(function() --[[ Line: 272 ]]
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
function v1.SetupPlayer(u57, u58) --[[ Line: 282 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u58.Character then
        u57:SetupCharacter(u58.Character);
    end;
    u58.CharacterAdded:Connect(function(p59) --[[ Line: 287 ]]
        -- upvalues: u57 (copy)
        u57:SetupCharacter(p59);
    end);
    l__BackpackListener__4.bind(u58, function(u60) --[[ Line: 291 ]]
        -- upvalues: u57 (copy), u58 (copy)
        if u60:IsA("Tool") and u57:IsTrackedTool(u60) then
            task.defer(function() --[[ Line: 293 ]]
                -- upvalues: u58 (ref), u60 (copy), u57 (ref)
                local l__Character__7 = u58.Character;
                if u60 and (u60.Parent and (l__Character__7 and l__Character__7.Parent)) then
                    u57:SetupTool(u60, l__Character__7);
                end;
            end);
        end;
    end);
end;
return v1;