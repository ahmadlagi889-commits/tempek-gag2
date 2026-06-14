-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 5
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
require(script.Parent.RollController);
local l__Networking__3 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__CrateOpenEffect__4 = require(script:WaitForChild("CrateOpenEffect"));
local l__LocalPlayer__5 = l__Players__1.LocalPlayer;
local u2 = 0;
local function u8(p3) --[[ Line: 22 ]]
    -- upvalues: l__ReplicatedStorage__2 (copy)
    local l__Assets__6 = l__ReplicatedStorage__2.Assets;
    local v4 = l__Assets__6:FindFirstChild("GuildCrates");
    if v4 then
        local v5 = v4:FindFirstChild(p3);
        if v5 and v5:IsA("Model") then
            return v5;
        end;
    end;
    local l__Crates__7 = l__Assets__6.Crates;
    local v6 = l__Crates__7:FindFirstChild(p3);
    if v6 and v6:IsA("Model") then
        return v6;
    else
        local v7 = l__Crates__7:FindFirstChild("Arch Crate");
        if v7 and v7:IsA("Model") then
            return v7;
        else
            return nil;
        end;
    end;
end;
function v1.Init(_) --[[ Line: 44 ]] end;
local l__CrateSFX__8 = game.SoundService.SFX.CrateSFX;
local u9 = {
    Spawn = l__CrateSFX__8.CrateSpawn,
    Land = l__CrateSFX__8.CrateLand,
    Shake = l__CrateSFX__8.CrateShake,
    Explode = l__CrateSFX__8.CrateExplode,
    Reveal = l__CrateSFX__8.CrateReward,
    Collect = l__CrateSFX__8.CrateCollect
};
function v1.Start(u10) --[[ Line: 58 ]]
    -- upvalues: l__LocalPlayer__5 (copy), l__Networking__3 (copy), u8 (copy), l__CrateOpenEffect__4 (copy), l__ReplicatedStorage__2 (copy), u9 (copy)
    local function v14(p11) --[[ Line: 59 ]]
        -- upvalues: u10 (copy)
        p11.ChildAdded:Connect(function(p12) --[[ Line: 60 ]]
            -- upvalues: u10 (ref)
            if p12:IsA("Tool") and p12:GetAttribute("Crate") then
                u10:BindCrateTool(p12);
            end;
        end);
        for _, v13 in p11:GetChildren() do
            if v13:IsA("Tool") and v13:GetAttribute("Crate") then
                u10:BindCrateTool(v13);
            end;
        end;
    end;
    if l__LocalPlayer__5.Character then
        v14(l__LocalPlayer__5.Character);
    end;
    l__LocalPlayer__5.CharacterAdded:Connect(v14);
    l__Networking__3.Crate.ReplicateOpenCrate.OnClientEvent:Connect(function(p15, p16) --[[ Line: 80 ]]
        -- upvalues: l__LocalPlayer__5 (ref), u8 (ref), l__CrateOpenEffect__4 (ref), l__ReplicatedStorage__2 (ref), u9 (ref)
        if p15 == l__LocalPlayer__5 then
        else
            local v17 = u8(p16.WonItem.CrateName);
            if v17 then
                l__CrateOpenEffect__4.Play({
                    RarityName = "Legendary",
                    Rarity = 0.01,
                    Player = p15,
                    CrateModel = v17,
                    ItemImage = p16.WonItem.Image,
                    ItemName = p16.WonItem.Name,
                    RarityColor = Color3.fromRGB(255, 215, 0),
                    IsBestItem = p16.WonItem.IsBestItem,
                    BillboardTemplate = l__ReplicatedStorage__2.Assets.BillboardUIs.CrateItemBillboard,
                    Particles = {
                        Impact = l__ReplicatedStorage__2.Assets.VFX.CrateVFX.Impact:GetChildren(),
                        Explosion = l__ReplicatedStorage__2.Assets.VFX.CrateVFX.Explosion:GetChildren(),
                        Trail = l__ReplicatedStorage__2.Assets.VFX.CrateVFX.Trail.Trail
                    },
                    Sounds = u9,
                    OnCollected = function() --[[ Name: OnCollected, Line 103 ]] end
                });
            end;
        end;
    end);
end;
function v1.BindCrateTool(u18, u19) --[[ Line: 110 ]]
    u19.Activated:Connect(function() --[[ Line: 111 ]]
        -- upvalues: u19 (copy), u18 (copy)
        local v20 = u19:GetAttribute("Crate");
        if v20 then
            u18:OpenCrate(v20);
        end;
    end);
end;
function v1.OpenCrate(_, u21) --[[ Line: 119 ]]
    -- upvalues: u2 (ref), l__Networking__3 (copy), u8 (copy), l__CrateOpenEffect__4 (copy), l__LocalPlayer__5 (copy), l__ReplicatedStorage__2 (copy), u9 (copy)
    if u2 >= 10 then
    else
        u2 = u2 + 1;
        local v22, u23 = pcall(function() --[[ Line: 127 ]]
            -- upvalues: l__Networking__3 (ref), u21 (copy)
            return l__Networking__3.Crate.OpenCrate:Fire(u21);
        end);
        if v22 and (u23 and u23.Success) then
            local u24 = u8(u23.WonItem.CrateName);
            if u24 then
                task.spawn(function() --[[ Line: 138 ]]
                    -- upvalues: l__CrateOpenEffect__4 (ref), l__LocalPlayer__5 (ref), u24 (copy), u23 (copy), l__ReplicatedStorage__2 (ref), u9 (ref), u2 (ref)
                    local v25, v26 = pcall(function() --[[ Line: 139 ]]
                        -- upvalues: l__CrateOpenEffect__4 (ref), l__LocalPlayer__5 (ref), u24 (ref), u23 (ref), l__ReplicatedStorage__2 (ref), u9 (ref)
                        l__CrateOpenEffect__4.Play({
                            RarityName = "Legendary",
                            Player = l__LocalPlayer__5,
                            CrateModel = u24,
                            ItemImage = u23.WonItem.Image,
                            ItemName = u23.WonItem.Name,
                            RarityColor = Color3.fromRGB(255, 215, 0),
                            Rarity = u23.WonItem.Chance / 100,
                            IsBestItem = u23.WonItem.IsBestItem,
                            BillboardTemplate = l__ReplicatedStorage__2.Assets.BillboardUIs.CrateItemBillboard,
                            Particles = {
                                Impact = l__ReplicatedStorage__2.Assets.VFX.CrateVFX.Impact:GetChildren(),
                                Explosion = l__ReplicatedStorage__2.Assets.VFX.CrateVFX.Explosion:GetChildren(),
                                Trail = l__ReplicatedStorage__2.Assets.VFX.CrateVFX.Trail.Trail
                            },
                            Sounds = u9
                        });
                    end);
                    if not v25 then
                        warn((`CrateOpenEffect.Play error: {v26}`));
                    end;
                    u2 = u2 - 1;
                end);
            else
                u2 = u2 - 1;
            end;
        else
            if not v22 then
                warn((`[CrateController] OpenCrate invoke errored ({u21}): {u23}`));
            end;
            u2 = u2 - 1;
        end;
    end;
end;
return v1;