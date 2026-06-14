-- Decompiled with Potassium's decompiler.

local u1 = {};
local l__Players__1 = game:GetService("Players");
local l__RunService__2 = game:GetService("RunService");
local l__SoundService__3 = game:GetService("SoundService");
local l__Networking__4 = require(game.ReplicatedStorage.SharedModules.Networking);
local l__SeedPackSpawnServerLocations__5 = game.Workspace.Map.SeedPackSpawnServerLocations;
local l__SeedPackSpawnClient__6 = game.Workspace.Map.SeedPackSpawnClient;
local l__SeedPacks__7 = game.ReplicatedStorage.Assets.SeedPacks;
local l__Seeds__8 = game.ReplicatedStorage.Assets.Seeds;
local l__PopVFX__9 = game.ReplicatedStorage.Assets.PopVFX;
local l__NotificationController__10 = require(l__Players__1.LocalPlayer.PlayerScripts.Controllers.NotificationController);
local u2 = {};
local u3 = {};
local u4 = nil;
local function u10(p5) --[[ Line: 60 ]]
    local v6 = os.clock() + 1;
    while p5.Parent do
        local v7 = p5:GetAttribute("SeedPack");
        local v8 = p5:GetAttribute("RainbowSeed") == true;
        local v9 = p5:GetAttribute("GoldSeed") == true;
        if v7 ~= nil or (v8 or v9) then
            if type(v7) ~= "string" then
                v7 = nil;
            end;
            return v7, v8, v9;
        end;
        if v6 <= os.clock() then
            break;
        end;
        p5:GetAttributeChangedSignal("SeedPack"):Wait();
    end;
    return nil, false, false;
end;
function u1.SpawnClient(_, u11, u12) --[[ Line: 75 ]]
    -- upvalues: u10 (copy), l__Seeds__8 (copy), l__SeedPacks__7 (copy), l__SeedPackSpawnClient__6 (copy), u3 (copy), u2 (copy), u1 (copy), u4 (ref), l__RunService__2 (copy), l__NotificationController__10 (copy)
    task.spawn(function() --[[ Line: 76 ]]
        -- upvalues: u11 (copy), u12 (ref), u10 (ref), l__Seeds__8 (ref), l__SeedPacks__7 (ref), l__SeedPackSpawnClient__6 (ref), u3 (ref), u2 (ref), u1 (ref), u4 (ref), l__RunService__2 (ref), l__NotificationController__10 (ref)
        if not u11.Parent then
            return;
        end;
        local v13 = u11:GetAttribute("RainbowSeed") == true;
        local v14 = u11:GetAttribute("GoldSeed") == true;
        if not v13 and (not v14 and (u12 == nil or u12 == "")) then
            local v15;
            v15, v13, v14 = u10(u11);
            u12 = v15;
        end;
        if not u11.Parent then
            return;
        end;
        local v16 = nil;
        local v17 = nil;
        local v18 = nil;
        if v13 then
            v16 = l__Seeds__8:FindFirstChild("Rainbow");
            v17 = 5;
            v18 = "Rainbow Seed";
        elseif v14 then
            v16 = l__Seeds__8:FindFirstChild("Gold");
            v17 = 5;
            v18 = "Gold Seed";
        elseif type(u12) == "string" and u12 ~= "" then
            v16 = l__SeedPacks__7:FindFirstChild(u12);
            v18 = u12;
            v17 = 3;
        end;
        if not v16 then
            return;
        end;
        local v19 = Instance.new("Part");
        v19.Anchored = true;
        v19.CanCollide = false;
        v19.Size = Vector3.new(1, 1, 1);
        v19.Transparency = 1;
        v19.CFrame = u11.CFrame;
        v19.Parent = l__SeedPackSpawnClient__6;
        local v20 = v16:Clone();
        local u21;
        if v20:IsA("BasePart") then
            u21 = Instance.new("Model");
            v20.Anchored = false;
            v20.Parent = u21;
            u21.PrimaryPart = v20;
            u21.Parent = l__SeedPackSpawnClient__6;
            v20.Size = v20.Size * v17;
        else
            u21 = v20;
            u21.Parent = l__SeedPackSpawnClient__6;
            if not u21.PrimaryPart then
                for _, v22 in u21:GetDescendants() do
                    if v22:IsA("BasePart") then
                        u21.PrimaryPart = v22;
                        break;
                    end;
                end;
            end;
            if not u21.PrimaryPart then
                v19:Destroy();
                u21:Destroy();
                return;
            end;
            u21:ScaleTo(v17);
        end;
        local _, v23 = u21:GetBoundingBox();
        u3[v19] = u11.CFrame * CFrame.new(0, -u11.Size.Y / 2, 0) * CFrame.new(0, v23.Y / 2 + 1, 0);
        local v24 = Instance.new("Attachment");
        v24.Parent = u21.PrimaryPart;
        local v25 = Instance.new("Attachment");
        v25.Parent = v19;
        local v26 = Instance.new("AlignPosition");
        v26.Attachment0 = v24;
        v26.Attachment1 = v25;
        v26.RigidityEnabled = true;
        v26.Parent = u21.PrimaryPart;
        local v27 = Instance.new("AlignOrientation");
        v27.Attachment0 = v24;
        v27.Attachment1 = v25;
        v27.RigidityEnabled = true;
        v27.Parent = u21.PrimaryPart;
        table.insert(u2, { u11, u21, v19 });
        local u28 = nil;
        u28 = u11.Destroying:Connect(function() --[[ Line: 172 ]]
            -- upvalues: u1 (ref), u11 (ref), u21 (ref), u28 (ref)
            u1:DespawnClient(u11, u21);
            u28:Disconnect();
        end);
        if not u4 then
            u4 = l__RunService__2.Heartbeat:Connect(function() --[[ Line: 36 ]]
                -- upvalues: u2 (ref), u3 (ref)
                local v29 = os.clock();
                local v30 = math.sin(v29 * 2) * 0.5;
                local v31 = CFrame.Angles(0, v29 * 1.5, 0);
                for _, v32 in u2 do
                    local v33 = u3[v32[3]];
                    if v33 and v32[3].Parent then
                        v32[3].CFrame = v33 * v31 + Vector3.new(0, v30, 0);
                    end;
                end;
            end);
        end;
        if v18 then
            l__NotificationController__10:CreateSeedPackSpawnNotification(v18);
        end;
    end);
