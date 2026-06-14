-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__TweenService__3 = game:GetService("TweenService");
local l__CatmullRomSpline__4 = require(l__ReplicatedStorage__1.ClientModules.CatmullRomSpline);
local l__CCDIKController__5 = require(l__ReplicatedStorage__1.ClientModules.CCDIKController);
local l__Vine__6 = l__ReplicatedStorage__1.Assets.Vine;
local l__Victim__7 = script.Parent:WaitForChild("Victim");
local function u7(p2, p3) --[[ Line: 38 ]]
    local v4 = Random.new();
    local v5 = p2.Unit:Dot(Vector3.new(0, 1, 0));
    local v6 = math.abs(v5) > 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0);
    local l__Unit__8 = p2.Unit:Cross(v6).Unit;
    local l__Unit__9 = p2.Unit:Cross(l__Unit__8).Unit;
    return l__Unit__8 * v4:NextNumber(-p3, p3) + l__Unit__9 * v4:NextNumber(-p3, p3);
end;
local function u16(p8, p9) --[[ Line: 47 ]]
    -- upvalues: u7 (copy), l__CatmullRomSpline__4 (copy)
    local v10 = p9 - p8;
    local l__Magnitude__10 = v10.Magnitude;
    local v11 = p8 + v10 * 0.33 + u7(v10, 3) + Vector3.new(0, 5, 0);
    local v12 = p8 + v10 * 0.66 + u7(v10, 3) + Vector3.new(0, 4, 0);
    local v13 = p8 - v10.Unit * (l__Magnitude__10 * 0.15) + u7(v10, 0.8999999999999999);
    local v14 = p9 + v10.Unit * (l__Magnitude__10 * 0.15) + u7(v10, 0.8999999999999999);
    local v15 = l__CatmullRomSpline__4.new({
        v13,
        p8,
        v11,
        v12
    });
    v15:AddPoint(p9);
    v15:AddPoint(v14);
    return v15;
end;
local function u35(p17, p18, u19) --[[ Line: 65 ]]
    -- upvalues: l__RunService__2 (copy), l__Vine__6 (copy), l__TweenService__3 (copy)
    local v20 = math.round((p17 - p18).Magnitude / 2) + 1;
    local l__PrimaryPart__11 = u19.PrimaryPart;
    if l__PrimaryPart__11 then
        local u21 = Instance.new("Part");
        u21.Size = Vector3.new(0.01, 0.01, 0.01);
        u21.Anchored = true;
        u21.CanCollide = false;
        u21.CanQuery = false;
        u21.MaterialVariant = "Weld 2x2 Plastic";
        u21.Color = Color3.fromRGB(44, 101, 29);
        u21.Parent = u19;
        local u22 = 0;
        local u23 = 0.1 + v20 * 0.005;
        local l__Z__12 = l__PrimaryPart__11.Size.Z;
        task.spawn(function() --[[ Line: 85 ]]
            -- upvalues: u22 (ref), u23 (copy), u19 (copy), l__RunService__2 (ref), l__Z__12 (copy), l__PrimaryPart__11 (copy), u21 (copy)
            while u22 < u23 and u19.Parent do
                u22 = u22 + l__RunService__2.Heartbeat:Wait();
                local v24 = u22 / u23;
                local v25 = v24 * l__Z__12;
                local v26 = CFrame.new(0, 0, l__Z__12 / 2 - v25 / 2);
                u21.CFrame = l__PrimaryPart__11.CFrame * v26;
                u21.Size = Vector3.new(0.7 * v24, 0.7 * v24, v25);
            end;
            if u19.Parent then
                u21.CFrame = l__PrimaryPart__11.CFrame;
                local v27 = Instance.new("WeldConstraint");
                u21.Anchored = false;
                v27.Part0 = u21;
                v27.Part1 = u19.PrimaryPart;
                v27.Parent = u21;
            end;
        end);
        for v28 = 0, v20 do
            if not u19.Parent then
                return;
            end;
            local v29 = v28 / math.round(v20);
            local l__Z__13 = l__PrimaryPart__11.Size.Z;
            local v30 = CFrame.new(0, 0, l__Z__13 / 2 - v29 * l__Z__13);
            local v31 = l__PrimaryPart__11.CFrame * v30;
            local v32 = l__Vine__6:Clone();
            local v33 = v32.Size * Random.new():NextNumber(0.8, 1.3);
            v32.Size = Vector3.new(0, 0, 0);
            v32.Parent = u19;
            v32.CFrame = CFrame.new(v31.Position, v31.Position + Random.new():NextUnitVector());
            l__TweenService__3:Create(v32, TweenInfo.new(0.3), {
                Size = v33
            }):Play();
            l__TweenService__3:Create(v32.SurfaceAppearance, TweenInfo.new(0.35), {
                Color = Color3.fromRGB(44, 101, 29)
            }):Play();
            local v34 = Instance.new("WeldConstraint");
            v34.Part0 = v32;
            v34.Part1 = u19.PrimaryPart;
            v34.Parent = v32;
            v32.Anchored = false;
            v32.Massless = true;
            v32.CanCollide = false;
            v32.CanQuery = false;
            v32.CanTouch = false;
            task.wait(0.005);
        end;
    end;
