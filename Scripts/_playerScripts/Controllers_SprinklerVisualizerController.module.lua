-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 4
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__SoundService__4 = game:GetService("SoundService");
local l__TweenService__5 = game:GetService("TweenService");
local l__UserInputService__6 = game:GetService("UserInputService");
local l__GardenSyncController__7 = require(script.Parent.GardenSyncController);
local l__SprinklerData__8 = require(l__ReplicatedStorage__2.SharedModules.SprinklerData);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__CurrentCamera__10 = workspace.CurrentCamera;
local l__Gardens__11 = workspace:WaitForChild("Gardens");
local l__Temporary__12 = workspace:WaitForChild("Temporary");
local l__Assets__13 = l__ReplicatedStorage__2.Assets;
local l__Sprinklers__14 = l__Assets__13.Sprinklers;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = 0;
local u6 = nil;
local u7 = nil;
local u8 = nil;
function v1.Init(_) --[[ Line: 34 ]]
    -- upvalues: l__SprinklerData__8 (copy), u3 (copy)
    for _, v9 in l__SprinklerData__8 do
        u3[v9.SprinklerName] = v9;
    end;
end;
function v1.Start(u10) --[[ Line: 40 ]]
    -- upvalues: l__GardenSyncController__7 (copy), l__RunService__3 (copy)
    l__GardenSyncController__7:OnSprinklerAdded(function(p11, p12, p13) --[[ Line: 41 ]]
        -- upvalues: u10 (copy)
        u10:SpawnSprinklerFromData(p11, p12, p13);
    end);
    l__GardenSyncController__7:OnSprinklerRemoved(function(p14, p15) --[[ Line: 45 ]]
        -- upvalues: u10 (copy)
        u10:RemoveSprinklerById(p14, p15);
    end);
    l__RunService__3.Heartbeat:Connect(function(p16) --[[ Line: 49 ]]
        -- upvalues: u10 (copy)
        debug.profilebegin("Controllers/SprinklerVisualizerController/Heartbeat");
        u10:UpdateSprinklerTimers();
        u10:UpdateSprinklerSpins(p16);
        u10:UpdateHoverPreview();
        debug.profileend();
    end);
end;
function v1.GetPlayerPlot(_, p17) --[[ Line: 58 ]]
    -- upvalues: l__Players__1 (copy), l__Gardens__11 (copy)
    local v18 = l__Players__1:GetPlayerByUserId(p17);
    if v18 then
        local v19 = v18:GetAttribute("PlotId");
        if v19 then
            return l__Gardens__11:FindFirstChild("Plot" .. v19);
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.GetSpawnPoint(p20, p21) --[[ Line: 68 ]]
    local v22 = p20:GetPlayerPlot(p21);
    if v22 then
        return v22:FindFirstChild("SpawnPoint");
    else
        return nil;
    end;
end;
function v1.GetSprinklersFolder(p23, p24) --[[ Line: 75 ]]
    local v25 = p23:GetPlayerPlot(p24);
    if not v25 then
        return nil;
    end;
    local v26 = v25:FindFirstChild("Sprinklers");
    if not v26 then
        v26 = Instance.new("Folder");
        v26.Name = "Sprinklers";
        v26.Parent = v25;
    end;
    return v26;
end;
function v1.GetSprinklerData(_, p27) --[[ Line: 88 ]]
    -- upvalues: u3 (copy)
    return u3[p27];
end;
function v1.CreateSprinklerTimerUI(_, p28) --[[ Line: 92 ]]
    local v29 = script.SprinklerTimerUI:Clone();
    v29.Parent = p28;
    return v29;
