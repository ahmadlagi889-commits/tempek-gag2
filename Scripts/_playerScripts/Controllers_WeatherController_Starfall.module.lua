-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Lighting__1 = game:GetService("Lighting");
local l__TweenService__2 = game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Players__4 = game:GetService("Players");
local l__SoundService__5 = game:GetService("SoundService");
require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__Skybox__6 = require(game.ReplicatedStorage.ClientModules.Skybox);
local l__StarfallSkybox__7 = game.ReplicatedStorage.Assets.Skybox.StarfallSkybox;
local l__Networking__8 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__Frame__9 = l__Players__4.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RainbowEffect"):WaitForChild("Frame");
l__SoundService__5:WaitForChild("MusicTracks"):WaitForChild("Rainbow");
local _ = {
    Color3.fromRGB(255, 80, 80),
    Color3.fromRGB(255, 160, 50),
    Color3.fromRGB(255, 240, 60),
    Color3.fromRGB(80, 220, 80),
    Color3.fromRGB(60, 160, 255),
    Color3.fromRGB(100, 60, 220),
    Color3.fromRGB(180, 80, 220)
};
local u2 = false;
local u3 = {};
local u4 = nil;
local u5 = Instance.new("ColorCorrectionEffect");
u5.Name = "StarEffect";
u5.Brightness = 0;
u5.Saturation = 0;
u5.Parent = l__Lighting__1;
l__Frame__9.BackgroundTransparency = 1;
local function u8() --[[ Line: 106 ]]
    -- upvalues: l__TweenService__2 (copy), l__Lighting__1 (copy), u5 (copy), l__Skybox__6 (copy), l__StarfallSkybox__7 (copy)
    workspace:SetAttribute("TimeFrozen", true);
    l__TweenService__2:Create(l__Lighting__1, TweenInfo.new(2), {
        ClockTime = 27
    }):Play();
    task.wait(2);
    local v6 = TweenInfo.new(3, Enum.EasingStyle.Sine);
    l__TweenService__2:Create(l__Lighting__1, v6, {
        Brightness = 1,
        ExposureCompensation = 0.7,
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ClockTime = 9.5,
        Ambient = Color3.fromRGB(143, 137, 211),
        OutdoorAmbient = Color3.fromRGB(220, 170, 255)
    }):Play();
    l__TweenService__2:Create(game.Workspace.Terrain.Clouds, v6, {
        Cover = 0.56,
        Density = 1,
        Color = Color3.fromRGB(89, 89, 255)
    }):Play();
    local v7 = game.Lighting:FindFirstChild("ActiveNightAtmosphere");
    if not v7 then
        v7 = game.ReplicatedStorage.Assets.NightAtmosphere:Clone();
        v7.Parent = game.Lighting;
        v7.Name = "StarSphere";
    end;
    l__TweenService__2:Create(v7, TweenInfo.new(3), {
        Density = 0.3,
        Haze = 1,
        Color = Color3.fromRGB(0, 179, 199)
    }):Play();
    l__TweenService__2:Create(u5, v6, {
        Brightness = 0.05,
        Contrast = 0.1,
        Saturation = 0.1,
        TintColor = Color3.fromRGB(199, 214, 255)
    }):Play();
    l__Skybox__6.SetOrder(l__StarfallSkybox__7, 3);
