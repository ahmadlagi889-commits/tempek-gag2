-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Lighting__1 = game:GetService("Lighting");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__Players__5 = game:GetService("Players");
local l__SoundService__6 = game:GetService("SoundService");
local l__NotificationController__7 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__Networking__8 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__EffectLoadManager__9 = require(l__ReplicatedStorage__3:WaitForChild("SharedModules"):WaitForChild("EffectLoadManager"));
local l__Frame__10 = l__Players__5.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RainbowEffect"):WaitForChild("Frame");
local l__Rainbow__11 = l__SoundService__6:WaitForChild("MusicTracks"):WaitForChild("Rainbow");
local u2 = {
    Color3.fromRGB(255, 80, 80),
    Color3.fromRGB(255, 160, 50),
    Color3.fromRGB(255, 240, 60),
    Color3.fromRGB(80, 220, 80),
    Color3.fromRGB(60, 160, 255),
    Color3.fromRGB(100, 60, 220),
    Color3.fromRGB(180, 80, 220)
};
local u3 = false;
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = 1;
local u8 = 0;
local u9 = 1;
local u10 = 0;
local u11 = Instance.new("ColorCorrectionEffect");
u11.Name = "RainbowEffect";
u11.Brightness = 0;
u11.Saturation = 0;
u11.Parent = l__Lighting__1;
l__Frame__10.BackgroundTransparency = 1;
local u12 = {};
local function v14() --[[ Line: 88 ]]
    -- upvalues: u12 (copy), l__Rainbow__11 (copy)
    table.clear(u12);
    for _, v13 in l__Rainbow__11:GetChildren() do
        if v13:IsA("Sound") then
            table.insert(u12, v13);
        end;
    end;
end;
l__Rainbow__11.ChildAdded:Connect(v14);
l__Rainbow__11.ChildRemoved:Connect(v14);
v14();
local function u16() --[[ Line: 125 ]]
    -- upvalues: l__TweenService__2 (copy), l__Lighting__1 (copy), u4 (copy), u11 (copy)
    local v15 = TweenInfo.new(3, Enum.EasingStyle.Sine);
    l__TweenService__2:Create(l__Lighting__1, v15, {
        Brightness = u4.Brightness + 0.3,
        ExposureCompensation = u4.ExposureCompensation + 0.15
    }):Play();
    l__TweenService__2:Create(u11, v15, {
        Brightness = 0.12,
        Saturation = 0.15
    }):Play();
end;
local function u18() --[[ Line: 137 ]]
    -- upvalues: l__TweenService__2 (copy), l__Lighting__1 (copy), u4 (copy), u11 (copy)
    local v17 = TweenInfo.new(3, Enum.EasingStyle.Sine);
    l__TweenService__2:Create(l__Lighting__1, v17, {
        Brightness = u4.Brightness,
        ExposureCompensation = u4.ExposureCompensation
    }):Play();
    l__TweenService__2:Create(u11, v17, {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0
    }):Play();