end;
function v1.UpdateSprinklerTimers(_) --[[ Line: 98 ]]
    -- upvalues: u2 (copy), u4 (copy)
    local v30 = os.time();
    for v31, v32 in u2 do
        if v32 and v32.Parent then
            local v33 = u4[v31];
            if v33 then
                local v34 = math.clamp(v33.Lifetime - (v30 - v33.PlacedAt), 0, v33.Lifetime);
                if v34 <= 0 then
                    v32:Destroy();
                    u2[v31] = nil;
                    u4[v31] = nil;
                else
                    local v35 = math.floor(v34 / 60);
                    local v36 = v34 % 60;
                    local v37 = v32:FindFirstChild("SprinklerTimerUI");
                    if v37 and v37:IsA("BillboardGui") then
                        local v38 = v37:FindFirstChildOfClass("TextLabel");
                        if v38 then
                            v38.Text = string.format("%d:%02d", v35, v36);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function v1.UpdateSprinklerSpins(_, p39) --[[ Line: 130 ]]
    -- upvalues: u5 (ref), u2 (copy)
    u5 = u5 + p39;
    if u5 < 0.2 then
    else
        u5 = 0;
        local v40 = CFrame.Angles(0, 0.3141592653589793, 0);
        for _, v41 in u2 do
            if v41 and v41.Parent then
                v41:PivotTo(v41:GetPivot() * v40);
            end;
        end;
    end;
end;
function v1.SpawnSprinklerFromData(p42, p43, p44, p45) --[[ Line: 148 ]]
    -- upvalues: u2 (copy), u4 (copy), l__Sprinklers__14 (copy), l__SoundService__4 (copy)
    local v46 = p42:GetSpawnPoint(p43);
    if v46 then
        local v47 = p42:GetSprinklersFolder(p43);
        if v47 then
            local l__SprinklerName__15 = p45.SprinklerName;
            if l__SprinklerName__15 then
                local v48 = `{p43}_{p44}`;
                if u2[v48] then
                    u2[v48]:Destroy();
                    u2[v48] = nil;
                    u4[v48] = nil;
                end;
                local v49 = Vector3.new(p45.Positions.PosX, p45.Positions.PosY, p45.Positions.PosZ);
                local l__Rotation__16 = p45.Positions.Rotation;
                local v50 = v46.CFrame:PointToWorldSpace(v49);
                local v51 = select(2, v46.CFrame:ToEulerAnglesYXZ());
                local v52 = l__Rotation__16 + math.deg(v51);
                local v53 = CFrame.new(v50) * CFrame.Angles(0, math.rad(v52), 0);
                local v54 = l__Sprinklers__14:FindFirstChild(l__SprinklerName__15);
                if v54 then
                    local v55 = v54:Clone();
                    v55.Name = v48;
                    v55:SetAttribute("SprinklerId", p44);
                    v55:SetAttribute("UserId", p43);
                    v55:SetAttribute("SprinklerName", l__SprinklerName__15);
                    v55.Parent = v47;
                    v55:PivotTo(v53);
                    local v56 = p42:GetSprinklerData(l__SprinklerName__15);
                    if v56 then
                        if os.time() - p45.PlacedAt >= v56.Lifetime then
                            v55:Destroy();
                            return;
                        end;
                        u4[v48] = {
                            PlacedAt = p45.PlacedAt,
                            Lifetime = v56.Lifetime
                        };
                        p42:CreateSprinklerTimerUI(v55);
                    end;
                    local v57 = v55.PrimaryPart or v55:FindFirstChildWhichIsA("BasePart");
                    if v57 then
                        local v58 = Instance.new("Sound");
                        v58.SoundId = "rbxassetid://76520945762958";
                        v58.Volume = 0.5;
                        v58.RollOffMaxDistance = 100;
                        v58.Looped = true;
                        v58.SoundGroup = l__SoundService__4:FindFirstChild("SFXGroup");
                        v58.Parent = v57;
                        v58:Play();
                    end;
                    u2[v48] = v55;
                end;
            end;
        end;
    end;
end;
function v1.RemoveSprinklerById(_, p59, p60) --[[ Line: 218 ]]
    -- upvalues: u2 (copy), u4 (copy)
    local v61 = `{p59}_{p60}`;
    local v62 = u2[v61];
    if v62 then
        v62:Destroy();
        u2[v61] = nil;
        u4[v61] = nil;
    end;
end;
function v1.GetSprinklerFromPart(_, p63) --[[ Line: 229 ]]
    -- upvalues: u2 (copy)
    for _, v64 in u2 do
        if v64 and (v64.Parent and p63:IsDescendantOf(v64)) then
            return v64;
        end;
    end;
    return nil;
