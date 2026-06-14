-- Decompiled with Potassium's decompiler.

local l__PlantController__1 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.PlantController);
local l__CamShake__2 = require(game.ReplicatedStorage.ClientModules.CamShake);
local l__BodyShaker__3 = require(game.ReplicatedStorage.ClientModules.BodyShaker);
local u1 = nil;
function lerp(p2, p3, p4)
    return p2 + (p3 - p2) * p4;
end;
local u5 = {};
local l__Notification__4 = game.SoundService.SFX.Notification;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local function u12(p9) --[[ Line: 32 ]]
    -- upvalues: l__Notification__4 (copy)
    local v10 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v11 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    game.TweenService:Create(p9.TextLabel, v11, {
        Position = p9.TextLabel.Position
    }):Play();
    game.TweenService:Create(p9.ImageLabel, v10, {
        ImageTransparency = 0.5
    }):Play();
    game.TweenService:Create(p9.TextLabel, v10, {
        TextTransparency = 0
    }):Play();
    game.TweenService:Create(p9.TextLabel, v10, {
        TextStrokeTransparency = 0
    }):Play();
    l__Notification__4.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    l__Notification__4.Playing = true;
    l__Notification__4.TimePosition = 0;
end;
local function u16(p13) --[[ Line: 47 ]]
    local v14 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    local v15 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
    game.TweenService:Create(p13.TextLabel, v15, {
        Position = p13.TextLabel.Position + UDim2.new(0, 0, 0.2, 0)
    }):Play();
    game.TweenService:Create(p13.ImageLabel, v14, {
        ImageTransparency = 1
    }):Play();
    game.TweenService:Create(p13.TextLabel, v14, {
        TextTransparency = 1
    }):Play();
    game.TweenService:Create(p13.TextLabel, v14, {
        TextStrokeTransparency = 1
    }):Play();
    game.Debris:AddItem(p13, v14.Time);
