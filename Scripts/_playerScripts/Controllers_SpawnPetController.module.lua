-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 7
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__Debris__4 = game:GetService("Debris");
local l__SoundService__5 = game:GetService("SoundService");
local l__LocalPlayer__6 = l__Players__1.LocalPlayer;
local l__SharedModules__7 = l__ReplicatedStorage__2:WaitForChild("SharedModules");
local l__Networking__8 = require(l__SharedModules__7:WaitForChild("Networking"));
local l__RarityVisuals__9 = require(l__SharedModules__7:WaitForChild("RarityVisuals"));
local l__PetModules__10 = require(l__SharedModules__7:WaitForChild("PetModules"));
local l__PetSizes__11 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetSizes"));
local l__PetTypes__12 = require(l__ReplicatedStorage__2:WaitForChild("SharedData"):WaitForChild("PetTypes"));
local l__PetLeaveTimer__13 = l__ReplicatedStorage__2.Assets.PetLeaveTimer;
local l__PetCostTimer__14 = l__ReplicatedStorage__2.Assets.PetCostTimer;
local l__Assets__15 = l__ReplicatedStorage__2:WaitForChild("Assets");
local u2 = l__Assets__15:FindFirstChild("Pets");
local u3 = {
    [2] = UDim2.new(0.2, 0, 0.722, 0),
    [3] = UDim2.new(0.3, 0, 0.722, 0),
    [4] = UDim2.new(0.375, 0, 0.722, 0),
    [5] = UDim2.new(0.5, 0, 0.722, 0),
    [6] = UDim2.new(0.575, 0, 0.722, 0),
    [7] = UDim2.new(0.65, 0, 0.722, 0)
};
local u4 = {};
local u5 = nil;
local function u11(p6) --[[ Line: 117 ]]
    local v7 = math.abs(p6);
    local v8 = math.floor(v7);
    local v9 = tostring(v8);
    local v10;
    repeat
        v9, v10 = string.gsub(v9, "^(%d+)(%d%d%d)", "%1,%2");
    until v10 == 0;
    return v9;
end;
local u12 = {
    [2] = UDim2.new(0.225, 0, 0.722, 0),
    [3] = UDim2.new(0.3, 0, 0.722, 0),
    [4] = UDim2.new(0.56, 0, 0.722, 0),
    [5] = UDim2.new(0.56, 0, 0.722, 0)
};
local function u18(p13) --[[ Line: 155 ]]
    local v14 = math.ceil(p13);
    local v15 = math.max(0, v14);
    if v15 >= 60 then
        local v16 = math.floor(v15 / 60);
        local v17 = v15 % 60;
        if v17 == 0 then
            return string.format("%dm", v16);
        else
            return string.format("%dm %ds", v16, v17);
        end;
    else
        return string.format("%ds", v15);
    end;
end;
local function u20() --[[ Line: 168 ]]
    -- upvalues: u5 (ref)
    if u5 and u5.Parent then
        return u5;
    end;
    local l__Map__16 = workspace:WaitForChild("Map", 30);
    local v19 = l__Map__16:FindFirstChild("WildPetSpawns");
    if v19 and v19:IsA("Folder") then
        u5 = v19;
    else
        u5 = Instance.new("Folder");
        u5.Name = "WildPetSpawns";
        u5.Parent = l__Map__16;
    end;
    return u5;
end;
local function u29(p21) --[[ Line: 191 ]]
    -- upvalues: l__Assets__15 (copy), l__Debris__4 (copy)
    local v22 = l__Assets__15:FindFirstChild("Poof");
    if v22 then
        local u23 = v22:Clone();
        if u23:IsA("BasePart") then
            u23.Anchored = true;
            u23.CanCollide = false;
            u23.CanQuery = false;
            u23.CanTouch = false;
            u23.Massless = true;
            u23.CFrame = p21;
        elseif u23:IsA("Model") then
            for _, v24 in u23:GetDescendants() do
                if v24:IsA("BasePart") then
                    v24.Anchored = true;
                    v24.CanCollide = false;
                    v24.CanQuery = false;
                    v24.CanTouch = false;
                    v24.Massless = true;
                end;
            end;
            u23:PivotTo(p21);
        end;
        local v25 = workspace:FindFirstChild("Temporary");
        if not (v25 and v25:IsA("Folder")) then
            v25 = Instance.new("Folder");
            v25.Name = "Temporary";
            v25.Parent = workspace;
        end;
        u23.Parent = v25;
        task.spawn(function() --[[ Line: 218 ]]
            -- upvalues: u23 (copy)
            task.wait();
            if u23 and u23.Parent then
                for _, v26 in u23:GetDescendants() do
                    if v26:IsA("ParticleEmitter") then
                        local v27;
                        if v26.Rate > 0 then
                            local v28 = math.floor(v26.Rate);
                            v27 = math.max(3, v28) or 5;
                        else
                            v27 = 5;
                        end;
                        v26:Emit(v27);
                    end;
                end;
            end;
        end);
        l__Debris__4:AddItem(u23, 5);
    end;
