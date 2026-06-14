-- Decompiled with Potassium's decompiler.

local l__PlantController__1 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.PlantController);
local l__CamShake__2 = require(game.ReplicatedStorage.ClientModules.CamShake);
local l__BodyShaker__3 = require(game.ReplicatedStorage.ClientModules.BodyShaker);
local u1 = nil;
local u2 = true;
local u3 = nil;
function lerp(p4, p5, p6)
    return p4 + (p5 - p4) * p6;
end;
local u7 = nil;
local u8 = {};
local u9 = {};
local u10 = {};
local l__Notification__4 = game.SoundService.SFX.Notification;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local function u17(p14) --[[ Line: 32 ]]
    -- upvalues: l__Notification__4 (copy)
    local v15 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v16 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    game.TweenService:Create(p14.TextLabel, v16, {
        Position = p14.TextLabel.Position
    }):Play();
    game.TweenService:Create(p14.ImageLabel, v15, {
        ImageTransparency = 0.5
    }):Play();
    game.TweenService:Create(p14.TextLabel, v15, {
        TextTransparency = 0
    }):Play();
    game.TweenService:Create(p14.TextLabel, v15, {
        TextStrokeTransparency = 0
    }):Play();
    l__Notification__4.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l__Notification__4.Playing = true;
    l__Notification__4.TimePosition = 0;
end;
local function u21(p18) --[[ Line: 47 ]]
    local v19 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v20 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    game.TweenService:Create(p18.TextLabel, v20, {
        Position = p18.TextLabel.Position + UDim2.new(0, 0, 0.2, 0)
    }):Play();
    game.TweenService:Create(p18.ImageLabel, v19, {
        ImageTransparency = 1
    }):Play();
    game.TweenService:Create(p18.TextLabel, v19, {
        TextTransparency = 1
    }):Play();
    game.TweenService:Create(p18.TextLabel, v19, {
        TextStrokeTransparency = 1
    }):Play();
    game.Debris:AddItem(p18, v19.Time);
