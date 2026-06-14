-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 4
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__RunService__3 = game:GetService("RunService");
local l__TweenService__4 = game:GetService("TweenService");
local l__UserInputService__5 = game:GetService("UserInputService");
local l__GardenSyncController__6 = require(script.Parent.GardenSyncController);
local l__RakeData__7 = require(l__ReplicatedStorage__2.SharedModules.RakeData);
local l__Networking__8 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__CurrentCamera__10 = workspace.CurrentCamera;
local l__Gardens__11 = workspace:WaitForChild("Gardens");
local l__Temporary__12 = workspace:WaitForChild("Temporary");
local l__Assets__13 = l__ReplicatedStorage__2.Assets;
local l__Rakes__14 = l__Assets__13.Rakes;
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = nil;
local u6 = nil;
local u7 = nil;
function v1.Init(_) --[[ Line: 31 ]]
    -- upvalues: l__RakeData__7 (copy), u3 (copy)
    for _, v8 in l__RakeData__7 do
        u3[v8.RakeName] = v8;
    end;
end;
function v1.Start(u9) --[[ Line: 37 ]]
    -- upvalues: l__GardenSyncController__6 (copy), l__Networking__8 (copy), l__RunService__3 (copy)
    l__GardenSyncController__6:OnRakeAdded(function(p10, p11, p12) --[[ Line: 38 ]]
        -- upvalues: u9 (copy)
        u9:SpawnRakeFromData(p10, p11, p12);
    end);
    l__GardenSyncController__6:OnRakeRemoved(function(p13, p14) --[[ Line: 42 ]]
        -- upvalues: u9 (copy)
        u9:RemoveRakeById(p13, p14);
    end);
    l__Networking__8.Place.RakeActivated.OnClientEvent:Connect(function(p15, p16) --[[ Line: 46 ]]
        -- upvalues: u9 (copy)
        u9:PlayRakeActivatedFx(p15, p16);
    end);
    l__RunService__3.Heartbeat:Connect(function() --[[ Line: 50 ]]
        -- upvalues: u9 (copy)
        debug.profilebegin("Controllers/RakeVisualizerController/Heartbeat");
        u9:UpdateRakeTimers();
        u9:UpdateHoverPreview();
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
function v1.GetSpawnPoint(p20, p21) --[[ Line: 73 ]]
    local v22 = p20:GetPlayerPlot(p21);
    if v22 then
        return v22:FindFirstChild("SpawnPoint");
    else
        return nil;
    end;
end;
function v1.GetRakesFolder(p23, p24) --[[ Line: 83 ]]
    local v25 = p23:GetPlayerPlot(p24);
    if not v25 then
        return nil;
    end;
    local v26 = v25:FindFirstChild("Rakes");
    if not v26 then
        v26 = Instance.new("Folder");
        v26.Name = "Rakes";
        v26.Parent = v25;
    end;
    return v26;
end;
function v1.GetRakeData(_, p27) --[[ Line: 98 ]]
    -- upvalues: u3 (copy)
    return u3[p27];
end;
function v1.CreateRakeTimerUI(_, p28) --[[ Line: 102 ]]
    local v29 = script.RakeTimerUI:Clone();
    v29.Parent = p28;
    return v29;
end;
function v1.UpdateRakeTimers(_) --[[ Line: 108 ]]
    -- upvalues: u2 (copy), u4 (copy)
    local v30 = os.time();
    local v31 = {};
    for v32, v33 in u2 do
        if v33 and v33.Parent then
            local v34 = u4[v32];
            if v34 then
                local v35 = math.clamp(v34.Lifetime - (v30 - v34.PlacedAt), 0, v34.Lifetime);
                if v35 <= 0 then
                    table.insert(v31, v32);
                else
                    local v36 = math.floor(v35 / 60);
                    local v37 = v35 % 60;
                    local v38 = v33:FindFirstChild("RakeTimerUI");
                    if v38 and v38:IsA("BillboardGui") then
                        local v39 = v38:FindFirstChildOfClass("TextLabel");
                        if v39 then
                            v39.Text = string.format("%d:%02d", v36, v37);
                        end;
                    end;
                end;
            end;
        end;
    end;
    for _, v40 in v31 do
        local v41 = u2[v40];
        if v41 then
            v41:Destroy();
        end;
        u2[v40] = nil;
        u4[v40] = nil;
    end;
end;
function v1.SpawnRakeFromData(p42, p43, p44, p45) --[[ Line: 151 ]]
    -- upvalues: u2 (copy), u4 (copy), l__Rakes__14 (copy)
    local v46 = p42:GetSpawnPoint(p43);
    if v46 then
        local v47 = p42:GetRakesFolder(p43);
        if v47 then
            local l__RakeName__15 = p45.RakeName;
            if l__RakeName__15 then
                local v48 = p42:GetRakeData(l__RakeName__15);
                if v48 and (p45.PlacedAt and os.time() - p45.PlacedAt >= (v48.Lifetime or (1 / 0))) then
                else
                    local v49 = `{p43}_{p44}`;
                    if u2[v49] then
                        u2[v49]:Destroy();
                        u2[v49] = nil;
                        u4[v49] = nil;
                    end;
                    local v50 = Vector3.new(p45.Positions.PosX, p45.Positions.PosY, p45.Positions.PosZ);
                    local v51 = p45.Positions.Rotation or 0;
                    local v52 = v46.CFrame:PointToWorldSpace(v50);
                    local _, v53, _ = v46.CFrame:ToEulerAnglesYXZ();
                    local v54 = math.rad(v51) + v53;
                    local v55 = CFrame.new(v52) * CFrame.Angles(0, v54, 0);
                    local v56 = l__Rakes__14:FindFirstChild(l__RakeName__15);
                    if v56 then
                        local v57 = v56:Clone();
                        v57.Name = v49;
                        v57:SetAttribute("RakeId", p44);
                        v57:SetAttribute("UserId", p43);
                        v57:SetAttribute("RakeName", l__RakeName__15);
                        v57.Parent = v47;
                        v57:PivotTo(v55 * CFrame.Angles(0, 3.141592653589793, 0));
                        for _, v58 in v57:GetDescendants() do
                            if v58:IsA("BasePart") then
                                v58.CanTouch = false;
                            end;
                        end;
                        local v59 = Instance.new("Part");
                        v59.Name = "HoverDetection";
                        v59.Size = Vector3.new(3, 2, 3);
                        v59.Transparency = 1;
                        v59.CanCollide = false;
                        v59.CanTouch = false;
                        v59.CanQuery = true;
                        v59.Anchored = true;
                        v59.CFrame = v55;
                        v59.Parent = v57;
                        local v60 = p42:GetRakeData(l__RakeName__15);
                        local v61 = (v60 and (v60.Radius or 7) or 7) * 2;
                        local v62 = Instance.new("Part");
                        v62.Name = "TouchHitbox";
                        v62.Shape = Enum.PartType.Cylinder;
                        v62.Size = Vector3.new(6, v61, v61);
                        v62.CFrame = CFrame.new(v52) * CFrame.Angles(0, 0, 1.5707963267948966);
                        v62.Transparency = 1;
                        v62.CanCollide = false;
                        v62.CanTouch = true;
                        v62.CanQuery = false;
                        v62.Anchored = true;
                        v62.Parent = v57;
                        if v60 then
                            u4[v49] = {
                                PlacedAt = p45.PlacedAt,
                                Lifetime = v60.Lifetime
                            };
                            p42:CreateRakeTimerUI(v57);
                        end;
                        u2[v49] = v57;
                    end;
                end;
            end;
        end;
    end;
end;
function v1.RemoveRakeById(_, p63, p64) --[[ Line: 256 ]]
    -- upvalues: u2 (copy), u4 (copy)
    local v65 = `{p63}_{p64}`;
    local v66 = u2[v65];
    if v66 then
        v66:Destroy();
        u2[v65] = nil;
        u4[v65] = nil;
    end;
end;
function v1.FindModelByRakeId(_, p67) --[[ Line: 270 ]]
    -- upvalues: u2 (copy)
    for _, v68 in u2 do
        if v68 and (v68.Parent and v68:GetAttribute("RakeId") == p67) then
            return v68;
        end;
    end;
    return nil;
end;
function v1.GetRakeFromPart(_, p69) --[[ Line: 279 ]]
    -- upvalues: u2 (copy)
    for _, v70 in u2 do
        if v70 and (v70.Parent and p69:IsDescendantOf(v70)) then
            return v70;
        end;
    end;
    return nil;
end;
function v1.PlayRakeActivatedFx(p71, p72, _) --[[ Line: 291 ]]
    -- upvalues: l__TweenService__4 (copy)
    local v73 = p71:FindModelByRakeId(p72);
    if v73 then
        local u74 = v73:FindFirstChild("RakeModel");
        local v75;
        if u74 then
            v75 = u74:FindFirstChild("Hitbox");
        else
            v75 = u74;
        end;
        if v75 then
            local v76 = v75:FindFirstChild("Thud");
            if v76 then
                v76.PlaybackSpeed = math.random(90, 110) / 100;
                v76.TimePosition = 0;
                v76:Play();
            end;
            local v77 = v75:FindFirstChild("VFX");
            if v77 and v77:FindFirstChild("Break") then
                v77.Break:Emit(2);
            end;
        end;
        if u74 then
            local u78 = u74:GetPivot();
            local _, v79, _ = u78:ToOrientation();
            local u80 = CFrame.new(u78.Position) * CFrame.Angles(0, v79 + 3.141592653589793, 0) * CFrame.Angles(-1.5707963267948966, 0, 0);
            local u81 = Instance.new("NumberValue");
            u81.Value = 0;
            local u82 = nil;
            u82 = u81.Changed:Connect(function() --[[ Line: 325 ]]
                -- upvalues: u74 (copy), u82 (ref), u81 (copy), u78 (copy), u80 (copy)
                if u74 and u74.Parent then
                    u74:PivotTo(u78:Lerp(u80, u81.Value));
                else
                    u82:Disconnect();
                    u81:Destroy();
                end;
            end);
            local v83 = l__TweenService__4:Create(u81, TweenInfo.new(0.4, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Value = 1
            });
            v83:Play();
            v83.Completed:Once(function() --[[ Line: 337 ]]
                -- upvalues: l__TweenService__4 (ref), u81 (copy), u82 (ref)
                task.wait(2);
                local v84 = l__TweenService__4:Create(u81, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Value = 0
                });
                v84:Play();
                v84.Completed:Once(function() --[[ Line: 342 ]]
                    -- upvalues: u82 (ref), u81 (ref)
                    u82:Disconnect();
                    u81:Destroy();
                end);
            end);
        end;
    end;