end;
local function u34(u30) --[[ Line: 230 ]]
    -- upvalues: l__Assets__15 (copy), l__Debris__4 (copy)
    local v31 = l__Assets__15:FindFirstChild("PopVFXModel");
    if v31 then
        local u32 = v31:Clone();
        if u32:IsA("Model") then
            pcall(function() --[[ Line: 235 ]]
                -- upvalues: u32 (copy), u30 (copy)
                u32:PivotTo(CFrame.new(u30));
            end);
        elseif u32:IsA("BasePart") then
            u32.CFrame = CFrame.new(u30);
        end;
        u32.Parent = workspace;
        task.spawn(function() --[[ Line: 241 ]]
            -- upvalues: u32 (copy)
            task.wait();
            if u32 and u32.Parent then
                for _, v33 in u32:GetDescendants() do
                    if v33:IsA("ParticleEmitter") then
                        v33:Emit(v33:GetAttribute("EmitCount") or 1);
                    end;
                end;
            end;
        end);
        l__Debris__4:AddItem(u32, 5);
    end;
end;
local function u40(p35, p36) --[[ Line: 253 ]]
    -- upvalues: l__SoundService__5 (copy)
    local u37 = Instance.new("Part");
    u37.Anchored = true;
    u37.CanCollide = false;
    u37.CanQuery = false;
    u37.CanTouch = false;
    u37.Transparency = 1;
    u37.Size = Vector3.new(1, 1, 1);
    u37.CFrame = CFrame.new(p36);
    u37.Parent = workspace;
    local u38 = Instance.new("Sound");
    u38.SoundId = p35;
    u38.Volume = 1;
    u38.RollOffMaxDistance = 200;
    u38.SoundGroup = l__SoundService__5:FindFirstChild("SFXGroup");
    u38.Parent = u37;
    task.spawn(function() --[[ Line: 271 ]]
        -- upvalues: u38 (copy), u37 (copy)
        if not u38.IsLoaded then
            u38.Loaded:Wait();
        end;
        u38:Play();
        local v39 = math.max(u38.PlaybackSpeed * u38.TimeLength, 0.5);
        task.wait(v39 + 0.1);
        if u37 and u37.Parent then
            u37:Destroy();
        end;
    end);
end;
local function u43(p41) --[[ Line: 280 ]]
    for _, v42 in p41:GetDescendants() do
        if v42:IsA("BodyMover") or (v42:IsA("VectorForce") or (v42:IsA("Torque") or (v42:IsA("LinearVelocity") or (v42:IsA("AngularVelocity") or (v42:IsA("AlignPosition") or v42:IsA("AlignOrientation")))))) then
            v42:Destroy();
        elseif v42:IsA("BasePart") then
            v42.Massless = true;
            v42.CanCollide = false;
            v42.CanTouch = false;
            v42.Anchored = false;
            v42.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            v42.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
        end;
    end;
end;
local function u49(p44) --[[ Line: 298 ]]
    -- upvalues: l__Assets__15 (copy)
    local v45 = l__Assets__15:FindFirstChild("PetTorso");
    if not v45 then
        return nil;
    end;
    local v46 = nil;
    for _, v47 in v45:GetChildren() do
        local v48 = v47:Clone();
        v48.Parent = p44;
        if v48.Name == "Tame" and v48:IsA("ParticleEmitter") then
            v48.Enabled = false;
            v46 = v48;
        end;
    end;
    return v46;
end;
local function u54(p50) --[[ Line: 333 ]]
    local v51 = (-1 / 0);
    local v52 = (1 / 0);
    for _, v53 in p50:GetDescendants() do
        if v53:IsA("BasePart") then
            local l__Y__17 = (v53.CFrame * CFrame.new(0, v53.Size.Y * 0.5, 0)).Y;
            local l__Y__18 = (v53.CFrame * CFrame.new(0, -v53.Size.Y * 0.5, 0)).Y;
            if v51 >= l__Y__17 then
                l__Y__17 = v51;
            end;
            if l__Y__18 < v52 then
                v52 = l__Y__18;
                v51 = l__Y__17;
            else
                v51 = l__Y__17;
            end;
        end;
    end;
    return v51 == (-1 / 0) and 0 or v51 - v52;
end;
local function u70(p55, p56) --[[ Line: 348 ]]
    -- upvalues: u54 (copy), l__PetCostTimer__14 (copy), l__PetLeaveTimer__13 (copy)
    local v57 = u54(p55);
    local v58 = nil;
    local v59 = nil;
    local v60 = {};
    local v61;
    if l__PetCostTimer__14 then
        v61 = l__PetCostTimer__14:Clone();
        if v61:IsA("BillboardGui") then
            v61.StudsOffset = Vector3.new(0, v57 + 1, 0);
            v61.Adornee = p56;
            v61.Parent = p56;
            local v62 = v61:FindFirstChild("TextLabel");
            if v62 then
                if v62:IsA("GuiObject") then
                    v59 = v62;
                end;
            end;
            if v62 and v62:IsA("TextLabel") then
                table.insert(v60, v62);
            end;
            if v62 then
                local v63 = v62:FindFirstChild("TextLabel");
                if v63 and v63:IsA("TextLabel") then
                    table.insert(v60, v63);
                end;
            end;
        else
            v61:Destroy();
            v61 = v58;
        end;
    else
        v61 = v58;
    end;
    local v64 = nil;
    local v65 = nil;
    local v66 = {};
    local v67;
    if l__PetLeaveTimer__13 then
        v67 = l__PetLeaveTimer__13:Clone();
        if v67:IsA("BillboardGui") then
            v67.StudsOffset = Vector3.new(0, v57 + 1 + 1.5, 0);
            v67.Adornee = p56;
            v67.Parent = p56;
            local v68 = v67:FindFirstChild("TextLabel");
            if v68 then
                if v68:IsA("GuiObject") then
                    v65 = v68;
                end;
            end;
            if v68 and v68:IsA("TextLabel") then
                table.insert(v66, v68);
            end;
            if v68 then
                local v69 = v68:FindFirstChild("TextLabel");
                if v69 and v69:IsA("TextLabel") then
                    table.insert(v66, v69);
                    return v61, v59, v60, v67, v65, v66;
                end;
            end;
        else
            v67:Destroy();
            v67 = v64;
        end;
    else
        v67 = v64;
    end;
    return v61, v59, v60, v67, v65, v66;
