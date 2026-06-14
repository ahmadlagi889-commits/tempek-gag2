-- Decompiled with Potassium's decompiler.

local l__CollectionService__1 = game:GetService("CollectionService");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__TweenService__3 = game:GetService("TweenService");
local l__RunService__4 = game:GetService("RunService");
local l__Players__5 = game:GetService("Players");
local l__Debris__6 = game:GetService("Debris");
local l__LocalPlayer__7 = l__Players__5.LocalPlayer;
local l__Networking__8 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__Signal__9 = require(l__ReplicatedStorage__2.ClientModules.Signal);
local l__FieldOfViewController__10 = require(script.Parent.FieldOfViewController);
local l__ImpactTouch__11 = game.SoundService.SFX.ImpactTouch;
l__Signal__9.new();
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = false;
local u6 = nil;
local u7 = nil;
local u8 = 0;
local u9 = 0;
local u10 = 0;
local u11 = nil;
local u12 = OverlapParams.new();
u12.FilterType = Enum.RaycastFilterType.Include;
u12.FilterDescendantsInstances = {};
local function u15() --[[ Line: 49 ]]
    -- upvalues: l__Players__5 (copy), u12 (copy)
    local v13 = {};
    for _, v14 in l__Players__5:GetPlayers() do
        if v14.Character then
            table.insert(v13, v14.Character);
        end;
    end;
    u12.FilterDescendantsInstances = v13;
end;
l__Players__5.PlayerAdded:Connect(u15);
l__Players__5.PlayerRemoving:Connect(u15);
task.spawn(function() --[[ Line: 62 ]]
    -- upvalues: u15 (copy)
    while true do
        u15();
        task.wait(5);
    end;
end);
function u1.GetPlantFromFruit(_, p16) --[[ Line: 69 ]]
    local l__Parent__12 = p16.Parent;
    if l__Parent__12 and (not l__Parent__12 or l__Parent__12.Name == "Fruits") then
        return l__Parent__12.Parent;
    end;