end;
local function u74(p36, p37, p38, p39) --[[ Line: 137 ]]
    -- upvalues: u16 (copy), l__CCDIKController__5 (copy), u35 (copy), l__TweenService__3 (copy)
    local v40 = u16(p36, p37);
    local u41 = Instance.new("Model");
    u41.Name = "VineGroup";
    u41.Parent = p39;
    local u42 = {};
    local v43 = {};
    local v44 = {};
    for v45 = 1, 10 do
        local v46 = Instance.new("Model");
        v46.Name = "Segment_" .. v45;
        v46.Parent = u41;
        u42[v45] = v46;
        local v47 = (v45 - 1) / 10;
        local v48 = v45 / 10;
        local v49 = v40:CalculatePositionAt(v47);
        local v50 = v40:CalculatePositionAt(v48);
        v43[v45] = v49;
        if v45 == 10 then
            v43[v45 + 1] = v50;
        end;
        table.insert(v44, {
            SegStart = v49,
            SegEnd = v50
        });
        local l__Magnitude__14 = (v50 - v49).Magnitude;
        local v51 = (v49 + v50) / 2;
        local v52 = Instance.new("Part");
        v52.Name = "PrimaryPart";
        v52.Anchored = false;
        v52.CanCollide = false;
        v52.CanQuery = false;
        v52.Massless = true;
        v52.Transparency = 1;
        v52.Size = Vector3.new(1, 1, l__Magnitude__14);
        v52.CFrame = CFrame.lookAt(v51, v50);
        v52.Parent = v46;
        v46.PrimaryPart = v52;
    end;
    local u53 = {};
    local v54 = Instance.new("Motor6D");
    v54.Name = "RootJoint";
    v54.Part0 = p38;
    v54.Part1 = u42[1].PrimaryPart;
    local v55 = CFrame.new(v43[1]);
    v54.C0 = p38.CFrame:Inverse() * v55;
    v54.C1 = u42[1].PrimaryPart.CFrame:Inverse() * v55;
    v54.Parent = p38;
    u53[1] = v54;
    for v56 = 1, 9 do
        local l__PrimaryPart__15 = u42[v56].PrimaryPart;
        local l__PrimaryPart__16 = u42[v56 + 1].PrimaryPart;
        local v57 = CFrame.new(v43[v56 + 1]);
        local v58 = Instance.new("Motor6D");
        v58.Name = "Joint_" .. v56;
        v58.Part0 = l__PrimaryPart__15;
        v58.Part1 = l__PrimaryPart__16;
        v58.C0 = l__PrimaryPart__15.CFrame:Inverse() * v57;
        v58.C1 = l__PrimaryPart__16.CFrame:Inverse() * v57;
        v58.Parent = l__PrimaryPart__15;
        u53[v56 + 1] = v58;
    end;
    for _, v59 in u42 do
        v59.PrimaryPart.Anchored = false;
    end;
    for _, v60 in u53 do
        local v61 = Instance.new("Attachment");
        v61.Name = v60.Part0.Name .. "AxisAttachment";
        v61.CFrame = v60.C0;
        v61.Parent = v60.Part0;
        local v62 = Instance.new("Attachment");
        v62.Name = v60.Part0.Name .. "JointAttachment";
        v62.CFrame = v60.C1;
        v62.Parent = v60.Part1;
    end;
    local v63 = {};
    for _, v64 in u53 do
        v63[v64] = {
            ConstraintType = "BallSocketConstraint",
            UpperAngle = 35,
            TwistLimitsEnabled = false
        };
    end;
    local u65 = l__CCDIKController__5.new(u53, v63);
    u65.LerpMode = false;
    u65.ConstantLerpSpeed = false;
    u65.AngularSpeed = 0.7853981633974483;
    u65.UseLastMotor = false;
    for v66, u67 in v44 do
        local u68 = u42[v66];
        task.spawn(function() --[[ Line: 244 ]]
            -- upvalues: u35 (ref), u67 (copy), u68 (copy)
            u35(u67.SegStart, u67.SegEnd, u68);
        end);
    end;
    return {
        Retract = function() --[[ Name: Retract, Line 256 ]]
            -- upvalues: u41 (copy), u42 (copy), l__TweenService__3 (ref), u53 (copy)
            if u41.Parent then
                for _, u69 in u42 do
                    if u69.Parent then
                        u69.PrimaryPart.Anchored = true;
                        task.spawn(function() --[[ Line: 262 ]]
                            -- upvalues: u69 (copy), l__TweenService__3 (ref)
                            for _, v70 in u69:GetChildren() do
                                if v70 ~= u69.PrimaryPart then
                                    if v70:IsA("MeshPart") then
                                        l__TweenService__3:Create(v70, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                            Size = Vector3.new(0, 0, 0),
                                            CFrame = CFrame.new(v70.Position, v70.Position + Random.new():NextUnitVector())
                                        }):Play();
                                        if v70:FindFirstChildOfClass("SurfaceAppearance") then
                                            l__TweenService__3:Create(v70.SurfaceAppearance, TweenInfo.new(0.2), {
                                                Color = Color3.fromRGB(71, 35, 14)
                                            }):Play();
                                        end;
                                    elseif v70:IsA("BasePart") then
                                        l__TweenService__3:Create(v70, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                            Size = Vector3.new(0, 0, 0)
                                        }):Play();
                                    end;
                                    task.wait(0.005);
                                end;
                            end;
                        end);
                    end;
                end;
                task.delay(0.6, function() --[[ Line: 283 ]]
                    -- upvalues: u53 (ref), u41 (ref)
                    for _, v71 in u53 do
                        if v71 and v71.Parent then
                            v71:Destroy();
                        end;
                    end;
                    if u41 and u41.Parent then
                        u41:Destroy();
                    end;
                end);
            end;
        end,
        UpdateGoal = function(p72, p73) --[[ Name: UpdateGoal, Line 250 ]]
            -- upvalues: u41 (copy), u65 (copy)
            if u41.Parent then
                u65:CCDIKIterateOnce(p72, 0, p73);
            end;
        end
    };
