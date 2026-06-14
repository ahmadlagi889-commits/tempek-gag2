-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
local l__RunService__2 = game:GetService("RunService");
local l__CatmullRomSpline__3 = require(l__ReplicatedStorage__1.ClientModules.CatmullRomSpline);
local l__CCDIKController__4 = require(l__ReplicatedStorage__1.ClientModules.CCDIKController);
local l__VineWrapperController__5 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.VineWrapperController);
local u2 = Instance.new("Animation");
u2.AnimationId = "rbxassetid://96203034991173";
local u3 = Instance.new("Animation");
u3.AnimationId = "rbxassetid://116086843391846";
local u4 = Instance.new("Animation");
u4.AnimationId = "rbxassetid://96228963929073";
local l__VineInspect__6 = script.Parent.VineInspect;
l__VineInspect__6.Parent = nil;
local u5 = game.MaterialService.ToolMaterials.GlowWeldTemplate:Clone();
u5.Name = "WeldGlow_Player_Shop";
u5.Parent = game.MaterialService.ToolMaterials;
local l__Vine__7 = l__ReplicatedStorage__1.Assets.Vine;
local function u11(p6, p7) --[[ Line: 47 ]]
    local v8 = Random.new();
    local v9 = p6.Unit:Dot(Vector3.new(0, 1, 0));
    local v10 = math.abs(v9) > 0.9 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0);
    local l__Unit__8 = p6.Unit:Cross(v10).Unit;
    local l__Unit__9 = p6.Unit:Cross(l__Unit__8).Unit;
    return l__Unit__8 * v8:NextNumber(-p7, p7) + l__Unit__9 * v8:NextNumber(-p7, p7);
end;
local function u20(p12, p13) --[[ Line: 56 ]]
    -- upvalues: u11 (copy), l__CatmullRomSpline__3 (copy)
    local v14 = p13 - p12;
    local l__Magnitude__10 = v14.Magnitude;
    local v15 = p12 + v14 * 0.33 + u11(v14, 3) + Vector3.new(0, 15, 0);
    local v16 = p12 + v14 * 0.66 + u11(v14, 3) + Vector3.new(0, 12, 0);
    local v17 = p12 - v14.Unit * (l__Magnitude__10 * 0.15) + u11(v14, 0.8999999999999999);
    local v18 = p13 + v14.Unit * (l__Magnitude__10 * 0.15) + u11(v14, 0.8999999999999999);
    local v19 = l__CatmullRomSpline__3.new({
        v17,
        p12,
        v15,
        v16
    });
    v19:AddPoint(p13);
    v19:AddPoint(v18);
    return v19;
end;
local function u39(p21, p22, u23) --[[ Line: 74 ]]
    -- upvalues: l__RunService__2 (copy), l__Vine__7 (copy)
    local v24 = math.round((p21 - p22).Magnitude / 2) + 1;
    local l__PrimaryPart__11 = u23.PrimaryPart;
    if l__PrimaryPart__11 then
        local u25 = Instance.new("Part");
        u25.Size = Vector3.new(0.01, 0.01, 0.01);
        u25.Anchored = true;
        u25.CanCollide = false;
        u25.CanQuery = false;
        u25.MaterialVariant = "Weld 2x2 Plastic";
        u25.Color = Color3.fromRGB(44, 101, 29);
        u25.Parent = u23;
        local u26 = 0;
        local u27 = 0.1 + v24 * 0.005;
        local l__Z__12 = l__PrimaryPart__11.Size.Z;
        task.spawn(function() --[[ Line: 94 ]]
            -- upvalues: u26 (ref), u27 (copy), u23 (copy), l__RunService__2 (ref), l__Z__12 (copy), l__PrimaryPart__11 (copy), u25 (copy)
            while u26 < u27 and u23.Parent do
                u26 = u26 + l__RunService__2.Heartbeat:Wait();
                local v28 = u26 / u27;
                local v29 = v28 * l__Z__12;
                local v30 = CFrame.new(0, 0, l__Z__12 / 2 - v29 / 2);
                u25.CFrame = l__PrimaryPart__11.CFrame * v30;
                u25.Size = Vector3.new(0.7 * v28, 0.7 * v28, v29);
            end;
            if u23.Parent then
                u25.CFrame = l__PrimaryPart__11.CFrame;
                local v31 = Instance.new("WeldConstraint");
                u25.Anchored = false;
                v31.Part0 = u25;
                v31.Part1 = u23.PrimaryPart;
                v31.Parent = u25;
            end;
        end);
        for v32 = 0, v24 do
            if not u23.Parent then
                return;
            end;
            local v33 = v32 / math.round(v24);
            local l__Z__13 = l__PrimaryPart__11.Size.Z;
            local v34 = CFrame.new(0, 0, l__Z__13 / 2 - v33 * l__Z__13);
            local v35 = l__PrimaryPart__11.CFrame * v34;
            local v36 = l__Vine__7:Clone();
            local v37 = v36.Size * Random.new():NextNumber(0.8, 1.3);
            v36.Size = Vector3.new(0, 0, 0);
            v36.Parent = u23;
            v36.CFrame = CFrame.new(v35.Position, v35.Position + Random.new():NextUnitVector());
            game.TweenService:Create(v36, TweenInfo.new(0.3), {
                Size = v37
            }):Play();
            game.TweenService:Create(v36.SurfaceAppearance, TweenInfo.new(0.35), {
                Color = Color3.fromRGB(44, 101, 29)
            }):Play();
            local v38 = Instance.new("WeldConstraint");
            v38.Part0 = v36;
            v38.Part1 = u23.PrimaryPart;
            v38.Parent = v36;
            v36.Anchored = false;
            v36.Massless = true;
            v36.CanCollide = false;
            v36.CanQuery = false;
            v36.CanTouch = false;
            task.wait(0.005);
        end;
    end;