end;
local function u25() --[[ Line: 154 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), u5 (ref), l__TweenService__2 (copy)
    local v19 = l__ReplicatedStorage__3.Assets:FindFirstChild("Rainbow");
    if v19 then
        u5 = v19:Clone();
        u5.Name = "ActiveRainbow";
        u5.Parent = workspace;
        local v20 = {};
        for _, v21 in u5:GetDescendants() do
            if v21:IsA("BasePart") then
                if v21:GetAttribute("OGTransparency") == nil then
                    v21:SetAttribute("OGTransparency", v21.Transparency);
                end;
                v21.Transparency = 1;
                table.insert(v20, v21);
            end;
        end;
        local u22 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        for v23, u24 in v20 do
            task.delay(v23 * 0.05, function() --[[ Line: 178 ]]
                -- upvalues: l__TweenService__2 (ref), u24 (copy), u22 (copy)
                l__TweenService__2:Create(u24, u22, {
                    Transparency = u24:GetAttribute("OGTransparency")
                }):Play();
            end);
        end;
    else
        warn("[Rainbow] Rainbow model not found in ReplicatedStorage.Assets");
    end;
end;
local function u31() --[[ Line: 184 ]]
    -- upvalues: u5 (ref), l__TweenService__2 (copy)
    if u5 then
        local v26 = {};
        for _, v27 in u5:GetDescendants() do
            if v27:IsA("BasePart") then
                table.insert(v26, v27);
            end;
        end;
        local v28 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
        for _, v29 in v26 do
            l__TweenService__2:Create(v29, v28, {
                Transparency = 1
            }):Play();
        end;
        local u30 = u5;
        task.delay(2.1, function() --[[ Line: 200 ]]
            -- upvalues: u30 (copy)
            if u30 and u30.Parent then
                u30:Destroy();
            end;
        end);
        u5 = nil;
    end;
end;
local function u40(p32) --[[ Line: 214 ]]
    -- upvalues: u8 (ref), u2 (copy), u7 (ref), l__Frame__10 (copy), u12 (copy), u9 (ref)
    u8 = u8 + p32;
    local v33 = math.clamp(u8 / 2, 0, 1);
    local v34 = u2[u7];
    local v35 = u7 % #u2 + 1;
    local v36 = u2[v35];
    l__Frame__10.BackgroundColor3 = Color3.new(v34.R + (v36.R - v34.R) * v33, v34.G + (v36.G - v34.G) * v33, v34.B + (v36.B - v34.B) * v33);
    if v33 >= 1 then
        u7 = v35;
        u8 = 0;
    end;
    local v37 = 0;
    for _, v38 in u12 do
        if v38.IsPlaying then
            local v39 = v38.PlaybackLoudness / 1000;
            if v37 < v39 then
                v37 = v39;
            end;
        end;
    end;
    if v37 >= 0.12 then
        u9 = math.clamp((v37 - 0.12) / 0.88, 0, 1) * -0.7 + 0.95;
    else
        u9 = 0.95;
    end;
    local l__BackgroundTransparency__12 = l__Frame__10.BackgroundTransparency;
    l__Frame__10.BackgroundTransparency = l__BackgroundTransparency__12 + (u9 - l__BackgroundTransparency__12) * math.min(1, p32 * 8);
end;
local function u41() --[[ Line: 285 ]]
    -- upvalues: u6 (ref), l__TweenService__2 (copy), l__Frame__10 (copy)
    if u6 then
        u6:Disconnect();
        u6 = nil;
    end;
    l__TweenService__2:Create(l__Frame__10, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play();
end;
function u1.StartWeather() --[[ Line: 295 ]]
    -- upvalues: u3 (ref), l__EffectLoadManager__9 (copy), l__NotificationController__7 (copy), u4 (copy), l__Lighting__1 (copy), u16 (copy), u25 (copy), l__Frame__10 (copy), u6 (ref), u7 (ref), u8 (ref), u10 (ref), u9 (ref), l__RunService__4 (copy), u40 (copy)
    if u3 then
    else
        u3 = true;
        l__EffectLoadManager__9.Register();
        l__NotificationController__7:CreateNotification("You received a rainbow magic carpet!🌈");
        u4.Brightness = l__Lighting__1.Brightness;
        u4.Ambient = l__Lighting__1.Ambient;
        u4.OutdoorAmbient = l__Lighting__1.OutdoorAmbient;
        u4.ExposureCompensation = l__Lighting__1.ExposureCompensation;
        u16();
        u25();
        l__Frame__10.BackgroundTransparency = 1;
        l__Frame__10.Visible = true;
        if u6 then
        else
            u7 = 1;
            u8 = 0;
            u10 = 0;
            u9 = 0.95;
            u6 = l__RunService__4.RenderStepped:Connect(function(p42) --[[ Line: 252 ]]
                -- upvalues: u10 (ref), l__EffectLoadManager__9 (ref), u40 (ref)
                u10 = u10 + p42;
                if u10 < l__EffectLoadManager__9.GetTickInterval() then
                else
                    debug.profilebegin("Controllers/WeatherController/Rainbow/Tick");
                    u40(u10);
                    u10 = 0;
                    debug.profileend();
                end;
            end);
        end;
    end;
end;
function u1.EndWeather() --[[ Line: 306 ]]
    -- upvalues: u3 (ref), l__EffectLoadManager__9 (copy), u18 (copy), u31 (copy), u41 (copy)
    if u3 then
        u3 = false;
        l__EffectLoadManager__9.Unregister();
        u18();
        u31();
        u41();
    end;
end;
l__Networking__8.WeatherEffects.RainbowStart.OnClientEvent:Connect(function() --[[ Line: 320 ]]
    -- upvalues: u1 (copy)
    u1.StartWeather();
end);
l__Networking__8.WeatherEffects.RainbowEnd.OnClientEvent:Connect(function() --[[ Line: 324 ]]
    -- upvalues: u1 (copy)
    u1.EndWeather();
end);
return u1;