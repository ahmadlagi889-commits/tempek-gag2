-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Lighting__1 = game:GetService("Lighting");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__Players__5 = game:GetService("Players");
local l__SoundService__6 = game:GetService("SoundService");
local l__Networking__7 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__LocalPlayer__8 = l__Players__5.LocalPlayer;
local l__Baseplate__9 = game.Workspace.Baseplate;
local l__Grass__10 = game.Workspace.Map.Middle.Grass;
local u2 = {};
PhysicalProperties.new(0.919, 0.01, 0.15, 100, 1);
local u3 = Color3.fromRGB(255, 255, 255);
local l__NotificationController__11 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__Snowfall__12 = l__ReplicatedStorage__3.Assets:WaitForChild("Snowfall");
local u4 = {
    Brightness = 2,
    EnvironmentDiffuseScale = 1,
    ClockTime = 0,
    Ambient = Color3.fromRGB(57, 121, 131),
    ColorShift_Bottom = Color3.fromRGB(35, 135, 171),
    ColorShift_Top = Color3.fromRGB(59, 158, 250),
    OutdoorAmbient = Color3.fromRGB(74, 139, 180)
};
local u5 = Color3.fromRGB(100, 200, 255);
local u6 = Color3.fromRGB(60, 150, 220);
local l__LaserBeam__13 = l__SoundService__6:WaitForChild("SFX"):WaitForChild("LaserBeam");
local u7 = Color3.fromRGB(120, 210, 255);
local u8 = {
    Color3.fromRGB(100, 200, 255),
    Color3.fromRGB(150, 220, 255),
    Color3.fromRGB(60, 170, 240),
    Color3.fromRGB(180, 230, 255),
    Color3.fromRGB(40, 140, 220),
    Color3.fromRGB(200, 240, 255)
};
local l__Snowfall__14 = l__SoundService__6:WaitForChild("MusicTracks"):WaitForChild("Snowfall");
local u9 = false;
local u10 = {};
local u11 = nil;
local u12 = nil;
local u13 = 0;
local u14 = 0;
local u15 = 0;
local u16 = 0;
local u17 = {};
local _ = workspace.CurrentCamera;
local u18 = Random.new();
local u19 = Instance.new("Folder");
u19.Name = "BlizzardBeams";
u19.Parent = workspace;
local function u23(p20) --[[ Line: 170 ]]
    -- upvalues: u18 (copy)
    local l__Size__15 = p20.Size;
    local l__CFrame__16 = p20.CFrame;
    local v21 = u18:NextNumber(-l__Size__15.X / 2, l__Size__15.X / 2);
    local v22 = u18:NextNumber(-l__Size__15.Y / 2, l__Size__15.Y / 2);
    return l__CFrame__16:PointToWorldSpace((Vector3.new(v21, v22, u18:NextNumber(-l__Size__15.Z / 2, l__Size__15.Z / 2))));
end;
local function u26() --[[ Line: 180 ]]
    -- upvalues: l__Snowfall__14 (copy)
    local v24 = 0;
    for _, v25 in l__Snowfall__14:GetChildren() do
        if v25:IsA("Sound") and (v25.IsPlaying and v24 < v25.PlaybackLoudness) then
            v24 = v25.PlaybackLoudness;
        end;
    end;
    return v24;
end;
local function u33() --[[ Line: 221 ]]
    -- upvalues: u2 (copy), u3 (copy), l__RunService__4 (copy), l__Baseplate__9 (copy), l__Grass__10 (copy)
    local u27 = os.clock();
    local u28 = 0;
    local function v30(p29) --[[ Line: 228 ]]
        -- upvalues: u2 (ref), u3 (ref), u28 (ref), u27 (ref), l__RunService__4 (ref)
        if p29:IsA("BasePart") then
            u2[p29] = {
                Color = p29.Color
            };
            p29.Color = u3;
            u28 = u28 + 1;
            if u28 >= 50 and os.clock() - u27 >= 0.004 then
                l__RunService__4.Heartbeat:Wait();
                u27 = os.clock();
                u28 = 0;
            end;
        end;
    end;
    for _, v31 in l__Baseplate__9:GetChildren() do
        v30(v31);
    end;
    for _, v32 in l__Grass__10:GetDescendants() do
        v30(v32);
    end;