end;
local function u80(p71) --[[ Line: 410 ]]
    -- upvalues: l__LocalPlayer__6 (copy), u11 (copy), u3 (copy)
    local l__RefPart__19 = p71.RefPart;
    if l__RefPart__19 and l__RefPart__19.Parent then
        local l__CostGui__20 = p71.CostGui;
        if l__CostGui__20 then
            local v72 = l__RefPart__19:GetAttribute("OwnerUserId");
            if type(v72) == "number" and v72 == l__LocalPlayer__6.UserId then
                if l__CostGui__20.Enabled then
                    l__CostGui__20.Enabled = false;
                end;
            else
                if not l__CostGui__20.Enabled then
                    l__CostGui__20.Enabled = true;
                end;
                local v73 = l__RefPart__19:GetAttribute("Price");
                if type(v73) == "number" then
                    local v74 = "¢" .. u11(v73);
                    if v74 ~= p71.LastCostText then
                        p71.LastCostText = v74;
                        for _, v75 in p71.CostLabels do
                            if v75 and v75.Parent then
                                v75.Text = v74;
                            end;
                        end;
                    end;
                    local l__CostSizeTarget__21 = p71.CostSizeTarget;
                    if l__CostSizeTarget__21 then
                        local v76 = math.abs(v73);
                        local v77 = math.floor(v76);
                        local v78 = #tostring(v77);
                        local u79;
                        if v78 <= 2 then
                            u79 = u3[2];
                        elseif u3[v78] then
                            u79 = u3[v78];
                        else
                            u79 = UDim2.new((v78 - 7) * 0.075 + 0.65, 0, 0.722, 0);
                        end;
                        if l__CostSizeTarget__21.Size ~= u79 then
                            pcall(function() --[[ Line: 438 ]]
                                -- upvalues: l__CostSizeTarget__21 (copy), u79 (copy)
                                l__CostSizeTarget__21.Size = u79;
                            end);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
local function u89(p81) --[[ Line: 443 ]]
    -- upvalues: u18 (copy), u12 (copy)
    local l__RefPart__22 = p81.RefPart;
    if l__RefPart__22 and l__RefPart__22.Parent then
        local l__TimerGui__23 = p81.TimerGui;
        if l__TimerGui__23 then
            local v82 = l__RefPart__22:GetAttribute("OwnerUserId");
            if type(v82) == "number" and v82 ~= 0 then
                if l__TimerGui__23.Enabled then
                    l__TimerGui__23.Enabled = false;
                end;
            else
                if not l__TimerGui__23.Enabled then
                    l__TimerGui__23.Enabled = true;
                end;
                local v83 = l__RefPart__22:GetAttribute("SpawnedAt");
                local v84 = l__RefPart__22:GetAttribute("Lifetime");
                if type(v83) == "number" and type(v84) == "number" then
                    local v85 = u18(v83 + v84 - os.time());
                    if v85 == p81.LastTimerText then
                    else
                        p81.LastTimerText = v85;
                        for _, v86 in p81.TimerLabels do
                            if v86 and v86.Parent then
                                v86.Text = v85;
                            end;
                        end;
                        local l__TimerSizeTarget__24 = p81.TimerSizeTarget;
                        if l__TimerSizeTarget__24 then
                            local v87 = #v85;
                            local u88;
                            if v87 <= 2 then
                                u88 = u12[2];
                            elseif v87 >= 5 then
                                u88 = u12[5];
                            else
                                u88 = u12[v87];
                            end;
                            if l__TimerSizeTarget__24.Size ~= u88 then
                                pcall(function() --[[ Line: 471 ]]
                                    -- upvalues: l__TimerSizeTarget__24 (copy), u88 (copy)
                                    l__TimerSizeTarget__24.Size = u88;
                                end);
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
local function u100(p90, p91) --[[ Line: 488 ]]
    local v92 = (1 / 0);
    for _, v93 in p90:GetDescendants() do
        if v93:IsA("BasePart") and v93.Transparency < 1 then
            local l__CFrame__25 = v93.CFrame;
            local v94 = v93.Size.X * 0.5;
            local v95 = v93.Size.Y * 0.5;
            local v96 = v93.Size.Z * 0.5;
            for v97 = -1, 1, 2 do
                for v98 = -1, 1, 2 do
                    local l__Y__26 = (l__CFrame__25 * CFrame.new(v97 * v94, v98 * v95, -1 * v96)).Y;
                    if l__Y__26 >= v92 then
                        l__Y__26 = v92;
                    end;
                    v92 = (l__CFrame__25 * CFrame.new(v97 * v94, v98 * v95, 1 * v96)).Y;
                    if v92 >= l__Y__26 then
                        v92 = l__Y__26;
                    end;
                end;
            end;
        end;
    end;
    if v92 == (1 / 0) then
    else
        local v99 = p91.Position.Y - p91.Size.Y * 0.5 - v92;
        if math.abs(v99) > 0.001 then
            p90:PivotTo(p90:GetPivot() + Vector3.new(0, v99, 0));
        end;
    end;