end;
local function u80(p75, p76) --[[ Line: 294 ]]
    -- upvalues: l__Victim__7 (copy)
    local v77 = l__Victim__7:Clone();
    v77.Name = "VineVictim";
    v77.Parent = p75;
    local v78 = v77:FindFirstChildOfClass("Humanoid");
    local v79 = v77:FindFirstChild("HumanoidRootPart");
    if not (v78 and v79) then
        v77:Destroy();
        return nil;
    end;
    v77.PrimaryPart = v79;
    v78.AutoRotate = false;
    v78:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false);
    v78:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false);
    v78:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false);
    v78:ChangeState(Enum.HumanoidStateType.Physics);
    v79.Anchored = false;
    v77:PivotTo(p76);
    return v77, v78, v79;
end;
local function u89(p81, p82) --[[ Line: 320 ]]
    local v83 = math.random() * 3.141592653589793 * 2;
    local v84 = 2.5 + math.random() * 15.5;
    local v85 = 3 + math.random() * 7;
    local l__Position__17 = p81.Position;
    local v86 = l__Position__17.X + math.cos(v83) * v84;
    local v87 = p82 + v85;
    local v88 = l__Position__17.Z + math.sin(v83) * v84;
    return Vector3.new(v86, v87, v88);
end;
local function u94(p90) --[[ Line: 332 ]]
    local v91 = Instance.new("Part");
    v91.Name = "FakeWrapperHandle";
    v91.Size = Vector3.new(0.6, 0.6, 1.4);
    v91.Transparency = 1;
    v91.CanCollide = false;
    v91.CanQuery = false;
    v91.Massless = true;
    v91.Anchored = false;
    v91.Parent = p90.Parent;
    local l__Parent__18 = p90.Parent;
    local v92 = l__Parent__18:FindFirstChild("RightHand") or (l__Parent__18:FindFirstChild("Right Arm") or p90);
    local v93 = Instance.new("Weld");
    v93.Part0 = v92;
    v93.Part1 = v91;
    v93.C0 = CFrame.new(0, -0.5, -0.7) * CFrame.Angles(-1.5707963267948966, 0, 0);
    v93.Parent = v91;
    return v91;
