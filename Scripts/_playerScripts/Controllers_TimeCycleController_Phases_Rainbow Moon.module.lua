-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("Lighting");
local l__TweenService__1 = game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
game:GetService("SoundService");
local l__Networking__4 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__5 = l__Players__3.LocalPlayer;
local l__CamShake__6 = require(l__ReplicatedStorage__2.ClientModules.CamShake);
local l__NotificationController__7 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__FieldOfViewController__8 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController);
local l__LightingController__9 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
local l__RainbowMoon__10 = l__ReplicatedStorage__2.Assets:WaitForChild("RainbowMoon");
local l__Skybox__11 = require(game.ReplicatedStorage.ClientModules.Skybox);
local l__RainbowMoon__12 = game.ReplicatedStorage.Assets.Skybox.RainbowMoon;
local u2 = {
    Brightness = 4,
    EnvironmentDiffuseScale = 1,
    ClockTime = 23,
    Ambient = Color3.fromRGB(197, 36, 241),
    ColorShift_Bottom = Color3.fromRGB(74, 171, 110),
    ColorShift_Top = Color3.fromRGB(125, 63, 250),
    OutdoorAmbient = Color3.fromRGB(74, 139, 180)
};
local function u13(p3, p4, p5, p6, p7) --[[ Line: 46 ]]
    -- upvalues: l__TweenService__1 (copy)
    local v8 = p3:GetScale();
    local v9 = p6 or Enum.EasingStyle.Linear;
    local v10 = p7 or Enum.EasingDirection.InOut;
    local v11 = 0;
    while v11 < p5 do
        v11 = v11 + task.wait(0);
        local v12 = l__TweenService__1:GetValue(math.clamp(v11 / p5, 0.01, 1), v9, v10);
        p3:ScaleTo(v8 + (p4 - v8) * v12);
    end;
