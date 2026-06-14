-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("TweenService");
local u1 = {};
local l__CCDIKController__2 = require(script.CCDIKController);
local l__Networking__3 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__RagdollModule__4 = require(game.ReplicatedStorage.ClientModules.RagdollModule);
local function u9(p2, p3) --[[ Line: 18 ]]
    local v4 = p3.PlantModel and p3.PlantModel.Base;
    if v4 then
        v4 = p3.PlantModel.Base:FindFirstChild("PLAYER_POINT");
    end;
    if v4 then
        if p2:IsA("Model") then
            local l__PrimaryPart__5 = p2.PrimaryPart;
            if l__PrimaryPart__5 then
                for _, v5 in p2:GetDescendants() do
                    if v5:IsA("BasePart") and v5.Name ~= "HarvestPart" then
                        v5.Anchored = false;
                        v5.CanCollide = false;
                        if v5 ~= l__PrimaryPart__5 then
                            local v6 = Instance.new("WeldConstraint");
                            v6.Part0 = l__PrimaryPart__5;
                            v6.Part1 = v5;
                            v6.Parent = v5;
                        end;
                    end;
                end;
                p2:PivotTo(v4.CFrame);
                local v7 = Instance.new("WeldConstraint");
                v7.Part0 = l__PrimaryPart__5;
                v7.Part1 = v4;
                v7.Parent = l__PrimaryPart__5;
                v7.Name = "AttachWeld";
            end;
        else
            if p2:IsA("BasePart") then
                p2.Anchored = false;
                p2.CanCollide = false;
                p2.CFrame = v4.CFrame;
                local v8 = Instance.new("WeldConstraint");
                v8.Part0 = p2;
                v8.Part1 = v4;
                v8.Parent = p2;
            end;
        end;
    end;
end;
local function u29(p10, p11) --[[ Line: 119 ]]
    -- upvalues: u29 (copy)
    local v12 = p11 or "";
    for v13, v14 in p10 do
        local v15 = p10[v13 + 1];
        if v14 and v15 then
            local v16 = Instance.new("Motor6D");
            v16.Name = v14.Name .. v12;
            v16.Part0 = v14;
            v16.Part1 = v15;
            v16.C0 = CFrame.new(0, v14.Size.Y / 2, 0);
            local v17 = v14.CFrame * v16.C0;
            v16.C1 = v15.CFrame:Inverse() * v17;
            v16.Parent = v14;
        end;
        for _, v18 in v14:GetChildren() do
            if v18.Name == "Reference" then
                for _, v19 in v18.Value:GetDescendants() do
                    if v19:IsA("BasePart") then
                        local v20 = Instance.new("WeldConstraint");
                        v20.Part0 = v19;
                        v20.Part1 = v14;
                        v20.Parent = v19;
                    end;
                end;
            elseif v18.Name == "LeafStemReference" then
                local v21 = {};
                local v22 = nil;
                for _, v23 in v18.Value:GetChildren() do
                    if v23:IsA("BasePart") then
                        if v23.Name == "EndJoint" then
                            v22 = v23;
                        else
                            v21[tonumber(v23.Name)] = v23;
                        end;
                    end;
                end;
                local v24 = nil;
                for v25 = 1, #v21 do
                    if v21[v25] ~= nil then
                        v24 = v25;
                        break;
                    end;
                end;
                local v26 = { table.unpack(v21, v24) };
                table.insert(v26, v22);
                u29(v26, v18.Name);
                local v27 = Instance.new("Motor6D");
                v27.Name = "Root_" .. v18.Name;
                v22.Name = "EndJoint";
                v27.Part0 = v14;
                v27.Part1 = v26[1];
                v27.C0 = CFrame.new(0, v14.Size.Y / 2, 0);
                local v28 = v14.CFrame * v27.C0;
                v27.C1 = v26[1].CFrame:Inverse() * v28;
                v27.Parent = v14;
            end;
        end;
    end;