end;
function v1.Run(u95) --[[ Line: 356 ]]
    -- upvalues: u94 (copy), u80 (copy), u74 (copy), l__RunService__2 (copy), u89 (copy), l__TweenService__3 (copy)
    local l__Plot__19 = u95.Plot;
    local l__PlayerModel__20 = u95.PlayerModel;
    local _ = u95.PlayerHumanoid;
    local l__Camera__21 = u95.Camera;
    local l__Trove__22 = u95.Trove;
    if l__PlayerModel__20 then
        local u96 = l__PlayerModel__20:FindFirstChild("HumanoidRootPart");
        if u96 then
            l__PlayerModel__20.PrimaryPart = u96;
            local u97 = l__PlayerModel__20:FindFirstChild("Torso") or l__PlayerModel__20:FindFirstChild("UpperTorso");
            if u97 then
                u97 = u97:FindFirstChild("Neck");
            end;
            local u98;
            if u97 then
                u98 = u97.C0;
            else
                u98 = u97;
            end;
            local u99 = u94(u96);
            l__Trove__22:Add(u99);
            local u100 = Instance.new("Folder");
            u100.Name = "VineWrapperSceneVines";
            u100.Parent = l__Plot__19;
            l__Trove__22:Add(u100);
            local v101 = l__Plot__19:FindFirstChild("CameraPart");
            local v102 = l__Plot__19:FindFirstChild("Center");
            local v103 = v102 and v102.Position or l__PlayerModel__20.PrimaryPart.Position;
            if v101 then
                l__Camera__21.CameraType = Enum.CameraType.Scriptable;
                l__Camera__21.CFrame = v101.CFrame;
                l__Camera__21.FieldOfView = 55;
            else
                l__Camera__21.CameraType = Enum.CameraType.Scriptable;
                l__Camera__21.CFrame = CFrame.lookAt(v103 + Vector3.new(14, 8, 14), v103);
                l__Camera__21.FieldOfView = 55;
            end;
            local l__Y__23 = v103.Y;
            local v104 = l__Plot__19:FindFirstChild("TopLayer");
            if v104 then
                l__Y__23 = v104.Position.Y + v104.Size.Y / 2;
            end;
            task.spawn(function() --[[ Line: 403 ]]
                -- upvalues: u100 (copy), u96 (copy), l__Y__23 (ref), u80 (ref), u95 (copy), l__PlayerModel__20 (copy), u74 (ref), u99 (copy), l__RunService__2 (ref), l__Trove__22 (copy), u97 (copy), u98 (copy), u89 (ref), l__TweenService__3 (ref)
                task.wait(0.4);
                while u100.Parent do
                    local u105 = u96;
                    if not (u105 and u105.Parent) then
                        break;
                    end;
                    local v106 = math.random() * 3.141592653589793 * 2;
                    local v107 = u105.Position.X + math.cos(v106) * 14;
                    local v108 = l__Y__23 + 0 + 3;
                    local v109 = u105.Position.Z + math.sin(v106) * 14;
                    local v110 = Vector3.new(v107, v108, v109);
                    local v111, _, v112 = u80(u100, CFrame.new(v110 + Vector3.new(0, -200, 0)));
                    if v111 then
                        v112.Anchored = true;
                        u95:ApplyRandomFriendAppearance(v111, nil, true);
                        if not (u100.Parent and v111.Parent) then
                            if v111 and v111.Parent then
                                v111:Destroy();
                            end;
                            return;
                        end;
                        local u113 = v111:FindFirstChild("HumanoidRootPart") or v112;
                        v111.PrimaryPart = u113;
                        u113.Anchored = true;
                        v111:PivotTo(CFrame.new(v110));
                        u113.Anchored = false;
                        task.wait(0.4);
                        if not (u100.Parent and u113.Parent) then
                            if v111 and v111.Parent then
                                v111:Destroy();
                            end;
                            return;
                        end;
                        local v114 = Vector3.new(u113.Position.X, u105.Position.Y, u113.Position.Z);
                        l__PlayerModel__20:PivotTo(CFrame.lookAt(u105.Position, v114));
                        task.wait(0.15);
                        if not (u100.Parent and u113.Parent) then
                            if v111 and v111.Parent then
                                v111:Destroy();
                            end;
                            return;
                        end;
                        local u115 = u74(u99.Position, u113.Position, u99, u100);
                        u113.Anchored = true;
                        local l__Anchored__24 = u105.Anchored;
                        u105.Anchored = true;
                        local u116 = nil;
                        u116 = l__RunService__2.Heartbeat:Connect(function(p117) --[[ Line: 472 ]]
                            -- upvalues: u100 (ref), u113 (ref), u116 (ref), u115 (copy)
                            if u100.Parent and u113.Parent then
                                u115.UpdateGoal(u113.Position, p117);
                            else
                                if u116 then
                                    u116:Disconnect();
                                end;
                            end;
                        end);
                        l__Trove__22:Add(u116);
                        local u118 = nil;
                        u118 = l__RunService__2.Heartbeat:Connect(function(p119) --[[ Line: 482 ]]
                            -- upvalues: u100 (ref), u113 (ref), u105 (copy), u118 (ref), l__PlayerModel__20 (ref), u97 (ref), u98 (ref)
                            if u100.Parent and (u113.Parent and u105.Parent) then
                                local l__Position__25 = u105.Position;
                                local l__Position__26 = u113.Position;
                                local v120 = Vector3.new(l__Position__26.X, l__Position__25.Y, l__Position__26.Z);
                                if (v120 - l__Position__25).Magnitude < 0.05 then
                                else
                                    local v121 = CFrame.lookAt(l__Position__25, v120);
                                    local v122 = 1 - math.exp(-8 * p119);
                                    l__PlayerModel__20:PivotTo((u105.CFrame:Lerp(v121, v122)));
                                    if u97 and u98 then
                                        local l__Magnitude__27 = Vector2.new(l__Position__26.X - l__Position__25.X, l__Position__26.Z - l__Position__25.Z).Magnitude;
                                        local v123 = l__Position__26.Y - l__Position__25.Y;
                                        local v124 = math.max(l__Magnitude__27, 0.1);
                                        local v125 = math.atan2(v123, v124);
                                        local v126 = math.clamp(v125, -0.7853981633974483, 1.0471975511965976);
                                        local v127 = u98 * CFrame.Angles(-v126, 0, 0);
                                        u97.C0 = u97.C0:Lerp(v127, v122);
                                    end;
                                end;
                            else
                                if u118 then
                                    u118:Disconnect();
                                end;
                            end;
                        end);
                        l__Trove__22:Add(u118);
                        local v128 = tick();
                        local v129 = u118;
                        local v130 = u116;
                        while tick() - v128 < 5 and (u100.Parent and u113.Parent) do
                            local v131 = u89(u105, l__Y__23);
                            local v132 = Vector3.new(u105.Position.X, v131.Y, u105.Position.Z);
                            local v133 = CFrame.lookAt(v131, v132);
                            local v134 = 0.35 + math.random() * 0.4;
                            local v135 = l__TweenService__3:Create(u113, TweenInfo.new(v134, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                CFrame = v133
                            });
                            v135:Play();
                            local v136 = 0;
                            while v136 < v134 and (u100.Parent and u113.Parent) do
                                v136 = v136 + l__RunService__2.Heartbeat:Wait();
                            end;
                            if v135 then
                                v135:Cancel();
                            end;
                        end;
                        if v130 then
                            v130:Disconnect();
                        end;
                        if v129 then
                            v129:Disconnect();
                        end;
                        if u115.Retract then
                            pcall(u115.Retract);
                        end;
                        if u97 and u98 then
                            u97.C0 = u98;
                        end;
                        if v111 and (v111.Parent and u113.Parent) then
                            u113.Anchored = false;
                        end;
                        if u105.Parent then
                            u105.Anchored = l__Anchored__24;
                        end;
                        task.wait(0.6);
                        if v111 and v111.Parent then
                            v111:Destroy();
                        end;
                        task.wait(0.9);
                    else
                        task.wait(0.9);
                    end;
                end;
            end);
        end;
    end;
end;
return v1;