end;
function v1.UpdateHoverPreview(p85) --[[ Line: 353 ]]
    -- upvalues: u7 (ref), l__UserInputService__5 (copy), l__CurrentCamera__10 (copy), l__Temporary__12 (copy), l__LocalPlayer__9 (copy)
    if u7 and not u7.Parent then
        p85:DestroyHoverPreview();
    end;
    local v86 = l__UserInputService__5:GetMouseLocation();
    local v87 = l__CurrentCamera__10:ViewportPointToRay(v86.X, v86.Y);
    local v88 = RaycastParams.new();
    v88.FilterType = Enum.RaycastFilterType.Exclude;
    local v89 = { l__Temporary__12 };
    local l__Character__16 = l__LocalPlayer__9.Character;
    if l__Character__16 then
        table.insert(v89, l__Character__16);
    end;
    v88.FilterDescendantsInstances = v89;
    local v90 = nil;
    for _ = 1, 10 do
        v90 = workspace:Raycast(v87.Origin, v87.Direction * 5000, v88);
        if not v90 then
            break;
        end;
        local l__Instance__17 = v90.Instance;
        if l__Instance__17.Transparency < 0.9 or l__Instance__17.Name == "HoverDetection" then
            break;
        end;
        table.insert(v89, l__Instance__17);
        v88.FilterDescendantsInstances = v89;
    end;
    local v91;
    if v90 then
        v91 = p85:GetRakeFromPart(v90.Instance);
    else
        v91 = nil;
    end;
    if v91 == u7 then
    else
        p85:DestroyHoverPreview();
        if v91 then
            p85:CreateHoverPreview(v91);
        end;
    end;