end;
local u34 = nil;
local u35 = false;
local function u36() --[[ Line: 281 ]]
    -- upvalues: u34 (ref), l__TweenService__2 (copy), l__Lighting__1 (copy), u4 (copy)
    if u34 then
        u34:Cancel();
    end;
    u34 = l__TweenService__2:Create(l__Lighting__1, TweenInfo.new(3, Enum.EasingStyle.Sine), {
        Ambient = u4.Ambient,
        Brightness = u4.Brightness,
        ColorShift_Bottom = u4.ColorShift_Bottom,
        ColorShift_Top = u4.ColorShift_Top,
        EnvironmentDiffuseScale = u4.EnvironmentDiffuseScale,
        OutdoorAmbient = u4.OutdoorAmbient,
        ClockTime = u4.ClockTime
    });
    u34:Play();
end;
local function u37() --[[ Line: 296 ]]
    -- upvalues: u35 (ref), u34 (ref), l__TweenService__2 (copy), l__Lighting__1 (copy), u10 (copy)
    if u35 then
        if u34 then
            u34:Cancel();
        end;
        u34 = l__TweenService__2:Create(l__Lighting__1, TweenInfo.new(3, Enum.EasingStyle.Sine), {
            Ambient = u10.Ambient,
            Brightness = u10.Brightness,
            ColorShift_Bottom = u10.ColorShift_Bottom,
            ColorShift_Top = u10.ColorShift_Top,
            EnvironmentDiffuseScale = u10.EnvironmentDiffuseScale,
            OutdoorAmbient = u10.OutdoorAmbient,
            ClockTime = u10.ClockTime
        });
        u34:Play();
        u35 = false;
    end;
end;
local function u43() --[[ Line: 338 ]]
    -- upvalues: u11 (ref), l__Snowfall__12 (copy), l__TweenService__2 (copy)
    if u11 then
    else
        u11 = l__Snowfall__12:Clone();
        u11.Name = "ActiveBlizzard";
        local v38 = {};
        for _, v39 in u11:GetDescendants() do
            if v39:IsA("BasePart") then
                if v39:GetAttribute("OGTransparency") == nil then
                    v39:SetAttribute("OGTransparency", v39.Transparency);
                end;
                v39.Transparency = 1;
                table.insert(v38, v39);
            end;
        end;
        u11.Parent = workspace;
        local u40 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        for v41, u42 in v38 do
            task.delay(v41 * 0.05, function() --[[ Line: 359 ]]
                -- upvalues: u42 (copy), l__TweenService__2 (ref), u40 (copy)
                if u42 and u42.Parent then
                    l__TweenService__2:Create(u42, u40, {
                        Transparency = u42:GetAttribute("OGTransparency")
                    }):Play();
                end;
            end);
        end;
    end;
end;
local function u49() --[[ Line: 367 ]]
    -- upvalues: u11 (ref), l__TweenService__2 (copy)
    if u11 then
        local v44 = {};
        for _, v45 in u11:GetDescendants() do
            if v45:IsA("BasePart") then
                table.insert(v44, v45);
            end;
        end;
        local v46 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        for _, v47 in v44 do
            l__TweenService__2:Create(v47, v46, {
                Transparency = 1
            }):Play();
        end;
        local u48 = u11;
        u11 = nil;
        task.delay(2.1, function() --[[ Line: 384 ]]
            -- upvalues: u48 (copy)
            if u48 and u48.Parent then
                u48:Destroy();
            end;
        end);
    end;
