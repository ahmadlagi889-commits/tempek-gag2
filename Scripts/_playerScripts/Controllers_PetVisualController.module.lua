-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__SoundService__4 = game:GetService("SoundService");
local l__PetModules__5 = require(l__ReplicatedStorage__2.SharedModules.PetModules);
local l__Networking__6 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__PetSizes__7 = require(l__ReplicatedStorage__2.SharedData.PetSizes);
local l__PetTypes__8 = require(l__ReplicatedStorage__2.SharedData.PetTypes);
local function u3(p1, p2) --[[ Line: 17 ]]
    -- upvalues: l__PetTypes__8 (copy)
    if p1 then
        if p2 == l__PetTypes__8.Rainbow then
            if not p1:HasTag("PetRainbow") then
                p1:AddTag("PetRainbow");
            end;
        elseif p1:HasTag("PetRainbow") then
            p1:RemoveTag("PetRainbow");
        end;
    end;
end;
local l__Assets__9 = l__ReplicatedStorage__2:WaitForChild("Assets");
local u4 = {
    StartOrder = 6
};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = RaycastParams.new();
u13.FilterType = Enum.RaycastFilterType.Exclude;
u13.IgnoreWater = false;
u13.RespectCanCollide = false;
local function u21() --[[ Line: 110 ]]
    -- upvalues: l__Players__1 (copy), u8 (ref), u13 (copy)
    local v14 = {};
    for _, v15 in pairs(l__Players__1:GetPlayers()) do
        local l__Character__10 = v15.Character;
        if l__Character__10 then
            table.insert(v14, l__Character__10);
        end;
    end;
    local v16 = workspace:FindFirstChild("PlayerPetReferences");
    if v16 then
        table.insert(v14, v16);
    end;
    if u8 then
        table.insert(v14, u8);
    end;
    local v17 = workspace:FindFirstChild("Gardens");
    if v17 then
        for _, v18 in pairs(v17:GetChildren()) do
            local v19 = v18:FindFirstChild("Plants");
            if v19 then
                table.insert(v14, v19);
            end;
        end;
    end;
    local v20 = workspace:FindFirstChild("PottedPlantVisuals");
    if v20 then
        table.insert(v14, v20);
    end;
    u13.FilterDescendantsInstances = v14;
end;
local u22 = (-1 / 0);
local u23 = RaycastParams.new();
u23.FilterType = Enum.RaycastFilterType.Exclude;
u23.IgnoreWater = false;
u23.RespectCanCollide = false;
local function u30(p24, p25) --[[ Line: 146 ]]
    -- upvalues: u13 (copy), u23 (copy)
    local v26 = Vector3.new(p24.X, p25 + 200, p24.Z);
    local v27 = workspace:Raycast(v26, Vector3.new(0, -600, 0), u13);
    if not (v27 and v27.Instance) then
        return nil;
    end;
    local l__Instance__11 = v27.Instance;
    if l__Instance__11.Transparency < 0.99 and l__Instance__11.CanCollide then
        return v27.Position.Y;
    end;
    local v28 = table.clone(u13.FilterDescendantsInstances);
    table.insert(v28, l__Instance__11);
    u23.FilterDescendantsInstances = v28;
    for _ = 1, 8 do
        local v29 = workspace:Raycast(v26, Vector3.new(0, -600, 0), u23);
        if not (v29 and v29.Instance) then
            return nil;
        end;
        local l__Instance__12 = v29.Instance;
        if l__Instance__12.Transparency < 0.99 and l__Instance__12.CanCollide then
            return v29.Position.Y;
        end;
        table.insert(v28, l__Instance__12);
        u23.FilterDescendantsInstances = v28;
    end;
    return nil;
end;
local function u37(p31) --[[ Line: 206 ]]
    if p31:GetAttribute("PetSpecies") ~= "Frog" then
        return 0;
    end;
    local v32 = p31:GetAttribute("SlotJumpStart");
    if typeof(v32) ~= "number" then
        return 0;
    end;
    local v33 = p31:GetAttribute("SlotJumpPeak");
    if typeof(v33) ~= "number" or v33 <= 0 then
        return 0;
    end;
    local v34 = p31:GetAttribute("SlotJumpDuration");
    if typeof(v34) ~= "number" or v34 <= 0 then
        return 0;
    end;
    local v35 = workspace:GetServerTimeNow() - v32;
    if v35 < 0 or v34 < v35 then
        return 0;
    end;
    local v36 = v35 / v34;
    return v33 * 4 * v36 * (1 - v36);
end;
local function u46(p38) --[[ Line: 254 ]]
    local l__Y__13 = p38:GetPivot().Position.Y;
    local v39 = (1 / 0);
    for _, v40 in pairs(p38:GetDescendants()) do
        if v40:IsA("BasePart") and v40.Transparency < 1 then
            local l__CFrame__14 = v40.CFrame;
            local l__Size__15 = v40.Size;
            local v41 = l__Size__15.X * 0.5;
            local v42 = l__Size__15.Y * 0.5;
            local v43 = l__Size__15.Z * 0.5;
            for v44 = -1, 1, 2 do
                for v45 = -1, 1, 2 do
                    local l__Y__16 = (l__CFrame__14 * Vector3.new(v44 * v41, v45 * v42, -1 * v43)).Y;
                    if l__Y__16 >= v39 then
                        l__Y__16 = v39;
                    end;
                    v39 = (l__CFrame__14 * Vector3.new(v44 * v41, v45 * v42, 1 * v43)).Y;
                    if v39 >= l__Y__16 then
                        v39 = l__Y__16;
                    end;
                end;
            end;
        end;
    end;
    return v39 == (1 / 0) and 0 or l__Y__13 - v39;
end;
local function u50(p47) --[[ Line: 277 ]]
    local v48 = p47:FindFirstChildOfClass("AnimationController");
    if not v48 then
        v48 = Instance.new("AnimationController");
        v48.Parent = p47;
    end;
    local v49 = v48:FindFirstChildOfClass("Animator");
    if not v49 then
        v49 = Instance.new("Animator");
        v49.Parent = v48;
    end;
    return v49;
end;
local function u60(p51, p52) --[[ Line: 292 ]]
    local v53 = {};
    local v54 = p51:FindFirstChild("Animations");
    if p52 then
        local v55 = {};
        for _, v56 in pairs(p52) do
            if type(v56) == "string" and (v56 ~= "" and not v55[v56]) then
                v55[v56] = true;
                local v57 = v54 and v54:FindFirstChild(v56) or p51:FindFirstChild(v56);
                if v57 and v57:IsA("Animation") then
                    v53[v56] = v57;
                end;
            end;
        end;
        return v53;
    else
        if v54 then
            for _, v58 in pairs(v54:GetChildren()) do
                if v58:IsA("Animation") then
                    v53[v58.Name] = v58;
                end;
            end;
        end;
        for _, v59 in pairs(p51:GetChildren()) do
            if v59:IsA("Animation") then
                v53[v59.Name] = v59;
            end;
        end;
        return v53;
    end;
