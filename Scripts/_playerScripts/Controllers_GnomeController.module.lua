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
local l__SoundService__7 = game:GetService("SoundService");
local l__BillboardGui__8 = script.BillboardGui;
local _ = l__BillboardGui__8.TextLabel.TextLabel;
local l__Networking__9 = require(l__ReplicatedStorage__5.SharedModules.Networking);
local l__LocalPlayer__10 = l__Players__1.LocalPlayer;
local l__CurrentCamera__11 = workspace.CurrentCamera;
local l__Assets__12 = l__ReplicatedStorage__5.Assets;
local l__Gnome__13 = l__Assets__12:WaitForChild("Gnome");
local l__Temporary__14 = workspace.Temporary;
local u2 = 0;
local function u8(p3, p4, p5) --[[ Line: 35 ]]
    for _ = 1, 10 do
        local v6 = workspace:Raycast(p3, p4, p5);
        if not v6 then
            return nil;
        end;
        if v6.Instance.Transparency < 1 then
            return v6;
        end;
        local v7 = table.clone(p5.FilterDescendantsInstances);
        table.insert(v7, v6.Instance);
        p5.FilterDescendantsInstances = v7;
    end;
    return nil;
end;
local u9 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true);
local u10 = Color3.fromRGB(100, 255, 100);
local u11 = Color3.fromRGB(255, 100, 100);
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local l__Gnomes__15 = workspace:WaitForChild("Gnomes");
local u17 = Instance.new("Folder");
u17.Name = "GnomeVisuals";
u17.Parent = workspace;
local u18 = {};
local u19 = {};
l__Networking__9.Gnome.Positions.OnClientEvent:Connect(function(p20) --[[ Line: 77 ]]
    -- upvalues: u19 (copy)
    if typeof(p20) == "table" then
        for _, v21 in p20 do
            local v22 = v21[1];
            local v23 = v21[2];
            if typeof(v22) == "Instance" and (v22:IsA("BasePart") and typeof(v23) == "Vector3") then
                u19[v22] = v23;
            end;
        end;
    end;
end);
local u24 = nil;
local function u29(p25) --[[ Line: 107 ]]
    -- upvalues: l__Assets__12 (copy), u19 (copy)
    if p25.RangeIndicator then
    else
        local v26 = p25.Part:GetAttribute("Range") or 50;
        local v27 = l__Assets__12.SprinklerRadius:Clone();
        v27.Name = "GnomeRangeIndicator";
        v27.Size = Vector3.new(v26, 0.5, v26);
        v27.Anchored = true;
        v27.CanCollide = false;
        v27.CanQuery = false;
        v27.CanTouch = false;
        local v28 = u19[p25.Part] or p25.Part.Position;
        v27.CFrame = CFrame.new(v28.X, v28.Y - p25.Part.Size.Y / 2 + 0.1, v28.Z);
        p25.RangeIndicator = v27;
    end;
