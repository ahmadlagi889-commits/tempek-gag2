-- Decompiled with Potassium's decompiler.

game:GetService("RunService");
local l__TweenService__1 = game:GetService("TweenService");
local l__Debris__2 = game:GetService("Debris");
local l__CreateTrail__3 = require(script.CreateTrail);
return {
    Init = function(u1, p2) --[[ Name: Init, Line 11 ]]
        -- upvalues: l__TweenService__1 (copy), l__CreateTrail__3 (copy), l__Debris__2 (copy)
        local v3 = p2.Frequency or (1 / 0);
        local u4 = p2.Radius or nil;
        local u5 = p2.Lifetime or (1 / 0);
        local v6 = p2.Time or 0.45;
        local u7 = p2.Offset or 0.05;
        for _ = 1, v3 do
            local u8 = 0;
            local v9 = p2.Size or 0.275;
            local v10 = p2.Color or Color3.fromRGB(255, 255, 255);
            local v11 = p2.Transparency or 0;
            local v12 = TweenInfo.new(v6, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1);
            local u13 = Instance.new("Part");
            u13.Anchored = true;
            u13.CanCollide = false;
            u13.CanTouch = false;
            u13.CanQuery = false;
            u13.CFrame = u1.CFrame * CFrame.new(0, -(u1.Size.Y / 2), 0);
            u13.Size = Vector3.new(1, 1, 1);
            u13.Transparency = 1;
            u13.Parent = u1;
            l__TweenService__1:Create(u13, v12, {
                Orientation = u13.Orientation + Vector3.new(0, 360, 0)
            }):Play();
            local u14 = Instance.new("Part");
            u14.Anchored = true;
            u14.CanCollide = false;
            u14.CanTouch = false;
            u14.CanQuery = false;
            u14.CFrame = u13.CFrame;
            u14.Size = Vector3.new(1, 1, 1);
            u14.Transparency = 1;
            u14.Parent = workspace.Temporary;
            local v15 = l__CreateTrail__3(u14, v9, v10, v11);
            local v19 = task.spawn(function() --[[ Line: 54 ]]
                -- upvalues: u8 (ref), u5 (copy), u13 (copy), u7 (copy), u4 (copy), u1 (copy), u14 (copy)
                while true do
                    local v16 = task.wait(0);
                    u8 = (u8 + v16 / u5) % 1;
                    local v17 = 6.283185307179586 * u8;
                    u13.CFrame = u13.CFrame * CFrame.new(0, u7 * v16, 0);
                    local v18 = u4 or math.sqrt(u1.Size.X ^ 2 + u1.Size.Y ^ 2) / 2;
                    u14.CFrame = u13.CFrame * CFrame.Angles(0, v17, 0) * CFrame.new(0, 0, v18);
                end;
            end);
            task.wait(1.35);
            v15.Enabled = false;
            l__Debris__2:AddItem(u13, 1);
            l__Debris__2:AddItem(u14, 1);
            task.wait(1);
            task.cancel(v19);
        end;
    end
};