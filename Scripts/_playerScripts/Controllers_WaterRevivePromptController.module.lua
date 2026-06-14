-- Decompiled with Potassium's decompiler.

local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__SoundService__4 = game:GetService("SoundService");
local l__SeedData__5 = require(l__ReplicatedStorage__3.SharedModules.SeedData);
local l__GearShopData__6 = require(l__ReplicatedStorage__3.SharedModules.GearShopData);
local l__PlayerStateClient__7 = require(l__ReplicatedStorage__3.ClientModules.PlayerStateClient);
local l__PlantLifecycleHandler__8 = require(game.Players.LocalPlayer.PlayerScripts.Controllers.PlantLifecycleHandler);
local v1 = {
    StartOrder = 5
};
local u2 = 0;
for _, v3 in l__GearShopData__6.Data do
    if v3.ItemName == "Common Watering Can" then
        u2 = v3.Cost;
        break;
    end;
end;
local u4 = UDim2.fromScale(4, 4);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__PlayerGui__10 = l__LocalPlayer__9:WaitForChild("PlayerGui");
local l__Click__11 = l__SoundService__4.SFX.Click;
local u5 = {};
local u6 = nil;
for _, v7 in l__SeedData__5 do
    u5[v7.SeedName] = v7;
end;
local u8 = nil;
local u9 = nil;
local u10 = 1;
local function u16() --[[ Line: 74 ]]
    -- upvalues: l__ReplicatedStorage__3 (copy), l__GearShopData__6 (copy)
    local v11 = l__ReplicatedStorage__3:FindFirstChild("StockValues");
    if not v11 then
        return false;
    end;
    local v12 = v11:FindFirstChild("GearShop");
    if not v12 then
        return false;
    end;
    local v13 = v12:FindFirstChild("Items");
    if not v13 then
        return false;
    end;
    for _, v14 in l__GearShopData__6.Data do
        if v14.ItemType == "Watering Can" then
            local v15 = v13:FindFirstChild(v14.ItemName);
            if v15 and v15.Value > 0 then
                return true;
            end;
        end;
    end;
    return false;
end;
local function u24(p17, p18) --[[ Line: 94 ]]
    -- upvalues: u5 (copy), l__PlantLifecycleHandler__8 (copy)
    if not p17.PrimeStartedAt or p17.PrimeStartedAt <= 0 then
        return false;
    end;
    if p17.Mutation then
        return false;
    end;
    local v19 = u5[p17.SeedName];
    if not (v19 and v19.PrimeTime) then
        return false;
    end;
    if v19.AlwaysPrime then
        return false;
    end;
    local v20, v21 = string.match(p18, "^(%d+)_(.+)$");
    if not (v20 and v21) then
        return false;
    end;
    local v22 = l__PlantLifecycleHandler__8:GetDecayAlpha(tonumber(v20), v21);
    local v23;
    if v22 == nil then
        v23 = false;
    else
        v23 = v22 > 0.5;
    end;
    return v23;
end;
local function u29(p25) --[[ Line: 117 ]]
    -- upvalues: u4 (copy), l__Click__11 (copy), l__ReplicatedStorage__3 (copy), l__PlayerGui__10 (copy)
    local v26 = Instance.new("BillboardGui");
    v26.Name = "WaterRevivePrompt";
    v26.Size = u4;
    v26.StudsOffset = Vector3.new(0, 4, 0);
    v26.AlwaysOnTop = true;
    v26.ResetOnSpawn = false;
    v26.Active = true;
    v26.Adornee = p25.PrimaryPart;
    local v27 = Instance.new("ImageButton");
    v27.Name = "ReviveButton";
    v27.Image = "rbxassetid://119733290955630";
    v27.Size = UDim2.fromScale(1, 1);
    v27.BackgroundTransparency = 1;
    v27.ImageTransparency = 1;
    v27.Parent = v26;
    v27.Activated:Connect(function() --[[ Line: 135 ]]
        -- upvalues: l__Click__11 (ref), l__ReplicatedStorage__3 (ref)
        l__Click__11.TimePosition = 0;
        l__Click__11.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        l__Click__11:Play();
        local v28 = l__ReplicatedStorage__3:FindFirstChild("Notify");
        if v28 then
            v28:Fire("Water this plant to revive it!");
        end;
    end);
    v26.Parent = l__PlayerGui__10;
    return v26;
