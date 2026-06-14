-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Assets__3 = l__ReplicatedStorage__2:WaitForChild("Assets");
local v2 = l__Assets__3:FindFirstChild("Pets");
local u3 = v2 and v2:FindFirstChild("Robin") or l__Assets__3:WaitForChild("Robin");
local l__BackpackListener__4 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = CFrame.Angles(0, 0, -1.5707963267948966);
function v1.Init(_) --[[ Line: 35 ]] end;
function v1.Start(u8) --[[ Line: 39 ]]
    -- upvalues: l__Players__1 (copy), u4 (copy)
    for _, v9 in l__Players__1:GetPlayers() do
        u8:SetupPlayer(v9);
    end;
    l__Players__1.PlayerAdded:Connect(function(p10) --[[ Line: 45 ]]
        -- upvalues: u8 (copy)
        u8:SetupPlayer(p10);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p11) --[[ Line: 50 ]]
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
function v1.PreparePartForTool(_, p14) --[[ Line: 62 ]]
    p14.Anchored = false;
    p14.CanCollide = false;
    p14.CanQuery = false;
    p14.CanTouch = false;
    p14.Massless = true;
end;
function v1.DisableVFX(_, p15) --[[ Line: 71 ]]
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
function v1.ClearHandle(_, p17) --[[ Line: 84 ]]
    for _, u18 in p17:GetChildren() do
        if u18.Name == "Handle" or (u18.Name == "Build" or u18:IsA("Model")) then
            u18.Parent = nil;
            task.defer(function() --[[ Line: 88 ]]
                -- upvalues: u18 (copy)
                if u18 then
                    u18:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p19) --[[ Line: 96 ]]
    for _, v20 in p19:GetChildren() do
        if v20.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p21, p22, p23) --[[ Line: 104 ]]
    -- upvalues: u6 (copy), u3 (copy), l__LocalPlayer__5 (copy), u7 (copy)
    if u6[p22] then
    else
        u6[p22] = true;
        p21:ClearHandle(p22);
        local v24 = p23:FindFirstChild("Right Arm") or p23:FindFirstChild("RightHand");
        if v24 then
            if p22:GetAttribute("Bird") then
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
                    local v30 = v25:FindFirstChild("Animations");
                    local v31;
                    if v30 then
                        v31 = v30:FindFirstChild("Fly");
                    else
                        v31 = nil;
                    end;
                    local u32 = v31 or v25:FindFirstChild("Fly");
                    v25.Name = "Build";
                    v25.Parent = p22;
                    l__PrimaryPart__6.Name = "Handle";
                    l__PrimaryPart__6.Parent = p22;
                    v28.Parent = l__PrimaryPart__6;
                    p22.Grip = u7;
                    if not v26 then
                        l__PrimaryPart__6.CFrame = v24.CFrame * CFrame.new(0, -1, 0) * u7;
                        local v33 = Instance.new("WeldConstraint");
                        v33.Part0 = v24;
                        v33.Part1 = l__PrimaryPart__6;
                        v33.Parent = l__PrimaryPart__6;
                    end;
                    if u32 and u32:IsA("Animation") then
                        local v34, v35 = pcall(function() --[[ Line: 200 ]]
                            -- upvalues: u29 (ref), u32 (ref)
                            return u29:LoadAnimation(u32);
                        end);
                        if v34 and v35 then
                            v35.Looped = true;
                            v35:Play(0);
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
function v1.UpdateToolState(p36, p37) --[[ Line: 214 ]]
    -- upvalues: u6 (copy), u5 (copy)
    if u6[p37] then
    else
        local v38 = u5[p37];
        if v38 then
            local v39 = p37.Parent == v38;
            local v40 = p36:HasHandle(p37);
            if v39 and not v40 then
                p36:SpawnHandle(p37, v38);
            else
                if not v39 and v40 then
                    p36:ClearHandle(p37);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p41) --[[ Line: 234 ]]
    -- upvalues: u4 (copy), u5 (copy), u6 (copy)
    local v42 = u4[p41];
    if v42 then
        for _, v43 in v42 do
            v43:Disconnect();
        end;
        u4[p41] = nil;
    end;
    u5[p41] = nil;
    u6[p41] = nil;
end;
function v1.CleanupTool(p44, p45) --[[ Line: 247 ]]
    p44:ClearHandle(p45);
    p44:DisconnectTool(p45);
end;
function v1.IsTrackedTool(_, p46) --[[ Line: 253 ]]
    return p46:GetAttribute("Bird") ~= nil;
end;
function v1.SetupTool(u47, u48, p49) --[[ Line: 258 ]]
    -- upvalues: u5 (copy), u4 (copy)
    u47:DisconnectTool(u48);
    local v50 = {};
    u5[u48] = p49;
    local v51 = u48:GetPropertyChangedSignal("Parent");
    table.insert(v50, v51:Connect(function() --[[ Line: 266 ]]
        -- upvalues: u48 (copy), u5 (ref), u47 (copy)
        task.defer(function() --[[ Line: 267 ]]
            -- upvalues: u48 (ref), u5 (ref), u47 (ref)
            if u48 and u5[u48] then
                u47:UpdateToolState(u48);
            end;
        end);
    end));
    u4[u48] = v50;
    task.defer(function() --[[ Line: 278 ]]
        -- upvalues: u48 (copy), u5 (ref), u47 (copy)
        if u48 and u5[u48] then
            u47:UpdateToolState(u48);
        end;
    end);
end;
function v1.SetupCharacter(u52, u53) --[[ Line: 286 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 287 ]]
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
            u53.ChildAdded:Connect(function(u57) --[[ Line: 308 ]]
                -- upvalues: u52 (ref), u53 (ref)
                if u57:IsA("Tool") and u52:IsTrackedTool(u57) then
                    task.defer(function() --[[ Line: 310 ]]
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
function v1.SetupPlayer(u58, u59) --[[ Line: 321 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u59.Character then
        u58:SetupCharacter(u59.Character);
    end;
    u59.CharacterAdded:Connect(function(p60) --[[ Line: 327 ]]
        -- upvalues: u58 (copy)
        u58:SetupCharacter(p60);
    end);
    l__BackpackListener__4.bind(u59, function(u61) --[[ Line: 332 ]]
        -- upvalues: u58 (copy), u59 (copy)
        if u61:IsA("Tool") and u58:IsTrackedTool(u61) then
            task.defer(function() --[[ Line: 334 ]]
                -- upvalues: u59 (ref), u61 (copy), u58 (ref)
                local l__Character__7 = u59.Character;
                if u61 and (u61.Parent and (l__Character__7 and l__Character__7.Parent)) then
                    u58:SetupTool(u61, l__Character__7);
                end;
            end);
        end;
    end);
end;
return v1;