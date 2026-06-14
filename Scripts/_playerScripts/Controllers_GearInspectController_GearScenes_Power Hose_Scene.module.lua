-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local u2 = Instance.new("Animation");
u2.AnimationId = "rbxassetid://115826940676460";
local u3 = Instance.new("Animation");
u3.AnimationId = "rbxassetid://94444226083144";
local u4 = Instance.new("Animation");
u4.AnimationId = "rbxassetid://130479531142776";
local l__HoseInspect__2 = script.Parent.HoseInspect;
l__HoseInspect__2.Parent = nil;
function v1.Run(p5) --[[ Line: 24 ]]
    -- upvalues: l__HoseInspect__2 (copy), l__RunService__1 (copy), u2 (copy), u3 (copy), u4 (copy)
    local _ = p5.Plot;
    local l__PlayerModel__3 = p5.PlayerModel;
    local l__PlayerHumanoid__4 = p5.PlayerHumanoid;
    local l__Camera__5 = p5.Camera;
    local l__Trove__6 = p5.Trove;
    if l__PlayerModel__3 and l__PlayerHumanoid__4 then
        local u6 = l__HoseInspect__2:Clone();
        l__Trove__6:Add(u6);
        local v7 = l__PlayerModel__3:Clone();
        v7.PrimaryPart = v7.HumanoidRootPart;
        v7:PivotTo(u6.Player1:GetPivot());
        v7.Parent = u6;
        local u8 = u6.Player1["Power Hose"]:Clone();
        u8.Parent = v7;
        local v9 = u6.Player1.PowerWasherBack:Clone();
        v9.Parent = v7;
        v9:SetPrimaryPartCFrame(v7.Torso.CFrame);
        u6.Player1:Destroy();
        local v10 = Instance.new("WeldConstraint");
        v10.Part0 = u8.Handle;
        v10.Part1 = v7["Right Arm"];
        v10.Parent = v7;
        local v11 = Instance.new("WeldConstraint");
        v11.Part0 = v9.Prim;
        v11.Part1 = v7.Torso;
        v11.Parent = v7;
        v7.Name = "Player1";
        u6.Parent = workspace.Terrain;
        l__Camera__5.CameraType = Enum.CameraType.Scriptable;
        local u12 = l__RunService__1.RenderStepped:Connect(function(_) --[[ Line: 78 ]]
            -- upvalues: u6 (copy), l__Camera__5 (copy)
            if u6.Parent then
                workspace.CurrentCamera.CFrame = u6.Camera.Camera.CFrame;
                l__Camera__5.FieldOfView = 35;
            end;
        end);
        l__Trove__6:Add(u12);
        local v13 = { u2, u3, u4 };
        game:GetService("ContentProvider"):PreloadAsync(v13);
        local u14 = script.FadeIn:Clone();
        u14.Parent = game.Players.LocalPlayer.PlayerGui;
        u14.Frame.BackgroundTransparency = 0;
        l__Trove__6:Add(u14);
        repeat
            task.wait(0.25);
        until game:GetService("ContentProvider").RequestQueueSize == 0;
        if u6.Parent then
            local u15 = v7.Humanoid.Animator:LoadAnimation(u2);
            local u16 = u6.Player2.Humanoid.Animator:LoadAnimation(u3);
            local u17 = u6.Camera.AnimationController.Animator:LoadAnimation(u4);
            local v18 = {};
            workspace.CurrentCamera.FieldOfView = 20;
            p5:ApplyRandomFriendAppearance(u6.Player2, nil, true);
            if u6.Parent then
                local v19 = nil;
                local u20 = nil;
                local u21 = nil;
                local function v27(p22, p23, p24) --[[ Line: 128 ]]
                    local v25 = p24.CFrame:Inverse() * p23.CFrame;
                    local l__Parent__7 = p22.Parent;
                    p22:Destroy();
                    local v26 = Instance.new("Weld");
                    v26.Name = "PowerHose_WaterWeld";
                    v26.Part0 = p24;
                    v26.Part1 = p23;
                    v26.C0 = v25;
                    v26.C1 = CFrame.new();
                    v26.Parent = l__Parent__7;
                    return v26, v25, CFrame.new();
                end;
                local u28 = v9:FindFirstChild("Water");
                local l__Size__8 = u28.Size;
                local u35, v36 = (function(p29) --[[ Name: FindWeldForWater, Line 149 ]]
                    local v30 = {};
                    local l__Parent__9 = p29.Parent;
                    local v31 = l__Parent__9 and l__Parent__9:FindFirstChild("Prim");
                    if v31 then
                        table.insert(v30, v31);
                    end;
                    table.insert(v30, p29);
                    if l__Parent__9 then
                        table.insert(v30, l__Parent__9);
                    end;
                    local v32 = p29:FindFirstAncestorWhichIsA("Model");
                    if v32 then
                        table.insert(v30, v32);
                    end;
                    for _, v33 in v30 do
                        for _, v34 in (v33 == p29 or v33 == l__Parent__9) and v33:GetChildren() or v33:GetDescendants() do
                            if v34:IsA("WeldConstraint") then
                                if v34.Part0 == p29 then
                                    return v34, v34.Part1;
                                end;
                                if v34.Part1 == p29 then
                                    return v34, v34.Part0;
                                end;
                            end;
                            if v34:IsA("JointInstance") and (v34.Part0 == p29 or v34.Part1 == p29) then
                                return v34, v34.Part0 == p29 and v34.Part1 or v34.Part0;
                            end;
                        end;
                    end;
                    return nil, nil;
                end)(u28);
                if u35 then
                    local _ = u35.Parent;
                    if u35:IsA("WeldConstraint") then
                        u35, u20, u21 = v27(u35, u28, v36);
                    elseif u35:IsA("JointInstance") then
                        u20 = u35.C0;
                        u21 = u35.C1;
                    else
                        u35 = v19;
                    end;
                else
                    u35 = v19;
                end;
                local v37 = l__Size__8;
                local v38 = math.max(v37.Y * 1, 0.001);
                u28.Size = Vector3.new(v37.X, v38, v37.Z);
                local v39 = (v37.Y - v38) / 2;
                if u35 then
                    u35.C0 = u20 * CFrame.new(0, -v39, 0);
                end;
                local u40 = nil;
                local v41 = u17:GetMarkerReachedSignal("Start");
                table.insert(v18, v41:Connect(function() --[[ Line: 239 ]]
                    -- upvalues: u40 (ref), u14 (copy), u8 (copy), u35 (ref), l__Size__8 (ref), u20 (ref), u21 (ref), u28 (copy)
                    if u40 then
                        u40:Destroy();
                    end;
                    game.TweenService:Create(u14.Frame, TweenInfo.new(0.3), {
                        BackgroundTransparency = 1
                    }):Play();
                    for _, v42 in u8.Nozzle.VFX:GetChildren() do
                        v42.Enabled = false;
                        v42:Clear();
                    end;
                    local v43 = u35;
                    local v44 = l__Size__8;
                    local v45 = u20;
                    local v46 = math.max(v44.Y * 1, 0.001);
                    u28.Size = Vector3.new(v44.X, v46, v44.Z);
                    local v47 = (v44.Y - v46) / 2;
                    if v43 then
                        v43.C0 = v45 * CFrame.new(0, -v47, 0);
                    end;
                end));
                local v48 = u17:GetMarkerReachedSignal("Fire");
                table.insert(v18, v48:Connect(function() --[[ Line: 254 ]]
                    -- upvalues: u8 (copy), u40 (ref), u17 (copy), u35 (ref), l__Size__8 (ref), u20 (ref), u21 (ref), u28 (copy)
                    for _, v49 in u8.Nozzle.VFX:GetChildren() do
                        v49:Emit(v49:GetAttribute("EmitCount") or 3);
                        v49.Enabled = true;
                    end;
                    u40 = game.SoundService.SFX.PowerHose:Clone();
                    u40.Parent = u8.Nozzle;
                    u40.TimePosition = 0;
                    u40.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    u40.Playing = true;
                    game.Debris:AddItem(u40, u40.TimeLength * u40.PlaybackSpeed);
                    task.spawn(function() --[[ Line: 271 ]]
                        -- upvalues: u17 (ref), u35 (ref), l__Size__8 (ref), u20 (ref), u21 (ref), u28 (ref)
                        local v50 = 0;
                        while u17 and v50 < 3 do
                            v50 = v50 + game:GetService("RunService").Heartbeat:Wait();
                            local v51 = u35;
                            local v52 = l__Size__8;
                            local v53 = u20;
                            local v54 = 1 - math.clamp(v50 / 3, 0, 1);
                            local v55 = v52.Y * math.clamp(v54, 0, 1);
                            local v56 = math.max(v55, 0.001);
                            u28.Size = Vector3.new(v52.X, v56, v52.Z);
                            local v57 = (v52.Y - v56) / 2;
                            if v51 then
                                v51.C0 = v53 * CFrame.new(0, -v57, 0);
                            end;
                        end;
                    end);
                end));
                local v58 = u17:GetMarkerReachedSignal("OffScreenTurnOff");
                table.insert(v18, v58:Connect(function() --[[ Line: 287 ]]
                    -- upvalues: u8 (copy)
                    for _, v59 in u8.Nozzle.VFX:GetChildren() do
                        v59.Enabled = false;
                    end;
                end));
                local v60 = u17:GetMarkerReachedSignal("FadeOut");
                table.insert(v18, v60:Connect(function() --[[ Line: 292 ]]
                    -- upvalues: u14 (copy)
                    game.TweenService:Create(u14.Frame, TweenInfo.new(0.3), {
                        BackgroundTransparency = 0
                    }):Play();
                end));
                u15.Looped = true;
                u16.Looped = true;
                u17.Looped = true;
                u15:Play();
                u16:Play();
                u17:Play();
                l__Camera__5.FieldOfView = 20;
                l__Trove__6:Add(function() --[[ Line: 311 ]]
                    -- upvalues: u14 (copy), u12 (ref), u15 (copy), u17 (copy), u16 (copy)
                    if u14 then
                        u14:Destroy();
                    end;
                    if u12 then
                        u12:Disconnect();
                    end;
                    if u15 then
                        u15:Stop();
                        u15:Destroy();
                    end;
                    if u17 then
                        u17:Stop();
                        u17:Destroy();
                    end;
                    if u16 then
                        u16:Stop();
                        u16:Destroy();
                    end;
                end);
            end;
        end;
    end;
end;
return v1;