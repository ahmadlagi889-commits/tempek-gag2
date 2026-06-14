-- Decompiled with Potassium's decompiler.

local v1 = {};
local l__Networking__1 = require(game.ReplicatedStorage.SharedModules.Networking);
function v1.Create(p2, p3, p4, p5, p6) --[[ Line: 3 ]]
    local v7 = game.ReplicatedStorage.Assets.Reticule:Clone();
    v7.CFrame = p2;
    v7.Size = Vector3.new(p3, 0.1, p3);
    local v8 = p6 or 1;
    for _, v9 in v7:GetDescendants() do
        if v9:IsA("Frame") then
            v9.BackgroundTransparency = v9.BackgroundTransparency * v8;
            v9.BackgroundColor3 = p4;
        elseif v9:IsA("UIStroke") then
            v9.Color = p4;
            v9.Transparency = v9.Transparency * v8;
        end;
    end;
    v7.Parent = workspace;
    game:GetService("TweenService"):Create(v7.SurfaceGui.Inner.UIScale, TweenInfo.new(p5), {
        Scale = 1
    }):Play();
    game.Debris:AddItem(v7, p5);
end;
l__Networking__1.WeatherEffects.Reticule.OnClientEvent:Connect(v1.Create);
return v1;