end;
function v1.Init(_) --[[ Line: 168 ]] end;
function v1.Start(_) --[[ Line: 171 ]]
    -- upvalues: u6 (ref), l__PlayerStateClient__7 (copy), l__RunService__2 (copy), l__LocalPlayer__9 (copy), u8 (ref), u9 (ref), u10 (ref), u2 (ref), u16 (copy), l__PlantLifecycleHandler__8 (copy), u24 (copy), u29 (copy)
    task.spawn(function() --[[ Line: 172 ]]
        -- upvalues: u6 (ref), l__PlayerStateClient__7 (ref)
        u6 = l__PlayerStateClient__7:WaitForLocalReplica(30);
    end);
    l__RunService__2.Heartbeat:Connect(function(p30) --[[ Line: 176 ]]
        -- upvalues: u6 (ref), l__LocalPlayer__9 (ref), u8 (ref), u9 (ref), u10 (ref), u2 (ref), u16 (ref), l__PlantLifecycleHandler__8 (ref), u24 (ref), u29 (ref)
        if u6 then
            if l__LocalPlayer__9:GetAttribute("SecondTimePlayer") == true then
                local v31;
                if u6 then
                    v31 = u6.Data.HasWateredPlants == true;
                else
                    v31 = false;
                end;
                if v31 then
                    if u8 then
                        u8:Destroy();
                        u8 = nil;
                    end;
                    u9 = nil;
                    u10 = 1;
                else
                    local v32;
                    if u6 then
                        v32 = u2 < (u6.Data.Sheckles or 0);
                    else
                        v32 = false;
                    end;
                    if v32 then
                        if u16() then
                            local l__Character__12 = l__LocalPlayer__9.Character;
                            local v33;
                            if l__Character__12 then
                                local v34 = l__Character__12:FindFirstChildWhichIsA("Tool");
                                if v34 then
                                    v33 = v34:GetAttribute("WateringCan") ~= nil;
                                else
                                    v33 = false;
                                end;
                            else
                                v33 = false;
                            end;
                            if v33 then
                                if u8 then
                                    u10 = math.clamp(u10 + p30 * 3, 0, 1);
                                    local v35 = u10;
                                    local v36 = u8:FindFirstChild("ReviveButton");
                                    if v36 then
                                        v36.ImageTransparency = v35;
                                    end;
                                    if u10 >= 1 then
                                        if u8 then
                                            u8:Destroy();
                                            u8 = nil;
                                        end;
                                        u9 = nil;
                                        u10 = 1;
                                    end;
                                end;
                            else
                                local l__Character__13 = l__LocalPlayer__9.Character;
                                local v37;
                                if l__Character__13 then
                                    local v38 = l__Character__13:FindFirstChild("HumanoidRootPart");
                                    if v38 then
                                        v37 = v38.Position;
                                    else
                                        v37 = nil;
                                    end;
                                else
                                    v37 = nil;
                                end;
                                if v37 then
                                    local v39 = 30;
                                    local v40 = nil;
                                    local v41 = nil;
                                    for v42, v43 in l__PlantLifecycleHandler__8:GetActiveEntries() do
                                        local v44 = string.match(v42, "^(%d+)_");
                                        local v45;
                                        if v44 then
                                            v45 = tonumber(v44) == l__LocalPlayer__9.UserId;
                                        else
                                            v45 = false;
                                        end;
                                        if v45 then
                                            local l__Model__14 = v43.Model;
                                            if l__Model__14 and l__Model__14.Parent then
                                                local v46 = u24(v43, v42);
                                                if l__Model__14:GetAttribute("Decaying") ~= v46 then
                                                    l__Model__14:SetAttribute("Decaying", v46);
                                                end;
                                                if v46 and l__Model__14.PrimaryPart then
                                                    local l__Magnitude__15 = (l__Model__14.PrimaryPart.Position - v37).Magnitude;
                                                    if l__Magnitude__15 < v39 then
                                                        v41 = v42;
                                                        v40 = l__Model__14;
                                                        v39 = l__Magnitude__15;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                    if v40 and v41 then
                                        if u9 ~= v40 then
                                            if u8 then
                                                u8:Destroy();
                                                u8 = nil;
                                            end;
                                            u9 = nil;
                                            u10 = 1;
                                            u8 = u29(v40);
                                            u9 = v40;
                                            u10 = 1;
                                        end;
                                        u10 = math.clamp(u10 - p30 * 3, 0, 1);
                                        if u8 then
                                            local v47 = u10;
                                            local v48 = u8:FindFirstChild("ReviveButton");
                                            if v48 then
                                                v48.ImageTransparency = v47;
                                            end;
                                        end;
                                    else
                                        if u8 then
                                            u10 = math.clamp(u10 + p30 * 3, 0, 1);
                                            local v49 = u10;
                                            local v50 = u8:FindFirstChild("ReviveButton");
                                            if v50 then
                                                v50.ImageTransparency = v49;
                                            end;
                                            if u10 >= 1 then
                                                if u8 then
                                                    u8:Destroy();
                                                    u8 = nil;
                                                end;
                                                u9 = nil;
                                                u10 = 1;
                                            end;
                                        end;
                                    end;
                                else
                                    if u8 then
                                        u8:Destroy();
                                        u8 = nil;
                                    end;
                                    u9 = nil;
                                    u10 = 1;
                                end;
                            end;
                        else
                            if u8 then
                                u8:Destroy();
                                u8 = nil;
                            end;
                            u9 = nil;
                            u10 = 1;
                        end;
                    else
                        if u8 then
                            u8:Destroy();
                            u8 = nil;
                        end;
                        u9 = nil;
                        u10 = 1;
                    end;
                end;
            else
                if u8 then
                    u8:Destroy();
                    u8 = nil;
                end;
                u9 = nil;
                u10 = 1;
            end;
        end;
    end);
end;
return v1;