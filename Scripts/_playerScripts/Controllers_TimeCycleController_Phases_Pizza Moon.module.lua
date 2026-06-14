-- Decompiled with Potassium's decompiler.

local v1 = {};
game:GetService("Lighting");
local l__TweenService__1 = game:GetService("TweenService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__Players__3 = game:GetService("Players");
game:GetService("SoundService");
require(l__ReplicatedStorage__2.SharedModules.Networking);
local _ = l__Players__3.LocalPlayer;
local l__CamShake__4 = require(l__ReplicatedStorage__2.ClientModules.CamShake);
local l__NotificationController__5 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.NotificationController);
require(game.StarterPlayer.StarterPlayerScripts.Controllers.FieldOfViewController);
local l__LightingController__6 = require(game.StarterPlayer.StarterPlayerScripts.Controllers.LightingController);
require(game.StarterPlayer.StarterPlayerScripts.Controllers.MusicController);
require(game.ReplicatedStorage.ClientModules.Reticule);
local l__PizzaMoon__7 = l__ReplicatedStorage__2.Assets:WaitForChild("PizzaMoon");
local l__Skybox__8 = require(game.ReplicatedStorage.ClientModules.Skybox);
local l__PizzaGuy__9 = require(script.PizzaGuy);
local l__PizzaSkybox__10 = game.ReplicatedStorage.Assets.Skybox.PizzaSkybox;
require(game.ReplicatedStorage.ClientModules.ButtonMash);
require(game.ReplicatedStorage.ClientModules.RagdollModule);
require(game.ReplicatedStorage.SharedModules.Networking);
local l__Bezier__11 = require(game.ReplicatedStorage.ClientModules.Bezier);
local u2 = {
    ClockTime = 24
};
local u3 = {
    Brightness = 0.5,
    EnvironmentDiffuseScale = 1,
    ClockTime = 9,
    Ambient = Color3.fromRGB(141, 117, 158),
    ColorShift_Bottom = Color3.fromRGB(30, 95, 199),
    ColorShift_Top = Color3.fromRGB(250, 208, 124),
    OutdoorAmbient = Color3.fromRGB(184, 43, 255)
};
local u4 = nil;
local u5 = game.SoundService.SFX.ShakeLoop:Clone();
local function u30() --[[ Line: 93 ]]
    -- upvalues: l__Skybox__8 (copy), l__PizzaSkybox__10 (copy), l__LightingController__6 (copy), u3 (copy), l__PizzaMoon__7 (copy)
    game.TweenService:Create(workspace.Terrain.Clouds, TweenInfo.new(1), {
        Cover = 0
    }):Play();
    task.delay(1, function() --[[ Line: 98 ]]
        -- upvalues: l__Skybox__8 (ref), l__PizzaSkybox__10 (ref), l__LightingController__6 (ref), u3 (ref), l__PizzaMoon__7 (ref)
        l__Skybox__8.SetOrder(l__PizzaSkybox__10, 2);
        l__LightingController__6:TransitionTo(u3, 1);
        l__PizzaMoon__7.Parent = workspace;
    end);
    local u6 = {};
    local u7 = {};
    for _, v8 in l__PizzaMoon__7.FloatingVeg:GetChildren() do
        u6[v8] = {
            direction = Random.new():NextUnitVector(),
            offset = Random.new():NextNumber(0, 400)
        };
        u7[v8] = v8:GetPivot();
        local l__new__12 = CFrame.new;
        local v9 = tick() * 90 + u6[v8].offset;
        local v10 = math.rad(v9);
        local v11 = l__new__12(0, math.sin(v10) * 10, 0) * u7[v8];
        local l__Angles__13 = CFrame.Angles;
        local v12 = math.round(u6[v8].direction.X) * tick() * 360;
        local v13 = math.rad(v12);
        local v14 = math.round(u6[v8].direction.Y) * tick() * 360;
        local v15 = math.rad(v14);
        local v16 = math.round(u6[v8].direction.Z) * tick() * 360;
        v8:PivotTo(v11 * l__Angles__13(v13, v15, (math.rad(v16))));
    end;
    local u17 = l__PizzaMoon__7.FloatingVeg:GetPivot();
    local u18 = CFrame.new(0, -300, 0) * u17;
    task.spawn(function() --[[ Line: 129 ]]
        -- upvalues: u18 (copy), u17 (copy), l__PizzaMoon__7 (ref), u6 (copy), u7 (copy)
        local v19 = 0;
        while v19 < 2 do
            v19 = v19 + task.wait(0.025);
            local v20 = u18:Lerp(u17, (game.TweenService:GetValue(v19 / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)));
            l__PizzaMoon__7.FloatingVeg:PivotTo(v20);
        end;
        while isActive do
            for _, v21 in l__PizzaMoon__7.FloatingVeg:GetChildren() do
                local l__new__14 = CFrame.new;
                local v22 = tick() * 90 + u6[v21].offset;
                local v23 = math.rad(v22);
                local v24 = l__new__14(0, math.sin(v23) * 10, 0) * u7[v21];
                local l__Angles__15 = CFrame.Angles;
                local v25 = math.round(u6[v21].direction.X) * tick() * 360;
                local v26 = math.rad(v25);
                local v27 = math.round(u6[v21].direction.Y) * tick() * 360;
                local v28 = math.rad(v27);
                local v29 = math.round(u6[v21].direction.Z) * tick() * 360;
                v21:PivotTo(v24 * l__Angles__15(v26, v28, (math.rad(v29))));
            end;
            task.wait(0.025);
        end;
    end);
