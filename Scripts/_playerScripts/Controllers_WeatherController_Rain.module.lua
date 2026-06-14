-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Lighting__1 = game:GetService("Lighting");
local l__TweenService__2 = game:GetService("TweenService");
local l__RunService__3 = game:GetService("RunService");
local _ = math.rad;
local _ = math.tan;
local _ = math.min;
local l__clock__4 = os.clock;
local l__CurrentCamera__5 = workspace.CurrentCamera;
local u2 = {};
local u3 = 0;
local u4 = false;
local u5 = nil;
local u6 = nil;
local u7 = Random.new();
local u8 = RaycastParams.new();
u8.FilterDescendantsInstances = { workspace.Terrain, workspace };
u8.FilterType = Enum.RaycastFilterType.Include;
game:GetService("TweenService");
TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local l__Rain__6 = game.SoundService.WeatherSFX.Rain;
l__Rain__6.Looped = true;
local u9 = {};
local u10 = Instance.new("ColorCorrectionEffect");
u10.Name = "RainEffect";
u10.Parent = l__Lighting__1;
local u11 = Instance.new("Folder");
u11.Name = "RainDrops";
u11.Parent = workspace;
local v12 = Instance.new("Folder");
v12.Name = "RainSplashes";
v12.Parent = workspace;
local u13 = Instance.new("Part");
u13.Name = "RainDrop";
u13.Size = Vector3.new(0.16, 2.4, 0.16);
u13.Material = Enum.Material.Neon;
u13.Color = Color3.fromRGB(100, 150, 255);
u13.Anchored = true;
u13.CanCollide = false;
u13.CastShadow = false;
u13.Transparency = 0.2;
(function() --[[ Name: createSplashTemplate, Line 93 ]]
    local v14 = Instance.new("Part");
    v14.Name = "Splash";
    v14.Size = Vector3.new(0.1, 0.1, 0.1);
    v14.Material = Enum.Material.Neon;
    v14.Color = Color3.fromRGB(120, 170, 255);
    v14.Anchored = false;
    v14.CanCollide = false;
    v14.CastShadow = false;
    v14.Transparency = 0.3;
    v14.Shape = Enum.PartType.Ball;
    return v14;
end)();
local u15 = {};
local u16 = 0;
local _ = 0;
local function u21() --[[ Line: 188 ]]
    -- upvalues: l__CurrentCamera__5 (copy), u7 (copy)
    local l__Position__7 = l__CurrentCamera__5.CFrame.Position;
    local v17 = u7:NextNumber(0, 6.283185307179586);
    local v18 = u7:NextNumber(5, 120);
    local v19 = l__Position__7.X + math.cos(v17) * v18;
    local v20 = l__Position__7.Z + math.sin(v17) * v18;
    return v19, l__Position__7.Y + u7:NextNumber(40, 80), v20;
end;
local function u27() --[[ Line: 202 ]]
    -- upvalues: u3 (ref), u21 (copy), u8 (copy), u16 (ref), u15 (copy), u13 (copy), u11 (copy), u2 (copy)
    if u3 >= 100 then
    else
        local v22, v23, v24 = u21();
        local v25 = Vector3.new(v22, v23, v24);
        if workspace:Raycast(v25, Vector3.new(0, 100, 0), u8) then
        else
            local v26;
            if u16 > 0 then
                v26 = u15[u16];
                u15[u16] = nil;
                u16 = u16 - 1;
            else
                v26 = u13:Clone();
            end;
            v26.CFrame = CFrame.new(v22, v23, v24);
            v26.Parent = u11;
            u3 = u3 + 1;
            u2[u3] = {
                part = v26,
                x = v22,
                y = v23,
                z = v24,
                startY = v23
            };
        end;
    end;
end;
local function u28() --[[ Line: 226 ]]
    -- upvalues: u27 (copy)
    debug.profilebegin("Controllers/WeatherController/Rain/spawnBatch");
    u27();
    u27();
    u27();
    u27();
    u27();
    u27();
    u27();
    debug.profileend();
end;
local function u39(p29) --[[ Line: 237 ]]
    -- upvalues: u3 (ref), l__CurrentCamera__5 (copy), u2 (copy), u16 (ref), u15 (copy), l__clock__4 (copy), u8 (copy)
    debug.profilebegin("Controllers/WeatherController/Rain/renderLoop");
    if u3 == 0 then
        debug.profileend();
        return;
    end;
    local v30 = 70 * p29;
    local l__Y__8 = l__CurrentCamera__5.CFrame.Position.Y;
    debug.profilebegin("Controllers/WeatherController/Rain/renderLoop/iterateDrops");
    local v31 = 1;
    local v32 = {};
    local v33 = {};
    local v34 = 0;
    while true do
        local v35, v36;
        while true do
            while true do
                if v31 > u3 then
                    debug.profileend();
                    if v34 > 0 then
                        debug.profilebegin("Controllers/WeatherController/Rain/renderLoop/BulkMoveTo");
                        workspace:BulkMoveTo(v32, v33, Enum.BulkMoveMode.FireCFrameChanged);
                        debug.profileend();
                    end;
                    debug.profileend();
                    return;
                end;
                v35 = u2[v31];
                v36 = v35.y - v30;
                v35.y = v36;
                if v35.startY - v36 <= 200 and v36 >= l__Y__8 - 50 then
                    break;
                end;
                local l__part__9 = v35.part;
                l__part__9.Parent = nil;
                u16 = u16 + 1;
                u15[u16] = l__part__9;
                u2[v31] = u2[u3];
                u2[u3] = nil;
                u3 = u3 - 1;
            end;
            local v37 = l__clock__4() * 60;
            if (v31 + math.floor(v37)) % 3 ~= 0 then
                break;
            end;
            debug.profilebegin("Controllers/WeatherController/Rain/renderLoop/raycastGround");
            local v38 = Vector3.new(v35.x, v36, v35.z);
            if not workspace:Raycast(v38, Vector3.new(0, -2, 0), u8) then
                debug.profileend();
                break;
            end;
            local l__part__10 = v35.part;
            l__part__10.Parent = nil;
            u16 = u16 + 1;
            u15[u16] = l__part__10;
            u2[v31] = u2[u3];
            u2[u3] = nil;
            u3 = u3 - 1;
            debug.profileend();
        end;
        v34 = v34 + 1;
        v32[v34] = v35.part;
        v33[v34] = CFrame.new(v35.x, v36, v35.z);
        v31 = v31 + 1;
    end;
