-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__TweenService__4 = game:GetService("TweenService");
local l__Debris__5 = game:GetService("Debris");
local l__ReplicatedStorage__6 = game:GetService("ReplicatedStorage");
local l__Networking__7 = require(l__ReplicatedStorage__6.SharedModules.Networking);
local l__LocalPlayer__8 = l__Players__1.LocalPlayer;
local l__CurrentCamera__9 = workspace.CurrentCamera;
local l__Gardens__10 = workspace:WaitForChild("Gardens");
local u2 = 0;
local u3 = false;
local u4 = 0;
local u5 = {};
local l__Assets__11 = l__ReplicatedStorage__6.Assets;
local l__Dirt__12 = l__Assets__11.Dirt;
local l__Seeds__13 = l__Assets__11.Seeds;
local l__PlantSFX__14 = game.SoundService.SFX.PlantSFX;
local l__Temporary__15 = workspace.Temporary;
local u6 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u7 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u8 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u9 = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local u10 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local u11 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u12 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local u13 = TweenInfo.new(0.12, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out);
local u14 = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u15 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u16 = {
    Color3.fromRGB(101, 67, 33),
    Color3.fromRGB(92, 60, 28),
    Color3.fromRGB(110, 75, 40),
    Color3.fromRGB(85, 55, 25)
};
function v1.Init(_) --[[ Line: 55 ]] end;
function v1.Start(u17) --[[ Line: 58 ]]
    -- upvalues: l__UserInputService__2 (copy), l__CurrentCamera__9 (copy), l__Networking__7 (copy), l__LocalPlayer__8 (copy)
    l__UserInputService__2.InputEnded:Connect(function(p18, _) --[[ Line: 59 ]]
        -- upvalues: u17 (copy)
        u17:OnInputEnded(p18);
    end);
    l__UserInputService__2.TouchTapInWorld:Connect(function(p19, p20) --[[ Line: 66 ]]
        -- upvalues: u17 (copy), l__CurrentCamera__9 (ref)
        if p20 then
        elseif u17:IsTouchInput() then
            local v21 = u17:GetEquippedTool();
            if v21 and v21:GetAttribute("SeedTool") ~= nil then
                u17:TryPlantWithRay((l__CurrentCamera__9:ViewportPointToRay(p19.X, p19.Y)));
            end;
        end;
    end);
    l__Networking__7.Plant.PlantFx.OnClientEvent:Connect(function(p22, p23) --[[ Line: 77 ]]
        -- upvalues: u17 (copy)
        u17:PlayPlantFx(p22, p23);
    end);
    u17:WatchBackpack();
    if l__LocalPlayer__8.Character then
        u17:WatchCharacter(l__LocalPlayer__8.Character);
    end;
    l__LocalPlayer__8.CharacterAdded:Connect(function(p24) --[[ Line: 85 ]]
        -- upvalues: u17 (copy)
        u17:WatchCharacter(p24);
    end);
