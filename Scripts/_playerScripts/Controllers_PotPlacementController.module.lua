-- Decompiled with Potassium's decompiler.

local v1 = {
    StartOrder = 8
};
local l__Players__1 = game:GetService("Players");
local l__ReplicatedStorage__2 = game:GetService("ReplicatedStorage");
local l__UserInputService__3 = game:GetService("UserInputService");
local l__RunService__4 = game:GetService("RunService");
local l__CollectionService__5 = game:GetService("CollectionService");
local l__Networking__6 = require(l__ReplicatedStorage__2.SharedModules.Networking);
local l__PlacementGrid__7 = require(l__ReplicatedStorage__2.ClientModules.PlacementGrid);
local l__NotificationController__8 = require(script.Parent.NotificationController);
local l__LocalPlayer__9 = l__Players__1.LocalPlayer;
local l__Gardens__10 = workspace:WaitForChild("Gardens");
local l__POT__11 = l__ReplicatedStorage__2.Assets.POT;
local l__Plants__12 = l__ReplicatedStorage__2.PlantGenerationModules.Plants;
local l__Fruits__13 = l__ReplicatedStorage__2.PlantGenerationModules.Fruits;
local u2 = false;
local u3 = 0;
local u4 = nil;
local u5 = false;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
local u10 = {};
local u11 = false;
local u12 = nil;
local u13 = nil;
local u14 = RaycastParams.new();
u14.FilterType = Enum.RaycastFilterType.Exclude;
local function u19() --[[ Line: 74 ]]
    -- upvalues: l__LocalPlayer__9 (copy), l__Gardens__10 (copy), u8 (ref), l__CollectionService__5 (copy)
    local v15 = l__LocalPlayer__9:GetAttribute("PlotId");
    local v16;
    if v15 then
        v16 = l__Gardens__10:FindFirstChild("Plot" .. tostring(v15));
    else
        v16 = nil;
    end;
    if v16 then
        local v17 = {};
        for _, v18 in v16:GetDescendants() do
            if v18:IsA("BasePart") and l__CollectionService__5:HasTag(v18, "PropArea") then
                table.insert(v17, v18);
            end;
        end;
        u8 = v17;
    else
        u8 = nil;
    end;
end;
local function u25(p20) --[[ Line: 90 ]]
    -- upvalues: u8 (ref)
    local v21 = u8;
    if not v21 then
        return false;
    end;
    for _, v22 in v21 do
        local v23 = v22.CFrame:PointToObjectSpace(p20);
        local v24 = v22.Size * 0.5;
        if math.abs(v23.X) <= v24.X + 0.5 and math.abs(v23.Z) <= v24.Z + 0.5 then
            return true;
        end;
    end;
    return false;
end;
local function u34(p26) --[[ Line: 120 ]]
    -- upvalues: l__LocalPlayer__9 (copy), u14 (copy), l__UserInputService__3 (copy), l__CollectionService__5 (copy)
    local v27 = {};
    local l__Character__14 = l__LocalPlayer__9.Character;
    if l__Character__14 then
        table.insert(v27, l__Character__14);
    end;
    if p26 then
        table.insert(v27, p26);
    end;
    u14.FilterDescendantsInstances = v27;
    local v28 = u14;
    local l__CurrentCamera__15 = workspace.CurrentCamera;
    local v29 = l__UserInputService__3:GetMouseLocation();
    local v30 = l__CurrentCamera__15:ViewportPointToRay(v29.X, v29.Y);
    local v31 = table.clone(v28.FilterDescendantsInstances);
    for _ = 1, 10 do
        local v32 = workspace:Raycast(v30.Origin, v30.Direction * 900, v28);
        if not v32 then
            return nil;
        end;
        local v33 = l__CollectionService__5:HasTag(v32.Instance, "PropArea") or l__CollectionService__5:HasTag(v32.Instance, "PlantArea");
        if v33 then
            v33 = math.abs(v32.Normal.Y) < 0.1;
        end;
        if v32.Instance.Transparency <= 0 and not v33 then
            return v32;
        end;
        table.insert(v31, v32.Instance);
        v28.FilterDescendantsInstances = v31;
    end;
    return nil;