end;
local function u42() --[[ Line: 319 ]]
    -- upvalues: l__TweenService__2 (copy), l__Lighting__1 (copy), u9 (copy), u10 (copy)
    local v40 = TweenInfo.new(3, Enum.EasingStyle.Sine);
    l__TweenService__2:Create(l__Lighting__1, v40, {
        FogEnd = 350,
        ExposureCompensation = 0.3,
        Brightness = u9.Brightness * 0.7,
        Ambient = Color3.fromRGB(180, 190, 210),
        OutdoorAmbient = Color3.fromRGB(70, 75, 85),
        FogColor = Color3.fromRGB(140, 145, 155)
    }):Play();
    l__TweenService__2:Create(u10, v40, {
        Brightness = 0.05,
        TintColor = Color3.fromRGB(210, 220, 240)
    }):Play();
    local v41 = workspace.Terrain:FindFirstChild("Clouds");
    if v41 == nil then
        v41 = Instance.new("Clouds", game.Workspace.Terrain);
        v41.Density = 0;
        v41.Cover = 0;
    end;
    v41.Enabled = true;
    l__TweenService__2:Create(v41, v40, {
        Cover = 0.85,
        Density = 0.15
    }):Play();
end;
local function u44() --[[ Line: 346 ]]
    -- upvalues: l__TweenService__2 (copy), l__Lighting__1 (copy), u9 (copy), u10 (copy)
    local v43 = TweenInfo.new(3, Enum.EasingStyle.Sine);
    l__TweenService__2:Create(l__Lighting__1, v43, {
        Brightness = u9.Brightness,
        Ambient = u9.Ambient,
        OutdoorAmbient = u9.OutdoorAmbient,
        FogEnd = u9.FogEnd,
        FogColor = u9.FogColor,
        ExposureCompensation = u9.ExposureCompensation
    }):Play();
    l__TweenService__2:Create(u10, v43, {
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    local l__Clouds__11 = workspace.Terrain.Clouds;
    l__TweenService__2:Create(l__Clouds__11, v43, {
        Cover = 0,
        Density = 0
    }):Play();
    task.delay(3, function() --[[ Line: 365 ]]
        -- upvalues: l__Clouds__11 (copy)
        l__Clouds__11.Enabled = false;
    end);
end;
local function u45() --[[ Line: 373 ]]
    -- upvalues: l__Rain__6 (copy), l__TweenService__2 (copy)
    l__Rain__6.Volume = 0;
    l__Rain__6:Play();
    l__TweenService__2:Create(l__Rain__6, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Volume = 0.5
    }):Play();
end;
local function u47() --[[ Line: 381 ]]
    -- upvalues: l__TweenService__2 (copy), l__Rain__6 (copy)
    local v46 = l__TweenService__2:Create(l__Rain__6, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Volume = 0
    });
    v46:Play();
    v46.Completed:Once(function() --[[ Line: 385 ]]
        -- upvalues: l__Rain__6 (ref)
        l__Rain__6:Stop();
    end);
end;
function v1.StartWeather() --[[ Line: 393 ]]
    -- upvalues: u4 (ref), u9 (copy), l__Lighting__1 (copy), u42 (copy), u45 (copy), u5 (ref), l__RunService__3 (copy), u39 (copy), u6 (ref), u28 (copy)
    if u4 then
    else
        u4 = true;
        u9.Brightness = l__Lighting__1.Brightness;
        u9.Ambient = l__Lighting__1.Ambient;
        u9.OutdoorAmbient = l__Lighting__1.OutdoorAmbient;
        u9.FogEnd = l__Lighting__1.FogEnd;
        u9.FogColor = l__Lighting__1.FogColor;
        u9.ExposureCompensation = l__Lighting__1.ExposureCompensation;
        u42();
        u45();
        u5 = l__RunService__3.RenderStepped:Connect(u39);
        u6 = task.spawn(function() --[[ Line: 405 ]]
            -- upvalues: u4 (ref), u28 (ref)
            while u4 do
                u28();
                task.wait(0.01);
            end;
        end);
    end;
end;
function v1.EndWeather() --[[ Line: 413 ]]
    -- upvalues: u4 (ref), u44 (copy), u47 (copy), u5 (ref), u3 (ref), u2 (copy), u16 (ref), u15 (copy)
    if u4 then
        u4 = false;
        u44();
        u47();
        task.delay(4, function() --[[ Line: 421 ]]
            -- upvalues: u5 (ref), u3 (ref), u2 (ref), u16 (ref), u15 (ref)
            if u5 then
                u5:Disconnect();
                u5 = nil;
            end;
            for v48 = 1, u3 do
                if u2[v48] then
                    local l__part__12 = u2[v48].part;
                    l__part__12.Parent = nil;
                    u16 = u16 + 1;
                    u15[u16] = l__part__12;
                    u2[v48] = nil;
                end;
            end;
            u3 = 0;
        end);
    end;
end;
return v1;