end;
local function u39(p30, p31) --[[ Line: 224 ]]
    -- upvalues: l__CCDIKController__2 (copy)
    local v32 = {};
    for _, v33 in p31:GetChildren() do
        local v34 = v33:FindFirstChildOfClass("Motor6D");
        if v34 then
            v32[tonumber(v33.Name)] = v34;
        end;
    end;
    local v35 = nil;
    for v36 = 1, #v32 do
        if v32[v36] ~= nil then
            v35 = v36;
            break;
        end;
    end;
    local v37 = { table.unpack(v32, v35) };
    local l__CFrame__6 = p31.EndJoint.CFrame;
    local v38 = Instance.new("Attachment");
    v38.Parent = p30.RotationHandler;
    v38.WorldCFrame = l__CFrame__6;
    return {
        bend = l__CCDIKController__2.new(v37),
        Attachment = v38,
        joints = v37,
        startingCF = v38.Position,
        maxRange = (l__CFrame__6.Position - (v37[1].C0 * v37[1].Part0.CFrame).Position).Magnitude * 0.9
    };
end;
local function u50(p40, p41) --[[ Line: 256 ]]
    local v42 = {};
    for v43, v44 in p40 do
        if p41[v43] then
            local v45 = v44.CFrame * CFrame.new(0, v44.Size.Y / 2, 0);
            local v46 = Instance.new("Attachment");
            v46.Name = v44.Name .. "AxisAttachment";
            v46.Parent = v44;
            v46.WorldCFrame = v45 * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966);
            local v47 = p40[v43 + 1];
            if v47 then
                local v48 = Instance.new("Attachment");
                v48.Name = v44.Name .. "JointAttachment";
                v48.Parent = v47;
                v48.WorldCFrame = v45 * CFrame.Angles(0, -1.5707963267948966, 1.5707963267948966);
                local v49 = Instance.new("BallSocketConstraint");
                v49.Name = v44.Name .. "BallSocket";
                v49.LimitsEnabled = true;
                v49.UpperAngle = 90;
                v49.Attachment0 = v46;
                v49.Attachment1 = v48;
                v49.Parent = v44;
                table.insert(v42, v49);
            end;
        end;
    end;
    return v42;