end;
local function u109(p101) --[[ Line: 514 ]]
    local l__Y__27 = p101:GetPivot().Position.Y;
    local v102 = (1 / 0);
    for _, v103 in p101:GetDescendants() do
        if v103:IsA("BasePart") and v103.Transparency < 1 then
            local l__CFrame__28 = v103.CFrame;
            local v104 = v103.Size.X * 0.5;
            local v105 = v103.Size.Y * 0.5;
            local v106 = v103.Size.Z * 0.5;
            for v107 = -1, 1, 2 do
                for v108 = -1, 1, 2 do
                    local l__Y__29 = (l__CFrame__28 * CFrame.new(v107 * v104, v108 * v105, -1 * v106)).Y;
                    if l__Y__29 >= v102 then
                        l__Y__29 = v102;
                    end;
                    v102 = (l__CFrame__28 * CFrame.new(v107 * v104, v108 * v105, 1 * v106)).Y;
                    if v102 >= l__Y__29 then
                        v102 = l__Y__29;
                    end;
                end;
            end;
        end;
    end;
    return v102 == (1 / 0) and 0 or l__Y__27 - v102;
end;
local function u123(u110, p111, p112) --[[ Line: 537 ]]
    local v113 = p112 and p112.Animations or {};
    local v114 = {};
    local v115 = {};
    for _, v116 in p111:GetChildren() do
        if v116:IsA("Animation") then
            v114[v116.Name] = v116;
        end;
    end;
    local v117 = p111:FindFirstChild("Animations");
    if v117 then
        for _, v118 in v117:GetChildren() do
            if v118:IsA("Animation") then
                v114[v118.Name] = v118;
            end;
        end;
    end;
    for _, v119 in v113 do
        local u120 = v114[v119];
        if u120 then
            local v121, v122 = pcall(function() --[[ Line: 553 ]]
                -- upvalues: u110 (copy), u120 (copy)
                return u110:LoadAnimation(u120);
            end);
            if v121 and v122 then
                v122.Looped = true;
                v115[v119] = v122;
            end;
        end;
    end;
    return v115;
end;
local u124 = { "Idle", "GroundIdle", "Fly" };
local u125 = { "Walk", "Fly", "GroundIdle" };
local function u134(p126, p127) --[[ Line: 572 ]]
    -- upvalues: l__PetModules__10 (copy), u124 (copy), u125 (copy)
    if p126.CurrentState == p127 then
        return;
    end;
    p126.CurrentState = p127;
    for _, v128 in p126.Tracks do
        if v128.IsPlaying then
            v128:Stop(0.2);
        end;
    end;
    local v129 = l__PetModules__10[p126.PetName];
    local v130 = v129 and v129.Animations or {};
    local v131 = nil;
    if p127 == "idle" then
        v131 = u124;
    elseif p127 == "walking" then
        v131 = u125;
    end;
    if v131 then
        for _, v132 in v131 do
            local v133 = v130[v132];
            if v133 and p126.Tracks[v133] then
                p126.Tracks[v133]:Play(0.2);
                break;
            end;
        end;
    end;
    if p127 == "walking" then
        p126.NeedYawSnap = true;
    end;
