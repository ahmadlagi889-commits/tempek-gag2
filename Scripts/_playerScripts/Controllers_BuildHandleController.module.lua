-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__SoundService__3 = game:GetService("SoundService");
local l__Build__4 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Build");
local l__BackpackListener__5 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = CFrame.new(0, 0, 0);
local u6 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
local function u11(p7, p8) --[[ Line: 23 ]]
    -- upvalues: l__SoundService__3 (copy)
    local v9 = p7:FindFirstChild("HumanoidRootPart");
    if v9 then
        local v10 = Instance.new("Sound");
        v10.SoundId = p8;
        v10.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        v10.SoundGroup = l__SoundService__3:FindFirstChild("SFXGroup");
        v10.Parent = v9;
        v10:Play();
        game.Debris:AddItem(v10, v10.TimeLength / v10.PlaybackSpeed + 1);
    end;
end;
function v1.Init(_) --[[ Line: 35 ]] end;
function v1.Start(u12) --[[ Line: 38 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v13 in l__Players__1:GetPlayers() do
        u12:SetupPlayer(v13);
    end;
    l__Players__1.PlayerAdded:Connect(function(p14) --[[ Line: 43 ]]
        -- upvalues: u12 (copy)
        u12:SetupPlayer(p14);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p15) --[[ Line: 47 ]]
        -- upvalues: u2 (ref), l__Players__1 (ref), u12 (copy)
        for v16 in u2 do
            local v17 = not l__Players__1:GetPlayerFromCharacter(v16.Parent) and (v16.Parent and v16.Parent:IsA("Backpack"));
            if v17 then
                v17 = l__Players__1:GetPlayerFromCharacter(v16.Parent.Parent);
            end;
            if v17 == p15 then
                u12:CleanupTool(v16);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p18) --[[ Line: 58 ]]
    p18.Anchored = false;
    p18.CanCollide = false;
    p18.CanQuery = false;
    p18.CanTouch = false;
end;
function v1.DisableVFX(_, p19) --[[ Line: 65 ]]
    for _, v20 in p19:GetDescendants() do
        if v20:IsA("ParticleEmitter") or (v20:IsA("Trail") or v20:IsA("Beam")) then
            v20.Enabled = false;
        elseif v20:IsA("Fire") or (v20:IsA("Smoke") or v20:IsA("Sparkles")) then
            v20.Enabled = false;
        elseif v20:IsA("Light") then
            v20.Enabled = false;
        end;
    end;
end;
function v1.ClearHandle(_, p21) --[[ Line: 77 ]]
    for _, u22 in p21:GetChildren() do
        if u22.Name == "Handle" or (u22.Name == "Build" or u22:IsA("Model")) then
            u22.Parent = nil;
            task.defer(function() --[[ Line: 81 ]]
                -- upvalues: u22 (copy)
                if u22 then
                    u22:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p23) --[[ Line: 90 ]]
    for _, v24 in p23:GetChildren() do
        if v24.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p25, p26, p27) --[[ Line: 99 ]]
    -- upvalues: u4 (copy), l__Build__4 (copy), l__LocalPlayer__6 (copy), u11 (copy), u5 (copy), u6 (copy)
    if u4[p26] then
    else
        u4[p26] = true;
        p25:ClearHandle(p26);
        local v28 = p27:FindFirstChild("Right Arm") or p27:FindFirstChild("RightHand");
        if v28 then
            local v29 = l__Build__4:Clone();
            p25:DisableVFX(v29);
            local v30 = l__LocalPlayer__6;
            if v30 then
                v30 = l__LocalPlayer__6.Character == p27;
            end;
            u11(p27, "rbxassetid://91013210534200");
            if v29:IsA("BasePart") then
                p25:PreparePartForTool(v29);
                v29.Name = "Handle";
                v29.Parent = p26;
                if v30 then
                    p26.Grip = u5;
                else
                    v29.CFrame = v28.CFrame * u6;
                    local v31 = Instance.new("WeldConstraint");
                    v31.Part0 = v29;
                    v31.Part1 = v28;
                    v31.Parent = v29;
                end;
            elseif v29:IsA("Model") then
                local l__PrimaryPart__7 = v29.PrimaryPart;
                if not l__PrimaryPart__7 then
                    v29:Destroy();
                    u4[p26] = nil;
                    return;
                end;
                for _, v32 in v29:GetDescendants() do
                    if v32:IsA("BasePart") then
                        p25:PreparePartForTool(v32);
                    end;
                end;
                for _, v33 in v29:GetDescendants() do
                    if v33:IsA("BasePart") and v33 ~= l__PrimaryPart__7 then
                        local v34 = Instance.new("WeldConstraint");
                        v34.Part0 = l__PrimaryPart__7;
                        v34.Part1 = v33;
                        v34.Parent = v33;
                    end;
                end;
                v29.Name = "Build";
                v29.Parent = p26;
                l__PrimaryPart__7.Name = "Handle";
                l__PrimaryPart__7.Parent = p26;
                if v30 then
                    p26.Grip = u5;
                else
                    l__PrimaryPart__7.CFrame = v28.CFrame * u6;
                    local v35 = Instance.new("WeldConstraint");
                    v35.Part0 = l__PrimaryPart__7;
                    v35.Part1 = v28;
                    v35.Parent = l__PrimaryPart__7;
                end;
            end;
            u4[p26] = nil;
        else
            u4[p26] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p36, p37) --[[ Line: 178 ]]
    -- upvalues: u4 (copy), u3 (copy), u11 (copy)
    if u4[p37] then
    else
        local v38 = u3[p37];
        if v38 then
            local v39 = p37.Parent == v38;
            local v40 = p36:HasHandle(p37);
            if v39 and not v40 then
                p36:SpawnHandle(p37, v38);
            else
                if not v39 and v40 then
                    u11(v38, "rbxassetid://134987769896663");
                    p36:ClearHandle(p37);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p41) --[[ Line: 195 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v42 = u2[p41];
    if v42 then
        for _, v43 in v42 do
            v43:Disconnect();
        end;
        u2[p41] = nil;
    end;
    u3[p41] = nil;
    u4[p41] = nil;
end;
function v1.CleanupTool(p44, p45) --[[ Line: 207 ]]
    p44:ClearHandle(p45);
    p44:DisconnectTool(p45);
end;
function v1.IsTrackedTool(_, p46) --[[ Line: 212 ]]
    return p46:GetAttribute("Build") ~= nil;
end;
function v1.SetupTool(u47, u48, p49) --[[ Line: 216 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u47:DisconnectTool(u48);
    local v50 = {};
    u3[u48] = p49;
    local v51 = u48:GetPropertyChangedSignal("Parent");
    table.insert(v50, v51:Connect(function() --[[ Line: 222 ]]
        -- upvalues: u48 (copy), u3 (ref), u47 (copy)
        task.defer(function() --[[ Line: 223 ]]
            -- upvalues: u48 (ref), u3 (ref), u47 (ref)
            if u48 and u3[u48] then
                u47:UpdateToolState(u48);
            end;
        end);
    end));
    u2[u48] = v50;
    task.defer(function() --[[ Line: 232 ]]
        -- upvalues: u48 (copy), u3 (ref), u47 (copy)
        if u48 and u3[u48] then
            u47:UpdateToolState(u48);
        end;
    end);
end;
function v1.SetupCharacter(u52, u53) --[[ Line: 239 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 240 ]]
        -- upvalues: u53 (copy), u52 (copy), l__Players__1 (ref)
        if u53 and u53.Parent then
            for _, v54 in u53:GetChildren() do
                if v54:IsA("Tool") and u52:IsTrackedTool(v54) then
                    u52:SetupTool(v54, u53);
                end;
            end;
            local v55 = l__Players__1:GetPlayerFromCharacter(u53);
            if v55 and v55.Backpack then
                for _, v56 in v55.Backpack:GetChildren() do
                    if v56:IsA("Tool") and u52:IsTrackedTool(v56) then
                        u52:SetupTool(v56, u53);
                    end;
                end;
            end;
            u53.ChildAdded:Connect(function(u57) --[[ Line: 259 ]]
                -- upvalues: u52 (ref), u53 (ref)
                if u57:IsA("Tool") and u52:IsTrackedTool(u57) then
                    task.defer(function() --[[ Line: 261 ]]
                        -- upvalues: u57 (copy), u53 (ref), u52 (ref)
                        if u57 and (u57.Parent and (u53 and u53.Parent)) then
                            u52:SetupTool(u57, u53);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u58, u59) --[[ Line: 271 ]]
    -- upvalues: l__BackpackListener__5 (copy)
    if u59.Character then
        u58:SetupCharacter(u59.Character);
    end;
    u59.CharacterAdded:Connect(function(p60) --[[ Line: 276 ]]
        -- upvalues: u58 (copy)
        u58:SetupCharacter(p60);
    end);
    l__BackpackListener__5.bind(u59, function(u61) --[[ Line: 280 ]]
        -- upvalues: u58 (copy), u59 (copy)
        if u61:IsA("Tool") and u58:IsTrackedTool(u61) then
            task.defer(function() --[[ Line: 282 ]]
                -- upvalues: u59 (ref), u61 (copy), u58 (ref)
                local l__Character__8 = u59.Character;
                if u61 and (u61.Parent and (l__Character__8 and l__Character__8.Parent)) then
                    u58:SetupTool(u61, l__Character__8);
                end;
            end);
        end;
    end);
end;
return v1;