end;
local function u63(p61, p62) --[[ Line: 320 ]]
    if p61 then
        p61 = p61.Animations;
    end;
    if p61 then
        if p62 == "idle" then
            return p61.Idle;
        elseif p62 == "walking" then
            return p61.Walk;
        elseif p62 == "flying" then
            return p61.Fly;
        elseif p62 == "flyidle" then
            return p61.FlyIdle or p61.Fly;
        elseif p62 == "landing" then
            return p61.Land;
        elseif p62 == "takeoff" then
            return p61.Takeoff;
        elseif p62 == "groundidle" then
            return p61.GroundIdle or p61.Idle;
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
local function u71(p64, p65) --[[ Line: 344 ]]
    -- upvalues: u63 (copy)
    if p65 == "takeoff" then
        local l__Module__17 = p64.Module;
        if l__Module__17 then
            l__Module__17 = p64.Module.Animations;
        end;
        p65 = l__Module__17 and not l__Module__17.Takeoff and "flying" or p65;
    end;
    if p64.CurrentState == p65 then
    else
        local l__CurrentState__18 = p64.CurrentState;
        p64.CurrentState = p65;
        local v66;
        if l__CurrentState__18 == "landing" then
            v66 = false;
        else
            v66 = l__CurrentState__18 ~= "takeoff";
        end;
        local v67 = v66 and 0.2 or 0.05;
        for _, v68 in pairs(p64.Tracks) do
            if v68.IsPlaying then
                v68:Stop(v67);
            end;
        end;
        local v69 = u63(p64.Module, p65);
        if v69 then
            v69 = p64.Tracks[v69];
        end;
        if v69 then
            local v70;
            if p65 == "landing" then
                v70 = false;
            else
                v70 = p65 ~= "takeoff";
            end;
            v69.Looped = v70;
            v69:Play(v69.Looped and 0.2 or 0.05);
        end;
    end;
end;
local function u76(p72, p73) --[[ Line: 366 ]]
    local v74 = p73 and 0 or 1;
    for _, v75 in pairs(p72.Model:GetDescendants()) do
        if v75 ~= p72.Model.PrimaryPart then
            if v75:IsA("BasePart") then
                v75.Transparency = v74;
            elseif v75:IsA("Decal") then
                v75.Transparency = v74;
            end;
        end;
    end;
end;
local function u83(p77) --[[ Line: 379 ]]
    -- upvalues: l__PetModules__5 (copy), l__Assets__9 (copy)
    local v78 = l__PetModules__5[p77];
    if not v78 then
        return nil, nil;
    end;
    local v79 = l__Assets__9:FindFirstChild("Pets");
    local v80 = v79 and v79:FindFirstChild(v78.AssetName) or l__Assets__9:FindFirstChild(v78.AssetName);
    if not (v80 and v80:IsA("Model")) then
        return nil, nil;
    end;
    local v81 = v80:Clone();
    for _, v82 in pairs(v81:GetDescendants()) do
        if v82:IsA("BasePart") then
            v82.Anchored = false;
            v82.CanCollide = false;
            v82.CanQuery = false;
            v82.CanTouch = true;
            v82.Massless = true;
        end;
    end;
    return v81, v78;
end;
local function u89(p84, p85, p86) --[[ Line: 410 ]]
    local v87 = p84:FindFirstChild("PetTarget");
    if not v87 then
        v87 = Instance.new("Attachment");
        v87.Name = "PetTarget";
        v87.Parent = p84;
    end;
    local v88 = p86 or CFrame.identity;
    v87.CFrame = CFrame.new(0, p85, 0) * v88;
    return v87;
end;
local function u94(p90) --[[ Line: 439 ]]
    -- upvalues: u7 (copy), u6 (copy), u5 (copy)
    u7[p90] = (u7[p90] or 0) + 1;
    u6[p90] = nil;
    local v91 = u5[p90];
    if v91 then
        u5[p90] = nil;
        for _, v92 in pairs(v91.Connections) do
            v92:Disconnect();
        end;
        v91.Connections = {};
        for _, v93 in pairs(v91.Tracks) do
            v93:Stop(0);
        end;
        if v91.CarryFruitModel then
            v91.CarryFruitModel:Destroy();
            v91.CarryFruitModel = nil;
        end;
        if v91.Model and v91.Model.Parent then
            v91.Model:Destroy();
        end;
    end;
    u7[p90] = nil;