end;
local function u71(p50) --[[ Line: 395 ]]
    -- upvalues: u8 (copy), u18 (copy), u19 (copy), l__TweenService__2 (copy)
    for v51 = 1, 16 do
        local v52 = v51 / 16 * 3.141592653589793 * 2;
        local u53 = Instance.new("Part");
        u53.Size = Vector3.new(5, 0.8, 5);
        u53.CFrame = CFrame.new(p50) * CFrame.Angles(0, v52, 0);
        u53.Anchored = false;
        u53.CanCollide = false;
        u53.CanQuery = false;
        u53.CanTouch = false;
        u53.CastShadow = false;
        u53.Material = Enum.Material.Neon;
        u53.Color = u8[u18:NextInteger(1, #u8)];
        u53.Transparency = 0;
        u53.Parent = u19;
        local v54 = 120 * (0.8 + u18:NextNumber() * 0.4);
        local v55 = u18:NextNumber(10, 25);
        local v56 = math.cos(v52) * v54;
        local v57 = math.sin(v52) * v54;
        u53.AssemblyLinearVelocity = Vector3.new(v56, v55, v57);
        local v58 = u18:NextNumber(-10, 10);
        local v59 = u18:NextNumber(-10, 10);
        u53.AssemblyAngularVelocity = Vector3.new(v58, v59, u18:NextNumber(-10, 10));
        l__TweenService__2:Create(u53, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1,
            Size = Vector3.new(0.3, 0.1, 0.3)
        }):Play();
        task.delay(1.1, function() --[[ Line: 431 ]]
            -- upvalues: u53 (copy)
            u53:Destroy();
        end);
    end;
    for _ = 1, 10 do
        local u60 = Instance.new("Part");
        u60.Size = Vector3.new(2, 2, 2) + Vector3.new(3, 3, 3) * u18:NextNumber(0, 1);
        local v61 = u18:NextNumber(-2, 2);
        local v62 = u18:NextNumber(0, 3);
        u60.Position = p50 + Vector3.new(v61, v62, u18:NextNumber(-2, 2));
        u60.Anchored = false;
        u60.CanCollide = false;
        u60.CanQuery = false;
        u60.CanTouch = false;
        u60.CastShadow = false;
        u60.Material = Enum.Material.Neon;
        u60.Color = u8[u18:NextInteger(1, #u8)];
        u60.Transparency = 0;
        u60.Parent = u19;
        local v63 = u18:NextNumber(0, 6.283185307179586);
        local v64 = 80 * (0.5 + u18:NextNumber() * 0.5);
        local v65 = math.cos(v63) * v64;
        local v66 = 80 * (0.6 + u18:NextNumber() * 0.8);
        local v67 = math.sin(v63) * v64;
        u60.AssemblyLinearVelocity = Vector3.new(v65, v66, v67);
        local v68 = u18:NextNumber(-15, 15);
        local v69 = u18:NextNumber(-15, 15);
        u60.AssemblyAngularVelocity = Vector3.new(v68, v69, u18:NextNumber(-15, 15));
        l__TweenService__2:Create(u60, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1,
            Size = Vector3.new(0.2, 0.2, 0.2)
        }):Play();
        task.delay(1.3, function() --[[ Line: 475 ]]
            -- upvalues: u60 (copy)
            u60:Destroy();
        end);
    end;
    local u70 = Instance.new("Part");
    u70.Shape = Enum.PartType.Ball;
    u70.Size = Vector3.new(17, 17, 17);
    u70.Position = p50;
    u70.Anchored = true;
    u70.CanCollide = false;
    u70.CanQuery = false;
    u70.CanTouch = false;
    u70.CastShadow = false;
    u70.Material = Enum.Material.Neon;
    u70.Color = Color3.fromRGB(150, 220, 255);
    u70.Transparency = 0;
    u70.Parent = u19;
    l__TweenService__2:Create(u70, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(100, 100, 100),
        Transparency = 1
    }):Play();
    task.delay(0.35, function() --[[ Line: 501 ]]
        -- upvalues: u70 (copy)
        u70:Destroy();
    end);
end;
local function u94(u72) --[[ Line: 530 ]]
    -- upvalues: u11 (ref), u5 (copy), u19 (copy), u6 (copy), u7 (copy), u18 (copy), u17 (ref), l__LaserBeam__13 (copy), l__TweenService__2 (copy), u71 (copy), l__LocalPlayer__8 (copy)
    local v73;
    if u11 then
        v73 = u11:FindFirstChild("START_PART");
    else
        v73 = nil;
    end;
    if v73 then
        local l__Position__17 = v73.Position;
        local v74 = u5;
        local u75 = Instance.new("Part");
        u75.Anchored = true;
        u75.CanCollide = false;
        u75.CanQuery = false;
        u75.CanTouch = false;
        u75.CastShadow = false;
        u75.Material = Enum.Material.Neon;
        u75.Color = v74;
        u75.Transparency = 1;
        u75.Parent = u19;
        local v76 = u6;
        local u77 = Instance.new("Part");
        u77.Anchored = true;
        u77.CanCollide = false;
        u77.CanQuery = false;
        u77.CanTouch = false;
        u77.CastShadow = false;
        u77.Material = Enum.Material.Neon;
        u77.Color = v76;
        u77.Transparency = 1;
        u77.Parent = u19;
        local v78 = u72 + Vector3.new(0, -15, 0);
        local l__Magnitude__18 = (v78 - l__Position__17).Magnitude;
        u75.Size = Vector3.new(30, 30, l__Magnitude__18);
        u75.CFrame = CFrame.lookAt(l__Position__17, v78) * CFrame.new(0, 0, -l__Magnitude__18 / 2);
        local l__Magnitude__19 = (v78 - l__Position__17).Magnitude;
        u77.Size = Vector3.new(45, 45, l__Magnitude__19);
        u77.CFrame = CFrame.lookAt(l__Position__17, v78) * CFrame.new(0, 0, -l__Magnitude__19 / 2);
        local u79 = Instance.new("Part");
        u79.Shape = Enum.PartType.Ball;
        u79.Size = Vector3.new(3, 3, 3);
        u79.Position = u72;
        u79.Anchored = true;
        u79.CanCollide = false;
        u79.CanQuery = false;
        u79.CanTouch = false;
        u79.CastShadow = false;
        u79.Material = Enum.Material.Neon;
        u79.Color = u7;
        u79.Transparency = 1;
        u79.Parent = u19;
        local u80 = {
            alive = true,
            beam = u75,
            glow = u77,
            startPos = l__Position__17,
            hitPos = u72,
            birthTime = os.clock(),
            seedX = u18:NextNumber(0, 100),
            seedZ = u18:NextNumber(0, 100)
        };
        table.insert(u17, u80);
        local u81 = l__LaserBeam__13:Clone();
        u81.Volume = 8;
        u81.RollOffMaxDistance = 300;
        u81.RollOffMinDistance = 20;
        u81.Parent = v73;
        u81:Play();
        u81.Ended:Once(function() --[[ Line: 579 ]]
            -- upvalues: u81 (copy)
            u81:Destroy();
        end);
        local u82 = Instance.new("Part");
        u82.Size = Vector3.new(1, 1, 1);
        u82.Position = u72;
        u82.Anchored = true;
        u82.CanCollide = false;
        u82.CanQuery = false;
        u82.CanTouch = false;
        u82.Transparency = 1;
        u82.Parent = u19;
        local v83 = l__LaserBeam__13:Clone();
        v83.Volume = 7;
        v83.PlaybackSpeed = 0.6 + u18:NextNumber() * 0.5;
        v83.RollOffMaxDistance = 200;
        v83.RollOffMinDistance = 15;
        v83.Parent = u82;
        v83:Play();
        v83.Ended:Once(function() --[[ Line: 601 ]]
            -- upvalues: u82 (copy)
            u82:Destroy();
        end);
        local v84 = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        l__TweenService__2:Create(u75, v84, {
            Transparency = 0
        }):Play();
        l__TweenService__2:Create(u77, v84, {
            Transparency = 0.5
        }):Play();
        l__TweenService__2:Create(u79, v84, {
            Transparency = 0.1
        }):Play();
        task.delay(0.06, function() --[[ Line: 612 ]]
            -- upvalues: l__TweenService__2 (ref), u79 (copy), u71 (ref), u72 (copy)
            l__TweenService__2:Create(u79, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(12, 12, 12),
                Transparency = 0.5
            }):Play();
            u71(u72);
        end);
        task.delay(0.31, function() --[[ Line: 623 ]]
            -- upvalues: l__TweenService__2 (ref), u75 (copy), u77 (copy), u79 (copy), u80 (copy), u17 (ref)
            local v85 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            l__TweenService__2:Create(u75, v85, {
                Transparency = 1
            }):Play();
            l__TweenService__2:Create(u77, v85, {
                Transparency = 1
            }):Play();
            l__TweenService__2:Create(u79, v85, {
                Transparency = 1
            }):Play();
            task.delay(0.4, function() --[[ Line: 629 ]]
                -- upvalues: u80 (ref)
                u80.alive = false;
            end);
            task.delay(0.9, function() --[[ Line: 633 ]]
                -- upvalues: u75 (ref), u77 (ref), u79 (ref), u17 (ref), u80 (ref)
                u75:Destroy();
                u77:Destroy();
                u79:Destroy();
                for v86 = #u17, 1, -1 do
                    if u17[v86] == u80 then
                        table.remove(u17, v86);
                        return;
                    end;
                end;
            end);
        end);
        local l__Character__20 = l__LocalPlayer__8.Character;
        local v87 = l__Character__20 and l__Character__20:FindFirstChild("HumanoidRootPart");
        if v87 then
            local l__Magnitude__21 = (v87.Position - u72).Magnitude;
            if l__Magnitude__21 <= 25 then
                local v88 = 1 - l__Magnitude__21 / 25;
                local v89 = 120 * v88 * v88;
                local v90 = v87.Position - u72;
                local v91 = Vector3.new(v90.X, 0, v90.Z);
                local v92;
                if v91.Magnitude > 0.1 then
                    v92 = v91.Unit;
                else
                    local v93 = u18:NextNumber(-1, 1);
                    v92 = Vector3.new(v93, 0, u18:NextNumber(-1, 1)).Unit;
                end;
                v87.AssemblyLinearVelocity = Vector3.new(v92.X * v89 * 0.5, v89, v92.Z * v89 * 0.5);
            end;
        end;
    end;
