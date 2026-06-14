-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__SoundService__3 = game:GetService("SoundService");
local l__Seeds__4 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Seeds");
local l__BackpackListener__5 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local u2 = {};
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local u3 = {};
local u4 = {};
local u5 = {};
local function u10(p6, p7) --[[ Line: 28 ]]
    -- upvalues: l__SoundService__3 (copy)
    local v8 = p6:FindFirstChild("HumanoidRootPart");
    if v8 then
        local v9 = Instance.new("Sound");
        v9.SoundId = p7;
        v9.PlaybackSpeed = 1 + math.random(-15, 15) * 0.01;
        v9.SoundGroup = l__SoundService__3:FindFirstChild("SFXGroup");
        v9.Parent = v8;
        v9:Play();
        game.Debris:AddItem(v9, v9.TimeLength / math.max(v9.PlaybackSpeed, 0.01) + 1);
    end;
end;
local u11 = CFrame.new(0, -0.5, 0.25);
local u12 = CFrame.new(0, -1.25, -0.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
function v1.Init(_) --[[ Line: 44 ]] end;
function v1.Start(u13) --[[ Line: 47 ]]
    -- upvalues: l__Players__1 (copy), u3 (copy)
    for _, v14 in l__Players__1:GetPlayers() do
        u13:SetupPlayer(v14);
    end;
    l__Players__1.PlayerAdded:Connect(function(p15) --[[ Line: 52 ]]
        -- upvalues: u13 (copy)
        u13:SetupPlayer(p15);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p16) --[[ Line: 56 ]]
        -- upvalues: u3 (ref), l__Players__1 (ref), u13 (copy)
        for v17 in u3 do
            local v18 = not l__Players__1:GetPlayerFromCharacter(v17.Parent) and (v17.Parent and v17.Parent:IsA("Backpack"));
            if v18 then
                v18 = l__Players__1:GetPlayerFromCharacter(v17.Parent.Parent);
            end;
            if v18 == p16 then
                u13:CleanupTool(v17);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p19) --[[ Line: 67 ]]
    p19.Anchored = false;
    p19.CanCollide = false;
    p19.CanQuery = false;
    p19.CanTouch = false;
end;
function v1.ClearHandle(_, p20) --[[ Line: 74 ]]
    for _, u21 in p20:GetChildren() do
        if u21.Name == "Handle" or (u21.Name == "Build" or u21:IsA("Model")) then
            u21.Parent = nil;
            task.defer(function() --[[ Line: 78 ]]
                -- upvalues: u21 (copy)
                if u21 then
                    u21:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p22) --[[ Line: 87 ]]
    for _, v23 in p22:GetChildren() do
        if v23.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.SpawnHandle(p24, p25, p26) --[[ Line: 96 ]]
    -- upvalues: u5 (copy), u2 (copy), l__Seeds__4 (copy), l__LocalPlayer__6 (copy), u10 (copy), u11 (copy), u12 (copy)
    if u5[p25] then
    else
        u5[p25] = true;
        p24:ClearHandle(p25);
        local v27 = p25:GetAttribute("SeedTool");
        if v27 then
            local v28 = l__Seeds__4:FindFirstChild(u2[v27] or v27);
            if v28 then
                local v29 = p26:FindFirstChild("Right Arm") or p26:FindFirstChild("RightHand");
                if v29 then
                    local v30 = v28:Clone();
                    local v31 = l__LocalPlayer__6;
                    if v31 then
                        v31 = l__LocalPlayer__6.Character == p26;
                    end;
                    u10(p26, "rbxassetid://85584987915775");
                    if v30:IsA("BasePart") then
                        p24:PreparePartForTool(v30);
                        v30.Name = "Handle";
                        v30.Parent = p25;
                        if v31 then
                            p25.Grip = u11;
                        else
                            v30.CFrame = v29.CFrame * u12;
                            local v32 = Instance.new("WeldConstraint");
                            v32.Part0 = v30;
                            v32.Part1 = v29;
                            v32.Parent = v30;
                        end;
                    elseif v30:IsA("Model") then
                        local l__PrimaryPart__7 = v30.PrimaryPart;
                        if not l__PrimaryPart__7 then
                            v30:Destroy();
                            u5[p25] = nil;
                            return;
                        end;
                        for _, v33 in v30:GetDescendants() do
                            if v33:IsA("BasePart") then
                                p24:PreparePartForTool(v33);
                            end;
                        end;
                        for _, v34 in v30:GetDescendants() do
                            if v34:IsA("BasePart") and v34 ~= l__PrimaryPart__7 then
                                local v35 = Instance.new("WeldConstraint");
                                v35.Part0 = l__PrimaryPart__7;
                                v35.Part1 = v34;
                                v35.Parent = v34;
                            end;
                        end;
                        v30.Name = "Build";
                        v30.Parent = p25;
                        l__PrimaryPart__7.Name = "Handle";
                        l__PrimaryPart__7.Parent = p25;
                        if v31 then
                            p25.Grip = u11;
                        else
                            l__PrimaryPart__7.CFrame = v29.CFrame * u12;
                            local v36 = Instance.new("WeldConstraint");
                            v36.Part0 = l__PrimaryPart__7;
                            v36.Part1 = v29;
                            v36.Parent = l__PrimaryPart__7;
                        end;
                    end;
                    u5[p25] = nil;
                else
                    u5[p25] = nil;
                end;
            else
                u5[p25] = nil;
            end;
        else
            u5[p25] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p37, p38) --[[ Line: 187 ]]
    -- upvalues: u5 (copy), u4 (copy), u10 (copy)
    if u5[p38] then
    else
        local v39 = u4[p38];
        if v39 then
            local v40 = p38.Parent == v39;
            local v41 = p37:HasHandle(p38);
            if v40 and not v41 then
                p37:SpawnHandle(p38, v39);
            else
                if not v40 and v41 then
                    u10(v39, "rbxassetid://80262894398376");
                    p37:ClearHandle(p38);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p42) --[[ Line: 204 ]]
    -- upvalues: u3 (copy), u4 (copy), u5 (copy)
    local v43 = u3[p42];
    if v43 then
        for _, v44 in v43 do
            v44:Disconnect();
        end;
        u3[p42] = nil;
    end;
    u4[p42] = nil;
    u5[p42] = nil;
