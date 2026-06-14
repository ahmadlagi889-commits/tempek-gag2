-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__BackpackListener__4 = require(l__ReplicatedStorage__2:WaitForChild("ClientModules"):WaitForChild("BackpackListener"));
local l__Environment__5 = require(l__ReplicatedStorage__2:WaitForChild("SharedModules"):WaitForChild("Environment"));
local l__MutationController__6 = require(script.Parent.MutationController);
local l__Handles__7 = game.Workspace.Handles;
local l__Hold_Above__8 = script.Hold_Above;
local l__Fruits__9 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Fruits");
local l__Plants__10 = l__ReplicatedStorage__2:WaitForChild("Assets"):WaitForChild("Plants");
local l__Fruits__11 = l__ReplicatedStorage__2:WaitForChild("PlantGenerationModules"):WaitForChild("Fruits");
local l__Plants__12 = l__ReplicatedStorage__2:WaitForChild("PlantGenerationModules"):WaitForChild("Plants");
local l__LocalPlayer__13 = l__Players__1.LocalPlayer;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = CFrame.new(0, -0.5, 0.25);
local u8 = CFrame.new(0, -1.25, -0.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
local function u17(p9, p10) --[[ Line: 36 ]]
    if p10 and p10 > 0 then
        local v11 = p10 > 1 and 1 or p10;
        local v12 = 0;
        for _, v13 in p9:GetDescendants() do
            if v13:IsA("BasePart") then
                local v14, v15, v16 = Color3.toHSV(v13.Color);
                v13.Color = Color3.fromHSV(v14, v15 * (1 - v11 * 0.75), v16);
                v12 = v12 + 1;
            end;
        end;
    end;
end;
local u18 = l__RunService__3:IsStudio() or l__Environment__5.env == "Dev";
local function u19(...) --[[ Line: 58 ]]
    -- upvalues: u18 (copy)
    if u18 then
        print("[FruitHandle]", ...);
    end;
end;
local function u20(...) --[[ Line: 64 ]]
    -- upvalues: u18 (copy)
    if u18 then
        warn("[FruitHandle]", ...);
    end;
end;
local function u26(p21) --[[ Line: 89 ]]
    -- upvalues: u18 (copy), u20 (copy)
    local v22 = {};
    for _, v23 in p21:GetDescendants() do
        if v23:IsA("BasePart") then
            v22[v23] = v23.CanQuery;
            v23:SetAttribute("_AllowQuery", true);
            v23.CanQuery = true;
        end;
    end;
    if u18 then
        local v24 = 0;
        for v25 in v22 do
            if v25.CanQuery ~= true then
                v24 = v24 + 1;
            end;
        end;
        if v24 > 0 then
            u20(("enableModelQuery: %d part(s) in %s had CanQuery reverted! Bottom raycast will miss them."):format(v24, p21:GetFullName()));
        end;
    end;
    return v22;
end;
local function u30(p27) --[[ Line: 115 ]]
    for v28, v29 in p27 do
        if v28 and v28.Parent then
            v28:SetAttribute("_AllowQuery", nil);
            v28.CanQuery = v29;
        end;
    end;
end;
function v1.Init(_) --[[ Line: 124 ]]
    -- upvalues: l__Fruits__11 (copy), u6 (copy), l__Plants__12 (copy)
    for _, v31 in l__Fruits__11:GetChildren() do
        if v31:IsA("ModuleScript") then
            u6[`Fruit_{v31.Name}`] = require(v31);
        end;
    end;
    for _, v32 in l__Plants__12:GetChildren() do
        if v32:IsA("ModuleScript") then
            u6[`Plant_{v32.Name}`] = require(v32);
        end;
    end;
end;
function v1.Start(u33) --[[ Line: 138 ]]
    -- upvalues: l__Players__1 (copy), u2 (copy)
    for _, v34 in l__Players__1:GetPlayers() do
        u33:SetupPlayer(v34);
    end;
    l__Players__1.PlayerAdded:Connect(function(p35) --[[ Line: 143 ]]
        -- upvalues: u33 (copy)
        u33:SetupPlayer(p35);
    end);
    l__Players__1.PlayerRemoving:Connect(function(p36) --[[ Line: 147 ]]
        -- upvalues: u2 (ref), l__Players__1 (ref), u33 (copy)
        for v37 in u2 do
            local v38 = not l__Players__1:GetPlayerFromCharacter(v37.Parent) and (v37.Parent and v37.Parent:IsA("Backpack"));
            if v38 then
                v38 = l__Players__1:GetPlayerFromCharacter(v37.Parent.Parent);
            end;
            if v38 == p36 then
                u33:CleanupTool(v37);
            end;
        end;
    end);
end;
function v1.PreparePartForTool(_, p39) --[[ Line: 158 ]]
    p39.Anchored = false;
    p39.CanCollide = false;
    p39.CanQuery = false;
    p39.CanTouch = false;
    p39.Massless = true;
end;
function v1.PrepareMushroom(_, p40) --[[ Line: 166 ]]
    p40.Anchored = false;
    p40.CanCollide = true;
    p40.CanQuery = false;
    p40.CanTouch = true;
    p40.CollisionGroup = "OnlyPlayers";
    p40.AssemblyLinearVelocity = Vector3.new(0, 100, 0);
    local v41 = script.Mushroom:Clone();
    v41.Parent = p40;
    v41.Enabled = true;
    p40.Massless = true;
end;
function v1.ClearHandle(_, p42) --[[ Line: 179 ]]
    -- upvalues: u19 (copy), u4 (copy)
    u19("ClearHandle called for tool:", p42.Name);
    for _, u43 in p42:GetChildren() do
        if u43.Name == "Handle" or (u43.Name == "Build" or u43:IsA("Model")) then
            u43.Parent = nil;
            task.defer(function() --[[ Line: 185 ]]
                -- upvalues: u43 (copy)
                if u43 then
                    u43:Destroy();
                end;
            end);
        end;
    end;
    local v44 = u4[p42];
    if v44 then
        if v44.animTrack then
            v44.animTrack:Stop();
            v44.animTrack = nil;
        end;
        if v44.model and v44.model.Parent then
            v44.model:Destroy();
        end;
        if v44.handle and v44.handle.Parent then
            v44.handle:Destroy();
        end;
        u4[p42] = nil;
    end;
end;
function v1.HasHandle(_, p45) --[[ Line: 209 ]]
    -- upvalues: u4 (copy)
    local v46 = u4[p45];
    return v46 and (v46.handle and v46.handle.Parent) and true or false;
end;
function v1.GetModelMetrics(_, p47) --[[ Line: 217 ]]
    -- upvalues: u20 (copy), u19 (copy)
    local v48, v49 = p47:GetBoundingBox();
    local l__Position__14 = v48.Position;
    local v50 = (1 / 0);
    local v51 = (-1 / 0);
    for _, v52 in p47:GetDescendants() do
        if v52:IsA("BasePart") and v52.Transparency < 1 then
            local v53 = v52.Position.Y - v52.Size.Y / 2;
            local v54 = v52.Position.Y + v52.Size.Y / 2;
            if v53 >= v50 then
                v53 = v50;
            end;
            if v51 < v54 then
                v51 = v54;
                v50 = v53;
            else
                v50 = v53;
            end;
        end;
    end;
    if v50 == (1 / 0) or v51 == (-1 / 0) then
        u20(("GetModelMetrics: \'%s\' has no visible parts right now - falling back to bounding box (size %.1f x %.1f x %.1f)"):format(p47.Name, v49.X, v49.Y, v49.Z));
        v50 = l__Position__14.Y - v49.Y / 2;
        v51 = l__Position__14.Y + v49.Y / 2;
    end;
    local v55 = v51 - v50;
    local v56 = Vector3.new(l__Position__14.X, v50, l__Position__14.Z);
    local v57 = (v49.X > 8 or v55 > 8) and true or v49.Z > 8;
    u19(("GetModelMetrics \'%s\': height=%.2f bounds=(%.1f, %.1f, %.1f) oversized=%s"):format(p47.Name, v55, v49.X, v49.Y, v49.Z, (tostring(v57))));
    return v55, v56, v57;
end;
function v1.WaitForAttributes(_, u58, p59) --[[ Line: 262 ]]
    -- upvalues: u19 (copy), u20 (copy)
    local v60;
    if u58:GetAttribute("FruitName") == nil then
        v60 = false;
    else
        v60 = u58:GetAttribute("Seed") ~= nil;
    end;
    if v60 then
        return true;
    end;
    u19("Waiting for attributes to replicate on tool:", u58.Name);
    local u61 = false;
    local u62 = Instance.new("BindableEvent");
    local v64 = u58.AttributeChanged:Connect(function() --[[ Line: 283 ]]
        -- upvalues: u58 (copy), u61 (ref), u62 (copy)
        local v63;
        if u58:GetAttribute("FruitName") == nil then
            v63 = false;
        else
            v63 = u58:GetAttribute("Seed") ~= nil;
        end;
        if v63 then
            u61 = true;
            u62:Fire();
        end;
    end);
    local v65;
    if u58:GetAttribute("FruitName") == nil then
        v65 = false;
    else
        v65 = u58:GetAttribute("Seed") ~= nil;
    end;
    if v65 then
        u61 = true;
        v64:Disconnect();
        u62:Destroy();
        return true;
    end;
    task.delay(p59, function() --[[ Line: 298 ]]
        -- upvalues: u61 (ref), u62 (copy)
        if not u61 then
            u62:Fire();
        end;
    end);
    u62.Event:Wait();
    v64:Disconnect();
    u62:Destroy();
    if not u61 then
        u20("TIMEOUT waiting for attributes on tool:", u58.Name);
    end;
    return u61;
end;
function v1.SpawnHandle(p66, p67, p68) --[[ Line: 315 ]]
    -- upvalues: u5 (copy), l__Players__1 (copy), l__LocalPlayer__13 (copy), u20 (copy), l__Fruits__9 (copy), l__Plants__10 (copy), u6 (copy), l__MutationController__6 (copy), u17 (copy), u19 (copy), u26 (copy), u30 (copy), l__Handles__7 (copy), u4 (copy), u7 (copy), l__Hold_Above__8 (copy), u8 (copy)
    if u5[p67] then
        return;
    end;
    u5[p67] = true;
    p66:ClearHandle(p67);
    local v69 = l__Players__1:GetPlayerFromCharacter(p68) == l__LocalPlayer__13;
    if not p66:WaitForAttributes(p67, 5) then
        u20("SpawnHandle ABORTED - attributes never replicated. Tool:", p67.Name);
        u5[p67] = nil;
        return;
    end;
    local v70 = p67:GetAttribute("FruitName");
    local v71 = p67:GetAttribute("Seed");
    local v72 = p67:GetAttribute("SizeMultiplier") or 1;
    local _ = p67:GetAttribute("OvertimeGrowth") or 1;
    local v73 = p67:GetAttribute("Mutation");
    local v74 = p67:GetAttribute("DecayAlpha");
    if not (v70 and v71) then
        u5[p67] = nil;
        return;
    end;
    local v75 = l__Fruits__9:FindFirstChild(v70) or l__Plants__10:FindFirstChild(v70);
    if not v75 then
        u20("SpawnHandle: no asset template for", v70);
        u5[p67] = nil;
        return;
    end;
    local v76 = v75.Parent.Name == l__Fruits__9.Name;
    local v77 = u6[v76 and `Fruit_{v70}` or `Plant_{v70}`];
    if not v77 then
        u20("SpawnHandle: no generation module for", v70);
        u5[p67] = nil;
        return;
    end;
    local v78 = p68:FindFirstChild("Right Arm") or p68:FindFirstChild("RightHand");
    if not v78 then
        u20("SpawnHandle: character has no Right Arm / RightHand");
        u5[p67] = nil;
        return;
    end;
    local v79 = v75:Clone();
    v79:SetAttribute("MaxAge", 100000);
    v79:SetAttribute("Age", 100000);
    if v73 and v73 ~= "" then
        v79:SetAttribute("Mutation", v73);
    end;
    v77[v76 and "InitFruit" or "InitPlant"](v79, v71, v72);
    local v80 = 0;
    repeat
        v80 = v80 + task.wait();
    until v79:HasTag("InitializationComplete") or v80 > 5;
    if v80 > 5 then
        u20("SpawnHandle: initialization timed out for", v70, "- metrics below may be measured mid-init");
    end;
    v77[v76 and "BeginFruitGrowth" or "BeginPlantGrowth"](v79);
    local v81 = v79:FindFirstChild("HarvestPrompt", true);
    if v81 and v81:IsA("ProximityPrompt") then
        v81:Destroy();
    end;
    l__MutationController__6:ApplyMutation(v79);
    if not v73 or v73 == "" then
        u17(v79, v74);
    end;
    local v82, _, v83 = p66:GetModelMetrics(v79);
    local l__PrimaryPart__15 = v79.PrimaryPart;
    if not l__PrimaryPart__15 then
        u20("SpawnHandle: fruit has no PrimaryPart after init:", v70);
        v79:Destroy();
        u5[p67] = nil;
        return;
    end;
    local v84 = Instance.new("Part");
    v84.Name = "FruitAnchor";
    v84.Size = Vector3.new(0.01, 0.01, 0.01);
    v84.Transparency = 1;
    v84.CanCollide = false;
    v84.CanQuery = false;
    v84.CanTouch = false;
    v84.Massless = true;
    local v85 = v79:GetAttribute("FlipWhenHeld") == true and true or ({
        Strawberry = true
    })[v70] == true;
    if v85 then
        local v86 = v79:GetBoundingBox();
        local v87 = CFrame.Angles(3.141592653589793, 0, 0);
        for _, v88 in v79:GetDescendants() do
            if v88:IsA("BasePart") then
                local v89 = v86:ToObjectSpace(v88.CFrame);
                v88.CFrame = v86 * v87 * v89;
            end;
        end;
        u19(("\'%s\' flipped 180 around bounding-box center BEFORE bottom detection"):format(v70));
    end;
    local v90 = (1 / 0);
    local v91 = nil;
    for _, v92 in v79:GetDescendants() do
        if v92:IsA("BasePart") and v92.Transparency < 1 then
            local v93 = v92.Position.Y - v92.Size.Y / 2;
            if v93 < v90 then
                v91 = v92;
                v90 = v93;
            end;
        end;
    end;
    if v90 == (1 / 0) then
        v90 = l__PrimaryPart__15.Position.Y - l__PrimaryPart__15.Size.Y / 2;
        u20("SpawnHandle: no visible parts when finding bottom of", v70, "- using PrimaryPart fallback Y =", v90);
    end;
    v79.Parent = workspace;
    local v94 = u26(v79);
    local v95 = RaycastParams.new();
    v95.FilterDescendantsInstances = { v79 };
    v95.FilterType = Enum.RaycastFilterType.Include;
    local v96 = CFrame.new(l__PrimaryPart__15.Position.X, v90, l__PrimaryPart__15.Position.Z);
    local v97 = Vector3.new(l__PrimaryPart__15.Position.X, l__PrimaryPart__15.Position.Y - 100, l__PrimaryPart__15.Position.Z);
    for _ = 1, 20 do
        local v98 = workspace:Raycast(v97, Vector3.new(0, 300, 0), v95);
        if not v98 then
            u20(("SpawnHandle: bottom raycast MISSED for \'%s\' - using iterated lowestY=%.2f (part: %s). If this is frequent, check the asset\'s CanQuery/Transparency."):format(v70, v90, v91 and v91.Name or "?"));
            break;
        end;
        if v98.Instance.Transparency < 1 then
            v96 = CFrame.new(v98.Position);
            u19(("SpawnHandle: bottom raycast hit \'%s\' at Y=%.2f for \'%s\'%s"):format(v98.Instance.Name, v98.Position.Y, v70, v85 and " (post-flip geometry)" or ""));
            break;
        end;
        v97 = Vector3.new(v97.X, v98.Position.Y + 0.01, v97.Z);
    end;
    u30(v94);
    v84.CFrame = v96 * CFrame.new(0, 0.5, 0);
    v84.Parent = v79;
    local v99 = Instance.new("Part");
    v99.Transparency = 1;
    v99.Anchored = true;
    v99.CanCollide = false;
    v99.Size = Vector3.new(1, 1, 1);
    v99.Parent = game.Workspace.Temporary;
    local l__Parent__16 = p67.Parent;
    if l__Parent__16 then
        l__Parent__16 = p67.Parent:FindFirstChild("HumanoidRootPart");
    end;
    local v100;
    if l__Parent__16 then
        v100 = l__Parent__16.CFrame or v96;
    else
        v100 = v96;
    end;
    v99.CFrame = v100;
    local l__Default__17 = game.SoundService.SFX.FruitSFX.Default;
    if v73 and v73 ~= "" then
        for _, v101 in pairs(game.SoundService.SFX.FruitSFX:GetChildren()) do
            if v101.Name == v73 then
                l__Default__17 = v101;
                break;
            end;
        end;
    end;
    local v102 = l__Default__17:Clone();
    v102.Parent = v99;
    v102.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    if v83 then
        v102.Volume = v102.Volume * 1.75;
    end;
    v102.Playing = true;
    game.Debris:AddItem(v99, v102.TimeLength * v102.PlaybackSpeed);
    v79.PrimaryPart = v84;
    for _, v103 in v79:GetDescendants() do
        if v103:IsA("BasePart") then
            if v103:HasTag("MuhsroomTop") then
                p66:PrepareMushroom(v103);
            else
                p66:PreparePartForTool(v103);
            end;
        end;
    end;
    local v104 = v79:GetAttribute("HeldYOffset");
    local v105 = type(v104) ~= "number" and (({
        ["Moon Bloom"] = 1,
        ["Dragon\'s Breath"] = 1,
        Bamboo = 3
    })[v70] or 0) or v104;
    for _, v106 in v79:GetDescendants() do
        if v106:IsA("BasePart") and v106 ~= v84 then
            local v107 = Instance.new("WeldConstraint");
            v107.Part0 = v84;
            v107.Part1 = v106;
            v107.Parent = v106;
        end;
    end;
    v79.Name = "Build";
    v79.Parent = l__Handles__7;
    u4[p67] = {
        handle = v84,
        model = v79
    };
    local v108 = Instance.new("Part");
    v108.Name = "Handle";
    v108.Size = Vector3.new(1, 1, 1);
    v108.Transparency = 1;
    v108.CanCollide = false;
    v108.CanQuery = false;
    v108.CanTouch = false;
    v108.Massless = true;
    v108.Parent = p67;
    local v109 = Instance.new("WeldConstraint");
    v109.Parent = v108;
    v109.Part0 = v108;
    v109.Part1 = v78;
    if v69 then
        p67.Grip = u7;
    end;
    if v83 then
        u19(("\'%s\' is OVERSIZED (height %.2f vs threshold %d) -> hold-above"):format(v70, v82, 8));
        v84.CFrame = v96 * CFrame.new(0, -0.5, 0);
        local v110 = p68:FindFirstChild("Head");
        if v110 then
            local v111 = p68:FindFirstChildOfClass("Humanoid");
            if v111 then
                local u112 = v111:FindFirstChildOfClass("Animator");
                if u112 and l__Hold_Above__8 then
                    local v113, v114 = pcall(function() --[[ Line: 637 ]]
                        -- upvalues: u112 (copy), l__Hold_Above__8 (ref)
                        return u112:LoadAnimation(l__Hold_Above__8);
                    end);
                    if v113 and v114 then
                        v114.Looped = true;
                        v114.Priority = Enum.AnimationPriority.Action4;
                        v114:Play();
                        u4[p67].animTrack = v114;
                    else
                        u20("Hold-above animation failed to load:", v114);
                    end;
                end;
            end;
            v84.CFrame = v110.CFrame * CFrame.new(0, v105 + 1, 0);
            local v115 = Instance.new("WeldConstraint");
            v115.Part0 = v84;
            v115.Part1 = v110;
            v115.Parent = v84;
        else
            u20("Oversized fruit but no Head found - falling back to arm hold");
            v84.CFrame = v78.CFrame * u8;
            local v116 = Instance.new("WeldConstraint");
            v116.Part0 = v84;
            v116.Part1 = v78;
            v116.Parent = v84;
        end;
    else
        u19(("\'%s\' is normal-sized (height %.2f) -> arm hold"):format(v70, v82));
        v84.CFrame = v78.CFrame * u8;
        local v117 = Instance.new("WeldConstraint");
        v117.Part0 = v84;
        v117.Part1 = v78;
        v117.Parent = v84;
    end;
    u19("SpawnHandle complete for:", p67.Name);
    u5[p67] = nil;
    if p67.Parent ~= p68 then
        p66:ClearHandle(p67);
    end;
end;
function v1.UpdateToolState(p118, p119) --[[ Line: 690 ]]
    -- upvalues: u5 (copy), u3 (copy)
    if u5[p119] then
    else
        local v120 = u3[p119];
        if v120 then
            local v121 = p119.Parent == v120;
            local v122 = p118:HasHandle(p119);
            if v121 and not v122 then
                p118:SpawnHandle(p119, v120);
            else
                if not v121 and v122 then
                    p118:ClearHandle(p119);
                end;
            end;
        end;
    end;
end;
function v1.DisconnectTool(_, p123) --[[ Line: 706 ]]
    -- upvalues: u2 (copy), u3 (copy), u5 (copy)
    local v124 = u2[p123];
    if v124 then
        for _, v125 in v124 do
            v125:Disconnect();
        end;
        u2[p123] = nil;
    end;
    u3[p123] = nil;
    u5[p123] = nil;
end;
function v1.CleanupTool(p126, p127) --[[ Line: 718 ]]
    p126:ClearHandle(p127);
    p126:DisconnectTool(p127);
end;
function v1.IsTrackedTool(_, p128) --[[ Line: 723 ]]
    return p128:GetAttribute("HarvestedFruit") == true;
end;
function v1.SetupTool(u129, u130, p131) --[[ Line: 727 ]]
    -- upvalues: u3 (copy), u2 (copy)
    u129:DisconnectTool(u130);
    local v132 = {};
    u3[u130] = p131;
    local v133 = u130:GetPropertyChangedSignal("Parent");
    table.insert(v132, v133:Connect(function() --[[ Line: 733 ]]
        -- upvalues: u130 (copy), u129 (copy), u3 (ref)
        task.defer(function() --[[ Line: 734 ]]
            -- upvalues: u130 (ref), u129 (ref), u3 (ref)
            if u130 then
                if u130.Parent then
                    if u3[u130] then
                        u129:UpdateToolState(u130);
                    end;
                else
                    u129:ClearHandle(u130);
                end;
            end;
        end);
    end));
    table.insert(v132, u130.Destroying:Connect(function() --[[ Line: 748 ]]
        -- upvalues: u129 (copy), u130 (copy)
        u129:CleanupTool(u130);
    end));
    u2[u130] = v132;
    task.defer(function() --[[ Line: 754 ]]
        -- upvalues: u130 (copy), u3 (ref), u129 (copy)
        if u130 and u3[u130] then
            u129:UpdateToolState(u130);
        end;
    end);
end;
function v1.DisconnectAllFruitTools(p134) --[[ Line: 761 ]]
    -- upvalues: u2 (copy)
    for v135 in u2 do
        p134:DisconnectTool(v135);
    end;
end;
function v1.CleanupAllToolsForCharacter(p136, p137) --[[ Line: 767 ]]
    -- upvalues: u3 (copy), l__Handles__7 (copy)
    for v138, v139 in u3 do
        if v139 == p137 then
            p136:CleanupTool(v138);
        end;
    end;
    for _, v140 in l__Handles__7:GetChildren() do
        if v140.Name == "Build" and v140:IsA("Model") then
            local l__PrimaryPart__18 = v140.PrimaryPart;
            if l__PrimaryPart__18 then
                for _, v141 in l__PrimaryPart__18:GetDescendants() do
                    if v141:IsA("WeldConstraint") then
                        local l__Part1__19 = v141.Part1;
                        if l__Part1__19 and l__Part1__19:IsDescendantOf(p137) then
                            v140:Destroy();
                            break;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function v1.SetupCharacter(u142, u143) --[[ Line: 794 ]]
    -- upvalues: u4 (copy), l__Players__1 (copy)
    u143.ChildRemoved:Connect(function(p144) --[[ Line: 797 ]]
        -- upvalues: u4 (ref), u142 (copy)
        if p144:IsA("Tool") and u4[p144] then
            u142:CleanupTool(p144);
        end;
    end);
    u143.Destroying:Connect(function() --[[ Line: 806 ]]
        -- upvalues: u142 (copy), u143 (copy)
        u142:CleanupAllToolsForCharacter(u143);
    end);
    task.defer(function() --[[ Line: 810 ]]
        -- upvalues: u143 (copy), u142 (copy), l__Players__1 (ref)
        if u143 and u143.Parent then
            for _, v145 in u143:GetChildren() do
                if v145:IsA("Tool") then
                    if u142:IsTrackedTool(v145) then
                        u142:SetupTool(v145, u143);
                    else
                        u142:ListenForTrackedAttribute(v145, u143);
                    end;
                end;
            end;
            local v146 = l__Players__1:GetPlayerFromCharacter(u143);
            if v146 and v146.Backpack then
                for _, v147 in v146.Backpack:GetChildren() do
                    if v147:IsA("Tool") then
                        if u142:IsTrackedTool(v147) then
                            u142:SetupTool(v147, u143);
                        else
                            u142:ListenForTrackedAttribute(v147, u143);
                        end;
                    end;
                end;
            end;
            u143.ChildAdded:Connect(function(u148) --[[ Line: 839 ]]
                -- upvalues: u143 (ref), u142 (ref)
                if u148:IsA("Tool") then
                    task.defer(function() --[[ Line: 841 ]]
                        -- upvalues: u148 (copy), u143 (ref), u142 (ref)
                        if u148 and (u148.Parent and (u143 and u143.Parent)) then
                            if u142:IsTrackedTool(u148) then
                                u142:SetupTool(u148, u143);
                            else
                                u142:ListenForTrackedAttribute(u148, u143);
                            end;
                        end;
                    end);
                end;
            end);
        end;
    end);
end;
function v1.ListenForTrackedAttribute(u149, u150, u151) --[[ Line: 857 ]]
    -- upvalues: u2 (copy)
    if u2[u150] then
    else
        local u152 = nil;
        u152 = u150.AttributeChanged:Connect(function(p153) --[[ Line: 862 ]]
            -- upvalues: u149 (copy), u150 (copy), u152 (ref), u151 (copy)
            if p153 == "HarvestedFruit" and u149:IsTrackedTool(u150) then
                u152:Disconnect();
                task.defer(function() --[[ Line: 865 ]]
                    -- upvalues: u150 (ref), u151 (ref), u149 (ref)
                    if u150 and (u150.Parent and (u151 and u151.Parent)) then
                        u149:SetupTool(u150, u151);
                    end;
                end);
            end;
        end);
        u150.Destroying:Once(function() --[[ Line: 874 ]]
            -- upvalues: u152 (ref)
            if u152.Connected then
                u152:Disconnect();
            end;
        end);
        if u149:IsTrackedTool(u150) then
            u152:Disconnect();
            task.defer(function() --[[ Line: 883 ]]
                -- upvalues: u150 (copy), u151 (copy), u149 (copy)
                if u150 and (u150.Parent and (u151 and u151.Parent)) then
                    u149:SetupTool(u150, u151);
                end;
            end);
        end;
    end;
end;
function v1.SetupPlayer(u154, u155) --[[ Line: 891 ]]
    -- upvalues: l__BackpackListener__4 (copy)
    if u155.Character then
        u154:SetupCharacter(u155.Character);
    end;
    u155.CharacterAdded:Connect(function(p156) --[[ Line: 896 ]]
        -- upvalues: u154 (copy)
        u154:SetupCharacter(p156);
    end);
    l__BackpackListener__4.bind(u155, function(u157) --[[ Line: 903 ]]
        -- upvalues: u155 (copy), u154 (copy)
        if u157:IsA("Tool") then
            task.defer(function() --[[ Line: 905 ]]
                -- upvalues: u155 (ref), u157 (copy), u154 (ref)
                local l__Character__20 = u155.Character;
                if u157 and (u157.Parent and (l__Character__20 and l__Character__20.Parent)) then
                    if u154:IsTrackedTool(u157) then
                        u154:SetupTool(u157, l__Character__20);
                    else
                        u154:ListenForTrackedAttribute(u157, l__Character__20);
                    end;
                end;
            end);
        end;
    end);
end;
return v1;