end;
local function u104(p95) --[[ Line: 679 ]]
    -- upvalues: u17 (ref)
    for _, v96 in u17 do
        if v96.alive and (v96.beam.Parent and v96.glow.Parent) then
            local v97 = (p95 - v96.birthTime) * 12;
            local v98 = math.sin(v97 + v96.seedX) * 8;
            local v99 = math.cos(v97 * 0.7 + v96.seedZ) * 8;
            local v100 = math.sin(v97 * 1.3 + v96.seedX + 2) * 2;
            local v101 = math.cos(v97 * 0.9 + v96.seedZ + 2) * 2;
            local v102 = v96.startPos + Vector3.new(v100, 0, v101);
            local v103 = v96.hitPos + Vector3.new(v98, -15, v99);
            local l__beam__22 = v96.beam;
            local l__Magnitude__23 = (v103 - v102).Magnitude;
            l__beam__22.Size = Vector3.new(30, 30, l__Magnitude__23);
            l__beam__22.CFrame = CFrame.lookAt(v102, v103) * CFrame.new(0, 0, -l__Magnitude__23 / 2);
            local l__glow__24 = v96.glow;
            local l__Magnitude__25 = (v103 - v102).Magnitude;
            l__glow__24.Size = Vector3.new(45, 45, l__Magnitude__25);
            l__glow__24.CFrame = CFrame.lookAt(v102, v103) * CFrame.new(0, 0, -l__Magnitude__25 / 2);
        end;
    end;