end;
local function u10() --[[ Line: 150 ]]
    -- upvalues: l__TweenService__2 (copy), l__Lighting__1 (copy), u3 (copy), u5 (copy), l__Skybox__6 (copy), l__StarfallSkybox__7 (copy)
    workspace:SetAttribute("TimeFrozen", nil);
    local v9 = TweenInfo.new(3, Enum.EasingStyle.Sine);
    l__TweenService__2:Create(l__Lighting__1, v9, {
        EnvironmentDiffuseScale = 0,
        EnvironmentSpecularScale = 0,
        Brightness = u3.Brightness,
        ExposureCompensation = u3.ExposureCompensation,
        Ambient = u3.Ambient,
        OutdoorAmbient = u3.OutdoorAmbient,
        ClockTime = u3.ClockTime
    }):Play();
    l__TweenService__2:Create(u5, v9, {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    l__TweenService__2:Create(game.Workspace.Terrain.Clouds, v9, {
        Cover = 0,
        Density = 0,
        Color = Color3.fromRGB(255, 255, 255)
    }):Play();
    if game.Lighting:FindFirstChild("StarSphere") then
        game.Lighting:FindFirstChild("StarSphere"):Destroy();
    end;
    l__Skybox__6.SetOrder(l__StarfallSkybox__7, 0);
end;
local function u11() --[[ Line: 206 ]]
    -- upvalues: u4 (ref), l__TweenService__2 (copy), l__Frame__9 (copy)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;
    l__TweenService__2:Create(l__Frame__9, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        BackgroundTransparency = 1
    }):Play();
end;
l__Networking__8.WeatherEffects.ShootingStar.OnClientEvent:Connect(function(p12) --[[ Line: 216 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy)
    local v13 = l__ReplicatedStorage__3.Assets.ShootingStarMeteor:Clone();
    local v14 = CFrame.new(p12) * CFrame.new(0, 200, 250);
    v13.CFrame = v14;
    v13.Parent = workspace;
    v13.Travel:Play();
    local v15 = 0;
    while v15 < 4 do
        v15 = v15 + task.wait();
        local v16 = game.TweenService:GetValue(v15 / 4, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        v13:PivotTo(v14:Lerp(CFrame.new(p12), v16));
        v13.Attachment.BillboardGui.ImageLabel.Rotation = tick() * 90;
    end;
    v13.Poof:Play();
    v13.Attachment.BillboardGui.Enabled = false;
    for _, v17 in v13.Attachment.Attachment:GetChildren() do
        if v17:IsA("ParticleEmitter") then
            v17:Emit(v17:GetAttribute("EmitCount") or 5);
        elseif v17:IsA("PointLight") then
            game.TweenService:Create(v17, TweenInfo.new(3), {
                Range = 0
            }):Play();
        end;
    end;
    game.Debris:AddItem(v13, 4);
end);
local u18 = game.ReplicatedStorage.Assets.StarfallModel:Clone();
function u1.StartWeather() --[[ Line: 259 ]]
    -- upvalues: u2 (ref), u18 (copy), u3 (copy), l__Lighting__1 (copy), u8 (copy), l__Frame__9 (copy), u4 (ref)
    if u2 then
    else
        u2 = true;
        for _, v19 in u18:GetDescendants() do
            if v19:IsA("ParticleEmitter") then
                v19.Enabled = true;
            end;
        end;
        u18.Parent = workspace;
        u3.Brightness = l__Lighting__1.Brightness;
        u3.Ambient = l__Lighting__1.Ambient;
        u3.OutdoorAmbient = l__Lighting__1.OutdoorAmbient;
        u3.ExposureCompensation = l__Lighting__1.ExposureCompensation;
        u3.ClockTime = l__Lighting__1.ClockTime;
        u8();
        l__Frame__9.BackgroundTransparency = 1;
        l__Frame__9.Visible = true;
        if u4 then
        end;
    end;
end;
function u1.EndWeather() --[[ Line: 275 ]]
    -- upvalues: u2 (ref), u18 (copy), u10 (copy), u11 (copy)
    if u2 then
        u2 = false;
        for _, v20 in u18:GetDescendants() do
            if v20:IsA("ParticleEmitter") then
                v20.Enabled = false;
                v20:Clear();
            end;
        end;
        u18.Parent = script;
        u10();
        u11();
    end;
end;
workspace:GetAttributeChangedSignal("ShootingStarEvent"):Connect(function() --[[ Line: 291 ]]
    -- upvalues: u1 (copy)
    if workspace:GetAttribute("ShootingStarEvent") then
        u1.StartWeather();
    else
        u1.EndWeather();
    end;
end);
return u1;