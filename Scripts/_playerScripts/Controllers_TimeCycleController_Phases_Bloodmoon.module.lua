-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Lighting__1 = game:GetService("Lighting");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__Players__5 = game:GetService("Players");
local l__SoundService__6 = game:GetService("SoundService");
local l__Debris__7 = game:GetService("Debris");
local l__Networking__8 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__LocalPlayer__9 = l__Players__5.LocalPlayer;
local l__NotificationController__10 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__FieldOfViewController__11 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController);
local l__LightingController__12 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
local l__Bloodmoon__13 = l__ReplicatedStorage__3.Assets:WaitForChild("Bloodmoon");
local u2 = {
    Brightness = 3,
    EnvironmentDiffuseScale = 1,
    ClockTime = 3.1,
    Ambient = Color3.fromRGB(115, 45, 45),
    ColorShift_Bottom = Color3.fromRGB(171, 34, 34),
    ColorShift_Top = Color3.fromRGB(250, 19, 19),
    OutdoorAmbient = Color3.fromRGB(180, 54, 54)
};
local u3 = Color3.fromRGB(255, 20, 20);
local u4 = Color3.fromRGB(200, 40, 40);
local l__LaserBeam__14 = l__SoundService__6:WaitForChild("SFX"):WaitForChild("LaserBeam");
local u5 = Color3.fromRGB(255, 30, 30);
local u6 = {
    Color3.fromRGB(255, 10, 10),
    Color3.fromRGB(220, 0, 0),
    Color3.fromRGB(180, 10, 10),
    Color3.fromRGB(255, 30, 20),
    Color3.fromRGB(150, 0, 0),
    Color3.fromRGB(255, 50, 30)
};
local l__Bloodmoon__15 = l__SoundService__6:WaitForChild("MusicTracks"):WaitForChild("Bloodmoon");
local u7 = false;
local u8 = nil;
local u9 = nil;
local u10 = 0;
local u11 = 0;
local u12 = 0;
local u13 = 0;
local u14 = 0;
local u15 = 0;
local u16 = {};
local l__CurrentCamera__16 = workspace.CurrentCamera;
local u17 = Random.new();
local u18 = Instance.new("ColorCorrectionEffect");
u18.Name = "BloodmoonFlash";
u18.Brightness = 0;
u18.Parent = l__Lighting__1;
local u19 = Instance.new("Folder");
u19.Name = "BloodmoonBeams";
u19.Parent = workspace;
local function u22() --[[ Line: 154 ]]
    -- upvalues: l__Bloodmoon__15 (copy)
    local v20 = 0;
    for _, v21 in l__Bloodmoon__15:GetChildren() do
        if v21:IsA("Sound") and (v21.IsPlaying and v20 < v21.PlaybackLoudness) then
            v20 = v21.PlaybackLoudness;
        end;
    end;
    return v20;
end;
local function u24() --[[ Line: 195 ]]
    -- upvalues: u15 (ref), u18 (copy), l__TweenService__2 (copy)
    local v23 = os.clock();
    if v23 - u15 < 0.3 then
    else
        u15 = v23;
        u18.Brightness = 2;
        u18.Saturation = -0.3;
        l__TweenService__2:Create(u18, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            Brightness = 0,
            Saturation = 0
        }):Play();
    end;
end;
local function u30() --[[ Line: 214 ]]
    -- upvalues: u8 (ref), l__Bloodmoon__13 (copy), l__TweenService__2 (copy)
    if u8 then
    else
        u8 = l__Bloodmoon__13:Clone();
        u8.Name = "ActiveBloodmoon";
        local v25 = {};
        for _, v26 in u8:GetDescendants() do
            if v26:IsA("BasePart") then
                if v26:GetAttribute("OGTransparency") == nil then
                    v26:SetAttribute("OGTransparency", v26.Transparency);
                end;
                v26.Transparency = 1;
                table.insert(v25, v26);
            end;
        end;
        u8.Parent = workspace;
        local u27 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        for v28, u29 in v25 do
            task.delay(v28 * 0.05, function() --[[ Line: 235 ]]
                -- upvalues: u29 (copy), l__TweenService__2 (ref), u27 (copy)
                if u29 and u29.Parent then
                    l__TweenService__2:Create(u29, u27, {
                        Transparency = u29:GetAttribute("OGTransparency")
                    }):Play();
                end;
            end);
        end;
    end;