end;
local function u122(u95, u96) --[[ Line: 466 ]]
    -- upvalues: u6 (copy), u7 (copy), u5 (copy), u11 (ref), l__Players__1 (copy), u83 (copy), l__PetSizes__7 (copy), u46 (copy), u89 (copy), l__RunService__3 (copy), u9 (ref), u50 (copy), u60 (copy), u3 (copy), u94 (ref), u71 (copy), u76 (copy)
    if u6[u95] then
    else
        local u97 = (u7[u95] or 0) + 1;
        u7[u95] = u97;
        u6[u95] = u97;
        local function v99() --[[ Line: 475 ]]
            -- upvalues: u6 (ref), u95 (copy), u97 (copy), u96 (copy), u5 (ref), u11 (ref)
            if u6[u95] == u97 then
                u6[u95] = nil;
            end;
            if u95.Parent then
                local v98 = u95:GetAttribute("PetSpecies");
                if type(v98) == "string" and (v98 ~= "" and (v98 ~= u96 or not u5[u95])) then
                    task.defer(u11, u95);
                end;
            end;
        end;
        local l__Parent__19 = u95.Parent;
        local v100;
        if l__Parent__19 and l__Parent__19:IsA("Folder") then
            v100 = l__Players__1:FindFirstChild(l__Parent__19.Name);
        else
            v100 = nil;
        end;
        if not v100 then
            return v99();
        end;
        local v101, v102 = u83(u96);
        if not (v101 and v102) then
            return v99();
        end;
        v101:SetAttribute("PetID", u95:GetAttribute("PetId"));
        v101:SetAttribute("Owner", v100.Name);
        v101:SetAttribute("OwnerSlot", u95.Name);
        local l__PrimaryPart__20 = v101.PrimaryPart;
        if not (l__PrimaryPart__20 and l__PrimaryPart__20.Parent) then
            l__PrimaryPart__20 = v101:FindFirstChild("Torso") or (v101:FindFirstChild("RootPart") or v101:FindFirstChildWhichIsA("BasePart"));
            if l__PrimaryPart__20 then
                v101.PrimaryPart = l__PrimaryPart__20;
            end;
        end;
        if not l__PrimaryPart__20 then
            v101:Destroy();
            return v99();
        end;
        local v103;
        if v102 then
            local l__Pivot__21 = v102.Pivot;
            if typeof(l__Pivot__21) == "Vector3" then
                v103 = CFrame.Angles(math.rad(l__Pivot__21.X), math.rad(l__Pivot__21.Y), (math.rad(l__Pivot__21.Z)));
            else
                v103 = CFrame.identity;
            end;
        else
            v103 = CFrame.identity;
        end;
        v101:PivotTo(v103);
        local v104 = l__PetSizes__7.GetScale(u95:GetAttribute("PetSize"), {
            Big = v102.BigScale,
            Huge = v102.HugeScale
        });
        if v104 ~= 1 then
            v101:ScaleTo(v104);
        end;
        local v105 = u46(v101);
        local v106 = l__PrimaryPart__20.CFrame:Inverse() * v101:GetPivot();
        local v107 = u89(u95, v105, v103);
        l__RunService__3.Heartbeat:Wait();
        local v108 = 0;
        while v108 < 60 and (u95.Position.Magnitude <= 1 and not u95:GetAttribute("SlotVisualIndex")) do
            l__RunService__3.Heartbeat:Wait();
            v108 = v108 + 1;
            if (u7[u95] or 0) ~= u97 or (not u95.Parent or u95:GetAttribute("PetSpecies") ~= u96) then
                v101:Destroy();
                return v99();
            end;
        end;
        if (u7[u95] or 0) ~= u97 or (not u95.Parent or u95:GetAttribute("PetSpecies") ~= u96) then
            v101:Destroy();
            return v99();
        end;
        v101:PivotTo(u95.CFrame * v107.CFrame);
        local v109 = Instance.new("Attachment");
        v109.Name = "PetPivot";
        v109.CFrame = v106;
        v109.Parent = l__PrimaryPart__20;
        l__PrimaryPart__20.Anchored = true;
        v101.Parent = u9;
        if (u7[u95] or 0) ~= u97 or (not u95.Parent or u95:GetAttribute("PetSpecies") ~= u96) then
            if v101.Parent then
                v101:Destroy();
            end;
            return v99();
        end;
        local u110 = u50(v101);
        local v111 = u60(v101, v102.Animations);
        local v112 = {};
        for v113, u114 in pairs(v111) do
            local v115, v116 = pcall(function() --[[ Line: 547 ]]
                -- upvalues: u110 (copy), u114 (copy)
                return u110:LoadAnimation(u114);
            end);
            if v115 and v116 then
                v116.Looped = true;
                v116.Priority = Enum.AnimationPriority.Movement;
                v112[v113] = v116;
            end;
        end;
        local u117 = {
            Owner = v100,
            Slot = u95,
            Species = u96,
            Module = v102,
            Model = v101,
            Primary = l__PrimaryPart__20,
            Animator = u110,
            Tracks = v112,
            CurrentState = "",
            SlotAttachment = v107,
            PetAttachment = v109,
            FootOffset = v105,
            SpeciesPivotCFrame = v103,
            Generation = u97,
            Connections = {},
            LastAnimPos = u95.Position,
            LastAnimTime = os.clock(),
            AnimState = "idle",
            IsFlyer = v102.IsFlying == true
        };
        u5[u95] = u117;
        u3(v101, u95:GetAttribute("PetType"));
        table.insert(u117.Connections, v101.AncestryChanged:Connect(function(_, p118) --[[ Line: 579 ]]
            -- upvalues: u94 (ref), u95 (copy)
            if p118 == nil then
                u94(u95);
            end;
        end));
        task.spawn(function() --[[ Line: 583 ]]
            -- upvalues: l__RunService__3 (ref), u5 (ref), u95 (copy), u117 (copy)
            l__RunService__3.Heartbeat:Wait();
            if u5[u95] then
                local v119 = u117;
                local l__Slot__22 = v119.Slot;
                if l__Slot__22.Parent then
                    v119.Model:PivotTo(l__Slot__22.CFrame * v119.SlotAttachment.CFrame);
                end;
                u117.LastAnimPos = u95.Position;
                u117.LastAnimTime = os.clock();
            end;
        end);
        task.spawn(function() --[[ Line: 591 ]]
            -- upvalues: l__RunService__3 (ref), u5 (ref), u95 (copy), u117 (copy), u71 (ref)
            l__RunService__3.Heartbeat:Wait();
            if u5[u95] then
                local v120;
                if u117.IsFlyer then
                    local v121 = u95:GetAttribute("FlightPhase") or "Flying";
                    v120 = v121 == "Flying" and "flying" or (v121 == "Landing" and "landing" or (v121 == "Grounded" and "groundidle" or (v121 == "Takeoff" and "takeoff" or "flying")));
                else
                    v120 = "idle";
                end;
                u117.CurrentState = "";
                u71(u117, v120);
            end;
        end);
        u76(u117, u95:GetAttribute("PetVisible") ~= false);
        if u6[u95] == u97 then
            u6[u95] = nil;
        end;
    end;
end;
u11 = function(p123) --[[ Name: SyncSlot, Line 619 ]]
    -- upvalues: u5 (copy), u94 (ref), u7 (copy), u6 (copy), l__Players__1 (copy), u9 (ref), u122 (copy), u76 (copy)
    local v124 = p123:GetAttribute("PetSpecies");
    local v125 = u5[p123];
    if v125 and v125.Species ~= v124 then
        u94(p123);
        v125 = nil;
    end;
    if type(v124) == "string" and v124 ~= "" then
        if type(v124) == "string" and (v124 ~= "" and not v125) then
            u122(p123, v124);
        else
            if v125 then
                v125.Model:SetAttribute("PetID", p123:GetAttribute("PetId"));
                u76(v125, p123:GetAttribute("PetVisible") ~= false);
                local v126 = v125.Slot:GetAttribute("PetAttached") ~= false;
                v125.Model:SetAttribute("AttachedToPetPart", v126);
            end;
        end;
    else
        u7[p123] = (u7[p123] or 0) + 1;
        u6[p123] = nil;
        local l__Parent__23 = p123.Parent;
        local v127;
        if l__Parent__23 and l__Parent__23:IsA("Folder") then
            v127 = l__Players__1:FindFirstChild(l__Parent__23.Name);
        else
            v127 = nil;
        end;
        if v127 and u9 then
            for _, v128 in pairs(u9:GetChildren()) do
                if v128:GetAttribute("OwnerSlot") == p123.Name and v128:GetAttribute("Owner") == v127.Name then
                    v128:Destroy();
                end;
            end;
        end;
    end;
end;
local u129 = nil;
local u130 = nil;
local u131 = nil;
local u132 = nil;
local u133 = {};
local function u140(p134) --[[ Line: 661 ]]
    -- upvalues: u133 (copy), u131 (ref), u132 (ref), l__ReplicatedStorage__2 (copy)
    if u133[p134] == nil then
        local v135 = not (u131 and u132) and l__ReplicatedStorage__2:FindFirstChild("PlantGenerationModules");
        if v135 then
            u131 = v135:FindFirstChild("Fruits");
            u132 = v135:FindFirstChild("Plants");
        end;
        local v136 = nil;
        if u131 and u131:FindFirstChild(p134) then
            v136 = u131;
        elseif u132 and u132:FindFirstChild(p134) then
            v136 = u132;
        end;
        if v136 then
            local v137 = v136:FindFirstChild(p134);
            local v138, v139 = pcall(require, v137);
            if v138 and v139 then
                u133[p134] = {
                    Module = v139,
                    IsPlant = v136 == u132
                };
                return u133[p134];
            else
                u133[p134] = false;
                return false;
            end;
        else
            u133[p134] = false;
            return false;
        end;
    else
        return u133[p134];
    end;
end;
local function u145(p141) --[[ Line: 691 ]]
    -- upvalues: u129 (ref), u130 (ref), l__ReplicatedStorage__2 (copy)
    local v142 = not (u129 and u130) and l__ReplicatedStorage__2:FindFirstChild("Assets");
    if v142 then
        u129 = v142:FindFirstChild("Fruits");
        u130 = v142:FindFirstChild("Plants");
    end;
    local v143 = u129 and u129:FindFirstChild(p141);
    if v143 then
        return v143, false;
    else
        local v144 = u130 and u130:FindFirstChild(p141);
        if v144 then
            return v144, true;
        else
            return nil, false;
        end;
    end;
