-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__TweenService__1 = game:GetService("TweenService");
local u2 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
local u3 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0);
local l__RadialScreenFlash__2 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RadialScreenFlash");
local l__Networking__3 = require(game.ReplicatedStorage.SharedModules.Networking);
function u1.Start(_) --[[ Line: 13 ]] end;
function u1.Init(_) --[[ Line: 17 ]]
    -- upvalues: l__Networking__3 (copy), u1 (copy)
    l__Networking__3.Flash.Flash.OnClientEvent:Connect(function(p4) --[[ Line: 18 ]]
        -- upvalues: u1 (ref)
        u1:PlayFX(p4);
    end);
end;
function u1.PlayFX(_, p5) --[[ Line: 23 ]]
    -- upvalues: l__RadialScreenFlash__2 (copy), l__TweenService__1 (copy), u2 (copy), u3 (copy)
    local u6 = l__RadialScreenFlash__2:FindFirstChild(p5);
    if u6 then
        local v7 = l__TweenService__1:Create(u6, u2, {
            ImageTransparency = 0
        });
        v7:Play();
        game.Debris:AddItem(v7, u2.Time);
        task.spawn(function() --[[ Line: 29 ]]
            -- upvalues: u2 (ref), l__TweenService__1 (ref), u6 (copy), u3 (ref)
            task.wait(u2.Time + 0.7);
            local v8 = l__TweenService__1:Create(u6, u3, {
                ImageTransparency = 1
            });
            v8:Play();
            game.Debris:AddItem(v8, u3.Time);
        end);
    end;
end;
return u1;