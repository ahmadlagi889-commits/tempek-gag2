-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Lighting__1 = game:GetService("Lighting");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local l__ReplicatedStorage__4 = game:GetService("ReplicatedStorage");
local l__Networking__5 = require(l__ReplicatedStorage__4.SharedModules.Networking);
local u2 = false;
local u3 = {};
local u4 = nil;
local u5 = nil;
local u6 = {};
local u7 = 0;
local l__CurrentCamera__6 = workspace.CurrentCamera;
local u8 = Random.new();
local l__Rain__7 = game.SoundService.WeatherSFX.Rain;
l__Rain__7.Looped = true;
local l__Lightning__8 = game.SoundService.WeatherSFX.Lightning;
local u9 = RaycastParams.new();
u9.FilterDescendantsInstances = { workspace.Terrain, workspace };
u9.FilterType = Enum.RaycastFilterType.Include;
local u10 = Instance.new("ColorCorrectionEffect");
u10.Name = "LightningEffect";
u10.Parent = l__Lighting__1;
local u11 = Instance.new("Folder");
u11.Name = "LightningEffects";
u11.Parent = workspace;
local u12 = Instance.new("Folder");
u12.Name = "StormRainDrops";
u12.Parent = workspace;
local v13 = Instance.new("Folder");
v13.Name = "StormSplashes";
v13.Parent = workspace;
local u14 = Instance.new("Part");
u14.Name = "RainDrop";
u14.Size = Vector3.new(0.12, 2.8, 0.12);
u14.Material = Enum.Material.Neon;
u14.Color = Color3.fromRGB(100, 150, 255);
u14.Anchored = true;
u14.CanCollide = false;
u14.CastShadow = false;
u14.Transparency = 0.2;
(function() --[[ Name: createSplashTemplate, Line 97 ]]
    local v15 = Instance.new("Part");
    v15.Name = "Splash";
    v15.Size = Vector3.new(0.1, 0.1, 0.1);
    v15.Material = Enum.Material.Neon;
    v15.Color = Color3.fromRGB(120, 170, 255);
    v15.Anchored = false;
    v15.CanCollide = false;
    v15.CastShadow = false;
    v15.Transparency = 0.3;
    v15.Shape = Enum.PartType.Ball;
    return v15;
end)();
local u16 = {};
local u17 = 0;
local _ = 0;
local function u22() --[[ Line: 189 ]]
    -- upvalues: l__CurrentCamera__6 (copy), u8 (copy)
    local l__Position__9 = l__CurrentCamera__6.CFrame.Position;
    local v18 = u8:NextNumber(0, 6.283185307179586);
    local v19 = u8:NextNumber(5, 130);
    local v20 = l__Position__9.X + math.cos(v18) * v19;
    local v21 = l__Position__9.Z + math.sin(v18) * v19;
    return v20, l__Position__9.Y + u8:NextNumber(50, 90), v21;
end;
local function u28() --[[ Line: 201 ]]
    -- upvalues: u7 (ref), u22 (copy), u9 (copy), u17 (ref), u16 (copy), u14 (copy), u12 (copy), u6 (copy)
    if u7 >= 100 then
    else
        local v23, v24, v25 = u22();
        local v26 = Vector3.new(v23, v24, v25);
        if workspace:Raycast(v26, Vector3.new(0, 100, 0), u9) then
        else
            local v27;
            if u17 > 0 then
                v27 = u16[u17];
                u16[u17] = nil;
                u17 = u17 - 1;
            else
                v27 = u14:Clone();
            end;
            v27.CFrame = CFrame.new(v23, v24, v25);
            v27.Parent = u12;
            u7 = u7 + 1;
            u6[u7] = {
                part = v27,
                x = v23,
                y = v24,
                z = v25,
                startY = v24
            };
        end;
    end;
end;
local function u29() --[[ Line: 223 ]]
    -- upvalues: u28 (copy)
    debug.profilebegin("Controllers/WeatherController/Lightning/spawnBatch");
    u28();
    u28();
    u28();
    u28();
    u28();
    u28();
    debug.profileend();
