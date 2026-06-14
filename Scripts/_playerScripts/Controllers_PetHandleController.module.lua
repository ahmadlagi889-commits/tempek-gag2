-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__Assets__3 = l__ReplicatedStorage__2:WaitForChild("Assets");
local l__Networking__4 = require(l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("Networking"));
local l__BackpackListener__5 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__PetModules__6 = require(l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("PetModules"));
local l__PetSizes__7 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetSizes"));
local l__PetTypes__8 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetTypes"));
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = CFrame.fromOrientation(0, 0, -1.5707963267948966);
local function u11() --[[ Line: 86 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u5 (ref)
    local l__Character__10 = l__LocalPlayer__9.Character;
    if l__Character__10 then
        local v8 = l__Character__10:FindFirstChildOfClass("Humanoid");
        if v8 then
            local v9 = v8:FindFirstChildOfClass("Animator");
            if v9 then
                if not u5 then
                    local v10 = Instance.new("Animation");
                    v10.AnimationId = "rbxassetid://72938295589356";
                    u5 = v9:LoadAnimation(v10);
                    u5.Looped = true;
                    u5.Priority = Enum.AnimationPriority.Action4;
                end;
                if not u5.IsPlaying then
                    u5:Play();
                end;
            end;
        end;
    end;
end;
function v1.Init(_) --[[ Line: 113 ]] end;
function v1.Start(u12) --[[ Line: 116 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v13 in l__Players__1:GetPlayers() do
        u12:SetupPlayer(v13);
    end;
    l__Players__1.PlayerAdded:Connect(function(p14) --[[ Line: 121 ]]
        -- upvalues: u12 (copy)
        u12:SetupPlayer(p14);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p15) --[[ Line: 125 ]]
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
function v1.PreparePartForTool(_, p18) --[[ Line: 136 ]]
    p18.Anchored = false;
    p18.CanCollide = false;
    p18.CanQuery = false;
    p18.CanTouch = false;
    p18.Massless = true;
end;
function v1.DisableVFX(_, p19) --[[ Line: 144 ]]
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
function v1.ClearHandle(_, p21) --[[ Line: 156 ]]
    if p21:HasTag("PetRainbow") then
        p21:RemoveTag("PetRainbow");
    end;
    for _, u22 in p21:GetChildren() do
        if u22.Name == "Handle" or (u22.Name == "Build" or u22:IsA("Model")) then
            u22.Parent = nil;
            task.defer(function() --[[ Line: 165 ]]
                -- upvalues: u22 (copy)
                if u22 then
                    u22:Destroy();
                end;
            end);
        end;
    end;
end;
function v1.HasHandle(_, p23) --[[ Line: 172 ]]
    for _, v24 in p23:GetChildren() do
        if v24.Name == "Handle" then
            return true;
        end;
    end;
    return false;
end;
function v1.PlaceAboveHead(_, p25, p26, p27, p28, p29) --[[ Line: 182 ]]
    local v30 = p27:FindFirstChild("Head");
    local v31 = p27:FindFirstChild("HumanoidRootPart");
    if v30 and v30:IsA("BasePart") then
        if v31 and v31:IsA("BasePart") then
            local v32;
            if p28 then
                local l__Pivot__11 = p28.Pivot;
                if typeof(l__Pivot__11) == "Vector3" then
                    v32 = CFrame.Angles(math.rad(l__Pivot__11.X), math.rad(l__Pivot__11.Y), (math.rad(l__Pivot__11.Z)));
                else
                    v32 = CFrame.identity;
                end;
            else
                v32 = CFrame.identity;
            end;
            local l__LookVector__12 = v31.CFrame.LookVector;
            local v33 = Vector3.new(l__LookVector__12.X, 0, l__LookVector__12.Z);
            if v33.Magnitude >= 0.001 then
                l__LookVector__12 = v33;
            end;
            local v34 = v30.Position + Vector3.new(0, p29 * 1 + 1, 0);
            p25:PivotTo(CFrame.lookAt(v34, v34 + l__LookVector__12) * v32);
            local v35 = Instance.new("WeldConstraint");
            v35.Part0 = p26;
            v35.Part1 = v31;
            v35.Parent = p26;
        end;
    end;
end;
function v1.SpawnHandle(p36, p37, p38) --[[ Line: 210 ]]
    -- upvalues: u4 (copy), l__Assets__3 (copy), l__PetModules__6 (copy), u7 (copy), l__PetSizes__7 (copy), l__LocalPlayer__9 (copy), l__PetTypes__8 (copy)
    if u4[p37] then
    else
        u4[p37] = true;
        p36:ClearHandle(p37);
        local v39 = p38:FindFirstChild("Right Arm") or p38:FindFirstChild("RightHand");
        if v39 then
            local v40 = p37:GetAttribute("Pet");
            if type(v40) == "string" and v40 ~= "" then
                local v41 = l__Assets__3:FindFirstChild("Pets");
                local v42 = v41 and v41:FindFirstChild(v40) or l__Assets__3:FindFirstChild(v40);
                if v42 and v42:IsA("Model") then
                    local v43 = l__PetModules__6[v40];
                    local v44;
                    if v43 then
                        local l__HandGrip__13 = v43.HandGrip;
                        if typeof(l__HandGrip__13) == "Vector3" then
                            v44 = CFrame.fromOrientation(math.rad(l__HandGrip__13.X), math.rad(l__HandGrip__13.Y), (math.rad(l__HandGrip__13.Z)));
                        else
                            v44 = u7;
                        end;
                    else
                        v44 = u7;
                    end;
                    local v45 = l__PetSizes__7.Normalize(p37:GetAttribute("PetSize")) ~= nil;
                    local v46 = v42:Clone();
                    local v47 = l__PetSizes__7.GetScale(p37:GetAttribute("PetSize"), v43 and {
                        Big = v43.BigScale,
                        Huge = v43.HugeScale
                    } or nil);
                    if v47 ~= 1 then
                        v46:ScaleTo(v47);
                    end;
                    p36:DisableVFX(v46);
                    local v48 = l__LocalPlayer__9;
                    if v48 then
                        v48 = l__LocalPlayer__9.Character == p38;
                    end;
                    local l__PrimaryPart__14 = v46.PrimaryPart;
                    if l__PrimaryPart__14 then
                        for _, v49 in v46:GetDescendants() do
                            if v49:IsA("BasePart") then
                                p36:PreparePartForTool(v49);
                            end;
                        end;
                        local v50 = v46:FindFirstChildOfClass("AnimationController") or Instance.new("AnimationController");
                        local u51 = v50:FindFirstChildOfClass("Animator");
                        if not u51 then
                            u51 = Instance.new("Animator");
                            u51.Parent = v50;
                        end;
                        local u52 = nil;
                        local v53;
                        if v43 then
                            v53 = v43.Animations;
                        else
                            v53 = v43;
                        end;
                        local v54;
                        if type(v53) == "table" then
                            if v43.IsFlying then
                                v54 = v53.Fly or v53.Idle;
                            else
                                v54 = v53.Idle;
                            end;
                        else
                            v54 = nil;
                        end;
                        if v54 then
                            local v55 = v46:FindFirstChild("Animations");
                            if v55 then
                                u52 = v55:FindFirstChild(v54);
                            end;
                            u52 = u52 or v46:FindFirstChild(v54);
                        end;
                        v50.Parent = v46;
                        if v45 then
                            v46.Name = "Build";
                            v46.Parent = p37;
                            local v56 = Instance.new("Part");
                            v56.Name = "Handle";
                            v56.Size = Vector3.new(1, 1, 1);
                            v56.Transparency = 1;
                            v56.CanCollide = false;
                            v56.CanQuery = false;
                            v56.CanTouch = false;
                            v56.Massless = true;
                            v56.Parent = p37;
                            p36:PlaceAboveHead(v46, l__PrimaryPart__14, p38, v43, v47);
                        else
                            v46.Name = "Build";
                            v46.Parent = p37;
                            l__PrimaryPart__14.Name = "Handle";
                            l__PrimaryPart__14.Parent = p37;
                            p37.Grip = v44;
                            if not v48 then
                                local v57 = Instance.new("Motor6D");
                                v57.Name = "RightGrip";
                                v57.Part0 = v39;
                                v57.Part1 = l__PrimaryPart__14;
                                v57.C0 = CFrame.new(0, -1, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
                                v57.C1 = CFrame.new(0, 0, 0) * v44;
                                v57.Parent = v39;
                            end;
                        end;
                        if u52 and u52:IsA("Animation") then
                            local v58, v59 = pcall(function() --[[ Line: 345 ]]
                                -- upvalues: u51 (ref), u52 (ref)
                                return u51:LoadAnimation(u52);
                            end);
                            if v58 and v59 then
                                v59.Looped = true;
                                v59:Play(0);
                            end;
                        end;
                        if p37:GetAttribute("PetType") == l__PetTypes__8.Rainbow and not p37:HasTag("PetRainbow") then
                            p37:AddTag("PetRainbow");
                        end;
                        u4[p37] = nil;
                    else
                        v46:Destroy();
                        u4[p37] = nil;
                    end;
                else
                    u4[p37] = nil;
                end;
            else
                u4[p37] = nil;
            end;
        else
            u4[p37] = nil;
        end;
    end;
end;
function v1.UpdateToolState(p60, p61) --[[ Line: 365 ]]
    -- upvalues: u4 (copy), u3 (copy), l__LocalPlayer__9 (copy), l__PetSizes__7 (copy), u6 (ref), u11 (copy), u5 (ref)
    if u4[p61] then
    else
        local v62 = u3[p61];
        if v62 then
            local v63 = p61.Parent == v62;
            local v64 = p60:HasHandle(p61);
            if v63 and not v64 then
                p60:SpawnHandle(p61, v62);
            elseif not v63 and v64 then
                p60:ClearHandle(p61);
            end;
            if v63 and (v62 == l__LocalPlayer__9.Character and l__PetSizes__7.Normalize(p61:GetAttribute("PetSize")) ~= nil) then
                u6 = p61;
                u11();
            else
                if u6 == p61 then
                    u6 = nil;
                    if u5 and u5.IsPlaying then
                        u5:Stop();
                    end;
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p65) --[[ Line: 391 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (copy)
    local v66 = u2[p65];
    if v66 then
        for _, v67 in v66 do
            v67:Disconnect();
        end;
        u2[p65] = nil;
    end;
    u3[p65] = nil;
    u4[p65] = nil;
end;
function v1.CleanupTool(p68, p69) --[[ Line: 403 ]]
    -- upvalues: u6 (ref), u5 (ref)
    if u6 == p69 then
        u6 = nil;
        if u5 and u5.IsPlaying then
            u5:Stop();
        end;
    end;
    p68:ClearHandle(p69);
    p68:DisconnectTool(p69);
end;
function v1.IsTrackedTool(_, p70) --[[ Line: 412 ]]
    local v71 = p70:GetAttribute("Pet");
    local v72;
    if type(v71) == "string" then
        v72 = v71 ~= "";
    else
        v72 = false;
    end;
    return v72;
end;
function v1.SetupTool(u73, u74, p75) --[[ Line: 417 ]]
    -- upvalues: u3 (copy), l__Networking__4 (copy), u2 (copy)
    u73:DisconnectTool(u74);
    local v76 = {};
    u3[u74] = p75;
    local v77 = u74:GetPropertyChangedSignal("Parent");
    table.insert(v76, v77:Connect(function() --[[ Line: 423 ]]
        -- upvalues: u74 (copy), u3 (ref), u73 (copy)
        task.defer(function() --[[ Line: 424 ]]
            -- upvalues: u74 (ref), u3 (ref), u73 (ref)
            if u74 and u3[u74] then
                u73:UpdateToolState(u74);
            end;
        end);
    end));
    local u78 = u74:GetAttribute("PetId");
    if type(u78) == "string" and u78 ~= "" then
        table.insert(v76, u74.Activated:Connect(function() --[[ Line: 437 ]]
            -- upvalues: l__Networking__4 (ref), u78 (copy)
            l__Networking__4.Pets.RequestToggleFollower:Fire(u78);
        end));
    end;
    u2[u74] = v76;
    task.defer(function() --[[ Line: 444 ]]
        -- upvalues: u74 (copy), u3 (ref), u73 (copy)
        if u74 and u3[u74] then
            u73:UpdateToolState(u74);
        end;
    end);
end;
function v1.SetupCharacter(u79, u80) --[[ Line: 451 ]]
    -- upvalues: l__Players__1 (copy)
    task.defer(function() --[[ Line: 452 ]]
        -- upvalues: u80 (copy), l__Players__1 (ref), u79 (copy)
        if u80 and u80.Parent then
            local v81 = l__Players__1:GetPlayerFromCharacter(u80);
            for _, v82 in u80:GetChildren() do
                if v82:IsA("Tool") and u79:IsTrackedTool(v82) then
                    u79:SetupTool(v82, u80);
                end;
            end;
            if v81 and v81.Backpack then
                for _, v83 in v81.Backpack:GetChildren() do
                    if v83:IsA("Tool") and u79:IsTrackedTool(v83) then
                        u79:SetupTool(v83, u80);
                    end;
                end;
            end;
            u80.ChildAdded:Connect(function(u84) --[[ Line: 472 ]]
                -- upvalues: u79 (ref), u80 (ref)
                if u84:IsA("Tool") and u79:IsTrackedTool(u84) then
                    task.defer(function() --[[ Line: 474 ]]
                        -- upvalues: u84 (copy), u80 (ref), u79 (ref)
                        if u84 and (u84.Parent and (u80 and u80.Parent)) then
                            u79:SetupTool(u84, u80);
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.SetupPlayer(u85, u86) --[[ Line: 484 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u5 (ref), u6 (ref), l__BackpackListener__5 (copy)
    if u86.Character then
        u85:SetupCharacter(u86.Character);
    end;
    u86.CharacterAdded:Connect(function(p87) --[[ Line: 489 ]]
        -- upvalues: u86 (copy), l__LocalPlayer__9 (ref), u5 (ref), u6 (ref), u85 (copy)
        if u86 == l__LocalPlayer__9 then
            u5 = nil;
            u6 = nil;
        end;
        u85:SetupCharacter(p87);
    end);
    l__BackpackListener__5.bind(u86, function(u88) --[[ Line: 499 ]]
        -- upvalues: u85 (copy), u86 (copy)
        if u88:IsA("Tool") and u85:IsTrackedTool(u88) then
            task.defer(function() --[[ Line: 501 ]]
                -- upvalues: u86 (ref), u88 (copy), u85 (ref)
                local l__Character__15 = u86.Character;
                if u88 and (u88.Parent and (l__Character__15 and l__Character__15.Parent)) then
                    u85:SetupTool(u88, l__Character__15);
                end;
            end);
        end;
    end);
end;
return v1;