end;
function v1.CleanupTool(p45, p46) --[[ Line: 216 ]]
    p45:ClearHandle(p46);
    p45:DisconnectTool(p46);
end;
function v1.IsTrackedTool(_, p47) --[[ Line: 221 ]]
    return p47:GetAttribute("SeedTool") ~= nil;
end;
function v1.SetupTool(u48, u49, p50) --[[ Line: 225 ]]
    -- upvalues: u4 (copy), u3 (copy)
    u48:DisconnectTool(u49);
    local v51 = {};
    u4[u49] = p50;
    local v52 = u49:GetPropertyChangedSignal("Parent");
    table.insert(v51, v52:Connect(function() --[[ Line: 231 ]]
        -- upvalues: u49 (copy), u4 (ref), u48 (copy)
        task.defer(function() --[[ Line: 232 ]]
            -- upvalues: u49 (ref), u4 (ref), u48 (ref)
            if u49 and u4[u49] then
                u48:UpdateToolState(u49);
            end;
        end);
    end));
    u3[u49] = v51;
    task.defer(function() --[[ Line: 241 ]]
        -- upvalues: u49 (copy), u4 (ref), u48 (copy)
        if u49 and u4[u49] then
            u48:UpdateToolState(u49);
        end;
    end);
end;
function v1.SetupCharacter(u53, u54) --[[ Line: 248 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 249 ]]
        -- upvalues: u54 (copy), u53 (copy), l__Players__1 (ref)
        if u54 and u54.Parent then
            for _, v55 in u54:GetChildren() do
                if v55:IsA("Tool") and u53:IsTrackedTool(v55) then
                    u53:SetupTool(v55, u54);
                end;
            end;
            local v56 = l__Players__1:GetPlayerFromCharacter(u54);
            if v56 and v56.Backpack then
                for _, v57 in v56.Backpack:GetChildren() do
                    if v57:IsA("Tool") and u53:IsTrackedTool(v57) then
                        u53:SetupTool(v57, u54);
                    end;
                end;
            end;
            u54.ChildAdded:Connect(function(u58) --[[ Line: 268 ]]
                -- upvalues: u53 (ref), u54 (ref)
                if u58:IsA("Tool") and u53:IsTrackedTool(u58) then
                    task.defer(function() --[[ Line: 270 ]]
                        -- upvalues: u58 (copy), u54 (ref), u53 (ref)
                        if u58 and (u58.Parent and (u54 and u54.Parent)) then
                            u53:SetupTool(u58, u54);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u59, u60) --[[ Line: 280 ]]
    -- upvalues: l__BackpackListener__5 (copy)
    if u60.Character then
        u59:SetupCharacter(u60.Character);
    end;
    u60.CharacterAdded:Connect(function(p61) --[[ Line: 285 ]]
        -- upvalues: u59 (copy)
        u59:SetupCharacter(p61);
    end);
    l__BackpackListener__5.bind(u60, function(u62) --[[ Line: 289 ]]
        -- upvalues: u59 (copy), u60 (copy)
        if u62:IsA("Tool") and u59:IsTrackedTool(u62) then
            task.defer(function() --[[ Line: 291 ]]
                -- upvalues: u60 (ref), u62 (copy), u59 (ref)
                local l__Character__8 = u60.Character;
                if u62 and (u62.Parent and (l__Character__8 and l__Character__8.Parent)) then
                    u59:SetupTool(u62, l__Character__8);
                end;
            end);
        end;
    end);
end;
return v1;