end;
local function u40(p30) --[[ Line: 231 ]]
    -- upvalues: u7 (ref), l__CurrentCamera__6 (copy), u6 (copy), u17 (ref), u16 (copy), u9 (copy)
    debug.profilebegin("Controllers/WeatherController/Lightning/renderLoop");
    if u7 == 0 then
        debug.profileend();
        return;
    end;
    local v31 = 90 * p30;
    local l__Y__10 = l__CurrentCamera__6.CFrame.Position.Y;
    debug.profilebegin("Controllers/WeatherController/Lightning/renderLoop/iterateDrops");
    local v32 = 1;
    local v33 = {};
    local v34 = {};
    local v35 = 0;
    while true do
        local v36, v37;
        while true do
            while true do
                if v32 > u7 then
                    debug.profileend();
                    if v35 > 0 then
                        debug.profilebegin("Controllers/WeatherController/Lightning/renderLoop/BulkMoveTo");
                        workspace:BulkMoveTo(v33, v34, Enum.BulkMoveMode.FireCFrameChanged);
                        debug.profileend();
                    end;
                    debug.profileend();
                    return;
                end;
                v36 = u6[v32];
                v37 = v36.y - v31;
                v36.y = v37;
                if v36.startY - v37 <= 200 and v37 >= l__Y__10 - 50 then
                    break;
                end;
                local l__part__11 = v36.part;
                l__part__11.Parent = nil;
                u17 = u17 + 1;
                u16[u17] = l__part__11;
                u6[v32] = u6[u7];
                u6[u7] = nil;
                u7 = u7 - 1;
            end;
            local v38 = os.clock() * 60;
            if (v32 + math.floor(v38)) % 3 ~= 0 then
                break;
            end;
            debug.profilebegin("Controllers/WeatherController/Lightning/renderLoop/raycastGround");
            local v39 = Vector3.new(v36.x, v37, v36.z);
            if not workspace:Raycast(v39, Vector3.new(0, -2, 0), u9) then
                debug.profileend();
                break;
            end;
            local l__part__12 = v36.part;
            l__part__12.Parent = nil;
            u17 = u17 + 1;
            u16[u17] = l__part__12;
            u6[v32] = u6[u7];
            u6[u7] = nil;
            u7 = u7 - 1;
            debug.profileend();
        end;
        v35 = v35 + 1;
        v33[v35] = v36.part;
        v34[v35] = CFrame.new(v36.x, v37, v36.z);
        v32 = v32 + 1;
    end;