end;
function u1.StartWeather() --[[ Line: 771 ]]
    -- upvalues: u9 (ref), l__NotificationController__11 (copy), u35 (ref), u10 (copy), l__Lighting__1 (copy), u36 (copy), u33 (copy), u43 (copy), u12 (ref), u15 (ref), u16 (ref), l__RunService__4 (copy), u14 (ref), u26 (copy), u11 (ref), u23 (copy), u94 (copy), u104 (copy)
    if u9 then
    else
        u9 = true;
        l__NotificationController__11:CreateNotification("A blizzard is approaching... ❄️");
        if not u35 then
            u35 = true;
            u10.Ambient = l__Lighting__1.Ambient;
            u10.Brightness = l__Lighting__1.Brightness;
            u10.ColorShift_Bottom = l__Lighting__1.ColorShift_Bottom;
            u10.ColorShift_Top = l__Lighting__1.ColorShift_Top;
            u10.EnvironmentDiffuseScale = l__Lighting__1.EnvironmentDiffuseScale;
            u10.OutdoorAmbient = l__Lighting__1.OutdoorAmbient;
            u10.ClockTime = l__Lighting__1.ClockTime;
            u10.ExposureCompensation = l__Lighting__1.ExposureCompensation;
        end;
        u36();
        u33();
        u43();
        if u12 then
        else
            u15 = os.clock();
            u16 = os.clock();
            lastFlashTime = 0;
            u12 = l__RunService__4.RenderStepped:Connect(function(_) --[[ Line: 713 ]]
                -- upvalues: u14 (ref), u26 (ref), u16 (ref), u15 (ref), u11 (ref), u23 (ref), u94 (ref), u104 (ref)
                debug.profilebegin("Controllers/WeatherController/Snowfall/RenderStepped");
                local v105 = os.clock();
                u14 = u26();
                if v105 - u16 >= 0.5 then
                    u16 = v105;
                    if u14 < 170 and (u14 < 130 and u14 < 80) then
                        local _ = u14 >= 40;
                    end;
                end;
                local v106 = u14;
                local v107;
                if v106 >= 170 then
                    v107 = 0.04;
                elseif v106 >= 130 then
                    v107 = (v106 - 130) / 40 * -0.07999999999999999 + 0.12;
                elseif v106 >= 80 then
                    v107 = (v106 - 80) / 50 * -0.28 + 0.4;
                else
                    v107 = v106 < 40 and 1.5 or (v106 - 40) / 40 * -1.1 + 1.5;
                end;
                if v107 <= v105 - u15 then
                    u15 = v105;
                    local v108;
                    if u11 then
                        v108 = u11:FindFirstChild("HIT_POINTS");
                    else
                        v108 = nil;
                    end;
                    if v108 then
                        u94((u23(v108)));
                    end;
                end;
                local _ = math.clamp((u14 - 40) / 130, 0, 1) * 15;
                u104(v105);
                debug.profileend();
            end);
        end;
    end;