end;
local function u164(u146, p147, p148, p149, _, p150) --[[ Line: 721 ]]
    -- upvalues: u145 (copy), u140 (copy), u10 (ref)
    if u146.CarryFruitModel then
        u146.CarryFruitModel:Destroy();
        u146.CarryFruitModel = nil;
    end;
    if u146.Primary and u146.Primary.Parent then
        local u151 = u146.Primary:FindFirstChild("FruitPosition");
        if u151 and u151:IsA("Attachment") then
            local v152, v153 = u145(p147);
            if v152 then
                local v154 = u140(p147);
                if v154 then
                    u146.CarryFruitToken = (u146.CarryFruitToken or 0) + 1;
                    local l__CarryFruitToken__24 = u146.CarryFruitToken;
                    local u155 = v152:Clone();
                    for _, v156 in pairs(u155:GetDescendants()) do
                        if v156:IsA("BasePart") then
                            v156.CanCollide = false;
                            v156.CanQuery = false;
                            v156.CanTouch = false;
                            v156.Massless = true;
                            v156.Anchored = false;
                        end;
                    end;
                    u155.DescendantAdded:Connect(function(p157) --[[ Line: 747 ]]
                        if p157:IsA("BasePart") then
                            p157.CanCollide = false;
                            p157.CanQuery = false;
                            p157.CanTouch = false;
                            p157.Massless = true;
                            p157.Anchored = false;
                        end;
                    end);
                    if p150 and p150 ~= "" then
                        u155:SetAttribute("Mutation", p150);
                    end;
                    local v158 = nil;
                    if v153 and type(v154.Module.InitPlant) == "function" then
                        v158 = pcall(v154.Module.InitPlant, u155, p148, p149);
                    elseif type(v154.Module.InitFruit) == "function" then
                        v158 = pcall(v154.Module.InitFruit, u155, p148, p149);
                    end;
                    if v158 then
                        u155:PivotTo(CFrame.new(0, -5000, 0));
                        u155.Parent = u10;
                        task.spawn(function() --[[ Line: 771 ]]
                            -- upvalues: u155 (copy), u146 (copy), l__CarryFruitToken__24 (copy), u151 (copy)
                            local v159 = 0;
                            while u155 and (u155.Parent and not u155:HasTag("InitializationComplete")) do
                                task.wait();
                                v159 = v159 + 1;
                                if v159 > 600 then
                                    break;
                                end;
                            end;
                            if u146.CarryFruitToken == l__CarryFruitToken__24 and u155.Parent then
                                u155:PivotTo(u151.WorldCFrame);
                                local v160 = Instance.new("Part");
                                v160.Name = "CarryAnchor";
                                v160.Size = Vector3.new(0.01, 0.01, 0.01);
                                v160.Transparency = 1;
                                v160.CanCollide = false;
                                v160.CanQuery = false;
                                v160.CanTouch = false;
                                v160.Massless = true;
                                v160.Anchored = true;
                                v160.CFrame = u151.WorldCFrame;
                                v160.Parent = u155;
                                u155.PrimaryPart = v160;
                                for _, v161 in pairs(u155:GetDescendants()) do
                                    if v161:IsA("BasePart") and v161 ~= v160 then
                                        v161.Anchored = false;
                                        v161.CanCollide = false;
                                        v161.CanQuery = false;
                                        v161.CanTouch = false;
                                        v161.Massless = true;
                                    end;
                                end;
                                for _, v162 in pairs(u155:GetDescendants()) do
                                    if v162:IsA("BasePart") and v162 ~= v160 then
                                        local v163 = Instance.new("WeldConstraint");
                                        v163.Part0 = v160;
                                        v163.Part1 = v162;
                                        v163.Parent = v162;
                                    end;
                                end;
                                u146.CarryFruitModel = u155;
                                u146.CarryFruitAnchor = v160;
                                u146.CarryFruitAttach = u151;
                            else
                                u155:Destroy();
                            end;
                        end);
                    else
                        u155:Destroy();
                    end;
                end;
            end;
        end;
    end;
end;
local function u174(u165) --[[ Line: 835 ]]
    -- upvalues: u11 (ref), u94 (ref), u5 (copy), u76 (copy), u3 (copy), u164 (copy)
    u165.CanQuery = false;
    u165:GetAttributeChangedSignal("PetSpecies"):Connect(function() --[[ Line: 838 ]]
        -- upvalues: u11 (ref), u165 (copy)
        u11(u165);
    end);
    u165:GetAttributeChangedSignal("PetSize"):Connect(function() --[[ Line: 840 ]]
        -- upvalues: u94 (ref), u165 (copy), u11 (ref)
        u94(u165);
        u11(u165);
    end);
    u165:GetAttributeChangedSignal("PetVisible"):Connect(function() --[[ Line: 845 ]]
        -- upvalues: u5 (ref), u165 (copy), u76 (ref)
        local v166 = u5[u165];
        if v166 then
            u76(v166, u165:GetAttribute("PetVisible") ~= false);
        end;
    end);
    u165:GetAttributeChangedSignal("PetAttached"):Connect(function() --[[ Line: 851 ]]
        -- upvalues: u5 (ref), u165 (copy)
        local v167 = u5[u165];
        if v167 then
            local v168 = v167.Slot:GetAttribute("PetAttached") ~= false;
            v167.Model:SetAttribute("AttachedToPetPart", v168);
        end;
    end);
    u165:GetAttributeChangedSignal("PetId"):Connect(function() --[[ Line: 857 ]]
        -- upvalues: u5 (ref), u165 (copy)
        local v169 = u5[u165];
        if v169 then
            v169.Model:SetAttribute("PetID", u165:GetAttribute("PetId"));
        end;
    end);
    u165:GetAttributeChangedSignal("PetType"):Connect(function() --[[ Line: 863 ]]
        -- upvalues: u5 (ref), u165 (copy), u3 (ref)
        local v170 = u5[u165];
        if v170 then
            u3(v170.Model, u165:GetAttribute("PetType"));
        end;
    end);
    u165:GetAttributeChangedSignal("CarryingFruit"):Connect(function() --[[ Line: 869 ]]
        -- upvalues: u5 (ref), u165 (copy), u164 (ref)
        local v171 = u5[u165];
        if v171 then
            local v172 = u165:GetAttribute("CarryingFruit");
            if typeof(v172) == "string" and v172 ~= "" then
                u164(v171, v172, u165:GetAttribute("CarryingFruitSeed") or 0, u165:GetAttribute("CarryingFruitSize") or 1, u165:GetAttribute("CarryingFruitOvertimeGrowth") or 1, u165:GetAttribute("CarryingFruitMutation") or "");
            else
                v171.CarryFruitToken = (v171.CarryFruitToken or 0) + 1;
                v171.CarryFruitAnchor = nil;
                v171.CarryFruitAttach = nil;
                if v171.CarryFruitModel then
                    v171.CarryFruitModel:Destroy();
                    v171.CarryFruitModel = nil;
                end;
            end;
        end;
    end);
    u165.AncestryChanged:Connect(function(_, p173) --[[ Line: 884 ]]
        -- upvalues: u94 (ref), u165 (copy)
        if p173 == nil then
            u94(u165);
        end;
    end);
    u11(u165);
