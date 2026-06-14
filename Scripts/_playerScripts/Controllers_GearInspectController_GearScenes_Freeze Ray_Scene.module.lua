-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__RunService__1 = game:GetService("RunService");
local u2 = Instance.new("Animation");
u2.AnimationId = "rbxassetid://135341385465559";
local u3 = Instance.new("Animation");
u3.AnimationId = "rbxassetid://88915834483502";
local u4 = Instance.new("Animation");
u4.AnimationId = "rbxassetid://83507025846411";
local l__FreezeInspect__2 = script.Parent.FreezeInspect;
l__FreezeInspect__2.Parent = nil;
function v1.Run(p5) --[[ Line: 22 ]]
    -- upvalues: l__FreezeInspect__2 (copy), l__RunService__1 (copy), u2 (copy), u3 (copy), u4 (copy)
    local _ = p5.Plot;
    local l__PlayerModel__3 = p5.PlayerModel;
    local l__PlayerHumanoid__4 = p5.PlayerHumanoid;
    local l__Camera__5 = p5.Camera;
    local l__Trove__6 = p5.Trove;
    if l__PlayerModel__3 and l__PlayerHumanoid__4 then
        local u6 = l__FreezeInspect__2:Clone();
        l__Trove__6:Add(u6);
        local v7 = l__PlayerModel__3:Clone();
        v7.PrimaryPart = v7.HumanoidRootPart;
        v7:PivotTo(u6.Player1:GetPivot());
        v7.Parent = u6;
        local u8 = u6.Player1["Freeze Ray"]:Clone();
        u8.Parent = v7;
        u6.Player1:Destroy();
        local v9 = Instance.new("WeldConstraint");
        v9.Part0 = u8.Handle;
        v9.Part1 = v7["Right Arm"];
        v9.Parent = v7;
        v7.Name = "Player1";
        u6.Parent = workspace.Terrain;
        l__Camera__5.CameraType = Enum.CameraType.Scriptable;
        local u10 = l__RunService__1.RenderStepped:Connect(function(_) --[[ Line: 66 ]]
            -- upvalues: u6 (copy), l__Camera__5 (copy)
            if u6.Parent then
                workspace.CurrentCamera.CFrame = u6.Camera.Camera.CFrame;
                l__Camera__5.FieldOfView = 35;
            end;
        end);
        l__Trove__6:Add(u10);
        local v11 = { u2, u3, u4 };
        game:GetService("ContentProvider"):PreloadAsync(v11);
        local u12 = script.FadeIn:Clone();
        u12.Parent = game.Players.LocalPlayer.PlayerGui;
        u12.Frame.BackgroundTransparency = 0;
        l__Trove__6:Add(u12);
        repeat
            task.wait(0.25);
        until game:GetService("ContentProvider").RequestQueueSize == 0;
        if u6.Parent then
            local u13 = v7.Humanoid.Animator:LoadAnimation(u2);
            local u14 = u6.Player2.Humanoid.Animator:LoadAnimation(u3);
            local u15 = u6.Camera.AnimationController.Animator:LoadAnimation(u4);
            local v16 = {};
            workspace.CurrentCamera.FieldOfView = 35;
            local u17 = nil;
            p5:ApplyRandomFriendAppearance(u6.Player2, nil, true);
            if u6.Parent then
                local function u21() --[[ Line: 109 ]]
                    local v18 = Instance.new("Part");
                    v18.Name = "FreezeRayShot";
                    v18.Color = Color3.fromRGB(100, 180, 255);
                    v18.Material = Enum.Material.Neon;
                    v18.Shape = Enum.PartType.Block;
                    v18.Size = Vector3.new(0.3, 0.3, 3);
                    v18.TopSurface = Enum.SurfaceType.Smooth;
                    v18.BottomSurface = Enum.SurfaceType.Smooth;
                    v18.CanCollide = false;
                    v18.Anchored = true;
                    v18.Locked = true;
                    v18.CastShadow = false;
                    local v19 = Instance.new("PointLight");
                    v19.Color = Color3.fromRGB(100, 180, 255);
                    v19.Brightness = 1;
                    v19.Range = 8;
                    v19.Parent = v18;
                    local v20 = Instance.new("SelectionBox");
                    v20.Adornee = v18;
                    v20.Color = BrickColor.new("Toothpaste");
                    v20.Parent = v18;
                    return v18;
                end;
                local v22 = u15:GetMarkerReachedSignal("ChargeGun");
                table.insert(v16, v22:Connect(function() --[[ Line: 140 ]]
                    -- upvalues: u8 (copy)
                    for _, u23 in u8.EmissivePart:GetChildren() do
                        if u23:IsA("SurfaceAppearance") then
                            game.TweenService:Create(u23, TweenInfo.new(0.3), {
                                EmissiveStrength = 4
                            }):Play();
                            task.delay(0.3, function() --[[ Line: 145 ]]
                                -- upvalues: u23 (copy)
                                if u23 then
                                    game.TweenService:Create(u23, TweenInfo.new(0.2), {
                                        EmissiveStrength = 3
                                    }):Play();
                                end;
                            end);
                        elseif u23:IsA("ParticleEmitter") then
                            u23:Emit(u23:GetAttribute("EmitCount") or 1);
                            u23.Enabled = true;
                        end;
                    end;
                    game.TweenService:Create(u8.Ice.SurfaceAppearance, TweenInfo.new(0.3), {
                        EmissiveStrength = 4
                    }):Play();
                    task.delay(0.3, function() --[[ Line: 160 ]]
                        -- upvalues: u8 (ref)
                        if u8:FindFirstChild("Ice") and u8.Ice:FindFirstChild("SurfaceAppearance") then
                            game.TweenService:Create(u8.Ice.SurfaceAppearance, TweenInfo.new(0.2), {
                                EmissiveStrength = 3
                            }):Play();
                        end;
                    end);
                end));
                local v24 = u15:GetMarkerReachedSignal("Fire");
                table.insert(v16, v24:Connect(function() --[[ Line: 169 ]]
                    -- upvalues: u8 (copy), u6 (copy), u21 (copy)
                    for _, u25 in u8:GetDescendants() do
                        if u25:IsA("SurfaceAppearance") then
                            game.TweenService:Create(u25, TweenInfo.new(0.3), {
                                EmissiveStrength = 4
                            }):Play();
                            task.delay(0.3, function() --[[ Line: 174 ]]
                                -- upvalues: u25 (copy)
                                if u25 then
                                    game.TweenService:Create(u25, TweenInfo.new(0.2), {
                                        EmissiveStrength = 3
                                    }):Play();
                                end;
                            end);
                        end;
                    end;
                    local v26 = game.SoundService.SFX.FreezeRay:Clone();
                    v26.TimePosition = 0.1;
                    v26:Play();
                    v26.Parent = u8.Handle;
                    game.Debris:AddItem(v26, 3);
                    for _, v27 in u8.Nozzle.Attachment:GetChildren() do
                        v27:Emit(v27:GetAttribute("EmitCount") or 1);
                    end;
                    local v28 = CFrame.new(u8.Nozzle.CFrame.Position, u6.Player2.Torso.Position);
                    local u29 = u21();
                    u29.CFrame = v28 + v28.LookVector * 1.5;
                    u29.Parent = u6;
                    game.Debris:AddItem(u29, 0.15);
                    local u30 = 0;
                    task.spawn(function() --[[ Line: 208 ]]
                        -- upvalues: u30 (ref), u29 (copy)
                        while u30 < 0.15 and u29 do
                            local v31 = game:GetService("RunService").Heartbeat:Wait();
                            u30 = u30 + v31;
                            local v32 = u29;
                            v32.CFrame = v32.CFrame * CFrame.new(0, 0, -120 * v31);
                        end;
                    end);
                end));
                local v33 = u15:GetMarkerReachedSignal("Freeze");
                table.insert(v16, v33:Connect(function() --[[ Line: 218 ]]
                    -- upvalues: u17 (ref), u6 (copy)
                    u17 = game.ReplicatedStorage.Assets.Ice_Part:Clone();
                    u17.CFrame = CFrame.new(u6.Player2.Torso.Position);
                    local v34 = Instance.new("WeldConstraint");
                    v34.Part0 = u17;
                    v34.Part1 = u6.Player2.Torso;
                    v34.Parent = u17;
                    u17.Transparency = 0;
                    local v35 = game.SoundService.SFX.Freeze:Clone();
                    v35.Parent = u17;
                    v35.TimePosition = 0;
                    v35.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                    v35.Playing = true;
                    game.Debris:AddItem(v35, v35.TimeLength * v35.PlaybackSpeed);
                    u17.Parent = u6;
                    local v36 = script.Highlight:Clone();
                    v36.Parent = u17;
                    v36.Enabled = true;
                    v36.Adornee = u17;
                    game.TweenService:Create(v36, TweenInfo.new(0.1), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    }):Play();
                    game.Debris:AddItem(v36, 0.1);
                    task.delay(0.1, function() --[[ Line: 248 ]]
                        -- upvalues: u17 (ref)
                        game.TweenService:Create(u17, TweenInfo.new(0.1), {
                            Transparency = 0.4
                        }):Play();
                    end);
                    for _, u37 in u17:GetChildren() do
                        if u37:IsA("ParticleEmitter") then
                            u37:Emit(u37:GetAttribute("EmitCount") or 0);
                        elseif u37:IsA("PointLight") then
                            game.TweenService:Create(u37, TweenInfo.new(0.1), {
                                Brightness = 6
                            }):Play();
                            task.delay(0.3, function() --[[ Line: 258 ]]
                                -- upvalues: u37 (copy)
                                game.TweenService:Create(u37, TweenInfo.new(0.1), {
                                    Brightness = 1
                                }):Play();
                            end);
                        end;
                    end;
                end));
                local v38 = u15:GetMarkerReachedSignal("PowerDown");
                table.insert(v16, v38:Connect(function() --[[ Line: 267 ]]
                    -- upvalues: u8 (copy)
                    for _, v39 in u8:GetDescendants() do
                        if v39:IsA("SurfaceAppearance") then
                            game.TweenService:Create(v39, TweenInfo.new(1), {
                                EmissiveStrength = 0
                            }):Play();
                        end;
                    end;
                end));
                local v40 = u15:GetMarkerReachedSignal("Start");
                table.insert(v16, v40:Connect(function() --[[ Line: 280 ]]
                    -- upvalues: u8 (copy), u12 (copy), u17 (ref)
                    for _, v41 in u8:GetDescendants() do
                        if v41:IsA("ParticleEmitter") then
                            v41:Clear();
                        end;
                    end;
                    u8.EmissivePart.SurfaceAppearance.EmissiveStrength = 0;
                    u8.Ice.SurfaceAppearance.EmissiveStrength = 0;
                    game.TweenService:Create(u12.Frame, TweenInfo.new(0.3), {
                        BackgroundTransparency = 1
                    }):Play();
                    if u17 then
                        u17:Destroy();
                    end;
                end));
                local v42 = u15:GetMarkerReachedSignal("FadeOut");
                table.insert(v16, v42:Connect(function() --[[ Line: 299 ]]
                    -- upvalues: u12 (copy)
                    game.TweenService:Create(u12.Frame, TweenInfo.new(0.3), {
                        BackgroundTransparency = 0
                    }):Play();
                end));
                u13.Looped = true;
                u14.Looped = true;
                u15.Looped = true;
                u13:Play();
                u14:Play();
                u15:Play();
                l__Camera__5.FieldOfView = 25;
                l__Trove__6:Add(function() --[[ Line: 317 ]]
                    -- upvalues: u17 (ref), u12 (copy), u10 (ref), u13 (copy), u15 (copy), u14 (copy)
                    if u17 then
                        u17:Destroy();
                    end;
                    if u12 then
                        u12:Destroy();
                    end;
                    if u10 then
                        u10:Disconnect();
                    end;
                    if u13 then
                        u13:Stop();
                        u13:Destroy();
                    end;
                    if u15 then
                        u15:Stop();
                        u15:Destroy();
                    end;
                    if u14 then
                        u14:Stop();
                        u14:Destroy();
                    end;
                end);
            end;
        end;
    end;
end;
return v1;