end;
local function u78(p40, p41, p42, p43) --[[ Line: 146 ]]
    -- upvalues: u20 (copy), l__CCDIKController__4 (copy), u39 (copy)
    local v44 = u20(p40, p41);
    local u45 = Instance.new("Model");
    u45.Name = "VineGroup";
    u45.Parent = p43;
    local u46 = {};
    local v47 = {};
    local v48 = {};
    for v49 = 1, 10 do
        local v50 = Instance.new("Model");
        v50.Name = "Segment_" .. v49;
        v50.Parent = u45;
        u46[v49] = v50;
        local v51 = (v49 - 1) / 10;
        local v52 = v49 / 10;
        local v53 = v44:CalculatePositionAt(v51);
        local v54 = v44:CalculatePositionAt(v52);
        v47[v49] = v53;
        if v49 == 10 then
            v47[v49 + 1] = v54;
        end;
        table.insert(v48, {
            SegStart = v53,
            SegEnd = v54
        });
        local l__Magnitude__14 = (v54 - v53).Magnitude;
        local v55 = (v53 + v54) / 2;
        local v56 = Instance.new("Part");
        v56.Name = "PrimaryPart";
        v56.Anchored = false;
        v56.CanCollide = false;
        v56.CanQuery = false;
        v56.Massless = true;
        v56.Transparency = 1;
        v56.Size = Vector3.new(1, 1, l__Magnitude__14);
        v56.CFrame = CFrame.lookAt(v55, v54);
        v56.Parent = v50;
        v50.PrimaryPart = v56;
    end;
    local u57 = {};
    local v58 = Instance.new("Motor6D");
    v58.Name = "RootJoint";
    v58.Part0 = p42;
    v58.Part1 = u46[1].PrimaryPart;
    local v59 = CFrame.new(v47[1]);
    v58.C0 = p42.CFrame:Inverse() * v59;
    v58.C1 = u46[1].PrimaryPart.CFrame:Inverse() * v59;
    v58.Parent = p42;
    u57[1] = v58;
    for v60 = 1, 9 do
        local l__PrimaryPart__15 = u46[v60].PrimaryPart;
        local l__PrimaryPart__16 = u46[v60 + 1].PrimaryPart;
        local v61 = CFrame.new(v47[v60 + 1]);
        local v62 = Instance.new("Motor6D");
        v62.Name = "Joint_" .. v60;
        v62.Part0 = l__PrimaryPart__15;
        v62.Part1 = l__PrimaryPart__16;
        v62.C0 = l__PrimaryPart__15.CFrame:Inverse() * v61;
        v62.C1 = l__PrimaryPart__16.CFrame:Inverse() * v61;
        v62.Parent = l__PrimaryPart__15;
        u57[v60 + 1] = v62;
    end;
    for _, v63 in u46 do
        v63.PrimaryPart.Anchored = false;
    end;
    for _, v64 in u57 do
        local v65 = Instance.new("Attachment");
        v65.Name = v64.Part0.Name .. "AxisAttachment";
        v65.CFrame = v64.C0;
        v65.Parent = v64.Part0;
        local v66 = Instance.new("Attachment");
        v66.Name = v64.Part0.Name .. "JointAttachment";
        v66.CFrame = v64.C1;
        v66.Parent = v64.Part1;
    end;
    local v67 = {};
    for _, v68 in u57 do
        v67[v68] = {
            ConstraintType = "BallSocketConstraint",
            UpperAngle = 35,
            TwistLimitsEnabled = false
        };
    end;
    local u69 = l__CCDIKController__4.new(u57, v67);
    u69.LerpMode = false;
    u69.ConstantLerpSpeed = false;
    u69.AngularSpeed = 0.7853981633974483;
    u69.UseLastMotor = false;
    for v70, u71 in v48 do
        local u72 = u46[v70];
        task.spawn(function() --[[ Line: 253 ]]
            -- upvalues: u39 (ref), u71 (copy), u72 (copy)
            u39(u71.SegStart, u71.SegEnd, u72);
        end);
    end;
    return {
        Retract = function() --[[ Name: Retract, Line 265 ]]
            -- upvalues: u45 (copy), u46 (copy), u57 (copy)
            if u45.Parent then
                for _, u73 in u46 do
                    if u73.Parent then
                        u73.PrimaryPart.Anchored = true;
                        task.spawn(function() --[[ Line: 271 ]]
                            -- upvalues: u73 (copy)
                            for _, v74 in u73:GetChildren() do
                                if v74 ~= u73.PrimaryPart then
                                    if v74:IsA("MeshPart") then
                                        game.TweenService:Create(v74, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                            Size = Vector3.new(0, 0, 0),
                                            CFrame = CFrame.new(v74.Position, v74.Position + Random.new():NextUnitVector())
                                        }):Play();
                                        if v74:FindFirstChildOfClass("SurfaceAppearance") then
                                            game.TweenService:Create(v74.SurfaceAppearance, TweenInfo.new(0.2), {
                                                Color = Color3.fromRGB(71, 35, 14)
                                            }):Play();
                                        end;
                                    elseif v74:IsA("BasePart") then
                                        game.TweenService:Create(v74, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                            Size = Vector3.new(0, 0, 0)
                                        }):Play();
                                    end;
                                    task.wait(0.005);
                                end;
                            end;
                        end);
                    end;
                end;
                task.delay(0.6, function() --[[ Line: 292 ]]
                    -- upvalues: u57 (ref), u45 (ref)
                    for _, v75 in u57 do
                        if v75 and v75.Parent then
                            v75:Destroy();
                        end;
                    end;
                    if u45 and u45.Parent then
                        u45:Destroy();
                    end;
                end);
            end;
        end,
        UpdateGoal = function(p76, p77) --[[ Name: UpdateGoal, Line 259 ]]
            -- upvalues: u45 (copy), u69 (copy)
            if u45.Parent then
                u69:CCDIKIterateOnce(p76, 0, p77);
            end;
        end
    };