end;
local function u175(u135) --[[ Line: 605 ]]
    -- upvalues: l__PetModules__10 (copy), u2 (copy), u43 (copy), l__PetSizes__11 (copy), u100 (copy), u109 (copy), u49 (copy), u70 (copy), u11 (copy), u20 (copy), l__PetTypes__12 (copy), u123 (copy), u80 (copy), u89 (copy), u134 (copy), l__LocalPlayer__6 (copy), l__Networking__8 (copy), u4 (copy)
    local v136 = u135:GetAttribute("PetName");
    if type(v136) ~= "string" or v136 == "" then
        return nil;
    end;
    local v137 = l__PetModules__10[v136];
    if not v137 then
        return nil;
    end;
    local v138 = u2:FindFirstChild(v137.AssetName);
    if not (v138 and v138:IsA("Model")) then
        return nil;
    end;
    local v139 = u135:GetAttribute("Rarity");
    local v140 = (type(v139) ~= "string" or v139 == "") and "Common" or v139;
    local v141 = v138:Clone();
    v141.Name = "WildPet_" .. v136 .. "_" .. u135.Name;
    v141:SetAttribute("PetName", v136);
    v141:SetAttribute("PetSize", u135:GetAttribute("PetSize"));
    v141:SetAttribute("PetType", u135:GetAttribute("PetType"));
    local v142 = not v141.PrimaryPart and (v141:FindFirstChild("RootPart") or v141:FindFirstChildWhichIsA("BasePart"));
    if v142 then
        v141.PrimaryPart = v142;
    end;
    if not v142 then
        v141:Destroy();
        return nil;
    end;
    u43(v141);
    v142.Anchored = true;
    local l__Pivot__30 = v137.Pivot;
    local l__identity__31 = CFrame.identity;
    if typeof(l__Pivot__30) == "Vector3" then
        l__identity__31 = CFrame.Angles(math.rad(l__Pivot__30.X), math.rad(l__Pivot__30.Y), (math.rad(l__Pivot__30.Z)));
    end;
    v141:PivotTo(u135.CFrame * l__identity__31);
    local v143 = l__PetSizes__11.GetScale(u135:GetAttribute("PetSize"), {
        Big = v137.BigScale,
        Huge = v137.HugeScale
    });
    if v143 ~= 1 then
        v141:ScaleTo(v143);
    end;
    u100(v141, u135);
    local v144 = u109(v141);
    local v145 = u49(v142);
    local v146 = v142:FindFirstChild("Info_BB");
    if v146 then
        v146:Destroy();
    end;
    local function v147() --[[ Line: 330 ]] end;
    local v148, v149, v150, v151, v152, v153 = u70(v141, v142);
    local v154 = v142:FindFirstChildOfClass("AnimationController") or v141:FindFirstChildOfClass("AnimationController");
    if not v154 then
        v154 = Instance.new("AnimationController");
        v154.Parent = v141;
    end;
    local v155 = v154:FindFirstChildOfClass("Animator");
    if not v155 then
        v155 = Instance.new("Animator");
        v155.Parent = v154;
    end;
    local v156 = Instance.new("ProximityPrompt");
    v156.Name = "BuyPrompt";
    v156.ActionText = "Buy";
    v156.ObjectText = "¢" .. u11(u135:GetAttribute("Price") or 0);
    v156.HoldDuration = 1;
    v156.MaxActivationDistance = 12;
    v156.RequiresLineOfSight = false;
    v156.Style = Enum.ProximityPromptStyle.Custom;
    v156.Parent = v142;
    v141.Parent = u20();
    if u135:GetAttribute("PetType") == l__PetTypes__12.Rainbow then
        v141:AddTag("PetRainbow");
    end;
    local v157 = u123(v155, v141, v137);
    local v158 = v137.IsFlying == true;
    local v159;
    if v158 then
        v159 = v137.AlwaysFlying == true;
    else
        v159 = v158;
    end;
    local v160 = v158 and ((v137.AirHeight or 5) * 0.6 or 0) or 0;
    local u161 = {
        RefPart = u135,
        PetName = v136,
        Rarity = v140,
        Model = v141,
        Primary = v142,
        Animator = v155,
        Tracks = v157,
        CurrentState = "",
        CurrentCF = v142.CFrame,
        LastYaw = 0,
        NeedYawSnap = true,
        FootOffset = v144,
        LastGroundY = nil,
        Prompt = v156,
        TameParticle = v145,
        Connections = {},
        RarityCleanup = v147,
        CostGui = v148,
        CostSizeTarget = v149,
        CostLabels = v150,
        LastCostText = "",
        TimerGui = v151,
        TimerSizeTarget = v152,
        TimerLabels = v153,
        LastTimerText = "",
        IsFlying = v158,
        AlwaysFlying = v159,
        AirHeight = v160,
        LandDuration = v158 and (v137.LandDuration or 0.8) or 0.8,
        TakeoffDuration = v158 and v137.TakeoffDuration or 0.8,
        FlightPhase = v159 and "Flying" or "Grounded",
        FlightHeight = v159 and v160 and v160 or 0,
        FlightPhaseStartedAt = os.clock(),
        LandingStartHeight = nil
    };
    u80(u161);
    u89(u161);
    local v162 = u134;
    local v163 = u135:GetAttribute("State");
    v162(u161, (v163 == "walking_to_garden" and true or v163 == "wandering_walking") and "walking" or "idle");
    local v164 = u161.RefPart:GetAttribute("OwnerUserId");
    u161.Prompt.Enabled = v164 ~= l__LocalPlayer__6.UserId;
    local v165 = u161.RefPart:GetAttribute("Price");
    if type(v165) == "number" then
        u161.Prompt.ObjectText = "¢" .. u11(v165);
    end;
    local l__Connections__32 = u161.Connections;
    local v166 = u135:GetAttributeChangedSignal("OwnerUserId");
    table.insert(l__Connections__32, v166:Connect(function() --[[ Line: 740 ]]
        -- upvalues: u161 (copy), l__LocalPlayer__6 (ref), u89 (ref), u80 (ref)
        local v167 = u161;
        local v168 = v167.RefPart:GetAttribute("OwnerUserId");
        v167.Prompt.Enabled = v168 ~= l__LocalPlayer__6.UserId;
        u89(u161);
        u80(u161);
    end));
    local l__Connections__33 = u161.Connections;
    local v169 = u135:GetAttributeChangedSignal("Price");
    table.insert(l__Connections__33, v169:Connect(function() --[[ Line: 746 ]]
        -- upvalues: u80 (ref), u161 (copy), u11 (ref)
        u80(u161);
        local v170 = u161;
        local v171 = v170.RefPart:GetAttribute("Price");
        if type(v171) == "number" then
            v170.Prompt.ObjectText = "¢" .. u11(v171);
        end;
    end));
    local l__Connections__34 = u161.Connections;
    local v172 = u135:GetAttributeChangedSignal("State");
    table.insert(l__Connections__34, v172:Connect(function() --[[ Line: 750 ]]
        -- upvalues: u135 (copy), u134 (ref), u161 (copy)
        local v173 = u135:GetAttribute("State");
        u134(u161, (v173 == "walking_to_garden" and true or v173 == "wandering_walking") and "walking" or "idle");
    end));
    table.insert(u161.Connections, v156.Triggered:Connect(function(p174) --[[ Line: 754 ]]
        -- upvalues: l__LocalPlayer__6 (ref), l__Networking__8 (ref), u135 (copy)
        if p174 == l__LocalPlayer__6 then
            l__Networking__8.Pets.WildPetTame:Fire(u135);
        end;
    end));
    u4[u135] = u161;
    return u161;