end;
function u1.UpdateAppearance(_, p17, p18) --[[ Line: 76 ]]
    -- upvalues: l__TweenService__3 (copy), l__ReplicatedStorage__2 (copy), l__CollectionService__1 (copy)
    if p18 then
        local function v21(p19) --[[ Line: 81 ]]
            -- upvalues: l__TweenService__3 (ref)
            if p19:HasTag("PoisonIvySwell") then
                return false;
            end;
            p19:AddTag("PoisonIvySwell");
            if not p19:GetAttribute("originalSize") then
                p19:SetAttribute("originalSize", p19.Size);
            end;
            if not p19:GetAttribute("originalColor") then
                p19:SetAttribute("originalColor", p19.Color);
            end;
            local v20 = Random.new():NextNumber(1.1, 1.3);
            l__TweenService__3:Create(p19, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = p19.Size * v20,
                Color = Color3.new(0.737255, 0.184314, 0.184314)
            }):Play();
            return true;
        end;
        local v22 = {};
        local v23 = 0;
        for _, v24 in p17:GetChildren() do
            if v24:IsA("Part") and (not v24:IsA("Part") or v24.Transparency == 0) then
                table.insert(v22, v24);
                local v25 = Instance.new("Part");
                v25.Parent = p17;
                v25.Shape = Enum.PartType.Ball;
                v25.Size = Vector3.new(0.01, 0.01, 0.01);
                local l__Position__13 = v24.Position;
                local v26 = v24.Size.X / 2.5;
                local v27 = Random.new();
                v25.Position = l__Position__13 + Vector3.new(v26, 0, v27:NextNumber(-v24.Size.Z / 2.5, v24.Size.Z / 2.5));
                v25.Color = Color3.fromRGB(255, 17, 21);
                v25.Anchored = false;
                v25.CanCollide = false;
                v25.CanQuery = false;
                l__TweenService__3:Create(v25, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = Vector3.new(1, 1, 1) * Random.new():NextNumber(0.35, 0.75)
                }):Play();
                local v28 = Instance.new("WeldConstraint");
                v28.Parent = v25;
                v28.Part0 = v25;
                v28.Part1 = v24;
                v25:AddTag("PoisonIvyAppearance");
                if math.random(1, 3) == 1 and v21(v24) then
                    v23 = v23 + 1;
                end;
            end;
        end;
        if v23 == 0 and #v22 > 0 then
            v21(v22[math.random(1, #v22)]);
        end;
        local v29 = l__ReplicatedStorage__2.Assets.VFX.StatusVFX:FindFirstChild("PoisonIvyVFX");
        if v29 == nil then
        else
            for _, v30 in v29:GetChildren() do
                local v31 = v30:Clone();
                v31.Parent = p17:FindFirstChild("Torso") or p17.PrimaryPart;
                v31.Enabled = true;
                v31:AddTag("PoisonIvyAppearance");
            end;
        end;
    else
        for _, v32 in l__CollectionService__1:GetTagged("PoisonIvyAppearance") do
            if v32:IsDescendantOf(p17) then
                v32:RemoveTag("PoisonIvyAppearance");
                if v32:IsA("ParticleEmitter") then
                    v32.Enabled = false;
                    game.Debris:AddItem(v32, 1);
                elseif v32:IsA("BasePart") then
                    l__TweenService__3:Create(v32, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Size = Vector3.new(0.01, 0.01, 0.01)
                    }):Play();
                    game.Debris:AddItem(v32, 0.15);
                end;
            end;
        end;
        for _, v33 in l__CollectionService__1:GetTagged("PoisonIvySwell") do
            if v33:IsDescendantOf(p17) then
                v33:RemoveTag("PoisonIvySwell");
                if v33:GetAttribute("originalSize") and v33:GetAttribute("originalColor") then
                    l__TweenService__3:Create(v33, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                        Size = v33:GetAttribute("originalSize"),
                        Color = v33:GetAttribute("originalColor")
                    }):Play();
                end;
            end;
        end;
    end;
end;
function u1.StartLocalPlayerEffects(_) --[[ Line: 189 ]]
    -- upvalues: u5 (ref), u8 (ref), u9 (ref), u11 (ref), l__LocalPlayer__7 (copy), u7 (ref), u6 (ref), l__RunService__4 (copy), u10 (ref), l__FieldOfViewController__10 (copy)
    if u5 then
    else
        u5 = true;
        u8 = tick();
        u9 = 0;
        u11 = nil;
        local v34 = l__LocalPlayer__7:FindFirstChildOfClass("PlayerGui");
        if v34 then
            u7 = Instance.new("ScreenGui");
            u7.Name = "PoisonIvyScreenEffect";
            u7.IgnoreGuiInset = true;
            u7.ResetOnSpawn = false;
            u7.DisplayOrder = 1000;
            u7.Parent = v34;
            local u35 = Instance.new("Frame");
            u35.Name = "RedFlash";
            u35.Size = UDim2.fromScale(1, 1);
            u35.BackgroundColor3 = Color3.fromRGB(255, 55, 55);
            u35.BackgroundTransparency = 1;
            u35.BorderSizePixel = 0;
            u35.ZIndex = 10;
            u35.Parent = u7;
            u6 = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 217 ]]
                -- upvalues: u8 (ref), l__LocalPlayer__7 (ref), u7 (ref), u35 (copy), u10 (ref), l__FieldOfViewController__10 (ref), u9 (ref)
                local v36 = tick() - u8;
                local l__Character__14 = l__LocalPlayer__7.Character;
                if l__Character__14 then
                    l__Character__14 = l__Character__14:FindFirstChildOfClass("Humanoid");
                end;
                if l__Character__14 then
                    local v37 = math.sin(v36 * 4) * 0.3 + math.sin(v36 * 7.3) * 0.1;
                    local v38 = math.cos(v36 * 5.2) * 0.3 + math.sin(v36 * 9.1) * 0.08;
                    l__Character__14.CameraOffset = Vector3.new(v37, v38, 0);
                end;
                if u7 and u35.Parent then
                    local v39 = math.sin(v36 * 2.5);
                    u35.BackgroundTransparency = 0.95 - math.max(0, v39) ^ 3 * 0.28;
                end;
                local v40 = math.sin(v36 * 1.8) * 15 + -35;
                u10 = v40;
                l__FieldOfViewController__10:SetAdjuster(v40, false);
                if l__Character__14 and (l__Character__14.Health > 0 and v36 - u9 >= 1) then
                    u9 = v36;
                    l__Character__14:TakeDamage(1);
                end;
            end);
        end;
    end;
