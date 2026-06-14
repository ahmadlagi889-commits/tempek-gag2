-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 6
};
local l__Players__1 = game:GetService("Players");
game:GetService("RunService");
local l__SoundService__2 = game:GetService("SoundService");
game:GetService("TweenService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__Networking__4 = require(l__ReplicatedStorage__3.SharedModules.Networking);
require(l__ReplicatedStorage__3.SharedModules.SeedPackData);
require(game.ReplicatedStorage.SharedModules.SeedData);
local l__SeedPackEffect__5 = require(script.SeedPackEffect);
game:GetService("CollectionService");
local _ = l__ReplicatedStorage__3.Assets.SeedPacks;
local _ = l__ReplicatedStorage__3.Assets.Seeds;
local _ = l__Players__1.LocalPlayer;
local _ = l__SoundService__2.SFX.Click;
local l__SeedpackSFX__6 = l__SoundService__2.SFX.SeedpackSFX;
local _ = l__SeedpackSFX__6.SeedpackReward;
local _ = l__SeedpackSFX__6.SeedpackOpen;
local _ = l__SeedpackSFX__6.SeedpackSpawn;
local _ = l__SeedpackSFX__6.SeedpackCollect;
local _ = game.ReplicatedStorage.Assets.SeedNameAttachment;
local _ = 0;
local _ = game.ReplicatedStorage.SharedModules.RarityData;
function v1.Init(_) --[[ Line: 540 ]] end;
function v1.Start(_) --[[ Line: 543 ]]
    -- upvalues: l__Networking__4 (copy), l__SeedPackEffect__5 (copy), l__Players__1 (copy)
    l__Networking__4.SeedPack.ReplicateOpenSeedPack.OnClientEvent:Connect(function(u2, u3, u4, u5, p6) --[[ Line: 544 ]]
        -- upvalues: l__SeedPackEffect__5 (ref), l__Players__1 (ref), l__Networking__4 (ref)
        if u2 and u2.Character then
            local l__Position__7 = u2.Character.HumanoidRootPart.Position;
            local u7 = CFrame.new(p6, p6 + CFrame.new(p6, l__Position__7).LookVector);
            task.spawn(function() --[[ Line: 551 ]]
                -- upvalues: l__SeedPackEffect__5 (ref), u3 (copy), u4 (copy), u5 (copy), l__Position__7 (copy), u7 (copy), u2 (copy), l__Players__1 (ref), l__Networking__4 (ref)
                l__SeedPackEffect__5.Open(u3, u4, u5, l__Position__7, u7);
                if u2 == l__Players__1.LocalPlayer then
                    l__Networking__4.SeedPack.ConfirmSeedPack:Fire(u3, u4, u5);
                end;
            end);
        end;
    end);
    l__Networking__4.SeedPack.ConfirmSeedPack.OnClientEvent:Connect(function(p8, p9) --[[ Line: 564 ]]
        -- upvalues: l__SeedPackEffect__5 (ref)
        l__SeedPackEffect__5.UpdateDropData(p8, p9);
    end);
end;
function v1.ReturnRandomItem(_, p10) --[[ Line: 569 ]]
    local v11 = 0;
    for _, v12 in pairs(p10) do
        v11 = v11 + v12.Chance;
    end;
    local v13 = math.random() * v11;
    local v14 = 0;
    for _, v15 in pairs(p10) do
        v14 = v14 + v15.Chance;
        if v13 <= v14 then
            return v15;
        end;
    end;
    return p10[#p10];
end;
function v1.PlaySFXLocation(_, p16, p17) --[[ Line: 587 ]]
    local v18 = Instance.new("Part");
    v18.Anchored = true;
    v18.CanCollide = false;
    v18.Size = Vector3.new(1, 1, 1);
    v18.Parent = game.Workspace.Temporary;
    v18.Transparency = 1;
    v18.Position = p17;
    local v19 = p16:Clone();
    v19.Parent = v18;
    v19.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
    v19.Playing = true;
    game.Debris:AddItem(v18, v19.TimeLength * v19.PlaybackSpeed);
end;
function v1.Roll(p20, p21, p22) --[[ Line: 1024 ]]
    return p22 or p20:ReturnRandomItem(p21);
end;
return v1;