end;
function v1.IsTouchInput(_) --[[ Line: 90 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local l__TouchEnabled__16 = l__UserInputService__2.TouchEnabled;
    if l__TouchEnabled__16 then
        l__TouchEnabled__16 = not l__UserInputService__2.MouseEnabled;
    end;
    return l__TouchEnabled__16;
end;
function v1.WatchBackpack(u25) --[[ Line: 94 ]]
    -- upvalues: l__LocalPlayer__8 (copy)
    local function u29(p26) --[[ Line: 95 ]]
        -- upvalues: u25 (copy)
        for _, v27 in p26:GetChildren() do
            if v27:IsA("Tool") then
                u25:TrySetupSeedTool(v27);
            end;
        end;
        p26.ChildAdded:Connect(function(p28) --[[ Line: 101 ]]
            -- upvalues: u25 (ref)
            if p28:IsA("Tool") then
                u25:TrySetupSeedTool(p28);
            end;
        end);
    end;
    local v30 = l__LocalPlayer__8:FindFirstChildOfClass("Backpack");
    if v30 then
        u29(v30);
    end;
    l__LocalPlayer__8.ChildAdded:Connect(function(p31) --[[ Line: 110 ]]
        -- upvalues: u29 (copy)
        if p31:IsA("Backpack") then
            u29(p31);
        end;
    end);
end;
function v1.WatchCharacter(u32, p33) --[[ Line: 117 ]]
    for _, v34 in p33:GetChildren() do
        if v34:IsA("Tool") then
            u32:TrySetupSeedTool(v34);
        end;
    end;
    p33.ChildAdded:Connect(function(p35) --[[ Line: 123 ]]
        -- upvalues: u32 (copy)
        if p35:IsA("Tool") then
            u32:TrySetupSeedTool(p35);
        end;
    end);
end;
function v1.TrySetupSeedTool(p36, p37) --[[ Line: 130 ]]
    -- upvalues: u5 (copy)
    if u5[p37] then
    else
        p36:SetupSeedTool(p37);
    end;
end;
function v1.SetupSeedTool(u38, u39) --[[ Line: 135 ]]
    -- upvalues: u5 (copy), u3 (ref)
    if u5[u39] then
    else
        local v40 = {};
        table.insert(v40, u39.Activated:Connect(function() --[[ Line: 140 ]]
            -- upvalues: u39 (copy), u38 (copy)
            if u39:GetAttribute("SeedTool") == nil then
            else
                u38:OnPlantTriggered();
            end;
        end));
        table.insert(v40, u39.Deactivated:Connect(function() --[[ Line: 145 ]]
            -- upvalues: u3 (ref)
            u3 = false;
        end));
        table.insert(v40, u39.AncestryChanged:Connect(function() --[[ Line: 149 ]]
            -- upvalues: u39 (copy), u38 (copy)
            if not u39:IsDescendantOf(game) then
                u38:CleanupSeedTool(u39);
            end;
        end));
        table.insert(v40, u39.Destroying:Connect(function() --[[ Line: 155 ]]
            -- upvalues: u38 (copy), u39 (copy)
            u38:CleanupSeedTool(u39);
        end));
        u5[u39] = v40;
    end;
end;
function v1.CleanupSeedTool(_, p41) --[[ Line: 162 ]]
    -- upvalues: u5 (copy)
    local v42 = u5[p41];
    if v42 then
        for _, v43 in v42 do
            v43:Disconnect();
        end;
        u5[p41] = nil;
    end;
end;
function v1.GetPlayerPlot(_) --[[ Line: 169 ]]
    -- upvalues: l__LocalPlayer__8 (copy), l__Gardens__10 (copy)
    local v44 = l__LocalPlayer__8:GetAttribute("PlotId");
    if v44 then
        return l__Gardens__10:FindFirstChild("Plot" .. v44);
    else
        return nil;
    end;
end;
function v1.GetEquippedTool(_) --[[ Line: 175 ]]
    -- upvalues: l__LocalPlayer__8 (copy)
    local l__Character__17 = l__LocalPlayer__8.Character;
    if l__Character__17 then
        return l__Character__17:FindFirstChildWhichIsA("Tool");
    else
        return nil;
    end;
end;
function v1.CreatePlantAreaParams(_) --[[ Line: 181 ]]
    -- upvalues: l__CollectionService__3 (copy)
    local v45 = RaycastParams.new();
    v45.FilterType = Enum.RaycastFilterType.Include;
    v45.FilterDescendantsInstances = l__CollectionService__3:GetTagged("PlantArea");
    return v45;
end;
function v1.CreatePlantsParams(_) --[[ Line: 188 ]]
    local v46 = RaycastParams.new();
    v46.FilterType = Enum.RaycastFilterType.Include;
    local v47 = {};
    for _, v48 in workspace.Gardens:GetChildren() do
        local v49 = v48:FindFirstChild("Plants");
        if v49 then
            table.insert(v47, v49);
        end;
    end;
    v46.FilterDescendantsInstances = v47;
    return v46;
end;
function v1.TryPlantWithRay(p50, p51) --[[ Line: 202 ]]
    -- upvalues: u2 (ref), l__Networking__7 (copy)
    local v52 = os.clock();
    if v52 - u2 < 0.05 then
        return false;
    end;
    local v53 = p50:GetEquippedTool();
    if not v53 then
        return false;
    end;
    local v54 = v53:GetAttribute("SeedTool");
    if not v54 then
        return false;
    end;
    local v55 = p50:GetPlayerPlot();
    if not v55 then
        return false;
    end;
    local v56 = p50:CreatePlantAreaParams();
    local v57 = nil;
    for _ = 1, 5 do
        v57 = workspace:Raycast(p51.Origin, p51.Direction * 5000, v56);
        if not v57 then
            break;
        end;
        local l__Instance__18 = v57.Instance;
        if l__Instance__18.Transparency < 1 then
            break;
        end;
        local l__FilterDescendantsInstances__19 = v56.FilterDescendantsInstances;
        local v58 = table.find(l__FilterDescendantsInstances__19, l__Instance__18);
        if not v58 then
            break;
        end;
        table.remove(l__FilterDescendantsInstances__19, v58);
        v56.FilterDescendantsInstances = l__FilterDescendantsInstances__19;
    end;
    if not v57 then
        return false;
    end;
    if not v57.Instance:IsDescendantOf(v55) then
        return false;
    end;
    local v59 = workspace:Raycast(p51.Origin, p51.Direction * 5000, p50:CreatePlantsParams());
    if v59 then
        local l__Position__20 = v57.Position;
        local l__Position__21 = v59.Position;
        if (Vector2.new(l__Position__21.X, l__Position__21.Z) - Vector2.new(l__Position__20.X, l__Position__20.Z)).Magnitude < 1 then
            return false;
        end;
    end;
    u2 = v52;
    l__Networking__7.Plant.PlantSeed:Fire(v57.Position, v54, v53);
    return true;
end;
function v1.OnPlantTriggered(u60) --[[ Line: 247 ]]
    -- upvalues: u3 (ref), l__UserInputService__2 (copy), l__CurrentCamera__9 (copy), u4 (ref)
    if u60:IsTouchInput() then
    elseif u3 then
    else
        local v61 = l__UserInputService__2:GetMouseLocation();
        u60:TryPlantWithRay((l__CurrentCamera__9:ViewportPointToRay(v61.X, v61.Y)));
        u3 = true;
        u4 = os.clock();
        task.spawn(function() --[[ Line: 260 ]]
            -- upvalues: u3 (ref), u4 (ref), l__UserInputService__2 (ref), l__CurrentCamera__9 (ref), u60 (copy)
            while u3 and os.clock() - u4 < 1 do
                task.wait(0.05);
            end;
            while u3 do
                local v62 = l__UserInputService__2:GetMouseLocation();
                u60:TryPlantWithRay((l__CurrentCamera__9:ViewportPointToRay(v62.X, v62.Y)));
                task.wait(0.4);
            end;
        end);
    end;
end;
function v1.OnInputEnded(_, p63) --[[ Line: 275 ]]
    -- upvalues: u3 (ref)
    if p63.UserInputType == Enum.UserInputType.MouseButton1 or (p63.UserInputType == Enum.UserInputType.Touch or p63.KeyCode == Enum.KeyCode.ButtonR2) then
        u3 = false;
    end;
end;
function v1.SetPartsTransparency(_, p64, p65) --[[ Line: 283 ]]
    if p64:IsA("BasePart") then
        p64.Transparency = p65;
    end;
    for _, v66 in p64:GetDescendants() do
        if v66:IsA("BasePart") then
            v66.Transparency = p65;
        end;
    end;
end;
function v1.CreateDirtChunk(_, p67) --[[ Line: 295 ]]
    -- upvalues: u16 (copy), l__Temporary__15 (copy), l__TweenService__4 (copy), u12 (copy), u13 (copy), u14 (copy), u15 (copy), l__Debris__5 (copy)
    local u68 = Instance.new("Part");
    local u69 = math.random(25, 45) / 100;
    u68.Size = Vector3.new(u69, u69 * 0.7, u69);
    u68.Color = u16[math.random(1, #u16)];
    u68.Material = Enum.Material.SmoothPlastic;
    u68.Anchored = true;
    u68.CanCollide = false;
    u68.CastShadow = false;
    u68.Transparency = 0;
    u68.Position = p67 + Vector3.new(0, 0.05, 0);
    local v70 = math.random(-30, 30);
    local v71 = math.random(-180, 180);
    u68.Orientation = Vector3.new(v70, v71, math.random(-30, 30));
    u68.Parent = l__Temporary__15;
    local v72 = math.random(0, 360);
    local v73 = math.rad(v72);
    local v74 = math.random(30, 60) / 100;
    local v75 = math.cos(v73) * v74;
    local v76 = math.sin(v73) * v74;
    local v77 = math.random(50, 90) / 100;
    local v78 = p67 + Vector3.new(v75 * 0.6, v77, v76 * 0.6);
    local u79 = p67 + Vector3.new(v75, 0.02, v76);
    local u80 = u79 + Vector3.new(0, -0.01, 0);
    local v81 = l__TweenService__4;
    local v82 = u12;
    local v83 = {
        Position = v78
    };
    local l__Orientation__22 = u68.Orientation;
    local v84 = math.random(-45, 45);
    local v85 = math.random(-90, 90);
    v83.Orientation = l__Orientation__22 + Vector3.new(v84, v85, math.random(-45, 45));
    local v86 = v81:Create(u68, v82, v83);
    v86:Play();
    v86.Completed:Connect(function() --[[ Line: 326 ]]
        -- upvalues: l__TweenService__4 (ref), u68 (copy), u13 (ref), u79 (copy), u69 (copy), u14 (ref), u80 (copy), u15 (ref), l__Debris__5 (ref)
        local v87 = l__TweenService__4:Create(u68, u13, {
            Position = u79,
            Size = Vector3.new(u69 * 1.1, u69 * 0.5, u69 * 1.1)
        });
        v87:Play();
        v87.Completed:Connect(function() --[[ Line: 333 ]]
            -- upvalues: l__TweenService__4 (ref), u68 (ref), u14 (ref), u80 (ref), u69 (ref), u15 (ref), l__Debris__5 (ref)
            local v88 = l__TweenService__4:Create(u68, u14, {
                Position = u80,
                Size = Vector3.new(u69, u69 * 0.65, u69)
            });
            v88:Play();
            v88.Completed:Connect(function() --[[ Line: 340 ]]
                -- upvalues: l__TweenService__4 (ref), u68 (ref), u15 (ref), l__Debris__5 (ref)
                task.delay(0.15, function() --[[ Line: 341 ]]
                    -- upvalues: l__TweenService__4 (ref), u68 (ref), u15 (ref), l__Debris__5 (ref)
                    l__TweenService__4:Create(u68, u15, {
                        Transparency = 1
                    }):Play();
                    l__Debris__5:AddItem(u68, u15.Time);
                end);
            end);
        end);
    end);
end;
function v1.PlaySfx(_) --[[ Line: 351 ]]
    -- upvalues: l__PlantSFX__14 (copy), l__Temporary__15 (copy)
    local u89 = l__PlantSFX__14:Clone();
    u89.PlaybackSpeed = 1 + math.random(-10, 10) / 100;
    u89.Parent = l__Temporary__15;
    u89:Play();
    u89.Ended:Connect(function() --[[ Line: 356 ]]
        -- upvalues: u89 (copy)
        u89:Destroy();
    end);
end;
function v1.SpawnDirtChunks(u90, u91) --[[ Line: 361 ]]
    for v92 = 1, math.random(6, 10) do
        task.delay(v92 * 0.015, function() --[[ Line: 364 ]]
            -- upvalues: u90 (copy), u91 (copy)
            u90:CreateDirtChunk(u91);
        end);
    end;
end;
function v1.CreateDirtDecal(_, p93) --[[ Line: 370 ]]
    -- upvalues: l__Dirt__12 (copy), l__Temporary__15 (copy), l__TweenService__4 (copy), u6 (copy), u7 (copy), l__Debris__5 (copy)
    local u94 = l__Dirt__12:Clone();
    u94.Position = p93 - Vector3.new(0, 0.01, 0);
    local l__X__23 = l__Dirt__12.Orientation.X;
    local v95 = math.random(-180, 180);
    u94.Orientation = Vector3.new(l__X__23, v95, l__Dirt__12.Orientation.Z);
    u94.Size = Vector3.new(0.1, 0.8, 0.8);
    u94.Transparency = 1;
    u94.Parent = l__Temporary__15;
    l__TweenService__4:Create(u94, u6, {
        Size = Vector3.new(0.1, 2, 2),
        Transparency = 0
    }):Play();
    task.delay(math.random(7, 11), function() --[[ Line: 381 ]]
        -- upvalues: l__TweenService__4 (ref), u94 (copy), u7 (ref), l__Debris__5 (ref)
        l__TweenService__4:Create(u94, u7, {
            Size = Vector3.new(0.1, 1.75, 1.75),
            Transparency = 1
        }):Play();
        l__Debris__5:AddItem(u94, u7.Time);
    end);
end;
function v1.CreateImpactRing(_, p96) --[[ Line: 388 ]]
    -- upvalues: l__Temporary__15 (copy), l__TweenService__4 (copy), l__Debris__5 (copy)
    local v97 = Instance.new("Part");
    v97.Shape = Enum.PartType.Cylinder;
    v97.Size = Vector3.new(0.05, 0.3, 0.3);
    v97.Color = Color3.fromRGB(139, 90, 43);
    v97.Material = Enum.Material.SmoothPlastic;
    v97.Anchored = true;
    v97.CanCollide = false;
    v97.CastShadow = false;
    v97.Transparency = 0.3;
    v97.Position = p96 + Vector3.new(0, 0.02, 0);
    v97.Orientation = Vector3.new(0, 0, 90);
    v97.Parent = l__Temporary__15;
    l__TweenService__4:Create(v97, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.05, 1.8, 1.8),
        Transparency = 1
    }):Play();
    l__Debris__5:AddItem(v97, 0.35);
end;
function v1.PlayPlantFx(u98, u99, p100) --[[ Line: 411 ]]
    -- upvalues: l__Seeds__13 (copy), l__Temporary__15 (copy), u8 (copy), l__TweenService__4 (copy), u9 (copy), u10 (copy), u11 (copy), l__Debris__5 (copy)
    local v101 = l__Seeds__13:FindFirstChild(p100);
    if v101 then
        local u102 = v101:Clone();
        local u103;
        if u102:IsA("BasePart") then
            u103 = u102;
        else
            u103 = u102.PrimaryPart;
        end;
        if u103 then
            u103.Anchored = true;
            u103.CanCollide = false;
            local l__Size__24 = u103.Size;
            local l__Orientation__25 = u103.Orientation;
            local v104 = CFrame.new(u99 + Vector3.new(0, 1.5, 0)) * CFrame.Angles(0, math.rad(l__Orientation__25.Y), 0);
            local v105 = CFrame.new(u99 + Vector3.new(0, 2, 0)) * CFrame.Angles(0, math.rad(l__Orientation__25.Y + 15), 0);
            local u106 = CFrame.new(u99 + Vector3.new(0, 0.15, 0)) * CFrame.Angles(0, math.rad(l__Orientation__25.Y + 60), 0);
            local u107 = CFrame.new(u99 + Vector3.new(0, 0.15 - l__Size__24.Y * 0.15, 0)) * CFrame.Angles(0, math.rad(l__Orientation__25.Y + 60), 0);
            local u108 = CFrame.new(u99 + Vector3.new(0, -0.1, 0)) * CFrame.Angles(0, math.rad(l__Orientation__25.Y + 60), 0);
            u103.CFrame = v104;
            u98:SetPartsTransparency(u102, 1);
            u102.Parent = l__Temporary__15;
            u98:TweenAllPartsTransparency(u102, u8, 0);
            local v109 = l__TweenService__4:Create(u103, u9, {
                CFrame = v105
            });
            v109:Play();
            v109.Completed:Once(function() --[[ Line: 451 ]]
                -- upvalues: l__TweenService__4 (ref), u103 (copy), u10 (ref), u106 (copy), u11 (ref), u107 (copy), l__Size__24 (copy), u108 (copy), u98 (copy), u102 (copy), u99 (copy), l__Debris__5 (ref)
                local v110 = l__TweenService__4:Create(u103, u10, {
                    CFrame = u106
                });
                v110:Play();
                v110.Completed:Once(function() --[[ Line: 457 ]]
                    -- upvalues: l__TweenService__4 (ref), u103 (ref), u11 (ref), u107 (ref), l__Size__24 (ref), u108 (ref), u98 (ref), u102 (ref), u99 (ref), l__Debris__5 (ref)
                    local v111 = l__TweenService__4:Create(u103, u11, {
                        CFrame = u107,
                        Size = Vector3.new(l__Size__24.X * 1.3, l__Size__24.Y * 0.6, l__Size__24.Z * 1.3)
                    });
                    v111:Play();
                    v111.Completed:Once(function() --[[ Line: 464 ]]
                        -- upvalues: l__TweenService__4 (ref), u103 (ref), u108 (ref), l__Size__24 (ref), u98 (ref), u102 (ref), u99 (ref), l__Debris__5 (ref)
                        local v112 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
                        l__TweenService__4:Create(u103, v112, {
                            CFrame = u108,
                            Size = l__Size__24 * 0.8
                        }):Play();
                        u98:TweenAllPartsTransparency(u102, v112, 1);
                        u98:PlaySfx();
                        u98:SpawnDirtChunks(u99);
                        u98:CreateDirtDecal(u99);
                        u98:CreateImpactRing(u99);
                        l__Debris__5:AddItem(u102, 0.2);
                    end);
                end);
            end);
        else
            u102:Destroy();
        end;
    else
        u98:PlaySfx();
        u98:SpawnDirtChunks(u99);
        u98:CreateDirtDecal(u99);
        u98:CreateImpactRing(u99);
    end;
end;
function v1.TweenAllPartsTransparency(_, p113, p114, p115) --[[ Line: 485 ]]
    -- upvalues: l__TweenService__4 (copy)
    if p113:IsA("BasePart") then
        l__TweenService__4:Create(p113, p114, {
            Transparency = p115
        }):Play();
    end;
    for _, v116 in p113:GetDescendants() do
        if v116:IsA("BasePart") then
            l__TweenService__4:Create(v116, p114, {
                Transparency = p115
            }):Play();
        end;
    end;
end;
return v1;