end;
function u1.StopLocalPlayerEffects(_) --[[ Line: 253 ]]
    -- upvalues: u5 (ref), u6 (ref), l__LocalPlayer__7 (copy), l__TweenService__3 (copy), u11 (ref), u10 (ref), l__FieldOfViewController__10 (copy), u7 (ref), l__Debris__6 (copy)
    if u5 then
        u5 = false;
        if u6 then
            u6:Disconnect();
            u6 = nil;
        end;
        local l__Character__15 = l__LocalPlayer__7.Character;
        local v41 = l__Character__15 and l__Character__15:FindFirstChildOfClass("Humanoid");
        if v41 then
            l__TweenService__3:Create(v41, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CameraOffset = Vector3.new(0, 0, 0)
            }):Play();
        end;
        local u42 = {};
        u11 = u42;
        local u43 = u10;
        task.spawn(function() --[[ Line: 279 ]]
            -- upvalues: u11 (ref), u42 (copy), l__FieldOfViewController__10 (ref), u43 (copy), u10 (ref)
            local v44 = tick();
            while u11 == u42 do
                local v45 = (tick() - v44) / 0.5;
                local v46 = math.min(v45, 1);
                l__FieldOfViewController__10:SetAdjuster(u43 * (1 - (1 - (1 - v46) ^ 3)), false);
                if v46 >= 1 then
                    l__FieldOfViewController__10:SetAdjuster(0, false);
                    u11 = nil;
                    u10 = 0;
                    return;
                end;
                task.wait();
            end;
        end);
        if u7 then
            local u47 = u7;
            u7 = nil;
            local v48 = u47:FindFirstChild("RedFlash");
            if v48 then
                local v49 = TweenInfo.new(0.5);
                local v50 = l__TweenService__3:Create(v48, v49, {
                    BackgroundTransparency = 1
                });
                v50:Play();
                l__Debris__6:AddItem(v50, v49.Time);
                v50.Completed:Connect(function() --[[ Line: 315 ]]
                    -- upvalues: u47 (copy)
                    u47:Destroy();
                end);
                return;
            end;
            u47:Destroy();
        end;
    end;
end;
function u1.ScheduleAppearanceRemoval(_, u51) --[[ Line: 324 ]]
    -- upvalues: u4 (copy), u1 (copy), l__LocalPlayer__7 (copy)
    if u51.Character then
        local u52 = {};
        u4[u51] = u52;
        local v53 = Random.new():NextNumber(7, 11);
        task.delay(v53, function() --[[ Line: 334 ]]
            -- upvalues: u4 (ref), u51 (copy), u52 (copy), u1 (ref), l__LocalPlayer__7 (ref)
            if u4[u51] == u52 then
                u4[u51] = nil;
                if u51.Character then
                    u1:UpdateAppearance(u51.Character, false);
                end;
                if u51 == l__LocalPlayer__7 then
                    u1:StopLocalPlayerEffects();
                end;
            end;
        end);
    end;
end;
function u1.RegisterPoisonObject(_, p54) --[[ Line: 351 ]]
    -- upvalues: u2 (copy)
    table.insert(u2, {
        Object = p54
    });
end;
function u1.UnregisterPoisonObject(_, p55) --[[ Line: 357 ]]
    -- upvalues: u2 (copy)
    for v56, v57 in u2 do
        if v57.Object == p55 then
            table.remove(u2, v56);
            return;
        end;
    end;
