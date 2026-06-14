-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__CollectionService__3 = game:GetService("CollectionService");
local l__TweenService__4 = game:GetService("TweenService");
local l__ReplicatedStorage__5 = game:GetService("ReplicatedStorage");
local l__RunService__6 = game:GetService("RunService");
local l__Debris__7 = game:GetService("Debris");
local l__SoundService__8 = game:GetService("SoundService");
local l__Rakes__9 = l__ReplicatedStorage__5.Assets.Rakes;
local l__Networking__10 = require(l__ReplicatedStorage__5.SharedModules.Networking);
local l__RakeData__11 = require(l__ReplicatedStorage__5.SharedModules.RakeData);
require(l__ReplicatedStorage__5.ClientModules.PlacementGrid);
local l__LocalPlayer__12 = l__Players__1.LocalPlayer;
local l__PlayerGui__13 = l__LocalPlayer__12:WaitForChild("PlayerGui");
local l__CurrentCamera__14 = workspace.CurrentCamera;
local l__Gardens__15 = workspace:WaitForChild("Gardens");
local l__Assets__16 = l__ReplicatedStorage__5.Assets;
local l__Temporary__17 = workspace.Temporary;
local function u2(...) --[[ Line: 35 ]] end;
local u3 = 0;
local u4 = Color3.fromRGB(100, 255, 100);
local u5 = Color3.fromRGB(255, 100, 100);
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = nil;
local u11 = {};
local u12 = 0;
local u13 = false;
local u14 = nil;
local u15 = {};
local u16 = {};
local u17 = nil;
local u18 = nil;
function v1.Init(_) --[[ Line: 84 ]]
    -- upvalues: l__RakeData__11 (copy), u11 (copy)
    for _, v19 in l__RakeData__11 do
        u11[v19.RakeName] = v19;
    end;
end;
function v1.Start(u20) --[[ Line: 90 ]]
    -- upvalues: u17 (ref), l__PlayerGui__13 (copy), u18 (ref), u13 (ref), u12 (ref), u2 (copy), l__UserInputService__2 (copy), l__LocalPlayer__12 (copy)
    u17 = l__PlayerGui__13:WaitForChild("RakeUI");
    u18 = u17:WaitForChild("Rotate");
    u18.Visible = false;
    u18.Activated:Connect(function() --[[ Line: 95 ]]
        -- upvalues: u13 (ref), u12 (ref), u2 (ref)
        if u13 then
            u12 = (u12 + 15) % 360;
            u2("UI Rotate pressed, placingRotation =", u12);
        end;
    end);
    l__UserInputService__2.InputBegan:Connect(function(p21, p22) --[[ Line: 102 ]]
        -- upvalues: u20 (copy)
        u20:OnInput(p21, p22);
    end);
    l__UserInputService__2.InputEnded:Connect(function(p23, _) --[[ Line: 106 ]]
        -- upvalues: u20 (copy)
        if p23.KeyCode == Enum.KeyCode.R or p23.KeyCode == Enum.KeyCode.ButtonR1 then
            u20:StopRotateHold();
        end;
    end);
    local l__Character__18 = l__LocalPlayer__12.Character;
    if l__Character__18 then
        u20:SetupCharacter(l__Character__18);
    end;
    l__LocalPlayer__12.CharacterAdded:Connect(function(p24) --[[ Line: 116 ]]
        -- upvalues: u20 (copy)
        u20:SetupCharacter(p24);
    end);
    u20:SetupRakeTouchDetection();
end;
function v1.StartRotateHold(p25) --[[ Line: 126 ]]
    -- upvalues: u14 (ref), u12 (ref)
    p25:StopRotateHold();
    u14 = task.spawn(function() --[[ Line: 128 ]]
        -- upvalues: u12 (ref)
        task.wait(1);
        while true do
            u12 = (u12 + 15) % 360;
            task.wait(0.08);
        end;
    end);
end;
function v1.StopRotateHold(_) --[[ Line: 137 ]]
    -- upvalues: u14 (ref)
    if u14 then
        task.cancel(u14);
        u14 = nil;
    end;
