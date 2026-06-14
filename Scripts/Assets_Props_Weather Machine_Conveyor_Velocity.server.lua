-- Decompiled with Potassium's decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
local l__Parent__2 = script.Parent;
local l__plr_Val__3 = script.Parent.Parent.plr_Val;
function UpdateSpeed()
    -- upvalues: l__LocalPlayer__1 (copy), l__Parent__2 (copy)
    local l__Character__4 = l__LocalPlayer__1.Character;
    local v1 = l__Character__4 and l__Character__4:FindFirstChild("Humanoid");
    if v1 then
        l__Parent__2.Velocity = -script.Parent.CFrame.RightVector * (v1.WalkSpeed - 0.25);
    end;
end;
function TrackCharater(p2)
    local l__Humanoid__5 = p2:WaitForChild("Humanoid");
    if l__Humanoid__5 then
        UpdateSpeed();
        l__Humanoid__5:GetPropertyChangedSignal("WalkSpeed"):Connect(function() --[[ Line: 21 ]]
            UpdateSpeed();
        end);
    end;
end;
local l__Character__6 = l__LocalPlayer__1.Character;
while l__Character__6 == nil do
    task.wait();
end;
TrackCharater(l__Character__6);
l__LocalPlayer__1.CharacterAdded:Connect(function(p3) --[[ Line: 34 ]]
    TrackCharater(p3);
end);
l__Parent__2:GetPropertyChangedSignal("Orientation"):Connect(function() --[[ Line: 38 ]]
    UpdateSpeed();
end);
game:GetService("TweenService");
TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0);
local l__RunService__7 = game:GetService("RunService");
local l__Top__8 = script.Parent.Top;
l__RunService__7.Heartbeat:Connect(function() --[[ Line: 50 ]]
    -- upvalues: l__plr_Val__3 (copy), l__Top__8 (copy)
    local v4 = l__Top__8;
    v4.OffsetStudsU = v4.OffsetStudsU - 0.05 * l__plr_Val__3.Value;
end);