end;
local function u46(p41) --[[ Line: 298 ]]
    -- upvalues: l__Lightning__8 (copy), u8 (copy), u11 (copy)
    local v42 = l__Lightning__8:GetChildren();
    if #v42 == 0 then
    else
        local v43 = v42[u8:NextInteger(1, #v42)];
        if v43:IsA("Sound") then
            local u44 = Instance.new("Part");
            u44.Name = "LightningSFXPart";
            u44.Size = Vector3.new(1, 1, 1);
            u44.Position = p41;
            u44.Anchored = true;
            u44.CanCollide = false;
            u44.Transparency = 1;
            u44.Parent = u11;
            local v45 = v43:Clone();
            v45.Volume = 2;
            v45.RollOffMaxDistance = 7000;
            v45.RollOffMinDistance = 10;
            v45.Parent = u44;
            v45:Play();
            v45.Ended:Once(function() --[[ Line: 325 ]]
                -- upvalues: u44 (copy)
                u44:Destroy();
            end);
            task.delay(v45.TimeLength + 1, function() --[[ Line: 330 ]]
                -- upvalues: u44 (copy)
                if u44.Parent then
                    u44:Destroy();
                end;
            end);
        end;
    end;
end;
local function u51(p47, p48, p49) --[[ Line: 339 ]]
    -- upvalues: u11 (copy)
    local v50 = Instance.new("Part");
    v50.Name = "LightningBolt";
    v50.Anchored = true;
    v50.CanCollide = false;
    v50.CastShadow = false;
    v50.Material = Enum.Material.Neon;
    v50.Color = Color3.fromRGB(235, 245, 255);
    v50.Transparency = 1;
    local l__Magnitude__13 = (p48 - p47).Magnitude;
    v50.Size = Vector3.new(p49, p49, l__Magnitude__13);
    v50.CFrame = CFrame.lookAt(p47, p48) * CFrame.new(0, 0, -l__Magnitude__13 / 2);
    v50.Parent = u11;
    return v50;
end;
local function u56(p52, p53, p54) --[[ Line: 358 ]]
    -- upvalues: u11 (copy)
    local v55 = Instance.new("Part");
    v55.Name = "LightningGlow";
    v55.Anchored = true;
    v55.CanCollide = false;
    v55.CastShadow = false;
    v55.Material = Enum.Material.Neon;
    v55.Color = Color3.fromRGB(180, 200, 255);
    v55.Transparency = 1;
    local l__Magnitude__14 = (p53 - p52).Magnitude;
    v55.Size = Vector3.new(p54 * 3, p54 * 3, l__Magnitude__14);
    v55.CFrame = CFrame.lookAt(p52, p53) * CFrame.new(0, 0, -l__Magnitude__14 / 2);
    v55.Parent = u11;
    return v55;
end;
local function u77(p57) --[[ Line: 376 ]]
    -- upvalues: u8 (copy), u51 (copy), u56 (copy), u11 (copy)
    local v58 = p57 + Vector3.new(0, 150, 0);
    local v59 = {};
    for v60 = 1, 10 do
        local v61 = v60 / 10;
        local v62 = p57.Y + (1 - v61) * 150;
        local v63 = (1 - v61) * 0.7;
        local v64 = u8:NextNumber(-10, 10) * v63;
        local v65 = u8:NextNumber(-10, 10) * v63;
        local v66;
        if v60 == 10 then
            v66 = p57;
        else
            v66 = Vector3.new(p57.X + v64, v62, p57.Z + v65);
        end;
        local v67 = 2.5 - v61 * 1;
        local v68 = u51(v58, v66, v67);
        table.insert(v59, v68);
        local v69 = u56(v58, v66, v67);
        table.insert(v59, v69);
        if v60 > 2 and (v60 < 8 and u8:NextNumber() > 0.65) then
            local v70 = u8:NextNumber(-18, 18);
            local v71 = u8:NextNumber(-30, -10);
            local v72 = v66 + Vector3.new(v70, v71, u8:NextNumber(-18, 18));
            local v73 = u51(v66, v72, 0.8);
            local v74 = u56(v66, v72, 0.8);
            table.insert(v59, v73);
            table.insert(v59, v74);
            v58 = v66;
        else
            v58 = v66;
        end;
    end;
    local v75 = Instance.new("Part");
    v75.Name = "StrikeGlow";
    v75.Shape = Enum.PartType.Ball;
    v75.Size = Vector3.new(3, 3, 3);
    v75.Position = p57;
    v75.Anchored = true;
    v75.CanCollide = false;
    v75.CastShadow = false;
    v75.Material = Enum.Material.Neon;
    v75.Color = Color3.fromRGB(235, 245, 255);
    v75.Transparency = 1;
    v75.Parent = u11;
    table.insert(v59, v75);
    local v76 = Instance.new("Part");
    v76.Name = "OuterStrikeGlow";
    v76.Shape = Enum.PartType.Ball;
    v76.Size = Vector3.new(6, 6, 6);
    v76.Position = p57;
    v76.Anchored = true;
    v76.CanCollide = false;
    v76.CastShadow = false;
    v76.Material = Enum.Material.Neon;
    v76.Color = Color3.fromRGB(180, 200, 255);
    v76.Transparency = 1;
    v76.Parent = u11;
    table.insert(v59, v76);
    return v59;
end;
local function u78() --[[ Line: 460 ]]
    -- upvalues: u10 (copy), l__TweenService__2 (copy)
    u10.Brightness = 2.5;
    u10.Contrast = 0.15;
    u10.Saturation = -0.3;
    l__TweenService__2:Create(u10, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0
    }):Play();
end;
local function u87(p79) --[[ Line: 475 ]]
    -- upvalues: u77 (copy), u46 (copy), l__TweenService__2 (copy), u2 (ref), u78 (copy), u10 (copy)
    local u80 = u77(p79);
    u46(p79);
    local v81 = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    for _, v82 in u80 do
        if v82.Name == "LightningBolt" then
            l__TweenService__2:Create(v82, v81, {
                Transparency = 0
            }):Play();
        elseif v82.Name == "LightningGlow" then
            l__TweenService__2:Create(v82, v81, {
                Transparency = 0.6
            }):Play();
        elseif v82.Name == "StrikeGlow" then
            l__TweenService__2:Create(v82, v81, {
                Transparency = 0
            }):Play();
        elseif v82.Name == "OuterStrikeGlow" then
            l__TweenService__2:Create(v82, v81, {
                Transparency = 0.4
            }):Play();
        end;
    end;
    task.delay(0.03, function() --[[ Line: 496 ]]
        -- upvalues: u2 (ref), u78 (ref)
        if u2 then
            u78();
        end;
    end);
    task.delay(0.1, function() --[[ Line: 502 ]]
        -- upvalues: u80 (copy), l__TweenService__2 (ref)
        for _, v83 in u80 do
            if v83.Name == "StrikeGlow" then
                l__TweenService__2:Create(v83, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = Vector3.new(15, 15, 15),
                    Transparency = 0.6
                }):Play();
            elseif v83.Name == "OuterStrikeGlow" then
                l__TweenService__2:Create(v83, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = Vector3.new(25, 25, 25),
                    Transparency = 0.8
                }):Play();
            end;
        end;
    end);
    task.delay(0.3, function() --[[ Line: 521 ]]
        -- upvalues: u80 (copy), l__TweenService__2 (ref)
        local v84 = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        for _, v85 in u80 do
            l__TweenService__2:Create(v85, v84, {
                Transparency = 1
            }):Play();
        end;
        task.delay(0.65, function() --[[ Line: 527 ]]
            -- upvalues: u80 (ref)
            for _, v86 in u80 do
                v86:Destroy();
            end;
        end);
    end);
    task.delay(0.5, function() --[[ Line: 535 ]]
        -- upvalues: u2 (ref), u10 (ref), l__TweenService__2 (ref)
        if u2 then
            u10.Brightness = 0.4;
            l__TweenService__2:Create(u10, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Brightness = 0
            }):Play();
        end;
    end);