end;
function v1.CreateHoverPreview(_, p92) --[[ Line: 405 ]]
    -- upvalues: u7 (ref), u3 (copy), l__Assets__13 (copy), l__Temporary__12 (copy), u5 (ref), u6 (ref), l__TweenService__4 (copy)
    u7 = p92;
    local v93 = u3[p92:GetAttribute("RakeName")];
    if v93 then
        local v94 = l__Assets__13.SprinklerRadius:Clone();
        v94.Size = Vector3.new(v93.Radius * 2, 0.5, v93.Radius * 2);
        v94.Anchored = true;
        v94.CanCollide = false;
        v94.CanQuery = false;
        v94.CanTouch = false;
        local l__Position__18 = p92:GetPivot().Position;
        v94.CFrame = CFrame.new((Vector3.new(l__Position__18.X, 142.602, l__Position__18.Z)));
        v94.Parent = l__Temporary__12;
        u5 = v94;
        local u95 = v94:FindFirstChild("SurfaceGui");
        if u95 then
            local u96 = u95:FindFirstChild("PrimaryCircle");
            if u96 and u96:IsA("ImageLabel") then
                u6 = task.spawn(function() --[[ Line: 428 ]]
                    -- upvalues: u5 (ref), u96 (copy), u95 (copy), l__TweenService__4 (ref)
                    while u5 and u5.Parent do
                        local u97 = u96:Clone();
                        local v98 = u97:FindFirstChildOfClass("UIScale");
                        if not v98 then
                            v98 = Instance.new("UIScale");
                            v98.Parent = u97;
                        end;
                        u97.Parent = u95;
                        v98.Scale = 0;
                        local v99 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                        l__TweenService__4:Create(v98, v99, {
                            Scale = 1
                        }):Play();
                        local v100 = l__TweenService__4:Create(u97, v99, {
                            ImageTransparency = 0
                        });
                        v100:Play();
                        v100.Completed:Once(function() --[[ Line: 446 ]]
                            -- upvalues: l__TweenService__4 (ref), u97 (copy)
                            local v101 = l__TweenService__4:Create(u97, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                ImageTransparency = 1
                            });
                            v101:Play();
                            v101.Completed:Once(function() --[[ Line: 450 ]]
                                -- upvalues: u97 (ref)
                                u97:Destroy();
                            end);
                        end);
                        task.wait(1.1);
                    end;
                end);
            end;
        end;
    end;
end;
function v1.DestroyHoverPreview(_) --[[ Line: 462 ]]
    -- upvalues: u6 (ref), u5 (ref), u7 (ref)
    if u6 then
        task.cancel(u6);
        u6 = nil;
    end;
    if u5 then
        u5:Destroy();
        u5 = nil;
    end;
    u7 = nil;
end;
return v1;