end;
local u22 = {};
return {
    FadeIn = function(p23, _) --[[ Name: FadeIn, Line 65 ]]
        -- upvalues: u1 (ref), u11 (ref), u7 (ref), u2 (ref), u22 (copy), u12 (ref), u13 (ref)
        local v24 = p23.Music:Clone();
        v24.Parent = workspace;
        v24:Play();
        workspace:SetAttribute("TimeFrozen", true);
        game.Lighting.GeographicLatitude = 24;
        u1 = p23:WaitForChild("FadeIn");
        u1.Frame.BackgroundTransparency = 0;
        u1.Parent = game.Players.LocalPlayer.PlayerGui;
        u11 = p23.Racoon;
        u11.Parent = game.ReplicatedStorage;
        u7 = p23.Map.Plants;
        u7.Parent = game.ReplicatedStorage;
        game.TweenService:Create(u1.Frame, TweenInfo.new(1), {
            BackgroundTransparency = 1
        }):Play();
        u2 = true;
        for _, v25 in p23.Faces:GetChildren() do
            u22[v25.Name] = v25.Texture;
        end;
        u12 = p23.Rigs.MainCharacter.Head.face;
        u13 = p23.Rigs.Thief.Head.face;
        local v26 = p23.Blur:Clone();
        v26.Parent = game.Lighting;
        game.TweenService:Create(v26, TweenInfo.new(5), {
            Size = 0
        }):Play();
        local l__Screen__5 = p23.Screen;
        local v27 = 0;
        while u2 == true do
            v27 = v27 + game:GetService("RunService").RenderStepped:Wait();
            local v28 = math.clamp(v27 / 12, 0, 1);
            l__Screen__5.LoadingGui.ProgressBar.Bar.Size = UDim2.new(v28, 0, 1, 0);
            l__Screen__5.LoadingGui.Variant1Frame.InnerFrame.CounterTxt.Text = "Loading " .. math.round(v28 * 2507) .. "/2507";
            local v29 = math.rad(workspace.CurrentCamera.FieldOfView / 2);
            local v30 = math.tan(v29) * 32;
            local v31 = v30 * (workspace.CurrentCamera.ViewportSize.X / workspace.CurrentCamera.ViewportSize.Y);
            l__Screen__5.LoadingGui.CanvasSize = workspace.CurrentCamera.ViewportSize;
            l__Screen__5.Size = Vector3.new(v31, v30, 0.1);
            l__Screen__5.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -16);
        end;
    end,
    LockScreenLocation = function(u32, _) --[[ Name: LockScreenLocation, Line 119 ]]
        -- upvalues: u2 (ref)
        task.wait(0.5);
        u2 = false;
        task.delay(3, function() --[[ Line: 123 ]]
            -- upvalues: u32 (copy)
            u32.Screen.LoadingGui.Enabled = false;
        end);
    end,
    SparkleFarm = function(p33, _) --[[ Name: SparkleFarm, Line 129 ]]
        for _, u34 in p33.Sparkles:GetDescendants() do
            if u34:IsA("ParticleEmitter") then
                u34.Enabled = true;
                task.delay(Random.new():NextInteger(1, 2), function() --[[ Line: 134 ]]
                    -- upvalues: u34 (copy)
                    u34.Enabled = false;
                end);
            end;
        end;
    end,
    CharacterLand = function(p35, _) --[[ Name: CharacterLand, Line 141 ]]
        p35.VFX.CharacterLand.PixelSmoke:Emit(8);
        p35.PlotSign.Empty.Enabled = false;
        p35.PlotSign.InGame.Enabled = true;
    end,
    WalkBehindNPC = function(p36, _) --[[ Name: WalkBehindNPC, Line 147 ]]
        -- upvalues: u10 (copy)
        for _, u37 in p36.NPCs:GetChildren() do
            local l__Anims__6 = u37.Anims;
            local l__Humanoid__7 = u37.Humanoid;
            local v38 = u10[u37];
            if not v38 then
                v38 = {};
                u10[u37] = v38;
            end;
            for _, v39 in l__Anims__6:GetChildren() do
                local v40 = v38[v39];
                if v40 then
                    v40:Stop(0);
                else
                    v40 = l__Humanoid__7:LoadAnimation(v39);
                    v38[v39] = v40;
                end;
                v40:Play();
            end;
            if u37:FindFirstChild("WalkPath") then
                task.spawn(function() --[[ Line: 175 ]]
                    -- upvalues: u37 (copy)
                    local v41 = {};
                    for _, v42 in u37.WalkPath:GetChildren() do
                        v41[tonumber(v42.Name)] = v42;
                    end;
                    for _, v43 in v41 do
                        u37.Humanoid:MoveTo(v43.Position);
                        u37.Humanoid.MoveToFinished:Wait();
                    end;
                end);
            end;
        end;
    end,
    CarrotSeedAnim = function(p44, _) --[[ Name: CarrotSeedAnim, Line 193 ]]
        -- upvalues: l__PlantController__1 (copy)
        l__PlantController__1:PlayPlantFx(p44.VFX.PlantFirst.Position, "");
    end,
    FarmModel1 = function(p45, _) --[[ Name: FarmModel1, Line 197 ]]
        -- upvalues: u7 (ref)
        game.Lighting.ClockTime = 11;
        u7["1"].Parent = p45.Fruits;
    end,
    Plant2 = function(p46, _) --[[ Name: Plant2, Line 201 ]]
        -- upvalues: l__PlantController__1 (copy)
        game.Lighting.ClockTime = 12;
        l__PlantController__1:PlayPlantFx(p46.VFX.Plant2.Position, "");
    end,
    FarmModel2 = function(p47, _) --[[ Name: FarmModel2, Line 206 ]]
        -- upvalues: u7 (ref)
        game.Lighting.ClockTime = 13;
        workspace.Temporary:ClearAllChildren();
        p47.Fruits["1"].Cleanup:Destroy();
        p47.Fruits["1"].Carrot:ScaleTo(1);
        for _, v48 in u7["2"]:GetDescendants() do
            if v48:HasTag("GrowMeVFX") then
                v48:ScaleTo(0.3);
            end;
        end;
        u7["2"].Parent = p47.Fruits;
    end,
    FarmModel3 = function(p49, _) --[[ Name: FarmModel3, Line 222 ]]
        -- upvalues: u7 (ref)
        game.Lighting.ClockTime = 14;
        game.Lighting.GeographicLatitude = 87;
        game.Lighting.SunRays.Intensity = 0.032;
        workspace.Temporary:ClearAllChildren();
        for _, v50 in p49.Fruits["2"]:GetDescendants() do
            if v50:HasTag("GrowMeVFX") then
                local v51 = v50:GetPivot();
                v50:ScaleTo(0.6);
                v50:PivotTo(v51);
            end;
        end;
        p49.Fruits["2"].Cleanup:Destroy();
        for _, v52 in u7["3"]:GetDescendants() do
            if v52:HasTag("GrowMeVFX") then
                local v53 = v52:GetPivot();
                v52:ScaleTo(0.5);
                v52:PivotTo(v53);
            end;
        end;
        u7["3"].Parent = p49.Fruits;
    end,
    FarmModel4 = function(p54, _) --[[ Name: FarmModel4, Line 245 ]]
        -- upvalues: u7 (ref), l__CamShake__2 (copy)
        game.Lighting.SunRays.Intensity = 0.25;
        game.Lighting.GeographicLatitude = 0;
        for _, v55 in p54.Fruits["2"]:GetDescendants() do
            if v55:HasTag("GrowMeVFX") then
                local v56 = v55:GetPivot();
                v55:ScaleTo(1);
                v55:PivotTo(v56);
            end;
        end;
        for _, v57 in p54.Fruits["3"]:GetDescendants() do
            if v57:HasTag("GrowMeVFX") then
                local v58 = v57:GetPivot();
                v57:ScaleTo(1);
                v57:PivotTo(v58);
            end;
        end;
        p54.Fruits["3"].Cleanup:Destroy();
        u7["4"].Parent = p54.Fruits;
        l__CamShake__2:StopSustained(0);
        p54.VFX.Thud:Destroy();
        p54.VFX.Thud2:Destroy();
        p54.NPCs.Bacon:Destroy();
    end,
    GoToNight = function(u59, _) --[[ Name: GoToNight, Line 274 ]]
        -- upvalues: u7 (ref), u1 (ref)
        local l__Lighting__8 = game.Lighting;
        game.Lighting.GeographicLatitude = 24;
        task.spawn(function() --[[ Line: 283 ]]
            -- upvalues: u7 (ref), u59 (copy)
            for v60 = 1, 3 do
                task.wait(1);
                u7[tostring(v60 + 4)].Parent = u59.Fruits;
            end;
        end);
        local v61 = 0;
        local v62 = nil;
        while v61 < 5 do
            v61 = v61 + game:GetService("RunService").Heartbeat:Wait();
            l__Lighting__8.ClockTime = lerp(10, 0, v61 / 5);
            if v61 > 3 and not v62 then
                game.TweenService:Create(u1.Frame, TweenInfo.new(1), {
                    BackgroundTransparency = 0
                }):Play();
                task.delay(4, function() --[[ Line: 297 ]]
                    -- upvalues: u1 (ref), u59 (copy)
                    game.Lighting.GeographicLatitude = 333;
                    game.Lighting.ClockTime = 19;
                    game.TweenService:Create(u1.Frame, TweenInfo.new(1), {
                        BackgroundTransparency = 1
                    }):Play();
                    task.delay(1, function() --[[ Line: 302 ]]
                        -- upvalues: u59 (ref)
                        game.Debris:AddItem(u59.NPCs.builderman);
                        game.Debris:AddItem(u59.NPCs.BaconHairGirl);
                    end);
                end);
                v62 = true;
            end;
        end;
    end,
    ToDay = function(u63, _) --[[ Name: ToDay, Line 313 ]]
        -- upvalues: u3 (ref)
        local l__Lighting__9 = game.Lighting;
        game.Lighting.GeographicLatitude = 0;
        task.spawn(function() --[[ Line: 324 ]]
            -- upvalues: u63 (copy), u3 (ref)
            local v64 = {};
            for _, v65 in game.CollectionService:GetTagged("StealMe") do
                if v65:IsDescendantOf(u63) then
                    table.insert(v64, v65);
                end;
            end;
            for _, v66 in u63.StealReferences:GetChildren() do
                for _, v67 in v66:GetChildren() do
                    v67.Value.Parent = v66;
                end;
                table.insert(v64, v66);
            end;
            u3 = u63.PickupParticle;
            u3.Parent = workspace.Terrain;
            for v68 = 1, #v64 do
                local v69 = 3 / #v64;
                u3.WorldPosition = v64[v68]:GetPivot().p;
                task.wait(v69);
                v64[v68]:Destroy();
                for _, v70 in u3:GetChildren() do
                    v70:Emit(v70:GetAttribute("EmitCount") or 1);
                end;
            end;
        end);
        local v71 = 0;
        while v71 < 4 do
            v71 = v71 + game:GetService("RunService").Heartbeat:Wait();
            l__Lighting__9.ClockTime = 24 - lerp(4, 10, v71 / 4);
        end;
    end,
    PlayerThud = function(p72, _) --[[ Name: PlayerThud, Line 363 ]]
        -- upvalues: l__CamShake__2 (copy)
        l__CamShake__2:Shake(l__CamShake__2.Presets.Bump);
        p72.VFX.Thud.PixelSmoke:Emit(p72.VFX.Thud.PixelSmoke:GetAttribute("EmitCount") or 8);
    end,
    CarrotThud = function(p73, _) --[[ Name: CarrotThud, Line 368 ]]
        -- upvalues: l__CamShake__2 (copy)
        l__CamShake__2:Shake(l__CamShake__2.Presets.Bump);
        p73.VFX.Thud2.PixelSmoke:Emit(p73.VFX.Thud2.PixelSmoke:GetAttribute("EmitCount") or 12);
    end,
    WakeUp = function(u74, _) --[[ Name: WakeUp, Line 373 ]]
        -- upvalues: u17 (copy), u12 (ref), u22 (copy), u21 (copy)
        u17(u74.Rigs.MainCharacter.Head.Notif.Notification_UI.Frame);
        u12.Texture = u22.NoobHmmm or u22.Normal;
        task.delay(2, function() --[[ Line: 376 ]]
            -- upvalues: u21 (ref), u74 (copy)
            u21(u74.Rigs.MainCharacter.Head.Notif.Notification_UI.Frame);
        end);
        u74.Rigs.MainCharacter.Head.Notif.ZzzEffect.Enabled = false;
    end,
    NoobCurious = function(u75, _) --[[ Name: NoobCurious, Line 382 ]]
        -- upvalues: u12 (ref), u22 (copy), u17 (copy), u21 (copy)
        u12.Texture = u22.NoobCurious or u22.Normal;
        task.delay(3, function() --[[ Line: 386 ]]
            -- upvalues: u17 (ref), u75 (copy), u21 (ref)
            u17(u75.Rigs.MainCharacter.Head.Notif.Restock.Frame);
            task.wait(1);
            u21(u75.Rigs.MainCharacter.Head.Notif.Restock.Frame);
        end);
    end,
    NoobHappy = function(u76, _) --[[ Name: NoobHappy, Line 392 ]]
        -- upvalues: u12 (ref), u22 (copy)
        u12.Texture = u22.NoobHappy or u22.Normal;
        task.delay(0.3, function() --[[ Line: 394 ]]
            -- upvalues: u76 (copy)
            u76.Rigs.SeedPack.Base.ParticleEmitter:Emit(8);
        end);
        task.wait(1.5);
        u12.Texture = u22.Normal or u22.Normal;
    end,
    NoobWork = function(_, _) --[[ Name: NoobWork, Line 400 ]]
        -- upvalues: u12 (ref), u22 (copy)
        u12.Texture = u22.NoobWork or u22.Normal;
    end,
    NoobNormal = function(_, _) --[[ Name: NoobNormal, Line 403 ]]
        -- upvalues: u12 (ref), u22 (copy)
        u12.Texture = u22.Normal or u22.Normal;
    end,
    NoobHmm = function(_, _) --[[ Name: NoobHmm, Line 406 ]]
        -- upvalues: u12 (ref), u22 (copy)
        u12.Texture = u22.NoobHmmm or u22.Normal;
    end,
    NoobConfident = function(_, _) --[[ Name: NoobConfident, Line 411 ]]
        -- upvalues: u12 (ref), u22 (copy), u11 (ref)
        u12.Texture = u22.NoobConfident or u22.Normal;
        u11.Parent = workspace;
        u11.AnimationController:LoadAnimation(u11.Walk):Play();
        local u77 = 0;
        local u78 = u11:GetPivot();
        local u79 = u78 * CFrame.new(0, 50, 0);
        task.delay(0.7, function() --[[ Line: 422 ]]
            -- upvalues: u77 (ref), u11 (ref), u78 (copy), u79 (copy)
            while u77 < 4 do
                u77 = u77 + game:GetService("RunService").Heartbeat:Wait();
                u11:PivotTo(u78:Lerp(u79, u77 / 4));
            end;
            u11:Destroy();
        end);
    end,
    NoobSleep = function(p80, _) --[[ Name: NoobSleep, Line 431 ]]
        -- upvalues: u12 (ref), u22 (copy)
        u12.Texture = u22.NoobSleep or u22.Normal;
        p80.Rigs.MainCharacter.Head.Notif.ZzzEffect.Enabled = true;
    end,
    AngryNoob = function(_, _) --[[ Name: AngryNoob, Line 435 ]]
        -- upvalues: u12 (ref), u22 (copy), l__CamShake__2 (copy)
        u12.Texture = u22.AngryNoob or u22.Normal;
        task.delay(0.2, function() --[[ Line: 438 ]]
            -- upvalues: l__CamShake__2 (ref)
            l__CamShake__2:Shake(l__CamShake__2.Presets.Bump2);
        end);
    end,
    ConfidentNoob = function(_, _) --[[ Name: ConfidentNoob, Line 443 ]]
        -- upvalues: u12 (ref), u22 (copy)
        u12.Texture = u22.ConfidentNoob or u22.Normal;
    end,
    ThiefLook = function(_, _) --[[ Name: ThiefLook, Line 447 ]]
        -- upvalues: u13 (ref), u22 (copy)
        u13.Texture = u22.ThiefLook or u22.Normal;
    end,
    CuriousThief = function(_, _) --[[ Name: CuriousThief, Line 450 ]]
        -- upvalues: u13 (ref), u22 (copy)
        u13.Texture = u22.CuriousThief or u22.Normal;
    end,
    ThiefScream = function(_, _) --[[ Name: ThiefScream, Line 453 ]]
        -- upvalues: u13 (ref), u22 (copy)
        u13.Texture = u22.ThiefScream or u22.Normal;
    end,
    HatOn = function(p81) --[[ Name: HatOn, Line 457 ]]
        -- upvalues: l__CamShake__2 (copy), u9 (copy)
        p81.Rigs.MainCharacter.BCHardHat.Handle.Transparency = 0;
        l__CamShake__2:Shake(l__CamShake__2.Presets.SideExplosion);
        local l__Flash1__10 = p81.Aura.Flash1;
        l__Flash1__10.Parent = game.Lighting;
        l__Flash1__10.Enabled = true;
        p81.Rigs.MainCharacter["1"].Handle.Transparency = 0;
        task.wait(0.075);
        for _, v82 in p81.Rigs.MainCharacter:GetChildren() do
            if v82:IsA("BasePart") and v82.Name ~= "HumanoidRootPart" then
                for _, v83 in p81.Aura.Particles:GetChildren() do
                    local v84 = v83:Clone();
                    v84.Parent = v82;
                    v84:Emit(4);
                    table.insert(u9, v84);
                end;
            end;
        end;
        for _, v85 in p81.Rigs.MainCharacter.Torso.GoldDisperse:GetChildren() do
            v85:Emit(v85:GetAttribute("EmitCount") or 5);
        end;
        local l__Flash2__11 = p81.Aura.Flash2;
        l__Flash2__11.Parent = game.Lighting;
        l__Flash1__10:Destroy();
        l__Flash2__11.Enabled = true;
        p81.Rigs.MainCharacter["1"].Handle.Transparency = 1;
        p81.Rigs.MainCharacter["2"].Handle.Transparency = 0;
        task.wait(0.075);
        l__Flash2__11:Destroy();
        local l__Flash3__12 = p81.Aura.Flash3;
        l__Flash3__12.Parent = game.Lighting;
        l__Flash3__12.Enabled = true;
        p81.Rigs.MainCharacter["2"].Handle.Transparency = 1;
        task.wait(0.075);
        game.Debris:AddItem(l__Flash3__12, 4);
        l__Flash3__12.Brightness = 0.6;
        l__Flash3__12.Contrast = 0;
        l__Flash3__12.Saturation = 0;
        l__Flash3__12.TintColor = Color3.fromRGB(255, 230, 129);
        game.TweenService:Create(l__Flash3__12, TweenInfo.new(0.8), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end,
    Build1 = function(_) --[[ Name: Build1, Line 503 ]]
        -- upvalues: u9 (copy)
        for _, v86 in u9 do
            v86:Destroy();
        end;
    end,
    BuildToNight = function(u87) --[[ Name: BuildToNight, Line 512 ]]
        -- upvalues: u3 (ref)
        local u88 = u87.QuickPlace:GetChildren();
        task.spawn(function() --[[ Line: 519 ]]
            -- upvalues: u88 (copy), u3 (ref), u87 (copy)
            for v89, v90 in u88 do
                v90:PivotTo(v90:GetPivot() * CFrame.new(0, 100, 0));
                local v91 = (1 - (1 - (v89 + 1) / #u88) ^ 2) * 4 - (1 - (1 - v89 / #u88) ^ 2) * 4;
                u3.WorldPosition = v90:GetPivot().p;
                for _, v92 in u3:GetChildren() do
                    v92:Emit(v92:GetAttribute("EmitCount") or 1);
                end;
                task.wait(v91);
            end;
            task.delay(4, function() --[[ Line: 540 ]]
                -- upvalues: u87 (ref)
                u87.Fruits["5"].Destroy1:Destroy();
                u87.Fruits["6"].Destroy2:Destroy();
                u87.PlaceInStages["3"].DestroyMe:Destroy();
                u87.PlaceInStages["3"].DestroyMe2:Destroy();
            end);
        end);
        game.Lighting.GeographicLatitude = 24;
        local v93 = 0;
        while v93 < 4 do
            v93 = v93 + game:GetService("RunService").Heartbeat:Wait();
            game.Lighting.ClockTime = lerp(14, 6, v93 / 4);
        end;
    end,
    Sweat = function(p94) --[[ Name: Sweat, Line 564 ]]
        -- upvalues: l__BodyShaker__3 (copy)
        p94.Rigs.Thief.Head.Sweat.Enabled = true;
        l__BodyShaker__3.EnableShaking(p94.Rigs.Thief);
    end,
    Poof = function(p95) --[[ Name: Poof, Line 572 ]]
        -- upvalues: l__BodyShaker__3 (copy), l__CamShake__2 (copy)
        l__BodyShaker__3.DisableShaking(p95.Rigs.Thief);
        p95.VFX.Poof.PixelSmoke:Emit(18);
        l__CamShake__2:Shake(l__CamShake__2.Presets.Bump);
    end,
    GAG2 = function(_) --[[ Name: GAG2, Line 578 ]]
        -- upvalues: u1 (ref)
        u1.LogoImg.Visible = true;
        u1.PressAnyTxt.Visible = true;
        task.wait(3);
        game.TweenService:Create(game.Lighting, TweenInfo.new(1), {
            ClockTime = 14
        }):Play();
        task.wait(1);
        game.TweenService:Create(u1.LogoImg.UIScale, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            Scale = 1
        }):Play();
        task.delay(4, function() --[[ Line: 589 ]]
            -- upvalues: u1 (ref)
            game.TweenService:Create(u1.PressAnyTxt, TweenInfo.new(1), {
                TextTransparency = 0,
                TextStrokeTransparency = 0
            }):Play();
        end);
        task.wait(8);
        game.TweenService:Create(u1.Frame, TweenInfo.new(1), {
            BackgroundTransparency = 0
        }):Play();
    end,
    EndState = function(p96) --[[ Name: EndState, Line 599 ]]
        -- upvalues: u1 (ref), u12 (ref), u13 (ref), u11 (ref), u8 (ref), u2 (ref)
        u1.LogoImg.Visible = false;
        u1.PressAnyTxt.Visible = false;
        workspace:SetAttribute("TimeFrozen", nil);
        game.TweenService:Create(u1.Frame, TweenInfo.new(1), {
            BackgroundTransparency = 1
        }):Play();
        game.Debris:AddItem(u1, 1);
        u12 = nil;
        u13 = nil;
        u11 = nil;
        for _, v97 in u8 do
            v97:Destroy();
        end;
        u8 = {};
        u2 = false;
        p96.Screen:Destroy();
    end
};