-- Decompiled with Potassium's decompiler.

local v1 = {
    NoMusic = true
};
game:GetService("Lighting");
local l__TweenService__1 = game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
game:GetService("SoundService");
require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__4 = l__Players__3.LocalPlayer;
local l__CamShake__5 = require(l__ReplicatedStorage__2.ClientModules.CamShake);
local l__NotificationController__6 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
local l__FieldOfViewController__7 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController);
local l__LightingController__8 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
local l__MusicController__9 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.MusicController);
require(game.ReplicatedStorage.ClientModules.Reticule);
local l__ChainedMoon__10 = l__ReplicatedStorage__2.Assets:WaitForChild("ChainedMoon");
local l__Skybox__11 = require(game.ReplicatedStorage.ClientModules.Skybox);
local l__EnchainedMoon__12 = game.ReplicatedStorage.Assets.Skybox.EnchainedMoon;
local l__ButtonMash__13 = require(game.ReplicatedStorage.ClientModules.ButtonMash);
local l__RagdollModule__14 = require(game.ReplicatedStorage.ClientModules.RagdollModule);
local l__Networking__15 = require(game.ReplicatedStorage.SharedModules.Networking);
local u2 = {
    ClockTime = 23
};
local u3 = {
    Brightness = 4,
    EnvironmentDiffuseScale = 1,
    ClockTime = 23,
    Ambient = Color3.fromRGB(197, 36, 241),
    ColorShift_Bottom = Color3.fromRGB(163, 70, 199),
    ColorShift_Top = Color3.fromRGB(125, 63, 250),
    OutdoorAmbient = Color3.fromRGB(74, 139, 180)
};
local u4 = nil;
local u5 = nil;
local u6 = game.SoundService.SFX.ShakeLoop:Clone();
local function u76() --[[ Line: 95 ]]
    -- upvalues: l__Skybox__11 (copy), l__EnchainedMoon__12 (copy), l__MusicController__9 (copy), l__ReplicatedStorage__2 (copy), l__LocalPlayer__4 (copy), l__FieldOfViewController__7 (copy), l__CamShake__5 (copy), l__LightingController__8 (copy), u3 (copy), u4 (ref), l__TweenService__1 (copy), l__ChainedMoon__10 (copy), u6 (copy)
    game.TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(1), {
        Cover = 0
    }):Play();
    task.delay(1, function() --[[ Line: 99 ]]
        -- upvalues: l__Skybox__11 (ref), l__EnchainedMoon__12 (ref)
        l__Skybox__11.SetOrder(l__EnchainedMoon__12, 2);
    end);
    l__MusicController__9:SetActiveWeather("Chained Moon");
    local u7 = false;
    local u8 = true;
    local u9 = game.SoundService.SFX.Gear:Clone();
    u9.Parent = game.SoundService;
    local u10 = game.SoundService.SFX.ChainMove:Clone();
    u10.Parent = game.SoundService;
    local u11 = game.ReplicatedStorage.Assets.ChainEffect:Clone();
    u11.Parent = workspace.CurrentCamera;
    local u12 = 2;
    local u13 = -1;
    task.spawn(function() --[[ Line: 113 ]]
        -- upvalues: u8 (ref), u7 (ref), u11 (copy), u12 (copy), u13 (copy), l__ReplicatedStorage__2 (ref), l__LocalPlayer__4 (ref), l__FieldOfViewController__7 (ref), l__CamShake__5 (ref)
        task.wait(0.4);
        game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainMove);
        local v14 = game.SoundService.SFX.Gear:Clone();
        v14.Parent = game.SoundService;
        v14.PlayOnRemove = true;
        v14:Destroy();
        local v15 = 0;
        local v16 = false;
        while u8 do
            v15 = v15 + game:GetService("RunService").Heartbeat:Wait();
            local v17 = math.rad(workspace.CurrentCamera.FieldOfView / 2);
            local v18 = math.tan(v17) * 8;
            local v19 = v18 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y);
            local v20 = 0.5 * (workspace.CurrentCamera.FieldOfView / 70);
            if u7 then
                u11.Attachment1.Beam.TextureSpeed = 10 * v20;
            end;
            u11.Attachment1.Beam.Width0 = v20;
            u11.Attachment1.Beam.Width1 = v20;
            u11.Attachment1.Beam.TextureLength = v20;
            local v21 = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -u12);
            local v22 = v21 * CFrame.new(u13 * (v19 / 4), v18 / 4, 0);
            local v23 = v21 * CFrame.new(-u13 * (v19 / 4), -v18 / 4, 0);
            local l__LookVector__16 = CFrame.new(v22.p, v23.p).LookVector;
            local v24 = game.TweenService:GetValue(math.min(v15, 0.7) / 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            if v24 == 1 and not v16 then
                v16 = true;
                for _, v25 in u11.Attachment2:GetChildren() do
                    v25:Emit(v25:GetAttribute("EmitCount") or 15);
                    v25.Enabled = false;
                end;
                local v26 = l__ReplicatedStorage__2.Assets.Vignette:Clone();
                v26.ImageLabel.ImageTransparency = 0.7;
                v26.ImageLabel.UIScale.Scale = 1;
                v26.ImageLabel.ImageColor3 = Color3.fromRGB(255, 108, 253);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Forge);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainImpact);
                game.TweenService:Create(v26.ImageLabel.UIScale, TweenInfo.new(1), {
                    Scale = 1.1
                }):Play();
                game.TweenService:Create(v26.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
                v26.Parent = l__LocalPlayer__4.PlayerGui;
                local u27 = Instance.new("ColorCorrectionEffect");
                u27.Parent = game.Lighting;
                game.TweenService:Create(u27, TweenInfo.new(0.3), {
                    Brightness = 0.4,
                    TintColor = Color3.fromRGB(210, 119, 255)
                }):Play();
                game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
                    FieldOfView = 90
                }):Play();
                task.delay(0.4, function() --[[ Line: 183 ]]
                    -- upvalues: u27 (copy), l__FieldOfViewController__7 (ref)
                    game.TweenService:Create(u27, TweenInfo.new(0.4), {
                        Brightness = 0,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    game.Debris:AddItem(u27, 0.8);
                    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
                        FieldOfView = 80
                    }):Play();
                    l__FieldOfViewController__7:SetBaseFOV(80);
                end);
                game.Debris:AddItem(v26, 1);
                l__CamShake__5:Shake(l__CamShake__5.Presets.SideExplosion);
                local u28 = game.ReplicatedStorage.Assets.ChainGlow:Clone();
                u28.Parent = u11;
                for _, v29 in u28:GetChildren() do
                    v29:Emit(v29:GetAttribute("EmitCount") or 15);
                end;
                task.spawn(function() --[[ Line: 203 ]]
                    -- upvalues: u8 (ref), u28 (copy), u13 (ref)
                    while u8 do
                        local v30 = math.rad(workspace.CurrentCamera.FieldOfView / 2);
                        local v31 = math.tan(v30) * 8;
                        local v32 = v31 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y);
                        u28.Size = Vector3.new(v32 / 2, 0.1, 0.1);
                        u28.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(-u13 * v32 / 4, -v31 / 2, -4);
                        game:GetService("RunService").RenderStepped:Wait();
                    end;
                    u28:Destroy();
                end);
            end;
            local v33 = v22:Lerp(v23, v24);
            u11.Attachment2.WorldCFrame = CFrame.new(v33.Position, v33.Position + l__LookVector__16);
            u11.Attachment1.WorldCFrame = v22;
        end;
        u11:Destroy();
    end);
    task.wait(0.7);
    task.delay(0.3, function() --[[ Line: 243 ]]
        -- upvalues: l__LightingController__8 (ref), u3 (ref)
        l__LightingController__8:TransitionTo(u3, 0.4);
    end);
    task.wait(1);
    local u34 = game.ReplicatedStorage.Assets.ChainEffect:Clone();
    u34.Parent = workspace.CurrentCamera;
    local u35 = 2.1;
    local u36 = 1;
    task.spawn(function() --[[ Line: 113 ]]
        -- upvalues: u8 (ref), u7 (ref), u34 (copy), u35 (copy), u36 (copy), l__ReplicatedStorage__2 (ref), l__LocalPlayer__4 (ref), l__FieldOfViewController__7 (ref), l__CamShake__5 (ref)
        task.wait(0.4);
        game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainMove);
        local v37 = game.SoundService.SFX.Gear:Clone();
        v37.Parent = game.SoundService;
        v37.PlayOnRemove = true;
        v37:Destroy();
        local v38 = 0;
        local v39 = false;
        while u8 do
            v38 = v38 + game:GetService("RunService").Heartbeat:Wait();
            local v40 = math.rad(workspace.CurrentCamera.FieldOfView / 2);
            local v41 = math.tan(v40) * 8;
            local v42 = v41 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y);
            local v43 = 0.5 * (workspace.CurrentCamera.FieldOfView / 70);
            if u7 then
                u34.Attachment1.Beam.TextureSpeed = 10 * v43;
            end;
            u34.Attachment1.Beam.Width0 = v43;
            u34.Attachment1.Beam.Width1 = v43;
            u34.Attachment1.Beam.TextureLength = v43;
            local v44 = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -u35);
            local v45 = v44 * CFrame.new(u36 * (v42 / 4), v41 / 4, 0);
            local v46 = v44 * CFrame.new(-u36 * (v42 / 4), -v41 / 4, 0);
            local l__LookVector__17 = CFrame.new(v45.p, v46.p).LookVector;
            local v47 = game.TweenService:GetValue(math.min(v38, 0.7) / 0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            if v47 == 1 and not v39 then
                v39 = true;
                for _, v48 in u34.Attachment2:GetChildren() do
                    v48:Emit(v48:GetAttribute("EmitCount") or 15);
                    v48.Enabled = false;
                end;
                local v49 = l__ReplicatedStorage__2.Assets.Vignette:Clone();
                v49.ImageLabel.ImageTransparency = 0.7;
                v49.ImageLabel.UIScale.Scale = 1;
                v49.ImageLabel.ImageColor3 = Color3.fromRGB(255, 108, 253);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.Forge);
                game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainImpact);
                game.TweenService:Create(v49.ImageLabel.UIScale, TweenInfo.new(1), {
                    Scale = 1.1
                }):Play();
                game.TweenService:Create(v49.ImageLabel, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play();
                v49.Parent = l__LocalPlayer__4.PlayerGui;
                local u50 = Instance.new("ColorCorrectionEffect");
                u50.Parent = game.Lighting;
                game.TweenService:Create(u50, TweenInfo.new(0.3), {
                    Brightness = 0.4,
                    TintColor = Color3.fromRGB(210, 119, 255)
                }):Play();
                game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
                    FieldOfView = 90
                }):Play();
                task.delay(0.4, function() --[[ Line: 183 ]]
                    -- upvalues: u50 (copy), l__FieldOfViewController__7 (ref)
                    game.TweenService:Create(u50, TweenInfo.new(0.4), {
                        Brightness = 0,
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    game.Debris:AddItem(u50, 0.8);
                    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
                        FieldOfView = 80
                    }):Play();
                    l__FieldOfViewController__7:SetBaseFOV(80);
                end);
                game.Debris:AddItem(v49, 1);
                l__CamShake__5:Shake(l__CamShake__5.Presets.SideExplosion);
                local u51 = game.ReplicatedStorage.Assets.ChainGlow:Clone();
                u51.Parent = u34;
                for _, v52 in u51:GetChildren() do
                    v52:Emit(v52:GetAttribute("EmitCount") or 15);
                end;
                task.spawn(function() --[[ Line: 203 ]]
                    -- upvalues: u8 (ref), u51 (copy), u36 (ref)
                    while u8 do
                        local v53 = math.rad(workspace.CurrentCamera.FieldOfView / 2);
                        local v54 = math.tan(v53) * 8;
                        local v55 = v54 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y);
                        u51.Size = Vector3.new(v55 / 2, 0.1, 0.1);
                        u51.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(-u36 * v55 / 4, -v54 / 2, -4);
                        game:GetService("RunService").RenderStepped:Wait();
                    end;
                    u51:Destroy();
                end);
            end;
            local v56 = v45:Lerp(v46, v47);
            u34.Attachment2.WorldCFrame = CFrame.new(v56.Position, v56.Position + l__LookVector__17);
            u34.Attachment1.WorldCFrame = v45;
        end;
        u34:Destroy();
    end);
    task.wait(1.1);
    u4 = l__ReplicatedStorage__2.Assets.Vignette:Clone();
    u4.ImageLabel.ImageTransparency = 0.7;
    u4.ImageLabel.UIScale.Scale = 1;
    u4.ImageLabel.ImageColor3 = Color3.fromRGB(255, 108, 253);
    game.TweenService:Create(u4.ImageLabel.UIScale, TweenInfo.new(1), {
        Scale = 1.04
    }):Play();
    game.TweenService:Create(u4.ImageLabel, TweenInfo.new(1), {
        ImageTransparency = 0.8
    }):Play();
    u4.Parent = l__LocalPlayer__4.PlayerGui;
    l__CamShake__5:ShakeSustain(l__CamShake__5.Presets.Earthquake, 0);
    task.delay(0.5, function() --[[ Line: 262 ]]
        -- upvalues: u7 (ref), u9 (copy), u10 (copy)
        u7 = true;
        u9.Looped = true;
        u10:Play();
        u9:Play();
    end);
    task.delay(1, function() --[[ Line: 274 ]]
        -- upvalues: l__TweenService__1 (ref), l__CamShake__5 (ref), u8 (ref), u10 (copy), u9 (copy), l__ChainedMoon__10 (ref), u6 (ref)
        local u57 = Instance.new("ColorCorrectionEffect");
        u57.Parent = game.Lighting;
        game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
            FieldOfView = 95
        }):Play();
        l__TweenService__1:Create(u57, TweenInfo.new(0.3), {
            Brightness = 1.5,
            Contrast = 0.2,
            Saturation = 0.5,
            TintColor = Color3.fromRGB(243, 153, 255)
        }):Play();
        l__CamShake__5:Shake(l__CamShake__5.Presets.Explosion);
        task.wait(0.38);
        u57.Brightness = 131;
        u57.Contrast = 0;
        u57.Saturation = 155;
        task.wait(0.08);
        u57.Brightness = -4;
        u57.Contrast = 10;
        u57.Saturation = -1;
        workspace.CurrentCamera.FieldOfView = 90;
        task.wait(0.08);
        u57.Brightness = 1.5;
        u57.Contrast = 0.1;
        u57.Saturation = -0.2;
        u8 = false;
        u10:Stop();
        u9:Stop();
        game.Debris:AddItem(u9, 1);
        game.Debris:AddItem(u10, 1);
        game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainBreak);
        game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainImpact2);
        game.TweenService:Create(game.SoundService.Master.GameMusic, TweenInfo.new(3), {
            Volume = 1
        }):Play();
        game.Workspace.CurrentCamera.FieldOfView = 110;
        l__CamShake__5:Shake(l__CamShake__5.Presets.Explosion);
        local u58 = l__ChainedMoon__10.Moon:GetPivot();
        l__ChainedMoon__10.Moon:PivotTo(u58 * CFrame.new(0, -600, 0));
        l__ChainedMoon__10.Parent = workspace;
        l__TweenService__1:Create(u57, TweenInfo.new(2), {
            Brightness = 0.1,
            Contrast = 0.2,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 172, 241)
        }):Play();
        game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(3), {
            FieldOfView = 70
        }):Play();
        local u59 = game.ReplicatedStorage.Assets.ChainBreak:Clone();
        local u60 = true;
        u59.Parent = workspace.CurrentCamera;
        task.spawn(function() --[[ Line: 330 ]]
            -- upvalues: u60 (ref), u59 (copy)
            while u60 do
                game:GetService("RunService").RenderStepped:Wait();
                local v61 = math.rad(workspace.CurrentCamera.FieldOfView / 2);
                local v62 = math.tan(v61) * 4 / (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y);
                u59.Size = Vector3.new(v62, 0.1, 2.2);
                u59.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2);
            end;
        end);
        local u63 = u60;
        for _, v64 in u59:GetChildren() do
            v64:Emit(v64:GetAttribute("EmitCount"));
        end;
        task.delay(8, function() --[[ Line: 349 ]]
            -- upvalues: u59 (copy), u63 (ref)
            u59:Destroy();
            u63 = false;
        end);
        task.spawn(function() --[[ Line: 354 ]]
            -- upvalues: l__ChainedMoon__10 (ref), u6 (ref), l__TweenService__1 (ref), u58 (copy), u57 (copy), l__CamShake__5 (ref)
            local v65 = 0;
            for _, v66 in l__ChainedMoon__10.Debris:GetChildren() do
                game.TweenService:Create(v66, TweenInfo.new(1.5), {
                    TimeScale = 1
                }):Play();
            end;
            u6.Parent = workspace;
            u6:Play();
            l__TweenService__1:Create(u6, TweenInfo.new(1), {
                Volume = 0.3
            }):Play();
            while v65 < 4 do
                v65 = v65 + task.wait(0.025);
                local v67 = (u58 * CFrame.new(0, -600, 0)):Lerp(u58, (l__TweenService__1:GetValue(v65 / 4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))) * CFrame.new(Random.new():NextUnitVector() * 1);
                l__ChainedMoon__10.Moon:PivotTo(v67);
            end;
            task.spawn(function() --[[ Line: 383 ]]
                -- upvalues: l__ChainedMoon__10 (ref), u58 (ref), l__TweenService__1 (ref), u57 (ref)
                local v68 = {};
                local v69 = {};
                for _, v70 in l__ChainedMoon__10.Rocks:GetChildren() do
                    v68[v70] = v70:GetPivot();
                    v69[v70] = Random.new():NextInteger(0, 10000);
                end;
                while isActive do
                    l__ChainedMoon__10.Moon:PivotTo(u58 * CFrame.new(Random.new():NextUnitVector() * 1));
                    for _, v71 in l__ChainedMoon__10.Rocks:GetChildren() do
                        local l__new__18 = CFrame.new;
                        local v72 = tick() * 90 + v69[v71];
                        local v73 = math.rad(v72);
                        v71:PivotTo(l__new__18(0, math.sin(v73) * 10, 0) * v68[v71]);
                    end;
                    task.wait(0.025);
                end;
                for v74, v75 in v68 do
                    v74:PivotTo(v75);
                end;
                l__TweenService__1:Create(u57, TweenInfo.new(2), {
                    Brightness = 0,
                    Contrast = 0,
                    Saturation = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                game.Debris:AddItem(u57, 5);
            end);
            l__CamShake__5:StopSustained(2);
            l__CamShake__5:ShakeSustain(l__CamShake__5.Presets.SoftEarthquake);
        end);
    end);
end;
local function u78() --[[ Line: 422 ]]
    -- upvalues: l__TweenService__1 (copy), l__CamShake__5 (copy), u4 (ref), u6 (copy), l__ChainedMoon__10 (copy), l__ReplicatedStorage__2 (copy), l__Skybox__11 (copy), l__EnchainedMoon__12 (copy)
    local u77 = Instance.new("ColorCorrectionEffect");
    u77.Parent = game.Lighting;
    game.Debris:AddItem(u77, 5);
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
        FieldOfView = 95
    }):Play();
    l__TweenService__1:Create(u77, TweenInfo.new(0.4), {
        Brightness = 1.5,
        Contrast = 0.2,
        Saturation = 0.5,
        TintColor = Color3.fromRGB(243, 153, 255)
    }):Play();
    l__CamShake__5:Shake(l__CamShake__5.Presets.Explosion);
    if u4 then
        u4:Destroy();
        u4 = nil;
    end;
    u6:Stop();
    u6.Volume = 0;
    l__CamShake__5:StopSustained(3);
    game.SoundService:PlayLocalSound(game.SoundService.SFX.Snap);
    task.delay(0.4, function() --[[ Line: 441 ]]
        -- upvalues: l__TweenService__1 (ref), u77 (copy)
        l__TweenService__1:Create(u77, TweenInfo.new(2), {
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
    l__ChainedMoon__10.Parent = l__ReplicatedStorage__2.Assets;
    l__Skybox__11.SetOrder(l__EnchainedMoon__12, 0);
end;
function v1.Start(_, _, _) --[[ Line: 453 ]]
    -- upvalues: l__LightingController__8 (copy), u2 (copy), u76 (copy)
    if isActive then
    else
        isActive = true;
        game.TweenService:Create(game.SoundService.Master.GameMusic, TweenInfo.new(3), {
            Volume = 0
        }):Play();
        l__LightingController__8:TransitionTo(u2, 3);
        task.wait(3);
        u76();
    end;
end;
function v1.End(_) --[[ Line: 466 ]]
    -- upvalues: u78 (copy)
    if isActive then
        isActive = false;
        u78();
    end;
end;
local function v83(p79) --[[ Line: 475 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__Players__3 (copy), u5 (ref), l__LocalPlayer__4 (copy), l__FieldOfViewController__7 (copy), l__NotificationController__6 (copy)
    if p79:GetAttribute("Enchained") then
    else
        p79:SetAttribute("Enchained", true);
        for _, v80 in l__ReplicatedStorage__2.Assets.EnchainedEffect:GetChildren() do
            local v81 = v80:Clone();
            if v81:IsA("Highlight") then
                v81.Parent = p79;
            else
                v81.Parent = p79:WaitForChild("Torso");
            end;
            v81:AddTag("EnchainedClearup");
        end;
        if p79 == l__Players__3.LocalPlayer.Character and not u5 then
            u5 = l__ReplicatedStorage__2.Assets.Vignette:Clone();
            u5.ImageLabel.ImageTransparency = 0.7;
            u5.ImageLabel.UIScale.Scale = 1;
            game.TweenService:Create(u5.ImageLabel.UIScale, TweenInfo.new(1), {
                Scale = 1.04
            }):Play();
            game.TweenService:Create(u5.ImageLabel, TweenInfo.new(1), {
                ImageTransparency = 0.8
            }):Play();
            u5.Parent = l__LocalPlayer__4.PlayerGui;
            local u82 = Instance.new("ColorCorrectionEffect");
            u82.Parent = game.Lighting;
            game.TweenService:Create(u82, TweenInfo.new(0.4), {
                Brightness = 0.4,
                TintColor = Color3.fromRGB(235, 175, 255)
            }):Play();
            game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.4), {
                FieldOfView = 90
            }):Play();
            task.delay(0.4, function() --[[ Line: 515 ]]
                -- upvalues: u82 (copy), l__FieldOfViewController__7 (ref)
                game.TweenService:Create(u82, TweenInfo.new(0.8), {
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                game.Debris:AddItem(u82, 0.8);
                game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.6), {
                    FieldOfView = 80
                }):Play();
                l__FieldOfViewController__7:SetBaseFOV(80);
            end);
            l__NotificationController__6:CreateNotification("You\'ve been " .. ("<font color=\"#" .. Color3.fromRGB(239, 116, 255):ToHex() .. "\">ENCHAINED!</font>") .. " Button mash to ESCAPE!", nil, 7);
        end;
    end;
end;
local function v88(p84) --[[ Line: 538 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy), l__LocalPlayer__4 (copy), u5 (ref), u4 (ref), l__FieldOfViewController__7 (copy)
    local v85 = l__ReplicatedStorage__2.Assets.EnchainedDisperse:Clone();
    v85.Parent = p84.HumanoidRootPart;
    for _, v86 in v85:GetChildren() do
        if v86:IsA("ParticleEmitter") then
            v86:Emit(v86:GetAttribute("EmitCount") or 3);
        elseif v86:IsA("Sound") then
            v86:Play();
        end;
    end;
    if p84 == l__LocalPlayer__4.Character and u5 then
        game.TweenService:Create(u4.ImageLabel.UIScale, TweenInfo.new(1), {
            Scale = 1.14
        }):Play();
        u5.ImageLabel.ImageColor3 = Color3.fromRGB(255, 114, 217);
        game.TweenService:Create(u5.ImageLabel, TweenInfo.new(1), {
            ImageTransparency = 1
        }):Play();
        l__FieldOfViewController__7:SetBaseFOV(70);
        game.Debris:AddItem(u5, 1);
        u5 = nil;
    end;
    game.Debris:AddItem(v85, 3);
    p84:SetAttribute("Enchained", nil);
    for _, v87 in p84:GetDescendants() do
        if v87:HasTag("EnchainedClearup") then
            if v87:IsA("Highlight") then
                game.TweenService:Create(v87, TweenInfo.new(0.5), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                }):Play();
            elseif v87:IsA("ParticleEmitter") or v87:IsA("Trail") then
                v87.Enabled = false;
            end;
            game.Debris:AddItem(v87, 1);
        end;
    end;
end;
for _, v89 in game.CollectionService:GetTagged("EnchainedHighlight") do
    v83(v89);
end;
game.CollectionService:GetInstanceAddedSignal("EnchainedHighlight"):Connect(v83);
game.CollectionService:GetInstanceRemovedSignal("EnchainedHighlight"):Connect(v88);
local l__PlantVisualizerController__19 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.PlantVisualizerController);
l__Networking__15.WeatherEffects.ChainPull.OnClientEvent:Connect(function() --[[ Line: 594 ]]
    -- upvalues: l__PlantVisualizerController__19 (copy), l__Networking__15 (copy), l__LocalPlayer__4 (copy), l__RagdollModule__14 (copy), l__ButtonMash__13 (copy), l__ChainedMoon__10 (copy)
    if l__PlantVisualizerController__19:GetOfflineCutsceneState() then
        task.wait(0.3);
        l__Networking__15.WeatherEffects.ChainPull:Fire(false);
    else
        l__LocalPlayer__4.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics);
        l__RagdollModule__14:Ragdoll(l__LocalPlayer__4.Character);
        local v90 = tick();
        local u91 = nil;
        task.spawn(function() --[[ Line: 609 ]]
            -- upvalues: u91 (ref), l__ButtonMash__13 (ref)
            u91 = l__ButtonMash__13.Start(0.1, 0.4);
        end);
        local u92 = nil;
        u92 = l__ChainedMoon__10.FloorCheck.Touched:Connect(function(p93) --[[ Line: 613 ]]
            -- upvalues: l__LocalPlayer__4 (ref), u92 (ref)
            if l__LocalPlayer__4.Character and p93:IsDescendantOf(l__LocalPlayer__4.Character) then
                u92:Disconnect();
                u92 = nil;
            end;
        end);
        local v94 = u92;
        repeat
            task.wait(0);
        until u91 or (tick() - v90 > 15 or v94 == nil);
        if v94 then
            v94:Disconnect();
            u92 = nil;
        end;
        l__ButtonMash__13.Disable();
        l__LocalPlayer__4.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp);
        l__RagdollModule__14:Unragdoll(l__LocalPlayer__4.Character);
        game.SoundService:PlayLocalSound(game.SoundService.SFX.ChainAttacks.Chain);
        l__Networking__15.WeatherEffects.ChainPull:Fire(u91);
    end;
end);
return v1;