end;
local function u182(p176) --[[ Line: 763 ]]
    -- upvalues: u4 (copy), u29 (copy)
    local u177 = u4[p176];
    if u177 then
        u4[p176] = nil;
        if u177.Model and u177.Model.Parent then
            local v178, v179 = pcall(function() --[[ Line: 769 ]]
                -- upvalues: u177 (copy)
                return u177.Model:GetBoundingBox();
            end);
            if v178 and v179 then
                u29(v179);
            end;
        end;
        for _, u180 in u177.Connections do
            pcall(function() --[[ Line: 778 ]]
                -- upvalues: u180 (copy)
                u180:Disconnect();
            end);
        end;
        pcall(u177.RarityCleanup);
        for _, u181 in u177.Tracks do
            pcall(function() --[[ Line: 782 ]]
                -- upvalues: u181 (copy)
                u181:Stop(0);
            end);
        end;
        if u177.Model and u177.Model.Parent then
            u177.Model:Destroy();
        end;
    end;
end;
local u183 = RaycastParams.new();
u183.FilterType = Enum.RaycastFilterType.Exclude;
u183.IgnoreWater = false;
u183.RespectCanCollide = false;
local u184 = RaycastParams.new();
u184.FilterType = Enum.RaycastFilterType.Exclude;
u184.IgnoreWater = false;
u184.RespectCanCollide = false;
local function u189() --[[ Line: 797 ]]
    -- upvalues: u5 (ref), l__Players__1 (copy), u183 (copy)
    local v185 = {};
    if u5 and u5.Parent then
        table.insert(v185, u5);
    end;
    local v186 = workspace:FindFirstChild("Map");
    local v187;
    if v186 then
        v187 = v186:FindFirstChild("WildPetRef");
    else
        v187 = v186;
    end;
    if v187 then
        table.insert(v185, v187);
    end;
    if v186 then
        v186 = v186:FindFirstChild("PetSpawn");
    end;
    if v186 then
        table.insert(v185, v186);
    end;
    for _, v188 in l__Players__1:GetPlayers() do
        if v188.Character then
            table.insert(v185, v188.Character);
        end;
    end;
    u183.FilterDescendantsInstances = v185;
end;
local function u196(p190, p191) --[[ Line: 813 ]]
    -- upvalues: u183 (copy), u184 (copy)
    local v192 = Vector3.new(p190.X, p191 + 10, p190.Z);
    local v193 = workspace:Raycast(v192, Vector3.new(0, -35, 0), u183);
    if not (v193 and v193.Instance) then
        return nil;
    end;
    local l__Instance__35 = v193.Instance;
    if l__Instance__35.Transparency < 0.99 and l__Instance__35.CanCollide then
        return v193.Position.Y;
    end;
    local v194 = table.clone(u183.FilterDescendantsInstances);
    table.insert(v194, l__Instance__35);
    u184.FilterDescendantsInstances = v194;
    for _ = 1, 8 do
        local v195 = workspace:Raycast(v192, Vector3.new(0, -35, 0), u184);
        if not (v195 and v195.Instance) then
            return nil;
        end;
        local l__Instance__36 = v195.Instance;
        if l__Instance__36.Transparency < 0.99 and l__Instance__36.CanCollide then
            return v195.Position.Y;
        end;
        table.insert(v194, l__Instance__36);
        u184.FilterDescendantsInstances = v194;
    end;
    return nil;
end;
local function u202(p197, p198) --[[ Line: 846 ]]
    local v199 = p197.AlwaysFlying or p197.CurrentState == "walking";
    local l__FlightPhase__37 = p197.FlightPhase;
    if l__FlightPhase__37 == "Grounded" then
        p197.FlightHeight = 0;
        if v199 then
            p197.FlightPhaseStartedAt = p198;
            l__FlightPhase__37 = "Takeoff";
        end;
    elseif l__FlightPhase__37 == "Takeoff" then
        local v200 = math.clamp((p198 - p197.FlightPhaseStartedAt) / p197.TakeoffDuration, 0, 1);
        p197.FlightHeight = p197.AirHeight * v200;
        if v199 then
            if v200 >= 1 then
                p197.FlightHeight = p197.AirHeight;
                l__FlightPhase__37 = "Flying";
            end;
        else
            p197.FlightPhaseStartedAt = p198;
            p197.LandingStartHeight = p197.FlightHeight;
            l__FlightPhase__37 = "Landing";
        end;
    elseif l__FlightPhase__37 == "Flying" then
        p197.FlightHeight = p197.AirHeight;
        if not v199 then
            p197.FlightPhaseStartedAt = p198;
            p197.LandingStartHeight = p197.AirHeight;
            l__FlightPhase__37 = "Landing";
        end;
    elseif l__FlightPhase__37 == "Landing" then
        local v201 = math.clamp((p198 - p197.FlightPhaseStartedAt) / p197.LandDuration, 0, 1);
        p197.FlightHeight = (p197.LandingStartHeight or p197.AirHeight) * (1 - v201);
        if v199 then
            p197.FlightPhaseStartedAt = p198;
            l__FlightPhase__37 = "Takeoff";
        elseif v201 >= 1 then
            p197.FlightHeight = 0;
            l__FlightPhase__37 = "Grounded";
        end;
    end;
    p197.FlightPhase = l__FlightPhase__37;
    return p197.FlightHeight;