end;
local u17 = {};
return {
    Drop = function(p18, _) --[[ Name: Drop, Line 65 ]]
        -- upvalues: l__PlantController__1 (copy)
        l__PlantController__1:PlayPlantFx(p18.DropZone1.Position, "Venus Fly Trap");
    end,
    DropOnSpot = function(p19, _) --[[ Name: DropOnSpot, Line 70 ]]
        -- upvalues: l__PlantController__1 (copy)
        l__PlantController__1:PlayPlantFx(p19.DropZone2.Position, "Venus Fly Trap");
    end,
    Plant2 = function(p20, _) --[[ Name: Plant2, Line 76 ]]
        -- upvalues: l__PlantController__1 (copy)
        game.Lighting.ClockTime = 12;
        l__PlantController__1:PlayPlantFx(p20.VFX.Plant2.Position, "");
    end,
    FarmModel2 = function(p21, _) --[[ Name: FarmModel2, Line 81 ]]
        game.Lighting.ClockTime = 13;
        workspace.Temporary:ClearAllChildren();
        p21.Fruits["1"].Cleanup:Destroy();
        p21.Fruits["1"].Carrot:ScaleTo(1);
        for _, v22 in (nil)["2"]:GetDescendants() do
            if v22:HasTag("GrowMeVFX") then
                v22:ScaleTo(0.3);
            end;
        end;
        (nil)["2"].Parent = p21.Fruits;
    end,
    FarmModel3 = function(p23, _) --[[ Name: FarmModel3, Line 97 ]]
        game.Lighting.ClockTime = 14;
        game.Lighting.GeographicLatitude = 87;
        game.Lighting.SunRays.Intensity = 0.032;
        workspace.Temporary:ClearAllChildren();
        for _, v24 in p23.Fruits["2"]:GetDescendants() do
            if v24:HasTag("GrowMeVFX") then
                local v25 = v24:GetPivot();
                v24:ScaleTo(0.6);
                v24:PivotTo(v25);
            end;
        end;
        p23.Fruits["2"].Cleanup:Destroy();
        for _, v26 in (nil)["3"]:GetDescendants() do
            if v26:HasTag("GrowMeVFX") then
                local v27 = v26:GetPivot();
                v26:ScaleTo(0.5);
                v26:PivotTo(v27);
            end;
        end;
        (nil)["3"].Parent = p23.Fruits;
    end,
    FarmModel4 = function(p28, _) --[[ Name: FarmModel4, Line 120 ]]
        -- upvalues: l__CamShake__2 (copy)
        game.Lighting.SunRays.Intensity = 0.25;
        game.Lighting.GeographicLatitude = 0;
        for _, v29 in p28.Fruits["2"]:GetDescendants() do
            if v29:HasTag("GrowMeVFX") then
                local v30 = v29:GetPivot();
                v29:ScaleTo(1);
                v29:PivotTo(v30);
            end;
        end;
        for _, v31 in p28.Fruits["3"]:GetDescendants() do
            if v31:HasTag("GrowMeVFX") then
                local v32 = v31:GetPivot();
                v31:ScaleTo(1);
                v31:PivotTo(v32);
            end;
        end;
        p28.Fruits["3"].Cleanup:Destroy();
        (nil)["4"].Parent = p28.Fruits;
        l__CamShake__2:StopSustained(0);
        p28.VFX.Thud:Destroy();
        p28.VFX.Thud2:Destroy();
        p28.NPCs.Bacon:Destroy();
    end,
    GoToNight = function(u33, _) --[[ Name: GoToNight, Line 149 ]]
        local l__Lighting__5 = game.Lighting;
        game.Lighting.GeographicLatitude = 24;
        task.spawn(function() --[[ Line: 158 ]]
            -- upvalues: u33 (copy)
            for v34 = 1, 3 do
                task.wait(1);
                (nil)[tostring(v34 + 4)].Parent = u33.Fruits;
            end;
        end);
        local v35 = 0;
        local v36 = nil;
        while v35 < 5 do
            v35 = v35 + game:GetService("RunService").Heartbeat:Wait();
            l__Lighting__5.ClockTime = lerp(10, 0, v35 / 5);
            if v35 > 3 and not v36 then
                game.TweenService:Create((nil).Frame, TweenInfo.new(1), {
                    BackgroundTransparency = 0
                }):Play();
                task.delay(4, function() --[[ Line: 172 ]]
                    -- upvalues: u33 (copy)
                    game.Lighting.GeographicLatitude = 333;
                    game.Lighting.ClockTime = 19;
                    game.TweenService:Create((nil).Frame, TweenInfo.new(1), {
                        BackgroundTransparency = 1
                    }):Play();
                    task.delay(1, function() --[[ Line: 177 ]]
                        -- upvalues: u33 (ref)
                        game.Debris:AddItem(u33.NPCs.builderman);
                        game.Debris:AddItem(u33.NPCs.BaconHairGirl);
                    end);
                end);
                v36 = true;
            end;
        end;
    end,
    ToDay = function(u37, _) --[[ Name: ToDay, Line 188 ]]
        -- upvalues: u1 (ref)
        local l__Lighting__6 = game.Lighting;
        game.Lighting.GeographicLatitude = 0;
        task.spawn(function() --[[ Line: 199 ]]
            -- upvalues: u37 (copy), u1 (ref)
            local v38 = {};
            for _, v39 in game.CollectionService:GetTagged("StealMe") do
                if v39:IsDescendantOf(u37) then
                    table.insert(v38, v39);
                end;
            end;
            for _, v40 in u37.StealReferences:GetChildren() do
                for _, v41 in v40:GetChildren() do
                    v41.Value.Parent = v40;
                end;
                table.insert(v38, v40);
            end;
            u1 = u37.PickupParticle;
            u1.Parent = workspace.Terrain;
            for v42 = 1, #v38 do
                local v43 = 3 / #v38;
                u1.WorldPosition = v38[v42]:GetPivot().p;
                task.wait(v43);
                v38[v42]:PivotTo(CFrame.new(0, -100, 0) * v38[v42]:GetPivot());
                for _, v44 in u1:GetChildren() do
                    v44:Emit(v44:GetAttribute("EmitCount") or 1);
                end;
            end;
        end);
        local v45 = 0;
        while v45 < 4 do
            v45 = v45 + game:GetService("RunService").Heartbeat:Wait();
            l__Lighting__6.ClockTime = 24 - lerp(4, 10, v45 / 4);
        end;
    end,
    PlayerThud = function(p46, _) --[[ Name: PlayerThud, Line 238 ]]
        -- upvalues: l__CamShake__2 (copy)
        l__CamShake__2:Shake(l__CamShake__2.Presets.Bump);
        p46.VFX.Thud.PixelSmoke:Emit(p46.VFX.Thud.PixelSmoke:GetAttribute("EmitCount") or 8);
    end,
    CarrotThud = function(p47, _) --[[ Name: CarrotThud, Line 243 ]]
        -- upvalues: l__CamShake__2 (copy)
        l__CamShake__2:Shake(l__CamShake__2.Presets.Bump);
        p47.VFX.Thud2.PixelSmoke:Emit(p47.VFX.Thud2.PixelSmoke:GetAttribute("EmitCount") or 12);
    end,
    WakeUp = function(u48, _) --[[ Name: WakeUp, Line 248 ]]
        -- upvalues: u12 (copy), u7 (ref), u17 (copy), u16 (copy)
        u12(u48.Rigs.MainCharacter.Head.Notif.Notification_UI.Frame);
        u7.Texture = u17.NoobHmmm or u17.Normal;
        task.delay(2, function() --[[ Line: 251 ]]
            -- upvalues: u16 (ref), u48 (copy)
            u16(u48.Rigs.MainCharacter.Head.Notif.Notification_UI.Frame);
        end);
        u48.Rigs.MainCharacter.Head.Notif.ZzzEffect.Enabled = false;
    end,
    NoobCurious = function(u49, _) --[[ Name: NoobCurious, Line 257 ]]
        -- upvalues: u7 (ref), u17 (copy), u12 (copy), u16 (copy)
        u7.Texture = u17.NoobCurious or u17.Normal;
        task.delay(3, function() --[[ Line: 261 ]]
            -- upvalues: u12 (ref), u49 (copy), u16 (ref)
            u12(u49.Rigs.MainCharacter.Head.Notif.Restock.Frame);
            task.wait(1);
            u16(u49.Rigs.MainCharacter.Head.Notif.Restock.Frame);
        end);
    end,
    NoobHappy = function(u50, _) --[[ Name: NoobHappy, Line 267 ]]
        -- upvalues: u7 (ref), u17 (copy)
        u7.Texture = u17.NoobHappy or u17.Normal;
        task.delay(0.3, function() --[[ Line: 269 ]]
            -- upvalues: u50 (copy)
            u50.Rigs.SeedPack.Base.ParticleEmitter:Emit(8);
        end);
        task.wait(1.5);
        u7.Texture = u17.Normal or u17.Normal;
    end,
    NoobWork = function(_, _) --[[ Name: NoobWork, Line 275 ]]
        -- upvalues: u7 (ref), u17 (copy)
        u7.Texture = u17.NoobWork or u17.Normal;
    end,
    NoobNormal = function(_, _) --[[ Name: NoobNormal, Line 278 ]]
        -- upvalues: u7 (ref), u17 (copy)
        u7.Texture = u17.Normal or u17.Normal;
    end,
    NoobHmm = function(_, _) --[[ Name: NoobHmm, Line 281 ]]
        -- upvalues: u7 (ref), u17 (copy)
        u7.Texture = u17.NoobHmmm or u17.Normal;
    end,
    NoobConfident = function(_, _) --[[ Name: NoobConfident, Line 286 ]]
        -- upvalues: u7 (ref), u17 (copy), u6 (ref)
        u7.Texture = u17.NoobConfident or u17.Normal;
        u6.Parent = workspace;
        u6.AnimationController:LoadAnimation(u6.Walk):Play();
        local u51 = 0;
        local u52 = u6:GetPivot();
        local u53 = u52 * CFrame.new(0, 50, 0);
        task.delay(0.7, function() --[[ Line: 297 ]]
            -- upvalues: u51 (ref), u6 (ref), u52 (copy), u53 (copy)
            while u51 < 4 do
                u51 = u51 + game:GetService("RunService").Heartbeat:Wait();
                u6:PivotTo(u52:Lerp(u53, u51 / 4));
            end;
            u6:Destroy();
        end);
    end,
    NoobSleep = function(p54, _) --[[ Name: NoobSleep, Line 306 ]]
        -- upvalues: u7 (ref), u17 (copy)
        u7.Texture = u17.NoobSleep or u17.Normal;
        p54.Rigs.MainCharacter.Head.Notif.ZzzEffect.Enabled = true;
    end,
    AngryNoob = function(p55, _) --[[ Name: AngryNoob, Line 310 ]]
        -- upvalues: u17 (copy), u7 (ref), u8 (ref)
        for _, v56 in p55.Faces:GetChildren() do
            u17[v56.Name] = v56.Texture;
        end;
        u7 = p55.Rigs.MainCharacter.Head.face;
        u8 = p55.Rigs.Thief.Head.face;
        u7.Texture = u17.AngryNoob or u17.Normal;
    end,
    ConfidentNoob = function(_, _) --[[ Name: ConfidentNoob, Line 324 ]]
        -- upvalues: u7 (ref), u17 (copy)
        u7.Texture = u17.ConfidentNoob or u17.Normal;
    end,
    ThiefLook = function(_, _) --[[ Name: ThiefLook, Line 328 ]]
        -- upvalues: u8 (ref), u17 (copy)
        u8.Texture = u17.ThiefLook or u17.Normal;
    end,
    CuriousThief = function(_, _) --[[ Name: CuriousThief, Line 331 ]]
        -- upvalues: u8 (ref), u17 (copy)
        u8.Texture = u17.CuriousThief or u17.Normal;
    end,
    ThiefScream = function(_, _) --[[ Name: ThiefScream, Line 334 ]]
        -- upvalues: u8 (ref), u17 (copy)
        u8.Texture = u17.ThiefScream or u17.Normal;
    end,
    HatOn = function(p57) --[[ Name: HatOn, Line 338 ]]
        -- upvalues: l__CamShake__2 (copy), u5 (copy)
        p57.Rigs.MainCharacter.BCHardHat.Handle.Transparency = 0;
        l__CamShake__2:Shake(l__CamShake__2.Presets.SideExplosion);
        local l__Flash1__7 = p57.Aura.Flash1;
        l__Flash1__7.Parent = game.Lighting;
        l__Flash1__7.Enabled = true;
        p57.Rigs.MainCharacter["1"].Handle.Transparency = 0;
        task.wait(0.075);
        for _, v58 in p57.Rigs.MainCharacter:GetChildren() do
            if v58:IsA("BasePart") and v58.Name ~= "HumanoidRootPart" then
                for _, v59 in p57.Aura.Particles:GetChildren() do
                    local v60 = v59:Clone();
                    v60.Parent = v58;
                    v60:Emit(4);
                    table.insert(u5, v60);
                end;
            end;
        end;
        for _, v61 in p57.Rigs.MainCharacter.Torso.GoldDisperse:GetChildren() do
            v61:Emit(v61:GetAttribute("EmitCount") or 5);
        end;
        local l__Flash2__8 = p57.Aura.Flash2;
        l__Flash2__8.Parent = game.Lighting;
        l__Flash1__7:Destroy();
        l__Flash2__8.Enabled = true;
        p57.Rigs.MainCharacter["1"].Handle.Transparency = 1;
        p57.Rigs.MainCharacter["2"].Handle.Transparency = 0;
        task.wait(0.075);
        l__Flash2__8:Destroy();
        local l__Flash3__9 = p57.Aura.Flash3;
        l__Flash3__9.Parent = game.Lighting;
        l__Flash3__9.Enabled = true;
        p57.Rigs.MainCharacter["2"].Handle.Transparency = 1;
        task.wait(0.075);
        game.Debris:AddItem(l__Flash3__9, 4);
        l__Flash3__9.Brightness = 0.6;
        l__Flash3__9.Contrast = 0;
        l__Flash3__9.Saturation = 0;
        l__Flash3__9.TintColor = Color3.fromRGB(255, 230, 129);
        game.TweenService:Create(l__Flash3__9, TweenInfo.new(0.8), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end,
    Build1 = function(p62) --[[ Name: Build1, Line 384 ]]
        -- upvalues: u5 (copy)
        for _, v63 in u5 do
            v63:Destroy();
        end;
        p62.FenceOG:Destroy();
        p62.FenceStage1:PivotTo(p62.FenceStage1:GetPivot() * CFrame.new(0, 100, 0));
    end,
    Build2 = function(p64) --[[ Name: Build2, Line 392 ]]
        p64.PlaceInStages["2"]:PivotTo(p64.PlaceInStages["2"]:GetPivot() * CFrame.new(0, 100, 0));
    end,
    Build3 = function(p65) --[[ Name: Build3, Line 398 ]]
        p65.PlaceInStages["3"]:PivotTo(p65.PlaceInStages["3"]:GetPivot() * CFrame.new(0, 100, 0));
    end,
    BuildToNight = function(u66) --[[ Name: BuildToNight, Line 403 ]]
        -- upvalues: u1 (ref)
        u66.PlaceInStages["4"]:PivotTo(u66.PlaceInStages["4"]:GetPivot() * CFrame.new(0, 100, 0));
        local u67 = u66.QuickPlace:GetChildren();
        task.spawn(function() --[[ Line: 412 ]]
            -- upvalues: u67 (copy), u1 (ref), u66 (copy)
            for v68, v69 in u67 do
                v69:PivotTo(v69:GetPivot() * CFrame.new(0, 100, 0));
                local v70 = (1 - (1 - (v68 + 1) / #u67) ^ 2) * 4 - (1 - (1 - v68 / #u67) ^ 2) * 4;
                u1.WorldPosition = v69:GetPivot().p;
                for _, v71 in u1:GetChildren() do
                    v71:Emit(v71:GetAttribute("EmitCount") or 1);
                end;
                task.wait(v70);
            end;
            task.delay(4, function() --[[ Line: 433 ]]
                -- upvalues: u66 (ref)
                u66.Fruits["5"].Destroy1:Destroy();
                u66.Fruits["6"].Destroy2:Destroy();
                u66.PlaceInStages["3"].DestroyMe:Destroy();
                u66.PlaceInStages["3"].DestroyMe2:Destroy();
            end);
        end);
        game.Lighting.GeographicLatitude = 24;
        local v72 = 0;
        while v72 < 4 do
            v72 = v72 + game:GetService("RunService").Heartbeat:Wait();
            game.Lighting.ClockTime = lerp(14, 6, v72 / 4);
        end;
    end,
    Sweat = function(p73) --[[ Name: Sweat, Line 457 ]]
        -- upvalues: l__BodyShaker__3 (copy)
        p73.Rigs.Thief.Head.Sweat.Enabled = true;
        l__BodyShaker__3.EnableShaking(p73.Rigs.Thief);
    end,
    Poof = function(p74) --[[ Name: Poof, Line 465 ]]
        -- upvalues: l__BodyShaker__3 (copy), l__CamShake__2 (copy)
        l__BodyShaker__3.DisableShaking(p74.Rigs.Thief);
        p74.VFX.Poof.PixelSmoke:Emit(18);
        l__CamShake__2:Shake(l__CamShake__2.Presets.Bump);
    end,
    GAG2 = function(_) --[[ Name: GAG2, Line 471 ]]
        (nil).LogoImg.Visible = true;
        (nil).PressAnyTxt.Visible = true;
        task.wait(3);
        game.TweenService:Create(game.Lighting, TweenInfo.new(1), {
            ClockTime = 14
        }):Play();
        task.wait(1);
        game.TweenService:Create((nil).LogoImg.UIScale, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {
            Scale = 1
        }):Play();
        task.delay(4, function() --[[ Line: 482 ]]
            game.TweenService:Create((nil).PressAnyTxt, TweenInfo.new(1), {
                TextTransparency = 0,
                TextStrokeTransparency = 0
            }):Play();
        end);
        task.wait(8);
        game.TweenService:Create((nil).Frame, TweenInfo.new(1), {
            BackgroundTransparency = 0
        }):Play();
    end,
    EndState = function(_) --[[ Name: EndState, Line 492 ]]
        -- upvalues: u7 (ref), u8 (ref), u6 (ref)
        workspace:SetAttribute("TimeFrozen", nil);
        u7 = nil;
        u8 = nil;
        u6 = nil;
    end
};