end;
local function u37(p35) --[[ Line: 146 ]]
    -- upvalues: u4 (ref)
    if u4 then
        local v36 = u4:FindFirstChild("SelectionBox");
        if v36 and v36:IsA("SelectionBox") then
            v36.Color3 = p35 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0);
        end;
    end;
end;
local u38 = nil;
local function u44() --[[ Line: 190 ]]
    -- upvalues: u38 (ref), u13 (ref), l__LocalPlayer__9 (copy), u11 (ref), u2 (ref)
    if u38 then
        u38:Disconnect();
        u38 = nil;
    end;
    for _, v39 in u13:GetChildren() do
        if v39:GetAttribute("Owner") == l__LocalPlayer__9.UserId then
            for _, v40 in v39:GetDescendants() do
                if v40:IsA("BasePart") or v40:IsA("Decal") then
                    if not v40:GetAttribute("OriginalTransparency") then
                        v40:SetAttribute("OriginalTransparency", v40.Transparency);
                    end;
                    v40.Transparency = 1;
                end;
            end;
            u11 = true;
            return;
        end;
    end;
    u38 = u13.ChildAdded:Connect(function(u41) --[[ Line: 214 ]]
        -- upvalues: u2 (ref), u38 (ref), l__LocalPlayer__9 (ref), u11 (ref)
        if u2 then
            if u41:GetAttribute("Owner") == l__LocalPlayer__9.UserId then
                u38:Disconnect();
                u38 = nil;
                task.defer(function() --[[ Line: 224 ]]
                    -- upvalues: u41 (copy), u2 (ref), u11 (ref)
                    for _, v42 in u41:GetDescendants() do
                        if v42:IsA("BasePart") or v42:IsA("Decal") then
                            if not v42:GetAttribute("OriginalTransparency") then
                                v42:SetAttribute("OriginalTransparency", v42.Transparency);
                            end;
                            v42.Transparency = 1;
                        end;
                    end;
                    u41.DescendantAdded:Connect(function(p43) --[[ Line: 234 ]]
                        -- upvalues: u2 (ref), u11 (ref)
                        if u2 and u11 then
                            if p43:IsA("BasePart") or p43:IsA("Decal") then
                                if not p43:GetAttribute("OriginalTransparency") then
                                    p43:SetAttribute("OriginalTransparency", p43.Transparency);
                                end;
                                p43.Transparency = 1;
                            end;
                        end;
                    end);
                    u11 = true;
                end);
            end;
        else
            u38:Disconnect();
            u38 = nil;
        end;
    end);
end;
local function u47() --[[ Line: 248 ]]
    -- upvalues: u38 (ref), u11 (ref), u13 (ref), l__LocalPlayer__9 (copy)
    if u38 then
        u38:Disconnect();
        u38 = nil;
    end;
    if u11 then
        u11 = false;
        for _, v45 in u13:GetChildren() do
            if v45:GetAttribute("Owner") == l__LocalPlayer__9.UserId then
                for _, v46 in v45:GetDescendants() do
                    if v46:IsA("BasePart") or v46:IsA("Decal") then
                        v46.Transparency = v46:GetAttribute("OriginalTransparency") or 0;
                        v46:SetAttribute("OriginalTransparency", nil);
                    end;
                end;
                return;
            end;
        end;
    end;
end;
local function u50() --[[ Line: 274 ]]
    -- upvalues: u4 (ref), u12 (ref)
    if u4 then
        local v48 = {};
        for _, v49 in u4:GetDescendants() do
            if v49:IsA("BasePart") or v49:IsA("Decal") then
                table.insert(v48, v49);
            end;
        end;
        u12 = v48;
    else
        u12 = nil;
    end;
