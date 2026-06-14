-- Decompiled with Potassium's decompiler.

local l__TweenService__1 = game:GetService("TweenService");
local l__Players__2 = game:GetService("Players");
local u1 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
local l__Networking__3 = require(game.ReplicatedStorage.SharedModules.Networking);
return function(u2) --[[ Line: 6 ]]
    -- upvalues: l__Networking__3 (copy), l__TweenService__1 (copy), u1 (copy), l__Players__2 (copy)
    local u3 = u2:GetAttribute("PropId");
    local l__Launcher__4 = u2.Build.Launcher;
    local l__Base__5 = u2.Build.Base;
    local l__SpringConstraint__6 = l__Base__5.SpringConstraint;
    local l__SFX__7 = l__Launcher__4.SFX;
    u2:SetAttribute("Debounce", true);
    l__Networking__3.Spring.SpringFire.OnClientEvent:Connect(function(p4) --[[ Line: 13 ]]
        -- upvalues: u3 (copy), u2 (copy), l__Launcher__4 (copy), l__SpringConstraint__6 (copy), l__SFX__7 (copy)
        if p4 == u3 then
            u2:SetAttribute("Debounce", false);
            l__Launcher__4.Anchored = false;
            l__SpringConstraint__6.MinLength = 1;
            l__SpringConstraint__6.MaxLength = 7;
            l__SFX__7.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
            l__SFX__7.Playing = true;
        end;
    end);
    l__Networking__3.Spring.SpringReload.OnClientEvent:Connect(function(p5) --[[ Line: 22 ]]
        -- upvalues: u3 (copy), l__TweenService__1 (ref), l__SpringConstraint__6 (copy), u1 (ref), l__Launcher__4 (copy), l__Base__5 (copy), u2 (copy)
        if p5 == u3 then
            local v6 = l__TweenService__1:Create(l__SpringConstraint__6, u1, {
                MaxLength = 3
            });
            v6:Play();
            game.Debris:AddItem(v6, u1.Time);
            task.wait(u1.Time);
            l__SpringConstraint__6.MinLength = 1;
            l__Launcher__4.CFrame = l__Base__5.CFrame + Vector3.new(0, 2, 0);
            l__Launcher__4.Anchored = true;
            u2:SetAttribute("Debounce", true);
        end;
    end);
    l__Launcher__4.Touched:Connect(function(p7) --[[ Line: 33 ]]
        -- upvalues: u2 (copy), l__Players__2 (ref), l__Networking__3 (ref), u3 (copy)
        if u2:GetAttribute("Debounce") then
            if p7 then
                p7 = p7.Parent;
            end;
            local u8;
            if p7 then
                u8 = p7:FindFirstChild("Humanoid");
            else
                u8 = p7;
            end;
            local v9;
            if p7 then
                v9 = p7.PrimaryPart;
            else
                v9 = p7;
            end;
            if u8 and v9 then
                if l__Players__2:GetPlayerFromCharacter(p7) == l__Players__2.LocalPlayer then
                    u2:SetAttribute("Debounce", false);
                    local v10 = Instance.new("BodyVelocity");
                    v10.MaxForce = Vector3.new(0, 12000, 0);
                    v10.Velocity = Vector3.new(0, 12000, 0);
                    v10.P = 10000;
                    v10.Parent = v9;
                    game.Debris:AddItem(v10, 0.25);
                    u8.PlatformStand = true;
                    l__Networking__3.Spring.SpringFire:Fire(u3);
                    task.delay(math.random(2, 3), function() --[[ Line: 52 ]]
                        -- upvalues: u8 (copy)
                        u8.PlatformStand = false;
                    end);
                end;
            end;
        end;
    end);
end;