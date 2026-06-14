-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 1
};
local l__Players__1 = game:GetService("Players");
local l__UserInputService__2 = game:GetService("UserInputService");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__RunService__4 = game:GetService("RunService");
local l__GuiService__5 = game:GetService("GuiService");
local l__CollectionService__6 = game:GetService("CollectionService");
local l__SoundService__7 = game:GetService("SoundService");
local l__Networking__8 = require(l__ReplicatedStorage__3.SharedModules.Networking);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__CurrentCamera__10 = workspace.CurrentCamera;
local l__Gardens__11 = workspace:WaitForChild("Gardens");
local l__Props__12 = l__ReplicatedStorage__3:WaitForChild("Assets"):WaitForChild("Props");
local u2 = false;
local function v4() --[[ Line: 25 ]]
    -- upvalues: u2 (ref), l__UserInputService__2 (copy)
    local v3;
    if workspace.CurrentCamera.ViewportSize.X < 1000 then
        v3 = true;
    else
        v3 = l__UserInputService__2.TouchEnabled;
        if v3 then
            v3 = not l__UserInputService__2.KeyboardEnabled;
        end;
    end;
    u2 = v3;
end;
local v5;
if workspace.CurrentCamera.ViewportSize.X < 1000 then
    v5 = true;
else
    v5 = l__UserInputService__2.TouchEnabled;
    if v5 then
        v5 = not l__UserInputService__2.KeyboardEnabled;
    end;
