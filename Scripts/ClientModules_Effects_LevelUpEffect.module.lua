-- Decompiled with Potassium's decompiler.

local l__Assets__1 = game:GetService("ReplicatedStorage").Assets;
local l__SpiralTrail__2 = require(game.ReplicatedStorage.ClientModules.SpiralTrail);
return {
    Play = function(_, p1) --[[ Name: Play, Line 9 ]]
        -- upvalues: l__Assets__1 (copy), l__SpiralTrail__2 (copy)
        local u2 = l__Assets__1.LevelUp.LevelUpEffect:Clone();
        local u3 = l__Assets__1.LevelUp.Highlight:Clone();
        local v4 = l__Assets__1.LevelUp.PoofEffect:Clone();
        u2:PivotTo(p1.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
        local v5 = Instance.new("WeldConstraint");
        v5.Part0 = u2;
        v5.Part1 = p1.HumanoidRootPart;
        v5.Parent = u2;
        u2.Parent = p1;
        v4.Parent = p1.HumanoidRootPart;
        u3.Parent = p1;
        local u6 = { 510, 470, 268 };
        task.spawn(function() --[[ Line: 35 ]]
            -- upvalues: l__SpiralTrail__2 (ref), u2 (copy)
            l__SpiralTrail__2.Init(u2, {
                Size = 0.2,
                Offset = 4,
                Time = 0.4,
                Frequency = 1,
                Radius = 2,
                Color = Color3.fromRGB(255, 243, 115)
            });
        end);
        local u7 = 0;
        task.spawn(function() --[[ Line: 48 ]]
            -- upvalues: u7 (ref), u6 (copy), u3 (copy)
            while u7 < 1.6 do
                u7 = u7 + game:GetService("RunService").Heartbeat:Wait();
                local v8 = tick() * 720;
                local v9 = math.rad(v8);
                local v10 = (math.sin(v9) + 1) / 2;
                u3.FillColor = Color3.fromRGB(u6[1], u6[2], u6[3]):Lerp(Color3.fromRGB(255, 235, 134), v10);
                local v11 = u3;
                local v12 = tick() * 360;
                local v13 = math.rad(v12);
                v11.FillTransparency = (math.sin(v13) + 1) / 2 * 0.3 * (u7 / 1.6 * 0.1) + 0.7;
                u3.OutlineTransparency = v10;
            end;
            game.TweenService:Create(u3, TweenInfo.new(1), {
                FillTransparency = 1,
                OutlineTransparency = 1
            }):Play();
        end);
        for _, u14 in v4:GetChildren() do
            if u14:IsA("ParticleEmitter") then
                u14:Emit(u14:GetAttribute("EmitCount") or 1);
                if u14.Name ~= "Glow2" then
                    u14.Enabled = true;
                    task.delay(0.9, function() --[[ Line: 75 ]]
                        -- upvalues: u14 (copy)
                        u14.Enabled = false;
                    end);
                end;
            end;
        end;
        for _, u15 in u2:GetDescendants() do
            if u15:IsA("ParticleEmitter") then
                u15.Enabled = true;
                u15:Emit(u15:GetAttribute("EmitCount") or 1);
                task.delay(0.9, function() --[[ Line: 86 ]]
                    -- upvalues: u15 (copy)
                    u15.Enabled = false;
                end);
            end;
        end;
        game.Debris:AddItem(u2, 2);
        game.Debris:AddItem(v4, 2);
        game.Debris:AddItem(u3, 2);
    end
};