end;
local u203 = 0;
local function u223(p204) --[[ Line: 894 ]]
    -- upvalues: u203 (ref), u4 (copy), u89 (copy), u196 (copy), u202 (copy), l__PetModules__10 (copy)
    local v205 = math.min(1, p204 * 25);
    u203 = u203 + p204;
    local v206 = u203 >= 0.25;
    if v206 then
        u203 = 0;
    end;
    for v207, v208 in u4 do
        if v207.Parent then
            if v206 then
                u89(v208);
            end;
            local l__Model__38 = v208.Model;
            if l__Model__38 and l__Model__38.PrimaryPart then
                local l__Position__39 = v207.Position;
                local v209 = u196(l__Position__39, l__Position__39.Y) or (v208.LastGroundY or l__Position__39.Y);
                local v210 = v208.LastGroundY or v209;
                local v211 = math.clamp(p204 * 18, 0, 1);
                local v212 = v210 + (v209 - v210) * v211;
                v208.LastGroundY = v212;
                local v213 = Vector3.new(l__Position__39.X, v212 + v208.FootOffset, l__Position__39.Z);
                if v208.IsFlying then
                    local v214 = u202(v208, os.clock());
                    v213 = v213 + Vector3.new(0, v214, 0);
                end;
                local l__Position__40 = v208.CurrentCF.Position;
                local v215 = l__Position__40:Lerp(v213, v205);
                local v216 = v213.X - l__Position__40.X;
                local v217 = v213.Z - l__Position__40.Z;
                local v218;
                if v216 * v216 + v217 * v217 > 0.01 then
                    v218 = v208.CurrentState == "walking";
                else
                    v218 = false;
                end;
                local l__LastYaw__41 = v208.LastYaw;
                if v218 then
                    l__LastYaw__41 = math.atan2(-v216, -v217);
                end;
                if v208.NeedYawSnap and v218 then
                    v208.LastYaw = l__LastYaw__41;
                    v208.NeedYawSnap = false;
                else
                    local v219 = (l__LastYaw__41 - v208.LastYaw + 3.141592653589793) % 6.283185307179586 - 3.141592653589793;
                    local v220 = math.clamp(p204 * 12, 0, 1);
                    v208.LastYaw = v208.LastYaw + v219 * v220;
                end;
                local v221 = l__PetModules__10[v208.PetName];
                if v221 then
                    v221 = v221.Pivot;
                end;
                local l__identity__42 = CFrame.identity;
                if typeof(v221) == "Vector3" then
                    l__identity__42 = CFrame.Angles(math.rad(v221.X), math.rad(v221.Y), (math.rad(v221.Z)));
                end;
                local v222 = CFrame.new(v215) * CFrame.Angles(0, v208.LastYaw, 0) * l__identity__42;
                v208.CurrentCF = v222;
                l__Model__38.PrimaryPart.CFrame = v222;
            end;
        end;
    end;
end;
local function u225() --[[ Line: 951 ]]
    -- upvalues: l__LocalPlayer__6 (copy)
    local l__Character__43 = l__LocalPlayer__6.Character;
    if l__Character__43 then
        local v224 = l__Character__43:FindFirstChild("RightHand") or (l__Character__43:FindFirstChild("Right Arm") or l__Character__43:FindFirstChild("HumanoidRootPart"));
        if v224 and v224:IsA("BasePart") then
            return v224.Position;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
local function u230(p226, p227) --[[ Line: 961 ]]
    -- upvalues: u34 (copy), u40 (copy), u4 (copy), l__LocalPlayer__6 (copy), u225 (copy)
    if typeof(p226) == "Instance" and p226:IsA("BasePart") then
        u34(p226.Position);
        u40("rbxassetid://82832537745906", p226.Position);
        local v228 = u4[p226];
        if v228 and (v228.TameParticle and v228.TameParticle.Parent) then
            v228.TameParticle:Emit(math.random(3, 4));
        end;
        local v229 = p227 == l__LocalPlayer__6.UserId and u225();
        if v229 then
            u34(v229);
        end;
    end;