end;
local function u89() --[[ Line: 545 ]]
    local v88 = workspace.Terrain:FindFirstChildOfClass("Clouds");
    if not v88 then
        v88 = Instance.new("Clouds");
        v88.Cover = 0;
        v88.Density = 0;
        v88.Color = Color3.fromRGB(255, 255, 255);
        v88.Enabled = false;
        v88.Parent = workspace.Terrain;
    end;
    return v88;
end;
local function u92() --[[ Line: 567 ]]
    -- upvalues: l__TweenService__2 (copy), l__Lighting__1 (copy), u3 (copy), u89 (copy)
    local v90 = TweenInfo.new(4, Enum.EasingStyle.Sine);
    l__TweenService__2:Create(l__Lighting__1, v90, {
        FogEnd = 300,
        ExposureCompensation = 0.2,
        Brightness = u3.Brightness * 0.4,
        Ambient = Color3.fromRGB(90, 95, 115),
        OutdoorAmbient = Color3.fromRGB(40, 45, 60),
        FogColor = Color3.fromRGB(70, 75, 90)
    }):Play();
    local v91 = u89();
    v91.Enabled = true;
    l__TweenService__2:Create(v91, v90, {
        Cover = 1,
        Density = 0.35
    }):Play();
end;
local function u95() --[[ Line: 584 ]]
    -- upvalues: l__TweenService__2 (copy), l__Lighting__1 (copy), u3 (copy), u10 (copy), u89 (copy), u2 (ref)
    local v93 = TweenInfo.new(4, Enum.EasingStyle.Sine);
    l__TweenService__2:Create(l__Lighting__1, v93, {
        Brightness = u3.Brightness,
        Ambient = u3.Ambient,
        OutdoorAmbient = u3.OutdoorAmbient,
        FogEnd = u3.FogEnd,
        FogColor = u3.FogColor,
        ExposureCompensation = u3.ExposureCompensation
    }):Play();
    l__TweenService__2:Create(u10, v93, {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0
    }):Play();
    local u94 = u89();
    l__TweenService__2:Create(u94, v93, {
        Cover = 0,
        Density = 0
    }):Play();
    task.delay(4, function() --[[ Line: 604 ]]
        -- upvalues: u2 (ref), u94 (copy)
        if not u2 then
            u94.Enabled = false;
        end;
    end);