end;
local u14 = nil;
task.spawn(function() --[[ Line: 74 ]]
    while true do
        task.wait(0.025);
        local v15 = tick() / 2 % 1;
        local v16 = Color3.fromHSV(v15, 1, 1);
        for _, v17 in game.CollectionService:GetTagged("RainbowTween") do
            if v17:IsA("Highlight") then
                local v18 = v17:HasTag("Multiplier") and 1.5 or 1;
                v17.FillColor = Color3.fromHSV(v15 * v18, 1 * v18, 1 * v18);
            elseif v17:IsA("ImageLabel") then
                v17.ImageColor3 = v16;
            else
                v17.Color = v16;
            end;
        end;
    end;
end);
local function v37(p19) --[[ Line: 101 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__Players__3 (copy), u14 (ref), l__LocalPlayer__5 (copy), l__FieldOfViewController__8 (copy), l__NotificationController__7 (copy)
    if p19:GetAttribute("Rainbow") then
    else
        p19:SetAttribute("Rainbow", true);
        for _, v20 in l__ReplicatedStorage__2.Assets.RainbowEffect:GetChildren() do
            local v21 = v20:Clone();
            if v21:IsA("Highlight") then
                v21.Parent = p19;
                v21:AddTag("Multiplier");
                v21:AddTag("RainbowTween");
            else
                v21.Parent = p19:WaitForChild("Torso");
            end;
            v21:AddTag("ClearUpRainbow");
        end;
        if p19 == l__Players__3.LocalPlayer.Character and not u14 then
            u14 = l__ReplicatedStorage__2.Assets.Vignette:Clone();
            u14.ImageLabel.ImageTransparency = 0.7;
            u14.ImageLabel.UIScale.Scale = 1;
            u14.ImageLabel:AddTag("RainbowTween");
            game.TweenService:Create(u14.ImageLabel.UIScale, TweenInfo.new(1), {
                Scale = 1.04
            }):Play();
            game.TweenService:Create(u14.ImageLabel, TweenInfo.new(1), {
                ImageTransparency = 0.8
            }):Play();
            u14.Parent = l__LocalPlayer__5.PlayerGui;
            local u22 = Instance.new("ColorCorrectionEffect");
            u22.Parent = game.Lighting;
            game.TweenService:Create(u22, TweenInfo.new(0.4), {
                Brightness = 0.4,
                TintColor = Color3.fromRGB(235, 175, 255)
            }):Play();
            game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
                FieldOfView = 90
            }):Play();
            task.delay(0.4, function() --[[ Line: 141 ]]
                -- upvalues: u22 (copy), l__FieldOfViewController__8 (ref)
                game.TweenService:Create(u22, TweenInfo.new(0.8), {
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                game.Debris:AddItem(u22, 0.8);
                game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.6), {
                    FieldOfView = 80
                }):Play();
                l__FieldOfViewController__8:SetBaseFOV(80);
            end);
            local function u28(p23, p24) --[[ Line: 155 ]]
                local l__Keypoints__13 = p23.Keypoints;
                if p24 <= l__Keypoints__13[1].Time then
                    return l__Keypoints__13[1].Value;
                end;
                if l__Keypoints__13[#l__Keypoints__13].Time <= p24 then
                    return l__Keypoints__13[#l__Keypoints__13].Value;
                end;
                for v25 = 1, #l__Keypoints__13 - 1 do
                    local v26 = l__Keypoints__13[v25];
                    local v27 = l__Keypoints__13[v25 + 1];
                    if v26.Time <= p24 and p24 <= v27.Time then
                        return v26.Value:lerp(v27.Value, (p24 - v26.Time) / (v27.Time - v26.Time));
                    end;
                end;
                return l__Keypoints__13[#l__Keypoints__13].Value;
            end;
            l__NotificationController__7:CreateNotification("You are " .. ("<font color=\"#" .. Color3.fromRGB(255, 204, 0):ToHex() .. "\">STAR-POWERED!</font>") .. " Steal QUICK to get a " .. (function(p29, p30) --[[ Name: Gradient, Line 177 ]]
                -- upvalues: u28 (copy)
                local l__Color__14 = p29.Color;
                local v31 = #p30;
                local v32 = {};
                for v33 = 1, v31 do
                    local v34 = u28(l__Color__14, (v33 - 1) / math.max(v31 - 1, 1));
                    local v35 = string.sub(p30, v33, v33);
                    local l__format__15 = string.format;
                    local v36 = v34:ToHex();
                    table.insert(v32, l__format__15("<font color=\"#%s\">%s</font>", v36, v35));
                end;
                return table.concat(v32);
            end)(game.ReplicatedStorage.Assets.RainbowGradient, "RAINBOW") .. " plant!", nil, 7);
        end;
    end;
end;
local function v42(p38) --[[ Line: 208 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__LocalPlayer__5 (copy), u14 (ref), l__FieldOfViewController__8 (copy)
    local v39 = l__ReplicatedStorage__2.Assets.RainbowDisperse:Clone();
    v39.Parent = p38.HumanoidRootPart;
    for _, v40 in v39:GetChildren() do
        if v40:IsA("ParticleEmitter") then
            v40:Emit(v40:GetAttribute("EmitCount") or 3);
        elseif v40:IsA("Sound") then
            v40:Play();
        end;
    end;
    if p38 == l__LocalPlayer__5.Character and u14 then
        game.TweenService:Create(u14.ImageLabel.UIScale, TweenInfo.new(1), {
            Scale = 1.14
        }):Play();
        game.TweenService:Create(u14.ImageLabel, TweenInfo.new(1), {
            ImageTransparency = 1
        }):Play();
        l__FieldOfViewController__8:SetBaseFOV(70);
        game.Debris:AddItem(u14, 1);
        u14 = nil;
    end;
    game.Debris:AddItem(v39, 3);
    p38:SetAttribute("Rainbow", nil);
    for _, v41 in p38:GetDescendants() do
        if v41:HasTag("ClearUpRainbow") then
            if v41:IsA("Highlight") then
                game.TweenService:Create(v41, TweenInfo.new(0.5), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                }):Play();
            elseif v41:IsA("ParticleEmitter") or v41:IsA("Trail") then
                v41.Enabled = false;
            end;
            game.Debris:AddItem(v41, 1);
        end;
    end;
end;
for _, v43 in game.CollectionService:GetTagged("RainbowHighlight") do
    v37(v43);
end;
game.CollectionService:GetInstanceAddedSignal("RainbowHighlight"):Connect(v37);
game.CollectionService:GetInstanceRemovedSignal("RainbowHighlight"):Connect(v42);
l__Networking__4.WeatherEffects.RainbowMoonStrike.OnClientEvent:Connect(function(p44) --[[ Line: 259 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy)
    local v45 = l__ReplicatedStorage__2.Assets.RainbowMeteor:Clone();
    local v46 = CFrame.new(p44) * CFrame.new(0, 200, 250);
    v45.CFrame = v46;
    v45.Parent = workspace;
    v45.Travel:Play();
    local v47 = 0;
    while v47 < 2 do
        v47 = v47 + task.wait(0.025);
        local v48 = game.TweenService:GetValue(v47 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
        v45:PivotTo(v46:Lerp(CFrame.new(p44), v48));
        v45.Attachment.BillboardGui.ImageLabel.Rotation = tick() * 720 % 360;
        v45.Attachment.BillboardGui.ImageLabel.ImageColor3 = Color3.fromHSV(tick() % 1, 1, 1);
    end;
    v45.Poof:Play();
    v45.Attachment.BillboardGui.Enabled = false;
    for _, v49 in v45.Attachment.Attachment:GetChildren() do
        v49:Emit(v49:GetAttribute("EmitCount") or 5);
    end;
    game.Debris:AddItem(v45, 4);
end);
local function u57() --[[ Line: 295 ]]
    -- upvalues: l__Skybox__11 (copy), l__RainbowMoon__12 (copy), l__TweenService__1 (copy), l__CamShake__6 (copy), l__RainbowMoon__10 (copy), u13 (copy)
    game.TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(1), {
        Cover = 0
    }):Play();
    task.delay(1, function() --[[ Line: 299 ]]
        -- upvalues: l__Skybox__11 (ref), l__RainbowMoon__12 (ref)
        l__Skybox__11.SetOrder(l__RainbowMoon__12, 2);
    end);
    task.delay(3, function() --[[ Line: 303 ]]
        -- upvalues: l__TweenService__1 (ref), l__CamShake__6 (ref), l__RainbowMoon__10 (ref), u13 (ref)
        local u50 = Instance.new("ColorCorrectionEffect");
        u50.Parent = game.Lighting;
        game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
            FieldOfView = 95
        }):Play();
        l__TweenService__1:Create(u50, TweenInfo.new(0.4), {
            Brightness = 1.5,
            Contrast = 0.2,
            Saturation = 0.5,
            TintColor = Color3.fromRGB(243, 153, 255)
        }):Play();
        l__CamShake__6:Shake(l__CamShake__6.Presets.Explosion);
        local u51 = game.ReplicatedStorage.Assets.RainbowScreenEffect:Clone();
        local u52 = true;
        u51.Parent = workspace.Camera;
        task.spawn(function() --[[ Line: 320 ]]
            -- upvalues: u52 (ref), u51 (copy)
            while u52 do
                local v53 = math.rad(workspace.CurrentCamera.FieldOfView / 2);
                local v54 = math.tan(v53) * 8 / (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y);
                u51.Size = Vector3.new(v54, 0.1, 2.2);
                u51.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -4);
                game:GetService("RunService").RenderStepped:Wait();
            end;
        end);
        local u55 = u52;
        for _, v56 in u51:GetChildren() do
            v56:Emit(v56:GetAttribute("EmitCount"));
        end;
        game.SoundService:PlayLocalSound(game.SoundService.SFX.RainbowPoof);
        task.delay(8, function() --[[ Line: 339 ]]
            -- upvalues: u55 (ref)
            u55 = false;
        end);
        game.Debris:AddItem(u51, 8);
        task.delay(0.4, function() --[[ Line: 346 ]]
            -- upvalues: l__RainbowMoon__10 (ref), l__TweenService__1 (ref), u50 (copy), u13 (ref)
            local l__CFrame__16 = l__RainbowMoon__10.beams.CFrame;
            l__RainbowMoon__10.beams.CFrame = CFrame.new(0, -5, 0) * l__CFrame__16;
            l__RainbowMoon__10.Parent = workspace;
            l__TweenService__1:Create(u50, TweenInfo.new(2), {
                Brightness = 0,
                Contrast = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            game.TweenService:Create(l__RainbowMoon__10.beams, TweenInfo.new(0.4), {
                CFrame = l__CFrame__16
            }):Play();
            game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2), {
                FieldOfView = 70
            }):Play();
            task.wait(2);
            game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
                FieldOfView = 70
            }):Play();
            l__TweenService__1:Create(u50, TweenInfo.new(0.2), {
                Brightness = 0.6,
                Contrast = 0,
                Saturation = 0.2,
                TintColor = Color3.fromRGB(243, 153, 255)
            }):Play();
            task.delay(0.3, function() --[[ Line: 362 ]]
                -- upvalues: l__TweenService__1 (ref), u50 (ref)
                game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2), {
                    FieldOfView = 70
                }):Play();
                l__TweenService__1:Create(u50, TweenInfo.new(2), {
                    Brightness = 0,
                    Contrast = 0,
                    Saturation = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
            end);
            u13(l__RainbowMoon__10.MoonModel, 1, 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
        end);
    end);
end;
local function u59() --[[ Line: 373 ]]
    -- upvalues: l__TweenService__1 (copy), l__CamShake__6 (copy), l__RainbowMoon__10 (copy), l__ReplicatedStorage__2 (copy), l__Skybox__11 (copy), l__RainbowMoon__12 (copy)
    local u58 = Instance.new("ColorCorrectionEffect");
    u58.Parent = game.Lighting;
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
        FieldOfView = 95
    }):Play();
    l__TweenService__1:Create(u58, TweenInfo.new(0.4), {
        Brightness = 1.5,
        Contrast = 0.2,
        Saturation = 0.5,
        TintColor = Color3.fromRGB(243, 153, 255)
    }):Play();
    l__CamShake__6:Shake(l__CamShake__6.Presets.Explosion);
    game.SoundService:PlayLocalSound(game.SoundService.SFX.Snap);
    task.delay(0.4, function() --[[ Line: 383 ]]
        -- upvalues: l__TweenService__1 (ref), u58 (copy)
        l__TweenService__1:Create(u58, TweenInfo.new(2), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(2), {
            FieldOfView = 70
        }):Play();
    end);
    game.TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(1), {
        Cover = 0.5
    }):Play();
    l__RainbowMoon__10.Parent = l__ReplicatedStorage__2.Assets;
    l__Skybox__11.SetOrder(l__RainbowMoon__12, 0);
end;
function v1.Start(_, _, _) --[[ Line: 395 ]]
    -- upvalues: l__LightingController__9 (copy), u2 (copy), u57 (copy)
    if isActive then
    else
        isActive = true;
        l__LightingController__9:TransitionTo(u2, 3);
        u57();
    end;
end;
function v1.End(_) --[[ Line: 404 ]]
    -- upvalues: u59 (copy)
    if isActive then
        isActive = false;
        u59();
    end;
end;
return v1;