end;
function v1.SetupCharacter(u26, p27) --[[ Line: 147 ]]
    p27.ChildAdded:Connect(function(p28) --[[ Line: 148 ]]
        -- upvalues: u26 (copy)
        if p28:IsA("Tool") and p28:GetAttribute("Rake") then
            u26:EnterPlacingMode(p28:GetAttribute("Rake"));
        end;
    end);
    p27.ChildRemoved:Connect(function(p29) --[[ Line: 154 ]]
        -- upvalues: u26 (copy)
        if p29:IsA("Tool") and p29:GetAttribute("Rake") then
            u26:ExitPlacingMode();
        end;
    end);
    for _, v30 in p27:GetChildren() do
        if v30:IsA("Tool") and v30:GetAttribute("Rake") then
            u26:EnterPlacingMode(v30:GetAttribute("Rake"));
        end;
    end;
end;
function v1.EnterPlacingMode(p31, p32) --[[ Line: 170 ]]
    -- upvalues: u13 (ref), u12 (ref), u2 (copy), u18 (ref)
    p31:ExitPlacingMode();
    u13 = true;
    u12 = 0;
    u2("EnterPlacingMode: rakeName =", p32, ", placingRotation reset to 0");
    if u18 then
        u18.Visible = true;
    end;
    p31:CreatePreview(p32);
end;
function v1.ExitPlacingMode(p33) --[[ Line: 185 ]]
    -- upvalues: u13 (ref), u18 (ref)
    u13 = false;
    p33:StopRotateHold();
    if u18 then
        u18.Visible = false;
    end;
    p33:DestroyPreview();
end;
function v1.CreatePreview(u34, p35) --[[ Line: 199 ]]
    -- upvalues: l__Rakes__9 (copy), u11 (copy), u6 (ref), l__Assets__16 (copy), u7 (ref), u9 (ref), l__TweenService__4 (copy), u10 (ref), l__Debris__7 (copy), l__Temporary__17 (copy), u8 (ref), l__RunService__6 (copy)
    u34:DestroyPreview();
    local v36 = l__Rakes__9:FindFirstChild(p35);
    local v37 = u11[p35];
    if v36 and v37 then
        u6 = v36:Clone();
        u6.Name = "RakePreview";
        local v38 = l__Assets__16.SprinklerRadius:Clone();
        v38.Size = Vector3.new(v37.Radius * 2, 0.5, v37.Radius * 2);
        v38.Anchored = true;
        v38.CanCollide = false;
        v38.CanQuery = false;
        v38.CanTouch = false;
        v38.Parent = u6;
        u7 = v38;
        local u39 = v38:FindFirstChild("SurfaceGui");
        if u39 then
            local u40 = u39:FindFirstChild("PrimaryCircle");
            if u40 and u40:IsA("ImageLabel") then
                u9 = l__TweenService__4:Create(u40, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                    ImageTransparency = 0.5
                });
                u10 = task.spawn(function() --[[ Line: 228 ]]
                    -- upvalues: u7 (ref), u40 (copy), u39 (copy), l__TweenService__4 (ref), l__Debris__7 (ref)
                    while u7 do
                        local u41 = u40:Clone();
                        local v42 = u41:FindFirstChildOfClass("UIScale");
                        if not v42 then
                            v42 = Instance.new("UIScale");
                            v42.Parent = u41;
                        end;
                        u41.Parent = u39;
                        v42.Scale = 0;
                        local v43 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                        local v44 = l__TweenService__4:Create(v42, v43, {
                            Scale = 1
                        });
                        v44:Play();
                        l__Debris__7:AddItem(v44, v43.Time);
                        local v45 = l__TweenService__4:Create(u41, v43, {
                            ImageTransparency = 0
                        });
                        v45:Play();
                        l__Debris__7:AddItem(v45, v43.Time);
                        v45.Completed:Once(function() --[[ Line: 250 ]]
                            -- upvalues: l__TweenService__4 (ref), u41 (copy), l__Debris__7 (ref)
                            local v46 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                            local v47 = l__TweenService__4:Create(u41, v46, {
                                ImageTransparency = 1
                            });
                            v47:Play();
                            l__Debris__7:AddItem(v47, v46.Time);
                            v47.Completed:Once(function() --[[ Line: 255 ]]
                                -- upvalues: u41 (ref)
                                u41:Destroy();
                            end);
                        end);
                        task.wait(1.1);
                    end;
                end);
            end;
        end;
        for _, v48 in u6:GetDescendants() do
            if v48:IsA("BasePart") then
                if v48.Transparency == 0 then
                    v48.Transparency = 0.5;
                end;
                v48.CanCollide = false;
                v48.CanQuery = false;
                v48.CanTouch = false;
                v48.Anchored = true;
            elseif v48:IsA("ParticleEmitter") then
                v48.Enabled = false;
            end;
        end;
        u6.Parent = l__Temporary__17;
        u8 = l__RunService__6.RenderStepped:Connect(function() --[[ Line: 281 ]]
            -- upvalues: u34 (copy)
            u34:UpdatePreview();
        end);
    end;