end;
local function u96() --[[ Line: 613 ]]
    -- upvalues: l__Rain__7 (copy), l__TweenService__2 (copy)
    l__Rain__7.Volume = 0;
    l__Rain__7:Play();
    l__TweenService__2:Create(l__Rain__7, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Volume = 0.5
    }):Play();
end;
local function u98() --[[ Line: 621 ]]
    -- upvalues: l__TweenService__2 (copy), l__Rain__7 (copy)
    local v97 = l__TweenService__2:Create(l__Rain__7, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Volume = 0
    });
    v97:Play();
    v97.Completed:Once(function() --[[ Line: 625 ]]
        -- upvalues: l__Rain__7 (ref)
        l__Rain__7:Stop();
    end);
end;
function u1.StartWeather() --[[ Line: 632 ]]
    -- upvalues: u2 (ref), u3 (copy), l__Lighting__1 (copy), u92 (copy), u96 (copy), u4 (ref), l__RunService__3 (copy), u40 (copy), u5 (ref), u29 (copy)
    if u2 then
    else
        u2 = true;
        u3.Brightness = l__Lighting__1.Brightness;
        u3.Ambient = l__Lighting__1.Ambient;
        u3.OutdoorAmbient = l__Lighting__1.OutdoorAmbient;
        u3.FogEnd = l__Lighting__1.FogEnd;
        u3.FogColor = l__Lighting__1.FogColor;
        u3.ExposureCompensation = l__Lighting__1.ExposureCompensation;
        u92();
        u96();
        u4 = l__RunService__3.RenderStepped:Connect(u40);
        u5 = task.spawn(function() --[[ Line: 642 ]]
            -- upvalues: u2 (ref), u29 (ref)
            while u2 do
                u29();
                task.wait(0.015);
            end;
        end);
    end;
end;
function u1.EndWeather() --[[ Line: 650 ]]
    -- upvalues: u2 (ref), u10 (copy), u95 (copy), u98 (copy), u4 (ref), u7 (ref), u6 (copy), u17 (ref), u16 (copy), u11 (copy)
    if u2 then
        u2 = false;
        u10.Brightness = 0;
        u10.Contrast = 0;
        u10.Saturation = 0;
        u95();
        u98();
        task.delay(4, function() --[[ Line: 661 ]]
            -- upvalues: u4 (ref), u7 (ref), u6 (ref), u17 (ref), u16 (ref), u11 (ref)
            if u4 then
                u4:Disconnect();
                u4 = nil;
            end;
            for v99 = 1, u7 do
                if u6[v99] then
                    local l__part__15 = u6[v99].part;
                    l__part__15.Parent = nil;
                    u17 = u17 + 1;
                    u16[u17] = l__part__15;
                    u6[v99] = nil;
                end;
            end;
            u7 = 0;
            for _, v100 in u11:GetChildren() do
                v100:Destroy();
            end;
        end);
    end;
end;
l__Networking__5.WeatherEffects.LightningStart.OnClientEvent:Connect(function() --[[ Line: 682 ]]
    -- upvalues: u1 (copy)
    u1.StartWeather();
end);
l__Networking__5.WeatherEffects.LightningEnd.OnClientEvent:Connect(function() --[[ Line: 686 ]]
    -- upvalues: u1 (copy)
    u1.EndWeather();
end);
l__Networking__5.WeatherEffects.LightningStrike.OnClientEvent:Connect(function(p101) --[[ Line: 690 ]]
    -- upvalues: u2 (ref), u87 (copy)
    if u2 then
        u87(p101);
    end;
end);
return u1;