end;
function u1.DespawnClient(_, p34, _) --[[ Line: 186 ]]
    -- upvalues: u2 (copy), u3 (copy), u4 (ref)
    for _, v35 in pairs(u2) do
        if v35[1] == p34 then
            local v36 = table.find(u2, v35);
            if v35[3] then
                u3[v35[3]] = nil;
                v35[3]:Destroy();
                v35[3] = nil;
            end;
            if v35[2] then
                v35[2]:Destroy();
                v35[2] = nil;
            end;
            if v36 then
                table.remove(u2, v36);
            end;
            break;
        end;
    end;
    if #u2 == 0 and u4 then
        u4:Disconnect();
        u4 = nil;
    end;
end;
function u1.Start(_) --[[ Line: 210 ]] end;
function u1.Init(_) --[[ Line: 214 ]]
    -- upvalues: l__SeedPackSpawnServerLocations__5 (copy), u1 (copy), l__Networking__4 (copy), l__PopVFX__9 (copy), l__SoundService__3 (copy)
    for _, v37 in pairs(l__SeedPackSpawnServerLocations__5:GetChildren()) do
        u1:SpawnClient(v37, v37:GetAttribute("SeedPack"));
    end;
    l__SeedPackSpawnServerLocations__5.ChildAdded:Connect(function(p38) --[[ Line: 218 ]]
        -- upvalues: u1 (ref)
        u1:SpawnClient(p38, p38:GetAttribute("SeedPack"));
    end);
    l__Networking__4.SeedPackSpawn.FX.OnClientEvent:Connect(function(p39) --[[ Line: 221 ]]
        -- upvalues: l__PopVFX__9 (ref), l__SoundService__3 (ref)
        local u40 = l__PopVFX__9:Clone();
        u40.Position = p39;
        u40.Parent = game.Workspace;
        local u41 = Instance.new("Sound");
        u41.SoundId = "rbxassetid://70730950826307";
        u41.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
        u41.SoundGroup = l__SoundService__3:FindFirstChild("SFXGroup");
        u41.Parent = u40;
        task.defer(function() --[[ Line: 232 ]]
            -- upvalues: u40 (copy), u41 (copy)
            for _, v42 in pairs(u40.PopEffect:GetChildren()) do
                v42:Emit(v42:GetAttribute("EmitCount"));
            end;
            u41:Play();
            game.Debris:AddItem(u40, 3);
        end);
    end);
end;
return u1;