end;
local function v81(u51) --[[ Line: 445 ]]
    -- upvalues: u29 (copy), u50 (copy), u9 (copy), u39 (copy), u1 (copy)
    local v52 = {};
    if not u51:HasTag("InitializationComplete") then
        repeat
            task.wait();
        until u51:HasTag("InitializationComplete");
    end;
    for v53 = 1, 8 do
        if u51:FindFirstChild((tostring(v53))) then
            local v54 = tostring(v53);
            table.insert(v52, u51:FindFirstChild(v54));
        end;
    end;
    u29(v52);
    local v55 = Instance.new("Motor6D");
    v55.Part0 = v52[#v52];
    v55.Part1 = u51.PlantModel.Rig.RootPart;
    v55.C0 = CFrame.new(0, v52[#v52].Size.Y / 2, 0);
    v55.Name = "HeadWeld";
    v55.C1 = u51.PlantModel.Rig.RootPart.CFrame:Inverse() * (v52[#v52].CFrame * v55.C0);
    v55.Parent = v52[#v52];
    for _, v56 in u51.PlantModel:GetChildren() do
        if v56:IsA("Model") and v56.Name ~= "Rig" then
            local v57 = u51.PlantModel.Rig[v56.Name];
            for _, v58 in v56:GetDescendants() do
                if v58:IsA("BasePart") then
                    local v59 = Instance.new("WeldConstraint");
                    v59.Part0 = v58;
                    v59.Part1 = v57;
                    v59.Parent = v58;
                end;
            end;
        end;
    end;
    local v60 = u51.FruitSpawnLocations:FindFirstChild("Fruit_Spawn");
    local v61 = Instance.new("WeldConstraint");
    v61.Part0 = v60;
    v61.Part1 = u51.PlantModel.Rig.Base;
    v61.Parent = v60;
    local v62 = Instance.new("Motor6D");
    v62.Part0 = u51.Base;
    v62.Part1 = v52[1];
    v62.Name = "Root";
    v62.C0 = CFrame.new(0, u51.Base.Size.Y / 2, 0);
    v62.C1 = v52[1].CFrame:Inverse() * (u51.Base.CFrame * v62.C0);
    v62.Parent = u51.Base;
    local v63 = {};
    for _, v64 in v52 do
        local v65 = v64:FindFirstChild(v64.Name) or v64:FindFirstChildOfClass("Motor6D");
        table.insert(v63, v65);
    end;
    u51.PlantModel.Rig.RootPart:FindFirstChildOfClass("Motor6D");
    u50(v52, v63);
    local v66 = {};
    local v67 = {};
    for _, v68 in v63 do
        if v68 then
            v66[v68] = v68.C0;
            v67[v68] = v68.C1;
        end;
    end;
    local v69 = u51:FindFirstChild("Fruits");
    if v69 then
        for _, v70 in v69:GetChildren() do
            u9(v70, u51);
        end;
        v69.ChildAdded:Connect(function(u71) --[[ Line: 541 ]]
            -- upvalues: u51 (copy), u9 (ref)
            task.defer(function() --[[ Line: 542 ]]
                -- upvalues: u71 (copy), u51 (ref), u9 (ref)
                if u71 and (u71.Parent and (u51 and u51.Parent)) then
                    u9(u71, u51);
                end;
            end);
        end);
    end;
    for _, v72 in u51:GetDescendants() do
        if v72:IsA("BasePart") and (v72.Name ~= "Base" and v72.Name ~= "HarvestPart") then
            v72.Anchored = false;
        end;
    end;
    local v73 = script.AnimationController:Clone();
    v73.Parent = u51;
    local v74 = u51.Base:Clone();
    v74:ClearAllChildren();
    v74.Name = "RotationHandler";
    v74.Anchored = true;
    v74.Parent = u51;
    local v75 = { u39(u51, u51.Leaf1), (u39(u51, u51.Leaf2)) };
    local v76 = Instance.new("Attachment");
    v76.Parent = v74;
    v76.WorldCFrame = v52[#v52 - 2].CFrame;
    local v77 = Instance.new("Attachment");
    v77.Parent = v74;
    v77.WorldCFrame = u51.PlantModel.Rig.IKJoint.CFrame;
    v77.Name = "Banana";
    local l__Center__7 = v73.Center;
    l__Center__7.EndEffector = v52[#v52 - 2];
    l__Center__7.ChainRoot = v52[2];
    l__Center__7.Target = v76;
    l__Center__7.Enabled = true;
    local l__Top__8 = v73.Top;
    l__Top__8.EndEffector = u51.PlantModel.Rig.IKJoint;
    l__Top__8.ChainRoot = v52[#v52 - 2];
    l__Top__8.Target = v77;
    l__Top__8.Enabled = true;
    local v78 = Random.new():NextInteger(1, 9999);
    local v79 = u51.Base.CFrame:ToObjectSpace(v76.WorldCFrame);
    local v80 = u51.Base.CFrame:ToObjectSpace(v77.WorldCFrame);
    u51.PlantModel.Rig.Base.TopJaw.MaxVelocity = 0.15;
    u51.PlantModel.Rig.Base.BottomJaw.MaxVelocity = 0.15;
    tick();
    u1[u51] = {
        CurrentTarget = nil,
        TargetLocked = false,
        LookTarget = nil,
        Model = u51,
        Offsets = {
            CenterOffset = v79 * CFrame.new(0, 2, 0),
            TopOffset = v80 * CFrame.new(0, 4, 0) * CFrame.Angles(0, 0, -0.7853981633974483)
        },
        RandomOffset = v78,
        CenterOffset = v79,
        TopOffset = v80,
        Base = v74,
        ArmJoints = v75,
        NextAttack = tick(),
        LastDecision = tick(),
        RestPoses = v66,
        Owner = game.Players:GetPlayerByUserId(u51:GetAttribute("UserId")),
        StartingPivot = v74.CFrame,
        Attachment1 = v76,
        Attachment2 = v77
    };
end;
game.CollectionService:GetInstanceAddedSignal("VenusFlyTrap"):Connect(v81);
local function u85() --[[ Line: 197 ]]
    local v82, v83 = pcall(function() --[[ Line: 198 ]]
        return UserSettings().GameSettings;
    end);
    if not (v82 and v83) then
        return 30;
    end;
    local l__SavedQualityLevel__9 = v83.SavedQualityLevel;
    local v84 = nil;
    if typeof(l__SavedQualityLevel__9) == "EnumItem" then
        l__SavedQualityLevel__9 = l__SavedQualityLevel__9.Value;
    elseif type(l__SavedQualityLevel__9) ~= "number" then
        l__SavedQualityLevel__9 = v84;
    end;
    return type(l__SavedQualityLevel__9) == "number" and (l__SavedQualityLevel__9 == 0 and 30 or (l__SavedQualityLevel__9 >= 7 and 60 or (l__SavedQualityLevel__9 >= 4 and 25 or 30))) or 50;
end;
local function u93(p86) --[[ Line: 75 ]]
    -- upvalues: l__Players__1 (copy)
    if p86:GetAttribute("Decaying") then
    else
        local v87 = game.ReplicatedStorage:FindFirstChild("Night");
        local v88;
        if v87 and v87:IsA("BoolValue") then
            v88 = v87.Value == true;
        else
            v88 = false;
        end;
        if v88 then
            local v89 = p86:GetAttribute("UserId");
            local v90 = nil;
            local v91 = nil;
            for _, v92 in l__Players__1:GetPlayers() do
                if v89 ~= v92.UserId and v92.Character then
                    local l__Magnitude__10 = (v92.Character:GetPivot().Position - p86.Base.Position).Magnitude;
                    if l__Magnitude__10 < 40 and (not v90 or l__Magnitude__10 < v90) then
                        v91 = v92.Character;
                        v90 = l__Magnitude__10;
                    end;
                end;
            end;
            if v91 then
                return v91.HumanoidRootPart;
            end;
        end;
    end;
end;
local function u117(u94) --[[ Line: 313 ]]
    -- upvalues: l__Players__1 (copy), l__RagdollModule__4 (copy), l__Networking__3 (copy)
    local v95 = CFrame.new(0, 0, -1) * u94.Offsets.CenterOffset;
    local v96 = CFrame.new(0, 0, -15);
    local u97 = {};
    local v98 = 0;
    for _, v99 in u94.Model.PlantModel:GetDescendants() do
        if v99:IsA("BasePart") then
            u97[v99] = v99.CanCollide;
            v99.CanCollide = false;
        end;
    end;
    local u100 = true;
    while v98 < 0.3 do
        v98 = v98 + game:GetService("RunService").Heartbeat:Wait();
        local v101 = game.TweenService:GetValue(v98 / 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In);
        u94.CenterOffset = u94.Offsets.CenterOffset:Lerp(v95, v101);
        u94.TopOffset = u94.Offsets.TopOffset:Lerp(v96, v101);
        local v102 = 0.7 * v101;
        u94.Model.PlantModel.Rig.Base.TopJaw.DesiredAngle = v102;
        u94.Model.PlantModel.Rig.Base.BottomJaw.DesiredAngle = -v102;
    end;
    task.spawn(function() --[[ Line: 354 ]]
        -- upvalues: u94 (copy), u100 (ref), l__Players__1 (ref), l__RagdollModule__4 (ref), l__Networking__3 (ref)
        local _, _ = u94.Model.PlantModel.Rig:GetBoundingBox();
        local v103 = {};
        while u100 do
            task.wait(0);
            local v104, v105 = u94.Model.PlantModel.Rig:GetBoundingBox();
            local v106 = OverlapParams.new();
            v106.FilterDescendantsInstances = { l__Players__1.LocalPlayer.Character };
            v106.FilterType = Enum.RaycastFilterType.Include;
            v103 = workspace:GetPartBoundsInBox(v104, v105 * 0.7, v106);
            if #v103 > 0 then
                break;
            end;
        end;
        if #v103 > 0 then
            u94.Model.PlantModel.Rig.Base.Chomp:Play();
            for _, v107 in u94.Model.PlantModel.Rig.Base.Attachment:GetChildren() do
                v107:Emit(v107:GetAttribute("EmitCount") or 3);
            end;
            local l__Owner__11 = u94.Owner;
            l__RagdollModule__4:Ragdoll(game.Players.LocalPlayer.Character, 2);
            l__Networking__3.FlytrapService.Chomp:Fire(l__Owner__11);
        else
            u94.Model.PlantModel.Rig.Base.BiteMiss:Play();
        end;
    end);
    task.wait(0.1);
    local v108 = 0;
    while v108 < 0.1 do
        v108 = v108 + game:GetService("RunService").Heartbeat:Wait();
        local v109 = -0.7 + 0.85 * game.TweenService:GetValue(v108 / 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        u94.Model.PlantModel.Rig.Base.TopJaw.DesiredAngle = v109;
        u94.Model.PlantModel.Rig.Base.BottomJaw.DesiredAngle = -v109;
    end;
    local _ = false;
    local v110 = {};
    for v111, _ in u94.RestPoses do
        v110[v111] = {
            C0 = v111.C0,
            C1 = v111.C1
        };
    end;
    task.delay(1, function() --[[ Line: 422 ]]
        -- upvalues: u97 (copy)
        for v112, v113 in u97 do
            v112.CanCollide = v113;
        end;
    end);
    local v114 = 0;
    while v114 < 2 do
        v114 = v114 + game:GetService("RunService").Heartbeat:Wait();
        local v115 = game.TweenService:GetValue(v114 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        u94.CenterOffset = v95:Lerp(u94.Offsets.CenterOffset, v115);
        u94.TopOffset = v96:Lerp(u94.Offsets.TopOffset, v115);
        local v116 = -0.15 * v115;
        u94.Model.PlantModel.Rig.Base.TopJaw.DesiredAngle = v116;
        u94.Model.PlantModel.Rig.Base.BottomJaw.DesiredAngle = -v116;
    end;
end;
local v118 = {};
for _, v119 in game.CollectionService:GetTagged("VenusFlyTrap") do
    v81(v119);
end;
task.spawn(function() --[[ Line: 658 ]]
    -- upvalues: u85 (copy), u1 (copy), u93 (copy), u117 (copy)
    while true do
        local l__wait__12 = task.wait;
        local v120 = u85();
        local v121 = l__wait__12(v120 <= 0 and 0.02 or 1 / math.clamp(v120, 15, 60));
        for u122, u123 in u1 do
            if u122:IsDescendantOf(workspace) then
                if tick() - u123.LastDecision > 1 then
                    u123.LastDecision = tick();
                    task.spawn(function() --[[ Line: 672 ]]
                        -- upvalues: u123 (copy), u93 (ref), u122 (copy), u117 (ref)
                        if u123.CurrentTarget == nil or not u123.CurrentTarget:IsDescendantOf(workspace) then
                            u123.CurrentTarget = u93(u122);
                            if u123.CurrentTarget then
                                u123.NextAttack = tick() + 2;
                            end;
                        end;
                        if u123.CurrentTarget and ((u123.CurrentTarget.Position - u122.Base.Position).Magnitude < 30 and tick() - u123.NextAttack > 0) then
                            u123.TargetLocked = true;
                            u123.NextAttack = tick() + 9;
                            u117(u123);
                            u123.TargetLocked = false;
                            u123.CurrentTarget = u93(u122);
                        end;
                    end);
                end;
                u123.LookTarget = u123.CurrentTarget and u123.CurrentTarget.Position or u122.Base.CFrame * CFrame.new(0, 0, 8).Position;
                local l__new__13 = CFrame.new;
                local v124 = (u123.RandomOffset + tick()) * 0.7;
                local v125 = l__new__13(0, math.sin(v124), 0);
                local v126 = (u123.LookTarget - u123.Base.Position).Unit * Vector3.new(1, 0, 1);
                if not u123.TargetLocked then
                    u123.LookTarget = u123.CurrentTarget and u123.CurrentTarget.Position or u122.Base.CFrame * CFrame.new(0, 0, 8).Position;
                end;
                local v127 = math.clamp(1 - (u123.LookTarget - u123.Base.Position).Magnitude / 25, 0, 1);
                local v128 = CFrame.Angles(math.rad(v127 * -20), 0, 0);
                local l__Position__14 = u122.Base.Position;
                u123.Base.CFrame = u123.Base.CFrame:Lerp(CFrame.new(l__Position__14, l__Position__14 + v126) * v128, v121 * 2);
                u123.Attachment1.WorldCFrame = u123.Base.CFrame * u123.CenterOffset * v125;
                u123.Attachment2.WorldCFrame = u123.Base.CFrame * u123.TopOffset * v125 * v128;
                for _, v129 in u123.ArmJoints do
                    local l__Attachment__15 = v129.Attachment;
                    local l__startingCF__16 = v129.startingCF;
                    local v130 = (u123.RandomOffset + tick()) * 1.2;
                    local v131 = math.sin(v130);
                    local v132 = 4 + u123.RandomOffset + tick() * 1.2;
                    local v133 = math.sin(v132);
                    l__Attachment__15.Position = l__startingCF__16 + Vector3.new(0, v131, v133);
                    v129.bend:CCDIKIterateOnce(v129.Attachment.WorldPosition, 0, v121);
                end;
            else
                u1[u122] = nil;
            end;
        end;
    end;
end);
return v118;