end;
function v1.UpdateHoverPreview(p65) --[[ Line: 238 ]]
    -- upvalues: u8 (ref), l__UserInputService__6 (copy), l__CurrentCamera__10 (copy), l__Temporary__12 (copy), l__LocalPlayer__9 (copy)
    if u8 and not u8.Parent then
        p65:DestroyHoverPreview();
    end;
    local v66 = l__UserInputService__6:GetMouseLocation();
    local v67 = l__CurrentCamera__10:ViewportPointToRay(v66.X, v66.Y);
    local v68 = RaycastParams.new();
    v68.FilterType = Enum.RaycastFilterType.Exclude;
    local v69 = { l__Temporary__12 };
    local l__Character__17 = l__LocalPlayer__9.Character;
    if l__Character__17 then
        table.insert(v69, l__Character__17);
    end;
    v68.FilterDescendantsInstances = v69;
    local v70 = nil;
    for _ = 1, 10 do
        local v71 = workspace:Raycast(v67.Origin, v67.Direction * 5000, v68);
        if not v71 then
            break;
        end;
        local l__Instance__18 = v71.Instance;
        local v72 = p65:GetSprinklerFromPart(l__Instance__18);
        if v72 then
            v70 = v72;
            break;
        end;
        if l__Instance__18.Transparency < 0.9 then
            break;
        end;
        table.insert(v69, l__Instance__18);
        v68.FilterDescendantsInstances = v69;
    end;
    if v70 == u8 then
    else
        p65:DestroyHoverPreview();
        if v70 then
            p65:CreateHoverPreview(v70);
        end;
    end;
end;
function v1.CreateHoverPreview(_, p73) --[[ Line: 292 ]]
    -- upvalues: u8 (ref), u3 (copy), l__Assets__13 (copy), l__Temporary__12 (copy), u6 (ref), u7 (ref), l__TweenService__5 (copy)
    u8 = p73;
    local v74 = u3[p73:GetAttribute("SprinklerName")];
    if v74 then
        local v75 = l__Assets__13.SprinklerRadius:Clone();
        v75.Size = Vector3.new(v74.Radius, 0.5, v74.Radius);
        v75.Anchored = true;
        v75.CanCollide = false;
        v75.CanQuery = false;
        v75.CanTouch = false;
        local l__Position__19 = p73:GetPivot().Position;
        v75.CFrame = CFrame.new((Vector3.new(l__Position__19.X, 142.602, l__Position__19.Z)));
        v75.Parent = l__Temporary__12;
        u6 = v75;
        local u76 = v75:FindFirstChild("SurfaceGui");
        if u76 then
            local u77 = u76:FindFirstChild("PrimaryCircle");
            if u77 and u77:IsA("ImageLabel") then
                u7 = task.spawn(function() --[[ Line: 317 ]]
                    -- upvalues: u6 (ref), u77 (copy), u76 (copy), l__TweenService__5 (ref)
                    while u6 and u6.Parent do
                        local u78 = u77:Clone();
                        local v79 = u78:FindFirstChildOfClass("UIScale");
                        if not v79 then
                            v79 = Instance.new("UIScale");
                            v79.Parent = u78;
                        end;
                        u78.Parent = u76;
                        v79.Scale = 0;
                        local v80 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                        l__TweenService__5:Create(v79, v80, {
                            Scale = 1
                        }):Play();
                        local v81 = l__TweenService__5:Create(u78, v80, {
                            ImageTransparency = 0
                        });
                        v81:Play();
                        v81.Completed:Once(function() --[[ Line: 335 ]]
                            -- upvalues: l__TweenService__5 (ref), u78 (copy)
                            local v82 = l__TweenService__5:Create(u78, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ImageTransparency = 1
                            });
                            v82:Play();
                            v82.Completed:Once(function() --[[ Line: 339 ]]
                                -- upvalues: u78 (ref)
                                u78:Destroy();
                            end);
                        end);
                        task.wait(1.1);
                    end;
                end);
            end;
        end;
    end;
end;
function v1.DestroyHoverPreview(_) --[[ Line: 349 ]]
    -- upvalues: u7 (ref), u6 (ref), u8 (ref)
    if u7 then
        task.cancel(u7);
        u7 = nil;
    end;
    if u6 then
        u6:Destroy();
        u6 = nil;
    end;
    u8 = nil;
end;
return v1;