end;
local function u178(p175) --[[ Line: 891 ]]
    -- upvalues: u174 (copy)
    for _, v176 in pairs(p175:GetChildren()) do
        if v176:IsA("BasePart") and string.match(v176.Name, "^PetPart%d+$") then
            u174(v176);
        end;
    end;
    p175.ChildAdded:Connect(function(p177) --[[ Line: 897 ]]
        -- upvalues: u174 (ref)
        if p177:IsA("BasePart") and string.match(p177.Name, "^PetPart%d+$") then
            u174(p177);
        end;
    end);
end;
local function u182(p179) --[[ Line: 904 ]]
    -- upvalues: u178 (copy)
    for _, v180 in pairs(p179:GetChildren()) do
        if v180:IsA("Folder") then
            u178(v180);
        end;
    end;
    p179.ChildAdded:Connect(function(p181) --[[ Line: 908 ]]
        -- upvalues: u178 (ref)
        if p181:IsA("Folder") then
            u178(p181);
        end;
    end);
end;
function u4.SnapPetsForPlayer(_, p183) --[[ Line: 913 ]]
    -- upvalues: u5 (copy)
    for v184, v185 in pairs(u5) do
        if v185.Owner == p183 and v184.Parent then
            local v186 = v184:GetAttribute("PetClaim");
            if type(v186) ~= "string" or v186 == "" then
                v185.Model:PivotTo(v184.CFrame * v185.SlotAttachment.CFrame);
                v185.LastAnimPos = v184.Position;
                v185.LastAnimTime = os.clock();
                local l__Primary__25 = v185.Primary;
                if l__Primary__25 then
                    l__Primary__25 = v185.Primary.Position;
                end;
                v185.LastVisualPos = l__Primary__25;
                v185.LastVisualTime = os.clock();
                v185.SmoothedSpeed = 0;
                v185.LastGoalChangeTime = nil;
                v185.LastTrackedGoalXZ = nil;
            end;
        end;
    end;
end;
function u4.SnapLocalPetsToFollow(_) --[[ Line: 933 ]]
    -- upvalues: l__Players__1 (copy), u5 (copy), u30 (copy)
    local l__LocalPlayer__26 = l__Players__1.LocalPlayer;
    local l__Character__27 = l__LocalPlayer__26.Character;
    if l__Character__27 then
        l__Character__27 = l__Character__27:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__27 then
        local l__CFrame__28 = l__Character__27.CFrame;
        local l__LookVector__29 = l__CFrame__28.LookVector;
        local v187 = Vector3.new(l__LookVector__29.X, 0, l__LookVector__29.Z);
        local v188 = v187.Magnitude < 0.0001 and Vector3.new(0, 0, -1) or v187.Unit;
        local l__Position__30 = l__CFrame__28.Position;
        local v189 = CFrame.lookAt(l__Position__30, l__Position__30 + v188);
        for v190, v191 in pairs(u5) do
            if v191.Owner == l__LocalPlayer__26 and (v190.Parent and (v191.Primary and v191.Primary.Parent)) then
                local v192 = v190:GetAttribute("PetClaim");
                if type(v192) ~= "string" or v192 == "" then
                    local v193 = v190:GetAttribute("SlotOffsetX");
                    local v194 = v190:GetAttribute("SlotOffsetZ");
                    if typeof(v193) == "number" and typeof(v194) == "number" then
                        local v195 = v190:GetAttribute("SlotHeightOffset") or 0;
                        local v196 = v189 * CFrame.new(v193, -2.5, v194);
                        local l__Position__31 = v196.Position;
                        local v197 = u30(l__Position__31, l__Position__31.Y);
                        if v197 == nil then
                            v197 = l__Position__31.Y;
                        end;
                        v191.LastLocalGroundY = v197;
                        local v198;
                        if v191.IsFlyer then
                            v198 = v197 + (v191.FootOffset or 0) + v195;
                        else
                            v198 = v197 + (v191.FootOffset or 0);
                        end;
                        local v199 = Vector3.new(l__Position__31.X, v198, l__Position__31.Z);
                        local v200 = v196 - v196.Position;
                        local v201 = math.atan2(-v200.LookVector.X, -v200.LookVector.Z);
                        local v202 = v191.SpeciesPivotCFrame or CFrame.identity;
                        v191.Primary.CFrame = CFrame.new(v199) * CFrame.Angles(0, v201, 0) * v202;
                        v191.LocalGoalPos = v199;
                        v191.LocalGoalRotation = v200;
                        v191.LastYaw = v201;
                        v191.LocalChase = true;
                        v191.VirtualSlotPos = nil;
                        v191.ForceFollowUntil = os.clock() + 0.4;
                        v191.LastVisualPos = v199;
                        v191.LastVisualTime = os.clock();
                        v191.SmoothedSpeed = 0;
                        v191.LastGoalChangeTime = nil;
                        v191.LastTrackedGoalXZ = nil;
                        v191.AnimState = "idle";
                    end;
                end;
            end;
        end;
    end;
end;
local function u204() --[[ Line: 1002 ]]
    -- upvalues: l__Players__1 (copy), u5 (copy)
    local l__LocalPlayer__32 = l__Players__1.LocalPlayer;
    for _, v203 in pairs(u5) do
        if v203.Owner == l__LocalPlayer__32 and v203.Species == "Owl" then
            local l__Primary__33 = v203.Primary;
            if l__Primary__33 and l__Primary__33.Parent then
                return l__Primary__33;
            end;
        end;
    end;
    return nil;
end;
local function u210(p205) --[[ Line: 1015 ]]
    -- upvalues: u12 (ref), u204 (copy), l__Players__1 (copy), l__SoundService__4 (copy)
    if type(p205) == "string" and p205 ~= "" then
        if u12 and (u12.Parent and u12.IsPlaying) then
        else
            local v206 = u204();
            local v207;
            if v206 then
                v207 = v206;
            else
                v207 = l__Players__1.LocalPlayer.Character;
                if v207 then
                    v207 = v207:FindFirstChild("HumanoidRootPart");
                end;
                if v207 then
                    if not v207:IsA("BasePart") then
                        v207 = v206;
                    end;
                else
                    v207 = v206;
                end;
            end;
            if v207 then
                local u208 = Instance.new("Sound");
                u208.Name = "OwlHoot";
                u208.SoundId = p205;
                u208.Volume = 4.5;
                u208.RollOffMode = Enum.RollOffMode.InverseTapered;
                u208.RollOffMinDistance = 10;
                u208.RollOffMaxDistance = 400;
                local v209 = l__SoundService__4:FindFirstChild("SFXGroup");
                if v209 and v209:IsA("SoundGroup") then
                    u208.SoundGroup = v209;
                end;
                u208.Parent = v207;
                u12 = u208;
                u208:Play();
                u208.Ended:Once(function() --[[ Line: 1039 ]]
                    -- upvalues: u12 (ref), u208 (copy)
                    if u12 == u208 then
                        u12 = nil;
                    end;
                    u208:Destroy();
                end);
            end;
        end;
    end;