end;
local function u40() --[[ Line: 146 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__UserInputService__2 (copy), l__CurrentCamera__11 (copy), u18 (copy), u24 (ref), u29 (copy), l__Temporary__14 (copy)
    if not l__LocalPlayer__10.Character then
        return;
    end;
    local v30 = l__UserInputService__2:GetMouseLocation();
    local v31 = l__CurrentCamera__11:ViewportPointToRay(v30.X, v30.Y);
    local v32 = {};
    for _, v33 in u18 do
        if v33.Model and v33.Model.Parent then
            table.insert(v32, v33.Model);
        end;
    end;
    if #v32 == 0 then
        if u24 then
            local v34 = u24;
            if v34.RangeIndicator then
                v34.RangeIndicator.Parent = nil;
            end;
            v34.IsHovered = false;
            u24 = nil;
        end;
        return;
    end;
    local v35 = RaycastParams.new();
    v35.FilterType = Enum.RaycastFilterType.Include;
    v35.FilterDescendantsInstances = v32;
    local v36 = workspace:Raycast(v31.Origin, v31.Direction * 500, v35);
    local v37 = nil;
    if v36 and v36.Instance then
        for _, v38 in u18 do
            if v38.Part:GetAttribute("Owner") == l__LocalPlayer__10.Name and (v36.Instance:IsDescendantOf(v38.Model) or v36.Instance == v38.Model.PrimaryPart) then
                v37 = v38;
                break;
            end;
        end;
    end;
    if v37 ~= u24 then
        if u24 then
            local v39 = u24;
            if v39.RangeIndicator then
                v39.RangeIndicator.Parent = nil;
            end;
            v39.IsHovered = false;
        end;
        if v37 then
            if not v37.RangeIndicator then
                u29(v37);
            end;
            local l__RangeIndicator__16 = v37.RangeIndicator;
            if l__RangeIndicator__16 then
                l__RangeIndicator__16.Parent = l__Temporary__14;
                v37.IsHovered = true;
            end;
        end;
        u24 = v37;
    end;
end;
local function u63(u41) --[[ Line: 203 ]]
    -- upvalues: u18 (copy), l__Gnome__13 (copy), u19 (copy), u17 (copy), l__BillboardGui__8 (copy)
    if u18[u41] then
    else
        local v42 = l__Gnome__13:Clone();
        v42.Name = "GnomeVisual_" .. u41.Name;
        local v43 = v42:FindFirstChildOfClass("AnimationController");
        if not v43 then
            v43 = Instance.new("AnimationController");
            v43.Parent = v42;
        end;
        local u44 = v43:FindFirstChildOfClass("Animator");
        if not u44 then
            u44 = Instance.new("Animator");
            u44.Parent = v43;
        end;
        local l__PrimaryPart__17 = v42.PrimaryPart;
        if l__PrimaryPart__17 then
            l__PrimaryPart__17.Anchored = true;
        end;
        for _, v45 in v42:GetDescendants() do
            if v45:IsA("BasePart") and v45 ~= l__PrimaryPart__17 then
                v45.Anchored = false;
            end;
            if v45:IsA("BasePart") then
                v45.CanCollide = false;
                v45.CanQuery = true;
                v45.CanTouch = false;
            end;
        end;
        local v46 = (u19[u41] or u41.Position) + Vector3.new(0, 0, 0);
        local _, v47, _ = u41.CFrame:ToEulerAnglesYXZ();
        local v48 = CFrame.new(v46) * CFrame.Angles(0, v47, 0);
        if l__PrimaryPart__17 then
            v42:PivotTo(v48);
        end;
        v42.Parent = u17;
        local v49 = {};
        local v50 = {};
        for _, v51 in v42:GetChildren() do
            if v51:IsA("Animation") then
                v49[v51.Name] = v51;
            end;
        end;
        local v52 = v42:FindFirstChild("Animations");
        if v52 then
            for _, v53 in v52:GetChildren() do
                if v53:IsA("Animation") then
                    v49[v53.Name] = v53;
                end;
            end;
        end;
        for v54, u55 in v49 do
            local v56, v57 = pcall(function() --[[ Line: 269 ]]
                -- upvalues: u44 (ref), u55 (copy)
                return u44:LoadAnimation(u55);
            end);
            if v56 and v57 then
                v50[v54] = v57;
                if v54 == "Idle" or v54 == "Walk" then
                    v57.Looped = true;
                elseif v54 == "Attack" then
                    v57.Looped = false;
                end;
            end;
        end;
        local v58 = l__BillboardGui__8:Clone();
        if l__PrimaryPart__17 then
            v58.Adornee = l__PrimaryPart__17;
            v58.Parent = l__PrimaryPart__17;
        end;
        local u59 = {
            CurrentState = "",
            AttributeConn = nil,
            RangeIndicator = nil,
            IsHovered = false,
            Part = u41,
            Model = v42,
            Animator = u44,
            Tracks = v50,
            CurrentCF = v48,
            Billboard = v58
        };
        u59.AttributeConn = u41.AttributeChanged:Connect(function(p60) --[[ Line: 304 ]]
            -- upvalues: u41 (copy), u59 (copy)
            if p60 == "GnomeState" then
                local v61 = u41:GetAttribute("GnomeState");
                switchAnimation(u59, v61);
            end;
        end);
        u18[u41] = u59;
        local v62 = u41:GetAttribute("GnomeState") or "idle";
        switchAnimation(u59, v62);
    end;
end;
function switchAnimation(p64, p65)
    if p64.CurrentState == p65 then
    else
        p64.CurrentState = p65;
        for _, v66 in p64.Tracks do
            if v66.IsPlaying then
                v66:Stop(0.2);
            end;
        end;
        local v67 = p65 == "idle" and "Idle" or ((p65 == "wandering" or p65 == "chasing") and "Walk" or (p65 == "attacking" and "Attack" or nil));
        if v67 and p64.Tracks[v67] then
            p64.Tracks[v67]:Play(0.2);
        end;
    end;
end;
local function u71(p68) --[[ Line: 342 ]]
    -- upvalues: u18 (copy), u24 (ref), u19 (copy)
    local v69 = u18[p68];
    if v69 then
        if u24 == v69 then
            u24 = nil;
        end;
        if v69.AttributeConn then
            v69.AttributeConn:Disconnect();
        end;
        if v69.RangeIndicator then
            v69.RangeIndicator:Destroy();
        end;
        if v69.Billboard then
            v69.Billboard:Destroy();
        end;
        for _, v70 in v69.Tracks do
            v70:Stop(0);
            v70:Destroy();
        end;
        if v69.Model then
            v69.Model:Destroy();
        end;
        u19[p68] = nil;
        u18[p68] = nil;
    end;
end;
function v1.Init(_) --[[ Line: 380 ]] end;
function v1.Start(u72) --[[ Line: 383 ]]
    -- upvalues: l__UserInputService__2 (copy), l__LocalPlayer__10 (copy)
    l__UserInputService__2.InputBegan:Connect(function(p73, p74) --[[ Line: 384 ]]
        -- upvalues: u72 (copy)
        u72:OnInput(p73, p74);
    end);
    l__UserInputService__2.TouchTapInWorld:Connect(function(p75, p76) --[[ Line: 391 ]]
        -- upvalues: u72 (copy)
        if p76 then
        else
            local v77 = u72:GetEquippedTool();
            if v77 and v77:GetAttribute("Gnome") then
                u72:TryPlace(p75);
            end;
        end;
    end);
    local l__Character__18 = l__LocalPlayer__10.Character;
    if l__Character__18 then
        u72:SetupCharacter(l__Character__18);
    end;
    l__LocalPlayer__10.CharacterAdded:Connect(function(p78) --[[ Line: 404 ]]
        -- upvalues: u72 (copy)
        u72:SetupCharacter(p78);
    end);
    u72:StartGnomeVisuals();
end;
function v1.StartGnomeVisuals(_) --[[ Line: 411 ]]
    -- upvalues: l__Gnomes__15 (copy), u63 (copy), u71 (copy), l__RunService__6 (copy), u18 (copy), u19 (copy), u40 (copy)
    for _, v79 in l__Gnomes__15:GetChildren() do
        if v79:IsA("BasePart") then
            u63(v79);
        end;
    end;
    l__Gnomes__15.ChildAdded:Connect(function(p80) --[[ Line: 418 ]]
        -- upvalues: u63 (ref)
        if p80:IsA("BasePart") then
            u63(p80);
        end;
    end);
    l__Gnomes__15.ChildRemoved:Connect(function(p81) --[[ Line: 424 ]]
        -- upvalues: u71 (ref)
        if p81:IsA("BasePart") then
            u71(p81);
        end;
    end);
    l__RunService__6.RenderStepped:Connect(function(p82) --[[ Line: 431 ]]
        -- upvalues: u18 (ref), u71 (ref), u19 (ref), u40 (ref)
        debug.profilebegin("Controllers/GnomeController/RenderStepped");
        local v83 = math.min(1, 15 * p82);
        for v84, v85 in u18 do
            if v84 and v84.Parent then
                local l__Model__19 = v85.Model;
                if l__Model__19 and l__Model__19.PrimaryPart then
                    local v86 = (u19[v84] or v84.Position) + Vector3.new(0, 0, 0);
                    local l__Position__20 = v85.CurrentCF.Position;
                    local v87 = l__Position__20:Lerp(v86, v83);
                    local v88 = v86.X - l__Position__20.X;
                    local v89 = v86.Z - l__Position__20.Z;
                    local v90;
                    if v88 * v88 + v89 * v89 > 0.01 and (v85.CurrentState == "wandering" or v85.CurrentState == "chasing") then
                        local v91 = v87 + Vector3.new(v88, 0, v89);
                        v90 = CFrame.lookAt(v87, v91);
                    else
                        local _, v92, _ = v85.CurrentCF:ToEulerAnglesYXZ();
                        v90 = CFrame.new(v87) * CFrame.Angles(0, v92, 0);
                    end;
                    v85.CurrentCF = v90;
                    l__Model__19.PrimaryPart.CFrame = v90;
                    if v85.RangeIndicator and v85.IsHovered then
                        local v93 = u19[v84] or v84.Position;
                        v85.RangeIndicator.CFrame = CFrame.new(v93.X, v93.Y - v84.Size.Y / 2 + 0.1, v93.Z);
                    end;
                    if v85.Billboard then
                        local v94 = v84:GetAttribute("PlacedAt");
                        local v95 = v84:GetAttribute("Lifetime") or 600;
                        if v94 then
                            local v96 = v95 - (workspace:GetServerTimeNow() - v94);
                            local v97 = math.ceil(v96);
                            local v98 = math.max(0, v97);
                            local v99 = math.floor(v98 / 60);
                            local v100 = v98 % 60;
                            local v101 = v85.Billboard:FindFirstChild("TextLabel");
                            if v101 then
                                v101.Text = string.format("%d:%02d", v99, v100);
                                local v102 = v101:FindFirstChild("TextLabel");
                                if v102 then
                                    v102.Text = string.format("%d:%02d", v99, v100);
                                end;
                            end;
                        end;
                    end;
                end;
            else
                u71(v84);
            end;
        end;
        u40();
        debug.profileend();
    end);
end;
function v1.SetupCharacter(u103, p104) --[[ Line: 505 ]]
    p104.ChildAdded:Connect(function(p105) --[[ Line: 506 ]]
        -- upvalues: u103 (copy)
        if p105:IsA("Tool") and p105:GetAttribute("Gnome") then
            u103:CreatePreview();
        end;
    end);
    p104.ChildRemoved:Connect(function(p106) --[[ Line: 512 ]]
        -- upvalues: u103 (copy)
        if p106:IsA("Tool") and p106:GetAttribute("Gnome") then
            u103:DestroyPreview();
        end;
    end);
    for _, v107 in p104:GetChildren() do
        if v107:IsA("Tool") and v107:GetAttribute("Gnome") then
            u103:CreatePreview();
        end;
    end;
end;
function v1.CreatePreview(u108) --[[ Line: 525 ]]
    -- upvalues: u12 (ref), l__Gnome__13 (copy), l__Assets__12 (copy), u13 (ref), u15 (ref), l__TweenService__4 (copy), u9 (copy), u16 (ref), l__Temporary__14 (copy), u14 (ref), l__RunService__6 (copy)
    u108:DestroyPreview();
    u12 = l__Gnome__13:Clone();
    u12.Name = "GnomePreview";
    local v109 = l__Assets__12.SprinklerRadius:Clone();
    v109.Size = Vector3.new(50, 0.5, 50);
    v109.Anchored = true;
    v109.CanCollide = false;
    v109.CanQuery = false;
    v109.CanTouch = false;
    v109.Parent = u12;
    u13 = v109;
    local u110 = v109:FindFirstChild("SurfaceGui");
    if u110 then
        local u111 = u110:FindFirstChild("PrimaryCircle");
        if u111 and u111:IsA("ImageLabel") then
            u15 = l__TweenService__4:Create(u111, u9, {
                ImageTransparency = 0.5
            });
            u16 = task.spawn(function() --[[ Line: 550 ]]
                -- upvalues: u13 (ref), u111 (copy), u110 (copy), l__TweenService__4 (ref)
                while u13 do
                    local u112 = u111:Clone();
                    local v113 = u112:FindFirstChildOfClass("UIScale");
                    if not v113 then
                        v113 = Instance.new("UIScale");
                        v113.Parent = u112;
                    end;
                    u112.Parent = u110;
                    v113.Scale = 0;
                    local v114 = TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                    l__TweenService__4:Create(v113, v114, {
                        Scale = 1
                    }):Play();
                    local v115 = l__TweenService__4:Create(u112, v114, {
                        ImageTransparency = 0
                    });
                    v115:Play();
                    v115.Completed:Once(function() --[[ Line: 568 ]]
                        -- upvalues: l__TweenService__4 (ref), u112 (copy)
                        local v116 = l__TweenService__4:Create(u112, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            ImageTransparency = 1
                        });
                        v116:Play();
                        v116.Completed:Once(function() --[[ Line: 572 ]]
                            -- upvalues: u112 (ref)
                            u112:Destroy();
                        end);
                    end);
                    task.wait(1.1);
                end;
            end);
        end;
    end;
    for _, v117 in u12:GetDescendants() do
        if v117:IsA("BasePart") then
            if v117.Transparency == 0 then
                v117.Transparency = 0.5;
            end;
            v117.CanCollide = false;
            v117.CanQuery = false;
            v117.CanTouch = false;
            v117.Anchored = true;
        elseif v117:IsA("ParticleEmitter") then
            v117.Enabled = false;
        end;
    end;
    u12.Parent = l__Temporary__14;
    u14 = l__RunService__6.RenderStepped:Connect(function() --[[ Line: 598 ]]
        -- upvalues: u108 (copy)
        debug.profilebegin("Controllers/GnomeController/PreviewUpdate");
        u108:UpdatePreview();
        debug.profileend();
    end);
end;
function v1.DestroyPreview(_) --[[ Line: 605 ]]
    -- upvalues: u16 (ref), u15 (ref), u12 (ref), u13 (ref), u14 (ref)
    if u16 then
        task.cancel(u16);
        u16 = nil;
    end;
    if u15 then
        u15:Cancel();
        u15 = nil;
    end;
    if u12 then
        u12:Destroy();
        u12 = nil;
    end;
    u13 = nil;
    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;
end;
function v1.SetPreviewColor(_, p118) --[[ Line: 629 ]]
    -- upvalues: u12 (ref)
    if u12 then
        for _, v119 in u12:GetDescendants() do
            if v119:IsA("BasePart") then
                v119.Color = p118;
            end;
        end;
    end;
end;
function v1.IsUsingGamepad(_) --[[ Line: 639 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local v120 = l__UserInputService__2:GetLastInputType();
    return (v120 == Enum.UserInputType.Gamepad1 or (v120 == Enum.UserInputType.Gamepad2 or v120 == Enum.UserInputType.Gamepad3)) and true or v120 == Enum.UserInputType.Gamepad4;
end;
function v1.GetGamepadPlacementRay(_) --[[ Line: 647 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local l__Character__21 = l__LocalPlayer__10.Character;
    if l__Character__21 then
        local v121 = l__Character__21:FindFirstChild("HumanoidRootPart");
        if v121 then
            return v121.Position + v121.CFrame.LookVector * 8 + Vector3.new(0, 50, 0), Vector3.new(0, -100, 0);
        else
            return nil;
        end;
    else
        return nil;
    end;
end;
function v1.CreateRaycastParams(_) --[[ Line: 662 ]]
    -- upvalues: l__LocalPlayer__10 (copy), l__Temporary__14 (copy), u17 (copy)
    local v122 = RaycastParams.new();
    v122.FilterType = Enum.RaycastFilterType.Exclude;
    local l__Character__22 = l__LocalPlayer__10.Character;
    local v123 = { l__Temporary__14, u17 };
    if l__Character__22 then
        table.insert(v123, l__Character__22);
    end;
    v122.FilterDescendantsInstances = v123;
    return v122;
end;
local u124 = nil;
local function u126() --[[ Line: 679 ]]
    -- upvalues: u124 (ref), l__LocalPlayer__10 (copy)
    if u124 and u124.Parent then
        return u124;
    end;
    u124 = nil;
    for _, v125 in workspace.Gardens:GetChildren() do
        if v125:GetAttribute("Owner") == l__LocalPlayer__10.Name then
            u124 = v125;
            break;
        end;
    end;
    return u124;
end;
local function u129(p127) --[[ Line: 693 ]]
    -- upvalues: l__CollectionService__3 (copy)
    for _, v128 in p127:GetDescendants() do
        if v128:IsA("BasePart") and l__CollectionService__3:HasTag(v128, "GardenTotalArea") then
            return v128;
        end;
    end;
    return nil;
end;
function v1.IsValidPlacement(_, p130) --[[ Line: 702 ]]
    -- upvalues: u126 (copy), u129 (copy)
    local v131 = u126();
    if not v131 then
        return false;
    end;
    local v132 = u129(v131);
    if not v132 then
        return false;
    end;
    local v133 = p130 + Vector3.new(0, 50, 0);
    local v134 = RaycastParams.new();
    v134.FilterType = Enum.RaycastFilterType.Include;
    v134.FilterDescendantsInstances = { v132 };
    return workspace:Raycast(v133, Vector3.new(0, -100, 0), v134) ~= nil;
end;
function v1.UpdatePreview(p135) --[[ Line: 720 ]]
    -- upvalues: u12 (ref), u8 (copy), l__UserInputService__2 (copy), l__CurrentCamera__11 (copy), l__Temporary__14 (copy), u126 (copy), u124 (ref), u13 (ref), u10 (copy), u11 (copy)
    if u12 then
        local v136 = p135:CreateRaycastParams();
        local v137;
        if p135:IsUsingGamepad() then
            local v138, v139 = p135:GetGamepadPlacementRay();
            if not v138 then
                u12.Parent = nil;
                return;
            end;
            v137 = u8(v138, v139, v136);
        else
            local v140 = l__UserInputService__2:GetMouseLocation();
            local v141 = l__CurrentCamera__11:ViewportPointToRay(v140.X, v140.Y);
            v137 = u8(v141.Origin, v141.Direction * 5000, v136);
        end;
        if v137 then
            u12.Parent = l__Temporary__14;
            local l__Position__23 = v137.Position;
            local v142 = l__Position__23 + Vector3.new(0, 1.5, 0);
            u126();
            local v143 = CFrame.Angles(0, 0, 0);
            if u124 and u124:FindFirstChild("SpawnPoint") then
                v143 = (u124.SpawnPoint.CFrame - u124.SpawnPoint.CFrame.Position) * CFrame.Angles(0, 3.141592653589793, 0);
            end;
            if u12.PrimaryPart then
                u12:PivotTo(CFrame.new(v142) * v143);
            end;
            if u13 then
                u13.CFrame = CFrame.new(l__Position__23) * v143;
            end;
            if p135:IsValidPlacement(l__Position__23) then
                p135:SetPreviewColor(u10);
            else
                p135:SetPreviewColor(u11);
            end;
        else
            u12.Parent = nil;
        end;
    end;
end;
function v1.GetEquippedTool(_) --[[ Line: 779 ]]
    -- upvalues: l__LocalPlayer__10 (copy)
    local l__Character__24 = l__LocalPlayer__10.Character;
    if l__Character__24 then
        return l__Character__24:FindFirstChildWhichIsA("Tool");
    else
        return nil;
    end;
end;
function v1.OnInput(p144, p145, p146) --[[ Line: 788 ]]
    if p146 then
    elseif p145.UserInputType == Enum.UserInputType.MouseButton1 and true or p145.KeyCode == Enum.KeyCode.ButtonR2 then
        p144:TryPlace();
    end;
end;
function v1.TryPlace(p147, p148) --[[ Line: 802 ]]
    -- upvalues: u2 (ref), u8 (copy), l__UserInputService__2 (copy), l__CurrentCamera__11 (copy), u124 (ref), l__Networking__9 (copy), l__LocalPlayer__10 (copy), l__SoundService__7 (copy)
    local v149 = os.clock();
    if v149 - u2 < 0.5 then
        return false;
    end;
    local v150 = p147:GetEquippedTool();
    if not v150 then
        return false;
    end;
    local v151 = v150:GetAttribute("Gnome");
    if not v151 then
        return false;
    end;
    local v152 = p147:CreateRaycastParams();
    local v153;
    if p147:IsUsingGamepad() then
        local v154, v155 = p147:GetGamepadPlacementRay();
        if not v154 then
            return false;
        end;
        v153 = u8(v154, v155, v152);
    else
        local v156 = p148 or l__UserInputService__2:GetMouseLocation();
        local v157 = l__CurrentCamera__11:ViewportPointToRay(v156.X, v156.Y);
        v153 = u8(v157.Origin, v157.Direction * 5000, v152);
    end;
    if not v153 then
        return false;
    end;
    if not p147:IsValidPlacement(v153.Position) then
        return false;
    end;
    u2 = v149;
    local l__Position__25 = v153.Position;
    local v158;
    if u124 and u124:FindFirstChild("SpawnPoint") then
        local _, v159, _ = u124.SpawnPoint.CFrame:ToEulerAnglesYXZ();
        v158 = math.deg(v159) + 180;
    else
        v158 = 0;
    end;
    l__Networking__9.Place.PlaceGnome:Fire(l__Position__25, v151, v150, v158);
    local l__Character__26 = l__LocalPlayer__10.Character;
    if l__Character__26 then
        l__Character__26 = l__Character__26:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__26 then
        local v160 = Instance.new("Sound");
        v160.SoundId = "rbxassetid://135948019584556";
        v160.SoundGroup = l__SoundService__7:FindFirstChild("SFXGroup");
        v160.Parent = l__Character__26;
        v160:Play();
        game.Debris:AddItem(v160, 3);
    end;
    return true;
end;
return v1;