end;
function u1.EndWeather() --[[ Line: 783 ]]
    -- upvalues: u9 (ref), u37 (copy), u2 (copy), u49 (copy), u12 (ref), u13 (ref), u17 (ref), u19 (copy)
    if u9 then
        u9 = false;
        u37();
        for v109, v110 in u2 do
            if v109 and v109.Parent then
                v109.Color = v110.Color;
            end;
        end;
        table.clear(u2);
        u49();
        if u12 then
            u12:Disconnect();
            u12 = nil;
        end;
        u13 = 0;
        u17 = {};
        task.delay(1.3, function() --[[ Line: 792 ]]
            -- upvalues: u19 (ref)
            for _, v111 in u19:GetChildren() do
                v111:Destroy();
            end;
        end);
    end;
end;
l__Networking__7.WeatherEffects.BlizzardStart.OnClientEvent:Connect(function() --[[ Line: 803 ]]
    -- upvalues: u1 (copy)
    u1.StartWeather();
end);
l__Networking__7.WeatherEffects.BlizzardEnd.OnClientEvent:Connect(function() --[[ Line: 807 ]]
    -- upvalues: u1 (copy)
    u1.EndWeather();
end);
l__Networking__7.WeatherEffects.BlizzardBeam.OnClientEvent:Connect(function(p112) --[[ Line: 812 ]]
    -- upvalues: u9 (ref), u94 (copy)
    if u9 then
        u94(p112);
    end;
end);
return u1;