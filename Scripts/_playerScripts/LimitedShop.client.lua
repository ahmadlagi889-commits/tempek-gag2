-- Decompiled with Potassium's decompiler.

repeat
    task.wait(0.3);
until game.Players.LocalPlayer;
require(game.ReplicatedStorage.ClientModules.Trove);
game:GetService("TweenService");
game:GetService("StarterGui");
local l__Controllers__1 = game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("Controllers");
local l__SeedInspectController__2 = require(l__Controllers__1:WaitForChild("SeedInspectController"));
local l__SeedPackData__3 = require(game.ReplicatedStorage.SharedModules.SeedPackData);
local l__SeedData__4 = game.ReplicatedStorage.SharedModules.SeedData;
local l__CinematicBars__5 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("CinematicBars");
l__CinematicBars__5:WaitForChild("BottomBar");
l__CinematicBars__5:WaitForChild("TopBar");
local l__Prizes__6 = l__CinematicBars__5:WaitForChild("PrizesUI"):WaitForChild("Prizes");
local v1 = l__SeedPackData__3.GetData("Ghost Pepper Pack");
local v2 = {};
for _, v3 in pairs(v1.Seeds) do
    table.insert(v2, v3);
end;
for _, v4 in pairs(l__Prizes__6:GetChildren()) do
    if v4:IsA("Frame") then
        local v5 = v4:FindFirstChild("Inspect");
        if v5 then
            local v6 = tonumber(v4.Name:sub(5));
            if v6 then
                local u7 = v2[v6];
                v4.Odds.Text = tostring(u7.Chance) .. "%";
                v4.ItemName.Text = u7.SeedName;
                v4.ItemImage.Image = l__SeedData__4.SeedImages[u7.SeedName].Value;
                v5.Activated:Connect(function() --[[ Line: 61 ]]
                    -- upvalues: l__SeedInspectController__2 (copy), u7 (copy)
                    l__SeedInspectController__2.Inspect(u7);
                end);
            end;
        end;
    end;
end;