end;
function v1.DestroyPreview(_) --[[ Line: 286 ]]
    -- upvalues: u10 (ref), u9 (ref), u6 (ref), u7 (ref), u8 (ref)
    if u10 then
        task.cancel(u10);
        u10 = nil;
    end;
    if u9 then
        u9:Cancel();
        u9:Destroy();
        u9 = nil;
    end;
    if u6 then
        u6:Destroy();
        u6 = nil;
    end;
    u7 = nil;
    if u8 then
        u8:Disconnect();
        u8 = nil;
    end;
end;
function v1.SetPreviewColor(_, p49) --[[ Line: 312 ]]
    -- upvalues: u6 (ref), u4 (copy), u5 (copy)
    if u6 then
        local v50 = p49 and u4 or u5;
        for _, v51 in u6:GetDescendants() do
            if v51:IsA("BasePart") then
                v51.Color = v50;
            end;
        end;
    end;
end;
function v1.IsUsingGamepad(_) --[[ Line: 325 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local v52 = l__UserInputService__2:GetLastInputType();
    return (v52 == Enum.UserInputType.Gamepad1 or (v52 == Enum.UserInputType.Gamepad2 or v52 == Enum.UserInputType.Gamepad3)) and true or v52 == Enum.UserInputType.Gamepad4;
end;
function v1.GetGamepadPlacementRay(_) --[[ Line: 333 ]]
    -- upvalues: l__LocalPlayer__12 (copy)
    local l__Character__19 = l__LocalPlayer__12.Character;
    if l__Character__19 then
        local v53 = l__Character__19:FindFirstChild("HumanoidRootPart");
        if v53 then
            return v53.Position + v53.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0);
        else
            return nil, nil;
        end;
    else
        return nil, nil;
    end;
end;
function v1.CreateRaycastParams(_) --[[ Line: 345 ]]
    -- upvalues: l__CollectionService__3 (copy)
    local v54 = RaycastParams.new();
    v54.FilterType = Enum.RaycastFilterType.Include;
    local v55 = l__CollectionService__3:GetTagged("GardenTotalArea");
    for _, v56 in l__CollectionService__3:GetTagged("PlantArea") do
        table.insert(v55, v56);
    end;
    v54.FilterDescendantsInstances = v55;
    return v54;
end;
function v1.CreatePreviewRaycastParams(_) --[[ Line: 360 ]]
    -- upvalues: l__LocalPlayer__12 (copy), l__Temporary__17 (copy)
    local v57 = RaycastParams.new();
    v57.FilterType = Enum.RaycastFilterType.Exclude;
    local l__Character__20 = l__LocalPlayer__12.Character;
    local v58 = workspace:QueryDescendants("BasePart[Transparency = 1]");
    table.insert(v58, l__Temporary__17);
    if l__Character__20 then
        table.insert(v58, l__Character__20);
    end;
    v57.FilterDescendantsInstances = v58;
    return v57;
end;
function v1.GetPlayerPlot(_) --[[ Line: 376 ]]
    -- upvalues: l__LocalPlayer__12 (copy), l__Gardens__15 (copy)
    local v59 = l__LocalPlayer__12:GetAttribute("PlotId");
    if v59 then
        return l__Gardens__15:FindFirstChild("Plot" .. v59);
    else
        return nil;
    end;
end;
function v1.GetPlotFromPart(_, p60) --[[ Line: 382 ]]
    -- upvalues: l__Gardens__15 (copy)
    while p60 do
        if p60.Parent == l__Gardens__15 and string.match(p60.Name, "^Plot%d+$") then
            return p60;
        end;
        p60 = p60.Parent;
        if p60 == workspace then
            break;
        end;
    end;
    return nil;
end;
function v1.GetPlotId(_, p61) --[[ Line: 394 ]]
    return tonumber(string.match(p61.Name, "%d+"));
end;
function v1.GetEquippedTool(_) --[[ Line: 398 ]]
    -- upvalues: l__LocalPlayer__12 (copy)
    local l__Character__21 = l__LocalPlayer__12.Character;
    if l__Character__21 then
        return l__Character__21:FindFirstChildWhichIsA("Tool");
    else
        return nil;
    end;
end;
function v1.GetSpawnPoint(p62) --[[ Line: 404 ]]
    local v63 = p62:GetPlayerPlot();
    if v63 then
        return v63:FindFirstChild("SpawnPoint");
    else
        return nil;
    end;
end;
function v1.GetGardenRotationY(p64) --[[ Line: 410 ]]
    local v65 = p64:GetSpawnPoint();
    if not v65 then
        return 0;
    end;
    local _, v66, _ = v65.CFrame:ToEulerAnglesYXZ();
    return v66;
end;
function v1.IsTooCloseToRake(_, p67, p68) --[[ Line: 420 ]]
    -- upvalues: u6 (ref)
    if not p67 then
        return false;
    end;
    local v69 = p67:FindFirstChild("Rakes");
    if not v69 then
        return false;
    end;
    for _, v70 in v69:GetDescendants() do
        if v70:IsA("Model") and (v70 ~= u6 and (v70.PrimaryPart and (v70.PrimaryPart.Position - p68).Magnitude < 0.5)) then
            return true;
        end;
    end;
    return false;
end;
function v1.IsValidPlacement(_, p71) --[[ Line: 437 ]]
    -- upvalues: l__CollectionService__3 (copy)
    local v72 = p71 + Vector3.new(0, 50, 0);
    local v73 = l__CollectionService__3:GetTagged("GardenTotalArea");
    if #v73 == 0 then
        return false;
    end;
    local v74 = RaycastParams.new();
    v74.FilterType = Enum.RaycastFilterType.Include;
    v74.FilterDescendantsInstances = v73;
    return workspace:Raycast(v72, Vector3.new(0, -100, 0), v74) ~= nil;
end;
function v1.ComputeRakeCFrame(p75, p76) --[[ Line: 452 ]]
    -- upvalues: u12 (ref)
    local v77 = p75:GetGardenRotationY() + math.rad(u12);
    return CFrame.new(p76) * CFrame.Angles(0, v77, 0);
end;
function v1.UpdatePreview(p78) --[[ Line: 461 ]]
    -- upvalues: u6 (ref), l__UserInputService__2 (copy), l__CurrentCamera__14 (copy), l__CollectionService__3 (copy), l__LocalPlayer__12 (copy), l__Temporary__17 (copy), u7 (ref)
    if u6 then
        local v79 = p78:CreateRaycastParams();
        local v80;
        if p78:IsUsingGamepad() then
            local v81, v82 = p78:GetGamepadPlacementRay();
            if not v81 then
                u6.Parent = nil;
                return;
            end;
            v80 = workspace:Raycast(v81, v82, v79);
        else
            local v83 = l__UserInputService__2:GetMouseLocation();
            local v84 = l__CurrentCamera__14:ViewportPointToRay(v83.X, v83.Y);
            v80 = workspace:Raycast(v84.Origin, v84.Direction * 5000, v79);
        end;
        if v80 then
            local l__Instance__22 = v80.Instance;
            local v85 = p78:GetPlotFromPart(l__Instance__22);
            local v86 = v85 and ((l__CollectionService__3:HasTag(l__Instance__22, "GardenTotalArea") or l__CollectionService__3:HasTag(l__Instance__22, "PlantArea")) and l__Instance__22:IsDescendantOf(v85));
            if v86 then
                if v85:GetAttribute("OwnerUserId") == l__LocalPlayer__12.UserId then
                    v86 = not p78:IsTooCloseToRake(v85, v80.Position);
                    if v86 then
                        v86 = p78:IsValidPlacement(v80.Position);
                    end;
                else
                    v86 = false;
                end;
            end;
            u6.Parent = l__Temporary__17;
            local l__Position__23 = v80.Position;
            local v87 = Vector3.new(l__Position__23.X, l__Position__23.Y, l__Position__23.Z);
            u6:PivotTo(p78:ComputeRakeCFrame(v87) * CFrame.Angles(0, 3.141592653589793, 0));
            if u7 then
                u7.CFrame = CFrame.new(v87);
            end;
            p78:SetPreviewColor(v86);
        else
            local v88 = p78:CreatePreviewRaycastParams();
            local v89;
            if p78:IsUsingGamepad() then
                local v90, v91 = p78:GetGamepadPlacementRay();
                if not v90 then
                    u6.Parent = nil;
                    return;
                end;
                v89 = workspace:Raycast(v90, v91, v88);
            else
                local v92 = l__UserInputService__2:GetMouseLocation();
                local v93 = l__CurrentCamera__14:ViewportPointToRay(v92.X, v92.Y);
                v89 = workspace:Raycast(v93.Origin, v93.Direction * 5000, v88);
            end;
            if v89 then
                u6.Parent = l__Temporary__17;
                local l__Position__24 = v89.Position;
                local v94 = Vector3.new(l__Position__24.X, 142.602, l__Position__24.Z);
                u6:PivotTo(p78:ComputeRakeCFrame(v94) * CFrame.Angles(0, 3.141592653589793, 0));
                if u7 then
                    u7.CFrame = CFrame.new(v94);
                end;
                p78:SetPreviewColor(false);
            else
                u6.Parent = nil;
            end;
        end;
    end;
end;
function v1.CleanupTouchConnections(_) --[[ Line: 546 ]]
    -- upvalues: u16 (ref)
    for _, v95 in u16 do
        v95:Disconnect();
    end;
    u16 = {};
end;
function v1.OnRakeTouched(_, p96, p97) --[[ Line: 553 ]]
    -- upvalues: l__LocalPlayer__12 (copy), u11 (copy), u15 (copy), u2 (copy), l__Networking__10 (copy)
    local l__Character__25 = l__LocalPlayer__12.Character;
    if l__Character__25 then
        if p97:IsDescendantOf(l__Character__25) then
            local v98 = os.clock();
            local v99 = p96:GetAttribute("RakeName") or p96.Name;
            local v100 = p96:GetAttribute("RakeId") or p96.Name;
            local v101 = u11[v99];
            local v102 = v101 and v101.Cooldown or 3;
            local v103 = u15[v100];
            if v103 and v98 - v103 < v102 then
            else
                u15[v100] = v98;
                local v104;
                if p96.PrimaryPart then
                    v104 = p96.PrimaryPart.Position;
                else
                    v104 = p96:GetPivot().Position;
                end;
                u2("=== RAKE TOUCHED ===");
                u2("  rakeName =", v99);
                u2("  rakePosition =", v104);
                if p96.PrimaryPart then
                    local l__CFrame__26 = p96.PrimaryPart.CFrame;
                    local _, v105, _ = l__CFrame__26:ToEulerAnglesYXZ();
                    u2("  Client sees PrimaryPart CFrame =", l__CFrame__26);
                    u2("  Client sees PrimaryPart rotY(rad) =", v105, "rotY(deg) =", (math.deg(v105)));
                    u2("  Client sees PrimaryPart LookVector =", l__CFrame__26.LookVector);
                    u2("  Client sees PrimaryPart RightVector =", l__CFrame__26.RightVector);
                else
                    u2("  WARNING: PrimaryPart is nil!");
                end;
                u2("  Firing RakeActivated to server with position =", v104);
                u2("=== END RAKE TOUCHED ===");
                l__Networking__10.Place.RakeActivated:Fire(v99, v104);
            end;
        end;
    end;
end;
function v1.ConnectRakeTouch(u106, u107) --[[ Line: 593 ]]
    -- upvalues: u16 (ref)
    for _, v108 in u107:GetDescendants() do
        if v108:IsA("BasePart") then
            local v110 = v108.Touched:Connect(function(p109) --[[ Line: 596 ]]
                -- upvalues: u106 (copy), u107 (copy)
                u106:OnRakeTouched(u107, p109);
            end);
            table.insert(u16, v110);
        end;
    end;
end;
function v1.GetRakeModelFromDescendant(_, p111) --[[ Line: 605 ]]
    -- upvalues: l__Gardens__15 (copy)
    while p111 and p111 ~= l__Gardens__15 do
        if p111:IsA("Model") and (p111.Parent and p111.Parent.Name == "Rakes") then
            return p111;
        end;
        p111 = p111.Parent;
    end;
    return nil;
end;
local u112 = {};
function v1.SetupRakeTouchDetection(u113) --[[ Line: 619 ]]
    -- upvalues: u2 (copy), l__Gardens__15 (copy), u112 (copy), u16 (ref)
    u2("SetupRakeTouchDetection: setting up DescendantAdded listener");
    for _, v114 in l__Gardens__15:GetChildren() do
        if v114:IsA("Model") then
            local v115 = v114:FindFirstChild("Rakes");
            if v115 then
                for _, v116 in v115:GetChildren() do
                    if v116:IsA("Model") and not u112[v116] then
                        u112[v116] = true;
                        u113:ConnectRakeTouch(v116);
                        u2("  Connected existing rake:", v116.Name, "in", v114.Name);
                    end;
                end;
            end;
        end;
    end;
    l__Gardens__15.DescendantAdded:Connect(function(p117) --[[ Line: 639 ]]
        -- upvalues: u112 (ref), u113 (copy), u2 (ref), u16 (ref)
        if p117:IsA("Model") and (p117.Parent and p117.Parent.Name == "Rakes") then
            task.wait();
            if not u112[p117] then
                u112[p117] = true;
                u113:ConnectRakeTouch(p117);
                u2("  DescendantAdded: connected new rake model:", p117.Name);
            end;
        else
            if p117:IsA("BasePart") then
                local u118 = u113:GetRakeModelFromDescendant(p117);
                if u118 and u112[u118] then
                    local v120 = p117.Touched:Connect(function(p119) --[[ Line: 655 ]]
                        -- upvalues: u113 (ref), u118 (copy)
                        u113:OnRakeTouched(u118, p119);
                    end);
                    table.insert(u16, v120);
                end;
            end;
        end;
    end);
    l__Gardens__15.DescendantRemoving:Connect(function(p121) --[[ Line: 664 ]]
        -- upvalues: u112 (ref)
        if p121:IsA("Model") and u112[p121] then
            u112[p121] = nil;
        end;
    end);
    u2("SetupRakeTouchDetection: done");
end;
function v1.OnInput(p122, p123, p124) --[[ Line: 676 ]]
    -- upvalues: u13 (ref), u12 (ref), u2 (copy), u3 (ref), l__CurrentCamera__14 (copy), l__CollectionService__3 (copy), l__LocalPlayer__12 (copy), l__Networking__10 (copy), l__SoundService__8 (copy)
    if p124 then
    elseif u13 and (p123.KeyCode == Enum.KeyCode.R or p123.KeyCode == Enum.KeyCode.ButtonR1) then
        u12 = (u12 + 15) % 360;
        u2("R key: placingRotation =", u12);
        p122:StartRotateHold();
    elseif (p123.UserInputType == Enum.UserInputType.MouseButton1 or p123.UserInputType == Enum.UserInputType.Touch) and true or p123.KeyCode == Enum.KeyCode.ButtonR2 then
        local v125 = os.clock();
        if v125 - u3 < 0.5 then
        else
            local v126 = p122:GetEquippedTool();
            if v126 then
                local v127 = v126:GetAttribute("Rake");
                if v127 then
                    local v128 = p122:CreateRaycastParams();
                    local v129;
                    if p122:IsUsingGamepad() then
                        local v130, v131 = p122:GetGamepadPlacementRay();
                        if not v130 then
                            return;
                        end;
                        v129 = workspace:Raycast(v130, v131, v128);
                    else
                        local l__Position__27 = p123.Position;
                        local v132 = l__CurrentCamera__14:ScreenPointToRay(l__Position__27.X, l__Position__27.Y);
                        v129 = workspace:Raycast(v132.Origin, v132.Direction * 5000, v128);
                    end;
                    if v129 then
                        local l__Instance__28 = v129.Instance;
                        if l__CollectionService__3:HasTag(l__Instance__28, "GardenTotalArea") or l__CollectionService__3:HasTag(l__Instance__28, "PlantArea") then
                            local v133 = p122:GetPlotFromPart(l__Instance__28);
                            if v133 then
                                if l__Instance__28:IsDescendantOf(v133) then
                                    if v133:GetAttribute("Owner") then
                                        local v134 = p122:GetPlotId(v133);
                                        if v134 then
                                            if v133:GetAttribute("OwnerUserId") == l__LocalPlayer__12.UserId then
                                                if p122:IsTooCloseToRake(v133, v129.Position) then
                                                elseif p122:IsValidPlacement(v129.Position) then
                                                    u3 = v125;
                                                    local l__Position__29 = v129.Position;
                                                    local v135 = p122:GetSpawnPoint();
                                                    local v136 = p122:GetGardenRotationY();
                                                    local v137 = math.deg(v136);
                                                    u2("=== PLACEMENT FIRE ===");
                                                    u2("  hitPosition =", l__Position__29);
                                                    u2("  rakeName =", v127);
                                                    u2("  targetPlotId =", v134);
                                                    u2("  SpawnPoint CFrame =", v135 and v135.CFrame or "nil");
                                                    u2("  gardenRotY(rad) =", v136, "gardenRotY(deg) =", v137);
                                                    u2("  placingRotation(deg) =", u12);
                                                    local v138 = v137 + u12;
                                                    u2("  worldRotationDeg = gardenRotYDeg + placingRotation =", v138);
                                                    local v139 = CFrame.new(l__Position__29) * CFrame.Angles(0, v136 + math.rad(u12), 0);
                                                    local _, v140, _ = v139:ToEulerAnglesYXZ();
                                                    u2("  PREVIEW CFrame =", v139);
                                                    u2("  PREVIEW rotY(deg) =", (math.deg(v140)));
                                                    u2("  PREVIEW LookVector =", v139.LookVector);
                                                    local v141 = v133:FindFirstChild("SpawnPoint");
                                                    if v141 then
                                                        local _, v142, _ = v141.CFrame:ToEulerAnglesYXZ();
                                                        local v143 = math.deg(v142);
                                                        u2("  targetSpawnPoint CFrame =", v141.CFrame);
                                                        u2("  targetSpawnPoint rotY(rad) =", v142, "rotY(deg) =", v143);
                                                        local v144 = v138 - v143;
                                                        u2("  relativeRotation = worldRotDeg - spawnRotYDeg =", v138, "-", v143, "=", v144);
                                                        v138 = v144;
                                                    else
                                                        u2("  WARNING: no SpawnPoint in targetPlot!");
                                                    end;
                                                    u2("  >>> SENDING TO SERVER: relativeRotation =", v138);
                                                    u2("=== END PLACEMENT FIRE ===");
                                                    l__Networking__10.Place.PlaceRake:Fire(l__Position__29, v127, v126, v134, v138);
                                                    local l__Character__30 = l__LocalPlayer__12.Character;
                                                    if l__Character__30 then
                                                        l__Character__30 = l__Character__30:FindFirstChild("HumanoidRootPart");
                                                    end;
                                                    if l__Character__30 then
                                                        local v145 = Instance.new("Sound");
                                                        v145.SoundId = "rbxassetid://135948019584556";
                                                        v145.SoundGroup = l__SoundService__8:FindFirstChild("SFXGroup");
                                                        v145.Parent = l__Character__30;
                                                        v145:Play();
                                                        game.Debris:AddItem(v145, 3);
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
return v1;