end;
function u1.GetTouchingParts(_, p58) --[[ Line: 366 ]]
    -- upvalues: l__Players__5 (copy), u12 (copy), u1 (copy), l__LocalPlayer__7 (copy), u3 (copy), u4 (copy), l__ImpactTouch__11 (copy), l__Networking__8 (copy)
    local l__Position__16 = p58.Position;
    local v59 = false;
    for _, v60 in l__Players__5:GetPlayers() do
        local l__Character__17 = v60.Character;
        if l__Character__17 then
            l__Character__17 = l__Character__17:FindFirstChild("HumanoidRootPart");
        end;
        if l__Character__17 and (l__Character__17.Position - l__Position__16).Magnitude < 30 then
            v59 = true;
            break;
        end;
    end;
    if v59 then
        local v61 = workspace:GetPartsInPart(p58, u12);
        if #v61 ~= 0 then
            local v62 = {};
            for _, v63 in v61 do
                if v63.Parent then
                    local v64 = v63:FindFirstAncestorWhichIsA("Model");
                    local v65;
                    if v64 then
                        v65 = l__Players__5:GetPlayerFromCharacter(v64);
                    else
                        v65 = nil;
                    end;
                    if v65 then
                        local v66 = u1:GetPlantFromFruit(p58.Parent);
                        if v66 then
                            local v67 = v66:GetAttribute("UserId");
                            if v67 and (not v67 or v67 ~= l__LocalPlayer__7.UserId) then
                                table.insert(v62, v65);
                                if not table.find(u3, v65) then
                                    local v68 = u4[v65] ~= nil;
                                    u4[v65] = nil;
                                    table.insert(u3, v65);
                                    if not v68 then
                                        u1:UpdateAppearance(v65.Character, true);
                                    end;
                                    if v65 == l__LocalPlayer__7 then
                                        u1:StartLocalPlayerEffects();
                                    end;
                                    l__ImpactTouch__11.PlaybackSpeed = 1 + math.random(-15, 15) / 100;
                                    l__ImpactTouch__11.TimePosition = 0;
                                    l__ImpactTouch__11.Playing = true;
                                    local v69;
                                    if p58.Parent then
                                        v69 = p58.Parent:GetAttribute("FruitId") or nil;
                                    else
                                        v69 = nil;
                                    end;
                                    if v69 then
                                        l__Networking__8.PoisonIvyService.TouchBegan:Fire(v65.Character, v69);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            return v62;
        end;
    end;
end;
function u1.Routine(_) --[[ Line: 429 ]]
    -- upvalues: u2 (copy), u1 (copy), l__Players__5 (copy), u3 (copy), l__Networking__8 (copy)
    local v70 = {};
    for _, v71 in u2 do
        local v72 = u1:GetTouchingParts(v71.Object);
        if v72 and (not v72 or #v72 ~= 0) then
            table.move(v72, 1, #v72, #v70 + 1, v70);
        end;
    end;
    for _, v73 in l__Players__5:GetPlayers() do
        if not table.find(v70, v73) then
            local v74 = table.find(u3, v73);
            if v74 then
                table.remove(u3, v74);
                u1:ScheduleAppearanceRemoval(v73);
                l__Networking__8.PoisonIvyService.TouchEnded:Fire(v73.Character);
            end;
        end;
    end;
end;
function u1.Init(_) --[[ Line: 453 ]]
    -- upvalues: l__CollectionService__1 (copy), u1 (copy)
    for _, v75 in l__CollectionService__1:GetTagged("PoisonIvy") do
        u1:RegisterPoisonObject(v75);
    end;
    l__CollectionService__1:GetInstanceAddedSignal("PoisonIvy"):Connect(function(p76) --[[ Line: 458 ]]
        -- upvalues: u1 (ref)
        u1:RegisterPoisonObject(p76);
    end);
    l__CollectionService__1:GetInstanceRemovedSignal("PoisonIvy"):Connect(function(p77) --[[ Line: 462 ]]
        -- upvalues: u1 (ref)
        u1:UnregisterPoisonObject(p77);
    end);
    task.spawn(function() --[[ Line: 466 ]]
        -- upvalues: u1 (ref)
        while true do
            u1:Routine();
            task.wait(0.5);
        end;
    end);
end;
return u1;