end;
function v1.Run(p79) --[[ Line: 304 ]]
    -- upvalues: l__VineInspect__6 (copy), l__RunService__2 (copy), u2 (copy), u3 (copy), u4 (copy), l__VineWrapperController__5 (copy), l__ReplicatedStorage__1 (copy), u5 (copy), u78 (copy)
    local _ = p79.Plot;
    local l__PlayerModel__17 = p79.PlayerModel;
    local l__PlayerHumanoid__18 = p79.PlayerHumanoid;
    local l__Camera__19 = p79.Camera;
    local l__Trove__20 = p79.Trove;
    if l__PlayerModel__17 and l__PlayerHumanoid__18 then
        local u80 = l__VineInspect__6:Clone();
        l__Trove__20:Add(u80);
        local u81 = l__PlayerModel__17:Clone();
        u81.PrimaryPart = u81.HumanoidRootPart;
        u81:PivotTo(u80.Player1:GetPivot());
        u81.Parent = u80;
        local u82 = u80.Player1["Vine Wrapper"]:Clone();
        u82.Parent = u81;
        local v83 = Instance.new("WeldConstraint");
        v83.Part0 = u82.Handle;
        v83.Part1 = u81["Right Arm"];
        v83.Parent = u81;
        u80.Player1:Destroy();
        u81.Name = "Player1";
        u80.Parent = workspace.Terrain;
        l__Camera__19.CameraType = Enum.CameraType.Scriptable;
        local u84 = l__RunService__2.RenderStepped:Connect(function(_) --[[ Line: 360 ]]
            -- upvalues: u80 (copy), l__Camera__19 (copy)
            if u80.Parent then
                workspace.CurrentCamera.CFrame = u80.Camera.Camera.CFrame;
                l__Camera__19.FieldOfView = 35;
            end;
        end);
        l__Trove__20:Add(u84);
        local v85 = { u2, u3, u4 };
        game:GetService("ContentProvider"):PreloadAsync(v85);
        local u86 = script.FadeIn:Clone();
        u86.Parent = game.Players.LocalPlayer.PlayerGui;
        u86.Frame.BackgroundTransparency = 0;
        l__Trove__20:Add(u86);
        repeat
            task.wait(0.25);
        until game:GetService("ContentProvider").RequestQueueSize == 0;
        if u80.Parent then
            local u87 = u81.Humanoid.Animator:LoadAnimation(u2);
            local u88 = u80.Player2.Humanoid.Animator:LoadAnimation(u3);
            local u89 = u80.Camera.AnimationController.Animator:LoadAnimation(u4);
            p79:ApplyRandomFriendAppearance(u80.Player2, nil, true);
            local v90 = {};
            workspace.CurrentCamera.FieldOfView = 35;
            local u91 = true;
            l__Trove__20:Add(u89:GetMarkerReachedSignal("Start"):Connect(function() --[[ Line: 397 ]]
                -- upvalues: u86 (copy)
                game.TweenService:Create(u86.Frame, TweenInfo.new(0.3), {
                    BackgroundTransparency = 1
                }):Play();
            end));
            if not u80:FindFirstChild("Temporary") then
                local v92 = Instance.new("Folder");
                v92.Name = "Temporary";
                v92.Parent = u80;
            end;
            local v93 = u89:GetMarkerReachedSignal("Chargeup");
            table.insert(v90, v93:Connect(function() --[[ Line: 409 ]]
                -- upvalues: l__VineWrapperController__5 (ref), u81 (copy), l__ReplicatedStorage__1 (ref), u5 (ref), u82 (copy), u91 (ref), u80 (copy)
                task.spawn(function() --[[ Line: 410 ]]
                    -- upvalues: l__VineWrapperController__5 (ref), u81 (ref), l__ReplicatedStorage__1 (ref), u5 (ref), u82 (ref), u91 (ref), u80 (ref)
                    local v94 = l__VineWrapperController__5.WrapCharacter(u81, l__ReplicatedStorage__1.Assets.VineArmTemplate);
                    game.TweenService:Create(u5, TweenInfo.new(1), {
                        EmissiveStrength = 2
                    }):Play();
                    for _, v95 in u82.Handle.VineEmitterAttachment:GetChildren() do
                        v95.Enabled = true;
                        v95:Emit(v95:GetAttribute("EmitCount"));
                    end;
                    u91 = true;
                    while u91 do
                        task.wait(0.1);
                        local v96 = u80 and u80.Parent;
                        if v96 then
                            v96 = u80:FindFirstChild("Temporary");
                        end;
                        if not v96 then
                            break;
                        end;
                        local u97 = Instance.new("Part");
                        u97.Size = Vector3.new(0.2, 0.2, 0.2);
                        u97.Color = ({ Color3.fromRGB(162, 227, 51), Color3.fromRGB(56, 158, 40), Color3.fromRGB(45, 141, 52) })[Random.new():NextInteger(1, 3)];
                        u97.Parent = v96;
                        u97.Anchored = true;
                        u97.CanCollide = false;
                        u97.CanTouch = false;
                        u97.CanQuery = false;
                        u97.MaterialVariant = u5.Name;
                        game.TweenService:Create(u97, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                            Size = Vector3.new(0.4, 0.4, 0.4)
                        }):Play();
                        local u98 = 0.8 / #u82.DetailEffect:GetChildren();
                        local u99 = nil;
                        task.spawn(function() --[[ Line: 446 ]]
                            -- upvalues: u82 (ref), u99 (ref), u98 (copy), u97 (copy)
                            for v100 = 1, #u82.DetailEffect:GetChildren() do
                                if not u82:FindFirstChild("DetailEffect") then
                                    return;
                                end;
                                local v101 = u82.DetailEffect:FindFirstChild((tostring(v100)));
                                if u99 == nil then
                                    u99 = v101;
                                else
                                    local v102 = 0;
                                    while v102 < u98 do
                                        v102 = v102 + game:GetService("RunService").Heartbeat:Wait();
                                        u97.CFrame = u99.CFrame:Lerp(v101.CFrame, v102 / u98);
                                    end;
                                    u99 = v101;
                                end;
                            end;
                            u97:Destroy();
                        end);
                    end;
                    v94();
                end);
            end));
            local u103 = nil;
            local u104 = nil;
            local v105 = u89:GetMarkerReachedSignal("CreateVine");
            table.insert(v90, v105:Connect(function() --[[ Line: 482 ]]
                -- upvalues: u5 (ref), u82 (copy), u103 (ref), u78 (ref), u80 (copy), u104 (ref), l__VineWrapperController__5 (ref), l__RunService__2 (ref), l__Trove__20 (copy)
                game.TweenService:Create(u5, TweenInfo.new(1), {
                    EmissiveStrength = 1
                }):Play();
                for _, v106 in u82.Handle.VineEmitterAttachment:GetChildren() do
                    v106:Emit(v106:GetAttribute("EmitCount"));
                end;
                local v107 = game.SoundService.SFX["Vine Cast"]:Clone();
                v107.Parent = u82.Handle;
                v107:Play();
                game.Debris:AddItem(v107, 3);
                u103 = u78(u82.Handle.VineEmitter.Position, u80.Player2.Torso.Position, u82.Handle.VineEmitter, u80.Temporary);
                u104 = l__VineWrapperController__5.WrapCharacter(u80.Player2);
                local u108 = nil;
                u108 = l__RunService__2.Heartbeat:Connect(function(p109) --[[ Line: 502 ]]
                    -- upvalues: u80 (ref), u108 (ref), u103 (ref)
                    if u80.Parent and u80.Temporary.Parent then
                        u103.UpdateGoal(u80.Player2.Torso.Position, p109);
                    else
                        if u108 then
                            u108:Disconnect();
                        end;
                    end;
                end);
                l__Trove__20:Add(u104);
                l__Trove__20:Add(u108);
            end));
            local v110 = u89:GetMarkerReachedSignal("VineDisconnect");
            table.insert(v90, v110:Connect(function() --[[ Line: 513 ]]
                -- upvalues: u103 (ref), u91 (ref), u104 (ref), u5 (ref), u82 (copy)
                if u103.Retract then
                    pcall(u103.Retract);
                end;
                u91 = false;
                u104();
                game.TweenService:Create(u5, TweenInfo.new(1), {
                    EmissiveStrength = 0
                }):Play();
                for _, v111 in u82.Handle.VineEmitterAttachment:GetChildren() do
                    v111:Emit(v111:GetAttribute("EmitCount"));
                    v111.Enabled = false;
                end;
                local v112 = game.SoundService.SFX.VineStrike:Clone();
                v112.Parent = u82.Handle;
                v112:Play();
                game.Debris:AddItem(v112, 3);
                local v113 = game.SoundService.SFX.VineCrumble:Clone();
                v113.Parent = u82.Handle;
                v113:Play();
                game.Debris:AddItem(v113, 2);
            end));
            local v114 = u89:GetMarkerReachedSignal("FadeOut");
            table.insert(v90, v114:Connect(function() --[[ Line: 543 ]]
                -- upvalues: u86 (copy)
                game.TweenService:Create(u86.Frame, TweenInfo.new(0.3), {
                    BackgroundTransparency = 0
                }):Play();
            end));
            u87.Looped = true;
            u88.Looped = true;
            u89.Looped = true;
            u87:Play();
            u88:Play();
            u89:Play();
            l__Camera__19.FieldOfView = 25;
            l__Trove__20:Add(function() --[[ Line: 562 ]]
                -- upvalues: u91 (ref), u103 (ref), u104 (ref), u86 (copy), u84 (ref), u87 (copy), u89 (copy), u88 (copy)
                u91 = false;
                if u103 and u103.Retract then
                    pcall(u103.Retract);
                end;
                if u104 then
                    u104();
                    u104 = nil;
                end;
                if u86 then
                    u86:Destroy();
                end;
                if u84 then
                    u84:Disconnect();
                end;
                if u87 then
                    u87:Stop();
                    u87:Destroy();
                end;
                if u89 then
                    u89:Stop();
                    u89:Destroy();
                end;
                if u88 then
                    u88:Stop();
                    u88:Destroy();
                end;
            end);
        end;
    end;
end;
return v1;