end;
local function u36() --[[ Line: 243 ]]
    -- upvalues: u8 (ref), l__TweenService__2 (copy)
    if u8 then
        local v31 = {};
        for _, v32 in u8:GetDescendants() do
            if v32:IsA("BasePart") then
                table.insert(v31, v32);
            end;
        end;
        local v33 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        for _, v34 in v31 do
            l__TweenService__2:Create(v34, v33, {
                Transparency = 1
            }):Play();
        end;
        local u35 = u8;
        u8 = nil;
        task.delay(2.1, function() --[[ Line: 260 ]]
            -- upvalues: u35 (copy)
            if u35 and u35.Parent then
                u35:Destroy();
            end;
        end);
    end;
end;
local function u58(p37) --[[ Line: 271 ]]
    -- upvalues: u6 (copy), u17 (copy), u19 (copy), l__TweenService__2 (copy)
    for v38 = 1, 16 do
        local v39 = v38 / 16 * 3.141592653589793 * 2;
        local u40 = Instance.new("Part");
        u40.Size = Vector3.new(5, 0.8, 5);
        u40.CFrame = CFrame.new(p37) * CFrame.Angles(0, v39, 0);
        u40.Anchored = false;
        u40.CanCollide = false;
        u40.CanQuery = false;
        u40.CanTouch = false;
        u40.CastShadow = false;
        u40.Material = Enum.Material.Neon;
        u40.Color = u6[u17:NextInteger(1, #u6)];
        u40.Transparency = 0;
        u40.Parent = u19;
        local v41 = 120 * (0.8 + u17:NextNumber() * 0.4);
        local v42 = u17:NextNumber(10, 25);
        local v43 = math.cos(v39) * v41;
        local v44 = math.sin(v39) * v41;
        u40.AssemblyLinearVelocity = Vector3.new(v43, v42, v44);
        local v45 = u17:NextNumber(-10, 10);
        local v46 = u17:NextNumber(-10, 10);
        u40.AssemblyAngularVelocity = Vector3.new(v45, v46, u17:NextNumber(-10, 10));
        l__TweenService__2:Create(u40, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1,
            Size = Vector3.new(0.3, 0.1, 0.3)
        }):Play();
        task.delay(1.1, function() --[[ Line: 306 ]]
            -- upvalues: u40 (copy)
            u40:Destroy();
        end);
    end;
    for _ = 1, 10 do
        local u47 = Instance.new("Part");
        u47.Size = Vector3.new(2, 2, 2) + Vector3.new(3, 3, 3) * u17:NextNumber(0, 1);
        local v48 = u17:NextNumber(-2, 2);
        local v49 = u17:NextNumber(0, 3);
        u47.Position = p37 + Vector3.new(v48, v49, u17:NextNumber(-2, 2));
        u47.Anchored = false;
        u47.CanCollide = false;
        u47.CanQuery = false;
        u47.CanTouch = false;
        u47.CastShadow = false;
        u47.Material = Enum.Material.Neon;
        u47.Color = u6[u17:NextInteger(1, #u6)];
        u47.Transparency = 0;
        u47.Parent = u19;
        local v50 = u17:NextNumber(0, 6.283185307179586);
        local v51 = 80 * (0.5 + u17:NextNumber() * 0.5);
        local v52 = math.cos(v50) * v51;
        local v53 = 80 * (0.6 + u17:NextNumber() * 0.8);
        local v54 = math.sin(v50) * v51;
        u47.AssemblyLinearVelocity = Vector3.new(v52, v53, v54);
        local v55 = u17:NextNumber(-15, 15);
        local v56 = u17:NextNumber(-15, 15);
        u47.AssemblyAngularVelocity = Vector3.new(v55, v56, u17:NextNumber(-15, 15));
        l__TweenService__2:Create(u47, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Transparency = 1,
            Size = Vector3.new(0.2, 0.2, 0.2)
        }):Play();
        task.delay(1.3, function() --[[ Line: 349 ]]
            -- upvalues: u47 (copy)
            u47:Destroy();
        end);
    end;
    local u57 = Instance.new("Part");
    u57.Shape = Enum.PartType.Ball;
    u57.Size = Vector3.new(17, 17, 17);
    u57.Position = p37;
    u57.Anchored = true;
    u57.CanCollide = false;
    u57.CanQuery = false;
    u57.CanTouch = false;
    u57.CastShadow = false;
    u57.Material = Enum.Material.Neon;
    u57.Color = Color3.fromRGB(255, 0, 0);
    u57.Transparency = 0;
    u57.Parent = u19;
    l__TweenService__2:Create(u57, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(100, 100, 100),
        Transparency = 1
    }):Play();
    task.delay(0.35, function() --[[ Line: 374 ]]
        -- upvalues: u57 (copy)
        u57:Destroy();
    end);
end;
local function u85(u59) --[[ Line: 403 ]]
    -- upvalues: u8 (ref), u3 (copy), u19 (copy), u4 (copy), u5 (copy), u17 (copy), u16 (ref), l__LaserBeam__14 (copy), l__TweenService__2 (copy), l__Debris__7 (copy), u58 (copy), u12 (ref), l__CurrentCamera__16 (copy), u11 (ref), u10 (ref), l__LocalPlayer__9 (copy), u24 (copy)
    local v60;
    if u8 then
        v60 = u8:FindFirstChild("START_PART");
    else
        v60 = nil;
    end;
    if v60 then
        local l__Position__17 = v60.Position;
        local v61 = u3;
        local u62 = Instance.new("Part");
        u62.Anchored = true;
        u62.CanCollide = false;
        u62.CanQuery = false;
        u62.CanTouch = false;
        u62.CastShadow = false;
        u62.Material = Enum.Material.Neon;
        u62.Color = v61;
        u62.Transparency = 1;
        u62.Parent = u19;
        local v63 = u4;
        local u64 = Instance.new("Part");
        u64.Anchored = true;
        u64.CanCollide = false;
        u64.CanQuery = false;
        u64.CanTouch = false;
        u64.CastShadow = false;
        u64.Material = Enum.Material.Neon;
        u64.Color = v63;
        u64.Transparency = 1;
        u64.Parent = u19;
        local v65 = u59 + Vector3.new(0, -15, 0);
        local l__Magnitude__18 = (v65 - l__Position__17).Magnitude;
        u62.Size = Vector3.new(30, 30, l__Magnitude__18);
        u62.CFrame = CFrame.lookAt(l__Position__17, v65) * CFrame.new(0, 0, -l__Magnitude__18 / 2);
        local l__Magnitude__19 = (v65 - l__Position__17).Magnitude;
        u64.Size = Vector3.new(45, 45, l__Magnitude__19);
        u64.CFrame = CFrame.lookAt(l__Position__17, v65) * CFrame.new(0, 0, -l__Magnitude__19 / 2);
        local u66 = Instance.new("Part");
        u66.Shape = Enum.PartType.Ball;
        u66.Size = Vector3.new(3, 3, 3);
        u66.Position = u59;
        u66.Anchored = true;
        u66.CanCollide = false;
        u66.CanQuery = false;
        u66.CanTouch = false;
        u66.CastShadow = false;
        u66.Material = Enum.Material.Neon;
        u66.Color = u5;
        u66.Transparency = 1;
        u66.Parent = u19;
        local u67 = {
            alive = true,
            beam = u62,
            glow = u64,
            startPos = l__Position__17,
            hitPos = u59,
            birthTime = os.clock(),
            seedX = u17:NextNumber(0, 100),
            seedZ = u17:NextNumber(0, 100)
        };
        table.insert(u16, u67);
        local u68 = l__LaserBeam__14:Clone();
        u68.Volume = 8;
        u68.RollOffMaxDistance = 300;
        u68.RollOffMinDistance = 20;
        u68.Parent = v60;
        u68:Play();
        u68.Ended:Once(function() --[[ Line: 448 ]]
            -- upvalues: u68 (copy)
            u68:Destroy();
        end);
        local u69 = Instance.new("Part");
        u69.Size = Vector3.new(1, 1, 1);
        u69.Position = u59;
        u69.Anchored = true;
        u69.CanCollide = false;
        u69.CanQuery = false;
        u69.CanTouch = false;
        u69.Transparency = 1;
        u69.Parent = u19;
        local v70 = l__LaserBeam__14:Clone();
        v70.Volume = 7;
        v70.PlaybackSpeed = 0.6 + u17:NextNumber() * 0.5;
        v70.RollOffMaxDistance = 200;
        v70.RollOffMinDistance = 15;
        v70.Parent = u69;
        v70:Play();
        v70.Ended:Once(function() --[[ Line: 469 ]]
            -- upvalues: u69 (copy)
            u69:Destroy();
        end);
        local v71 = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local v72 = l__TweenService__2:Create(u62, v71, {
            Transparency = 0
        });
        v72:Play();
        l__Debris__7:AddItem(v72, v71.Time);
        local v73 = l__TweenService__2:Create(u64, v71, {
            Transparency = 0.5
        });
        v73:Play();
        l__Debris__7:AddItem(v73, v71.Time);
        local v74 = l__TweenService__2:Create(u66, v71, {
            Transparency = 0.1
        });
        v74:Play();
        l__Debris__7:AddItem(v74, v71.Time);
        task.delay(0.06, function() --[[ Line: 485 ]]
            -- upvalues: l__TweenService__2 (ref), u66 (copy), l__Debris__7 (ref), u58 (ref), u59 (copy)
            local v75 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v76 = l__TweenService__2:Create(u66, v75, {
                Size = Vector3.new(12, 12, 12),
                Transparency = 0.5
            });
            v76:Play();
            l__Debris__7:AddItem(v76, v75.Time);
            u58(u59);
        end);
        task.delay(0.31, function() --[[ Line: 496 ]]
            -- upvalues: l__TweenService__2 (ref), u62 (copy), l__Debris__7 (ref), u64 (copy), u66 (copy), u67 (copy), u16 (ref)
            local v77 = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            local v78 = l__TweenService__2:Create(u62, v77, {
                Transparency = 1
            });
            v78:Play();
            l__Debris__7:AddItem(v78, v77.Time);
            local v79 = l__TweenService__2:Create(u64, v77, {
                Transparency = 1
            });
            v79:Play();
            l__Debris__7:AddItem(v79, v77.Time);
            local v80 = l__TweenService__2:Create(u66, v77, {
                Transparency = 1
            });
            v80:Play();
            l__Debris__7:AddItem(v80, v77.Time);
            task.delay(0.4, function() --[[ Line: 508 ]]
                -- upvalues: u67 (ref)
                u67.alive = false;
            end);
            task.delay(0.9, function() --[[ Line: 512 ]]
                -- upvalues: u62 (ref), u64 (ref), u66 (ref), u16 (ref), u67 (ref)
                u62:Destroy();
                u64:Destroy();
                u66:Destroy();
                for v81 = #u16, 1, -1 do
                    if u16[v81] == u67 then
                        table.remove(u16, v81);
                        return;
                    end;
                end;
            end);
        end);
        local v82 = math.clamp(u12 / 170, 0, 1) * 2.2 + 0.8;
        local l__Magnitude__20 = (l__CurrentCamera__16.CFrame.Position - u59).Magnitude;
        if l__Magnitude__20 <= 60 then
            local v83 = 1 - l__Magnitude__20 / 60;
            u11 = math.max(u11, v82 * v83 * v83);
            u10 = os.clock() + 0.3;
        end;
        local l__Character__21 = l__LocalPlayer__9.Character;
        if l__Character__21 then
            local v84 = l__Character__21:FindFirstChild("HumanoidRootPart");
            if v84 and (v84.Position - u59).Magnitude <= 50 then
                u24();
            end;
        end;
    end;
end;
local function u95(p86) --[[ Line: 552 ]]
    -- upvalues: u16 (ref)
    for _, v87 in u16 do
        if v87.alive and (v87.beam.Parent and v87.glow.Parent) then
            local v88 = (p86 - v87.birthTime) * 12;
            local v89 = math.sin(v88 + v87.seedX) * 8;
            local v90 = math.cos(v88 * 0.7 + v87.seedZ) * 8;
            local v91 = math.sin(v88 * 1.3 + v87.seedX + 2) * 2;
            local v92 = math.cos(v88 * 0.9 + v87.seedZ + 2) * 2;
            local v93 = v87.startPos + Vector3.new(v91, 0, v92);
            local v94 = v87.hitPos + Vector3.new(v89, -15, v90);
            local l__beam__22 = v87.beam;
            local l__Magnitude__23 = (v94 - v93).Magnitude;
            l__beam__22.Size = Vector3.new(30, 30, l__Magnitude__23);
            l__beam__22.CFrame = CFrame.lookAt(v93, v94) * CFrame.new(0, 0, -l__Magnitude__23 / 2);
            local l__glow__24 = v87.glow;
            local l__Magnitude__25 = (v94 - v93).Magnitude;
            l__glow__24.Size = Vector3.new(45, 45, l__Magnitude__25);
            l__glow__24.CFrame = CFrame.lookAt(v93, v94) * CFrame.new(0, 0, -l__Magnitude__25 / 2);
        end;
    end;
end;
function v1.Start(_, _, _) --[[ Line: 635 ]]
    -- upvalues: u7 (ref), l__NotificationController__10 (copy), l__LightingController__12 (copy), u2 (copy), u30 (copy), u9 (ref), u13 (ref), u14 (ref), u15 (ref), l__RunService__4 (copy), u12 (ref), u22 (copy), u24 (copy), l__FieldOfViewController__11 (copy), u95 (copy), u10 (ref), u11 (ref), l__CurrentCamera__16 (copy)
    if u7 then
    else
        u7 = true;
        l__NotificationController__10:CreateNotification("A blood moon is rising...");
        l__LightingController__12:TransitionTo(u2);
        u30();
        if u9 then
        else
            u13 = os.clock();
            u14 = os.clock();
            u15 = 0;
            u9 = l__RunService__4.RenderStepped:Connect(function(_) --[[ Line: 585 ]]
                -- upvalues: u12 (ref), u22 (ref), u14 (ref), u24 (ref), l__FieldOfViewController__11 (ref), u95 (ref), u10 (ref), u11 (ref), l__CurrentCamera__16 (ref)
                local v96 = os.clock();
                u12 = u22();
                if v96 - u14 >= 0.5 then
                    u14 = v96;
                    if u12 < 170 and (u12 < 130 and u12 < 80) then
                        local _ = u12 >= 40;
                    end;
                end;
                if u12 >= 170 then
                    u24();
                end;
                l__FieldOfViewController__11:SetAdjuster(math.clamp((u12 - 40) / 130, 0, 1) * 15);
                u95(v96);
                if v96 < u10 and u11 > 0 then
                    local v97 = u11 * ((u10 - v96) / 0.3);
                    local v98 = math.sin(v96 * 30 * 6.28) * v97;
                    local v99 = math.cos(v96 * 30 * 4.17) * v97;
                    local v100 = math.sin(v96 * 30 * 5.23 + 1) * v97 * 0.5;
                    l__CurrentCamera__16.CFrame = l__CurrentCamera__16.CFrame * CFrame.new(v98, v99, v100);
                end;
            end);
        end;
    end;
end;
function v1.End(_) --[[ Line: 645 ]]
    -- upvalues: u7 (ref), l__TweenService__2 (copy), u18 (copy), u36 (copy), u9 (ref), u11 (ref), u16 (ref), l__FieldOfViewController__11 (copy), u19 (copy)
    if u7 then
        u7 = false;
        l__TweenService__2:Create(u18, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0
        }):Play();
        u36();
        if u9 then
            u9:Disconnect();
            u9 = nil;
        end;
        u11 = 0;
        u16 = {};
        l__FieldOfViewController__11:ClearAdjuster();
        task.delay(1.3, function() --[[ Line: 659 ]]
            -- upvalues: u19 (ref)
            for _, v101 in u19:GetChildren() do
                v101:Destroy();
            end;
        end);
    end;
end;
l__Networking__8.WeatherEffects.BloodmoonBeam.OnClientEvent:Connect(function(p102) --[[ Line: 670 ]]
    -- upvalues: u7 (ref), u85 (copy)
    if u7 then
        u85(p102);
    end;
end);
return v1;