end;
local function u235(p231) --[[ Line: 978 ]]
    -- upvalues: l__SoundService__5 (copy)
    if p231 and p231.Parent then
        local v232 = (p231.Character or p231.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart");
        if v232 then
            local u233 = Instance.new("Sound");
            u233.SoundId = "rbxassetid://88022650354104";
            u233.Volume = 1;
            u233.RollOffMaxDistance = 700;
            u233.SoundGroup = l__SoundService__5:FindFirstChild("SFXGroup");
            u233.Parent = v232;
            task.spawn(function() --[[ Line: 991 ]]
                -- upvalues: u233 (copy)
                if not u233.IsLoaded then
                    u233.Loaded:Wait();
                end;
                u233:Play();
                local v234 = math.max(u233.PlaybackSpeed > 0 and u233.TimeLength / u233.PlaybackSpeed or 0.5, 0.5);
                task.wait(v234 + 0.1);
                if u233 and u233.Parent then
                    u233:Destroy();
                end;
            end);
        end;
    end;
end;
local function u238(p236, _) --[[ Line: 1000 ]]
    -- upvalues: u235 (copy), l__LocalPlayer__6 (copy), u225 (copy), u34 (copy)
    u235(p236);
    if p236 == l__LocalPlayer__6 then
        local v237 = u225();
        if v237 then
            u34(v237);
        end;
    end;
end;
local function u243(p239) --[[ Line: 1010 ]]
    -- upvalues: l__PetTypes__12 (copy), l__RunService__3 (copy), l__RarityVisuals__9 (copy), l__Debris__4 (copy)
    local l__Model__44 = p239.Model;
    if l__Model__44 and l__Model__44.Parent then
        local v240 = l__Model__44:FindFirstChild("OwlAlertHighlight");
        if v240 then
            v240:Destroy();
        end;
        local u241 = Instance.new("Highlight");
        u241.Name = "OwlAlertHighlight";
        u241.FillTransparency = 1;
        u241.OutlineTransparency = 0;
        u241.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        u241.Adornee = l__Model__44;
        u241.Parent = l__Model__44;
        if p239.RefPart:GetAttribute("PetType") == l__PetTypes__12.Rainbow then
            local u242 = nil;
            u242 = l__RunService__3.Heartbeat:Connect(function() --[[ Line: 1027 ]]
                -- upvalues: u241 (copy), u242 (ref)
                if u241.Parent then
                    u241.OutlineColor = Color3.fromHSV(tick() * 0.5 % 1, 1, 1);
                else
                    u242:Disconnect();
                end;
            end);
            task.delay(15, function() --[[ Line: 1034 ]]
                -- upvalues: u242 (ref), u241 (copy)
                u242:Disconnect();
                if u241 and u241.Parent then
                    u241:Destroy();
                end;
            end);
        else
            u241.OutlineColor = l__RarityVisuals__9.GetStaticColor(p239.Rarity);
            l__Debris__4:AddItem(u241, 15);
        end;
    end;
end;
local function u248(p244) --[[ Line: 1047 ]]
    -- upvalues: u4 (copy), u243 (copy)
    local v245 = os.clock() + 5;
    while os.clock() < v245 do
        for v246, v247 in u4 do
            if v246.Name == p244 then
                u243(v247);
                return;
            end;
        end;
        task.wait(0.05);
    end;
end;
function v1.Init(_) --[[ Line: 1060 ]] end;
function v1.Start(_) --[[ Line: 1062 ]]
    -- upvalues: u20 (copy), u189 (copy), l__Players__1 (copy), u175 (copy), u182 (copy), l__RunService__3 (copy), u223 (copy), l__Networking__8 (copy), u230 (copy), u238 (copy), u248 (copy)
    u20();
    u189();
    l__Players__1.PlayerAdded:Connect(u189);
    l__Players__1.PlayerRemoving:Connect(function(_) --[[ Line: 1066 ]]
        -- upvalues: u189 (ref)
        task.defer(u189);
    end);
    for _, v249 in l__Players__1:GetPlayers() do
        v249.CharacterAdded:Connect(function(_) --[[ Line: 1068 ]]
            -- upvalues: u189 (ref)
            u189();
        end);
    end;
    l__Players__1.PlayerAdded:Connect(function(p250) --[[ Line: 1070 ]]
        -- upvalues: u189 (ref)
        p250.CharacterAdded:Connect(function(_) --[[ Line: 1071 ]]
            -- upvalues: u189 (ref)
            u189();
        end);
    end);
    task.spawn(function() --[[ Line: 1074 ]]
        -- upvalues: u175 (ref), u182 (ref)
        local l__Map__45 = workspace:WaitForChild("Map", 30);
        if l__Map__45 then
            local function u255(p251) --[[ Line: 1077 ]]
                -- upvalues: u175 (ref), u182 (ref)
                for _, v252 in p251:GetChildren() do
                    if v252:IsA("BasePart") then
                        u175(v252);
                    end;
                end;
                p251.ChildAdded:Connect(function(p253) --[[ Line: 1081 ]]
                    -- upvalues: u175 (ref)
                    if p253:IsA("BasePart") then
                        u175(p253);
                    end;
                end);
                p251.ChildRemoved:Connect(function(p254) --[[ Line: 1084 ]]
                    -- upvalues: u182 (ref)
                    if p254:IsA("BasePart") then
                        u182(p254);
                    end;
                end);
            end;
            local v256 = l__Map__45:FindFirstChild("WildPetRef");
            if v256 and v256:IsA("Folder") then
                u255(v256);
            else
                l__Map__45.ChildAdded:Connect(function(p257) --[[ Line: 1092 ]]
                    -- upvalues: u255 (copy)
                    if p257.Name == "WildPetRef" and p257:IsA("Folder") then
                        u255(p257);
                    end;
                end);
            end;
        end;
    end);
    l__RunService__3.Heartbeat:Connect(function(p258) --[[ Line: 1100 ]]
        -- upvalues: u223 (ref)
        u223(p258);
    end);
    l__Networking__8.Pets.WildPetTameResult.OnClientEvent:Connect(function(p259, p260) --[[ Line: 1104 ]]
        -- upvalues: u230 (ref)
        pcall(u230, p259, p260);
    end);
    l__Networking__8.Pets.WildPetCollected.OnClientEvent:Connect(function(p261, p262) --[[ Line: 1108 ]]
        -- upvalues: u238 (ref)
        pcall(u238, p261, p262);
    end);
    l__Networking__8.SFX.OwlHoot.OnClientEvent:Connect(function(_, p263) --[[ Line: 1112 ]]
        -- upvalues: u248 (ref)
        if type(p263) == "string" and p263 ~= "" then
            task.spawn(u248, p263);
        end;
    end);
end;
return v1;