end;
function u4.Init(_) --[[ Line: 1045 ]] end;
function u4.Start(_) --[[ Line: 1047 ]]
    -- upvalues: u8 (ref), u9 (ref), u10 (ref), u182 (copy), l__Networking__6 (copy), u210 (copy), l__RunService__3 (copy), u4 (copy), l__Players__1 (copy), u22 (ref), u21 (copy), u5 (copy), u30 (copy), u37 (copy), u71 (copy)
    u8 = Instance.new("Folder");
    u8.Name = "_PetVisualClient";
    u8.Parent = workspace;
    u9 = Instance.new("Folder");
    u9.Name = "Models";
    u9.Parent = u8;
    u10 = Instance.new("Folder");
    u10.Name = "Carry";
    u10.Parent = u8;
    local v211 = workspace:FindFirstChild("PlayerPetReferences") or workspace:WaitForChild("PlayerPetReferences", 30);
    if v211 and v211:IsA("Folder") then
        u182(v211);
        l__Networking__6.SFX.OwlHoot.OnClientEvent:Connect(u210);
        l__Networking__6.Place.TeleportedBack.OnClientEvent:Connect(function() --[[ Line: 1066 ]]
            -- upvalues: l__RunService__3 (ref), u4 (ref), l__Players__1 (ref)
            task.spawn(function() --[[ Line: 1067 ]]
                -- upvalues: l__RunService__3 (ref), u4 (ref), l__Players__1 (ref)
                l__RunService__3.Heartbeat:Wait();
                u4:SnapPetsForPlayer(l__Players__1.LocalPlayer);
            end);
        end);
        local u212 = 0;
        local function v217(p213) --[[ Line: 1089 ]]
            -- upvalues: u212 (ref), l__Networking__6 (ref)
            local v214 = p213:FindFirstChildOfClass("Humanoid") or p213:WaitForChild("Humanoid", 10);
            if v214 and v214:IsA("Humanoid") then
                v214.Jumping:Connect(function(p215) --[[ Line: 1081 ]]
                    -- upvalues: u212 (ref), l__Networking__6 (ref)
                    if p215 then
                        local v216 = os.clock();
                        if v216 - u212 < 0.2 then
                        else
                            u212 = v216;
                            l__Networking__6.Pets.FrogJump:Fire();
                        end;
                    end;
                end);
            end;
        end;
        l__Players__1.LocalPlayer.CharacterAdded:Connect(v217);
        if l__Players__1.LocalPlayer.Character then
            task.spawn(v217, l__Players__1.LocalPlayer.Character);
        end;
        l__Networking__6.Pets.SnapPetsBroadcast.OnClientEvent:Connect(function(p218) --[[ Line: 1102 ]]
            -- upvalues: l__Players__1 (ref), l__RunService__3 (ref), u4 (ref)
            if p218 == l__Players__1.LocalPlayer.UserId then
            else
                local u219 = l__Players__1:GetPlayerByUserId(p218);
                if u219 then
                    task.spawn(function() --[[ Line: 1106 ]]
                        -- upvalues: l__RunService__3 (ref), u4 (ref), u219 (copy)
                        l__RunService__3.Heartbeat:Wait();
                        u4:SnapPetsForPlayer(u219);
                    end);
                end;
            end;
        end);
        l__RunService__3:BindToRenderStep("PetVisualFollow", Enum.RenderPriority.Camera.Value + 1, function(p220) --[[ Line: 1113 ]]
            -- upvalues: l__Players__1 (ref), u22 (ref), u21 (ref), u5 (ref), u30 (ref), u37 (ref)
            local l__LocalPlayer__34 = l__Players__1.LocalPlayer;
            local l__Character__35 = l__LocalPlayer__34.Character;
            if l__Character__35 then
                l__Character__35 = l__Character__35:FindFirstChild("HumanoidRootPart");
            end;
            local v221 = os.clock();
            if v221 - u22 >= 1 then
                u22 = v221;
                u21();
            end;
            for v222, v223 in pairs(u5) do
                if v222.Parent and (v223.Primary and v223.Primary.Parent) then
                    local v224 = nil;
                    local v225 = v222:GetAttribute("SlotOverride");
                    local v226 = v222:GetAttribute("SlotOffsetX");
                    local v227 = v222:GetAttribute("SlotOffsetZ");
                    local v228 = v222:GetAttribute("SlotHeightOffset") or 0;
                    local v229 = v222:GetAttribute("PetClaim");
                    local v230;
                    if type(v229) == "string" then
                        v230 = v229 ~= "";
                    else
                        v230 = false;
                    end;
                    if v230 then
                        v223.ForceFollowUntil = nil;
                        v225 = true;
                    elseif v223.ForceFollowUntil and os.clock() < v223.ForceFollowUntil then
                        if v223.Owner == l__LocalPlayer__34 and l__Character__35 then
                            v225 = false;
                        else
                            v223.ForceFollowUntil = nil;
                        end;
                    elseif v223.ForceFollowUntil then
                        v223.ForceFollowUntil = nil;
                    end;
                    if v223.Owner == l__LocalPlayer__34 and (l__Character__35 and (v225 ~= true and (typeof(v226) == "number" and typeof(v227) == "number"))) then
                        local l__CFrame__36 = l__Character__35.CFrame;
                        local l__LookVector__37 = l__CFrame__36.LookVector;
                        local v231 = Vector3.new(l__LookVector__37.X, 0, l__LookVector__37.Z);
                        local v232 = v231.Magnitude < 0.0001 and Vector3.new(0, 0, -1) or v231.Unit;
                        local l__Position__38 = l__CFrame__36.Position;
                        local v233 = CFrame.lookAt(l__Position__38, l__Position__38 + v232) * CFrame.new(v226, -2.5, v227);
                        local l__Position__39 = v233.Position;
                        local v234;
                        if v223.IsFlyer then
                            v234 = l__Position__39.Y + v228;
                        else
                            v234 = l__Position__39.Y;
                        end;
                        local v235 = Vector3.new(l__Position__39.X, v234, l__Position__39.Z);
                        local v236 = v233 - v233.Position;
                        v223.LocalGoalPos = v235;
                        v223.LocalGoalRotation = v236;
                        v223.LocalChase = true;
                        local v237 = Vector3.new(v235.X, 0, v235.Z);
                        if v223.LastTrackedGoalXZ and (v237 - v223.LastTrackedGoalXZ).Magnitude > 0.005 then
                            v223.LastGoalChangeTime = os.clock();
                        end;
                        v223.LastTrackedGoalXZ = v237;
                    else
                        local l__CFrame__40 = v222.CFrame;
                        if l__CFrame__40 ~= v223.LastSlotCF then
                            local v238 = os.clock();
                            if v223.LastSlotTickAt then
                                local v239 = v238 - v223.LastSlotTickAt;
                                if v223.SlotTickPeriod then
                                    v223.SlotTickPeriod = v223.SlotTickPeriod * 0.7 + math.clamp(v239, 0.01, 0.2) * 0.3;
                                else
                                    v223.SlotTickPeriod = math.clamp(v239, 0.01, 0.2);
                                end;
                            end;
                            v223.PrevSlotCF = v223.LastSlotCF or l__CFrame__40;
                            v223.LastSlotCF = l__CFrame__40;
                            v223.LastSlotTickAt = v238;
                            v223.LastGoalChangeTime = v238;
                        end;
                        if v223.PrevSlotCF and v223.LastSlotTickAt then
                            local v240 = v223.SlotTickPeriod or 0.03333333333333333;
                            local v241 = (os.clock() - v223.LastSlotTickAt) / v240;
                            local v242 = math.clamp(v241, 0, 1);
                            l__CFrame__40 = v223.PrevSlotCF:Lerp(l__CFrame__40, v242);
                        end;
                        v224 = l__CFrame__40 * v223.SlotAttachment.CFrame;
                        v223.InterpSlotCF = l__CFrame__40;
                        v223.LocalChase = false;
                    end;
                    if v223.LocalChase then
                        local l__LocalGoalPos__41 = v223.LocalGoalPos;
                        local l__LocalGoalRotation__42 = v223.LocalGoalRotation;
                        local l__Position__43 = v223.Primary.CFrame.Position;
                        local v243 = l__LocalGoalPos__41.X - l__Position__43.X;
                        local v244 = l__LocalGoalPos__41.Z - l__Position__43.Z;
                        local v245 = math.sqrt(v243 * v243 + v244 * v244);
                        local v246 = 1 - math.exp(-60 * p220);
                        local v247 = v223.Module and (v223.Module.FollowSpeed or 14) or 14;
                        local l__Owner__44 = v223.Owner;
                        if l__Owner__44 then
                            local l__Character__45 = l__Owner__44.Character;
                            if l__Character__45 then
                                l__Character__45 = l__Character__45:FindFirstChildOfClass("Humanoid");
                            end;
                            if l__Character__45 then
                                v247 = v247 * math.max(1, l__Character__45.WalkSpeed / 16);
                            end;
                        end;
                        local v248 = v247 * p220;
                        local v249, v250;
                        if v245 <= 0.05 or v245 <= v248 then
                            v249 = l__LocalGoalPos__41.X;
                            v250 = l__LocalGoalPos__41.Z;
                        else
                            local v251 = 1 / v245;
                            local v252 = v248 / math.max(v246, 0.001);
                            v249 = l__Position__43.X + v243 * v251 * v252;
                            v250 = l__Position__43.Z + v244 * v251 * v252;
                        end;
                        local v253;
                        if v223.IsFlyer then
                            local v254 = (v222:GetAttribute("SlotHeightOffset") or 0) / 1.5;
                            local v255 = math.clamp(v254, 0, 1);
                            local l__Y__46 = l__LocalGoalPos__41.Y;
                            local v256;
                            if v255 < 1 then
                                local v257 = u30(Vector3.new(v249, l__Position__43.Y, v250), l__Position__43.Y) or (v223.LastChaseGroundY or l__Position__43.Y);
                                local v258 = v223.LastChaseGroundY or v257;
                                local v259 = math.clamp(18 * p220, 0, 1);
                                local v260 = v258 + (v257 - v258) * v259;
                                v223.LastChaseGroundY = v260;
                                v256 = v260 + (v223.FootOffset or 0);
                            else
                                v256 = l__Y__46;
                            end;
                            v253 = v256 * (1 - v255) + l__Y__46 * v255;
                        else
                            local v261 = u30(Vector3.new(v249, l__Position__43.Y, v250), l__Position__43.Y) or (v223.LastChaseGroundY or l__Position__43.Y);
                            local v262 = v223.LastChaseGroundY or v261;
                            local v263 = math.clamp(18 * p220, 0, 1);
                            local v264 = v262 + (v261 - v262) * v263;
                            v223.LastChaseGroundY = v264;
                            v253 = v264 + (v223.FootOffset or 0) + u37(v222);
                        end;
                        local v265 = Vector3.new(v249, v253, v250);
                        local v266 = v265 - l__Position__43;
                        local v267 = v266.Magnitude / math.max(p220, 0.001);
                        local v268 = math.atan2(-l__LocalGoalRotation__42.LookVector.X, -l__LocalGoalRotation__42.LookVector.Z);
                        if v267 > 0.5 then
                            local v269 = Vector3.new(v266.X, 0, v266.Z);
                            if v269.Magnitude > 0.0001 then
                                local l__Unit__47 = v269.Unit;
                                v268 = math.atan2(-l__Unit__47.X, -l__Unit__47.Z);
                            end;
                        end;
                        local v270 = v223.LastYaw or v268;
                        local v271 = v270 + ((v268 - v270 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * math.clamp(12 * p220, 0, 1);
                        v223.LastYaw = v271;
                        v223.VirtualSlotPos = nil;
                        local v272 = v223.SpeciesPivotCFrame or CFrame.identity;
                        local v273 = CFrame.new(v265) * CFrame.Angles(0, v271, 0) * v272;
                        v223.Primary.CFrame = v223.Primary.CFrame:Lerp(v273, v246);
                    else
                        local l__Position__48 = v223.Primary.CFrame.Position;
                        local l__Position__49 = v224.Position;
                        local v274 = l__Position__49.X - l__Position__48.X;
                        local v275 = l__Position__49.Z - l__Position__48.Z;
                        local v276 = math.sqrt(v274 * v274 + v275 * v275);
                        local v277 = 1 - math.exp(-60 * p220);
                        local v278 = v223.Module and (v223.Module.FollowSpeed or 14) or 14;
                        local l__Owner__50 = v223.Owner;
                        if l__Owner__50 then
                            local l__Character__51 = l__Owner__50.Character;
                            if l__Character__51 then
                                l__Character__51 = l__Character__51:FindFirstChildOfClass("Humanoid");
                            end;
                            if l__Character__51 then
                                v278 = v278 * math.max(1, l__Character__51.WalkSpeed / 16);
                            end;
                        end;
                        local v279 = v278 * p220;
                        local v280, v281, v282;
                        if v276 > 0.05 and v279 < v276 then
                            local v283 = 1 / v276;
                            local v284 = v279 / math.max(v277, 0.001);
                            v280 = l__Position__48.X + v274 * v283 * v284;
                            v281 = l__Position__48.Z + v275 * v283 * v284;
                            v282 = true;
                        else
                            v280 = l__Position__49.X;
                            v281 = l__Position__49.Z;
                            v282 = false;
                        end;
                        local v285;
                        if v223.IsFlyer then
                            v285 = l__Position__49.Y;
                        else
                            local v286 = u30(Vector3.new(v280, l__Position__48.Y, v281), l__Position__48.Y) or (v223.LastChaseGroundY or l__Position__48.Y);
                            local v287 = v223.LastChaseGroundY or v286;
                            local v288 = math.clamp(18 * p220, 0, 1);
                            local v289 = v287 + (v286 - v287) * v288;
                            v223.LastChaseGroundY = v289;
                            v285 = v289 + (v223.FootOffset or 0) + u37(v222);
                        end;
                        local v290 = Vector3.new(v280, v285, v281);
                        local l__LookVector__52 = (v223.InterpSlotCF or v224).LookVector;
                        local v291 = math.atan2(-l__LookVector__52.X, -l__LookVector__52.Z);
                        local v292 = v290 - l__Position__48;
                        if v282 and v292.Magnitude / math.max(p220, 0.001) > 0.5 then
                            local v293 = Vector3.new(v292.X, 0, v292.Z);
                            if v293.Magnitude > 0.0001 then
                                local l__Unit__53 = v293.Unit;
                                v291 = math.atan2(-l__Unit__53.X, -l__Unit__53.Z);
                            end;
                        end;
                        local v294 = v223.LastYaw or v291;
                        local v295 = v294 + ((v291 - v294 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793) * math.clamp(12 * p220, 0, 1);
                        v223.LastYaw = v295;
                        local v296 = v223.SpeciesPivotCFrame or CFrame.identity;
                        local v297 = CFrame.new(v290) * CFrame.Angles(0, v295, 0) * v296;
                        v223.Primary.CFrame = v223.Primary.CFrame:Lerp(v297, v277);
                        v223.VirtualSlotPos = nil;
                    end;
                    if v223.CarryFruitAnchor and (v223.CarryFruitAnchor.Parent and (v223.CarryFruitAttach and v223.CarryFruitAttach.Parent)) then
                        v223.CarryFruitAnchor.CFrame = v223.CarryFruitAttach.WorldCFrame;
                    end;
                end;
            end;
        end);
        l__RunService__3.Heartbeat:Connect(function(p298) --[[ Line: 1349 ]]
            -- upvalues: u22 (ref), u21 (ref), u5 (ref), u30 (ref), u71 (ref)
            local v299 = os.clock();
            if v299 - u22 >= 1 then
                u22 = v299;
                u21();
            end;
            for v300, v301 in pairs(u5) do
                if v300.Parent then
                    local l__Position__54 = v300.Position;
                    local l__SlotAttachment__55 = v301.SlotAttachment;
                    if l__SlotAttachment__55 and l__SlotAttachment__55.Parent then
                        local v302 = v301.SpeciesPivotCFrame or CFrame.identity;
                        local v303;
                        if v301.IsFlyer then
                            local v304 = (v300:GetAttribute("SlotHeightOffset") or 0) / 1.5;
                            local v305 = math.clamp(v304, 0, 1);
                            local v306 = v301.FootOffset or 0;
                            local v307 = v300:GetAttribute("Perched") == true;
                            local v308 = v300:GetAttribute("FlightPhase") == "Takeoff";
                            local v309;
                            if v305 < 1 and not (v307 or v308) then
                                local v310 = os.clock();
                                if (v301.SlotGroundCastNext or 0) <= v310 then
                                    local v311 = u30(l__Position__54, l__Position__54.Y);
                                    if v311 ~= nil then
                                        v301.SlotGroundCachedY = v311;
                                    end;
                                    v301.SlotGroundCastNext = v310 + 0.06666666666666667;
                                end;
                                local l__SlotGroundCachedY__56 = v301.SlotGroundCachedY;
                                if l__SlotGroundCachedY__56 == nil then
                                    l__SlotGroundCachedY__56 = v301.LastGroundY or l__Position__54.Y;
                                end;
                                local v312 = v301.LastGroundY or l__SlotGroundCachedY__56;
                                local v313 = math.clamp(18 * p298, 0, 1);
                                local v314 = v312 + (l__SlotGroundCachedY__56 - v312) * v313;
                                v301.LastGroundY = v314;
                                v309 = v314 - l__Position__54.Y + (v301.FootOffset or 0);
                            else
                                v309 = v306;
                            end;
                            v303 = v309 * (1 - v305) + v306 * v305;
                        else
                            local v315 = os.clock();
                            if (v301.SlotGroundCastNext or 0) <= v315 then
                                local v316 = u30(l__Position__54, l__Position__54.Y);
                                if v316 ~= nil then
                                    v301.SlotGroundCachedY = v316;
                                end;
                                v301.SlotGroundCastNext = v315 + 0.06666666666666667;
                            end;
                            local l__SlotGroundCachedY__57 = v301.SlotGroundCachedY;
                            if l__SlotGroundCachedY__57 == nil then
                                l__SlotGroundCachedY__57 = v301.LastGroundY or l__Position__54.Y;
                            end;
                            local v317 = v301.LastGroundY or l__SlotGroundCachedY__57;
                            local v318 = math.clamp(18 * p298, 0, 1);
                            local v319 = v317 + (l__SlotGroundCachedY__57 - v317) * v318;
                            v301.LastGroundY = v319;
                            v303 = v319 - l__Position__54.Y + (v301.FootOffset or 0);
                        end;
                        l__SlotAttachment__55.CFrame = CFrame.new(0, v303, 0) * v302;
                    end;
                    if v301.IsFlyer then
                        local v320 = v300:GetAttribute("FlightPhase") or "Flying";
                        local v321 = v320 == "Flying" and "flying" or (v320 == "Landing" and "landing" or (v320 == "Grounded" and "groundidle" or (v320 == "Takeoff" and "takeoff" or "flying")));
                        local l__Module__58 = v301.Module;
                        if l__Module__58 then
                            l__Module__58 = v301.Module.Animations;
                        end;
                        if v321 == "flying" and (l__Module__58 and l__Module__58.FlyIdle) then
                            local v322 = os.clock();
                            local v323 = 0;
                            local l__Primary__59 = v301.Primary;
                            if l__Primary__59 then
                                l__Primary__59 = v301.Primary.Position;
                            end;
                            if l__Primary__59 then
                                if v301.LastVisualPos and v301.LastVisualTime then
                                    local v324 = math.max(0.001, v322 - v301.LastVisualTime);
                                    local l__Magnitude__60 = (l__Primary__59 - v301.LastVisualPos).Magnitude;
                                    if l__Magnitude__60 < 50 then
                                        v323 = l__Magnitude__60 / v324;
                                    end;
                                end;
                                v301.LastVisualPos = l__Primary__59;
                                v301.LastVisualTime = v322;
                            end;
                            local v325 = math.clamp(p298 * 6, 0, 1);
                            v301.SmoothedSpeed = (v301.SmoothedSpeed or 0) * (1 - v325) + v323 * v325;
                            local l__SmoothedSpeed__61 = v301.SmoothedSpeed;
                            local l__AnimState__62 = v301.AnimState;
                            v321 = l__SmoothedSpeed__61 > 2 and "flying" or (l__SmoothedSpeed__61 < 0.6 and "flyidle" or (l__AnimState__62 ~= "flying" and l__AnimState__62 ~= "flyidle" and "flying" or l__AnimState__62));
                        end;
                        v301.AnimState = v321;
                        u71(v301, v321);
                    else
                        local v326 = os.clock();
                        local v327 = 0;
                        local l__Primary__63 = v301.Primary;
                        if l__Primary__63 then
                            l__Primary__63 = v301.Primary.Position;
                        end;
                        if l__Primary__63 then
                            if v301.LastVisualPos and v301.LastVisualTime then
                                local v328 = math.max(0.001, v326 - v301.LastVisualTime);
                                local l__Magnitude__64 = (l__Primary__63 - v301.LastVisualPos).Magnitude;
                                if l__Magnitude__64 < 50 then
                                    v327 = l__Magnitude__64 / v328;
                                end;
                            end;
                            v301.LastVisualPos = l__Primary__63;
                            v301.LastVisualTime = v326;
                        end;
                        local v329 = math.clamp(p298 * 6, 0, 1);
                        v301.SmoothedSpeed = (v301.SmoothedSpeed or 0) * (1 - v329) + v327 * v329;
                        local l__SmoothedSpeed__65 = v301.SmoothedSpeed;
                        local v330 = v301.AnimState or "idle";
                        local v331 = v330 == "idle" and l__SmoothedSpeed__65 > 2 and "walking" or (v330 == "walking" and l__SmoothedSpeed__65 < 0.6 and "idle" or v330);
                        v301.AnimState = v331;
                        u71(v301, v331);
                    end;
                end;
            end;
        end);
    end;
end;
return u4;