end;
local function u84(p51) --[[ Line: 289 ]]
    -- upvalues: u4 (ref), l__POT__11 (copy), l__ReplicatedStorage__2 (copy), l__Plants__12 (copy), l__Fruits__13 (copy), u50 (copy)
    if u4 then
        u4:Destroy();
        u4 = nil;
    end;
    local v52 = p51:GetAttribute("PlantName");
    local v53 = p51:GetAttribute("Seed");
    local v54 = p51:GetAttribute("SizeMultiplier") or 1;
    local _ = p51:GetAttribute("Age") or 0;
    local v55 = p51:GetAttribute("MaxAge") or 100;
    local v56 = p51:GetAttribute("Mutation");
    local v57 = l__POT__11:Clone();
    v57.Name = "PottedPlantPreview";
    v57:ScaleTo(v54);
    for _, v58 in v57:GetDescendants() do
        if v58:IsA("BasePart") then
            v58.Transparency = 0.5;
            v58.CanCollide = false;
            v58.CanQuery = false;
            v58.CanTouch = false;
            v58.Anchored = true;
        end;
    end;
    if v52 and v53 then
        local v59 = l__ReplicatedStorage__2.Assets.Plants:FindFirstChild(v52);
        local v60 = l__Plants__12:FindFirstChild(v52);
        local v61;
        if v59 then
            v61 = false;
        else
            v59 = l__ReplicatedStorage__2.Assets.Fruits:FindFirstChild(v52);
            v60 = l__Fruits__13:FindFirstChild(v52);
            v61 = true;
        end;
        if v59 and v60 then
            local v62 = require(v60);
            local v63 = v59:Clone();
            v63:SetAttribute("Age", v55);
            v63:SetAttribute("MaxAge", v55);
            if v56 and v56 ~= "" then
                v63:SetAttribute("Mutation", v56);
            end;
            v63.Parent = workspace;
            (v61 and v62.InitFruit or v62.InitPlant)(v63, v53, v54);
            local v64 = 0;
            repeat
                v64 = v64 + task.wait();
            until v63:HasTag("InitializationComplete") or v64 > 5;
            (v61 and v62.BeginFruitGrowth or v62.BeginPlantGrowth)(v63);
            task.wait();
            for _, v65 in v63:GetDescendants() do
                if v65:IsA("BasePart") and v65.Transparency < 1 then
                    v65.Transparency = 0.5;
                    v65.CanCollide = false;
                    v65.CanQuery = false;
                    v65.CanTouch = false;
                    v65.Anchored = true;
                end;
            end;
            local v66 = v57:FindFirstChild("PlantRoot", true);
            if v66 then
                local l__PrimaryPart__16 = v63.PrimaryPart;
                local v67 = l__PrimaryPart__16 and l__PrimaryPart__16.Position.Y - l__PrimaryPart__16.Size.Y / 2 or v63:GetPivot().Position.Y;
                for _, v68 in v63:GetDescendants() do
                    if v68:IsA("BasePart") and (v68.Transparency < 1 and v68.Size.Y > 0.01) then
                        local v69 = v68.Position.Y - v68.Size.Y / 2;
                        if v69 < v67 then
                            v67 = v69;
                        end;
                    end;
                end;
                local v70 = v63:GetPivot().Position.Y - v67;
                local l__Position__17 = v66.WorldCFrame.Position;
                v63:PivotTo(CFrame.new(l__Position__17.X, l__Position__17.Y + v70, l__Position__17.Z));
            end;
            local l__Fruits__18 = l__ReplicatedStorage__2.Assets.Fruits;
            local v71 = v63:FindFirstChild("FruitSpawnLocations");
            local u72 = p51:GetAttribute("SavedFruitsJSON");
            if v71 and (u72 and u72 ~= "") then
                local v73, v74 = pcall(function() --[[ Line: 389 ]]
                    -- upvalues: u72 (copy)
                    return game:GetService("HttpService"):JSONDecode(u72);
                end);
                if v73 and (v74 and #v74 > 0) then
                    local v75 = l__Fruits__18:FindFirstChild(v52);
                    local v76 = l__Fruits__13:FindFirstChild(v52);
                    if v75 and v76 then
                        local v77 = require(v76);
                        for _, v78 in v74 do
                            local v79 = v71:FindFirstChild((tostring(v78.SpawnLocationIndex))) or v71:GetChildren()[v78.SpawnLocationIndex];
                            if v79 then
                                local v80 = v75:Clone();
                                v80:SetAttribute("Age", v55);
                                v80:SetAttribute("MaxAge", v55);
                                if v78.Mutation and v78.Mutation ~= "" then
                                    v80:SetAttribute("Mutation", v78.Mutation);
                                end;
                                v80.Parent = workspace;
                                v77.InitFruit(v80, v78.Seed, v78.SizeMultiplier);
                                local v81 = 0;
                                repeat
                                    v81 = v81 + task.wait();
                                until v80:HasTag("InitializationComplete") or v81 > 5;
                                v77.BeginFruitGrowth(v80);
                                task.wait();
                                if v78.OvertimeGrowth and v78.OvertimeGrowth > 1 then
                                    v80:ScaleTo(v78.OvertimeGrowth);
                                end;
                                for _, v82 in v80:GetDescendants() do
                                    if v82:IsA("BasePart") and v82.Transparency < 1 then
                                        v82.Transparency = 0.5;
                                        v82.CanCollide = false;
                                        v82.CanQuery = false;
                                        v82.CanTouch = false;
                                        v82.Anchored = true;
                                    end;
                                end;
                                v80:PivotTo(v79.CFrame);
                                v80.Parent = v57;
                            end;
                        end;
                    end;
                end;
            end;
            v63.Parent = v57;
        end;
    end;
    v57.Parent = workspace;
    u4 = v57;
    if u4 and u4.PrimaryPart then
        local v83 = Instance.new("SelectionBox");
        v83.Name = "SelectionBox";
        v83.Color3 = Color3.fromRGB(0, 255, 0);
        v83.LineThickness = 0.03;
        v83.Transparency = 0.3;
        v83.Adornee = u4.PrimaryPart;
        v83.Parent = u4;
    end;
    u50();
end;
local function u90() --[[ Line: 459 ]]
    -- upvalues: u4 (ref), l__LocalPlayer__9 (copy), u12 (ref), u50 (copy), u44 (copy), u47 (copy)
    if u4 then
        local v85 = l__LocalPlayer__9:GetAttribute("IsInOwnGarden");
        local v86 = v85 and 0.5 or 1;
        local v87 = u12;
        if not v87 then
            u50();
            v87 = u12;
        end;
        if v87 then
            for _, v88 in v87 do
                if v88.Parent then
                    if v88:IsA("BasePart") then
                        v88.Transparency = v86;
                    elseif v88:IsA("Decal") then
                        v88.Transparency = v86;
                    end;
                end;
            end;
        end;
        local v89 = u4:FindFirstChild("SelectionBox");
        if v89 and v89:IsA("SelectionBox") then
            v89.Visible = v85;
        end;
        if v85 then
            u44();
        else
            u47();
        end;
    end;
end;
local function u99() --[[ Line: 500 ]]
    -- upvalues: u4 (ref), l__LocalPlayer__9 (copy), u90 (copy), u34 (copy), l__Gardens__10 (copy), l__PlacementGrid__7 (copy), u6 (ref), u3 (ref), u5 (ref), u25 (copy), u37 (copy)
    if u4 and u4.PrimaryPart then
        if l__LocalPlayer__9:GetAttribute("IsInOwnGarden") then
            local v91 = u34(u4);
            if v91 then
                local v92 = l__LocalPlayer__9:GetAttribute("PlotId");
                local v93;
                if v92 then
                    v93 = l__Gardens__10:FindFirstChild("Plot" .. tostring(v92));
                else
                    v93 = nil;
                end;
                local v94;
                if v93 then
                    v94 = v93:FindFirstChild("SpawnPoint");
                else
                    v94 = nil;
                end;
                local v95;
                if v94 and math.abs(v91.Normal.Y) > 0.1 then
                    v95 = l__PlacementGrid__7.SnapToGrid(v91.Position, v94, 0.5);
                else
                    local v96 = math.floor(v91.Position.X / 0.5 + 0.5) * 0.5;
                    local l__Y__19 = v91.Position.Y;
                    local v97 = math.floor(v91.Position.Z / 0.5 + 0.5) * 0.5;
                    v95 = Vector3.new(v96, l__Y__19, v97);
                end;
                u6 = v95;
                local v98 = v94 and l__PlacementGrid__7.GetGardenRotationY(v94) or 0;
                u4:PivotTo((l__PlacementGrid__7.PositionModel(u4, v95, v98, u3)));
                u5 = u25(v95);
                u37(u5);
                u90();
            end;
        else
            u90();
        end;
    end;
end;
local function u105() --[[ Line: 539 ]]
    -- upvalues: u4 (ref), u5 (ref), u6 (ref), u7 (ref), l__LocalPlayer__9 (copy), l__NotificationController__8 (copy), l__Gardens__10 (copy), l__PlacementGrid__7 (copy), u3 (ref), l__Networking__6 (copy)
    if u4 and (u5 and (u6 and u7)) then
        if l__LocalPlayer__9:GetAttribute("IsInOwnGarden") then
            local v100 = l__LocalPlayer__9:GetAttribute("PlotId");
            local v101;
            if v100 then
                v101 = l__Gardens__10:FindFirstChild("Plot" .. tostring(v100));
            else
                v101 = nil;
            end;
            local v102;
            if v101 then
                v102 = v101:FindFirstChild("SpawnPoint");
            else
                v102 = nil;
            end;
            local v103 = v102 and l__PlacementGrid__7.GetGardenRotationY(v102) or 0;
            local v104 = math.deg(v103) + u3;
            l__Networking__6.PotPlacement.PlacePottedPlant:Fire(u6, v104, u7:GetAttribute("Id"));
        else
            l__NotificationController__8:CreateNotification("You must be in your garden to place this!");
        end;
    end;
end;
local function u117(u106) --[[ Line: 584 ]]
    -- upvalues: u2 (ref), u9 (ref), u10 (ref), u8 (ref), u4 (ref), u12 (ref), u3 (ref), u6 (ref), u5 (ref), u7 (ref), u84 (copy), u19 (copy), l__RunService__4 (copy), u99 (copy), l__UserInputService__3 (copy), u105 (copy), l__LocalPlayer__9 (copy), u44 (copy), u50 (copy), u90 (copy)
    if u2 then
        u2 = false;
        if u9 then
            task.cancel(u9);
            u9 = nil;
        end;
        for _, v107 in u10 do
            v107:Disconnect();
        end;
        u10 = {};
        u8 = nil;
        if u4 then
            u4:Destroy();
            u4 = nil;
        end;
        u12 = nil;
        u3 = 0;
        u6 = nil;
        u5 = false;
    end;
    u2 = true;
    u7 = u106;
    u84(u106);
    u19();
    table.insert(u10, l__RunService__4.RenderStepped:Connect(u99));
    table.insert(u10, l__UserInputService__3.InputBegan:Connect(function(p108, p109) --[[ Line: 598 ]]
        -- upvalues: u2 (ref), u105 (ref), u3 (ref), u9 (ref), u10 (ref), u8 (ref), u4 (ref), u12 (ref), u6 (ref), u5 (ref)
        if p109 then
        elseif u2 then
            if p108.UserInputType == Enum.UserInputType.MouseButton1 and true or p108.KeyCode == Enum.KeyCode.ButtonR2 then
                u105();
            elseif p108.KeyCode == Enum.KeyCode.R or p108.KeyCode == Enum.KeyCode.ButtonR1 then
                u3 = (u3 + 15) % 360;
                if u9 then
                    task.cancel(u9);
                    u9 = nil;
                end;
                u9 = task.spawn(function() --[[ Line: 177 ]]
                    -- upvalues: u3 (ref)
                    task.wait(1);
                    while true do
                        u3 = (u3 + 15) % 360;
                        task.wait(0.08);
                    end;
                end);
            elseif p108.KeyCode == Enum.KeyCode.Escape or p108.KeyCode == Enum.KeyCode.ButtonB then
                u2 = false;
                if u9 then
                    task.cancel(u9);
                    u9 = nil;
                end;
                for _, v110 in u10 do
                    v110:Disconnect();
                end;
                u10 = {};
                u8 = nil;
                if u4 then
                    u4:Destroy();
                    u4 = nil;
                end;
                u12 = nil;
                u3 = 0;
                u6 = nil;
                u5 = false;
            end;
        end;
    end));
    table.insert(u10, l__UserInputService__3.InputEnded:Connect(function(p111) --[[ Line: 631 ]]
        -- upvalues: u9 (ref)
        if (p111.KeyCode == Enum.KeyCode.R or p111.KeyCode == Enum.KeyCode.ButtonR1) and u9 then
            task.cancel(u9);
            u9 = nil;
        end;
    end));
    local v112 = u10;
    local v113 = u106:GetPropertyChangedSignal("Parent");
    table.insert(v112, v113:Connect(function() --[[ Line: 638 ]]
        -- upvalues: u106 (copy), l__LocalPlayer__9 (ref), u2 (ref), u9 (ref), u10 (ref), u8 (ref), u4 (ref), u12 (ref), u3 (ref), u6 (ref), u5 (ref)
        if u106.Parent ~= l__LocalPlayer__9.Character then
            u2 = false;
            if u9 then
                task.cancel(u9);
                u9 = nil;
            end;
            for _, v114 in u10 do
                v114:Disconnect();
            end;
            u10 = {};
            u8 = nil;
            if u4 then
                u4:Destroy();
                u4 = nil;
            end;
            u12 = nil;
            u3 = 0;
            u6 = nil;
            u5 = false;
        end;
    end));
    if l__LocalPlayer__9:GetAttribute("IsInOwnGarden") then
        u44();
    end;
    local v115 = u10;
    local v116 = l__LocalPlayer__9:GetAttributeChangedSignal("IsInOwnGarden");
    table.insert(v115, v116:Connect(function() --[[ Line: 650 ]]
        -- upvalues: u50 (ref), u90 (ref), l__LocalPlayer__9 (ref), u19 (ref)
        u50();
        task.defer(u90);
        if l__LocalPlayer__9:GetAttribute("IsInOwnGarden") then
            u19();
        end;
    end));
end;
function v1.Init(_) --[[ Line: 668 ]]
    -- upvalues: u13 (ref)
    u13 = workspace:WaitForChild("PottedPlantVisuals");
end;
function v1.Start(_) --[[ Line: 672 ]]
    -- upvalues: u117 (copy), u2 (ref), u9 (ref), u10 (ref), u8 (ref), u4 (ref), u12 (ref), u3 (ref), u6 (ref), u5 (ref), l__LocalPlayer__9 (copy), l__Networking__6 (copy)
    local function v122(u118) --[[ Line: 673 ]]
        -- upvalues: u117 (ref), u2 (ref), u9 (ref), u10 (ref), u8 (ref), u4 (ref), u12 (ref), u3 (ref), u6 (ref), u5 (ref)
        u118.ChildAdded:Connect(function(u119) --[[ Line: 675 ]]
            -- upvalues: u118 (copy), u117 (ref)
            if u119:IsA("Tool") and u119:GetAttribute("PottedPlant") then
                task.defer(function() --[[ Line: 677 ]]
                    -- upvalues: u119 (copy), u118 (ref), u117 (ref)
                    if u119.Parent == u118 then
                        u117(u119);
                    end;
                end);
            end;
        end);
        u118.ChildRemoved:Connect(function(p120) --[[ Line: 686 ]]
            -- upvalues: u2 (ref), u9 (ref), u10 (ref), u8 (ref), u4 (ref), u12 (ref), u3 (ref), u6 (ref), u5 (ref)
            if p120:IsA("Tool") and p120:GetAttribute("PottedPlant") then
                u2 = false;
                if u9 then
                    task.cancel(u9);
                    u9 = nil;
                end;
                for _, v121 in u10 do
                    v121:Disconnect();
                end;
                u10 = {};
                u8 = nil;
                if u4 then
                    u4:Destroy();
                    u4 = nil;
                end;
                u12 = nil;
                u3 = 0;
                u6 = nil;
                u5 = false;
            end;
        end);
    end;
    v122(l__LocalPlayer__9.Character or l__LocalPlayer__9.CharacterAdded:Wait());
    l__LocalPlayer__9.CharacterAdded:Connect(v122);
    l__Networking__6.PotPlacement.PottedPlantPlaced.OnClientEvent:Connect(function() --[[ Line: 698 ]]
        -- upvalues: u2 (ref), u9 (ref), u10 (ref), u8 (ref), u4 (ref), u12 (ref), u3 (ref), u6 (ref), u5 (ref)
        u2 = false;
        if u9 then
            task.cancel(u9);
            u9 = nil;
        end;
        for _, v123 in u10 do
            v123:Disconnect();
        end;
        u10 = {};
        u8 = nil;
        if u4 then
            u4:Destroy();
            u4 = nil;
        end;
        u12 = nil;
        u3 = 0;
        u6 = nil;
        u5 = false;
    end);
end;
return v1;