end;
local function u32() --[[ Line: 160 ]]
    -- upvalues: l__TweenService__1 (copy), l__CamShake__4 (copy), u4 (ref), u5 (copy), l__PizzaMoon__7 (copy), l__ReplicatedStorage__2 (copy), l__Skybox__8 (copy), l__PizzaSkybox__10 (copy)
    local u31 = Instance.new("ColorCorrectionEffect");
    u31.Parent = game.Lighting;
    game.Debris:AddItem(u31, 5);
    game.TweenService:Create(game.Workspace.CurrentCamera, TweenInfo.new(0.2), {
        FieldOfView = 95
    }):Play();
    l__TweenService__1:Create(u31, TweenInfo.new(0.4), {
        Brightness = 1.5,
        Contrast = 0.2,
        Saturation = 0.5,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    l__CamShake__4:Shake(l__CamShake__4.Presets.Explosion);
    if u4 then
        u4:Destroy();
        u4 = nil;
    end;
    u5:Stop();
    u5.Volume = 0;
    l__CamShake__4:StopSustained(3);
    game.SoundService:PlayLocalSound(game.SoundService.SFX.Snap);
    task.delay(0.4, function() --[[ Line: 179 ]]
        -- upvalues: l__TweenService__1 (ref), u31 (copy)
        l__TweenService__1:Create(u31, TweenInfo.new(2), {
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
    l__PizzaMoon__7.Parent = l__ReplicatedStorage__2.Assets;
    l__Skybox__8.SetOrder(l__PizzaSkybox__10, 0);
end;
local u33 = l__PizzaGuy__9.new(l__PizzaMoon__7.PizzaGuy);
function v1.Start(_, _, _) --[[ Line: 191 ]]
    -- upvalues: l__LightingController__6 (copy), u2 (copy), u30 (copy), l__NotificationController__5 (copy), u33 (copy), l__Bezier__11 (copy), l__PizzaMoon__7 (copy)
    if isActive then
    else
        isActive = true;
        l__LightingController__6:TransitionTo(u2, 1);
        task.wait(1);
        task.spawn(function() --[[ Line: 200 ]]
            -- upvalues: u30 (ref)
            u30();
        end);
        l__NotificationController__5:CreateNotification(("<font color=\"#" .. Color3.fromRGB(255, 60, 60):ToHex() .. "\">PIZZA PARTY!!</font>") .. " Leave your garden for the deliveries to begin!", nil, 7);
        local l__ActivePizzaTarget__16 = workspace:WaitForChild("ActivePizzaTarget");
        u33:Start();
        local u34 = nil;
        local function u41(p35, p36, p37, p38) --[[ Line: 220 ]]
            -- upvalues: l__Bezier__11 (ref)
            local v39 = p36 - p35;
            local v40 = Vector3.new(-v39.Z, 0, v39.X);
            if v40.Magnitude > 0 then
                v40 = v40.Unit;
            end;
            if p38 then
                v40 = -v40 or v40;
            end;
            return l__Bezier__11.new(p35, p35 + v39 * 0.25 + v40 * p37, p36 - v39 * 0.25 - v40 * p37, p36);
        end;
        local function u60(p42, p43, p44, p45) --[[ Line: 235 ]]
            -- upvalues: l__PizzaMoon__7 (ref), u34 (ref), u41 (copy)
            local v46 = p42 or 5;
            local l__Position__17 = l__PizzaMoon__7.PizzaGuy:GetPivot().Position;
            if u34:IsDescendantOf(workspace.Gardens) then
                p43 = p43 + Vector3.new(0, 24, 0);
            end;
            local l__Magnitude__18 = (l__Position__17 - p43).Magnitude;
            local v47 = u41(l__Position__17, p43, l__Magnitude__18 * p44, p45);
            local v48 = l__Magnitude__18 / v46;
            local v49 = u34;
            local v50 = 0;
            while v50 < v48 and v49 == u34 do
                local v51 = game.TweenService:GetValue(math.clamp(v50 / v48, 0, 1), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
                local v52 = v47:CalculatePositionAt(v51);
                local v53 = v47:CalculatePositionAt(v51 + 0.01);
                local v54 = CFrame.new(v52, v53);
                local v55 = math.clamp(v50 / 2, 0, 1);
                local v56 = l__PizzaMoon__7.PizzaGuy:GetPivot().LookVector:Lerp(v54.LookVector, v55);
                local l__new__19 = CFrame.new;
                local v57 = tick() * 180;
                local v58 = math.rad(v57);
                local v59 = l__new__19(0, math.sin(v58) * 1, 0);
                l__PizzaMoon__7.PizzaGuy:PivotTo(CFrame.new(v52, v52 + v56) * v59);
                v50 = v50 + task.wait(0.025);
            end;
        end;
        local function u64(p61) --[[ Line: 280 ]]
            -- upvalues: l__ActivePizzaTarget__16 (copy), l__PizzaMoon__7 (ref), u34 (ref), u60 (copy)
            local l__p__20 = (p61.CFrame * CFrame.new(-p61.Size.X / 2, 0, 0)).p;
            local l__p__21 = (p61.CFrame * CFrame.new(p61.Size.X / 2, 0, 0)).p;
            local v62 = true;
            if l__ActivePizzaTarget__16.Value then
                l__PizzaMoon__7.PizzaGuy.PizzaRig.PizzaSlot.Pizza.Enabled = true;
            end;
            while u34 == p61 do
                local _ = l__PizzaMoon__7.PizzaGuy:GetPivot().Position;
                local v63 = v62 and l__p__21 and l__p__21 or l__p__20;
                v62 = not v62;
                u60(20, v63, 0.4, v62);
            end;
            l__PizzaMoon__7.PizzaGuy.PizzaRig.PizzaSlot.Pizza.Enabled = false;
        end;
        task.spawn(function() --[[ Line: 304 ]]
            -- upvalues: l__ActivePizzaTarget__16 (copy), l__PizzaMoon__7 (ref), u34 (ref), u60 (copy), u64 (copy)
            while isActive do
                task.wait(1);
                local u65 = l__ActivePizzaTarget__16.Value or l__PizzaMoon__7:WaitForChild("Center");
                if u34 ~= u65 then
                    u34 = u65;
                    u60(40, u34:GetPivot().Position, 0.8);
                    task.spawn(function() --[[ Line: 323 ]]
                        -- upvalues: u64 (ref), u65 (ref)
                        u64(u65);
                    end);
                end;
            end;
        end);
    end;
end;
function v1.End(_) --[[ Line: 335 ]]
    -- upvalues: u32 (copy)
    if isActive then
        isActive = false;
        u32();
    end;
end;
return v1;