end;
u2 = v5;
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(v4);
local function u7() --[[ Line: 40 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__SoundService__7 (copy)
    local l__Character__13 = l__LocalPlayer__9.Character;
    if l__Character__13 then
        l__Character__13 = l__Character__13:FindFirstChild("HumanoidRootPart");
    end;
    if l__Character__13 then
        local v6 = Instance.new("Sound");
        v6.SoundId = "rbxassetid://136697624359338";
        v6.Volume = 1;
        v6.SoundGroup = l__SoundService__7:FindFirstChild("SFXGroup");
        v6.Parent = l__Character__13;
        v6:Play();
        game.Debris:AddItem(v6, v6.TimeLength / math.max(v6.PlaybackSpeed, 0.01) + 1);
    end;
end;
local u8 = false;
local u9 = nil;
local u10 = nil;
local u11 = nil;
local u12 = nil;
local u13 = nil;
local u14 = nil;
local u15 = nil;
local u16 = nil;
local u17 = 0;
local u18 = nil;
local u19 = 0;
local u20 = nil;
local u21 = {};
local u22 = {};
local u23 = {};
local u24 = {};
local u25 = {};
local u26 = 0;
local function u27(...) --[[ Line: 88 ]] end;
function v1.Init(_) --[[ Line: 101 ]] end;
function v1.Start(u28) --[[ Line: 105 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u18 (ref)
    local l__Character__14 = l__LocalPlayer__9.Character;
    if l__Character__14 then
        u28:SetupCharacter(l__Character__14);
    end;
    l__LocalPlayer__9.CharacterAdded:Connect(function(p29) --[[ Line: 111 ]]
        -- upvalues: u28 (copy)
        u28:SetupCharacter(p29);
    end);
    l__LocalPlayer__9:GetAttributeChangedSignal("PlotId"):Connect(function() --[[ Line: 115 ]]
        -- upvalues: u18 (ref)
        u18 = nil;
    end);
end;
function v1.SetupCharacter(u30, p31) --[[ Line: 120 ]]
    -- upvalues: u15 (ref)
    p31.ChildAdded:Connect(function(p32) --[[ Line: 121 ]]
        -- upvalues: u15 (ref)
        if p32:IsA("Tool") and p32:GetAttribute("Build") then
            u15 = p32;
        end;
    end);
    p31.ChildRemoved:Connect(function(p33) --[[ Line: 127 ]]
        -- upvalues: u15 (ref), u30 (copy)
        if p33:IsA("Tool") and (p33:GetAttribute("Build") and u15 == p33) then
            u15 = nil;
            u30:StopPlacement();
        end;
    end);
    for _, v34 in p31:GetChildren() do
        if v34:IsA("Tool") and v34:GetAttribute("Build") then
            u15 = v34;
        end;
    end;
end;
function v1.GetPlayerPlotFolder(_) --[[ Line: 143 ]]
    -- upvalues: u18 (ref), l__LocalPlayer__9 (copy), l__Gardens__11 (copy)
    if u18 then
        return u18;
    end;
    local v35 = l__LocalPlayer__9:GetAttribute("PlotId");
    if not v35 then
        return nil;
    end;
    local v36 = l__Gardens__11:FindFirstChild("Plot" .. tostring(v35));
    if not v36 then
        return nil;
    end;
    u18 = v36;
    return u18;
end;
function v1.GetSpawnPoint(p37) --[[ Line: 158 ]]
    local v38 = p37:GetPlayerPlotFolder();
    if v38 then
        return v38:FindFirstChild("SpawnPoint");
    else
        return nil;
    end;
end;
function v1.SnapToGrid(p39, p40) --[[ Line: 164 ]]
    -- upvalues: u26 (ref), u27 (copy)
    local v41 = p39:GetSpawnPoint();
    if not v41 then
        u27("SnapToGrid: WARNING no spawnPoint, falling back to world-space snap");
        local v42 = math.round(p40.X / 0.5) * 0.5;
        local v43 = math.round(p40.Y / 0.5) * 0.5;
        local v44 = math.round(p40.Z / 0.5) * 0.5;
        return Vector3.new(v42, v43, v44);
    end;
    local v45 = v41.CFrame:PointToObjectSpace(p40);
    local v46 = math.round(v45.X / 0.5) * 0.5;
    local v47 = math.round(v45.Y / 0.5) * 0.5;
    local v48 = math.round(v45.Z / 0.5) * 0.5;
    local v49 = Vector3.new(v46, v47, v48);
    local v50 = v41.CFrame:PointToWorldSpace(v49);
    if u26 < 20 then
        u26 = u26 + 1;
        u27("SnapToGrid: worldIn=" .. string.format("(%.4f, %.4f, %.4f)", p40.X, p40.Y, p40.Z));
        local v51 = u27;
        local l__CFrame__15 = v41.CFrame;
        local v52, v53, v54 = l__CFrame__15:ToEulerAnglesYXZ();
        local l__format__16 = string.format;
        local l__Position__17 = l__CFrame__15.Position;
        v51("  spawnCFrame=" .. l__format__16("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", l__Position__17.X, l__Position__17.Y, l__Position__17.Z), math.deg(v52), math.deg(v53), (math.deg(v54))));
        u27("  localPos=" .. string.format("(%.4f, %.4f, %.4f)", v45.X, v45.Y, v45.Z));
        u27("  snappedLocal=" .. string.format("(%.4f, %.4f, %.4f)", v49.X, v49.Y, v49.Z));
        u27("  worldOut=" .. string.format("(%.4f, %.4f, %.4f)", v50.X, v50.Y, v50.Z));
        u27("  deltaXYZ local=(" .. string.format("%.4f", v45.X - v49.X) .. ", " .. string.format("%.4f", v45.Y - v49.Y) .. ", " .. string.format("%.4f", v45.Z - v49.Z) .. ")");
    end;
    return v50;
end;
function v1.CalculateYOffset(_, p55) --[[ Line: 195 ]]
    if not (p55 and p55.PrimaryPart) then
        return 0;
    end;
    local l__PrimaryPart__18 = p55.PrimaryPart;
    return l__PrimaryPart__18.Size.Y / 2 + (p55:GetPivot().Position.Y - l__PrimaryPart__18.Position.Y);
end;
function v1.CreateRaycastParams(_) --[[ Line: 207 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u9 (ref), u20 (ref)
    local v56 = RaycastParams.new();
    v56.FilterType = Enum.RaycastFilterType.Exclude;
    local v57 = {};
    local l__Character__19 = l__LocalPlayer__9.Character;
    if l__Character__19 then
        table.insert(v57, l__Character__19);
    end;
    if u9 then
        table.insert(v57, u9);
    end;
    if u20 then
        table.insert(v57, u20);
    end;
    v56.FilterDescendantsInstances = v57;
    return v56;
end;
function v1.IsTouchInJoystickZone(_, p58) --[[ Line: 230 ]]
    -- upvalues: l__CurrentCamera__10 (copy), l__GuiService__5 (copy)
    local l__ViewportSize__20 = l__CurrentCamera__10.ViewportSize;
    local v59 = l__GuiService__5:GetGuiInset();
    local v60 = p58.X / l__ViewportSize__20.X;
    local v61 = (p58.Y - v59.Y) / (l__ViewportSize__20.Y - v59.Y);
    local v62;
    if v60 < 0.3 then
        v62 = v61 > 0.6;
    else
        v62 = false;
    end;
    return v62;
end;
function v1.GetPlacementPositionFromScreen(p63, p64, p65) --[[ Line: 240 ]]
    -- upvalues: l__CurrentCamera__10 (copy), u27 (copy), u26 (ref), u19 (ref)
    local v66 = p63:CreateRaycastParams();
    local v67 = l__CurrentCamera__10:ViewportPointToRay(p64, p65);
    local l__Origin__21 = v67.Origin;
    local v68 = v67.Direction * 5000;
    for v69 = 1, 100 do
        local v70 = workspace:Raycast(l__Origin__21, v68, v66);
        if not v70 then
            u27("Raycast: iteration " .. v69 .. " hit nothing");
            return nil;
        end;
        if not v70.Instance or (not v70.Instance:IsA("BasePart") or v70.Instance.Transparency < 0.5) then
            local v71 = u27;
            local v72 = v70.Instance:GetFullName();
            local l__Position__22 = v70.Position;
            local v73 = string.format("(%.4f, %.4f, %.4f)", l__Position__22.X, l__Position__22.Y, l__Position__22.Z);
            local l__Normal__23 = v70.Normal;
            v71("Raycast: hit " .. v72 .. " at " .. v73 .. " normal=" .. string.format("(%.4f, %.4f, %.4f)", l__Normal__23.X, l__Normal__23.Y, l__Normal__23.Z));
            u26 = 0;
            local v74 = p63:SnapToGrid(v70.Position);
            local v75 = Vector3.new(v74.X, v74.Y + u19, v74.Z);
            u27("Raycast: finalPos=" .. string.format("(%.4f, %.4f, %.4f)", v75.X, v75.Y, v75.Z) .. " (yOffset=" .. string.format("%.4f", u19) .. ")");
            return v75;
        end;
        u27("Raycast: iteration " .. v69 .. " skipping transparent part: " .. v70.Instance:GetFullName() .. " transparency=" .. v70.Instance.Transparency);
        local l__Magnitude__24 = (v70.Position - l__Origin__21).Magnitude;
        l__Origin__21 = v70.Position + v67.Direction * 0.01;
        v68 = v67.Direction * (5000 - l__Magnitude__24 - 0.01);
        local v76 = table.clone(v66.FilterDescendantsInstances);
        table.insert(v76, v70.Instance);
        v66.FilterDescendantsInstances = v76;
    end;
    return nil;
end;
function v1.GetPlacementPosition(p77) --[[ Line: 280 ]]
    -- upvalues: l__UserInputService__2 (copy)
    local v78 = l__UserInputService__2:GetMouseLocation();
    return p77:GetPlacementPositionFromScreen(v78.X, v78.Y);
end;
function v1.CreatePreview(p79, p80) --[[ Line: 285 ]]
    -- upvalues: l__Props__12 (copy), u19 (ref), u27 (copy), u2 (ref)
    local v81 = l__Props__12:FindFirstChild(p80);
    if not v81 then
        return nil;
    end;
    local v82 = v81:Clone();
    for _, v83 in v82:GetDescendants() do
        if v83:IsA("BasePart") then
            v83.Transparency = 0.5;
            v83.CanCollide = false;
            v83.CanQuery = false;
            v83.CanTouch = false;
            v83.Anchored = true;
        end;
    end;
    v82.Name = "PropPreview";
    v82.Parent = workspace;
    u19 = p79:CalculateYOffset(v82);
    u27("CreatePreview: propName=" .. p80 .. " yOffset=" .. string.format("%.4f", u19));
    if u2 then
        for _, v84 in v82:GetDescendants() do
            if v84:IsA("BasePart") then
                v84.Transparency = 1;
            end;
        end;
    end;
    return v82;
end;
function v1.CreateSelectionBox(_, p85) --[[ Line: 320 ]]
    -- upvalues: u2 (ref)
    local v86 = Instance.new("SelectionBox");
    v86.Color3 = Color3.fromRGB(0, 255, 0);
    v86.LineThickness = 0.05;
    v86.Transparency = 0.3;
    v86.Adornee = p85;
    v86.Parent = p85;
    if u2 then
        v86.Visible = false;
    end;
    return v86;
end;
function v1.UpdatePreview(p87) --[[ Line: 335 ]]
    -- upvalues: u2 (ref), u9 (ref), u17 (ref), u10 (ref)
    debug.profilebegin("Controllers/PropController/UpdatePreview");
    if u2 then
        debug.profileend();
    elseif u9 and u9.PrimaryPart then
        local v88 = p87:GetPlacementPosition();
        if v88 then
            local v89 = p87:GetGardenRotationY();
            local v90 = CFrame.Angles(0, v89 + math.rad(u17), 0);
            u9:PivotTo(CFrame.new(v88) * v90);
            if u10 then
                u10.Color3 = p87:CanPlace() and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0);
            end;
            debug.profileend();
        else
            debug.profileend();
        end;
    else
        debug.profileend();
    end;
end;
function v1.CanPlace(p91) --[[ Line: 364 ]]
    -- upvalues: u9 (ref)
    if p91:GetPlayerPlotFolder() then
        return u9 and u9.PrimaryPart and true or false;
    else
        return false;
    end;
end;
function v1.IsPlacing(_) --[[ Line: 371 ]]
    -- upvalues: u8 (ref)
    return u8;
end;
function v1.GetCurrentPropName(_) --[[ Line: 375 ]]
    -- upvalues: u16 (ref)
    return u16;
end;
function v1.UnequipTool(_) --[[ Line: 379 ]]
    -- upvalues: l__LocalPlayer__9 (copy)
    local l__Character__25 = l__LocalPlayer__9.Character;
    local v92 = l__Character__25 and l__Character__25:FindFirstChildOfClass("Humanoid");
    if v92 then
        v92:UnequipTools();
    end;
end;
function v1.OnPlacementInput(p93, p94, p95) --[[ Line: 389 ]]
    -- upvalues: u8 (ref), u2 (ref), u21 (copy)
    if u8 then
        if u2 then
            if p94.UserInputType == Enum.UserInputType.Touch then
                u21[p94] = {
                    startTime = tick(),
                    startPos = p94.Position
                };
            end;
        elseif p95 then
        elseif p94.UserInputType == Enum.UserInputType.MouseButton1 and true or p94.KeyCode == Enum.KeyCode.ButtonR2 then
            p93:PlaceProp();
        elseif p94.KeyCode == Enum.KeyCode.R and true or p94.KeyCode == Enum.KeyCode.ButtonR1 then
            p93:RotateProp(45);
        end;
    end;
end;
function v1.OnPlacementInputEnded(p96, p97, _) --[[ Line: 418 ]]
    -- upvalues: u8 (ref), u2 (ref), u21 (copy)
    if u8 then
        if u2 then
            if p97.UserInputType == Enum.UserInputType.Touch then
                local v98 = u21[p97];
                u21[p97] = nil;
                if v98 then
                    local v99 = tick() - v98.startTime;
                    local l__Magnitude__26 = (p97.Position - v98.startPos).Magnitude;
                    if v99 > 0.3 then
                    elseif l__Magnitude__26 > 30 then
                    else
                        local l__Position__27 = p97.Position;
                        if p96:IsTouchInJoystickZone((Vector2.new(l__Position__27.X, l__Position__27.Y))) then
                        else
                            p96:PlacePropAtScreen(l__Position__27.X, l__Position__27.Y);
                        end;
                    end;
                end;
            end;
        end;
    end;
end;
function v1.StartPlacement(u100, p101) --[[ Line: 450 ]]
    -- upvalues: u8 (ref), u15 (ref), u16 (ref), u17 (ref), u9 (ref), u10 (ref), u27 (copy), u11 (ref), l__RunService__4 (copy), u12 (ref), l__UserInputService__2 (copy), u2 (ref), u13 (ref), u14 (ref), u25 (copy), u22 (copy)
    if u8 then
        u100:StopPlacement();
    end;
    if u15 then
        u8 = true;
        u16 = p101;
        u17 = 0;
        u9 = u100:CreatePreview(p101);
        if u9 then
            u10 = u100:CreateSelectionBox(u9);
            u100:CreateGrid();
            local v102 = u100:GetSpawnPoint();
            if v102 then
                local v103 = u27;
                local l__CFrame__28 = v102.CFrame;
                local v104, v105, v106 = l__CFrame__28:ToEulerAnglesYXZ();
                local l__format__29 = string.format;
                local l__Position__30 = l__CFrame__28.Position;
                v103("StartPlacement: spawnPoint=" .. l__format__29("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", l__Position__30.X, l__Position__30.Y, l__Position__30.Z), math.deg(v104), math.deg(v105), (math.deg(v106))));
                local v107 = u27;
                local l__format__31 = string.format;
                local v108 = u100:GetGardenRotationY();
                v107("StartPlacement: gardenRotY=" .. l__format__31("%.4f deg", (math.deg(v108))));
            else
                u27("StartPlacement: WARNING spawnPoint is nil!");
            end;
            u11 = l__RunService__4.RenderStepped:Connect(function() --[[ Line: 481 ]]
                -- upvalues: u100 (copy)
                debug.profilebegin("Controllers/PropController/PreviewUpdate");
                u100:UpdatePreview();
                debug.profileend();
            end);
            u12 = l__UserInputService__2.InputBegan:Connect(function(p109, p110) --[[ Line: 487 ]]
                -- upvalues: u100 (copy)
                u100:OnPlacementInput(p109, p110);
            end);
            if u2 then
                u13 = l__UserInputService__2.InputEnded:Connect(function(p111, p112) --[[ Line: 492 ]]
                    -- upvalues: u100 (copy)
                    u100:OnPlacementInputEnded(p111, p112);
                end);
            end;
            if u15 then
                u14 = u15.AttributeChanged:Connect(function(p113) --[[ Line: 498 ]]
                    -- upvalues: u15 (ref), u100 (copy), u25 (ref), u16 (ref)
                    if p113 == "RemainingCount" then
                        local v114 = u15:GetAttribute("RemainingCount");
                        if v114 and v114 <= 0 then
                            u100:StopPlacement();
                            u100:UnequipTool();
                            for _, v115 in u25 do
                                task.spawn(v115, u16);
                            end;
                        end;
                    end;
                end);
            end;
            for _, v116 in u22 do
                task.spawn(v116, p101);
            end;
        else
            u8 = false;
        end;
    end;
end;
function v1.StopPlacement(p117) --[[ Line: 518 ]]
    -- upvalues: u8 (ref), u16 (ref), u17 (ref), u19 (ref), u21 (copy), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u10 (ref), u9 (ref), u23 (copy)
    local v118 = u8;
    local v119 = u16;
    u8 = false;
    u16 = nil;
    u17 = 0;
    u19 = 0;
    table.clear(u21);
    if u11 then
        u11:Disconnect();
        u11 = nil;
    end;
    if u12 then
        u12:Disconnect();
        u12 = nil;
    end;
    if u13 then
        u13:Disconnect();
        u13 = nil;
    end;
    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;
    p117:DestroyGrid();
    if u10 then
        u10:Destroy();
        u10 = nil;
    end;
    if u9 then
        u9:Destroy();
        u9 = nil;
    end;
    if v118 then
        for _, v120 in u23 do
            task.spawn(v120, v119);
        end;
    end;
end;
function v1.GetGardenRotationY(p121) --[[ Line: 569 ]]
    local v122 = p121:GetSpawnPoint();
    if not v122 then
        return 0;
    end;
    local _, v123, _ = v122.CFrame:ToEulerAnglesYXZ();
    return v123;
end;
function v1.RotateProp(_, p124) --[[ Line: 576 ]]
    -- upvalues: u17 (ref)
    u17 = (u17 + p124) % 360;
end;
function v1.CreateGrid(p125) --[[ Line: 580 ]]
    -- upvalues: u27 (copy), l__CollectionService__6 (copy), u20 (ref)
    p125:DestroyGrid();
    local v126 = p125:GetSpawnPoint();
    local v127 = p125:GetPlayerPlotFolder();
    if not v126 then
        u27("CreateGrid: ABORT - no spawnPoint");
        return;
    end;
    if not v127 then
        u27("CreateGrid: ABORT - no plot");
        return;
    end;
    local v128 = u27;
    local l__CFrame__32 = v126.CFrame;
    local v129, v130, v131 = l__CFrame__32:ToEulerAnglesYXZ();
    local l__format__33 = string.format;
    local l__Position__34 = l__CFrame__32.Position;
    v128("CreateGrid: spawnPoint=" .. l__format__33("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", l__Position__34.X, l__Position__34.Y, l__Position__34.Z), math.deg(v129), math.deg(v130), (math.deg(v131))));
    local v132 = nil;
    for _, v133 in v127:GetDescendants() do
        if v133:IsA("BasePart") and l__CollectionService__6:HasTag(v133, "PropArea") then
            v132 = v133;
            break;
        end;
    end;
    if v132 then
        u27("CreateGrid: propArea=" .. v132:GetFullName());
        local v134 = u27;
        local l__Size__35 = v132.Size;
        v134("CreateGrid: propArea.Size=" .. string.format("(%.4f, %.4f, %.4f)", l__Size__35.X, l__Size__35.Y, l__Size__35.Z));
        local v135 = u27;
        local l__CFrame__36 = v132.CFrame;
        local v136, v137, v138 = l__CFrame__36:ToEulerAnglesYXZ();
        local l__format__37 = string.format;
        local l__Position__38 = l__CFrame__36.Position;
        v135("CreateGrid: propArea.CFrame=" .. l__format__37("pos=%s rot=(%.2f, %.2f, %.2f)deg", string.format("(%.4f, %.4f, %.4f)", l__Position__38.X, l__Position__38.Y, l__Position__38.Z), math.deg(v136), math.deg(v137), (math.deg(v138))));
        u27("CreateGrid: propArea.Transparency=" .. v132.Transparency);
        local v139 = Instance.new("Folder");
        v139.Name = "PlacementGrid";
        local v140 = v126.CFrame:PointToObjectSpace(v132.Position);
        local v141 = v132.Size.X / 2 + 0.5;
        local v142 = v132.Size.Z / 2 + 0.5;
        u27("CreateGrid: areaLocalCenter=" .. string.format("(%.4f, %.4f, %.4f)", v140.X, v140.Y, v140.Z));
        u27("CreateGrid: halfX=" .. v141 .. " halfZ=" .. v142);
        local v143 = math.ceil((v140.X - v141) / 0.5) * 0.5;
        local v144 = math.floor((v140.X + v141) / 0.5) * 0.5;
        local v145 = math.ceil((v140.Z - v142) / 0.5) * 0.5;
        local v146 = math.floor((v140.Z + v142) / 0.5) * 0.5;
        u27("CreateGrid: grid bounds local X=[" .. v143 .. ", " .. v144 .. "] Z=[" .. v145 .. ", " .. v146 .. "]");
        local v147 = v132.Position.Y + v132.Size.Y / 2 + 0.05;
        u27("CreateGrid: gridY=" .. string.format("%.4f", v147));
        local v148 = v144 - v143;
        local v149 = v146 - v145;
        if v148 <= 0 or v149 <= 0 then
            u27("CreateGrid: ABORT - zero or negative grid dimensions: xLength=" .. v148 .. " zLength=" .. v149);
        else
            local v150 = (v143 + v144) / 2;
            local v151 = (v145 + v146) / 2;
            local v152 = Color3.fromRGB(0, 170, 255);
            local _, v153, _ = v126.CFrame:ToEulerAnglesYXZ();
            local v154 = 0;
            for v155 = 0, math.round((v146 - v145) / 0.5) do
                local v156 = v126.CFrame:PointToWorldSpace((Vector3.new(v150, 0, v145 + v155 * 0.5)));
                local v157 = Vector3.new(v156.X, v147, v156.Z);
                local v158 = Instance.new("Part");
                v158.Anchored = true;
                v158.CanCollide = false;
                v158.CanQuery = false;
                v158.CanTouch = false;
                v158.CastShadow = false;
                v158.Material = Enum.Material.Neon;
                v158.Color = v152;
                v158.Transparency = 0.5;
                v158.Size = Vector3.new(v148, 0.1, 0.1);
                v158.CFrame = CFrame.new(v157) * CFrame.Angles(0, v153, 0);
                v158.Parent = v139;
                v154 = v154 + 1;
            end;
            for v159 = 0, math.round((v144 - v143) / 0.5) do
                local v160 = v126.CFrame:PointToWorldSpace((Vector3.new(v143 + v159 * 0.5, 0, v151)));
                local v161 = Vector3.new(v160.X, v147, v160.Z);
                local v162 = Instance.new("Part");
                v162.Anchored = true;
                v162.CanCollide = false;
                v162.CanQuery = false;
                v162.CanTouch = false;
                v162.CastShadow = false;
                v162.Material = Enum.Material.Neon;
                v162.Color = v152;
                v162.Transparency = 0.5;
                v162.Size = Vector3.new(0.1, 0.1, v149);
                v162.CFrame = CFrame.new(v161) * CFrame.Angles(0, v153, 0);
                v162.Parent = v139;
                v154 = v154 + 1;
            end;
            u27("CreateGrid: created " .. v154 .. " grid lines");
            v139.Parent = workspace;
            u20 = v139;
            u27("CreateGrid: done, folder parented to workspace");
        end;
    else
        u27("CreateGrid: ABORT - no PropArea found in plot descendants");
        u27("CreateGrid: listing plot descendants with tags:");
        for _, v163 in v127:GetDescendants() do
            if v163:IsA("BasePart") then
                local v164 = l__CollectionService__6:GetTags(v163);
                if #v164 > 0 then
                    u27("  " .. v163:GetFullName() .. " tags=" .. table.concat(v164, ","));
                end;
            end;
        end;
    end;
end;
function v1.DestroyGrid(_) --[[ Line: 711 ]]
    -- upvalues: u20 (ref)
    if u20 then
        u20:Destroy();
        u20 = nil;
    end;
end;
function v1.PlacePropAtScreen(p165, p166, p167) --[[ Line: 718 ]]
    -- upvalues: u8 (ref), u9 (ref), u16 (ref), u17 (ref), u15 (ref), u27 (copy), l__Networking__8 (copy), u7 (copy), u24 (copy)
    if u8 and (u9 and u16) then
        local v168 = p165:GetPlacementPositionFromScreen(p166, p167);
        if v168 then
            local v169 = p165:GetGardenRotationY();
            local v170 = CFrame.Angles(0, v169 + math.rad(u17), 0);
            u9:PivotTo(CFrame.new(v168) * v170);
            if p165:CanPlace() then
                local v171 = u15;
                if v171 then
                    local v172 = u16;
                    local v173 = math.deg(v169) + u17;
                    u27("PlacePropAtScreen: pos=" .. string.format("(%.4f, %.4f, %.4f)", v168.X, v168.Y, v168.Z) .. " gardenRotY=" .. string.format("%.2f", (math.deg(v169))) .. " currentRot=" .. u17 .. " worldRot=" .. string.format("%.2f", v173));
                    l__Networking__8.Prop.PlaceProp:Fire(v168, v172, v171, v173);
                    u7();
                    for _, v174 in u24 do
                        task.spawn(v174, v172, v168, v173);
                    end;
                end;
            end;
        end;
    end;
end;
function v1.PlaceProp(p175) --[[ Line: 755 ]]
    -- upvalues: u8 (ref), u9 (ref), u16 (ref), u15 (ref), u17 (ref), u27 (copy), l__Networking__8 (copy), u7 (copy), u24 (copy)
    if u8 and (u9 and u16) then
        if p175:CanPlace() then
            local v176 = p175:GetPlacementPosition();
            if v176 then
                local v177 = u15;
                if v177 then
                    local v178 = u16;
                    local v179 = p175:GetGardenRotationY();
                    local v180 = math.deg(v179) + u17;
                    u27("PlaceProp: pos=" .. string.format("(%.4f, %.4f, %.4f)", v176.X, v176.Y, v176.Z) .. " gardenRotY=" .. string.format("%.2f", (math.deg(v179))) .. " currentRot=" .. u17 .. " worldRot=" .. string.format("%.2f", v180));
                    l__Networking__8.Prop.PlaceProp:Fire(v176, v178, v177, v180);
                    u7();
                    for _, v181 in u24 do
                        task.spawn(v181, v178, v176, v180);
                    end;
                end;
            end;
        end;
    end;
end;
function v1.OnPlacementStarted(_, p182) --[[ Line: 779 ]]
    -- upvalues: u22 (copy)
    table.insert(u22, p182);
end;
function v1.OnPlacementStopped(_, p183) --[[ Line: 783 ]]
    -- upvalues: u23 (copy)
    table.insert(u23, p183);
end;
function v1.OnPropPlaced(_, p184) --[[ Line: 787 ]]
    -- upvalues: u24 (copy)
    table.insert(u24, p184);
end;
function v1.OnOutOfProps(_, p185) --[[ Line: 791 ]]
    -- upvalues: u25 (copy)
    table.insert(u25, p185);
end;
return v1;