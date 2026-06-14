-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__TweenService__4 = game:GetService("TweenService");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__Networking__6 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__CatmullRomSpline__7 = require(l__ReplicatedStorage__2.ClientModules.CatmullRomSpline);
local l__CCDIKController__8 = require(l__ReplicatedStorage__2.ClientModules.CCDIKController);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Exclude;
local function u8(p2, p3) --[[ Line: 48 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u1 (copy)
    local v4 = {};
    if l__LocalPlayer__9.Character then
        table.insert(v4, l__LocalPlayer__9.Character);
    end;
    if p3 then
        for _, v5 in game.CollectionService:GetTagged("Character") do
            table.insert(v4, v5);
        end;
    end;
    local v6 = 10;
    while true do
        u1.FilterDescendantsInstances = v4;
        local v7 = workspace:Raycast(p2.Origin, p2.Direction * 40, u1);
        if not v7 then
            break;
        end;
        local l__Instance__10 = v7.Instance;
        if l__Instance__10.Transparency < 1 and (l__Instance__10.CanQuery and not l__Instance__10:IsDescendantOf(l__LocalPlayer__9.Character)) then
            return v7.Position, l__Instance__10, v7.Normal;
        end;
        table.insert(v4, l__Instance__10);
        v6 = v6 - 1;
        if v6 == 0 then
            return;
        end;
    end;
    return p2.Origin + p2.Direction * 40;
end;
local function u14(p9, p10) --[[ Line: 86 ]]
    local v11 = Random.new();
    local v12 = p9.Unit:Dot(Vector3.new(0, 1, 0));
    local v13 = math.abs(v12) > 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0);
    local l__Unit__11 = p9.Unit:Cross(v13).Unit;
    local l__Unit__12 = p9.Unit:Cross(l__Unit__11).Unit;
    return l__Unit__11 * v11:NextNumber(-p10, p10) + l__Unit__12 * v11:NextNumber(-p10, p10);
end;
local l__Vine__13 = game.ReplicatedStorage.Assets.Vine;
local function u33(p15, p16, u17) --[[ Line: 97 ]]
    -- upvalues: l__RunService__3 (copy), l__Vine__13 (copy), l__TweenService__4 (copy)
    local v18 = math.round((p15 - p16).Magnitude / 2) + 1;
    local u19 = Instance.new("Part");
    u19.Size = Vector3.new(0.01, 0.01, 0.01);
    u19.Anchored = true;
    u19.CanCollide = false;
    u19.CanQuery = false;
    u19.CanTouch = false;
    u19.Massless = true;
    u19.CastShadow = false;
    u19.EnableFluidForces = false;
    u19.MaterialVariant = "Weld 2x2 Plastic";
    u19.Color = Color3.fromRGB(44, 101, 29);
    u19.Parent = u17;
    local u20 = 0;
    local u21 = 0.1 + v18 * 0.005;
    local l__PrimaryPart__14 = u17.PrimaryPart;
    local l__Z__15 = l__PrimaryPart__14.Size.Z;
    task.spawn(function() --[[ Line: 122 ]]
        -- upvalues: u20 (ref), u21 (copy), l__RunService__3 (ref), l__Z__15 (copy), l__PrimaryPart__14 (copy), u19 (copy), u17 (copy)
        while u20 < u21 do
            u20 = u20 + l__RunService__3.Heartbeat:Wait();
            local v22 = u20 / u21;
            local v23 = v22 * l__Z__15;
            local v24 = CFrame.new(0, 0, l__Z__15 / 2 - v23 / 2);
            u19.CFrame = l__PrimaryPart__14.CFrame * v24;
            u19.Size = Vector3.new(0.7 * v22, 0.7 * v22, v23);
        end;
        u19.CFrame = l__PrimaryPart__14.CFrame;
        local v25 = Instance.new("WeldConstraint");
        u19.Anchored = false;
        v25.Part0 = u19;
        v25.Part1 = u17.PrimaryPart;
        v25.Parent = u19;
    end);
    for v26 = 0, v18 do
        local v27 = v26 / math.round(v18);
        p15:Lerp(p16, v27);
        local v28 = l__Vine__13:Clone();
        local v29 = v28.Size * Random.new():NextNumber(0.8, 1.3);
        v28.Size = Vector3.new(0, 0, 0);
        v28.Parent = u17;
        local l__PrimaryPart__16 = u17.PrimaryPart;
        local l__Z__17 = l__PrimaryPart__16.Size.Z;
        local v30 = CFrame.new(0, 0, l__Z__17 / 2 - v27 * l__Z__17);
        local v31 = l__PrimaryPart__16.CFrame * v30;
        v28.CFrame = CFrame.new(v31.Position, v31.Position + Random.new():NextUnitVector());
        l__TweenService__4:Create(v28, TweenInfo.new(0.3), {
            Size = v29
        }):Play();
        l__TweenService__4:Create(v28.SurfaceAppearance, TweenInfo.new(0.35), {
            Color = Color3.fromRGB(44, 101, 29)
        }):Play();
        local v32 = Instance.new("WeldConstraint");
        v32.Part0 = v28;
        v32.Part1 = u17.PrimaryPart;
        v32.Parent = v28;
        v28.Anchored = false;
        v28.Massless = true;
        v28.CanCollide = false;
        v28.CanQuery = false;
        v28.CanTouch = false;
        v28.CastShadow = false;
        v28.EnableFluidForces = false;
        task.wait(0.005);
    end;
end;
local function u42(p34, p35) --[[ Line: 195 ]]
    -- upvalues: u14 (copy), l__CatmullRomSpline__7 (copy)
    local v36 = p35 - p34;
    local l__Magnitude__18 = v36.Magnitude;
    local v37 = p34 + v36 * 0.33 + u14(v36, 3) + Vector3.new(0, 5, 0);
    local v38 = p34 + v36 * 0.66 + u14(v36, 3) + Vector3.new(0, 4, 0);
    local v39 = p34 - v36.Unit * (l__Magnitude__18 * 0.15) + u14(v36, 0.8999999999999999);
    local v40 = p35 + v36.Unit * (l__Magnitude__18 * 0.15) + u14(v36, 0.8999999999999999);
    local v41 = l__CatmullRomSpline__7.new({
        v39,
        p34,
        v37,
        v38
    });
    v41:AddPoint(p35);
    v41:AddPoint(v40);
    return v41;
end;
local function u74(p43, p44, p45) --[[ Line: 213 ]]
    -- upvalues: u42 (copy), u33 (copy)
    local v46 = u42(p43, p44);
    local v47 = Instance.new("Model");
    v47.Name = "VineGroup";
    v47.Parent = workspace.Temporary;
    local v48 = {};
    local v49 = {};
    local v50 = {};
    local v51 = 0;
    for v52 = 1, 6 do
        local v53 = Instance.new("Model");
        v53.Name = "Segment_" .. v52;
        v53.Parent = v47;
        v48[v52] = v53;
        local v54 = (v52 - 1) / 6;
        local v55 = v52 / 6;
        local v56 = v46:CalculatePositionAt(v54);
        local v57 = v46:CalculatePositionAt(v55);
        v49[v52] = v56;
        if v52 == 6 then
            v49[v52 + 1] = v57;
        end;
        table.insert(v50, {
            SegStart = v56,
            SegEnd = v57
        });
        local l__Magnitude__19 = (v57 - v56).Magnitude;
        local v58 = (v56 + v57) / 2;
        local v59 = Instance.new("Part");
        v59.Name = "PrimaryPart";
        v59.Anchored = false;
        v59.CanCollide = false;
        v59.CanQuery = false;
        v59.CanTouch = false;
        v59.Massless = true;
        v59.CastShadow = false;
        v59.EnableFluidForces = false;
        v59.Transparency = 1;
        v59.Size = Vector3.new(1, 1, l__Magnitude__19);
        v59.CFrame = CFrame.lookAt(v58, v57);
        v59.Parent = v53;
        v53.PrimaryPart = v59;
        v51 = v51 + l__Magnitude__19;
    end;
    local v60 = {};
    local v61 = Instance.new("Motor6D");
    v61.Name = "RootJoint";
    v61.Part0 = p45;
    v61.Part1 = v48[1].PrimaryPart;
    local v62 = CFrame.new(v49[1]);
    v61.C0 = p45.CFrame:Inverse() * v62;
    v61.C1 = v48[1].PrimaryPart.CFrame:Inverse() * v62;
    v61.Parent = p45;
    v60[1] = v61;
    for v63 = 1, 5 do
        local l__PrimaryPart__20 = v48[v63].PrimaryPart;
        local l__PrimaryPart__21 = v48[v63 + 1].PrimaryPart;
        local v64 = CFrame.new(v49[v63 + 1]);
        local v65 = Instance.new("Motor6D");
        v65.Name = "Joint_" .. v63;
        v65.Part0 = l__PrimaryPart__20;
        v65.Part1 = l__PrimaryPart__21;
        v65.C0 = l__PrimaryPart__20.CFrame:Inverse() * v64;
        v65.C1 = l__PrimaryPart__21.CFrame:Inverse() * v64;
        v65.Parent = l__PrimaryPart__20;
        v60[v63 + 1] = v65;
    end;
    for _, v66 in v60 do
        local v67 = Instance.new("Attachment");
        v67.Name = v66.Part0.Name .. "AxisAttachment";
        v67.CFrame = v66.C0;
        v67.Parent = v66.Part0;
        local v68 = Instance.new("Attachment");
        v68.Name = v66.Part0.Name .. "JointAttachment";
        v68.CFrame = v66.C1;
        v68.Parent = v66.Part1;
    end;
    local l__PrimaryPart__22 = v48[6].PrimaryPart;
    local v69 = Instance.new("Attachment");
    v69.Name = "Target";
    v69.CFrame = CFrame.new(0, 0, -l__PrimaryPart__22.Size.Z / 2);
    v69.Parent = l__PrimaryPart__22;
    for _, v70 in v48 do
        v70.PrimaryPart.Anchored = false;
    end;
    for v71, u72 in v50 do
        local u73 = v48[v71];
        task.spawn(function() --[[ Line: 333 ]]
            -- upvalues: u33 (ref), u72 (copy), u73 (copy)
            u33(u72.SegStart, u72.SegEnd, u73);
        end);
    end;
    return v48, v60, v51, v47;
end;
local function u115(p75, p76) --[[ Line: 342 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__Networking__6 (copy), u74 (copy), l__Players__1 (copy), l__CCDIKController__8 (copy), l__UserInputService__5 (copy), u8 (copy), l__RunService__3 (copy), l__TweenService__4 (copy)
    local l__Character__23 = p75.Character;
    if not l__Character__23 then
        return;
    end;
    local v77 = nil;
    for _, v78 in l__Character__23:GetChildren() do
        if v78:IsA("Tool") and (v78:HasTag("VineWrapper") or (v78:GetAttribute("VineWrapper") or v78.Name == "Vine Wrapper")) then
            v77 = v78;
            break;
        end;
    end;
    if not v77 then
        return;
    end;
    local v79 = v77:FindFirstChild("Handle");
    if not (v79 and v79:FindFirstChild("VineEmitter")) then
        return;
    end;
    local v80 = game.SoundService.SFX["Vine Cast"]:Clone();
    v80.Parent = v77.Handle;
    v80:Play();
    game.Debris:AddItem(v80, 3);
    local l__VineEmitter__24 = v77.Handle.VineEmitter;
    if p75 == l__LocalPlayer__9 then
        l__Networking__6.VineWrapper.Activate:Fire(p76);
    end;
    local v81, v82, v83, v84 = u74(l__VineEmitter__24.Position, p76, l__VineEmitter__24);
    local v85 = nil;
    if p75 == l__LocalPlayer__9 then
        local v86 = OverlapParams.new();
        v86.FilterDescendantsInstances = game.CollectionService:GetTagged("Character");
        v86.FilterType = Enum.RaycastFilterType.Whitelist;
        local v87 = workspace:GetPartBoundsInRadius(p76, 12, v86);
        if #v87 > 0 then
            for _, v88 in v87 do
                if v88.Parent ~= l__Character__23 and (v88.Parent and v88.Parent:HasTag("Character")) then
                    local v89 = l__Players__1:GetPlayerFromCharacter(v88.Parent);
                    if not (v89 and (v89:GetAttribute("InSafeZone") or v89:GetAttribute("IsInOwnGarden"))) then
                        v85 = v88.Parent;
                        break;
                    end;
                end;
            end;
        end;
        if v85 then
            l__Networking__6.VineWrapper.AssignTarget:Fire(v85, v83);
        end;
    else
        local v90 = tick();
        repeat
            task.wait();
            v85 = v77.Target.Value;
        until v85 or tick() - v90 > 2;
    end;
    local v91 = {};
    for _, v92 in v82 do
        v91[v92] = {
            ConstraintType = "BallSocketConstraint",
            UpperAngle = 35,
            TwistLimitsEnabled = false
        };
    end;
    local v93 = l__CCDIKController__8.new(v82, v91);
    v93.LerpMode = false;
    v93.ConstantLerpSpeed = false;
    v93.AngularSpeed = 12.566370614359172;
    v93.UseLastMotor = false;
    tick();
    local v94 = 0;
    local v95 = p75 ~= l__LocalPlayer__9;
    local v96 = 0;
    v80:Stop();
    local v97 = game.SoundService.SFX.VineStrike:Clone();
    v97.Parent = v77.Handle;
    v97:Play();
    game.Debris:AddItem(v97, 3);
    if v85 then
        game.Debris:AddItem(v97, 3);
        local v98 = p76;
        local v99 = v98;
        local v100 = v98;
        v98 = v99;
        v100 = v99;
        while v96 < 7.5 and (v85 and (l__Character__23:FindFirstChild("HumanoidRootPart") and (v77 and (v77:IsDescendantOf(workspace) and v77:GetAttribute("Active") == true)))) do
            local v101 = game:GetService("RunService").Heartbeat:Wait();
            v96 = v96 + v101;
            if p75 == l__LocalPlayer__9 then
                local v102 = l__UserInputService__5:GetMouseLocation();
                local v103, _, v104 = u8(workspace.CurrentCamera:ViewportPointToRay(v102.X, v102.Y), true);
                local v105 = v103 + (v104 or Vector3.new(0, 0.3, 0)) * 8;
                local v106 = l__Character__23:FindFirstChild("HumanoidRootPart");
                local v107;
                if v106 then
                    v107 = v106:FindFirstChild("VineTarget");
                else
                    v107 = v106;
                end;
                if v107 and v107:IsA("Attachment") then
                    local l__Position__25 = v106.Position;
                    if v83 < (v105 - l__Position__25).Magnitude then
                        v105 = l__Position__25 + (v105 - l__Position__25).Unit * v83;
                    end;
                    v98 = v98:Lerp(v105, 1 - math.exp(-18 * v101));
                    v107.WorldCFrame = CFrame.new(v98, l__Position__25);
                end;
            end;
            if v85 and v85:FindFirstChild("HumanoidRootPart") then
                v99 = v85.HumanoidRootPart.Position;
            end;
            local v108;
            if v95 then
                v108 = tick();
                if v108 - v94 >= 0.03333333333333333 then
                    if (v99 - p76).Magnitude ^ 2 > 0.01 or v94 == 0 then
                        v93:CCDIKIterateOnce(v99, 0, v108 - v94);
                        p76 = v99;
                    end;
                else
                    v108 = v94;
                end;
            else
                v93:CCDIKIterateUntil(v99, 0.5, 3, v101);
                v108 = v94;
                p76 = v99;
            end;
            v94 = v108;
        end;
    elseif p75 == l__LocalPlayer__9 then
        local v109 = tick();
        while tick() - v109 < 0.3 and (v77 and (v77:IsDescendantOf(workspace) and v77:GetAttribute("Active") == true)) do
            l__RunService__3.Heartbeat:Wait();
        end;
    end;
    v77:SetAttribute("Active", false);
    local v110 = Instance.new("Attachment");
    v110.Position = v84:GetPivot().Position;
    local v111 = game.SoundService.SFX.VineCrumble:Clone();
    v111.Parent = v110;
    v111:Play();
    v110.Parent = workspace.Terrain;
    game.Debris:AddItem(v110, 3);
    for _, u112 in v81 do
        u112.PrimaryPart.Anchored = true;
        task.spawn(function() --[[ Line: 544 ]]
            -- upvalues: u112 (copy), l__TweenService__4 (ref)
            for _, v113 in u112:GetChildren() do
                if v113 ~= u112.PrimaryPart then
                    if v113:IsA("MeshPart") then
                        l__TweenService__4:Create(v113, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = Vector3.new(0, 0, 0),
                            CFrame = CFrame.new(v113.Position, v113.Position + Random.new():NextUnitVector())
                        }):Play();
                        l__TweenService__4:Create(v113.SurfaceAppearance, TweenInfo.new(0.2), {
                            Color = Color3.fromRGB(71, 35, 14)
                        }):Play();
                    elseif v113:IsA("BasePart") then
                        l__TweenService__4:Create(v113, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = Vector3.new(0, 0, 0)
                        }):Play();
                    end;
                    task.wait(0.005);
                end;
            end;
            task.delay(0.2, function() --[[ Line: 565 ]]
                -- upvalues: u112 (ref)
                u112:Destroy();
            end);
        end);
    end;
    for _, v114 in v82 do
        v114:Destroy();
    end;
    game.Debris:AddItem(v84, 5);
end;
local u116 = game.MaterialService.ToolMaterials.GlowWeldTemplate:Clone();
u116.Name = "WeldGlow_Player_Vine";
u116.Parent = game.MaterialService.ToolMaterials;
local function v153(u117) --[[ Line: 585 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__UserInputService__5 (copy), u8 (copy), l__ReplicatedStorage__2 (copy), u116 (copy), u115 (copy)
    if u117.Parent == l__LocalPlayer__9.Backpack or u117.Parent == l__LocalPlayer__9.Character then
        local u118 = false;
        local u119 = 0;
        local function v121() --[[ Line: 596 ]]
            -- upvalues: u118 (ref), u117 (copy)
            u118 = true;
            for _, v120 in u117.Handle.Vines:GetChildren() do
                v120.MaterialVariant = "WeldGlow_Player_Vine";
            end;
        end;
        local function v122() --[[ Line: 605 ]]
            -- upvalues: u118 (ref)
            u118 = false;
        end;
        local function v148() --[[ Line: 611 ]]
            -- upvalues: l__UserInputService__5 (ref), u119 (ref), u117 (copy), l__LocalPlayer__9 (ref), u8 (ref), l__ReplicatedStorage__2 (ref), u116 (ref), u115 (ref)
            local v123 = l__UserInputService__5:GetMouseLocation();
            local v124 = workspace.CurrentCamera:ViewportPointToRay(v123.X, v123.Y);
            if tick() - u119 < 2 then
                return;
            end;
            if u117:GetAttribute("Active") == true then
                return;
            end;
            local v125 = u117:GetAttribute("CooldownUntil");
            if v125 and workspace:GetServerTimeNow() < v125 then
                return;
            end;
            if l__LocalPlayer__9.Character and l__LocalPlayer__9.Character:GetAttribute("VineWrapped") then
                return;
            end;
            u119 = tick();
            u117:SetAttribute("Active", true);
            local v126, v127, _ = u8(v124);
            local u128 = true;
            local v129;
            if u117:IsDescendantOf(l__LocalPlayer__9.Character) then
                v129 = l__LocalPlayer__9.Character.Humanoid.Animator:LoadAnimation(l__ReplicatedStorage__2.Assets.Animations.VinewrapperSlam);
                v129.Priority = Enum.AnimationPriority.Action;
                v129:Play(0.5, 1, 1);
                game.TweenService:Create(u116, TweenInfo.new(1), {
                    EmissiveStrength = 2
                }):Play();
                for _, v130 in u117.Handle.VineEmitterAttachment:GetChildren() do
                    v130.Enabled = true;
                end;
                task.spawn(function() --[[ Line: 665 ]]
                    -- upvalues: u128 (ref), u116 (ref), u117 (ref)
                    while u128 do
                        task.wait(0.1);
                        local u131 = Instance.new("Part");
                        u131.Size = Vector3.new(0.2, 0.2, 0.2);
                        u131.Color = ({ Color3.fromRGB(162, 227, 51), Color3.fromRGB(56, 158, 40), Color3.fromRGB(45, 141, 52) })[Random.new():NextInteger(1, 3)];
                        u131.Parent = workspace.Temporary;
                        u131.Anchored = true;
                        u131.CanCollide = false;
                        u131.CanTouch = false;
                        u131.CanQuery = false;
                        u131.MaterialVariant = u116.Name;
                        game.TweenService:Create(u131, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                            Size = Vector3.new(0.4, 0.4, 0.4)
                        }):Play();
                        local u132 = 0.8 / #u117.DetailEffect:GetChildren();
                        local u133 = nil;
                        task.spawn(function() --[[ Line: 691 ]]
                            -- upvalues: u117 (ref), u133 (ref), u132 (copy), u131 (copy)
                            for v134 = 1, #u117.DetailEffect:GetChildren() do
                                local v135 = u117.DetailEffect:FindFirstChild((tostring(v134)));
                                if u133 == nil then
                                    u133 = v135;
                                else
                                    local v136 = 0;
                                    while v136 < u132 do
                                        v136 = v136 + game:GetService("RunService").Heartbeat:Wait();
                                        u131.CFrame = u133.CFrame:Lerp(v135.CFrame, v136 / u132);
                                    end;
                                    u133 = v135;
                                end;
                            end;
                            u131:Destroy();
                        end);
                    end;
                end);
                local u137 = ClientTrapCharacter(l__LocalPlayer__9.Character, game.ReplicatedStorage.Assets.VineArmTemplate);
                v129:GetMarkerReachedSignal("SlamDown"):Wait();
                v129:AdjustSpeed(0);
                game.TweenService:Create(u116, TweenInfo.new(1), {
                    EmissiveStrength = 1
                }):Play();
                for _, v138 in u117.Handle.VineEmitterAttachment:GetChildren() do
                    v138:Emit(v138:GetAttribute("EmitCount"));
                end;
                task.spawn(function() --[[ Line: 725 ]]
                    -- upvalues: l__LocalPlayer__9 (ref), u128 (ref), u116 (ref), u137 (copy), u117 (ref)
                    local v139 = l__LocalPlayer__9.Character.Torso:WaitForChild("Left Shoulder");
                    local v140 = l__LocalPlayer__9.Character.Torso:WaitForChild("Right Shoulder");
                    local l__C0__26 = v139.C0;
                    local l__C0__27 = v140.C0;
                    local v141 = 0;
                    while u128 do
                        v141 = v141 + task.wait(0);
                        local v142 = math.sin(v141 * 4) * 0.03490658503988659;
                        local v143 = math.cos(v141 * 4) * 0.03490658503988659;
                        local v144 = (math.sin(v141 * 20) * 0.6 + math.sin(v141 * 20 * 1.4) * 0.4) * 0.03490658503988659;
                        v140.C0 = l__C0__27 * CFrame.Angles(v142 + v144, 0, v143 + v144);
                        v139.C0 = l__C0__26 * CFrame.Angles(v142 + v144, 0, -(v143 + v144));
                    end;
                    game.TweenService:Create(u116, TweenInfo.new(1), {
                        EmissiveStrength = 0
                    }):Play();
                    u137();
                    for _, v145 in u117.Handle.VineEmitterAttachment:GetChildren() do
                        v145.Enabled = false;
                        v145:Emit(v145:GetAttribute("EmitCount"));
                    end;
                    v139.C0 = l__C0__26;
                    v140.C0 = l__C0__27;
                end);
            else
                v129 = nil;
            end;
            if not v126 then
                u117:SetAttribute("Active", false);
                return;
            end;
            if v127 then
                local v146 = v127:FindFirstAncestorOfClass("Model");
                while v146 and v146 ~= workspace do
                    if v146:HasTag("Character") and v146 ~= l__LocalPlayer__9.Character then
                        local v147 = v146:FindFirstChild("HumanoidRootPart");
                        if v147 then
                            v126 = v147.Position;
                        end;
                        break;
                    end;
                    local l__Parent__28 = v146.Parent;
                    if l__Parent__28 then
                        v146 = v146.Parent:FindFirstAncestorOfClass("Model");
                    else
                        v146 = l__Parent__28;
                    end;
                end;
            end;
            u115(l__LocalPlayer__9, v126);
            v129:AdjustSpeed(-1);
            local _ = false;
            u117:SetAttribute("Active", false);
        end;
        local function v152() --[[ Line: 800 ]]
            -- upvalues: u117 (copy)
            local v149 = u117:GetAttribute("CooldownUntil");
            if typeof(v149) == "number" then
                local v150 = v149 - workspace:GetServerTimeNow();
                local v151 = math.max(0, v150);
                u117:SetAttribute("CooldownEnd", os.clock() + v151);
            end;
        end;
        u117:GetAttributeChangedSignal("CooldownUntil"):Connect(v152);
        v152();
        u117.Activated:Connect(v148);
        u117.Unequipped:Connect(v122);
        u117.Equipped:Connect(v121);
    end;
end;
game.CollectionService:GetInstanceAddedSignal("VineWrapper"):Connect(v153);
local v154 = {};
for _, v155 in game.CollectionService:GetTagged("VineWrapper") do
    v153(v155);
end;
l__Networking__6.VineWrapper.SendVisual.OnClientEvent:Connect(function(p156, p157) --[[ Line: 823 ]]
    -- upvalues: u115 (copy)
    u115(p156, p157);
end);
local l__VineWrapperAssets__29 = l__ReplicatedStorage__2.Assets:WaitForChild("VineWrapperAssets");
local l__VineTemplate__30 = l__VineWrapperAssets__29:WaitForChild("VineTemplate");
local l__Flower__31 = l__VineWrapperAssets__29:WaitForChild("Flower");
local u158 = {
    {
        Name = "Left Leg",
        Wait = 0
    },
    {
        Name = "Right Leg",
        Wait = 0.05
    },
    {
        Name = "Torso",
        Wait = 0.1
    },
    {
        Name = "Left Arm",
        Wait = 0.18
    },
    {
        Name = "Right Arm",
        Wait = 0.2
    }
};
local u159 = {
    Color3.fromRGB(255, 180, 200),
    Color3.fromRGB(255, 230, 130),
    Color3.fromRGB(200, 160, 255),
    Color3.fromRGB(255, 120, 100),
    Color3.fromRGB(180, 220, 255)
};
local u160 = {};
local function u188(u161, p162, p163) --[[ Line: 872 ]]
    -- upvalues: l__TweenService__4 (copy), l__Flower__31 (copy), u159 (copy)
    local l__CFrame__32 = p163.CFrame;
    local u164 = {};
    for _, v165 in u161:GetDescendants() do
        if v165:IsA("BasePart") and v165 ~= p163 then
            u164[v165] = {
                Offset = l__CFrame__32:ToObjectSpace(v165.CFrame),
                TargetSize = v165.Size
            };
        end;
    end;
    for v166, v167 in u164 do
        v166.CFrame = p162.CFrame * v167.Offset;
        v166.Size = Vector3.new(0.01, 0.01, 0.01);
        v166.Transparency = 1;
        v166.Anchored = false;
        v166.CanCollide = false;
        v166.CanQuery = false;
        v166.CanTouch = false;
        v166.Massless = true;
        v166.CastShadow = false;
        v166.EnableFluidForces = false;
        local v168 = Instance.new("WeldConstraint");
        v168.Part0 = p162;
        v168.Part1 = v166;
        v168.Parent = v166;
    end;
    u161.Parent = p162;
    local v169 = {};
    for v170, _ in u164 do
        local v171 = math.floor((v170.Position - p163.Position).Magnitude / 0.5);
        v169[v171] = v169[v171] or {};
        table.insert(v169[v171], v170);
    end;
    local v172 = {};
    for v173 in v169 do
        table.insert(v172, v173);
    end;
    table.sort(v172);
    local v174 = 0;
    for _, v175 in v172 do
        local u176 = v169[v175];
        task.delay(v174, function() --[[ Line: 909 ]]
            -- upvalues: u176 (copy), u164 (copy), l__TweenService__4 (ref), l__Flower__31 (ref), u159 (ref), u161 (copy)
            for _, u177 in u176 do
                if u177.Parent then
                    local v178 = u164[u177];
                    if v178 then
                        u177.Transparency = 0;
                        l__TweenService__4:Create(u177, TweenInfo.new(0.04), {
                            Size = v178.TargetSize
                        }):Play();
                        task.spawn(function() --[[ Line: 916 ]]
                            -- upvalues: u177 (copy), l__Flower__31 (ref), u159 (ref), u161 (ref), l__TweenService__4 (ref)
                            local v179 = u177:FindFirstChild("Sprout");
                            if v179 and v179:IsA("Attachment") then
                                local u180 = l__Flower__31:Clone();
                                if u180:FindFirstChild("Petals") and u180:FindFirstChild("Base") then
                                    local v181 = u159[Random.new():NextInteger(1, #u159)];
                                    for _, v182 in u180.Petals:GetChildren() do
                                        v182.Color = v181;
                                    end;
                                    u180.Parent = u161;
                                    u180:PivotTo(v179.WorldCFrame);
                                    for _, v183 in u180:GetDescendants() do
                                        if v183:IsA("BasePart") then
                                            v183.CanCollide = false;
                                            v183.CanQuery = false;
                                            v183.CanTouch = false;
                                            v183.Massless = true;
                                            v183.CastShadow = false;
                                            v183.EnableFluidForces = false;
                                        end;
                                    end;
                                    local v184 = Instance.new("Weld");
                                    v184.Part0 = v179.Parent;
                                    v184.Part1 = u180.Base;
                                    v184.C0 = v179.Parent.CFrame:ToObjectSpace(u180.Base.CFrame);
                                    v184.C1 = CFrame.new();
                                    v184.Parent = u180.Base;
                                    u180:ScaleTo(0.01);
                                    local v185 = Random.new():NextNumber(0.6, 1.1);
                                    for _, v186 in u180:GetDescendants() do
                                        if v186:IsA("BasePart") then
                                            local _ = v186.Size * (v185 / 0.01);
                                            l__TweenService__4:Create(v186, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                Size = v186.Size * v185 * 100
                                            }):Play();
                                        end;
                                    end;
                                    task.delay(0.5, function() --[[ Line: 960 ]]
                                        -- upvalues: u180 (copy)
                                        for _, v187 in u180.Base:GetChildren() do
                                            if v187:IsA("Motor6D") then
                                                v187.DesiredAngle = 0.7853981633974483;
                                                if v187.Name == "Reverse" then
                                                    v187.DesiredAngle = v187.DesiredAngle * -1;
                                                end;
                                                v187.MaxVelocity = 0.03;
                                            end;
                                        end;
                                    end);
                                else
                                    u180:Destroy();
                                end;
                            end;
                        end);
                        task.wait(0.01);
                    end;
                end;
            end;
        end);
        v174 = v174 + 0.02;
    end;
end;
function ClientTrapCharacter(u189, p190)
    -- upvalues: l__VineTemplate__30 (copy), u158 (copy), u188 (copy), l__TweenService__4 (copy)
    local v191 = (p190 or l__VineTemplate__30):Clone();
    v191.Name = "Vines";
    local u192 = {};
    for _, v193 in u158 do
        local v194 = v191:FindFirstChild(v193.Name);
        local u195 = u189:FindFirstChild(v193.Name);
        if v194 and u195 then
            local u196 = nil;
            for _, v197 in v194:GetChildren() do
                if v197:IsA("BasePart") and v197.Name == v193.Name then
                    u196 = v197;
                    break;
                end;
            end;
            if u196 then
                local u198 = v194:FindFirstChild("Model");
                if u198 then
                    task.delay(v193.Wait, function() --[[ Line: 1005 ]]
                        -- upvalues: u189 (copy), u195 (copy), u188 (ref), u198 (copy), u196 (ref)
                        if u189.Parent and u195.Parent then
                            u188(u198, u195, u196);
                        end;
                    end);
                    u196:Destroy();
                    table.insert(u192, u198);
                end;
            end;
        end;
    end;
    return function() --[[ Name: Destroy, Line 1014 ]]
        -- upvalues: u192 (copy), l__TweenService__4 (ref)
        for _, v199 in u192 do
            game.Debris:AddItem(v199, 1);
            local v200 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v201 = Color3.fromRGB(71, 35, 14);
            for _, v202 in v199:GetChildren() do
                if v202:IsA("BasePart") then
                    l__TweenService__4:Create(v202, v200, {
                        Size = Vector3.new(0, 0, 0),
                        Color = v201
                    }):Play();
                elseif v202:IsA("Model") then
                    for _, v203 in v202:GetDescendants() do
                        if v203:IsA("BasePart") then
                            l__TweenService__4:Create(v203, v200, {
                                Size = Vector3.new(0, 0, 0),
                                Color = v201
                            }):Play();
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
l__Networking__6.VineWrapper.WrapCharacter.OnClientEvent:Connect(function(p204) --[[ Line: 1037 ]]
    -- upvalues: u160 (copy)
    if p204 and p204:IsDescendantOf(workspace) then
        if u160[p204] then
            pcall(u160[p204]);
            u160[p204] = nil;
        end;
        u160[p204] = ClientTrapCharacter(p204);
    end;
end);
l__Networking__6.VineWrapper.UnwrapCharacter.OnClientEvent:Connect(function(p205) --[[ Line: 1047 ]]
    -- upvalues: u160 (copy)
    if p205 then
        local v206 = u160[p205];
        if v206 then
            u160[p205] = nil;
            pcall(v206);
        end;
    end;
end);
v154.WrapCharacter = ClientTrapCharacter;
return v154;